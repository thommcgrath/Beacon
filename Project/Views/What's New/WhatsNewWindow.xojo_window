#tag Window
Begin Window WhatsNewWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   True
   Height          =   413
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   413
   MaximumWidth    =   660
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   413
   MinimumWidth    =   660
   Resizeable      =   False
   Title           =   "What's New in Beacon"
   Type            =   0
   Visible         =   False
   Width           =   660
   Begin HTMLViewer Viewer
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   414
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Renderer        =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   False
      Width           =   660
   End
   Begin URLConnection PreflightSocket
      AllowCertificateValidation=   False
      Enabled         =   True
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin WebView2ControlMBS WinViewer
      AdditionalBrowserArguments=   ""
      AllowSingleSignOnUsingOSPrimaryAccount=   False
      areBrowserAcceleratorKeysEnabled=   False
      AreDefaultContextMenusEnabled=   False
      AreDefaultScriptDialogsEnabled=   True
      AreDevToolsEnabled=   False
      AreHostObjectsAllowed=   True
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   413
      Index           =   -2147483648
      InitialParent   =   ""
      IsBuiltInErrorPageEnabled=   True
      IsGeneralAutofillEnabled=   True
      IsPasswordAutosaveEnabled=   False
      IsPinchZoomEnabled=   False
      IsScriptEnabled =   True
      IsStatusBarEnabled=   False
      IsWebMessageEnabled=   True
      IsZoomControlEnabled=   False
      Language        =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TargetCompatibleBrowserVersion=   ""
      Tooltip         =   ""
      Top             =   -457
      UserAgent       =   ""
      Visible         =   False
      Width           =   660
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.mTopMargin = 20
		  Self.mLeftMargin = 20
		  Self.mBottomMargin = 20
		  Self.mRightMargin = 20
		  
		  #if false and TargetMacOS
		    Var Win As NSWindowMBS = Self.NSWindowMBS
		    Var FrameRect As NSRectMBS = Win.Frame
		    Var ContentRect As NSRectMBS = Win.ContentView.Frame
		    
		    Var TopBorder As Integer = FrameRect.Height - (ContentRect.Y + ContentRect.Height)
		    Var LeftBorder As Integer = ContentRect.X
		    Var BottomBorder As Integer = ContentRect.Y
		    Var RightBorder As Integer = FrameRect.Width - (ContentRect.X + ContentRect.Width)
		    
		    Self.mTopMargin = Max(Self.mTopMargin, TopBorder)
		    Self.mLeftMargin = Max(Self.mLeftMargin, LeftBorder)
		    Self.mBottomMargin = Max(Self.mBottomMargin, BottomBorder)
		    Self.mRightMargin = Max(Self.mRightMargin, RightBorder)
		    
		    Win.StyleMask = Win.StyleMask Or NSWindowMBS.NSFullSizeContentViewWindowMask
		    Win.TitlebarAppearsTransparent = True
		    Win.TitleVisibility = NSWindowMBS.NSWindowTitleHidden
		  #endif
		  
		  PreflightSocket.RequestHeader("User-Agent") = App.UserAgent
		  PreflightSocket.Send("HEAD", Beacon.WebURL("/welcome/?from=" + Self.mPreviousVersion.ToString("0") + "&to=" + App.BuildNumber.ToString))
		  
		  If WebView2ControlMBS.AvailableCoreWebView2BrowserVersionString.IsEmpty = False Then
		    Self.Viewer.Visible = False
		    Self.WinViewer.Top = 0
		    Self.WinViewer.Left = 0
		    Self.WinViewer.Width = Self.Width
		    Self.WinViewer.Height = Self.Height
		    Self.WinViewer.UserAgent = App.UserAgent
		    Self.WinViewer.Visible = True
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CloseLater()
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Self.mPreviousVersion = Preferences.NewestUsedBuild
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present()
		  Var Win As New WhatsNewWindow
		  
		  #Pragma Unused Win
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShouldCancel(URL As String) As Boolean
		  If URL.BeginsWith("beacon://finished") Then
		    Call CallLater.Schedule(1, AddressOf CloseLater)
		    Return True
		  ElseIf URL.BeginsWith("res://") Then
		    Return True
		  End If
		  
		  If URL.BeginsWith(Beacon.WebURL("/welcome")) = False Then
		    System.GotoURL(URL)
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBottomMargin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLeftMargin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreviousVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRightMargin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTopMargin As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events Viewer
	#tag Event
		Sub DocumentComplete(url as String)
		  #Pragma Unused URL
		  
		  Self.Visible = True
		  Self.Show
		  
		  Preferences.NewestUsedBuild = App.BuildNumber
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(errorNumber as Integer, errorMessage as String)
		  App.Log("Unable to load welcome content: " + ErrorNumber.ToString("0") + ", " + ErrorMessage)
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Function CancelLoad(URL as String) As Boolean
		  If Self.ShouldCancel(URL) Then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub TitleChanged(newTitle as String)
		  Self.Title = "What's new in Beacon: " + NewTitle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PreflightSocket
	#tag Event
		Sub Error(e As RuntimeException)
		  #Pragma Unused e
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub HeadersReceived(URL As String, HTTPStatus As Integer)
		  If HTTPStatus = 200 Then
		    If Self.WinViewer.Visible Then
		      Self.Visible = True // Has to be visible before loading
		      Self.WinViewer.LoadURL(URL)
		    Else
		      Self.Viewer.LoadURL(URL)
		    End If
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WinViewer
	#tag Event
		Sub NavigationCompleted(isSuccess as Boolean, ErrorStatus as Integer, NavigationID as UInt64)
		  #Pragma Unused NavigationID
		  
		  If isSuccess Then
		    Self.Visible = True
		    Self.Show
		    Me.Refresh
		    
		    Preferences.NewestUsedBuild = App.BuildNumber
		  Else
		    App.Log("Unable to load welcome content: " + ErrorStatus.ToString("0"))
		    
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DocumentTitleChanged()
		  Self.Title = "What's new in Beacon: " + Me.DocumentTitle
		End Sub
	#tag EndEvent
	#tag Event
		Function NavigationStarting(URL as String, IsUserInitiated as Boolean, IsRedirected as Boolean, NavigationID as UInt64) As Boolean
		  #Pragma Unused IsUserInitiated
		  #Pragma Unused IsRedirected
		  #Pragma Unused NavigationID
		  
		  If Self.ShouldCancel(URL) Then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub Configure()
		  Me.UserDataFolder = App.ApplicationSupport.Child("BrowserData").NativePath
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
