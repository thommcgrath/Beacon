#tag Window
Begin BeaconDialog LootSourceWizard
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   False
   MinWidth        =   450
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Add Loot Source"
   Visible         =   True
   Width           =   550
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   550
      Begin UITweaks.ResizedPushButton SelectionActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   450
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton SelectionCancelButton
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   358
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label SelectionMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Add Loot Source"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   510
      End
      Begin UITweaks.ResizedPushButton SelectionCustomButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Custom Loot Source…"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   160
      End
      Begin Label DefineMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Define Loot Source"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   510
      End
      Begin UITweaks.ResizedPushButton DefineActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   450
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DefineCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Back"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   358
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CustomizeActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Done"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   450
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CustomizeCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Back"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   358
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label CustomizeMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Customize Loot Source"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   510
      End
      Begin UITweaks.ResizedLabel DefineMaxMultiplierLabel
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Max Multiplier:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   156
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedLabel DefineMinMultiplierLabel
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
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Min Multiplier:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   122
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedLabel DefineClassLabel
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
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Class String:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   54
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedLabel DefineNameLabel
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Label:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedTextField DefineMaxMultiplierField
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
         Left            =   136
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
         Top             =   156
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField DefineMinMultiplierField
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
         Left            =   136
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
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   122
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField DefineNameField
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
         Left            =   136
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
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   394
      End
      Begin UITweaks.ResizedTextField DefineClassField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "ExampleSourceClass_C"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
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
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   54
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   394
      End
      Begin UITweaks.ResizedTextField CustomizeMinSetsField
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
         Left            =   136
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
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   54
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel CustomizeMinSetsLabel
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
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Min Sets:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   54
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedTextField CustomizeMaxSetsField
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
         Left            =   136
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
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel CustomizeMaxSetsLabel
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Max Sets:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin CheckBox CustomizePreventDuplicatesCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Prevent Duplicates"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   122
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   394
      End
      Begin Label CustomizePresetsLabel
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Presets:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   154
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin CheckBox CustomizeReconfigureCheckbox
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Rebuild Existing Presets"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   "When enabled, the existing item sets will be emptied and refilled according to their original preset."
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         State           =   0
         TabIndex        =   8
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   394
      End
      Begin CheckBox SelectionExperimentalCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Show Experimental Loot Sources"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         State           =   0
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   510
      End
      Begin UITweaks.ResizedLabel DefineMapsLabel
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
         TabPanelIndex   =   2
         TabStop         =   True
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   190
         Transparent     =   True
         Underline       =   False
         Value           =   "Maps:"
         Visible         =   True
         Width           =   104
      End
      Begin MapSelectionGrid DefineMapsSelector
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   118
         HelpTag         =   ""
         InitialParent   =   "Panel"
         Left            =   130
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Scope           =   2
         TabIndex        =   14
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   184
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   400
      End
      Begin BeaconListbox SourceList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   False
         ColumnWidths    =   "30,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   34
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   0
         Height          =   262
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   " 	Label	Kind	Package"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   1
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   54
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   510
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconListbox CustomizePresetsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   False
         ColumnWidths    =   "22,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   1
         Height          =   162
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   ""
         Italic          =   False
         Left            =   136
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   154
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   394
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Var HasExperimentalSources As Boolean = LocalData.SharedInstance.HasExperimentalLootSources(Self.mMods)
		  If HasExperimentalSources Then
		    Self.SelectionExperimentalCheck.Value = Preferences.ShowExperimentalLootSources
		  Else
		    Self.SelectionExperimentalCheck.Visible = False
		    Self.SourceList.Height = (Self.SelectionExperimentalCheck.Top + Self.SelectionExperimentalCheck.Height) - Self.SourceList.Top
		  End If
		  Self.BuildSourceList()
		  
		  Var Mask As UInt64 = Self.mMask
		  If Self.mSource <> Nil Then
		    If Self.mDuplicateSource Then
		      Self.ShowSelect()
		    Else
		      If Self.mSource.IsOfficial Then
		        Self.CustomizeCancelButton.Caption = "Cancel"
		        Self.mDestinations.ResizeTo(0)
		        Self.mDestinations(0) = Self.mSource.Clone
		        Self.ShowCustomize()
		      Else
		        Self.DefineCancelButton.Caption = "Cancel"
		        Mask = Self.mSource.Availability
		        Self.ShowDefine(Self.mSource)
		      End If
		    End If
		  End If
		  
		  Self.DefineMapsSelector.Mask = Mask
		  Var DesiredWinHeight As Integer = Self.DefineMapsSelector.Top + Self.DefineMapsSelector.Height + 6 + Self.DefineActionButton.Height + 20
		  Var Diff As Integer = DesiredWinHeight - Self.Height
		  Self.Height = Self.Height + Diff
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BuildSourceList()
		  Var Data As LocalData = LocalData.SharedInstance
		  Var Labels As Dictionary = Data.LootSourceLabels(Self.mMask)
		  
		  Var CurrentSources() As Beacon.LootSource = Self.mConfig.DefinedSources
		  Var AllowedLootSources() As Beacon.LootSource = Data.SearchForLootSources("", Self.mMods, Preferences.ShowExperimentalLootSources)
		  For X As Integer = AllowedLootSources.LastRowIndex DownTo 0
		    If Not AllowedLootSources(X).ValidForMask(Self.mMask) Then
		      AllowedLootSources.RemoveRowAt(X)
		    End If
		  Next
		  
		  For X As Integer = 0 To CurrentSources.LastRowIndex
		    For Y As Integer = AllowedLootSources.LastRowIndex DownTo 0
		      If AllowedLootSources(Y).ClassString = CurrentSources(X).ClassString Then
		        AllowedLootSources.RemoveRowAt(Y)
		        Exit For Y
		      End If
		    Next
		  Next
		  Beacon.Sort(AllowedLootSources)
		  
		  Var Selections() As String
		  For I As Integer = 0 To Self.SourceList.RowCount - 1
		    If Not Self.SourceList.Selected(I) Then
		      Continue
		    End If
		    
		    Var Source As Beacon.LootSource = Self.SourceList.RowTagAt(I)
		    Selections.AddRow(Source.ClassString)
		  Next
		  
		  Var ScrollPosition As Integer = Self.SourceList.ScrollPosition
		  Self.SourceList.RemoveAllRows
		  
		  Var MapLabels As New Dictionary
		  For Each Source As Beacon.LootSource In AllowedLootSources
		    Var RowText As String = Labels.Lookup(Source.Path, Source.Label)
		    If Source.Notes <> "" Then
		      RowText = RowText + EndOfLine + Source.Notes
		    Else
		      Var ComboMask As UInt64 = Source.Availability And Self.mMask
		      If Not MapLabels.HasKey(ComboMask) Then
		        MapLabels.Value(ComboMask) = Beacon.Maps.ForMask(ComboMask).Label
		      End If
		      RowText = RowText + EndOfLine + "Spawns on " + MapLabels.Value(ComboMask)
		    End If
		    Self.SourceList.AddRow("", RowText)
		    Self.SourceList.RowTagAt(Self.SourceList.LastAddedRowIndex) = Source
		    Self.SourceList.Selected(Self.SourceList.LastAddedRowIndex) = Selections.IndexOf(Source.ClassString) > -1
		  Next
		  Self.SourceList.Sort
		  Self.SourceList.ScrollPosition = ScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ChooseSelectedLootSources()
		  If Self.SourceList.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Self.mDestinations.ResizeTo(-1)
		  
		  For I As Integer = 0 To Self.SourceList.RowCount - 1
		    If Not Self.SourceList.Selected(I) Then
		      Continue
		    End If
		    
		    Var Source As Beacon.LootSource = SourceList.RowTagAt(I)
		    
		    If Source.Experimental And Not Preferences.HasShownExperimentalWarning Then
		      If Self.ShowConfirm(Language.ExperimentalWarningMessage, Language.ReplacePlaceholders(Language.ExperimentalWarningExplanation, Source.Label), Language.ExperimentalWarningActionCaption, Language.ExperimentalWarningCancelCaption) Then
		        Preferences.HasShownExperimentalWarning = True
		      Else
		        Return
		      End If
		    End If
		    
		    Self.mDestinations.AddRow(Source.Clone)
		  Next
		  
		  Self.ShowCustomize()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Config As BeaconConfigs.LootDrops, Mask As UInt64, Mods As Beacon.StringList, Source As Beacon.LootSource, Duplicate As Boolean)
		  // Calling the overridden superclass constructor.
		  Self.mConfig = Config
		  Self.mMask = Mask
		  Self.mMods = Mods
		  Self.mSource = Source
		  Self.mDuplicateSource = Duplicate
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Config As BeaconConfigs.LootDrops, Mask As UInt64, Mods As Beacon.StringList, Source As Beacon.LootSource = Nil, Duplicate As Boolean = False) As Boolean
		  If Parent = Nil Or Config = Nil Then
		    Return False
		  End If
		  Parent = Parent.TrueWindow
		  
		  Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Mask)
		  If Maps.LastRowIndex = -1 Then
		    Parent.ShowAlert("Beacon does not know which loot sources to show because no maps have been selected.", "Use the menu currently labelled """ + Language.LabelForConfig(BeaconConfigs.LootDrops.ConfigName) + """ to select ""Maps"" and choose tha maps for this file.")
		    Return False
		  End If
		  
		  Var Win As New LootSourceWizard(Config, Mask, Mods, Source, Source <> Nil And Duplicate = True)
		  Win.ShowModalWithin(Parent)
		  
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowCustomize()
		  Var BasedOn As Beacon.LootSource
		  If Self.mSource <> Nil Then
		    BasedOn = Self.mSource
		  Else
		    BasedOn = New Beacon.CustomLootContainer("Template")
		  End If
		  
		  Self.CustomizeMinSetsField.Value = Format(BasedOn.MinItemSets, "-0")
		  Self.CustomizeMaxSetsField.Value = Format(BasedOn.MaxItemSets, "-0")
		  Self.CustomizePreventDuplicatesCheck.Value = BasedOn.PreventDuplicates
		  
		  Var Presets() As Beacon.Preset = Beacon.Data.Presets()
		  
		  Self.CustomizePresetsList.RemoveAllRows()
		  For Each Preset As Beacon.Preset In Presets
		    If Preset.ValidForMask(Self.mMask) Then
		      Self.CustomizePresetsList.AddRow("", Preset.Label)
		      Self.CustomizePresetsList.RowTagAt(Self.CustomizePresetsList.LastAddedRowIndex) = Preset
		    End If
		  Next
		  Self.CustomizePresetsList.Sort
		  
		  Var Scrolled, HasUsedPresets As Boolean
		  For I As Integer = 0 To Self.CustomizePresetsList.RowCount - 1
		    Var Preset As Beacon.Preset = Self.CustomizePresetsList.RowTagAt(I)
		    For Each Set As Beacon.ItemSet In BasedOn.ItemSets
		      If Set.SourcePresetID = Preset.PresetID Then
		        HasUsedPresets = True
		        Self.CustomizePresetsList.CellCheckBoxValueAt(I, 0) = True
		        If Set.Label <> Preset.Label Then
		          Self.CustomizePresetsList.CellValueAt(I, 1) = Set.Label + " (" + Preset.Label + ")"
		        End If
		        If Not Scrolled Then
		          Self.CustomizePresetsList.ScrollPosition = I
		          Scrolled = True
		        End If
		        Continue For I
		      End If
		    Next
		    
		    Self.CustomizePresetsList.CellCheckBoxValueAt(I, 0) = False
		  Next
		  
		  If HasUsedPresets = False Then
		    Self.CustomizeReconfigureCheckbox.Visible = False
		    Self.CustomizePresetsList.Height = (Self.CustomizeReconfigureCheckbox.Top + Self.CustomizeReconfigureCheckbox.Height) - Self.CustomizePresetsList.Top
		  End If
		  
		  Self.Panel.SelectedPanelIndex = Self.PaneCustomize
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDefine(FieldSource As Beacon.LootSource)
		  If FieldSource <> Nil Then
		    Self.DefineClassField.Value = FieldSource.ClassString
		    Self.DefineNameField.Value = FieldSource.Label
		    Self.DefineMinMultiplierField.Value = Format(FieldSource.Multipliers.Min, "0.0000")
		    Self.DefineMaxMultiplierField.Value = Format(FieldSource.Multipliers.Max, "0.0000")
		  End If
		  
		  Self.Panel.SelectedPanelIndex = Self.PaneDefine
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowSelect()
		  Self.Panel.SelectedPanelIndex = Self.PaneSelection
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfig As BeaconConfigs.LootDrops
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefineLabelEditingAutomatically As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefineLabelWasEditedByUser As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinations() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDuplicateSource As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Beacon.LootSource
	#tag EndProperty


	#tag Constant, Name = PaneCustomize, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PaneDefine, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PaneSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events SelectionActionButton
	#tag Event
		Sub Action()
		  Self.ChooseSelectedLootSources()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionCancelButton
	#tag Event
		Sub Action()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionCustomButton
	#tag Event
		Sub Action()
		  Self.ShowDefine(Nil)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineActionButton
	#tag Event
		Sub Action()
		  Var ClassString As String = Self.DefineClassField.Value.Trim
		  Var ClassTester As New RegEx
		  ClassTester.Options.TreatTargetAsOneLine = True
		  ClassTester.SearchPattern = "^[A-Za-z0-9_]+_C$"
		  If ClassTester.Search(ClassString) Is Nil Then
		    Self.ShowAlert("Invalid class string", "Ark class strings always end in _C. Check your class string and try again.")
		    Return
		  End If
		  
		  Var Destination As Beacon.LootSource
		  Var Source As Beacon.LootSource = Beacon.Data.GetLootSource(ClassString)
		  If Source <> Nil Then
		    Destination = Source.Clone
		  Else
		    Var Label As String = Self.DefineNameField.Value.Trim
		    If Label = "" Then
		      Self.ShowAlert("No label provided", "A loot source without a name isn't very useful is it? Enter a name and try again.")
		      Return
		    End If
		    
		    Var MinMultiplier As Double = CDbl(Self.DefineMinMultiplierField.Value)
		    Var MaxMultiplier As Double = CDbl(Self.DefineMaxMultiplierField.Value)
		    If MinMultiplier <= 0 Or MaxMultiplier <= 0 Then
		      Self.ShowAlert("Invalid multipliers", "The loot source multipliers must be greater than 0. If you do not know these values - which is common - set them to 1.0 to be safe.")
		      Return
		    End If
		    
		    Var Mask As UInt64 = Self.DefineMapsSelector.Mask
		    If Mask = 0 Then
		      Self.ShowAlert("Please select a map", "Your loot source should be available to at least one map.")
		      Return
		    End If
		    
		    Destination = New Beacon.CustomLootContainer(ClassString)
		    Beacon.CustomLootContainer(Destination).Label = Label
		    Beacon.CustomLootContainer(Destination).Availability = Mask
		    Beacon.CustomLootContainer(Destination).Multipliers = New Beacon.Range(MinMultiplier, MaxMultiplier)
		  End If
		  
		  Self.mDestinations.ResizeTo(0)
		  Self.mDestinations(0) = Destination
		  
		  Self.ShowCustomize()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineCancelButton
	#tag Event
		Sub Action()
		  If Me.Caption = "Cancel" Then
		    Self.mCancelled = True
		    Self.Hide
		    Return
		  End If
		  
		  Self.ShowSelect()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizeActionButton
	#tag Event
		Sub Action()
		  Var MinItemSets As Integer = Floor(CDbl(Self.CustomizeMinSetsField.Value))
		  Var MaxItemSets As Integer = Floor(CDbl(Self.CustomizeMaxSetsField.Value))
		  Var PreventDuplicates As Boolean = Self.CustomizePreventDuplicatesCheck.Value
		  Var AppendMode As Boolean = If(Self.mSource <> Nil, Self.mSource.AppendMode, False)
		  Var ReconfigurePresets As Boolean = Self.CustomizeReconfigureCheckbox.Value
		  
		  Var AllowedPresets(), AdditionalPresets() As String
		  For I As Integer = 0 To Self.CustomizePresetsList.RowCount - 1
		    If Not Self.CustomizePresetsList.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Var Preset As Beacon.Preset = Self.CustomizePresetsList.RowTagAt(I)
		    AllowedPresets.AddRow(Preset.PresetID)
		    AdditionalPresets.AddRow(Preset.PresetID)
		  Next
		  
		  Var SourceSets() As Beacon.ItemSet
		  If Self.mSource <> Nil Then
		    For Each Set As Beacon.ItemSet In Self.mSource.ItemSets
		      If Set.SourcePresetID = "" Or AllowedPresets.IndexOf(Set.SourcePresetID) > -1 Or LocalData.SharedInstance.GetPreset(Set.SourcePresetID) = Nil Then
		        SourceSets.AddRow(Set)
		      End If
		      
		      Var Idx As Integer = AdditionalPresets.IndexOf(Set.SourcePresetID)
		      If Idx > -1 Then
		        AdditionalPresets.RemoveRowAt(Idx)
		      End If
		    Next
		  End If
		  
		  For Each Destination As Beacon.LootSource In Self.mDestinations
		    // Clear the current contents
		    Destination.ItemSets.Clear
		    
		    // Add the clones
		    For Each Set As Beacon.ItemSet In SourceSets
		      Call Destination.ItemSets.Append(New Beacon.ItemSet(Set))
		    Next
		    
		    // Add newly selected presets
		    For Each PresetID As String In AdditionalPresets
		      Var Preset As Beacon.Preset = LocalData.SharedInstance.GetPreset(PresetID)
		      If Preset = Nil Then
		        Continue
		      End If
		      
		      Call Destination.ItemSets.Append(Beacon.ItemSet.FromPreset(Preset, Destination, Self.mMask, Self.mMods))
		    Next
		    
		    // Rebuild if necessary
		    If ReconfigurePresets Then
		      Call Destination.ReconfigurePresets(Self.mMask, Self.mMods)
		    End If
		    
		    // Apply basic settings
		    Destination.MinItemSets = MinItemSets
		    Destination.MaxItemSets = MaxItemSets
		    Destination.PreventDuplicates = PreventDuplicates
		    Destination.AppendMode = AppendMode
		    
		    Var Idx As Integer = Self.mConfig.IndexOf(Destination)
		    If Idx = -1 Then
		      Self.mConfig.Append(Destination)
		    Else
		      Self.mConfig(Idx) = Destination
		    End If
		  Next
		  
		  Self.mCancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizeCancelButton
	#tag Event
		Sub Action()
		  If Me.Caption = "Cancel" Then
		    Self.mCancelled = True
		    Self.Hide
		    Return
		  End If
		  
		  If Self.mDestinations.LastRowIndex > -1 And Self.mDestinations(0).IsOfficial = False Then
		    Self.ShowDefine(Self.mDestinations(0))
		  Else
		    Self.ShowSelect()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineNameField
	#tag Event
		Sub TextChange()
		  If Not Self.mDefineLabelEditingAutomatically Then
		    Self.mDefineLabelWasEditedByUser = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineClassField
	#tag Event
		Sub TextChange()
		  If Not Self.mDefineLabelWasEditedByUser Then
		    Self.mDefineLabelEditingAutomatically = True
		    Self.DefineNameField.Value = Beacon.LabelFromClassString(Me.Value.Trim)
		    Self.mDefineLabelEditingAutomatically = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionExperimentalCheck
	#tag Event
		Sub Action()
		  If Preferences.ShowExperimentalLootSources = Me.Value Then
		    Return
		  End If
		  
		  Preferences.ShowExperimentalLootSources = Me.Value
		  Self.BuildSourceList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceList
	#tag Event
		Sub Change()
		  SelectionActionButton.Enabled = Me.SelectedRowIndex > -1
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  #Pragma Unused TextColor
		  
		  If Column <> 0 Or Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Var PrecisionX As Double = 1 / G.ScaleX
		  Var PrecisionY As Double = 1 / G.ScaleY
		  
		  Var Source As Beacon.LootSource = Me.RowTagAt(Row)
		  Var Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, BackgroundColor)
		  Var SpaceWidth As Integer = Me.ColumnAt(Column).WidthActual
		  Var SpaceHeight As Integer = Me.DefaultRowHeight
		  
		  G.DrawPicture(Icon, NearestMultiple((SpaceWidth - Icon.Width) / 2, PrecisionX), NearestMultiple((SpaceHeight - Icon.Height) / 2, PrecisionY))
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 0 Then
		    Return False
		  End If
		  
		  Var Source1 As Beacon.LootSource = Me.RowTagAt(Row1)
		  Var Source2 As Beacon.LootSource = Me.RowTagAt(Row2)
		  
		  If Source1.SortValue > Source2.SortValue Then
		    Result = 1
		  ElseIf Source1.SortValue < Source2.SortValue Then
		    Result = -1
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Self.ChooseSelectedLootSources()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.TypeaheadColumn = 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizePresetsList
	#tag Event
		Sub Open()
		  Me.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		  Me.TypeaheadColumn = 1
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
