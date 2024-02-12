#tag DesktopWindow
Begin BeaconContainer RCONCommandsSidebar
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   300
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   200
   Begin UITweaks.ResizedPopupMenu GamePicker
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   10
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   180
   End
   Begin DelayedSearchField FilterField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      AllowTabStop    =   True
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   42
      Transparent     =   False
      Visible         =   True
      Width           =   180
   End
   Begin FadedSeparator TopSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   76
      Transparent     =   True
      Visible         =   True
      Width           =   200
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   -1
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Insert"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   223
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   77
      TotalPages      =   -1
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      Width           =   200
      _ScrollWidth    =   -1
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Const EdgePadding = 10
		  Const Spacing = 12
		  
		  Self.GamePicker.Top = EdgePadding
		  Self.GamePicker.Left = EdgePadding
		  Self.GamePicker.Width = Self.Width - (EdgePadding * 2)
		  
		  Self.FilterField.Top = Self.GamePicker.Bottom + Spacing
		  Self.FilterField.Left = Self.GamePicker.Left
		  Self.FilterField.Width = Self.GamePicker.Width
		  
		  Self.TopSeparator.Top = Self.FilterField.Bottom + EdgePadding
		  
		  Self.List.Top = Self.TopSeparator.Bottom
		  Self.List.Height = Self.Height - Self.List.Top
		  
		  Var Games() As Beacon.Game = Beacon.Games
		  For Each Game As Beacon.Game In Games
		    Self.GamePicker.AddRow(Game.Name)
		    Self.GamePicker.RowTagAt(Self.GamePicker.LastAddedRowIndex) = Game.Identifier
		  Next
		  Self.GamePicker.SelectedRowIndex = 0
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Reload()
		  Var GameId As String = Self.GamePicker.SelectedRowTag
		  Var Filter As String = Self.FilterField.Text.Trim
		  Var DataSource As Beacon.CommonData = Beacon.CommonData.Pool.Get(False)
		  Var Commands() As Beacon.RCONCommand = DataSource.GetRCONCommands(GameId, Filter)
		  
		  Var SelectedCommands() As String
		  For RowIdx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Var Command As Beacon.RCONCommand = Self.List.RowTagAt(RowIdx)
		    If (Command Is Nil) = False Then
		      SelectedCommands.Add(Command.CommandId)
		    End If
		  Next
		  
		  Self.List.SelectionChangeBlocked = True
		  Self.List.RowCount = Commands.Count
		  For RowIdx As Integer = 0 To Self.List.LastRowIndex
		    Var Command As Beacon.RCONCommand = Commands(RowIdx)
		    Self.List.CellTextAt(RowIdx) = Command.Label
		    Self.List.RowTagAt(RowIdx) = Command
		    Self.List.RowSelectedAt(RowIdx) = SelectedCommands.IndexOf(Command.CommandId) > -1
		  Next
		  Self.List.SelectionChangeBlocked = False
		  Self.List.EnsureSelectionIsVisible
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event InsertCommand(Command As Beacon.RCONCommand)
	#tag EndHook


#tag EndWindowCode

#tag Events GamePicker
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  Self.Reload()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.Reload()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub PerformEdit()
		  If Me.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Command As Beacon.RCONCommand = Me.RowTagAt(Me.SelectedRowIndex)
		  RaiseEvent InsertCommand(Command)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
