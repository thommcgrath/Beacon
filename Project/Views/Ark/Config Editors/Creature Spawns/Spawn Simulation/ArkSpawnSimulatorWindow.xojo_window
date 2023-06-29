#tag DesktopWindow
Begin BeaconWindow ArkSpawnSimulatorWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   0
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   554
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   817604607
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   1000
   Resizeable      =   True
   Title           =   "Spawn Simulator: Project"
   Type            =   0
   Visible         =   True
   Width           =   1032
   Begin UITweaks.ResizedLabel MapLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Map:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedPopupMenu MapMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   132
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   150
   End
   Begin BeaconSegmentedControl ModeSelector
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowMultipleSelection=   False
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Spawn Points	Creatures"
      Left            =   294
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Visible         =   True
      Width           =   200
   End
   Begin FadedSeparator TopBarSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   62
      Transparent     =   True
      Visible         =   True
      Width           =   1032
   End
   Begin DesktopPagePanel Panels
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   491
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   63
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   1032
      Begin BeaconListbox PointsList
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
         DefaultRowHeight=   26
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
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
         Height          =   491
         Index           =   -2147483648
         InitialParent   =   "Panels"
         InitialValue    =   ""
         Italic          =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   63
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   250
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin FadedSeparator SpawnPointListSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   491
         Index           =   -2147483648
         InitialParent   =   "Panels"
         Left            =   250
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   63
         Transparent     =   True
         Visible         =   True
         Width           =   1
      End
      Begin DesktopLabel SpawnInstanceCountLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panels"
         Italic          =   False
         Left            =   271
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Locations on Map:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   83
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   130
      End
      Begin DesktopLabel SpawnInstanceCountField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panels"
         Italic          =   False
         Left            =   413
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Num"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   83
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   73
      End
      Begin DesktopLabel SpawnAvgPopLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panels"
         Italic          =   False
         Left            =   498
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Average Population per Location:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   83
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   214
      End
      Begin DesktopLabel SpawnAvgPopField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panels"
         Italic          =   False
         Left            =   724
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Num"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   83
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   73
      End
      Begin DesktopLabel SpawnTotalPopLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panels"
         Italic          =   False
         Left            =   809
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Total Population:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   83
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel SpawnTotalPopField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panels"
         Italic          =   False
         Left            =   921
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Num"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   83
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   73
      End
   End
   Begin Thread SimulationThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Activated()
		  Self.RunSimulator()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.MapLabel.SizeToFit
		  Self.MapMenu.Left = Self.MapLabel.Left + Self.MapLabel.Width + 12
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project)
		  Self.mProject = Project
		  Super.Constructor
		  Self.Title = "Spawn Simulator: " + Project.Title
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Self.ModeSelector.Left = (Self.Width - Self.ModeSelector.Width) / 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RunSimulator()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSpawnPointView()
		  Self.SpawnAvgPopLabel.SizeToFit
		  Self.SpawnInstanceCountLabel.SizeToFit
		  Self.SpawnTotalPopLabel.SizeToFit
		  
		  Var PopFigures As Ark.PopulationFigures
		  
		  If (Self.mSelectedPoint Is Nil) = False Then
		    Var Figures() As Ark.PopulationFigures = Ark.DataSource.Pool.Get(False).GetPopulationFigures(Self.mSelectedPoint)
		    For Idx As Integer = Figures.FirstIndex To Figures.LastIndex
		      If Figures(Idx).MapName = Self.MapMenu.SelectedRowValue Then
		        PopFigures = Figures(Idx)
		        Exit
		      End If
		    Next
		  End If
		  
		  If PopFigures Is Nil Then
		    Self.SpawnAvgPopField.Text = "N/A"
		    Self.SpawnInstanceCountField.Text = "N/A"
		    Self.SpawnTotalPopField.Text = "N/A"
		  Else
		    Var AvgPop As Integer = Round(PopFigures.TargetPopulation / PopFigures.Instances)
		    Self.SpawnAvgPopField.Text = AvgPop.ToString(Locale.Current, "#,##0")
		    Self.SpawnInstanceCountField.Text = PopFigures.Instances.ToString(Locale.Current, "#,##0")
		    Self.SpawnTotalPopField.Text = PopFigures.TargetPopulation.ToString(Locale.Current, "#,##0")
		  End If
		  
		  Self.SpawnAvgPopField.SizeToFit
		  Self.SpawnInstanceCountField.SizeToFit
		  Self.SpawnTotalPopField.SizeToFit
		  
		  Self.SpawnInstanceCountLabel.Left = Self.SpawnPointListSeparator.Left + Self.SpawnPointListSeparator.Width + 20
		  Self.SpawnInstanceCountField.Left = Self.SpawnInstanceCountLabel.Left + Self.SpawnInstanceCountLabel.Width + 12
		  Self.SpawnAvgPopLabel.Left = Self.SpawnInstanceCountField.Left + Self.SpawnInstanceCountField.Width + 20
		  Self.SpawnAvgPopField.Left = Self.SpawnAvgPopLabel.Left + Self.SpawnAvgPopLabel.Width + 12
		  Self.SpawnTotalPopLabel.Left = Self.SpawnAvgPopField.Left + Self.SpawnAvgPopField.Width + 20
		  Self.SpawnTotalPopField.Left = Self.SpawnTotalPopLabel.Left + Self.SpawnTotalPopLabel.Width + 12
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mFilterMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.FilterMode = Value Then
			    Return
			  End If
			  
			  Self.ModeSelector.LockChangeEvent
			  Self.ModeSelector.Segment(Self.ModeSpawnPoints).Selected = (Value = Self.ModeSpawnPoints)
			  Self.ModeSelector.Segment(Self.ModeCreatures).Selected = (Value = Self.ModeCreatures)
			  Self.ModeSelector.UnlockChangeEvent
			  
			  Self.mFilterMode = Value
			  Self.Panels.SelectedPanelIndex = Value
			  
			  #if false
			    Self.FilterMenu.RemoveAllRows
			    
			    Select Case Value
			    Case Self.ModeSpawnPoints
			      Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.Pool.Get(False).GetSpawnPoints("", Self.mProject.ContentPacks, "")
			      For Each SpawnPoint As Ark.SpawnPoint In SpawnPoints
			        If SpawnPoint.ValidForMap(Self.MapMenu.SelectedRowTag) Then
			          Self.FilterMenu.AddRow(SpawnPoint.Label, SpawnPoint)
			        End If
			      Next
			    Case Self.ModeCreatures
			      Var Creatures() As Ark.Creature = Ark.DataSource.Pool.Get(False).GetCreatures("", Self.mProject.ContentPacks, "")
			      For Each Creature As Ark.Creature In Creatures
			        Self.FilterMenu.AddRow(Creature.Label, Creature)
			      Next
			    End Select
			  #endif
			End Set
		#tag EndSetter
		Private FilterMode As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFilterMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedPoint As Ark.SpawnPoint
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mSelectedPoint
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedPoint = Value Then
			    Return
			  End If
			  
			  Self.mSelectedPoint = Value
			  Self.UpdateSpawnPointView()
			End Set
		#tag EndSetter
		Private SelectedPoint As Ark.SpawnPoint
	#tag EndComputedProperty


	#tag Constant, Name = ModeCreatures, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ModeSpawnPoints, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events MapMenu
	#tag Event
		Sub Opening()
		  Var Maps() As Ark.Map = Self.mProject.Maps
		  If Maps.Count = 0 Then
		    Return
		  End If
		  For Each Map As Ark.Map In Maps
		    Me.AddRow(Map.Name, Map)
		  Next
		  Me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModeSelector
	#tag Event
		Sub Pressed()
		  For Idx As Integer = 0 To Me.LastIndex
		    If Me.Segment(Idx).Selected Then
		      Self.FilterMode = Idx
		      Return
		    End If
		  Next Idx
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Segment(0).Selected = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Panels
	#tag Event
		Sub PanelChanged()
		  Select Case Me.SelectedPanelIndex
		  Case Self.ModeSpawnPoints
		    Self.UpdateSpawnPointView()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PointsList
	#tag Event
		Sub SelectionChanged()
		  
		End Sub
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
#tag EndViewBehavior
