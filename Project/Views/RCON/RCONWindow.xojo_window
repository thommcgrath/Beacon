#tag DesktopWindow
Begin BeaconWindow RCONWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   234
   MinimumWidth    =   550
   Resizeable      =   True
   Title           =   "RCON"
   Type            =   0
   Visible         =   True
   Width           =   800
   Begin OmniBar TabsBar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      Left            =   201
      LeftPadding     =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   10
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   599
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   359
      Index           =   -2147483648
      Left            =   201
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   1
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   599
   End
   Begin FadedSeparator SidebarSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   400
      Index           =   -2147483648
      Left            =   200
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin OmniBar SidebarSwitcher
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      Left            =   0
      LeftPadding     =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RightPadding    =   10
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   200
   End
   Begin DesktopPagePanel Sidebar
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   359
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   200
      Begin RCONBookmarksSidebar Bookmarks
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   359
         Index           =   -2147483648
         InitialParent   =   "Sidebar"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         Transparent     =   True
         Visible         =   True
         Width           =   200
      End
      Begin RCONCommandsSidebar Commands
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   359
         Index           =   -2147483648
         InitialParent   =   "Sidebar"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         Transparent     =   True
         Visible         =   True
         Width           =   200
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.Panel.RemovePanelAt(0)
		  If Self.mOpenDefaultTab Then
		    Call Self.NewTab()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Attach(Container As RCONContainer)
		  If Container Is Nil Then
		    Return
		  End If
		  
		  If Self.mContainers.HasKey(Container.ViewId) Then
		    Self.CurrentView = Container
		    Return
		  End If
		  
		  Var Tab As OmniBarItem = OmniBarItem.CreateTab(Container.ViewId, "New Connection")
		  Tab.CanBeClosed = True
		  Container.LinkedOmniBarItem = Tab
		  Self.TabsBar.Append(Tab)
		  
		  Self.Panel.AddPanel
		  Var Idx As Integer = Self.Panel.LastAddedPanelIndex
		  Container.EmbedWithinPanel(Self.Panel, Idx, 0, 0, Self.Panel.Width, Self.Panel.Height)
		  Self.mPanelDiff = Container.PanelIndex - Idx // At least some Xojo versions get this wrong
		  
		  Self.mContainers.Value(Container.ViewId) = Container
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Constructor(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(WithDefaultTab As Boolean)
		  Self.mContainers = New Dictionary
		  Self.mOpenDefaultTab = WithDefaultTab
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContainerForConnection(Config As Beacon.RCONConfig, BringToFront As Boolean = False) As RCONContainer
		  If Config Is Nil Then
		    Return Nil
		  End If
		  
		  Return Self.ContainerForConnection(Config.Host, Config.Port, BringToFront)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContainerForConnection(Host As String, Port As Integer, BringToFront As Boolean = False) As RCONContainer
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Var Container As RCONContainer = Entry.Value
		    If Container.Host = Host And Container.Port = Port Then
		      If BringToFront Then
		        Self.CurrentView = Container
		      End If
		      Return Container
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentView() As RCONContainer
		  Return Self.mCurrentView
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentView(Assigns Container As RCONContainer)
		  If Container Is Nil Or Container = Self.mCurrentView Then
		    Return
		  End If
		  
		  If Self.mContainers.HasKey(Container.ViewId) = False Then
		    Return
		  End If
		  
		  If (Self.mCurrentView Is Nil) = False Then
		    Self.mCurrentView.SwitchedFrom()
		    If (Self.mCurrentView.LinkedOmniBarItem Is Nil) = False Then
		      Self.mCurrentView.LinkedOmniBarItem.Toggled = False
		    End If
		  End If
		  
		  Self.Panel.SelectedPanelIndex = Container.PanelIndex - Self.mPanelDiff
		  If (Container.LinkedOmniBarItem Is Nil) = False Then
		    Container.LinkedOmniBarItem.Toggled = True
		  End If
		  Self.mCurrentView = Container
		  Container.SwitchedTo(Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentViewId() As String
		  If Self.mCurrentView Is Nil Then
		    Return ""
		  End If
		  
		  Return Self.mCurrentView.ViewId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentViewId(Assigns ViewId As String)
		  If ViewId = Self.CurrentViewId Or Self.mContainers.HasKey(ViewId) = False Then
		    Return
		  End If
		  
		  Var Container As RCONContainer = Self.mContainers.Value(ViewId)
		  Self.CurrentView = Container
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewTab(AllowReuse As Boolean = True) As RCONContainer
		  Var Container As RCONContainer
		  If AllowReuse Then
		    For Each Entry As DictionaryEntry In Self.mContainers
		      Var Tab As RCONContainer = Entry.Value
		      If Tab.IsUsed = False Then
		        Container = Tab
		        Exit
		      End If
		    Next
		  End If
		  If Container Is Nil Then
		    Container = New RCONContainer
		    Self.Attach(Container)
		  End If
		  Self.CurrentView = Container
		  Return Container
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub PresentConfig(Config As Beacon.RCONConfig)
		  Var Win As RCONWindow = RCONWindow.WindowForConnection(Config, True)
		  If (Win Is Nil) = False Then
		    // Because it returned a window, it found a window that has this config
		    Return
		  End If
		  
		  For Each Window As DesktopWindow In App.Windows
		    If Window IsA RCONWindow Then
		      Win = RCONWindow(Window)
		      Exit
		    End If
		  Next
		  
		  If Win Is Nil Then
		    Win = New RCONWindow(False)
		  End If
		  
		  Var Container As RCONContainer = Win.NewTab
		  Container.Setup(Config, True)
		  Win.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetSidebarWidth(Width As Integer)
		  Var MinWidth As Integer = Width + Self.SidebarSeparator.Width + Self.TabMinWidth
		  If Self.Width < MinWidth Then
		    Self.Width = MinWidth
		  End If
		  Self.MinimumWidth = MinWidth
		  
		  Self.Sidebar.Width = Width
		  Self.SidebarSeparator.Left = Width
		  Self.SidebarSwitcher.Width = Width
		  Self.Panel.Left = Self.SidebarSeparator.Right
		  Self.Panel.Width = Self.Width - Self.Panel.Left
		  Self.TabsBar.Left = Self.Panel.Left
		  Self.TabsBar.Width = Self.Panel.Width
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function WindowForConnection(Config As Beacon.RCONConfig, BringToFront As Boolean = False) As RCONWindow
		  If Config Is Nil Then
		    Return Nil
		  End If
		  
		  Return RCONWindow.WindowForConnection(Config.Host, Config.Port, BringToFront)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function WindowForConnection(Host As String, Port As Integer, BringToFront As Boolean = False) As RCONWindow
		  For Each Win As DesktopWindow In App.Windows
		    If (Win IsA RCONWindow) = False Then
		      Continue
		    End If
		    
		    Var Container As RCONContainer = RCONWindow(Win).ContainerForConnection(Host, Port, BringToFront)
		    If (Container Is Nil) = False Then
		      If BringToFront Then
		        Win.Show
		      End If
		      Return RCONWindow(Win)
		    End If
		  Next
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContainers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentView As RCONContainer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpenDefaultTab As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPanelDiff As Integer
	#tag EndProperty


	#tag Constant, Name = PageBookmarks, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageCommands, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SidebarMargin, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SidebarSpacing, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TabMinHeight, Type = Double, Dynamic = False, Default = \"193", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TabMinWidth, Type = Double, Dynamic = False, Default = \"350", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TabsBar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("NewTabButton", "New Tab", IconToolbarAdd, "Creates a new RCON tab", True))
		  Me.Append(OmniBarItem.CreateSeparator)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  If Item Is Nil Then
		    Return
		  End If
		  
		  Select Case Item.Name
		  Case "NewTabButton"
		    Call Self.NewTab(False)
		  Else
		    Self.CurrentViewId = Item.Name
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldCloseItem(Item As OmniBarItem)
		  If Item Is Nil Then
		    Return
		  End If
		  
		  Var ViewId As String = Item.Name
		  If Self.mContainers.HasKey(ViewId) = False Then
		    Return
		  End If
		  Var View As RCONContainer = Self.mContainers.Value(ViewId)
		  Var PanelIndex As Integer = View.PanelIndex - Self.mPanelDiff
		  
		  Var TabIndex As Integer = Me.IndexOf(ViewId)
		  Var NewViewId As String = Self.CurrentViewId
		  If ViewId = Self.CurrentViewId Then
		    If Self.mContainers.KeyCount = 1 Then
		      NewViewId = ""
		    Else
		      If TabIndex > 2 Then
		        NewViewId = Me.Item(TabIndex - 1).Name
		      Else
		        NewViewId = Me.Item(TabIndex + 1).Name
		      End If
		    End If
		  End If
		  
		  Me.Remove(TabIndex)
		  Self.Panel.RemovePanelAt(PanelIndex)
		  Self.mContainers.Remove(ViewId)
		  
		  If NewViewId.IsEmpty Then
		    Self.mCurrentView = Nil
		  ElseIf Self.CurrentViewId = NewViewId Then
		    Self.Panel.SelectedPanelIndex = Self.mCurrentView.PanelIndex - Self.mPanelDiff
		  Else
		    Self.CurrentViewId = NewViewId
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SidebarSwitcher
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateButton("BookmarksButton", "Bookmarks", IconToolbarBookmark, "Show saved RCON bookmarks."))
		  Me.Append(OmniBarItem.CreateButton("CommandsButton", "Commands", IconToolbarCommand, "Show game commands."))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.ToggleOnly("BookmarksButton")
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "BookmarksButton"
		    Self.Sidebar.SelectedPanelIndex = Self.PageBookmarks
		    Me.ToggleOnly(Item.Name)
		  Case "CommandsButton"
		    Self.Sidebar.SelectedPanelIndex = Self.PageCommands
		    Me.ToggleOnly(Item.Name)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Bookmarks
	#tag Event
		Sub LoadBookmark(Config As Beacon.RCONConfig)
		  Var Win As RCONWindow = RCONWindow.WindowForConnection(Config, True)
		  If Win Is Nil Then
		    Var Container As RCONContainer = Self.NewTab
		    Container.Setup(Config, False)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Commands
	#tag Event
		Function InsertCommand(Command As String) As Boolean
		  If Self.mCurrentView Is Nil Then
		    Self.ShowAlert("No RCON tab", "To insert this command, please open a new tab and connect to a server.")
		    Return False
		  End If
		  
		  If Self.mCurrentView.IsConnected = False Then
		    Self.ShowAlert("RCON is not connected", "The RCON server is not connected. Please connect to a server to insert this command.")
		    Return False
		  End If
		  
		  Self.mCurrentView.InsertCommand(Command)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub RequestResize(Width As Integer, Height As Integer)
		  Var MinHeight As Integer = Max(Height, Self.TabMinHeight) + Self.SidebarSwitcher.Top + Self.SidebarSwitcher.Height
		  If Self.Height < MinHeight Then
		    Self.Height = MinHeight
		  End If
		  Self.MinimumHeight = MinHeight
		  
		  Self.SetSidebarWidth(Max(Width, 200))
		End Sub
	#tag EndEvent
	#tag Event
		Sub RestoreDimensions()
		  Self.SetSidebarWidth(200)
		  Self.MinimumHeight = Self.TabMinHeight + Self.TabsBar.Top + Self.TabsBar.Height
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
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
		Name="Resizeable"
		Visible=false
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
