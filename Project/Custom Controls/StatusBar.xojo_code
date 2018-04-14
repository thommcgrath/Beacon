#tag Class
Protected Class StatusBar
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Not Self.mClickable Then
		    Return True
		  End If
		  
		  Self.mDrawPressed = True
		  Self.Invalidate
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Not Self.mClickable Then
		    Return
		  End If
		  
		  Dim Pressed As Boolean = X >= 0 And X <= Self.Width And Y >= 0 And Y <= Self.Height
		  If Self.mDrawPressed <> Pressed Then
		    Self.mDrawPressed = Pressed
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Not Self.mClickable Then
		    Return
		  End If
		  
		  Dim Pressed As Boolean = X >= 0 And X <= Self.Width And Y >= 0 And Y <= Self.Height
		  If Pressed Then
		    RaiseEvent Action
		  End If
		  If Self.mDrawPressed <> False Then
		    Self.mDrawPressed = False
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.ForeColor = Self.ColorProfile.BorderColor
		  G.FillRect(0, 0, G.Width, G.Height)
		  
		  Dim ContentLeft As Integer = 0
		  Dim ContentTop As Integer = 0
		  Dim ContentRight As Integer = G.Width
		  Dim ContentBottom As Integer = G.Height
		  
		  If (Self.mBorders And BeaconUI.BorderTop) = BeaconUI.BorderTop Then
		    ContentTop = ContentTop + 1
		  End If
		  If (Self.mBorders And BeaconUI.BorderLeft) = BeaconUI.BorderLeft Then
		    ContentLeft = ContentLeft + 1
		  End If
		  If (Self.mBorders And BeaconUI.BorderBottom) = BeaconUI.BorderBottom Then
		    ContentBottom = ContentBottom - 1
		  End If
		  If (Self.mBorders And BeaconUI.BorderRight) = BeaconUI.BorderRight Then
		    ContentRight = ContentRight - 1
		  End If
		  
		  Dim BackgroundColor As Color = Self.ColorProfile.BackgroundColor
		  Dim ForegroundColor As Color = Self.ColorProfile.ForegroundColor
		  Dim ShadowColor As Color = Self.ColorProfile.ShadowColor
		  
		  If Self.mDrawPressed Then
		    BackgroundColor = BackgroundColor.Darker(0.5)
		    ForegroundColor = ForegroundColor.Darker(0.5)
		    ShadowColor = ShadowColor.Darker(0.5)
		  End If
		  
		  Dim Clip As Graphics = G.Clip(ContentLeft, ContentTop, ContentRight - ContentLeft, ContentBottom - ContentTop)
		  Clip.ForeColor = BackgroundColor
		  Clip.FillRect(0, 0, Clip.Width, Clip.Height)
		  
		  Clip.TextFont = "SmallSystem"
		  Clip.TextSize = 0
		  
		  Dim CaptionLeft As Integer = 4
		  Dim CaptionSpace As Integer = Clip.Width - (CaptionLeft * 2)
		  If Self.Clickable Then
		    CaptionSpace = CaptionSpace - (IconEdit.Width + CaptionLeft)
		  End If
		  Dim CaptionBottom As Integer = Round((Clip.Height / 2) + (Clip.CapHeight / 2))
		  
		  Clip.ForeColor = ShadowColor
		  Clip.DrawString(Self.mCaption, CaptionLeft, CaptionBottom + 1, CaptionSpace, True)
		  Clip.ForeColor = ForegroundColor
		  Clip.DrawString(Self.mCaption, CaptionLeft, CaptionBottom, CaptionSpace, True)
		  
		  If Self.Clickable Then
		    Dim ForeIcon As Picture = BeaconUI.IconWithColor(IconEdit, ForegroundColor)
		    Dim ShadowIcon As Picture = BeaconUI.IconWithColor(IconEdit, ShadowColor)
		    Dim IconLeft As Integer = Clip.Width - (CaptionLeft + ForeIcon.Width)
		    Dim IconTop As Integer = (Clip.Height - ForeIcon.Height) / 2
		    
		    Clip.DrawPicture(ShadowIcon, IconLeft, IconTop + 1)
		    Clip.DrawPicture(ForeIcon, IconLeft, IconTop)
		  End If
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Action()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBorders
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Mask As Integer = BeaconUI.BorderBottom Or BeaconUI.BorderLeft Or BeaconUI.BorderRight Or BeaconUI.BorderTop
			  Value = Value And Mask
			  If Self.mBorders <> Value Then
			    Self.mBorders = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Borders As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If StrComp(Self.mCaption, Value, 0) <> 0 Then
			    Self.mCaption = Value
			    Self.HelpTag = Self.mCaption
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mClickable
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mClickable <> Value Then
			    Self.mClickable = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Clickable As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBorders As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClickable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDrawPressed As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Borders"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Clickable"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="21"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
