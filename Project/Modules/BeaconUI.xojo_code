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
		  
		  Dim Color1Percent As Double = 1.0 - Color2Percent
		  
		  Dim Red As Integer = (Color1.Red * Color1Percent) + (Color2.Red * Color2Percent)
		  Dim Green As Integer = (Color1.Green * Color1Percent) + (Color2.Green * Color2Percent)
		  Dim Blue As Integer = (Color1.Blue * Color1Percent) + (Color2.Blue * Color2Percent)
		  Dim Alpha As Integer = (Color1.Alpha * Color1Percent) + (Color2.Alpha * Color2Percent)
		  
		  Return RGB(Red, Green, Blue, Alpha)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CapHeight(Extends G As Graphics) As Double
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa.framework" (ClassName As CString) As Ptr
		    Dim NSFont As Ptr = objc_getClass("NSFont")
		    If NSFont = Nil Then
		      #if DebugBuild
		        System.DebugLog("Unable to get class reference to NSFont.")
		      #endif
		      Return G.FontAscent * 0.8
		    End If
		    
		    Dim FontObject As Ptr
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
		    Declare Sub BitBlt Lib "GDI32" (DestinationContext As Integer, X As Integer, Y As Integer, Width As Integer, Height As Integer, SourceContext As Integer, SrcX As Integer, SrcY As Integer, RasterOperationCode As Integer)
		    Declare Function GetDC Lib "User32" (Handle As Integer ) As Integer
		    Declare Function CreateCompatibleBitmap Lib "Gdi32" (Context As Integer, Width As Integer, Height As Integer) As Integer
		    Declare Sub GetObjectA Lib "GDI32" (Bitmap As Integer, Size As Integer, Struct As Ptr)
		    Declare Sub DeleteObject Lib "Gdi32" (Obj As Integer)
		    Declare Function GetDeviceCaps Lib "GDI32" (hDC As Integer, Index As Integer) As Integer
		    
		    Const LOGPIXELSX = 88
		    Const LOGPIXELSY = 90
		    
		    // We want to get the screen's DC first
		    Dim Context As Integer = GetDC(Win.Handle)
		    Dim HorizontalScale As Double = GetDeviceCaps(Context, LOGPIXELSX) / 96
		    Dim VerticalScale As Double = GetDeviceCaps(Context, LOGPIXELSY) / 96
		    
		    Dim BitmapHandle As Integer
		    Dim PicWidth As Integer = Win.Width * HorizontalScale
		    Dim PicHeight As Integer = Win.Height * VerticalScale
		    BitmapHandle = CreateCompatibleBitmap(Context, PicWidth, PicHeight)
		    If BitmapHandle = 0 Then
		      Return Nil
		    End If
		    
		    Dim BitsPerPixel As Integer
		    #if Target32Bit
		      Dim BitmapInfo As New MemoryBlock(24)
		      GetObjectA(BitmapHandle, 24, BitmapInfo)
		      BitsPerPixel = BitmapInfo.UInt8Value(18)
		    #else
		      Dim BitmapInfo As New MemoryBlock(48)
		      GetObjectA(BitmapHandle, 48, BitmapInfo)
		      BitsPerPixel = BitmapInfo.UInt8Value(18)
		    #endif
		    
		    DeleteObject(BitmapHandle)
		    
		    Dim WindowPic As New Picture(PicWidth, PicHeight, BitsPerPixel)
		    WindowPic.HorizontalResolution = 72 * HorizontalScale
		    WindowPic.VerticalResolution = 72 * VerticalScale
		    
		    Dim DestinationContext As Integer = WindowPic.Graphics.Handle(Graphics.HandleTypeHDC)
		    Const CAPTUREBLT = &h40000000
		    Const SRCCOPY = &hCC0020
		    BitBlt(DestinationContext, 0, 0, PicWidth, PicHeight, Context, 0, 0, SRCCOPY + CAPTUREBLT )
		    
		    Dim Pics() As Picture
		    For Scale As Double = 1.0 To 3.0
		      If Scale = HorizontalScale And Scale = VerticalScale Then
		        Pics.Append(WindowPic)
		        Continue
		      End If
		      
		      Dim Pic As New Picture(Win.Width * Scale, Win.Height * Scale)
		      Pic.HorizontalResolution = 72 * Scale
		      Pic.VerticalResolution = 72 * Scale
		      Pic.Graphics.DrawPicture(WindowPic, 0, 0, Pic.Width, Pic.Height, 0, 0, WindowPic.Width, WindowPic.Height)
		      Pics.Append(Pic)
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
		  Dim LeftLuminance As Double = LeftColor.Luminance
		  Dim RightLuminance As Double = RightColor.Luminance
		  If LeftLuminance > RightLuminance Then
		    Return (LeftLuminance + 0.05) / (RightLuminance + 0.05)
		  Else
		    Return (RightLuminance + 0.05) / (LeftLuminance + 0.05)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateWeightIndicator(OffsetPercent As Double, WeightPercent As Double, WidthInPoints As Integer, HeightInPoints As Integer, Scale As Double = 1.0) As Picture
		  Dim Pic As New Picture(WidthInPoints * Scale, HeightInPoints * Scale)
		  ' Pic.Graphics.ScaleX = Scale
		  ' Pic.Graphics.ScaleY = Scale
		  ' Pic.HorizontalResolution = 72 * Scale
		  ' Pic.VerticalResolution = 72 * Scale
		  
		  Pic.Graphics.ForeColor = &c000000
		  Pic.Graphics.FillRect(0, 0, Pic.Width, Pic.Height)
		  
		  Pic.Graphics.ForeColor = &cFFFFFF
		  Pic.Graphics.FillOval(2 * Scale, 2 * Scale, Pic.Width - (4 * Scale) , Pic.Height - (4 * Scale))
		  
		  Dim CenterPoint As New REALbasic.Point(Pic.Width / 2, Pic.Height / 2)
		  
		  Dim Angles(1) As Double
		  Angles(0) = (360 * OffsetPercent) - 90
		  Angles(1) = (360 * (OffsetPercent + WeightPercent)) - 90
		  
		  Dim Radius As Double = Min(Pic.Width, Pic.Height) / 2
		  Dim Distance As Double = Radius * 1.5
		  Dim Points(2) As Integer
		  Points(1) = Round(CenterPoint.X)
		  Points(2) = Round(CenterPoint.Y)
		  For Each Angle As Double In Angles
		    While Angle >= 270
		      Angle = Angle - 360
		    Wend
		    Dim Rads As Double = Angle * 0.01745329252
		    Dim LegX As Double = CenterPoint.X + (Distance * Cos(Rads))
		    Dim LegY As Double = CenterPoint.Y + (Distance * Sin(Rads))
		    Points.Append(Round(LegX))
		    Points.Append(Round(LegY))
		  Next
		  
		  Pic.Graphics.ForeColor = &c000000
		  Pic.Graphics.FillPolygon(Points)
		  
		  Dim Mask As New Picture(Pic.Width, Pic.Height, 32)
		  Mask.Graphics.ForeColor = &c000000
		  Mask.Graphics.FillOval(0, 0, Mask.Width, Mask.Height)
		  Pic.ApplyMask(Mask)
		  
		  Dim Final As New Picture(Pic.Width, Pic.Height, 32)
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
		    Dim Darker As Color = ForegroundColor.Darker(Percent)
		    Dim Lighter As Color = ForegroundColor.Lighter(Percent)
		    If Darker.ContrastAgainst(BackgroundColor) >= 4.5 Then
		      Return Darker
		    ElseIf Lighter.ContrastAgainst(BackgroundColor) >= 4.5 Then
		      Return Lighter
		    End If
		  Next
		  
		  Dim WhiteContrast As Double = BackgroundColor.ContrastAgainst(&cFFFFFF)
		  Dim BlackContrast As Double = BackgroundColor.ContrastAgainst(&c000000)
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
		    Dim NSFont As Ptr = objc_getClass("NSFont")
		    If NSFont = Nil Then
		      Return
		    End If
		    
		    Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As CGFloat) As Ptr
		    Dim FontObject As Ptr = SystemFontOfSize(NSFont, 0)
		    
		    Declare Function GetPointSize Lib "Cocoa.framework" Selector "pointSize" (Target As Ptr) As CGFloat
		    
		    Panel.FontUnit = FontUnits.Point
		    Panel.FontName = "System"
		    Panel.FontSize = GetPointSize(FontObject)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Handler_WillPositionSheet(id as Ptr, s as Ptr, WindowHandle As Integer, SheetHandle As Integer, DefaultPosition As NSRect) As NSRect
		  #Pragma Unused id
		  #Pragma Unused s
		  
		  Dim Bound As Integer = WindowCount - 1
		  Dim Sheet As Window
		  
		  For I As Integer = 0 To Bound
		    If Window(I).Handle = SheetHandle Then
		      Sheet = Window(I)
		      Exit For I
		    End If
		  Next
		  
		  Dim InitialPosition As New REALbasic.Rect(DefaultPosition.Left, DefaultPosition.Top, DefaultPosition.Width, DefaultPosition.Height)
		  
		  For I As Integer = 0 To Bound
		    If Window(I) IsA BeaconUI.SheetPositionHandler And Window(I).Handle = WindowHandle Then
		      Dim NewPosition As REALbasic.Rect = BeaconUI.SheetPositionHandler(Window(I)).PositionSheet(Sheet, InitialPosition)
		      If NewPosition = Nil Then
		        Return DefaultPosition
		      Else
		        Dim ReturnRect As NSRect
		        ReturnRect.Left = InitialPosition.Left
		        ReturnRect.Top = InitialPosition.Top
		        ReturnRect.Width = InitialPosition.Width
		        ReturnRect.Height = InitialPosition.Height
		        Return ReturnRect
		      End If
		    End If
		  Next
		  
		  Return DefaultPosition
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IconWithColor(Icon As Picture, FillColor As Color, Overlay As Picture = Nil) As Picture
		  Dim Width As Integer = Icon.Width
		  Dim Height As Integer = Icon.Height
		  
		  Dim Bitmaps() As Picture
		  For Factor As Integer = 1 To 3
		    Dim Mask As Picture = Icon.BestRepresentation(Width, Height, Factor)
		    
		    Dim Pic As New Picture(Width * Factor, Height * Factor, 32)
		    Pic.VerticalResolution = 72 * Factor
		    Pic.HorizontalResolution = 72 * Factor
		    Pic.Graphics.ForeColor = RGB(FillColor.Red, FillColor.Green, FillColor.Blue)
		    Pic.Graphics.FillRect(0, 0, Pic.Width, Pic.Height)
		    Pic.Mask.Graphics.ClearRect(0, 0, Pic.Width, Pic.Height)
		    Pic.Mask.Graphics.DrawPicture(Mask, 0, 0, Mask.Width, Mask.Height, 0, 0, Mask.Width, Mask.Height)
		    
		    If Overlay <> Nil Then
		      Dim OverlayMask As Picture = Overlay.BestRepresentation(Width, Height, Factor)
		      Pic.Mask.Graphics.DrawPicture(OverlayMask, 0, 0, Mask.Width, Mask.Height, 0, 0, OverlayMask.Width, OverlayMask.Height)
		    End If
		    
		    Pic.Mask.Graphics.ForeColor = RGB(255, 255, 255, 255 - FillColor.Alpha)
		    Pic.Mask.Graphics.FillRect(0, 0, Pic.Width, Pic.Height)
		    
		    Bitmaps.Append(Pic)
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
		  Dim Red As Double = (Source.Red / 255)
		  Dim Green As Double = (Source.Green / 255)
		  Dim Blue As Double = (Source.Blue / 255)
		  
		  Red = If(Red <= 0.03928, Red / 12.92, ((Red + 0.055) / 1.055) ^ 2.4)
		  Green = If(Green <= 0.03928, Green / 12.92, ((Green + 0.055) / 1.055) ^ 2.4)
		  Blue = If(Blue <= 0.03928, Blue / 12.92, ((Blue + 0.055) / 1.055) ^ 2.4)
		  
		  Return (0.2126 * Red) + (0.7152 * Green) + (0.0722 * Blue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Piece(Extends Source As Picture, Left As Integer, Top As Integer, Width As Integer, Height As Integer) As Picture
		  Dim Pic As New Picture(Width, Height)
		  Pic.Graphics.DrawPicture(Source, 0, 0, Width, Height, Left, Top, Width, Height)
		  Return Pic
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RegisterSheetPositionHandler()
		  #if TargetCocoa
		    If DelegateClass = Nil Then
		      Declare Function NSSelectorFromString Lib "Cocoa" (SelectorName As CFStringRef) As Ptr
		      Declare Function NSClassFromString Lib "Cocoa" (ClassName As CFStringRef) As Ptr
		      Declare Function class_addMethod Lib "Cocoa" (Ref As Ptr, Name As Ptr, Imp As Ptr, Types As CString) As Boolean
		      
		      DelegateClass = NSClassFromString("XOJWindowController")
		      If Not class_addMethod(DelegateClass, NSSelectorFromString("window:willPositionSheet:usingRect:"), AddressOf Handler_WillPositionSheet, "{NSRect=ffff}@:@@{NSRect=ffff}") Then
		        Break
		        Return
		      End If
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeCells(Extends Target As SegmentedButton)
		  Dim CellCount As Integer = Target.SegmentCount
		  Dim AvailableWidth As Integer = Target.Width - (CellCount * 2)
		  Dim BaseCellWidth As Integer = Floor(AvailableWidth / CellCount)
		  Dim Remainder As Integer = AvailableWidth - (BaseCellWidth * CellCount)
		  
		  For I As Integer = 0 To CellCount - 1
		    Dim CellWidth As Integer = BaseCellWidth
		    If I < Remainder Then
		      CellWidth = CellWidth + 1
		    End If
		    
		    Dim Cell As Segment = Target.SegmentAt(I)
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
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  
		  Try
		    If Win = Nil Or Win.Type = Window.Types.Sheet Then
		      Call Dialog.ShowModal()
		    Else
		      Dim FocusControl As RectControl = Win.Focus
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
		Function ShowConfirm(Extends Win As Window, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Return ShowConfirm(Win, Message, Explanation, ActionCaption, CancelCaption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowConfirm(Win As Window = Nil, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Try
		    Win = Win.TrueWindow
		  Catch Err As RuntimeException
		    Win = Nil
		  End Try
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  Dialog.ActionButton.Caption = ActionCaption
		  Dialog.CancelButton.Caption = CancelCaption
		  Dialog.CancelButton.Visible = True
		  
		  Try
		    If Win = Nil Or Win.Type = Window.Types.Sheet Then
		      Return Dialog.ShowModal() = Dialog.ActionButton
		    Else
		      Dim FocusControl As RectControl = Win.Focus
		      Win.Focus = Nil
		      Dim Result As Boolean = Dialog.ShowModalWithin(Win) = Dialog.ActionButton
		      Win.Focus = FocusControl
		      Return Result
		    End If
		  Catch Err As RuntimeException
		    Return Dialog.ShowModal() = Dialog.ActionButton
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WithColor(Extends Icon As Picture, FillColor As Color) As Picture
		  Return BeaconUI.IconWithColor(Icon, FillColor)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private DelegateClass As Ptr
	#tag EndProperty

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


	#tag Structure, Name = NSRect, Flags = &h21
		Left As CGFloat
		  Top As CGFloat
		  Width As CGFloat
		Height As CGFloat
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
