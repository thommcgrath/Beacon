#tag Class
Private Class ColorGroupMimic
	#tag Method, Flags = &h21
		Private Shared Function ColorGroupsSupported() As Boolean
		  If Not mColorGroupsTested Then
		    mColorGroupsSupported = XojoVersion >= 2021.01 Or TargetMacOS = False Or SystemInformationMBS.isMojave(True)
		    mColorGroupsTested = True
		  End If
		  Return mColorGroupsSupported
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(LightColor As Color)
		  If Self.ColorGroupsSupported Then
		    Self.mGroup = New ColorGroup(LightColor)
		  Else
		    Self.mFallbackColor = LightColor
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(LightColor As Color, DarkColor As Color)
		  If Self.ColorGroupsSupported Then
		    Self.mGroup = New ColorGroup(LightColor, DarkColor)
		  Else
		    Self.mFallbackColor = LightColor
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Named As String)
		  If Self.ColorGroupsSupported Then
		    Self.mGroup = New ColorGroup(Named)
		  Else
		    Raise New InvalidArgumentException
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Color
		  If Self.mGroup Is Nil Then
		    Return Self.mFallbackColor
		  Else
		    Return Self.mGroup
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mColorGroupsSupported As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mColorGroupsTested As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFallbackColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGroup As ColorGroup
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
	#tag EndViewBehavior
End Class
#tag EndClass
