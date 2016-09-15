#tag Class
Protected Class Range
	#tag Method, Flags = &h0
		Sub Constructor(Min As Double, Max As Double)
		  If Min > Max Then
		    Self.mMin = Max
		    Self.mMax = Min
		  Else
		    Self.mMin = Min
		    Self.mMax = Max
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(Value As Double) As Boolean
		  Return Value >= Self.mMin And Value <= Self.mMax
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Difference() As Double
		  Return Self.mMax - Self.mMin
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Max() As Double
		  Return Self.mMax
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Min() As Double
		  Return Self.mMin
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Percent(Value As Double) As Double
		  Return (Value - Self.mMin) / (Self.mMax - Self.mMin)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMax As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMin As Double
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
