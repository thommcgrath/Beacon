#tag Module
Protected Module BeaconUI
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
