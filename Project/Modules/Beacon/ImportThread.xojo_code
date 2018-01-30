#tag Class
Protected Class ImportThread
Inherits Beacon.Thread
	#tag Event
		Sub Run()
		  Static CR As Text = Text.FromUnicodeCodepoint(13)
		  Static LF As Text = Text.FromUnicodeCodepoint(10)
		  Static CRLF As Text = CR + LF
		  
		  Self.mFinished = False
		  Self.Invalidate
		  
		  // Normalize line endings
		  Dim Content As Text = Self.mContent
		  Self.mContent = ""
		  Self.mCharactersProcessed = 0
		  Self.mCharactersTotal = Content.Length
		  Content = Content.ReplaceAll(CRLF, CR)
		  Content = Content.ReplaceAll(LF, CR)
		  
		  Self.mParsedData = New Xojo.Core.Dictionary
		  
		  Dim Lines() As Text = Content.Split(CR)
		  Self.mCharactersTotal = Self.mCharactersTotal + Lines.Ubound + 1 // To account for the trailing CR characters we're adding
		  For Each Line As Text In Lines
		    If Line.Length = 0 Or Line.Left(1) = ";" Then
		      Self.mCharactersProcessed = Self.mCharactersProcessed + Line.Length + 1
		      Self.Invalidate
		      Continue
		    End If
		    
		    Try
		      Dim Value As Auto = Self.Import(Line + CR)
		      If Value = Nil Then
		        Continue
		      End If
		      Dim ValueInfo As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		      If ValueInfo.FullName <> "Beacon.Pair" Then
		        Continue
		      End If
		      
		      Dim Key As Text = Beacon.Pair(Value).Key
		      Value = Beacon.Pair(Value).Value
		      
		      If Self.mParsedData.HasKey(Key) Then
		        Dim ExistingValue As Auto = Self.mParsedData.Value(Key)
		        Dim TypeInfo As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(ExistingValue)
		        
		        Dim ValueArray() As Auto
		        If TypeInfo.IsArray Then
		          ValueArray = ExistingValue
		        Else
		          ValueArray.Append(ExistingValue)
		        End If
		        ValueArray.Append(Value)
		        Self.mParsedData.Value(Key) = ValueArray
		      Else
		        Self.mParsedData.Value(Key) = Value
		      End If
		      
		      #if false
		        Dim Dict As Xojo.Core.Dictionary = Value
		        If Dict.HasKey("ConfigOverrideSupplyCrateItems") Then
		          Dim LootSource As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(Dict.Value("ConfigOverrideSupplyCrateItems"), Self.Document.DifficultyValue)
		          If LootSource <> Nil Then
		            LootSource.NumItemSetsPower = 1.0
		            Self.Document.Add(LootSource)
		          End If
		        End If
		      #endif
		    Catch Stop As Beacon.ThreadStopException
		      Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Off
		      Return
		    Catch Err As RuntimeException
		      // Don't let an error halt processing, skip and move on
		    End Try
		    Self.Invalidate
		  Next
		  
		  Self.Invalidate
		  Self.mCharactersProcessed = Self.mCharactersTotal
		  Self.mFinished = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub AddContent(File As Global.FolderItem, Prepend As Boolean = False)
		  If File = Nil Or File.Exists = False Then
		    Return
		  End If
		  
		  Dim Stream As Global.TextInputStream = Global.TextInputStream.Open(File)
		  Dim Content As Text = Stream.ReadAll(Encodings.UTF8).ToText
		  Stream.Close
		  
		  Self.AddContent(Content, Prepend)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddContent(Content As Text, Prepend As Boolean = False)
		  If Self.State <> Beacon.Thread.States.NotRunning Then
		    Dim Err As New RuntimeException
		    Err.Reason = "Importer is already running"
		    Raise Err
		  End If
		  
		  If Prepend Then
		    Self.mContent = Content + Text.FromUnicodeCodepoint(13) + Self.mContent
		  Else
		    Self.mContent = Self.mContent + Text.FromUnicodeCodepoint(13) + Content
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddContent(File As Xojo.IO.FolderItem, Prepend As Boolean = False)
		  If File = Nil Or File.Exists = False Then
		    Return
		  End If
		  
		  Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(File, Xojo.Core.TextEncoding.UTF8)
		  Dim Content As Text = Stream.ReadAll
		  Stream.Close
		  
		  Self.AddContent(Content, Prepend)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  Self.mContent = ""
		  Self.mFinished = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  Self.mUpdateTimer = New Xojo.Core.Timer
		  Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Off
		  Self.mUpdateTimer.Period = 0
		  AddHandler Self.mUpdateTimer.Action, WeakAddressOf Self.mUpdateTimer_Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Import(Content As Text) As Auto
		  Dim Parser As New Beacon.ConfigParser
		  Dim Value As Auto
		  For Each Char As Text In Content.Characters
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
		  
		  If Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Off Then
		    Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Single
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateTimer_Action(Sender As Xojo.Core.Timer)
		  #Pragma Unused Sender
		  
		  RaiseEvent UpdateUI
		  
		  If Self.mFinished Then
		    RaiseEvent Finished(Self.mParsedData)
		    Self.mParsedData = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As Double
		  Return Self.mCharactersProcessed / Self.mCharactersTotal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToXojoType(Input As Auto) As Auto
		  If Input = Nil Then
		    Return Nil
		  End If
		  
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Input)
		  Select Case Info.FullName
		  Case "Beacon.Pair"
		    Dim Original As Beacon.Pair = Input
		    Return New Beacon.Pair(Original.Key, ToXojoType(Original.Value))
		  Case "Auto()"
		    Dim ArrayValue() As Auto = Input
		    Dim IsDict As Boolean = True
		    For Each Item As Auto In ArrayValue
		      Dim ItemInfo As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Item)
		      IsDict = IsDict And ItemInfo.FullName = "Beacon.Pair"
		    Next
		    If IsDict Then
		      Dim Dict As New Xojo.Core.Dictionary
		      For Each Item As Beacon.Pair In ArrayValue
		        Dict.Value(Item.Key) = ToXojoType(Item.Value)
		      Next
		      Return Dict
		    Else
		      Dim Items() As Auto
		      For Each Item As Auto In ArrayValue
		        Items.Append(ToXojoType(Item))
		      Next
		      Return Items
		    End If
		  Case "Text"
		    If Input = "true" Then
		      Return True
		    ElseIf Input = "false" Then
		      Return False
		    ElseIf Input = "" Then
		      Return ""
		    Else
		      Dim IsNumeric As Boolean = True
		      Dim DecimalPoints As Integer
		      Dim TextValue As Text = Input
		      For Each Char As Text In TextValue.Characters
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
		      If IsNumeric Then
		        // Number
		        Return Double.FromText(TextValue)
		      Else
		        // Probably Text
		        Return TextValue
		      End If
		    End If
		  Else
		    Break
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(ParsedData As Xojo.Core.Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateUI()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCharactersProcessed As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCharactersTotal As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParsedData As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateTimer As Xojo.Core.Timer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="State"
			Group="Behavior"
			Type="Beacon.Thread.States"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
