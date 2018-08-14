#tag Window
Begin DiscoveryView FTPDiscoveryView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   352
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
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   352
      HelpTag         =   ""
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
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedPushButton ServerActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   312
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ServerCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   312
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField ServerPathField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Optional"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   118
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   278
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   462
      End
      Begin UITweaks.ResizedLabel ServerPathLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Path Prefix:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   278
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerPassField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   118
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   244
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   462
      End
      Begin UITweaks.ResizedLabel ServerPassLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Password:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   244
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerUserField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   118
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   210
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   462
      End
      Begin UITweaks.ResizedLabel ServerUserLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Username:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   210
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerPortField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   118
         LimitText       =   5
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   "#####"
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "21"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   176
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   173
      End
      Begin UITweaks.ResizedLabel ServerPortLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Port:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   176
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerHostField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   118
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
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   142
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   462
      End
      Begin UITweaks.ResizedLabel ServerHostLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Host:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   142
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin Label ServerMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Server Settings"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin GroupBox GroupBox1
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   ""
         Enabled         =   True
         Height          =   78
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         Visible         =   True
         Width           =   560
         Begin Label Label1
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   38
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "GroupBox1"
            Italic          =   False
            Left            =   40
            LockBottom      =   True
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Multiline       =   True
            Scope           =   2
            Selectable      =   False
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Beacon will securely send this information to the Beacon API server, which will perform the FTP work. The server will not store or log FTP information in any way."
            TextAlign       =   0
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   72
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   520
         End
      End
      Begin ProgressBar ImportingProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         Top             =   189
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin Label ImportingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Retreiving Required Files…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   157
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
   End
   Begin BeaconAPI.Socket APISocket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Beacon.ImportThread Importer
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   0
      Scope           =   2
      StackSize       =   ""
      State           =   ""
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 352
		  Self.PagePanel1.Value = 0
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  Self.SwapButtons()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Dim ContentHeight As Integer = ImportingLabel.Height + 12 + ImportingProgress.Height
		  Dim AvailableHeight As Integer = Self.Height - 40
		  
		  Dim ContentTop As Integer = 20 + ((AvailableHeight - ContentHeight) / 2)
		  ImportingLabel.Top = ContentTop
		  ImportingProgress.Top = ContentTop + ImportingLabel.Height + 12
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_Discovery(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  If Not Success Then
		    Self.ShowAlert("Unable to connect to server", "Server said '" + Message + "'")
		    Self.PagePanel1.Value = 0
		    Return
		  End If
		  
		  Dim Dict As Xojo.Core.Dictionary = Details
		  If Not Dict.HasAllKeys("Game.ini", "GameUserSettings.ini") Then
		    If Not Self.ShowConfirm("Could not find config files", "Beacon was unable to find the server's Game.ini and GameUserSettings.ini files. Would you like to continue without them?", "Continue", "Cancel") Then
		      Self.PagePanel1.Value = 0
		      Return
		    End If
		  End If
		  
		  Dim Pieces() As Text
		  Pieces.Append("host=" + Beacon.EncodeURLComponent(Self.ServerHostField.Text.ToText))
		  Pieces.Append("port=" + Beacon.EncodeURLComponent(Self.ServerPortField.Text.ToText))
		  Pieces.Append("user=" + Beacon.EncodeURLComponent(Self.ServerUserField.Text.ToText))
		  Pieces.Append("pass=" + Beacon.EncodeURLComponent(Self.ServerPassField.Text.ToText))
		  
		  Dim Query As Text = Text.Join(Pieces, "&")
		  Dim GamePath As Text = Dict.Value("Game.ini")
		  Dim SettingsPath As Text = Dict.Value("GameUserSettings.ini")
		  
		  Dim SettingsRequest As New BeaconAPI.Request("ftp.php?" + Query + "&path=" + Beacon.EncodeURLComponent(SettingsPath) + "&ref=GameUserSettings", "GET", WeakAddressOf APICallback_DownloadConfigFile)
		  SettingsRequest.Sign(App.Identity)
		  Self.APISocket.Start(SettingsRequest)
		  
		  Dim GameRequest As New BeaconAPI.Request("ftp.php?" + Query + "&path=" + Beacon.EncodeURLComponent(GamePath) + "&ref=Game", "GET", WeakAddressOf APICallback_DownloadConfigFile)
		  GameRequest.Sign(App.Identity)
		  Self.APISocket.Start(GameRequest)
		  
		  Self.mDiscoveredData = Dict
		  Self.mDownloadedSettings = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DownloadConfigFile(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer)
		  // GameUserSettings.ini will come first
		  
		  If Success Then
		    Dim Dict As Xojo.Core.Dictionary = Details
		    Dim Content As Text = Dict.Value("content")
		    Dim Ref As Text = Dict.Value("ref")
		    Self.Importer.AddContent(Content)
		    
		    Select Case Ref
		    Case "GameUserSettings"
		      Self.mDownloadedSettings = True
		    Case "Game"
		      If Self.mDownloadedSettings Then
		        Self.FinishDownloads()
		      Else
		        Break
		      End If
		    End Select
		  Else
		    If Self.PagePanel1.Value = 1 Then
		      Self.ShowAlert("Unable to download config", "Server said " + Message)
		      Self.PagePanel1.Value = 0
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginServerImport()
		  Self.DesiredHeight = 92
		  Self.PagePanel1.Value = 1
		  Self.Importer.Clear
		  
		  Dim Pieces() As Text
		  Pieces.Append("host=" + Beacon.EncodeURLComponent(Self.ServerHostField.Text.ToText))
		  Pieces.Append("port=" + Beacon.EncodeURLComponent(Self.ServerPortField.Text.ToText))
		  Pieces.Append("user=" + Beacon.EncodeURLComponent(Self.ServerUserField.Text.ToText))
		  Pieces.Append("pass=" + Beacon.EncodeURLComponent(Self.ServerPassField.Text.ToText))
		  If Self.ServerPathField.Text <> "" Then
		    Pieces.Append("path=" + Beacon.EncodeURLComponent(Self.ServerPathField.Text.ToText))
		  End If
		  
		  Dim URL As Text = "ftp.php/discover?" + Text.Join(Pieces, "&")
		  Dim DiscoveryRequest As New BeaconAPI.Request(URL, "GET", WeakAddressOf APICallback_Discovery)
		  DiscoveryRequest.Sign(App.Identity)
		  Self.APISocket.Start(DiscoveryRequest)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckServerActionButton()
		  Self.ServerActionButton.Enabled = ServerHostField.Text <> "" And Val(ServerPortField.Text) > 0 And ServerUserField.Text <> "" And ServerPassField.Text <> ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishDownloads()
		  Self.ImportingLabel.Text = "Parsing Config…"
		  Self.ImportingProgress.Maximum = 500
		  Self.Importer.Run
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDiscoveredData As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadedSettings As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events ServerActionButton
	#tag Event
		Sub Action()
		  Self.BeginServerImport()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerPathField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerPassField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerUserField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerPortField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerHostField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If Not Me.Finished Then
		    Dim Value As Integer = Self.ImportingProgress.Maximum * Me.Progress
		    If Self.ImportingProgress.Value <> Value Then
		      Self.ImportingProgress.Value = Value
		    End If
		    Return
		  End If
		  
		  Self.ImportingProgress.Value = Self.ImportingProgress.Maximum
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(ParsedData As Xojo.Core.Dictionary)
		  Dim Document As New Beacon.Document
		  
		  If Self.mDiscoveredData.HasKey("Maps") Then
		    Dim Maps() As Auto = Self.mDiscoveredData.Value("Maps")
		    Document.MapCompatibility = 0
		    For Each Map As Text In Maps
		      Select Case Map
		      Case "ScorchedEarth_P"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.ScorchedEarth.Mask
		      Case "Aberration_P"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.Aberration.Mask
		      Case "TheCenter"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.TheCenter.Mask
		      Case "Ragnarok"
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.Ragnarok.Mask
		      Else
		        // Unofficial maps will be tagged as The Island
		        Document.MapCompatibility = Document.MapCompatibility Or Beacon.Maps.TheIsland.Mask
		      End Select
		    Next
		  End If
		  
		  If ParsedData.HasKey("SessionName") Then
		    Try
		      Document.Title = ParsedData.Value("SessionName")
		    Catch Err As TypeMismatchException
		    End Try
		  End If
		  If Document.Title = "" Then
		    Dim Maps() As Beacon.Map = Document.Maps
		    If Maps.Ubound = 0 Then
		      Document.Title = Maps(0).Name + " Server"
		    Else
		      Document.Title = "Ark Cluster"
		    End If
		  End If
		  
		  Dim Profile As New Beacon.FTPServerProfile
		  Profile.Name = Document.Title
		  Profile.Host = ServerHostField.Text.ToText
		  Profile.Username = ServerUserField.Text.ToText
		  Profile.Password = ServerPassField.Text.ToText
		  Profile.Port = Val(ServerPortField.Text.ToText)
		  If Self.mDiscoveredData.HasKey("Game.ini") Then
		    Profile.GameIniPath = Self.mDiscoveredData.Value("Game.ini")
		  End If
		  If Self.mDiscoveredData.HasKey("GameUserSettings.ini") Then
		    Profile.GameUserSettingsIniPath = Self.mDiscoveredData.Value("GameUserSettings.ini")
		  End If
		  Document.Add(Profile)
		  
		  Dim SetDifficulty As Boolean
		  If Self.mDiscoveredData.HasKey("Options") Then
		    Dim Options As Xojo.Core.Dictionary = Self.mDiscoveredData.Value("Options")
		    If Options.HasKey("OverrideOfficialDifficulty") Then
		      Document.DifficultyValue = Double.FromText(Options.Value("OverrideOfficialDifficulty"))
		      SetDifficulty = True
		    End If
		  End If
		  If Not SetDifficulty And ParsedData.HasKey("OverrideOfficialDifficulty") Then
		    Try
		      Document.DifficultyValue = ParsedData.Value("OverrideOfficialDifficulty")
		      SetDifficulty = True
		    Catch Err As TypeMismatchException
		      
		    End Try
		  End If
		  If Not SetDifficulty And ParsedData.HasKey("DifficultyOffset") Then
		    Dim Offset As Double
		    Try
		      Offset = ParsedData.Value("DifficultyOffset")
		      SetDifficulty = True
		    Catch Err As TypeMismatchException
		      Offset = 1.0
		    End Try
		    Document.DifficultyValue = Beacon.DifficultyValue(Offset, Document.Maps.DifficultyScale)
		  End If
		  
		  Dim Dicts() As Auto
		  Try
		    Dicts = ParsedData.Value("ConfigOverrideSupplyCrateItems")
		  Catch Err As TypeMismatchException
		    Dicts.Append(ParsedData.Value("ConfigOverrideSupplyCrateItems"))
		  End Try
		  
		  For Each ConfigDict As Xojo.Core.Dictionary In Dicts
		    Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(ConfigDict, Document.DifficultyValue)
		    If Source <> Nil Then
		      Document.Add(Source)
		    End If
		  Next
		  
		  Self.ShouldFinish(Document)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
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
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
