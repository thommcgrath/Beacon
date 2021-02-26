#tag Module
Protected Module SystemColors
	#tag Method, Flags = &h1
		Protected Function AlternateSelectedControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.2+
		      Return New ColorGroupMimic("alternateSelectedControlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFFFFF00)
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
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("controlAccentColor")
		      End If
		    #elseif TargetWindows
		      If UseWindowsColors Then
		        Return WindowsAccentColor
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c5c248700, &c8030bf00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("controlBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFFFFF00, &c1E1E1E00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("controlColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFFFFF00, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("controlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000027, &cFFFFFF27)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DisabledControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("disabledControlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c000000C0, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindHighlightColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.13+
		      If MacIsHighSierra Then
		        Return New ColorGroupMimic("findHighlightColor")
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFFF0000)
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function GetColorValueFunc(this As Ptr, desiredColor As WindowsColorTypes, ByRef value As UInt32) As Int32
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function GetWindowsColorValue(DesiredColor As WindowsColorTypes) As Color
		  #if TargetWindows
		    'Information provided by William here 'https://blog.xojo.com/2019/07/02/accessing-windows-runtime-winrt/ made this a lot easier to do, thanks William
		    
		    Soft Declare Function WindowsCreateString Lib "combase.dll" (source As WString, length As UInt32, ByRef out As Ptr) As Integer
		    Soft Declare Function WindowsDeleteString Lib "combase.dll" (hstring As Ptr) As Integer
		    Soft Declare Function RoActivateInstance Lib "combase.dll" (classId As Ptr, ByRef inspectable As Ptr) As Integer
		    
		    Var classUUID As String = "{03021BE4-5254-4781-8194-5168F7D06D7B}"
		    Var className As String = "Windows.UI.ViewManagement.UISettings"
		    Var classId As Ptr
		    Var result As Integer = WindowsCreateString(className, className.Length, classId)
		    
		    Var inspectable As Ptr
		    result = RoActivateInstance(classId, inspectable)
		    
		    Var unknown As New COM.IUnknown(inspectable)
		    Var interfacePtr As Ptr
		    
		    result = unknown.QueryInterface(COM.IIDFromString(classUUID), interfacePtr)
		    
		    '0-2 for IUnknown, 3-5 for IInspectable, 6 for GetColorValue
		    Var func As New GetColorValueFunc(interfacePtr.Ptr(0).Ptr(6 * COM.SIZEOF_PTR))
		    
		    Var colorValue As UInt32
		    result = func.Invoke(interfacePtr, desiredColor, colorValue)
		    
		    Var r As UInt8 = Bitwise.ShiftRight(colorValue And &hFF00, 8, 32)
		    Var g As UInt8 = Bitwise.ShiftRight(colorValue And &hFF0000, 16, 32)
		    Var b As UInt8 = Bitwise.ShiftRight(colorValue And &hFF000000, 24, 32)
		    Var a As UInt8 = Not Bitwise.ShiftRight(colorValue And &hFF, 0, 32)
		    
		    Var convertedColor As Color = Color.RGB(r, g, b, a)
		    
		    Return convertedColor
		  #else
		    #Pragma Unused DesiredColor
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GridColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("gridColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cCCCCCC00, &cFFFFFFE6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HeaderTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("headerTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000027, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HighlightColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("highlightColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFFFFF00, &cB4B4B400)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Init()
		  #if TargetWindows
		    Try
		      If SystemInformationMBS.IsWindows10(True) Then
		        WindowsAccentColor = GetWindowsColorValue(WindowsColorTypes.Accent)
		        UseWindowsColors = True
		      End If
		    Catch Err As RuntimeException
		    End Try
		  #elseif TargetMacOS
		    MacIsMojave = SystemInformationMBS.isMojave(True)
		    MacIsHighSierra = SystemInformationMBS.isHighSierra(True)
		  #endif
		End Sub
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
		      // 10.0+
		      Return New ColorGroupMimic("keyboardFocusIndicatorColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c0067F4BF, &c1AA9FFB2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("labelColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("label")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000027, &cFFFFFF27)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LinkColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("linkColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("link")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c0068DA00, &c419CFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListEvenRowColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("primaryContentBackgroundColor")
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cfffefe00, &c16161600)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListOddRowColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("secondaryContentBackgroundColor")
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cf1f2f200, &cfffefef3)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PlaceholderTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("placeholderTextColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("placeholderText")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c000000C0, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function QuaternaryLabelColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("quaternaryLabelColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("quaternaryLabel")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c000000E6, &cFFFFFFE6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondaryLabelColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("secondaryLabelColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("secondaryLabel")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000080, &cFFFFFF73)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedContentBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("selectedContentBackgroundColor")
		      End If
		    #elseif TargetWindows
		      If UseWindowsColors Then
		        Return WindowsAccentColor
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c47156d00, &c5b188e00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedControlColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("selectedControlColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cB3D7FF00, &c3F638B00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedControlTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("selectedControlTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000027, &cFFFFFF27)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedMenuItemTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("selectedMenuItemTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTextBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("selectedTextBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cB3D7FF00, &c3F638B00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("selectedTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000000, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SeparatorColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("separatorColor")
		      End If
		    #elseif TargetiOS
		      Return New ColorGroupMimic("separator")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c000000E6, &cFFFFFFE6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShadowColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("shadowColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SupportsDualColors() As Boolean
		  Static mSupportsDualColors As Boolean
		  Static mDetected As Boolean
		  
		  If Not mDetected Then
		    #if TargetMacOS
		      mSupportsDualColors = XojoVersion >= 2021.01 Or MacIsMojave
		    #else
		      mSupportsDualColors = True
		    #endif
		    mDetected = True
		  End If
		  
		  Return mSupportsDualColors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemBlueColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemBlueColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemBlue")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c007AFF00, &c0A84FF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemBrownColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemBrownColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cA2845E00, &cAC8E6800)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemGrayColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemGrayColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemGray")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c8E8E9300, &c98989D00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemGreenColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemGreenColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemGreen")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c28CD4100, &c32D74B00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemOrangeColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemOrangeColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemOrange")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFF950000, &cFF9F0A00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemPinkColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemPinkColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemPink")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFF2D5500, &cFF375F00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemPurpleColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemPurpleColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemPurple")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cAF52DE00, &cBF5AF200)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemRedColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemRedColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemRed")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFF3B3000, &cFF453A00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemYellowColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("systemYellowColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("systemYellow")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFCC0000, &cFFD60A00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TertiaryLabelColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.10+
		      Return New ColorGroupMimic("tertiaryLabelColor")
		    #elseif TargetiOS
		      Return New ColorGroupMimic("tertiaryLabel")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c000000C0, &cFFFFFFC0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("textBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cFFFFFF00, &c1E1E1E00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("textColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000000, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnderPageBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.8+
		      Return New ColorGroupMimic("underPageBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c9696961A, &c28282800)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedContentBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("unemphasizedSelectedContentBackgroundColor")
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cDCDCDC00, &c46464600)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedTextBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("unemphasizedSelectedTextBackgroundColor")
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cDCDCDC00, &c46464600)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnemphasizedSelectedTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.14+
		      If MacIsMojave Then
		        Return New ColorGroupMimic("unemphasizedSelectedTextColor")
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000000, &cFFFFFF00)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WindowBackgroundColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("windowBackgroundColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&cECECEC00, &c32323200)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WindowFrameTextColor() As Color
		  Try
		    #if TargetMacOS
		      // 10.0+
		      Return New ColorGroupMimic("windowFrameTextColor")
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New ColorGroupMimic(&c00000027, &cFFFFFF27)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private MacIsHighSierra As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MacIsMojave As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UseWindowsColors As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private WindowsAccentColor As Color
	#tag EndProperty


	#tag Enum, Name = WindowsColorTypes, Type = Integer, Flags = &h21
		Accent = 5
	#tag EndEnum


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
