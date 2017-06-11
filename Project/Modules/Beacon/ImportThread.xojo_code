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
		  Self.mContent = Self.mContent.ReplaceAll(CRLF, LF)
		  Self.mContent = Self.mContent.ReplaceAll(CR, LF)
		  
		  Dim Lines() As Text = Self.mContent.Split(LF)
		  For I As Integer = UBound(Lines) DownTo 0
		    If Lines(I).Length < 30 Or Lines(I).Left(30) <> "ConfigOverrideSupplyCrateItems" Then
		      Lines.Remove(I)
		    End If
		  Next
		  
		  Self.mBeaconCount = UBound(Lines) + 1
		  Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Single
		  
		  For Each Line As Text In Lines
		    Try
		      Dim Value As Auto = Self.Import(Line)
		      If Value IsA Beacon.Pair And Beacon.Pair(Value).Key = "ConfigOverrideSupplyCrateItems" Then
		        Dim Dict As Xojo.Core.Dictionary = Beacon.Pair(Value).Value
		        Dim LootSource As Beacon.LootSource = Beacon.LootSource.Import(Dict)
		        If LootSource <> Nil Then
		          LootSource.NumItemSetsPower = 1.0
		          Self.mLootSources.Append(LootSource)
		        End If
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
		  Dim Offset As Integer = 0
		  Return Self.Import(Content, Offset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Import(Content As Text, ByRef Offset As Integer) As Auto
		  If Self.ShouldStop Then
		    Raise New Beacon.ThreadStopException
		  End If
		  
		  If Content.Mid(Offset, 1) = "(" Then
		    Dim IsDictionary As Boolean = True
		    Dim Children() As Auto
		    Do Until Content.Mid(Offset, 1) = ")"
		      Offset = Offset + 1
		      Dim Value As Auto = Self.Import(Content, Offset)
		      If Value = Nil Then
		        Continue
		      End If
		      If IsDictionary Then
		        Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		        IsDictionary = Info.FullName = "Beacon.Pair"
		      End If
		      Children.Append(Value)
		    Loop
		    Offset = Offset + 1
		    
		    If IsDictionary Then
		      Dim Dict As New Xojo.Core.Dictionary
		      For Each Child As Beacon.Pair In Children
		        Dict.Value(Child.Key) = Child.Value
		      Next
		      Return Dict
		    Else
		      Return Children
		    End If
		  ElseIf Content.Mid(Offset, 1) = """" Then
		    // Text
		    Dim ClosingPos As Integer = Content.IndexOf(Offset + 1, """")
		    Dim TextValue As Text = Content.Mid(Offset + 1, ClosingPos - (Offset + 1))
		    Offset = ClosingPos + 1
		    Return TextValue
		  End If
		  
		  Dim Pos As Integer = Self.PositionOfNextDelimeter(Offset, Content)
		  If Pos = -1 Then
		    Dim Piece As Text = Content.Mid(Offset)
		    Offset = Offset + Piece.Length
		    Return Self.ImportIntrinsic(Piece)
		  End If
		  
		  If Content.Mid(Pos, 1) = "=" Then
		    // Pair
		    Dim Key As Text = Content.Mid(Offset, Pos - Offset)
		    Offset = Pos + 1
		    Dim Value As Auto = Self.Import(Content, Offset)
		    Return New Beacon.Pair(Key.Trim, Value)
		  Else
		    // Array entry
		    Dim Piece As Text = Content.Mid(Offset, Pos - Offset)
		    Offset = Pos
		    Dim Value As Auto = Self.ImportIntrinsic(Piece)
		    Return Value
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportIntrinsic(Content As Text) As Auto
		  If Self.ShouldStop Then
		    Raise New Beacon.ThreadStopException
		  End If
		  
		  If Content = "" Then
		    Return Nil
		  End If
		  
		  If Content.Left(1) = """" And Content.Right(1) = """" Then
		    // Text in quotes
		    Return Content.Mid(1, Content.Length - 2)
		  ElseIf Content = "true" Or Content = "false" Then
		    // Boolean
		    Return Content = "true"
		  Else
		    Dim IsNumeric As Boolean = True
		    Dim DecimalPoints As Integer
		    For Each Char As Text In Content.Characters
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
		      Return Double.FromText(Content)
		    Else
		      // Probably Text
		      Return Content
		    End If
		  End If
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

	#tag Method, Flags = &h21
		Private Function PositionOfNextDelimeter(Offset As Integer, Content As Text) As Integer
		  If Self.ShouldStop Then
		    Raise New Beacon.ThreadStopException
		  End If
		  
		  Dim Positions() As Integer
		  Positions.Append(Content.IndexOf(Offset, "="))
		  Positions.Append(Content.IndexOf(Offset, ","))
		  Positions.Append(Content.IndexOf(Offset, ")"))
		  
		  Dim Position As Integer = -1
		  For I As Integer = 0 To UBound(Positions)
		    If Positions(I) = -1 Then
		      Continue
		    End If
		    If Position = -1 Then
		      Position = Positions(I)
		    Else
		      Position = Min(Position, Positions(I))
		    End If
		  Next
		  Return Position
		End Function
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
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Suspended"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
