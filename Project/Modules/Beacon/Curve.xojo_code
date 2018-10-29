#tag Class
Protected Class Curve
	#tag CompatibilityFlags = ( not TargetHasGUI and not TargetWeb and not TargetIOS ) or ( TargetWeb ) or ( TargetHasGUI ) or ( TargetIOS )
	#tag Method, Flags = &h1
		Protected Shared Function Approximately(Value1 As Double, Value2 As Double) As Boolean
		  Return Xojo.Math.Abs(Value1 - Value2) < 0.000001
		End Function
	#tag EndMethod

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
		  Self.C1 = New Xojo.Core.Point(Max(Min(P1.X, 1), 0), Max(Min(P1.Y, 1), 0))
		  Self.C2 = New Xojo.Core.Point(Max(Min(P2.X, 1), 0), Max(Min(P2.Y, 1), 0))
		  Self.C3 = New Xojo.Core.Point(1, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function CubicRoot(Value As Double) As Double
		  Return If(Value < 0, ((1 - Value)^(1/3)) * -1, Value^(1/3))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(XValue As Double, RangeBeginValue As Double, RangeEndValue As Double) As Double
		  If RangeBeginValue = RangeEndValue Then
		    Return RangeBeginValue
		  End If
		  
		  Dim YValue As Double = Self.YForX(XValue)
		  Return RangeBeginValue + ((RangeEndValue - RangeBeginValue) * YValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(Time As Double, Rect As Xojo.Core.Rect) As Xojo.Core.Point
		  Dim X As Double = Self.XForT(Time)
		  Dim Y As Double = Self.YForT(Time)
		  
		  X = Rect.Left + (Rect.Width * X)
		  Y = Rect.Top + (Rect.Height * Y)
		  
		  Return New Xojo.Core.Point(X, Y)
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

	#tag Method, Flags = &h1
		Protected Function FindRoots(XValue As Double) As Double()
		  Dim PA3 As Double = 3 * Self.C0.X
		  Dim PB3 As Double = 3 * Self.C1.X
		  Dim PC3 As Double = 3 * Self.C2.X
		  Dim A As Double = (Self.C0.X * -1) + PB3 - PC3 + Self.C3.X
		  Dim B As Double = PA3 - (2 * PB3) + PC3
		  Dim C As Double = (PA3 * -1) + PC3
		  Dim D As Double = Self.C0.X - XValue
		  
		  If Self.Approximately(A, 0) Then
		    // This is not a cubic curve
		    If Self.Approximately(B, 0) Then
		      // Not a quadratic curve either
		      If Self.Approximately(C, 0) Then
		        // There are no possible solutions
		        Dim Results() As Double
		        Return Results
		      End If
		      
		      Dim Results(1) As Double
		      Results(0) = D * -1
		      Results(1) = C
		      Return Results
		    End If
		    
		    Dim Q As Double = Xojo.Math.Sqrt(C * C - 4 * B * d)
		    Dim B2 As Double = 2 * B
		    Dim Results(1) As Double
		    Results(0) = (Q - C) / B2
		    Results(1) = ((C * -1) - Q) / B2
		    Return Results
		  End If
		  
		  B = B / A
		  C = C / A
		  D = D / A
		  
		  Dim B3 As Double = B / 3
		  Dim P As Double = (3 * C - B * B) / 3
		  Dim P3 As Double = P / 3
		  Dim Q As Double = (2 * B * B * B - 9 * B * C + 27 * D) / 27
		  Dim Q2 As Double = Q / 2
		  Dim Discriminant As Double = Q2 * Q2 + P3 * P3 * P3
		  Dim U1, V1 As Double
		  
		  Const Tau = 6.2831853071
		  
		  If Discriminant < 0 Then
		    Dim MP3 As Double = (P * -1) / 3
		    Dim R As Double = Xojo.Math.Sqrt(MP3 * MP3 * MP3)
		    Dim T As Double = (Q * -1) / (2 * R)
		    Dim CosPhi As Double = If(T < -1, -1, If(T > 1, 1, T))
		    Dim Phi As Double = Xojo.Math.ACos(CosPhi)
		    Dim CRtR As Double = Self.CubicRoot(R)
		    Dim T1 As Double = 2 * CRtR
		    
		    Dim Results(2) As Double
		    Results(0) = T1 * Xojo.Math.Cos(Phi / 3) - B3
		    Results(1) = T1 * Xojo.Math.Cos((Phi + TAU) / 3) - B3
		    Results(2) = T1 * Xojo.Math.Cos((Phi + 2 * TAU) / 2) - B3
		    Return Results
		  ElseIf Discriminant = 0 Then
		    U1 = If(Q2 < 0, Self.CubicRoot(Q2 * -1), Self.CubicRoot(Q2) * -1)
		    Dim Results(1) As Double
		    Results(0) = 2 * U1 * B3
		    Results(1) = (U1 * -1) - B3
		    Return Results
		  Else
		    Dim SD As Double = Xojo.Math.Sqrt(Discriminant)
		    U1 = Self.CubicRoot((Q2 * -1) + SD)
		    V1 = Self.CubicRoot(Q2 + SD)
		    Dim Results(0) As Double
		    Results(0) = U1 - V1 - B3
		    Return Results
		  End If
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

	#tag Method, Flags = &h1
		Protected Function SolvePolynomial(Factor As Double, A As Double, B As Double, C As Double, D As Double) As Double
		  Return (1-Factor)^3 * A + 3*(1-Factor)^2 * Factor * B + 3*(1-Factor) * Factor^2 * C + Factor^3 * D
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TimeForX(X As Double) As Double
		  Dim Roots() As Double = Self.FindRoots(X)
		  For Each Time As Double In Roots
		    If (Time < 0 Or Time > 1) Then
		      Continue
		    End If
		    
		    Return Time
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function XForT(T As Double) As Double
		  Return Self.SolvePolynomial(T, Self.C0.X, Self.C1.X, Self.C2.X, Self.C3.X)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function YForT(T As Double) As Double
		  Return Self.SolvePolynomial(T, Self.C0.Y, Self.C1.Y, Self.C2.Y, Self.C3.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function YForX(X As Double) As Double
		  Dim Time As Double = Self.TimeForX(X)
		  Return Self.YForT(Time)
		End Function
	#tag EndMethod


	#tag Note, Name = Source
		I feel like such a cheat, but a lot of this code came from https://stackoverflow.com/a/51883347
		
	#tag EndNote


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
