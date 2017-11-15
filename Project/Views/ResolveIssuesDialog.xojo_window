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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   507
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
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
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
      AutomaticallyCheckSpelling=   True
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
      Styled          =   True
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   275
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
      Underline       =   False
      Visible         =   True
      Width           =   131
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  For Each Issue As String In Self.Issues
		    IssuesList.AddRow(Issue)
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Document As Beacon.Document, Issues() As String)
		  Self.Issues = Issues
		  Self.Document = Document
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DescribeIssues(Document As Beacon.Document) As String()
		  Dim Issues As New Dictionary
		  
		  If Document.Map = Nil Then
		    Issues.Value("No map is selected. Press the gear icon below the loot sources list to pick a map.") = True
		  End If
		  If Document.DifficultyValue = -1 Then
		    Issues.Value("Difficulty is not set. Press the gear icon below the loot sources list to set difficulty.") = True
		  End If
		  
		  Dim EmptyOptionsCount As Integer
		  For Each Source As Beacon.LootSource In Document.LootSources
		    If Source.IsValid Then
		      Continue
		    End If
		    
		    If Source.Count < Source.RequiredItemSets Then
		      Issues.Value("Loot source " + Source.Label + " is needs at least " + Str(Source.RequiredItemSets, "-0") + " " + if(Source.RequiredItemSets = 1, "item set", "item sets") + " to work correctly.") = True
		    Else
		      For Each Set As Beacon.ItemSet In Source
		        If Set.IsValid Then
		          Continue
		        End If
		        
		        If Set.Count = 0 Then
		          Issues.Value("Item set " + Set.Label + " of loot source " + Source.Label + " is empty.") = True
		        Else
		          For Each Entry As Beacon.SetEntry In Set
		            If Entry.IsValid Then
		              Continue
		            End If
		            
		            If Entry.Count = 0 Then
		              EmptyOptionsCount = EmptyOptionsCount + 1
		            Else
		              For Each Option As Beacon.SetEntryOption In Entry
		                If Option.IsValid Then
		                  Continue
		                End If
		                
		                If Option.Engram = Nil Then
		                  EmptyOptionsCount = EmptyOptionsCount + 1
		                Else
		                  Issues.Value("Beacon does not know the blueprint for " + Option.Engram.ClassString + ".") = True
		                End If
		              Next
		            End If
		          Next
		        End If
		      Next
		    End If
		  Next
		  
		  If EmptyOptionsCount = 1 Then
		    Issues.Value("A set entry has no engrams selected.") = True
		  ElseIf EmptyOptionsCount > 1 Then
		    Issues.Value(Str(EmptyOptionsCount, "-0") + " set entries have no engrams selected.") = True
		  End If
		  
		  Dim Keys() As Variant = Issues.Keys
		  Dim List() As String
		  For Each Key As String In Keys
		    List.Append(Key)
		  Next
		  List.Sort
		  Return List
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, Document As Beacon.Document)
		  Dim Issues() As String = ResolveIssuesDialog.DescribeIssues(Document)
		  If UBound(Issues) = -1 Then
		    Return
		  End If
		  
		  Dim Win As New ResolveIssuesDialog(Document, Issues)
		  Win.ShowModalWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Document As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Issues() As String
	#tag EndProperty


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Action()
		  Self.Close
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
		  Dim Content As String = BlueprintsField.Text
		  Dim Engrams() As Beacon.Engram = Beacon.PullEngramsFromText(Content)
		  Self.Document.ConsumeMissingEngrams(Engrams)
		  
		  // Once extracted
		  Dim OriginalIssueCount As Integer = UBound(Self.Issues)
		  Self.Issues = Self.DescribeIssues(Self.Document)
		  Dim NewIssueCount As Integer = UBound(Self.Issues)
		  If UBound(Self.Issues) = -1 Then
		    Self.ShowAlert("All blueprints found", "Great, all blueprints are now known and all problems are resolved.")
		    Self.Close
		    Return
		  End If
		  
		  If OriginalIssueCount = NewIssueCount Then
		    Self.ShowAlert("No blueprints found", "Sorry, the spawn codes provided did not resolve any of the blueprint problems.")
		  Else
		    Self.ShowAlert("Some blueprints found", "Some problems were resolved, but there are still others that will need attention.")
		  End If
		  
		  IssuesList.DeleteAllRows
		  For Each Issue As String In Self.Issues
		    IssuesList.AddRow(Issue)
		  Next
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
