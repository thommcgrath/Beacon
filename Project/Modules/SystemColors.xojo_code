#tag Module
Protected Module SystemColors
	#tag Method, Flags = &h1
		Protected Function AlternateSelectedControlTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("alternateSelectedControlTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return &cFFFFFF00
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Brightness(Extends SourceColor As Color) As Integer
		  Return Exp(Log((SourceColor.Red * SourceColor.Red * 0.241) + (SourceColor.Green * SourceColor.Green * 0.691) + (SourceColor.Blue * SourceColor.Blue * 0.068)) * 0.5)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ColorByName(ColorName As String) As Color
		  Select Case ColorName
		  Case "AlternateSelectedControlTextColor"
		    Return SystemColors.AlternateSelectedControlTextColor
		  Case "ControlAccentColor"
		    Return SystemColors.ControlAccentColor
		  Case "ControlBackgroundColor"
		    Return SystemColors.ControlBackgroundColor
		  Case "ControlColor"
		    Return SystemColors.ControlColor
		  Case "ControlTextColor"
		    Return SystemColors.ControlTextColor
		  Case "DisabledControlTextColor"
		    Return SystemColors.DisabledControlTextColor
		  Case "FindHighlightColor"
		    Return SystemColors.FindHighlightColor
		  Case "GridColor"
		    Return SystemColors.GridColor
		  Case "HeaderTextColor"
		    Return SystemColors.HeaderTextColor
		  Case "HighlightColor"
		    Return SystemColors.HighlightColor
		  Case "KeyboardFocusIndicatorColor"
		    Return SystemColors.KeyboardFocusIndicatorColor
		  Case "LabelColor"
		    Return SystemColors.LabelColor
		  Case "LinkColor"
		    Return SystemColors.LinkColor
		  Case "ListEvenRowColor"
		    Return SystemColors.ListEvenRowColor
		  Case "ListOddRowColor"
		    Return SystemColors.ListOddRowColor
		  Case "PlaceholderTextColor"
		    Return SystemColors.PlaceholderTextColor
		  Case "QuaternaryLabelColor"
		    Return SystemColors.QuaternaryLabelColor
		  Case "SecondaryLabelColor"
		    Return SystemColors.SecondaryLabelColor
		  Case "SelectedContentBackgroundColor"
		    Return SystemColors.SelectedContentBackgroundColor
		  Case "SelectedControlColor"
		    Return SystemColors.SelectedControlColor
		  Case "SelectedControlTextColor"
		    Return SystemColors.SelectedControlTextColor
		  Case "SelectedMenuItemTextColor"
		    Return SystemColors.SelectedMenuItemTextColor
		  Case "SelectedTextBackgroundColor"
		    Return SystemColors.SelectedTextBackgroundColor
		  Case "SelectedTextColor"
		    Return SystemColors.SelectedTextColor
		  Case "SeparatorColor"
		    Return SystemColors.SeparatorColor
		  Case "ShadowColor"
		    Return SystemColors.ShadowColor
		  Case "SystemBlueColor"
		    Return SystemColors.SystemBlueColor
		  Case "SystemBrownColor"
		    Return SystemColors.SystemBrownColor
		  Case "SystemGrayColor"
		    Return SystemColors.SystemGrayColor
		  Case "SystemGreenColor"
		    Return SystemColors.SystemGreenColor
		  Case "SystemOrangeColor"
		    Return SystemColors.SystemOrangeColor
		  Case "SystemPinkColor"
		    Return SystemColors.SystemPinkColor
		  Case "SystemPurpleColor"
		    Return SystemColors.SystemPurpleColor
		  Case "SystemRedColor"
		    Return SystemColors.SystemRedColor
		  Case "SystemYellowColor"
		    Return SystemColors.SystemYellowColor
		  Case "TertiaryLabelColor"
		    Return SystemColors.TertiaryLabelColor
		  Case "TextBackgroundColor"
		    Return SystemColors.TextBackgroundColor
		  Case "TextColor"
		    Return SystemColors.TextColor
		  Case "UnderPageBackgroundColor"
		    Return SystemColors.UnderPageBackgroundColor
		  Case "UnemphasizedSelectedContentBackgroundColor"
		    Return SystemColors.UnemphasizedSelectedContentBackgroundColor
		  Case "UnemphasizedSelectedTextBackgroundColor"
		    Return SystemColors.UnemphasizedSelectedTextBackgroundColor
		  Case "UnemphasizedSelectedTextColor"
		    Return SystemColors.UnemphasizedSelectedTextColor
		  Case "WindowBackgroundColor"
		    Return SystemColors.WindowBackgroundColor
		  Case "WindowFrameTextColor"
		    Return SystemColors.WindowFrameTextColor
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlAccentColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("controlAccentColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return &c007AFF00
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("controlBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c1E1E1E00, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("controlColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFFC0, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("controlTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF27, &c00000027)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DisabledControlTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("disabledControlTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFFC0, &c000000C0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindHighlightColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("findHighlightColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return &cFFFF0000
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GridColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("gridColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFFE6, &cCCCCCC00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HeaderTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("headerTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF00, &c00000027)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HighlightColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("highlightColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cB4B4B400, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDark(Extends SourceColor As Color) As Boolean
		  Return SourceColor.Brightness < 170
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsDarkMode() As Boolean
		  #if XojoVersion >= 2019.03
		    Return Color.IsDarkMode
		  #elseif XojoVersion >= 2018.03
		    Return REALbasic.IsDarkMode
		  #else
		    Return False
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function KeyboardFocusIndicatorColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("keyboardFocusIndicatorColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c1AA9FFB2, &c0067F4BF)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("labelColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF27, &c00000027)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LinkColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("linkColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c419CFF00, &c0068DA00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListEvenRowColor() As Color
		  Dim Colors() As Color = SystemColors.RowColors
		  Return Colors(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListOddRowColor() As Color
		  Dim Colors() As Color = SystemColors.RowColors
		  Return Colors(1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PlaceholderTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("placeholderTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFFC0, &c000000C0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function QuaternaryLabelColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("quaternaryLabelColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFFE6, &c000000E6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RowColors() As Color()
		  Dim Results() As SystemColors.NSColor = SystemColors.NSColor.GetAlternatingRowColors
		  Dim Colors() As Color
		  Redim Colors(Results.LastRowIndex)
		  
		  For I As Integer = 0 To Results.LastRowIndex
		    Colors(I) = Results(I).ColorValue
		  Next
		  
		  If Colors.LastRowIndex = -1 Then
		    Redim Colors(1)
		    Colors(0) = If(SystemColors.IsDarkMode, &c1E1E1E00, &cFFFFFF00)
		    Colors(1) = If(SystemColors.IsDarkMode, &cFFFFFFF3, &cF4F5F500)
		  End If
		  
		  // This is to work around an issue where the even dark color isn't getting the proper alpha channel
		  // https://forum.xojo.com/50440-dark-mode-alternatingcontentbackgroundcolors-doesn-t-seem-corre
		  If SystemColors.IsDarkMode Then
		    Colors(0) = RGB(Colors(0).Red, Colors(0).Green, Colors(0).Blue, 153)
		  End If
		  
		  Return Colors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondaryLabelColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("secondaryLabelColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF73, &c00000080)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedContentBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("selectedContentBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c0058D000, &c0063E100)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedControlColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("selectedControlColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c3F638B00, &cB3D7FF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedControlTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("selectedControlTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF27, &c00000027)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedMenuItemTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("selectedMenuItemTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return &cFFFFFF00
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTextBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("selectedTextBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c3F638B00, &cB3D7FF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("selectedTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF00, &c00000000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SeparatorColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("separatorColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFFE6, &c000000E6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShadowColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("shadowColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return &c00000000
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemBlueColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemBlueColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c0A84FF00, &c007AFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemBrownColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemBrownColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cAC8E6800, &cA2845E00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemGrayColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemGrayColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c98989D00, &c8E8E9300)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemGreenColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemGreenColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c32D74B00, &c28CD4100)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemOrangeColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemOrangeColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFF9F0A00, &cFF950000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemPinkColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemPinkColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFF375F00, &cFF2D5500)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemPurpleColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemPurpleColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cBF5AF200, &cAF52DE00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemRedColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemRedColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFF453A00, &cFF3B3000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemYellowColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("systemYellowColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFD60A00, &cFFCC0000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TertiaryLabelColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("tertiaryLabelColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFFC0, &c000000C0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("textBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c1E1E1E00, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("textColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF00, &c00000000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnderPageBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("underPageBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c28282800, &c9696961A)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedContentBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("unemphasizedSelectedContentBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c46464600, &cDCDCDC00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedTextBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("unemphasizedSelectedTextBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c46464600, &cDCDCDC00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("unemphasizedSelectedTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF00, &c00000000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WindowBackgroundColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("windowBackgroundColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &c32323200, &cECECEC00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WindowFrameTextColor() As Color
		  Dim Value As SystemColors.NSColor = SystemColors.NSColor.GetSystemColor("windowFrameTextColor")
		  If Value <> Nil Then
		    Return Value.ColorValue
		  End If
		  
		  Return If(SystemColors.IsDarkMode, &cFFFFFF27, &c00000027)
		End Function
	#tag EndMethod


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
	#tag EndViewBehavior
End Module
#tag EndModule
