#tag Module
Protected Module Ark
	#tag Method, Flags = &h21
		Private Function Import(Content As Text) As Auto
		  Dim Offset As Integer = 0
		  Return Ark.Import(Content, Offset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Import(Content As Text, ByRef Offset As Integer) As Auto
		  If Content.Mid(Offset, 1) = "(" Then
		    Dim IsDictionary As Boolean = True
		    Dim Children() As Auto
		    Do Until Content.Mid(Offset, 1) = ")"
		      Offset = Offset + 1
		      Dim Value As Auto = Ark.Import(Content, Offset)
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
		  
		  Dim Pos As Integer = Ark.PositionOfNextDelimeter(Offset, Content)
		  If Pos = -1 Then
		    Dim Piece As Text = Content.Mid(Offset)
		    Offset = Offset + Piece.Length
		    Return Ark.ImportIntrinsic(Piece)
		  End If
		  
		  If Content.Mid(Pos, 1) = "=" Then
		    // Pair
		    Dim Key As Text = Content.Mid(Offset, Pos - Offset)
		    Offset = Pos + 1
		    Dim Value As Auto = Ark.Import(Content, Offset)
		    Return New Ark.Pair(Key, Value)
		  Else
		    // Array entry
		    Dim Piece As Text = Content.Mid(Offset, Pos - Offset)
		    Offset = Pos
		    Dim Value As Auto = Ark.ImportIntrinsic(Piece)
		    Return Value
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function ImportFromConfig(File As Global.FolderItem) As Ark.Beacon()
		  Dim Path As String = File.NativePath
		  Return Ark.ImportFromConfig(New Xojo.IO.FolderItem(Path.ToText))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ImportFromConfig(File As Xojo.IO.FolderItem) As Ark.Beacon()
		  Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(File, Xojo.Core.TextEncoding.UTF8)
		  Dim Lines() As Text
		  While Not Stream.EOF
		    Dim Line As Text = Stream.ReadLine.Trim
		    If Line.Left(30) = "ConfigOverrideSupplyCrateItems" Then
		      Lines.Append(Line)
		    End If
		  Wend
		  Stream.Close
		  
		  Dim Beacons() As Ark.Beacon
		  For Each Line As Text In Lines
		    Dim Value As Auto = Ark.Import(Line)
		    If Value IsA Ark.Pair And Ark.Pair(Value).Key = "ConfigOverrideSupplyCrateItems" Then
		      Dim Dict As Xojo.Core.Dictionary = Ark.Pair(Value).Value
		      Dim Beacon As Ark.Beacon = Ark.Beacon.Import(Dict)
		      If Beacon <> Nil Then
		        Beacons.Append(Beacon)
		      End If
		    End If
		  Next
		  Return Beacons
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportIntrinsic(Content As Text) As Auto
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
		Private Function PositionOfNextDelimeter(Offset As Integer, Content As Text) As Integer
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
		Function UBound(Item As Ark.Countable) As Integer
		  Return Item.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound(Extends Item As Ark.Countable) As Integer
		  Return Item.Count - 1
		End Function
	#tag EndMethod


	#tag Constant, Name = QualityApprentice, Type = Double, Dynamic = False, Default = \"2.5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendant, Type = Double, Dynamic = False, Default = \"10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityJourneyman, Type = Double, Dynamic = False, Default = \"4.5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityMastercraft, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityPrimitive, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityRamshackle, Type = Double, Dynamic = False, Default = \"1.25", Scope = Protected
	#tag EndConstant


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
End Module
#tag EndModule
