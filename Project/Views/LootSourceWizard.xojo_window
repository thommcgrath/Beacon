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
         DefaultRowHeight=   30
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   0
         Height          =   294
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
         SelectionType   =   0
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
         TabIndex        =   14
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
         TabIndex        =   13
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
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Max Multiplier:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   188
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
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Min Multiplier:"
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
      Begin UITweaks.ResizedLabel DefineKindLabel
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
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Kind:"
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
      Begin UITweaks.ResizedPopupMenu DefineKindMenu
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   ""
         Italic          =   False
         Left            =   136
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   122
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   260
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
         TabIndex        =   12
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   188
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
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   154
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
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BuildSourceList(CurrentSources() As Beacon.LootSource, ConsoleSafe As Boolean)
		  Dim AllowedLootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("", ConsoleSafe)
		  For X As Integer = UBound(AllowedLootSources) DownTo 0
		    If Not AllowedLootSources(X).ValidForMask(Self.mCurrentMask) Then
		      AllowedLootSources.Remove(X)
		    End If
		  Next
		  
		  For X As Integer = 0 To UBound(CurrentSources)
		    For Y As Integer = UBound(AllowedLootSources) DownTo 0
		      If AllowedLootSources(Y).ClassString = CurrentSources(X).ClassString Then
		        AllowedLootSources.Remove(Y)
		        Exit For Y
		      End If
		    Next
		  Next
		  Beacon.Sort(AllowedLootSources)
		  
		  For Each Source As Beacon.LootSource In AllowedLootSources
		    SourceList.AddRow("", Source.Label)
		    SourceList.RowTag(SourceList.LastIndex) = Source
		  Next
		  
		  SourceList.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckDefineReady()
		  Self.DefineActionButton.Enabled = DefineClassField.Text.Right(2) = "_C" And DefineNameField.Text <> "" And DefineKindMenu.ListIndex > -1 And DefineMinMultiplierField.Text <> "" And DefineMaxMultiplierField.Text <> ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PresentAdd(Parent As Window, Document As Beacon.Document) As Beacon.LootSource
		  Dim Win As New LootSourceWizard
		  Win.mCurrentMask = Document.MapCompatibility
		  Win.mConsoleSafe = Document.ConsoleModsOnly
		  Win.BuildSourceList(Document.LootSources, Document.ConsoleModsOnly)
		  Win.mOriginal = Nil
		  Win.ShowModalWithin(Parent)
		  
		  Dim NewSource As Beacon.LootSource
		  If Not Win.mCancelled Then
		    NewSource = New Beacon.LootSource(Win.mEditing)
		  End If
		  Return NewSource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PresentDuplicate(Parent As Window, Document As Beacon.Document, Source As Beacon.LootSource) As Beacon.LootSource
		  Dim Win As New LootSourceWizard
		  Win.mCurrentMask = Document.MapCompatibility
		  Win.mConsoleSafe = Document.ConsoleModsOnly
		  Win.BuildSourceList(Document.LootSources, Document.ConsoleModsOnly)
		  Win.mOriginal = New Beacon.LootSource(Source)
		  Win.ShowModalWithin(Parent)
		  
		  Dim Duplicated As Beacon.LootSource
		  If Not Win.mCancelled Then
		    Duplicated = New Beacon.LootSource(Win.mEditing)
		  End If
		  Return Duplicated
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PresentEdit(Parent As Window, Document As Beacon.Document, Source As Beacon.LootSource) As Beacon.LootSource
		  Dim Win As New LootSourceWizard
		  Win.mCurrentMask = Document.MapCompatibility
		  Win.mConsoleSafe = Document.ConsoleModsOnly
		  Win.BuildSourceList(Document.LootSources, Document.ConsoleModsOnly)
		  Win.mOriginal = New Beacon.LootSource(Source)
		  Win.mEditing = New Beacon.MutableLootSource(Source)
		  
		  If Source.IsOfficial Then
		    Win.Panel.Value = Win.PaneCustomize
		    Win.CustomizeCancelButton.Caption = "Cancel"
		  Else
		    Win.Panel.Value = Win.PaneDefine
		    Win.DefineCancelButton.Caption = "Cancel"
		  End If
		  
		  Win.ShowModalWithin(Parent)
		  
		  Dim Edited As Beacon.LootSource
		  If Not Win.mCancelled Then
		    Edited = New Beacon.LootSource(Win.mEditing)
		  End If
		  Return Edited
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditing As Beacon.MutableLootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginal As Beacon.LootSource
	#tag EndProperty


	#tag Constant, Name = PaneCustomize, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PaneDefine, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PaneSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Panel
	#tag Event
		Sub Change()
		  Select Case Me.Value
		  Case Self.PaneSelection
		    
		  Case Self.PaneDefine
		    DefineClassField.Text = Self.mEditing.ClassString
		    DefineNameField.Text = Self.mEditing.Label
		    DefineMinMultiplierField.Text = Format(Self.mEditing.Multipliers.Min, "0.0000")
		    DefineMaxMultiplierField.Text = Format(Self.mEditing.Multipliers.Max, "0.0000")
		    DefineKindMenu.SelectByTag(Self.mEditing.Kind)
		    Self.CheckDefineReady()
		  Case Self.PaneCustomize
		    CustomizeMinSetsField.Text = Format(Self.mEditing.MinItemSets, "-0")
		    CustomizeMaxSetsField.Text = Format(Self.mEditing.MaxItemSets, "-0")
		    CustomizePreventDuplicatesCheck.Value = Self.mEditing.SetsRandomWithoutReplacement
		    
		    Dim Presets() As Beacon.Preset = Beacon.Data.Presets()
		    
		    CustomizePresetsList.DeleteAllRows()
		    For Each Preset As Beacon.Preset In Presets
		      If Preset.ValidForMask(Self.mCurrentMask) Then
		        CustomizePresetsList.AddRow("", Preset.Label)
		        CustomizePresetsList.RowTag(CustomizePresetsList.LastIndex) = Preset
		      End If
		    Next
		    CustomizePresetsList.Sort
		    
		    Dim Scrolled As Boolean
		    For I As Integer = 0 To CustomizePresetsList.ListCount - 1
		      Dim Preset As Beacon.Preset = CustomizePresetsList.RowTag(I)
		      For Each Set As Beacon.ItemSet In Self.mEditing
		        If Set.SourcePresetID = Preset.PresetID Then
		          CustomizePresetsList.CellCheck(I, 0) = True
		          If Set.Label <> Preset.Label Then
		            CustomizePresetsList.Cell(I, 1) = Set.Label + " (" + Preset.Label + ")"
		          End If
		          If Not Scrolled Then
		            CustomizePresetsList.ScrollPosition = I
		            Scrolled = True
		          End If
		          Continue For I
		        End If
		      Next
		      
		      CustomizePresetsList.CellCheck(I, 0) = False
		    Next
		    
		    If Self.mOriginal = Nil Then
		      CustomizeReconfigureCheckbox.Visible = False
		      CustomizePresetsList.Height = (CustomizeReconfigureCheckbox.Top + CustomizeReconfigureCheckbox.Height) - CustomizePresetsList.Top
		    End If
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionActionButton
	#tag Event
		Sub Action()
		  Dim Source As Beacon.LootSource = SourceList.RowTag(SourceList.ListIndex)
		  If Self.mOriginal <> Nil Then
		    Dim MutableSource As New Beacon.MutableLootSource(Self.mOriginal)
		    MutableSource.ClassString = Source.ClassString
		    MutableSource.Label = Source.Label
		    MutableSource.Kind = Source.Kind
		    MutableSource.Availability = Source.Availability
		    MutableSource.Multipliers = New Beacon.Range(Source.Multipliers.Min, Source.Multipliers.Max)
		    MutableSource.IsOfficial = Source.IsOfficial
		    MutableSource.SortValue = Source.SortValue
		    MutableSource.UIColor = Source.UIColor
		    Self.mEditing = MutableSource
		  Else
		    Self.mEditing = New Beacon.MutableLootSource(Source)
		  End If
		  Panel.Value = Self.PaneCustomize
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
		  
		  If Column <> 0 Or Row >= Me.ListCount Then
		    Return
		  End If
		  
		  Dim Source As Beacon.LootSource = Me.RowTag(Row)
		  Dim Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, RGB(TextColor.Red, TextColor.Green, TextColor.Blue, 150))
		  Dim SpaceWidth As Integer = Me.Column(Column).WidthActual
		  Dim SpaceHeight As Integer = Me.DefaultRowHeight
		  
		  G.DrawPicture(Icon, (SpaceWidth - Icon.Width) / 2, (SpaceHeight - Icon.Height) / 2)
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
		  If Self.mOriginal <> Nil Then
		    Self.mEditing = New Beacon.MutableLootSource(Self.mOriginal)
		  Else
		    Self.mEditing = New Beacon.MutableLootSource("", False)
		  End If
		  Panel.Value = Self.PaneDefine
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineActionButton
	#tag Event
		Sub Action()
		  Dim Source As Beacon.LootSource = Beacon.Data.GetLootSource(DefineClassField.Text.ToText)
		  If Source <> Nil Then
		    // User entered a known loot source
		    Self.mEditing.ClassString = Source.ClassString
		    Self.mEditing.Label = Source.Label
		    Self.mEditing.Kind = Source.Kind
		    Self.mEditing.Availability = Source.Availability
		    Self.mEditing.Multipliers = New Beacon.Range(Source.Multipliers.Min, Source.Multipliers.Max)
		    Self.mEditing.IsOfficial = True
		    Self.mEditing.UseBlueprints = Source.UseBlueprints
		  Else
		    Self.mEditing.ClassString = DefineClassField.Text.ToText
		    Self.mEditing.Label = DefineNameField.Text.ToText
		    Self.mEditing.Kind = CType(DefineKindMenu.RowTag(DefineKindMenu.ListIndex), Beacon.LootSource.Kinds)
		    Self.mEditing.Availability = Self.mCurrentMask
		    Self.mEditing.Multipliers = New Beacon.Range(CDbl(DefineMinMultiplierField.Text), CDbl(DefineMaxMultiplierField.Text))
		    Self.mEditing.IsOfficial = False
		    Self.mEditing.UseBlueprints = False
		  End If
		  
		  Panel.Value = Self.PaneCustomize
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
		  
		  Panel.Value = Self.PaneSelection
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizeActionButton
	#tag Event
		Sub Action()
		  Self.mEditing.MinItemSets = CDbl(CustomizeMinSetsField.Text)
		  Self.mEditing.MaxItemSets = CDbl(CustomizeMaxSetsField.Text)
		  Self.mEditing.SetsRandomWithoutReplacement = CustomizePreventDuplicatesCheck.Value
		  Self.mEditing.AppendMode = False
		  
		  For I As Integer = 0 To CustomizePresetsList.ListCount - 1
		    Dim Preset As Beacon.Preset = CustomizePresetsList.RowTag(I)
		    If CustomizePresetsList.CellCheck(I, 0) Then
		      For X As Integer = 0 To UBound(Self.mEditing)
		        Dim Set As Beacon.ItemSet = Self.mEditing(X)
		        If Set.SourcePresetID = Preset.PresetID Then
		          If CustomizeReconfigureCheckbox.Value Then
		            // Wants to rebuild it
		            Self.mEditing(X).ReconfigureWithPreset(Preset, Self.mEditing, Self.mCurrentMask, Self.mConsoleSafe)
		          End If
		          Continue For I
		        End If
		      Next
		      
		      Dim Set As Beacon.ItemSet = Beacon.ItemSet.FromPreset(Preset, Self.mEditing, Self.mCurrentMask, Self.mConsoleSafe)
		      Self.mEditing.Append(Set)
		    Else
		      For X As Integer = 0 To UBound(Self.mEditing)
		        Dim Set As Beacon.ItemSet = Self.mEditing(X)
		        If Set.SourcePresetID = Preset.PresetID Then
		          // Remove this set
		          Self.mEditing.Remove(X)
		          Continue For I
		        End If
		      Next
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
		  
		  If Self.mEditing.IsOfficial Then
		    Panel.Value = Self.PaneSelection
		  Else
		    Panel.Value = Self.PaneDefine
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineKindMenu
	#tag Event
		Sub Open()
		  Me.AddRow(Language.LootSourceKindStandard)
		  Me.AddRow(Language.LootSourceKindBonus)
		  Me.AddRow(Language.LootSourceKindCave)
		  Me.AddRow(Language.LootSourceKindSea)
		  
		  Me.RowTag(0) = Beacon.LootSource.Kinds.Standard
		  Me.RowTag(1) = Beacon.LootSource.Kinds.Bonus
		  Me.RowTag(2) = Beacon.LootSource.Kinds.Cave
		  Me.RowTag(3) = Beacon.LootSource.Kinds.Sea
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.CheckDefineReady()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineMaxMultiplierField
	#tag Event
		Sub TextChange()
		  Self.CheckDefineReady()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineMinMultiplierField
	#tag Event
		Sub TextChange()
		  Self.CheckDefineReady()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineNameField
	#tag Event
		Sub TextChange()
		  Self.CheckDefineReady()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineClassField
	#tag Event
		Sub TextChange()
		  Self.CheckDefineReady()
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
