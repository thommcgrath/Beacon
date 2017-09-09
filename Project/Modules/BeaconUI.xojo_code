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
		Function Piece(Extends Source As Picture, Left As Integer, Top As Integer, Width As Integer, Height As Integer) As Picture
		  Dim Pic As New Picture(Width, Height)
		  Pic.Graphics.DrawPicture(Source, 0, 0, Width, Height, Left, Top, Width, Height)
		  Return Pic
		End Function
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
