#tag Window
Begin BeaconContainer SpawnPointSetEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   678
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
   Begin GroupBox EntriesGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Creatures"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   336
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
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   428
      Begin BeaconListbox EntriesList
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
         Height          =   248
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
         RequiresSelection=   False
         RowSelectionType=   "0"
         Scope           =   2
         SelectionChangeBlocked=   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   98
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   388
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   358
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   358
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   358
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin GroupBox ReplaceGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Creature Replacement"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   336
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
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   304
      Begin BeaconListbox ReplaceList
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
         Height          =   248
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
         RequiresSelection=   False
         RowSelectionType=   "0"
         Scope           =   2
         SelectionChangeBlocked=   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   98
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   264
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   358
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   358
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   358
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin UITweaks.ResizedTextField NameField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
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
      DataField       =   ""
      DataSource      =   ""
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
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   "500"
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel NameLabel
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Name:"
      Visible         =   True
      Width           =   71
   End
   Begin UITweaks.ResizedLabel WeightLabel
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
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Weight:"
      Visible         =   True
      Width           =   71
   End
   Begin UpDownArrows WeightStepper
      AllowAutoDeactivate=   True
      AllowFocus      =   False
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
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   13
   End
   Begin GroupBox AdvancedGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Advanced (Optional)"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   248
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
      Top             =   410
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   744
      Begin UITweaks.ResizedLabel WaterMinHeightLabel
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
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   616
         Transparent     =   False
         Underline       =   False
         Value           =   "(Water Only) Min Height:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel SpreadRadiusLabel
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
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   582
         Transparent     =   False
         Underline       =   False
         Value           =   "Spread Radius:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel TameDistanceLabel
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
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   548
         Transparent     =   False
         Underline       =   False
         Value           =   "Distance from Tames Multiplier:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel StructureDistanceLabel
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
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   514
         Transparent     =   False
         Underline       =   False
         Value           =   "Distance from Structures Multiplier:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel PlayerDistanceLabel
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
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   480
         Transparent     =   False
         Underline       =   False
         Value           =   "Distance from Players Multiplier:"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedLabel OffsetLabel
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
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   446
         Transparent     =   False
         Underline       =   False
         Value           =   "Offset (X, Y, Z):"
         Visible         =   True
         Width           =   228
      End
      Begin UITweaks.ResizedTextField WaterMinHeightField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   280
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   616
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField SpreadRadiusField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   280
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   582
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField TameDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   280
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   548
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField StructureDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   280
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   514
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField PlayerDistanceField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   280
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   480
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField OffsetZField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   464
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   446
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField OffsetYField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   372
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   446
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField OffsetXField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   280
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   446
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function SpawnSet() As Beacon.MutableSpawnPointSet
		  If Self.mRef <> Nil And Self.mRef.Value <> Nil Then
		    Return Beacon.MutableSpawnPointSet(Self.mRef.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnSet(Assigns Set As Beacon.MutableSpawnPointSet)
		  If Set = Self.SpawnSet Then
		    Return
		  End If
		  
		  If Set = Nil Then
		    Self.mRef = Nil
		    Self.UpdateUI(New Beacon.MutableSpawnPointSet)
		    Return
		  End If
		  
		  Self.mRef = New WeakRef(Set)
		  Self.UpdateUI(Set)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI(Set As Beacon.SpawnPointSet)
		  Self.mSettingUp = True
		  
		  Self.NameField.Value = Set.Label
		  Self.WeightField.Value = Set.Weight.PrettyText
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = MinimumWidth, Type = Double, Dynamic = False, Default = \"660", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WeightScale, Type = Double, Dynamic = False, Default = \"1000", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Self.SpawnSet.Label = Me.Value
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
		Sub TextChange()
		  If Self.mSettingUp Or Self.SpawnSet = Nil Then
		    Return
		  End If
		  
		  Dim Value As Double = Me.DoubleValue
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
		Sub Down()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue - (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue + (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Type="Color"
		EditorType="Color"
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
		Name="EraseBackground"
		Visible=false
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
