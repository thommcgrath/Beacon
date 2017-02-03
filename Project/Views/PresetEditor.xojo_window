#tag Window
Begin ContainerControl PresetEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   733
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   720
   Begin GroupBox ContentsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Contents"
      Enabled         =   True
      Height          =   281
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   6
      LockBottom      =   True
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
      Top             =   446
      Underline       =   False
      Visible         =   True
      Width           =   708
      Begin BeaconListbox ContentsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   7
         ColumnsResizable=   False
         ColumnWidths    =   "90,90,90,90,*,100,100"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   4
         Height          =   193
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "ContentsGroup"
         InitialValue    =   "Island	Scorched	Lock Quality	Lock Quantity	Description	Quality	Quantity"
         Italic          =   False
         Left            =   26
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   1
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   482
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   668
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton AddButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Add"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ContentsGroup"
         Italic          =   False
         Left            =   26
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   687
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton EditButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Edit"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ContentsGroup"
         Italic          =   False
         Left            =   118
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   687
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DeleteButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Remove"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ContentsGroup"
         Italic          =   False
         Left            =   210
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   687
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin GroupBox SettingsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Settings"
      Enabled         =   True
      Height          =   180
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   6
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   6
      Underline       =   False
      Visible         =   True
      Width           =   708
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
         InitialParent   =   "SettingsGroup"
         Italic          =   False
         Left            =   128
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   42
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   566
      End
      Begin UITweaks.ResizedTextField GroupField
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
         Left            =   128
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
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   76
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   566
      End
      Begin UITweaks.ResizedTextField MinItemsField
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
         Left            =   128
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
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   110
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField MaxItemsField
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
         Left            =   128
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
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   144
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel NameLabel
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
         Left            =   26
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
         Text            =   "Preset Name:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   42
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedLabel GroupLabel
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
         Left            =   26
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
         Text            =   "Group:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   76
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedLabel MinItemsLabel
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
         Left            =   26
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
         Text            =   "Min Items:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   110
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedLabel MaxItemsLabel
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
         Left            =   26
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
         Text            =   "Max Items:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   144
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
   End
   Begin GroupBox StandardGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Standard Beacons && Boss Loot"
      Enabled         =   True
      Height          =   112
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   6
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   198
      Underline       =   False
      Visible         =   True
      Width           =   348
      Begin UITweaks.ResizedTextField StandardQualityField
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
         InitialParent   =   "StandardGroup"
         Italic          =   False
         Left            =   163
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   234
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label StandardQualityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "StandardGroup"
         Italic          =   False
         Left            =   26
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
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   234
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin Label StandardQualitySuffixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "StandardGroup"
         Italic          =   False
         Left            =   235
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
         Text            =   "Tiers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   234
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   40
      End
      Begin UITweaks.ResizedTextField StandardQuantityField
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
         InitialParent   =   "StandardGroup"
         Italic          =   False
         Left            =   163
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
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   268
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label StandardQuantityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "StandardGroup"
         Italic          =   False
         Left            =   26
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   0
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   268
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
   End
   Begin GroupBox BonusGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Bonus Beacons"
      Enabled         =   True
      Height          =   112
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   198
      Underline       =   False
      Visible         =   True
      Width           =   348
      Begin UITweaks.ResizedTextField BonusQualityField
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
         InitialParent   =   "BonusGroup"
         Italic          =   False
         Left            =   523
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   234
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label BonusQualityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "BonusGroup"
         Italic          =   False
         Left            =   386
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
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   234
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin Label BonusQualitySuffixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "BonusGroup"
         Italic          =   False
         Left            =   595
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
         Text            =   "Tiers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   234
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   40
      End
      Begin UITweaks.ResizedTextField BonusQuantityField
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
         InitialParent   =   "BonusGroup"
         Italic          =   False
         Left            =   523
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
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   268
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label BonusQuantityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "BonusGroup"
         Italic          =   False
         Left            =   386
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   0
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   268
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
   End
   Begin GroupBox CaveGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Cave && Desert Loot Crates"
      Enabled         =   True
      Height          =   112
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   6
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   322
      Underline       =   False
      Visible         =   True
      Width           =   348
      Begin UITweaks.ResizedTextField CaveQualityField
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
         InitialParent   =   "CaveGroup"
         Italic          =   False
         Left            =   163
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label CaveQualityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "CaveGroup"
         Italic          =   False
         Left            =   26
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
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin Label CaveQualitySuffixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "CaveGroup"
         Italic          =   False
         Left            =   235
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
         Text            =   "Tiers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   40
      End
      Begin UITweaks.ResizedTextField CaveQuantityField
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
         InitialParent   =   "CaveGroup"
         Italic          =   False
         Left            =   163
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
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   392
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label CaveQuantityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "CaveGroup"
         Italic          =   False
         Left            =   26
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   0
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   392
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
   End
   Begin GroupBox SeaGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Deep Sea Loot Crates"
      Enabled         =   True
      Height          =   112
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   366
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   322
      Underline       =   False
      Visible         =   True
      Width           =   348
      Begin UITweaks.ResizedTextField SeaQualityField
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
         InitialParent   =   "SeaGroup"
         Italic          =   False
         Left            =   523
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label SeaQualityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SeaGroup"
         Italic          =   False
         Left            =   386
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
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
      Begin Label SeaQualitySuffixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SeaGroup"
         Italic          =   False
         Left            =   595
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
         Text            =   "Tiers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   40
      End
      Begin UITweaks.ResizedTextField SeaQuantityField
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
         InitialParent   =   "SeaGroup"
         Italic          =   False
         Left            =   523
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
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   392
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin Label SeaQuantityPrefixLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SeaGroup"
         Italic          =   False
         Left            =   386
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   0
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   392
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddEntriesToList(Entries() As Beacon.PresetEntry)
		  For Each Entry As Beacon.PresetEntry In Entries
		    ContentsList.AddRow("")
		    Self.PutEntryInRow(Entry, ContentsList.LastIndex)
		  Next
		  ContentsList.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Preset() As Beacon.Preset
		  If Self.mPreset <> Nil Then
		    Return New Beacon.Preset(Self.mPreset)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Preset(Assigns Value As Beacon.Preset)
		  If Value <> Nil Then
		    Self.mPreset = New Beacon.MutablePreset(Value)
		  Else
		    Self.mPreset = Nil
		  End If
		  
		  Self.mUpdating = True
		  Self.ContentsChanged = False
		  
		  If Self.mPreset <> Nil Then
		    NameField.Text = Self.mPreset.Label
		    GroupField.Text = Self.mPreset.Grouping
		    MinItemsField.Text = Format(Self.mPreset.MinItems, "0")
		    MaxItemsField.Text = Format(Self.mPreset.MaxItems, "0")
		    StandardQualityField.Text = Format(Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Standard), "-0")
		    StandardQuantityField.Text = Format(Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Standard), "-0.000")
		    BonusQualityField.Text = Format(Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Bonus), "-0")
		    BonusQuantityField.Text = Format(Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Bonus), "-0.000")
		    CaveQualityField.Text = Format(Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Cave), "-0")
		    CaveQuantityField.Text = Format(Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Cave), "-0.000")
		    SeaQualityField.Text = Format(Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Sea), "-0")
		    SeaQuantityField.Text = Format(Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Sea), "-0.000")
		    ContentsList.DeleteAllRows
		    
		    For Each Entry As Beacon.PresetEntry In Self.mPreset
		      Self.PutEntryInRow(Entry, -1)
		    Next
		    ContentsList.Sort
		  Else
		    NameField.Text = ""
		    GroupField.Text = ""
		    MinItemsField.Text = ""
		    MaxItemsField.Text = ""
		    StandardQualityField.Text = ""
		    StandardQuantityField.Text = ""
		    BonusQualityField.Text = ""
		    BonusQuantityField.Text = ""
		    CaveQualityField.Text = ""
		    CaveQuantityField.Text = ""
		    SeaQualityField.Text = ""
		    SeaQuantityField.Text = ""
		    ContentsList.DeleteAllRows
		  End If
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PutEntryInRow(Entry As Beacon.PresetEntry, Index As Integer)
		  If Index = -1 Then
		    ContentsList.AddRow("")
		    Index = ContentsList.LastIndex
		  End If
		  
		  ContentsList.RowTag(Index) = Entry
		  ContentsList.Cell(Index, Self.ColumnDescription) = Entry.Label
		  ContentsList.Cell(Index, Self.ColumnQuantity) = if(Entry.MinQuantity = Entry.MaxQuantity, Format(Entry.MinQuantity, "0"), Format(Entry.MinQuantity, "0") + "-" + Format(Entry.MaxQuantity, "0"))
		  ContentsList.Cell(Index, Self.ColumnQuality) = if(Entry.MinQuality = Entry.MaxQuality, Language.LabelForQuality(Entry.MinQuality), Language.LabelForQuality(Entry.MinQuality).Left(4) + "-" + Language.LabelForQuality(Entry.MaxQuality).Left(4))
		  ContentsList.CellCheck(Index, Self.ColumnIslandValid) = Entry.ValidForPackage(Beacon.LootSource.Packages.Island)
		  ContentsList.CellCheck(Index, Self.ColumnScorchedValid) = Entry.ValidForPackage(Beacon.LootSource.Packages.Scorched)
		  ContentsList.CellCheck(Index, Self.ColumnQualityLock) = Not Entry.RespectQualityModifier
		  ContentsList.CellCheck(Index, Self.ColumnQuantityLock) = Not Entry.RespectQuantityMultiplier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Dim Width As Integer = Max(Self.Width, 720) // Containers will not do this automatically
		  
		  SettingsGroup.Width = Width - 12
		  ContentsGroup.Width = Width - 12
		  
		  Dim PairWidth As Integer = Width - 24
		  Dim LeftWidth As Integer = Ceil(PairWidth / 2)
		  Dim RightWidth As Integer = Floor(PairWidth / 2)
		  
		  StandardGroup.Width = LeftWidth
		  CaveGroup.Width = LeftWidth
		  BonusGroup.Left = StandardGroup.Left + StandardGroup.Width + 12
		  BonusGroup.Width = RightWidth
		  SeaGroup.Left = CaveGroup.Left + CaveGroup.Width + 12
		  SeaGroup.Width = RightWidth
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPreset As Beacon.MutablePreset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnDescription, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIslandValid, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQualityLock, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantityLock, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnScorchedValid, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ContentsList
	#tag Event
		Sub Open()
		  Me.ColumnType(Self.ColumnIslandValid) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnQualityLock) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnQuantityLock) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnScorchedValid) = Listbox.TypeCheckbox
		  
		  Me.Column(Self.ColumnDescription).WidthExpression = "*"
		  Me.Column(Self.ColumnQuantity).WidthExpression = "70"
		  Me.Column(Self.ColumnQuality).WidthExpression = "100"
		  Me.Column(Self.ColumnIslandValid).WidthExpression = "70"
		  Me.Column(Self.ColumnScorchedValid).WidthExpression = "70"
		  Me.Column(Self.ColumnQuantityLock).WidthExpression = "70"
		  Me.Column(Self.ColumnQualityLock).WidthExpression = "70"
		  
		  Me.Heading(Self.ColumnDescription) = "Description"
		  Me.Heading(Self.ColumnQuantity) = "Quantity"
		  Me.Heading(Self.ColumnQuality) = "Quality"
		  Me.Heading(Self.ColumnIslandValid) = "Island"
		  Me.Heading(Self.ColumnScorchedValid) = "Scorched"
		  Me.Heading(Self.ColumnQuantityLock) = "Lock Qty"
		  Me.Heading(Self.ColumnQualityLock) = "Lock Qlty"
		  
		  Me.HeadingIndex = Self.ColumnDescription
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		  Select Case Column
		  Case Self.ColumnIslandValid
		    Entry.ValidForPackage(Beacon.LootSource.Packages.Island) = Me.CellCheck(Row, Column)
		    Self.ContentsChanged = True
		  Case Self.ColumnScorchedValid
		    Entry.ValidForPackage(Beacon.LootSource.Packages.Scorched) = Me.CellCheck(Row, Column)
		    Self.ContentsChanged = True
		  Case Self.ColumnQualityLock
		    Entry.RespectQualityModifier = Not Me.CellCheck(Row, Column)
		    Self.ContentsChanged = True
		  Case Self.ColumnQuantityLock
		    Entry.RespectQuantityMultiplier = Not Me.CellCheck(Row, Column)
		    Self.ContentsChanged = True
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  EditButton.Enabled = Me.ListIndex > -1
		  DeleteButton.Enabled = Me.ListIndex > -1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddButton
	#tag Event
		Sub Action()
		  Dim Entries() As Beacon.SetEntry = EntryEditor.Present(Self.TrueWindow)
		  For Each Entry As Beacon.SetEntry In Entries
		    Dim Item As New Beacon.PresetEntry(Entry)
		    Self.PutEntryInRow(Item, -1)
		    Self.mPreset.Append(Item)
		  Next
		  ContentsList.Sort
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditButton
	#tag Event
		Sub Action()
		  Dim Entries() As Beacon.PresetEntry
		  For I As Integer = 0 To ContentsList.ListCount - 1
		    If Not ContentsList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Entry As Beacon.PresetEntry = ContentsList.RowTag(I)
		    Call Entry.UniqueID // Triggers generation if necessary so we can compare when done
		    Entries.Append(Entry)
		  Next
		  
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
	#tag EndEvent
#tag EndEvents
#tag Events DeleteButton
	#tag Event
		Sub Action()
		  For I As Integer = ContentsList.ListCount - 1 DownTo 0
		    If Not ContentsList.Selected(I) Then
		      Continue
		    End If
		    Dim Entry As Beacon.PresetEntry = ContentsList.RowTag(I)
		    Dim Idx As Integer = Self.mPreset.IndexOf(Entry)
		    If Idx > -1 Then
		      Self.mPreset.Remove(Idx)
		    End If
		    ContentsList.RemoveRow(I)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.Label = Me.Text.ToText
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GroupField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.Grouping = Me.Text.ToText
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.MinItems = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.MaxItems = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StandardQualityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Standard) = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StandardQuantityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Standard) = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BonusQualityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Bonus) = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BonusQuantityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Bonus) = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CaveQualityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Cave) = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CaveQuantityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Cave) = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SeaQualityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QualityModifier(Beacon.LootSource.Kinds.Sea) = CDbl(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SeaQuantityField
	#tag Event
		Sub TextChange()
		  If Not Self.mUpdating Then
		    Self.ContentsChanged = True
		    Self.mPreset.QuantityMultiplier(Beacon.LootSource.Kinds.Sea) = CDbl(Me.Text)
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
