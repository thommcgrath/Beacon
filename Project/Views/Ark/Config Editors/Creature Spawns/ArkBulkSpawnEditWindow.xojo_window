#tag DesktopWindow
Begin BeaconDialog ArkBulkSpawnEditWindow
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
   Begin DesktopGroupBox CreaturesGroup
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
      Begin DesktopRadioButton AllCreaturesRadio
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
      Begin DesktopRadioButton SelectedCreaturesRadio
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
         DefaultRowHeight=   -1
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
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
         VisibleRowCount =   0
         Width           =   274
         _ScrollOffset   =   0
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
   Begin DesktopGroupBox ActionsGroup
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
      Begin DesktopCheckBox ChangeColorsCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Change Colors:"
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
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   128
      End
      Begin DesktopCheckBox SetLevelsCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Set Levels:"
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
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   128
      End
      Begin UITweaks.ResizedPopupMenu ColorsMenu
         AllowAutoDeactivate=   True
         Bold            =   False
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
      Begin DesktopLabel LevelToLabel
         AllowAutoDeactivate=   True
         Bold            =   False
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
   Begin Thread ProcessingThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   2
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
   Begin DesktopProgressWheel Spinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   412
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel StatusLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   48
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Untitled"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   410
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   448
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Constructor(Config As Ark.Configs.SpawnPoints, Mods As Beacon.StringList, Mask As UInt64, DifficultyValue As Double)
		  // Calling the overridden superclass constructor.
		  Self.mConfig = Config
		  Self.mMods = Mods
		  Self.mMask = Mask
		  Self.mDifficultyValue = DifficultyValue
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Config As Ark.Configs.SpawnPoints, Mods As Beacon.StringList, Mask As UInt64, DifficultyValue As Double) As Boolean
		  If Parent Is Nil Then
		    Return False
		  End If
		  
		  Var Win As New ArkBulkSpawnEditWindow(Config, Mods, Mask, DifficultyValue)
		  Win.ShowModal(Parent)
		  
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessSpawnPoint(Point As Ark.MutableSpawnPoint)
		  For SetIdx As Integer = 0 To Point.LastIndex
		    Var MutableSet As Ark.MutableSpawnPointSet = Point.Set(SetIdx).MutableVersion
		    Var ChangeThisColorSet As Boolean
		    
		    For EntryIdx As Integer = 0 To MutableSet.LastIndex
		      Var Entry As Ark.MutableSpawnPointSetEntry = MutableSet.Entry(EntryIdx).MutableVersion
		      If Self.mCreatureIds.IndexOf(Entry.Creature.ObjectID) = -1 Then
		        Continue
		      End If
		      
		      If Self.mChangeColors Then
		        ChangeThisColorSet = True
		      End
		      
		      If Self.mChangeLevels Then
		        Entry.MaxLevelMultiplier = Nil
		        Entry.MinLevelMultiplier = Nil
		        Entry.MaxLevelOffset = Nil
		        Entry.MinLevelOffset = Nil
		        Entry.Levels = Self.mLevelOverrides
		        MutableSet.Entry(EntryIdx) = Entry
		      End If
		    Next EntryIdx
		    
		    If ChangeThisColorSet Then
		      MutableSet.ColorSetClass = Self.mSelectedColorClass
		    End If
		    
		    Point.Set(SetIdx) = MutableSet
		  Next SetIdx
		  
		  Self.mConfig.Add(Point)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChangeColors As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChangeLevels As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfig As Ark.Configs.SpawnPoints
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatureIds() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatures() As Ark.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDifficultyValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLevelOverrides() As Ark.SpawnPointLevel
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedColorClass As String
	#tag EndProperty


#tag EndWindowCode

#tag Events AllCreaturesRadio
	#tag Event
		Sub ValueChanged()
		  Self.CreatureList.Enabled = False
		  Self.ChooseCreaturesButton.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectedCreaturesRadio
	#tag Event
		Sub ValueChanged()
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
		    If Self.CreatureList.RowSelectedAt(Idx) Then
		      Self.CreatureList.RemoveRowAt(Idx)
		    End If
		  Next Idx
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseCreaturesButton
	#tag Event
		Sub Pressed()
		  Var SelectedCreatures() As Ark.Creature
		  For Idx As Integer = 0 To Self.CreatureList.LastRowIndex
		    SelectedCreatures.Add(Self.CreatureList.RowTagAt(Idx))
		  Next Idx
		  
		  Var AddedCreatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", SelectedCreatures, Self.mMods, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  For Each Creature As Ark.Creature In AddedCreatures
		    Self.CreatureList.AddRow(Creature.Label)
		    Self.CreatureList.RowTagAt(Self.CreatureList.LastAddedRowIndex) = Creature
		  Next Creature
		  Self.CreatureList.Sort
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var MinLevel, MaxLevel As Integer
		  
		  If Self.ChangeColorsCheckbox.Value = False And Self.SetLevelsCheckbox.Value = False Then
		    Self.ShowAlert("No Change Selected", "You must choose at least one action to perform.")
		    Return
		  ElseIf Self.ChangeColorsCheckbox.Value And Self.ColorsMenu.SelectedRowIndex = -1 Then
		    Self.ShowAlert("No Color Selected", "You must choose a color set to apply.")
		    Return
		  ElseIf Self.SetLevelsCheckbox.Value Then
		    If (IsNumeric(Self.MinLevelField.Text) = False Or IsNumeric(Self.MaxLevelField.Text) = False) Then
		      Self.ShowAlert("No Level Range Defined", "You must set a min and max level.")
		      Return
		    End
		    
		    Try
		      MinLevel = Integer.FromString(Self.MinLevelField.Text, Locale.Current)
		    Catch Err As InvalidArgumentException
		    End Try
		    Try
		      MaxLevel = Integer.FromString(Self.MaxLevelField.Text, Locale.Current)
		    Catch Err As InvalidArgumentException
		    End Try
		    
		    If MinLevel <= 0 Or MaxLevel < MinLevel Then
		      Self.ShowAlert("Invalid Level Range Defined", "Minimum level must be greater than zero, and maximum level must not be less than the minimum level.")
		      Return
		    End If
		  End If
		  
		  Var Creatures() As Ark.Creature
		  Var CreatureIds() As String
		  If AllCreaturesRadio.Value Then
		    Creatures = Ark.DataSource.Pool.Get(False).GetCreatures("", Self.mMods)
		    For Each Creature As Ark.Creature In Creatures
		      CreatureIds.Add(Creature.ObjectID)
		    Next
		  Else
		    For RowIdx As Integer = 0 To Self.CreatureList.LastRowIndex
		      Var Creature As Ark.Creature = Self.CreatureList.RowTagAt(RowIdx)
		      Creatures.Add(Creature)
		      CreatureIds.Add(Creature.ObjectID)
		    Next RowIdx
		  End If
		  
		  If Creatures.Count = 0 Then
		    Self.ShowAlert("No Creatures Selected", "You need to select at least one creature to work on.")
		    Return
		  End If
		  
		  Self.mCreatures = Creatures
		  Self.mCreatureIds = CreatureIds
		  
		  Self.mChangeColors = Self.ChangeColorsCheckbox.Value
		  If Self.mChangeColors Then
		    Self.mSelectedColorClass = Self.ColorsMenu.RowTagAt(Self.ColorsMenu.SelectedRowIndex)
		  End If
		  
		  Self.mChangeLevels = Self.SetLevelsCheckbox.Value
		  If Self.mChangeLevels Then
		    // Validation already happened above.
		    Self.mLevelOverrides.ResizeTo(-1)
		    Self.mLevelOverrides.Add(Ark.SpawnPointLevel.FromUserLevel(MinLevel, MaxLevel, Self.mDifficultyValue))
		  End If
		  
		  Self.ActionButton.Enabled = False
		  Self.CancelButton.Enabled = False
		  
		  Self.ProcessingThread.Start
		  Self.Spinner.Visible = True
		  Self.StatusLabel.Text = "Starting thread…"
		  Self.StatusLabel.Visible = True
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
#tag Events ChangeColorsCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.ColorsMenu.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetLevelsCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.MinLevelField.Enabled = Me.Value
		  Self.LevelToLabel.Enabled = Me.Value
		  Self.MaxLevelField.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ColorsMenu
	#tag Event
		Sub Opening()
		  Me.AddRow("No Color Override")
		  Me.RowTagAt(Me.LastAddedRowIndex) = ""
		  
		  Var Colors() As Ark.CreatureColorSet = Ark.DataSource.Pool.Get(False).GetCreatureColorSets()
		  For Each ColorSet As Ark.CreatureColorSet In Colors
		    Me.AddRow(ColorSet.Label)
		    Me.RowTagAt(Me.LastAddedRowIndex) = ColorSet.ClassString
		  Next ColorSet
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ProcessingThread
	#tag Event
		Sub Run()
		  // First, add missing spawn points
		  Var CreaturesCount As Integer = Self.mCreatures.Count
		  Var TotalCreaturesText As String = Language.NounWithQuantity(CreaturesCount, "creature", "creatures")
		  Var CreaturesProcessed As Integer = 0
		  Me.AddUserInterfaceUpdate(New Dictionary("Status": "Found spawn points for 0 of " + TotalCreaturesText + "…"))
		  For Each Creature As Ark.Creature In Self.mCreatures
		    Var Points() As Ark.SpawnPoint = Ark.DataSource.Pool.Get(False).GetSpawnPointsForCreature(Creature, Self.mMods, "")
		    For Each Definition As Ark.SpawnPoint In Points
		      If Definition.ValidForMask(Self.mMask) = False Then
		        Continue
		      End If
		      
		      Var Original As Ark.SpawnPoint = Self.mConfig.GetSpawnPoint(Definition.ObjectID, Ark.SpawnPoint.ModeOverride)
		      If (Original Is Nil) = False Then
		        Continue
		      End If
		      
		      Var Mutable As Ark.MutableSpawnPoint = Definition.MutableClone
		      Mutable.Mode = Ark.SpawnPoint.ModeOverride
		      Ark.DataSource.Pool.Get(False).LoadDefaults(Mutable)
		      
		      Var Remove As Ark.SpawnPoint = Self.mConfig.GetSpawnPoint(Definition.ObjectID, Ark.SpawnPoint.ModeRemove)
		      If (Remove Is Nil) = False Then
		        For Each Set As Ark.SpawnPointSet In Remove
		          For Each Entry As Ark.SpawnPointSetEntry In Set
		            Mutable.RemoveCreature(Entry.Creature)
		          Next Entry
		        Next Set
		        Self.mConfig.Remove(Remove)
		      End If
		      
		      Var Append As Ark.SpawnPoint = Self.mConfig.GetSpawnPoint(Definition.ObjectID, Ark.SpawnPoint.ModeAppend)
		      If (Append Is Nil) = False Then
		        For Each Set As Ark.SpawnPointSet In Append
		          Mutable.AddSet(Set.Clone)
		        Next Set
		        Var Limits As Dictionary = Append.Limits
		        For Each Entry As DictionaryEntry In Limits
		          Var LimitCreature As Ark.Creature = Entry.Key
		          Var Percent As Double = Entry.Value
		          Mutable.Limit(LimitCreature) = Percent
		        Next Entry
		        Self.mConfig.Remove(Append)
		      End If
		      
		      Self.mConfig.Add(Mutable)
		    Next Definition
		    CreaturesProcessed = CreaturesProcessed + 1
		    Me.AddUserInterfaceUpdate(New Dictionary("Status": "Found spawn points for " + CreaturesProcessed.ToString(Locale.Current, "#,##0") + " of " + TotalCreaturesText + "…"))
		  Next Creature
		  
		  // Next, process everything
		  Var Points() As Ark.SpawnPoint = Self.mConfig.Points
		  Var PointCount As Integer = Points.Count
		  Var TotalPointsText As String = Language.NounWithQuantity(PointCount, "spawn point", "spawn points")
		  Var PointsProcessed As Integer
		  Me.AddUserInterfaceUpdate(New Dictionary("Status": "Processed 0 of " + TotalPointsText + "…"))
		  For Each Point As Ark.SpawnPoint In Points
		    Var Mutable As Ark.MutableSpawnPoint = Point.MutableVersion
		    Self.ProcessSpawnPoint(Mutable)
		    PointsProcessed = PointsProcessed + 1
		    Me.AddUserInterfaceUpdate(New Dictionary("Status": "Processed " + PointsProcessed.ToString(Locale.Current, "#,##0") + " of " + TotalPointsText + "…"))
		  Next Point
		  
		  Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Status": "Finished"))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    If Dict.Lookup("Finished", False) Then
		      Self.Spinner.Visible = False
		      Self.mCancelled = False
		      Self.Hide
		    End If
		    If Dict.HasKey("Status") Then
		      Self.StatusLabel.Text = Dict.Value("Status")
		    End If
		  Next Dict
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
