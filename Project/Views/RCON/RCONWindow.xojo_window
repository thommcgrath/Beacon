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
   MinimumHeight   =   200
   MinimumWidth    =   300
   Resizeable      =   True
   Title           =   "RCON"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin OmniBar TabsBar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   38
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   362
      Index           =   -2147483648
      Left            =   0
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
      Top             =   38
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.Panel.RemovePanelAt(0)
		  Call Self.NewTab()
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
		  Self.mContainers = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContainerForConnection(Host As String, Port As Integer) As RCONContainer
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Var Container As RCONContainer = Entry.Value
		    If Container.IsConnected And Container.Host = Host And Container.Port = Port Then
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
		Function NewTab() As RCONContainer
		  Var Container As New RCONContainer
		  Self.Attach(Container)
		  Self.CurrentView = Container
		  Return Container
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function WindowForConnection(Host As String, Port As Integer) As RCONWindow
		  For Each Win As DesktopWindow In App.Windows
		    If (Win IsA RCONWindow) = False Then
		      Continue
		    End If
		    
		    Var Container As RCONContainer = RCONWindow(Win).ContainerForConnection(Host, Port)
		    If (Container Is Nil) = False Then
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
		Private mPanelDiff As Integer
	#tag EndProperty


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
		    Call Self.NewTab()
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
