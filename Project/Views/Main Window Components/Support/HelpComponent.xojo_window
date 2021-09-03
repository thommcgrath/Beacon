#tag Window
Begin BeaconSubview HelpComponent
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   394
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   738
   Begin HTMLViewer HelpViewer
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   394
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
      Visible         =   True
      Width           =   738
   End
   Begin WebView2ControlMBS WinViewer
      AdditionalBrowserArguments=   ""
      AllowSingleSignOnUsingOSPrimaryAccount=   False
      areBrowserAcceleratorKeysEnabled=   False
      AreDefaultContextMenusEnabled=   True
      AreDefaultScriptDialogsEnabled=   False
      AreDevToolsEnabled=   False
      AreHostObjectsAllowed=   True
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   101
      Index           =   -2147483648
      InitialParent   =   ""
      IsBuiltInErrorPageEnabled=   True
      IsGeneralAutofillEnabled=   True
      IsPasswordAutosaveEnabled=   False
      IsPinchZoomEnabled=   False
      IsScriptEnabled =   True
      IsStatusBarEnabled=   False
      IsWebMessageEnabled=   False
      IsZoomControlEnabled=   False
      Language        =   ""
      Left            =   462
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
      Top             =   -151
      UserAgent       =   ""
      Visible         =   False
      Width           =   267
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  If WebView2ControlMBS.AvailableCoreWebView2BrowserVersionString.IsEmpty = False Then
		    Self.WinViewer.Visible = True
		    Self.HelpViewer.Visible = False
		    Self.WinViewer.Top = 0
		    Self.WinViewer.Left = 0
		    Self.WinViewer.Width = Self.Width
		    Self.WinViewer.Height = Self.Height
		    Self.WinViewer.UserAgent = App.UserAgent
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  If Self.mHelpLoaded Then
		    Return
		  End If
		  
		  Self.LoadURL(Self.HelpURL)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function HelpURL(ChildPath As String = "") As String
		  If ChildPath.IsEmpty = False And ChildPath.BeginsWith("/") = False Then
		    ChildPath = "/" + ChildPath
		  End If
		  
		  Return Beacon.WebURL("/help/" + App.BuildVersion + ChildPath)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadURL(URL As String)
		  If BeaconUI.WebContentSupported = False Then
		    System.GotoURL(URL)
		    Return
		  End If
		  
		  If Self.WinViewer.Visible Then
		    Self.WinViewer.LoadURL(URL)
		  Else
		    Self.HelpViewer.LoadURL(URL)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShouldCancel(URL As String) As Boolean
		  If Beacon.IsBeaconURL(URL) Then
		    Call App.HandleURL(URL, True)
		    Return True
		  End If
		  
		  Static TicketURL As String
		  If TicketURL.IsEmpty Then
		    TicketURL = Beacon.WebURL("/help/contact")
		  End If
		  If URL = TicketURL Then
		    App.StartTicket()
		    Return True
		  End If
		  
		  Static DiscordDetector As Regex
		  If DiscordDetector Is Nil Then
		    DiscordDetector = New Regex
		    DiscordDetector.SearchPattern = "^https?://(.+\.)?((discord\.com)|(discord\.gg)|(discord\.media)|(discordapp\.com)|(discordapp\.net))/"
		  End If
		  Var Matches As RegexMatch = DiscordDetector.Search(URL)
		  If (Matches Is Nil) = False Then
		    System.GotoURL(URL)
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHelpLoaded As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events HelpViewer
	#tag Event
		Sub DocumentComplete(url as String)
		  #Pragma Unused URL
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.HasProgressIndicator = False
		  End If
		  Self.mHelpLoaded = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub DocumentProgressChanged(URL as String, percentageComplete as Integer)
		  #Pragma Unused URL
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.Progress = PercentageComplete
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DocumentBegin(url as String)
		  #Pragma Unused URL
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.HasProgressIndicator = True
		    Self.LinkedOmniBarItem.Progress = OmniBarItem.ProgressIndeterminate
		  End If
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
		Sub Open()
		  Me.UserAgent = App.UserAgent
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WinViewer
	#tag Event
		Sub NavigationCompleted(isSuccess as Boolean, ErrorStatus as Integer, NavigationID as UInt64)
		  #Pragma Unused ErrorStatus
		  #Pragma Unused NavigationID
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.HasProgressIndicator = False
		  End If
		  If isSuccess Then
		    Self.mHelpLoaded = True
		  End If
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
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.HasProgressIndicator = True
		    Self.LinkedOmniBarItem.Progress = OmniBarItem.ProgressIndeterminate
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
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
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
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
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
