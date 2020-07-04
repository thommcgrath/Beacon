#tag Class
Protected Class SourceList
Inherits ControlCanvas
	#tag Event
		Sub Activate()
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Deactivate()
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Var MousePoint As New Xojo.Point(X, Y)
		  Var Idx As Integer = Self.IndexAtPoint(MousePoint)
		  If Idx = -1 Then
		    Self.mMouseDown = False
		    Return True
		  End If
		  
		  Self.mMouseDown = True
		  Self.mMousePoint = MousePoint
		  Self.mMouseDownPoint = MousePoint
		  Self.mMouseDownIndex = Idx
		  Self.mMouseOverIndex = Idx
		  Self.Invalidate(Self.mMouseDownIndex)
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = New Xojo.Point(X, Y)
		  
		  Var OldIndex As Integer = Self.mMouseOverIndex
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  If OldIndex > -1 And Self.mMouseOverIndex <> OldIndex Then
		    Var OldRect As Rect = Self.mItemRects(OldIndex)
		    Self.Invalidate(OldRect.Left, OldRect.Top, OldRect.Width, OldRect.Height)
		  End If
		  
		  If Self.mMouseOverIndex > -1 Then
		    Var OverRect As Rect = Self.mItemRects(Self.mMouseOverIndex)
		    Self.Invalidate(OverRect.Left, OverRect.Top, OverRect.Width, OverRect.Height)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  If Self.mMouseDown Then
		    Return
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = Nil
		  
		  If Self.mMouseOverIndex <> -1 Then
		    Self.Invalidate(Self.mMouseOverIndex)
		    Self.mMouseOverIndex = -1
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = New Point(X, Y)
		  Var OldIndex As Integer = Self.mMouseOverIndex
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  If OldIndex > -1 And Self.mMouseOverIndex <> OldIndex Then
		    Self.Invalidate(OldIndex)
		  End If
		  
		  If Self.mMouseOverIndex > -1 Then
		    Self.Invalidate(Self.mMouseOverIndex)
		  End If
		  
		  #if TargetMacOS
		    Self.TrueWindow.NSWindowMBS.Movable = Self.mMouseOverIndex = -1
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = New Point(X, Y)
		  
		  If Self.mMouseDownIndex > -1 And Self.IndexAtPoint(Self.mMousePoint) = Self.mMouseDownIndex Then
		    Self.SelectedRowIndex = Self.mMouseDownIndex
		  End If
		  
		  Self.mMouseDown = False
		  Self.mMouseDownIndex = -1
		  
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.mSelectedRowIndex = -1
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  G.DrawingColor = SystemColors.ControlBackgroundColor
		  G.FillRectangle(0, 0, G.Width, G.Height)
		  
		  Var Rects() As Xojo.Rect
		  Rects.ResizeTo(Self.mItems.LastRowIndex)
		  
		  Const RowHeight = 30
		  Const Inset = 10
		  Const CornerRadius = 8
		  Const Padding = 8
		  
		  Var RowTop As Integer = Inset
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    Rects(Idx) = New Xojo.Rect(Inset, RowTop, G.Width - (Inset * 2), RowHeight)
		    RowTop = RowTop + RowHeight
		  Next
		  
		  Self.ContentHeight = RowTop + Inset
		  Self.mItemRects = Rects
		  
		  Var Viewport As New Xojo.Rect(0, 0, G.Width, G.Height)
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    Var ItemRect As Xojo.Rect = Self.mItemRects(Idx)
		    Var Draw As Boolean
		    If Viewport.Intersects(ItemRect) Then
		      If Areas.LastRowIndex = -1 Then
		        Draw = True
		      Else
		        For Each Area As Xojo.Rect In Areas
		          If Area.Intersects(ItemRect) Then
		            Draw = True
		          End If
		        Next
		      End If
		    End If
		    If Not Draw Then
		      Continue
		    End If
		    
		    Var Clip As Graphics = G.Clip(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height)
		    Var CaptionBaseline As Double = (Clip.Height / 2) + (Clip.CapHeight / 2)
		    Var CaptionLeft As Double = Padding
		    
		    If Self.SelectedRowIndex = Idx Then
		      Clip.DrawingColor = If(Self.Highlighted, SystemColors.ControlAccentColor, SystemColors.UnemphasizedSelectedContentBackgroundColor)
		      Clip.FillRoundRectangle(0, 0, Clip.Width, Clip.Height, CornerRadius, CornerRadius)
		      Clip.DrawingColor = If(Self.Highlighted, SystemColors.AlternateSelectedControlTextColor, SystemColors.UnemphasizedSelectedTextColor)
		    Else
		      Clip.DrawingColor = SystemColors.ControlTextColor
		    End If
		    Clip.DrawText(Self.mItems(Idx).Caption, CaptionLeft, CaptionBaseline, Clip.Width - (Padding * 2), True)
		    
		    If Self.mMouseDown And Self.mMouseOverIndex = Idx And Self.mMouseDownIndex = Idx Then
		      Clip.DrawingColor = &c000000AA
		      Clip.FillRoundRectangle(0, 0, Clip.Width, Clip.Height, CornerRadius, CornerRadius)
		    End If
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(ParamArray Items() As SourceListItem)
		  For Each Item As SourceListItem In Items
		    If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		      Self.mItems.AddRow(Item)
		      Self.Invalidate
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mItems.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexAtPoint(X As Integer, Y As Integer) As Integer
		  Return Self.IndexAtPoint(New Xojo.Point(X, Y))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexAtPoint(Point As Xojo.Point) As Integer
		  For Idx As Integer = 0 To Self.mItemRects.LastRowIndex
		    If (Self.mItemRects(Idx) Is Nil) = False And Self.mItemRects(Idx).Contains(Point) Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As SourceListItem) As Integer
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    If Self.mItems(Idx) = Item Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Idx As Integer, Item As SourceListItem)
		  If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		    If Idx < Self.mSelectedRowIndex Then
		      Self.mSelectedRowIndex = Self.mSelectedRowIndex + 1
		    End If
		    
		    Self.mItems.AddRowAt(Idx, Item)
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(Idx As Integer)
		  If Idx < Self.mItemRects.FirstRowIndex Or Idx > Self.mItemRects.LastRowIndex Then
		    Super.Invalidate(False)
		    Return
		  End If
		  
		  Var ItemRect As Rect = Self.mItemRects(Idx)
		  If ItemRect Is Nil Then
		    Super.Invalidate(False)
		    Return
		  End If
		  
		  Super.Invalidate(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Idx As Integer) As SourceListItem
		  If Idx >= 0 And Idx <= Self.mItems.LastRowIndex Then
		    Return Self.mItems(Idx)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Item(Idx As Integer, Assigns Item As SourceListItem)
		  If Idx >= 0 And Idx <= Self.mItems.LastRowIndex Then
		    Self.mItems(Idx) = Item
		    Self.Invalidate(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastItemIndex() As Integer
		  Return Self.mItems.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  #Pragma Warning "Won't trigger change event"
		  
		  If Idx >= 0 And Idx <= Self.mItems.LastRowIndex Then
		    Self.mItems.RemoveRowAt(Idx)
		    
		    If Idx <= Self.mSelectedRowIndex Then
		      Self.mSelectedRowIndex = Self.mSelectedRowIndex - 1
		    End If
		    
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAllItems()
		  #Pragma Warning "Won't trigger change event"
		  
		  Self.mItems.ResizeTo(-1)
		  Self.mSelectedRowIndex = -1
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedItem() As SourceListItem
		  If Self.SelectedRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.Item(Self.SelectedRowIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedItem(Assigns Item As SourceListItem)
		  Self.SelectedRowIndex = Self.IndexOf(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedTag() As Variant
		  If Self.mSelectedRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.mItems(Self.mSelectedRowIndex).Tag
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedTag(Assigns Tag As Variant)
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    If Self.mItems(Idx).Tag = Tag Then
		      Self.SelectedRowIndex = Idx
		      Return
		    End If
		  Next
		  Self.SelectedRowIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort()
		  Var Names() As String
		  Var SelectedItem As SourceListItem = Self.Item(Self.SelectedRowIndex)
		  
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    Names.AddRow(Self.mItems(Idx).Caption)
		  Next
		  
		  If Self.mItemRects.LastRowIndex = Self.mItems.LastRowIndex Then
		    Names.SortWith(Self.mItems, Self.mItemRects)
		  Else
		    Names.SortWith(Self.mItems)
		    Self.mItemRects.ResizeTo(-1)
		  End If
		  
		  If (SelectedItem Is Nil) = False Then
		    Self.mSelectedRowIndex = Self.IndexOf(SelectedItem)
		  End If
		  
		  Self.Invalidate
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldChange(DesiredIndex As Integer) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mContentHeight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mContentHeight = Value Then
			    Return
			  End If
			  
			  Self.mContentHeight = Value
			  Self.Invalidate()
			End Set
		#tag EndSetter
		Private ContentHeight As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mContentHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItemRects() As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As SourceListItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownPoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseOverIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMousePoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedRowIndex As Integer = -1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelectedRowIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedRowIndex <> Value Then
			    If IsEventImplemented("ShouldChange") Then
			      If Not RaiseEvent ShouldChange(Value) Then
			        Return
			      End If
			    End If
			    
			    If Self.mSelectedRowIndex > -1 Then
			      Self.Invalidate(Self.mSelectedRowIndex)
			    End If
			    Self.mSelectedRowIndex = Value
			    RaiseEvent Change
			    Self.Invalidate(Value)
			  End If
			End Set
		#tag EndSetter
		SelectedRowIndex As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group=""
			InitialValue=""
			Type="String"
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
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Transparent"
			Visible=true
			Group="Behavior"
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
			Name="SelectedRowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
