#tag Class
Protected Class ImportThread
Inherits Ark.Thread
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
		      If Value IsA Ark.Pair And Ark.Pair(Value).Key = "ConfigOverrideSupplyCrateItems" Then
		        Dim Dict As Xojo.Core.Dictionary = Ark.Pair(Value).Value
		        Dim Beacon As Ark.Beacon = Ark.Beacon.Import(Dict)
		        If Beacon <> Nil Then
		          Self.mBeacons.Append(Beacon)
		        End If
		      End If
		    Catch Stop As Ark.ThreadStopException
		      Self.mUpdateTimer.Mode = Xojo.Core.Timer.Modes.Off
		      Self.Reset
		      Return
		    Catch Err As RuntimeException
		      // Don't let an error halt processing, skip and move on
		    End Try
		    Self.mBeaconsProcessed = Self.mBeaconsProcessed + 1
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
		Function Beacons() As Ark.Beacon()
		  Dim Results() As Ark.Beacon
		  Redim Results(UBound(Self.mBeacons))
		  
		  For I As Integer = 0 To UBound(Self.mBeacons)
		    Results(I) = New Ark.Beacon(Self.mBeacons(I))
		  Next
		  
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeaconsProcessed() As UInteger
		  Return Self.mBeaconsProcessed
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
		    Raise New Ark.ThreadStopException
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
		        IsDictionary = Info.FullName = "Ark.Pair"
		      End If
		      Children.Append(Value)
		    Loop
		    Offset = Offset + 1
		    
		    If IsDictionary Then
		      Dim Dict As New Xojo.Core.Dictionary
		      For Each Child As Ark.Pair In Children
		        Dict.Value(Child.Key) = Child.Value
		      Next
		      Return Dict
		    Else
		      Return Children
		    End If
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
		    Return New Ark.Pair(Key, Value)
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
		    Raise New Ark.ThreadStopException
		  End If
		  
		  If Content = "" Then
		    Return Nil
		  End If
		  
		  If Content.Left(1) = """" And Content.Right(1) = """" Then
		    // Text
		    Return Content.Mid(1, Content.Length - 2)
		  ElseIf Content = "true" Or Content = "false" Then
		    // Boolean
		    Return Content = "true"
		  Else
		    // Number
		    Return Double.FromText(Content)
		  End If
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
		    Raise New Ark.ThreadStopException
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
		  Self.mBeaconsProcessed = 0
		  Redim Self.mBeacons(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Run()
		  Super.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub Run(File As Global.FolderItem)
		  If Self.State <> Ark.Thread.States.NotRunning Then
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
		  If Self.State <> Ark.Thread.States.NotRunning Then
		    Dim Err As New RuntimeException
		    Err.Reason = "Importer is already running"
		    Raise Err
		  End If
		  
		  Self.mContent = Content
		  Self.Run()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Sub Run(File As Xojo.IO.FolderItem)
		  If Self.State <> Ark.Thread.States.NotRunning Then
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
		Private mBeacons() As Ark.Beacon
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBeaconsProcessed As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContent As Text
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
			Type="Ark.Thread.States"
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
