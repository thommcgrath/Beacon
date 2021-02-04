#tag Class
Protected Class OmniBarColorProfile
	#tag Method, Flags = &h0
		Sub Constructor()
		  Var BackgroundColor As Color = SystemColors.WindowBackgroundColor
		  
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
		  
		  Self.AccentedText = BeaconUI.FindContrastingColor(BackgroundColor, SystemColors.ControlAccentColor)
		  Self.BlueText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Blue)
		  Self.BrownText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Brown)
		  Self.GrayText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Gray)
		  Self.GreenText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Green)
		  Self.OrangeText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Orange)
		  Self.PinkText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Pink)
		  Self.PurpleText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Purple)
		  Self.RedText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Red)
		  Self.YellowText = BeaconUI.FindContrastingColor(BackgroundColor, Self.Yellow)
		  
		  Self.SeparatorColor = SystemColors.SeparatorColor
		  
		  Self.TextColor = SystemColors.ControlTextColor
		  Self.DisabledTextColor = SystemColors.DisabledControlTextColor
		  Self.TextShadowColor = Self.ShadowColor(Self.TextColor)
		  
		  Self.ToggledButtonIconColor = SystemColors.AlternateSelectedControlTextColor
		  Self.ToggledButtonShadowColor = Self.ShadowColor(Self.ToggledButtonIconColor)
		  Self.ToggledButtonInactiveColor = SystemColors.QuaternaryLabelColor
		  
		  Self.AccessoryColor = SystemColors.TertiaryLabelColor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShadowColor(ForegroundColor As Color) As Color
		  If ForegroundColor.IsBright Then
		    Return &c000000C0
		  Else
		    Return &cFFFFFF40
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
