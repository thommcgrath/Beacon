#tag Window
Begin ServerViewContainer NitradoServerView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
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
   UseFocusRing    =   False
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
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Untitled"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
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
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
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
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
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
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
   Begin Timer RefreshTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   5000
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin UITweaks.ResizedLabel ServerStatusField
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
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
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   438
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
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
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
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
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   124
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   438
   End
   Begin UITweaks.ResizedLabel ServerNameLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
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
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   124
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.Auth.Provider = Beacon.OAuth2Client.ProviderNitrado
		  Self.Auth.AuthData = Self.mDocument.OAuthData("Nitrado")
		  Self.Auth.Authenticate
		  
		  Self.Controls.Caption = Self.mProfile.Name
		  
		  Self.ServerNameField.Text = Self.mProfile.Name
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Callback_ServerStatus(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.Closed Then
		    Return
		  End If
		  
		  If Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    Dim Data As Xojo.Core.Dictionary = Response.Value("data")
		    Dim GameServer As Xojo.Core.Dictionary = Data.Value("gameserver")
		    
		    Dim ServerStatus As Text = GameServer.Value("status")
		    Dim Started, Enabled As Boolean
		    Select Case ServerStatus
		    Case "started"
		      Self.ServerStatusField.Text = "Running"
		      Started = True
		      Enabled = True
		    Case "stopped"
		      Self.ServerStatusField.Text = "Stopped"
		      Started = False
		      Enabled = True
		    Case "stopping"
		      Self.ServerStatusField.Text = "Stopping"
		      Started = True
		      Enabled = False
		    Case "restarting"
		      Self.ServerStatusField.Text = "Restarting"
		      Started = False
		      Enabled = False
		    Case "suspended"
		      Self.ServerStatusField.Text = "Suspended"
		      Started = False
		      Enabled = False
		    Case "guardian_locked"
		      Self.ServerStatusField.Text = "Locked by Guardian"
		      Started = False
		      Enabled = False
		    Case "gs_installation"
		      Self.ServerStatusField.Text = "Switching games"
		      Started = False
		      Enabled = False
		    Case "backup_restore"
		      Self.ServerStatusField.Text = "Restoring from backup"
		      Started = False
		      Enabled = False
		    Case "backup_creation"
		      Self.ServerStatusField.Text = "Creating backup"
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
		    Self.ServerStatusField.Text = "Unknown"
		  End Try
		  
		  Self.RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerToggle(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
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
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.Auth.AccessToken
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToText + "/gameservers", AddressOf Callback_ServerStatus, Nil, Headers)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
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
		Function ShowURL(URL As Text) As Beacon.WebView
		  Return MiniBrowser.ShowURL(URL)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Controls
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "PowerButton"
		    Dim Headers As New Xojo.Core.Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.Auth.AccessToken
		    
		    If Item.Toggled Then
		      Dim FormData As New Xojo.Core.Dictionary
		      FormData.Value("message") = "Server stopped by Beacon (https://beaconapp.cc)"
		      FormData.Value("stop_message") = "Server is now stopping."
		      
		      SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToText + "/gameservers/stop", FormData, AddressOf Callback_ServerToggle, Nil, Headers)
		    Else
		      Dim FormData As New Xojo.Core.Dictionary
		      FormData.Value("message") = "Server started by Beacon (https://beaconapp.cc)"
		      
		      SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToText + "/gameservers/restart", FormData, AddressOf Callback_ServerToggle, Nil, Headers)
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
		  Self.mProfile.Name = Me.Text.ToText
		  Self.Controls.Caption = Me.Text
		  Self.ContentsChanged = Self.mProfile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
