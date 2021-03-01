#tag Window
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
      ContentHeight   =   0
      DoubleBuffer    =   False
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
      RightPadding    =   -1
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
   Begin PagePanel Pages
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   38
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   1420
      Begin DashboardPane DashboardPane1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   782
         HelpTag         =   ""
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
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   38
         Transparent     =   True
         UseFocusRing    =   False
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
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
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
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Blueprints"
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
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
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
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
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
         DoubleBuffer    =   False
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
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
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
      Begin PresetsComponent PresetsComponent1
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
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Presets"
         Visible         =   True
         Width           =   1420
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  Const AllowClose = False
		  Const BlockClose = True
		  
		  If Self.DocumentsComponent1.ConfirmClose(AddressOf ShowView) = False Then
		    Return BlockClose
		  End If
		  
		  If Self.BlueprintsComponent1.ConfirmClose(AddressOf ShowView) = False Then
		    Return BlockClose
		  End If
		  
		  If Self.PresetsComponent1.ConfirmClose(AddressOf ShowView) = False Then
		    Return BlockClose
		  End If
		  
		  If Self.Busy Then
		    Self.mQuitWhenNotBusy = Self.mQuitWhenNotBusy Or AppQuitting
		    If Self.mBusyWatcher Is Nil Then
		      Self.mBusyWatcher = New Timer
		      Self.mBusyWatcher.Period = 500
		      AddHandler mBusyWatcher.Action, WeakAddressOf mBusyWatcher_Action
		    End If
		    Self.mBusyWatcher.RunMode = Timer.RunModes.Multiple
		    Return BlockClose
		  End If
		  
		  Return AllowClose
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, UpdatesKit.Notification_UpdateAvailable, BeaconSubview.Notification_ViewShown)
		  #if TargetMacOS
		    NSNotificationCenterMBS.DefaultCenter.RemoveObserver(Self.mObserver)
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
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
		Sub Open()
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
		    Var IdealScreen As Screen = Screen(0)
		    If ScreenCount > 1 Then
		      Var MaxArea As Integer
		      For I As Integer = 0 To ScreenCount - 1
		        Var ScreenBounds As New Rect(Screen(I).AvailableLeft, Screen(I).AvailableTop, Screen(I).AvailableWidth, Screen(I).AvailableHeight)
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
		          IdealScreen = Screen(I)
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
		  
		  NotificationKit.Watch(Self, UpdatesKit.Notification_UpdateAvailable, BeaconSubview.Notification_ViewShown)
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
		Function ViewPresets() As Boolean Handles ViewPresets.Action
			Self.ShowPresets()
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
		  
		  If (Self.PresetsComponent1 Is Nil) = False And Self.PresetsComponent1.Busy Then
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
		  Case Self.PagePresets
		    Return Self.PresetsComponent1
		  Case Self.PageHelp
		    Return Self.HelpComponent1
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentEditors() As DocumentEditorView()
		  Return Self.DocumentsComponent1.DocumentEditors
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

	#tag Method, Flags = &h0
		Function FrontmostDocumentView() As DocumentEditorView
		  Var DocumentView As BeaconSubview = Self.DocumentsComponent1.CurrentPage
		  If (DocumentView Is Nil) = False And DocumentView IsA DocumentEditorView Then
		    Return DocumentEditorView(DocumentView)
		  End If
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
		  
		  If (Self.PresetsComponent1 Is Nil) = False And Self.PresetsComponent1.HasModifications Then
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
		  
		  Select Case Notification.Name
		  Case UpdatesKit.Notification_UpdateAvailable
		    Self.SetupUpdateUI()
		  Case BeaconSubview.Notification_ViewShown
		    Self.UpdateEditorMenu()
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
		    Self.NavBar.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets(SwitchTo As Boolean = True) As PresetsComponent
		  If SwitchTo Then
		    Self.SwitchView(Self.PagePresets)
		  End If
		  
		  Return Self.PresetsComponent1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUpdateUI()
		  If UpdatesKit.IsUpdateAvailable Then
		    Var Preview As String = UpdatesKit.AvailablePreview
		    If Preview.IsEmpty = False Then
		      Preview = Preview + " Click here to update."
		    Else
		      Preview = "Beacon " + UpdatesKit.AvailableDisplayVersion + " is now available! Click here to update."
		    End If
		    
		    Var UpdateItem As OmniBarItem = Self.NavBar.Item("NavUpdate")
		    If UpdateItem Is Nil Then
		      UpdateItem = OmniBarItem.CreateButton("NavUpdate", "", IconToolbarUpdate, Preview)
		      UpdateItem.AlwaysUseActiveColor = True
		      UpdateItem.ActiveColor = OmniBarItem.ActiveColors.Green
		      
		      Var Idx As Integer = Self.NavBar.IndexOf("NavUser")
		      If Idx > -1 Then
		        Self.NavBar.Insert(Idx, UpdateItem)
		      Else
		        Self.NavBar.Append(UpdateItem)
		      End If
		    Else
		      UpdateItem.HelpTag = Preview
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
		Sub ShowPresets()
		  Self.SwitchView(Self.PagePresets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowUserMenu(X As Integer, Y As Integer)
		  Var Base As New MenuItem
		  
		  If Not Preferences.OnlineEnabled Then
		    Base.AddMenu(New MenuItem("Enable Cloud && Community", "beacon://action/enableonline"))
		  Else
		    If App.IdentityManager.CurrentIdentity = Nil Or App.IdentityManager.CurrentIdentity.Username = "" Then
		      Base.AddMenu(New MenuItem("Sign In", "beacon://action/signin"))
		    Else
		      Var IdentityItem As New MenuItem(App.IdentityManager.CurrentIdentity.Username(True), "")
		      IdentityItem.Enabled = False
		      Base.AddMenu(IdentityItem)
		      Base.AddMenu(New MenuItem("Manage Account", "beacon://action/showaccount"))
		      Base.AddMenu(New MenuItem("Sign Out", "beacon://action/signout"))
		    End If
		  End If
		  Base.AddMenu(New MenuItem(MenuItem.TextSeparator))
		  Base.AddMenu(New MenuItem("User Info…", "beacon://action/showidentity"))
		  
		  Var Choice As MenuItem = Base.PopUp(X, Y)
		  If Choice Is Nil Or IsNull(Choice.Tag) Or Choice.Tag.Type <> Variant.TypeString Then
		    Return
		  End If
		  
		  If Choice.Tag.StringValue.IsEmpty = False Then
		    Call App.HandleURL(Choice.Tag.StringValue)
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
		  Var CurrentIndex As Integer = Self.Pages.SelectedPanelIndex
		  If CurrentIndex = Index Then
		    Return
		  End If
		  
		  If Index = Self.PageHelp And BeaconUI.WebContentSupported = False Then
		    ShowURL(HelpComponent.HelpURL)
		    Return
		  End If
		  
		  Select Case CurrentIndex
		  Case Self.PageHome
		    Self.DashboardPane1.SwitchedFrom()
		  Case Self.PageDocuments
		    Self.DocumentsComponent1.SwitchedFrom()
		  Case Self.PageBlueprints
		    Self.BlueprintsComponent1.SwitchedFrom()
		  Case Self.PagePresets
		    Self.PresetsComponent1.SwitchedFrom()
		  Case Self.PageHelp
		    Self.HelpComponent1.SwitchedFrom()
		  End Select
		  
		  Self.Pages.SelectedPanelIndex = Index
		  
		  Select Case Index
		  Case Self.PageHome
		    Self.DashboardPane1.SwitchedTo(Nil)
		  Case Self.PageDocuments
		    Self.DocumentsComponent1.SwitchedTo(Nil)
		  Case Self.PageBlueprints
		    Self.BlueprintsComponent1.SwitchedTo(Nil)
		  Case Self.PagePresets
		    Self.PresetsComponent1.SwitchedTo(Nil)
		  Case Self.PageHelp
		    Self.HelpComponent1.SwitchedTo(Nil)
		  End Select
		  
		  For Idx As Integer = 0 To Self.NavBar.LastIndex
		    Self.NavBar.Item(Idx).Toggled = (Idx = Index)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEditorMenu()
		  Var Menu As MenuItem = EditorMenu
		  
		  For I As Integer = Menu.LastRowIndex DownTo 0
		    If Menu.MenuAt(I) IsA ConfigGroupMenuItem Then
		      Exit For I
		    End If
		    Menu.RemoveMenuAt(I)
		  Next
		  
		  Var Items() As MenuItem
		  Var Component As BeaconSubview = Self.CurrentComponent
		  If (Component Is Nil) = False Then
		    Component.GetEditorMenuItems(Items)
		  End If
		  
		  If Items.LastIndex = -1 Then
		    Return
		  End If
		  
		  Menu.AddMenu(New MenuItem(MenuItem.TextSeparator))
		  
		  For Each Item As MenuItem In Items
		    Menu.AddMenu(Item)
		  Next
		End Sub
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

	#tag Constant, Name = PagePresets, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events NavBar
	#tag Event
		Sub Open()
		  Var Home As OmniBarItem = OmniBarItem.CreateTab("NavHome", "Home")
		  Home.Toggled = True
		  Self.DashboardPane1.LinkedOmniBarItem = Home
		  
		  Var Documents As OmniBarItem = OmniBarItem.CreateTab("NavDocuments", "Projects")
		  Self.DocumentsComponent1.LinkedOmniBarItem = Documents
		  
		  Var Blueprints As OmniBarItem = OmniBarItem.CreateTab("NavBlueprints", "Blueprints")
		  Self.BlueprintsComponent1.LinkedOmniBarItem = Blueprints
		  
		  Var Presets As OmniBarItem = OmniBarItem.CreateTab("NavPresets", "Presets")
		  Self.PresetsComponent1.LinkedOmniBarItem = Presets
		  
		  Var Help As OmniBarItem = OmniBarItem.CreateTab("NavHelp", "Support")
		  Self.HelpComponent1.LinkedOmniBarItem = Help
		  
		  Var User As OmniBarItem = OmniBarItem.CreateButton("NavUser", "", IconToolbarUser, "Access user settings")
		  
		  Me.Append(Home, Documents, Blueprints, Presets, Help, OmniBarItem.CreateFlexibleSpace, User)
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
		  Case "NavPresets"
		    NewIndex = Self.PagePresets
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
		  Self.SwitchView(Self.PageDocuments)
		  Self.DocumentsComponent1.NewDocument()
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
#tag Events PresetsComponent1
	#tag Event
		Sub WantsFrontmost()
		  Self.SwitchView(Self.PagePresets)
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
		Type="MenuBar"
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
