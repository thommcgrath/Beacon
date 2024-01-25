#tag Class
Protected Class ImportThread
Inherits Beacon.Thread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  Self.mFinished = False
		  Self.mCancelled = False
		  Self.mCreatedProject = Nil
		  Self.mError = Nil
		  
		  If Self.mProgress Is Nil Then
		    Self.mProgress = New Beacon.DummyProgressDisplayer
		  End If
		  
		  Try
		    Var Project As Palworld.Project = Self.RunSynchronous(Self.mData, Self.mDestinationProject, Self.mProgress)
		    If Self.mCancelled Then
		      Return
		    End If
		    
		    Self.mCreatedProject = Project
		    Self.mFinished = True
		  Catch Err As RuntimeException
		    Self.mFinished = True
		    Self.mError = Err
		  End Try
		  
		  Var Dict As New Dictionary
		  Dict.Value("Event") = "Finished"
		  Self.AddUserInterfaceUpdate(Dict)
		End Sub
	#tag EndEvent

	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("Event", "").StringValue = "Finished" Then
		      RaiseEvent Finished(Self.mCreatedProject)
		    End If
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Sub AddCharactersParsed(CharacterCount As Integer, TotalCharacters As Integer, Progress As Beacon.ProgressDisplayer, ByRef CharactersProcessed As Integer)
		  CharactersProcessed = CharactersProcessed + CharacterCount
		  Var Percent As Double = CharactersProcessed / TotalCharacters
		  If (Progress Is Nil) = False Then
		    Progress.Progress = Percent
		    Progress.Detail = "Parsing files (" + Percent.ToString(Locale.Current, "0%") + ")…"
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BuildProject(Data As Palworld.DiscoveredData, DestinationProject As Palworld.Project, Progress As Beacon.ProgressDisplayer, ParsedData As Dictionary) As Palworld.Project
		  Var Profile As Palworld.ServerProfile
		  If (Data Is Nil) = False And (Data.Profile Is Nil) = False Then
		    Profile = Data.Profile
		  End If
		  
		  Var Project As New Palworld.Project
		  If ParsedData.HasKey("SessionName") Then
		    Var SessionNames() As Variant = ParsedData.AutoArrayValue("SessionName")
		    For Each SessionName As Variant In SessionNames
		      Try
		        Var SessionTitle As String = SessionName.StringValue
		        If SessionTitle.Encoding Is Nil Then
		          SessionTitle = SessionTitle.DefineEncoding(Encodings.UTF8)
		        ElseIf SessionTitle.Encoding <> Encodings.UTF8 Then
		          SessionTitle = SessionTitle.ConvertEncoding(Encodings.UTF8)
		        End If
		        Project.Title = SessionTitle
		        Exit
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  
		  If (DestinationProject Is Nil) = False Then
		    Var DestinationPacks As Beacon.StringList = DestinationProject.ContentPacks
		    For Each PackUUID As String In DestinationPacks
		      Project.ContentPackEnabled(PackUUID) = True
		    Next PackUUID
		  End If
		  
		  If (Profile Is Nil) = False Then
		    Profile.Name = Project.Title
		    Project.AddServerProfile(Profile)
		  End If
		  
		  Var ConfigNames() As String = Palworld.Configs.AllNames()
		  Var Configs() As Palworld.ConfigGroup
		  For Each ConfigName As String In ConfigNames
		    If ConfigName = Palworld.Configs.NameCustomConfig Then
		      // Custom content is special
		      Continue For ConfigName
		    End If
		    
		    Progress.Message = "Building Beacon project… (" + Language.LabelForConfig(ConfigName) + ")"
		    Var Group As Palworld.ConfigGroup
		    Try
		      Group = Palworld.Configs.CreateInstance(ConfigName, ParsedData, Project)
		    Catch Err As RuntimeException
		    End Try
		    If Group <> Nil Then
		      Project.AddConfigGroup(Group)
		      Configs.Add(Group)
		    End If
		  Next
		  
		  // Now split the content into values and remove the ones controlled by the imported groups
		  Progress.Message = "Building Beacon project… (" + Language.LabelForConfig(Palworld.Configs.NameCustomConfig) + ")"
		  Var CustomConfigOrganizer As New Palworld.ConfigOrganizer(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, Data.SettingsIniContent)
		  For Each Config As Palworld.ConfigGroup In Configs
		    Var ManagedKeys() As Palworld.ConfigOption = Config.ManagedKeys()
		    CustomConfigOrganizer.Remove(ManagedKeys)
		  Next
		  CustomConfigOrganizer.Remove(Palworld.ConfigFileSettings, "Beacon")
		  
		  Var CustomContent As New Palworld.Configs.CustomContent
		  Try
		    CustomContent.SettingsIniContent() = CustomConfigOrganizer
		  Catch Err As RuntimeException
		  End Try
		  If CustomContent.Modified Then
		    Project.AddConfigGroup(CustomContent)
		  End If
		  
		  Return Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Data As Palworld.DiscoveredData, DestinationProject As Palworld.Project)
		  Self.mData = Data
		  Self.mDestinationProject = DestinationProject
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Error() As RuntimeException
		  Return Self.mError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return (Self.mError Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Import(Content As String, TotalCharacters As Integer, Progress As Beacon.ProgressDisplayer, ByRef CharactersProcessed As Integer) As Variant
		  Var Parser As New Palworld.ConfigParser
		  Var Value As Variant
		  Var Characters() As String = Content.Split("")
		  For Each Char As String In Characters
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    If Parser.AddCharacter(Char) Then
		      Value = Parser.Value
		      Exit
		    End If
		    
		    AddCharactersParsed(1, TotalCharacters, Progress, CharactersProcessed)
		  Next
		  
		  Return ToXojoType(Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function LineEndingChar() As String
		  Return Encodings.UTF8.Chr(10)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Var Name As String
		  If (Self.mData Is Nil) = False And (Self.mData.Profile Is Nil) = False Then
		    Name = Self.mData.Profile.Name
		  End If
		  If Name.IsEmpty Then
		    Name = "Untitled Importer"
		  End If
		  Return Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ParseLine(Content As String) As Variant
		  Var TotalCharacters, CharactersProcessed As Integer
		  Return Import(Content, TotalCharacters, Nil, CharactersProcessed)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As Beacon.ProgressDisplayer
		  Return Self.mProgress
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Progress(Assigns Displayer As Beacon.ProgressDisplayer)
		  Var OldDisplayer As Beacon.ProgressDisplayer = Self.mProgress
		  Self.mProgress = Displayer
		  If (OldDisplayer Is Nil) = False And (Self.mProgress Is Nil) = False Then
		    Self.mProgress.Detail = OldDisplayer.Detail
		    Self.mProgress.Message = OldDisplayer.Message
		    Self.mProgress.Progress = OldDisplayer.Progress
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Palworld.Project
		  Return Self.mCreatedProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function RunSynchronous(Data As Palworld.DiscoveredData, DestinationProject As Palworld.Project, Progress As Beacon.ProgressDisplayer) As Palworld.Project
		  Progress.Message = "Importing…"
		  Progress.Detail = "Cleaning up files…"
		  Progress.Progress = Nil
		  Progress.ShowSubProgress = False
		  
		  Var LineEnding As String = LineEndingChar()
		  
		  // Normalize line endings
		  Var Content As String
		  If (Data Is Nil) = False Then
		    Var Blocks() As String
		    
		    Var SettingsIniContent As String = Data.SettingsIniContent.ReplaceLineEndings(LineEnding)
		    If SettingsIniContent.IsEmpty = False Then
		      If SettingsIniContent.BeginsWith("[") = False Then
		        SettingsIniContent = "[" + Palworld.HeaderPalworldSettings + "]" + LineEnding + SettingsIniContent
		      End If
		      Blocks.Add(SettingsIniContent)
		    End If
		    
		    Content = Blocks.Join(LineEnding)
		  End If
		  
		  // Fix smart quotes
		  Content = Content.SanitizeIni
		  
		  Var CharactersProcessed As Integer
		  Var CharactersTotal As Integer = Content.Length
		  Var CurrentHeader As String
		  Var ParsedData As New Dictionary
		  Var Lines() As String = Content.Split(LineEnding)
		  CharactersTotal = CharactersTotal + ((Lines.LastIndex + 1) * LineEnding.Length) // To account for the trailing line ending characters we're adding
		  
		  Progress.Detail = "Parsing files…"
		  AddCharactersParsed(0, CharactersTotal, Progress, CharactersProcessed)
		  
		  For Each Line As String In Lines
		    If Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    Var CharacterCount As Integer = Line.Length + LineEnding.Length
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      CurrentHeader = Line.Middle(1, Line.Length - 2)
		    End If
		    
		    If Line.IsEmpty Or Line.BeginsWith(";") Then
		      AddCharactersParsed(CharacterCount, CharactersTotal, Progress, CharactersProcessed)
		      Continue
		    End If
		    
		    Try
		      Var Value As Variant = Import(Line + LineEnding, CharactersTotal, Progress, CharactersProcessed)
		      If Value = Nil Then
		        Continue
		      End If
		      If Value.Type <> Variant.TypeObject Or Value IsA Beacon.KeyValuePair = False Then
		        Continue
		      End If
		      
		      Var Key As String = Beacon.KeyValuePair(Value).Key
		      Var ExtendedKey As String = CurrentHeader + "." + Key
		      Value = Beacon.KeyValuePair(Value).Value
		      
		      If ParsedData.HasKey(Key) Then
		        Var ExistingValue As Variant = ParsedData.Value(Key)
		        
		        Var ValueArray() As Variant
		        If ExistingValue.IsArray Then
		          ValueArray = ExistingValue
		        Else
		          ValueArray.Add(ExistingValue)
		        End If
		        ValueArray.Add(Value)
		        ParsedData.Value(Key) = ValueArray
		      Else
		        ParsedData.Value(Key) = Value
		      End If
		      
		      If ParsedData.HasKey(ExtendedKey) Then
		        Var ExistingValue As Variant = ParsedData.Value(ExtendedKey)
		        
		        Var ValueArray() As Variant
		        If ExistingValue.IsArray Then
		          ValueArray = ExistingValue
		        Else
		          ValueArray.Add(ExistingValue)
		        End If
		        ValueArray.Add(Value)
		        ParsedData.Value(ExtendedKey) = ValueArray
		      Else
		        ParsedData.Value(ExtendedKey) = Value
		      End If
		    Catch Err As RuntimeException
		      // Don't let an error halt processing, skip and move on
		    End Try
		    
		    Thread.SleepCurrent(10)
		  Next
		  CharactersProcessed = CharactersTotal
		  
		  Progress.Detail = "Building Beacon project…"
		  Try
		    Return BuildProject(Data, DestinationProject, Progress, ParsedData)
		  Catch Err As RuntimeException
		  End Try
		  Progress.Detail = "Finished"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToXojoType(Input As Variant) As Variant
		  If Input = Nil Then
		    Return Nil
		  End If
		  
		  If Input.IsArray And Input.ArrayElementType = Variant.TypeObject Then
		    Var ArrayValue() As Variant = Input
		    Var IsDict As Boolean = True
		    For Each Item As Variant In ArrayValue
		      IsDict = IsDict And Item.Type = Variant.TypeObject And Item.ObjectValue IsA Beacon.KeyValuePair
		    Next
		    If IsDict Then
		      Var Dict As New Dictionary
		      For Each Item As Beacon.KeyValuePair In ArrayValue
		        Dict.Value(Item.Key) = ToXojoType(Item.Value)
		      Next
		      Return Dict
		    Else
		      Var Items() As Variant
		      For Each Item As Variant In ArrayValue
		        Items.Add(ToXojoType(Item))
		      Next
		      Return Items
		    End If
		  End If
		  
		  Select Case Input.Type
		  Case Variant.TypeObject
		    Var ObjectValue As Object = Input.ObjectValue
		    Select Case ObjectValue
		    Case IsA Beacon.KeyValuePair
		      Var Original As Beacon.KeyValuePair = Input
		      Return New Beacon.KeyValuePair(Original.Key, ToXojoType(Original.Value))
		    End Select
		  Case Variant.TypeString
		    Var StringValue As String = Input.StringValue
		    If StringValue = "true" Then
		      Return True
		    ElseIf StringValue = "false" Then
		      Return False
		    Else
		      Var IsNumeric As Boolean
		      If StringValue.Length > 0 Then
		        IsNumeric = True
		        Var DecimalPoints As Integer
		        Var Characters() As String = StringValue.Split("")
		        For Each Char As String In Characters
		          Select Case Char
		          Case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
		            // Still a Number
		          Case "."
		            If DecimalPoints = 1 Then
		              IsNumeric = False
		              Exit
		            Else
		              DecimalPoints = 1
		            End If
		          Else
		            IsNumeric = False
		            Exit
		          End Select
		        Next
		      End If
		      If IsNumeric Then
		        // Number
		        Return Double.FromString(StringValue, Locale.Raw)
		      Else
		        // Probably String
		        Return StringValue
		      End If
		    End If
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(Project As Palworld.Project)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatedProject As Palworld.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mData As Palworld.DiscoveredData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinationProject As Palworld.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Beacon.ProgressDisplayer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
