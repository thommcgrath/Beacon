#tag Class
Protected Class ColorProfile
	#tag Method, Flags = &h0
		Function BackgroundColor() As Color
		  Return Self.mStandardBackgroundColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function BlendColors(Color1 As Color, Color2 As Color, Color2Percent As Double) As Color
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
		Function BlendWithProfile(OtherProfile As BeaconUI.ColorProfile, OtherPercent As Double) As BeaconUI.ColorProfile
		  Dim Blended As New BeaconUI.ColorProfile
		  Blended.mBorderColor = Self.BlendColors(Self.mBorderColor, OtherProfile.mBorderColor, OtherPercent)
		  Blended.mSelectedBackgroundColor = Self.BlendColors(Self.mSelectedBackgroundColor, OtherProfile.mSelectedBackgroundColor, OtherPercent)
		  Blended.mSelectedForegroundColor = Self.BlendColors(Self.mSelectedForegroundColor, OtherProfile.mSelectedForegroundColor, OtherPercent)
		  Blended.mSelectedShadowColor = Self.BlendColors(Self.mSelectedShadowColor, OtherProfile.mSelectedShadowColor, OtherPercent)
		  Blended.mStandardBackgroundColor = Self.BlendColors(Self.mStandardBackgroundColor, OtherProfile.mStandardBackgroundColor, OtherPercent)
		  Blended.mStandardForegroundColor = Self.BlendColors(Self.mStandardForegroundColor, OtherProfile.mStandardForegroundColor, OtherPercent)
		  Blended.mStandardShadowColor = Self.BlendColors(Self.mStandardShadowColor, OtherProfile.mStandardShadowColor, OtherPercent)
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
		  
		  Self.mStandardBackgroundColor = &cF7F7F7
		  Self.mStandardForegroundColor = &c4C4C4C
		  Self.mStandardShadowColor = &cFFFFFF
		  Self.mSelectedForegroundColor = PrimaryColor
		  
		  Dim ForegroundLuminance As Double = PrimaryColor.Luminance
		  Dim DesiredGray As Double = 0.87
		  
		  Dim Contrast As Double
		  If ForegroundLuminance > DesiredGray Then
		    Contrast = (ForegroundLuminance + 0.05) / (DesiredGray + 0.05)
		  Else
		    Contrast = (DesiredGray + 0.05) / (ForegroundLuminance + 0.05)
		  End If
		  
		  Dim SelectedGray As Double
		  If Contrast >= TargetContrast Then
		    SelectedGray = DesiredGray
		  Else
		    Dim Grays(), Differences() As Double
		    For I As Integer = 0 To 100
		      Dim TestGray As Double = I / 100
		      If ForegroundLuminance > TestGray Then
		        Contrast = (ForegroundLuminance + 0.05) / (TestGray + 0.05)
		      Else
		        Contrast = (TestGray + 0.05) / (ForegroundLuminance + 0.05)
		      End If
		      
		      If Contrast < TargetContrast Then
		        Continue
		      End If
		      
		      Dim Difference As Double = Xojo.Math.Abs(TestGray - DesiredGray)
		      Grays.Append(TestGray)
		      Differences.Append(Difference)
		    Next
		    
		    If Grays.Ubound = -1 Then
		      // Give up
		      SelectedGray = DesiredGray
		    Else
		      Differences.SortWith(Grays)
		      SelectedGray = Grays(0)
		    End If
		  End If
		  
		  Dim LuminanceDifference As Double = ForegroundLuminance - SelectedGray
		  Self.mSelectedBackgroundColor = HSV(0, 0, SelectedGray)
		  Self.mSelectedShadowColor = If(LuminanceDifference <= 0, &cFFFFFF, &C00000080)
		  
		  Self.mBorderColor = HSV(0, 0, Min(Max(SelectedGray * 0.80, 0.00), 0.65))
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
		  
		  Dim SelfLuminance As Double = Self.mSelectedForegroundColor.Luminance
		  Dim OtherLuminance As Double = Other.mSelectedForegroundColor.Luminance
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
End Class
#tag EndClass
