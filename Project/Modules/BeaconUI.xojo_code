#tag Module
Protected Module BeaconUI
	#tag Method, Flags = &h0
		Function AtOpacity(Extends SourceColor As Color, Opacity As Double = 1.0) As Color
		  // Opacity = 1.0 means unchanged, may not actually be opaque
		  // Opacity = 0.5 means cut opacity in half
		  
		  Return RGB(SourceColor.Red, SourceColor.Green, SourceColor.Blue, 255 + ((SourceColor.Alpha - 255) * Opacity))
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
		  
		  Return RGB(Red, Green, Blue, Alpha)
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
		  #elseif TargetWin32
		    Return G.FontAscent * 0.75
		  #else
		    Return G.FontAscent
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Capture(Extends Win As Window) As Picture
		  #if TargetWin32
		    Declare Sub BitBlt Lib "GDI32" (DestinationContext As Ptr, X As Integer, Y As Integer, Width As Integer, Height As Integer, SourceContext As Integer, SrcX As Integer, SrcY As Integer, RasterOperationCode As Integer)
		    Declare Function GetDC Lib "User32" (Handle As Integer ) As Integer
		    Declare Function CreateCompatibleBitmap Lib "Gdi32" (Context As Integer, Width As Integer, Height As Integer) As Integer
		    Declare Sub GetObjectA Lib "GDI32" (Bitmap As Integer, Size As Integer, Struct As Ptr)
		    Declare Sub DeleteObject Lib "Gdi32" (Obj As Integer)
		    Declare Function GetDeviceCaps Lib "GDI32" (hDC As Integer, Index As Integer) As Integer
		    
		    Const LOGPIXELSX = 88
		    Const LOGPIXELSY = 90
		    
		    // We want to get the screen's DC first
		    Var Context As Integer = GetDC(Win.Handle)
		    Var HorizontalScale As Double = GetDeviceCaps(Context, LOGPIXELSX) / 96
		    Var VerticalScale As Double = GetDeviceCaps(Context, LOGPIXELSY) / 96
		    
		    Var BitmapHandle As Integer
		    Var PicWidth As Integer = Win.Width * HorizontalScale
		    Var PicHeight As Integer = Win.Height * VerticalScale
		    BitmapHandle = CreateCompatibleBitmap(Context, PicWidth, PicHeight)
		    If BitmapHandle = 0 Then
		      Return Nil
		    End If
		    
		    Var BitsPerPixel As Integer
		    #if Target32Bit
		      Var BitmapInfo As New MemoryBlock(24)
		      GetObjectA(BitmapHandle, 24, BitmapInfo)
		      BitsPerPixel = BitmapInfo.UInt8Value(18)
		    #else
		      Var BitmapInfo As New MemoryBlock(48)
		      GetObjectA(BitmapHandle, 48, BitmapInfo)
		      BitsPerPixel = BitmapInfo.UInt8Value(18)
		    #endif
		    
		    DeleteObject(BitmapHandle)
		    
		    Var WindowPic As New Picture(PicWidth, PicHeight, BitsPerPixel)
		    WindowPic.HorizontalResolution = 72 * HorizontalScale
		    WindowPic.VerticalResolution = 72 * VerticalScale
		    
		    Var DestinationContext As Ptr = WindowPic.Graphics.Handle(Graphics.HandleTypes.HDC)
		    Const CAPTUREBLT = &h40000000
		    Const SRCCOPY = &hCC0020
		    BitBlt(DestinationContext, 0, 0, PicWidth, PicHeight, Context, 0, 0, SRCCOPY + CAPTUREBLT )
		    
		    Var Pics() As Picture
		    For Scale As Double = 1.0 To 3.0
		      If Scale = HorizontalScale And Scale = VerticalScale Then
		        Pics.AddRow(WindowPic)
		        Continue
		      End If
		      
		      Var Pic As New Picture(Win.Width * Scale, Win.Height * Scale)
		      Pic.HorizontalResolution = 72 * Scale
		      Pic.VerticalResolution = 72 * Scale
		      Pic.Graphics.DrawPicture(WindowPic, 0, 0, Pic.Width, Pic.Height, 0, 0, WindowPic.Width, WindowPic.Height)
		      Pics.AddRow(Pic)
		    Next
		    
		    Return New Picture(Win.Width, Win.Height, Pics)
		  #else
		    #Pragma Unused Win
		    Return Nil
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
		Function CreateWeightIndicator(OffsetPercent As Double, WeightPercent As Double, WidthInPoints As Integer, HeightInPoints As Integer, Scale As Double = 1.0) As Picture
		  Var Pic As New Picture(WidthInPoints * Scale, HeightInPoints * Scale)
		  ' Pic.Graphics.ScaleX = Scale
		  ' Pic.Graphics.ScaleY = Scale
		  ' Pic.HorizontalResolution = 72 * Scale
		  ' Pic.VerticalResolution = 72 * Scale
		  
		  Pic.Graphics.DrawingColor = &c000000
		  Pic.Graphics.FillRectangle(0, 0, Pic.Width, Pic.Height)
		  
		  Pic.Graphics.DrawingColor = &cFFFFFF
		  Pic.Graphics.FillOval(2 * Scale, 2 * Scale, Pic.Width - (4 * Scale) , Pic.Height - (4 * Scale))
		  
		  Var CenterPoint As New Xojo.Point(Pic.Width / 2, Pic.Height / 2)
		  
		  Var Angles(1) As Double
		  Angles(0) = (360 * OffsetPercent) - 90
		  Angles(1) = (360 * (OffsetPercent + WeightPercent)) - 90
		  
		  Var Radius As Double = Min(Pic.Width, Pic.Height) / 2
		  Var Distance As Double = Radius * 1.5
		  Var Points(2) As Integer
		  Points(1) = Round(CenterPoint.X)
		  Points(2) = Round(CenterPoint.Y)
		  For Each Angle As Double In Angles
		    While Angle >= 270
		      Angle = Angle - 360
		    Wend
		    Var Rads As Double = Angle * 0.01745329252
		    Var LegX As Double = CenterPoint.X + (Distance * Cos(Rads))
		    Var LegY As Double = CenterPoint.Y + (Distance * Sin(Rads))
		    Points.AddRow(Round(LegX))
		    Points.AddRow(Round(LegY))
		  Next
		  
		  Pic.Graphics.DrawingColor = &c000000
		  Pic.Graphics.FillPolygon(Points)
		  
		  Var Mask As New Picture(Pic.Width, Pic.Height, 32)
		  Mask.Graphics.DrawingColor = &c000000
		  Mask.Graphics.FillOval(0, 0, Mask.Width, Mask.Height)
		  Pic.ApplyMask(Mask)
		  
		  Var Final As New Picture(Pic.Width, Pic.Height, 32)
		  Final.Graphics.DrawPicture(Pic, 0, 0)
		  
		  Return New Picture(WidthInPoints, HeightInPoints, Array(Final))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Darker(Extends Source As Color, Percent As Double) As Color
		  Return Color.HSV(Source.Hue, Source.Saturation, Source.Value * (1 - Percent))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindContrastingColor(BackgroundColor As Color, ForegroundColor As Color) As Color
		  For Percent As Double = 0.0 To 1.0 Step 0.01
		    Var Darker As Color = ForegroundColor.Darker(Percent)
		    Var Lighter As Color = ForegroundColor.Lighter(Percent)
		    If Darker.ContrastAgainst(BackgroundColor) >= 4.5 Then
		      Return Darker
		    ElseIf Lighter.ContrastAgainst(BackgroundColor) >= 4.5 Then
		      Return Lighter
		    End If
		  Next
		  
		  Var WhiteContrast As Double = BackgroundColor.ContrastAgainst(&cFFFFFF)
		  Var BlackContrast As Double = BackgroundColor.ContrastAgainst(&c000000)
		  If WhiteContrast > BlackContrast Then
		    Return &cFFFFFF
		  Else
		    Return &c000000
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FixTabFont(Extends Panel As TabPanel)
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

	#tag Method, Flags = &h1
		Protected Function IconWithColor(Icon As Picture, FillColor As Color, Overlay As Picture = Nil) As Picture
		  Var Width As Integer = Icon.Width
		  Var Height As Integer = Icon.Height
		  
		  Var Bitmaps() As Picture
		  For Factor As Integer = 1 To 3
		    Var ScaledIcon As Picture = Icon.BestRepresentation(Width, Height, Factor)
		    
		    Var Pic As New Picture(Width * Factor, Height * Factor)
		    Pic.VerticalResolution = 72 * Factor
		    Pic.HorizontalResolution = 72 * Factor
		    Pic.Graphics.DrawingColor = RGB(FillColor.Red, FillColor.Green, FillColor.Blue)
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
		      Mask.Graphics.DrawingColor = RGB(255, 255, 255, 255 - FillColor.Alpha)
		      Mask.Graphics.FillRectangle(0, 0, Pic.Width, Pic.Height)
		    End If
		    
		    Pic.ApplyMask(Mask)
		    Bitmaps.AddRow(Pic)
		  Next
		  Return New Picture(Width, Height, Bitmaps)
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
		Function Piece(Extends Source As Picture, Left As Integer, Top As Integer, Width As Integer, Height As Integer) As Picture
		  Var Pic As New Picture(Width, Height)
		  Pic.Graphics.DrawPicture(Source, 0, 0, Width, Height, Left, Top, Width, Height)
		  Return Pic
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAllRows(Extends Menu As MenuItem)
		  For I As Integer = Menu.LastRowIndex DownTo 0
		    Menu.RemoveMenuAt(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeCells(Extends Target As SegmentedButton)
		  Var CellCount As Integer = Target.SegmentCount
		  Var AvailableWidth As Integer = Target.Width - (CellCount + 3)
		  Var BaseCellWidth As Integer = Floor(AvailableWidth / CellCount)
		  Var Remainder As Integer = AvailableWidth - (BaseCellWidth * CellCount)
		  
		  For I As Integer = 0 To CellCount - 1
		    Var CellWidth As Integer = BaseCellWidth
		    If I < Remainder Then
		      CellWidth = CellWidth + 1
		    End If
		    
		    Var Cell As Segment = Target.SegmentAt(I)
		    Cell.Width = CellWidth
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowAlert(Extends Win As Window, Message As String, Explanation As String)
		  ShowAlert(Win, Message, Explanation)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShowAlert(Win As Window = Nil, Message As String, Explanation As String)
		  Try
		    Win = Win.TrueWindow
		  Catch Err As RuntimeException
		    Win = Nil
		  End Try
		  
		  Var Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  
		  Try
		    If Win = Nil Or Win.Type = Window.Types.Sheet Then
		      Call Dialog.ShowModal()
		    Else
		      Var FocusControl As RectControl = Win.Focus
		      Win.Focus = Nil
		      Call Dialog.ShowModalWithin(Win)
		      Win.Focus = FocusControl
		    End If
		  Catch Err As RuntimeException
		    Call Dialog.ShowModal()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowConfirm(Extends Win As Window, Account As Beacon.ExternalAccount) As Boolean
		  Return ShowConfirm(Win, Account)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowConfirm(Extends Win As Window, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Return ShowConfirm(Win, Message, Explanation, ActionCaption, CancelCaption, "") = ConfirmResponses.Action
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowConfirm(Extends Win As Window, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String, AlternateCaption As String) As BeaconUI.ConfirmResponses
		  Return ShowConfirm(Win, Message, Explanation, ActionCaption, CancelCaption, AlternateCaption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowConfirm(Win As Window = Nil, Account As Beacon.ExternalAccount) As Boolean
		  If Account Is Nil Then
		    Return False
		  End If
		  
		  Var Provider As String = Account.Provider
		  Var Message As String
		  Var Explanation As String = "This can happen if unused for a while or permission was revoked."
		  If Account.Label.IsEmpty Then
		    // Unnamed account
		    Message = "Beacon needs permission to access an account on " + Provider + ". Open your browser to authorize " + Provider + "?"
		  Else
		    // Named account
		    Message = "Beacon needs permission to access the " + Provider + " account " + Account.Label + ". Open your browser to authorize " + Provider + "?"
		    Explanation = " Make sure you authenticate with the account + " + Account.Label + " to prevent errors."
		  End If
		  
		  Return ShowConfirm(Win, Message, Explanation, "Continue", "Cancel")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowConfirm(Win As Window = Nil, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Return ShowConfirm(Win, Message, Explanation, ActionCaption, CancelCaption, "") = ConfirmResponses.Action
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowConfirm(Win As Window = Nil, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String, AlternateAction As String) As BeaconUI.ConfirmResponses
		  Try
		    Win = Win.TrueWindow
		  Catch Err As RuntimeException
		    Win = Nil
		  End Try
		  
		  Var Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  Dialog.ActionButton.Caption = ActionCaption
		  Dialog.CancelButton.Caption = CancelCaption
		  Dialog.CancelButton.Visible = True
		  If AlternateAction.Length > 0 Then
		    Dialog.AlternateActionButton.Caption = AlternateAction
		    Dialog.AlternateActionButton.Visible = True
		  End If
		  
		  Var Result As MessageDialogButton
		  Try
		    If Win = Nil Or Win.Type = Window.Types.Sheet Then
		      Result = Dialog.ShowModal()
		    Else
		      Var FocusControl As RectControl = Win.Focus
		      Win.Focus = Nil
		      Result = Dialog.ShowModalWithin(Win)
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
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowDeleteConfirmation(Extends Win As Window, Items() As Beacon.NamedItem, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Return ShowDeleteConfirmation(Win, Items, SingularNoun, PluralNoun, Restore)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowDeleteConfirmation(Extends Win As Window, Names() As String, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Return ShowDeleteConfirmation(Win, Names, SingularNoun, PluralNoun, Restore)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowDeleteConfirmation(Win As Window = Nil, Items() As Beacon.NamedItem, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Var Names() As String
		  For Each Item As Beacon.NamedItem In Items
		    Names.AddRow(Item.Label)
		  Next
		  Return ShowDeleteConfirmation(Win, Names, SingularNoun, PluralNoun, Restore)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowDeleteConfirmation(Win As Window = Nil, Names() As String, SingularNoun As String, PluralNoun As String, Restore As Boolean = False) As Boolean
		  Var UniqueNames() As String
		  Var UseGenericNames As Boolean
		  For Each Name As String In Names
		    If UniqueNames.IndexOf(Name) > -1 Then
		      UseGenericNames = True
		    Else
		      UniqueNames.AddRow(Name)
		    End If
		  Next
		  UseGenericNames = UseGenericNames Or UniqueNames.Count > 8
		  
		  Var Message As String
		  If Restore Then
		    If UseGenericNames Then
		      Message = "Are you sure you want to restore these " + Names.Count.ToString + " " + PluralNoun + " to their default settings?"
		    ElseIf Names.LastRowIndex = 0 Then
		      Message = "Are you sure you want to restore the " + SingularNoun + " " + UniqueNames(0) + " to its default settings?"
		    Else
		      Message = "Are you sure you want to restore the " + PluralNoun + " " + Language.EnglishOxfordList(UniqueNames) + " to their default settings?"
		    End If
		  Else
		    If UseGenericNames Then
		      Message = "Are you sure you want to delete these " + Names.Count.ToString + " " + PluralNoun + "?"
		    ElseIf Names.LastRowIndex = 0 Then
		      Message = "Are you sure you want to delete the " + SingularNoun + " " + UniqueNames(0) + "?"
		    Else
		      Message = "Are you sure you want to delete the " + PluralNoun + " " + Language.EnglishOxfordList(UniqueNames) + "?"
		    End If
		  End If
		  
		  Return ShowConfirm(Win, Message, "This action cannot be undone.", If(Restore, "Restore", "Delete"), "Cancel")
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
