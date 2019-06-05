#tag Class
Protected Class TagPicker
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  For I As Integer = 0 To Self.mCells.Ubound
		    If Self.mCells(I) <> Nil And Self.mCells(I).Contains(X, Y) Then
		      Self.mMouseDownCellIndex = I
		      Self.mMousePressedIndex = I
		      Self.Invalidate
		      Return True
		    End If
		  Next
		  
		  Self.mMouseDownCellIndex = -1
		  Self.mMousePressedIndex = -1
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDownCellIndex > -1 Then
		    If Self.mCells(Self.mMouseDownCellIndex).Contains(X, Y) Then
		      If Self.mMousePressedIndex <> Self.mMouseDownCellIndex Then
		        Self.mMousePressedIndex = Self.mMouseDownCellIndex
		        Self.Invalidate
		      End If
		    Else
		      If Self.mMousePressedIndex = Self.mMouseDownCellIndex Then
		        Self.mMousePressedIndex = -1
		        Self.Invalidate
		      End If
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mMouseDownCellIndex > -1 And Self.mCells(Self.mMouseDownCellIndex).Contains(X, Y) Then
		    Dim Tag As String = Self.mTags(Self.mMouseDownCellIndex)
		    Dim RequireIndex As Integer = Self.mRequireTags.IndexOf(Tag)
		    Dim ExcludeIndex As Integer = Self.mExcludeTags.IndexOf(Tag)
		    
		    If RequireIndex > -1 Then
		      Self.mRequireTags.Remove(RequireIndex)
		      Self.mExcludeTags.Append(Tag)
		    ElseIf ExcludeIndex > -1 Then
		      Self.mExcludeTags.Remove(ExcludeIndex)
		    Else
		      Self.mRequireTags.Append(Tag)
		    End If
		    
		    RaiseEvent Change
		  End If
		  
		  Self.mMousePressedIndex = -1
		  Self.mMouseDownCellIndex = -1
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.ClearRect(0, 0, G.Width, G.Height)
		  
		  Dim ContentArea As REALbasic.Rect = Self.ContentArea
		  G.ForeColor = SystemColors.SeparatorColor
		  G.DrawRect(ContentArea.Left - 1, ContentArea.Top - 1, ContentArea.Width + 2, ContentArea.Height + 2)
		  G.ForeColor = SystemColors.ControlBackgroundColor
		  G.FillRect(ContentArea.Left, ContentArea.Top, ContentArea.Width, ContentArea.Height)
		  
		  Const VerticalSpacing = 6
		  Const HorizontalSpacing = 6
		  Const VerticalPadding = 5
		  Const HorizontalPadding = 10
		  
		  Dim XPos As Integer = HorizontalSpacing + ContentArea.Left
		  Dim YPos As Integer = VerticalSpacing + ContentArea.Top
		  Dim MaxCellWidth As Integer = ContentArea.Width - (HorizontalSpacing * 2)
		  Dim CapHeight As Integer = Ceil(G.CapHeight)
		  Dim CellHeight As Integer = CapHeight + (VerticalPadding * 2)
		  
		  For I As Integer = 0 To Self.mTags.Ubound
		    Dim Tag As String = Self.mTags(I)
		    Dim Required As Boolean = Self.mRequireTags.IndexOf(Tag) > -1
		    Dim Excluded As Boolean = Self.mExcludeTags.IndexOf(Tag) > -1
		    Dim Pressed As Boolean = Self.mMousePressedIndex = I
		    Tag = Titlecase(Tag)
		    
		    Dim CaptionWidth As Integer = Ceil(G.StringWidth(Tag))
		    Dim CellWidth As Integer = Min(MaxCellWidth, CaptionWidth + (HorizontalPadding * 2))
		    If XPos + CellWidth > ContentArea.Right - HorizontalSpacing Then
		      XPos = ContentArea.Left + HorizontalSpacing
		      YPos = YPos + VerticalSpacing + CellHeight
		    End If
		    
		    Dim CellRect As New REALbasic.Rect(XPos, YPos, CellWidth, CellHeight)
		    Self.mCells(I) = CellRect
		    
		    Dim CaptionLeft As Integer = CellRect.Left + HorizontalPadding
		    Dim CaptionBottom As Integer = CellRect.Top + VerticalPadding + CapHeight
		    
		    Dim CellColor, CellTextColor As Color
		    If Required Then
		      CellColor = SystemColors.SelectedContentBackgroundColor
		      CellTextColor = SystemColors.AlternateSelectedControlTextColor
		    ElseIf Excluded Then
		      CellColor = SystemColors.SystemRedColor
		      CellTextColor = SystemColors.AlternateSelectedControlTextColor
		    Else
		      CellColor = SystemColors.UnemphasizedSelectedTextBackgroundColor
		      CellTextColor = SystemColors.UnemphasizedSelectedTextColor
		    End If
		    G.ForeColor = CellColor
		    G.FillRoundRect(CellRect.Left, CellRect.Top, CellRect.Width, CellRect.Height, CellRect.Height, CellRect.Height)
		    G.ForeColor = CellTextColor
		    G.DrawString(Tag, CaptionLeft, CaptionBottom, CellWidth - (HorizontalPadding * 2), True)
		    If Excluded Then
		      G.FillRect(CaptionLeft, CellRect.VerticalCenter, CellRect.Width - (HorizontalPadding * 2), 2)
		    End If
		    
		    If Pressed Then
		      G.ForeColor = &c00000080
		      G.FillRoundRect(CellRect.Left, CellRect.Top, CellRect.Width, CellRect.Height, CellRect.Height, CellRect.Height)
		    End If
		    
		    XPos = XPos + HorizontalSpacing + CellRect.Width
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Border = Self.BorderTop Or Self.BorderLeft Or Self.BorderBottom Or Self.BorderRight
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ContentArea() As REALbasic.Rect
		  Dim X, Y, W, H As Integer
		  W = Self.Width
		  H = Self.Height
		  
		  Dim Borders As Integer = Self.Border
		  If (Borders And Self.BorderTop) = Self.BorderTop Then
		    Y = Y + 1
		    H = H - 1
		  End If
		  If (Borders And Self.BorderBottom) = Self.BorderBottom Then
		    H = H - 1
		  End If
		  If (Borders And Self.BorderLeft) = Self.BorderLeft Then
		    X = X + 1
		    W = W - 1
		  End If
		  If (Borders And Self.BorderRight) = Self.BorderRight Then
		    W = W - 1
		  End If
		  
		  Return New REALbasic.Rect(X, Y, W, H)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LocalizeCoordinates(ByRef X As Integer, ByRef Y As Integer)
		  If (Self.Border And Self.BorderTop) = Self.BorderTop Then
		    Y = Y + 1
		  End If
		  If (Self.Border And Self.BorderLeft) = Self.BorderLeft Then
		    X = X + 1
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  Dim Clone() As String
		  Redim Clone(Self.mTags.Ubound)
		  For I As Integer = 0 To Self.mTags.Ubound
		    Clone(I) = Self.mTags(I)
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Values As Beacon.TextList)
		  If Values = Nil Then
		    Return
		  End If
		  
		  Dim Changed As Boolean
		  If Self.mTags.Ubound <> Values.Ubound Then
		    Redim Self.mTags(Values.Ubound)
		    Changed = True
		  End If
		  For I As Integer = 0 To Values.Ubound
		    If StrComp(Self.mTags(I), Values(I), 0) <> 0 Then
		      Self.mTags(I) = Values(I)
		      Changed = True
		    End If
		  Next
		  
		  If Changed Then
		    Redim Self.mCells(-1)
		    Redim Self.mCells(Self.mTags.Ubound)
		    
		    Dim FireChangeEvent As Boolean
		    For I As Integer = Self.mRequireTags.Ubound DownTo 0
		      If Self.mTags.IndexOf(Self.mRequireTags(I)) = -1 Then
		        Self.mRequireTags.Remove(I)
		        FireChangeEvent = True
		      End
		      If Self.mTags.IndexOf(Self.mExcludeTags(I)) = -1 Then
		        Self.mExcludeTags.Remove(I)
		        FireChangeEvent = True
		      End If
		    Next
		    
		    If FireChangeEvent Then
		      If App.CurrentThread = Nil Then
		        RaiseEvent Change
		      Else
		        Call CallLater.Schedule(0, AddressOf TriggerChange)
		      End If
		    End If
		    
		    Self.Invalidate()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Values() As String)
		  If Values = Nil Then
		    Return
		  End If
		  
		  Dim Changed As Boolean
		  If Self.mTags.Ubound <> Values.Ubound Then
		    Redim Self.mTags(Values.Ubound)
		    Changed = True
		  End If
		  For I As Integer = 0 To Values.Ubound
		    If StrComp(Self.mTags(I), Values(I), 0) <> 0 Then
		      Self.mTags(I) = Values(I)
		      Changed = True
		    End If
		  Next
		  
		  If Changed Then
		    Redim Self.mCells(-1)
		    Redim Self.mCells(Self.mTags.Ubound)
		    
		    Dim FireChangeEvent As Boolean
		    For I As Integer = Self.mRequireTags.Ubound DownTo 0
		      If Self.mTags.IndexOf(Self.mRequireTags(I)) = -1 Then
		        Self.mRequireTags.Remove(I)
		        FireChangeEvent = True
		      End
		      If Self.mTags.IndexOf(Self.mExcludeTags(I)) = -1 Then
		        Self.mExcludeTags.Remove(I)
		        FireChangeEvent = True
		      End If
		    Next
		    
		    If FireChangeEvent Then
		      If App.CurrentThread = Nil Then
		        RaiseEvent Change
		      Else
		        Call CallLater.Schedule(0, AddressOf TriggerChange)
		      End If
		    End If
		    
		    Self.Invalidate()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerChange()
		  RaiseEvent Change
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value And (Self.BorderTop Or Self.BorderLeft Or Self.BorderBottom Or Self.BorderRight)
			  If Value = Self.mBorder Then
			    Return
			  End If
			  
			  Self.mBorder = Value
			  Self.Invalidate
			End Set
		#tag EndSetter
		Border As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mBorder As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCells() As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExcludeTags() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownCellIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMousePressedIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequireTags() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTags() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Value As String
			  If Self.mRequireTags.Ubound > -1 Then
			    Value = """" + Join(Self.mRequireTags, """ """) + """"
			  End If
			  If Self.mExcludeTags.Ubound > -1 Then
			    Value = Trim(Value + " -""" + Join(Self.mExcludeTags, """ -""") + """")
			  End If
			  Return Value
			End Get
		#tag EndGetter
		Spec As String
	#tag EndComputedProperty


	#tag Constant, Name = BorderBottom, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderLeft, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderRight, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderTop, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


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
			InitialValue="100"
			Type="Integer"
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
			Name="Border"
			Visible=true
			Group="Behavior"
			InitialValue="15"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Spec"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
