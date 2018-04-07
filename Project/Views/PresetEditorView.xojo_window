#tag Window
Begin BeaconSubview PresetEditorView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   556
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   740
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Preset"
      CaptionEnabled  =   False
      CaptionIsButton =   False
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      HasResizer      =   False
      Height          =   41
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   740
   End
   Begin TabPanel Panel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   483
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Panels          =   ""
      Scope           =   2
      SmallTabs       =   False
      TabDefinition   =   "Contents\rSettings"
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   53
      Underline       =   False
      Value           =   0
      Visible         =   True
      Width           =   700
      Begin BeaconListbox ContentsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   4
         ColumnsResizable=   False
         ColumnWidths    =   "30,*,100,120"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   "#ColumnDescription"
         Height          =   351
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   " 	Engram	Quantity	Quality"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowCount        =   0
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   1
         ShowDropIndicator=   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   660
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPopupMenu MapFilterMenu
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "All\nThe Island\nScorched Earth\nAbberation\nThe Center\nRagnarok"
         Italic          =   False
         Left            =   126
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   92
         Underline       =   False
         Visible         =   True
         Width           =   139
      End
      Begin UITweaks.ResizedLabel MapFilterLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Map Filter:"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   92
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   74
      End
      Begin Label LockExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   30
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   277
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Checking the box next to a quantity or quality will allow the values to be adjusted by the values on the settings tab."
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   486
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   423
      End
      Begin UITweaks.ResizedTextField NameField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   152
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   91
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   548
      End
      Begin UITweaks.ResizedTextField GroupingField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   152
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   125
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   548
      End
      Begin Label NameLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   91
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label GroupingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Grouping:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   125
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label ItemRangeLabel1
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Select at least"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   159
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedTextField MinItemsField
         AcceptTabs      =   False
         Alignment       =   2
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   152
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   159
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label ItemRangeLabel2
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   237
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "items, but not more than"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   159
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   160
      End
      Begin UITweaks.ResizedTextField MaxItemsField
         AcceptTabs      =   False
         Alignment       =   2
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   409
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   159
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label ItemRangeLabel3
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   494
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "items."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   159
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   174
      End
      Begin UpDownArrows MinItemsStepper
         AcceptFocus     =   False
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   212
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   159
         Visible         =   True
         Width           =   13
      End
      Begin UpDownArrows MaxItemsStepper
         AcceptFocus     =   False
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   469
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   159
         Visible         =   True
         Width           =   13
      End
      Begin GroupBox AdjustmentsGroup
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Adjustments"
         Enabled         =   True
         Height          =   180
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   201
         Underline       =   False
         Visible         =   True
         Width           =   660
         Begin UITweaks.ResizedLabel StandardMultipliersLabel1
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   60
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
            Text            =   "In standard beacons, improve qualities by"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   237
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   267
         End
         Begin TextField AdjustQualityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   0
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   339
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   237
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
         Begin UITweaks.ResizedLabel StandardMultipliersLabel2
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   411
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
            Text            =   "tiers and multiply quantities by"
            TextAlign       =   1
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   237
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   197
         End
         Begin TextField AdjustQuantityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   0
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   620
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   3
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   237
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
         Begin UITweaks.ResizedLabel BonusMultipliersLabel1
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   60
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   4
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "In bonus beacons, improve qualities by"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   271
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   267
         End
         Begin UITweaks.ResizedLabel CaveMultipliersLabel1
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   60
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
            Text            =   "In cave crates, improve qualities by"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   305
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   267
         End
         Begin UITweaks.ResizedLabel SeaMultipliersLabel1
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   60
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   6
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "In sea && desert crates, improve qualities by"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   339
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   267
         End
         Begin TextField AdjustQualityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   1
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   339
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   7
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   271
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
         Begin UITweaks.ResizedLabel BonusMultipliersLabel2
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   411
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
            Text            =   "tiers and multiply quantities by"
            TextAlign       =   1
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   271
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   197
         End
         Begin TextField AdjustQuantityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   1
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   620
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   9
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   271
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
         Begin TextField AdjustQualityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   2
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   339
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   10
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   305
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
         Begin UITweaks.ResizedLabel CaveMultipliersLabel2
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   411
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   11
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "tiers and multiply quantities by"
            TextAlign       =   1
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   305
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   197
         End
         Begin TextField AdjustQuantityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   2
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   620
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   12
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   305
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
         Begin TextField AdjustQualityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   3
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   339
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   13
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   339
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
         Begin UITweaks.ResizedLabel SeaMultipliersLabel2
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   411
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   14
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "tiers and multiply quantities by"
            TextAlign       =   1
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   339
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   197
         End
         Begin TextField AdjustQuantityField
            AcceptTabs      =   False
            Alignment       =   2
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   3
            InitialParent   =   "AdjustmentsGroup"
            Italic          =   False
            Left            =   620
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   15
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   339
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   60
         End
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  If Self.ContentsChanged Then
		    FileSave.Enable
		    If Self.mSaveFile <> Nil Then
		      FileSaveAs.Enable
		    End If
		  End If
		  If Self.mSaveFile = Nil Then
		    FileExport.Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.UpdateUI()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			Dim Dialog As New SaveAsDialog
			Dialog.Filter = BeaconFileTypes.BeaconPreset
			Dialog.SuggestedFileName = Self.mPreset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension
			
			Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
			If File <> Nil Then
			Dim Writer As New Beacon.JSONWriter(Self.mPreset.ToDictionary, File)
			Writer.Run
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			Self.Save()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			Dim Dialog As New SaveAsDialog
			Dialog.Filter = BeaconFileTypes.BeaconPreset
			Dialog.SuggestedFileName = Self.mPreset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension
			
			Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
			If File <> Nil Then
			Self.mSaveFile = File
			Self.Save()
			End If
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddEntriesToList(Entries() As Beacon.PresetEntry)
		  For Each Entry As Beacon.PresetEntry In Entries
		    Self.ContentsList.AddRow("")
		    Self.PutEntryInRow(Entry, Self.ContentsList.LastIndex)
		  Next
		  Self.ContentsList.Sort
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Preset As Beacon.Preset) As PresetEditorView
		  Dim View As New PresetEditorView
		  View.mPreset = New Beacon.MutablePreset(Preset)
		  View.ToolbarCaption = Preset.Label
		  View.ToolbarIcon = IconLibraryPresets
		  Return View
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelectedEntries(Warn As Boolean)
		  If Self.ContentsList.SelCount = 0 Then
		    Return
		  End If
		  
		  If Warn And Not Self.ShowConfirm(if(Self.ContentsList.SelCount = 1, "Are you sure you want to delete this entry?", "Are you sure you want to delete these " + Str(Self.ContentsList.SelCount, "-0") + " entries?"), "This action cannot be undone.", "Delete", "Cancel") Then
		    Return
		  End If
		  
		  For I As Integer = Self.ContentsList.ListCount - 1 DownTo 0
		    If Not Self.ContentsList.Selected(I) Then
		      Continue
		    End If
		    Dim Entry As Beacon.PresetEntry = Self.ContentsList.RowTag(I)
		    Dim Idx As Integer = Self.mPreset.IndexOf(Entry)
		    If Idx > -1 Then
		      Self.mPreset.Remove(Idx)  
		      Self.ContentsChanged = True
		    End If
		    Self.ContentsList.RemoveRow(I)
		  Next
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelectedEntries()
		  Dim Entries() As Beacon.PresetEntry
		  For I As Integer = 0 To ContentsList.ListCount - 1
		    If Not ContentsList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Entry As Beacon.PresetEntry = ContentsList.RowTag(I)
		    Call Entry.UniqueID // Triggers generation if necessary so we can compare when done
		    Entries.Append(Entry)
		  Next
		  
		  If Entries.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim NewEntries() As Beacon.SetEntry = EntryEditor.Present(Self.TrueWindow, Entries)
		  If NewEntries = Nil Then
		    Return
		  End If
		  
		  For Each NewEntry As Beacon.SetEntry In NewEntries
		    Dim OriginalEntry As Beacon.PresetEntry
		    Dim OriginalIndex As Integer = -1
		    For I As Integer = 0 To UBound(Self.mPreset)
		      If Self.mPreset(I).UniqueID = NewEntry.UniqueID Then
		        OriginalEntry = Self.mPreset(I)
		        OriginalIndex = I
		        Exit For I
		      End If
		    Next
		    If OriginalIndex = -1 Then
		      System.DebugLog("Unable to find original entry " + NewEntry.UniqueID)
		      Break
		      Return
		    End If
		    
		    Dim Item As New Beacon.PresetEntry(NewEntry)
		    Item.Availability = OriginalEntry.Availability
		    Item.RespectQualityModifier = OriginalEntry.RespectQualityModifier
		    Item.RespectQuantityMultiplier = OriginalEntry.RespectQuantityMultiplier
		    Self.mPreset(OriginalIndex) = Item
		    
		    For I As Integer = 0 To ContentsList.ListCount - 1
		      If Beacon.PresetEntry(ContentsList.RowTag(I)).UniqueID = OriginalEntry.UniqueID Then
		        Self.PutEntryInRow(Item, I)
		        Exit For I
		      End If
		    Next
		  Next
		  
		  ContentsList.Sort
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilteredMaps() As Beacon.Map()
		  Dim Maps() As Beacon.Map
		  If MapFilterMenu.ListIndex > -1 Then
		    Maps = MapFilterMenu.RowTag(MapFilterMenu.ListIndex)
		  End If
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinHeight() As UInteger
		  Return 455
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinWidth() As UInteger
		  Return 740
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PutEntryInRow(Entry As Beacon.PresetEntry, Index As Integer, SelectIt As Boolean = False)
		  If Index = -1 Then
		    Self.ContentsList.AddRow("")
		    Index = Self.ContentsList.LastIndex
		  End If
		  
		  Dim Maps() As Beacon.Map = Self.FilteredMaps()
		  Dim MapsValid, MapsInvalid As Integer
		  For Each Map As Beacon.Map In Maps
		    If Entry.ValidForMap(Map) Then
		      MapsValid = MapsValid + 1
		    Else
		      MapsInvalid = MapsInvalid + 1
		    End If
		  Next
		  
		  If MapsValid = 0 Then
		    Self.ContentsList.CellState(Index, Self.ColumnIncluded) = Checkbox.CheckedStates.Unchecked
		  ElseIf MapsInvalid = 0 Then
		    Self.ContentsList.CellState(Index, Self.ColumnIncluded) = Checkbox.CheckedStates.Checked
		  Else
		    Self.ContentsList.CellState(Index, Self.ColumnIncluded) = Checkbox.CheckedStates.Indeterminate
		  End If
		  
		  Self.ContentsList.RowTag(Index) = Entry
		  Self.ContentsList.Cell(Index, Self.ColumnDescription) = Entry.Label
		  Self.ContentsList.Cell(Index, Self.ColumnQuantity) = if(Entry.MinQuantity = Entry.MaxQuantity, Format(Entry.MinQuantity, "0"), Format(Entry.MinQuantity, "0") + "-" + Format(Entry.MaxQuantity, "0"))
		  Self.ContentsList.Cell(Index, Self.ColumnQuality) = if(Entry.MinQuality = Entry.MaxQuality, Language.LabelForQuality(Entry.MinQuality), Language.LabelForQuality(Entry.MinQuality).Left(4) + "-" + Language.LabelForQuality(Entry.MaxQuality).Left(4))
		  Self.ContentsList.CellCheck(Index, Self.ColumnQuantity) = Entry.RespectQuantityMultiplier
		  Self.ContentsList.CellCheck(Index, Self.ColumnQuality) = Entry.RespectQualityModifier
		  
		  If SelectIt Then
		    Self.ContentsList.Selected(Index) = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Save()
		  If Self.mSaveFile = Nil Then
		    Beacon.Data.SavePreset(Self.mPreset)
		  Else
		    Dim Writer As New Beacon.JSONWriter(Self.mPreset.ToDictionary, Self.mSaveFile)
		    Writer.Run
		  End If
		  Self.ContentsChanged = False
		  Self.Header.Caption = Self.mPreset.Label
		  NotificationKit.Post("Preset Saved", Self.mPreset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedEntries() As Beacon.PresetEntry()
		  Dim Entries() As Beacon.PresetEntry
		  For I As Integer = Self.ContentsList.ListCount - 1 DownTo 0
		    If Self.ContentsList.Selected(I) Then
		      Entries.Append(Self.ContentsList.RowTag(I))
		    End If
		  Next
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddDialog()
		  Dim Entries() As Beacon.SetEntry = EntryEditor.Present(Self.TrueWindow)
		  If Entries = Nil Or Entries.Ubound = -1 Then
		    Return
		  End If
		  Self.ContentsList.ListIndex = -1
		  For Each Entry As Beacon.SetEntry In Entries
		    Dim Item As New Beacon.PresetEntry(Entry)
		    Self.PutEntryInRow(Item, -1, True)
		    Self.mPreset.Append(Item)
		    Self.ContentsChanged = True
		  Next
		  Self.ContentsList.Sort
		  Self.ContentsList.EnsureSelectionIsVisible
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMinAndMaxFields()
		  Dim Focus As RectControl = Self.Window.Focus
		  
		  If Focus <> Self.MinItemsField Then
		    Self.MinItemsField.Text = Str(Self.mPreset.MinItems)
		  End If
		  If Focus <> Self.MaxItemsField Then
		    Self.MaxItemsField.Text = Str(Self.mPreset.MaxItems)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.Header.Caption = Self.mPreset.Label
		  Self.mUpdating = True
		  Self.ContentsChanged = False
		  Self.MapFilterMenu.ListIndex = 0
		  
		  For Each Entry As Beacon.PresetEntry In Self.mPreset
		    Self.PutEntryInRow(Entry, -1)
		  Next
		  Self.ContentsList.Sort
		  
		  Self.NameField.Text = Self.mPreset.Label
		  Self.GroupingField.Text = Self.mPreset.Grouping
		  Self.UpdateMinAndMaxFields
		  
		  Dim Kinds() As Beacon.LootSource.Kinds
		  Kinds.Append(Beacon.LootSource.Kinds.Standard)
		  Kinds.Append(Beacon.LootSource.Kinds.Bonus)
		  Kinds.Append(Beacon.LootSource.Kinds.Cave)
		  Kinds.Append(Beacon.LootSource.Kinds.Sea)
		  
		  For Each Kind As Beacon.LootSource.Kinds In Kinds
		    Dim Index As Integer = CType(Kind, Integer)
		    If Self.AdjustQualityField(Index) <> Nil Then
		      Self.AdjustQualityField(Index).Text = Str(Self.mPreset.QualityModifier(Kind), "-0")
		    End If
		    If Self.AdjustQuantityField(Index) <> Nil Then
		      Self.AdjustQuantityField(Index).Text = Str(Self.mPreset.QuantityMultiplier(Kind), "-0")
		    End If
		  Next
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPreset As Beacon.MutablePreset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnDescription, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIncluded, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageContents, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSettings, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddEntries"
		    Self.ShowAddDialog()
		  Case "EditEntries"
		    Self.EditSelectedEntries()
		  Case "DeleteEntries"
		    Self.DeleteSelectedEntries(True)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("AddEntries", Nil))
		  Me.LeftItems.Append(New BeaconToolbarItem("EditEntries", Nil, False))
		  Me.LeftItems.Append(New BeaconToolbarItem("DeleteEntries", Nil, False))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Panel
	#tag Event
		Sub Open()
		  Me.FixTabFont
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentsList
	#tag Event
		Sub Open()
		  Me.ColumnType(Self.ColumnIncluded) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnQuantity) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnQuality) = Listbox.TypeCheckbox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim ChangeAll As Boolean = (Keyboard.CommandKey And TargetMacOS) Or (Keyboard.ControlKey And TargetWindows)
		  
		  Select Case Column
		  Case Self.ColumnIncluded
		    Dim State As CheckBox.CheckedStates = Me.CellState(Row, Column)
		    If State = Checkbox.CheckedStates.Indeterminate Then
		      Return
		    End If
		    
		    Dim Maps() As Beacon.Map = Self.FilteredMaps
		    If ChangeAll Then
		      For I As Integer = Me.ListCount - 1 DownTo 0
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        For Each Map As Beacon.Map In Maps
		          If Entry.ValidForMap(Map) <> (State = Checkbox.CheckedStates.Checked) Then
		            Entry.ValidForMap(Map) = (State = Checkbox.CheckedStates.Checked)
		            Me.CellState(I, Column) = State
		            Self.ContentsChanged = True
		          End If
		        Next
		      Next
		    Else
		      Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		      For Each Map As Beacon.Map In Maps
		        If Entry.ValidForMap(Map) <> (State = Checkbox.CheckedStates.Checked) Then
		          Entry.ValidForMap(Map) = (State = Checkbox.CheckedStates.Checked)
		          Self.ContentsChanged = True
		        End If
		      Next
		    End If
		    Return
		  Case Self.ColumnQuantity
		    Dim Checked As Boolean = Me.CellCheck(Row, Column)
		    
		    If ChangeAll Then
		      For I As Integer = Me.ListCount - 1 DownTo 0
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        If Entry.RespectQuantityMultiplier <> Checked Then
		          Entry.RespectQuantityMultiplier = Checked
		          Me.CellCheck(I, Column) = Checked
		          Self.ContentsChanged = True
		        End If
		      Next
		    Else
		      Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		      If Entry.RespectQuantityMultiplier <> Checked Then
		        Entry.RespectQuantityMultiplier = Checked
		        Self.ContentsChanged = True
		      End If
		    End If
		  Case Self.ColumnQuality
		    Dim Checked As Boolean = Me.CellCheck(Row, Column)
		    
		    If ChangeAll Then
		      For I As Integer = Me.ListCount - 1 DownTo 0
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        If Entry.RespectQualityModifier <> Checked Then
		          Entry.RespectQualityModifier = Checked
		          Me.CellCheck(I, Column) = Checked
		          Self.ContentsChanged = True
		        End If
		      Next
		    Else
		      Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		      If Entry.RespectQualityModifier <> Checked Then
		        Entry.RespectQualityModifier = Checked
		        Self.ContentsChanged = True
		      End If
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Dim Item As MenuItem
		  
		  Item = New MenuItem
		  Item.Text = "Create Blueprint Entry"
		  Item.Enabled = Me.SelCount > 0
		  Item.Tag = "createblueprintentry"
		  
		  Base.Append(Item)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Tag
		  Case "createblueprintentry"
		    Dim Maps() As Beacon.Map = Beacon.Maps.All
		    Dim NewEntries As New Xojo.Core.Dictionary
		    For Each Map As Beacon.Map In Maps
		      Dim Entries() As Beacon.PresetEntry
		      For I As Integer = 0 To Me.ListCount - 1
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        If Entry.ValidForMap(Map) Then
		          Entries.Append(Entry)
		        End If
		      Next
		      
		      Dim BlueprintEntry As Beacon.SetEntry = Beacon.SetEntry.CreateBlueprintEntry(Entries)
		      If BlueprintEntry <> Nil Then
		        Dim Hash As Text = BlueprintEntry.Hash
		        If NewEntries.HasKey(Hash) Then
		          Dim Entry As Beacon.PresetEntry = NewEntries.Value(Hash)
		          Entry.ValidForMap(Map) = True
		          NewEntries.Value(Hash) = Entry
		        Else
		          Dim Entry As New Beacon.PresetEntry(BlueprintEntry)
		          Entry.Availability = 0
		          Entry.ValidForMap(Map) = True
		          NewEntries.Value(Hash) = Entry
		        End If
		      End If
		    Next
		    
		    If NewEntries.Count = 0 Then
		      Beep
		      Return True
		    End If
		    
		    For I As Integer = 0 To Me.ListCount - 1
		      If Me.Selected(I) Then
		        Beacon.PresetEntry(Me.RowTag(I)).ChanceToBeBlueprint = 0.0
		      End If
		    Next
		    Me.ListIndex = -1
		    
		    For Each Entry As Xojo.Core.DictionaryEntry In NewEntries
		      Dim Item As Beacon.PresetEntry = Entry.Value
		      Item.RespectQualityModifier = False
		      Item.RespectQuantityMultiplier = False
		      Self.PutEntryInRow(Item, -1, True)
		      Self.mPreset.Append(Item)
		    Next
		    
		    Me.Sort
		    Me.EnsureSelectionIsVisible()
		    Self.ContentsChanged = True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelCount > -1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Self.DeleteSelectedEntries(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  Header.EditEntries.Enabled = Me.SelCount > 0
		  Header.DeleteEntries.Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapFilterMenu
	#tag Event
		Sub Open()
		  Me.DeleteAllRows()
		  
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  Me.AddRow("All", Maps)
		  For Each Map As Beacon.Map In Maps
		    Dim Arr(0) As Beacon.Map = Array(Map)
		    Me.AddRow(Map.Name, Arr)
		  Next
		  
		  Me.ListIndex = -1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  If Self.mUpdating = True Then
		    Return
		  End If
		  
		  Self.mUpdating = True
		  For I As Integer = ContentsList.ListCount - 1 DownTo 0
		    Dim Entry As Beacon.PresetEntry = ContentsList.RowTag(I)
		    Self.PutEntryInRow(Entry, I, ContentsList.Selected(I))
		  Next
		  Self.mUpdating = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As String = Trim(Me.Text)
		  If Value <> "" And StrComp(Self.mPreset.Label, Value, 0) <> 0 Then
		    Self.mPreset.Label = Value.ToText
		    Self.ContentsChanged = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GroupingField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As String = Trim(Me.Text)
		  If Value <> "" And StrComp(Self.mPreset.Grouping, Value, 0) <> 0 Then
		    Self.mPreset.Grouping = Value.ToText
		    Self.ContentsChanged = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As Integer = Min(Max(CDbl(Me.Text), 1), Self.mPreset.MaxItems, Self.mPreset.Count)
		  If Self.mPreset.MinItems <> Value Then
		    Self.mPreset.MinItems = Value
		    Self.ContentsChanged = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Text = Str(Self.mPreset.MinItems, "-0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Me.Text = Str(Self.mPreset.MinItems, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As Integer = Min(Max(CDbl(Me.Text), 1, Self.mPreset.MinItems), Self.mPreset.Count)
		  If Self.mPreset.MaxItems <> Value Then
		    Self.mPreset.MaxItems = Value
		    Self.ContentsChanged = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Text = Str(Self.mPreset.MaxItems, "-0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Me.Text = Str(Self.mPreset.MaxItems, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsStepper
	#tag Event
		Sub Down()
		  Self.MinItemsField.Text = Str(CDbl(Self.MinItemsField.Text) - 1, "-0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Self.MinItemsField.Text = Str(CDbl(Self.MinItemsField.Text) + 1, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsStepper
	#tag Event
		Sub Down()
		  Self.MaxItemsField.Text = Str(CDbl(Self.MaxItemsField.Text) - 1, "-0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Self.MaxItemsField.Text = Str(CDbl(Self.MaxItemsField.Text) + 1, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AdjustQualityField
	#tag Event
		Sub TextChange(index as Integer)
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Kind As Beacon.LootSource.Kinds = CType(Index, Beacon.LootSource.Kinds)
		  Dim Value As Integer = CDbl(Me.Text)
		  
		  If Self.mPreset.QualityModifier(Kind) <> Value Then
		    Self.mPreset.QualityModifier(Kind) = Value
		    Self.ContentsChanged = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AdjustQuantityField
	#tag Event
		Sub TextChange(index as Integer)
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Kind As Beacon.LootSource.Kinds = CType(Index, Beacon.LootSource.Kinds)
		  Dim Value As Integer = CDbl(Me.Text)
		  
		  If Self.mPreset.QuantityMultiplier(Kind) <> Value Then
		    Self.mPreset.QuantityMultiplier(Kind) = Value
		    Self.ContentsChanged = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarIcon"
		Group="Behavior"
		Type="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
