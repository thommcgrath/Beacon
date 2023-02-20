#tag DesktopWindow
Begin ArkConfigEditor ArkSpoilTimersEditor
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
   Height          =   535
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
   Width           =   969
   Begin OmniBar ConfigToolbar
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   969
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   494
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   969
      Begin DesktopGroupBox DecayPreviewGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Times"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   269
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   430
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   246
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   519
         Begin BeaconListbox DecayPreviewList
            AllowAutoDeactivate=   True
            AllowAutoHideScrollbars=   True
            AllowExpandableRows=   False
            AllowFocusRing  =   True
            AllowInfiniteScroll=   False
            AllowResizableColumns=   False
            AllowRowDragging=   False
            AllowRowReordering=   False
            Bold            =   False
            ColumnCount     =   5
            ColumnWidths    =   ""
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
            Height          =   185
            Index           =   -2147483648
            InitialParent   =   "DecayPreviewGroup"
            InitialValue    =   "Class	PvE Decay Time	PvE Destroy Time	PvP Decay Time	PvP Destroy Time"
            Italic          =   False
            Left            =   450
            LockBottom      =   True
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            PreferencesKey  =   ""
            RequiresSelection=   False
            RowSelectionType=   0
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   False
            Tooltip         =   ""
            Top             =   282
            Transparent     =   False
            TypeaheadColumn =   0
            Underline       =   False
            Visible         =   True
            VisibleRowCount =   0
            Width           =   479
            _ScrollOffset   =   0
            _ScrollWidth    =   -1
         End
         Begin DesktopLabel DestroyWarningLabel
            AllowAutoDeactivate=   True
            Bold            =   True
            Enabled         =   True
            FontName        =   "SmallSystem"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "DecayPreviewGroup"
            Italic          =   False
            Left            =   478
            LockBottom      =   True
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   False
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Your structures will destroy before they finish decaying."
            TextAlignment   =   0
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   479
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   451
         End
         Begin IconCanvas DestroyWarningIcon
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Clickable       =   False
            ContentHeight   =   0
            Enabled         =   True
            Height          =   16
            Icon            =   52676607
            IconColor       =   9
            Index           =   -2147483648
            InitialParent   =   "DecayPreviewGroup"
            Left            =   450
            LockBottom      =   True
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   False
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   2
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   479
            Transparent     =   True
            Visible         =   True
            Width           =   16
         End
      End
      Begin DesktopGroupBox DecayGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Decay"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   454
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   398
         Begin UITweaks.ResizedLabel PvEDinoDecayMultiplierLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabIndex        =   11
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Creature Decay Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipDinoDecayMultiplier"
            Top             =   259
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin UITweaks.ResizedLabel PvEStructureDecayMultiplierLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabIndex        =   9
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Structure Decay Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipStructureDecayMultiplier"
            Top             =   225
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin SwitchControl PvEStructureDecaySwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   3
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipStructureDecay"
            Top             =   129
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl PvEDinoDecaySwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   6
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipDinoDecay"
            Top             =   161
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin DesktopLabel PvEStructureDecayLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabIndex        =   2
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Enable Structure Decay:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipStructureDecay"
            Top             =   129
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin DesktopLabel PvEDinoDecayLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabIndex        =   5
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Enable Creature Decay:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipDinoDecay"
            Top             =   161
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin DesktopLabel PvEDecayLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Italic          =   False
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "PvE"
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   97
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl PvPDinoDecaySwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Left            =   358
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   7
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipDinoDecay"
            Top             =   161
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl PvPStructureDecaySwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Left            =   358
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   4
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipStructureDecay"
            Top             =   129
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin DesktopLabel PvPDecayLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Italic          =   False
            Left            =   358
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "PvP"
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   97
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   40
         End
         Begin UITweaks.ResizedTextField PvEStructureDecayMultiplierField
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
            InitialParent   =   "DecayGroup"
            Italic          =   False
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   0
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   10
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipStructureDecayMultiplier"
            Top             =   225
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   92
         End
         Begin UITweaks.ResizedTextField PvEDinoDecayMultiplierField
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
            InitialParent   =   "DecayGroup"
            Italic          =   False
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   0
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   12
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipDinoDecayMultiplier"
            Top             =   259
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   92
         End
         Begin UITweaks.ResizedTextField CropDecaySpeedMultiplierField
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
            InitialParent   =   "DecayGroup"
            Italic          =   False
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   0
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   14
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipCropDecayMultiplier"
            Top             =   293
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   92
         End
         Begin UITweaks.ResizedLabel CropDecaySpeedMultiplierLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabIndex        =   13
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Crop Decay Speed Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipCropDecayMultiplier"
            Top             =   293
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin SwitchControl FastDecayUnsnappedCoreStructuresSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   18
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipFastDecayUnsnapped"
            Top             =   359
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl OnlyDecayUnsnappedCoreStructuresSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   16
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipOnlyDecayUnsnapped"
            Top             =   327
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin IntervalField FastDecayPeriodField
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
            InitialParent   =   "DecayGroup"
            Italic          =   False
            Left            =   306
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   0
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   20
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipFastDecayPeriod"
            Top             =   391
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   92
         End
         Begin UITweaks.ResizedLabel FastDecayPeriodLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Fast Decay Period:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipFastDecayPeriod"
            Top             =   391
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin DesktopLabel FastDecayUnsnappedCoreStructuresLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabIndex        =   17
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Fast Decay Unsnapped Core Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipFastDecayUnsnapped"
            Top             =   359
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin DesktopLabel OnlyDecayUnsnappedCoreStructuresLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
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
            TabIndex        =   15
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Only Decay Unsnapped Core Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipOnlyDecayUnsnapped"
            Top             =   327
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin DesktopSeparator Separator1
            Active          =   False
            AllowAutoDeactivate=   True
            AllowTabStop    =   True
            Enabled         =   True
            Height          =   4
            Index           =   -2147483648
            InitialParent   =   "DecayGroup"
            Left            =   40
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            PanelIndex      =   0
            Scope           =   2
            TabIndex        =   8
            TabPanelIndex   =   1
            Tooltip         =   ""
            Top             =   201
            Transparent     =   False
            Visible         =   True
            Width           =   358
            _mIndex         =   0
            _mInitialParent =   ""
            _mName          =   ""
            _mPanelIndex    =   0
         End
      End
      Begin UITweaks.ResizedTextField SpoilTimeMultiplierField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   281
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipSpoilTimeMultiplier"
         Top             =   61
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   92
      End
      Begin DesktopLabel SpoilTimeMultiplierLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Spoil Time Multiplier:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipSpoilTimeMultiplier"
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   249
      End
      Begin BeaconListbox SpoilTimesList
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
         Height          =   312
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Item"
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
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   False
         Tooltip         =   ""
         Top             =   203
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   929
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedTextField CorpseDecomposeMultiplierField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   281
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipCorpseDecomposeTimeMultiplier"
         Top             =   95
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   92
      End
      Begin UITweaks.ResizedTextField ItemDecomposeMultiplierField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   281
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipItemDecomposeTimeMultiplier"
         Top             =   129
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   92
      End
      Begin DesktopLabel CorpseDecomposeMultiplierLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Corpse Decomposition Time Multiplier:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipCorpseDecomposeTimeMultiplier"
         Top             =   95
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   249
      End
      Begin DesktopLabel ItemDecomposeMultiplierLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Item Decomposition Time Multiplier:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipItemDecomposeTimeMultiplier"
         Top             =   129
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   249
      End
      Begin IntervalField CorpseDecomposePreviewField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   385
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipCorpseDecomposeTimeMultiplier"
         Top             =   95
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   92
      End
      Begin IntervalField ItemDecomposePreviewField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   385
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipItemDecomposeTimeMultiplier"
         Top             =   129
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   92
      End
      Begin DesktopLabel ClampSpoilTimesLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Clamp Item Spoil Times:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   "#TooltipClampItemSpoilTimes"
         Top             =   163
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   249
      End
      Begin SwitchControl ClampSpoilTimesSwitch
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   281
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   "#TooltipClampItemSpoilTimes"
         Top             =   163
         Transparent     =   True
         Visible         =   True
         Width           =   40
      End
      Begin DesktopGroupBox AutoDestroyGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Auto Destroy"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   173
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   430
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   398
         Begin UITweaks.ResizedTextField AutoDestroyPeriodMultiplierField
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
            InitialParent   =   "AutoDestroyGroup"
            Italic          =   False
            Left            =   689
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
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipAutoDestroyStructuresMultiplier"
            Top             =   128
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   92
         End
         Begin UITweaks.ResizedLabel AutoDestroyPeriodMultiplierLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "AutoDestroyGroup"
            Italic          =   False
            Left            =   450
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
            Text            =   "Auto Destroy Structures Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipAutoDestroyStructuresMultiplier"
            Top             =   129
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   227
         End
         Begin DesktopLabel AutoDestroyStructuresLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "AutoDestroyGroup"
            Italic          =   False
            Left            =   450
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Auto Destroy Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipAutoDestroyStructures"
            Top             =   97
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   227
         End
         Begin DesktopLabel OnlyDestroyCoreStructuresLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "AutoDestroyGroup"
            Italic          =   False
            Left            =   450
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
            Text            =   "Only Auto Destroy Core Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipOnlyAutoDestroyCoreStructures"
            Top             =   163
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   227
         End
         Begin DesktopLabel AutoDestroyDinosLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "AutoDestroyGroup"
            Italic          =   False
            Left            =   450
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
            Text            =   "Auto Destroy Creatures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   "#TooltipAutoDestroyCreatures"
            Top             =   195
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   227
         End
         Begin SwitchControl AutoDestroyStructuresSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "AutoDestroyGroup"
            Left            =   689
            LockBottom      =   False
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
            Tooltip         =   "#TooltipAutoDestroyStructures"
            Top             =   96
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl OnlyDestroyCoreStructuresSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "AutoDestroyGroup"
            Left            =   689
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   5
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipOnlyAutoDestroyCoreStructures"
            Top             =   162
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl AutoDestroyDinosSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "AutoDestroyGroup"
            Left            =   689
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            ScrollActive    =   False
            ScrollingEnabled=   False
            ScrollSpeed     =   20
            TabIndex        =   7
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   "#TooltipAutoDestroyCreatures"
            Top             =   194
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.mScorchedSpoilMultiplier = Ark.DataSource.Pool.Get(False).GetDoubleVariable("Scorched Spoil Multiplier", 0.9)
		  Self.mDecayPeriods = New Dictionary
		  Self.mSpoilMultipliers = New Dictionary
		  Self.mSpoilTimes = New Dictionary
		  
		  Try
		    Var JSON As String = Ark.DataSource.Pool.Get(False).GetStringVariable("Decay Periods")
		    If JSON.IsEmpty = False Then
		      Self.mDecayPeriods = Beacon.ParseJSON(JSON)
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Var JSON As String = Ark.DataSource.Pool.Get(False).GetStringVariable("Spoil Multipliers")
		    If JSON.IsEmpty = False Then
		      Self.mSpoilMultipliers = Beacon.ParseJSON(JSON)
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Var JSON As String = Ark.DataSource.Pool.Get(False).GetStringVariable("Spoil Times")
		    If JSON.IsEmpty = False Then
		      Self.mSpoilTimes = Beacon.ParseJSON(JSON)
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.SpoilTimesList.ColumnCount = Self.mSpoilMultipliers.KeyCount + 1
		  
		  Var ColumnIndex As Integer = 1
		  For Each Entry As DictionaryEntry In Self.mSpoilMultipliers
		    Var HeaderName As String = Entry.Key
		    Self.SpoilTimesList.HeaderAt(ColumnIndex) = HeaderName
		    Self.SpoilTimesList.ColumnAttributesAt(ColumnIndex).WidthExpression = "100"
		    ColumnIndex = ColumnIndex + 1
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Const MaxContentWidth = 1200
		  Const LeftColumnMinWidth = 398
		  Const RightColumnMinWidth = 519
		  
		  Var ContentWidth As Integer = Min(Self.Width - 40, MaxContentWidth)
		  Var ContentLeft As Integer = (Self.Width - ContentWidth) / 2
		  
		  Var AvailableWidth As Integer = Max(ContentWidth - 12, LeftColumnMinWidth + RightColumnMinWidth)
		  Var LeftColumnWidth As Integer = LeftColumnMinWidth//Max(AvailableWidth * (LeftColumnMinWidth / (LeftColumnMinWidth + RightColumnMinWidth)), LeftColumnMinWidth)
		  Var RightColumnWidth As Integer = AvailableWidth - LeftColumnWidth
		  
		  Self.DecayGroup.Left = ContentLeft
		  Self.DecayGroup.Width = LeftColumnWidth
		  Self.AutoDestroyGroup.Left = Self.DecayGroup.Left + Self.DecayGroup.Width + 12
		  Self.AutoDestroyGroup.Width = RightColumnWidth
		  Self.DecayPreviewGroup.Left = Self.AutoDestroyGroup.Left
		  Self.DecayPreviewGroup.Width = Self.AutoDestroyGroup.Width
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(False)
		  
		  Self.PvEDinoDecaySwitch.Value(False) = Not Config.DisableDinoDecayPvE
		  Self.PvEStructureDecaySwitch.Value(False) = Not Config.DisableStructureDecayPvE
		  Self.PvPDinoDecaySwitch.Value(False) = Config.PvPDinoDecay
		  Self.PvPStructureDecaySwitch.Value(False) = Config.PvPStructureDecay
		  Self.PvEStructureDecayMultiplierField.Text = Config.PvEStructureDecayPeriodMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.PvEDinoDecayMultiplierField.Text = Config.PvEDinoDecayPeriodMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.AutoDestroyStructuresSwitch.Value(False) = Config.AutoDestroyStructures
		  Self.AutoDestroyDinosSwitch.Value(False) = Config.AutoDestroyDecayedDinos
		  Self.FastDecayPeriodField.Text = Beacon.SecondsToString(Config.FastDecayInterval)
		  Self.AutoDestroyPeriodMultiplierField.Text = Config.AutoDestroyOldStructuresMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.OnlyDecayUnsnappedCoreStructuresSwitch.Value(False) = Config.OnlyDecayUnsnappedCoreStructures
		  Self.OnlyDestroyCoreStructuresSwitch.Value(False) = Config.OnlyAutoDestroyCoreStructures
		  Self.FastDecayUnsnappedCoreStructuresSwitch.Value(False) = Config.FastDecayUnsnappedCoreStructures
		  Self.CropDecaySpeedMultiplierField.Text = Config.CropDecaySpeedMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.SpoilTimeMultiplierField.Text = Config.GlobalSpoilingTimeMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.ClampSpoilTimesSwitch.Value(False) = Config.ClampItemSpoilingTimes
		  Self.CorpseDecomposeMultiplierField.Text = Config.GlobalCorpseDecompositionTimeMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.ItemDecomposeMultiplierField.Text = Config.GlobalItemDecompositionTimeMultiplier.ToString(Locale.Current, "0.0#####")
		  
		  Self.PvEDinoDecaySwitch.Enabled = Not Self.PvPDinoDecaySwitch.Value
		  Self.PvEStructureDecaySwitch.Enabled = Not Self.PvEStructureDecaySwitch.Value
		  
		  Self.UpdateFigures()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As Ark.Configs.SpoilTimers
		  Return Ark.Configs.SpoilTimers(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameSpoilTimers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateDecayFigures()
		  Var SelectedKeys() As String
		  For Idx As Integer = 0 To Self.DecayPreviewList.LastRowIndex
		    If Self.DecayPreviewList.RowSelectedAt(Idx) Then
		      SelectedKeys.Add(Self.DecayPreviewList.CellTextAt(Idx, 0))
		    End If
		  Next
		  
		  Self.DecayPreviewList.RemoveAllRows
		  
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(False)
		  For Each Entry As DictionaryEntry In Self.mDecayPeriods
		    Var Key As String = Entry.Key
		    
		    Var PvEDecayString As String = "N/A"
		    Var PvEDestroyString As String = "N/A"
		    Var PvPDecayString As String = "N/A"
		    Var PvPDestroyString As String = "N/A"
		    
		    Var PvEDecayPeriod As Integer = 0
		    Var PvEDestroyPeriod As Integer = 0
		    Var PvPDecayPeriod As Integer = 0
		    Var PvPDestroyPeriod As Integer = 0
		    
		    If Key = "Creatures" Then
		      If Config.DisableDinoDecayPvE = False Then
		        PvEDecayPeriod = Entry.Value * Config.PvEDinoDecayPeriodMultiplier
		        PvEDecayString = Beacon.SecondsToString(PvEDecayPeriod)
		        
		        If Config.AutoDestroyDecayedDinos Then
		          PvEDestroyString = PvEDecayString
		          PvEDestroyPeriod = PvEDecayPeriod
		        End If
		      End If
		      
		      If Config.PvPDinoDecay Then
		        PvPDecayPeriod = Entry.Value * Config.PvEDinoDecayPeriodMultiplier
		        PvPDecayString = Beacon.SecondsToString(PvPDecayPeriod)
		        
		        If Config.AutoDestroyDecayedDinos Then
		          PvPDestroyString = PvPDecayString
		          PvPDestroyPeriod = PvPDecayPeriod
		        End If
		      End If
		    Else
		      If Config.DisableStructureDecayPvE = False Then
		        PvEDecayPeriod = Entry.Value * Config.PvEStructureDecayPeriodMultiplier
		        PvEDecayString = Beacon.SecondsToString(PvEDecayPeriod)
		        
		        If Config.AutoDestroyStructures Then
		          PvEDestroyPeriod = Entry.Value * Config.AutoDestroyOldStructuresMultiplier
		          PvEDestroyString = Beacon.SecondsToString(PvEDestroyPeriod)
		        End If
		      End If
		      
		      If Config.PvPStructureDecay Then
		        PvPDecayPeriod = Entry.Value * Config.PvEStructureDecayPeriodMultiplier
		        PvPDecayString = Beacon.SecondsToString(PvPDecayPeriod)
		        
		        If Config.AutoDestroyStructures Then
		          PvPDestroyPeriod = Entry.Value * Config.AutoDestroyOldStructuresMultiplier
		          PvPDestroyString = Beacon.SecondsToString(PvPDestroyPeriod)
		        End If
		      End If
		    End If
		    
		    Self.DecayPreviewList.AddRow(Key, PvEDecayString, PvEDestroyString, PvPDecayString, PvPDestroyString)
		    Var RowIdx As Integer = Self.DecayPreviewList.LastAddedRowIndex
		    Self.DecayPreviewList.RowSelectedAt(RowIdx) = SelectedKeys.IndexOf(Key) > -1
		    
		    Self.DecayPreviewList.CellTagAt(RowIdx, 1) = PvEDecayPeriod
		    Self.DecayPreviewList.CellTagAt(RowIdx, 2) = PvEDestroyPeriod
		    Self.DecayPreviewList.CellTagAt(RowIdx, 3) = PvPDecayPeriod
		    Self.DecayPreviewList.CellTagAt(RowIdx, 4) = PvPDestroyPeriod
		  Next
		  
		  Var ShowDestroyWarning As Boolean = Config.AutoDestroyStructures And Config.PvEStructureDecayPeriodMultiplier > Config.AutoDestroyOldStructuresMultiplier
		  If ShowDestroyWarning = True And Self.DestroyWarningLabel.Visible = False Then
		    Self.DecayPreviewList.Height = (Self.DestroyWarningLabel.Top - 12) - Self.DecayPreviewList.Top
		    Self.DestroyWarningLabel.Visible = True
		    Self.DestroyWarningIcon.Visible = True
		  ElseIf ShowDestroyWarning = False And Self.DestroyWarningLabel.Visible = True Then
		    Self.DecayPreviewList.Height = (Self.DestroyWarningLabel.Top + Self.DestroyWarningLabel.Height) - Self.DecayPreviewList.Top
		    Self.DestroyWarningLabel.Visible = False
		    Self.DestroyWarningIcon.Visible = False
		  End If
		  
		  Self.DecayPreviewList.Sort
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFigures()
		  Self.UpdateDecayFigures()
		  Self.UpdateSpoilFigures()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSpoilFigures()
		  Var List As BeaconListbox = Self.SpoilTimesList
		  
		  Var SelectedNames() As String
		  For Idx As Integer = 0 To List.LastRowIndex
		    If List.RowSelectedAt(Idx) Then
		      SelectedNames.Add(List.CellTextAt(Idx, 0))
		    End If
		  Next
		  
		  List.RemoveAllRows()
		  
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(False)
		  For Each TimeEntry As DictionaryEntry In Self.mSpoilTimes
		    Var Name As String = TimeEntry.Key
		    Var BasePeriod As Integer = Round(TimeEntry.Value * Config.GlobalSpoilingTimeMultiplier)
		    Var Keys() As Variant = Self.mSpoilMultipliers.Keys
		    
		    List.AddRow(Name)
		    Var RowIndex As Integer = List.LastAddedRowIndex
		    
		    For Idx As Integer = 0 To Keys.LastIndex
		      Var Multiplier As Double = Self.mSpoilMultipliers.Value(Keys(Idx))
		      Var ColumnIndex As Integer = Idx + 1
		      
		      List.CellTextAt(RowIndex, ColumnIndex) = Beacon.SecondsToString(BasePeriod * Multiplier)
		      List.CellTagAt(RowIndex, ColumnIndex) = BasePeriod * Multiplier
		      List.RowSelectedAt(List.LastAddedRowIndex) = SelectedNames.IndexOf(Name) > -1
		    Next
		  Next
		  
		  List.Sort
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecayPeriods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScorchedSpoilMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpoilMultipliers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpoilTimes As Dictionary
	#tag EndProperty


	#tag Constant, Name = PageDecay, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSpoil, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipAutoDestroyCreatures, Type = String, Dynamic = False, Default = \"When turned on\x2C creatures will be destroyed upon server reset once their decay timer ends.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipAutoDestroyStructures, Type = String, Dynamic = False, Default = \"When turned on\x2C structures will be destroyed upon server reset once their decay timer ends.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipAutoDestroyStructuresMultiplier, Type = String, Dynamic = False, Default = \"At 1.0\x2C structures will be automatically destroyed (if Auto Destroy Structures is turned on) upon server reset once their decay timer ends. Values lower than 1.0 will cause structures to be destroyed before their decay period has elapsed. Values higher than 1.0 will cause structures to be destroyed some time after their decay period has elapsed.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipClampItemSpoilTimes, Type = String, Dynamic = False, Default = \"Will clamp all spoiling times to the items\' maximum spoiling times. Could potentially cause issues with mods that alter spoiling time.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipCorpseDecomposeTimeMultiplier, Type = String, Dynamic = False, Default = \"Adjusts the time required for bodies of players and creatures to be removed from the game world. Values higher than 1.0 will increase the time.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipCropDecayMultiplier, Type = String, Dynamic = False, Default = \"Adjust the rate at which crops decay without fertilizer. Higher values will increase the rate\x2C meaning crops will die faster. Lower values will decrease the rate\x2C meaning crops will last longer without fertilizer.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipDinoDecay, Type = String, Dynamic = False, Default = \"When turned on\x2C creatures decay whenever a member of their tribe is not nearby. Decayed creatures become unclaimed and may be claimed by any player.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipDinoDecayMultiplier, Type = String, Dynamic = False, Default = \"Adjusts the time it takes for creatures decay. Higher values will increase the decay time\x2C while lower values will decrease the decay time.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipFastDecayPeriod, Type = String, Dynamic = False, Default = \"Adjusts the amount of time it takes for structures affected by fast decay to decay.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipFastDecayUnsnapped, Type = String, Dynamic = False, Default = \"When turned on\x2C core structures (such as foundations and pillars) that are not attached to anything will decay according to the Fast Decay Period setting.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipItemDecomposeTimeMultiplier, Type = String, Dynamic = False, Default = \"Adjusts the time required for loot bags and dropped items to be removed from the game world. Values higher than 1.0 will increase the time.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipOnlyAutoDestroyCoreStructures, Type = String, Dynamic = False, Default = \"When turned on\x2C only core structures (such as foundations and pillars) will be auto destroyed. Structures that can be placed on the ground without needing a foundation will not be auto destroyed.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipOnlyDecayUnsnapped, Type = String, Dynamic = False, Default = \"When turned on\x2C only core structures (such as foundations and pillars) that are not attached to anything will decay. Other structures will not decay.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipSpoilTimeMultiplier, Type = String, Dynamic = False, Default = \"Adjusts the time required for items to spoil. Values higher than 1.0 will increase the spoil time.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipStructureDecay, Type = String, Dynamic = False, Default = \"When turned on\x2C structures decay whenever a member of its tribe is not online. After their decay time\x2C structures can be demolished by any player.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipStructureDecayMultiplier, Type = String, Dynamic = False, Default = \"Adjusts the time it takes for structures decay. Higher values will increase the decay time\x2C while lower values will decrease the decay time.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateTab("DecayButton", "Decay"))
		  Me.Append(OmniBarItem.CreateTab("SpoilButton", "Spoil"))
		  
		  Me.Item("DecayButton").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "DecayButton"
		    Self.Pages.SelectedPanelIndex = Self.PageDecay
		  Case "SpoilButton"
		    Self.Pages.SelectedPanelIndex = Self.PageSpoil
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Var DecayButton As OmniBarItem = Self.ConfigToolbar.Item("DecayButton")
		  If (DecayButton Is Nil) = False Then
		    DecayButton.Toggled = (Me.SelectedPanelIndex = Self.PageDecay)
		  End If
		  
		  Var SpoilButton As OmniBarItem = Self.ConfigToolbar.Item("SpoilButton")
		  If (SpoilButton Is Nil) = False Then
		    SpoilButton.Toggled = (Me.SelectedPanelIndex = Self.PageSpoil)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DecayPreviewList
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column = 0 Then
		    Return False
		  End If
		  
		  Try
		    Var Row1Value As Integer = Me.CellTagAt(Row1, Column)
		    Var Row2Value As Integer = Me.CellTagAt(Row2, Column)
		    
		    If Row1Value > Row2Value Then
		      Result = 1
		    ElseIf Row1Value < Row2Value Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events PvEStructureDecaySwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.DisableStructureDecayPvE = Not Me.Value
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvEDinoDecaySwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.DisableDinoDecayPvE = Not Me.Value
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvPDinoDecaySwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.PvPDinoDecay = Me.Value
		  
		  If Me.Value Then
		    Config.DisableDinoDecayPvE = False
		    Self.PvEDinoDecaySwitch.Value = True
		  End If
		  Self.PvEDinoDecaySwitch.Enabled = Not Me.Value
		  
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvPStructureDecaySwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.PvPStructureDecay = Me.Value
		  
		  If Me.Value Then
		    Config.DisableStructureDecayPvE = False
		    Self.PvEStructureDecaySwitch.Value = True
		  End If
		  Self.PvEStructureDecaySwitch.Enabled = Not Me.Value
		  
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvEStructureDecayMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.PvEStructureDecayPeriodMultiplier = Value
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvEDinoDecayMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.PvEDinoDecayPeriodMultiplier = Value
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CropDecaySpeedMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.CropDecaySpeedMultiplier = Value
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FastDecayUnsnappedCoreStructuresSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.FastDecayUnsnappedCoreStructures = Me.Value
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OnlyDecayUnsnappedCoreStructuresSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.OnlyDecayUnsnappedCoreStructures = Me.Value
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FastDecayPeriodField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Interval As DateInterval = Beacon.ParseInterval(Me.Text)
		  If Interval Is Nil Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.FastDecayInterval = Interval.TotalSeconds
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SpoilTimeMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.GlobalSpoilingTimeMultiplier = Value
		  Self.Modified = Config.Modified
		  Self.UpdateSpoilFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SpoilTimesList
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column = 0 Then
		    Return False
		  End If
		  
		  Try
		    Var Row1Value As Integer = Me.CellTagAt(Row1, Column)
		    Var Row2Value As Integer = Me.CellTagAt(Row2, Column)
		    
		    If Row1Value > Row2Value Then
		      Result = 1
		    ElseIf Row1Value < Row2Value Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events CorpseDecomposeMultiplierField
	#tag Event
		Sub TextChanged()
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  If Self.Focus <> Self.CorpseDecomposePreviewField Then
		    Var Duration As Double = Ark.DataSource.Pool.Get(False).GetDoubleVariable("Corpse Decompose Time", 900) * Value
		    Self.CorpseDecomposePreviewField.Text = Beacon.SecondsToString(Duration)
		  End If
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.GlobalCorpseDecompositionTimeMultiplier = Value
		  Self.Modified = Config.Modified
		  Self.UpdateSpoilFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ItemDecomposeMultiplierField
	#tag Event
		Sub TextChanged()
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  If Self.Focus <> Self.ItemDecomposePreviewField Then
		    Var Duration As Double = Ark.DataSource.Pool.Get(False).GetDoubleVariable("Item Decompose Time", 120) * Value
		    Self.ItemDecomposePreviewField.Text = Beacon.SecondsToString(Duration)
		  End If
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.GlobalItemDecompositionTimeMultiplier = Value
		  Self.Modified = Config.Modified
		  Self.UpdateSpoilFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CorpseDecomposePreviewField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Or (Self.Focus <> Me) Then
		    Return
		  End If
		  
		  Var Interval As DateInterval = Beacon.ParseInterval(Me.Text)
		  If Interval Is Nil Then
		    Return
		  End If
		  
		  Var Seconds As Integer = Interval.TotalSeconds
		  Var DefaultTime As Double = Ark.DataSource.Pool.Get(False).GetDoubleVariable("Corpse Decompose Time", 900)
		  Var Multiplier As Double = Seconds / DefaultTime
		  
		  Self.CorpseDecomposeMultiplierField.Text = Multiplier.ToString(Locale.Current, "0.0#####")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ItemDecomposePreviewField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Or (Self.Focus <> Me) Then
		    Return
		  End If
		  
		  Var Interval As DateInterval = Beacon.ParseInterval(Me.Text)
		  If Interval Is Nil Then
		    Return
		  End If
		  
		  Var Seconds As Integer = Interval.TotalSeconds
		  Var DefaultTime As Double = Ark.DataSource.Pool.Get(False).GetDoubleVariable("Item Decompose Time", 120)
		  Var Multiplier As Double = Seconds / DefaultTime
		  
		  Self.ItemDecomposeMultiplierField.Text = Multiplier.ToString(Locale.Current, "0.0#####")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClampSpoilTimesSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.ClampItemSpoilingTimes = Me.Value
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoDestroyPeriodMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.AutoDestroyOldStructuresMultiplier = Value
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoDestroyStructuresSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.AutoDestroyStructures = Me.Value
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OnlyDestroyCoreStructuresSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.OnlyAutoDestroyCoreStructures = Me.Value
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoDestroyDinosSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.SpoilTimers = Self.Config(True)
		  Config.AutoDestroyDecayedDinos = Me.Value
		  Self.Modified = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
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
