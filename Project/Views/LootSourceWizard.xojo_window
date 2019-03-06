#tag Window
Begin Window LootSourceWizard
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   True
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
   Resizeable      =   True
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
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   550
      Begin UITweaks.ResizedPushButton SelectionActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
         RowCount        =   0
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
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   510
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton SelectionCustomButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
         RowCount        =   0
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
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   394
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
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
         Caption         =   "Rebuild Exiting Presets"
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
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim HasExperimentalSources As Boolean = LocalData.SharedInstance.HasExperimentalLootSources(Self.mDocument.Mods)
		  If HasExperimentalSources Then
		    Self.SelectionExperimentalCheck.Value = Preferences.ShowExperimentalLootSources
		  Else
		    Self.SelectionExperimentalCheck.Visible = False
		    Self.SourceList.Height = (Self.SelectionExperimentalCheck.Top + Self.SelectionExperimentalCheck.Height) - Self.SourceList.Top
		  End If
		  Self.BuildSourceList()
		  
		  If Self.mSource <> Nil Then
		    If Self.mDuplicateSource Then
		      Self.ShowSelect()
		    Else
		      If Self.mSource.IsOfficial Then
		        Self.CustomizeCancelButton.Caption = "Cancel"
		        Redim Self.mDestinations(0)
		        Self.mDestinations(0) = New Beacon.MutableLootSource(Self.mSource)   
		        Self.ShowCustomize()
		      Else
		        Self.DefineCancelButton.Caption = "Cancel"
		        Self.ShowDefine(Self.mSource)
		      End If
		    End If
		  End If
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BuildSourceList()
		  Dim CurrentSources() As Beacon.LootSource = Self.mDocument.LootSources
		  Dim AllowedLootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("", Self.mDocument.Mods, Preferences.ShowExperimentalLootSources)
		  Dim Mask As UInt64 = Self.mDocument.MapCompatibility
		  For X As Integer = AllowedLootSources.Ubound DownTo 0
		    If Not AllowedLootSources(X).ValidForMask(Mask) Then
		      AllowedLootSources.Remove(X)
		    End If
		  Next
		  
		  For X As Integer = 0 To CurrentSources.Ubound
		    For Y As Integer = AllowedLootSources.Ubound DownTo 0
		      If AllowedLootSources(Y).ClassString = CurrentSources(X).ClassString Then
		        AllowedLootSources.Remove(Y)
		        Exit For Y
		      End If
		    Next
		  Next
		  Beacon.Sort(AllowedLootSources)
		  
		  Dim Selections() As Text
		  For I As Integer = 0 To Self.SourceList.ListCount - 1
		    If Not Self.SourceList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Source As Beacon.LootSource = Self.SourceList.RowTag(I)
		    Selections.Append(Source.ClassString)
		  Next
		  
		  Dim ScrollPosition As Integer = Self.SourceList.ScrollPosition
		  Self.SourceList.DeleteAllRows
		  
		  For Each Source As Beacon.LootSource In AllowedLootSources
		    Dim RowText As String = Source.Label
		    If Source.Notes <> "" Then
		      RowText = RowText + EndOfLine + Source.Notes
		    End If
		    Self.SourceList.AddRow("", RowText)
		    Self.SourceList.RowTag(Self.SourceList.LastIndex) = Source
		    Self.SourceList.Selected(Self.SourceList.LastIndex) = Selections.IndexOf(Source.ClassString) > -1
		  Next
		  Self.SourceList.Sort
		  Self.SourceList.ScrollPosition = ScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Document As Beacon.Document, Source As Beacon.LootSource, Duplicate As Boolean)
		  // Calling the overridden superclass constructor.
		  Self.mDocument = Document
		  Self.mSource = Source
		  Self.mDuplicateSource = Duplicate
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Preset(Parent As Window, Document As Beacon.Document, Source As Beacon.LootSource = Nil, Duplicate As Boolean = False) As Boolean
		  If Parent = Nil Or Document = Nil Then
		    Return False
		  End If
		  Parent = Parent.TrueWindow
		  
		  Dim Win As New LootSourceWizard(Document, Source, Source <> Nil And Duplicate = True)
		  Win.ShowModalWithin(Parent)
		  
		  Dim Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowCustomize()
		  Dim BasedOn As Beacon.LootSource
		  If Self.mSource <> Nil Then
		    BasedOn = Self.mSource
		  Else
		    BasedOn = New Beacon.MutableLootSource("Template", False)
		  End If
		  
		  Self.CustomizeMinSetsField.Text = Format(BasedOn.MinItemSets, "-0")
		  Self.CustomizeMaxSetsField.Text = Format(BasedOn.MaxItemSets, "-0")
		  Self.CustomizePreventDuplicatesCheck.Value = BasedOn.SetsRandomWithoutReplacement
		  
		  Dim Presets() As Beacon.Preset = Beacon.Data.Presets()
		  Dim Mask As UInt64 = Self.mDocument.MapCompatibility
		  
		  Self.CustomizePresetsList.DeleteAllRows()
		  For Each Preset As Beacon.Preset In Presets
		    If Preset.ValidForMask(Mask) Then
		      Self.CustomizePresetsList.AddRow("", Preset.Label)
		      Self.CustomizePresetsList.RowTag(Self.CustomizePresetsList.LastIndex) = Preset
		    End If
		  Next
		  Self.CustomizePresetsList.Sort
		  
		  Dim Scrolled, HasUsedPresets As Boolean
		  For I As Integer = 0 To Self.CustomizePresetsList.ListCount - 1
		    Dim Preset As Beacon.Preset = Self.CustomizePresetsList.RowTag(I)
		    For Each Set As Beacon.ItemSet In BasedOn
		      If Set.SourcePresetID = Preset.PresetID Then
		        HasUsedPresets = True
		        Self.CustomizePresetsList.CellCheck(I, 0) = True
		        If Set.Label <> Preset.Label Then
		          Self.CustomizePresetsList.Cell(I, 1) = Set.Label + " (" + Preset.Label + ")"
		        End If
		        If Not Scrolled Then
		          Self.CustomizePresetsList.ScrollPosition = I
		          Scrolled = True
		        End If
		        Continue For I
		      End If
		    Next
		    
		    Self.CustomizePresetsList.CellCheck(I, 0) = False
		  Next
		  
		  If HasUsedPresets = False Then
		    Self.CustomizeReconfigureCheckbox.Visible = False
		    Self.CustomizePresetsList.Height = (Self.CustomizeReconfigureCheckbox.Top + Self.CustomizeReconfigureCheckbox.Height) - Self.CustomizePresetsList.Top
		  End If
		  
		  Self.Panel.Value = Self.PaneCustomize
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDefine(FieldSource As Beacon.LootSource)
		  If FieldSource <> Nil Then
		    Self.DefineClassField.Text = FieldSource.ClassString
		    Self.DefineNameField.Text = FieldSource.Label
		    Self.DefineMinMultiplierField.Text = Format(FieldSource.Multipliers.Min, "0.0000")
		    Self.DefineMaxMultiplierField.Text = Format(FieldSource.Multipliers.Max, "0.0000")
		  End If
		  
		  Self.Panel.Value = Self.PaneDefine
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowSelect()
		  Self.Panel.Value = Self.PaneSelection
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinations() As Beacon.MutableLootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDuplicateSource As Boolean
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
		  Redim Self.mDestinations(-1)
		  
		  For I As Integer = 0 To Self.SourceList.ListCount - 1
		    If Not Self.SourceList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Source As Beacon.LootSource = SourceList.RowTag(I)
		    
		    If Source.Experimental And Not Preferences.HasShownExperimentalWarning Then
		      If Self.ShowConfirm(Language.ExperimentalWarningMessage, Language.ReplacePlaceholders(Language.ExperimentalWarningExplanation, Source.Label), Language.ExperimentalWarningActionCaption, Language.ExperimentalWarningCancelCaption) Then
		        Preferences.HasShownExperimentalWarning = True
		      Else
		        Return
		      End If
		    End If
		    
		    Self.mDestinations.Append(New Beacon.MutableLootSource(Source))
		  Next
		  
		  Self.ShowCustomize()
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
#tag Events SourceList
	#tag Event
		Sub Change()
		  SelectionActionButton.Enabled = Me.ListIndex > -1
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  #Pragma Unused TextColor
		  
		  If Column <> 0 Or Row >= Me.ListCount Then
		    Return
		  End If
		  
		  Dim PrecisionX As Double = 1 / G.ScaleX
		  Dim PrecisionY As Double = 1 / G.ScaleY
		  
		  Dim Source As Beacon.LootSource = Me.RowTag(Row)
		  Dim Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, BackgroundColor)
		  Dim SpaceWidth As Integer = Me.Column(Column).WidthActual
		  Dim SpaceHeight As Integer = Me.DefaultRowHeight
		  
		  G.DrawPicture(Icon, NearestMultiple((SpaceWidth - Icon.Width) / 2, PrecisionX), NearestMultiple((SpaceHeight - Icon.Height) / 2, PrecisionY))
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 0 Then
		    Return False
		  End If
		  
		  Dim Source1 As Beacon.LootSource = Me.RowTag(Row1)
		  Dim Source2 As Beacon.LootSource = Me.RowTag(Row2)
		  
		  If Source1.SortValue > Source2.SortValue Then
		    Result = 1
		  ElseIf Source1.SortValue < Source2.SortValue Then
		    Result = -1
		  End If
		  
		  Return True
		End Function
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
		  Dim ClassString As Text = Self.DefineClassField.Text.ToText.Trim
		  If Not ClassString.EndsWith("_C") Then
		    Self.ShowAlert("Invalid class string", "Ark class strings always end in _C. Check your class string and try again.")
		    Return
		  End If
		  
		  Dim Destination As Beacon.MutableLootSource
		  Dim Source As Beacon.LootSource = Beacon.Data.GetLootSource(ClassString)
		  If Source <> Nil Then
		    Destination = New Beacon.MutableLootSource(Source)
		  Else
		    Dim Label As Text = Self.DefineNameField.Text.ToText.Trim
		    If Label = "" Then
		      Self.ShowAlert("No label provided", "A loot source without a name isn't very useful is it? Enter a name and try again.")
		      Return
		    End If
		    
		    Dim MinMultiplier As Double = CDbl(Self.DefineMinMultiplierField.Text)
		    Dim MaxMultiplier As Double = CDbl(Self.DefineMaxMultiplierField.Text)
		    If MinMultiplier <= 0 Or MaxMultiplier <= 0 Then
		      Self.ShowAlert("Invalid multipliers", "The loot source multipliers must be greater than 0. If you do not know these values - which is common - set them to 1.0 to be safe.")
		      Return
		    End If
		    
		    Destination = New Beacon.MutableLootSource(ClassString, False)
		    Destination.Label = Label
		    Destination.Availability = Self.mDocument.MapCompatibility
		    Destination.Multipliers = New Beacon.Range(MinMultiplier, MaxMultiplier)
		    Destination.IsOfficial = False
		    Destination.UseBlueprints = False
		  End If
		  
		  Redim Self.mDestinations(0)
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
		  Dim MinItemSets As Integer = Floor(CDbl(Self.CustomizeMinSetsField.Text))
		  Dim MaxItemSets As Integer = Floor(CDbl(Self.CustomizeMaxSetsField.Text))
		  Dim PreventDuplicates As Boolean = Self.CustomizePreventDuplicatesCheck.Value
		  Dim AppendMode As Boolean = False
		  Dim ReconfigurePresets As Boolean = Self.CustomizeReconfigureCheckbox.Value
		  Dim Mask As UInt64 = Self.mDocument.MapCompatibility
		  Dim Mods As Beacon.TextList = Self.mDocument.Mods
		  
		  Dim AllowedPresets(), AdditionalPresets() As Text
		  For I As Integer = 0 To Self.CustomizePresetsList.ListCount - 1
		    If Not Self.CustomizePresetsList.CellCheck(I, 0) Then
		      Continue
		    End If
		    
		    Dim Preset As Beacon.Preset = Self.CustomizePresetsList.RowTag(I)
		    AllowedPresets.Append(Preset.PresetID)
		    AdditionalPresets.Append(Preset.PresetID)
		  Next
		  
		  Dim SourceSets() As Beacon.ItemSet
		  If Self.mSource <> Nil Then
		    For Each Set As Beacon.ItemSet In Self.mSource
		      If Set.SourcePresetID = "" Or AllowedPresets.IndexOf(Set.SourcePresetID) > -1 Or LocalData.SharedInstance.GetPreset(Set.SourcePresetID) = Nil Then
		        SourceSets.Append(Set)
		      End If
		      
		      Dim Idx As Integer = AdditionalPresets.IndexOf(Set.SourcePresetID)
		      If Idx > -1 Then
		        AdditionalPresets.Remove(Idx)
		      End If
		    Next
		  End If
		  
		  For Each Destination As Beacon.MutableLootSource In Self.mDestinations
		    // Clear the current contents
		    Redim Destination(-1)
		    
		    // Add the clones
		    For Each Set As Beacon.ItemSet In SourceSets
		      Destination.Append(New Beacon.ItemSet(Set))
		    Next
		    
		    // Add newly selected presets
		    For Each PresetID As Text In AdditionalPresets
		      Dim Preset As Beacon.Preset = LocalData.SharedInstance.GetPreset(PresetID)
		      If Preset = Nil Then
		        Continue
		      End If
		      
		      Dim Set As Beacon.ItemSet = Beacon.ItemSet.FromPreset(Preset, Destination, Mask, Mods)
		      Destination.Append(Set)
		    Next
		    
		    // Rebuild if necessary
		    If Self.CustomizeReconfigureCheckbox.Value Then
		      Destination.ReconfigurePresets(Mask, Mods)
		    End If
		    
		    // Apply basic settings
		    Destination.MinItemSets = MinItemSets
		    Destination.MaxItemSets = MaxItemSets
		    Destination.SetsRandomWithoutReplacement = PreventDuplicates
		    Destination.AppendMode = AppendMode
		    
		    Self.mDocument.Add(Destination)
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
		  
		  If Self.mDestinations.Ubound > -1 And Self.mDestinations(0).IsOfficial = False Then
		    Self.ShowDefine(Self.mDestinations(0))
		  Else
		    Self.ShowSelect()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizePresetsList
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = ListBox.TypeCheckbox
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
