#tag Window
Begin ConfigEditor SpoilTimersConfigEditor
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
   Height          =   794
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
   Width           =   918
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
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
      Width           =   918
   End
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   753
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
      TabIndex        =   1
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   918
      Begin GroupBox DecayPreviewGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Times"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   525
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   403
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   249
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   495
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
            DataField       =   ""
            DataSource      =   ""
            DefaultRowHeight=   -1
            DefaultSortColumn=   0
            DefaultSortDirection=   0
            DropIndicatorVisible=   False
            EditCaption     =   "Edit"
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            GridLinesHorizontalStyle=   0
            GridLinesVerticalStyle=   0
            HasBorder       =   True
            HasHeader       =   True
            HasHorizontalScrollbar=   False
            HasVerticalScrollbar=   True
            HeadingIndex    =   -1
            Height          =   469
            Index           =   -2147483648
            InitialParent   =   "DecayPreviewGroup"
            InitialValue    =   "Class	PvE Decay Time	PvE Destroy Time	PvP Decay Time	PvP Destroy Time"
            Italic          =   False
            Left            =   423
            LockBottom      =   True
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            PreferencesKey  =   ""
            RequiresSelection=   False
            RowSelectionType=   0
            Scope           =   2
            SelectionChangeBlocked=   False
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   285
            Transparent     =   False
            TypeaheadColumn =   0
            Underline       =   False
            Visible         =   True
            VisibleRowCount =   0
            Width           =   455
            _ScrollOffset   =   0
            _ScrollWidth    =   -1
         End
      End
      Begin GroupBox PvEGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "PvE"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   176
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   403
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
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
         Width           =   495
         Begin UITweaks.ResizedTextField PvEDinoDecayMultiplierField
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
            InitialParent   =   "PvEGroup"
            Italic          =   False
            Left            =   622
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
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   195
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   80
         End
         Begin UITweaks.ResizedTextField PvEStructureDecayMultiplierField
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
            InitialParent   =   "PvEGroup"
            Italic          =   False
            Left            =   622
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
            Tooltip         =   ""
            Top             =   161
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   80
         End
         Begin UITweaks.ResizedLabel PvEDinoDecayMultiplierLabel
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
            InitialParent   =   "PvEGroup"
            Italic          =   False
            Left            =   423
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
            Text            =   "Creature Decay Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   195
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   187
         End
         Begin UITweaks.ResizedLabel PvEStructureDecayMultiplierLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   21
            Index           =   -2147483648
            InitialParent   =   "PvEGroup"
            Italic          =   False
            Left            =   423
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
            Text            =   "Structure Decay Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   161
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   187
         End
         Begin SwitchControl PvEStructureDecaySwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "PvEGroup"
            Left            =   622
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
            Tooltip         =   ""
            Top             =   97
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
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "PvEGroup"
            Left            =   622
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
            Tooltip         =   ""
            Top             =   129
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin Label PvEStructureDecayLabel
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
            InitialParent   =   "PvEGroup"
            Italic          =   False
            Left            =   423
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   8
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Enable PvE Structure Decay:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   97
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   187
         End
         Begin Label PvEDinoDecayLabel
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
            InitialParent   =   "PvEGroup"
            Italic          =   False
            Left            =   423
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
            Text            =   "Enable PvE Dino Decay:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   129
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   187
         End
      End
      Begin GroupBox PvPGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "PvP"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   108
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
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
         Width           =   371
         Begin Label PvPStructureDecayLabel
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
            InitialParent   =   "PvPGroup"
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
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Enable PvP Structure Decay:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   97
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin Label PvPDinoDecayLabel
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
            InitialParent   =   "PvPGroup"
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
            Text            =   "Enable PvP Dino Decay:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   129
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin SwitchControl PvPStructureDecaySwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "PvPGroup"
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
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   97
            Transparent     =   True
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
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "PvPGroup"
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
            Tooltip         =   ""
            Top             =   129
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
      End
      Begin TextField SpoilTimeMultiplierField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   168
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
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin CheckBox ClampItemSpoilTimesCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Clamp Item Spoil Times"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   268
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   62
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   630
      End
      Begin Label SpoilTimeMultiplierLabel
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
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   136
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
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontalStyle=   0
         GridLinesVerticalStyle=   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   671
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
         SelectionChangeBlocked=   False
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   103
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   878
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin GroupBox CommonGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Common"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   593
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   181
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   371
         Begin UITweaks.ResizedTextField AutoDestroyPeriodMultiplierField
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
            InitialParent   =   "CommonGroup"
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
            TabIndex        =   6
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   347
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   65
         End
         Begin UITweaks.ResizedTextField FastDecayPeriodField
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
            InitialParent   =   "CommonGroup"
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
            TabIndex        =   3
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   2
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   281
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   65
         End
         Begin UITweaks.ResizedLabel AutoDestroyPeriodMultiplierLabel
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
            InitialParent   =   "CommonGroup"
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
            Text            =   "Auto Destroy Structures Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   347
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin UITweaks.ResizedLabel FastDecayPeriodLabel
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
            InitialParent   =   "CommonGroup"
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
            Text            =   "Fast Decay Period:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   281
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin UITweaks.ResizedLabel CropDecaySpeedMultiplierLabel
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
            InitialParent   =   "CommonGroup"
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
            Text            =   "Crop Decay Speed Multiplier:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   445
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin UITweaks.ResizedTextField CropDecaySpeedMultiplierField
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
            InitialParent   =   "CommonGroup"
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
            Tooltip         =   ""
            Top             =   445
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   65
         End
         Begin Label OnlyDecayUnsnappedCoreStructuresLabel
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
            InitialParent   =   "CommonGroup"
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
            Text            =   "Only Decay Unsnapped Core Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   217
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin Label FastDecayUnsnappedCoreStructuresLabel
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
            InitialParent   =   "CommonGroup"
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
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Fast Decay Unsnapped Core Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   249
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin Label AutoDestroyStructuresLabel
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
            InitialParent   =   "CommonGroup"
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
            Text            =   "Auto Destroy Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   315
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin Label OnlyDestroyCoreStructuresLabel
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
            InitialParent   =   "CommonGroup"
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
            TabIndex        =   14
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Only Auto Destroy Core Structures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   381
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin Label AutoDestroyDinosLabel
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
            InitialParent   =   "CommonGroup"
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
            Text            =   "Auto Destroy Creatures:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   413
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   254
         End
         Begin SwitchControl OnlyDecayUnsnappedCoreStructuresSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "CommonGroup"
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
            Tooltip         =   ""
            Top             =   217
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl FastDecayUnsnappedCoreStructuresSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "CommonGroup"
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
            TabIndex        =   17
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   249
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
         Begin SwitchControl AutoDestroyStructuresSwitch
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ContentHeight   =   0
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "CommonGroup"
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
            Tooltip         =   ""
            Top             =   315
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
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "CommonGroup"
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
            TabIndex        =   19
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   381
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
            DoubleBuffer    =   False
            Enabled         =   True
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "CommonGroup"
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
            TabIndex        =   20
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   413
            Transparent     =   True
            Visible         =   True
            Width           =   40
         End
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.mScorchedSpoilMultiplier = LocalData.SharedInstance.GetDoubleVariable("Scorched Spoil Multiplier", 0.9)
		  
		  Try
		    Var JSON As String = LocalData.SharedInstance.GetStringVariable("Decay Periods")
		    Self.mDecayPeriods = Beacon.ParseJSON(JSON)
		  Catch Err As RuntimeException
		    Self.mDecayPeriods = New Dictionary
		  End Try
		  
		  Try
		    Var JSON As String = LocalData.SharedInstance.GetStringVariable("Spoil Multipliers")
		    Self.mSpoilMultipliers = Beacon.ParseJSON(JSON)
		  Catch Err As RuntimeException
		    Self.mSpoilMultipliers = New Dictionary
		  End Try
		  
		  Try
		    Var JSON As String = LocalData.SharedInstance.GetStringVariable("Spoil Times")
		    Self.mSpoilTimes = Beacon.ParseJSON(JSON)
		  Catch Err As RuntimeException
		    Self.mSpoilTimes = New Dictionary
		  End Try
		  
		  Self.SpoilTimesList.ColumnCount = Self.mSpoilMultipliers.KeyCount + 1
		  
		  Var ColumnIndex As Integer = 1
		  For Each Entry As DictionaryEntry In Self.mSpoilMultipliers
		    Var HeaderName As String = Entry.Key
		    Self.SpoilTimesList.HeaderAt(ColumnIndex) = HeaderName
		    Self.SpoilTimesList.ColumnAt(ColumnIndex).WidthExpression = "100"
		    ColumnIndex = ColumnIndex + 1
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  #if false
		    // Might be used later
		    Var AvailableWidth As Integer = Self.Width - 52 // (20 + 20 + 12)
		    Var LeftColumnWidth As Integer = AvailableWidth * 0.4
		    Var RightColumnWidth As Integer = AvailableWidth - LeftColumnWidth
		    
		    PvPGroup.Width = LeftColumnWidth
		    CommonGroup.Width = LeftColumnWidth
		    PvEGroup.Left = PvPGroup.Left + PvPGroup.Width + 12
		    PvEGroup.Width = RightColumnWidth
		    DecayPreviewGroup.Left = PvEGroup.Left
		    DecayPreviewGroup.Width = PvEGroup.Width
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.NameSpoilTimers)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(False)
		  
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
		  Self.ClampItemSpoilTimesCheck.Value = Config.ClampItemSpoilingTimes
		  
		  Self.UpdateFigures()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.SpoilTimers
		  Static ConfigName As String = BeaconConfigs.NameSpoilTimers
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.SpoilTimers
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.SpoilTimers(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.SpoilTimers(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.SpoilTimers
		    Self.mConfigRef = New WeakRef(Config)
		  End If
		  
		  If ForWriting And Not Document.HasConfigGroup(ConfigName) Then
		    Document.AddConfigGroup(Config)
		  End If
		  
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return Language.LabelForConfig(BeaconConfigs.NameSpoilTimers)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateDecayFigures()
		  Self.DecayPreviewList.RemoveAllRows
		  
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(False)
		  For Each Entry As DictionaryEntry In Self.mDecayPeriods
		    Var Key As String = Entry.Key
		    
		    Var PvEDecayString As String = "N/A"
		    Var PvEDestroyString As String = "N/A"
		    Var PvPDecayString As String = "N/A"
		    Var PvPDestroyString As String = "N/A"
		    
		    If Key = "Creatures" Then
		      If Config.DisableDinoDecayPvE = False Then
		        Var PvEDecayPeriod As Integer = Entry.Value * Config.PvEDinoDecayPeriodMultiplier
		        PvEDecayString = Beacon.SecondsToString(PvEDecayPeriod)
		        
		        If Config.AutoDestroyDecayedDinos Then
		          PvEDestroyString = PvEDecayString
		        End If
		      End If
		      
		      If Config.PvPDinoDecay Then
		        Var PvPDecayPeriod As Integer = Entry.Value
		        PvPDecayString = Beacon.SecondsToString(PvPDecayPeriod)
		        
		        If Config.AutoDestroyDecayedDinos Then
		          PvPDestroyString = PvPDecayString
		        End If
		      End If
		    Else
		      If Config.DisableStructureDecayPvE = False Then
		        Var PvEDecayPeriod As Integer = Entry.Value * Config.PvEStructureDecayPeriodMultiplier
		        PvEDecayString = Beacon.SecondsToString(PvEDecayPeriod)
		        
		        If Config.AutoDestroyStructures Then
		          Var PvEDestroyPeriod As Integer = PvEDecayPeriod * Config.AutoDestroyOldStructuresMultiplier
		          PvEDestroyString = Beacon.SecondsToString(PvEDestroyPeriod)
		        End If
		      End If
		      
		      If Config.PvPStructureDecay Then
		        Var PvPDecayPeriod As Integer = Entry.Value
		        PvPDecayString = Beacon.SecondsToString(PvPDecayPeriod)
		        
		        If Config.AutoDestroyStructures Then
		          Var PvPDestroyPeriod As Integer = PvPDecayPeriod * Config.AutoDestroyOldStructuresMultiplier
		          PvPDestroyString = Beacon.SecondsToString(PvPDestroyPeriod)
		        End If
		      End If
		    End If
		    
		    Self.DecayPreviewList.AddRow(Key, PvEDecayString, PvEDestroyString, PvPDecayString, PvPDestroyString)
		  Next
		  
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
		  
		  List.RemoveAllRows()
		  
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(False)
		  For Each TimeEntry As DictionaryEntry In Self.mSpoilTimes
		    Var Name As String = TimeEntry.Key
		    Var BasePeriod As Integer = Round(TimeEntry.Value * Config.GlobalSpoilingTimeMultiplier)
		    Var Keys() As Variant = Self.mSpoilMultipliers.Keys
		    
		    List.AddRow(Name)
		    Var RowIndex As Integer = List.LastAddedRowIndex
		    
		    For Idx As Integer = 0 To Keys.LastRowIndex
		      Var Multiplier As Double = Self.mSpoilMultipliers.Value(Keys(Idx))
		      Var ColumnIndex As Integer = Idx + 1
		      
		      List.CellValueAt(RowIndex, ColumnIndex) = Beacon.SecondsToString(BasePeriod * Multiplier)
		    Next
		  Next
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


#tag EndWindowCode

#tag Events ConfigToolbar
	#tag Event
		Sub Open()
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
		Sub Change()
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
#tag Events PvEDinoDecayMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.PvEDinoDecayPeriodMultiplier = Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvEStructureDecayMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.PvEStructureDecayPeriodMultiplier = Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvEStructureDecaySwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.DisableStructureDecayPvE = Not Me.Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvEDinoDecaySwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.DisableDinoDecayPvE = Not Me.Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvPStructureDecaySwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.PvPStructureDecay = Me.Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PvPDinoDecaySwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.PvPDinoDecay = Me.Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SpoilTimeMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.GlobalSpoilingTimeMultiplier = Value
		  Self.Changed = Config.Modified
		  Self.UpdateSpoilFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClampItemSpoilTimesCheck
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.ClampItemSpoilingTimes = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoDestroyPeriodMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.AutoDestroyOldStructuresMultiplier = Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FastDecayPeriodField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Interval As DateInterval = Beacon.ParseInterval(Me.Text)
		  If Interval Is Nil Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.FastDecayInterval = Interval.TotalSeconds
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CropDecaySpeedMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var Value As Double
		  If Not Self.ParseDouble(Me.Text, Value) Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.CropDecaySpeedMultiplier = Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OnlyDecayUnsnappedCoreStructuresSwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.OnlyDecayUnsnappedCoreStructures = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FastDecayUnsnappedCoreStructuresSwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.FastDecayUnsnappedCoreStructures = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoDestroyStructuresSwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.AutoDestroyStructures = Me.Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OnlyDestroyCoreStructuresSwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.OnlyAutoDestroyCoreStructures = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoDestroyDinosSwitch
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.SpoilTimers = Self.Config(True)
		  Config.AutoDestroyDecayedDinos = Me.Value
		  Self.Changed = Config.Modified
		  Self.UpdateDecayFigures()
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
