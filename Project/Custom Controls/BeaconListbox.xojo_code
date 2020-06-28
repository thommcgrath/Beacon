#tag Class
Protected Class BeaconListbox
Inherits Listbox
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mCellActionCascading Then
		    // Looks like CellCheckBoxValueAt does not trigger CellAction, but just in case
		    Return
		  End If
		  
		  Self.mCellActionCascading = True
		  RaiseEvent BulkColumnChangeStarted(Column)
		  RaiseEvent CellAction(Row, Column)
		  
		  If Self.CellTypeAt(Row, Column) = Listbox.CellTypes.CheckBox And (TargetMacOS And Keyboard.AsyncCommandKey) Or (Not TargetMacOS And Keyboard.AsyncControlKey) Then
		    Var DesiredValue As Boolean = Self.CellCheckBoxValueAt(Row, Column)
		    For Idx As Integer = Self.LastRowIndex DownTo 0
		      If Idx <> Row And Self.CellCheckBoxValueAt(Idx, Column) <> DesiredValue Then
		        Self.CellCheckBoxValueAt(Idx, Column) = DesiredValue
		        RaiseEvent CellAction(Idx, Column)
		      End If
		    Next
		  End If
		  
		  Self.mCellActionCascading = False
		  RaiseEvent BulkColumnChangeFinished(Column)
		End Sub
	#tag EndEvent

	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  #Pragma Unused Column
		  
		  Const InsetAmount = 20
		  Const CornerRadius = 8
		  
		  Var ColumnWidth As Integer = Self.ColumnAt(Column).WidthActual
		  Var RowHeight As Integer = Self.DefaultRowHeight
		  
		  Var RowInvalid, RowSelected As Boolean
		  If Row < Self.RowCount Then
		    RowInvalid = RowIsInvalid(Row)
		    RowSelected = Self.Selected(Row)
		  End If
		  
		  // Need to fill with color first so translucent system colors can apply correctly
		  If Self.Transparent Then
		    G.ClearRectangle(0, 0, G.Width, G.Height)
		  End If
		  G.DrawingColor = SystemColors.ControlBackgroundColor
		  G.FillRectangle(0, 0, G.Width, G.Height)
		  
		  #if false
		    #if TargetMacOS
		      Var OSMajor, OSMinor, OSBug As Integer
		      UpdateChecker.OSVersion(OSMajor, OSMinor, OSBug)
		      If Self.Transparent And OSMajor >= 10 And OSMinor >= 14 Then
		        G.ClearRectangle(0, 0, G.Width, G.Height)
		      Else
		        G.DrawingColor = SystemColors.UnderPageBackgroundColor
		        G.FillRectangle(0, 0, G.Width, G.Height)
		      End If
		    #else
		      G.DrawingColor = SystemColors.UnderPageBackgroundColor
		      G.FillRectangle(0, 0, G.Width, G.Height)
		    #endif
		  #endif
		  
		  Var InsetLeft, InsetRight As Integer
		  If Column = 0 Then
		    InsetLeft = InsetAmount
		  End If
		  If Column = Self.ColumnCount - 1 Then
		    InsetRight = InsetAmount
		  End If
		  
		  // To ensure a consistent drawing experience. Partially obscure rows traditionally have a truncated g.height value.
		  Var Clip As Graphics = G.Clip(InsetLeft, 0, ColumnWidth - (InsetLeft + InsetRight), RowHeight)
		  
		  Var BackgroundColor, TextColor, SecondaryTextColor As Color
		  Var IsHighlighted As Boolean = Self.Highlighted And Self.Window.Focus = Self
		  If RowSelected Then
		    If IsHighlighted Then
		      BackgroundColor = If(RowInvalid, SystemColors.SystemRedColor, SystemColors.SelectedContentBackgroundColor)
		      TextColor = SystemColors.AlternateSelectedControlTextColor
		    Else
		      BackgroundColor = SystemColors.UnemphasizedSelectedContentBackgroundColor
		      TextColor = SystemColors.UnemphasizedSelectedTextColor
		    End If
		    SecondaryTextColor = TextColor
		  Else
		    BackgroundColor = If(Row Mod 2 = 0, SystemColors.ListEvenRowColor, SystemColors.ListOddRowColor)
		    TextColor = If(RowInvalid, SystemColors.SystemRedColor, SystemColors.TextColor)
		    SecondaryTextColor = If(RowInvalid, TextColor, SystemColors.SecondaryLabelColor)
		  End If
		  
		  Clip.DrawingColor = BackgroundColor
		  
		  Var LeftPad, RightPad As Integer = CornerRadius
		  If Column = 0 Then
		    LeftPad = 0
		  End If
		  If Column = Self.ColumnCount - 1 Then
		    RightPad = 0
		  End If
		  Clip.FillRoundRectangle(0 - LeftPad, 0, Clip.Width + LeftPad + RightPad, Clip.Height, CornerRadius, CornerRadius)
		  
		  Call CellBackgroundPaint(Clip, Row, Column, BackgroundColor, TextColor, IsHighlighted)
		  
		  If Row >= Self.RowCount Then
		    Return True
		  End If
		  
		  // Text paint
		  
		  Const CellPadding = 4
		  Const LineSpacing = 6
		  
		  Var Contents As String = Me.CellValueAt(Row, Column).ReplaceLineEndings(EndOfLine)
		  Var Lines() As String = Contents.Split(EndOfLine)
		  Var MaxDrawWidth As Integer = ColumnWidth - (CellPadding * 4)
		  
		  If Lines.LastRowIndex = -1 Then
		    Return True
		  End If
		  
		  Var IsChecked As Boolean = Self.ColumnTypeAt(Column) = Listbox.CellTypes.CheckBox Or Self.CellTypeAt(Row, Column) = Listbox.CellTypes.CheckBox
		  If IsChecked Then
		    MaxDrawWidth = MaxDrawWidth - 20
		  End If
		  
		  Clip.FontSize = 0
		  Clip.FontName = "System"
		  Clip.Bold = RowInvalid
		  
		  // Need to compute the combined height of the lines
		  Var TotalTextHeight As Double = Clip.CapHeight
		  Clip.FontName = "SmallSystem"
		  Clip.Bold = False
		  TotalTextHeight = TotalTextHeight + ((Clip.CapHeight + LineSpacing) * Lines.LastRowIndex)
		  Clip.FontName = "System"
		  Clip.Bold = RowInvalid
		  
		  Var DrawTop As Double = (Clip.Height - TotalTextHeight) / 2
		  For I As Integer = 0 To Lines.LastRowIndex
		    Var LineWidth As Integer = Min(Ceil(Clip.TextWidth(Lines(I))), MaxDrawWidth)
		    
		    Var DrawLeft As Integer
		    Var Align As Listbox.Alignments = Self.CellAlignmentAt(Row, Column)
		    If Align = Listbox.Alignments.Default Then
		      Align = Self.ColumnAlignmentAt(Column)
		    End If
		    Select Case Align
		    Case Listbox.Alignments.Left, Listbox.Alignments.Default
		      DrawLeft = CellPadding + If(IsChecked, 20, 0)
		    Case Listbox.Alignments.Center
		      DrawLeft = CellPadding + If(IsChecked, 20, 0) + ((MaxDrawWidth - LineWidth) / 2)
		    Case Listbox.Alignments.Right, Listbox.Alignments.Decimal
		      DrawLeft = Clip.Width - (LineWidth + CellPadding)
		    End Select
		    
		    Var LineHeight As Double = Clip.CapHeight
		    Var LinePosition As Integer = Round(DrawTop + LineHeight)
		    
		    If Not CellTextPaint(Clip, Row, Column, Lines(I), TextColor, DrawLeft, LinePosition, IsHighlighted) Then
		      Clip.DrawingColor = If(I = 0, TextColor, SecondaryTextColor)
		      Clip.DrawText(Lines(I), DrawLeft, LinePosition, MaxDrawWidth, True)
		    End If
		    
		    DrawTop = DrawTop + LineSpacing + LineHeight
		    If I = 0 Then
		      Clip.FontName = "SmallSystem"
		      Clip.FontSize = 0
		      Clip.Bold = False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  #Pragma Unused G
		  #Pragma Unused Row
		  #Pragma Unused Column
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Change()
		  If Self.mBlockSelectionChangeCount > 0 Then
		    Self.mFireChangeWhenUnlocked = True
		    Return
		  End If
		  
		  RaiseEvent Change
		End Sub
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Var Board As New Clipboard
		  Var CanEdit As Boolean = RaiseEvent CanEdit()
		  Var CanCopy As Boolean = RaiseEvent CanCopy()
		  Var CanDelete As Boolean = RaiseEvent CanDelete()
		  Var CanPaste As Boolean = RaiseEvent CanPaste(Board)
		  
		  Var EditItem As New MenuItem(Self.mEditCaption, "edit")
		  EditItem.Enabled = CanEdit
		  Base.AddMenu(EditItem)
		  
		  Base.AddMenu(New MenuItem(MenuItem.TextSeparator))
		  
		  Var CutItem As New MenuItem("Cut", "cut")
		  CutItem.Shortcut = "X"
		  CutItem.Enabled = CanCopy And CanDelete
		  Base.AddMenu(CutItem)
		  
		  Var CopyItem As New MenuItem("Copy", "copy")
		  CopyItem.Shortcut = "C"
		  CopyItem.Enabled = CanCopy
		  Base.AddMenu(CopyItem)
		  
		  Var PasteItem As New MenuItem("Paste", "paste")
		  PasteItem.Shortcut = "V"
		  PasteItem.Enabled = CanPaste
		  Base.AddMenu(PasteItem)
		  
		  Var DeleteItem As New MenuItem("Delete", "clear")
		  DeleteItem.Enabled = CanDelete
		  Base.AddMenu(DeleteItem)
		  
		  Call ConstructContextualMenu(Base, X, Y)
		  
		  Var Bound As Integer = Base.Count - 1
		  For I As Integer = 0 To Bound
		    If Base.MenuAt(I) = DeleteItem And I < Bound Then
		      Base.AddMenuAt(I + 1, New MenuItem(MenuItem.TextSeparator))
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If HitItem.Tag <> Nil And HitItem.Tag.Type = Variant.TypeString Then
		    Select Case HitItem.Tag
		    Case "edit"
		      Self.DoEdit()
		      Return True
		    Case "cut"
		      Self.DoCut()
		      Return True
		    Case "copy"
		      Self.DoCopy()
		      Return True
		    Case "paste"
		      Self.DoPaste()
		      Return True
		    Case "clear"
		      Self.DoClear()
		      Return True
		    End Select
		  End If
		  
		  Return ContextualMenuAction(HitItem)
		End Function
	#tag EndEvent

	#tag Event
		Sub DoubleClick()
		  If IsEventImplemented("DoubleClick") Then
		    RaiseEvent DoubleClick
		  Else
		    If Self.CanEdit Then
		      Self.DoEdit
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  If Self.Window = Nil Or Self.Window.Focus <> Self Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  Var CanCopy As Boolean = RaiseEvent CanCopy()
		  Var CanDelete As Boolean = RaiseEvent CanDelete()
		  Var CanPaste As Boolean = RaiseEvent CanPaste(Board)
		  
		  EditCopy.Enabled = CanCopy
		  EditCut.Enabled = CanCopy And CanDelete
		  EditClear.Enabled = CanDelete
		  EditPaste.Enabled = CanPaste
		  
		  RaiseEvent EnableMenuItems
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(Key As String) As Boolean
		  Self.mForwardKeyUp = False
		  
		  If (Key = Encodings.UTF8.Chr(8) Or Key = Encodings.UTF8.Chr(127)) And Self.CanDelete() Then
		    Self.DoClear()
		    Return True
		  ElseIf (Key = Encodings.UTF8.Chr(10) Or Key = Encodings.UTF8.Chr(13)) And Self.CanEdit() Then
		    Self.DoEdit()
		    Return True
		  ElseIf RaiseEvent KeyDown(Key) Then
		    Self.mForwardKeyUp = True
		  Else
		    Self.mTypeaheadBuffer = Self.mTypeaheadBuffer + Key
		    If Self.mTypeaheadTimer.RunMode = Timer.RunModes.Off Then
		      Self.mTypeaheadTimer.RunMode = Timer.RunModes.Single
		    End If
		    Self.mTypeaheadTimer.Reset
		    Self.mTypeaheadTimer.Period = 1000
		    
		    If Not RaiseEvent Typeahead(Self.mTypeaheadBuffer) Then
		      For Idx As Integer = 0 To Self.LastRowIndex
		        If Self.CellValueAt(Idx, Self.TypeaheadColumn).BeginsWith(Self.mTypeaheadBuffer) Then
		          Self.SelectedRowIndex = Idx
		          Self.EnsureSelectionIsVisible()
		          Exit
		        End If
		      Next
		    End If
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub KeyUp(Key As String)
		  If Self.mForwardKeyUp Then
		    RaiseEvent KeyUp(Key)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.FontName = "SmallSystem"
		  Self.DefaultRowHeight = Max(26, Self.DefaultRowHeight)
		  
		  RaiseEvent Open
		  
		  Self.mPostOpenInvalidateCallbackKey = CallLater.Schedule(0, WeakAddressOf PostOpenInvalidate)
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditClear() As Boolean Handles EditClear.Action
			Self.DoClear()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
			Self.DoCopy()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
			Self.DoCut()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			Self.DoPaste()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function CanCopy() As Boolean
		  Return RaiseEvent CanCopy()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanDelete() As Boolean
		  Return RaiseEvent CanDelete()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanEdit() As Boolean
		  If IsEventImplemented("CanEdit") Then
		    Return RaiseEvent CanEdit()
		  End If
		  
		  Return (Self.EditableCell Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanPaste() As Boolean
		  Var Board As New Clipboard
		  Return RaiseEvent CanPaste(Board)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mTypeaheadTimer = New Timer
		  Self.mTypeaheadTimer.RunMode = Timer.RunModes.Off
		  AddHandler mTypeaheadTimer.Action, WeakAddressOf mTypeaheadTimer_Action
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mPostOpenInvalidateCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoClear()
		  RaiseEvent PerformClear(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoCopy()
		  Var Board As New Clipboard
		  RaiseEvent PerformCopy(Board)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoCut()
		  Var Board As New Clipboard
		  RaiseEvent PerformCopy(Board)
		  RaiseEvent PerformClear(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoEdit()
		  If IsEventImplemented("PerformEdit") Then
		    RaiseEvent PerformEdit
		    Return
		  End If
		  
		  // Look through the columns for exactly one editable cell
		  Var Cell As Point = Self.EditableCell
		  If (Cell Is Nil) = False Then
		    Self.EditCellAt(Cell.Y, Cell.X)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoPaste()
		  Var Board As New Clipboard
		  RaiseEvent PerformPaste(Board)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EditableCell() As Point
		  If Self.SelectedRowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Var Row As Integer = Self.SelectedRowIndex
		  Var Editable As Integer = -1
		  For Column As Integer = 0 To Self.LastColumnIndex
		    If Self.CellTypeAt(Row, Column) = Listbox.CellTypes.TextField Then
		      If Editable = -1 Then
		        Editable = Column
		      Else
		        Editable = -2
		      End If
		    End If
		  Next
		  
		  If Editable >= 0 Then
		    Return New Point(Editable, Row)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnsureSelectionIsVisible(Animated As Boolean = True)
		  If Self.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var VisibleStart As Integer = Self.ScrollPosition
		  Var VisibleEnd As Integer = VisibleStart + Self.VisibleRowCount
		  Var AtLeastOneVisible As Boolean
		  
		  For I As Integer = 0 To Self.RowCount - 1
		    If Self.Selected(I) Then
		      AtLeastOneVisible = AtLeastOneVisible Or (I >= VisibleStart And I <= VisibleEnd)
		    End If
		  Next
		  If Not AtLeastOneVisible Then
		    If Animated Then
		      Var Task As New AnimationKit.ScrollTask(Self)
		      Task.DurationInSeconds = 0.4
		      Task.Position = Self.SelectedRowIndex
		      Task.Curve = AnimationKit.Curve.CreateEaseOut
		      
		      If Self.mScrollTask <> Nil Then
		        Self.mScrollTask.Cancel
		        Self.mScrollTask = Nil
		      End If
		      
		      Self.mScrollTask = Task
		      Task.Run
		    Else
		      Self.ScrollPosition = Self.SelectedRowIndex
		    End If
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

	#tag Method, Flags = &h21
		Private Sub mTypeaheadTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  Self.mTypeaheadBuffer = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PostOpenInvalidate()
		  Self.ScrollPosition = Self.ScrollPosition
		  Self.Invalidate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RowCount(Assigns Value As Integer)
		  If Self.RowCount = Value Then
		    Return
		  End If
		  
		  Self.SelectionChangeBlocked = True
		  
		  #if TargetWindows
		    Var ScrollPosition As Integer = Self.ScrollPosition
		    Self.ScrollPosition = 0
		    Var ScrollerVisible As Boolean = Self.HasVerticalScrollbar
		    If ScrollerVisible Then
		      Self.HasVerticalScrollbar = False
		    End If
		  #endif
		  
		  Var Count As Integer = Self.RowCount
		  While Count < Value
		    Self.AddRow("")
		    Count = Count + 1
		  Wend
		  While Count > Value
		    Self.RemoveRowAt(Count - 1)
		    Count = Count - 1
		  Wend
		  
		  #if TargetWindows
		    If ScrollerVisible Then
		      Self.HasVerticalScrollbar = True
		      Self.ScrollPosition = ScrollPosition
		    End If
		  #endif
		  
		  Self.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BulkColumnChangeFinished(Column As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BulkColumnChangeStarted(Column As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanCopy() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanDelete() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanEdit() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanPaste(Board As Clipboard) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellAction(row As Integer, column As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellTextPaint(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContextualMenuAction(HitItem As MenuItem) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DoubleClick()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyDown(Key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyUp(Key As String)
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
		Event PerformEdit()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformPaste(Board As Clipboard)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RowIsInvalid(Row As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Typeahead(Buffer As String) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEditCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEditCaption.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mEditCaption = Value
			  End If
			End Set
		#tag EndSetter
		EditCaption As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBlockSelectionChangeCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCellActionCascading As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditCaption As String = "Edit"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFireChangeWhenUnlocked As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mForwardKeyUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPostOpenInvalidateCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollTask As AnimationKit.ScrollTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTypeaheadBuffer As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTypeaheadTimer As Timer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBlockSelectionChangeCount > 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.mBlockSelectionChangeCount = Self.mBlockSelectionChangeCount + 1
			  Else
			    Self.mBlockSelectionChangeCount = Self.mBlockSelectionChangeCount - 1
			  End If
			  
			  If Self.mBlockSelectionChangeCount = 0 And Self.mFireChangeWhenUnlocked Then
			    RaiseEvent Change
			    Self.mFireChangeWhenUnlocked = False
			  End If
			End Set
		#tag EndSetter
		SelectionChangeBlocked As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		TypeaheadColumn As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Var ViewportHeight As Integer = Self.Height
			  If Self.HasHeader Then
			    ViewportHeight = ViewportHeight - Self.HeaderHeight
			  End If
			  If Self.HasBorder Then
			    ViewportHeight = ViewportHeight - 2
			  End If
			  Return Floor(ViewportHeight / Self.DefaultRowHeight)
			End Get
		#tag EndGetter
		VisibleRowCount As Integer
	#tag EndComputedProperty


	#tag Constant, Name = AlternateRowColor, Type = Color, Dynamic = False, Default = \"&cFAFAFA", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DoubleLineRowHeight, Type = Double, Dynamic = False, Default = \"34", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedRowColor, Type = Color, Dynamic = False, Default = \"&c800000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedRowColorInactive, Type = Color, Dynamic = False, Default = \"&cD4BEBE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedTextColor, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedTextColorInactive, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidTextColor, Type = Color, Dynamic = False, Default = \"&c800000", Scope = Public
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

	#tag Constant, Name = StandardRowHeight, Type = Double, Dynamic = False, Default = \"26", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TextColor, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant


	#tag Structure, Name = CGRect, Flags = &h21
		X As CGFloat
		  Y As CGFloat
		  W As CGFloat
		H As CGFloat
	#tag EndStructure


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
			InitialValue="100"
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
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
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
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesHorizontalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
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
			Name="GridLinesVerticalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
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
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
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
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="26"
			Type="Integer"
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
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
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
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataSource"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionChangeBlocked"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="VisibleRowCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TypeaheadColumn"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditCaption"
			Visible=true
			Group="Behavior"
			InitialValue="Edit"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
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
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
