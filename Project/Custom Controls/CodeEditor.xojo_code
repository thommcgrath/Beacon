#tag Class
Protected Class CodeEditor
Inherits ScintillaControlMBS
	#tag Event
		Sub Open()
		  Self.InitializeLexer("props")
		  
		  For Idx As Integer = 1 To 4
		    Self.Margin(Idx).Width = 0
		  Next Idx
		  
		  Var Style As ScintillaStyleMBS = Self.Style(ScintillaStyleMBS.kStylesCommonDefault)
		  Style.Font = "Source Code Pro"
		  Style.Size = 12
		  
		  Self.UpdateColors()
		  
		  RaiseEvent Open
		  
		  Self.UpdateLineNumbersGutter()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub UpdateColors()
		  const SCE_PROPS_DEFAULT = 0
		  const SCE_PROPS_COMMENT = 1
		  const SCE_PROPS_SECTION = 2
		  const SCE_PROPS_ASSIGNMENT = 3
		  const SCE_PROPS_DEFVAL = 4
		  const SCE_PROPS_KEY = 5
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateLineNumbersGutter()
		  Var LineCount As String = Self.LineCount.ToString(Locale.Current, "0,")
		  Var Measure As New Picture(10, 10)
		  Var Style As ScintillaStyleMBS = Self.Style(ScintillaStyleMBS.kStylesCommonDefault)
		  Measure.Graphics.FontName = Style.Font
		  Measure.Graphics.FontSize = Style.Size
		  Measure.Graphics.FontUnit = FontUnits.Point
		  
		  Var GutterWidth As Integer = Ceiling(Measure.Graphics.TextWidth(LineCount)) + 10
		  Var Margin As ScintillaMarginMBS = Self.Margin(0)
		  Margin.Width = GutterWidth
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SelChange()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldCopy() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextChange()
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
