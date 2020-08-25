#tag Class
Protected Class OmniBarItem
Implements ObservationKit.Observable
	#tag Method, Flags = &h21
		Private Shared Function ActiveColorToColor(Value As OmniBarItem.ActiveColors, Profile As OmniBarColorProfile, ForBackground As Boolean = False) As Color
		  Select Case Value
		  Case OmniBarItem.ActiveColors.Blue
		    Return If(ForBackground, Profile.Blue, Profile.BlueText)
		  Case OmniBarItem.ActiveColors.Brown
		    Return If(ForBackground, Profile.Brown, Profile.BrownText)
		  Case OmniBarItem.ActiveColors.Gray
		    Return If(ForBackground, Profile.Gray, Profile.GrayText)
		  Case OmniBarItem.ActiveColors.Green
		    Return If(ForBackground, Profile.Green, Profile.GreenText)
		  Case OmniBarItem.ActiveColors.Orange
		    Return If(ForBackground, Profile.Orange, Profile.OrangeText)
		  Case OmniBarItem.ActiveColors.Pink
		    Return If(ForBackground, Profile.Pink, Profile.PinkText)
		  Case OmniBarItem.ActiveColors.Purple
		    Return If(ForBackground, Profile.Purple, Profile.PurpleText)
		  Case OmniBarItem.ActiveColors.Red
		    Return If(ForBackground, Profile.Red, Profile.RedText)
		  Case OmniBarItem.ActiveColors.Yellow
		    Return If(ForBackground, Profile.Yellow, Profile.YellowText)
		  Else
		    Return If(ForBackground, Profile.AccentColor, Profile.AccentedText)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.AddRow(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clickable() As Boolean
		  Select Case Self.Type
		  Case OmniBarItem.Types.Tab, OmniBarItem.Types.Button
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Type As OmniBarItem.Types, Name As String, Caption As String, Icon As Picture = Nil)
		  Self.mType = Type
		  Self.mActiveColor = OmniBarItem.ActiveColors.Accent
		  Self.mAlwaysUseActiveColor = False
		  Self.mCanBeClosed = False
		  Self.mCaption = Caption
		  Self.mEnabled = True
		  Self.mHasProgressIndicator = False
		  Self.mHasUnsavedChanges = False
		  Self.mHelpTag = ""
		  Self.mIcon = Icon
		  Self.mName = Name
		  Self.mProgress = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateButton(Name As String, Caption As String, Icon As Picture, HelpTag As String) As OmniBarItem
		  Var Item As New OmniBarItem(OmniBarItem.Types.Button, Name, Caption, Icon)
		  Item.HelpTag = HelpTag
		  Return Item
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFlexibleSpace() As OmniBarItem
		  Return New OmniBarItem(OmniBarItem.Types.FlexSpace, EncodeHex(Crypto.GenerateRandomBytes(3)).Lowercase, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSeparator() As OmniBarItem
		  Return New OmniBarItem(OmniBarItem.Types.Separator, EncodeHex(Crypto.GenerateRandomBytes(3)).Lowercase, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSpace() As OmniBarItem
		  Return New OmniBarItem(OmniBarItem.Types.Space, EncodeHex(Crypto.GenerateRandomBytes(3)).Lowercase, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateTab(Name As String, Caption As String, Icon As Picture = Nil) As OmniBarItem
		  Return New OmniBarItem(OmniBarItem.Types.Tab, Name, Caption, Icon)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawButton(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  #Pragma Unused LocalMousePoint
		  
		  Const CornerRadius = 6
		  Const Spacing = 2
		  
		  Var CellHeight As Double = Self.ButtonIconSize
		  If Self.Caption.IsEmpty = False Then
		    CellHeight = CellHeight + Spacing + G.TextHeight
		  End If
		  Var CellTop As Double = NearestMultiple((G.Height - CellHeight) / 2, G.ScaleY)
		  
		  Var ForeColor, BackColor, ShadowColor As Color = &c000000FF
		  If Self.Toggled Then
		    If Highlighted Then
		      ForeColor = Colors.ToggledButtonIconColor
		      BackColor = Self.ActiveColorToColor(Self.ActiveColor, Colors, True)
		      ShadowColor = Colors.ToggledButtonShadowColor
		    Else
		      ForeColor = Colors.TextColor
		      BackColor = Colors.ToggledButtonInactiveColor
		      ShadowColor = Colors.TextShadowColor
		    End If
		  ElseIf Highlighted And Self.AlwaysUseActiveColor Then
		    ForeColor = Self.ActiveColorToColor(Self.ActiveColor, Colors, False)
		    ShadowColor = Colors.TextShadowColor
		  Else
		    ForeColor = Colors.TextColor
		    ShadowColor = Colors.TextShadowColor
		  End If
		  
		  Var IconRect As New Rect(NearestMultiple((G.Width - Self.ButtonIconSize) / 2, G.ScaleX), CellTop, Self.ButtonIconSize, Self.ButtonIconSize)
		  Var HighlightRect As New Rect(0, CellTop - Self.ButtonPadding, G.Width, CellHeight + (Self.ButtonPadding * 2))
		  Var Factor As Double = Max(G.ScaleX, G.ScaleY)
		  Var Icon As Picture = BeaconUI.IconWithColor(Self.Icon, ForeColor, Factor, Factor)
		  Var Shadow As Picture = BeaconUI.IconWithColor(Self.Icon, ShadowColor, Factor, Factor)
		  
		  If BackColor.Alpha < 255 Then
		    G.DrawingColor = BackColor
		    G.FillRoundRectangle(HighlightRect.Left, HighlightRect.Top, HighlightRect.Width, HighlightRect.Height, CornerRadius, CornerRadius)
		  End If
		  
		  G.DrawPicture(Shadow, IconRect.Left, IconRect.Top + 1, IconRect.Width, IconRect.Height, 0, 0, Icon.Width, Icon.Height)
		  G.DrawPicture(Icon, IconRect.Left, IconRect.Top, IconRect.Width, IconRect.Height, 0, 0, Icon.Width, Icon.Height)
		  
		  If Self.Caption.IsEmpty = False Then
		    Var CaptionWidth As Double = G.TextWidth(Self.Caption)
		    Var CaptionLeft As Double = NearestMultiple((G.Width - CaptionWidth) / 2, G.ScaleX)
		    Var CaptionBaseline As Double = NearestMultiple(IconRect.Bottom + Spacing + G.FontAscent, G.ScaleY)
		    
		    G.DrawingColor = ShadowColor
		    G.DrawText(Self.Caption, CaptionLeft, CaptionBaseline + 1, G.Width, True)
		    G.DrawingColor = ForeColor
		    G.DrawText(Self.Caption, CaptionLeft, CaptionBaseline, G.Width, True)
		  End If
		  
		  If MouseDown And Self.Enabled Then
		    G.DrawingColor = &c00000080
		    G.FillRoundRectangle(HighlightRect.Left, HighlightRect.Top, HighlightRect.Width, HighlightRect.Height, CornerRadius, CornerRadius)
		  End If
		  
		  Self.mLastInsetRect = HighlightRect
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawInto(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  Select Case Self.Type
		  Case OmniBarItem.Types.Tab
		    Self.DrawTab(G, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		  Case OmniBarItem.Types.Button
		    Self.DrawButton(G, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		  Case OmniBarItem.Types.Separator
		    Self.DrawSeparator(G, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawSeparator(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  #Pragma Unused MouseDown
		  #Pragma Unused MouseHover
		  #Pragma Unused LocalMousePoint
		  #Pragma Unused Highlighted
		  
		  Const Spacing = 10
		  
		  G.DrawingColor = Colors.SeparatorColor
		  G.DrawLine(15, Spacing, 15, G.Height - Spacing)
		  G.DrawingColor = Colors.TextShadowColor
		  G.DrawLine(16, Spacing + 1, 16, (G.Height - Spacing) + 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTab(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  Var HasIcon As Boolean = (Self.Icon Is Nil) = False
		  Var HasCaption As Boolean = Self.Caption.IsEmpty = False
		  If HasIcon = False And HasCaption = False Then
		    // There's nothing here to draw
		    Return
		  End If
		  
		  If Self.HasProgressIndicator Then
		    If Self.Progress = Self.ProgressIndeterminate Then
		      Const BarMaxPercent = 0.75
		      
		      Var Phase As Double = Self.IndeterminatePhase
		      Var RangeMin As Double = (G.Width * BarMaxPercent) * -1
		      Var RangeMax As Double = G.Width
		      Var BarLeft As Double = NearestMultiple(RangeMin + ((RangeMax - RangeMin) * Phase), G.ScaleX)
		      Var BarWidth As Double = NearestMultiple(G.Width * BarMaxpercent, G.ScaleX)
		      
		      G.DrawingColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		      G.FillRectangle(BarLeft, G.Height - 2, BarWidth, 2)
		    Else
		      Var BarWidth As Double = NearestMultiple(G.Width * Self.Progress, G.ScaleX)
		      G.DrawingColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		      G.FillRectangle(0, G.Height - 2, BarWidth, 2)
		    End If
		  ElseIf Self.Toggled Then
		    G.ClearRectangle(0, G.Height - 2, G.Width, 2)
		    If Highlighted Then
		      G.DrawingColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		    Else
		      G.DrawingColor = Colors.SeparatorColor
		    End If
		    G.DrawRectangle(0, G.Height - 2, G.Width, 2)
		  End If
		  
		  // Find the color we'll be using
		  Var ForeColor, ShadowColor As Color
		  If Self.Enabled = False Then
		    ForeColor = Colors.DisabledTextColor
		  ElseIf Highlighted = True Then
		    If Self.Toggled Or Self.AlwaysUseActiveColor Or MouseDown Or MouseHover Then
		      ForeColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		    Else
		      ForeColor = Colors.TextColor
		    End If
		  Else
		    ForeColor = Colors.TextColor
		  End If
		  ShadowColor = Colors.TextShadowColor
		  
		  Var OriginalForeColor As Color = ForeColor
		  If MouseDown And Self.Enabled Then
		    ForeColor = ForeColor.Darker(0.5)
		  End If
		  
		  // Draw as text, with an icon to the left if available.
		  // Accessory comes first, as it may change the hover and pressed appearances
		  
		  Var AccessoryImage As Picture
		  Var AccessoryRect As New Rect(G.Width - Self.IconSize, NearestMultiple((G.Height - Self.IconSize) / 2, G.ScaleY), Self.IconSize, Self.IconSize)
		  Var AccessoryColor As Color
		  Var WithAccessory As Boolean = True
		  If Self.CanBeClosed And (MouseHover Or MouseDown) Then
		    Var AccessoryPressed As Boolean = MouseDown
		    If (LocalMousePoint Is Nil) = False And AccessoryRect.Contains(LocalMousePoint) Then
		      G.DrawingColor = Colors.ToggledButtonInactiveColor
		      G.FillRoundRectangle(AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 6, 6)
		      MouseDown = False
		      ForeColor = OriginalForeColor
		    End If
		    
		    G.DrawPicture(BeaconUI.IconWithColor(IconClose, Colors.AccessoryColor), AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, IconClose.Width, IconClose.Height)
		    
		    If AccessoryPressed Then
		      If (LocalMousePoint Is Nil) = False And AccessoryRect.Contains(LocalMousePoint) Then
		        G.DrawingColor = &C00000090
		        G.FillRoundRectangle(AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 6, 6)
		      ElseIf Self.Enabled Then
		        G.DrawPicture(BeaconUI.IconWithColor(IconClose, &C00000090), AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, IconClose.Width, IconClose.Height)
		      End If
		    End If
		  ElseIf Self.HasUnsavedChanges Then
		    AccessoryColor = ForeColor
		    AccessoryImage = IconModified
		  ElseIf Self.CanBeClosed Then
		    AccessoryColor = Colors.AccessoryColor
		    AccessoryImage = IconClose
		  Else
		    WithAccessory = False
		  End If
		  If (AccessoryImage Is Nil) = False Then
		    AccessoryImage = BeaconUI.IconWithColor(AccessoryImage, AccessoryColor)
		    G.DrawPicture(AccessoryImage, AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, AccessoryImage.Width, AccessoryImage.Height)
		  End If
		  
		  Var CaptionOffset As Double = 0
		  If HasIcon = True Then
		    CaptionOffset = Self.IconSize + Self.ElementSpacing
		    
		    Var IconTop As Double = NearestMultiple((G.Height - Self.IconSize) / 2, G.ScaleY)
		    Var Icon As Picture = BeaconUI.IconWithColor(Self.Icon, Forecolor)
		    Var Shadow As Picture = BeaconUI.IconWithColor(Self.Icon, ShadowColor)
		    G.DrawPicture(Shadow, 0, IconTop + 1, Self.IconSize, Self.IconSize, 0, 0, Icon.Width, Icon.Height)
		    G.DrawPicture(Icon, 0, IconTop, Self.IconSize, Self.IconSize, 0, 0, Icon.Width, Icon.Height)
		  End If
		  
		  If Self.Toggled Then
		    G.Bold = True
		  End If
		  
		  Var CaptionSpace As Double = If(WithAccessory, AccessoryRect.Left, G.Width) - CaptionOffset
		  Var CaptionLeft As Double = NearestMultiple(CaptionOffset + ((CaptionSpace - Min(G.TextWidth(Self.Caption), Self.MaxCaptionWidth)) / 2), G.ScaleX)
		  Var CaptionBaseline As Double = NearestMultiple((G.Height / 2) + (G.CapHeight / 2), G.ScaleY)
		  
		  G.DrawingColor = ShadowColor
		  G.DrawText(Self.Caption, CaptionLeft, CaptionBaseline + 1, Self.MaxCaptionWidth, True)
		  G.DrawingColor = ForeColor
		  G.DrawText(Self.Caption, CaptionLeft, CaptionBaseline, Self.MaxCaptionWidth, True)
		  G.Bold = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InsetRect() As Rect
		  Return Self.mLastInsetRect
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Margin() As Integer
		  Select Case Self.Type
		  Case OmniBarItem.Types.Button
		    Return 10
		  Case OmniBarItem.Types.Tab
		    Return 20
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mIndeterminateTimer_Action(Sender As Timer)
		  If Self.mIndeterminatePhase >= 1.0 Then
		    Self.mIndeterminateStep = (Sender.Period / 1000) * -1
		  ElseIf Self.mIndeterminatePhase <= 0.0 Then
		    Self.mIndeterminateStep = Sender.Period / 1000
		  End If
		  
		  Self.mIndeterminatePhase = Self.mIndeterminatePhase + Self.mIndeterminateStep
		  Self.NotifyObservers("MinorChange", Self.mIndeterminatePhase)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyObservers(Key As String, Value As Variant)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, Value)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As OmniBarItem) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Return Self.mName.Compare(Other.mName, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Width(G As Graphics) As Integer
		  Var Segments() As Double
		  Select Case Self.mType
		  Case OmniBarItem.Types.Space
		    Segments.AddRow(20)
		  Case OmniBarItem.Types.FlexSpace
		    Segments.AddRow(0)
		  Case OmniBarItem.Types.Separator
		    Segments.AddRow(32)
		  Case OmniBarItem.Types.Button
		    Segments.AddRow(Max(Min(G.TextWidth(Self.Caption), Self.MaxCaptionWidth), Self.ButtonIconSize) + (Self.ButtonPadding * 2))
		  Case OmniBarItem.Types.Tab
		    If Self.Caption.IsEmpty = False Then
		      Segments.AddRow(Min(G.TextWidth(Self.Caption), Self.MaxCaptionWidth))
		    End If
		    If (Self.Icon Is Nil) = False Then
		      If Self.Caption.IsEmpty Then
		        Segments.AddRow(Self.IconSize + (Self.ButtonPadding * 2))
		      Else
		        Segments.AddRow(Self.IconSize)
		      End If
		    End If
		    If Self.CanBeClosed Or Self.HasUnsavedChanges Then
		      Segments.AddRow(Self.CloseIconSize)
		    End If
		  End Select
		  Return NearestMultiple(Segments.Sum(Self.ElementSpacing), 1.0) // Yes, round to nearest whole
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mActiveColor <> Value Then
			    Self.mActiveColor = Value
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		ActiveColor As OmniBarItem.ActiveColors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAlwaysUseActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAlwaysUseActiveColor <> Value Then
			    Self.mAlwaysUseActiveColor = Value
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		AlwaysUseActiveColor As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCanBeClosed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCanBeClosed <> Value Then
			    Var WasWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    Self.mCanBeClosed = Value
			    Var IsWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    
			    If WasWide <> IsWide Then
			      Self.NotifyObservers("MajorChange", Value)
			    Else
			      Self.NotifyObservers("MinorChange", Value)
			    End If
			  End If
			End Set
		#tag EndSetter
		CanBeClosed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCaption.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mCaption = Value
			    Self.NotifyObservers("MajorChange", Value)
			  End If
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEnabled <> Value Then
			    Self.mEnabled = Value
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		Enabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasMenu
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasMenu <> Value Then
			    Self.mHasMenu = Value
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		HasMenu As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasProgressIndicator
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasProgressIndicator <> Value Then
			    Self.mHasProgressIndicator = Value
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		HasProgressIndicator As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasUnsavedChanges
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasUnsavedChanges <> Value Then
			    Var WasWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    Self.mHasUnsavedChanges = Value
			    Var IsWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    
			    If WasWide <> IsWide Then
			      Self.NotifyObservers("MajorChange", Value)
			    Else
			      Self.NotifyObservers("MinorChange", Value)
			    End If
			  End If
			End Set
		#tag EndSetter
		HasUnsavedChanges As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHelpTag
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHelpTag.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mHelpTag = Value
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		HelpTag As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var Major As Boolean
			  Major = ((Self.mIcon Is Nil) And (Value Is Nil) = False) Or ((Self.mIcon Is Nil) = False And (Value Is Nil))
			  
			  Self.mIcon = Value
			  
			  If Major Then
			    Self.NotifyObservers("MajorChange", Value)
			  Else
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		Icon As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIndeterminatePhase
			End Get
		#tag EndGetter
		IndeterminatePhase As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mActiveColor As OmniBarItem.ActiveColors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAlwaysUseActiveColor As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCanBeClosed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasMenu As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasProgressIndicator As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasUnsavedChanges As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHelpTag As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndeterminatePhase As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndeterminateStep As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndeterminateTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastInsetRect As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToggled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As OmniBarItem.Types
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProgress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProgress <> Value Then
			    Self.mProgress = Value
			    
			    If Value = Self.ProgressIndeterminate And Self.mIndeterminateTimer Is Nil Then
			      Self.mIndeterminateTimer = New Timer
			      Self.mIndeterminateTimer.RunMode = Timer.RunModes.Multiple
			      Self.mIndeterminateTimer.Period = 1000/120
			      AddHandler mIndeterminateTimer.Action, WeakAddressOf mIndeterminateTimer_Action
			    ElseIf Value <> Self.ProgressIndeterminate And (Self.mIndeterminateTimer Is Nil) = False Then
			      RemoveHandler mIndeterminateTimer.Action, WeakAddressOf mIndeterminateTimer_Action
			      Self.mIndeterminateTimer.RunMode = Timer.RunModes.Off
			      Self.mIndeterminateTimer = Nil
			    End If
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		Progress As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mToggled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mToggled <> Value Then
			    Self.mToggled = Value
			    Self.NotifyObservers("MinorChange", Value)
			  End If
			End Set
		#tag EndSetter
		Toggled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mType
			End Get
		#tag EndGetter
		Type As OmniBarItem.Types
	#tag EndComputedProperty


	#tag Constant, Name = ButtonIconSize, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ButtonPadding, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CloseIconSize, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ElementSpacing, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IconSize, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MaxCaptionWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProgressIndeterminate, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


	#tag Enum, Name = ActiveColors, Type = Integer, Flags = &h0
		Accent
		  Blue
		  Brown
		  Gray
		  Green
		  Orange
		  Pink
		  Purple
		  Red
		Yellow
	#tag EndEnum

	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Tab
		  Button
		  Space
		  FlexSpace
		Separator
	#tag EndEnum


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
			Name="ActiveColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="OmniBarItem.ActiveColors"
			EditorType="Enum"
			#tag EnumValues
				"0 - Accent"
				"1 - Blue"
				"2 - Brown"
				"3 - Gray"
				"4 - Green"
				"5 - Orange"
				"6 - Pink"
				"7 - Purple"
				"8 - Red"
				"9 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AlwaysUseActiveColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanBeClosed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasProgressIndicator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasUnsavedChanges"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Progress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasMenu"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Toggled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IndeterminatePhase"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="OmniBarItem.Types"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
