#tag Class
Protected Class DocumentMergeFlagItem
Inherits Beacon.DocumentMergeItem
	#tag Method, Flags = &h0
		Sub Constructor(Label As String, FlagsToSet As UInt64, FlagsToRemove As UInt64)
		  Self.Label = Label
		  Self.mFlagsToSet = FlagsToSet
		  Self.mFlagsToRemove = FlagsToRemove
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlagsToRemove() As UInt64
		  Return Self.mFlagsToRemove
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlagsToSet() As UInt64
		  Return Self.mFlagsToSet
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFlagsToRemove As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlagsToSet As UInt64
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
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
