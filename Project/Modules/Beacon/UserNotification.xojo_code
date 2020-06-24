#tag Class
Protected Class UserNotification
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Severity = Beacon.UserNotification.Severities.Normal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As String, Severity As Beacon.UserNotification.Severities = Beacon.UserNotification.Severities.Normal)
		  Self.Constructor()
		  Self.Message = Message
		  Self.Timestamp = New DateTime(DateTime.Now.SecondsFrom1970, New TimeZone(0))
		  Self.Severity = Severity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Var Raw As String = Self.Message + Self.SecondaryMessage + Self.ActionURL
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
		Severity As Beacon.UserNotification.Severities
	#tag EndProperty

	#tag Property, Flags = &h0
		Timestamp As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		UserData As Dictionary
	#tag EndProperty


	#tag Enum, Name = Severities, Type = Integer, Flags = &h0
		Normal
		Elevated
	#tag EndEnum


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
			Name="Message"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActionURL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Read"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryMessage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoNotResurrect"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Severity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Beacon.UserNotification.Severities"
			EditorType="Enum"
			#tag EnumValues
				"0 - Normal"
				"1 - Elevated"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
