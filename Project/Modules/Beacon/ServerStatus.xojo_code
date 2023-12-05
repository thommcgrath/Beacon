#tag Class
Protected Class ServerStatus
	#tag Method, Flags = &h0
		Sub Constructor(State As Beacon.ServerStatus.States)
		  Self.Constructor(State, "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(State As Beacon.ServerStatus.States, Message As String, UserData As Variant)
		  Self.mState = State
		  Self.mMessage = Message
		  Self.mUserData = UserData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(State As Beacon.ServerStatus.States, UserData As Variant)
		  Self.Constructor(State, "", UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As String)
		  Self.Constructor(Beacon.ServerStatus.States.Other, Message, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Message As String, UserData As Variant)
		  Self.Constructor(Beacon.ServerStatus.States.Other, Message, UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  Return Self.mMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerStatus) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Return Self.Operator_Compare(Other.mState)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(State As Beacon.ServerStatus.States) As Integer
		  Var MyValue As Integer = CType(Self.mState, Integer)
		  Var OtherValue As Integer = CType(State, Integer)
		  
		  If MyValue = OtherValue Then
		    Return 0
		  ElseIf MyValue > OtherValue Then
		    Return 1
		  Else
		    Return -1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function State() As Beacon.ServerStatus.States
		  Return Self.mState
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
		Private mState As Beacon.ServerStatus.States
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Variant
	#tag EndProperty


	#tag Enum, Name = States, Type = Integer, Flags = &h0
		Unsupported = -1
		  Other
		  Running
		  Starting
		  Stopped
		Stopping
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
	#tag EndViewBehavior
End Class
#tag EndClass
