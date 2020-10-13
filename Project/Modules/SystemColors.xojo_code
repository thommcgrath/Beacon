#tag Module
Protected Module SystemColors
	#tag Method, Flags = &h1
		Protected Function AlternateSelectedControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("alternateSelectedControlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFFFFF00)
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
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("controlAccentColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c713A9A00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("controlBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFFFFF00, &c1E1E1E00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("controlColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFFFFF00, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("controlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000027, &cFFFFFF27)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DisabledControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("disabledControlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c000000C0, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindHighlightColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("findHighlightColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFFF0000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GridColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("gridColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cCCCCCC00, &cFFFFFFE6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HeaderTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("headerTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000027, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HighlightColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("highlightColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFFFFF00, &cB4B4B400)
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
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("keyboardFocusIndicatorColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c0067F4BF, &c1AA9FFB2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("labelColor")
		    #elseif TargetiOS
		      Return New ColorGroup("label")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000027, &cFFFFFF27)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LinkColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("linkColor")
		    #elseif TargetiOS
		      Return New ColorGroup("link")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c0068DA00, &c419CFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListEvenRowColor() As Color
		  Var Colors() As Color = SystemColors.RowColors
		  Return Colors(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListOddRowColor() As Color
		  Var Colors() As Color = SystemColors.RowColors
		  Return Colors(1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PlaceholderTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("placeholderTextColor")
		    #elseif TargetiOS
		      Return New ColorGroup("placeholderText")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c000000C0, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function QuaternaryLabelColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("quaternaryLabelColor")
		    #elseif TargetiOS
		      Return New ColorGroup("quaternaryLabel")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c000000E6, &cFFFFFFE6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RowColors() As Color()
		  Var Colors(1) As Color
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function NSSelectorFromString Lib "Cocoa" (SelectorName As CFStringRef) As Ptr
		    Declare Function RespondsToSelector Lib "Cocoa" Selector "respondsToSelector:" (Target As Ptr, Sel As Ptr) As Boolean
		    
		    Var NSColor As Ptr = objc_getClass("NSColor")
		    
		    Var ArrayRef As Ptr
		    If RespondsToSelector(NSColor, NSSelectorFromString("alternatingContentBackgroundColors")) Then
		      Declare Function RowColors Lib "Cocoa" Selector "alternatingContentBackgroundColors" (Target As Ptr) As Ptr
		      ArrayRef = RowColors(NSColor)
		    Else
		      Declare Function RowColors Lib "Cocoa" Selector "controlAlternatingRowBackgroundColors" (Target As Ptr) As Ptr
		      ArrayRef = RowColors(NSColor)
		    End If
		    
		    Declare Function ArrayCount Lib "Cocoa" Selector "count" (Target As Ptr) As UInteger
		    Declare Function ArrayObjectAtIndex Lib "Cocoa" Selector "objectAtIndex:" (Target As Ptr, Index As UInteger) As Ptr
		    Declare Function GetGenericRGBColorSpace Lib "Cocoa" Selector "deviceRGBColorSpace" (Target As Ptr) As Ptr
		    Declare Function ColorUsingColorSpace Lib "Cocoa" Selector "colorUsingColorSpace:" (Target As Ptr, ColorSpace As Ptr) As Ptr
		    Declare Sub GetRGBValues Lib "Cocoa" Selector "getRed:green:blue:alpha:" (Target As Ptr, ByRef Red As CGFloat, ByRef Green As CGFloat, ByRef Blue As CGFloat, ByRef Alpha As CGFloat)
		    
		    Var ObjectCount As UInteger = ArrayCount(ArrayRef)
		    Var Bound As Integer = CType(ObjectCount, Integer) - 1
		    Var NSColorSpace As Ptr = objc_getClass("NSColorSpace")
		    Var ColorSpace As Ptr = GetGenericRGBColorSpace(NSColorSpace)
		    
		    Colors.ResizeTo(Bound)
		    For I As Integer = 0 To Bound
		      Var Handle As Ptr = ColorUsingColorSpace(ArrayObjectAtIndex(ArrayRef, CType(I, UInteger)), ColorSpace)
		      If Handle = Nil Then
		        Colors(I) = &cFB02FE00
		        Continue
		      End If
		      
		      Var RedValue, GreenValue, BlueValue, AlphaValue As CGFloat
		      GetRGBValues(Handle, RedValue, GreenValue, BlueValue, AlphaValue)
		      Colors(I) = Color.RGB(255 * RedValue, 255 * GreenValue, 255 * BlueValue, 255 - (AlphaValue * 255))
		    Next
		    
		    // This is to work around an issue where the even dark color isn't getting the proper alpha channel
		    // https://forum.xojo.com/50440-dark-mode-alternatingcontentbackgroundcolors-doesn-t-seem-corre
		    If SystemColors.IsDarkMode Then
		      Colors(0) = Color.RGB(Colors(0).Red, Colors(0).Green, Colors(0).Blue, 153)
		    End If
		    
		    Return Colors
		  #endif
		  
		  Colors(0) = New ColorGroup(&cFFFFFF00, &c1E1E1E99)
		  Colors(1) = New ColorGroup(&cF4F5F500, &cFFFFFFF3)
		  
		  Return Colors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondaryLabelColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("secondaryLabelColor")
		    #elseif TargetiOS
		      Return New ColorGroup("secondaryLabel")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000080, &cFFFFFF73)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedContentBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("selectedContentBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c0063E100, &c0058D000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedControlColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("selectedControlColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cB3D7FF00, &c3F638B00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("selectedControlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000027, &cFFFFFF27)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedMenuItemTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("selectedMenuItemTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTextBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("selectedTextBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cB3D7FF00, &c3F638B00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("selectedTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000000, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SeparatorColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("separatorColor")
		    #elseif TargetiOS
		      Return New ColorGroup("separator")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c000000E6, &cFFFFFFE6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShadowColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("shadowColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemBlueColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemBlueColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemBlue")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c007AFF00, &c0A84FF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemBrownColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemBrownColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cA2845E00, &cAC8E6800)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemGrayColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemGrayColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemGray")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c8E8E9300, &c98989D00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemGreenColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemGreenColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemGreen")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c28CD4100, &c32D74B00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemOrangeColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemOrangeColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemOrange")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFF950000, &cFF9F0A00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemPinkColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemPinkColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemPink")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFF2D5500, &cFF375F00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemPurpleColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemPurpleColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemPurple")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cAF52DE00, &cBF5AF200)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemRedColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemRedColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemRed")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFF3B3000, &cFF453A00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemYellowColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("systemYellowColor")
		    #elseif TargetiOS
		      Return New ColorGroup("systemYellow")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFCC0000, &cFFD60A00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TertiaryLabelColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("tertiaryLabelColor")
		    #elseif TargetiOS
		      Return New ColorGroup("tertiaryLabel")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c000000C0, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("textBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cFFFFFF00, &c1E1E1E00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("textColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000000, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnderPageBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("underPageBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c9696961A, &c28282800)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedContentBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("unemphasizedSelectedContentBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cDCDCDC00, &c46464600)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedTextBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("unemphasizedSelectedTextBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cDCDCDC00, &c46464600)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("unemphasizedSelectedTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000000, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WindowBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("windowBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&cECECEC00, &c32323200)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WindowFrameTextColor() As Color
		  Try
		    #if TargetMacOS
		      Return New ColorGroup("windowFrameTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroup(&c00000027, &cFFFFFF27)
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
