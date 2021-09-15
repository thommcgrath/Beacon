#tag Class
Protected Class Curve
	#tag CompatibilityFlags = ( not TargetHasGUI and not TargetWeb and not TargetIOS ) or ( TargetWeb ) or ( TargetHasGUI ) or ( TargetIOS )
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Creates an uninteresting linear curve
		  Self.Constructor(0.250, 0.250, 0.750, 0.750)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(P1 As Point, P2 As Point)
		  Self.C0 = New Point(0, 0)
		  Self.C1 = New Point(Max(Min(P1.X, 1), 0), Max(Min(P1.Y, 1), 0))
		  Self.C2 = New Point(Max(Min(P2.X, 1), 0), Max(Min(P2.Y, 1), 0))
		  Self.C3 = New Point(1, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(P1X As Single, P1Y As Single, P2X As Single, P2Y As Single)
		  Self.Constructor(New Point(P1X, P1Y), New Point(P2X, P2Y))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("C1X") = Self.C1.X
		  Dict.Value("C1Y") = Self.C1.Y
		  Dict.Value("C2X") = Self.C2.X
		  Dict.Value("C2Y") = Self.C2.Y
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Dict As Dictionary) As Beacon.Curve
		  If Not Dict.HasAllKeys("C1X", "C1Y", "C2X", "C2Y") Then
		    Return Nil
		  End If
		  
		  Try
		    Return New Beacon.Curve(Dict.Value("C1X"), Dict.Value("C1Y"), Dict.Value("C2X"), Dict.Value("C2Y"))
		  Catch Err As RuntimeException
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
		Function Point(Index As Integer) As Point
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
		Protected Shared Function Solve(Factor As Double, A As Double, B As Double, C As Double, D As Double) As Double
		  Return (1-Factor)^3 * A + 3*(1-Factor)^2 * Factor * B + 3*(1-Factor) * Factor^2 * C + Factor^3 * D
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function XForT(T As Double) As Double
		  Return Self.Solve(T, Self.C0.X, Self.C1.X, Self.C2.X, Self.C3.X)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function YForT(T As Double) As Double
		  Return Self.Solve(T, Self.C0.Y, Self.C1.Y, Self.C2.Y, Self.C3.Y)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private C0 As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C1 As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C2 As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C3 As Point
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
