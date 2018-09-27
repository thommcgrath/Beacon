#tag Class
Protected Class Rect
	#tag Method, Flags = &h0
		Function Area() As Double
		  Return Self.mSize.Area
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Origin As BeaconUI.Point, Size As BeaconUI.Size)
		  Self.mOrigin = New BeaconUI.Point(Origin)
		  Self.mSize = New BeaconUI.Size(Size)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Left As Double, Top As Double, Width As Double, Height As Double)
		  Self.mOrigin = New BeaconUI.Point(Left, Top)
		  Self.mSize = New BeaconUI.Size(Width, Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(Point As BeaconUI.Point) As Boolean
		  Return Point.Left >= Self.Left And Point.Top >= Self.Top And Point.Left < Self.Right And Point.Top < Self.Bottom
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(Rect As BeaconUI.Rect) As Boolean
		  Return Rect.Left >= Self.Left And Rect.Top >= Self.Top And Rect.Right <= Self.Right And Rect.Bottom <= Self.Bottom
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(X As Double, Y As Double) As Boolean
		  Return Self.Contains(New BeaconUI.Point(X, Y))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Intersects(Rect As BeaconUI.Rect) As Boolean
		  Return Self.Left < Rect.Right And Self.Right > Rect.Left And Self.Top > Rect.Bottom And Self.Bottom < Rect.Top
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Point As BeaconUI.Point) As BeaconUI.Point
		  Return New BeaconUI.Point(Point.Left - Self.mOrigin.Left, Point.Top - Self.mOrigin.Top)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Rect As BeaconUI.Rect) As BeaconUI.Rect
		  Return New BeaconUI.Rect(Self.Localize(Rect.Origin), Rect.Size)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Offset(DeltaLeft As Double, DeltaTop As Double)
		  Self.mOrigin.Left = Self.mOrigin.Left + DeltaLeft
		  Self.mOrigin.Top = Self.mOrigin.Top + DeltaTop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Resize(DeltaWidth As Double, DeltaHeight As Double)
		  Self.mSize.Width = Self.mSize.Width + DeltaWidth
		  Self.mSize.Height = Self.mSize.Height + DeltaHeight
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOrigin.Top + Self.mSize.Height
			End Get
		#tag EndGetter
		Bottom As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSize.Height
			End Get
		#tag EndGetter
		Height As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOrigin.Left
			End Get
		#tag EndGetter
		Left As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOrigin As BeaconUI.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSize As BeaconUI.Size
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New BeaconUI.Point(Self.mOrigin)
			End Get
		#tag EndGetter
		Origin As BeaconUI.Point
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOrigin.Left + Self.mSize.Width
			End Get
		#tag EndGetter
		Right As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New BeaconUI.Size(Self.mSize)
			End Get
		#tag EndGetter
		Size As BeaconUI.Size
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOrigin.Top
			End Get
		#tag EndGetter
		Top As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSize.Width
			End Get
		#tag EndGetter
		Width As Double
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mOrigin"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mSize"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
