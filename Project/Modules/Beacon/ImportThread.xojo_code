#tag Class
Protected Class ImportThread
Inherits Beacon.Thread
	#tag Event
		Sub Run()
		  Self.mFinished = False
		  Self.Status = "Loading config files…"
		  Self.Invalidate
		  
		  Var LineEnding As String = Self.LineEndingChar()
		  
		  // Normalize line endings
		  Var Content As String
		  If (Self.mData Is Nil) = False Then
		    Content = Self.mData.GameUserSettingsIniContent.ReplaceLineEndings(LineEnding) + LineEnding + Self.mData.GameIniContent.ReplaceLineEndings(LineEnding)
		  End If
		  
		  // Fix smart quotes
		  Content = Content.SanitizeIni
		  
		  Self.mCharactersProcessed = 0
		  Self.mCharactersTotal = Content.Length
		  
		  Self.Status = "Parsing config files…"
		  Self.Invalidate
		  
		  Var MessageOfTheDayMode As Boolean = False
		  Var ParsedData As New Dictionary
		  Var Lines() As String = Content.Split(LineEnding)
		  Self.mCharactersTotal = Self.mCharactersTotal + ((Lines.LastIndex + 1) * LineEnding.Length) // To account for the trailing line ending characters we're adding
		  For Each Line As String In Lines
		    If Self.mCancelled Then
		      Return
		    End If
		    
		    Var CharacterCount As Integer = Line.Length + LineEnding.Length
		    
		    If MessageOfTheDayMode Then
		      If Line.BeginsWith("[") And Line.EndsWith("]") Then
		        MessageOfTheDayMode = False
		      Else
		        Try
		          If Line.BeginsWith("Duration=") Then
		            Var Duration As Integer = Integer.FromString(Line.Middle(9))
		            ParsedData.Value("Duration") = Duration
		          Else
		            Var Message As String
		            If Line.BeginsWith("Message=") Then
		              Line = Line.Middle(8)
		            Else
		              Message = ParsedData.Lookup("Message", "")
		            End If
		            If Message.IsEmpty Then
		              Message = Line
		            Else
		              Message = Message + LineEnding + Line
		            End If
		            ParsedData.Value("Message") = Message
		          End If
		        Catch Err As RuntimeException
		        End Try
		        
		        Self.AddCharactersParsed(CharacterCount)
		        Continue
		      End If
		    End If
		    
		    If Line.IsEmpty Or Line.Left(1) = ";" Then
		      Self.AddCharactersParsed(CharacterCount)
		      Continue
		    ElseIf Line = "[MessageOfTheDay]" Then
		      MessageOfTheDayMode = True
		      Self.AddCharactersParsed(CharacterCount)
		      Continue
		    End If
		    
		    Try
		      Var Value As Variant = Self.Import(Line + LineEnding)
		      If Value = Nil Then
		        Continue
		      End If
		      If Value.Type <> Variant.TypeObject Or Value IsA Beacon.Pair = False Then
		        Continue
		      End If
		      
		      Var Key As String = Beacon.Pair(Value).Key
		      Value = Beacon.Pair(Value).Value
		      
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
		    Catch Stop As Beacon.ThreadStopException
		      Self.mUpdateTimer.RunMode = Timer.RunModes.Off
		      Return
		    Catch Err As RuntimeException
		      // Don't let an error halt processing, skip and move on
		    End Try
		    
		    Var Progress As Integer = Round(Self.Progress * 100)
		    Self.Status = "Parsing config files… (" + Progress.ToString + "%)"
		  Next
		  
		  Self.mCharactersProcessed = Self.mCharactersTotal
		  
		  Self.Status = "Building Beacon project…"
		  Try
		    Var CommandLineOptions As Dictionary
		    If (Self.mData Is Nil) = False Then
		      CommandLineOptions = Self.mData.CommandLineOptions
		    End If
		    Self.mDocument = Self.BuildDocument(ParsedData, CommandLineOptions)
		  Catch Err As RuntimeException
		  End Try
		  Self.Status = "Finished"
		  
		  Self.mFinished = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddCharactersParsed(CharacterCount As Integer)
		  Self.mCharactersProcessed = Self.mCharactersProcessed + CharacterCount
		  Var Progress As Integer = Round(Self.Progress * 100)
		  Self.Status = "Parsing config files… (" + Progress.ToString + "%)"
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildDocument(ParsedData As Dictionary, CommandLineOptions As Dictionary) As Beacon.Document
		  Var Profile As Beacon.ServerProfile
		  If (Self.mData Is Nil) = False And (Self.mData.Profile Is Nil) = False Then
		    Profile = Self.mData.Profile
		  End If
		  
		  Var Document As New Beacon.Document
		  If (Profile Is Nil) = False Then
		    Document.MapCompatibility = Profile.Mask
		  End If
		  If Document.MapCompatibility = CType(0, UInt64) Then
		    Document.MapCompatibility = Beacon.Maps.TheIsland.Mask
		  End If
		  
		  If CommandLineOptions Is Nil Then
		    CommandLineOptions = New Dictionary
		  End If
		  
		  If (Self.mData Is Nil) = False And Self.mData.IsPrimitivePlus Then
		    Document.ModEnabled("68d1be8b-a66e-41a2-b0b4-cb2a724fc80b") = True
		  End If
		  
		  If ParsedData.HasKey("ActiveMods") And IsNull(ParsedData.Value("ActiveMods")) = False Then
		    Var ActiveMods As String = ParsedData.StringValue("ActiveMods", "")
		    Var ModIDs() As String = ActiveMods.Split(",")
		    For Each ModID As String In ModIDs
		      Var ModInfo As Beacon.ModDetails = Beacon.Data.GetModWithWorkshopID(ModID.ToInteger)
		      If (ModInfo Is Nil) = False Then
		        Document.ModEnabled(ModInfo.ModID) = True
		      End If
		    Next
		  End If
		  
		  Try
		    Var Maps() As Beacon.Map = Document.Maps
		    Var DifficultyTotal, DifficultyScale As Double
		    For Each Map As Beacon.Map In Maps
		      DifficultyTotal = DifficultyTotal + Map.DifficultyScale
		    Next
		    DifficultyScale = DifficultyTotal / Maps.Count
		    
		    Var DifficultyValue As Double
		    If CommandLineOptions.HasKey("OverrideOfficialDifficulty") And CommandLineOptions.DoubleValue("OverrideOfficialDifficulty") > 0 Then
		      DifficultyValue = CommandLineOptions.DoubleValue("OverrideOfficialDifficulty")
		    ElseIf ParsedData.HasKey("OverrideOfficialDifficulty") And ParsedData.DoubleValue("OverrideOfficialDifficulty") > 0 Then
		      DifficultyValue = ParsedData.DoubleValue("OverrideOfficialDifficulty")
		    ElseIf ParsedData.HasKey("DifficultyOffset") Then
		      DifficultyValue = ParsedData.DoubleValue("DifficultyOffset") * (DifficultyScale - 0.5) + 0.5
		    ElseIf (Self.mDestinationDocument Is Nil) = False Then
		      DifficultyValue = Self.mDestinationDocument.DifficultyValue
		    Else
		      DifficultyValue = DifficultyScale
		    End If
		    
		    Document.AddConfigGroup(New BeaconConfigs.Difficulty(DifficultyValue))
		  Catch Err As RuntimeException
		    Document.AddConfigGroup(New BeaconConfigs.Difficulty(5.0))
		  End Try
		  
		  If (Profile Is Nil) = False Then
		    If ParsedData.HasKey("SessionName") Then
		      Var SessionNames() As Variant = ParsedData.AutoArrayValue("SessionName")
		      For Each SessionName As Variant In SessionNames
		        Try
		          Profile.Name = SessionName.StringValue.GuessEncoding
		          Exit
		        Catch Err As RuntimeException
		        End Try
		      Next
		    End If
		    
		    Var ServerPassword, AdminPassword, SpectatorPassword As String
		    If ParsedData.HasKey("ServerPassword") Then
		      ServerPassword = ParsedData.StringValue("ServerPassword", "")
		    ElseIf CommandLineOptions.HasKey("ServerPassword") Then
		      ServerPassword = CommandLineOptions.StringValue("ServerPassword", "")
		    End If
		    If CommandLineOptions.HasKey("SpectatorPassword") Then
		      SpectatorPassword = CommandLineOptions.StringValue("SpectatorPassword", "")
		    ElseIf ParsedData.HasKey("SpectatorPassword") Then
		      SpectatorPassword = ParsedData.StringValue("SpectatorPassword", "")
		    End If
		    If CommandLineOptions.HasKey("ServerAdminPassword") Then
		      AdminPassword = CommandLineOptions.StringValue("ServerAdminPassword", "")
		    ElseIf ParsedData.HasKey("ServerAdminPassword") Then
		      AdminPassword = ParsedData.StringValue("ServerAdminPassword", "")
		    End If
		    Profile.ServerPassword = ServerPassword
		    Profile.SpectatorPassword = SpectatorPassword
		    Profile.AdminPassword = AdminPassword
		    
		    If ParsedData.HasKey("Message") Then
		      Var Duration As Integer = 30
		      If ParsedData.HasKey("Duration") Then
		        Duration = Round(ParsedData.DoubleValue("Duration", 30, True))
		      End If
		      
		      Profile.MessageOfTheDay = Beacon.ArkML.FromArkML(ParsedData.StringValue("Message", "", True).Trim())
		      Profile.MessageDuration = Duration
		    End If
		    
		    Document.AddServerProfile(Profile)
		  End If
		  
		  Var ConfigNames() As String = BeaconConfigs.AllConfigNames()
		  Var PurchasedOmniVersion As Integer = App.IdentityManager.CurrentIdentity.OmniVersion
		  Var Configs() As Beacon.ConfigGroup
		  For Each ConfigName As String In ConfigNames
		    If ConfigName = BeaconConfigs.NameDifficulty Or ConfigName = BeaconConfigs.NameCustomContent Then
		      // Difficulty and custom content area special
		      Continue For ConfigName
		    End If
		    
		    If BeaconConfigs.ConfigPurchased(ConfigName, PurchasedOmniVersion) = False Then
		      // Do not import code for groups that the user has not purchased
		      Continue For ConfigName
		    End If
		    
		    Self.Status = "Building Beacon project… (" + Language.LabelForConfig(ConfigName) + ")"
		    Var Group As Beacon.ConfigGroup
		    Try
		      Group = BeaconConfigs.CreateInstance(ConfigName, ParsedData, CommandLineOptions, Document)
		    Catch Err As RuntimeException
		    End Try
		    If Group <> Nil Then
		      Document.AddConfigGroup(Group)
		      Configs.Add(Group)
		    End If
		  Next
		  
		  // Now split the content into values and remove the ones controlled by the imported groups
		  Self.Status = "Building Beacon project… (" + Language.LabelForConfig(BeaconConfigs.NameCustomContent) + ")"
		  Var CustomConfigOrganizer As New Beacon.ConfigOrganizer(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, Self.mData.GameIniContent)
		  CustomConfigOrganizer.Add(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, Self.mData.GameUserSettingsIniContent)
		  For Each Config As Beacon.ConfigGroup In Configs
		    Var ManagedKeys() As Beacon.ConfigKey = Config.ManagedKeys()
		    CustomConfigOrganizer.Remove(ManagedKeys)
		  Next
		  CustomConfigOrganizer.Remove(Beacon.ConfigFileGameUserSettings, "/Game/PrimalEarth/CoreBlueprints/TestGameMode.TestGameMode_C")
		  CustomConfigOrganizer.Remove(Beacon.ConfigFileGameUserSettings, "/Script/Engine.GameSession")
		  CustomConfigOrganizer.Remove(Beacon.ConfigFileGameUserSettings, "/Script/ShooterGame.ShooterGameUserSettings")
		  CustomConfigOrganizer.Remove(Beacon.ConfigFileGameUserSettings, "ScalabilityGroups")
		  CustomConfigOrganizer.Remove(Beacon.ConfigFileGameUserSettings, "ScalabilityGroups.sg")
		  CustomConfigOrganizer.Remove(Beacon.ConfigFileGameUserSettings, "Beacon")
		  CustomConfigOrganizer.Remove(Beacon.ConfigFileGame, "Beacon")
		  
		  Var CustomContent As New BeaconConfigs.CustomContent
		  Try
		    CustomContent.GameIniContent() = CustomConfigOrganizer
		  Catch Err As RuntimeException
		  End Try
		  Try
		    CustomContent.GameUserSettingsIniContent() = CustomConfigOrganizer
		  Catch Err As RuntimeException
		  End Try
		  If CustomContent.Modified Then
		    Document.AddConfigGroup(CustomContent)
		  End If
		  
		  Return Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Data As Beacon.DiscoveredData, DestinationDocument As Beacon.Document)
		  Self.mUpdateTimer = New Timer
		  Self.mUpdateTimer.RunMode = Timer.RunModes.Off
		  Self.mUpdateTimer.Period = 0
		  #if TargetDesktop
		    AddHandler Self.mUpdateTimer.Action, WeakAddressOf Self.mUpdateTimer_Action
		  #else
		    AddHandler Self.mUpdateTimer.Run, WeakAddressOf Self.mUpdateTimer_Action
		  #endif
		  
		  Self.mData = Data
		  Self.mDestinationDocument = DestinationDocument
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Document() As Beacon.Document
		  Return Self.mDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Import(Content As String) As Variant
		  Var Parser As New Beacon.ConfigParser
		  Var Value As Variant
		  Var Characters() As String = Content.Split("")
		  For Each Char As String In Characters
		    If Self.mCancelled Then
		      Return Nil
		    End If
		    
		    If Parser.AddCharacter(Char) Then
		      Value = Parser.Value
		      Exit
		    End If
		    Self.mCharactersProcessed = Self.mCharactersProcessed + 1
		    Self.Invalidate
		  Next
		  
		  Return Self.ToXojoType(Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Invalidate()
		  If Self.mFinished Then
		    Return
		  End If
		  
		  If Self.mUpdateTimer.RunMode = Timer.RunModes.Off Then
		    Self.mUpdateTimer.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function LineEndingChar() As String
		  Return Encodings.UTF8.Chr(10)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  RaiseEvent UpdateUI
		  
		  If Self.mFinished Then
		    RaiseEvent Finished(Self.mDocument)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  If (Self.mData Is Nil) = False And (Self.mData.Profile Is Nil) = False Then
		    Return Self.mData.Profile.Name
		  Else
		    Return "Untitled Importer"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As Double
		  Return Self.mCharactersProcessed / Self.mCharactersTotal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  Return Self.mStatusMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Status(Assigns Value As String)
		  If Self.mStatusMessage.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) <> 0 Then
		    Self.mStatusMessage = Value
		    Self.Invalidate
		  End If
		End Sub
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
		      IsDict = IsDict And Item.Type = Variant.TypeObject And Item.ObjectValue IsA Beacon.Pair
		    Next
		    If IsDict Then
		      Var Dict As New Dictionary
		      For Each Item As Beacon.Pair In ArrayValue
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
		    Case IsA Beacon.Pair
		      Var Original As Beacon.Pair = Input
		      Return New Beacon.Pair(Original.Key, ToXojoType(Original.Value))
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
		Event Finished(Document As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateUI()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCharactersProcessed As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCharactersTotal As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mData As Beacon.DiscoveredData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinationDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateTimer As Timer
	#tag EndProperty


	#tag ViewBehavior
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
