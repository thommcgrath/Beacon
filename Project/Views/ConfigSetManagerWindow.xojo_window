#tag DesktopWindow
Begin BeaconDialog ConfigSetManagerWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   400
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   400
   MinimumWidth    =   600
   Resizeable      =   True
   Title           =   "Manage Config Sets"
   Type            =   8
   Visible         =   True
   Width           =   600
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox SetList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "*,100"
      DefaultRowHeight=   -1
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   236
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Set Name	Server Count"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   104
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Manage Config Sets"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   40
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Config Sets allow admins to manage multiple groups of configuration changes that can be blended together at export or deploy."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton NewButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "New Config Set"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   125
   End
   Begin UITweaks.ResizedPushButton EditButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Edit"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   157
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton DeleteButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Delete"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   249
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Constructor(Project As Beacon.Project)
		  // Calling the overridden superclass constructor.
		  Self.mProject = Project
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Project As Beacon.Project) As Boolean
		  If Parent Is Nil Then
		    Return False
		  End If
		  
		  Var Win As New ConfigSetManagerWindow(Project)
		  Win.ShowModal(Parent)
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  Return Not Cancelled
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeletedSetNames() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Beacon.Project
	#tag EndProperty


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  // Do the work here
		  
		  // Delete sets here
		  For Each SetName As String In Self.mDeletedSetNames
		    Self.mProject.RemoveConfigSet(SetName)
		  Next
		  
		  // Rename or add sets
		  For Idx As Integer = 0 To Self.SetList.LastRowIndex
		    Var SetName As String = Self.SetList.CellTextAt(Idx, 0)
		    Var OriginalName As String = Self.SetList.RowTagAt(Idx)
		    
		    If OriginalName.IsEmpty = False Then
		      // Possible rename
		      If OriginalName.Compare(SetName, ComparisonOptions.CaseSensitive) <> 0 Then
		        // Rename
		        Self.mProject.RenameConfigSet(OriginalName, SetName)
		      End If
		    Else
		      // New set
		      Self.mProject.AddConfigSet(SetName)
		    End If
		  Next
		  
		  Self.mCancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetList
	#tag Event
		Sub SelectionChanged()
		  Self.EditButton.Enabled = Me.CanEdit
		  Self.DeleteButton.Enabled = Me.CanDelete
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount = 1 And Me.CellTextAt(Me.SelectedRowIndex, 0) <> Beacon.Project.BaseConfigSetName
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1 And Me.CellTextAt(Me.SelectedRowIndex, 0) <> Beacon.Project.BaseConfigSetName
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var SetIsUsed As Boolean = Me.CellTagAt(Me.SelectedRowIndex, 1).IntegerValue > 0
		  
		  If SetIsUsed And Warn Then
		    Var Sets() As String = Array(Me.CellTextAt(Me.SelectedRowIndex, 0))
		    If BeaconUI.ShowDeleteConfirmation(Sets, "config set", "config sets") = False Then
		      Return
		    End If
		  End If
		  
		  Var OriginalSetName As String = Me.RowTagAt(Me.SelectedRowIndex)
		  If OriginalSetName.IsEmpty = False And Self.mDeletedSetNames.IndexOf(OriginalSetName) = -1 Then
		    Self.mDeletedSetNames.Add(OriginalSetName)
		  End If
		  Me.RemoveRowAt(Me.SelectedRowIndex)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Me.CellTagAt(Me.SelectedRowIndex, 0) = Me.CellTextAt(Me.SelectedRowIndex, 0)
		  Me.EditCellAt(Me.SelectedRowIndex, 0)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(0) = DesktopListbox.CellTypes.TextField
		  
		  Var Counts As New Dictionary
		  Var ProfileBound As Integer = Self.mProject.ServerProfileCount - 1
		  For Idx As Integer = 0 To ProfileBound
		    Var Profile As Beacon.ServerProfile = Self.mProject.ServerProfile(Idx)
		    Var States() As Beacon.ConfigSetState = Profile.ConfigSetStates
		    If States Is Nil Or States.Count = 0 Then
		      Counts.Value(Beacon.Project.BaseConfigSetName) = Counts.Lookup(Beacon.Project.BaseConfigSetName, 0).IntegerValue + 1
		      Continue
		    End If
		    For Each State As Beacon.ConfigSetState In States
		      If State.Enabled Then
		        Counts.Value(State.Name) = Counts.Lookup(State.Name, 0).IntegerValue + 1
		      End If
		    Next
		  Next
		  
		  Var SetNames() As String = Self.mProject.ConfigSetNames
		  For Each SetName As String In SetNames
		    Me.AddRow(SetName, Language.NounWithQuantity(Counts.Lookup(SetName, 0).IntegerValue, "Server", "Servers"))
		    Me.RowTagAt(Me.LastAddedRowIndex) = SetName
		    
		    If SetName = Beacon.Project.BaseConfigSetName Then
		      Me.CellTypeAt(Me.LastAddedRowIndex, 0) = DesktopListbox.CellTypes.Normal
		    End If
		  Next
		  Me.Sort
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  #Pragma Unused Column
		  
		  Var NewValue As String = Me.CellTextAt(Row, Column)
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Idx = Row Then
		      Continue
		    End If
		    
		    If Me.CellTextAt(Idx, 0) = NewValue Then
		      // Duplicate!
		      Var Original As String = Me.CellTagAt(Row, 0)
		      If Original.IsEmpty Then
		        Original = Me.RowTagAt(Row)
		        If Original.IsEmpty Then
		          Original = "New Config Set"
		        End If
		      End If
		      System.Beep
		      Me.CellTextAt(Row, Column) = Original
		      Return
		    End If
		  Next
		  
		  Me.CellTagAt(Row, Column) = NewValue
		  Me.Sort
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NewButton
	#tag Event
		Sub Pressed()
		  Self.SetList.AddRow("New Config Set", "0 Servers")
		  Self.SetList.CellTagAt(Self.SetList.LastAddedRowIndex, 1) = 0
		  Self.SetList.SelectedRowIndex = Self.SetList.LastAddedRowIndex
		  Self.SetList.Sort
		  Self.SetList.DoEdit()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditButton
	#tag Event
		Sub Pressed()
		  Self.SetList.DoEdit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeleteButton
	#tag Event
		Sub Pressed()
		  Self.SetList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Interfaces"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
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
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
#tag EndViewBehavior
