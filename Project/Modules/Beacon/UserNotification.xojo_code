#tag Class
Protected Class UserNotification
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As Text)
		  Self.Constructor()
		  Self.Message = Message
		  Self.Timestamp = New Xojo.Core.Date(Xojo.Core.Date.Now.SecondsFrom1970, New Xojo.Core.TimeZone(0))
		  Self.Identifier = Beacon.CreateUUID
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ActionURL As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Identifier As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Message As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Read As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SecondaryMessage As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Timestamp As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h0
		UserData As Xojo.Core.Dictionary
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
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
