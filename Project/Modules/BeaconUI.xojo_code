#tag Module
Protected Module BeaconUI
	#tag Method, Flags = &h0
		Function AtOpacity(Extends SourceColor As Color, Opacity As Double = 1.0) As Color
		  // Opacity = 1.0 means unchanged, may not actually be opaque
		  // Opacity = 0.5 means cut opacity in half
		  
		  Return Color.RGB(SourceColor.Red, SourceColor.Green, SourceColor.Blue, 255 + ((SourceColor.Alpha - 255) * Opacity))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlendWith(Extends Color1 As Color, Color2 As Color, Color2Percent As Double) As Color
		  If Color1.Red = Color2.Red And Color1.Green = Color2.Green And Color1.Blue = Color2.Blue And Color1.Alpha = Color2.Alpha Then
		    Return Color1
		  End If
		  
		  Var Color1Percent As Double = 1.0 - Color2Percent
		  
		  Var Red As Integer = (Color1.Red * Color1Percent) + (Color2.Red * Color2Percent)
		  Var Green As Integer = (Color1.Green * Color1Percent) + (Color2.Green * Color2Percent)
		  Var Blue As Integer = (Color1.Blue * Color1Percent) + (Color2.Blue * Color2Percent)
		  Var Alpha As Integer = (Color1.Alpha * Color1Percent) + (Color2.Alpha * Color2Percent)
		  
		  Return Color.RGB(Red, Green, Blue, Alpha)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CapHeight(Extends G As Graphics) As Double
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa.framework" (ClassName As CString) As Ptr
		    Var NSFont As Ptr = objc_getClass("NSFont")
		    If NSFont = Nil Then
		      #if DebugBuild
		        System.DebugLog("Unable to get class reference to NSFont.")
		      #endif
		      Return G.FontAscent * 0.8
		    End If
		    
		    Var FontObject As Ptr
		    If G.FontName = "SmallSystem" And G.FontSize = 0 Then
		      If G.Bold Then
		        Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "boldSystemFontOfSize:" (Target As Ptr, Size As CGFloat) As Ptr
		        FontObject = SystemFontOfSize(NSFont, 11)
		      Else
		        Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As CGFloat) As Ptr
		        FontObject = SystemFontOfSize(NSFont, 11)
		      End If
		    ElseIf G.FontName = "System" Or G.FontName = "SmallSystem" Then
		      If G.Bold Then
		        Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "boldSystemFontOfSize:" (Target As Ptr, Size As CGFloat) As Ptr
		        FontObject = SystemFontOfSize(NSFont, G.FontSize)
		      Else
		        Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As CGFloat) As Ptr
		        FontObject = SystemFontOfSize(NSFont, G.FontSize)
		      End If
		    Else
		      Declare Function FontWithName Lib "Cocoa.framework" Selector "fontWithName:size:" (Target As Ptr, FontName As CFStringRef, Size As CGFloat) As Ptr
		      FontObject = FontWithName(NSFont,G.FontName, G.FontSize)
		    End If
		    
		    If FontObject = Nil Then
		      #if DebugBuild
		        System.DebugLog("Unable to get font object.")
		      #endif
		      Return G.FontAscent * 0.8
		    End If
		    
		    Declare Function GetCapHeight Lib "Cocoa.framework" Selector "capHeight" (Target As Ptr) As CGFloat
		    Return GetCapHeight(FontObject)
		  #elseif TargetWin32 or TargetLinux
		    Return G.FontAscent * 0.75
		  #else
		    Return G.FontAscent
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContrastAgainst(Extends LeftColor As Color, RightColor As Color) As Double
		  Var LeftLuminance As Double = LeftColor.Luminance
		  Var RightLuminance As Double = RightColor.Luminance
		  If LeftLuminance > RightLuminance Then
		    Return (LeftLuminance + 0.05) / (RightLuminance + 0.05)
		  Else
		    Return (RightLuminance + 0.05) / (LeftLuminance + 0.05)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Darker(Extends Source As Color, Percent As Double) As Color
		  Return Color.HSV(Source.Hue, Source.Saturation, Source.Value * (1 - Percent))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DarkModeSupported() As Boolean
		  #if TargetMacOS
		    Return True
		  #elseif TargetWindows
		    Return SystemInformationMBS.WinMajorVersion >= 10 And SystemInformationMBS.WinBuildNumber >= 18362
		  #else
		    Return False
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindContrastingColor(BackgroundColor As Color, ForegroundColor As Color, ChangeForeground As Boolean = True, RequiredContrast As Double = 4.5) As Color
		  If mContrastingColors Is Nil Then
		    mContrastingColors = New Dictionary
		  End If
		  
		  Var TargetColor, TestAgainst As Color
		  If ChangeForeground Then
		    TargetColor = ForegroundColor
		    TestAgainst = BackgroundColor
		  Else
		    TargetColor = BackgroundColor
		    TestAgainst = ForegroundColor
		  End If
		  
		  Var Key As String = BackgroundColor.ToHex + ":" + ForegroundColor.ToHex + ":" + RequiredContrast.ToString + ":" + ChangeForeground.ToString
		  If mContrastingColors.HasKey(Key) = False Then
		    Var ComputedColor As Color
		    
		    Var Computed As Boolean
		    For Percent As Double = 0.0 To 1.0 Step 0.01
		      Var Darker As Color = TargetColor.Darker(Percent)
		      Var Lighter As Color = TargetColor.Lighter(Percent)
		      If Darker.ContrastAgainst(TestAgainst) >= RequiredContrast Then
		        ComputedColor = Darker
		        Computed = True
		        Exit
		      ElseIf Lighter.ContrastAgainst(TestAgainst) >= RequiredContrast Then
		        ComputedColor = Lighter
		        Computed = True
		        Exit
		      End If
		    Next
		    
		    If Computed = False Then
		      Var WhiteContrast As Double = TestAgainst.ContrastAgainst(&cFFFFFF)
		      Var BlackContrast As Double = TestAgainst.ContrastAgainst(&c000000)
		      If WhiteContrast > BlackContrast Then
		        ComputedColor = &cFFFFFF
		      Else
		        ComputedColor = &c000000
		      End If
		    End If
		    
		    mContrastingColors.Value(Key) = ComputedColor
		  End If
		  
		  Return mContrastingColors.Value(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub FixTabFont(Extends Panel As DesktopTabPanel)
		  #if TargetCocoa
		    Declare Function objc_getClass Lib "Cocoa.framework" (ClassName As CString) As Ptr
		    Var NSFont As Ptr = objc_getClass("NSFont")
		    If NSFont = Nil Then
		      Return
		    End If
		    
		    Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As CGFloat) As Ptr
		    Var FontObject As Ptr = SystemFontOfSize(NSFont, 0)
		    
		    Declare Function GetPointSize Lib "Cocoa.framework" Selector "pointSize" (Target As Ptr) As CGFloat
		    
		    Panel.FontUnit = FontUnits.Point
		    Panel.FontName = "System"
		    Panel.FontSize = GetPointSize(FontObject)
		  #else
		    #Pragma Unused Panel
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function GlobalPosition(Extends Target As DesktopContainer) As Xojo.Point
		  Var Offset As Xojo.Point
		  Var Parent As Object = Target.Parent
		  
		  Do Until (Parent IsA DesktopUIControl) = False
		    Parent = DesktopUIControl(Parent).Parent
		  Loop
		  
		  Select Case Parent
		  Case IsA DesktopContainer
		    Offset = DesktopContainer(Parent).GlobalPosition
		  Case IsA DesktopWindow
		    Offset = New Xojo.Point(DesktopWindow(Parent).Left, DesktopWindow(Parent).Top)
		  End Select
		  
		  Return New Xojo.Point(Target.Left + Offset.X, Target.Top + Offset.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function GlobalPosition(Extends Target As DesktopUIControl) As Xojo.Point
		  Var Offset As Xojo.Point
		  Var Parent As Object = Target.Parent
		  
		  Do Until (Parent IsA DesktopUIControl) = False
		    Parent = DesktopUIControl(Parent).Parent
		  Loop
		  
		  Select Case Parent
		  Case IsA DesktopContainer
		    Offset = DesktopContainer(Parent).GlobalPosition
		  Case IsA DesktopWindow
		    Offset = New Xojo.Point(DesktopWindow(Parent).Left, DesktopWindow(Parent).Top)
		  End Select
		  
		  Return New Xojo.Point(Target.Left + Offset.X, Target.Top + Offset.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IconWithColor(Icon As Picture, FillColor As Color, MinFactor As Double, MaxFactor As Double, Overlay As Picture = Nil) As Picture
		  Var Width As Integer = Icon.Width
		  Var Height As Integer = Icon.Height
		  
		  Var Bitmaps() As Picture
		  For Factor As Integer = MinFactor To MaxFactor
		    Var ScaledIcon As Picture = Icon.BestRepresentation(Width, Height, Factor)
		    
		    Var Pic As New Picture(Width * Factor, Height * Factor)
		    Pic.VerticalResolution = 72 * Factor
		    Pic.HorizontalResolution = 72 * Factor
		    Pic.Graphics.DrawingColor = Color.RGB(FillColor.Red, FillColor.Green, FillColor.Blue)
		    Pic.Graphics.FillRectangle(0, 0, Pic.Width, Pic.Height)
		    
		    Var Mask As New Picture(Width * Factor, Height * Factor)
		    Mask.VerticalResolution = 72 * Factor
		    Mask.HorizontalResolution = 72 * Factor
		    Mask.Graphics.DrawingColor = &cFFFFFF
		    Mask.Graphics.FillRectangle(0, 0, Pic.Width, Pic.Height)
		    Mask.Graphics.DrawPicture(ScaledIcon, 0, 0, Pic.Width, Pic.Height, 0, 0, ScaledIcon.Width, ScaledIcon.Height)
		    
		    If Overlay <> Nil Then
		      Var OverlayIcon As Picture = Overlay.BestRepresentation(Width, Height, Factor)
		      Mask.Graphics.DrawPicture(OverlayIcon, 0, 0, Mask.Width, Mask.Height, 0, 0, OverlayIcon.Width, OverlayIcon.Height)
		    End If
		    
		    If FillColor.Alpha <> 0 Then
		      Mask.Graphics.DrawingColor = Color.RGB(255, 255, 255, 255 - FillColor.Alpha)
		      Mask.Graphics.FillRectangle(0, 0, Pic.Width, Pic.Height)
		    End If
		    
		    Pic.ApplyMask(Mask)
		    Bitmaps.Add(Pic)
		  Next
		  Return New Picture(Width, Height, Bitmaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IconWithColor(Icon As Picture, FillColor As Color, Overlay As Picture = Nil) As Picture
		  Return IconWithColor(Icon, FillColor, 1, 3, Overlay)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IdealHeight(Targets() As DesktopLabel) As Integer
		  Var MaxHeight As Integer
		  Var Pic As New Picture(20, 20)
		  Var G As Graphics = Pic.Graphics
		  For Idx As Integer = Targets.FirstIndex To Targets.LastIndex
		    If Targets(Idx) Is Nil Or Targets(Idx).Visible = False Then
		      Continue
		    End If
		    
		    G.FontName = Targets(Idx).FontName
		    G.FontSize = Targets(Idx).FontSize
		    G.FontUnit = Targets(Idx).FontUnit
		    G.Bold = Targets(Idx).Bold
		    G.Italic = Targets(Idx).Italic
		    G.Underline = Targets(Idx).Underline
		    
		    MaxHeight = Max(MaxHeight, Ceiling(G.TextHeight(Targets(Idx).Text, Targets(Idx).Width)))
		  Next Idx
		  #if TargetMacOS
		    Return Round(MaxHeight * 1.15)
		  #else
		    Return MaxHeight
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IdealHeight(ParamArray Targets() As DesktopLabel) As Integer
		  Return IdealHeight(Targets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function IdealHeight(Extends Target As DesktopLabel) As Integer
		  Return IdealHeight(Target)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IdealWidth(ParamArray Targets() As DesktopCheckBox) As Integer
		  Return IdealWidth(Targets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IdealWidth(Targets() As DesktopCheckBox) As Integer
		  Var MaxWidth As Integer
		  Var Pic As New Picture(20, 20)
		  Var G As Graphics = Pic.Graphics
		  For Idx As Integer = Targets.FirstIndex To Targets.LastIndex
		    If Targets(Idx) Is Nil Or Targets(Idx).Visible = False Then
		      Continue
		    End If
		    
		    G.FontName = Targets(Idx).FontName
		    G.FontSize = Targets(Idx).FontSize
		    G.FontUnit = Targets(Idx).FontUnit
		    G.Bold = Targets(Idx).Bold
		    G.Italic = Targets(Idx).Italic
		    G.Underline = Targets(Idx).Underline
		    
		    MaxWidth = Max(MaxWidth, Ceiling(G.TextWidth(Targets(Idx).Caption)))
		  Next Idx
		  #if TargetWindows
		    Return Round(MaxWidth * 1.05) + 20
		  #else
		    Return MaxWidth + 22
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IdealWidth(Targets() As DesktopLabel) As Integer
		  Var MaxWidth As Integer
		  Var Pic As New Picture(20, 20)
		  Var G As Graphics = Pic.Graphics
		  For Idx As Integer = Targets.FirstIndex To Targets.LastIndex
		    If Targets(Idx) Is Nil Or Targets(Idx).Visible = False Then
		      Continue
		    End If
		    
		    G.FontName = Targets(Idx).FontName
		    G.FontSize = Targets(Idx).FontSize
		    G.FontUnit = Targets(Idx).FontUnit
		    G.Bold = Targets(Idx).Bold
		    G.Italic = Targets(Idx).Italic
		    G.Underline = Targets(Idx).Underline
		    
		    MaxWidth = Max(MaxWidth, Ceiling(G.TextWidth(Targets(Idx).Text)))
		  Next Idx
		  #if TargetWindows
		    Return Round(MaxWidth * 1.05)
		  #else
		    Return MaxWidth
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IdealWidth(ParamArray Targets() As DesktopLabel) As Integer
		  Return IdealWidth(Targets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function IdealWidth(Extends Target As DesktopCheckBox) As Integer
		  Return IdealWidth(Target)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function IdealWidth(Extends Target As DesktopLabel) As Integer
		  Return IdealWidth(Target)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBright(Extends Source As Color) As Boolean
		  Return Source.Luminance > 0.65
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lighter(Extends Source As Color, Percent As Double) As Color
		  Return Color.HSV(Source.Hue, Source.Saturation, Source.Value + (Source.Value * Percent))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Luminance(Extends Source As Color) As Double
		  Var Red As Double = (Source.Red / 255)
		  Var Green As Double = (Source.Green / 255)
		  Var Blue As Double = (Source.Blue / 255)
		  
		  Red = If(Red <= 0.03928, Red / 12.92, ((Red + 0.055) / 1.055) ^ 2.4)
		  Green = If(Green <= 0.03928, Green / 12.92, ((Green + 0.055) / 1.055) ^ 2.4)
		  Blue = If(Blue <= 0.03928, Blue / 12.92, ((Blue + 0.055) / 1.055) ^ 2.4)
		  
		  Return (0.2126 * Red) + (0.7152 * Green) + (0.0722 * Blue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OpaqueColor(Extends Source As Color, BackgroundColor As Color) As Color
		  Var SourceOpacity As Double = Source.Alpha / 255
		  If SourceOpacity = 1 Then
		    Return Source
		  End If
		  
		  Var SourceBase As Color = Color.RGB(Source.Red, Source.Green, Source.Blue)
		  Return SourceBase.BlendWith(BackgroundColor, SourceOpacity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Piece(Extends Source As Picture, Left As Integer, Top As Integer, Width As Integer, Height As Integer) As Picture
		  Var Pic As New Picture(Width, Height)
		  Pic.Graphics.DrawPicture(Source, 0, 0, Width, Height, Left, Top, Width, Height)
		  Return Pic
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub RemoveAllRows(Extends Menu As DesktopMenuItem)
		  For I As Integer = Menu.LastRowIndex DownTo 0
		    Menu.RemoveMenuAt(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Sub ShowAlert(Win As DesktopWindow = Nil, Message As String, Explanation As String)
		  If (Thread.Current Is Nil) = False Then
		    // Can't show the alert right now
		    Var Dict As New Dictionary
		    Dict.Value("Window") = Win
		    Dict.Value("Message") = Message
		    Dict.Value("Explanation") = Explanation
		    Call CallLater.Schedule(0, AddressOf ShowAlertLater, Dict)
		    Return
		  End If
		  
		  If (Win Is Nil) = False Then
		    Try
		      Win = Win.TrueWindow
		    Catch Err As RuntimeException
		      Win = Nil
		    End Try
		  End If
		  
		  #if TargetWindows
		    Var Dialog As New TaskDialogMBS
		    Dialog.Yield = False
		    Dialog.ExpandFooterArea = False
		    Dialog.MainInstruction = Message
		    Dialog.Content = Explanation
		    Dialog.CommonButtons = TaskDialogMBS.kCommonButtonOK
		    Dialog.DefaultButton = TaskDialogMBS.kCommonButtonOK
		    Dialog.Parent = Win
		    Dialog.PositionRelativeToWindow = True
		    Call Dialog.ShowDialog
		  #else
		    Var Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = Message
		    Dialog.Explanation = Explanation
		    
		    Try
		      If Win Is Nil Or Win.Type = DesktopWindow.Types.Sheet Or TargetWindows Then
		        Call Dialog.ShowModal()
		      Else
		        Var FocusControl As DesktopUIControl = Win.Focus
		        Win.Focus = Nil
		        Call Dialog.ShowModal(Win)
		        Win.Focus = FocusControl
		      End If
		    Catch Err As RuntimeException
		      Call Dialog.ShowModal()
		    End Try
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub ShowAlert(Extends Win As DesktopWindow, Message As String, Explanation As String)
		  ShowAlert(Win, Message, Explanation)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target64Bit))
		Sub ShowAlert(Extends Win As MobileScreen, Message As String, Explanation As String)
		  Win.ShowAlert(Message, Explanation)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetIOS and (Target64Bit))
		Protected Sub ShowAlert(Win As MobileScreen = Nil, Message As String, Explanation As String)
		  #Pragma Unused Win
		  
		  Var Dialog As New MobileMessageBox
		  Dialog.Title = Message
		  Dialog.Message = Explanation
		  Dialog.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub ShowAlertLater(Argument As Variant)
		  If Argument.IsNull = False And Argument IsA Dictionary Then
		    Var Dict As Dictionary = Argument
		    ShowAlert(Dict.Value("Window"), Dict.Value("Message").StringValue, Dict.Value("Explanation").StringValue)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function ShowConfirm(Win As DesktopWindow = Nil, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Return ShowConfirm(Win, Message, Explanation, ActionCaption, CancelCaption, "") = ConfirmResponses.Action
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function ShowConfirm(Win As DesktopWindow = Nil, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String, AlternateAction As String) As BeaconUI.ConfirmResponses
		  If (Win Is Nil) = False Then
		    Try
		      Win = Win.TrueWindow
		    Catch Err As RuntimeException
		      Win = Nil
		    End Try
		  End If
		  
		  #if TargetWindows
		    Var Dialog As New TaskDialogMBS
		    Dialog.Yield = False
		    Dialog.ExpandFooterArea = False
		    Dialog.MainInstruction = Message
		    Dialog.Content = Explanation
		    Dialog.Parent = Win
		    Dialog.PositionRelativeToWindow = True
		    
		    Var ActionButton As New TaskDialogButtonMBS
		    ActionButton.Text = ActionCaption
		    ActionButton.ID = 0
		    ActionButton.Default = True
		    Dialog.AppendButton(ActionButton)
		    
		    If AlternateAction.IsEmpty = False Then
		      Var AlternateButton As New TaskDialogButtonMBS
		      AlternateButton.Text = AlternateAction
		      AlternateButton.ID = 2
		      AlternateButton.Default = False
		      Dialog.AppendButton(AlternateButton)
		    End If
		    
		    Var CancelButton As New TaskDialogButtonMBS
		    CancelButton.Text = CancelCaption
		    CancelButton.ID = 1
		    CancelButton.Default = False
		    Dialog.AppendButton(CancelButton)
		    
		    If Dialog.ShowDialog = False Or Dialog.TimedOut Then
		      Return BeaconUI.ConfirmResponses.Cancel
		    End If
		    
		    Var Choice As Integer = Dialog.SelectedButton
		    Select Case Choice
		    Case 0
		      Return BeaconUI.ConfirmResponses.Action
		    Case 1
		      Return BeaconUI.ConfirmResponses.Cancel
		    Case 2
		      Return BeaconUI.ConfirmResponses.Alternate
		    End Select
		  #else
		    Var Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = Message
		    Dialog.Explanation = Explanation
		    Dialog.ActionButton.Caption = ActionCaption
		    Dialog.CancelButton.Caption = CancelCaption
		    Dialog.CancelButton.Visible = True
		    If AlternateAction.IsEmpty = False Then
		      Dialog.AlternateActionButton.Caption = AlternateAction
		      Dialog.AlternateActionButton.Visible = True
		    End If
		    
		    Var Result As MessageDialogButton
		    Try
		      If Win Is Nil Or Win.Type = DesktopWindow.Types.Sheet Or TargetWindows Then
		        Result = Dialog.ShowModal()
		      Else
		        Var FocusControl As DesktopUIControl = Win.Focus
		        Win.Focus = Nil
		        Result = Dialog.ShowModal(Win)
		        Win.Focus = FocusControl
		      End If
		    Catch Err As RuntimeException
		      Result = Dialog.ShowModal()
		    End Try
		    
		    Select Case Result
		    Case Dialog.ActionButton
		      Return ConfirmResponses.Action
		    Case Dialog.CancelButton
		      Return ConfirmResponses.Cancel
		    Case Dialog.AlternateActionButton
		      Return ConfirmResponses.Alternate
		    End Select
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ShowConfirm(Extends Win As DesktopWindow, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Return ShowConfirm(Win, Message, Explanation, ActionCaption, CancelCaption, "") = ConfirmResponses.Action
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ShowConfirm(Extends Win As DesktopWindow, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String, AlternateCaption As String) As BeaconUI.ConfirmResponses
		  Return ShowConfirm(Win, Message, Explanation, ActionCaption, CancelCaption, AlternateCaption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function ShowDeleteConfirmation(Win As DesktopWindow = Nil, Items() As Beacon.NamedItem, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Var Names() As String
		  For Each Item As Beacon.NamedItem In Items
		    Names.Add(Item.Label)
		  Next
		  Return ShowDeleteConfirmation(Win, Names, SingularNoun, PluralNoun, Restore)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function ShowDeleteConfirmation(Win As DesktopWindow = Nil, Names() As String, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Var UniqueNames() As String
		  Var UseGenericNames As Boolean
		  For Each Name As String In Names
		    If UniqueNames.IndexOf(Name) > -1 Then
		      UseGenericNames = True
		    Else
		      UniqueNames.Add(Name)
		    End If
		  Next
		  UseGenericNames = UseGenericNames Or UniqueNames.Count > 8
		  
		  Var Message As String
		  If Restore Then
		    If UseGenericNames Then
		      Message = "Are you sure you want to restore these " + Names.Count.ToString + " " + PluralNoun + " to their default settings?"
		    ElseIf Names.LastIndex = 0 Then
		      Message = "Are you sure you want to restore the " + SingularNoun + " " + UniqueNames(0) + " to its default settings?"
		    Else
		      Message = "Are you sure you want to restore the " + PluralNoun + " " + Language.EnglishOxfordList(UniqueNames) + " to their default settings?"
		    End If
		  Else
		    If UseGenericNames Then
		      Message = "Are you sure you want to delete these " + Names.Count.ToString + " " + PluralNoun + "?"
		    ElseIf Names.LastIndex = 0 Then
		      Message = "Are you sure you want to delete the " + SingularNoun + " " + UniqueNames(0) + "?"
		    Else
		      Message = "Are you sure you want to delete the " + PluralNoun + " " + Language.EnglishOxfordList(UniqueNames) + "?"
		    End If
		  End If
		  
		  Return ShowConfirm(Win, Message, "This action cannot be undone.", If(Restore, "Restore", "Delete"), "Cancel")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ShowDeleteConfirmation(Extends Win As DesktopWindow, Items() As Beacon.NamedItem, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Return ShowDeleteConfirmation(Win, Items, SingularNoun, PluralNoun, Restore)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ShowDeleteConfirmation(Extends Win As DesktopWindow, Names() As String, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Return ShowDeleteConfirmation(Win, Names, SingularNoun, PluralNoun, Restore)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Sub SizeColumnToFit(Extends List As DesktopListbox, ColumnIndex As Integer, MinWidth As Integer = 0)
		  Var TestPic As New Picture(10, 10)
		  TestPic.Graphics.FontSize = 0
		  TestPic.Graphics.FontName = "System"
		  Var MaxWidth As Integer = Max(Ceiling(TestPic.Graphics.TextWidth(List.HeaderAt(ColumnIndex))) + 30, MinWidth)
		  For Row As Integer = 0 To List.LastRowIndex
		    MaxWidth = Max(MaxWidth, Ceiling(TestPic.Graphics.TextWidth(List.CellTextAt(Row, ColumnIndex))) + 30)
		  Next
		  List.ColumnAttributesAt(ColumnIndex).WidthExpression = MaxWidth.ToString(Locale.Raw, "0")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SizeToFit(ParamArray Targets() As DesktopCheckBox)
		  SizeToFit(Targets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SizeToFit(Targets() As DesktopCheckBox)
		  Var Width As Integer = IdealWidth(Targets)
		  For Idx As Integer = Targets.FirstIndex To Targets.LastIndex
		    If Targets(Idx) Is Nil Then
		      Continue
		    End If
		    
		    Targets(Idx).Width = Width
		  Next Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SizeToFit(Targets() As DesktopLabel)
		  Var Width As Integer = IdealWidth(Targets)
		  For Idx As Integer = Targets.FirstIndex To Targets.LastIndex
		    If Targets(Idx) Is Nil Then
		      Continue
		    End If
		    
		    Targets(Idx).Width = Width
		  Next Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SizeToFit(ParamArray Targets() As DesktopLabel)
		  SizeToFit(Targets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SizeToFit(Extends Target As DesktopCheckBox)
		  SizeToFit(Target)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SizeToFit(Extends Target As DesktopLabel)
		  SizeToFit(Target)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewIcon(Extends Url As Beacon.ProjectUrl) As Picture
		  Select Case Url.Type
		  Case Beacon.ProjectURL.TypeCloud
		    Return IconCloudDocument
		  Case Beacon.ProjectURL.TypeCommunity
		    Return IconCommunityDocument
		  Case Beacon.ProjectURL.TypeShared
		    Return IconSharedDocument
		  Case Beacon.ProjectURL.TypeWeb
		    Return IconWebDocument
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WebContentSupported() As Boolean
		  #if TargetMacOS
		    Return SystemInformationMBS.IsHighSierra(True)
		  #else
		    Return True
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WithColor(Extends Icon As Picture, FillColor As Color) As Picture
		  Return BeaconUI.IconWithColor(Icon, FillColor)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mColorProfile As BeaconUI.ColorProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContrastingColors As Dictionary
	#tag EndProperty


	#tag Constant, Name = BorderBottom, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BorderLeft, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BorderRight, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BorderTop, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CursorsEnabled, Type = Boolean, Dynamic = False, Default = \"True", Scope = Protected
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"False"
	#tag EndConstant

	#tag Constant, Name = ToolbarHasBackground, Type = Boolean, Dynamic = False, Default = \"True", Scope = Protected
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"False"
	#tag EndConstant


	#tag Enum, Name = ConfirmResponses, Type = Integer, Flags = &h0
		Action
		  Cancel
		Alternate
	#tag EndEnum


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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
