#tag Window
Begin BeaconDialog DinoAdjustmentDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   378
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   378
   MaximizeButton  =   False
   MaxWidth        =   626
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   378
   MinimizeButton  =   False
   MinWidth        =   626
   Placement       =   1
   Resizable       =   "False"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Edit Creature"
   Visible         =   True
   Width           =   626
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Edit Creature"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   586
   End
   Begin Label ExplanationLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   36
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "From here you can adjust creature damage and resistance multipliers, replace the creature with another, or disable the creature completely."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   586
   End
   Begin UITweaks.ResizedLabel TargetDinoLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Creature:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin RadioButton ModeMultipliersRadio
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Change Multipliers"
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   140
   End
   Begin RadioButton ModeReplaceRadio
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Replace Creature"
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   304
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
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   140
   End
   Begin RadioButton ModeDisableRadio
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Disable Creature"
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   456
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
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   140
   End
   Begin UITweaks.ResizedLabel ModeLabel
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Mode:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin PagePanel Pages
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   168
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      Top             =   158
      Transparent     =   False
      Value           =   "0"
      Visible         =   True
      Width           =   626
      Begin UITweaks.ResizedTextField WildDamageField
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
         InitialParent   =   "Pages"
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   164
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel WildDamageLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Wild Damage:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedTextField WildResistanceField
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
         InitialParent   =   "Pages"
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
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   198
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel WildResistanceLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
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
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Wild Resistance:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   198
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedLabel WildDamageHelp
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
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
         Text            =   "Greater than 1.0 increases wild creature damage"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedLabel WildResistanceHelp
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
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
         Text            =   "Less than 1.0 increases amount of damage taken"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   198
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedTextField TameDamageField
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
         InitialParent   =   "Pages"
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
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   232
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel TameDamageLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Tame Damage:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   232
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedTextField TameResistanceField
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
         InitialParent   =   "Pages"
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
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   266
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel TameResistanceLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
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
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Tame Resistance:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   266
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedLabel TameDamageHelp
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
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
         Text            =   "Greater than 1.0 increases tamed creature damage"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   232
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedLabel TameResistanceHelp
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
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
         Text            =   "Less than 1.0 increases amount of damage taken"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   266
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedLabel ReplacementDinoLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         Text            =   "Replacement:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedPushButton ChooseReplacementButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Choose…"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   152
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedLabel ReplacementDinoNameLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   250
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Not Selected"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   356
      End
      Begin CheckBox PreventTamingCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Prevent Taming"
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
         Left            =   152
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   300
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   454
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
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
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   338
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   434
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   338
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ChooseTargetButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
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
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   86
   End
   Begin UITweaks.ResizedLabel TargetDinoNameLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   250
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Not Selected"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   356
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SwapButtons()
		  
		  Self.WildDamageField.Value = Format(1.0, "0.0#####")
		  Self.WildResistanceField.Value = Format(1.0, "0.0#####")
		  Self.TameDamageField.Value = Format(1.0, "0.0#####")
		  Self.TameResistanceField.Value = Format(1.0, "0.0#####")
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(ConfiguredCreatures() As Beacon.Creature, DisabledCreatures() As Beacon.Creature, Mods As Beacon.StringList)
		  Self.ConfiguredCreatures = ConfiguredCreatures
		  Self.DisabledCreatures = DisabledCreatures
		  Self.Mods = Mods
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, EditCreature As Beacon.Creature, Config As BeaconConfigs.DinoAdjustments, Mods As Beacon.StringList) As Boolean
		  // This one needs the whole config because there are a lot of factors to showing the creatures in the menus
		  
		  If Parent = Nil Or Config = Nil Then
		    Return False
		  End If
		  
		  Var ConfiguredBehaviors() As Beacon.CreatureBehavior = Config.All
		  Var ConfiguredCreatures(), DisabledCreatures() As Beacon.Creature
		  For Each Behavior As Beacon.CreatureBehavior In ConfiguredBehaviors
		    If Behavior.TargetCreature = EditCreature Then
		      Continue
		    End If
		    ConfiguredCreatures.Add(Behavior.TargetCreature)
		    If Behavior.ProhibitSpawning Then
		      DisabledCreatures.Add(Behavior.TargetCreature)
		    End If
		  Next
		  
		  Var Win As New DinoAdjustmentDialog(ConfiguredCreatures, DisabledCreatures, Mods)
		  If IsNull(EditCreature) = False Then
		    Win.SelectedCreature = EditCreature
		    
		    Var Behavior As Beacon.CreatureBehavior = Config.Behavior(EditCreature)
		    If Behavior <> Nil Then
		      If Behavior.ProhibitSpawning Then
		        Win.ModeDisableRadio.Value = True
		      ElseIf Behavior.ReplacementCreature <> Nil Then
		        Win.SelectedReplacement = Behavior.ReplacementCreature
		        Win.ModeReplaceRadio.Value = True
		      Else
		        Win.WildDamageField.Value = Format(Behavior.DamageMultiplier, "0.0#####")
		        Win.WildResistanceField.Value = Format(Behavior.ResistanceMultiplier, "0.0#####")
		        Win.TameDamageField.Value = Format(Behavior.TamedDamageMultiplier, "0.0#####")
		        Win.TameResistanceField.Value = Format(Behavior.TamedResistanceMultiplier, "0.0#####")
		        Win.ModeMultipliersRadio.Value = True
		        Win.PreventTamingCheck.Value = Behavior.PreventTaming
		      End If
		    End If
		  End If
		  Win.ShowModalWithin(Parent.TrueWindow)
		  If Win.Cancelled Then
		    Win.Close
		    Return False
		  End If
		  
		  Var TargetCreature As Beacon.Creature = Win.SelectedCreature
		  Var Behavior As New Beacon.MutableCreatureBehavior(TargetCreature)
		  If Win.ModeDisableRadio.Value Then
		    Behavior.ProhibitSpawning = True
		  ElseIf Win.ModeReplaceRadio.Value Then
		    Behavior.ReplacementCreature = Win.SelectedReplacement
		  Else
		    Behavior.DamageMultiplier = CDbl(Win.WildDamageField.Value)
		    Behavior.ResistanceMultiplier = CDbl(Win.WildResistanceField.Value)
		    Behavior.TamedDamageMultiplier = CDbl(Win.TameDamageField.Value)
		    Behavior.TamedResistanceMultiplier = CDbl(Win.TameResistanceField.Value)
		    Behavior.PreventTaming = Win.PreventTamingCheck.Value
		  End If
		  
		  If IsNull(EditCreature) = False And TargetCreature <> EditCreature Then
		    Config.RemoveBehavior(EditCreature)
		  End If
		  Config.Behavior(TargetCreature) = Behavior
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Cancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ConfiguredCreatures() As Beacon.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DisabledCreatures() As Beacon.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Mods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedCreature As Beacon.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedReplacement As Beacon.Creature
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mSelectedCreature
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedCreature = Value Then
			    Return
			  End If
			  
			  Self.mSelectedCreature = Value
			  If IsNull(Self.mSelectedCreature) Then
			    Self.TargetDinoNameLabel.Italic = True
			    Self.TargetDinoNameLabel.Value = "No Selection"
			  Else
			    Self.TargetDinoNameLabel.Italic = False
			    Self.TargetDinoNameLabel.Value = Self.mSelectedCreature.Label
			  End If
			  
			  If Self.mSelectedReplacement = Self.mSelectedCreature Then
			    Self.SelectedReplacement = Nil
			  End If
			End Set
		#tag EndSetter
		Private SelectedCreature As Beacon.Creature
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mSelectedReplacement
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedReplacement = Value Then
			    Return
			  End If
			  
			  Self.mSelectedReplacement = Value
			  If IsNull(Self.mSelectedReplacement) Then
			    Self.ReplacementDinoNameLabel.Italic = True
			    Self.ReplacementDinoNameLabel.Value = "No Selection"
			  Else
			    Self.ReplacementDinoNameLabel.Italic = False
			    Self.ReplacementDinoNameLabel.Value = Self.mSelectedReplacement.Label
			  End If
			End Set
		#tag EndSetter
		Private SelectedReplacement As Beacon.Creature
	#tag EndComputedProperty


	#tag Constant, Name = HeightDisable, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightMultipliers, Type = Double, Dynamic = False, Default = \"168", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightReplace, Type = Double, Dynamic = False, Default = \"32", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDisable, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageMultipliers, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageReplace, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ModeMultipliersRadio
	#tag Event
		Sub Action()
		  If Me.Value Then
		    Self.Pages.SelectedPanelIndex = Self.PageMultipliers
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModeReplaceRadio
	#tag Event
		Sub Action()
		  If Me.Value Then
		    Self.Pages.SelectedPanelIndex = Self.PageReplace
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModeDisableRadio
	#tag Event
		Sub Action()
		  If Me.Value Then
		    Self.Pages.SelectedPanelIndex = Self.PageDisable
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub Change()
		  Var OriginalHeight As Integer = Me.Height
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageMultipliers
		    Me.Height = Self.HeightMultipliers
		  Case Self.PageReplace
		    Me.Height = Self.HeightReplace
		  Case Self.PageDisable
		    Me.Height = Self.HeightDisable
		  End Select
		  Var Delta As Integer = Me.Height - OriginalHeight
		  Self.Height = Self.Height + Delta
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseReplacementButton
	#tag Event
		Sub Action()
		  Var Exclude() As Beacon.Creature
		  If Not IsNull(Self.SelectedCreature) Then
		    Exclude.Add(Self.SelectedCreature)
		  End If
		  For Each Creature As Beacon.Creature In Self.DisabledCreatures
		    Exclude.Add(Creature)
		  Next
		  
		  Var Creatures() As Beacon.Creature = EngramSelectorDialog.Present(Self, "", Exclude, Self.Mods, EngramSelectorDialog.SelectModes.Single)
		  If Creatures <> Nil And Creatures.LastIndex = 0 Then
		    Self.SelectedReplacement = Creatures(0)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If IsNull(Self.SelectedCreature) Then
		    Self.ShowAlert("You haven't selected a creature", "That's an important step, right?")
		    Return
		  End If
		  
		  If Self.ModeReplaceRadio.Value Then
		    If IsNull(Self.SelectedReplacement) Then
		      Self.ShowAlert("You haven't selected a replacement creature", "If you wan to replace the creature with nothing, choose the ""Disable Creature"" button.")
		      Return
		    End If
		  ElseIf Self.ModeMultipliersRadio.Value Then
		    Var DamageMultiplier As Double = CDbl(Self.WildDamageField.Value)
		    Var ResistanceMultiplier As Double = CDbl(Self.WildResistanceField.Value)
		    Var TamedDamageMultiplier As Double = CDbl(Self.TameDamageField.Value)
		    Var TamedResistanceMultiplier As Double = CDbl(Self.TameResistanceField.Value)
		    Var PreventTaming As Boolean = Self.PreventTamingCheck.Value
		    
		    If DamageMultiplier < 0 Or ResistanceMultiplier < 0 Or TamedDamageMultiplier < 0 Or TamedResistanceMultiplier < 0 Then
		      Self.ShowAlert("You have a multiplier that doesn't make sense", "It's ok to make the multipliers really small, but they must be at least zero.")
		      Return
		    End If
		    If DamageMultiplier = 1.0 And ResistanceMultiplier = 1.0 And TamedDamageMultiplier = 1.0 And TamedResistanceMultiplier = 1.0 And PreventTaming = False Then
		      Self.ShowAlert("You haven't changed any multipliers", "There's no reason to save a creature adjustment with no differences than official.")
		      Return
		    End If
		  End If
		  
		  Self.Cancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.Cancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseTargetButton
	#tag Event
		Sub Action()
		  Var Exclude() As Beacon.Creature
		  For Each Creature As Beacon.Creature In Self.ConfiguredCreatures
		    Exclude.Add(Creature)
		  Next
		  
		  Var Creatures() As Beacon.Creature = EngramSelectorDialog.Present(Self, "", Exclude, Self.Mods, EngramSelectorDialog.SelectModes.Single)
		  If Creatures <> Nil And Creatures.LastIndex = 0 Then
		    Self.SelectedCreature = Creatures(0)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Type="Color"
		EditorType="Color"
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
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
