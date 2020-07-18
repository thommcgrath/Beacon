#tag Class
Protected Class Point3D
	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Point3D)
		  Self.X = Source.X
		  Self.Y = Source.Y
		  Self.Z = Source.Z
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(X As Double, Y As Double, Z As Double)
		  Self.X = X
		  Self.Y = Y
		  Self.Z = Z
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.Point3D
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  If Dict.HasAllKeys("x", "y", "z") Then
		    Return New Beacon.Point3D(Dict.Value("x"), Dict.Value("y"), Dict.Value("z"))
		  ElseIf Dict.HasAllKeys("X", "Y", "Z") Then
		    Return New Beacon.Point3D(Dict.Value("X"), Dict.Value("Y"), Dict.Value("Z"))
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Point3D) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.X = Other.X And Self.Y = Other.Y And Self.Z = Other.Z Then
		    Return 0
		  End If
		  
		  // How do you really sort these?
		  If Self.X + Self.Y + Self.Z > Other.X + Other.Y + Other.Z Then
		    Return 1
		  Else
		    Return -1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("x") = Self.X
		  Dict.Value("y") = Self.Y
		  Dict.Value("z") = Self.Z
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		X As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Y As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Z As Double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
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
			Name="X"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Z"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
