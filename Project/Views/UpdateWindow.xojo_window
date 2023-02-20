#tag DesktopWindow
Begin BeaconWindow UpdateWindow Implements NotificationKit.Receiver
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   True
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   132
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   132
   MinimizeButton  =   True
   MinWidth        =   600
   Placement       =   3
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Beacon Updates"
   Visible         =   True
   Width           =   600
   Begin DesktopPagePanel ViewPanel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   132
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   600
      Begin DesktopLabel CheckMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Check for Beacon updates…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopProgressBar CheckProgress
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin UITweaks.ResizedPushButton CheckCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel ResultsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   96
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
         Text            =   "A new version of Beacon is available!"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   484
      End
      Begin UITweaks.ResizedPushButton ResultsActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Download"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   490
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   92
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedPushButton ResultsCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   388
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   92
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin DesktopLabel DownloadMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Downloading update…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopProgressBar DownloadProgressBar
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin UITweaks.ResizedPushButton DownloadCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ResultsNotesButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Release Notes"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   96
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   92
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin DesktopLabel ResultsExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   96
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "After downloading, the update will install only when you're ready."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   484
      End
      Begin ControlCanvas ResultsIconCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   64
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Visible         =   True
         Width           =   64
      End
      Begin DesktopLabel DownloadStatusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Starting download…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   468
      End
   End
   Begin Timer DownloadWatchTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, UpdatesKit.Notification_Error, UpdatesKit.Notification_NoUpdates, UpdatesKit.Notification_UpdateAvailable, UpdatesKit.Notification_UpdateDownloaded, UpdatesKit.Notification_DownloadError, UpdatesKit.Notification_DownloadStarted)
		  
		  Self.mInstance = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  NotificationKit.Watch(Self, UpdatesKit.Notification_Error, UpdatesKit.Notification_NoUpdates, UpdatesKit.Notification_UpdateAvailable, UpdatesKit.Notification_UpdateDownloaded, UpdatesKit.Notification_DownloadError, UpdatesKit.Notification_DownloadStarted)
		  
		  If UpdatesKit.IsDownloading Then
		    Self.ViewPanel.SelectedPanelIndex = Self.ViewDownload
		  End If
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case UpdatesKit.Notification_Error
		    If Self.mErrorShown Then
		      Return
		    End If
		    
		    Var Reason As String
		    Try
		      Reason = Notification.UserData
		      If Reason.IsEmpty = False Then
		        Reason = " The updater said: " + Reason
		        If Reason.EndsWith(".") = False And Reason.EndsWith("!") = False And Reason.EndsWith("?") = False Then
		          Reason = Reason + "."
		        End If
		      End If
		    Catch Err As RuntimeException
		    End Try
		    
		    Var ReportError As Boolean = Self.ShowConfirm("Unable to check for updates.", "Uh oh, something seems to be wrong." + Reason + " Please report this problem so it can be fixed as soon as possible.", "Report Now", "Cancel")
		    Self.mErrorShown = True
		    
		    If UpdatesKit.AvailableUpdateRequired Then
		      Quit
		      Return
		    End If
		    
		    If ReportError Then
		      Self.Hide()
		      App.StartTicket()
		    End If
		    
		    Self.Close
		  Case UpdatesKit.Notification_NoUpdates
		    Self.ShowAlert("You are using the latest version.", "Beacon automatically checks for updates on each launch so you won't miss a release.")
		    Self.Close
		  Case UpdatesKit.Notification_UpdateAvailable
		    If UpdatesKit.AvailableUpdateRequired Then
		      Self.DownloadMessageLabel.Text = "Downloading required update…"
		    End If
		    If Preferences.AutomaticallyDownloadsUpdates Then
		      Self.ViewPanel.SelectedPanelIndex = Self.ViewDownload
		    Else
		      Self.ShowResults(UpdatesKit.AvailableDisplayVersion, UpdatesKit.AvailableNotesURL, UpdatesKit.AvailableDownloadURL, UpdatesKit.AvailableSignature)
		    End If
		  Case UpdatesKit.Notification_UpdateDownloaded
		    If Preferences.AutomaticallyDownloadsUpdates Then
		      Self.Hide
		      Var InstallNow As Boolean
		      If UpdatesKit.AvailableUpdateRequired Then
		        InstallNow = True
		        BeaconUI.ShowAlert(Self, "A required update to Beacon " + UpdatesKit.AvailableDisplayVersion + " has been downloaded and will now be installed.", "Beacon will be relaunched when the install is finished.")
		      Else
		        InstallNow = BeaconUI.ShowConfirm(Self, "An update to Beacon " + UpdatesKit.AvailableDisplayVersion + " has been downloaded and will be installed when you exit Beacon.", "You can choose to install the update now if you would prefer.", "Install Now", "Cancel")
		      End If
		      If InstallNow Then
		        App.LaunchUpdate(UpdatesKit.AvailableUpdateFile, True)
		        Quit
		      End If
		      Self.Close
		    Else
		      Self.PresentInstallWindow()
		    End If
		  Case UpdatesKit.Notification_DownloadError
		    Var Message As String = Notification.UserData
		    If Self.ShowConfirm("Unable to download update.", Message, "Report Now", "Cancel") Then
		      App.StartTicket()
		    End If
		    
		    Self.Close
		  Case UpdatesKit.Notification_DownloadStarted
		    Self.ViewPanel.SelectedPanelIndex = Self.ViewDownload
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present()
		  // Will check for updates
		  
		  If mInstance = Nil Then
		    mInstance = New UpdateWindow
		    If UpdatesKit.IsDownloading Then
		      mInstance.ViewPanel.SelectedPanelIndex = UpdateWindow.ViewDownload
		      mInstance.Show
		    Else
		      mInstance.Show
		      If UpdatesKit.IsBusy = False Then
		        UpdatesKit.Check()
		      End If
		    End If
		  Else
		    mInstance.Show
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PresentInstallWindow()
		  Self.Hide
		  
		  Var Message As String = "Beacon is ready to update."
		  
		  Var Selection As BeaconUI.ConfirmResponses
		  If UpdatesKit.AvailableUpdateRequired Then
		    BeaconUI.ShowAlert(Message, "Beacon will now quit to install the update.")
		    Selection = BeaconUI.ConfirmResponses.Action
		  Else
		    Var Explanation As String = "Choose ""Install Now"" to quit Beacon and start the update. If you aren't ready to update now, choose ""Install On Quit"" to start the update when you're done with Beacon."
		    Var ActionCaption As String = "Install Now"
		    Var CancelCaption As String = "Install On Quit"
		    Var AlternateCaption As String = ""
		    #if TargetMacOS
		      Explanation = Explanation + "."
		    #else
		      Explanation = Explanation + ", or ""Show Archive"" to install the update yourself."
		      AlternateCaption = "Show Archive"
		    #endif
		    
		    Selection = Self.ShowConfirm(Message, Explanation, ActionCaption, CancelCaption, AlternateCaption)
		  End If
		  Select Case Selection
		  Case BeaconUI.ConfirmResponses.Action
		    App.LaunchUpdate(UpdatesKit.AvailableUpdateFile, True)
		    Quit
		    Self.Close
		  Case BeaconUI.ConfirmResponses.Cancel
		    App.LaunchUpdate(UpdatesKit.AvailableUpdateFile, False)
		    Self.Close
		  Case BeaconUI.ConfirmResponses.Alternate
		    UpdatesKit.AvailableUpdateFile.Parent.Open
		    Self.Close
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowResults(Version As String, NotesURL As String, URL As String, Signature As String)
		  #Pragma Unused Version
		  
		  Self.mURL = URL
		  Self.mSignature = Signature
		  Self.mNotesURL = NotesURL
		  Self.ResultsNotesButton.Enabled = NotesURL.BeginsWith("https://")
		  
		  If UpdatesKit.AvailableUpdateRequired Then
		    Self.ResultsCancelButton.Caption = "Quit"
		    Self.ResultsMessageLabel.Text = "A required Beacon update is available."
		    Self.ResultsExplanationLabel.Text = "This update is required. Beacon will not function until updated."
		  End If
		  
		  Self.ViewPanel.SelectedPanelIndex = Self.ViewResults
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mErrorShown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As UpdateWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotesURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As String
	#tag EndProperty


	#tag Constant, Name = HeightCheck, Type = Double, Dynamic = False, Default = \"124", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightDownload, Type = Double, Dynamic = False, Default = \"124", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightResults, Type = Double, Dynamic = False, Default = \"132", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ViewCheck, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ViewDownload, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ViewResults, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ViewPanel
	#tag Event
		Sub PanelChanged()
		  Select Case Me.SelectedPanelIndex
		  Case Self.ViewCheck
		    Self.Height = Self.HeightCheck
		    Self.Resizeable = False
		  Case Self.ViewResults
		    Self.Height = Self.HeightResults
		    Self.Resizeable = True
		  Case Self.ViewDownload
		    Self.Height = Self.HeightDownload
		    Self.Resizeable = False
		  End Select
		  
		  Self.DownloadWatchTimer.RunMode = If(Me.SelectedPanelIndex = Self.ViewDownload, Timer.RunModes.Multiple, Timer.RunModes.Off)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckCancelButton
	#tag Event
		Sub Pressed()
		  UpdatesKit.Cancel
		  If UpdatesKit.AvailableUpdateRequired Then
		    Quit
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsActionButton
	#tag Event
		Sub Pressed()
		  #if TargetMacOS
		    Var Dialog As New SaveFileDialog
		    Dialog.SuggestedFileName = "Beacon.dmg"
		    Dialog.PromptText = "Choose a location for the update file"
		    
		    Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		    If File = Nil Then
		      Return
		    End If
		    
		    UpdatesKit.AvailableUpdateFile = File
		  #endif
		  
		  UpdatesKit.DownloadUpdate
		  Self.ViewPanel.SelectedPanelIndex = Self.ViewDownload
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsCancelButton
	#tag Event
		Sub Pressed()
		  If UpdatesKit.AvailableUpdateRequired Then
		    Quit
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DownloadCancelButton
	#tag Event
		Sub Pressed()
		  UpdatesKit.Cancel
		  If UpdatesKit.AvailableUpdateRequired Then
		    Quit
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsNotesButton
	#tag Event
		Sub Pressed()
		  System.GotoURL(Self.mNotesURL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsIconCanvas
	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  G.DrawPicture(IconApp, 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DownloadWatchTimer
	#tag Event
		Sub Action()
		  If Self.DownloadProgressBar.MaximumValue <> 1000 Then
		    Self.DownloadProgressBar.MaximumValue = 1000
		  End If
		  
		  Var BytesDownloaded As Int64 = UpdatesKit.DownloadedBytes
		  Var BytesTotal As Int64 = UpdatesKit.TotalBytesToDownload
		  Self.DownloadProgressBar.Value = (BytesDownloaded / BytesTotal) * Self.DownloadProgressBar.MaximumValue
		  
		  Var BytesPerSecond As Double = UpdatesKit.DownloadRate
		  Var RemainingSeconds As Double = UpdatesKit.DownloadSecondsRemaining
		  
		  Self.DownloadStatusLabel.Text = "Downloaded " + Beacon.BytesToString(BytesDownloaded) + " of " + Beacon.BytesToString(BytesTotal) + " at " + Beacon.BytesToString(BytesPerSecond) + "ps, " + Beacon.SecondsToString(True, RemainingSeconds) + " remaining"
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
			"9 - Metal Window"
			"11 - Modeless Dialog"
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
