#tag Class
Protected Class CodeEditor
Inherits ScintillaControlMBS
Implements NotificationKit.Receiver
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, App.Notification_AppearanceChanged)
		  
		  RaiseEvent Close
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  For Idx As Integer = 1 To 4
		    Self.Margin(Idx).Width = 0
		  Next Idx
		  
		  Self.ScrollWidthTracking = True
		  Self.RunSetup()
		  
		  RaiseEvent Open
		  
		  NotificationKit.Watch(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SelectionChanged(updated as Integer)
		  #Pragma Unused Updated
		  
		  RaiseEvent SelectionChanged
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextChanged(Position as Integer, modificationType as Integer, Text as String, length as Integer, linesAdded as Integer, line as Integer)
		  #Pragma Unused Position
		  #Pragma Unused modificationType
		  #Pragma Unused Text
		  #Pragma Unused Length
		  #Pragma Unused Line
		  
		  RaiseEvent TextChanged
		  
		  If LinesAdded > 0 Then
		    Self.UpdateLineNumbersGutter()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Copy()
		  If IsEventImplemented("ShouldCopy") And RaiseEvent ShouldCopy() = False Then
		    Return
		  End If
		  
		  Super.Copy()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case App.Notification_AppearanceChanged
		    Self.RunSetup()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PositionInLine() As Integer
		  // find position within line
		  
		  Var Position As Integer = Self.Position
		  Var LineNum As Integer = Self.LineFromPosition(Position)
		  Var LineStart As Integer = Self.LineStart(LineNum)
		  Return Position - LineStart
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RunSetup()
		  Var BaseStyle As ScintillaStyleMBS = Self.Style(ScintillaStyleMBS.kStylesCommonDefault)
		  If Color.IsDarkMode Then
		    BaseStyle.BackColor = &c161616
		    BaseStyle.ForeColor = &cFFFFFF
		  Else
		    BaseStyle.BackColor = &cFFFFFF
		    BaseStyle.ForeColor = &c000000
		  End If
		  BaseStyle.Font = "Source Code Pro"
		  #if TargetWindows
		    BaseStyle.Size = 9 // 864 / 96dpi
		  #else
		    BaseStyle.Size = 12 // 864 / 72dpi
		  #endif
		  
		  Self.StyleClearAll()
		  
		  Var MarginStyle As ScintillaStyleMBS = Self.Style(ScintillaStyleMBS.kStylesCommonLineNumber)
		  If Color.IsDarkMode Then
		    MarginStyle.BackColor = &c222222
		    MarginStyle.ForeColor = &cCBCBCB
		  Else
		    MarginStyle.BackColor = &cF9F9F9
		    MarginStyle.ForeColor = &c515151
		  End If
		  
		  RaiseEvent SetupNeeded()
		  
		  Self.CaretForeColor = BaseStyle.ForeColor
		  Self.UpdateLineNumbersGutter()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateLineNumbersGutter()
		  Var LineCount As String = Self.LineCount.ToString(Locale.Current, ",##0")
		  Var Measure As New Picture(10, 10)
		  Var Style As ScintillaStyleMBS = Self.Style(ScintillaStyleMBS.kStylesCommonDefault)
		  Measure.Graphics.FontName = Style.Font
		  Measure.Graphics.FontSize = Style.Size
		  Measure.Graphics.FontUnit = FontUnits.Point
		  
		  Var GutterWidth As Integer = Ceiling(Measure.Graphics.TextWidth(LineCount)) + 10
		  #if TargetWindows
		    If (Self.TrueWindow Is Nil) = False Then
		      GutterWidth = GutterWidth * Self.TrueWindow.ScaleFactor
		    End If
		  #endif
		  Var Margin As ScintillaMarginMBS = Self.Margin(0)
		  Margin.Width = GutterWidth
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SelectionChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SetupNeeded()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldCopy() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextChanged()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.XOffset
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.XOffset = Value
			End Set
		#tag EndSetter
		HorizontalScrollPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.SelectionEnd - Self.SelectionStart
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.SelectionEnd = Self.SelectionStart + Value
			End Set
		#tag EndSetter
		SelectionLength As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.FirstVisibleLine
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.FirstVisibleLine = Value
			End Set
		#tag EndSetter
		VerticalScrollPosition As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group=""
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
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
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
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
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
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
		#tag ViewProperty
			Name="ShowInfoBar"
			Visible=true
			Group=""
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HorizontalScrollPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionLength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerticalScrollPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
