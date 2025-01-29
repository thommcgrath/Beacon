#tag Class
Protected Class BeaconSegmentedControl
Inherits ControlCanvas
Implements ObservationKit.Observer
	#tag Event
		Sub Activated()
		  Self.Refresh(False)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Deactivated()
		  Self.Refresh(False)
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Var SegmentIndex As Integer = Self.IndexForPoint(X, Y)
		  Self.mMouseDownIndex = SegmentIndex
		  Self.mPressedIndex = SegmentIndex
		  Self.Refresh(False)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var SegmentIndex As Integer = Self.IndexForPoint(X, Y)
		  Var PressedIndex As Integer = If(SegmentIndex = Self.mMouseDownIndex, SegmentIndex, -1)
		  If Self.mPressedIndex <> PressedIndex Then
		    Self.mPressedIndex = PressedIndex
		    Self.Refresh(False)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Var SegmentIndex As Integer = Self.IndexForPoint(X, Y)
		  If Self.mMouseDownIndex > -1 And SegmentIndex = Self.mMouseDownIndex Then
		    If Self.mAllowMultipleSelection Then
		      Self.mSegments(SegmentIndex).Selected = Not Self.mSegments(SegmentIndex).Selected
		    Else
		      Self.LockChangeEvent()
		      For Idx As Integer = Self.mSegments.FirstIndex To Self.mSegments.LastIndex
		        Self.mSegments(Idx).Selected = (Idx = SegmentIndex)
		      Next Idx
		      Self.UnlockChangeEvent()
		    End If
		  End If
		  Self.mMouseDownIndex = -1
		  Self.mPressedIndex = -1
		  Self.Refresh(False)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  Self.mOpening = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused SafeArea
		  
		  If Self.Width <> Self.mLastWidth Or Self.Height <> Self.mLastHeight Then
		    Self.ComputeRects(G)
		    Self.mLastWidth = Self.Width
		    Self.mLastHeight = Self.Height
		  End If
		  
		  Const BorderRadius = 12
		  Const CellRadius = BorderRadius - BorderSize
		  
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRoundRectangle(0, 0, Self.Width, Self.Height, BorderRadius, BorderRadius)
		  G.DrawingColor = SystemColors.SeparatorColor.AtOpacity(0.5)
		  G.DrawRoundRectangle(0, 0, Self.Width, Self.Height, BorderRadius, BorderRadius)
		  
		  Var SelectionRects() As Rect
		  For Row As Integer = 1 To Self.mRowCount
		    Var SelectionStart As Integer = -1
		    Var SelectionEnd As Integer = -1
		    Var MatchingTop As Integer = Self.BorderSize + ((Row - 1) * (Self.BorderSize + Self.RowHeight))
		    For Idx As Integer = Self.mSegments.FirstIndex To Self.mSegments.LastIndex
		      Var CellRect As Rect = Self.mSegmentRects(Idx)
		      If CellRect.Top <> MatchingTop Then
		        Continue
		      End If
		      
		      If Self.mSegments(Idx).Selected Then
		        SelectionEnd = CellRect.Right
		        If SelectionStart = -1 Then
		          SelectionStart = CellRect.Left
		        End If
		      ElseIf SelectionStart <> -1 And SelectionEnd <> -1 Then
		        SelectionRects.Add(New Rect(SelectionStart, CellRect.Top, SelectionEnd - SelectionStart, CellRect.Height))
		        SelectionStart = -1
		        SelectionEnd = -1
		      End If
		    Next Idx
		    If SelectionStart <> -1 And SelectionEnd <> -1 Then
		      SelectionRects.Add(New Rect(SelectionStart, MatchingTop, SelectionEnd - SelectionStart, Self.RowHeight))
		    End If
		  Next
		  
		  If Highlighted Then
		    G.DrawingColor = SystemColors.SelectedContentBackgroundColor
		  Else
		    G.DrawingColor = SystemColors.QuaternaryLabelColor
		  End If
		  For Each SelRect As Rect In SelectionRects
		    G.FillRoundRectangle(SelRect.Left, SelRect.Top, SelRect.Width, SelRect.Height, CellRadius, CellRadius)
		  Next SelRect
		  
		  
		  For Idx As Integer = Self.mSegments.FirstIndex To Self.mSegments.LastIndex
		    Var Segment As BeaconSegment = Self.mSegments(Idx)
		    Var CellRect As Rect = Self.mSegmentRects(Idx)
		    Var Baseline As Double = NearestMultiple(CellRect.Top + ((CellRect.Height / 2) + (G.CapHeight / 2)), G.ScaleY)
		    
		    Var CaptionWidth As Double = Min(G.TextWidth(Segment.Caption), CellRect.Width - 12)
		    Var CaptionLeft As Double = NearestMultiple(CellRect.Left + ((CellRect.Width - CaptionWidth) / 2), G.ScaleX)
		    
		    G.DrawingColor = If(Segment.Selected And Highlighted, SystemColors.AlternateSelectedControlTextColor, SystemColors.ControlTextColor)
		    G.DrawText(Segment.Caption, CaptionLeft, Baseline)
		    
		    If Idx = Self.mPressedIndex Then
		      G.DrawingColor = &c00000080
		      G.FillRoundRectangle(CellRect.Left, CellRect.Top, CellRect.Width, CellRect.Height, CellRadius, CellRadius)
		    End If
		  Next Idx
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Segments() As BeaconSegment)
		  For Each Segment As BeaconSegment In Segments
		    Self.mSegments.Add(Segment)
		    Self.mSegmentRects.Add(New Rect(0, 0, 10, 10)) // Just have to add something for now
		    Segment.AddObserver(Self, "Selected", "Caption")
		  Next
		  Self.ComputeRects()
		  Self.Refresh(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Segment As BeaconSegment)
		  Var Segments(0) As BeaconSegment
		  Segments(0) = Segment
		  Self.Add(Segments)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Captions() As String)
		  Var Segments() As BeaconSegment
		  Segments.ResizeTo(Captions.LastIndex)
		  For Idx As Integer = 0 To Segments.LastIndex
		    Segments(Idx) = New BeaconSegment(Captions(Idx), False)
		  Next
		  Self.Add(Segments)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Caption As String, Selected As Boolean = False)
		  Var Segments(0) As BeaconSegment
		  Segments(0) = New BeaconSegment(Caption, Selected)
		  Self.Add(Segments)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ComputeRects(G As Graphics = Nil)
		  If G Is Nil Then
		    Var Pic As New Picture(1, 1)
		    G = Pic.Graphics
		  End If
		  
		  Var BaseCellSize As Integer = 0
		  For Each Segment As BeaconSegment In Self.mSegments
		    Var SegmentWidth As Integer = G.TextWidth(Segment.Caption) + (Self.CellPadding * 2)
		    BaseCellSize = Max(BaseCellSize, SegmentWidth)
		  Next
		  Var Columns As Integer = Min(Floor((Self.Width - Self.BorderSize) / (BaseCellSize + Self.BorderSize)), Self.mSegments.Count)
		  Var TotalWidth As Integer = Self.Width - (Self.BorderSize + (Self.BorderSize * Columns))
		  BaseCellSize = Floor(TotalWidth / Columns)
		  
		  Var Rows As Integer = Ceiling(Self.mSegments.Count / Columns)
		  Var Remainder As Integer = TotalWidth - (Columns * BaseCellSize)
		  
		  Var Row As Integer = 1
		  Var Column As Integer = 1
		  Var RowTop As Integer = Self.BorderSize
		  Var CellLeft As Integer = Self.BorderSize
		  Var MaxRight As Integer = Self.Width - Self.BorderSize
		  For Idx As Integer = 0 To Self.mSegments.LastIndex
		    Var CellWidth As Integer = BaseCellSize + If(Column <= Remainder, 1, 0)
		    Var CellRect As New Rect(CellLeft, RowTop, CellWidth, Self.RowHeight)
		    Self.mSegmentRects(Idx) = CellRect
		    CellLeft = CellRect.Right + Self.BorderSize
		    Column = Column + 1
		    If CellLeft >= MaxRight Then
		      Row = Row + 1
		      RowTop = RowTop + Self.BorderSize + RowHeight
		      Column = 1
		      CellLeft = Self.BorderSize
		    End If
		  Next
		  
		  If Rows <> Self.mRowCount Then
		    Self.mRowCount = Rows
		    RaiseEvent RowCountChanged
		    Call CallLater.Schedule(1, WeakAddressOf DelayedRefresh)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mOpening = True
		  Self.mPressedIndex = -1
		  Self.mMouseDownIndex = -1
		  Self.mRowCount = 1
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DelayedRefresh()
		  Self.Refresh(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleChange()
		  If Self.mOpening Then
		    Return
		  End If
		  
		  If Self.mLockCount > 0 Then
		    Self.mChangedWhileLocked = True
		    Return
		  End If
		  
		  RaiseEvent Pressed()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IdealHeight() As Integer
		  Return Self.BorderSize + ((Self.RowHeight + Self.BorderSize) * Self.mRowCount)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexForPoint(X As Integer, Y As Integer) As Integer
		  For Idx As Integer = Self.mSegmentRects.FirstIndex To Self.mSegmentRects.LastIndex
		    If Self.mSegmentRects(Idx).Contains(X, Y) Then
		      Return Idx
		    End If
		  Next Idx
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Segment As BeaconSegment) As Integer
		  Return Self.IndexOf(Segment.Caption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Caption As String) As Integer
		  For Idx As Integer = Self.mSegments.FirstIndex To Self.mSegments.LastIndex
		    If Self.mSegments(Idx).Caption.Compare(Caption, ComparisonOptions.CaseSensitive) = 0 Then
		      Return Idx
		    End If
		  Next Idx
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As Integer
		  Return Self.mSegments.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LockChangeEvent()
		  Self.mLockCount = Self.mLockCount + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Key
		  #Pragma Unused OldValue
		  #Pragma Unused NewValue
		  
		  If Key = "Selected" Then
		    Self.HandleChange()
		  End If
		  
		  Self.Refresh(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Segment As BeaconSegment)
		  Var Idx As Integer = Self.IndexOf(Segment.Caption)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  If Self.mAllowMultipleSelection = False And Self.mSegments.Count > 1 And Self.mSegments(Idx).Selected = True Then
		    // Need to change the selection
		    Self.LockChangeEvent()
		    Self.mSegments(Idx).Selected = False
		    If Idx = Self.mSegments.LastIndex Then
		      Self.mSegments(Idx - 1).Selected = True
		    Else
		      Self.mSegments(Idx + 1).Selected = True
		    End If
		    Self.UnlockChangeEvent()
		  End If
		  
		  Self.mSegments(Idx).RemoveObserver(Self, "Selected", "Caption")
		  Self.mSegments.RemoveAt(Idx)
		  Self.mSegmentRects.RemoveAt(Idx)
		  Self.ComputeRects()
		  Self.Refresh(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Caption As String)
		  Var Idx As Integer = Self.IndexOf(Caption)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  Self.LockChangeEvent()
		  For Idx As Integer = Self.mSegments.LastIndex DownTo Self.mSegments.FirstIndex
		    Self.Remove(Idx)
		  Next Idx
		  Self.UnlockChangeEvent()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Segment(AtIndex As Integer) As BeaconSegment
		  Return Self.mSegments(AtIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Segment(AtIndex As Integer, Assigns Segment As BeaconSegment)
		  If Self.mSegments(AtIndex) <> Segment Then
		    Self.mSegments(AtIndex).RemoveObserver(Self, "Selected", "Caption")
		    Segment.AddObserver(Self, "Selected", "Caption")
		  End If
		  
		  Self.mSegments(AtIndex) = Segment
		  Self.Refresh(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SegmentCount() As Integer
		  Return Self.mSegments.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedSegments() As BeaconSegment()
		  Var Segments() As BeaconSegment
		  For Idx As Integer = Self.mSegments.FirstIndex To Self.mSegments.LastIndex
		    If Self.mSegments(Idx).Selected Then
		      Segments.Add(Self.mSegments(Idx))
		    End If
		  Next Idx
		  Return Segments
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnlockChangeEvent()
		  If Self.mLockCount = 0 Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Change locking is not active"
		    Raise Err
		  End If
		  
		  Self.mLockCount = Self.mLockCount - 1
		  
		  If Self.mLockCount = 0 And Self.mChangedWhileLocked Then
		    Self.mChangedWhileLocked = False
		    
		    RaiseEvent Pressed()
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Pressed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RowCountChanged()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAllowMultipleSelection
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAllowMultipleSelection = Value Then
			    Return
			  End If
			  
			  If Value = False Then
			    Var FoundSelection As Boolean
			    For Idx As Integer = 0 To Self.mSegments.LastIndex
			      If Self.mSegments(Idx).Selected Then
			        If FoundSelection Then
			          Self.mSegments(Idx).Selected = False
			        Else
			          FoundSelection = True
			        End If
			      End If
			    Next Idx
			  End If
			  
			  Self.mAllowMultipleSelection = Value
			End Set
		#tag EndSetter
		AllowMultipleSelection As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Var Captions() As String
			  For Idx As Integer = Self.mSegments.FirstIndex To Self.mSegments.LastIndex
			    Captions.Add(Self.mSegments(Idx).Caption)
			  Next Idx
			  Return String.FromArray(Captions, Encodings.ASCII.Chr(9))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSegments.ResizeTo(-1)
			  Self.mSegmentRects.ResizeTo(-1)
			  
			  Var Captions() As String = Value.Split(Encodings.ASCII.Chr(9))
			  For Each Caption As String In Captions
			    Self.Add(Caption)
			  Next Caption
			End Set
		#tag EndSetter
		InitialValue As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAllowMultipleSelection As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChangedWhileLocked As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLockCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpening As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRowCount As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSegmentRects() As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSegments() As BeaconSegment
	#tag EndProperty


	#tag Constant, Name = BorderSize, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CellPadding, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RowHeight, Type = Double, Dynamic = False, Default = \"18", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Width"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="AllowMultipleSelection"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
