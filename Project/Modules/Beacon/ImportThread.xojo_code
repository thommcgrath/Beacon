#tag Class
Protected Class ImportThread
Inherits Beacon.Thread
	#tag Event
		Sub Run()
		  Static CR As Text = Text.FromUnicodeCodepoint(13)
		  Static LF As Text = Text.FromUnicodeCodepoint(10)
		  Static CRLF As Text = CR + LF
		  
		  Self.Reset
		  Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Single
		  
		  // Normalize line endings
		  Self.mContent = Self.mContent.ReplaceAll(CRLF, CR)
		  Self.mContent = Self.mContent.ReplaceAll(LF, CR)
		  
		  Dim Lines() As Text = Self.mContent.Split(CR)
		  For I As Integer = UBound(Lines) DownTo 0
		    If Lines(I).Length < 30 Or Lines(I).Left(30) <> "ConfigOverrideSupplyCrateItems" Then
		      Lines.Remove(I)
		    End If
		  Next
		  
		  Self.mBeaconCount = UBound(Lines) + 1
		  Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Single
		  
		  For Each Line As Text In Lines
		    Try
		      Dim Value As Auto = Self.Import(Line + CR)
		      If Value = Nil Then
		        Continue
		      End If
		      Dim ValueInfo As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		      If ValueInfo.FullName <> "Xojo.Core.Dictionary" Or Xojo.Core.Dictionary(Value).HasKey("ConfigOverrideSupplyCrateItems") = False Then
		        Continue
		      End If
		      
		      Dim LootSource As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(Xojo.Core.Dictionary(Value), 1.0)
		      If LootSource <> Nil Then
		        LootSource.NumItemSetsPower = 1.0
		        Self.mLootSources.Append(LootSource)
		      End If
		    Catch Stop As Beacon.ThreadStopException
		      Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Off
		      Self.Reset
		      Return
		    Catch Err As RuntimeException
		      // Don't let an error halt processing, skip and move on
		    End Try
		    Self.mLootSourcesProcessed = Self.mLootSourcesProcessed + 1
		    Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Single
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function BeaconCount() As UInteger
		  Return Self.mBeaconCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  Self.mUpdateTimer = New Xojo.Core.Timer
		  Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Off
		  Self.mUpdateTimer.Period = 1
		  AddHandler Self.mUpdateTimer.Action, WeakAddressOf Self.mUpdateTimer_Action
		End Sub
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
		  Next
		  
		  Return Self.ToXojoType(Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSources() As Beacon.LootSource()
		  Dim Results() As Beacon.LootSource
		  Redim Results(UBound(Self.mLootSources))
		  
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    Results(I) = New Beacon.LootSource(Self.mLootSources(I))
		  Next
		  
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSourcesProcessed() As UInteger
		  Return Self.mLootSourcesProcessed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateTimer_Action(Sender As Xojo.Core.Timer)
		  #Pragma Unused Sender
		  
		  RaiseEvent UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  Self.mBeaconCount = 0
		  Self.mLootSourcesProcessed = 0
		  Redim Self.mLootSources(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Run()
		  Super.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub Run(File As Global.FolderItem)
		  If Self.State <> Beacon.Thread.States.NotRunning Then
		    Dim Err As New RuntimeException
		    Err.Reason = "Importer is already running"
		    Raise Err
		  End If
		  
		  Dim Stream As Global.TextInputStream = Global.TextInputStream.Open(File)
		  Self.mContent = Stream.ReadAll(Encodings.UTF8).ToText
		  Stream.Close
		  
		  Self.Run()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run(Content As Text)
		  If Self.State <> Beacon.Thread.States.NotRunning Then
		    Dim Err As New RuntimeException
		    Err.Reason = "Importer is already running"
		    Raise Err
		  End If
		  
		  Self.mContent = Content
		  Self.Run()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Sub Run(File As Xojo.IO.FolderItem)
		  If Self.State <> Beacon.Thread.States.NotRunning Then
		    Dim Err As New RuntimeException
		    Err.Reason = "Importer is already running"
		    Raise Err
		  End If
		  
		  Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(File, Xojo.Core.TextEncoding.UTF8)
		  Self.mContent = Stream.ReadAll
		  Stream.Close
		  
		  Self.Run()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToXojoType(Input As Auto) As Auto
		  If Input = Nil Then
		    Return Nil
		  End If
		  
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Input)
		  Select Case Info.FullName
		  Case "Beacon.Pair"
		    Dim Dict As New Xojo.Core.Dictionary
		    Dict.Value(Beacon.Pair(Input).Key) = ToXojoType(Beacon.Pair(Input).Value)
		    Return Dict
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
		    ElseIf Input = "false" then
		      Return False
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
		Event UpdateUI()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mBeaconCount As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLootSources() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLootSourcesProcessed As UInteger
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
