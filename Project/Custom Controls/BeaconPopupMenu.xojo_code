#tag Class
Protected Class BeaconPopupMenu
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If RaiseEvent MouseDown(X, Y) Then
		    Self.mSubclassHandlesMouse = True
		    Return True
		  End If
		  
		  Self.mSubclassHandlesMouse = False
		  If Self.mHitRect <> Nil And Self.mHitRect.Contains(X, Y) Then
		    Self.mPressed = True
		    Self.Invalidate
		    
		    Dim Position As Xojo.Core.Point = Self.Window.GlobalPosition
		    Dim MenuPosX As Integer = Position.X + Self.Left + Self.mHitRect.Left
		    Dim MenuPosY As Integer = Position.Y + Self.Top + Self.mHitRect.Top
		    
		    Dim Menu As New MenuItem
		    For I As Integer = 0 To Self.mItems.Ubound
		      Dim Item As New MenuItem(Self.mItems(I), I)
		      Item.Checked = Self.mListIndex = I
		      Menu.Append(Item)
		    Next
		    
		    Dim Choice As MenuItem = Menu.PopUp(MenuPosX, MenuPosY)
		    If Choice <> Nil Then
		      Dim Index As Integer = Choice.Tag
		      Self.ListIndex = Index
		    End If
		    
		    Return True
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mSubclassHandlesMouse Then
		    RaiseEvent MouseDrag(X, Y)
		    Return
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mSubclassHandlesMouse Then
		    RaiseEvent MouseUp(X, Y)
		    Return
		  End If
		  
		  Self.mPressed = False
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim CaptionColor As Color = SystemColors.ControlTextColor
		  Dim BorderColor As Color = CaptionColor.AtOpacity(0.25)
		  Dim DropdownColor As Color = CaptionColor.AtOpacity(0.5)
		  
		  Dim ControlWidth As Double = G.Width
		  Dim ControlHeight As Double = 22
		  Dim ControlLeft As Double = (G.Width - ControlWidth) / 2
		  Dim ControlTop As Double = (G.Height - ControlHeight) / 2
		  
		  G.ForeColor = BorderColor
		  G.DrawRoundRect(ControlLeft, ControlTop, ControlWidth, ControlHeight, 4, 4)
		  
		  Dim DropDownIcon As Picture = BeaconUI.IconWithColor(IconDropdown, DropdownColor)
		  G.DrawPicture(DropDownIcon, (ControlLeft + ControlWidth) - (DropDownIcon.Width + 4), ControlTop + ((ControlHeight - DropDownIcon.Height) / 2))
		  
		  If Self.mListIndex > -1 And Self.mListIndex <= Self.mItems.Ubound Then
		    Dim CaptionSpace As Double = ControlWidth - (DropDownIcon.Width + 12)
		    Dim CaptionLeft As Double = ControlLeft + 4
		    Dim CaptionBottom As Double = ControlTop + (ControlHeight / 2) + (G.CapHeight / 2)
		    
		    G.ForeColor = CaptionColor
		    G.DrawString(Self.Caption, CaptionLeft, CaptionBottom, CaptionSpace, True)
		  End If
		  
		  If Self.mPressed Then
		    G.ForeColor = &c00000080
		    G.FillRoundRect(ControlLeft, ControlTop, ControlWidth, ControlHeight, 4, 4)
		  End If
		  
		  Self.mHitRect = New REALbasic.Rect(ControlLeft, ControlTop, ControlWidth, ControlHeight)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddRow(ItemText As String, Tag As Variant = Nil)
		  Self.mItems.Append(ItemText)
		  Self.mTags.Append(Tag)
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(ItemText As String) As Integer
		  Return Self.mItems.IndexOf(ItemText)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertRow(BeforeIndex As Integer, ItemText As String, Tag As Variant = Nil)
		  Self.mItems.Insert(BeforeIndex, ItemText)
		  Self.mTags.Insert(BeforeIndex, Tag)
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveRow(RowIndex As Integer)
		  Self.mItems.Remove(RowIndex)
		  Self.mTags.Remove(RowIndex)
		  If Self.mListIndex > RowIndex Then
		    Self.mListIndex = Self.mListIndex - 1
		  ElseIf Self.mListIndex = RowIndex Then
		    Self.ListIndex = -1
		  End If
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveRow(ItemText As String)
		  Self.RemoveRow(Self.IndexOf(ItemText))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Row(RowIndex As Integer) As String
		  Return Self.mItems(RowIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Row(RowIndex As Integer, Assigns ItemText As String)
		  If StrComp(ItemText, Self.mItems(RowIndex), 0) <> 0 Then
		    Self.mItems(RowIndex) = ItemText
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowTag(RowIndex As Integer) As Variant
		  Return Self.mTags(RowIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RowTag(RowIndex As Integer, Assigns Tag As Variant)
		  Self.mTags(RowIndex) = Tag
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort()
		  Dim Caption As String = Self.Caption
		  Self.mItems.SortWith(Self.mTags)
		  Self.mListIndex = Self.mItems.IndexOf(Caption)
		  Self.Invalidate
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDown(X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDrag(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseUp(X As Integer, Y As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mListIndex > -1 And Self.mListIndex <= Self.mItems.Ubound Then
			    Return Self.mItems(Self.mListIndex)
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mListIndex > -1 And Self.mListIndex <= Self.mItems.Ubound Then
			    Self.Row(Self.mListIndex) = Value
			  End If
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mItems.Ubound + 1
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mItems.Ubound
			End Get
		#tag EndGetter
		LastIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mListIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Min(Value, Self.mItems.Ubound), -1)
			  If Self.mListIndex <> Value Then
			    Self.mListIndex = Value
			    Self.Invalidate
			    RaiseEvent Change()
			  End If
			End Set
		#tag EndSetter
		ListIndex As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHitRect As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mListIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubclassHandlesMouse As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTags() As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mListIndex > -1 And Self.mListIndex <= Self.mTags.Ubound Then
			    Return Self.mTags(Self.mListIndex)
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mListIndex > -1 And Self.mListIndex <= Self.mTags.Ubound Then
			    Self.RowTag(Self.mListIndex) = Value
			  End If
			End Set
		#tag EndSetter
		Tag As Variant
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
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
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="AcceptFocus"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollSpeed"
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ListIndex"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastIndex"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
