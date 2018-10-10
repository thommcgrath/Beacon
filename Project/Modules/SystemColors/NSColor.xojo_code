#tag Class
Private Class NSColor
	#tag Method, Flags = &h0
		Function ColorValue() As Color
		  #if TargetMacOS
		    Declare Function GetGenericRGBColorSpace Lib CocoaLib Selector "deviceRGBColorSpace" (Target As Ptr) As Ptr
		    Declare Function ColorUsingColorSpace Lib CocoaLib Selector "colorUsingColorSpace:" (Target As Ptr, ColorSpace As Ptr) As Ptr
		    Declare Sub GetRGBValues Lib CocoaLib Selector "getRed:green:blue:alpha:" (Target As Ptr, ByRef Red As CGFloat, ByRef Green As CGFloat, ByRef Blue As CGFloat, ByRef Alpha As CGFloat)
		    
		    Dim NSColorSpace As Ptr = objc_getClass("NSColorSpace")
		    Dim ColorSpace As Ptr = GetGenericRGBColorSpace(NSColorSpace)
		    Dim Handle As Ptr = ColorUsingColorSpace(Self.mHandle, ColorSpace)
		    If Handle = Nil Then
		      Return &cFB02FE00
		    End If
		    
		    Dim RedValue, GreenValue, BlueValue, AlphaValue As CGFloat
		    GetRGBValues(Handle, RedValue, GreenValue, BlueValue, AlphaValue)
		    Return RGB(255 * RedValue, 255 * GreenValue, 255 * BlueValue, 255 - (AlphaValue * 255))
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ptr)
		  Self.mHandle = Source
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAlternatingRowColors() As SystemColors.NSColor()
		  Dim Colors() As SystemColors.NSColor
		  #if TargetMacOS
		    Dim NSColor As Ptr = objc_getClass("NSColor")
		    
		    Dim ArrayRef As Ptr
		    If RespondsToSelector(NSColor, NSSelectorFromString("alternatingContentBackgroundColors")) Then
		      Declare Function RowColors Lib CocoaLib Selector "alternatingContentBackgroundColors" (Target As Ptr) As Ptr
		      ArrayRef = RowColors(NSColor)
		    Else
		      Declare Function RowColors Lib CocoaLib Selector "controlAlternatingRowBackgroundColors" (Target As Ptr) As Ptr
		      ArrayRef = RowColors(NSColor)
		    End If
		    
		    Declare Function ArrayCount Lib CocoaLib Selector "count" (Target As Ptr) As UInteger
		    Declare Function ArrayObjectAtIndex Lib CocoaLib Selector "objectAtIndex:" (Target As Ptr, Index As UInteger) As Ptr
		    
		    Dim ObjectCount As Integer = ArrayCount(ArrayRef)
		    For I As Integer = 0 To ObjectCount - 1
		      Dim Handle As Ptr = ArrayObjectAtIndex(ArrayRef, I)
		      Colors.Append(New SystemColors.NSColor(Handle))
		    Next
		  #endif
		  Return Colors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetSystemColor(SelectorName As String) As SystemColors.NSColor
		  #if TargetMacOS
		    Dim NSColor As Ptr = objc_getClass("NSColor")
		    
		    If Not RespondsToSelector(NSColor, NSSelectorFromString(SelectorName)) Then
		      Select Case SelectorName
		      Case "selectedContentBackgroundColor"
		        SelectorName = "alternateSelectedControlColor"
		      Case "unemphasizedSelectedContentBackgroundColor"
		        SelectorName = "secondarySelectedControlColor"
		      Else
		        Return Nil
		      End Select
		    End If
		    
		    Dim Handle As Ptr
		    Select Case SelectorName
		    Case "labelColor"
		      Declare Function labelColor Lib CocoaLib Selector "labelColor" (Target As Ptr) As Ptr
		      Handle = labelColor(NSColor)
		    Case "secondaryLabelColor"
		      Declare Function secondaryLabelColor Lib CocoaLib Selector "secondaryLabelColor" (Target As Ptr) As Ptr
		      Handle = secondaryLabelColor(NSColor)
		    Case "tertiaryLabelColor"
		      Declare Function tertiaryLabelColor Lib CocoaLib Selector "tertiaryLabelColor" (Target As Ptr) As Ptr
		      Handle = tertiaryLabelColor(NSColor)
		    Case "quaternaryLabelColor"
		      Declare Function quaternaryLabelColor Lib CocoaLib Selector "quaternaryLabelColor" (Target As Ptr) As Ptr
		      Handle = quaternaryLabelColor(NSColor)
		    Case "textColor"
		      Declare Function textColor Lib CocoaLib Selector "textColor" (Target As Ptr) As Ptr
		      Handle = textColor(NSColor)
		    Case "placeholderTextColor"
		      Declare Function placeholderTextColor Lib CocoaLib Selector "placeholderTextColor" (Target As Ptr) As Ptr
		      Handle = placeholderTextColor(NSColor)
		    Case "selectedTextColor"
		      Declare Function selectedTextColor Lib CocoaLib Selector "selectedTextColor" (Target As Ptr) As Ptr
		      Handle = selectedTextColor(NSColor)
		    Case "textBackgroundColor"
		      Declare Function textBackgroundColor Lib CocoaLib Selector "textBackgroundColor" (Target As Ptr) As Ptr
		      Handle = textBackgroundColor(NSColor)
		    Case "selectedTextBackgroundColor"
		      Declare Function selectedTextBackgroundColor Lib CocoaLib Selector "selectedTextBackgroundColor" (Target As Ptr) As Ptr
		      Handle = selectedTextBackgroundColor(NSColor)
		    Case "keyboardFocusIndicatorColor"
		      Declare Function keyboardFocusIndicatorColor Lib CocoaLib Selector "keyboardFocusIndicatorColor" (Target As Ptr) As Ptr
		      Handle = keyboardFocusIndicatorColor(NSColor)
		    Case "unemphasizedSelectedTextColor"
		      Declare Function unemphasizedSelectedTextColor Lib CocoaLib Selector "unemphasizedSelectedTextColor" (Target As Ptr) As Ptr
		      Handle = unemphasizedSelectedTextColor(NSColor)
		    Case "unemphasizedSelectedTextBackgroundColor"
		      Declare Function unemphasizedSelectedTextBackgroundColor Lib CocoaLib Selector "unemphasizedSelectedTextBackgroundColor" (Target As Ptr) As Ptr
		      Handle = unemphasizedSelectedTextBackgroundColor(NSColor)
		    Case "linkColor"
		      Declare Function linkColor Lib CocoaLib Selector "linkColor" (Target As Ptr) As Ptr
		      Handle = linkColor(NSColor)
		    Case "separatorColor"
		      Declare Function separatorColor Lib CocoaLib Selector "separatorColor" (Target As Ptr) As Ptr
		      Handle = separatorColor(NSColor)
		    Case "selectedContentBackgroundColor"
		      Declare Function selectedContentBackgroundColor Lib CocoaLib Selector "selectedContentBackgroundColor" (Target As Ptr) As Ptr
		      Handle = selectedContentBackgroundColor(NSColor)
		    Case "unemphasizedSelectedContentBackgroundColor"
		      Declare Function unemphasizedSelectedContentBackgroundColor Lib CocoaLib Selector "unemphasizedSelectedContentBackgroundColor" (Target As Ptr) As Ptr
		      Handle = unemphasizedSelectedContentBackgroundColor(NSColor)
		    Case "selectedMenuItemTextColor"
		      Declare Function selectedMenuItemTextColor Lib CocoaLib Selector "selectedMenuItemTextColor" (Target As Ptr) As Ptr
		      Handle = selectedMenuItemTextColor(NSColor)
		    Case "gridColor"
		      Declare Function gridColor Lib CocoaLib Selector "gridColor" (Target As Ptr) As Ptr
		      Handle = gridColor(NSColor)
		    Case "headerTextColor"
		      Declare Function headerTextColor Lib CocoaLib Selector "headerTextColor" (Target As Ptr) As Ptr
		      Handle = headerTextColor(NSColor)
		    Case "controlAccentColor"
		      Declare Function controlAccentColor Lib CocoaLib Selector "controlAccentColor" (Target As Ptr) As Ptr
		      Handle = controlAccentColor(NSColor)
		    Case "controlColor"
		      Declare Function controlColor Lib CocoaLib Selector "controlColor" (Target As Ptr) As Ptr
		      Handle = controlColor(NSColor)
		    Case "controlBackgroundColor"
		      Declare Function controlBackgroundColor Lib CocoaLib Selector "controlBackgroundColor" (Target As Ptr) As Ptr
		      Handle = controlBackgroundColor(NSColor)
		    Case "controlTextColor"
		      Declare Function controlTextColor Lib CocoaLib Selector "controlTextColor" (Target As Ptr) As Ptr
		      Handle = controlTextColor(NSColor)
		    Case "disabledControlTextColor"
		      Declare Function disabledControlTextColor Lib CocoaLib Selector "disabledControlTextColor" (Target As Ptr) As Ptr
		      Handle = disabledControlTextColor(NSColor)
		    Case "selectedControlColor"
		      Declare Function selectedControlColor Lib CocoaLib Selector "selectedControlColor" (Target As Ptr) As Ptr
		      Handle = selectedControlColor(NSColor)
		    Case "selectedControlTextColor"
		      Declare Function selectedControlTextColor Lib CocoaLib Selector "selectedControlTextColor" (Target As Ptr) As Ptr
		      Handle = selectedControlTextColor(NSColor)
		    Case "alternateSelectedControlTextColor"
		      Declare Function alternateSelectedControlTextColor Lib CocoaLib Selector "alternateSelectedControlTextColor" (Target As Ptr) As Ptr
		      Handle = alternateSelectedControlTextColor(NSColor)
		    Case "windowBackgroundColor"
		      Declare Function windowBackgroundColor Lib CocoaLib Selector "windowBackgroundColor" (Target As Ptr) As Ptr
		      Handle = windowBackgroundColor(NSColor)
		    Case "windowFrameTextColor"
		      Declare Function windowFrameTextColor Lib CocoaLib Selector "windowFrameTextColor" (Target As Ptr) As Ptr
		      Handle = windowFrameTextColor(NSColor)
		    Case "underPageBackgroundColor"
		      Declare Function underPageBackgroundColor Lib CocoaLib Selector "underPageBackgroundColor" (Target As Ptr) As Ptr
		      Handle = underPageBackgroundColor(NSColor)
		    Case "findHighlightColor"
		      Declare Function findHighlightColor Lib CocoaLib Selector "findHighlightColor" (Target As Ptr) As Ptr
		      Handle = findHighlightColor(NSColor)
		    Case "highlightColor"
		      Declare Function highlightColor Lib CocoaLib Selector "highlightColor" (Target As Ptr) As Ptr
		      Handle = highlightColor(NSColor)
		    Case "shadowColor"
		      Declare Function shadowColor Lib CocoaLib Selector "shadowColor" (Target As Ptr) As Ptr
		      Handle = shadowColor(NSColor)
		    Case "systemBlueColor"
		      Declare Function systemBlueColor Lib CocoaLib Selector "systemBlueColor" (Target As Ptr) As Ptr
		      Handle = systemBlueColor(NSColor)
		    Case "systemBrownColor"
		      Declare Function systemBrownColor Lib CocoaLib Selector "systemBrownColor" (Target As Ptr) As Ptr
		      Handle = systemBrownColor(NSColor)
		    Case "systemGrayColor"
		      Declare Function systemGrayColor Lib CocoaLib Selector "systemGrayColor" (Target As Ptr) As Ptr
		      Handle = systemGrayColor(NSColor)
		    Case "systemGreenColor"
		      Declare Function systemGreenColor Lib CocoaLib Selector "systemGreenColor" (Target As Ptr) As Ptr
		      Handle = systemGreenColor(NSColor)
		    Case "systemOrangeColor"
		      Declare Function systemOrangeColor Lib CocoaLib Selector "systemOrangeColor" (Target As Ptr) As Ptr
		      Handle = systemOrangeColor(NSColor)
		    Case "systemPinkColor"
		      Declare Function systemPinkColor Lib CocoaLib Selector "systemPinkColor" (Target As Ptr) As Ptr
		      Handle = systemPinkColor(NSColor)
		    Case "systemPurpleColor"
		      Declare Function systemPurpleColor Lib CocoaLib Selector "systemPurpleColor" (Target As Ptr) As Ptr
		      Handle = systemPurpleColor(NSColor)
		    Case "systemRedColor"
		      Declare Function systemRedColor Lib CocoaLib Selector "systemRedColor" (Target As Ptr) As Ptr
		      Handle = systemRedColor(NSColor)
		    Case "systemYellowColor"
		      Declare Function systemYellowColor Lib CocoaLib Selector "systemYellowColor" (Target As Ptr) As Ptr
		      Handle = systemYellowColor(NSColor)
		    End Select
		    
		    If Handle = Nil Then
		      Return Nil
		    End If
		    Return New SystemColors.NSColor(Handle)
		  #endif
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function NSSelectorFromString Lib CocoaLib (SelectorName As CFStringRef) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function objc_getClass Lib CocoaLib (Name As CString) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function RespondsToSelector Lib CocoaLib Selector "respondsToSelector:" (Target As Ptr, SelectorRef As Ptr) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function WithSystemEffect(Effect As SystemColors.NSColor.SystemEffect) As SystemColors.NSColor
		  #if TargetMacOS
		    Declare Function GetColorWithSystemEffect Lib CocoaLib Selector "colorWithSystemEffect:" (Target As Ptr, Effect As Integer) As Ptr
		    Dim Handle As Ptr = GetColorWithSystemEffect(Self.mHandle, CType(Effect, Integer))
		    Return New SystemColors.NSColor(Handle)
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHandle As PTr
	#tag EndProperty


	#tag Constant, Name = CocoaLib, Type = String, Dynamic = False, Default = \"/System/Library/Frameworks/Cocoa.framework/Versions/A/Cocoa", Scope = Private
	#tag EndConstant


	#tag Enum, Name = SystemEffect, Type = Integer, Flags = &h0
		None
		  Pressed
		  DeepPressed
		  Disabled
		Rollover
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
