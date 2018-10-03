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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As Text
		  Dim Raw As Text = Self.Message + Self.SecondaryMessage + Self.ActionURL
		  Return Beacon.EncodeHex(Xojo.Crypto.SHA1(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Raw.Lowercase))).Lowercase
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ActionURL As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		DoNotResurrect As Boolean
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
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActionURL"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Read"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryMessage"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
