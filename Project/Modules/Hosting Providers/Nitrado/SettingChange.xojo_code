#tag Class
Protected Class SettingChange
	#tag Method, Flags = &h0
		Function Category() As String
		  Return Self.mCategory
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Category As String, Key As String, Value As Variant)
		  Self.mCategory = Category
		  Self.mKey = Key
		  Self.mValue = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As String
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  Return Self.mValue
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCategory As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As Variant
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
			Name="mCategory"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
