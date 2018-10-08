#tag Class
Protected Class HelpDrawer
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Self.mButtonRect <> Nil Then
		    Self.mPressed = Self.mButtonRect.Contains(X, Y)
		    Self.Invalidate
		  End If
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Dim Pressed As Boolean = Self.mButtonRect <> Nil And Self.mButtonRect.Contains(X, Y)
		  If Self.mPressed = True And Pressed = False Then
		    Self.mPressed = False
		    Self.Invalidate
		  ElseIf Self.mPressed = False And Pressed = True Then
		    Self.mPressed = True
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mButtonRect <> Nil And Self.mButtonRect.Contains(X, Y) Then
		    ShowURL(Self.mDetailURL)
		    Self.mPressed = False
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(MouseX As Integer, MouseY As Integer, PixelsX As Integer, PixelsY As Integer, WheelData As BeaconUI.ScrollEvent) As Boolean
		  #Pragma Unused MouseX
		  #Pragma Unused MouseY
		  #Pragma Unused PixelsX
		  #Pragma Unused WheelData
		  
		  If PixelsY <> 0 Then
		    Self.mScrollPosition = Self.mScrollPosition + PixelsY
		    Self.Invalidate
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Const ButtonHeight = 30
		  
		  Dim InsetTop, InsetRight, InsetBottom, InsetLeft As Double
		  If (Self.mBorders And Self.BorderTop) = Self.BorderTop Then
		    InsetTop = 1
		  End If
		  If (Self.mBorders And Self.BorderRight) = Self.BorderRight Then
		    InsetRight = 1
		  End If
		  If (Self.mBorders And Self.BorderBottom) = Self.BorderBottom Then
		    InsetBottom = 1
		  End If
		  If (Self.mBorders And Self.BorderLeft) = Self.BorderLeft Then
		    InsetLeft = 1
		  End If
		  
		  G.ForeColor = SystemColors.SeparatorColor
		  G.FillRect(0, 0, G.Width, InsetTop)
		  G.FillRect(0, G.Height - InsetBottom, G.Width, InsetBottom)
		  G.FillRect(0, InsetTop, InsetLeft, G.Height - (InsetTop + InsetBottom))
		  G.FillRect(G.Width - InsetRight, InsetTop, InsetRight, G.Height - (InsetTop + InsetBottom))
		  
		  Dim Clip As Graphics = G.Clip(InsetLeft, InsetTop, G.Width - (InsetLeft + InsetRight), G.Height - (InsetTop + InsetBottom))
		  #if false
		    Clip.ForeColor = SystemColors.UnderPageBackgroundColor
		    Clip.FillRect(0, 0, Clip.Width, Clip.Height)
		    Clip.ForeColor = SystemColors.ControlBackgroundColor
		    Clip.FillRect(0, 0, Clip.Width, Clip.Height)
		  #endif
		  
		  Clip.TextFont = "System"
		  Clip.TextSize = 0
		  Clip.Bold = True
		  
		  Dim ViewportWidth As Double = Clip.Width - 40
		  
		  Dim BodyHeight As Double = Clip.StringHeight(Self.mBody, ViewportWidth)
		  Dim ContentHeight As Double = Clip.CapHeight + 20 + BodyHeight
		  If Self.mDetailURL <> "" Then
		    ContentHeight = ContentHeight + ButtonHeight + 20
		  End If
		  
		  Dim ViewportHeight As Double = Clip.Height - 40
		  Self.mContentOverflow = Max(ContentHeight - ViewportHeight, 0)
		  Self.mScrollPosition = Max(Min(Self.mScrollPosition, Self.mContentOverflow), 0)
		  
		  Dim TitleBaseline As Double = (20 + Clip.CapHeight) - Self.mScrollPosition
		  Clip.ForeColor = SystemColors.LabelColor
		  Clip.Bold = False
		  Clip.DrawString(Self.mBody, 20, TitleBaseline + 20 + Clip.CapHeight, ViewportWidth, False)
		  
		  Clip.Bold = True
		  Clip.DrawString(Self.mTitle, 20, TitleBaseline, ViewportWidth, True)
		  
		  If Self.mDetailURL <> "" Then
		    Clip.Bold = False
		    
		    Dim ButtonTop As Double = Max(TitleBaseline + 40 + BodyHeight, Clip.Height - (ButtonHeight + 20))
		    Dim CaptionWidth As Double = Clip.StringWidth("More Details")
		    Dim ButtonWidth As Double = CaptionWidth + 40
		    Dim ButtonLeft As Double = (Clip.Width - ButtonWidth) / 2
		    Dim CaptionLeft As Double = ButtonLeft + 20
		    Dim CaptionBaseline As Double = ButtonTop + ((ButtonHeight / 2) + (Clip.CapHeight / 2))
		    
		    Clip.ForeColor = SystemColors.ControlColor
		    Clip.FillRoundRect(ButtonLeft, ButtonTop, ButtonWidth, ButtonHeight, 6, 6)
		    Clip.ForeColor = SystemColors.GridColor
		    Clip.DrawRoundRect(ButtonLeft, ButtonTop, ButtonWidth, ButtonHeight, 6, 6)
		    Clip.ForeColor = SystemColors.ControlTextColor
		    Clip.DrawString("More Details", CaptionLeft, CaptionBaseline)
		    
		    Self.mButtonRect = New BeaconUI.Rect(ButtonLeft, ButtonTop, ButtonWidth, ButtonHeight)
		    
		    If Self.mPressed Then
		      Clip.ForeColor = &c00000080
		      Clip.FillRoundRect(ButtonLeft, ButtonTop, ButtonWidth, ButtonHeight, 6, 6)
		    End If
		  Else
		    Self.mButtonRect = Nil
		  End If
		End Sub
	#tag EndEvent


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBody
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If StrComp(Self.mBody, Value, 0) <> 0 Then
			    Self.mBody = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Body As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBorders
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Mask As Integer = Self.BorderTop Or Self.BorderRight Or Self.BorderBottom Or Self.BorderLeft
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
			  Return Self.mDetailURL
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If StrComp(Self.mDetailURL, Value, 0) <> 0 Then
			    Self.mDetailURL = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		DetailURL As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBody As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBorders As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mButtonRect As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentOverflow As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDetailURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollPosition As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If StrComp(Self.mTitle, Value, 0) <> 0 Then
			    Self.mTitle = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Title As String
	#tag EndComputedProperty


	#tag Constant, Name = BorderBottom, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderLeft, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderNone, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderRight, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderTop, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="DoubleBuffer"
			Visible=true
			Group="Behavior"
			InitialValue="False"
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
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollSpeed"
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Body"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DetailURL"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Borders"
			Visible=true
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
