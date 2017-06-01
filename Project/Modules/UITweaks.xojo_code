#tag Module
Protected Module UITweaks
	#tag Method, Flags = &h0
		Sub ResizeForPlatform(Extends Target As Global.RectControl)
		  Dim Diff As Integer = Max(UITweaks.IdealHeight - Target.Height, 0)
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
		Sub ShowAlert(Extends Win As Window, Message As String, Explanation As String)
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = Message
		  Dialog.Explanation = Explanation
		  Call Dialog.ShowModalWithin(Win.TrueWindow)
		End Sub
	#tag EndMethod


	#tag Constant, Name = IdealHeight, Type = Double, Dynamic = False, Default = \"20", Scope = Private
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"23"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"30"
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
