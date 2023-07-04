#tag DesktopWindow
Begin DesktopWindow UserWelcomeWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   True
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   360
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   360
   MinimumWidth    =   640
   Resizeable      =   False
   Title           =   "Welcome to Beacon"
   Type            =   1
   Visible         =   True
   Width           =   640
   Begin DesktopPagePanel PagePanel1
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   360
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   216
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   424
      Begin DesktopLabel PrivacyMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Welcome to Beacon"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin DesktopLabel PrivacyExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   36
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Beacon stores fully anonymous user data to provide community project sharing and cloud storage features."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin LinkLabel PrivacyPolicyLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         ShowAsLink      =   True
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "See how Beacon manages your data…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   True
         URL             =   ""
         Visible         =   True
         Width           =   384
      End
      Begin UITweaks.ResizedPushButton ContinueAnonymousButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Use Anonymously"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   192
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPushButton ContinueAuthenticatedButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Use a Beacon Account"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   160
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPushButton DisableOnlineButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Use Offline"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   224
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPushButton QuitButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Quit"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   256
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin DesktopProgressWheel WelcomePageSpinner
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   236
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         Tooltip         =   ""
         Top             =   324
         Transparent     =   False
         Visible         =   False
         Width           =   16
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopHTMLViewer LoginView
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   360
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   216
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Renderer        =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Visible         =   True
         Width           =   424
      End
      Begin DesktopLabel InitializingMessage
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   320
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Connecting…"
         TextAlignment   =   2
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
   End
   Begin DesktopCanvas SidebarCanvas
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   360
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   216
   End
   Begin URLConnection OAuthStartSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection OAuthRedeemSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Thread RefreshAndCloseThread
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  App.NextLaunchQueueTask()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  #if TargetMacOS
		    Self.NSWindowMBS.styleMask = Self.NSWindowMBS.styleMask Or NSWindowMBS.NSFullSizeContentViewWindowMask
		    Self.NSWindowMBS.titlebarAppearsTransparent = True
		    Self.NSWindowMBS.titleVisibility = NSWindowMBS.NSWindowTitleHidden
		  #endif
		  
		  If Self.mLoginOnly Then
		    Self.StartOAuth(Nil)
		  Else
		    Preferences.OnlineEnabled = False
		  End If
		  
		  If Beacon.SafeToInvoke(Self.mExecuteAfterPresent) Then
		    Self.mExecuteAfterPresent.Invoke(Self)
		  End If
		  Self.mExecuteAfterPresent = Nil
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Collapse()
		  For Idx As Integer = Self.mAnimationTasks.LastIndex DownTo 0
		    Self.mAnimationTasks(Idx).Cancel
		    Self.mAnimationTasks.RemoveAt(Idx)
		  Next
		  
		  Var CollapsedWidth As Integer = 640
		  Var CollapsedHeight As Integer = 360
		  If Self.Width = CollapsedWidth And Self.Height = CollapsedHeight Then
		    Return
		  End If
		  
		  Var Task As AnimationKit.MoveTask
		  
		  Task = New AnimationKit.MoveTask(Self)
		  Task.Width = CollapsedWidth
		  Task.Height = CollapsedHeight
		  Task.Left = Self.Left + ((Self.Width - Task.Width) / 2)
		  Task.DurationInSeconds = Self.AnimationTime
		  Task.Curve = AnimationKit.Curve.CreateEaseOut
		  Task.Run
		  Self.mAnimationTasks.Add(Task)
		  
		  Task = New AnimationKit.MoveTask(Self.SidebarCanvas)
		  Task.Left = 0
		  Task.Height = CollapsedHeight
		  Task.DurationInSeconds = Self.AnimationTime
		  Task.Curve = AnimationKit.Curve.CreateEaseOut
		  Task.Run
		  Self.mAnimationTasks.Add(Task)
		  
		  Task = New AnimationKit.MoveTask(Self.PagePanel1)
		  Task.Left = Self.SidebarCanvas.Width
		  Task.Width = CollapsedWidth - Self.SidebarCanvas.Width
		  Task.Height = CollapsedHeight
		  Task.DurationInSeconds = Self.AnimationTime
		  Task.Curve = AnimationKit.Curve.CreateEaseOut
		  Task.Run
		  Self.mAnimationTasks.Add(Task)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Just here to block calling with New
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(LoginOnly As Boolean, ExecuteAfterPresent As UserWelcomeWindow.ExecuteAfterPresentDelegate)
		  Self.mLoginOnly = LoginOnly
		  Self.mExecuteAfterPresent = ExecuteAfterPresent
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ExecuteAfterPresentDelegate(WelcomeWindow As UserWelcomeWindow)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub Expand()
		  For Idx As Integer = Self.mAnimationTasks.LastIndex DownTo 0
		    Self.mAnimationTasks(Idx).Cancel
		    Self.mAnimationTasks.RemoveAt(Idx)
		  Next
		  
		  Var ExpandedWidth As Integer = 800
		  Var ExpandedHeight As Integer = (ExpandedWidth / 1.6) + Self.LoginView.Top
		  If Self.Width = ExpandedWidth And Self.Height = ExpandedHeight Then
		    Return
		  End If
		  
		  Var Task As AnimationKit.MoveTask
		  
		  Task = New AnimationKit.MoveTask(Self)
		  Task.Width = ExpandedWidth
		  Task.Height = ExpandedHeight
		  Task.Left = Self.Left + ((Self.Width - Task.Width) / 2)
		  Task.DurationInSeconds = Self.AnimationTime
		  Task.Curve = AnimationKit.Curve.CreateEaseOut
		  Task.Run
		  Self.mAnimationTasks.Add(Task)
		  
		  Task = New AnimationKit.MoveTask(Self.SidebarCanvas)
		  Task.Left = Self.SidebarCanvas.Width * -1
		  Task.Height = ExpandedHeight
		  Task.DurationInSeconds = Self.AnimationTime
		  Task.Curve = AnimationKit.Curve.CreateEaseOut
		  Task.Run
		  Self.mAnimationTasks.Add(Task)
		  
		  Task = New AnimationKit.MoveTask(Self.PagePanel1)
		  Task.Left = 0
		  Task.Width = ExpandedWidth
		  Task.Height = ExpandedHeight
		  Task.DurationInSeconds = Self.AnimationTime
		  Task.Curve = AnimationKit.Curve.CreateEaseOut
		  Task.Run
		  Self.mAnimationTasks.Add(Task)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GenerateCodeVerifier() As String
		  Var Chars() As String
		  
		  Do
		    Var Bytes As MemoryBlock = Crypto.GenerateRandomBytes(128)
		    For Offset As Integer = 0 To Bytes.Size - 1
		      Var Codepoint As Integer = Bytes.Byte(Offset)
		      If Codepoint = 45 Or Codepoint = 46 Or Codepoint = 95 Or Codepoint = 126 Or (Codepoint >= 48 And Codepoint <= 57) Or (Codepoint >= 65 And Codepoint <= 90) Or (Codepoint >= 97 And Codepoint <= 122) Then
		        Var Char As String = Encodings.ASCII.Chr(Codepoint)
		        Chars.Add(Char)
		        If Chars.Count = 128 Then
		          Exit Do
		        End If
		      End If
		    Next
		  Loop
		  
		  Return String.FromArray(Chars, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleAnonymous()
		  Self.ContinueAnonymousButton.Enabled = False
		  Self.ContinueAuthenticatedButton.Enabled = False
		  Self.DisableOnlineButton.Enabled = False
		  Self.WelcomePageSpinner.Visible = True
		  
		  Preferences.OnlineEnabled = True
		  Preferences.BeaconAuth = Nil
		  
		  Var Identity As Beacon.Identity = App.IdentityManager.FetchAnonymous(True)
		  Self.StartOAuth(Identity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleAuthenticated()
		  Self.ContinueAnonymousButton.Enabled = False
		  Self.ContinueAuthenticatedButton.Enabled = False
		  Self.DisableOnlineButton.Enabled = False
		  Self.WelcomePageSpinner.Visible = True
		  
		  Preferences.OnlineEnabled = True
		  Preferences.BeaconAuth = Nil
		  
		  Self.StartOAuth(Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDisableOnline()
		  Preferences.OnlineEnabled = False
		  Preferences.BeaconAuth = Nil
		  
		  Call App.IdentityManager.FetchAnonymous(true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsPresent() As Boolean
		  Return mIsPresent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(LoginOnly As Boolean, ExecuteAfterPresent As UserWelcomeWindow.ExecuteAfterPresentDelegate = Nil)
		  If mIsPresent = True Or (Thread.Current Is Nil) = False Then
		    Return
		  End If
		  
		  mIsPresent = True
		  Var Win As New UserWelcomeWindow(LoginOnly, ExecuteAfterPresent)
		  Win.ShowModal()
		  mIsPresent = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RedeemOAuth(Code As String)
		  Var Params As New Dictionary
		  Params.Value("client_id") = BeaconAPI.ClientId
		  Params.Value("code") = Code
		  Params.Value("grant_type") = "authorization_code"
		  Params.Value("redirect_uri") = Self.RedirectUri
		  Params.Value("code_verifier") = Self.mOAuthChallenge
		  
		  Self.OAuthRedeemSocket.SetRequestContent(Beacon.GenerateJSON(Params, False), "application/json")
		  Self.OAuthRedeemSocket.Send("POST", BeaconAPI.URL("/login"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveOAuthResponse(Response As String)
		  Var Token As BeaconAPI.OAuthToken = BeaconAPI.OAuthToken.Load(Response)
		  Preferences.OnlineEnabled = (Token Is Nil) = False
		  Preferences.BeaconAuth = Token
		  
		  Self.InitializingMessage.Text = "Downloading user details…"
		  Self.PagePanel1.SelectedPanelIndex = Self.PageInitializing
		  Self.Collapse()
		  
		  Self.RefreshAndCloseThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowError(Message As String, HTTPStatus As Integer)
		  App.Log(Message + " HTTP " + HTTPStatus.ToString(Locale.Raw, "0") + " error.")
		  
		  Select Case HTTPStatus
		  Case 404
		    Self.ShowAlert(Message, "The connector was not found. Please contact help@usebeacon.app for support.")
		  Case 403, 401
		    Self.ShowAlert(Message, "The connector thinks this request is not authorized. Please contact help@usebeacon.app for support.")
		  Case 400
		    Self.ShowAlert(Message, "The connector received incorrect parameters. Please contact help@usebeacon.app for support.")
		  Case 500
		    Self.ShowAlert(Message, "The connector had an error. Please contact help@usebeacon.app for support.")
		  Else
		    Self.ShowAlert(Message, "The connector returned HTTP status " + HTTPStatus.ToString(Locale.Raw, "0") + " which Beacon was not prepared for. Please contact help@usebeacon.app for support.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowError(Message As String, Err As RuntimeException)
		  App.Log(Err, CurrentMethodName, Message)
		  
		  Const Explanation = "Press the ""System Status"" button to check on the status of Beacon's services. If Beacon is working correctly, check your internet connection."
		  
		  Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm(Message, Explanation, "System Status", "Cancel", "Help")
		  Select Case Choice
		  Case BeaconUI.ConfirmResponses.Action
		    System.GotoURL("https://status.usebeacon.app/")
		  Case BeaconUI.ConfirmResponses.Alternate
		    System.GotoURL(Beacon.WebURL("/help/solving_connection_problems_to"))
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartOAuth(WithIdentity As Beacon.Identity = Nil)
		  Self.mOAuthState = Beacon.UUID.v4
		  Self.InitializingMessage.Text = "Starting authentication…"
		  Self.PagePanel1.SelectedPanelIndex = Self.PageInitializing
		  
		  Var Params As New Dictionary
		  Params.Value("state") = Self.mOAuthState
		  Params.Value("client_id") = BeaconAPI.ClientId
		  Params.Value("no_redirect") = "true"
		  
		  Var Scopes() As String = Array("common", "users:read")
		  If WithIdentity Is Nil Then
		    Scopes.Add("users.private_key:read")
		    
		    Self.mOAuthChallenge = Self.GenerateCodeVerifier()
		    
		    Params.Value("redirect_uri") = Self.RedirectUri
		    Params.Value("response_type") = "code"
		    Params.Value("code_challenge") = EncodeBase64URLMBS(Crypto.Hash(Self.mOAuthChallenge, Crypto.HashAlgorithms.SHA2_256))
		    Params.Value("code_challenge_method") = "S256"
		    Params.Value("public_key") = Preferences.DevicePublicKey
		  Else
		    Scopes.Add("auth.public_key:create")
		    
		    Var Expiration As String = Ceiling(DateTime.Now.SecondsFrom1970 + 90).ToString(Locale.Raw, "0")
		    Var StringToSign As String = WithIdentity.UserId + ";" + Expiration
		    Var Signature As String = EncodeBase64URLMBS(WithIdentity.Sign(StringToSign))
		    
		    Params.Value("user_id") = WithIdentity.UserId
		    Params.Value("expiration") = Expiration
		    Params.Value("signature") = Signature
		    Params.Value("public_key") = WithIdentity.PublicKey()
		  End If 
		  Params.Value("scope") = String.FromArray(Scopes, " ")
		  
		  Var Query As String = SimpleHTTP.BuildFormData(Params)
		  Self.OAuthStartSocket.Send("GET", BeaconAPI.URL("/login?" + Query))
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAnimationTasks() As AnimationKit.MoveTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExecuteAfterPresent As UserWelcomeWindow.ExecuteAfterPresentDelegate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mIsPresent As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginOnly As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthChallenge As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthState As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseRecoverLanguage As Boolean
	#tag EndProperty


	#tag Constant, Name = AnimationTime, Type = Double, Dynamic = False, Default = \"0.15", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageInitializing, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLogin, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PagePrivacy, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RedirectUri, Type = String, Dynamic = False, Default = \"beacon://oauth", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events PrivacyPolicyLabel
	#tag Event
		Sub Pressed()
		  System.GotoURL(Beacon.WebURL("/help/about_user_privacy"))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.SizeToFit
		  Me.Left = Self.PagePanel1.Left + ((Self.PagePanel1.Width - Me.Width) / 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContinueAnonymousButton
	#tag Event
		Sub Pressed()
		  Self.HandleAnonymous()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContinueAuthenticatedButton
	#tag Event
		Sub Pressed()
		  Self.HandleAuthenticated()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DisableOnlineButton
	#tag Event
		Sub Pressed()
		  Self.HandleDisableOnline()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events QuitButton
	#tag Event
		Sub Pressed()
		  Quit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginView
	#tag Event
		Sub DocumentComplete(url as String)
		  #Pragma Unused url
		  
		  If Self.PagePanel1.SelectedPanelIndex <> Self.PageLogin Then
		    Self.PagePanel1.SelectedPanelIndex = Self.PageLogin
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CancelLoad(URL as String) As Boolean
		  If Url.BeginsWith(Self.RedirectUri) Then
		    Var Query As String = Url.Middle(Url.IndexOf("?") + 1)
		    Var Params As New Dictionary
		    Var QueryVars() As String = Query.Split("&")
		    For Each QueryVar As String In QueryVars
		      Var Pos As Integer = QueryVar.IndexOf("=")
		      Var Key As String = QueryVar.Left(Pos)
		      Var Value As String = QueryVar.Middle(Pos + 1)
		      Params.Value(DecodeURLComponent(Key).DefineEncoding(Encodings.ASCII)) = DecodeURLComponent(Value).DefineEncoding(Encodings.ASCII)
		    Next
		    
		    Var State As String = Params.Lookup("state", "")
		    Var Code As String = Params.Lookup("code", "")
		    If State <> Self.mOAuthState Then
		      Self.ShowAlert("There was an error with the authorization process.", "The authorization did not finish correctly.")
		      Self.Close
		      Return True
		    End If
		    
		    Self.RedeemOAuth(Code)
		    
		    Return True
		  ElseIf Url = "beacon://dismiss" Then
		    If Self.mLoginOnly Then
		      Self.Close
		    Else
		      Self.Collapse
		      Self.PagePanel1.SelectedPanelIndex = Self.PagePrivacy
		    End If
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function NewWindow(url as String) As DesktopHTMLViewer
		  System.GotoURL(URL)
		  Return Nil
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SidebarCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused Areas
		  
		  G.ClearRectangle(0, 0, G.Width, G.Height)
		  
		  If Not SystemColors.IsDarkMode Then
		    Var Scale As Double = G.Height / LoginSidebarBackground.Height
		    Var ScaledWidth As Integer = Ceiling(LoginSidebarBackground.Width * Scale)
		    Var ScaledHeight As Integer = Ceiling(LoginSidebarBackground.Height * Scale)
		    G.DrawPicture(LoginSidebarBackground, G.Width - (ScaledWidth + 1), (G.Height - ScaledHeight) / 2, ScaledWidth, ScaledHeight, 0, 0, LoginSidebarBackground.Width, LoginSidebarBackground.Height)
		  End If
		  
		  G.DrawPicture(LoginSidebarLogo, 0, (G.Height - LoginSidebarLogo.Height) / 2)
		  
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRectangle(G.Width - 1, 0, G.Width - 1, G.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OAuthStartSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  Self.ContinueAnonymousButton.Enabled = True
		  Self.ContinueAuthenticatedButton.Enabled = True
		  Self.DisableOnlineButton.Enabled = True
		  Self.WelcomePageSpinner.Visible = False
		  
		  If HTTPStatus = 200 Or HTTPStatus = 302 Then
		    // Show html viewer
		    Var LoginUrl As String
		    If HTTPStatus = 200 Then
		      If Me.ResponseHeader("Content-Type").BeginsWith("application/json") Then
		        Var Parsed As Dictionary = Beacon.ParseJSON(Content)
		        LoginUrl = Parsed.Value("login_url")
		      Else
		        LoginUrl = URL
		      End If
		    ElseIf HTTPStatus = 302 Then
		      LoginUrl = Me.ResponseHeader("Location")
		    End If
		    
		    Self.LoginView.LoadURL(LoginURL)
		    Self.Expand()
		  ElseIf HTTPStatus = 201 Then
		    // Session started
		    Self.SaveOAuthResponse(Content)
		  Else
		    // Something else
		    Break
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Break
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OAuthRedeemSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  If HTTPStatus = 201 Then
		    Self.SaveOAuthResponse(Content)
		  Else
		    Break
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Break
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshAndCloseThread
	#tag Event
		Sub Run()
		  BeaconAPI.UserController.RefreshUserDetails()
		  Me.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("Finished", False).BooleanValue = True Then
		      Self.Close
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
			"9 - Modeless Dialog"
		#tag EndEnumValues
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
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
