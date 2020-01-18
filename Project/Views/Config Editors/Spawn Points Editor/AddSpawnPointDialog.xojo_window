#tag Window
Begin BeaconDialog AddSpawnPointDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "1"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   450
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   400
   MinimumWidth    =   600
   Resizeable      =   True
   Title           =   "Add Spawn Point Override"
   Type            =   "8"
   Visible         =   True
   Width           =   600
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   False
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   410
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
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   410
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel ModeLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   314
      Transparent     =   False
      Underline       =   False
      Value           =   "Mode:"
      Visible         =   True
      Width           =   52
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   214
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   84
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   "1"
      Scope           =   2
      SelectionChangeBlocked=   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   496
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Label MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
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
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Add Spawn Points"
      Visible         =   True
      Width           =   560
   End
   BeginSegmentedButton SegmentedButton FilterSelector
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   380
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   "0"
      Scope           =   2
      Segments        =   "Spawn Points\n\nTrue\rCreatures\n\nFalse"
      SelectionStyle  =   "0"
      TabIndex        =   3
      TabPanelIndex   =   0
      Top             =   52
      Transparent     =   False
      Visible         =   True
      Width           =   200
   End
   Begin DelayedTextField FilterField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      Height          =   22
      Hint            =   "Search for spawn points"
      Index           =   -2147483648
      Italic          =   False
      Left            =   84
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   53
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   284
   End
   Begin UITweaks.ResizedLabel FilterLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   53
      Transparent     =   False
      Underline       =   False
      Value           =   "Filter:"
      Visible         =   True
      Width           =   52
   End
   Begin CheckBox LoadDefaultsCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Load Simplified Default Spawns"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   310
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   314
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   "0"
      Width           =   270
   End
   Begin RadioButton OverrideRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Override Spawn Point"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   84
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   314
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   214
   End
   Begin RadioButton AppendRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Add to Default Spawns"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   84
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   346
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   214
   End
   Begin RadioButton RemoveRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Remove from Default Spawns"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   84
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   378
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   214
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SwapButtons()
		  
		  If Self.mUIMode = Self.UIModeDuplicate Then
		    Self.ModeLabel.Visible = False
		    Self.LoadDefaultsCheck.Visible = False
		    Self.OverrideRadio.Visible = False
		    Self.RemoveRadio.Visible = False
		    Self.AppendRadio.Visible = False
		    Self.List.Height = Self.List.Height + (Self.RemoveRadio.Bottom - Self.List.Bottom)
		  End If
		  
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckActionEnabled()
		  Self.LoadDefaultsCheck.Enabled = Self.OverrideRadio.Value
		  
		  Var Enabled As Boolean = Self.List.SelectedRowCount > 0 And (Self.mUIMode <> Self.UIModeAdd Or Self.OverrideRadio.Value Or Self.AppendRadio.Value Or Self.RemoveRadio.Value)
		  If Self.ActionButton.Enabled <> Enabled Then
		    Self.ActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Document As Beacon.Document, UIMode As Integer)
		  Self.mMods = Document.Mods
		  Self.mAvailability = Document.MapCompatibility
		  Self.mDefinedSpawns = New Dictionary
		  Self.mUIMode = UIMode
		  
		  If Document.HasConfigGroup(BeaconConfigs.SpawnPoints.ConfigName) Then
		    Var Config As BeaconConfigs.SpawnPoints = BeaconConfigs.SpawnPoints(Document.ConfigGroup(BeaconConfigs.SpawnPoints.ConfigName, False))
		    If Config <> Nil Then
		      Var SpawnPoints() As Beacon.SpawnPoint = Config.All
		      For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		        Self.mDefinedSpawns.Value(SpawnPoint.UniqueKey) = True
		      Next
		    End If
		  End If
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Document As Beacon.Document, UIMode As Integer = UIModeAdd) As Beacon.SpawnPoint()
		  Var Win As New AddSpawnPointDialog(Document, UIMode)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  Var SpawnPoints() As Beacon.SpawnPoint = Win.mSelectedPoints
		  Win.Close
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFilter()
		  Var SearchText As String = Self.FilterField.Value.Trim
		  Var SpawnPoints() As Beacon.SpawnPoint
		  
		  If SearchText = "" Then
		    SpawnPoints = LocalData.SharedInstance.SearchForSpawnPoints("", Self.mMods)
		  Else
		    Select Case Self.FilterMode
		    Case Self.FilterModeSpawnPoint
		      SpawnPoints = LocalData.SharedInstance.SearchForSpawnPoints(SearchText, Self.mMods)
		    Case Self.FilterModeCreature
		      Var Creatures() As Beacon.Creature = LocalData.SharedInstance.SearchForCreatures(SearchText, Self.mMods)
		      Var UniqueSpawnPoints As New Dictionary
		      For Each Creature As Beacon.Creature In Creatures
		        Var CreatureSpawnPoints() As Beacon.SpawnPoint = LocalData.SharedInstance.GetSpawnPointsForCreature(Creature, Self.mMods, "")
		        For Each SpawnPoint As Beacon.SpawnPoint In CreatureSpawnPoints
		          UniqueSpawnPoints.Value(SpawnPoint.Path) = SpawnPoint
		        Next
		      Next
		      
		      For Each Entry As DictionaryEntry In UniqueSpawnPoints
		        SpawnPoints.AddRow(Beacon.SpawnPoint(Entry.Value))
		      Next
		    End Select
		  End If
		  
		  Var Labels As Dictionary = LocalData.SharedInstance.SpawnPointLabels(Self.mAvailability)
		  
		  Self.List.RemoveAllRows()
		  For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		    If Not SpawnPoint.ValidForMask(Self.mAvailability) Then
		      Continue
		    End If
		    
		    If Self.mDefinedSpawns.HasKey(SpawnPoint.Path + ":Override") Or (Self.mDefinedSpawns.HasKey(SpawnPoint.Path + ":Append") And Self.mDefinedSpawns.HasKey(SpawnPoint.Path + ":Remove")) Then
		      Continue
		    End If
		    
		    Self.List.AddRow(Labels.Lookup(SpawnPoint.Path, SpawnPoint.Label).StringValue)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = SpawnPoint
		  Next
		  Self.List.SortingColumn = 0
		  Self.List.Sort
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
			  If Self.FilterMode <> Value Then
			    If Self.FilterSelector.SelectedSegmentIndex <> Value Then
			      Self.FilterSelector.SelectedSegmentIndex = Value
			    End If
			    
			    Var Hint As String = ""
			    Select Case Value
			    Case Self.FilterModeSpawnPoint
			      Hint = "Search for spawn points"
			    Case Self.FilterModeCreature
			      Hint = "Search for creature spawns"
			    End Select
			    If Self.FilterField.Hint <> Hint Then
			      Self.FilterField.Hint = Hint
			    End If
			    
			    Self.mFilterMode = Value
			    
			    Self.UpdateFilter()
			  End If
			End Set
		#tag EndSetter
		Private FilterMode As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefinedSpawns As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFilterMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedPoints() As Beacon.SpawnPoint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUIMode As Integer
	#tag EndProperty


	#tag Constant, Name = FilterModeCreature, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FilterModeSpawnPoint, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UIModeAdd, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = UIModeDuplicate, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Action()
		  Var Mode As Integer
		  If Self.OverrideRadio.Value Then
		    Mode = Beacon.SpawnPoint.ModeOverride
		  ElseIf Self.AppendRadio.Value Then
		    Mode = Beacon.SpawnPoint.ModeAppend
		  ElseIf Self.RemoveRadio.Value Then
		    Mode = Beacon.SpawnPoint.ModeRemove
		  End If
		  Var ClearPoints As Boolean = Mode <> Beacon.SpawnPoint.ModeOverride Or Self.LoadDefaultsCheck.Value = False
		  
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Var SpawnPoint As Beacon.SpawnPoint = Self.List.RowTagAt(I)
		    Var MutableSpawnPoint As Beacon.MutableSpawnPoint = SpawnPoint.MutableVersion
		    
		    If ClearPoints Then
		      MutableSpawnPoint.ResizeTo(-1)
		      MutableSpawnPoint.LimitsString = "{}"
		    End If
		    
		    MutableSpawnPoint.Mode = Mode
		    Self.mSelectedPoints.AddRow(MutableSpawnPoint)
		  Next
		  
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  Var SupportedModes As Integer = Beacon.SpawnPoint.ModeOverride Or Beacon.SpawnPoint.ModeAppend Or Beacon.SpawnPoint.ModeRemove
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var DefinedModes As Integer
		    Var Point As Beacon.SpawnPoint = Me.RowTagAt(I)
		    If Self.mDefinedSpawns.HasKey(Point.Path + ":Override") Then
		      // Include Append and Remove here so they cannot be selected if Override is already defined
		      DefinedModes = DefinedModes Or Beacon.SpawnPoint.ModeOverride Or Beacon.SpawnPoint.ModeAppend Or Beacon.SpawnPoint.ModeRemove
		    End If
		    If Self.mDefinedSpawns.HasKey(Point.Path + ":Append") Then
		      DefinedModes = DefinedModes Or Beacon.SpawnPoint.ModeOverride Or Beacon.SpawnPoint.ModeAppend
		    End If
		    If Self.mDefinedSpawns.HasKey(Point.Path + ":Remove") Then
		      DefinedModes = DefinedModes Or Beacon.SpawnPoint.ModeOverride Or Beacon.SpawnPoint.ModeRemove
		    End If
		    
		    SupportedModes = SupportedModes And (Not DefinedModes)
		  Next
		  
		  Self.OverrideRadio.Enabled = (SupportedModes And Beacon.SpawnPoint.ModeOverride) = Beacon.SpawnPoint.ModeOverride
		  Self.AppendRadio.Enabled = (SupportedModes And Beacon.SpawnPoint.ModeAppend) = Beacon.SpawnPoint.ModeAppend
		  Self.RemoveRadio.Enabled = (SupportedModes And Beacon.SpawnPoint.ModeRemove) = Beacon.SpawnPoint.ModeRemove
		  
		  If Self.OverrideRadio.Enabled = False And Self.OverrideRadio.Value = True Then
		    Self.OverrideRadio.Value = False
		  End If
		  If Self.AppendRadio.Enabled = False And Self.AppendRadio.Value = True Then
		    Self.AppendRadio.Value = False
		  End If
		  If Self.RemoveRadio.Enabled = False And Self.RemoveRadio.Value = True Then
		    Self.RemoveRadio.Value = False
		  End If
		  
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterSelector
	#tag Event
		Sub Open()
		  Me.Width = Me.SegmentCount * 100
		  Me.ResizeCells
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed(segmentIndex as integer)
		  Self.FilterMode = SegmentIndex
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChange()
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OverrideRadio
	#tag Event
		Sub Action()
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AppendRadio
	#tag Event
		Sub Action()
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveRadio
	#tag Event
		Sub Action()
		  Self.CheckActionEnabled()
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
		Type="Color"
		EditorType="Color"
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
		Type="MenuBar"
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
