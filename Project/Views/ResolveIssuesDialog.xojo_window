#tag Window
Begin Window ResolveIssuesDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   547
   ImplicitInstance=   False
   LiveResize      =   True
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
   Resizeable      =   True
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
      ButtonStyle     =   "0"
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
      RowCount        =   0
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
      ButtonStyle     =   "0"
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
      ButtonStyle     =   "0"
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
		  
		  If Document.IsValid Then
		    Return DocumentIssues
		  End If
		  
		  Dim UniqueIssues As New Xojo.Core.Dictionary
		  Dim Configs() As Beacon.ConfigGroup = Document.ImplementedConfigs
		  For Each Config As Beacon.ConfigGroup In Configs
		    Dim Issues() As Beacon.Issue = Config.Issues(Document)
		    For Each Issue As Beacon.Issue In Issues
		      If Not UniqueIssues.HasKey(Issue.Description) Then
		        DocumentIssues.Append(Issue)
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
		  If Issues.Ubound = -1 Then
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
		  If Issues.Ubound = -1 Then
		    BeaconUI.ShowAlert("All issues resolved.", "Great! All issues have been resolved.")
		    Self.Close
		    Return
		  End If
		  
		  Dim SomeResolved As Boolean = Issues.Ubound < Self.Issues.Ubound
		  
		  Self.Issues = Issues
		  Self.UpdateUI
		  
		  Self.ActionButton.Enabled = True
		  Self.ExtractButton.Enabled = BlueprintsField.Text.Len > 0
		  Self.ResolutionSpinner.Visible = False
		  Self.GoToButton.Enabled = Self.GoToIssueHandler <> Nil And Self.IssuesList.ListIndex > -1
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
		  Self.IssuesList.DeleteAllRows
		  For Each Issue As Beacon.Issue In Self.Issues
		    Self.IssuesList.AddRow(Issue.Description)
		    Self.IssuesList.RowTag(Self.IssuesList.LastIndex) = Issue
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
		  Self.GoToButton.Enabled = ResolutionSpinner.Visible = False And Self.GoToIssueHandler <> Nil And Me.ListIndex > -1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BlueprintsField
	#tag Event
		Sub TextChange()
		  Self.ExtractButton.Enabled = Trim(Me.Text) <> ""
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
		  
		  Dim Content As Text = BlueprintsField.Text.ToText
		  Dim Configs() As Beacon.ConfigGroup = Self.Document.ImplementedConfigs
		  Dim Callback As Beacon.ConfigGroup.ResolveIssuesCallback = AddressOf ResolvingFinished
		  Self.ConfigsWaitingToResolve = Configs.Ubound + 1
		  For Each Config As Beacon.ConfigGroup In Configs
		    Config.TryToResolveIssues(Content, Callback)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GoToButton
	#tag Event
		Sub Action()
		  If Self.IssuesList.ListIndex = -1 Or Self.GoToIssueHandler = Nil Then
		    Return
		  End If
		  
		  Dim Issue As Beacon.Issue = Self.IssuesList.RowTag(Self.IssuesList.ListIndex)
		  Self.Hide()
		  Self.GoToIssueHandler.Invoke(Issue)
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
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
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
