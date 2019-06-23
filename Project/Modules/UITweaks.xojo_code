#tag Module
Protected Module UITweaks
	#tag Method, Flags = &h0
		Sub ResizeForPlatform(Extends Target As Global.RectControl, IdealHeight As Integer)
		  Dim Diff As Integer = Max(IdealHeight - Target.Height, 0)
		  If Diff = 0 Then
		    Return
		  End If
		  
		  Dim TopOffset As Integer = Floor(Diff / 2)
		  Dim BottomOffset As Integer = Diff - TopOffset
		  
		  Target.Top = Target.Top - TopOffset
		  Target.Height = Target.Height + BottomOffset
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwapButtons(Extends Win As Window, PanelIndex As Integer = -1)
		  Dim DefaultButton As PushButton
		  Dim CancelButton As PushButton
		  Dim ControlCount As Integer = Win.ControlCount
		  For I As Integer = 0 To ControlCount - 1
		    Dim Ctl As Control = Win.Control(I)
		    Dim ControlPanelIndex As Integer = Ctl.PanelIndex
		    #if TargetWin32 And Target64Bit
		      // Bug <feedback://showreport?report_id=54283>
		      #if XojoVersion >= 2018.03 And XojoVersion < 2018.04
		        If ControlPanelIndex = 4294967295 Then
		          ControlPanelIndex = -1
		        End If
		      #else
		        #Pragma Error "Test PanelIndex again to make sure this code is still necessary"
		      #endif
		    #endif
		    If ControlPanelIndex <> PanelIndex Then
		      Continue
		    End If
		    If Ctl IsA PushButton Then
		      If PushButton(Ctl).Default And DefaultButton = Nil Then
		        DefaultButton = PushButton(Ctl)
		      ElseIf PushButton(Ctl).Cancel And CancelButton = Nil Then
		        CancelButton = PushButton(Ctl)
		      End If
		    ElseIf Ctl IsA PagePanel Then
		      Dim PanelCount As Integer = PagePanel(Ctl).PanelCount
		      For Idx As Integer = 0 To PanelCount - 1
		        Win.SwapButtons(Idx)
		      Next
		    End If
		  Next
		  If DefaultButton = Nil Or CancelButton = Nil Then
		    Return
		  End If
		  
		  Dim LeftButton As PushButton = if(DefaultButton.Left < CancelButton.Left, DefaultButton, CancelButton)
		  Dim RightButton As PushButton = if(DefaultButton.Left < CancelButton.Left, CancelButton, DefaultButton)
		  Dim LeftRect As New Xojo.Core.Rect(LeftButton.Left, LeftButton.Top, LeftButton.Width, LeftButton.Height)
		  Dim RightRect As New Xojo.Core.Rect(RightButton.Left, RightButton.Top, RightButton.Width, RightButton.Height)
		  
		  #if TargetWindows
		    DefaultButton.Left = LeftRect.Left
		    DefaultButton.Top = LeftRect.Top
		    DefaultButton.Width = LeftRect.Width
		    DefaultButton.Height = LeftRect.Height
		    CancelButton.Left = RightRect.Left
		    CancelButton.Top = RightRect.Top
		    CancelButton.Width = RightRect.Width
		    CancelButton.Height = RightRect.Height
		  #else
		    DefaultButton.Left = RightRect.Left
		    DefaultButton.Top = RightRect.Top
		    DefaultButton.Width = RightRect.Width
		    DefaultButton.Height = RightRect.Height
		    CancelButton.Left = LeftRect.Left
		    CancelButton.Top = LeftRect.Top
		    CancelButton.Width = LeftRect.Width
		    CancelButton.Height = LeftRect.Height
		  #endif
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
