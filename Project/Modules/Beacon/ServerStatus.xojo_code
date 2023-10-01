#tag Class
Protected Class ServerStatus
	#tag Method, Flags = &h0
		Sub Constructor(Status As Integer)
		  Self.Constructor(Status, "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Status As Integer, Message As String, UserData As Variant)
		  Self.mStatus = Status
		  Self.mMessage = Message
		  Self.mUserData = UserData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Status As Integer, UserData As Variant)
		  Self.Constructor(Status, "", UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As String)
		  Self.Constructor(Self.Other, Message, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As String, UserData As Variant)
		  Self.Constructor(Self.Other, Message, UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  Return Self.mMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Integer
		  Return Self.Status
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserData() As Variant
		  Return Self.mUserData
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Variant
	#tag EndProperty


	#tag Constant, Name = Other, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Running, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Started, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Starting, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Stopped, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Stopping, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant


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
