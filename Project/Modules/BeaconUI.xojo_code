#tag Module
Protected Module BeaconUI
	#tag Method, Flags = &h1
		Protected Function BackgroundColorForInvalidRow(InitialColor As Color, Highlighted As Boolean, Selected As Boolean) As Color
		  If Selected Then
		    If Highlighted Then
		      Return &c800000
		    Else
		      Return &cD4BEBE
		    End If
		  Else
		    Return InitialColor
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CapHeight(Extends G As Graphics) As Double
		  #if TargetCocoa
		    Declare Function objc_getClass Lib "Cocoa.framework" (ClassName As CString) As Ptr
		    Dim NSFont As Ptr = objc_getClass("NSFont")
		    If NSFont = Nil Then
		      #if DebugBuild
		        System.DebugLog("Unable to get class reference to NSFont.")
		      #endif
		      Return G.TextAscent * 0.8
		    End If
		    
		    Dim FontObject As Ptr
		    If G.TextFont = "SmallSystem" And G.TextSize = 0 Then
		      If G.Bold Then
		        #if Target64Bit
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "boldSystemFontOfSize:" (Target As Ptr, Size As Double) As Ptr
		        #else
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "boldSystemFontOfSize:" (Target As Ptr, Size As Single) As Ptr
		        #endif
		        FontObject = SystemFontOfSize(NSFont,11)
		      Else
		        #if Target64Bit
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As Double) As Ptr
		        #else
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As Single) As Ptr
		        #endif
		        FontObject = SystemFontOfSize(NSFont,11)
		      End If
		    ElseIf G.TextFont = "System" Or G.TextFont = "SmallSystem" Then
		      If G.Bold Then
		        #if Target64Bit
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "boldSystemFontOfSize:" (Target As Ptr, Size As Double) As Ptr
		        #else
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "boldSystemFontOfSize:" (Target As Ptr, Size As Single) As Ptr
		        #endif
		        FontObject = SystemFontOfSize(NSFont,G.TextSize)
		      Else
		        #if Target64Bit
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As Double) As Ptr
		        #else
		          Declare Function SystemFontOfSize Lib "Cocoa.framework" Selector "systemFontOfSize:" (Target As Ptr, Size As Single) As Ptr
		        #endif
		        FontObject = SystemFontOfSize(NSFont,G.TextSize)
		      End If
		    Else
		      #if Target64Bit
		        Declare Function FontWithName Lib "Cocoa.framework" Selector "fontWithName:size:" (Target As Ptr, FontName As CFStringRef, Size As Double) As Ptr
		      #else
		        Declare Function FontWithName Lib "Cocoa.framework" Selector "fontWithName:size:" (Target As Ptr, FontName As CFStringRef, Size As Single) As Ptr
		      #endif
		      FontObject = FontWithName(NSFont,G.TextFont,G.TextSize)
		    End If
		    
		    If FontObject = Nil Then
		      #if DebugBuild
		        System.DebugLog("Unable to get font object.")
		      #endif
		      Return G.TextAscent * 0.8
		    End If
		    
		    #if Target64Bit
		      Declare Function GetCapHeight Lib "Cocoa.framework" Selector "capHeight" (Target As Ptr) As Double
		    #else
		      Declare Function GetCapHeight Lib "Cocoa.framework" Selector "capHeight" (Target As Ptr) As Single
		    #endif
		    Return GetCapHeight(FontObject)
		  #elseif TargetWin32
		    Return G.TextAscent * 0.75
		  #elseif TargetCarbon
		    Return G.TextAscent * 0.80
		  #else
		    Return G.TextAscent
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContrastWith(Extends Color1 As Color, Color2 As Color) As Double
		  Dim C1R As Double = (Color1.Red / 255) ^ 2.2
		  Dim C1G As Double = (Color1.Green / 255) ^ 2.2
		  Dim C1B As Double = (Color1.Blue / 255) ^ 2.2
		  
		  Dim C2R As Double = (Color2.Red / 255) ^ 2.2
		  Dim C2G As Double = (Color2.Green / 255) ^ 2.2
		  Dim C2B As Double = (Color2.Blue / 255) ^ 2.2
		  
		  Dim C1Y As Double = (0.2126 * C1R) + (0.7151 * C1G) + (0.0721 * C1B)
		  Dim C2Y As Double = (0.2126 * C2R) + (0.7151 * C2G) + (0.0721 * C2B)
		  
		  If C1Y > C2Y Then
		    Return (C1Y + 0.05) / (C2Y + 0.05)
		  ElseIf C2Y > C1Y Then
		    Return (C2Y + 0.05) / (C1Y + 0.05)
		  Else
		    Return 1
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
		    
		    Panel.TextUnit = FontUnits.Point
		    Panel.TextFont = "System"
		    Panel.TextSize = GetPointSize(FontObject)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IconWithColor(Icon As Picture, FillColor As Color) As Picture
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
		    Pic.Mask.Graphics.ForeColor = RGB(255, 255, 255, 255 - FillColor.Alpha)
		    Pic.Mask.Graphics.FillRect(0, 0, Pic.Width, Pic.Height)
		    
		    Bitmaps.Append(Pic)
		  Next
		  Return New Picture(Width, Height, Bitmaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBright(Extends Source As Color) As Boolean
		  Return Source.Luminosity > 128
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Luminosity(Extends Source As Color) As Integer
		  If Source.Red = Source.Green And Source.Green = Source.Blue Then
		    Return Source.Red
		  End If
		  
		  Dim RedValue As Double = 0.299 * (Source.Red ^ 2)
		  Dim GreenValue As Double = 0.587 * (Source.Green ^ 2)
		  Dim BlueValue As Double = 0.114 * (Source.Blue ^ 2)
		  
		  Return Xojo.Math.Sqrt(RedValue + GreenValue + BlueValue)
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
		Protected Function PrimaryColor() As Color
		  If App.Identity <> Nil And App.Identity.IsPatreonSupporter Then
		    Return App.Preferences.ColorValue("UI Color", DefaultPrimaryColor)
		  Else
		    Return DefaultPrimaryColor
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PrimaryColor(Assigns Value As Color)
		  Dim CurrentColor As Color = PrimaryColor()
		  App.Preferences.ColorValue("UI Color") = Value
		  If CurrentColor <> Value Then
		    NotificationKit.Post(PrimaryColorNotification, Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecallPosition(Extends Win As Window, Key As Text)
		  Dim Rect As Xojo.Core.Rect = App.Preferences.RectValue(Key, Nil)
		  If Rect = Nil Then
		    // That's ok
		    Return
		  End If
		  
		  Dim Bounds As New REALbasic.Rect(Rect.Left, Rect.Top, Rect.Width, Rect.Height)
		  Dim ScreenCount As Integer = ScreenCount
		  Dim MaxArea As Integer
		  Dim TargetRect As REALbasic.Rect
		  For I As Integer = 0 To ScreenCount - 1
		    Dim ScreenRect As New REALbasic.Rect(Screen(I).AvailableLeft, Screen(I).AvailableTop, Screen(I).AvailableWidth, Screen(I).AvailableHeight)
		    Dim Overlap As REALbasic.Rect = ScreenRect.Intersection(Bounds)
		    If Overlap = Nil Then
		      Continue
		    End If
		    Dim Area As Integer = Overlap.Width * Overlap.Height
		    If Area > MaxArea Then
		      MaxArea = Area
		      TargetRect = ScreenRect
		    End If
		  Next
		  If TargetRect = Nil Then
		    // Also ok
		    Return
		  End If
		  
		  Bounds.Width = Max(Min(Bounds.Width, TargetRect.Width), Win.MinWidth)
		  Bounds.Height = Max(Min(Bounds.Height, TargetRect.Height), Win.MinHeight)
		  Bounds.Left = Min(Bounds.Left, TargetRect.Right - Bounds.Width)
		  Bounds.Top = Min(Bounds.Top, TargetRect.Bottom - Bounds.Height)
		  
		  Win.Bounds = Bounds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePosition(Extends Win As Window, Key As Text)
		  Dim Rect As REALbasic.Rect = Win.Bounds
		  
		  App.Preferences.RectValue(Key) = New Xojo.Core.Rect(Rect.Left, Rect.Top, Rect.Width, Rect.Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShadowColor(Extends Source As Color) As Color
		  If Source.IsBright Then
		    Return &c00000080
		  Else
		    Return &cFFFFFF
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowAlert(Extends Win As Window, Message As String, Explanation As String)
		  Win = Win.TrueWindow
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  
		  If Win.Frame = Window.FrameTypeSheet Then
		    Call Dialog.ShowModal()
		  Else
		    Call Dialog.ShowModalWithin(Win.TrueWindow)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShowAlert(Message As String, Explanation As String)
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  Call Dialog.ShowModal()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowConfirm(Extends Win As Window, Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Win = Win.TrueWindow
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  Dialog.ActionButton.Caption = ActionCaption
		  Dialog.CancelButton.Caption = CancelCaption
		  Dialog.CancelButton.Visible = True
		  
		  If Win.Frame = Window.FrameTypeSheet Then
		    Return Dialog.ShowModal() = Dialog.ActionButton
		  Else
		    Return Dialog.ShowModalWithin(Win.TrueWindow) = Dialog.ActionButton
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShowConfirm(Message As String, Explanation As String, ActionCaption As String, CancelCaption As String) As Boolean
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  Dialog.ActionButton.Caption = ActionCaption
		  Dialog.CancelButton.Caption = CancelCaption
		  Dialog.CancelButton.Visible = True
		  Return Dialog.ShowModal() = Dialog.ActionButton
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextColorForInvalidRow(Highlighted As Boolean, Selected As Boolean) As Color
		  If Selected Then
		    If Highlighted Then
		      Return &cFFFFFF
		    Else
		      Return &c000000
		    End If
		  Else
		    Return &c800000
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WithColor(Extends Icon As Picture, FillColor As Color) As Picture
		  Return BeaconUI.IconWithColor(Icon, FillColor)
		End Function
	#tag EndMethod


	#tag Constant, Name = BorderColor, Type = Color, Dynamic = False, Default = \"&cA6A6A6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ColorChangeDuration, Type = Double, Dynamic = False, Default = \"2.0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DefaultPrimaryColor, Type = Color, Dynamic = False, Default = \"&cA64DCF", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PrimaryColorNotification, Type = Text, Dynamic = False, Default = \"UI Color Changed", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
