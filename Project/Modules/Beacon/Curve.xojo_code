#tag Class
Protected Class Curve
	#tag CompatibilityFlags = ( not TargetHasGUI and not TargetWeb and not TargetIOS ) or ( TargetWeb ) or ( TargetHasGUI ) or ( TargetIOS )
	#tag Method, Flags = &h1
		Protected Function B0(XValue As Double) As Double
		  Return XValue * XValue * XValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function B1(XValue As Double) As Double
		  Return 3 * XValue * XValue * (1 - XValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function B2(XValue As Double) As Double
		  Return 3 * XValue * (1 - XValue) * (1 - XValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function B3(XValue As Double) As Double
		  Return (1 - XValue) * (1 - XValue) * (1 - XValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Creates an uninteresting linear curve
		  Self.Constructor(0.250, 0.250, 0.750, 0.750)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(P1X As Single, P1Y As Single, P2X As Single, P2Y As Single)
		  Self.Constructor(New Xojo.Core.Point(P1X, P1Y), New Xojo.Core.Point(P2X, P2Y))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(P1 As Xojo.Core.Point, P2 As Xojo.Core.Point)
		  Self.C0 = New Xojo.Core.Point(0, 0)
		  Self.C1 = New Xojo.Core.Point(P1.X, P1.Y)
		  Self.C2 = New Xojo.Core.Point(P2.X, P2.Y)
		  Self.C3 = New Xojo.Core.Point(1, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(XValue As Double, RangeBeginValue As Double, RangeEndValue As Double) As Double
		  If RangeBeginValue = RangeEndValue Then
		    Return RangeBeginValue
		  End If
		  
		  XValue = 1 - XValue
		  
		  Dim V0 As Double = Self.C0.Y * Self.B0(XValue)
		  Dim V1 As Double = Self.C1.Y * Self.B1(XValue)
		  Dim V2 As Double = Self.C2.Y * Self.B2(XValue)
		  Dim V3 As Double = Self.C3.Y * Self.B3(XValue)
		  
		  Dim YValue As Double = V0 + V1 + V2 + V3
		  Return RangeBeginValue + ((RangeEndValue - RangeBeginValue) * YValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("C1X") = Self.C1.X
		  Dict.Value("C1Y") = Self.C1.Y
		  Dict.Value("C2X") = Self.C2.X
		  Dict.Value("C2Y") = Self.C2.Y
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Dict As Xojo.Core.Dictionary) As Beacon.Curve
		  If Not Dict.HasAllKeys("C1X", "C1Y", "C2X", "C2Y") Then
		    Return Nil
		  End If
		  
		  Try
		    Return New Beacon.Curve(Dict.Value("C1X"), Dict.Value("C1Y"), Dict.Value("C2X"), Dict.Value("C2Y"))
		  Catch Err As TypeMismatchException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Curve) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.C1.X = Other.C1.X And Self.C1.Y = Other.C1.Y And Self.C2.X = Other.C2.X And Self.C2.Y = Other.C2.Y Then
		    Return 0
		  End If
		  
		  // There's no logical way to sort curves, so... whatever
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Point(Index As Integer) As Xojo.Core.Point
		  Select Case Index
		  Case 0
		    Return Self.C0
		  Case 1
		    Return Self.C1
		  Case 2
		    Return Self.C2
		  Case 3
		    Return Self.C3
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private C0 As Xojo.Core.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C1 As Xojo.Core.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C2 As Xojo.Core.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C3 As Xojo.Core.Point
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
