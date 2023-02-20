#tag Class
Protected Class ProfileColorChooser
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Var Cell As Integer = Self.IndexAtXY(X, Y)
		  If Self.mPressedCell <> Cell Or Self.mHoverCell <> Cell Then
		    Self.mPressedCell = Cell
		    Self.mHoverCell = Cell
		    Self.mOriginCell = Cell
		    Self.Refresh
		  End If
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var Cell As Integer = Self.IndexAtXY(X, Y)
		  If Cell <> Self.mOriginCell Then
		    Cell = -1
		  End If
		  If Self.mPressedCell <> Cell Or Self.mHoverCell <> Cell Then
		    Self.mPressedCell = Cell
		    Self.mHoverCell = Cell
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  Self.mHoverCell = -1
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  Self.mHoverCell = -1
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Var Cell As Integer = Self.IndexAtXY(X, Y)
		  If Self.mHoverCell <> Cell Then
		    Self.mHoverCell = Cell
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Var Cell As Integer = Self.IndexAtXY(X, Y)
		  If Cell <> Self.mOriginCell Then
		    Cell = -1
		  End If
		  If Cell > -1 Then
		    Self.mSelectedColor = CType(Cell, Ark.ServerProfile.Colors)
		    RaiseEvent Change()
		  End If
		  Self.mPressedCell = -1
		  Self.mOriginCell = -1
		  Self.mHoverCell = Cell
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  Var Padding As Double = (Self.ControlHeight - Self.CellHeight) / 2
		  Var ControlWidth As Integer = ((Self.CellHeight + Padding) * Self.CellCount) + Padding
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRoundRectangle(0, 0, ControlWidth, ControlHeight, ControlHeight, ControlHeight)
		  
		  For Idx As Integer = Self.mCellRects.FirstIndex To Self.mCellRects.LastIndex
		    Var ProfileColor As Ark.ServerProfile.Colors = CType(Idx, Ark.ServerProfile.Colors)
		    Var Style As Integer
		    If Self.mSelectedColor = ProfileColor Then
		      Style = Self.DrawSelected
		    ElseIf Self.mPressedCell = Idx Then
		      Style = Self.DrawPressed
		    ElseIf Self.mHoverCell = Idx Then
		      Style = Self.DrawHover
		    End If
		    Self.DrawCell(G, Self.mCellRects(Idx), ProfileColor, Style)
		  Next Idx
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ComputeRects()
		  Var Padding As Double = (Self.ControlHeight - Self.CellHeight) / 2
		  Var Left As Double = Padding
		  Self.mCellRects.ResizeTo(Self.CellCount - 1)
		  For Idx As Integer = Self.mCellRects.FirstIndex To Self.mCellRects.LastIndex
		    Var Rect As New Xojo.Rect(Left, Padding, Self.CellHeight, Self.CellHeight)
		    Left = Rect.Right + Padding
		    Self.mCellRects(Idx) = Rect
		  Next Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.ComputeRects()
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawCell(G As Graphics, Location As Xojo.Rect, ProfileColor As Ark.ServerProfile.Colors, Style As Integer)
		  If Style = Self.DrawHover Then
		    Location = New Xojo.Rect(Location.Left - 1, Location.Top - 1, Location.Width + 2, Location.Height + 2)
		  ElseIf Style = Self.DrawSelected Then
		    Location = New Xojo.Rect(Location.Left + 2, Location.Top + 2, Location.Width - 4, Location.Height - 4)
		  End If
		  
		  Select Case ProfileColor
		  Case Ark.ServerProfile.Colors.None
		    G.DrawingColor = SystemColors.ControlColor
		  Case Ark.ServerProfile.Colors.Blue
		    G.DrawingColor = SystemColors.SystemBlueColor
		  Case Ark.ServerProfile.Colors.Brown
		    G.DrawingColor = SystemColors.SystemBrownColor
		  Case Ark.ServerProfile.Colors.Green
		    G.DrawingColor = SystemColors.SystemGreenColor
		  Case Ark.ServerProfile.Colors.Grey
		    G.DrawingColor = SystemColors.SystemGrayColor
		  Case Ark.ServerProfile.Colors.Indigo
		    G.DrawingColor = SystemColors.SystemIndigoColor
		  Case Ark.ServerProfile.Colors.Orange
		    G.DrawingColor = SystemColors.SystemOrangeColor
		  Case Ark.ServerProfile.Colors.Pink
		    G.DrawingColor = SystemColors.SystemPinkColor
		  Case Ark.ServerProfile.Colors.Purple
		    G.DrawingColor = SystemColors.SystemPurpleColor
		  Case Ark.ServerProfile.Colors.Red
		    G.DrawingColor = SystemColors.SystemRedColor
		  Case Ark.ServerProfile.Colors.Teal
		    G.DrawingColor = SystemColors.SystemTealColor
		  Case Ark.ServerProfile.Colors.Yellow
		    G.DrawingColor = SystemColors.SystemYellowColor
		  End Select
		  
		  G.FillOval(Location.Left, Location.Top, Location.Width, Location.Height)
		  If Style = Self.DrawSelected Then
		    G.PenSize = 2
		    G.DrawingColor = SystemColors.ControlAccentColor
		    G.DrawOval(Location.Left - 4, Location.Top - 4, Location.Width + 8, Location.Height + 8)
		    G.PenSize = 1
		  End If
		  
		  G.DrawingColor = New ColorGroup(&c000000A0, &cFFFFFFA0)
		  G.DrawOval(Location.Left, Location.Top, Location.Width, Location.Height)
		  
		  If ProfileColor = Ark.ServerProfile.Colors.None Then
		    Var Center As New Xojo.Point(Location.Left + ((Location.Width - 1) / 2), Location.Top + ((Location.Height - 1) / 2))
		    G.DrawLine(Center.X - 1.5, Center.Y - 1.5, Center.X + 1.5, Center.Y + 1.5)
		    G.DrawLine(Center.X - 1.5, Center.Y + 1.5, Center.X + 1.5, Center.Y - 1.5)
		  End If
		  
		  If Style = Self.DrawPressed Then
		    G.DrawingColor = &c000000AA
		    G.FillOval(Location.Left, Location.Top, Location.Width, Location.Height)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexAtXY(X As Integer, Y As Integer) As Integer
		  For Idx As Integer = Self.mCellRects.FirstIndex To Self.mCellRects.LastIndex
		    Var Rect As Xojo.Rect = Self.mCellRects(Idx)
		    If Rect.Contains(X, Y) Then
		      Return Idx
		    End If
		  Next Idx
		  Return -1
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCellRects() As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverCell As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginCell As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedCell As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedColor As Ark.ServerProfile.Colors
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelectedColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedColor <> Value Then
			    Self.mSelectedColor = Value
			    Self.Refresh
			  End If
			End Set
		#tag EndSetter
		SelectedColor As Ark.ServerProfile.Colors
	#tag EndComputedProperty


	#tag Constant, Name = CellCount, Type = Double, Dynamic = False, Default = \"12", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CellHeight, Type = Double, Dynamic = False, Default = \"14", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ControlHeight, Type = Double, Dynamic = False, Default = \"22", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DrawHover, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DrawPressed, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DrawSelected, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="242"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollSpeed"
			Visible=false
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollingEnabled"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
