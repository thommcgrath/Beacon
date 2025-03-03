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
   MinimumWidth    =   800
   Resizeable      =   False
   Title           =   "Quick Edit Creatures"
   Type            =   8
   Visible         =   True
   Width           =   800
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
      Width           =   760
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
         PageSize        =   100
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   160
         TotalPages      =   -1
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
      Left            =   700
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
      Left            =   608
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   434
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
         TabIndex        =   2
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
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   96
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   254
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
         Width           =   59
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
         Left            =   569
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
         Left            =   599
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
         Width           =   59
      End
      Begin DesktopCheckBox MultiplyWeightCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Multiply Weight:"
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
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   162
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   128
      End
      Begin UITweaks.ResizedTextField WeightMultiplierField
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
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   162
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   59
      End
      Begin DesktopCheckBox RemoveCreatureCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Remove Creature"
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
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   262
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   294
      End
      Begin DesktopCheckBox ReplaceWithCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Replace With:"
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
         TabIndex        =   10
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   230
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   128
      End
      Begin UITweaks.ResizedPushButton ChooseReplacementButton
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
         InitialParent   =   "ActionsGroup"
         Italic          =   False
         Left            =   670
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   230
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin DesktopLabel ReplacementCreatureField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ActionsGroup"
         Italic          =   True
         Left            =   506
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "No Creature Selected"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   230
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin DesktopCheckBox MultiplyLimitCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Multiply Limit:"
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
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   196
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   128
      End
      Begin UITweaks.ResizedTextField LimitMultiplierField
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
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   196
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   59
      End
   End
   Begin Thread ProcessingThread
      DebugIdentifier =   ""
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
      TabIndex        =   3
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
      TabIndex        =   4
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
      Width           =   548
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
		Private Sub ProcessSpawnPoint(Point As Ark.MutableSpawnPointOverride)
		  For SetIdx As Integer = Point.LastIndex DownTo 0
		    Var MutableSet As Ark.MutableSpawnPointSet = Point.SetAt(SetIdx).MutableVersion
		    Var ChangeThisColorSet, ChangeThisWeight As Boolean
		    
		    For EntryIdx As Integer = MutableSet.LastIndex DownTo 0
		      Var Entry As Ark.MutableSpawnPointSetEntry = MutableSet.Entry(EntryIdx).MutableVersion
		      If Self.mCreatureIds.IndexOf(Entry.Creature.CreatureId) = -1 Then
		        Continue
		      End If
		      
		      If Self.mReplacesCreatures Then
		        Entry.CreatureReference = Self.mReplacementCreatureRef
		      ElseIf Self.mRemovesCreatures Then
		        MutableSet.Remove(EntryIdx)
		        Continue
		      End If
		      
		      If Self.mChangeColors Then
		        ChangeThisColorSet = True
		      End
		      
		      If Self.mChangeWeights Then
		        ChangeThisWeight = True
		      End If
		      
		      If Self.mChangeLevels Then
		        Entry.MaxLevelMultiplier = Nil
		        Entry.MinLevelMultiplier = Nil
		        Entry.MaxLevelOffset = Nil
		        Entry.MinLevelOffset = Nil
		        Entry.Levels = Self.mLevelOverrides
		      End If
		      
		      If Entry.Modified Then
		        MutableSet.Entry(EntryIdx) = Entry
		      End If
		    Next
		    
		    If MutableSet.Count > 0 Then
		      If MutableSet.ReplacesCreatures And (Self.mReplacesCreatures Or Self.mRemovesCreatures) Then
		        Var ReplacedRefs() As Ark.BlueprintReference = MutableSet.ReplacedCreatureRefs
		        For Each FromCreatureRef As Ark.BlueprintReference In ReplacedRefs
		          Var OriginalFromCreatureRef As Ark.BlueprintReference = FromCreatureRef
		          Var FromCreatureTargeted As Boolean
		          If Self.mCreatureIds.IndexOf(FromCreatureRef.BlueprintId) > -1 Then
		            FromCreatureRef = Self.mReplacementCreatureRef
		            FromCreatureTargeted = True
		          End If
		          
		          Var ReplacementRefs() As Ark.BlueprintReference = MutableSet.ReplacementCreatures(OriginalFromCreatureRef)
		          For Each ToCreatureRef As Ark.BlueprintReference In ReplacementRefs
		            Var OriginalToCreatureRef As Ark.BlueprintReference = ToCreatureRef
		            If Self.mCreatureIds.IndexOf(ToCreatureRef.BlueprintId) > -1 Then
		              ToCreatureRef = Self.mReplacementCreatureRef
		            End If
		            
		            If (Self.mReplacesCreatures And OriginalFromCreatureRef.BlueprintId = FromCreatureRef.BlueprintId And OriginalToCreatureRef.BlueprintId = ToCreatureRef.BlueprintId) Or (Self.mRemovesCreatures And FromCreatureTargeted = False) Then
		              // No change
		              Continue
		            End If
		            
		            Var Weight As NullableDouble = MutableSet.CreatureReplacementWeight(OriginalFromCreatureRef, OriginalToCreatureRef)
		            MutableSet.CreatureReplacementWeight(OriginalFromCreatureRef, OriginalToCreatureRef) = Nil
		            If Self.mReplacesCreatures Then
		              MutableSet.CreatureReplacementWeight(FromCreatureRef, ToCreatureRef) = Weight
		            End If
		          Next
		        Next
		      End If
		      
		      If ChangeThisColorSet And MutableSet.ColorSetClass <> Self.mSelectedColorClass Then
		        MutableSet.ColorSetClass = Self.mSelectedColorClass
		      End If
		      
		      If ChangeThisWeight Then
		        MutableSet.RawWeight = MutableSet.RawWeight * Self.mWeightMultiplier
		      End If
		      
		      Point.SetAt(SetIdx) = MutableSet
		    Else
		      Point.RemoveAt(SetIdx)
		    End If
		  Next
		  
		  If Self.mChangeLimits Then
		    For Each Creature As Ark.Creature In Self.mCreatures
		      Var CurrentLimit As Double = Point.Limit(Creature)
		      If CurrentLimit < 1.0 Then
		        Point.Limit(Creature) = CurrentLimit * Self.mLimitMultiplier
		      End If
		    Next
		  ElseIf Self.mRemovesCreatures Then
		    For Each Creature As Ark.Creature In Self.mCreatures
		      Point.Limit(Creature) = 1.0
		    Next
		  End If
		  
		  Self.mConfig.Add(Point)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEnabledState()
		  Var ColorsAllowed, LevelsAllowed, WeightAllowed, LimitAllowed, ReplaceAllowed, RemoveAllowed As Boolean = True
		  Var ColorsEnabled, LevelsEnabled, WeightEnabled, LimitEnabled, ReplaceEnabled As Boolean
		  
		  If Self.RemoveCreatureCheckbox.Value Then
		    ColorsAllowed = False
		    LevelsAllowed = False
		    WeightAllowed = False
		    LimitAllowed = False
		    ReplaceAllowed = False
		  Else
		    ReplaceEnabled = Self.ReplaceWithCheckbox.Value
		    ColorsEnabled = Self.ChangeColorsCheckbox.Value
		    LevelsEnabled = Self.SetLevelsCheckbox.Value
		    WeightEnabled = Self.MultiplyWeightCheckbox.Value
		    LimitEnabled = Self.MultiplyLimitCheckbox.Value
		    
		    RemoveAllowed = Not (ColorsEnabled Or LevelsEnabled Or WeightEnabled Or LimitEnabled Or ReplaceEnabled)
		  End If
		  
		  Self.ChangeColorsCheckbox.Enabled = ColorsAllowed
		  Self.ColorsMenu.Enabled = ColorsAllowed And ColorsEnabled
		  
		  Self.SetLevelsCheckbox.Enabled = LevelsAllowed
		  Self.MinLevelField.Enabled = LevelsAllowed And LevelsEnabled
		  Self.LevelToLabel.Enabled = LevelsAllowed And LevelsEnabled
		  Self.MaxLevelField.Enabled = LevelsAllowed And LevelsEnabled
		  
		  Self.MultiplyWeightCheckbox.Enabled = WeightAllowed
		  Self.WeightMultiplierField.Enabled = WeightAllowed And WeightEnabled
		  
		  Self.MultiplyLimitCheckbox.Enabled = LimitAllowed
		  Self.LimitMultiplierField.Enabled = LimitAllowed And LimitEnabled
		  
		  Self.ReplaceWithCheckbox.Enabled = ReplaceAllowed
		  Self.ReplacementCreatureField.Enabled = ReplaceAllowed And ReplaceEnabled
		  Self.ChooseReplacementButton.Enabled = ReplaceAllowed And ReplaceEnabled
		  
		  Self.RemoveCreatureCheckbox.Enabled = RemoveAllowed
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
		Private mChangeLimits As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChangeWeights As Boolean
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
		Private mLimitMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemovesCreatures As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReplacementCreatureRef As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReplacesCreatures As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedColorClass As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeightMultiplier As Double
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
		  Var WeightMultiplier, LimitMultiplier As Double = 1.0
		  
		  If Self.ChangeColorsCheckbox.Value = False And Self.SetLevelsCheckbox.Value = False And Self.MultiplyWeightCheckbox.Value = False And Self.MultiplyLimitCheckbox.Value = False And Self.RemoveCreatureCheckbox.Value = False And Self.ReplaceWithCheckbox.Value = False Then
		    Self.ShowAlert("No Change Selected", "You must choose at least one action to perform.")
		    Return
		  End If
		  If Self.ChangeColorsCheckbox.Value And Self.ColorsMenu.SelectedRowIndex = -1 Then
		    Self.ShowAlert("No Color Selected", "You must choose a color set to apply.")
		    Return
		  End If
		  If Self.SetLevelsCheckbox.Value Then
		    If (IsNumeric(Self.MinLevelField.Text) = False Or IsNumeric(Self.MaxLevelField.Text) = False) Then
		      Self.ShowAlert("No Level Range Defined", "You must set a min and max level.")
		      Return
		    End
		    
		    Try
		      MinLevel = Integer.FromString(Self.MinLevelField.Text, Locale.Current)
		    Catch Err As RuntimeException
		    End Try
		    Try
		      MaxLevel = Integer.FromString(Self.MaxLevelField.Text, Locale.Current)
		    Catch Err As RuntimeException
		    End Try
		    
		    If MinLevel <= 0 Or MaxLevel < MinLevel Then
		      Self.ShowAlert("Invalid Level Range Defined", "Minimum level must be greater than zero, and maximum level must not be less than the minimum level.")
		      Return
		    End If
		  End
		  If Self.MultiplyWeightCheckbox.Value Then
		    Try
		      WeightMultiplier = Double.FromString(Self.WeightMultiplierField.Text, Locale.Current)
		    Catch Err As RuntimeException
		      Self.ShowAlert("Bad Weight Multiplier", "The weight multiplier must be a number.")
		    End Try
		  End If
		  If Self.MultiplyLimitCheckbox.Value Then
		    Try
		      LimitMultiplier = Double.FromString(Self.LimitMultiplierField.Text, Locale.Current)
		    Catch Err As RuntimeException
		      Self.ShowAlert("Bad Limit Multiplier", "The limit multiplier must be a number.")
		    End Try
		  End If
		  If Self.ReplaceWithCheckbox.Value And Self.mReplacementCreatureRef Is Nil Then
		    Self.ShowAlert("No Replacement Selected", "You must choose a creature to use as a replacement.")
		    Return
		  End If
		  
		  Var Creatures() As Ark.Creature
		  Var CreatureIds() As String
		  If AllCreaturesRadio.Value Then
		    Creatures = Ark.DataSource.Pool.Get(False).GetCreatures("", Self.mMods)
		    For Each Creature As Ark.Creature In Creatures
		      CreatureIds.Add(Creature.CreatureId)
		    Next
		  Else
		    For RowIdx As Integer = 0 To Self.CreatureList.LastRowIndex
		      Var Creature As Ark.Creature = Self.CreatureList.RowTagAt(RowIdx)
		      Creatures.Add(Creature)
		      CreatureIds.Add(Creature.CreatureId)
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
		  
		  Self.mChangeWeights = Self.MultiplyWeightCheckbox.Value
		  If Self.mChangeWeights Then
		    Self.mWeightMultiplier = WeightMultiplier
		  End If
		  
		  Self.mChangeLimits = Self.MultiplyLimitCheckbox.Value
		  If Self.mChangeLimits Then
		    Self.mLimitMultiplier = LimitMultiplier
		  End If
		  
		  Self.mChangeLevels = Self.SetLevelsCheckbox.Value
		  If Self.mChangeLevels Then
		    // Validation already happened above.
		    Self.mLevelOverrides.ResizeTo(-1)
		    Self.mLevelOverrides.Add(Ark.SpawnPointLevel.FromUserLevel(MinLevel, MaxLevel, Self.mDifficultyValue))
		  End If
		  
		  Self.mRemovesCreatures = Self.RemoveCreatureCheckbox.Value
		  Self.mReplacesCreatures = Self.ReplaceWithCheckbox.Value
		  
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
		  Self.UpdateEnabledState()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetLevelsCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.UpdateEnabledState()
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
#tag Events MultiplyWeightCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.UpdateEnabledState()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveCreatureCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.UpdateEnabledState()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceWithCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.UpdateEnabledState()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseReplacementButton
	#tag Event
		Sub Pressed()
		  Var SelectedCreatures() As Ark.Creature
		  Var AddedCreatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", SelectedCreatures, Self.mMods, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If AddedCreatures.Count >= 1 Then
		    Self.mReplacementCreatureRef = New Ark.BlueprintReference(AddedCreatures(0))
		    Self.ReplacementCreatureField.Text = AddedCreatures(0).Label
		    Self.ReplacementCreatureField.Italic = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MultiplyLimitCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.UpdateEnabledState()
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
		    Var Points() As Ark.SpawnPoint = Ark.DataSource.Pool.Get(False).GetSpawnPointsForCreature(Creature, Self.mMods, Nil)
		    For Each Definition As Ark.SpawnPoint In Points
		      If Definition.ValidForMask(Self.mMask) = False Then
		        Continue
		      End If
		      
		      Var Original As Ark.SpawnPointOverride = Self.mConfig.OverrideForSpawnPoint(Definition, Ark.SpawnPointOverride.ModeOverride)
		      If (Original Is Nil) = False Then
		        Continue
		      End If
		      
		      Var Mutable As New Ark.MutableSpawnPointOverride(Definition, Ark.SpawnPointOverride.ModeOverride, True)
		      
		      Var Remove As Ark.SpawnPointOverride = Self.mConfig.OverrideForSpawnPoint(Definition, Ark.SpawnPointOverride.ModeRemove)
		      If (Remove Is Nil) = False Then
		        For Each Set As Ark.SpawnPointSet In Remove
		          For Each Entry As Ark.SpawnPointSetEntry In Set
		            Mutable.RemoveCreature(Entry.Creature)
		          Next Entry
		        Next Set
		        Self.mConfig.Remove(Remove)
		      End If
		      
		      Var Append As Ark.SpawnPointOverride = Self.mConfig.OverrideForSpawnPoint(Definition, Ark.SpawnPointOverride.ModeAppend)
		      If (Append Is Nil) = False Then
		        For Each Set As Ark.SpawnPointSet In Append
		          Mutable.Add(Set.Clone)
		        Next Set
		        Var LimitedCreatureRefs() As Ark.BlueprintReference = Append.LimitedCreatureRefs
		        For Each CreatureRef As Ark.BlueprintReference In LimitedCreatureRefs
		          Var Percent As Double = Append.Limit(CreatureRef)
		          Mutable.Limit(CreatureRef) = Percent
		        Next
		        Self.mConfig.Remove(Append)
		      End If
		      
		      Self.mConfig.Add(Mutable)
		    Next Definition
		    CreaturesProcessed = CreaturesProcessed + 1
		    Me.AddUserInterfaceUpdate(New Dictionary("Status": "Found spawn points for " + CreaturesProcessed.ToString(Locale.Current, "#,##0") + " of " + TotalCreaturesText + "…"))
		  Next Creature
		  
		  // Next, process everything
		  Var Overrides() As Ark.SpawnPointOverride = Self.mConfig.Overrides
		  Var OverrideCount As Integer = Overrides.Count
		  Var TotalPointsText As String = Language.NounWithQuantity(OverrideCount, "spawn point", "spawn points")
		  Var PointsProcessed As Integer
		  Me.AddUserInterfaceUpdate(New Dictionary("Status": "Processed 0 of " + TotalPointsText + "…"))
		  For Each Override As Ark.SpawnPointOverride In Overrides
		    Var Mutable As Ark.MutableSpawnPointOverride = Override.MutableVersion
		    Self.ProcessSpawnPoint(Mutable)
		    PointsProcessed = PointsProcessed + 1
		    Me.AddUserInterfaceUpdate(New Dictionary("Status": "Processed " + PointsProcessed.ToString(Locale.Current, "#,##0") + " of " + TotalPointsText + "…"))
		  Next
		  
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
