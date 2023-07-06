#tag DesktopWindow
Begin BeaconContainer ArkSpawnPointSetEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   678
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   784
   Begin DesktopGroupBox EntriesGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Creatures"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   275
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   103
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   428
      Begin UITweaks.ResizedPushButton EntryAddButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "EntriesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   338
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton EntryEditButton
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
         InitialParent   =   "EntriesGroup"
         Italic          =   False
         Left            =   132
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   338
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton EntryDeleteButton
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
         InitialParent   =   "EntriesGroup"
         Italic          =   False
         Left            =   224
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   338
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox EntriesList
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
         DefaultRowHeight=   34
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
         Height          =   187
         Index           =   -2147483648
         InitialParent   =   "EntriesGroup"
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
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   139
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   388
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin DesktopGroupBox ReplaceGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Creature Replacement"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   275
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   460
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   103
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   304
      Begin UITweaks.ResizedPushButton ReplaceAddButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ReplaceGroup"
         Italic          =   False
         Left            =   480
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   338
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ReplaceEditButton
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
         InitialParent   =   "ReplaceGroup"
         Italic          =   False
         Left            =   572
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   338
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ReplaceDeleteButton
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
         InitialParent   =   "ReplaceGroup"
         Italic          =   False
         Left            =   664
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   338
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox ReplaceList
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
         DefaultRowHeight=   34
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
         Height          =   187
         Index           =   -2147483648
         InitialParent   =   "ReplaceGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   480
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   139
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   264
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin UITweaks.ResizedTextField NameField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   103
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   472
   End
   Begin RangeField WeightField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   670
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "500"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel NameLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Name:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   71
   End
   Begin UITweaks.ResizedLabel WeightLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   587
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Weight:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   71
   End
   Begin DesktopUpDownArrows WeightStepper
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   751
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Visible         =   True
      Width           =   13
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopGroupBox AdvancedGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Advanced (Optional)"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   268
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   390
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   744
      Begin UITweaks.ResizedLabel WaterMinHeightLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Min Water Height:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   494
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   136
      End
      Begin UITweaks.ResizedLabel SpreadRadiusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Spread Radius:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   460
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   136
      End
      Begin UITweaks.ResizedLabel DistanceMultipliersLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "Distance Multipliers:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   584
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   136
      End
      Begin UITweaks.ResizedLabel OffsetLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "Offset (X, Y, Z):"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   426
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   136
      End
      Begin RangeField WaterMinHeightField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   188
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   494
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin RangeField SpreadRadiusField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   188
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   460
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin RangeField TameDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   390
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
         Top             =   584
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin RangeField StructureDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   289
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
         Top             =   584
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin RangeField PlayerDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   188
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
         Top             =   584
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin RangeField OffsetFields
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   2
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   390
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
         Top             =   426
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin RangeField OffsetFields
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   1
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   289
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
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   426
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin RangeField OffsetFields
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   0
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   188
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   426
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   89
      End
      Begin DesktopCheckBox OffsetBeforeMultiplierCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Add Level Offset Before Multiplier"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   188
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   14
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   "When enabled, any level multipliers will be applied before adding any level offsets. When disabled, offsets are added first, then the multipliers are used."
         Top             =   528
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   291
      End
      Begin DesktopLabel PlayerDistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   188
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   15
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Players"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   560
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   89
      End
      Begin DesktopLabel StructureDistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   289
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   16
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Structures"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   560
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   89
      End
      Begin DesktopLabel TameDistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   390
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   17
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Tames"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   560
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   89
      End
      Begin UITweaks.ResizedPopupMenu ColorSetsMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   188
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   18
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   618
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   291
      End
      Begin UITweaks.ResizedLabel ColorSetsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AdvancedGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   19
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Colors:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   618
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   136
      End
   End
   Begin OmniBar SpawnSetToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   784
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SizeLabels()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  If Self.mHasSizedLabels = False Then
		    Self.SizeLabels()
		  End If
		  
		  Const ReplaceMinWidth = 304
		  Const DesiredButtonsWidth = 80
		  Const ScaleDownStartWidth = 660
		  Const ScaleDownStartHeight = 600
		  
		  Var MajorMargin As Integer = 20
		  Var MinorMargin As Integer = 12
		  If Self.Width < ScaleDownStartWidth Or Self.Height < 600 Then
		    Var WidthPercent As Double = 1.0 - ((ScaleDownStartWidth - Self.Width) / (ScaleDownStartWidth - Self.MinEditorWidth))
		    Var HeightPercent As Double = 1.0 - ((ScaleDownStartHeight - Self.Height) / (ScaleDownStartHeight - Self.MinEditorHeight))
		    MajorMargin = 10 + Round(10 * Min(WidthPercent, HeightPercent))
		    MinorMargin = 10 + Round(2 * Min(WidthPercent, HeightPercent))
		  End If
		  
		  Self.NameLabel.Left = MajorMargin
		  Self.NameLabel.Top = Self.SpawnSetToolbar.Bottom + MajorMargin
		  Self.WeightStepper.Top = Self.NameLabel.Top
		  Self.WeightStepper.Left = Self.Width - (Self.WeightStepper.Width + MajorMargin)
		  Self.WeightField.Top = Self.NameLabel.Top
		  Self.WeightField.Left = Self.WeightStepper.Left - (Self.WeightField.Width + 1)
		  Self.WeightLabel.Top = Self.WeightField.Top
		  Self.WeightLabel.Left = Self.WeightField.Left - (Self.WeightLabel.Width + MinorMargin)
		  Self.NameField.Top = Self.NameLabel.Top
		  Self.NameField.Left = Self.NameLabel.Right + MinorMargin
		  Self.NameField.Width = Self.WeightLabel.Left - (Self.NameField.Left + MinorMargin)
		  
		  Var AvailableWidth As Integer = Self.Width - ((MajorMargin * 2) + MinorMargin)
		  Var ReplacementsWidth As Integer = Max(AvailableWidth * 0.4, ReplaceMinWidth)
		  Var EntriesWidth As Integer = AvailableWidth - ReplacementsWidth
		  If EntriesWidth < ReplaceMinWidth Then
		    EntriesWidth = Ceiling(AvailableWidth / 2)
		    ReplacementsWidth = Floor(AvailableWidth / 2)
		  End If
		  
		  Self.EntriesGroup.Left = MajorMargin
		  Self.EntriesGroup.Top = Self.NameLabel.Bottom + MajorMargin
		  Self.EntriesGroup.Width = EntriesWidth
		  Self.ReplaceGroup.Left = Self.EntriesGroup.Right + MinorMargin
		  Self.ReplaceGroup.Top = Self.EntriesGroup.Top
		  Self.ReplaceGroup.Width = ReplacementsWidth
		  
		  Self.SizeGroup(Self.EntriesGroup, Self.EntriesList, Self.EntryAddButton, Self.EntryEditButton, Self.EntryDeleteButton, MajorMargin, MinorMargin)
		  Self.SizeGroup(Self.ReplaceGroup, Self.ReplaceList, Self.ReplaceAddButton, Self.ReplaceEditButton, Self.ReplaceDeleteButton, MajorMargin, MinorMargin)
		  
		  Self.OffsetLabel.Top = Self.AdvancedGroup.Top + 16 + MajorMargin
		  Self.OffsetLabel.Left = Self.AdvancedGroup.Left + MajorMargin
		  Self.OffsetFields(0).Top = Self.OffsetLabel.Top
		  Self.OffsetFields(0).Left = Self.OffsetLabel.Right + MinorMargin
		  Self.OffsetFields(1).Top = Self.OffsetLabel.Top
		  Self.OffsetFields(1).Left = Self.OffsetFields(0).Right + MinorMargin
		  Self.OffsetFields(2).Top = Self.OffsetLabel.Top
		  Self.OffsetFields(2).Left = Self.OffsetFields(1).Right + MinorMargin
		  
		  Self.SpreadRadiusLabel.Top = Self.OffsetLabel.Bottom + MinorMargin
		  Self.SpreadRadiusLabel.Left = Self.OffsetLabel.Left
		  Self.SpreadRadiusField.Top = Self.SpreadRadiusLabel.Top
		  Self.SpreadRadiusField.Left = Self.SpreadRadiusLabel.Right + MinorMargin
		  
		  Self.WaterMinHeightLabel.Top = Self.SpreadRadiusLabel.Bottom + MinorMargin
		  Self.WaterMinHeightLabel.Left = Self.OffsetLabel.Left
		  Self.WaterMinHeightField.Top = Self.WaterMinHeightLabel.Top
		  Self.WaterMinHeightField.Left = Self.WaterMinHeightLabel.Right + MinorMargin
		  
		  Self.OffsetBeforeMultiplierCheck.Top = Self.WaterMinHeightField.Bottom + MinorMargin
		  Self.OffsetBeforeMultiplierCheck.Left = Self.WaterMinHeightField.Left
		  
		  Self.PlayerDistanceLabel.Top = Self.OffsetBeforeMultiplierCheck.Bottom + MinorMargin
		  Self.PlayerDistanceLabel.Left = Self.OffsetBeforeMultiplierCheck.Left
		  Self.StructureDistanceLabel.Top = Self.PlayerDistanceLabel.Top
		  Self.StructureDistanceLabel.Left = Self.PlayerDistanceLabel.Right + MinorMargin
		  Self.TameDistanceLabel.Top = Self.PlayerDistanceLabel.Top
		  Self.TameDistanceLabel.Left = Self.StructureDistanceLabel.Right + MinorMargin
		  
		  Self.PlayerDistanceField.Top = Self.PlayerDistanceLabel.Bottom + 4
		  Self.PlayerDistanceField.Left = Self.PlayerDistanceLabel.Left
		  Self.StructureDistanceField.Top = Self.PlayerDistanceField.Top
		  Self.StructureDistanceField.Left = Self.StructureDistanceLabel.Left
		  Self.TameDistanceField.Top = Self.PlayerDistanceField.Top
		  Self.TameDistanceField.Left = Self.TameDistanceLabel.Left
		  Self.DistanceMultipliersLabel.Top = Self.PlayerDistanceField.Top
		  Self.DistanceMultipliersLabel.Left = Self.OffsetLabel.Left
		  
		  Self.ColorSetsLabel.Top = Self.DistanceMultipliersLabel.Bottom + MinorMargin
		  Self.ColorSetsLabel.Left = Self.OffsetLabel.Left
		  Self.ColorSetsMenu.Top = Self.ColorSetsLabel.Top
		  Self.ColorSetsMenu.Left = Self.ColorSetsLabel.Right + MinorMargin
		  
		  Var AdvancedInnerHeight As Integer = Self.ColorSetsMenu.Bottom - Self.OffsetLabel.Top
		  Self.AdvancedGroup.Height = AdvancedInnerHeight + 16 + (MajorMargin * 2)
		  Self.AdvancedGroup.Width = Self.Width - (MajorMargin * 2)
		  Self.AdvancedGroup.Top = Self.Height - (MajorMargin + Self.AdvancedGroup.Height)
		  Self.AdvancedGroup.Left = MajorMargin
		  
		  Self.EntriesGroup.Height = Self.AdvancedGroup.Top - (MajorMargin + Self.EntriesGroup.Top)
		  Self.ReplaceGroup.Height = Self.EntriesGroup.Height
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Project() As Ark.Project
		  Return RaiseEvent GetProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub SizeGroup(Group As DesktopGroupBox, List As DesktopListBox, AddButton As DesktopButton, EditButton As DesktopButton, DeleteButton As DesktopButton, MajorMargin As Integer, MinorMargin As Integer)
		  Const DesiredButtonsWidth = 80
		  
		  List.Left = Group.Left + MajorMargin
		  List.Width = Group.Width - (MajorMargin * 2)
		  List.Top = Group.Top + 16 + MajorMargin
		  AddButton.Top = Group.Bottom - (MajorMargin + AddButton.Height)
		  EditButton.Top = AddButton.Top
		  DeleteButton.Top = AddButton.Top
		  List.Height = AddButton.Top - (MinorMargin + List.Top)
		  If List.Width < ((DesiredButtonsWidth * 3) + (MinorMargin * 2)) Then
		    Var BaseButtonsWidth As Integer = Floor((List.Width - (MinorMargin * 2)) / 3)
		    Var Remainder As Integer = List.Width - ((MinorMargin * 2) + (BaseButtonsWidth * 3))
		    
		    AddButton.Width = BaseButtonsWidth + If(Remainder > 0, 1, 0)
		    EditButton.Width = BaseButtonsWidth + If(Remainder > 1, 1, 0)
		    DeleteButton.Width = BaseButtonsWidth + If(Remainder > 2, 1, 0)
		  Else
		    AddButton.Width = DesiredButtonsWidth
		    EditButton.Width = DesiredButtonsWidth
		    DeleteButton.Width = DesiredButtonsWidth
		  End If
		  AddButton.Left = List.Left
		  EditButton.Left = AddButton.Right + MinorMargin
		  DeleteButton.Left = EditButton.Right + MinorMargin
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SizeLabels()
		  If Self.NameLabel.Visible = False Then
		    Return
		  End If
		  
		  Self.NameLabel.SizeToFit
		  Self.WeightLabel.SizeToFit
		  BeaconUI.SizeToFit(Self.OffsetLabel, Self.SpreadRadiusLabel, Self.WaterMinHeightLabel, Self.DistanceMultipliersLabel, Self.ColorSetsLabel)
		  Self.mHasSizedLabels = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnSet() As Ark.MutableSpawnPointSet
		  If (Self.mRef Is Nil) = False And (Self.mRef.Value Is Nil) = False Then
		    Return Ark.MutableSpawnPointSet(Self.mRef.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnSet(Assigns Set As Ark.MutableSpawnPointSet)
		  If Set = Self.SpawnSet Then
		    Return
		  End If
		  
		  If Set Is Nil Then
		    Self.mRef = Nil
		    Self.UpdateUI(New Ark.MutableSpawnPointSet)
		    Return
		  End If
		  
		  Self.mRef = New WeakRef(Set)
		  Self.UpdateUI(Set)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEntriesList(Set As Ark.SpawnPointSet, SelectEntries() As Ark.SpawnPointSetEntry = Nil)
		  Var List As BeaconListbox = Self.EntriesList
		  
		  Var SelectedEntries() As String
		  If SelectEntries = Nil Then
		    For I As Integer = 0 To List.RowCount - 1
		      If List.RowSelectedAt(I) Then
		        Var Entry As Ark.SpawnPointSetEntry = List.RowTagAt(I)
		        SelectedEntries.Add(Entry.ID)
		      End If
		    Next
		  Else
		    For Each Entry As Ark.SpawnPointSetEntry In SelectEntries
		      SelectedEntries.Add(Entry.ID)
		    Next
		  End If
		  
		  Var RowHeight As Integer = BeaconListbox.StandardRowHeight
		  List.SelectionChangeBlocked = True
		  List.RowCount = Set.Count
		  Var Bound As Integer = Set.Count - 1
		  For RowIndex As Integer = 0 To Bound
		    Var Entry As Ark.SpawnPointSetEntry = Set.Entry(RowIndex)
		    
		    Var Figures() As String
		    If Entry.Offset <> Nil Then
		      Figures.Add("Offset: " + Entry.Offset.X.PrettyText + "," + Entry.Offset.Y.PrettyText + "," + Entry.Offset.Z.PrettyText)
		    End If
		    If (Entry.SpawnChance Is Nil) = False Then
		      Var Percent As Double = Max(Min(Entry.SpawnChance.DoubleValue, 1.0), 0.0) * 100
		      Figures.Add("Chance: " + Percent.PrettyText(2) + "%")
		    End If
		    If Entry.LevelCount > 0 Or Entry.MinLevelOffset <> Nil Or Entry.MaxLevelOffset <> Nil Or Entry.MinLevelMultiplier <> Nil Or Entry.MaxLevelMultiplier <> Nil Then
		      Var Difficulty As Double = Self.Project.Difficulty.DifficultyValue
		      Var LevelRange As Beacon.Range = Entry.LevelRangeForDifficulty(Difficulty, Set.LevelOffsetBeforeMultiplier)
		      Figures.Add("Level Override: " + LevelRange.Min.PrettyText() + " to " + LevelRange.Max.PrettyText())
		    End If
		    Figures.Sort
		    
		    Var Label As String = Entry.Creature.Label
		    If Figures.LastIndex > -1 Then
		      Label = Label + EndOfLine + Figures.Join("   ")
		      RowHeight = BeaconListbox.DoubleLineRowHeight
		    End If
		    
		    List.RowTagAt(RowIndex) = Entry.MutableVersion
		    List.CellTextAt(RowIndex, 0) = Label
		    List.RowSelectedAt(RowIndex) = SelectedEntries.IndexOf(Entry.ID) > -1
		  Next
		  If List.DefaultRowHeight <> RowHeight Then
		    List.DefaultRowHeight = RowHeight
		  End If
		  List.SortingColumn = 0
		  List.Sort
		  List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateReplacementsList(Set As Ark.SpawnPointSet, SelectCreatures() As Ark.Creature = Nil)
		  Var SelectedReplacements() As String
		  If SelectCreatures = Nil Then
		    For I As Integer = 0 To Self.ReplaceList.RowCount - 1
		      If Self.ReplaceList.RowSelectedAt(I) Then
		        SelectedReplacements.Add(Self.ReplaceList.RowTagAt(I))
		      End If
		    Next
		  Else
		    For Each Creature As Ark.Creature In SelectCreatures
		      SelectedReplacements.Add(Creature.ObjectID)
		    Next
		  End If
		  
		  Var ReplacedCreatures() As Ark.Creature = Set.ReplacedCreatures
		  Self.ReplaceList.SelectionChangeBlocked = True
		  Self.ReplaceList.RowCount = ReplacedCreatures.LastIndex + 1
		  For RowIndex As Integer = 0 To ReplacedCreatures.LastIndex
		    Var ReplacedCreature As Ark.Creature = ReplacedCreatures(RowIndex)
		    Var ReplacementCreatures() As Ark.Creature = Set.ReplacementCreatures(ReplacedCreature)
		    
		    Var TotalWeight As Double
		    For Each ReplacementCreature As Ark.Creature In ReplacementCreatures
		      Var Weight As NullableDouble = Set.CreatureReplacementWeight(ReplacedCreature, ReplacementCreature)
		      If Weight <> Nil Then
		        TotalWeight = TotalWeight + Weight
		      End If
		    Next
		    
		    Var ReplacementCreatureNames() As String
		    For Each ReplacementCreature As Ark.Creature In ReplacementCreatures
		      Var Label As String = ReplacementCreature.Label
		      Var Weight As NullableDouble = Set.CreatureReplacementWeight(ReplacedCreature, ReplacementCreature)
		      If Weight <> Nil Then
		        Var Chance As Double = (Weight / TotalWeight) * 100
		        Label = Label + " (" + Chance.PrettyText(2) + "%)"
		      End If
		      ReplacementCreatureNames.Add(Label)
		    Next
		    ReplacementCreatureNames.Sort
		    
		    Self.ReplaceList.CellTextAt(RowIndex, 0) = ReplacedCreature.Label + EndOfLine + Language.EnglishOxfordList(ReplacementCreatureNames)
		    Self.ReplaceList.RowTagAt(RowIndex) = ReplacedCreature.ObjectID
		    Self.ReplaceList.RowSelectedAt(RowIndex) = SelectedReplacements.IndexOf(ReplacedCreature.ObjectID) > -1
		  Next
		  Self.ReplaceList.SortingColumn = 0
		  Self.ReplaceList.Sort
		  Self.ReplaceList.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI(Set As Ark.SpawnPointSet)
		  Self.mSettingUp = True
		  
		  Self.NameField.Text = Set.Label
		  Self.WeightField.DoubleValue = Set.RawWeight
		  Self.OffsetBeforeMultiplierCheck.Value = Set.LevelOffsetBeforeMultiplier
		  
		  If Set.GroupOffset <> Nil Then
		    Self.OffsetFields(0).DoubleValue = Set.GroupOffset.X
		    Self.OffsetFields(1).DoubleValue = Set.GroupOffset.Y
		    Self.OffsetFields(2).DoubleValue = Set.GroupOffset.Z
		  Else
		    Self.OffsetFields(0).Clear
		    Self.OffsetFields(1).Clear
		    Self.OffsetFields(2).Clear
		  End If
		  
		  If Set.MinDistanceFromPlayersMultiplier <> Nil Then
		    Self.PlayerDistanceField.DoubleValue = Set.MinDistanceFromPlayersMultiplier
		  Else
		    Self.PlayerDistanceField.Clear
		  End If
		  
		  If Set.MinDistanceFromStructuresMultiplier <> Nil Then
		    Self.StructureDistanceField.DoubleValue = Set.MinDistanceFromStructuresMultiplier
		  Else
		    Self.StructureDistanceField.Clear
		  End If
		  
		  If Set.MinDistanceFromTamedDinosMultiplier <> Nil Then
		    Self.TameDistanceField.DoubleValue = Set.MinDistanceFromTamedDinosMultiplier
		  Else
		    Self.TameDistanceField.Clear
		  End If
		  
		  If Set.SpreadRadius <> Nil Then
		    Self.SpreadRadiusField.DoubleValue = Set.SpreadRadius
		  Else
		    Self.SpreadRadiusField.Clear
		  End If
		  
		  If Set.WaterOnlyMinimumHeight <> Nil Then
		    Self.WaterMinHeightField.DoubleValue = Set.WaterOnlyMinimumHeight
		  Else
		    Self.WaterMinHeightField.Clear
		  End If
		  
		  Self.ColorSetsMenu.RemoveAllRows
		  Self.ColorSetsMenu.AddRow("Unchanged", "")
		  Self.ColorSetsMenu.SelectedRowIndex = 0
		  #if TargetMacOS
		    Self.ColorSetsMenu.AddRow(MenuItem.TextSeparator, "-")
		  #endif
		  Var FoundColorSet As Boolean
		  If Set.ColorSetClass.IsEmpty Then
		    FoundColorSet = True
		  End If
		  Var ColorSets() As Ark.CreatureColorSet = Ark.DataSource.Pool.Get(False).GetCreatureColorSets()
		  For Each ColorSet As Ark.CreatureColorSet In ColorSets
		    If FoundColorSet = False And ColorSet.ClassString = Set.ColorSetClass Then
		      FoundColorSet = True
		    End If
		    Self.ColorSetsMenu.AddRow(ColorSet.Label, ColorSet.ClassString)
		  Next
		  If FoundColorSet = False Then
		    Self.ColorSetsMenu.AddRowAt(1, Set.ColorSetClass, Set.ColorSetClass)
		  End If
		  Self.ColorSetsMenu.SelectByTag(Set.ColorSetClass)
		  
		  Self.UpdateEntriesList(Set)
		  Self.UpdateReplacementsList(Set)
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetProject() As Ark.Project
	#tag EndHook


	#tag Property, Flags = &h21
		Private mHasSizedLabels As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = kEntryClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.spawn.entry", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kReplacementClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.spawn.replacement", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinEditorHeight, Type = Double, Dynamic = False, Default = \"535", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MinEditorWidth, Type = Double, Dynamic = False, Default = \"519", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WeightScale, Type = Double, Dynamic = False, Default = \"1.0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events EntryAddButton
	#tag Event
		Sub Pressed()
		  Var Set As Ark.MutableSpawnPointSet = Self.SpawnSet
		  Var Entry As Ark.MutableSpawnPointSetEntry = ArkSpawnPointCreatureDialog.Present(Self, Self.Project, Set)
		  If Entry = Nil Then
		    Return
		  End If
		  
		  Set.Append(Entry)
		  
		  Var Entries(0) As Ark.MutableSpawnPointSetEntry
		  Entries(0) = Entry
		  Self.UpdateEntriesList(Set, Entries)
		  Self.EntriesList.EnsureSelectionIsVisible()
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntryEditButton
	#tag Event
		Sub Pressed()
		  Self.EntriesList.DoEdit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntryDeleteButton
	#tag Event
		Sub Pressed()
		  Self.EntriesList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntriesList
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kEntryClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("""Type"": ""SpawnPointSetEntry""") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Bound As Integer = Me.RowCount - 1
		  Var EntriesToDelete() As Ark.SpawnPointSetEntry
		  For I As Integer = 0 To Bound
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Var Entry As Ark.SpawnPointSetEntry = Me.RowTagAt(I)
		    EntriesToDelete.Add(Entry)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(EntriesToDelete, "creature", "creatures") = False Then
		    Return
		  End If
		  
		  Var Set As Ark.MutableSpawnPointSet = Self.SpawnSet
		  Var Changed As Boolean
		  For Each Entry As Ark.SpawnPointSetEntry In EntriesToDelete
		    Var Idx As Integer = Set.IndexOf(Entry)
		    If Idx > -1 Then
		      Set.Remove(Idx)
		      Changed = True
		    End If
		  Next
		  
		  If Changed Then
		    RaiseEvent Changed
		    Self.UpdateEntriesList(Set)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.RowSelectedAt(I) Then
		      Items.Add(Ark.SpawnPointSetEntry(Me.RowTagAt(I)).SaveData)
		    End If
		  Next
		  
		  Var JSON As String = Beacon.GenerateJSON(Items, True)
		  Board.Text = JSON.Trim
		  Board.RawData(Self.kEntryClipboardType) = JSON
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Me.CanPaste Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Items() As Variant
		  Try
		    If Board.RawDataAvailable(Self.kEntryClipboardType) Then
		      Items = Beacon.ParseJSON(Board.RawData(Self.kEntryClipboardType))
		    Else
		      Items = Beacon.ParseJSON(Board.Text)
		    End If
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Set As Ark.MutableSpawnPointSet = Self.SpawnSet
		  Var SelectEntries() As Ark.SpawnPointSetEntry
		  For Each Item As Dictionary In Items
		    Var Entry As Ark.SpawnPointSetEntry = Ark.SpawnPointSetEntry.FromSaveData(Item)
		    If Entry = Nil Then
		      Continue
		    End If
		    
		    Set.Append(Entry)
		    SelectEntries.Add(Entry)
		  Next
		  
		  Self.UpdateEntriesList(Set, SelectEntries)
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.EntryDeleteButton.Enabled = Me.CanDelete
		  Self.EntryEditButton.Enabled = Me.CanEdit
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var Entries() As Ark.MutableSpawnPointSetEntry
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Entries.Add(Me.RowTagAt(I))
		  Next
		  
		  Var Set As Ark.MutableSpawnPointSet = Self.SpawnSet
		  Var UpdatedEntries() As Ark.MutableSpawnPointSetEntry = ArkSpawnPointCreatureDialog.Present(Self, Self.Project, Set, Entries)
		  If UpdatedEntries = Nil Or UpdatedEntries.LastIndex = -1 Then
		    Return
		  End If
		  
		  For Each Entry As Ark.MutableSpawnPointSetEntry In Entries
		    Set.Remove(Entry)
		  Next
		  For Each Entry As Ark.MutableSpawnPointSetEntry In UpdatedEntries
		    Set.Append(Entry)
		  Next
		  
		  Self.UpdateEntriesList(Set, UpdatedEntries)
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  #Pragma Unused Column
		  
		  Var Entry1 As Ark.SpawnPointSetEntry = Me.RowTagAt(Row1)
		  Var Entry2 As Ark.SpawnPointSetEntry = Me.RowTagAt(Row2)
		  If Entry1 Is Nil Or Entry2 Is Nil Then
		    Return False
		  End If
		  
		  Result = Entry1.SortValue.Compare(Entry2.SortValue)
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceAddButton
	#tag Event
		Sub Pressed()
		  Var Set As Ark.MutableSpawnPointSet = Self.SpawnSet
		  
		  Var Creature As Ark.Creature = ArkSpawnPointReplacementsDialog.Present(Self, Self.Project.ContentPacks, Set)
		  If Creature = Nil Then
		    Return
		  End If
		  
		  Var Creatures(0) As Ark.Creature
		  Creatures(0) = Creature
		  Self.UpdateReplacementsList(Set, Creatures)
		  Self.ReplaceList.EnsureSelectionIsVisible
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceEditButton
	#tag Event
		Sub Pressed()
		  Self.ReplaceList.DoEdit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceDeleteButton
	#tag Event
		Sub Pressed()
		  Self.ReplaceList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplaceList
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kReplacementClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("""Replacements"": {") > -1 And Board.Text.IndexOf("""Creature"": """) > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.ReplaceDeleteButton.Enabled = Me.CanDelete
		  Self.ReplaceEditButton.Enabled = Me.CanEdit
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Bound As Integer = Me.RowCount - 1
		  Var CreaturesToDelete() As Ark.Creature
		  For I As Integer = Bound DownTo 0
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Var Creature As Ark.Creature
		    Try
		      Creature = Ark.DataSource.Pool.Get(False).GetCreatureByUUID(Me.RowTagAt(I))
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Creature UUID: " + Me.RowTagAt(I).StringValue)
		    End Try
		    If Creature Is Nil Then
		      Continue
		    End If
		    
		    CreaturesToDelete.Add(Creature)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(CreaturesToDelete, "creature replacement", "creature replacements") = False Then
		    Return
		  End If
		  
		  Var Set As Ark.MutableSpawnPointSet = Self.SpawnSet
		  Var Changed As Boolean
		  For Each FromCreature As Ark.Creature In CreaturesToDelete
		    Var Replacements() As Ark.Creature = Set.ReplacementCreatures(FromCreature)
		    For Each ToCreature As Ark.Creature In Replacements
		      If Set.CreatureReplacementWeight(FromCreature, ToCreature) <> Nil Then
		        Set.CreatureReplacementWeight(FromCreature, ToCreature) = Nil
		        Changed = True
		      End If
		    Next
		  Next
		  
		  If Changed Then
		    RaiseEvent Changed
		    Self.UpdateReplacementsList(Set)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items() As Dictionary
		  Var Set As Ark.SpawnPointSet = Self.SpawnSet
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var FromUUID As String = Me.RowTagAt(I)
		    Var FromCreature As Ark.Creature = Ark.DataSource.Pool.Get(False).GetCreatureByUUID(FromUUID)
		    If FromCreature Is Nil Then
		      Continue
		    End If
		    
		    Var Replacements() As Ark.Creature = Set.ReplacementCreatures(FromCreature)
		    Var Map As New Dictionary
		    For Each ToCreature As Ark.Creature In Replacements
		      Var Weight As NullableDouble = Set.CreatureReplacementWeight(FromCreature, ToCreature)
		      If (Weight Is Nil) = False Then
		        Map.Value(ToCreature.ObjectID) = Weight.DoubleValue
		      End If
		    Next
		    
		    Var Dict As New Dictionary
		    Dict.Value("Creature") = FromCreature.ObjectID
		    Dict.Value("Replacements") = Map
		    Items.Add(Dict)
		  Next
		  
		  Var JSON As String = Beacon.GenerateJSON(Items, True)
		  Board.Text = JSON.Trim
		  Board.RawData(Self.kReplacementClipboardType) = JSON
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Me.CanPaste Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Items() As Variant
		  Try
		    If Board.RawDataAvailable(Self.kReplacementClipboardType) Then
		      Items = Beacon.ParseJSON(Board.RawData(Self.kReplacementClipboardType))
		    Else
		      Items = Beacon.ParseJSON(Board.Text)
		    End If
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Set As Ark.MutableSpawnPointSet = Self.SpawnSet
		  Var SelectCreatures() As Ark.Creature
		  For Each Item As Dictionary In Items
		    Try
		      If Item.HasKey("Creature") = False Or Item.HasKey("Replacements") = False Then
		        Continue
		      End If
		      
		      Var FromUUID As String = Item.Value("Creature")
		      Var FromCreature As Ark.Creature = Ark.DataSource.Pool.Get(False).GetCreatureByUUID(FromUUID)
		      If FromCreature Is Nil Then
		        Continue
		      End If
		      
		      Var Map As Dictionary = Item.Value("Replacements")
		      For Each Entry As DictionaryEntry In Map
		        Var ToUUID As String = Entry.Key
		        Var ToCreature As Ark.Creature = Ark.DataSource.Pool.Get(False).GetCreatureByUUID(ToUUID)
		        If ToCreature Is Nil Then
		          Continue
		        End If
		        Var Weight As Double = Entry.Value
		        Set.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		      Next Entry
		      
		      SelectCreatures.Add(FromCreature)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Pasting spawn set replacement")
		    End Try
		  Next Item
		  
		  Self.UpdateReplacementsList(Set, SelectCreatures)
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var TargetUUID As String = Self.ReplaceList.RowTagAt(Self.ReplaceList.SelectedRowIndex)
		  Var TargetCreature As Ark.Creature = Ark.DataSource.Pool.Get(False).GetCreatureByUUID(TargetUUID)
		  If TargetCreature Is Nil Then
		    Return
		  End If
		  
		  Var Creature As Ark.Creature = ArkSpawnPointReplacementsDialog.Present(Self, Self.Project.ContentPacks, Self.SpawnSet, TargetCreature)
		  If Creature <> Nil Then
		    Var Creatures(0) As Ark.Creature
		    Creatures(0) = Creature
		    Self.UpdateReplacementsList(Self.SpawnSet, Creatures)
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Self.SpawnSet.Label = Me.Text
		  If Self.SpawnSet.Modified Then
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightField
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Value As Double = Me.DoubleValue
		  If Value = 0 Then
		    Return
		  End If
		  
		  Self.SpawnSet.Weight = Value
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightStepper
	#tag Event
		Sub DownPressed()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue - (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpPressed()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue + (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WaterMinHeightField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Text = "" Then
		    Self.SpawnSet.WaterOnlyMinimumHeight = Nil
		  Else
		    Self.SpawnSet.WaterOnlyMinimumHeight = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SpreadRadiusField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Text = "" Then
		    Self.SpawnSet.SpreadRadius = Nil
		  Else
		    Self.SpawnSet.SpreadRadius = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TameDistanceField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Text = "" Then
		    Self.SpawnSet.MinDistanceFromTamedDinosMultiplier = Nil
		  Else
		    Self.SpawnSet.MinDistanceFromTamedDinosMultiplier = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events StructureDistanceField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Text = "" Then
		    Self.SpawnSet.MinDistanceFromStructuresMultiplier = Nil
		  Else
		    Self.SpawnSet.MinDistanceFromStructuresMultiplier = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events PlayerDistanceField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  If Me.Text = "" Then
		    Self.SpawnSet.MinDistanceFromPlayersMultiplier = Nil
		  Else
		    Self.SpawnSet.MinDistanceFromPlayersMultiplier = Me.DoubleValue
		  End If
		  
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events OffsetFields
	#tag Event
		Sub GetRange(index as Integer, ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(index as Integer, DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged(index as Integer)
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Var Offset As Beacon.Point3D
		  If OffsetFields(0).Text = "" Or OffsetFields(1).Text = "" Or OffsetFields(2).Text = "" Then
		    Offset = Nil
		  Else
		    Offset = New Beacon.Point3D(OffsetFields(0).DoubleValue, OffsetFields(1).DoubleValue, OffsetFields(2).DoubleValue)
		  End If
		  
		  If Self.SpawnSet.GroupOffset <> Offset Then
		    Self.SpawnSet.GroupOffset = Offset
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(index as Integer, Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events OffsetBeforeMultiplierCheck
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Self.SpawnSet.LevelOffsetBeforeMultiplier = Me.Value
		  Self.UpdateEntriesList(Self.SpawnSet)
		  If Self.SpawnSet.Modified Then
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ColorSetsMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Self.SpawnSet.ColorSetClass = Me.SelectedRowTag
		  RaiseEvent Changed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SpawnSetToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("SetTitle", "Spawn Set Contents"))
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
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
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
#tag EndViewBehavior
