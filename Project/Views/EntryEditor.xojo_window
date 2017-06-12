#tag Window
Begin Window EntryEditor
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   500
   ImplicitInstance=   False
   LiveResize      =   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   500
   MinimizeButton  =   False
   MinWidth        =   850
   Placement       =   1
   Resizeable      =   True
   Title           =   "Set Entry"
   Visible         =   True
   Width           =   900
   Begin GroupBox EngramsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Possible Items"
      Enabled         =   True
      Height          =   428
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
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   330
      Begin TextField FilterField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Search or Enter Spawn Command"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Italic          =   False
         Left            =   40
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   290
      End
      Begin BeaconListbox EngramList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,70"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   1
         Height          =   306
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         InitialValue    =   " 	Name	Weight"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   290
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin CheckBox SingleEntryCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Merge selections into one entry"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         State           =   0
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   408
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   290
      End
   End
   Begin GroupBox SettingsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Quantities And Qualities"
      Enabled         =   True
      Height          =   211
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   362
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   518
      Begin Label MinQuantityLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   382
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
         Text            =   "Min Quantity:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin UITweaks.ResizedTextField MinQuantityField
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
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   546
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   "###"
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin Label MaxQuantityLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   382
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   0
         Text            =   "Max Quantity:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin UITweaks.ResizedTextField MaxQuantityField
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
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   546
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   "###"
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin Label MinQualityLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   382
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
         Text            =   "Min Quality:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   124
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin UITweaks.ResizedPopupMenu QualityMenus
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   0
         InitialParent   =   "SettingsGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   546
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   124
         Underline       =   False
         Visible         =   True
         Width           =   139
      End
      Begin Label MaxQualityLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   382
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
         Text            =   "Max Quality:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   156
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin UITweaks.ResizedPopupMenu QualityMenus
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   1
         InitialParent   =   "SettingsGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   546
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   156
         Underline       =   False
         Visible         =   True
         Width           =   139
      End
      Begin Label ChanceLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   382
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
         Text            =   "Chance To Be Blueprint:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   188
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin Slider ChanceSlider
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   "Items with a higher weight will be selected more frequently than items with a smaller weight. Two items with the same weight will be selected at the same frequency."
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Left            =   546
         LineStep        =   5
         LiveScroll      =   True
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   100
         Minimum         =   0
         PageStep        =   25
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         TickStyle       =   "0"
         Top             =   188
         Value           =   25
         Visible         =   True
         Width           =   139
      End
      Begin UITweaks.ResizedTextField ChanceField
         AcceptTabs      =   False
         Alignment       =   3
         AutoDeactivate  =   False
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
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   697
         LimitText       =   3
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Mask            =   "99#"
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "25"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   188
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   53
      End
      Begin UITweaks.ResizedLabel PercentLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   753
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   11
         TabPanelIndex   =   0
         Text            =   "%"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   188
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   37
      End
      Begin CheckBox EditMinQuantityCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Edit"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   802
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   58
      End
      Begin CheckBox EditMaxQuantityCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Edit"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   802
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   58
      End
      Begin CheckBox EditMinQualityCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Edit"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   802
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   14
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   124
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   58
      End
      Begin CheckBox EditMaxQualityCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Edit"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   802
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   15
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   156
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   58
      End
      Begin CheckBox EditChanceCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Edit"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   802
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   16
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   188
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   58
      End
   End
   Begin GroupBox SimulationGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Simulation"
      Enabled         =   True
      Height          =   205
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   362
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   243
      Underline       =   False
      Visible         =   True
      Width           =   518
      Begin BeaconListbox SimulatedResultsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   1
         ColumnsResizable=   False
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   -1
         Height          =   117
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "SimulationGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   382
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   279
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   478
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton SimulateButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Refresh"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SimulationGroup"
         Italic          =   False
         Left            =   780
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   408
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   800
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   460
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   708
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   25
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   460
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim DefaultSize As New Xojo.Core.Size(900, 500)
		  Dim PreferredSize As Xojo.Core.Size = App.Preferences.SizeValue("Entry Editor Size", DefaultSize)
		  
		  Self.Width = Max(PreferredSize.Width, Self.MinWidth)
		  Self.Height = Max(PreferredSize.Height, Self.MinHeight)
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  App.Preferences.SizeValue("Entry Editor Size") = New Xojo.Core.Size(Self.Width, Self.Height)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSelectedEngrams = New Xojo.Core.Dictionary
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MaxQualityMenu() As PopupMenu
		  Return Self.QualityMenus(1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MinQualityMenu() As PopupMenu
		  Return Self.QualityMenus(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Sources() As Beacon.SetEntry = Nil) As Beacon.SetEntry()
		  Dim Win As New EntryEditor
		  
		  If Sources <> Nil Then
		    Redim Win.mEntries(UBound(Sources))
		    For I As Integer = 0 To UBound(Sources)
		      Win.mEntries(I) = New Beacon.SetEntry(Sources(I))
		    Next
		  End If
		  
		  Select Case UBound(Win.mEntries)
		  Case -1
		    Win.mMode = EntryEditor.Modes.NewEntry
		  Case 0
		    Win.mMode = EntryEditor.Modes.SingleEdit
		  Else
		    Win.mMode = EntryEditor.Modes.MultiEdit
		  End Select
		  
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  If Win.mCancelled Then
		    Win.Close
		    Return Nil
		  End If
		  
		  Dim Entries() As Beacon.SetEntry = Win.mEntries
		  Win.Close
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Search(SearchText As String)
		  If FilterField.Text <> SearchText Then
		    FilterField.Text = SearchText
		  End If
		  
		  Dim Engrams() As Beacon.Engram = Beacon.Data.SearchForEngrams(SearchText.ToText)
		  EngramList.DeleteAllRows
		  
		  Dim PerfectMatch As Boolean
		  Dim Indexes As New Dictionary
		  For Each Engram As Beacon.Engram In Engrams
		    Dim Weight As String = ""
		    If Self.mSelectedEngrams.HasKey(Engram.ClassString) Then
		      Dim WeightValue As Double = Beacon.SetEntryOption(Self.mSelectedEngrams.Value(Engram.ClassString)).Weight * 100
		      Weight = WeightValue.PrettyText
		    End If
		    
		    EngramList.AddRow("", Engram.Label, Weight)
		    EngramList.RowTag(EngramList.LastIndex) = Engram
		    Indexes.Value(Engram.ClassString) = EngramList.LastIndex
		    If Engram.ClassString = SearchText Or Engram.Label = SearchText Then
		      PerfectMatch = True
		    End If
		  Next
		  
		  If Not PerfectMatch Then
		    Dim ParsedEngrams() As Beacon.Engram = Beacon.PullEngramsFromText(SearchText)
		    For Each Engram As Beacon.Engram In ParsedEngrams
		      Dim Weight As String = ""
		      If Self.mSelectedEngrams.HasKey(Engram.ClassString) Then
		        Dim WeightValue As Double = Beacon.SetEntryOption(Self.mSelectedEngrams.Value(Engram.ClassString)).Weight * 100
		        Weight = WeightValue.PrettyText
		      End If
		      
		      EngramList.AddRow("", Engram.Label, Weight)
		      EngramList.RowTag(EngramList.LastIndex) = Engram
		      Indexes.Value(Engram.ClassString) = EngramList.LastIndex
		    Next
		  End If
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mSelectedEngrams
		    Dim ClassString As Text = Entry.Key
		    Dim Option As Beacon.SetEntryOption = Entry.Value
		    
		    Dim Idx As Integer = Indexes.Lookup(ClassString, -1)
		    If Idx = -1 Then
		      Dim Weight As String = ""
		      If Self.mSelectedEngrams.HasKey(ClassString) Then
		        Dim WeightValue As Double = Option.Weight * 100
		        Weight = WeightValue.PrettyText
		      End If
		      
		      EngramList.AddRow("", Option.Engram.Label, Weight)
		      EngramList.RowTag(EngramList.LastIndex) = Option.Engram
		      Indexes.Value(ClassString) = EngramList.LastIndex
		      Idx = EngramList.LastIndex
		    End If
		    EngramList.CellCheck(Idx, 0) = True
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Select Case Self.mMode
		  Case EntryEditor.Modes.NewEntry
		    Self.Search("")
		  Case EntryEditor.Modes.SingleEdit
		    ' BehaviorGroup.Visible = False
		    ' BehaviorSingleEntryRadio.Value = True
		    ' EngramList.Height = (BehaviorGroup.Top + BehaviorGroup.Height) - EngramList.Top
		    ' DoneButton.Caption = "Save"
		    ' 
		    ' For Each Option As Beacon.SetEntryOption In Self.mEntries(0)
		    ' Self.mSelectedEngrams.Append(Option.Engram)
		    ' Next
		    ' 
		    ' Self.Search("")
		    ' Self.UpdateSelectionUI()
		    ' 
		    ' For I As Integer = 0 To EngramList.ListCount - 1
		    ' If EngramList.CellCheck(I, 0) Then
		    ' EngramList.ScrollPosition = I
		    ' Exit For I
		    ' End If
		    ' Next
		  Case EntryEditor.Modes.MultiEdit
		    ' BackButton.Caption = "Cancel"
		    ' DoneButton.Caption = "Save"
		    ' 
		    ' EditChanceCheck.Visible = True
		    ' EditMaxQualityCheck.Visible = True
		    ' EditMaxQuantityCheck.Visible = True
		    ' EditMinQualityCheck.Visible = True
		    ' EditMinQuantityCheck.Visible = True
		    ' 
		    ' EditChanceCheck.Value = False
		    ' EditMaxQualityCheck.Value = False
		    ' EditMaxQuantityCheck.Value = False
		    ' EditMinQualityCheck.Value = False
		    ' EditMinQuantityCheck.Value = False
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show()
		  Self.SetupUI()
		  Super.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowModal()
		  Self.SetupUI()
		  Super.ShowModal()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowModalWithin(ParentWindow As Window)
		  Self.SetupUI()
		  Super.ShowModalWithin(ParentWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowWithin(ParentWindow As Window, Facing As Integer = - 1)
		  Self.SetupUI()
		  Super.ShowWithin(ParentWindow, Facing)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSelectionUI()
		  If Self.mSelectedEngrams.Count > 1 Then
		    Self.SingleEntryCheck.Visible = True
		    Self.EngramList.Height = Self.SingleEntryCheck.Top - (12 + Self.EngramList.Top)
		  Else
		    Self.SingleEntryCheck.Visible = False
		    Self.EngramList.Height = (Self.SingleEntryCheck.Top + Self.SingleEntryCheck.Height) - Self.EngramList.Top
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSimulation()
		  SimulatedResultsList.DeleteAllRows
		  If Self.mSelectedEngrams.Count = 0 Then
		    Return
		  End If
		  
		  Dim Entry As New Beacon.SetEntry
		  For Each Item As Xojo.Core.DictionaryEntry In Self.mSelectedEngrams
		    Dim Option As Beacon.SetEntryOption = Item.Value
		    Entry.Append(Option)
		    If Not (Self.SingleEntryCheck.Value And Self.SingleEntryCheck.Visible) Then
		      Exit
		    End If
		  Next
		  
		  Entry.MinQuantity = Val(Self.MinQuantityField.Text)
		  Entry.MaxQuantity = Val(Self.MaxQuantityField.Text)
		  Entry.MinQuality = MinQualityMenu.Tag
		  Entry.MaxQuality = MaxQualityMenu.Tag
		  Entry.ChanceToBeBlueprint = ChanceSlider.Value / 100
		  
		  Dim Selections() As Beacon.SimulatedSelection = Entry.Simulate
		  Dim GroupedItems As New Xojo.Core.Dictionary
		  For Each Selection As Beacon.SimulatedSelection In Selections
		    Dim Description As Text = Selection.Description
		    Dim Quantity As Integer
		    If GroupedItems.HasKey(Description) Then
		      Quantity = GroupedItems.Value(Description)
		    End If
		    GroupedItems.Value(Description) = Quantity + 1
		  Next
		  
		  For Each Item As Xojo.Core.DictionaryEntry In GroupedItems
		    Dim Description As Text = Item.Key
		    Dim Quantity As Integer = Item.Value
		    SimulatedResultsList.AddRow(Str(Quantity, "0") + "x " + Description)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEntries() As Beacon.SetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As EntryEditor.Modes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedEngrams As Xojo.Core.Dictionary
	#tag EndProperty


	#tag Enum, Name = Modes, Type = Integer, Flags = &h21
		NewEntry
		  SingleEdit
		MultiEdit
	#tag EndEnum


#tag EndWindowCode

#tag Events FilterField
	#tag Event
		Sub TextChange()
		  Self.Search(Me.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column = 1 Then
		    Return
		  End If
		  
		  Dim Engram As Beacon.Engram = Me.RowTag(Row)
		  
		  Select Case Column
		  Case 0
		    Dim Checked As Boolean = Me.CellCheck(Row, Column)
		    If Checked And Not Self.mSelectedEngrams.HasKey(Engram.ClassString) Then
		      Dim Weight As Double = Max(Min(Val(Me.Cell(Row, Column)) / 100, 1), 0)
		      Self.mSelectedEngrams.Value(Engram.ClassString) = New Beacon.SetEntryOption(Engram, Weight)
		    ElseIf Not Checked And Self.mSelectedEngrams.HasKey(Engram.ClassString) Then
		      Self.mSelectedEngrams.Remove(Engram.ClassString)
		    Else
		      Return
		    End If
		    Self.UpdateSelectionUI()
		    Self.UpdateSimulation()
		  Case 2
		    If Self.mSelectedEngrams.HasKey(Engram.ClassString) Then
		      Dim Weight As Double = Max(Min(Val(Me.Cell(Row, Column)) / 100, 1), 0)
		      Self.mSelectedEngrams.Value(Engram.ClassString) = New Beacon.SetEntryOption(Engram, Weight)
		      Self.UpdateSelectionUI()
		      Self.UpdateSimulation()
		    End If
		  Else
		    Return
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = Listbox.TypeCheckbox
		  Me.ColumnType(2) = Listbox.TypeEditable
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case 0
		    If Me.CellCheck(Row1, 0) = True And Me.CellCheck(Row2, 0) = False Then
		      Result = -1
		    ElseIf Me.CellCheck(Row1, 0) = False And Me.CellCheck(Row2, 0) = True Then
		      Result = 1
		    Else
		      Dim Engram1 As Beacon.Engram = Me.RowTag(Row1)
		      Dim Engram2 As Beacon.Engram = Me.RowTag(Row2)
		      
		      Result = StrComp(Engram1.Label, Engram2.Label, 0)
		    End If
		  Case 2
		    Dim Weight1 As Double = Val(Me.Cell(Row1, Column))
		    Dim Weight2 As Double = Val(Me.Cell(Row2, Column))
		    If Weight1 > Weight2 Then
		      Result = 1
		    ElseIf Weight2 > Weight1 Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		  Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SingleEntryCheck
	#tag Event
		Sub Action()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinQuantityField
	#tag Event
		Sub TextChange()
		  EditMinQuantityCheck.Value = True
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxQuantityField
	#tag Event
		Sub TextChange()
		  EditMaxQuantityCheck.Value = True
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events QualityMenus
	#tag Event
		Sub Open(index as Integer)
		  Me.DeleteAllRows()
		  
		  Dim Value As Integer
		  Do
		    Dim Quality As Beacon.Qualities = CType(Value, Beacon.Qualities)
		    Value = Value + 1
		    
		    Dim Label As String = Language.LabelForQuality(Quality)
		    If Label = "" Then
		      Exit
		    End If
		    
		    Me.AddRow(Label, Quality)
		  Loop
		  
		  Me.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change(index as Integer)
		  Select Case Index
		  Case 0 // Min
		    EditMinQualityCheck.Value = True
		  Case 1 // Max
		    EditMaxQualityCheck.Value = True
		  End Select
		  
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChanceSlider
	#tag Event
		Sub ValueChanged()
		  If Self.Focus <> ChanceField Then
		    ChanceField.Text = Str(Me.Value, "-0")
		  End If
		  
		  EditChanceCheck.Value = True
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChanceField
	#tag Event
		Sub TextChange()
		  If Self.Focus = Me Then
		    ChanceSlider.Value = Max(Min(Val(Me.Text), ChanceSlider.Maximum), ChanceSlider.Minimum)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Me.Text = Str(ChanceSlider.Value, "-0")
		  ChanceSlider.Enabled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  ChanceSlider.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SimulateButton
	#tag Event
		Sub Action()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  For Each Entry As Beacon.SetEntry In Self.mEntries
		    If EditMaxQuantityCheck.Value Then
		      Entry.MaxQuantity = Val(MaxQuantityField.Text)
		    End If
		    If EditMinQuantityCheck.Value Then
		      Entry.MinQuantity = Val(MinQuantityField.Text)
		    End If
		    If EditChanceCheck.Value Then
		      Entry.ChanceToBeBlueprint = ChanceSlider.Value / 100
		    End If
		    If EditMaxQualityCheck.Value Then
		      Entry.MaxQuality = MaxQualityMenu.Tag
		    End If
		    If EditMinQualityCheck.Value Then
		      Entry.MinQuality = MinQualityMenu.Tag
		    End If
		  Next
		  
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
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
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
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
