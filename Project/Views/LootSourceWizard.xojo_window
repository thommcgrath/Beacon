#tag Window
Begin BeaconDialog LootSourceWizard
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   DefaultLocation =   "1"
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   False
   MinimumHeight   =   300
   MinimumWidth    =   450
   MinWidth        =   450
   Placement       =   1
   Resizable       =   True
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Add Loot Source"
   Type            =   "8"
   Visible         =   True
   Width           =   550
   Begin PagePanel Panel
      AllowAutoDeactivate=   True
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
      SelectedPanelIndex=   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   550
      Begin UITweaks.ResizedPushButton SelectionActionButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton SelectionCancelButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label SelectionMessageLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Value           =   "Add Loot Source"
         Visible         =   True
         Width           =   510
      End
      Begin BeaconListbox SourceList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
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
         DropIndicatorVisible=   False
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontal=   "0"
         GridLinesHorizontalStyle=   "0"
         GridLinesVertical=   "0"
         GridLinesVerticalStyle=   "0"
         HasBorder       =   True
         HasHeader       =   True
         HasHeading      =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
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
         RowSelectionType=   "1"
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   "1"
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
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
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Custom Loot Source…"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   160
      End
      Begin Label DefineMessageLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Value           =   "Define Loot Source"
         Visible         =   True
         Width           =   510
      End
      Begin UITweaks.ResizedPushButton DefineActionButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DefineCancelButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Back"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CustomizeActionButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Done"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CustomizeCancelButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Back"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label CustomizeMessageLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Value           =   "Customize Loot Source"
         Visible         =   True
         Width           =   510
      End
      Begin UITweaks.ResizedLabel DefineMaxMultiplierLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   156
         Transparent     =   True
         Underline       =   False
         Value           =   "Max Multiplier:"
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedLabel DefineMinMultiplierLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   122
         Transparent     =   True
         Underline       =   False
         Value           =   "Min Multiplier:"
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedLabel DefineClassLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   54
         Transparent     =   True
         Underline       =   False
         Value           =   "Class String:"
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedLabel DefineNameLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   88
         Transparent     =   True
         Underline       =   False
         Value           =   "Label:"
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedTextField DefineMaxMultiplierField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
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
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   156
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField DefineMinMultiplierField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
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
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   122
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField DefineNameField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
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
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   88
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   394
      End
      Begin UITweaks.ResizedTextField DefineClassField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "ExampleSourceClass_C"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   "ExampleSourceClass_C"
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
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   394
      End
      Begin UITweaks.ResizedTextField CustomizeMinSetsField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
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
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   "###"
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel CustomizeMinSetsLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   54
         Transparent     =   True
         Underline       =   False
         Value           =   "Min Sets:"
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedTextField CustomizeMaxSetsField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
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
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   88
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   "###"
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel CustomizeMaxSetsLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   88
         Transparent     =   True
         Underline       =   False
         Value           =   "Max Sets:"
         Visible         =   True
         Width           =   104
      End
      Begin CheckBox CustomizePreventDuplicatesCheck
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Prevent Duplicates"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         State           =   "0"
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   122
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   394
      End
      Begin BeaconListbox CustomizePresetsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
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
         DropIndicatorVisible=   False
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontal=   "0"
         GridLinesHorizontalStyle=   "0"
         GridLinesVertical=   "0"
         GridLinesVerticalStyle=   "0"
         HasBorder       =   True
         HasHeader       =   False
         HasHeading      =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
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
         RowSelectionType=   "0"
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   "0"
         ShowDropIndicator=   False
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
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
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   154
         Transparent     =   True
         Underline       =   False
         Value           =   "Presets:"
         Visible         =   True
         Width           =   104
      End
      Begin CheckBox CustomizeReconfigureCheckbox
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Rebuild Existing Presets"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         State           =   "0"
         TabIndex        =   8
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   "When enabled, the existing item sets will be emptied and refilled according to their original preset."
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   394
      End
      Begin CheckBox SelectionExperimentalCheck
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Show Experimental Loot Sources"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         State           =   "0"
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   510
      End
      Begin UITweaks.ResizedLabel DefineMapsLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
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
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         HasBackgroundColor=   False
         Height          =   118
         HelpTag         =   ""
         InitialParent   =   "Panel"
         Left            =   130
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   14
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   184
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   400
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Dim HasExperimentalSources As Boolean = LocalData.SharedInstance.HasExperimentalLootSources(Self.mMods)
		  If HasExperimentalSources Then
		    Self.SelectionExperimentalCheck.Value = Preferences.ShowExperimentalLootSources
		  Else
		    Self.SelectionExperimentalCheck.Visible = False
		    Self.SourceList.Height = (Self.SelectionExperimentalCheck.Top + Self.SelectionExperimentalCheck.Height) - Self.SourceList.Top
		  End If
		  Self.BuildSourceList()
		  
		  Dim Mask As UInt64 = Self.mMask
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
		        Mask = Self.mSource.Availability
		        Self.ShowDefine(Self.mSource)
		      End If
		    End If
		  End If
		  
		  Self.DefineMapsSelector.Mask = Mask
		  Dim DesiredWinHeight As Integer = Self.DefineMapsSelector.Top + Self.DefineMapsSelector.Height + 6 + Self.DefineActionButton.Height + 20
		  Dim Diff As Integer = DesiredWinHeight - Self.Height
		  Self.Height = Self.Height + Diff
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BuildSourceList()
		  Dim CurrentSources() As Beacon.LootSource = Self.mConfig.DefinedSources
		  Dim AllowedLootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("", Self.mMods, Preferences.ShowExperimentalLootSources)
		  For X As Integer = AllowedLootSources.LastRowIndex DownTo 0
		    If Not AllowedLootSources(X).ValidForMask(Self.mMask) Then
		      AllowedLootSources.Remove(X)
		    End If
		  Next
		  
		  For X As Integer = 0 To CurrentSources.LastRowIndex
		    For Y As Integer = AllowedLootSources.LastRowIndex DownTo 0
		      If AllowedLootSources(Y).ClassString = CurrentSources(X).ClassString Then
		        AllowedLootSources.Remove(Y)
		        Exit For Y
		      End If
		    Next
		  Next
		  Beacon.Sort(AllowedLootSources)
		  
		  Dim Selections() As String
		  For I As Integer = 0 To Self.SourceList.RowCount - 1
		    If Not Self.SourceList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Source As Beacon.LootSource = Self.SourceList.RowTagAt(I)
		    Selections.Append(Source.ClassString)
		  Next
		  
		  Dim ScrollPosition As Integer = Self.SourceList.ScrollPosition
		  Self.SourceList.RemoveAllRows
		  
		  Dim MapLabels As New Dictionary
		  For Each Source As Beacon.LootSource In AllowedLootSources
		    Dim RowText As String = Source.Label
		    If Source.Notes <> "" Then
		      RowText = RowText + EndOfLine + Source.Notes
		    Else
		      Dim ComboMask As UInt64 = Source.Availability And Self.mMask
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
		  
		  Redim Self.mDestinations(-1)
		  
		  For I As Integer = 0 To Self.SourceList.RowCount - 1
		    If Not Self.SourceList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Source As Beacon.LootSource = SourceList.RowTagAt(I)
		    
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
		  
		  Dim Maps() As Beacon.Map = Beacon.Maps.ForMask(Mask)
		  If Maps.LastRowIndex = -1 Then
		    Parent.ShowAlert("Beacon does not know which loot sources to show because no maps have been selected.", "Use the menu currently labelled """ + Language.LabelForConfig(BeaconConfigs.LootDrops.ConfigName) + """ to select ""Maps"" and choose tha maps for this file.")
		    Return False
		  End If
		  
		  Dim Win As New LootSourceWizard(Config, Mask, Mods, Source, Source <> Nil And Duplicate = True)
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
		  
		  Self.CustomizeMinSetsField.Value = Format(BasedOn.MinItemSets, "-0")
		  Self.CustomizeMaxSetsField.Value = Format(BasedOn.MaxItemSets, "-0")
		  Self.CustomizePreventDuplicatesCheck.Value = BasedOn.SetsRandomWithoutReplacement
		  
		  Dim Presets() As Beacon.Preset = Beacon.Data.Presets()
		  
		  Self.CustomizePresetsList.RemoveAllRows()
		  For Each Preset As Beacon.Preset In Presets
		    If Preset.ValidForMask(Self.mMask) Then
		      Self.CustomizePresetsList.AddRow("", Preset.Label)
		      Self.CustomizePresetsList.RowTagAt(Self.CustomizePresetsList.LastAddedRowIndex) = Preset
		    End If
		  Next
		  Self.CustomizePresetsList.Sort
		  
		  Dim Scrolled, HasUsedPresets As Boolean
		  For I As Integer = 0 To Self.CustomizePresetsList.RowCount - 1
		    Dim Preset As Beacon.Preset = Self.CustomizePresetsList.RowTagAt(I)
		    For Each Set As Beacon.ItemSet In BasedOn
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
		Private mDestinations() As Beacon.MutableLootSource
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
		Sub Pressed()
		  Self.ChooseSelectedLootSources()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionCancelButton
	#tag Event
		Sub Pressed()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceList
	#tag Event
		Sub SelectionChanged()
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
		  
		  Dim PrecisionX As Double = 1 / G.ScaleX
		  Dim PrecisionY As Double = 1 / G.ScaleY
		  
		  Dim Source As Beacon.LootSource = Me.RowTagAt(Row)
		  Dim Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, BackgroundColor)
		  Dim SpaceWidth As Integer = Me.ColumnAt(Column).WidthActual
		  Dim SpaceHeight As Integer = Me.DefaultRowHeight
		  
		  G.DrawPicture(Icon, NearestMultiple((SpaceWidth - Icon.Width) / 2, PrecisionX), NearestMultiple((SpaceHeight - Icon.Height) / 2, PrecisionY))
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClicked()
		  Self.ChooseSelectedLootSources()
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 0 Then
		    Return False
		  End If
		  
		  Dim Source1 As Beacon.LootSource = Me.RowTagAt(Row1)
		  Dim Source2 As Beacon.LootSource = Me.RowTagAt(Row2)
		  
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
		Sub Pressed()
		  Self.ShowDefine(Nil)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DefineActionButton
	#tag Event
		Sub Pressed()
		  Dim ClassString As String = Self.DefineClassField.Value.Trim
		  If Not ClassString.EndsWith("_C") Then
		    Self.ShowAlert("Invalid class string", "Ark class strings always end in _C. Check your class string and try again.")
		    Return
		  End If
		  
		  Dim Destination As Beacon.MutableLootSource
		  Dim Source As Beacon.LootSource = Beacon.Data.GetLootSource(ClassString)
		  If Source <> Nil Then
		    Destination = New Beacon.MutableLootSource(Source)
		  Else
		    Dim Label As String = Self.DefineNameField.Value.Trim
		    If Label = "" Then
		      Self.ShowAlert("No label provided", "A loot source without a name isn't very useful is it? Enter a name and try again.")
		      Return
		    End If
		    
		    Dim MinMultiplier As Double = CDbl(Self.DefineMinMultiplierField.Value)
		    Dim MaxMultiplier As Double = CDbl(Self.DefineMaxMultiplierField.Value)
		    If MinMultiplier <= 0 Or MaxMultiplier <= 0 Then
		      Self.ShowAlert("Invalid multipliers", "The loot source multipliers must be greater than 0. If you do not know these values - which is common - set them to 1.0 to be safe.")
		      Return
		    End If
		    
		    Dim Mask As UInt64 = Self.DefineMapsSelector.Mask
		    If Mask = 0 Then
		      Self.ShowAlert("Please select a map", "Your loot source should be available to at least one map.")
		      Return
		    End If
		    
		    Destination = New Beacon.MutableLootSource(ClassString, False)
		    Destination.Label = Label
		    Destination.Availability = Mask
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
		Sub Pressed()
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
		Sub Pressed()
		  Dim MinItemSets As Integer = Floor(CDbl(Self.CustomizeMinSetsField.Value))
		  Dim MaxItemSets As Integer = Floor(CDbl(Self.CustomizeMaxSetsField.Value))
		  Dim PreventDuplicates As Boolean = Self.CustomizePreventDuplicatesCheck.Value
		  Dim AppendMode As Boolean = If(Self.mSource <> Nil, Self.mSource.AppendMode, False)
		  Dim ReconfigurePresets As Boolean = Self.CustomizeReconfigureCheckbox.Value
		  
		  Dim AllowedPresets(), AdditionalPresets() As String
		  For I As Integer = 0 To Self.CustomizePresetsList.RowCount - 1
		    If Not Self.CustomizePresetsList.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Dim Preset As Beacon.Preset = Self.CustomizePresetsList.RowTagAt(I)
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
		    For Each PresetID As String In AdditionalPresets
		      Dim Preset As Beacon.Preset = LocalData.SharedInstance.GetPreset(PresetID)
		      If Preset = Nil Then
		        Continue
		      End If
		      
		      Dim Set As Beacon.ItemSet = Beacon.ItemSet.FromPreset(Preset, Destination, Self.mMask, Self.mMods)
		      Destination.Append(Set)
		    Next
		    
		    // Rebuild if necessary
		    If ReconfigurePresets Then
		      Call Destination.ReconfigurePresets(Self.mMask, Self.mMods)
		    End If
		    
		    // Apply basic settings
		    Destination.MinItemSets = MinItemSets
		    Destination.MaxItemSets = MaxItemSets
		    Destination.SetsRandomWithoutReplacement = PreventDuplicates
		    Destination.AppendMode = AppendMode
		    
		    Dim Idx As Integer = Self.mConfig.IndexOf(Destination)
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
		Sub Pressed()
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
#tag Events CustomizePresetsList
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionExperimentalCheck
	#tag Event
		Sub ValueChanged()
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
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		Name="Resizable"
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
