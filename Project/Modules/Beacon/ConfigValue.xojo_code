#tag Class
Protected Class ConfigValue
	#tag Method, Flags = &h0
		Sub Constructor(Header As Text, Key As Text, Value As Text)
		  Self.mHeader = Header
		  Self.mKey = Key
		  Self.mValue = Value
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHeader
			End Get
		#tag EndGetter
		Header As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKey
			End Get
		#tag EndGetter
		Key As Text
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHeader As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Idx As Integer = Self.mKey.IndexOf("[")
			  If Idx = -1 Then
			    Return Self.mKey
			  Else
			    Return Self.mKey.Left(Idx)
			  End If
			End Get
		#tag EndGetter
		SimplifiedKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mValue
			End Get
		#tag EndGetter
		Value As Text
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Key"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Header"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
