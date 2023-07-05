#tag DesktopWindow
Begin ServerViewContainer NitradoServerView
   AcceptFocus     =   "False"
   AcceptTabs      =   "True"
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   AutoDeactivate  =   "True"
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackColor    =   False
   Height          =   600
   HelpTag         =   ""
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
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   600
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   559
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin FadedSeparator FadedSeparator1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   103
         Transparent     =   True
         Visible         =   True
         Width           =   580
      End
      Begin UITweaks.ResizedLabel ServerStatusField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   168
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Checking…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   412
      End
      Begin UITweaks.ResizedLabel ServerStatusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Server Status:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   136
      End
      Begin BeaconTextArea AdminNotesField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   519
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   560
      End
      Begin CommonServerSettingsView SettingsView
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   496
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         SettingUp       =   False
         ShowsMapMenu    =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   104
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
   End
   Begin OmniBar ControlToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
   Begin Thread RefreshThread
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Beacon.Thread ToggleThread
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
		Sub Hidden()
		  Self.CancelRefresh()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  If Self.mRefreshKey.IsEmpty Then
		    Self.RefreshServerStatus()
		  End If
		  
		  Self.AdminNotesField.Text = Self.mProfile.AdminNotes
		  Self.SettingsView.RefreshUI()
		  Self.UpdateStatusDisplay()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CancelRefresh()
		  If Self.mRefreshKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mRefreshKey)
		    Self.mRefreshKey = ""
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Document As Ark.Project, Profile As Ark.NitradoServerProfile)
		  Self.mProject = Document
		  Self.mProfile = Profile
		  Self.mLock = New CriticalSection
		  Self.mServerState = Self.StatusChecking
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshServerStatus()
		  Self.CancelRefresh()
		  
		  If Self.RefreshThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.RefreshThread.Start
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScheduleRefresh()
		  Self.CancelRefresh()
		  
		  If Self.IsFrontmost Then
		    Self.mRefreshKey = CallLater.Schedule(5000, WeakAddressOf RefreshServerStatus)
		  Else
		    Self.mRefreshKey = ""
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StatusFromHTTPCode(HTTPStatus As Integer) As String
		  Select Case HTTPStatus
		  Case 401, 403
		    Self.mServerState = Self.StatusUnauthorized
		  Case 429
		    Self.mServerState = Self.StatusRateLimited
		  Case 502
		    Self.mServerState = Self.StatusBadGateway
		  Case 503
		    Self.mServerState = Self.StatusMaintenance
		  Else
		    #if DebugBuild
		      System.DebugLog("Nitrado status " + HTTPStatus.ToString)
		    #endif
		    Self.mServerState = Self.StatusNitradoOther
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatusDisplay()
		  Var Started As Boolean = Self.mServerState = Self.StatusStarted
		  Var ButtonEnabled As Boolean
		  Select Case Self.mServerState
		  Case Self.StatusStarted
		    Self.ServerStatusField.Text = "Running"
		    ButtonEnabled = True
		  Case Self.StatusStopped
		    Self.ServerStatusField.Text = "Stopped"
		    ButtonEnabled = True
		  Case Self.StatusStopping
		    Self.ServerStatusField.Text = "Stopping"
		  Case Self.StatusRestarting
		    Self.ServerStatusField.Text = "Starting"
		  Case Self.StatusSuspended
		    Self.ServerStatusField.Text = "Suspended"
		  Case Self.StatusGuardianLocked
		    Self.ServerStatusField.Text = "Locked by guardian"
		  Case Self.StatusGameserverInstallation
		    Self.ServerStatusField.Text = "Switching games"
		  Case Self.StatusBackupRestore
		    Self.ServerStatusField.Text = "Restoring from backup"
		  Case Self.StatusBackupCreation
		    Self.ServerStatusField.Text = "Creating backup"
		  Case Self.StatusChecking
		    Self.ServerStatusField.Text = "Checking…"
		  Case Self.StatusException
		    Self.ServerStatusField.Text = "Beacon error"
		  Case Self.StatusBadGateway
		    Self.ServerStatusField.Text = "Unexpected Nitrado outage"
		  Case Self.StatusEncryptedToken
		    Self.ServerStatusField.Text = "Token is encrypted. Ask the project owner to resave."
		  Case Self.StatusMaintenance
		    Self.ServerStatusField.Text = "Nitrado is down for maintenance"
		  Case Self.StatusMissingProfile
		    Self.ServerStatusField.Text = "Missing profile. Try a server list refresh."
		  Case Self.StatusMissingToken
		    Self.ServerStatusField.Text = "Missing token. Try a server list refresh."
		  Case Self.StatusNitradoOther
		    Self.ServerStatusField.Text = "Unknown Nitrado error"
		  Case Self.StatusUnauthorized
		    Self.ServerStatusField.Text = "Unauthorized. The token may have been revoked."
		  Case Self.StatusNetworkError
		    Self.ServerStatusField.Text = "Network error. This is likely an outage between you and Nitrado."
		  Else
		    Self.ServerStatusField.Text = "Unknown state: " + Self.mServerState
		  End Select
		  
		  Self.ControlToolbar.Item("PowerButton").Enabled = ButtonEnabled
		  Self.ControlToolbar.Item("PowerButton").Toggled = Started
		  Self.ControlToolbar.Item("PowerButton").HelpTag = If(Started, "Stop the server", "Start the server")
		  Self.ControlToolbar.Item("PowerButton").Caption = If(Started, "Stop", "Start")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Ark.NitradoServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerState As String = "beacon_checking"
	#tag EndProperty


	#tag Constant, Name = StatusBackupCreation, Type = String, Dynamic = False, Default = \"backup_creation", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusBackupRestore, Type = String, Dynamic = False, Default = \"backup_restore", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusBadGateway, Type = String, Dynamic = False, Default = \"nitrado_bad_gateway", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusChecking, Type = String, Dynamic = False, Default = \"beacon_checking", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusEncryptedToken, Type = String, Dynamic = False, Default = \"beacon_encrypted_token", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusException, Type = String, Dynamic = False, Default = \"beacon_exception", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusGameserverInstallation, Type = String, Dynamic = False, Default = \"gs_installation", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusGuardianLocked, Type = String, Dynamic = False, Default = \"guardian_locked", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusMaintenance, Type = String, Dynamic = False, Default = \"nitrado_maintenance", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusMissingProfile, Type = String, Dynamic = False, Default = \"beacon_missing_profile", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusMissingToken, Type = String, Dynamic = False, Default = \"beacon_missing_token", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusNetworkError, Type = String, Dynamic = False, Default = \"network_error", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusNitradoOther, Type = String, Dynamic = False, Default = \"nitrado_other", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusRateLimited, Type = String, Dynamic = False, Default = \"nitrado_rate_limited", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusRestarting, Type = String, Dynamic = False, Default = \"restarting", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusStarted, Type = String, Dynamic = False, Default = \"started", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusStopped, Type = String, Dynamic = False, Default = \"stopped", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusStopping, Type = String, Dynamic = False, Default = \"stopping", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusSuspended, Type = String, Dynamic = False, Default = \"suspended", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusUnauthorized, Type = String, Dynamic = False, Default = \"nitrado_unauthorized", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events AdminNotesField
	#tag Event
		Sub TextChanged()
		  Self.mProfile.AdminNotes = Me.Text
		  Self.Modified = Self.mProfile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SettingsView
	#tag Event
		Sub ContentsChanged()
		  Self.Modified = Me.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Function GetProject() As Ark.Project
		  Return Self.mProject
		End Function
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Profile = Self.mProfile
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ControlToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTab("PageGeneral", "General"))
		  Me.Append(OmniBarItem.CreateTab("PageNotes", "Notes"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("PowerButton", "Stop", IconToolbarPower, "Stop the server", False))
		  Me.Item("PageGeneral").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "PageGeneral"
		    Self.Pages.SelectedPanelIndex = 0
		    Item.Toggled = True
		    Me.Item("PageNotes").Toggled = False
		  Case "PageNotes"
		    Self.Pages.SelectedPanelIndex = 1
		    Item.Toggled = True
		    Me.Item("PageGeneral").Toggled = False
		  Case "PowerButton"
		    If Self.mServerState = Self.StatusStarted Then
		      Var StopMessage As String = StopMessageDialog.Present(Self)
		      If StopMessage.IsEmpty Then
		        Return
		      End If
		      ToggleThread.UserData = StopMessage
		    End If
		    
		    ToggleThread.Start
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshThread
	#tag Event
		Sub Run()
		  Self.mLock.Enter
		  
		  If Self.mProfile Is Nil Or Self.mProfile.ProviderTokenId.IsEmpty Then
		    Self.mServerState = Self.StatusMissingProfile
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		    Self.ScheduleRefresh()
		    Return
		  End If
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Self.mProfile.ProviderTokenId, True)
		  If Token Is Nil Then
		    Self.mServerState = Self.StatusMissingToken
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		    Self.ScheduleRefresh()
		    Self.mLock.Leave
		    Return
		  End If
		  
		  If Token.IsEncrypted And Token.Decrypt(Self.mProject.ProviderTokenKey(Token.TokenId)) = False Then
		    Self.mServerState = Self.StatusEncryptedToken
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		    Self.ScheduleRefresh()
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Var Socket As New URLConnection
		  Socket.RequestHeader("Authorization") = Token.AuthHeaderValue
		  Socket.RequestHeader("User-Agent") = App.UserAgent
		  
		  Var Response As String
		  Try
		    Response = Socket.SendSync("GET", "https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers")
		  Catch Err As NetworkException
		    Self.mServerState = Self.StatusNetworkError
		  End Try
		  
		  If Response.IsEmpty = False Then
		    Select Case Socket.HTTPStatusCode
		    Case 200, 304
		      Try
		        Var Parsed As Dictionary = Beacon.ParseJSON(Response)
		        Var Data As Dictionary = Parsed.Value("data")
		        Var GameServer As Dictionary = Data.Value("gameserver")
		        
		        Self.mServerState = GameServer.Value("status")
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Trying to refresh server status")
		        Self.mServerState = Self.StatusException
		      End Try
		    Else
		      Self.mServerState = Self.StatusFromHTTPCode(Socket.HTTPStatusCode)
		    End Select
		  End If
		  
		  Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		  Self.ScheduleRefresh()
		  Self.mLock.Leave
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("RefreshStatus", False).BooleanValue = True Then
		      Self.UpdateStatusDisplay()
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ToggleThread
	#tag Event
		Sub Run()
		  Self.mLock.Enter
		  Self.CancelRefresh()
		  
		  If Self.mProfile Is Nil Or Self.mProfile.ProviderTokenId.IsEmpty Then
		    Self.mServerState = Self.StatusMissingProfile
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		    Self.ScheduleRefresh()
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Self.mProfile.ProviderTokenId, True)
		  If Token Is Nil Then
		    Self.mServerState = Self.StatusMissingToken
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		    Self.ScheduleRefresh()
		    Self.mLock.Leave
		    Return
		  End If
		  
		  If Token.IsEncrypted And Token.Decrypt(Self.mProject.ProviderTokenKey(Token.TokenId)) = False Then
		    Self.mServerState = Self.StatusEncryptedToken
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		    Self.ScheduleRefresh()
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Select Case Self.mServerState
		  Case Self.StatusStarted
		    Var FormData As New Dictionary
		    FormData.Value("message") = "Server stopped by Beacon"
		    FormData.Value("stop_message") = Me.UserData
		    
		    Var Socket As New URLConnection
		    Socket.RequestHeader("Authorization") = Token.AuthHeaderValue
		    Socket.RequestHeader("Connection") = "close"
		    Socket.RequestHeader("User-Agent") = App.UserAgent
		    Socket.SetRequestContent(Beacon.GenerateJSON(FormData, False), "application/json; chartset=utf-8")
		    
		    Try
		      Call Socket.SendSync("POST", "https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/stop")
		      If Socket.HTTPStatusCode = 200 Then
		        Self.mServerState = Self.StatusStopping
		      Else
		        Self.mServerState = Self.StatusFromHTTPCode(Socket.HTTPStatusCode)
		      End If
		    Catch Err As NetworkException
		      Self.mServerState = Self.StatusNetworkError
		    End Try
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		  Case Self.StatusStopped
		    Var FormData As New Dictionary
		    FormData.Value("message") = "Server started by Beacon"
		    FormData.Value("restart_message") = Nil
		    
		    Var Socket As New URLConnection
		    Socket.RequestHeader("Authorization") = Token.AuthHeaderValue
		    Socket.RequestHeader("Connection") = "close"
		    Socket.RequestHeader("User-Agent") = App.UserAgent
		    Socket.SetRequestContent(Beacon.GenerateJSON(FormData, False), "application/json; chartset=utf-8")
		    
		    Try
		      Call Socket.SendSync("POST", "https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/restart")
		      If Socket.HTTPStatusCode = 200 Then
		        Self.mServerState = Self.StatusRestarting
		      Else
		        Self.mServerState = Self.StatusFromHTTPCode(Socket.HTTPStatusCode)
		      End If
		    Catch Err As NetworkException
		      Self.mServerState = Self.StatusNetworkError
		    End Try
		    Me.AddUserInterfaceUpdate(New Dictionary("RefreshStatus": True))
		  Else
		    Me.AddUserInterfaceUpdate(New Dictionary("ShowAlert": True, "AlertMessage": "Cannot do that right now.", "AlertExplanation": "The server is neither started nor stopped. Please wait for the current process to finish."))
		  End Select
		  
		  Self.ScheduleRefresh()
		  Self.mLock.Leave
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("RefreshStatus", False).BooleanValue = True Then
		      Self.UpdateStatusDisplay()
		    End If
		    If Update.Lookup("ShowAlert", False).BooleanValue = True Then
		      Var AlertMessage As String = Update.Lookup("AlertMessage", "")
		      Var AlertExplanation As String = Update.Lookup("AlertExplanation", "")
		      Self.ShowAlert(AlertMessage, AlertExplanation)
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
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
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
#tag EndViewBehavior
