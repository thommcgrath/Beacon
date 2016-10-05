#tag Window
Begin Window PresetCreationSheet
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   700
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Create Preset"
   Visible         =   True
   Width           =   718
   Begin PushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   618
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   660
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton CancelButton
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
      Left            =   526
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
      Top             =   660
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   2
      TabPanelIndex   =   0
      Text            =   "New Preset"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   678
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
      TabIndex        =   4
      TabPanelIndex   =   0
      Text            =   "Group:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   171
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   76
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
      Italic          =   False
      Left            =   108
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   171
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   590
   End
   Begin GroupBox StandardGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Standard Beacons"
      Enabled         =   True
      Height          =   112
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   108
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   205
      Underline       =   False
      Visible         =   True
      Width           =   289
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
         Left            =   265
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
         Top             =   241
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
         Left            =   128
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
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   241
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
         Left            =   337
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
         Text            =   "Tiers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   241
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
         Left            =   265
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
         Top             =   275
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
         Left            =   128
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   0
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   275
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
      Left            =   409
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   205
      Underline       =   False
      Visible         =   True
      Width           =   289
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
         Left            =   566
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
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   241
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
         Left            =   429
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   241
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
         Left            =   638
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
         Top             =   241
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
         Left            =   566
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   275
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
         Left            =   429
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
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   275
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
   End
   Begin GroupBox CaveGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Cave Loot Crates"
      Enabled         =   True
      Height          =   112
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   108
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   329
      Underline       =   False
      Visible         =   True
      Width           =   289
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
         Left            =   265
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
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   365
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
         Left            =   128
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   365
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
         Left            =   337
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
         Top             =   365
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
         Left            =   265
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   399
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
         Left            =   128
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
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   399
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
      Left            =   409
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   329
      Underline       =   False
      Visible         =   True
      Width           =   289
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
         Left            =   566
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
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   365
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
         Left            =   429
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         Text            =   "Adjust Quality By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   365
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
         Left            =   638
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
         Top             =   365
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
         Left            =   566
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   399
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
         Left            =   429
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
         Text            =   "Multiply Quantity By"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   399
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   125
      End
   End
   Begin Label ExplanationLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   107
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      Text            =   "Presets behave differently based on the loot source they are added to. For each loot source below, both quantity and quality can be adjusted. ""Adjust Quality By"" is a fixed number of quality levels to adjust. So a value of 2 would bring a Primitive quality to Apprentice. ""Multiply Quantity By"" simply multiplies the quantity of each entry by the given multiplier.\n\nEach individual item can be included in loot sources for The Island && The Center, Scorched Earth, or both."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   678
   End
   Begin BeaconListbox ContentsList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "75,75,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   195
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Island	Scorched	Item"
      Italic          =   False
      Left            =   108
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
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   453
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   590
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Label ContentsLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   13
      TabPanelIndex   =   0
      Text            =   "Contents:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   453
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   76
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, Set As Beacon.ItemSet)
		  Dim Preset As New Beacon.MutablePreset
		  
		  Preset.Label = Set.Label
		  Preset.MinItems = Set.MinNumItems
		  Preset.MaxItems = Set.MaxNumItems
		  Preset.Weight = Set.Weight
		  
		  For Each Entry As Beacon.SetEntry In Set
		    Preset.Append(New Beacon.PresetEntry(Entry))
		  Next
		  
		  PresetCreationSheet.Present(Parent, Preset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, Preset As Beacon.Preset)
		  Dim Win As New PresetCreationSheet
		  
		  Win.mPreset = Preset
		  Win.GroupingField.Text = Preset.Grouping
		  Win.BonusQualityField.Text = Preset.QualityModifier(Beacon.LootSource.Kinds.Bonus).ToText(Xojo.Core.Locale.Current)
		  Win.BonusQuantityField.Text = Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Bonus).ToText(Xojo.Core.Locale.Current)
		  Win.CaveQualityField.Text = Preset.QualityModifier(Beacon.LootSource.Kinds.Cave).ToText(Xojo.Core.Locale.Current)
		  Win.CaveQuantityField.Text = Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Cave).ToText(Xojo.Core.Locale.Current)
		  Win.SeaQualityField.Text = Preset.QualityModifier(Beacon.LootSource.Kinds.Sea).ToText(Xojo.Core.Locale.Current)
		  Win.SeaQuantityField.Text = Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Sea).ToText(Xojo.Core.Locale.Current)
		  Win.StandardQualityField.Text = Preset.QualityModifier(Beacon.LootSource.Kinds.Standard).ToText(Xojo.Core.Locale.Current)
		  Win.StandardQuantityField.Text = Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Standard).ToText(Xojo.Core.Locale.Current)
		  
		  For Each Entry As Beacon.PresetEntry In Preset
		    Win.ContentsList.AddRow("", "", App.DataSource.Describe(Entry))
		    
		    Dim Idx As Integer = Win.ContentsList.LastIndex
		    Win.ContentsList.CellCheck(Idx, 0) = Entry.ValidForIsland
		    Win.ContentsList.CellCheck(Idx, 1) = Entry.ValidForScorched
		    Win.ContentsList.RowTag(Idx) = Entry
		  Next
		  
		  Win.ShowWithin(Parent.TrueWindow)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPreset As Beacon.Preset
	#tag EndProperty


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Action()
		  Dim Preset As New Beacon.MutablePreset(Self.mPreset)
		  Dim Locale As Xojo.Core.Locale = Xojo.Core.Locale.Current
		  
		  Preset.Grouping = Self.GroupingField.Text.ToText
		  Preset.QualityModifier(Beacon.LootSource.Kinds.Standard) = Integer.FromText(Self.StandardQualityField.Text.ToText, Locale)
		  Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Standard) = Double.FromText(Self.StandardQuantityField.Text.ToText, Locale)
		  Preset.QualityModifier(Beacon.LootSource.Kinds.Bonus) = Integer.FromText(Self.BonusQualityField.Text.ToText, Locale)
		  Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Bonus) = Double.FromText(Self.BonusQuantityField.Text.ToText, Locale)
		  Preset.QualityModifier(Beacon.LootSource.Kinds.Cave) = Integer.FromText(Self.CaveQualityField.Text.ToText, Locale)
		  Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Cave) = Double.FromText(Self.CaveQuantityField.Text.ToText, Locale)
		  Preset.QualityModifier(Beacon.LootSource.Kinds.Sea) = Integer.FromText(Self.SeaQualityField.Text.ToText, Locale)
		  Preset.QuantityMultiplier(Beacon.LootSource.Kinds.Sea) = Double.FromText(Self.SeaQuantityField.Text.ToText, Locale)
		  
		  Redim Preset(-1)
		  For I As Integer = 0 To Self.ContentsList.ListCount - 1
		    Dim Entry As Beacon.PresetEntry = Self.ContentsList.RowTag(I)
		    Entry.ValidForIsland = Self.ContentsList.CellCheck(I, 0)
		    Entry.ValidForScorched = Self.ContentsList.CellCheck(I, 1)
		    Preset.Append(Entry)
		  Next
		  
		  Dim Filename As String = Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension
		  Dim File As FolderItem = App.PresetsFolder(False).Child(Filename)
		  
		  Preset.ToFile(New Xojo.IO.FolderItem(File.NativePath.ToText))
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GroupingField
	#tag Event
		Sub TextChange()
		  ActionButton.Enabled = Trim(Me.Text) <> ""
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentsList
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = ListBox.TypeCheckbox
		  Me.ColumnType(1) = ListBox.TypeCheckbox
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
