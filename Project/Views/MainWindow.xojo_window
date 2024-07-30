#tag DesktopWindow
Begin BeaconWindow MainWindow Implements ObservationKit.Observer,NotificationKit.Receiver
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   True
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   True
   HasBackColor    =   False
   Height          =   820
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   817604607
   MenuBarVisible  =   True
   MinHeight       =   680
   MinimizeButton  =   True
   MinWidth        =   1200
   Placement       =   2
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Beacon"
   Visible         =   True
   Width           =   1420
   Begin OmniBar NavBar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   14
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1420
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   782
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   38
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   1420
      Begin DashboardPane DashboardPane1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   782
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Modified        =   False
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Home"
         Visible         =   True
         Width           =   1119
      End
      Begin BlueprintsComponent BlueprintsComponent1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   782
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Modified        =   False
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Mods"
         Visible         =   True
         Width           =   1420
      End
      Begin DocumentsComponent DocumentsComponent1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   782
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Modified        =   False
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Projects"
         Visible         =   True
         Width           =   1420
      End
      Begin NewsPane NotificationsPane1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   782
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsFrontmost     =   False
         Left            =   1120
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   0
         MinimumWidth    =   0
         Modified        =   False
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Untitled"
         Visible         =   True
         Width           =   300
      End
      Begin FadedSeparator NotificationsSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   782
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   1119
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         Visible         =   True
         Width           =   1
      End
      Begin HelpComponent HelpComponent1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   782
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   0
         MinimumWidth    =   0
         Modified        =   False
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Help"
         Visible         =   True
         Width           =   1420
      End
      Begin TemplatesComponent TemplatesComponent1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   782
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Modified        =   False
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Templates"
         Visible         =   True
         Width           =   1420
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function CancelClosing(appQuitting As Boolean) As Boolean
		  Const AllowClose = False
		  Const BlockClose = True
		  
		  Var ReturnValue As Boolean = AllowClose
		  
		  If Self.DocumentsComponent1.ConfirmClose() = False Or Self.BlueprintsComponent1.ConfirmClose() = False Or Self.TemplatesComponent1.ConfirmClose() = False Then
		    ReturnValue = BlockClose
		  End If
		  
		  If Self.Busy Then
		    Self.mQuitWhenNotBusy = Self.mQuitWhenNotBusy Or AppQuitting
		    If Self.mBusyWatcher Is Nil Then
		      Self.mBusyWatcher = New Timer
		      Self.mBusyWatcher.Period = 500
		      AddHandler mBusyWatcher.Action, WeakAddressOf mBusyWatcher_Action
		    End If
		    Self.mBusyWatcher.RunMode = Timer.RunModes.Multiple
		    ReturnValue = BlockClose
		  End If
		  
		  Return ReturnValue
		End Function
	#tag EndEvent

	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, UpdatesKit.Notification_UpdateAvailable, Preferences.Notification_ProfileIconChanged, Beacon.PusherSocket.Notification_StateChanged, IdentityManager.Notification_IdentityChanged)
		  #if TargetMacOS
		    NSNotificationCenterMBS.DefaultCenter.RemoveObserver(Self.mObserver)
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MenuBarSelected()
		  Var Component As BeaconSubview = Self.CurrentComponent
		  If (Component Is Nil) = False Then
		    Component.EnableMenuItems()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Moved()
		  If Self.mOpened Then
		    Var Bounds As Xojo.Rect = Self.Bounds
		    Preferences.MainWindowPosition = New Rect(Bounds.Left, Bounds.Top, Bounds.Width, Bounds.Height)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Var Frame As Rect = Self.Bounds
		  Var XDelta As Integer = Frame.Width - Self.Width
		  Var YDelta As Integer = Frame.Height - Self.Height
		  Self.MinimumWidth = Self.MinimumWidth - XDelta
		  Self.MinimumHeight = Self.MinimumHeight - YDelta
		  Self.Width = Max(Self.Width, Self.MinimumWidth)
		  Self.Height = Max(Self.Height, Self.MinimumHeight)
		  
		  Var Bounds As Rect = Preferences.MainWindowPosition
		  If Bounds <> Nil Then
		    // Find the best screen
		    Var IdealScreen As DesktopDisplay = DesktopDisplay.DisplayAt(0)
		    Var Bound As Integer = DesktopDisplay.DisplayCount - 1
		    If Bound > 0 Then
		      Var MaxArea As Integer
		      For I As Integer = 0 To Bound
		        Var Display As DesktopDisplay = DesktopDisplay.DisplayAt(I)
		        Var ScreenBounds As New Rect(Display.AvailableLeft, Display.AvailableTop, Display.AvailableWidth, Display.AvailableHeight)
		        Var Intersection As Rect = ScreenBounds.Intersection(Bounds)
		        If Intersection = Nil Then
		          Continue
		        End If
		        Var Area As Integer = Intersection.Width * Intersection.Height
		        If Area <= 0 Then
		          Continue
		        End If
		        If Area > MaxArea Then
		          MaxArea = Area
		          IdealScreen = Display
		        End If
		      Next
		    End If
		    
		    Var AvailableBounds As New Rect(IdealScreen.AvailableLeft, IdealScreen.AvailableTop, IdealScreen.AvailableWidth, IdealScreen.AvailableHeight)
		    Var WidthRange As New Beacon.Range(Self.MinimumWidth + XDelta, Self.MaximumWidth + XDelta)
		    Var HeightRange As New Beacon.Range(Self.MinimumHeight + YDelta, Self.MaximumHeight + YDelta)
		    Var Width As Integer = WidthRange.Fit(Min(Bounds.Width, AvailableBounds.Width))
		    Var Height As Integer = HeightRange.Fit(Min(Bounds.Height, AvailableBounds.Height))
		    Var Left As Integer = Max(Min(Max(Bounds.Left, AvailableBounds.Left), AvailableBounds.Right - Width), 0)
		    Var Top As Integer = Max(Min(Max(Bounds.Top, AvailableBounds.Top), AvailableBounds.Bottom - Height), 0)
		    Self.Bounds = New Xojo.Rect(Left, Top, Width, Height)
		  End If
		  
		  #if TargetMacOS
		    Var Win As NSWindowMBS = Self.NSWindowMBS
		    Win.StyleMask = Win.StyleMask Or NSWindowMBS.NSFullSizeContentViewWindowMask
		    Win.TitlebarAppearsTransparent = True
		    Win.TitleVisibility = NSWindowMBS.NSWindowTitleHidden
		    
		    Var Toolbar As New NSToolbarMBS("com.thezaz.beacon.mainwindow.toolbar")
		    Toolbar.sizeMode = NSToolbarMBS.NSToolbarDisplayModeIconOnly
		    Toolbar.showsBaselineSeparator = False
		    Self.mToolbar = Toolbar
		    
		    Win.toolbar = Toolbar
		    
		    Var CloseButton As NSButtonMBS = Win.StandardWindowButton(NSWindowMBS.NSWindowCloseButton)
		    Var ZoomButton As NSButtonMBS = Win.StandardWindowButton(NSWindowMBS.NSWindowZoomButton)
		    If (CloseButton Is Nil Or ZoomButton Is Nil) = False Then
		      Self.NavBar.LeftPadding = CloseButton.Frame.MinX + ZoomButton.Frame.MaxX
		    End If
		  #endif
		  
		  UpdatesKit.Init()
		  NotificationKit.Watch(Self, UpdatesKit.Notification_UpdateAvailable, Preferences.Notification_ProfileIconChanged, Beacon.PusherSocket.Notification_StateChanged, IdentityManager.Notification_IdentityChanged)
		  Self.SetupUpdateUI()
		  
		  Self.mOpened = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  If Self.mOpened Then
		    Var Bounds As Xojo.Rect = Self.Bounds
		    Preferences.MainWindowPosition = New Rect(Bounds.Left, Bounds.Top, Bounds.Width, Bounds.Height)
		  End If
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function ViewDashboard() As Boolean Handles ViewDashboard.Action
		  Self.ShowView(Self.DashboardPane1)
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewDocuments() As Boolean Handles ViewDocuments.Action
		  Self.ShowDocuments()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewEngrams() As Boolean Handles ViewEngrams.Action
		  Self.ShowBlueprints()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewHelp() As Boolean Handles ViewHelp.Action
		  Self.ShowHelp()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewTemplates() As Boolean Handles ViewTemplates.Action
		  Self.ShowTemplates()
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  If (Self.DocumentsComponent1 Is Nil) = False And Self.DocumentsComponent1.Busy Then
		    Return True
		  End If
		  
		  If (Self.DashboardPane1 Is Nil) = False And Self.DashboardPane1.Busy Then
		    Return True
		  End If
		  
		  If (Self.BlueprintsComponent1 Is Nil) = False And Self.BlueprintsComponent1.Busy Then
		    Return True
		  End If
		  
		  If (Self.TemplatesComponent1 Is Nil) = False And Self.TemplatesComponent1.Busy Then
		    Return True
		  End If
		  
		  If (Self.HelpComponent1 Is Nil) = False And Self.HelpComponent1.Busy Then
		    Return True
		  End If
		  
		  If UserCloud.IsBusy Or UserCloud.HasPendingSync Then
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  If Super.CanBeClosed() = False Then
		    Return False
		  End If
		  
		  Select Case Self.Pages.SelectedPanelIndex
		  Case Self.PageDocuments
		    Var Frontmost As BeaconSubview = Self.DocumentsComponent1.FrontmostPage
		    Return (Frontmost Is Nil) = False And Frontmost.CanBeClosed
		  Case Self.PageBlueprints
		    Var Frontmost As BeaconSubview = Self.BlueprintsComponent1.FrontmostPage
		    Return (Frontmost Is Nil) = False And Frontmost.CanBeClosed
		  Case Self.PageTemplates
		    Var Frontmost As BeaconSubview = Self.TemplatesComponent1.FrontmostPage
		    Return (Frontmost Is Nil) = False And Frontmost.CanBeClosed
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  #if TargetMacOS
		    Self.mObserver = New NSNotificationObserverMBS
		    AddHandler mObserver.GotNotification, WeakAddressOf mObserver_GotNotification
		    
		    NSNotificationCenterMBS.DefaultCenter.AddObserver(Self.mObserver, NSWindowMBS.NSWindowWillEnterFullScreenNotification)
		    NSNotificationCenterMBS.DefaultCenter.addObserver(Self.mObserver, NSWindowMBS.NSWindowDidExitFullScreenNotification)
		  #endif
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentComponent() As BeaconSubview
		  Var CurrentIndex As Integer = -1
		  If (Self.Pages Is Nil) = False Then
		    CurrentIndex = Self.Pages.SelectedPanelIndex
		  End If
		  
		  Select Case CurrentIndex
		  Case Self.PageHome
		    Return Self.DashboardPane1
		  Case Self.PageDocuments
		    Return Self.DocumentsComponent1
		  Case Self.PageBlueprints
		    Return Self.BlueprintsComponent1
		  Case Self.PageTemplates
		    Return Self.TemplatesComponent1
		  Case Self.PageHelp
		    Return Self.HelpComponent1
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentEditors() As DocumentEditorView()
		  If (Self.DocumentsComponent1 Is Nil) = False Then
		    Return Self.DocumentsComponent1.DocumentEditors
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Documents(SwitchTo As Boolean = True) As DocumentsComponent
		  If SwitchTo Then
		    Self.SwitchView(Self.PageDocuments)
		  End If
		  
		  Return Self.DocumentsComponent1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DoFileClose()
		  Select Case Self.Pages.SelectedPanelIndex
		  Case Self.PageDocuments
		    Var Frontmost As BeaconSubview = Self.DocumentsComponent1.FrontmostPage
		    If (Frontmost Is Nil) = False And Frontmost.CanBeClosed Then
		      Call Self.DocumentsComponent1.DiscardView(Frontmost)
		    End If
		  Case Self.PageBlueprints
		    Var Frontmost As BeaconSubview = Self.BlueprintsComponent1.FrontmostPage
		    If (Frontmost Is Nil) = False And Frontmost.CanBeClosed Then
		      Call Self.BlueprintsComponent1.CloseView(Frontmost)
		    End If
		  Case Self.PageTemplates
		    Var Frontmost As BeaconSubview = Self.TemplatesComponent1.FrontmostPage
		    If (Frontmost Is Nil) = False And Frontmost.CanBeClosed Then
		      Call Self.TemplatesComponent1.CloseView(Frontmost)
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FrontmostDocumentView(GameId As String) As DocumentEditorView
		  If Self.DocumentsComponent1 Is Nil Then
		    Return Nil
		  End If
		  
		  Return Self.DocumentsComponent1.FrontmostDocumentEditor(GameId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasModifications() As Boolean
		  If (Self.DocumentsComponent1 Is Nil) = False And Self.DocumentsComponent1.HasModifications Then
		    Return True
		  End If
		  
		  If (Self.DashboardPane1 Is Nil) = False And Self.DashboardPane1.HasModifications Then
		    Return True
		  End If
		  
		  If (Self.BlueprintsComponent1 Is Nil) = False And Self.BlueprintsComponent1.HasModifications Then
		    Return True
		  End If
		  
		  If (Self.TemplatesComponent1 Is Nil) = False And Self.TemplatesComponent1.HasModifications Then
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Help(SwitchTo As Boolean = True) As HelpComponent
		  If SwitchTo Then
		    Self.SwitchView(Self.PageHelp)
		  End If
		  
		  Return Self.HelpComponent1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mBusyWatcher_Action(Sender As Timer)
		  If Self.Busy Then
		    Return
		  End If
		  
		  If Self.HasModifications Then
		    // The work has finished but there are still changes left, so cancel this action entirely.
		    Sender.RunMode = Timer.RunModes.Off
		    Self.mQuitWhenNotBusy = False
		    Return
		  End If
		  
		  If Self.mQuitWhenNotBusy Then
		    Quit
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mObserver_GotNotification(Sender As NSNotificationObserverMBS, Notification As NSNotificationMBS)
		  #Pragma Unused Sender
		  
		  If Notification Is Nil Then
		    Return
		  End If
		  
		  Select Case Notification.Name
		  Case NSWindowMBS.NSWindowWillEnterFullScreenNotification
		    Self.NSWindowMBS.Toolbar = Nil
		    Self.NavBar.LeftPadding = -1
		  Case NSWindowMBS.NSWindowDidExitFullScreenNotification
		    Self.NSWindowMBS.Toolbar = Self.mToolbar
		    
		    Var CloseButton As NSButtonMBS = Self.NSWindowMBS.StandardWindowButton(NSWindowMBS.NSWindowCloseButton)
		    Var ZoomButton As NSButtonMBS = Self.NSWindowMBS.StandardWindowButton(NSWindowMBS.NSWindowZoomButton)
		    If (CloseButton Is Nil Or ZoomButton Is Nil) = False Then
		      Self.NavBar.LeftPadding = CloseButton.Frame.MinX + ZoomButton.Frame.MaxX
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  If Self.NavBar Is Nil Then
		    Return
		  End If
		  
		  Select Case Notification.Name
		  Case UpdatesKit.Notification_UpdateAvailable
		    Self.SetupUpdateUI()
		  Case Preferences.Notification_ProfileIconChanged
		    Var ProfileButton As OmniBarItem = Self.NavBar.Item("NavUser")
		    If (ProfileButton Is Nil) = False Then
		      ProfileButton.Icon = Self.ProfileIcon()
		    End If
		  Case Beacon.PusherSocket.Notification_StateChanged
		    Self.UpdatePusherStatus()
		  Case IdentityManager.Notification_IdentityChanged
		    Var ProfileButton As OmniBarItem = Self.NavBar.Item("NavUser")
		    If (ProfileButton Is Nil) = False Then
		      Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		      If (Identity Is Nil) = False Then
		        ProfileButton.Caption = Identity.Username(True)
		      Else
		        ProfileButton.Caption = ""
		      End If
		    End If
		    
		    Self.UpdateRenewButton()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused OldValue
		  #Pragma Unused NewValue
		  
		  Select Case Key
		  Case "ViewTitle", "ViewIcon"
		    If (Self.NavBar Is Nil) = False Then
		      Self.NavBar.Refresh
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProfileIcon() As Picture
		  Select Case Preferences.ProfileIcon
		  Case Preferences.ProfileIconChoices.Cat
		    Return IconToolbarCat
		  Case Preferences.ProfileIconChoices.WithoutPonytail
		    Return IconToolbarUser
		  Case Preferences.ProfileIconChoices.WithPonytail
		    Return IconToolbarUserPonytail
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUpdateUI()
		  If Self.NavBar Is Nil Then
		    Return
		  End If
		  
		  Var ShowUpdateBar As Boolean = UpdatesKit.IsUpdateAvailable And UpdatesKit.AutomaticallyDownloadsUpdates = False
		  If UpdatesKit.AvailableUpdateRequired Then
		    ShowUpdateBar = False
		    Call App.HandleURL("beacon://action/checkforupdate")
		    Self.Hide
		    Return
		  End If
		  
		  If ShowUpdateBar Then
		    Var Preview As String = UpdatesKit.AvailablePreview
		    If Preview.IsEmpty = False Then
		      Preview = Preview + " Click here to update."
		    Else
		      Preview = "Beacon " + UpdatesKit.AvailableDisplayVersion + " is now available! Click here to update."
		    End If
		    
		    Var UpdateItem As OmniBarItem = Self.NavBar.Item("NavUpdate")
		    If (UpdateItem Is Nil) = False Then
		      If UpdateItem.Visible = False Then
		        SoundUpdateAvailable.Play
		      End If
		      UpdateItem.Visible = True
		      UpdateItem.HelpTag = Preview
		    End If
		    
		    If UpdatesKit.AvailableUpdateRequired Then
		      Self.NavBar.BackgroundColor = OmniBar.BackgroundColors.Red
		      
		      If Not Self.HasModifications Then
		        Self.Hide
		      End If
		      
		      UpdateWindow.Present
		    Else
		      Self.NavBar.BackgroundColor = OmniBar.BackgroundColors.Natural
		    End If
		  Else
		    Self.NavBar.BackgroundColor = OmniBar.BackgroundColors.Natural
		    
		    Var UpdateItem As OmniBarItem = Self.NavBar.Item("NavUpdate")
		    If (UpdateItem Is Nil) = False Then
		      UpdateItem.Visible = False
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowBlueprints()
		  Self.SwitchView(Self.PageBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowDocuments()
		  Self.SwitchView(Self.PageDocuments)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowHelp()
		  Self.SwitchView(Self.PageHelp)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowHome()
		  Self.SwitchView(Self.PageHome)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowTemplates()
		  Self.SwitchView(Self.PageTemplates)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowUserMenu(X As Integer, Y As Integer)
		  Var Base As New DesktopMenuItem
		  
		  If Not Preferences.OnlineEnabled Then
		    Base.AddMenu(New DesktopMenuItem("Enable Cloud && Community", "beacon://action/enableonline"))
		  Else
		    If App.IdentityManager.CurrentIdentity Is Nil Then
		      Base.AddMenu(New DesktopMenuItem("Log In", "beacon://action/signin"))
		    Else
		      Base.AddMenu(New DesktopMenuItem("Refresh Purchases", "beacon://action/refreshuser?silent=false"))
		      Base.AddMenu(New DesktopMenuItem("Account Control Panel", "beacon://action/showaccount"))
		      Base.AddMenu(New DesktopMenuItem("Show Account Info…", "beacon://action/showidentity"))
		      Base.AddMenu(New DesktopMenuItem("Copy Username", "copyusername"))
		      Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		      Base.AddMenu(New DesktopMenuItem("Change Account…", "beacon://action/signout"))
		    End If
		  End If
		  
		  Var Choice As DesktopMenuItem = Base.PopUp(X, Y)
		  If Choice Is Nil Or IsNull(Choice.Tag) Or Choice.Tag.Type <> Variant.TypeString Or Choice.Tag.StringValue.IsEmpty Then
		    Return
		  End If
		  
		  Var ChoiceString As String = Choice.Tag.StringValue
		  If ChoiceString.BeginsWith("beacon://") Then
		    Call App.HandleURL(ChoiceString)
		  Else
		    Select Case ChoiceString
		    Case "copyusername"
		      Var Board As New Clipboard
		      Board.Text = App.IdentityManager.CurrentIdentity.Username(True)
		      MessageBox("Your username has been copied")
		    End Select
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowView(View As BeaconSubview)
		  Var NewIndex As Integer
		  Select Case View
		  Case Self.BlueprintsComponent1
		    NewIndex = Self.PageBlueprints
		  Case Self.DocumentsComponent1
		    NewIndex = Self.PageDocuments
		  Case Self.DashboardPane1
		    NewIndex = Self.PageHome
		  Else
		    Return
		  End Select
		  
		  Self.SwitchView(NewIndex)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwitchView(Index As Integer)
		  If Self.Pages Is Nil Then
		    Return
		  End If
		  
		  Var CurrentIndex As Integer = Self.Pages.SelectedPanelIndex
		  If CurrentIndex = Index Then
		    Return
		  End If
		  
		  If Index = Self.PageHelp And BeaconUI.WebContentSupported = False Then
		    System.GotoURL(Beacon.HelpURL)
		    Return
		  End If
		  
		  Var FromView As BeaconSubview
		  Select Case CurrentIndex
		  Case Self.PageHome
		    FromView = Self.DashboardPane1
		  Case Self.PageDocuments
		    FromView = Self.DocumentsComponent1
		  Case Self.PageBlueprints
		    FromView = Self.BlueprintsComponent1
		  Case Self.PageTemplates
		    FromView = Self.TemplatesComponent1
		  Case Self.PageHelp
		    FromView = Self.HelpComponent1
		  End Select
		  If (FromView Is Nil) = False Then
		    FromView.SwitchedFrom()
		  End If
		  
		  Self.Pages.SelectedPanelIndex = Index
		  
		  Var ToView As BeaconSubview
		  Select Case Index
		  Case Self.PageHome
		    ToView = Self.DashboardPane1
		  Case Self.PageDocuments
		    ToView = Self.DocumentsComponent1
		  Case Self.PageBlueprints
		    ToView = Self.BlueprintsComponent1
		  Case Self.PageTemplates
		    ToView = Self.TemplatesComponent1
		  Case Self.PageHelp
		    ToView = Self.HelpComponent1
		  End Select
		  If (ToView Is Nil) = False Then
		    ToView.SwitchedTo(Nil)
		  End If
		  
		  If (Self.NavBar Is Nil) = False Then
		    For Idx As Integer = 0 To Self.NavBar.LastIndex
		      If (Self.NavBar.Item(Idx) Is Nil) = False Then
		        Self.NavBar.Item(Idx).Toggled = (Idx = Index)
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Templates(SwitchTo As Boolean = True) As TemplatesComponent
		  If SwitchTo Then
		    Self.SwitchView(Self.PageTemplates)
		  End If
		  
		  Return Self.TemplatesComponent1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePusherStatus()
		  Var State As Beacon.PusherSocket.States
		  If (App.Pusher Is Nil) = False Then
		    State = App.Pusher.State
		  Else
		    State = Beacon.PusherSocket.States.Disabled
		  End If
		  Var Button As OmniBarItem = Self.NavBar.Item("NavPusher")
		  If Button Is Nil Then
		    Return
		  End If
		  
		  If State = Beacon.PusherSocket.States.Disabled Then
		    Button.Visible = False
		    Return
		  End If
		  
		  Button.Visible = True
		  
		  Select Case State
		  Case Beacon.PusherSocket.States.Connected
		    Button.AlwaysUseActiveColor = False
		    Button.ActiveColor = OmniBarItem.ActiveColors.Green
		    Button.HelpTag = "Beacon is connected. Status updates happen in real time."
		    Button.Icon = IconToolbarCloud
		  Case Beacon.PusherSocket.States.Disconnected
		    Button.AlwaysUseActiveColor = False
		    Button.ActiveColor = OmniBarItem.ActiveColors.Orange
		    Button.HelpTag = "Beacon is disconnected. Most features will continue to work, but Beacon will not receive live status updates. Click to attempt to connect."
		    Button.Icon = IconToolbarCloudDisconnected
		  Case Beacon.PusherSocket.States.Errored
		    Button.AlwaysUseActiveColor = True
		    Button.ActiveColor = OmniBarItem.ActiveColors.Red
		    Button.HelpTag = "Beacon is disconnected due to an error. Most features will continue to work, but Beacon will not receive live status updates. Click to attempt to connect."
		    Button.Icon = IconToolbarCloudError
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateRenewButton()
		  If Self.NavBar Is Nil Then
		    Return
		  End If
		  
		  Var RenewButton As OmniBarItem = Self.NavBar.Item("NavRenew")
		  If RenewButton Is Nil Then
		    Return
		  End If
		  
		  Var Manager As IdentityManager = App.IdentityManager
		  If Manager Is Nil Then
		    RenewButton.Visible = False
		    Return
		  End If
		  
		  Var Identity As Beacon.Identity = Manager.CurrentIdentity
		  If Identity Is Nil Then
		    RenewButton.Visible = False
		    Return
		  End If
		  
		  Var Licenses() As Beacon.OmniLicense = Identity.ExpiredLicenses()
		  If Licenses.Count = 0 Then
		    RenewButton.Visible = False
		  ElseIf Licenses.Count = 1 Then
		    RenewButton.HelpTag = "Your update plan for '" + Licenses(0).Description(False) + "' expired on " + Licenses(0).ExpirationDateTime.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.None) + ". Renew your update plan to gain access to new features."
		    RenewButton.Visible = True
		  Else
		    RenewButton.HelpTag = "You have " + Language.NounWithQuantity(Licenses.Count, "expired update plan", "expired update plans") + ". Renew your update plans to gain access to new features."
		    RenewButton.Visible = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WindowTypeLabel() As String
		  Select Case Self.Pages.SelectedPanelIndex
		  Case Self.PageHome
		    Return "Home"
		  Case Self.PageDocuments
		    Return "Project"
		  Case Self.PageBlueprints
		    Return "Mod"
		  Case Self.PageTemplates
		    Return "Template"
		  Case Self.PageHelp
		    Return "Help"
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBusyWatcher As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObserver As NSNotificationObserverMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQuitWhenNotBusy As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToolbar As NSToolbarMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateText As String
	#tag EndProperty


	#tag Constant, Name = MinSplitterPosition, Type = Double, Dynamic = False, Default = \"300", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageBlueprints, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDocuments, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageHelp, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageHome, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageTemplates, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events NavBar
	#tag Event
		Sub Opening()
		  Var Home As OmniBarItem = OmniBarItem.CreateTab("NavHome", "Home")
		  Home.Toggled = True
		  Self.DashboardPane1.LinkedOmniBarItem = Home
		  
		  Var Documents As OmniBarItem = OmniBarItem.CreateTab("NavDocuments", "Projects")
		  Self.DocumentsComponent1.LinkedOmniBarItem = Documents
		  
		  Var Blueprints As OmniBarItem = OmniBarItem.CreateTab("NavBlueprints", "Mods")
		  Self.BlueprintsComponent1.LinkedOmniBarItem = Blueprints
		  
		  Var Templates As OmniBarItem = OmniBarItem.CreateTab("NavTemplates", "Templates")
		  Self.TemplatesComponent1.LinkedOmniBarItem = Templates
		  
		  Var Help As OmniBarItem = OmniBarItem.CreateTab("NavHelp", "Support")
		  Self.HelpComponent1.LinkedOmniBarItem = Help
		  
		  Var User As OmniBarItem = OmniBarItem.CreateButton("NavUser", "", Self.ProfileIcon, "Access user settings")
		  User.ButtonStyle = OmniBarItem.ButtonStyleLeftCaption
		  
		  Var Update As OmniBarItem = OmniBarItem.CreateButton("NavUpdate", "Update Ready", IconToolbarUpdate, "")
		  Update.AlwaysUseActiveColor = True
		  Update.ActiveColor = OmniBarItem.ActiveColors.Green
		  Update.Visible = False
		  
		  Var Pusher As OmniBarItem = OmniBarItem.CreateButton("NavPusher", "", IconToolbarCloudDisconnected, "")
		  Pusher.Visible = False
		  
		  Var Renew As OmniBarItem = OmniBarItem.CreateButton("NavRenew", "Renew Update Plan", IconToolbarRenew, "Renew your Beacon update plan")
		  Renew.AlwaysUseActiveColor = True
		  Renew.ActiveColor = OmniBarItem.ActiveColors.Orange
		  Renew.Visible = False
		  
		  Me.Append(Home, Documents, Blueprints, Templates, Help, OmniBarItem.CreateFlexibleSpace("MidSpacer"), Renew, Update, Pusher, OmniBarItem.CreateSeparator("UserSeparator"), User)
		  
		  Self.UpdatePusherStatus()
		  Self.UpdateRenewButton()
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Var NewIndex As Integer
		  Select Case Item.Name
		  Case "NavDocuments"
		    NewIndex = Self.PageDocuments
		  Case "NavBlueprints"
		    NewIndex = Self.PageBlueprints
		  Case "NavTemplates"
		    NewIndex = Self.PageTemplates
		  Case "NavHelp"
		    NewIndex = Self.PageHelp
		  Case "NavHome"
		    NewIndex = Self.PageHome
		  Case "NavUpdate"
		    Call App.HandleURL("beacon://action/checkforupdate")
		    Return
		  Case "NavUser"
		    Self.ShowUserMenu(Self.Left + Me.Left + ItemRect.Left, Self.Top + Me.Top + ItemRect.Bottom)
		    Return
		  Case "NavPusher"
		    If (App.Pusher Is Nil) = False And App.Pusher.State <> Beacon.PusherSocket.States.Connected Then
		      App.Pusher.Start()
		    End If
		    Return
		  Case "NavRenew"
		    System.GotoURL(Beacon.WebURL("/omni"))
		  Else
		    Return
		  End Select
		  
		  Self.SwitchView(NewIndex)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DashboardPane1
	#tag Event
		Sub NewDocument()
		  Self.DocumentsComponent1.NewProject()
		End Sub
	#tag EndEvent
	#tag Event
		Sub WantsFrontmost()
		  Self.SwitchView(Self.PageHome)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BlueprintsComponent1
	#tag Event
		Sub WantsFrontmost()
		  Self.SwitchView(Self.PageBlueprints)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DocumentsComponent1
	#tag Event
		Sub WantsFrontmost()
		  Self.SwitchView(Self.PageDocuments)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NotificationsPane1
	#tag Event
		Sub WantsFrontmost()
		  Self.SwitchView(Self.PageHome)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HelpComponent1
	#tag Event
		Sub WantsFrontmost()
		  Self.SwitchView(Self.PageHelp)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TemplatesComponent1
	#tag Event
		Sub WantsFrontmost()
		  Self.SwitchView(Self.PageTemplates)
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
