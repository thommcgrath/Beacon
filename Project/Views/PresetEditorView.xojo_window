#tag Window
Begin BeaconSubview PresetEditorView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   556
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
   Width           =   740
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   ""
      Enabled         =   True
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Resizer         =   ""
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   10
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   200
   End
   Begin FadedSeparator HeaderSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Enabled         =   True
      Height          =   1
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
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   740
   End
   Begin Shelf ViewSelector
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DrawCaptions    =   True
      Enabled         =   True
      Height          =   60
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      IsVertical      =   False
      Left            =   200
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   340
   End
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   495
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   740
      BeginSegmented SegmentedButton MapSelector
         Enabled         =   True
         Height          =   24
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         Segments        =   "The Island\n\nFalse\rScorched Earth\n\nFalse\rAberration\n\nFalse\rExtinction\n\nFalse\rThe Center\n\nFalse\rRagnarok\n\nFalse\rValguero\n\nFalse"
         SelectionStyle  =   "0"
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   81
         Transparent     =   False
         Visible         =   True
         Width           =   660
      End
      Begin BeaconListbox ContentsList
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
         ColumnCount     =   5
         ColumnsResizable=   False
         ColumnWidths    =   "30,*,100,120,100"
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
         HasHeader       =   True
         HasHeading      =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   "#ColumnDescription"
         Height          =   379
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   " 	Engram	Quantity	Quality	Blueprint %"
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
         SelectionRequired=   False
         SelectionType   =   "1"
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   125
         Transparent     =   True
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   700
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label LockExplanationLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Checking the box next to a quantity, quality, or blueprint chance will allow the values to be adjusted by modifiers."
         TextAlign       =   "1"
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   516
         Transparent     =   True
         Underline       =   False
         Value           =   "Checking the box next to a quantity, quality, or blueprint chance will allow the values to be adjusted by modifiers."
         Visible         =   True
         Width           =   700
      End
      Begin UpDownArrows MaxItemsStepper
         AcceptFocus     =   False
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   183
         Transparent     =   False
         Visible         =   True
         Width           =   13
      End
      Begin UpDownArrows MinItemsStepper
         AcceptFocus     =   False
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   149
         Transparent     =   False
         Visible         =   True
         Width           =   13
      End
      Begin UITweaks.ResizedTextField MaxItemsField
         AcceptTabs      =   False
         Alignment       =   "2"
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   183
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   60
      End
      Begin UITweaks.ResizedLabel MaxItemsLabel
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
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Max Items:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   183
         Transparent     =   True
         Underline       =   False
         Value           =   "Max Items:"
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedTextField MinItemsField
         AcceptTabs      =   False
         Alignment       =   "2"
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
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
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   149
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   60
      End
      Begin UITweaks.ResizedLabel MinItemsLabels
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
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Min Items:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   149
         Transparent     =   True
         Underline       =   False
         Value           =   "Min Items:"
         Visible         =   True
         Width           =   100
      End
      Begin Label GroupingLabel
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Grouping:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   115
         Transparent     =   True
         Underline       =   False
         Value           =   "Grouping:"
         Visible         =   True
         Width           =   100
      End
      Begin Label NameLabel
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
         Text            =   "Name:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   81
         Transparent     =   True
         Underline       =   False
         Value           =   "Name:"
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedTextField GroupingField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
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
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   115
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   588
      End
      Begin UITweaks.ResizedTextField NameField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   81
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   588
      End
      Begin BeaconListbox ModifiersList
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
         ColumnCount     =   5
         ColumnsResizable=   False
         ColumnWidths    =   "40%,15%,15%,15%,15%"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         DropIndicatorVisible=   False
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         FontName        =   "System"
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
         HeadingIndex    =   -1
         Height          =   415
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Group	Min Quality Change	Max Quality Change	Quantity Multiplier	Blueprint % Multiplier"
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
         SelectionRequired=   False
         SelectionType   =   "1"
         ShowDropIndicator=   False
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   121
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   700
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton AddModifierButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Add Modifier"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   81
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   114
      End
      Begin UITweaks.ResizedPushButton EditModifierButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Edit"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   154
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   81
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DeleteModifierButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   246
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   81
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub MenuSelected()
		  If Self.Changed Then
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
		Sub Opening()
		  Self.UpdateUI()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma unused Initial
		  
		  Self.MapSelector.Left = Self.ContentsList.Left + ((Self.ContentsList.Width - Self.MapSelector.Width) / 2)
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  Self.Save()
		  Return True
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			Dim Dialog As New SaveFileDialog
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
			Dim Dialog As New SaveFileDialog
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
		  Dim Maps() As Beacon.Map = Self.FilteredMaps()
		  For Each Entry As Beacon.PresetEntry In Entries
		    Self.ContentsList.AddRow("")
		    Self.PutEntryInRow(Entry, Self.ContentsList.LastAddedRowIndex, Maps)
		  Next
		  Self.ContentsList.Sort
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Preset As Beacon.Preset, SourceFile As FolderItem = Nil)
		  Self.mPreset = New Beacon.MutablePreset(Preset)
		  Self.mSaveFile = SourceFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelectedEntries(Warn As Boolean)
		  If Self.ContentsList.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  If Warn And Not Self.ShowConfirm(if(Self.ContentsList.SelectedRowCount = 1, "Are you sure you want to delete this entry?", "Are you sure you want to delete these " + Str(Self.ContentsList.SelectedRowCount, "-0") + " entries?"), "This action cannot be undone.", "Delete", "Cancel") Then
		    Return
		  End If
		  
		  For I As Integer = Self.ContentsList.RowCount - 1 DownTo 0
		    If Not Self.ContentsList.Selected(I) Then
		      Continue
		    End If
		    Dim Entry As Beacon.PresetEntry = Self.ContentsList.RowTag(I)
		    Dim Idx As Integer = Self.mPreset.IndexOf(Entry)
		    If Idx > -1 Then
		      Self.mPreset.Remove(Idx)  
		      Self.Changed = True
		    End If
		    Self.ContentsList.RemoveRow(I)
		  Next
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelectedEntries()
		  Dim Entries() As Beacon.PresetEntry
		  For I As Integer = 0 To ContentsList.RowCount - 1
		    If Not ContentsList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Entry As Beacon.PresetEntry = ContentsList.RowTag(I)
		    Call Entry.UniqueID // Triggers generation if necessary so we can compare when done
		    Entries.Append(Entry)
		  Next
		  
		  If Entries.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim NewEntries() As Beacon.SetEntry = EntryEditor.Present(Self.TrueWindow, New Beacon.StringList, Entries)
		  If NewEntries = Nil Then
		    Return
		  End If
		  
		  Dim Maps() As Beacon.Map = Self.FilteredMaps()
		  For Each NewEntry As Beacon.SetEntry In NewEntries
		    Dim OriginalEntry As Beacon.PresetEntry
		    Dim OriginalIndex As Integer = -1
		    For I As Integer = 0 To Self.mPreset.LastRowIndex
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
		    
		    For I As Integer = 0 To ContentsList.RowCount - 1
		      If Beacon.PresetEntry(ContentsList.RowTag(I)).UniqueID = OriginalEntry.UniqueID Then
		        Self.PutEntryInRow(Item, I, Maps)
		        Exit For I
		      End If
		    Next
		  Next
		  
		  ContentsList.Sort
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilteredMaps() As Beacon.Map()
		  Dim Maps() As Beacon.Map
		  For I As Integer = 0 To Self.MapSelector.SegmentCount - 1
		    Dim Cell As Segment = Self.MapSelector.SegmentValueAt(I)
		    If Not Cell.IsSelected Then
		      Continue
		    End If
		    Select Case I
		    Case 0
		      Maps.Append(Beacon.Maps.TheIsland)
		    Case 1
		      Maps.Append(Beacon.Maps.ScorchedEarth)
		    Case 2
		      Maps.Append(Beacon.Maps.Aberration)
		    Case 3
		      Maps.Append(Beacon.Maps.Extinction)
		    Case 4
		      Maps.Append(Beacon.Maps.TheCenter)
		    Case 5
		      Maps.Append(Beacon.Maps.Ragnarok)
		    Case 6
		      Maps.Append(Beacon.Maps.Valguero)
		    End Select
		  Next
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
		Private Sub PutEntryInRow(Entry As Beacon.PresetEntry, Index As Integer, Maps() As Beacon.Map, SelectIt As Boolean = False)
		  If Index = -1 Then
		    Self.ContentsList.AddRow("")
		    Index = Self.ContentsList.LastAddedRowIndex
		  End If
		  
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
		  Self.ContentsList.Cell(Index, Self.ColumnQuality) = if(Entry.MinQuality = Entry.MaxQuality, Language.LabelForQuality(Entry.MinQuality), Language.LabelForQuality(Entry.MinQuality, True) + "-" + Language.LabelForQuality(Entry.MaxQuality, True))
		  Self.ContentsList.Cell(Index, Self.ColumnBlueprint) = if(Entry.CanBeBlueprint, Str(Entry.ChanceToBeBlueprint, "0%"), "N/A")
		  Self.ContentsList.CellCheck(Index, Self.ColumnQuantity) = Entry.RespectQuantityMultiplier
		  Self.ContentsList.CellCheck(Index, Self.ColumnQuality) = Entry.RespectQualityModifier
		  Self.ContentsList.CellCheck(Index, Self.ColumnBlueprint) = Entry.RespectBlueprintMultiplier
		  
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
		  Self.Changed = False
		  NotificationKit.Post("Preset Saved", Self.mPreset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedEntries() As Beacon.PresetEntry()
		  Dim Entries() As Beacon.PresetEntry
		  For I As Integer = Self.ContentsList.RowCount - 1 DownTo 0
		    If Self.ContentsList.Selected(I) Then
		      Entries.Append(Self.ContentsList.RowTag(I))
		    End If
		  Next
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddDialog()
		  Dim Entries() As Beacon.SetEntry = EntryEditor.Present(Self.TrueWindow, New Beacon.StringList)
		  If Entries = Nil Or Entries.LastRowIndex = -1 Then
		    Return
		  End If
		  Self.ContentsList.SelectedIndex = -1
		  Dim Maps() As Beacon.Map = Self.FilteredMaps
		  For Each Entry As Beacon.SetEntry In Entries
		    Dim Item As New Beacon.PresetEntry(Entry)
		    Self.PutEntryInRow(Item, -1, Maps, True)
		    Self.mPreset.Append(Item)
		    Self.Changed = True
		  Next
		  Self.ContentsList.Sort
		  Self.ContentsList.EnsureSelectionIsVisible
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowModifierEditor(Edit As Boolean)
		  Dim EditID As String
		  If Edit And Self.ModifiersList.SelectedRowCount = 1 Then
		    EditID = Self.ModifiersList.RowTag(Self.ModifiersList.SelectedIndex)
		  End If
		  If PresetModifierEditor.Present(Self, Self.mPreset, EditID) Then
		    Self.UpdateUI
		    Self.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMinAndMaxFields()
		  Dim Focus As RectControl = Self.Window.Focus
		  
		  If Focus <> Self.MinItemsField Then
		    Self.MinItemsField.Value = Str(Self.mPreset.MinItems)
		  End If
		  If Focus <> Self.MaxItemsField Then
		    Self.MaxItemsField.Value = Str(Self.mPreset.MaxItems)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  If Self.mSaveFile <> Nil Then
		    Self.Title = Self.mSaveFile.DisplayName
		  Else
		    Self.Title = Self.mPreset.Label
		  End If
		  Self.ToolbarCaption = Self.Title
		  Self.mUpdating = True
		  Self.Changed = False
		  
		  Dim Mask As UInt64 = Preferences.LastPresetMapFilter
		  Self.MapSelector.SegmentValueAt(0).IsSelected = (Mask And Beacon.Maps.TheIsland.Mask) = Beacon.Maps.TheIsland.Mask
		  Self.MapSelector.SegmentValueAt(1).IsSelected = (Mask And Beacon.Maps.ScorchedEarth.Mask) = Beacon.Maps.ScorchedEarth.Mask
		  Self.MapSelector.SegmentValueAt(2).IsSelected = (Mask And Beacon.Maps.Aberration.Mask) = Beacon.Maps.Aberration.Mask
		  Self.MapSelector.SegmentValueAt(3).IsSelected = (Mask And Beacon.Maps.Extinction.Mask) = Beacon.Maps.Extinction.Mask
		  Self.MapSelector.SegmentValueAt(4).IsSelected = (Mask And Beacon.Maps.TheCenter.Mask) = Beacon.Maps.TheCenter.Mask
		  Self.MapSelector.SegmentValueAt(5).IsSelected = (Mask And Beacon.Maps.Ragnarok.Mask) = Beacon.Maps.Ragnarok.Mask
		  Self.MapSelector.SegmentValueAt(6).IsSelected = (Mask And Beacon.Maps.Valguero.Mask) = Beacon.Maps.Valguero.Mask
		  
		  Dim Maps() As Beacon.Map = Self.FilteredMaps()
		  Dim SelectedEntries() As String
		  For I As Integer = 0 To Self.ContentsList.RowCount - 1
		    If Self.ContentsList.Selected(I) Then
		      Dim Entry As Beacon.PresetEntry = Self.ContentsList.RowTag(I)
		      SelectedEntries.Append(Entry.UniqueID)
		    End If
		  Next
		  Self.ContentsList.DeleteAllRows()
		  For Each Entry As Beacon.PresetEntry In Self.mPreset
		    Self.PutEntryInRow(Entry, -1, Maps, SelectedEntries.IndexOf(Entry.UniqueID) > -1)
		  Next
		  Self.ContentsList.Sort
		  
		  Self.NameField.Value = Self.mPreset.Label
		  Self.GroupingField.Value = Self.mPreset.Grouping
		  Self.UpdateMinAndMaxFields
		  
		  Dim AppliedModifiers() As String = Self.mPreset.ActiveModifierIDs
		  Dim Modifiers() As Beacon.PresetModifier = LocalData.SharedInstance.AllPresetModifiers
		  Self.ModifiersList.DeleteAllRows()
		  For Each Modifier As Beacon.PresetModifier In Modifiers
		    If AppliedModifiers.IndexOf(Modifier.ModifierID) = -1 Then
		      Continue
		    End If
		    
		    Dim QuantityMultiplier As Double = Self.mPreset.QuantityMultiplier(Modifier)
		    Dim MinQualityModifier As Integer = Self.mPreset.MinQualityModifier(Modifier)
		    Dim MaxQualityModifier As Integer = Self.mPreset.MaxQualityModifier(Modifier)
		    Dim BlueprintMultiplier As Double = Self.mPreset.BlueprintMultiplier(Modifier)
		    
		    Dim QuantityLabel As String = "x " + QuantityMultiplier.ToString(Locale.Current)
		    Dim BlueprintLabel As String = "x " + BlueprintMultiplier.ToString(Locale.Current)
		    Dim MinQualityLabel, MaxQualityLabel As String
		    If MinQualityModifier = 0 Then
		      MinQualityLabel = "No Change"
		    Else
		      MinQualityLabel = MinQualityModifier.ToString(Locale.Current, "+0;-0") + " Tier" + If(Abs(MinQualityModifier) <> 1, "s", "")
		    End If
		    If MaxQualityModifier = 0 Then
		      MaxQualityLabel = "No Change"
		    Else
		      MaxQualityLabel = MaxQualityModifier.ToString(Locale.Current, "+0;-0") + " Tier" + If(Abs(MaxQualityModifier) <> 1, "s", "")
		    End If
		    
		    Self.ModifiersList.AddRow(Modifier.Label, MinQualityLabel, MaxQualityLabel, QuantityLabel, BlueprintLabel)
		    Self.ModifiersList.RowTag(Self.ModifiersList.LastAddedRowIndex) = Modifier.ModifierID
		  Next
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewID() As String
		  If Self.mSaveFile <> Nil Then
		    Return EncodeHex(Crypto.MD5(Self.mSaveFile.NativePath))
		  Else
		    Return Self.mPreset.PresetID
		  End If
		End Function
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


	#tag Constant, Name = ColumnBlueprint, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnDescription, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIncluded, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ModifierClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.presetmodifier", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageContents, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSettings, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub Pressed(Item As BeaconToolbarItem)
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
		Sub Opening()
		  Me.LeftItems.Append(New BeaconToolbarItem("AddEntries", IconAdd))
		  Me.LeftItems.Append(New BeaconToolbarItem("EditEntries", IconToolbarEdit, False))
		  Me.LeftItems.Append(New BeaconToolbarItem("DeleteEntries", IconRemove, False))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ViewSelector
	#tag Event
		Sub Opening()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconPresetSettings, "General", "settings")
		  Me.Add(IconPresetContents, "Contents", "contents")
		  Me.Add(IconPresetModifiers, "Modifiers", "modifiers")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  Self.Pages.SelectedPanelIndex = Me.SelectedIndex - 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapSelector
	#tag Event
		Sub Pressed(segmentedIndex as integer)
		  #Pragma Unused segmentedIndex
		  
		  If Self.mUpdating = True Then
		    Return
		  End If
		  
		  Self.mUpdating = True
		  
		  Dim Maps() As Beacon.Map = Self.FilteredMaps
		  Preferences.LastPresetMapFilter = Maps.Mask
		  
		  For I As Integer = ContentsList.RowCount - 1 DownTo 0
		    Dim Entry As Beacon.PresetEntry = ContentsList.RowTag(I)
		    Self.PutEntryInRow(Entry, I, Maps, ContentsList.Selected(I))
		  Next
		  
		  Self.mUpdating = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Width = Me.SegmentCount * 110 // Because the design-time size is not being respected
		  Me.ResizeCells
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentsList
	#tag Event
		Sub Opening()
		  Me.ColumnType(Self.ColumnIncluded) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnQuantity) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnQuality) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnBlueprint) = Listbox.TypeCheckbox
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
		      For I As Integer = Me.RowCount - 1 DownTo 0
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        For Each Map As Beacon.Map In Maps
		          If Entry.ValidForMap(Map) <> (State = Checkbox.CheckedStates.Checked) Then
		            Entry.ValidForMap(Map) = (State = Checkbox.CheckedStates.Checked)
		            Me.CellState(I, Column) = State
		            Self.Changed = True
		          End If
		        Next
		      Next
		    Else
		      Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		      For Each Map As Beacon.Map In Maps
		        If Entry.ValidForMap(Map) <> (State = Checkbox.CheckedStates.Checked) Then
		          Entry.ValidForMap(Map) = (State = Checkbox.CheckedStates.Checked)
		          Self.Changed = True
		        End If
		      Next
		    End If
		    Return
		  Case Self.ColumnQuantity
		    Dim Checked As Boolean = Me.CellCheck(Row, Column)
		    
		    If ChangeAll Then
		      For I As Integer = Me.RowCount - 1 DownTo 0
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        If Entry.RespectQuantityMultiplier <> Checked Then
		          Entry.RespectQuantityMultiplier = Checked
		          Me.CellCheck(I, Column) = Checked
		          Self.Changed = True
		        End If
		      Next
		    Else
		      Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		      If Entry.RespectQuantityMultiplier <> Checked Then
		        Entry.RespectQuantityMultiplier = Checked
		        Self.Changed = True
		      End If
		    End If
		  Case Self.ColumnQuality
		    Dim Checked As Boolean = Me.CellCheck(Row, Column)
		    
		    If ChangeAll Then
		      For I As Integer = Me.RowCount - 1 DownTo 0
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        If Entry.RespectQualityModifier <> Checked Then
		          Entry.RespectQualityModifier = Checked
		          Me.CellCheck(I, Column) = Checked
		          Self.Changed = True
		        End If
		      Next
		    Else
		      Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		      If Entry.RespectQualityModifier <> Checked Then
		        Entry.RespectQualityModifier = Checked
		        Self.Changed = True
		      End If
		    End If
		  Case Self.ColumnBlueprint
		    Dim Checked As Boolean = Me.CellCheck(Row, Column)
		    
		    If ChangeAll Then
		      For I As Integer = Me.RowCount - 1 DownTo 0
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        If Entry.RespectBlueprintMultiplier <> Checked Then
		          Entry.RespectBlueprintMultiplier = Checked
		          Me.CellCheck(I, Column) = Checked
		          Self.Changed = True
		        End If
		      Next
		    Else
		      Dim Entry As Beacon.PresetEntry = Me.RowTag(Row)
		      If Entry.RespectBlueprintMultiplier <> Checked Then
		        Entry.RespectBlueprintMultiplier = Checked
		        Self.Changed = True
		      End If
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Dim Item As MenuItem
		  
		  Item = New MenuItem
		  Item.Value = "Create Blueprint Entry"
		  Item.Enabled = Me.SelectedRowCount > 0
		  Item.Tag = "createblueprintentry"
		  
		  Base.Append(Item)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  Select Case hitItem.Tag
		  Case "createblueprintentry"
		    Dim Maps() As Beacon.Map = Beacon.Maps.All
		    Dim NewEntries As New Dictionary
		    For Each Map As Beacon.Map In Maps
		      Dim Entries() As Beacon.PresetEntry
		      For I As Integer = 0 To Me.RowCount - 1
		        If Not Me.Selected(I) Then
		          Continue
		        End If
		        
		        Dim Entry As Beacon.PresetEntry = Me.RowTag(I)
		        If Entry.ValidForMap(Map) Then
		          Entries.Append(Entry)
		        End If
		      Next
		      
		      Dim BlueprintEntry As Beacon.SetEntry = Beacon.SetEntry.CreateBlueprintEntry(Entries)
		      If BlueprintEntry <> Nil Then
		        Dim Hash As String = BlueprintEntry.Hash
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
		    
		    If NewEntries.KeyCount = 0 Then
		      Beep
		      Return True
		    End If
		    
		    For I As Integer = 0 To Me.RowCount - 1
		      If Me.Selected(I) Then
		        Beacon.PresetEntry(Me.RowTag(I)).ChanceToBeBlueprint = 0.0
		      End If
		    Next
		    Me.SelectedIndex = -1
		    
		    Dim SelectedMaps() As Beacon.Map = Self.FilteredMaps()
		    For Each Entry As DictionaryEntry In NewEntries
		      Dim Item As Beacon.PresetEntry = Entry.Value
		      Item.RespectQualityModifier = False
		      Item.RespectQuantityMultiplier = False
		      Self.PutEntryInRow(Item, -1, SelectedMaps, True)
		      Self.mPreset.Append(Item)
		    Next
		    
		    Me.Sort
		    Me.EnsureSelectionIsVisible()
		    Self.Changed = True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > -1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Self.DeleteSelectedEntries(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Header.EditEntries.Enabled = Me.SelectedRowCount > 0
		  Header.DeleteEntries.Enabled = Me.SelectedRowCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClicked()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsStepper
	#tag Event
		Sub Down()
		  Self.MaxItemsField.Value = Str(CDbl(Self.MaxItemsField.Value) - 1, "-0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Self.MaxItemsField.Value = Str(CDbl(Self.MaxItemsField.Value) + 1, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsStepper
	#tag Event
		Sub Down()
		  Self.MinItemsField.Value = Str(CDbl(Self.MinItemsField.Value) - 1, "-0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Self.MinItemsField.Value = Str(CDbl(Self.MinItemsField.Value) + 1, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As Integer = Max(CDbl(Me.Value), 1)
		  If Self.mPreset.MaxItems <> Value Then
		    Self.mPreset.MaxItems = Value
		    Self.Changed = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Value = Str(Self.mPreset.MaxItems, "-0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Me.Value = Str(Self.mPreset.MaxItems, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As Integer = Max(CDbl(Me.Value), 1)
		  If Self.mPreset.MinItems <> Value Then
		    Self.mPreset.MinItems = Value
		    Self.Changed = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Value = Str(Self.mPreset.MinItems, "-0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Me.Value = Str(Self.mPreset.MinItems, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GroupingField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As String = Trim(Me.Value)
		  If Value <> "" And StrComp(Self.mPreset.Grouping, Value, 0) <> 0 Then
		    Self.mPreset.Grouping = Value
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim Value As String = Trim(Me.Value)
		  If Value <> "" And StrComp(Self.mPreset.Label, Value, 0) <> 0 Then
		    Self.mPreset.Label = Value
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModifiersList
	#tag Event
		Sub SelectionChanged()
		  EditModifierButton.Enabled = Me.SelectedRowCount = 1
		  DeleteModifierButton.Enabled = Me.SelectedRowCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClicked()
		  Self.ShowModifierEditor(True)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.ModifierClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn And Not Self.ShowConfirm(if(Self.ModifiersList.SelectedRowCount = 1, "Are you sure you want to delete this modifier?", "Are you sure you want to delete these " + Str(Self.ModifiersList.SelectedRowCount, "-0") + " modifiers?"), "This action cannot be undone.", "Delete", "Cancel") Then
		    Return
		  End If
		  
		  For I As Integer = Self.ModifiersList.RowCount - 1 DownTo 0
		    If Not Self.ModifiersList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ModifierID As String = Self.ModifiersList.RowTag(I)
		    Self.mPreset.ClearModifier(ModifierID)
		    Self.ModifiersList.RemoveRow(I)
		    Self.Changed = True
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Modifiers As New Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ModifierID As String = Me.RowTag(I)
		    Dim Dict As New Dictionary
		    Dict.Value("Quantity") = Self.mPreset.QuantityMultiplier(ModifierID)
		    Dict.Value("MinQuality") = Self.mPreset.MinQualityModifier(ModifierID)
		    Dict.Value("MaxQuality") = Self.mPreset.MaxQualityModifier(ModifierID)
		    Dict.Value("Blueprint") = Self.mPreset.BlueprintMultiplier(ModifierID)
		    Modifiers.Value(ModifierID) = Dict
		  Next
		  
		  Board.AddRawData(Beacon.GenerateJSON(Modifiers, False), Self.ModifierClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Board.RawDataAvailable(Self.ModifierClipboardType) Then
		    Return
		  End If
		  
		  Try
		    Dim Data As String = Board.RawData(Self.ModifierClipboardType).DefineEncoding(Encodings.UTF8)
		    Dim Modifiers As Dictionary = Beacon.ParseJSON(Data)
		    
		    For Each Entry As DictionaryEntry In Modifiers
		      Dim ModifierID As String = Entry.Key
		      Dim Dict As Dictionary = Entry.Value
		      
		      If Dict.HasKey("Quantity") Then
		        Self.mPreset.QuantityMultiplier(ModifierID) = Dict.Value("Quantity")
		      End If
		      If Dict.HasKey("MinQuality") And Dict.HasKey("MaxQuality") Then
		        Self.mPreset.MinQualityModifier(ModifierID) = Dict.Value("MinQuality")
		        Self.mPreset.MaxQualityModifier(ModifierID) = Dict.Value("MaxQuality")
		      ElseIf Dict.HasKey("Quality") Then
		        Self.mPreset.MinQualityModifier(ModifierID) = Dict.Value("Quality")
		        Self.mPreset.MaxQualityModifier(ModifierID) = Dict.Value("Quality")
		      End If
		      If Dict.HasKey("Blueprint") Then
		        Self.mPreset.BlueprintMultiplier(ModifierID) = Dict.Value("Blueprint")
		      End If
		    Next
		    
		    Self.UpdateUI()
		    Self.Changed = True
		  Catch Err As RuntimeException
		    Return
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddModifierButton
	#tag Event
		Sub Pressed()
		  Self.ShowModifierEditor(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditModifierButton
	#tag Event
		Sub Pressed()
		  Self.ShowModifierEditor(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeleteModifierButton
	#tag Event
		Sub Pressed()
		  Self.ModifiersList.DoClear()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
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
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
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
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
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
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
