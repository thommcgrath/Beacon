#tag Module
Protected Module Ark
	#tag Method, Flags = &h21
		Private Function Import(Content As Text, ByRef Key As Text) As Auto
		  Dim Pos As Integer = Content.IndexOf("=")
		  Key = Content.Left(Pos)
		  
		  Dim Body As Text = Content.Mid(Pos + 1).Trim
		  If Body.Left(1) = "(" Then
		    // Array or dictionary
		    Body = Body.Mid(1, Body.Length - 2)
		    If Body.IndexOf("=") > -1 Then
		      // Dictionary
		      Dim Dict As New Xojo.Core.Dictionary
		      Pos = 0
		      Do
		        Dim Idx As Integer = Body.IndexOf(Pos, ",")
		        If Idx = -1 Then
		          Exit
		        End If
		        
		        Dim Child As Text = Body.Mid(Pos, Idx - Pos)
		        Pos = Pos + Child.Length + 1
		        
		        Dim ChildKey As Text
		        Dim ChildValue As Auto = Ark.Import(Child, ChildKey)
		        Dict.Value(ChildKey) = ChildValue
		      Loop
		      Return Dict
		    Else
		      // Array
		      Break
		    End If
		  Else
		    // Intrinsic
		    Return Ark.ImportIntrinsic(Body)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportAsBeacon(Content As Text) As Ark.Beacon
		  
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
		    Dim Key As Text
		    Dim Value As Auto = Ark.Import(Line, Key)
		    Break
		  Next
		  Return Beacons
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportIntrinsic(Content As Text) As Auto
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
