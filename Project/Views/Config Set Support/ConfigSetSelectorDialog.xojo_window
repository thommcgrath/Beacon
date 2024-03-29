#tag DesktopWindow
Begin BeaconDialog ConfigSetSelectorDialog
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
   Height          =   378
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   378
   MaximumWidth    =   492
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   378
   MinimumWidth    =   492
   Resizeable      =   False
   Title           =   "Prioritize Config Sets"
   Type            =   8
   Visible         =   True
   Width           =   492
   Begin DesktopLabel InstructionsLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   30
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   True
      Scope           =   2
      Selectable      =   True
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Checked sets will be enabled. Drag sets to change priority. Highest priority is the top of the list."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   296
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   452
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   True
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "24"
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
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   232
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   360
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Prioritize Config Sets"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   452
   End
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
      Left            =   392
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   338
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
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   338
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton UpButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Up"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   392
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton DownButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Down"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   392
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Constructor(Sets() As Beacon.ConfigSet, States() As Beacon.ConfigSetState)
		  Self.mSets = Sets
		  Self.mStates = States
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Sets() As Beacon.ConfigSet, States() As Beacon.ConfigSetState) As Boolean
		  If Parent Is Nil Then
		    Return False
		  End If
		  
		  Var Cancelled As Boolean
		  Var Win As New ConfigSetSelectorDialog(Sets, States)
		  Win.ShowModal(Parent)
		  Cancelled = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSets() As Beacon.ConfigSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStates() As Beacon.ConfigSetState
	#tag EndProperty


#tag EndWindowCode

#tag Events List
	#tag Event
		Function DragReorderRows(newPosition as Integer, parentRow as Integer) As Boolean
		  // What a stupid event this is. It doesn't even tell us *what* changed.
		  // Rows have not been moved yet. Return true to prevent moving.
		  
		  #Pragma Unused ParentRow
		  
		  If Me.SelectedRowIndex = Me.LastRowIndex Or NewPosition = Me.LastRowIndex Then
		    // Can't move the base row
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(0) = DesktopListbox.CellTypes.CheckBox
		  
		  Var SetsMap As New Dictionary
		  For Each Set As Beacon.ConfigSet In Self.mSets
		    SetsMap.Value(Set.ConfigSetId) = Set
		  Next
		  
		  // Zero is the lowest priority, so this needs to happen in reverse.
		  For Idx As Integer = Self.mStates.LastIndex DownTo 0
		    Var State As Beacon.ConfigSetState = Self.mStates(Idx)
		    If SetsMap.HasKey(State.ConfigSetId) = False Then
		      Continue
		    End If
		    
		    Var Set As Beacon.ConfigSet = SetsMap.Value(State.ConfigSetId)
		    Self.List.AddRow("", Set.Name)
		    Var RowIdx As Integer = Self.List.LastAddedRowIndex
		    Self.List.RowTagAt(RowIdx) = Set
		    Self.List.CellCheckBoxValueAt(RowIdx, 0) = State.Enabled
		    
		    If Set.IsBase Then
		      Self.List.CellTypeAt(RowIdx, 0) = DesktopListbox.CellTypes.Normal
		    End If
		    
		    SetsMap.Remove(State.ConfigSetId)
		  Next
		  
		  // What's left of SetsMap still needs to be added
		  For Each Entry As DictionaryEntry In SetsMap
		    Var Set As Beacon.ConfigSet = Entry.Value
		    Self.List.AddRowAt(0, "")
		    Var RowIdx As Integer = Self.List.LastAddedRowIndex
		    Self.List.CellTextAt(RowIdx, 1) = Set.Name
		    Self.List.RowTagAt(RowIdx) = Set
		    
		    If Set.IsBase Then
		      Self.List.CellTypeAt(RowIdx, 0) = DesktopListbox.CellTypes.Normal
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Var Idx As Integer = Me.SelectedRowIndex
		  Var BaseIdx As Integer = Me.LastRowIndex
		  Self.UpButton.Enabled = Idx > 0 And Idx <> BaseIdx
		  Self.DownButton.Enabled = Idx < BaseIdx - 1 And Idx <> BaseIdx
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Self.mStates.ResizeTo(-1)
		  
		  For RowIdx As Integer = Self.List.LastRowIndex DownTo 0
		    Var Checked As Boolean = Self.List.CellCheckBoxValueAt(RowIdx, 0)
		    Var Set As Beacon.ConfigSet = Self.List.RowTagAt(RowIdx)
		    Self.mStates.Add(New Beacon.ConfigSetState(Set, Checked))
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
#tag Events UpButton
	#tag Event
		Sub Pressed()
		  Var RowIdx As Integer = Self.List.SelectedRowIndex
		  Var DestinationIdx As Integer = Max(RowIdx - 1, 0)
		  If RowIdx = DestinationIdx Then
		    Return
		  End If
		  
		  Var Set As Beacon.ConfigSet = Self.List.RowTagAt(RowIdx)
		  Self.List.RemoveRowAt(RowIdx)
		  
		  Self.List.AddRowAt(DestinationIdx, "")
		  Self.List.CellTextAt(DestinationIdx, 1) = Set.Name
		  Self.List.RowTagAt(DestinationIdx) = Set
		  Self.List.SelectedRowIndex = DestinationIdx
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DownButton
	#tag Event
		Sub Pressed()
		  Var RowIdx As Integer = Self.List.SelectedRowIndex
		  Var DestinationIdx As Integer = Min(RowIdx + 1, Self.List.LastRowIndex - 1)
		  If RowIdx = DestinationIdx Then
		    Return
		  End If
		  
		  Var Set As Beacon.ConfigSet = Self.List.RowTagAt(RowIdx)
		  Self.List.RemoveRowAt(RowIdx)
		  
		  Self.List.AddRowAt(DestinationIdx, "")
		  Self.List.CellTextAt(DestinationIdx, 1) = Set.Name
		  Self.List.RowTagAt(DestinationIdx) = Set
		  Self.List.SelectedRowIndex = DestinationIdx
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
