#tag Class
Protected Class Shelf
Inherits ControlCanvas
Implements  NotificationKit.Receiver,  BeaconUI.ColorAnimator
	#tag Event
		Sub Close()
		  RaiseEvent Close
		  NotificationKit.Ignore(Self, BeaconUI.PrimaryColorNotification)
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim Point As New Xojo.Core.Point(X,Y)
		  
		  For I As Integer = 0 To Self.mHitRects.Ubound
		    If Self.mHitRects(I).Contains(Point) Then
		      Self.mMouseDownItem = I
		      Self.mPressed = True
		      Self.Invalidate
		      Return True
		    End If
		  Next
		  
		  Self.mMouseDownItem = -1
		  Self.mPressed = False
		  Self.Invalidate
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDownItem = -1 Then
		    Return
		  End If
		  
		  Dim Point As New Xojo.Core.Point(X,Y)
		  Dim TargetRect As Xojo.Core.Rect = Self.mHitRects(Self.mMouseDownItem)
		  If TargetRect.Contains(Point) = True And Self.mPressed = False Then
		    Self.mPressed = True
		    Self.Invalidate
		  ElseIf TargetRect.Contains(Point) = False And Self.mPressed = True Then
		    Self.mPressed = False
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mMouseDownItem = -1 Then
		    Return
		  End If
		  
		  Dim Point As New Xojo.Core.Point(X,Y)
		  Dim TargetRect As Xojo.Core.Rect = Self.mHitRects(Self.mMouseDownItem)
		  If TargetRect.Contains(Point) = True Then
		    Self.mPressed = False
		    Self.SelectedIndex = Self.mMouseDownItem
		    Self.mMouseDownItem = -1
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Dim CellColor, ShadowColor As Color
		  Self.mSelectedFillColor = BeaconUI.PrimaryColor
		  Self.ComputeColors(Self.mSelectedFillColor, CellColor, ShadowColor)
		  Self.mSelectedCellColor = CellColor
		  Self.mSelectedShadowColor = ShadowColor
		  NotificationKit.Watch(Self, BeaconUI.PrimaryColorNotification)
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = Self.BorderColor
		  G.FillRect(0, 0, G.Width, G.Height)
		  
		  G.TextSize = 10
		  G.TextUnit = FontUnits.Point
		  
		  Dim ContentTop As Integer = 0
		  Dim ContentHeight As Integer = G.Height
		  
		  If (Self.mBorderStyle And Self.BorderTop) = Self.BorderTop Then
		    ContentTop = ContentTop + 1
		    ContentHeight = ContentHeight - 1
		  End If
		  If (Self.mBorderStyle And Self.BorderBottom) = Self.BorderBottom Then
		    ContentHeight = ContentHeight - 1
		  End If
		  
		  Dim Content As Graphics = G.Clip(0, ContentTop, G.Width, ContentHeight)
		  Content.ForeColor = Self.BackgroundColor
		  Content.FillRect(0, 0, Content.Width, Content.Height)
		  
		  Dim AvailableWidth As Integer = G.Width - (Self.EdgePadding * 2)
		  Dim CommonCellWidth As Integer = Floor(AvailableWidth / Self.Count)
		  Dim Remainder As Integer = AvailableWidth - (CommonCellWidth * Self.Count)
		  
		  Dim NextLeft As Integer = Self.EdgePadding
		  Redim Self.mHitRects(Self.mItems.Ubound)
		  For I As Integer = 0 To Self.mItems.Ubound
		    Dim CellWidth As Integer = CommonCellWidth
		    If I < Remainder Then
		      CellWidth = CellWidth + 1
		    End If
		    
		    Dim ItemHeight As Integer = Self.IconSize + Self.CellPadding + Self.TextHeight
		    Dim CellContent As Graphics = Content.Clip(NextLeft, 0, CellWidth, Content.Height)
		    Dim IconLeft As Integer = (CellContent.Width - Self.IconSize) / 2
		    Dim IconTop As Integer = (CellContent.Height - ItemHeight) / 2
		    Dim Caption As String = Self.mItems(I).Caption
		    Dim CaptionY As Integer = IconTop + Self.IconSize + Self.CellPadding + Self.TextHeight
		    Dim CaptionWidth As Integer = Ceil(CellContent.StringWidth(Caption))
		    CaptionWidth = Min(CaptionWidth, CellContent.Width - (Self.CellPadding / 2))
		    Dim CaptionX As Integer = (CellContent.Width - CaptionWidth) / 2
		    Dim FillColor As Color = Self.FillColor
		    Dim ShadowColor As Color = &cFFFFFF
		    
		    If Self.mSelectedIndex = I Then
		      FillColor = Self.mSelectedFillColor
		      ShadowColor = Self.mSelectedShadowColor
		      Dim CellColor As Color = Self.mSelectedCellColor
		      
		      CellContent.ForeColor = HSV(CellColor.Hue, CellColor.Saturation, CellColor.Value / 1.2, CellColor.Alpha)
		      CellContent.FillRect(0, 0, CellContent.Width, CellContent.Height)
		      CellContent.ForeColor = CellColor
		      CellContent.FillRect(1, 0, CellContent.Width - 2, CellContent.Height)
		    End If
		    
		    CellContent.ForeColor = ShadowColor
		    CellContent.DrawString(Caption, CaptionX, CaptionY + 1, CaptionWidth, True)
		    CellContent.ForeColor = FillColor
		    CellContent.DrawString(Caption, CaptionX, CaptionY, CaptionWidth, True)
		    
		    Dim ShadowIcon As Picture = BeaconUI.IconWithColor(Self.mItems(I).Icon, ShadowColor)
		    Dim FillIcon As Picture = BeaconUI.IconWithColor(Self.mItems(I).Icon, FillColor)
		    CellContent.DrawPicture(ShadowIcon, IconLeft, IconTop + 1, Self.IconSize, Self.IconSize, 0, 0, Self.mItems(I).Icon.Width, Self.mItems(I).Icon.Height)
		    CellContent.DrawPicture(FillIcon, IconLeft, IconTop, Self.IconSize, Self.IconSize, 0, 0, Self.mItems(I).Icon.Width, Self.mItems(I).Icon.Height)
		    
		    Dim HitRect As New Xojo.Core.Rect(NextLeft, ContentTop, CellWidth, ContentHeight)
		    Self.mHitRects(I) = HitRect
		    
		    If Self.mPressed And Self.mMouseDownItem = I And Self.mSelectedIndex <> I Then
		      CellContent.ForeColor = &c000000CC
		      CellContent.FillRect(0, 0, CellContent.Width, CellContent.Height)
		    End If
		    
		    NextLeft = NextLeft + CellWidth
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Icon As Picture, Caption As String, Tag As String)
		  Self.Add(New ShelfItem(Icon, Caption, Tag))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Item As ShelfItem)
		  Self.mItems.Append(Item)
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AnimationStep(Identifier As Text, Value As Color)
		  // Part of the BeaconUI.ColorAnimator interface.
		  
		  Select Case Identifier
		  Case "FillColor"
		    Self.mSelectedFillColor = Value
		    Self.Invalidate
		  Case "CellColor"
		    Self.mSelectedCellColor = Value
		    Self.Invalidate
		  Case "ShadowColor"
		    Self.mSelectedShadowColor = Value
		    Self.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ComputeColors(FillColor As Color, ByRef CellColor As Color, ByRef ShadowColor As Color)
		  Dim Contrast As Double = FillColor.ContrastWith(SelectedBackgroundColor)
		  If Contrast < 1.8 Then
		    CellColor = HSV(0, 0, 0.6)
		    ShadowColor = &c00000080
		    Contrast = FillColor.ContrastWith(CellColor)
		    If Contrast < 1.8 Then
		      // Still needs more
		      CellColor = HSV(0, 0, 0.4)
		    End If
		  Else
		    CellColor = SelectedBackgroundColor
		    ShadowColor = &cFFFFFF
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return Self.mItems.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case BeaconUI.PrimaryColorNotification
		    If Self.mFillAnimator <> Nil Then
		      Self.mFillAnimator.Cancel
		      Self.mFillAnimator = Nil
		    End If
		    
		    If Self.mCellAnimator <> Nil Then
		      Self.mCellAnimator.Cancel
		      Self.mCellAnimator = Nil
		    End If
		    
		    If Self.mShadowAnimator <> Nil Then
		      Self.mShadowAnimator.Cancel
		      Self.mShadowAnimator = Nil
		    End If
		    
		    Dim PrimaryColor As Color = Notification.UserData
		    Dim CellColor, ShadowColor As Color
		    Self.ComputeColors(PrimaryColor, CellColor, ShadowColor)
		    
		    If Self.mSelectedFillColor <> PrimaryColor Then
		      Self.mFillAnimator = New BeaconUI.ColorTask(Self, "FillColor", Self.mSelectedFillColor, PrimaryColor)
		      Self.mFillAnimator.Curve = AnimationKit.Curve.CreateEaseOut
		      Self.mFillAnimator.DurationInSeconds = BeaconUI.ColorChangeDuration
		      Self.mFillAnimator.Run
		    End If
		    
		    If Self.mSelectedCellColor <> CellColor Then
		      Self.mCellAnimator = New BeaconUI.ColorTask(Self, "CellColor", Self.mSelectedCellColor, CellColor)
		      Self.mCellAnimator.Curve = AnimationKit.Curve.CreateEaseOut
		      Self.mCellAnimator.DurationInSeconds = BeaconUI.ColorChangeDuration
		      Self.mCellAnimator.Run
		    End If
		    
		    If Self.mSelectedShadowColor <> ShadowColor Then
		      Self.mShadowAnimator = New BeaconUI.ColorTask(Self, "ShadowColor", Self.mSelectedShadowColor, ShadowColor)
		      Self.mShadowAnimator.Curve = AnimationKit.Curve.CreateEaseOut
		      Self.mShadowAnimator.DurationInSeconds = BeaconUI.ColorChangeDuration
		      Self.mShadowAnimator.Run
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems.Remove(Index)
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedIndex() As Integer
		  Return Self.mSelectedIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedIndex(Assigns Value As Integer)
		  Value = Max(Min(Self.mItems.Ubound, Value), 0)
		  If Self.mSelectedIndex <> Value Then
		    Self.mSelectedIndex = Value
		    RaiseEvent Change
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedItem() As ShelfItem
		  Return Self.mItems(Self.mSelectedIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedItem(Assigns Value As ShelfItem)
		  For I As Integer = 0 To Self.mItems.Ubound
		    If Self.mItems(I).Tag = Value.Tag Then
		      Self.SelectedIndex = I
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBorderStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value And (Self.BorderNone Or Self.BorderTop Or Self.BorderBottom)
			  
			  If Self.mBorderStyle = Value Then
			    Return
			  End If
			  
			  Self.mBorderStyle = Value
			  Self.Invalidate()
			End Set
		#tag EndSetter
		BorderStyle As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBorderStyle As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCellAnimator As BeaconUI.ColorTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFillAnimator As BeaconUI.ColorTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHitRects() As Xojo.Core.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As ShelfItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownItem As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedCellColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedFillColor As Color = BeaconUI.DefaultPrimaryColor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedShadowColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShadowAnimator As BeaconUI.ColorTask
	#tag EndProperty


	#tag Constant, Name = BackgroundColor, Type = Color, Dynamic = False, Default = \"&cf7f7f7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderBottom, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderColor, Type = Color, Dynamic = False, Default = \"&ca6a6a6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = BorderNone, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderTop, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CellPadding, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EdgePadding, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FillColor, Type = Color, Dynamic = False, Default = \"&c4c4c4c", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IconSize, Type = Double, Dynamic = False, Default = \"24", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SelectedBackgroundColor, Type = Color, Dynamic = False, Default = \"&cdedede", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedEdgeColor, Type = Color, Dynamic = False, Default = \"&cc6c6c6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TextHeight, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
			Name="BorderStyle"
			Visible=true
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Top"
				"2 - Bottom"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="72"
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
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
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
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="False"
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
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Group="Behavior"
			Type="Boolean"
			EditorType="Boolean"
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
			InitialValue="376"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
