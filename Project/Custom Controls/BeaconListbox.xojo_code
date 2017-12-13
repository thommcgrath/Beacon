#tag Class
Protected Class BeaconListbox
Inherits Listbox
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  #Pragma Unused Column
		  
		  Dim TextColor As Color
		  Dim IsHighlighted As Boolean = Self.Highlighted And Self.Window.Focus = Self
		  If Row < Self.ListCount And Self.Selected(Row) Then
		    G.ForeColor = if(IsHighlighted, Self.SelectedRowColor, Self.SelectedRowColorInactive)
		    TextColor = if(IsHighlighted, Self.SelectedTextColor, Self.SelectedTextColorInactive)
		  Else
		    G.ForeColor = if(Row Mod 2 = 0, Self.PrimaryRowColor, Self.AlternateRowColor)
		    TextColor = Self.TextColor
		  End If
		  
		  G.FillRect(0, 0, G.Width, G.Height)
		  
		  Call CellBackgroundPaint(G, Row, Column, G.ForeColor, TextColor, IsHighlighted)
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  #Pragma Unused X
		  
		  Dim IsHighlighted As Boolean = Self.Highlighted And Self.Window.Focus = Self
		  Dim RefTextColor As Color
		  If Self.Selected(Row) Then
		    RefTextColor = if(IsHighlighted, Self.SelectedTextColor, Self.SelectedTextColorInactive)
		  Else
		    RefTextColor = Self.TextColor
		  End If
		  
		  Dim LeftEdge As Integer = 0
		  Dim DrawWidth As Integer = Self.Column(Column).WidthActual - 8
		  Dim RightEdge As Integer = LeftEdge + DrawWidth
		  
		  If CellTextPaint(G, Row, Column, RefTextColor, New Xojo.Core.Rect(LeftEdge, 0, DrawWidth, Self.DefaultRowHeight), Y, IsHighlighted) Then
		    Return True
		  End If
		  
		  G.ForeColor = RefTextColor
		  G.TextFont = "System"
		  
		  Dim Contents As String = Self.Cell(Row, Column)
		  Dim ContentsWidth As Integer = Min(Ceil(G.StringWidth(Contents)), DrawWidth)
		  Dim ContentsLeft As Integer
		  Dim Align As Integer = Self.CellAlignment(Row, Column)
		  If Align = Listbox.AlignDefault Then
		    Align = Self.ColumnAlignment(Column)
		  End If
		  Select Case Align
		  Case Listbox.AlignLeft, Listbox.AlignDefault
		    ContentsLeft = LeftEdge
		  Case Listbox.AlignCenter
		    ContentsLeft = ((DrawWidth - ContentsWidth) / 2) + LeftEdge
		  Case Listbox.AlignRight, Listbox.AlignDecimal
		    ContentsLeft = RightEdge - ContentsWidth
		  End Select
		  
		  ContentsLeft = ContentsLeft + Self.ColumnAlignmentOffset(Column) + Self.CellAlignmentOffset(Row, Column)
		  
		  G.DrawString(Contents, ContentsLeft, Y + 1, DrawWidth, True)
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  If Self.Window = Nil Or Self.Window.Focus <> Self Then
		    Return
		  End If
		  
		  Dim Board As New Clipboard
		  Dim CanCopy As Boolean = RaiseEvent CanCopy()
		  Dim CanDelete As Boolean = RaiseEvent CanDelete()
		  Dim CanPaste As Boolean = RaiseEvent CanPaste(Board)
		  
		  EditCopy.Enabled = CanCopy
		  EditCut.Enabled = CanCopy And CanDelete
		  EditClear.Enabled = CanDelete
		  EditPaste.Enabled = CanPaste
		  
		  RaiseEvent EnableMenuItems()
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If (Key = Chr(8) Or Key = Chr(127)) And CanDelete() Then
		    RaiseEvent PerformClear(True)
		    Return True
		  Else
		    Return RaiseEvent KeyDown(Key)
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.TextFont = "SmallSystem"
		  Self.DefaultRowHeight = Max(22, Self.DefaultRowHeight)
		  
		  RaiseEvent Open
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditClear() As Boolean Handles EditClear.Action
			RaiseEvent PerformClear(True)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
			Dim Board As New Clipboard
			RaiseEvent PerformCopy(Board)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
			Dim Board As New Clipboard
			RaiseEvent PerformCopy(Board)
			RaiseEvent PerformClear(False)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			Dim Board As New Clipboard
			RaiseEvent PerformPaste(Board)
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function CanCopy() As Boolean
		  Return RaiseEvent CanCopy()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanPaste() As Boolean
		  Dim Board As New Clipboard
		  Return RaiseEvent CanPaste(Board)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnsureSelectionIsVisible()
		  Dim ViewportHeight As Integer = Self.Height
		  If Self.HasHeading Then
		    ViewportHeight = ViewportHeight - Self.HeaderHeight
		  End If
		  If Self.Border Then
		    ViewportHeight = ViewportHeight - 2
		  End If
		  Dim VisibleStart As Integer = Self.ScrollPosition
		  Dim VisibleEnd As Integer = VisibleStart + Floor(ViewportHeight / Self.DefaultRowHeight)
		  Dim AtLeastOneVisible As Boolean
		  
		  For I As Integer = 0 To Self.ListCount - 1
		    If Self.Selected(I) Then
		      AtLeastOneVisible = AtLeastOneVisible Or (I >= VisibleStart And I <= VisibleEnd)
		    End If
		  Next
		  If AtLeastOneVisible = False And Self.SelCount > 0 Then
		    Self.ScrollPosition = Self.ListIndex
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Highlighted() As Boolean
		  If Self.Enabled Then
		    #if TargetCocoa
		      Declare Function IsMainWindow Lib "Cocoa.framework" Selector "isMainWindow" (Target As Integer) As Boolean
		      Declare Function IsKeyWindow Lib "Cocoa.framework" Selector "isKeyWindow" (Target As Integer) As Boolean
		      Return IsKeyWindow(Self.TrueWindow.Handle) Or IsMainWindow(Self.TrueWindow.Handle)
		    #else
		      Return True
		    #endif
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CanCopy() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanDelete() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanPaste(Board As Clipboard) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellTextPaint(G As Graphics, Row As Integer, Column As Integer, ByRef TextColor As Color, DrawSpace As Xojo.Core.Rect, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyDown(Key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformClear(Warn As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformCopy(Board As Clipboard)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformPaste(Board As Clipboard)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.ListCount
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.ListCount = Value Then
			    Return
			  End If
			  
			  Dim Count As Integer = Self.ListCount
			  While Count < Value
			    Self.AddRow("")
			    Count = Count + 1
			  Wend
			  While Count > Value
			    Self.RemoveRow(Count - 1)
			    Count = Count - 1
			  Wend
			End Set
		#tag EndSetter
		RowCount As Integer
	#tag EndComputedProperty


	#tag Constant, Name = AlternateRowColor, Type = Color, Dynamic = False, Default = \"&cFAFAFA", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PrimaryRowColor, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedRowColor, Type = Color, Dynamic = False, Default = \"&c0850CE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedRowColorInactive, Type = Color, Dynamic = False, Default = \"&cCACACA", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedTextColor, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedTextColorInactive, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TextColor, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Border"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnsResizable"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataSource"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="22"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableDrag"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableDragReorder"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesHorizontal"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesVertical"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeading"
			Visible=true
			Group="Appearance"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hierarchical"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollbarHorizontal"
			Visible=true
			Group="Appearance"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollBarVertical"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowDropIndicator"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFont"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
