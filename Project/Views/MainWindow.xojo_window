#tag Window
Begin BeaconWindow MainWindow Implements AnimationKit.ValueAnimator,ObservationKit.Observer,NotificationKit.Receiver
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   True
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   True
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   817604607
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   True
   MinWidth        =   800
   Placement       =   2
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Beacon"
   Visible         =   True
   Width           =   800
   Begin TabBar TabBar1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Count           =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   41
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      SelectedIndex   =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   759
   End
   Begin PagePanel Views
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   375
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   41
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      Top             =   25
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   759
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
         Height          =   375
         HelpTag         =   ""
         InitialParent   =   "Views"
         Left            =   41
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
         ToolbarCaption  =   ""
         ToolbarIcon     =   0
         Top             =   25
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   759
      End
   End
   Begin ControlCanvas UpdateBar
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   41
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
      Top             =   -169
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   759
   End
   Begin ControlCanvas OverlayCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   100
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   69
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   445
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   False
      Width           =   100
   End
   Begin LibraryPane LibraryPane1
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   400
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   -259
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   300
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  #Pragma Unused AppQuitting
		  
		  Var ModifiedViews() As BeaconSubview
		  
		  For Each View As BeaconSubview In Self.mSubviews
		    If View.Changed Then
		      ModifiedViews.AddRow(View)
		    End If
		  Next
		  
		  Select Case ModifiedViews.LastRowIndex
		  Case -1
		    Return False
		  Case 0
		    Return Not Self.DiscardView(ModifiedViews(0))
		  Else
		    Var NumChanges As Integer = ModifiedViews.LastRowIndex + 1
		    
		    Var Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "You have " + NumChanges.ToString + " documents with unsaved changes. Do you want to review these changes before quitting?"
		    Dialog.Explanation = "If you don't review your documents, all your changes will be lost."
		    Dialog.ActionButton.Caption = "Review Changes…"
		    Dialog.CancelButton.Visible = True
		    Dialog.AlternateActionButton.Caption = "Discard Changes"
		    Dialog.AlternateActionButton.Visible = True
		    
		    Var Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		    If Choice = Dialog.ActionButton Then
		      For Each View As BeaconSubview In ModifiedViews
		        If Not Self.DiscardView(View) Then
		          Return True
		        End If
		      Next
		      Return False
		    ElseIf Choice = Dialog.CancelButton Then
		      Return True
		    ElseIf Choice = Dialog.AlternateActionButton Then
		      For Each View As BeaconSubview In ModifiedViews
		        View.DiscardChanges()
		      Next
		      Return False
		    End If
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, App.Notification_UpdateFound, BeaconSubview.Notification_ViewShown)
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  If Self.mCurrentView <> Nil Then
		    Self.mCurrentView.EnableMenuItems()
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
		    
		    Var Width As Integer = Min(Max(Bounds.Width, Self.MinimumWidth), Self.MaximumWidth, AvailableBounds.Width)
		    Var Height As Integer = Min(Max(Bounds.Height, Self.MinimumHeight), Self.MaximumHeight, AvailableBounds.Height)
		    Var Left As Integer = Min(Max(Bounds.Left, AvailableBounds.Left), AvailableBounds.Right - Width)
		    Var Top As Integer = Min(Max(Bounds.Top, AvailableBounds.Top), AvailableBounds.Bottom - Height)
		    Self.Bounds = New Xojo.Rect(Left, Top, Width, Height)
		  End If
		  
		  Self.UpdateSizeForView(Self.DashboardPane1)
		  NotificationKit.Watch(Self, App.Notification_UpdateFound, BeaconSubview.Notification_ViewShown)
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

	#tag Event
		Sub Resizing()
		  #if TargetWin32
		    Self.LibraryPane1.Dismiss()
		  #endif
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			If Self.mCurrentView = Nil Then
			Self.Close
			Return True
			End If
			
			Call Self.DiscardView(Self.mCurrentView)
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewDashboard() As Boolean Handles ViewDashboard.Action
			Self.ShowView(Self.DashboardPane1)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewDocuments() As Boolean Handles ViewDocuments.Action
			Self.LibraryPane1.ShowPage(LibraryPane.PaneDocuments)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewEngrams() As Boolean Handles ViewEngrams.Action
			Self.LibraryPane1.ShowPage(LibraryPane.PaneEngrams)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewPresets() As Boolean Handles ViewPresets.Action
			Self.LibraryPane1.ShowPage(LibraryPane.PanePresets)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewSearch() As Boolean Handles ViewSearch.Action
			Self.LibraryPane1.ShowPage(LibraryPane.PaneSearch)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ViewTools() As Boolean Handles ViewTools.Action
			Self.LibraryPane1.ShowPage(LibraryPane.PaneTools)
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub AnimationStep(Identifier As String, Value As Double)
		  // Part of the AnimationKit.ValueAnimator interface.
		  
		  Select Case Identifier
		  Case "overlay_opacity"
		    Self.mOverlayFillOpacity = Value
		    Self.OverlayCanvas.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentView() As BeaconSubview
		  Return Self.mCurrentView
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DiscardView(View As BeaconSubview) As Boolean
		  If View = DashboardPane1 Then
		    Return False
		  End If
		  
		  If Not View.ConfirmClose(AddressOf ShowView) Then
		    Return False
		  End If
		  
		  If View = Self.mCurrentView Then
		    Self.ShowView(Nil)
		  End If
		  
		  Var ViewIndex As Integer = Self.mSubviews.IndexOf(View)
		  If ViewIndex = -1 Then
		    Return True
		  End If
		  
		  View.AddObserver(Self, "ToolbarCaption")
		  View.AddObserver(Self, "ToolbarIcon")
		  
		  Self.mSubviews.RemoveRowAt(ViewIndex)
		  View.Close
		  Self.TabBar1.Count = Self.mSubviews.LastRowIndex + 2
		  Self.LibraryPane1.CleanupClosedViews()
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Documents() As LibraryPaneDocuments
		  Return Self.LibraryPane1.DocumentsPane
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mOverlayFillAnimation_Completed(Sender As AnimationKit.ValueTask)
		  #Pragma Unused Sender
		  
		  Self.OverlayCanvas.Visible = False
		  #if TargetWin32
		    Self.Views.Visible = True
		    Self.TabBar1.Visible = True
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case App.Notification_UpdateFound
		    Self.SetupUpdateUI()
		  Case BeaconSubview.Notification_ViewShown
		    Self.UpdateEditorMenu()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, Value As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Value
		  
		  Select Case Key
		  Case "MinimumWidth", "MinimumHeight"
		    If Self.mCurrentView <> Nil Then
		      Self.UpdateSizeForView(Self.mCurrentView)
		    Else
		      Self.UpdateSizeForView(Self.DashboardPane1)
		    End If
		  Case "ToolbarCaption", "ToolbarIcon"
		    Self.TabBar1.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As LibraryPanePresets
		  Return Self.LibraryPane1.PresetsPane
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUpdateUI()
		  If App.UpdateAvailable Then
		    Var Data As Dictionary = App.UpdateDetails
		    Var Preview As String = Data.Value("Preview")
		    If Preview <> "" Then
		      Self.mUpdateText = Preview + " Click here to update."
		    Else
		      Self.mUpdateText = "Beacon " + Data.Value("Version") + " is now available! Click here to update."
		    End If
		    Self.UpdateBarVisible = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowLibraryPane(PageIndex As Integer)
		  Self.LibraryPane1.ShowPage(PageIndex)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowView(View As BeaconSubview)
		  If Self.mCurrentView = View Then
		    Return
		  End If
		  
		  If Self.mCurrentView <> Nil Then
		    Self.mCurrentView.Visible = False
		    Self.mCurrentView.RemoveObserver(Self, "MinimumHeight")
		    Self.mCurrentView.RemoveObserver(Self, "MinimumWidth")
		    Self.mCurrentView.SwitchedFrom()
		  End If
		  
		  If View = Nil Or View = DashboardPane1 Then
		    Self.Changed = False
		    Self.mCurrentView = Nil
		    Self.Views.SelectedPanelIndex = 0
		    Self.TabBar1.SelectedIndex = 0
		    Self.UpdateSizeForView(DashboardPane1)
		    Self.DashboardPane1.SwitchedTo()
		    Self.UpdateSizeForView(Self.DashboardPane1)
		    Self.Title = "Beacon"
		    Self.UpdateEditorMenu()
		    Return
		  End If
		  
		  View.Visible = True
		  Self.mCurrentView = View
		  
		  Var ViewIndex As Integer = Self.mSubviews.IndexOf(View)
		  If ViewIndex = -1 Then
		    Self.mSubviews.AddRow(View)
		    ViewIndex = Self.mSubviews.LastRowIndex
		    Self.TabBar1.Count = Self.mSubviews.LastRowIndex + 2
		    View.EmbedWithinPanel(Self.Views, 1, 0, 0, Self.Views.Width, Self.Views.Height)
		    
		    View.AddObserver(Self, "ToolbarCaption")
		    View.AddObserver(Self, "ToolbarIcon")
		    
		    AddHandler View.OwnerModifiedHook, WeakAddressOf Subview_ContentsChanged
		  End If
		  Self.TabBar1.SelectedIndex = ViewIndex + 1
		  
		  Self.Changed = View.Changed
		  Self.UpdateSizeForView(View)
		  
		  If Self.mCurrentView.ToolbarCaption.Length > 0 Then
		    Self.Title = "Beacon: " + Self.mCurrentView.ToolbarCaption
		  Else
		    Self.Title = "Beacon"
		  End If
		  
		  Self.mCurrentView.SwitchedTo()
		  Self.UpdateSizeForView(Self.mCurrentView)
		  Self.mCurrentView.AddObserver(Self, "MinimumHeight")
		  Self.mCurrentView.AddObserver(Self, "MinimumWidth")
		  Self.Views.SelectedPanelIndex = 1
		  Self.UpdateEditorMenu()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Subview_ContentsChanged(Sender As ContainerControl)
		  If Self.mCurrentView = Sender Then
		    Self.Changed = Sender.Changed
		    If Self.mCurrentView.ToolbarCaption.Length > 0 Then
		      Self.Title = "Beacon: " + Self.mCurrentView.ToolbarCaption
		    Else
		      Self.Title = "Beacon"
		    End If
		  End If
		  Self.TabBar1.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tools() As LibraryPaneTools
		  Return Self.LibraryPane1.ToolsPane
		End Function
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
		  If Self.CurrentView <> Nil Then
		    Self.CurrentView.GetEditorMenuItems(Items)
		  End If
		  
		  If Items.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Menu.AddMenu(New MenuItem(MenuItem.TextSeparator))
		  
		  For Each Item As MenuItem In Items
		    Menu.AddMenu(Item)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSizeForView(View As BeaconSubview)
		  Self.MinimumWidth = Max(View.MinimumWidth, Self.AbsoluteMinWidth) + Self.Views.Left
		  Self.MinimumHeight = Max(View.MinimumHeight, Self.AbsoluteMinHeight) + Self.Views.Top
		  Self.Width = Max(Self.Width, Self.MinimumWidth)
		  Self.Height = Max(Self.Height, Self.MinimumHeight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewAtIndex(Idx As Integer) As BeaconSubview
		  Return Self.mSubviews(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewCount() As UInteger
		  Return Self.mSubviews.LastRowIndex + 1
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentView As BeaconSubview
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLibraryPaneAnimation As AnimationKit.MoveTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverlayFillAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverlayFillOpacity As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverlayPic As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubviews(-1) As BeaconSubview
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTabBarAnimation As AnimationKit.MoveTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateBarPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateText As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViewsAnimation As AnimationKit.MoveTask
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.UpdateBar.Top + Self.UpdateBar.Height > 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.UpdateBarVisible = Value Then
			    Return
			  End If
			  
			  Var UpdateBarHeight As Integer = If(Value, Self.UpdateBar.Height, 0)
			  
			  Self.Views.Height = Self.Height - (Self.TabBar1.Height + UpdateBarHeight)
			  Self.Views.Top = Self.Height - Self.Views.Height
			  Self.TabBar1.Top = UpdateBarHeight
			  Self.UpdateBar.Top = (Self.UpdateBar.Height * -1) + UpdateBarHeight
			  Self.UpdateBar.Invalidate
			End Set
		#tag EndSetter
		Private UpdateBarVisible As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = AbsoluteMinHeight, Type = Double, Dynamic = False, Default = \"468", Scope = Private
	#tag EndConstant

	#tag Constant, Name = AbsoluteMinWidth, Type = Double, Dynamic = False, Default = \"800", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinSplitterPosition, Type = Double, Dynamic = False, Default = \"300", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TabBar1
	#tag Event
		Sub Open()
		  Me.Count = 1
		End Sub
	#tag EndEvent
	#tag Event
		Function ViewAtIndex(TabIndex As Integer) As BeaconSubview
		  If TabIndex = 0 Then
		    Return DashboardPane1
		  Else
		    TabIndex = TabIndex - 1
		    If TabIndex >= 0 And TabIndex <= Self.mSubviews.LastRowIndex Then
		      Return Self.mSubviews(TabIndex)
		    End If
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub ShouldDismissView(ViewIndex As Integer)
		  If ViewIndex = 0 Then
		    Return
		  End If
		  
		  ViewIndex = ViewIndex - 1
		  If ViewIndex <= Self.mSubviews.LastRowIndex Then
		    Call Self.DiscardView(Self.mSubviews(ViewIndex))
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SwitchToView(ViewIndex As Integer)
		  If ViewIndex = 0 Then
		    Self.ShowView(DashboardPane1)
		    Return
		  End If
		  
		  ViewIndex = ViewIndex - 1
		  If ViewIndex <= Self.mSubviews.LastRowIndex Then
		    Self.ShowView(Self.mSubviews(ViewIndex))
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpdateBar
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.DrawingColor = SystemColors.SelectedContentBackgroundColor
		  G.FillRectangle(0, 0, G.Width, G.Height)
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRectangle(0, G.Height - 1, G.Width, 1)
		  
		  Var Caption As String = Self.mUpdateText
		  Var MaxCaptionWidth As Integer = G.Width - 40
		  Var CaptionWidth As Integer = Min(Ceil(G.TextWidth(Caption)), MaxCaptionWidth)
		  Var CaptionLeft As Integer = Round((G.Width - CaptionWidth) / 2)
		  Var CaptionBaseline As Double = ((G.Height - 1) / 2) + (G.CapHeight / 2)
		  
		  G.DrawingColor = SystemColors.AlternateSelectedControlTextColor
		  G.DrawText(Caption, CaptionLeft, CaptionBaseline, MaxCaptionWidth, True)
		  
		  If Self.mUpdateBarPressed Then
		    G.DrawingColor = &c00000080
		    G.FillRectangle(0, 0, G.Width, G.Height)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Self.mUpdateBarPressed = True
		  Self.UpdateBar.Invalidate
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var Inside As Boolean = (X >= 0 And Y >= 0 And X <= Me.Width And Y <= Me.Height - 1)
		  If Inside <> Self.mUpdateBarPressed Then
		    Self.mUpdateBarPressed = Inside
		    Self.UpdateBar.Invalidate
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Var Inside As Boolean = (X >= 0 And Y >= 0 And X <= Me.Width And Y <= Me.Height - 1)
		  If Inside Then
		    Call App.HandleURL("beacon://action/checkforupdate")
		  End If
		  Self.mUpdateBarPressed = False
		  Self.UpdateBar.Invalidate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OverlayCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  If Self.mOverlayPic <> Nil Then
		    G.DrawPicture(Self.mOverlayPic, 0, 0, G.Width, G.Height, 0, 0, Self.mOverlayPic.Width, Self.mOverlayPic.Height)
		  End If
		  
		  G.DrawingColor = SystemColors.ShadowColor.AtOpacity(Self.mOverlayFillOpacity)
		  G.FillRectangle(0, 0, G.Width, G.Height)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If X >= 0 And Y >= 0 And X <= Me.Width And Y <= Me.Height Then
		    Self.LibraryPane1.Dismiss
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.Visible = False
		  Me.Left = 0
		  Me.Top = 0
		  Me.Width = Self.Width
		  Me.Height = Self.Height
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LibraryPane1
	#tag Event
		Sub ShouldShowView(View As BeaconSubview)
		  Self.ShowView(View)
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldDiscardView(View As BeaconSubview) As Boolean
		  Return Self.DiscardView(View)
		End Function
	#tag EndEvent
	#tag Event
		Sub ChangePosition(Difference As Integer)
		  If Self.mLibraryPaneAnimation <> Nil Then
		    Self.mLibraryPaneAnimation.Cancel
		    Self.mLibraryPaneAnimation = Nil
		  End If
		  
		  Self.mLibraryPaneAnimation = New AnimationKit.MoveTask(Me)
		  Self.mLibraryPaneAnimation.Left = Me.Left + Difference
		  Self.mLibraryPaneAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		  Self.mLibraryPaneAnimation.DurationInSeconds = 0.12
		  Self.mLibraryPaneAnimation.Run
		  
		  If Self.mOverlayFillAnimation <> Nil Then
		    Self.mOverlayFillAnimation.Cancel
		    Self.mOverlayFillAnimation = Nil
		  End If
		  
		  If Self.mOverlayFillOpacity = 0 Then
		    Self.mOverlayPic = Self.Capture
		  End If
		  
		  If Difference > 0 Then
		    Self.OverlayCanvas.Visible = True
		    #if TargetWin32
		      Self.Views.Visible = False
		      Self.TabBar1.Visible = False
		    #endif
		    Self.mOverlayFillAnimation = New AnimationKit.ValueTask(Self, "overlay_opacity", Self.mOverlayFillOpacity, 0.35)
		  Else
		    Self.mOverlayFillAnimation = New AnimationKit.ValueTask(Self, "overlay_opacity", Self.mOverlayFillOpacity, 0.0)
		    AddHandler Self.mOverlayFillAnimation.Completed, WeakAddressOf mOverlayFillAnimation_Completed
		  End If
		  
		  Self.mOverlayFillAnimation.Curve = Self.mLibraryPaneAnimation.Curve
		  Self.mOverlayFillAnimation.DurationInSeconds = Self.mLibraryPaneAnimation.DurationInSeconds
		  Self.mOverlayFillAnimation.Run
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
