#tag Window
Begin ContainerControl LibraryPane
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
   Height          =   468
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   300
   Begin PagePanel Views
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   468
      HelpTag         =   ""
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
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Transparent     =   False
      Value           =   4
      Visible         =   True
      Width           =   300
      Begin LibraryPaneDocuments DocumentsView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   468
         HelpTag         =   ""
         InitialParent   =   "Views"
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
         ToolbarCaption  =   ""
         ToolbarIcon     =   0
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         View            =   0
         Visible         =   True
         Width           =   300
      End
      Begin LibraryPanePresets PresetsView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   468
         HelpTag         =   ""
         InitialParent   =   "Views"
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
         ToolbarCaption  =   ""
         ToolbarIcon     =   0
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   300
      End
      Begin LibraryPaneEngrams EngramsView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   468
         HelpTag         =   ""
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         ToolbarCaption  =   ""
         ToolbarIcon     =   0
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   300
      End
      Begin LibraryPaneTools ToolsView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   468
         HelpTag         =   ""
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         ToolbarCaption  =   ""
         ToolbarIcon     =   0
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   300
      End
      Begin LibraryPaneSearch SearchView
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   468
         HelpTag         =   ""
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         ToolbarCaption  =   ""
         ToolbarIcon     =   0
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   300
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  Self.CurrentView.EnableMenuItems()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.CurrentView.SwitchedTo()
		  RaiseEvent Open
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CurrentPage() As Integer
		  Return Self.Views.Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CurrentView() As LibrarySubview
		  Return Self.ViewAtIndex(Self.Views.Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentsPane() As LibraryPaneDocuments
		  Return Self.DocumentsView
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsPane() As LibraryPaneEngrams
		  Return Self.EngramsView
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PresetsPane() As LibraryPanePresets
		  Return Self.PresetsView
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchPane() As LibraryPaneSearch
		  Return Self.SearchView
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowPage(Index As Integer, UserData As Auto = Nil)
		  If Self.Views.Value = Index Or Index = -1 Then
		    Return
		  End If
		  
		  Dim OldPage As LibrarySubview = Self.CurrentView
		  If OldPage <> Nil Then
		    OldPage.SwitchedFrom()
		  End If
		  
		  Dim NewPage As LibrarySubview = Self.ViewAtIndex(Index)
		  If NewPage <> Nil Then  
		    Self.Views.Value = Index
		    NewPage.SwitchedTo(UserData)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToolsPane() As LibraryPaneTools
		  Return Self.ToolsView
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ViewAtIndex(Index As Integer) As LibrarySubview
		  Select Case Index
		  Case Self.PaneDocuments
		    Return Self.DocumentsView
		  Case Self.PanePresets
		    Return Self.PresetsView
		  Case Self.PaneEngrams
		    Return Self.EngramsView
		  Case Self.PaneTools
		    Return Self.ToolsView
		  Case Self.PaneSearch
		    Return Self.SearchView
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldDiscardView(View As BeaconSubview) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(ByRef NewSize As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldShowView(View As BeaconSubview)
	#tag EndHook


	#tag Constant, Name = PaneDocuments, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PaneEngrams, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PanePresets, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PaneSearch, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PaneTools, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events DocumentsView
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldDiscardView(View As BeaconSubview) As Boolean
		  Return RaiseEvent ShouldDiscardView(View)
		End Function
	#tag EndEvent
	#tag Event
		Sub ShouldShowView(View As BeaconSubview)
		  RaiseEvent ShouldShowView(View)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PresetsView
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldShowView(View As BeaconSubview)
		  RaiseEvent ShouldShowView(View)
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldDiscardView(View As BeaconSubview) As Boolean
		  Return RaiseEvent ShouldDiscardView(View)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events EngramsView
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldDiscardView(View As BeaconSubview) As Boolean
		  Return RaiseEvent ShouldDiscardView(View)
		End Function
	#tag EndEvent
	#tag Event
		Sub ShouldShowView(View As BeaconSubview)
		  RaiseEvent ShouldShowView(View)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ToolsView
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldDiscardView(View As BeaconSubview) As Boolean
		  Return RaiseEvent ShouldDiscardView(View)
		End Function
	#tag EndEvent
	#tag Event
		Sub ShouldShowView(View As BeaconSubview)
		  RaiseEvent ShouldShowView(View)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SearchView
	#tag Event
		Function ShouldDiscardView(View As BeaconSubview) As Boolean
		  Return RaiseEvent ShouldDiscardView(View)
		End Function
	#tag EndEvent
	#tag Event
		Sub ShouldShowView(View As BeaconSubview)
		  RaiseEvent ShouldShowView(View)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
