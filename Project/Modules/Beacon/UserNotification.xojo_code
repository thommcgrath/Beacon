#tag Class
Protected Class UserNotification
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As String)
		  Self.Constructor()
		  Self.Message = Message
		  Self.Timestamp = New Date
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Dim Raw As String = Self.Message + Self.SecondaryMessage + Self.ActionURL
		  Return EncodeHex(Crypto.SHA1(Raw.Lowercase)).Lowercase
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ActionURL As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DoNotResurrect As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Message As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Read As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SecondaryMessage As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Timestamp As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		UserData As Dictionary
	#tag EndProperty


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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActionURL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Read"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoNotResurrect"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
