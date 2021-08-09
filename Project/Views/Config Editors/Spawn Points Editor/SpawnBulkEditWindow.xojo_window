#tag Window
Begin BeaconDialog SpawnBulkEditWindow
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
   Height          =   450
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   450
   MinimumWidth    =   700
   Resizeable      =   False
   Title           =   "Quick Edit Creatures"
   Type            =   8
   Visible         =   True
   Width           =   700
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Quick Edit Creature Spawns"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   660
   End
   Begin GroupBox CreaturesGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Target Creatures"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   330
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   314
      Begin RadioButton AllCreaturesRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "All Creatures"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "CreaturesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   96
         Transparent     =   False
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   274
      End
      Begin RadioButton SelectedCreaturesRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "These Creatures:"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "CreaturesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   128
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   274
      End
      Begin BeaconListbox CreatureList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   1
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontalStyle=   0
         GridLinesVerticalStyle=   0
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   0
         Height          =   178
         Index           =   -2147483648
         InitialParent   =   "CreaturesGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   160
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         Width           =   274
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton ChooseCreaturesButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Choose…"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "CreaturesGroup"
         Italic          =   False
         Left            =   224
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   350
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
   End
   Begin PushButton ActionButton
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
      Left            =   600
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   410
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton CancelButton
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
      Left            =   508
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   410
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin GroupBox ActionsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Actions"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   330
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   346
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   334
      Begin CheckBox ChangeColorsCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Change Colors:"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ActionsGroup"
         Italic          =   False
         Left            =   366
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   96
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   128
      End
      Begin CheckBox SetLevelsCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Set Levels:"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "ActionsGroup"
         Italic          =   False
         Left            =   366
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   128
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   128
      End
      Begin UITweaks.ResizedPopupMenu ColorsMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ActionsGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   506
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   96
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   154
      End
      Begin UITweaks.ResizedTextField MinLevelField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ActionsGroup"
         Italic          =   False
         Left            =   506
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   128
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   60
      End
      Begin Label LevelToLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "ActionsGroup"
         Italic          =   False
         Left            =   570
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "to"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   128
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   26
      End
      Begin UITweaks.ResizedTextField MaxLevelField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ActionsGroup"
         Italic          =   False
         Left            =   600
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   128
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   60
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Constructor(Config As BeaconConfigs.SpawnPoints, Mods As Beacon.StringList, Mask As UInt64, DifficultyValue As Double)
		  // Calling the overridden superclass constructor.
		  Self.mConfig = Config
		  Self.mMods = Mods
		  Self.mMask = Mask
		  Self.mDifficultyValue = DifficultyValue
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Config As BeaconConfigs.SpawnPoints, Mods As Beacon.StringList, Mask As UInt64, DifficultyValue As Double) As Boolean
		  If Parent Is Nil Then
		    Return False
		  End If
		  
		  Var Win As New SpawnBulkEditWindow(Config, Mods, Mask, DifficultyValue)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfig As BeaconConfigs.SpawnPoints
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDifficultyValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty


#tag EndWindowCode

#tag Events AllCreaturesRadio
	#tag Event
		Sub Action()
		  Self.CreatureList.Enabled = False
		  Self.ChooseCreaturesButton.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectedCreaturesRadio
	#tag Event
		Sub Action()
		  Self.CreatureList.Enabled = True
		  Self.ChooseCreaturesButton.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CreatureList
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  #Pragma Unused Warn
		  
		  For Idx As Integer = Self.CreatureList.LastRowIndex DownTo 0
		    If Self.CreatureList.Selected(Idx) Then
		      Self.CreatureList.RemoveRowAt(Idx)
		    End If
		  Next Idx
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseCreaturesButton
	#tag Event
		Sub Action()
		  Var SelectedCreatures() As Beacon.Creature
		  For Idx As Integer = 0 To Self.CreatureList.LastRowIndex
		    SelectedCreatures.Add(Self.CreatureList.RowTagAt(Idx))
		  Next Idx
		  
		  Var AddedCreatures() As Beacon.Creature = EngramSelectorDialog.Present(Self, "", SelectedCreatures, Self.mMods, EngramSelectorDialog.SelectModes.ExplicitMultiple)
		  For Each Creature As Beacon.Creature In AddedCreatures
		    Self.CreatureList.AddRow(Creature.Label)
		    Self.CreatureList.RowTagAt(Self.CreatureList.LastAddedRowIndex) = Creature
		  Next Creature
		  Self.CreatureList.Sort
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If Self.ChangeColorsCheckbox.Value = False And Self.SetLevelsCheckbox.Value = False Then
		    Self.ShowAlert("No Change Selected", "You must choose at least one action to perform.")
		    Return
		  ElseIf Self.ChangeColorsCheckbox.Value And Self.ColorsMenu.SelectedRowIndex = -1 Then
		    Self.ShowAlert("No Color Selected", "You must choose a color set to apply.")
		    Return
		  ElseIf Self.SetLevelsCheckbox.Value And (IsNumeric(Self.MinLevelField.Text) = False Or IsNumeric(Self.MaxLevelField.Text) = False) Then
		    Self.ShowAlert("No Level Range Defined", "You must set a min and max level.")
		    Return
		  End If
		  
		  Var Creatures() As Beacon.Creature
		  If AllCreaturesRadio.Value Then
		    Creatures = Beacon.Data.SearchForCreatures("", Self.mMods)
		  Else
		    For RowIdx As Integer = 0 To Self.CreatureList.LastRowIndex
		      Creatures.Add(Self.CreatureList.RowTagAt(RowIdx))
		    Next RowIdx
		  End If
		  
		  If Creatures.Count = 0 Then
		    Self.ShowAlert("No Creatures Selected", "You need to select at least one creature to work on.")
		    Return
		  End If
		  
		  Var ChangeColorSets As Boolean = Self.ChangeColorsCheckbox.Value
		  Var ColorSetClass As String
		  If ChangeColorSets Then
		    ColorSetClass = Self.ColorsMenu.RowTagAt(Self.ColorsMenu.SelectedRowIndex)
		  End If
		  
		  Var ChangeLevels As Boolean = Self.SetLevelsCheckbox.Value
		  Var LevelOverrides() As Beacon.SpawnPointLevel
		  If ChangeLevels Then
		    Var MinLevel As Integer = Integer.FromString(Self.MinLevelField.Text, Locale.Current)
		    Var MaxLevel As Integer = Integer.FromString(Self.MaxLevelField.Text, Locale.Current)
		    If MinLevel >= 1 And MaxLevel >= 1 Then
		      LevelOverrides.Add(Beacon.SpawnPointLevel.FromUserLevel(MinLevel, MaxLevel, Self.mDifficultyValue))
		    End If
		  End If
		  
		  #Pragma Warning "This technique will not handle creatures added to overrides"
		  For Each Creature As Beacon.Creature In Creatures
		    Var Points() As Beacon.SpawnPoint = Beacon.Data.GetSpawnPointsForCreature(Creature, Self.mMods, "")
		    For Each Definition As Beacon.SpawnPoint In Points
		      If Definition.ValidForMask(Self.mMask) = False Then
		        Continue
		      End If
		      
		      Var Original As Beacon.SpawnPoint = Self.mConfig.GetSpawnPoint(Definition.ObjectID, Beacon.SpawnPoint.ModeOverride)
		      Var Mutable As Beacon.MutableSpawnPoint
		      If Original Is Nil Then
		        Mutable = Definition.MutableClone
		        Mutable.Mode = Beacon.SpawnPoint.ModeOverride
		        LocalData.SharedInstance.LoadDefaults(Mutable)
		        
		        Var Remove As Beacon.SpawnPoint = Self.mConfig.GetSpawnPoint(Definition.ObjectID, Beacon.SpawnPoint.ModeRemove)
		        If (Remove Is Nil) = False Then
		          For Each Set As Beacon.SpawnPointSet In Remove
		            For Each Entry As Beacon.SpawnPointSetEntry In Set
		              Mutable.RemoveCreature(Entry.Creature)
		            Next Entry
		          Next Set
		          Self.mConfig.Remove(Remove)
		        End If
		        
		        Var Append As Beacon.SpawnPoint = Self.mConfig.GetSpawnPoint(Definition.ObjectID, Beacon.SpawnPoint.ModeAppend)
		        If (Append Is Nil) = False Then
		          For Each Set As Beacon.SpawnPointSet In Append
		            Mutable.AddSet(Set.Clone)
		          Next Set
		          Self.mConfig.Remove(Append)
		        End If
		      Else
		        Mutable = Original.MutableClone
		      End If
		      
		      For SetIdx As Integer = 0 To Mutable.LastRowIndex
		        Var MutableSet As Beacon.MutableSpawnPointSet = Mutable.Set(SetIdx).MutableVersion
		        Var ChangeThisColorSet As Boolean
		        
		        For EntryIdx As Integer = 0 To MutableSet.LastRowIndex
		          Var Entry As Beacon.MutableSpawnPointSetEntry = MutableSet.Entry(EntryIdx).MutableVersion
		          If Entry.Creature.ObjectID <> Creature.ObjectID Then
		            Continue
		          End If
		          
		          If ChangeColorSets Then
		            ChangeThisColorSet = True
		          End
		          
		          If ChangeLevels Then
		            Entry.MaxLevelMultiplier = Nil
		            Entry.MinLevelMultiplier = Nil
		            Entry.MaxLevelOffset = Nil
		            Entry.MinLevelOffset = Nil
		            Entry.Levels = LevelOverrides
		            MutableSet.Entry(EntryIdx) = Entry
		          End If
		        Next EntryIdx
		        
		        If ChangeThisColorSet Then
		          MutableSet.ColorSetClass = ColorSetClass
		        End If
		        
		        Mutable.Set(SetIdx) = MutableSet
		      Next SetIdx
		      
		      Self.mConfig.Add(Mutable)
		    Next Definition
		  Next Creature
		  
		  Self.mCancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChangeColorsCheckbox
	#tag Event
		Sub Action()
		  Self.ColorsMenu.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetLevelsCheckbox
	#tag Event
		Sub Action()
		  Self.MinLevelField.Enabled = Me.Value
		  Self.LevelToLabel.Enabled = Me.Value
		  Self.MaxLevelField.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ColorsMenu
	#tag Event
		Sub Open()
		  Me.AddRow("No Color Override")
		  Me.RowTagAt(Me.LastAddedRowIndex) = ""
		  
		  Var Colors() As Beacon.CreatureColorSet = Beacon.Data.SearchForCreatureColorSets()
		  For Each ColorSet As Beacon.CreatureColorSet In Colors
		    Me.AddRow(ColorSet.Label)
		    Me.RowTagAt(Me.LastAddedRowIndex) = ColorSet.ClassString
		  Next ColorSet
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
