#tag Window
Begin BeaconDialog ResolveIssuesDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   547
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   500
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Document Issues"
   Visible         =   True
   Width           =   600
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "This document has problems that must be resolved"
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
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   507
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox IssuesList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   160
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Label BlueprintsExplanation
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   39
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "To resolve unknown blueprint problems, paste their spawn codes below. It is ok to include more codes than necessary, Beacon will use only the ones it needs."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   224
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin TextArea BlueprintsField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   220
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "Source Code Pro"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   275
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton ExtractButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Extract Blueprints"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   507
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   131
   End
   Begin UITweaks.ResizedPushButton GoToButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Go To Issue"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   383
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   507
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin ProgressWheel ResolutionSpinner
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   163
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   509
      Transparent     =   False
      Visible         =   False
      Width           =   16
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.UpdateUI()
		  Self.GoToButton.Visible = (Self.GoToIssueHandler <> Nil)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Document As Beacon.Document, Issues() As Beacon.Issue, Handler As ResolveIssuesDialog.GoToIssueCallback)
		  Self.Issues = Issues
		  Self.Document = Document
		  Self.GoToIssueHandler = Handler
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DescribeIssues(Document As Beacon.Document) As Beacon.Issue()
		  Dim DocumentIssues() As Beacon.Issue
		  
		  Dim UniqueIssues As New Dictionary
		  If Document.MapCompatibility = 0 Then
		    Dim Issue As New Beacon.Issue("Maps", "No maps have been selected. Use the ""Maps"" config editor to choose maps.")
		    UniqueIssues.Value(Issue.Description) = Issue
		    DocumentIssues.AddRow(Issue)
		  End If
		  
		  Dim Configs() As Beacon.ConfigGroup = Document.ImplementedConfigs
		  For Each Config As Beacon.ConfigGroup In Configs
		    Dim Issues() As Beacon.Issue = Config.Issues(Document, App.IdentityManager.CurrentIdentity)
		    For Each Issue As Beacon.Issue In Issues
		      If Not UniqueIssues.HasKey(Issue.Description) Then
		        DocumentIssues.AddRow(Issue)
		        UniqueIssues.Value(Issue.Description) = Issue
		      End If
		    Next
		  Next
		  
		  Return DocumentIssues
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub GoToIssueCallback(Issue As Beacon . Issue)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, Document As Beacon.Document, Handler As ResolveIssuesDialog.GoToIssueCallback = Nil)
		  Dim Issues() As Beacon.Issue = DescribeIssues(Document)
		  If Issues.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim Win As New ResolveIssuesDialog(Document, Issues, Handler)
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResolvingFinished()
		  Self.ConfigsWaitingToResolve = Self.ConfigsWaitingToResolve - 1
		  
		  If Self.ConfigsWaitingToResolve > 0 Then
		    Return
		  End If
		  
		  Dim Issues() As Beacon.Issue = Self.DescribeIssues(Self.Document)
		  If Issues.LastRowIndex = -1 Then
		    BeaconUI.ShowAlert("All issues resolved.", "Great! All issues have been resolved.")
		    Self.Close
		    Return
		  End If
		  
		  Dim SomeResolved As Boolean = Issues.LastRowIndex < Self.Issues.LastRowIndex
		  
		  Self.Issues = Issues
		  Self.UpdateUI
		  
		  Self.ActionButton.Enabled = True
		  Self.ExtractButton.Enabled = BlueprintsField.Value.Length > 0
		  Self.ResolutionSpinner.Visible = False
		  Self.GoToButton.Enabled = Self.GoToIssueHandler <> Nil And Self.IssuesList.SelectedRowIndex > -1
		  Self.BlueprintsField.ReadOnly = False
		  
		  If SomeResolved Then
		    BeaconUI.ShowAlert("Some issues resolved.", "The text successfully resolved some issues, but not all of them.")
		  Else
		    BeaconUI.ShowAlert("No issues resolved.", "The text provided did not resolve any issues.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.IssuesList.RemoveAllRows
		  For Each Issue As Beacon.Issue In Self.Issues
		    Self.IssuesList.AddRow(Issue.Description)
		    Self.IssuesList.RowTagAt(Self.IssuesList.LastAddedRowIndex) = Issue
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ConfigsWaitingToResolve As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Document As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private GoToIssueHandler As ResolveIssuesDialog.GoToIssueCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Issues() As Beacon.Issue
	#tag EndProperty


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IssuesList
	#tag Event
		Sub Change()
		  Self.GoToButton.Enabled = ResolutionSpinner.Visible = False And Self.GoToIssueHandler <> Nil And Me.SelectedRowIndex > -1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BlueprintsField
	#tag Event
		Sub TextChange()
		  Self.ExtractButton.Enabled = Me.Value.Trim <> ""
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ExtractButton
	#tag Event
		Sub Action()
		  ResolutionSpinner.Visible = True
		  ActionButton.Enabled = False
		  GoToButton.Enabled = False
		  Me.Enabled = False
		  BlueprintsField.ReadOnly = True
		  
		  Dim Content As String = BlueprintsField.Value
		  Dim Configs() As Beacon.ConfigGroup = Self.Document.ImplementedConfigs
		  Dim Callback As Beacon.ConfigGroup.ResolveIssuesCallback = AddressOf ResolvingFinished
		  Self.ConfigsWaitingToResolve = Configs.LastRowIndex + 1
		  For Each Config As Beacon.ConfigGroup In Configs
		    Config.TryToResolveIssues(Content, Callback)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GoToButton
	#tag Event
		Sub Action()
		  If Self.IssuesList.SelectedRowIndex = -1 Or Self.GoToIssueHandler = Nil Then
		    Return
		  End If
		  
		  Dim Issue As Beacon.Issue = Self.IssuesList.RowTagAt(Self.IssuesList.SelectedRowIndex)
		  Self.Hide()
		  Self.GoToIssueHandler.Invoke(Issue)
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
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
