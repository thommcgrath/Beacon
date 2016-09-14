#tag Class
Private Class Pair
	#tag Method, Flags = &h0
		Sub Constructor(Key As Text, Value As Auto)
		  Self.mKey = Key
		  Self.mValue = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As Text
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Auto
		  Return Self.mValue
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mKey As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As Auto
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
