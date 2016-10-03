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


	#tag Constant, Name = IdealHeight, Type = Double, Dynamic = False, Default = \"20", Scope = Private
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"23"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"30"
	#tag EndConstant


End Module
#tag EndModule
