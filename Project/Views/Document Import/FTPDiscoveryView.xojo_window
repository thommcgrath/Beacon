#tag DesktopWindow
Begin DiscoveryView FTPDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   450
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
   Width           =   600
   Begin DesktopPagePanel ViewPanel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   450
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
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin DesktopLabel ServerMessageLabel
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
         Text            =   "Server Settings"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel BrowseMessage
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Choose your config file"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton BrowseActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
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
         Top             =   410
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton BrowseCancelButton
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
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   410
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ColumnBrowser Browser
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         CurrentPath     =   ""
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   344
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   21
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   53
         Transparent     =   True
         Visible         =   True
         Width           =   558
      End
      Begin DesktopProgressWheel BrowseSpinner
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   2
         Tooltip         =   ""
         Top             =   414
         Transparent     =   False
         Visible         =   False
         Width           =   16
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin UITweaks.ResizedPushButton ServerCancelButton
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
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   19
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   410
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ServerActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
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
         TabIndex        =   20
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   410
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   0
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   52
         Transparent     =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   1
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   397
         Transparent     =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   344
         Index           =   2
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   53
         Transparent     =   True
         Visible         =   True
         Width           =   1
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   344
         Index           =   3
         InitialParent   =   "ViewPanel"
         Left            =   579
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   53
         Transparent     =   True
         Visible         =   True
         Width           =   1
      End
      Begin FTPSettingsView SettingsView
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   328
         Host            =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         InternalizeKey  =   False
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mode            =   ""
         Modified        =   False
         Password        =   ""
         Port            =   0
         Scope           =   2
         TabIndex        =   21
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   True
         UsePublicKeyAuth=   False
         Username        =   ""
         VerifyTLSCertificate=   False
         Visible         =   True
         Width           =   600
      End
      Begin FadedSeparator SettingsTopSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   22
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   60
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin FadedSeparator SettingsBottomSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   23
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   389
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin DesktopButton ServerLoadSpecButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Load FileZilla Spec"
         Default         =   False
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
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   24
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   410
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
      Begin DesktopLabel DiscoveryMessageLabel
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
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Attempting to find your config files…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   199
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopProgressBar DiscoveryProgressBar
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
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
         Top             =   231
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
   End
   Begin ClipboardWatcher URLWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = Self.DesiredHeight
		End Sub
	#tag EndEvent

	#tag Event
		Function CreateHostingProvider() As Beacon.HostingProvider
		  Return New FTP.HostingProvider
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Open
		  Self.SwapButtons()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Var Group As New ControlGroup(Self.DiscoveryMessageLabel, Self.DiscoveryProgressBar)
		  Group.Top = Self.ViewPanel.Top + ((Self.ViewPanel.Height - Group.Height) / 2.5)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ChoosePath(Filename As String, Options As Integer) As String
		  Var Sender As Thread = Thread.Current
		  If Sender Is Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Do not call on main thread"
		    Raise Err
		  End If
		  
		  Self.mChooserOptions = Options And (Self.ChooserOptionAllowFiles Or Self.ChooserOptionAllowFolders Or Self.ChooserOptionOptional Or Self.ChooserOptionStrictNames)
		  Self.mChooserFilename = Filename
		  Self.mChooserOriginThread = Sender
		  
		  Call CallLater.Schedule(1, WeakAddressOf ShowPathChooser)
		  Sender.Pause
		  Return Self.mChosenPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListedFiles(Filenames() As String)
		  // Directories should be suffixed with /
		  
		  Self.Browser.Enabled = True
		  Self.BrowseSpinner.Visible = False
		  
		  Var Children() As String
		  For Each Filename As String In Filenames
		    If Filename = "." Or Filename = ".." Then
		      Continue
		    End If
		    
		    Children.Add(Filename)
		  Next
		  Self.Browser.AppendChildren(Children)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListError(Err As RuntimeException)
		  Self.Browser.Enabled = True
		  Self.BrowseSpinner.Visible = False
		  
		  Var Reason As String
		  If Err.Message.IsEmpty Then
		    Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		    Reason = "Unhandled " + Info.FullName
		  Else
		    Reason = Err.Message
		  End If
		  
		  Self.ShowAlert("Beacon was unable to retrieve the file list.", Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListFiles(Path As String)
		  Var Thread As New Beacon.Thread
		  Thread.DebugIdentifier = CurrentMethodName
		  Thread.UserData = Path
		  AddHandler Thread.Run, WeakAddressOf ListThread_Run
		  AddHandler Thread.UserInterfaceUpdate, WeakAddressOf ListThread_UserInterfaceUpdate
		  Self.mListThread = Thread
		  
		  Self.Browser.Enabled = False
		  Self.BrowseSpinner.Visible = True
		  Thread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListThread_Run(Sender As Beacon.Thread)
		  Try
		    Var Filenames() As String = Self.Provider.ListFiles(Nil, Self.mProfile, Sender.UserData.StringValue)
		    Var Dict As New Dictionary
		    Dict.Value("Event") = "Finished"
		    Dict.Value("Filenames") = Filenames
		    Dict.Value("Finished") = True
		    Sender.AddUserInterfaceUpdate(Dict)
		  Catch Err As RuntimeException
		    Var Dict As New Dictionary
		    Dict.Value("Event") = "Error"
		    Dict.Value("Error") = Err
		    Dict.Value("Finished") = True
		    Sender.AddUserInterfaceUpdate(Dict)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    Try
		      If Update.HasKey("Event") Then
		        Select Case Update.Value("Event")
		        Case "Finished"
		          Var Filenames() As String = Update.Value("Filenames")
		          Self.ListedFiles(Filenames)
		        Case "Error"
		          Var Error As RuntimeException = Update.Value("Error")
		          Self.ListError(Error)
		        End Select
		      End If
		      If Update.Lookup("Finished", False).BooleanValue = True Then
		        Self.mListThread = Nil
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Processing discovery thread interface update")
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDiscoverThread_Run(Sender As Beacon.Thread)
		  Var Provider As FTP.HostingProvider = FTP.HostingProvider(Self.Provider)
		  Var Profile As Beacon.ServerProfile = Self.mProfile
		  Var Dict As New Dictionary
		  Dict.Value("Event") = "Finished"
		  Try
		    Var DiscoveredProfiles() As Beacon.ServerProfile = RaiseEvent Discover(Provider, Profile, Sender)
		    Dict.Value("Success") = (DiscoveredProfiles Is Nil) = False And DiscoveredProfiles.Count > 0
		    Dict.Value("Profiles") = DiscoveredProfiles
		  Catch Err As RuntimeException
		    Dict.Value("Success") = False
		    Dict.Value("Error") = Err
		  End Try
		  Sender.AddUserInterfaceUpdate(Dict)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDiscoverThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    Try
		      If Update.HasKey("Event") Then
		        Select Case Update.Value("Event")
		        Case "Finished"
		          Var Success As Boolean = Update.Value("Success")
		          If Success Then
		            Var Profiles() As Beacon.ServerProfile = Update.Value("Profiles")
		            Self.ShouldFinish(Profiles)
		          Else
		            If Update.HasKey("Error") Then
		              Var Err As RuntimeException = Update.Value("Error")
		              Var Message As String
		              If (Err Is Nil) = False Then
		                If Err.Message.IsEmpty = False Then
		                  Message = Err.Message
		                Else
		                  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		                  Message = "Unhandled " + Info.FullName 
		                End If
		              Else
		                Message = "No error information is available."
		              End If
		              
		              Self.ShowAlert("FTP import did not complete", Message)
		            End If
		            Self.ViewPanel.SelectedPanelIndex = Self.PageGeneral
		          End If
		          Self.mDiscoverThread = Nil
		        End Select
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Processing discovery thread interface update")
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowPathChooser()
		  Var Files As Boolean = (Self.mChooserOptions And Self.ChooserOptionAllowFiles) > 0
		  Var Folders As Boolean = (Self.mChooserOptions And Self.ChooserOptionAllowFolders) > 0
		  Var Required As Boolean = (Self.mChooserOptions And Self.ChooserOptionOptional) = 0
		  Var Noun As String
		  If Files And Folders Then
		    Noun = "file or folder"
		  ElseIf Files Then
		    Noun = "file"
		  Else
		    Noun = "folder"
		  End If
		  
		  Self.BrowseMessage.Text = "Please locate your " + Self.mChooserFilename + " " + Noun + "."
		  Self.BrowseCancelButton.Caption = If(Required, "Cancel", "Skip")
		  Self.ViewPanel.SelectedPanelIndex = Self.PageBrowse
		  
		  If Self.Browser.CurrentPath.IsEmpty Or Self.Browser.CurrentPath = "/" Then
		    Self.ListFiles("")
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CreateServerProfile(Name As String) As Beacon.ServerProfile
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Discover(Provider As FTP.HostingProvider, InitialProfile As Beacon.ServerProfile, SenderThread As Beacon.Thread) As Beacon.ServerProfile()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Satisfied(Path As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private mActiveController As Beacon.TaskWaitController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBrowserRoot As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChooserFilename As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChooserOptions As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChooserOriginThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChosenPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDiscoverThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mListThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingsPageHeight As Integer
	#tag EndProperty


	#tag Constant, Name = ChooserOptionAllowFiles, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ChooserOptionAllowFolders, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ChooserOptionOptional, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ChooserOptionStrictNames, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PageBrowse, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDiscover, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageGeneral, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ViewPanel
	#tag Event
		Sub PanelChanged()
		  If Me.SelectedPanelIndex = Self.PageGeneral Then
		    Self.DesiredHeight = Self.mSettingsPageHeight
		  Else
		    Self.DesiredHeight = Max(420, Self.mSettingsPageHeight)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BrowseActionButton
	#tag Event
		Sub Pressed()
		  Var CurrentPath As String = Self.Browser.CurrentPath
		  If CurrentPath.EndsWith(Self.mChooserFilename) = False Then
		    Var SelectedNoun As String = If(CurrentPath.EndsWith("/"), "folder", "file")
		    Var Strict As Boolean = (Self.mChooserOptions And Self.ChooserOptionStrictNames) > 0
		    If Strict Then
		      Var Files As Boolean = (Self.mChooserOptions And Self.ChooserOptionAllowFiles) > 0
		      Var Folders As Boolean = (Self.mChooserOptions And Self.ChooserOptionAllowFolders) > 0
		      Var DesiredNoun As String
		      If Files And Folders Then
		        DesiredNoun = "file or folder"
		      ElseIf Files Then
		        DesiredNoun = "file"
		      Else
		        DesiredNoun = "folder"
		      End If
		      Self.ShowAlert("Please select a " + DesiredNoun + " named " + Self.mChooserFilename + ".", "The selected " + SelectedNoun + " is not what Beacon needs to finish the import.")
		    Else
		      Var UseAnyway As Boolean = Self.ShowConfirm("The chosen " + SelectedNoun + " is not named " + Self.mChooserFilename + ".", "You can still use the chosen " + SelectedNoun + " but it may not be the one Beacon needs. Only continue if you know what you're doing.", "Use Anyway", "Cancel")
		      If UseAnyway = False Then
		        Return
		      End If
		    End If
		  End If
		  
		  Self.mChosenPath = CurrentPath
		  Self.ViewPanel.SelectedPanelIndex = Self.PageDiscover
		  Self.mChooserOriginThread.Resume
		  Self.mChooserOriginThread = Nil
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BrowseCancelButton
	#tag Event
		Sub Pressed()
		  Self.mChosenPath = ""
		  Self.ViewPanel.SelectedPanelIndex = Self.PageGeneral
		  Self.mChooserOriginThread.Resume
		  Self.mChooserOriginThread = Nil
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Browser
	#tag Event
		Sub NeedsChildrenForPath(Path As String)
		  Var Empty() As String
		  Me.AppendChildren(Empty)
		  
		  If (Self.mProfile Is Nil) = False And Self.ViewPanel.SelectedPanelIndex = Self.PageBrowse Then
		    System.DebugLog("NeedsChildrenForPath(""" + Path + """)")
		    Self.ListFiles(Path)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PathSelected(Path As String)
		  If Path.IsEmpty Then
		    Self.BrowseActionButton.Enabled = False
		    Return
		  End If
		  
		  Var Files As Boolean = (Self.mChooserOptions And Self.ChooserOptionAllowFiles) > 0
		  Var Folders As Boolean = (Self.mChooserOptions And Self.ChooserOptionAllowFolders) > 0
		  Var IsFolder As Boolean = Path.EndsWith("/")
		  
		  If (Files = False And IsFolder = False) Or (Folders = False And IsFolder = True) Then
		    Self.BrowseActionButton.Enabled = False
		    Return
		  End If
		  
		  Self.BrowseActionButton.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerCancelButton
	#tag Event
		Sub Pressed()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerActionButton
	#tag Event
		Sub Pressed()
		  Var Profile As Beacon.ServerProfile = RaiseEvent CreateServerProfile(Language.DefaultServerName(Self.GameId))
		  If Profile Is Nil Then
		    Return
		  End If
		  
		  Var Config As New FTP.HostConfig
		  Config.Host = Self.SettingsView.Host
		  Config.Port = Self.SettingsView.Port
		  Config.Username = Self.SettingsView.Username
		  Config.Password = Self.SettingsView.Password
		  Config.VerifyHost = Self.SettingsView.VerifyTLSCertificate
		  Config.Mode = Self.SettingsView.Mode
		  
		  If Self.SettingsView.UsePublicKeyAuth Then
		    Var PrivateKeyFile As FolderItem = Self.SettingsView.PrivateKeyFile
		    If PrivateKeyFile Is Nil Then
		      Return
		    End If
		    
		    If Self.SettingsView.InternalizeKey Then
		      Config.PrivateKeyFile = Self.SettingsView.PrivateKeyFile.Read(Encodings.UTF8)
		    Else
		      Config.PrivateKeyFile = Self.SettingsView.PrivateKeyFile
		    End If
		  End If
		  
		  Profile.HostConfig = Config
		  Profile.SecondaryName = Config.Username + "@" + Config.Host + ":" + Config.Port.ToString(Locale.Raw, "0")
		  Self.mProfile = Profile
		  Self.ViewPanel.SelectedPanelIndex = Self.PageDiscover
		  
		  Self.Browser.Reset
		  
		  Var Thread As New Beacon.Thread
		  Thread.DebugIdentifier = CurrentMethodName
		  AddHandler Thread.Run, WeakAddressOf mDiscoverThread_Run
		  AddHandler Thread.UserInterfaceUpdate, WeakAddressOf mDiscoverThread_UserInterfaceUpdate
		  Self.mDiscoverThread = Thread
		  Thread.Start
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SettingsView
	#tag Event
		Sub ReadyStateChanged()
		  Self.ServerActionButton.Enabled = Me.Ready
		End Sub
	#tag EndEvent
	#tag Event
		Sub WantsHeightChange(NewDesiredHeight As Integer)
		  Me.Height = NewDesiredHeight
		  Self.SettingsBottomSeparator.Top = Me.Top + Me.Height
		  Self.ServerActionButton.Top = Self.SettingsBottomSeparator.Bottom + 20
		  Self.ServerCancelButton.Top = Self.ServerActionButton.Top
		  Self.ServerLoadSpecButton.Top = Self.ServerActionButton.Top
		  Self.mSettingsPageHeight = Self.ServerActionButton.Bottom + 20
		  Self.DesiredHeight = Self.mSettingsPageHeight
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerLoadSpecButton
	#tag Event
		Sub Pressed()
		  Var Board As New Clipboard
		  If Board.TextAvailable And Self.SettingsView.ImportFileZillaSpec(Board.Text) Then
		    Return
		  End If
		  
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.Text
		  
		  Var SpecFile As FolderItem = Dialog.ShowModal(Self)
		  If SpecFile Is Nil Then
		    Return
		  End If
		  
		  Call Self.SettingsView.ImportFileZillaSpec(SpecFile)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events URLWatcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  Var Matcher As New Regex
		  Matcher.SearchPattern = "^((ftp|ftps|sftp)://)(([^@:\s]+):([^@:\s]+)@)?([^/:\s]+\.[^/:\s]+)(:(\d{1,5}))?"
		  
		  Var Matches As RegexMatch = Matcher.Search(Content)
		  If Matches Is Nil Then
		    Return
		  End If
		  
		  Var Protocol As String = If(Matches.SubExpressionCount >= 2, DecodeURLComponent(Matches.SubExpressionString(2)), "")
		  Var Username As String = If(Matches.SubExpressionCount >= 4, DecodeURLComponent(Matches.SubExpressionString(4)), "")
		  Var Password As String = If(Matches.SubExpressionCount >= 5, DecodeURLComponent(Matches.SubExpressionString(5)), "")
		  Var Host As String = If(Matches.SubExpressionCount >= 6, DecodeURLComponent(Matches.SubExpressionString(6)), "")
		  Var Port As String = If(Matches.SubExpressionCount >= 8, DecodeURLComponent(Matches.SubExpressionString(8)), "")
		  
		  If Port.IsEmpty Then
		    If Protocol = "sftp" Then
		      Port = "22"
		    Else
		      Port = "21"
		    End If
		  End If
		  
		  Self.SettingsView.Mode = Protocol
		  
		  If Host.IsEmpty = False Then
		    Self.SettingsView.Host = Host
		  End If
		  If Port.IsEmpty = False Then
		    Self.SettingsView.Port = Integer.FromString(Port, Locale.Current)
		  End If
		  If Username.IsEmpty = False Then
		    Self.SettingsView.Username = Username
		  End If
		  If Password.IsEmpty = False Then
		    Self.SettingsView.Password = Password
		  End If
		  
		  Exception Err As RuntimeException
		    Return
		End Sub
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
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
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="LockLeft"
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
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
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
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
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
#tag EndViewBehavior
