#tag Class
Protected Class CodeEditor
Inherits TextInputCanvas
Implements NotificationKit.Receiver
	#tag Event
		Sub Close()
		  RaiseEvent Close
		  NotificationKit.Ignore(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, deltaX as Integer, deltaY as Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Dim WheelData As New BeaconUI.ScrollEvent(Self.mLineHeight, DeltaX, DeltaY)
		  Dim NewPositionX As Integer = Min(Max(Self.mScrollPositionX + WheelData.ScrollX, 0), Self.mScrollMaxX)
		  Dim NewPositionY As Integer = Min(Max(Self.mScrollPositionY + WheelData.ScrollY, 0), Self.mScrollMaxY)
		  If NewPositionX <> Self.mScrollPositionX Or NewPositionY <> Self.mScrollPositionY Then
		    Self.mScrollPositionX = NewPositionX
		    Self.mScrollPositionY = NewPositionY
		    Self.mSurface = Nil
		    Self.Invalidate
		  End If
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  NotificationKit.Watch(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g as Graphics, areas() as object)
		  #Pragma Unused Areas
		  
		  Dim RequiredWidth As Integer = G.Width * G.ScaleX
		  Dim RequiredHeight As Integer = G.Height * G.ScaleY
		  
		  If Self.mSurface <> Nil And Self.mSurface.Width = RequiredWidth And Self.mSurface.Height = RequiredHeight Then
		    G.DrawPicture(Self.mSurface, 0, 0)
		    Return
		  End If
		  
		  Self.mSurface = New Picture(RequiredWidth, RequiredHeight, 32)
		  Self.mSurface.Graphics.ScaleX = G.ScaleY
		  Self.mSurface.Graphics.ScaleY = G.ScaleX
		  Self.mSurface.HorizontalResolution = 72 * G.ScaleX
		  Self.mSurface.VerticalResolution = 72 * G.ScaleY
		  Self.PaintInto(Self.mSurface.Graphics)
		  G.DrawPicture(Self.mSurface, 0, 0)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function LineCount() As UInteger
		  Return Self.Lines.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case App.Notification_AppearanceChanged
		    Self.mSurface = Nil
		    Self.mColors = Nil
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PaintInto(G As Graphics)
		  If Self.mColors = Nil Then
		    Dim BackgroundColor As Color = SystemColors.ControlBackgroundColor
		    Self.mColors = New CodeEditorColors
		    Self.mColors.HeaderColor = SystemColors.SecondaryLabelColor
		    Self.mColors.TextColor = SystemColors.LabelColor
		    Self.mColors.KeywordColor = BeaconUI.FindContrastingColor(BackgroundColor, SystemColors.SystemBlueColor)
		    Self.mColors.TrueColor = BeaconUI.FindContrastingColor(BackgroundColor, SystemColors.SystemGreenColor)
		    Self.mColors.FalseColor = BeaconUI.FindContrastingColor(BackgroundColor, SystemColors.SystemRedColor)
		    Self.mColors.NumberColor = BeaconUI.FindContrastingColor(BackgroundColor, SystemColors.SystemBrownColor)
		    Self.mColors.EncryptedBackgroundColor = BeaconUI.FindContrastingColor(BackgroundColor, SystemColors.SystemOrangeColor)
		    Self.mColors.EncryptedTextColor = BackgroundColor
		  End If
		  
		  Dim StartTime As Double = Microseconds
		  Dim LineCount As UInteger = Self.LineCount
		  Dim GutterWidth As Double = Max(Ceil(G.StringWidth(Str(LineCount))) + 10, 20) + 1
		  
		  G.ClearRect(0, 0, G.Width, G.Height)
		  G.ForeColor = SystemColors.TextBackgroundColor
		  G.FillRect(0, 0, G.Width, G.Height)
		  G.ForeColor = SystemColors.ControlBackgroundColor
		  G.FillRect(0, 0, GutterWidth, G.Height)
		  G.ForeColor = SystemColors.SeparatorColor
		  G.DrawLine(GutterWidth - 1, 0, GutterWidth - 1, G.Height)
		  
		  Dim EditorSurface As Graphics = G.Clip(GutterWidth, 0, G.Width - GutterWidth, G.Height)
		  EditorSurface.TextFont = "Source Code Pro"
		  EditorSurface.ForeColor = SystemColors.TextColor
		  
		  Dim Gutter As Graphics = G.Clip(0, 0, GutterWidth, G.Height)
		  Gutter.ForeColor = SystemColors.SecondaryLabelColor
		  Gutter.TextFont = EditorSurface.TextFont
		  
		  Self.mLineHeight = EditorSurface.TextHeight + 3
		  Self.mContentHeight = 9 + (Self.mLineHeight * (Self.Lines.Ubound + 1))
		  Self.mContentWidth = 0
		  
		  Dim LineTop As Double = 6 - Self.mScrollPositionY
		  Dim LineLeft As Double = 0 - Self.mScrollPositionX
		  For I As Integer = 0 To Self.Lines.Ubound
		    Dim Line As CodeEditorLine = Self.Lines(I)
		    Dim LineBottom As Double = LineTop + EditorSurface.TextHeight
		    Dim LineBaseline As Double = LineTop + EditorSurface.TextAscent
		    Self.mContentWidth = Max(Self.mContentWidth, Line.LineWidth)
		    
		    If LineLeft + Line.LineWidth < 0 Or LineBottom < 0 Or LineTop > EditorSurface.Height Then
		      LineTop = LineBottom + 3
		      Continue
		    End If
		    
		    Dim LineNumberString As String = Str(I + 1)
		    Dim LineNumberLeft As Double = Gutter.Width - (6 + Gutter.StringWidth(LineNumberString))
		    Gutter.DrawString(LineNumberString, LineNumberLeft, LineBaseline)
		    
		    Line.DrawInto(EditorSurface, LineLeft, LineBaseline, Self.mColors)
		    LineTop = LineBottom + 3
		  Next
		  Self.mScrollMaxX = Max(Self.mContentWidth - EditorSurface.Width, 0)
		  Self.mScrollMaxY = Max(Self.mContentHeight - EditorSurface.Height, 0)
		  Dim ElapsedTime As Double = Microseconds - StartTime
		  System.DebugLog("Full redraw took " + Str(ElapsedTime * 0.001, "0") + "ms")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextContent() As String
		  Return Self.TextContent(EndOfLine)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TextContent(Assigns Content As String)
		  Content = ReplaceLineEndings(Content, EndOfLine.Unix)
		  
		  Dim Lines() As String = Content.Split(EndOfLine.Unix)
		  Redim Self.Lines(Lines.Ubound)
		  For I As Integer = 0 To Lines.Ubound
		    Self.Lines(I) = Lines(I)
		  Next
		  Self.mSurface = Nil
		  Self.Invalidate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextContent(LineEnding As String) As String
		  Dim Lines() As String
		  Redim Lines(Self.Lines.Ubound)
		  For I As Integer = 0 To Self.Lines.Ubound
		    Lines(I) = Self.Lines(I)
		  Next
		  Return Join(Lines, LineEnding)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private Lines() As CodeEditorLine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mColors As CodeEditorColors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLineHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollMaxX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollMaxY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollPositionX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollPositionY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSurface As Picture
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
