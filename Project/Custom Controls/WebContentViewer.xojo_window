#tag DesktopWindow
Begin DesktopContainer WebContentViewer
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   300
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
   Width           =   300
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Shared Function Available() As Boolean
		  #if TargetMacOS Or TargetLinux
		    Return True
		  #elseif TargetWindows
		    Return DesktopWebView2ControlMBS.AvailableCoreWebView2BrowserVersionString.IsEmpty = False
		  #else
		    Return False
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanGoBack() As Boolean
		  #if TargetWindows
		    Return DesktopWebView2ControlMBS(Self.mViewer).CanGoBack
		  #else
		    Return DesktopHTMLViewer(Self.mViewer).CanGoBack
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanGoForward() As Boolean
		  #if TargetWindows
		    Return DesktopWebView2ControlMBS(Self.mViewer).CanGoForward
		  #else
		    Return DesktopHTMLViewer(Self.mViewer).CanGoForward
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  #if TargetWindows
		    Var Viewer As New DesktopWebView2ControlMBS
		    Viewer.Left = 0
		    Viewer.Top = 0
		    Viewer.Width = Self.Width
		    Viewer.Height = Self.Height
		    Viewer.LockLeft = True
		    Viewer.LockTop = True
		    Viewer.LockRight = True
		    Viewer.LockBottom = True
		    Viewer.Visible = True
		    Viewer.Enabled = True
		    Viewer.UserAgent = App.UserAgent
		    Viewer.UserDataFolder = App.ApplicationSupport.NativePath
		    Self.AddControl(Viewer)
		    
		    AddHandler Viewer.DocumentTitleChanged, WeakAddressOf WebView2_DocumentTitleChanged
		    AddHandler Viewer.NavigationStarting, WeakAddressOf WebView2_NavigationStarting
		    AddHandler Viewer.NavigationCompleted, WeakAddressOf WebView2_NavigationCompleted
		    AddHandler Viewer.NewWindowRequested, WeakAddressOf WebView2_NewWindowRequested
		    
		    Self.mViewer = Viewer
		  #else
		    Var Viewer As New DesktopHTMLViewer
		    Viewer.Left = 0
		    Viewer.Top = 0
		    Viewer.Width = Self.Width
		    Viewer.Height = Self.Height
		    Viewer.LockLeft = True
		    Viewer.LockTop = True
		    Viewer.LockRight = True
		    Viewer.LockBottom = True
		    Viewer.Visible = True
		    Viewer.Enabled = True
		    Viewer.UserAgent = App.UserAgent
		    Self.AddControl(Viewer)
		    
		    AddHandler Viewer.CancelLoad, WeakAddressOf DesktopViewer_CancelLoad
		    AddHandler Viewer.DocumentBegin, WeakAddressOf DesktopViewer_DocumentBegin
		    AddHandler Viewer.DocumentComplete, WeakAddressOf DesktopViewer_DocumentComplete
		    AddHandler Viewer.DocumentProgressChanged, WeakAddressOf DesktopViewer_DocumentProgressChanged
		    AddHandler Viewer.JavaScriptRequest, WeakAddressOf DesktopViewer_JavaScriptRequest
		    AddHandler Viewer.NewWindow, WeakAddressOf DesktopViewer_NewWindow
		    AddHandler Viewer.TitleChanged, WeakAddressOf DesktopViewer_TitleChanged
		    
		    Self.mViewer = Viewer
		  #endif
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DesktopViewer_CancelLoad(Sender As DesktopHTMLViewer, URL As String) As Boolean
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused URL
		  #else
		    Return RaiseEvent CancelLoad(URL)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DesktopViewer_DocumentBegin(Sender As DesktopHTMLViewer, URL As String)
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused URL
		  #else
		    RaiseEvent DocumentBegin(URL)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DesktopViewer_DocumentComplete(Sender As DesktopHTMLViewer, URL As String)
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused URL
		  #else
		    RaiseEvent DocumentComplete(URL)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DesktopViewer_DocumentProgressChanged(Sender As DesktopHTMLViewer, URL As String, PercentageComplete As Integer)
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused URL
		    #Pragma Unused PercentageComplete
		  #else
		    RaiseEvent DocumentProgressChanged(URL, PercentageComplete)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DesktopViewer_Error(Sender As DesktopHTMLViewer, Error As RuntimeException)
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused Error
		  #else
		    RaiseEvent Error(Error)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DesktopViewer_JavaScriptRequest(Sender As DesktopHTMLViewer, Method As String, Parameters() As Variant) As String
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused Method
		    #Pragma Unused Parameters
		  #else
		    Return RaiseEvent JavaScriptRequest(Method, Parameters)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DesktopViewer_NewWindow(Sender As DesktopHTMLViewer, URL As String) As DesktopHTMLViewer
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused URL
		  #else
		    Var NewViewer As WebContentViewer = RaiseEvent NewWindow(URL)
		    If (NewViewer Is Nil) = False Then
		      Return DesktopHTMLViewer(NewViewer.mViewer)
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DesktopViewer_TitleChanged(Sender As DesktopHTMLViewer, NewTitle As String)
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    #Pragma Unused NewTitle
		  #else
		    RaiseEvent TitleChanged(NewTitle)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteJavaScript(Source As String)
		  #if TargetWindows
		    DesktopWebView2ControlMBS(Self.mViewer).ExecuteScript(Source)
		  #else
		    DesktopHTMLViewer(Self.mViewer).ExecuteJavaScript(Source)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GoBack()
		  #if TargetWindows
		    DesktopWebView2ControlMBS(Self.mViewer).GoBack
		  #else
		    DesktopHTMLViewer(Self.mViewer).GoBack
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GoForward()
		  #if TargetWindows
		    DesktopWebView2ControlMBS(Self.mViewer).GoForward
		  #else
		    DesktopHTMLViewer(Self.mViewer).GoForward
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadHTML(Source As String)
		  #if TargetWindows
		    DesktopWebView2ControlMBS(Self.mViewer).LoadHTML(Source)
		  #else
		    DesktopHTMLViewer(Self.mViewer).LoadPage(Source, Nil)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadURL(URL As String)
		  If Self.Available = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Web content is not supported on this platform."
		    RaiseEvent Error(Err)
		    Return
		  End If
		  
		  #if TargetWindows
		    DesktopWebView2ControlMBS(Self.mViewer).LoadURL(URL)
		  #else
		    DesktopHTMLViewer(Self.mViewer).LoadURL(URL)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserAgent() As String
		  #if TargetWindows
		    Return DesktopWebView2ControlMBS(Self.mViewer).UserAgent
		  #else
		    Return DesktopHTMLViewer(Self.mViewer).UserAgent
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserAgent(Assigns Agent As String)
		  #if TargetWindows
		    DesktopWebView2ControlMBS(Self.mViewer).UserAgent = Agent
		  #else
		    DesktopHTMLViewer(Self.mViewer).UserAgent = Agent
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WebView2_DocumentTitleChanged(Sender As DesktopWebView2ControlMBS)
		  #if TargetWindows
		    RaiseEvent TitleChanged(Sender.DocumentTitle)
		  #else
		    #Pragma Unused Sender
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WebView2_NavigationCompleted(Sender As DesktopWebView2ControlMBS, IsSuccess As Boolean, ErrorStatus As Integer, NavigationId As UInt64)
		  #Pragma Unused IsSuccess
		  #Pragma Unused ErrorStatus
		  #Pragma Unused NavigationId
		  
		  #if TargetWindows
		    RaiseEvent DocumentComplete(Sender.URL)
		  #else
		    #Pragma Unused Sender
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WebView2_NavigationStarting(Sender As DesktopWebView2ControlMBS, URL As String, IsUserInitiated As Boolean, IsRedirected As Boolean, NavigationId As UInt64) As Boolean
		  #Pragma Unused Sender
		  #Pragma Unused IsUserInitiated
		  #Pragma Unused IsRedirected
		  #Pragma Unused NavigationId
		  
		  #if TargetWindows
		    If RaiseEvent CancelLoad(URL) Then
		      Return True
		    End If
		    RaiseEvent DocumentBegin(URL)
		  #else
		    #Pragma Unused URL
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WebView2_NewWindowRequested(Sender As DesktopWebView2ControlMBS, URL As String, IsUserInitiated As Boolean, WindowFeatures As WebView2WindowFeaturesMBS, ByRef NewWindow As Variant) As Boolean
		  #Pragma Unused Sender
		  #Pragma Unused IsUserInitiated
		  #Pragma Unused WindowFeatures
		  
		  #if TargetWindows
		    Var NewViewer As WebContentViewer = RaiseEvent NewWindow(URL)
		    If (NewViewer Is Nil) = False Then
		      NewWindow = DesktopWebView2ControlMBS(NewViewer.mViewer)
		    End If
		    Return True
		  #else
		    #Pragma Unused URL
		    #Pragma Unused NewWindow
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WebView2_ProcessFailed(Sender As DesktopWebView2ControlMBS, ProcessFailedKind As Integer)
		  #Pragma Unused Sender
		  
		  #if TargetWindows
		    Var Err As New NetworkException
		    Err.ErrorNumber = ProcessFailedKind
		    RaiseEvent Error(Err)
		  #else
		    #Pragma Unused ProcessFailedKind
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CancelLoad(URL As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentBegin(URL As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentComplete(URL As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentProgressChanged(URL As String, PercentageComplete As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(Error As RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event JavaScriptRequest(Method As String, Parameters() As Variant) As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewWindow(URL As String) As WebContentViewer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TitleChanged(NewTitle As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mViewer As DesktopUIControl
	#tag EndProperty


#tag EndWindowCode

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
		Name="Super"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
