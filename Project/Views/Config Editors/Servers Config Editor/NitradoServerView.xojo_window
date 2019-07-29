#tag Window
Begin ServerViewContainer NitradoServerView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   600
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   600
   Begin Beacon.OAuth2Client Auth
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Provider        =   ""
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin BeaconToolbar Controls
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Untitled"
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "False"
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   600
   End
   Begin FadedSeparator ControlsSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   600
   End
   Begin UITweaks.ResizedLabel ServerStatusLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Server Status:"
      TextAlign       =   "2"
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Value           =   "Server Status:"
      Visible         =   True
      Width           =   110
   End
   Begin Timer RefreshTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   "0"
      Period          =   5000
      RunMode         =   "0"
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin UITweaks.ResizedLabel ServerStatusField
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   142
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Checking…"
      TextAlign       =   "0"
      TextAlignment   =   "1"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Value           =   "Checking…"
      Visible         =   True
      Width           =   438
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   103
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   580
   End
   Begin UITweaks.ResizedTextField ServerNameField
      AcceptTabs      =   False
      Alignment       =   "0"
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      HelpTag         =   ""
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   142
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   124
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   438
   End
   Begin UITweaks.ResizedLabel ServerNameLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Server Name:"
      TextAlign       =   "2"
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   124
      Transparent     =   False
      Underline       =   False
      Value           =   "Server Name:"
      Visible         =   True
      Width           =   110
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.Auth.Provider = Beacon.OAuth2Client.ProviderNitrado
		  Self.Auth.AuthData = Self.mDocument.OAuthData("Nitrado")
		  Self.Auth.Authenticate(App.IdentityManager.CurrentIdentity)
		  
		  Self.Controls.Caption = Self.mProfile.Name
		  
		  Self.ServerNameField.Value = Self.mProfile.Name
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Callback_ServerStatus(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.Closed Then
		    Return
		  End If
		  
		  If Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    Dim Data As Dictionary = Response.Value("data")
		    Dim GameServer As Dictionary = Data.Value("gameserver")
		    
		    Dim ServerStatus As String = GameServer.Value("status")
		    Dim Started, Enabled As Boolean
		    Select Case ServerStatus
		    Case "started"
		      Self.ServerStatusField.Value = "Running"
		      Started = True
		      Enabled = True
		    Case "stopped"
		      Self.ServerStatusField.Value = "Stopped"
		      Started = False
		      Enabled = True
		    Case "stopping"
		      Self.ServerStatusField.Value = "Stopping"
		      Started = True
		      Enabled = False
		    Case "restarting"
		      Self.ServerStatusField.Value = "Restarting"
		      Started = False
		      Enabled = False
		    Case "suspended"
		      Self.ServerStatusField.Value = "Suspended"
		      Started = False
		      Enabled = False
		    Case "guardian_locked"
		      Self.ServerStatusField.Value = "Locked by Guardian"
		      Started = False
		      Enabled = False
		    Case "gs_installation"
		      Self.ServerStatusField.Value = "Switching games"
		      Started = False
		      Enabled = False
		    Case "backup_restore"
		      Self.ServerStatusField.Value = "Restoring from backup"
		      Started = False
		      Enabled = False
		    Case "backup_creation"
		      Self.ServerStatusField.Value = "Creating backup"
		      Started = False
		      Enabled = False
		    End Select
		    
		    Self.Controls.PowerButton.Enabled = Enabled
		    Self.Controls.PowerButton.Toggled = Started
		    Self.Controls.PowerButton.HelpTag = If(Started, "Stop the server.", "Start the server.")
		  Catch Err As RuntimeException
		    Self.Controls.PowerButton.Enabled = False
		    Self.Controls.PowerButton.Toggled = False
		    Self.Controls.PowerButton.HelpTag = "Server state unknown. Cannot start or stop."
		    Self.ServerStatusField.Value = "Unknown"
		  End Try
		  
		  Self.RefreshTimer.RunMode = Timer.RunModes.Single
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerToggle(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Content
		  #Pragma Unused Tag
		  
		  If Self.Closed Then
		    Return
		  End If
		  
		  If Self.CheckError(Status) Then
		    Return
		  End If
		  
		  // Doesn't really matter, just refresh
		  Self.RefreshTimer.Reset
		  Self.RefreshServerStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckError(Status As Integer) As Boolean
		  Select Case Status
		  Case 401
		    Self.ShowAlert("Nitrado API Error", "You are not authorized to query this server.")
		    Return True
		  Case 429
		    Self.ShowAlert("Nitrado API Error", "Rate limit has been exceeded.")
		    Return True
		  Case 503
		    Self.ShowAlert("Nitrado API Error", "Nitrado is currently offline for maintenace.")
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Document As Beacon.Document, Profile As Beacon.NitradoServerProfile)
		  Self.mDocument = Document
		  Self.mProfile = Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshServerStatus()
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.Auth.AccessToken
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers", AddressOf Callback_ServerStatus, Nil, Headers)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBrowser As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthWindow As OAuthAuthorizationWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.NitradoServerProfile
	#tag EndProperty


#tag EndWindowCode

#tag Events Auth
	#tag Event
		Sub Authenticated()
		  Self.mDocument.OAuthData("Nitrado") = Me.AuthData
		  Self.RefreshServerStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function StartAuthentication(URL As String, Provider As String) As Boolean
		  If Not Self.ShowConfirm("You must reauthorize " + Provider + " to allow Beacon to access your servers.", "The authorization tokens expires. If it has been a while since you've deployed, this can happen.", "Continue", "Cancel") Then
		    Return False
		  End If
		  
		  ShowURL(URL)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub DismissWaitingWindow()
		  If Self.mOAuthWindow <> Nil Then
		    Self.mOAuthWindow.Close
		    Self.mOAuthWindow = Nil
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShowWaitingWindow()
		  Self.mOAuthWindow = New OAuthAuthorizationWindow(Me)
		  Self.mOAuthWindow.Show()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Controls
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "PowerButton"
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.Auth.AccessToken
		    
		    If Item.Toggled Then
		      Dim FormData As New Dictionary
		      FormData.Value("message") = "Server stopped by Beacon (https://beaconapp.cc)"
		      FormData.Value("stop_message") = "Server is now stopping."
		      
		      SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/stop", FormData, AddressOf Callback_ServerToggle, Nil, Headers)
		    Else
		      Dim FormData As New Dictionary
		      FormData.Value("message") = "Server started by Beacon (https://beaconapp.cc)"
		      
		      SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/restart", FormData, AddressOf Callback_ServerToggle, Nil, Headers)
		    End If
		    
		    Item.Enabled = False
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("PowerButton", IconToolbarPower, False, "Start or stop the server."))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshTimer
	#tag Event
		Sub Action()
		  Self.RefreshServerStatus()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerNameField
	#tag Event
		Sub TextChange()
		  Self.mProfile.Name = Me.Value
		  Self.Controls.Caption = Me.Value
		  Self.Changed = Self.mProfile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		EditorType="String"
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
		EditorType="Boolean"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
