#tag Class
Protected Class Map
	#tag Method, Flags = &h0
		Sub Constructor(Name As Text, Mask As UInt64, DifficultyScale As Double)
		  Self.mName = Name
		  Self.mMask = Mask
		  Self.mDifficultyScale = DifficultyScale
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyOffset(DifficultyValue As Double) As Double
		  Return Min((DifficultyValue - 0.5) / (Self.mDifficultyScale - 0.5), 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyScale() As Double
		  Return Self.mDifficultyScale
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyValue(DifficultyOffset As Double) As Double
		  DifficultyOffset = Min(DifficultyOffset, 1.0)
		  Return (DifficultyOffset * (Self.mDifficultyScale - 0.5)) + 0.5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask() As UInt64
		  Return Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Value As UInt64) As Boolean
		  Return (Value And Self.mMask) = Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Map) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.mMask > Other.mMask Then
		    Return 1
		  ElseIf Self.mMask < Other.mMask Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDifficultyScale As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
