#tag Class
Protected Class OmniBarColorProfile
	#tag Method, Flags = &h0
		Sub Constructor(BackgroundColor As OmniBar.BackgroundColors)
		  Self.SeparatorColor = SystemColors.SeparatorColor
		  
		  If BackgroundColor = OmniBar.BackgroundColors.Natural Then
		    Var EstimatedBackground As Color = SystemColors.WindowBackgroundColor
		    
		    Self.FillColor = &cFFFFFFFF
		    Self.AccentColor = SystemColors.SelectedContentBackgroundColor
		    
		    Self.Blue = SystemColors.SystemBlueColor
		    Self.Brown = SystemColors.SystemBrownColor
		    Self.Gray = SystemColors.SystemGrayColor
		    Self.Green = SystemColors.SystemGreenColor
		    Self.Orange = SystemColors.SystemOrangeColor
		    Self.Pink = SystemColors.SystemPinkColor
		    Self.Purple = SystemColors.SystemPurpleColor
		    Self.Red = SystemColors.SystemRedColor
		    Self.Yellow = SystemColors.SystemYellowColor
		    
		    Self.AccentedText = BeaconUI.FindContrastingColor(EstimatedBackground, SystemColors.ControlAccentColor)
		    Self.BlueText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Blue)
		    Self.BrownText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Brown)
		    Self.GrayText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Gray)
		    Self.GreenText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Green)
		    Self.OrangeText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Orange)
		    Self.PinkText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Pink)
		    Self.PurpleText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Purple)
		    Self.RedText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Red)
		    Self.YellowText = BeaconUI.FindContrastingColor(EstimatedBackground, Self.Yellow)
		    
		    Self.TextColor = SystemColors.ControlTextColor
		    Self.DisabledTextColor = SystemColors.DisabledControlTextColor
		    Self.TextShadowColor = Self.ShadowColor(Self.TextColor)
		    
		    Self.ToggledButtonIconColor = SystemColors.AlternateSelectedControlTextColor
		    Self.ToggledButtonShadowColor = Self.ShadowColor(Self.ToggledButtonIconColor)
		    Self.ToggledButtonInactiveColor = SystemColors.QuaternaryLabelColor
		    
		    Self.AccessoryColor = SystemColors.TertiaryLabelColor
		  Else
		    Select Case BackgroundColor
		    Case OmniBar.BackgroundColors.Blue
		      Self.FillColor = &c2861d9
		    Case OmniBar.BackgroundColors.Gray
		      Self.FillColor = &c807f80
		    Case OmniBar.BackgroundColors.Green
		      Self.FillColor = &c629e41
		    Case OmniBar.BackgroundColors.Orange
		      Self.FillColor = &ccb702c
		    Case OmniBar.BackgroundColors.Pink
		      Self.FillColor = &cc84884
		    Case OmniBar.BackgroundColors.Purple
		      Self.FillColor = &c713a9a
		    Case OmniBar.BackgroundColors.Red
		      Self.FillColor = &cB33531
		    Case OmniBar.BackgroundColors.Yellow
		      Self.FillColor = &cd9ad3f
		    End Select
		    
		    Self.AccentColor = &cFFFFFF
		    Self.Blue = &cFFFFFF
		    Self.Brown = &cFFFFFF
		    Self.Gray = &cFFFFFF
		    Self.Green = &cFFFFFF
		    Self.Orange = &cFFFFFF
		    Self.Pink = &cFFFFFF
		    Self.Purple = &cFFFFFF
		    Self.Red = &cFFFFFF
		    Self.Yellow = &cFFFFFF
		    
		    Self.AccentedText = &cFFFFFF
		    Self.BlueText = &cFFFFFF
		    Self.BrownText = &cFFFFFF
		    Self.GrayText = &cFFFFFF
		    Self.GreenText = &cFFFFFF
		    Self.OrangeText = &cFFFFFF
		    Self.PinkText = &cFFFFFF
		    Self.PurpleText = &cFFFFFF
		    Self.RedText = &cFFFFFF
		    Self.YellowText = &cFFFFFF
		    
		    Self.TextColor = &cFFFFFF
		    Self.DisabledTextColor = &cFFFFFF80
		    Self.TextShadowColor = &c000000A0
		    
		    Self.ToggledButtonIconColor = Self.FillColor
		    Self.ToggledButtonShadowColor = &cFFFFFFFF
		    Self.ToggledButtonInactiveColor = &cFFFFFF80
		    
		    Self.AccessoryColor = &cFFFFFFAA
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShadowColor(ForegroundColor As Color) As Color
		  If ForegroundColor.IsBright Then
		    Return &c000000C0
		  Else
		    Return &cFFFFFF
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		AccentColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		AccentedText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		AccessoryColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Blue As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		BlueText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Brown As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		BrownText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		DisabledTextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		FillColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Gray As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		GrayText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Green As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		GreenText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Orange As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		OrangeText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Pink As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		PinkText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Purple As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		PurpleText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Red As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		RedText As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		SeparatorColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		TextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		TextShadowColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ToggledButtonIconColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ToggledButtonInactiveColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ToggledButtonShadowColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Yellow As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		YellowText As Color
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
		#tag ViewProperty
			Name="AccentedText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SeparatorColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Purple"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Blue"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Gray"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Green"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Orange"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Pink"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Red"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Yellow"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Brown"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToggledButtonIconColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToggledButtonShadowColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextShadowColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToggledButtonInactiveColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AccentColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AccessoryColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BlueText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BrownText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GrayText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GreenText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OrangeText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PinkText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PurpleText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RedText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="YellowText"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
