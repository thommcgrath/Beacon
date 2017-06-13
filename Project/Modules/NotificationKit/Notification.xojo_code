#tag Class
Protected Class Notification
	#tag Method, Flags = &h0
		Sub Constructor(Name As Text)
		  Self.Constructor(Name, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As Text, UserData As Auto)
		  Self.mName = Name
		  Self.mUserData = UserData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserData() As Auto
		  Return Self.mUserData
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mName As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Auto
	#tag EndProperty


End Class
#tag EndClass
