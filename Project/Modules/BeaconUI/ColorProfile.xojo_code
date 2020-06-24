#tag Class
Protected Class ColorProfile
	#tag Method, Flags = &h0
		Function AlternateRowColor() As Color
		  Return Self.mAlternateRowColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackgroundColor() As Color
		  #if BeaconUI.ToolbarHasBackground
		    Return Self.mStandardBackgroundColor
		  #else
		    #if TargetMacOS
		      Return &cECECEC
		    #else
		      Return FillColor
		    #endif
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlendWithProfile(OtherProfile As BeaconUI.ColorProfile, OtherPercent As Double) As BeaconUI.ColorProfile
		  Var Blended As New BeaconUI.ColorProfile
		  Blended.mBorderColor = Self.mBorderColor.BlendWith(OtherProfile.mBorderColor, OtherPercent)
		  Blended.mSelectedBackgroundColor = Self.mSelectedBackgroundColor.BlendWith(OtherProfile.mSelectedBackgroundColor, OtherPercent)
		  Blended.mSelectedForegroundColor = Self.mSelectedForegroundColor.BlendWith(OtherProfile.mSelectedForegroundColor, OtherPercent)
		  Blended.mSelectedShadowColor = Self.mSelectedShadowColor.BlendWith(OtherProfile.mSelectedShadowColor, OtherPercent)
		  Blended.mStandardBackgroundColor = Self.mStandardBackgroundColor.BlendWith(OtherProfile.mStandardBackgroundColor, OtherPercent)
		  Blended.mStandardForegroundColor = Self.mStandardForegroundColor.BlendWith(OtherProfile.mStandardForegroundColor, OtherPercent)
		  Blended.mStandardShadowColor = Self.mStandardShadowColor.BlendWith(OtherProfile.mStandardShadowColor, OtherPercent)
		  Return Blended
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BorderColor() As Color
		  Return Self.mBorderColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(PrimaryColor As Color)
		  Self.Constructor()
		  
		  Self.mSelectedForegroundColor = PrimaryColor
		  
		  Var ForegroundLuminance As Double = PrimaryColor.Luminance
		  Var DesiredGray As Double = 0.87
		  
		  Var Contrast As Double
		  If ForegroundLuminance > DesiredGray Then
		    Contrast = (ForegroundLuminance + 0.05) / (DesiredGray + 0.05)
		  Else
		    Contrast = (DesiredGray + 0.05) / (ForegroundLuminance + 0.05)
		  End If
		  
		  Var SelectedGray As Double
		  If Contrast >= TargetContrast Then
		    SelectedGray = DesiredGray
		  Else
		    Var Grays(), Differences() As Double
		    For I As Integer = 0 To 100
		      Var TestGray As Double = I / 100
		      If ForegroundLuminance > TestGray Then
		        Contrast = (ForegroundLuminance + 0.05) / (TestGray + 0.05)
		      Else
		        Contrast = (TestGray + 0.05) / (ForegroundLuminance + 0.05)
		      End If
		      
		      If Contrast < TargetContrast Then
		        Continue
		      End If
		      
		      Var Difference As Double = Abs(TestGray - DesiredGray)
		      Grays.AddRow(TestGray)
		      Differences.AddRow(Difference)
		    Next
		    
		    If Grays.LastRowIndex = -1 Then
		      // Give up
		      SelectedGray = DesiredGray
		    Else
		      Differences.SortWith(Grays)
		      SelectedGray = Grays(0)
		    End If
		  End If
		  
		  Var LuminanceDifference As Double = ForegroundLuminance - SelectedGray
		  Self.mSelectedBackgroundColor = HSV(0, 0, SelectedGray)
		  Self.mSelectedShadowColor = If(LuminanceDifference <= 0, &cFFFFFF, &C00000080)
		  
		  Self.mBorderColor = HSV(0, 0, Min(Max(SelectedGray * 0.80, 0.00), 0.65))
		  Self.mStandardBackgroundColor = HSV(0, 0, Min(SelectedGray * 1.3, 0.968))
		  If Self.mStandardBackgroundColor.Luminance > 0.55 Then
		    Self.mStandardForegroundColor = &c4C4C4C
		    Self.mStandardShadowColor = &cFFFFFF
		  Else
		    Self.mStandardForegroundColor = &cFFFFFF
		    Self.mStandardShadowColor = &c00000080
		  End If
		  
		  Self.mAlternateRowColor = PrimaryColor.BlendWith(&cFFFFFF, 0.98)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ForegroundColor() As Color
		  Return Self.mStandardForegroundColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As BeaconUI.ColorProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  // Only equal if all colors match
		  If Self.mBorderColor = Other.mBorderColor And Self.mSelectedBackgroundColor = Other.mSelectedBackgroundColor And Self.mSelectedForegroundColor = Other.mSelectedForegroundColor And Self.mSelectedShadowColor = Other.mSelectedShadowColor And Self.mStandardBackgroundColor = Other.mStandardBackgroundColor And Self.mStandardForegroundColor = Other.mStandardForegroundColor And Self.mStandardShadowColor = Other.mStandardShadowColor Then
		    Return 0
		  End If
		  
		  Var SelfLuminance As Double = Self.mSelectedForegroundColor.Luminance
		  Var OtherLuminance As Double = Other.mSelectedForegroundColor.Luminance
		  If SelfLuminance >= OtherLuminance Then
		    // They cannot be considered equal
		    Return 1
		  Else
		    Return -1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrimaryColor() As Color
		  Return Self.mSelectedForegroundColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedBackgroundColor() As Color
		  Return Self.mSelectedBackgroundColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedForegroundColor() As Color
		  Return Self.mSelectedForegroundColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedShadowColor() As Color
		  Return Self.mSelectedShadowColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShadowColor() As Color
		  Return Self.mStandardShadowColor
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAlternateRowColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBorderColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedForegroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedShadowColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStandardBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStandardForegroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStandardShadowColor As Color
	#tag EndProperty


	#tag Constant, Name = TargetContrast, Type = Double, Dynamic = False, Default = \"2.2", Scope = Private
	#tag EndConstant


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
End Class
#tag EndClass
