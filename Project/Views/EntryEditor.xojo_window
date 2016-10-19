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
   Height          =   442
   ImplicitInstance=   False
   LiveResize      =   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   322
   MinimizeButton  =   False
   MinWidth        =   500
   Placement       =   1
   Resizeable      =   True
   Title           =   "Set Entry"
   Visible         =   True
   Width           =   600
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   442
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      Top             =   0
      Value           =   0
      Visible         =   True
      Width           =   600
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   402
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin PushButton NextButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   402
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton BackButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   402
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DoneButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   402
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin TextField FilterField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Filter"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
      End
      Begin BeaconListbox EngramList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,*"
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
         Height          =   216
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   " 	Name	Class String"
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
         SelectionType   =   0
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   54
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label ClassField
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   184
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
         Text            =   "Untitled"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   396
      End
      Begin Label NameField
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   184
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   2
         Text            =   "Untitled"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   396
      End
      Begin Label ClassLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabPanelIndex   =   2
         Text            =   "Class:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin Label NameLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   184
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
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   184
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   118
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   80
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
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   184
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   152
         Underline       =   False
         Visible         =   True
         Width           =   139
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
         InitialParent   =   "PagePanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   184
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   184
         Underline       =   False
         Visible         =   True
         Width           =   139
      End
      Begin Label MinQuantityLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   12
         TabPanelIndex   =   2
         Text            =   "Min Quantity:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
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
         InitialParent   =   "PagePanel1"
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
         Text            =   "Max Quantity:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   118
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
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
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   14
         TabPanelIndex   =   2
         Text            =   "Min Quality:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   152
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
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
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   15
         TabPanelIndex   =   2
         Text            =   "Max Quality:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   184
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin Label WeightLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   16
         TabPanelIndex   =   2
         Text            =   "Weight:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   216
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin Slider WeightSlider
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   "Items with a higher weight will be selected more frequently than items with a smaller weight. Two items with the same weight will be selected at the same frequency."
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   184
         LineStep        =   5
         LiveScroll      =   True
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Maximum         =   100
         Minimum         =   0
         PageStep        =   25
         Scope           =   2
         TabIndex        =   17
         TabPanelIndex   =   2
         TabStop         =   True
         TickStyle       =   "0"
         Top             =   216
         Value           =   100
         Visible         =   True
         Width           =   139
      End
      Begin Label WeightField
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   335
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   18
         TabPanelIndex   =   2
         Text            =   "100"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   216
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   93
      End
      Begin Slider ChanceSlider
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   "Items with a higher weight will be selected more frequently than items with a smaller weight. Two items with the same weight will be selected at the same frequency."
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   184
         LineStep        =   5
         LiveScroll      =   True
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Maximum         =   100
         Minimum         =   0
         PageStep        =   25
         Scope           =   2
         TabIndex        =   19
         TabPanelIndex   =   2
         TabStop         =   True
         TickStyle       =   "0"
         Top             =   251
         Value           =   25
         Visible         =   True
         Width           =   139
      End
      Begin Label ChanceField
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   335
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   20
         TabPanelIndex   =   2
         Text            =   "25%"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   251
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   93
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
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   21
         TabPanelIndex   =   2
         Text            =   "Chance To Be Blueprint:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   251
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   152
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   22
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   251
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   100
      End
      Begin CheckBox EditWeightCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Edit"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   23
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   216
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   100
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   24
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   184
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   100
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   25
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   152
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   100
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   26
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   118
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   100
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   27
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Underline       =   False
         Value           =   True
         Visible         =   False
         Width           =   100
      End
      Begin Label SelectionCountLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   4
         TabPanelIndex   =   1
         Text            =   "No items selected"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   402
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   376
      End
      Begin GroupBox BehaviorGroup
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Behavior"
         Enabled         =   True
         Height          =   108
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   282
         Underline       =   False
         Visible         =   True
         Width           =   560
         Begin RadioButton BehaviorMultipleEntriesRadio
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Create one entry for each selected engram"
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "BehaviorGroup"
            Italic          =   False
            Left            =   40
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   318
            Underline       =   False
            Value           =   True
            Visible         =   True
            Width           =   520
         End
         Begin RadioButton BehaviorSingleEntryRadio
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Create a single entry containing the selected engrams"
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "BehaviorGroup"
            Italic          =   False
            Left            =   40
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   350
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   520
         End
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim DefaultSize As New Xojo.Core.Size(600, 442)
		  Dim PreferredSize As Xojo.Core.Size = App.Preferences.SizeValue("Entry Editor Size", DefaultSize)
		  
		  Self.Width = PreferredSize.Width
		  Self.Height = PreferredSize.Height
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  If PagePanel1.Value = 0 And Self.mAnimating = False Then
		    App.Preferences.SizeValue("Entry Editor Size") = New Xojo.Core.Size(Self.Width, Self.Height)
		  End If
		End Sub
	#tag EndEvent


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

	#tag Method, Flags = &h21
		Private Sub ResizeCompleted(Sender As AnimationKit.MoveTask)
		  If PagePanel1.Value = 1 Then
		    Self.MaxHeight = Self.MinHeight
		  End If
		  
		  Self.mAnimating = False
		End Sub
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
		    EngramList.AddRow("", Engram.Label, Engram.ClassString)
		    EngramList.RowTag(EngramList.LastIndex) = Engram
		    Indexes.Value(Engram.ClassString) = EngramList.LastIndex
		    If Engram.ClassString = SearchText Or Engram.Label = SearchText Then
		      PerfectMatch = True
		    End If
		  Next
		  
		  If Not PerfectMatch And SearchText <> "" Then
		    Dim Engram As New Beacon.MutableEngram(SearchText.ToText)
		    EngramList.AddRow("", Engram.Label, Engram.ClassString)
		    EngramList.RowTag(EngramList.LastIndex) = Engram
		    Indexes.Value(Engram.ClassString) = EngramList.LastIndex
		  End If
		  
		  For Each Engram As Beacon.Engram In Self.mSelectedEngrams
		    Dim Idx As Integer = Indexes.Lookup(Engram.ClassString, -1)
		    If Idx > -1 Then
		      EngramList.CellCheck(Idx, 0) = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Select Case Self.mMode
		  Case EntryEditor.Modes.NewEntry
		    Self.Search("")
		  Case EntryEditor.Modes.SingleEdit
		    BehaviorGroup.Visible = False
		    BehaviorSingleEntryRadio.Value = True
		    EngramList.Height = (BehaviorGroup.Top + BehaviorGroup.Height) - EngramList.Top
		    DoneButton.Caption = "Save"
		    
		    For Each Option As Beacon.SetEntryOption In Self.mEntries(0)
		      Self.mSelectedEngrams.Append(Option.Engram)
		    Next
		    
		    Self.Search("")
		    Self.UpdateSelectionUI()
		    
		    For I As Integer = 0 To EngramList.ListCount - 1
		      If EngramList.CellCheck(I, 0) Then
		        EngramList.ScrollPosition = I
		        Exit For I
		      End If
		    Next
		  Case EntryEditor.Modes.MultiEdit
		    PagePanel1.Value = 1
		    BackButton.Caption = "Cancel"
		    DoneButton.Caption = "Save"
		    
		    EditChanceCheck.Visible = True
		    EditMaxQualityCheck.Visible = True
		    EditMaxQuantityCheck.Visible = True
		    EditMinQualityCheck.Visible = True
		    EditMinQuantityCheck.Visible = True
		    EditWeightCheck.Visible = True
		    
		    EditChanceCheck.Value = False
		    EditMaxQualityCheck.Value = False
		    EditMaxQuantityCheck.Value = False
		    EditMinQualityCheck.Value = False
		    EditMinQuantityCheck.Value = False
		    EditWeightCheck.Value = False
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show()
		  Self.SetupUI()
		  Self.mReadyForAnimation = True
		  Super.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowModal()
		  Self.SetupUI()
		  Self.mReadyForAnimation = True
		  Super.ShowModal()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowModalWithin(ParentWindow As Window)
		  Self.SetupUI()
		  Self.mReadyForAnimation = True
		  Super.ShowModalWithin(ParentWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowWithin(ParentWindow As Window, Facing As Integer = - 1)
		  Self.SetupUI()
		  Self.mReadyForAnimation = True
		  Super.ShowWithin(ParentWindow, Facing)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSelectionUI()
		  Select Case UBound(Self.mSelectedEngrams)
		  Case -1
		    SelectionCountLabel.Text = "No classes selected"
		  Case 0
		    SelectionCountLabel.Text = "1 class selected"
		  Else
		    SelectionCountLabel.Text = Str(UBound(Self.mSelectedEngrams) + 1, "-0") + " classes selected"
		  End Select
		  
		  NextButton.Enabled = UBound(Self.mSelectedEngrams) > -1
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAnimating As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEntries() As Beacon.SetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIgnoreChanges As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As EntryEditor.Modes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReadyForAnimation As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedEngrams() As Beacon.Engram
	#tag EndProperty


	#tag Enum, Name = Modes, Type = Integer, Flags = &h21
		NewEntry
		  SingleEdit
		MultiEdit
	#tag EndEnum


#tag EndWindowCode

#tag Events PagePanel1
	#tag Event
		Sub Change()
		  Select Case Me.Value
		  Case 0
		    Dim DefaultSize As New Xojo.Core.Size(600, 442)
		    Dim PreferredSize As Xojo.Core.Size = App.Preferences.SizeValue("Entry Editor Size", DefaultSize)
		    
		    Self.MaxHeight = 32000
		    
		    If Self.mReadyForAnimation Then
		      Self.mAnimating = True
		      
		      Dim Task As New AnimationKit.MoveTask(Self)
		      Task.Height = PreferredSize.Height
		      Task.Curve = AnimationKit.Curve.CreateEaseOut
		      Task.DurationInSeconds = 0.15
		      AddHandler Task.Completed, AddressOf Self.ResizeCompleted
		      Task.Run
		    Else
		      Self.Height = PreferredSize.Height
		    End If
		  Case 1
		    If Self.mReadyForAnimation Then
		      Self.mAnimating = True
		      
		      Dim Task As New AnimationKit.MoveTask(Self)
		      Task.Height = Self.MinHeight
		      Task.Curve = AnimationKit.Curve.CreateEaseOut
		      Task.DurationInSeconds = 0.15
		      AddHandler Task.Completed, AddressOf Self.ResizeCompleted
		      Task.Run
		    Else
		      Self.Height = Self.MinHeight
		    End If
		    
		    ClassField.Text = if(UBound(Self.mEntries) = 0, Self.mEntries(0).ClassesLabel, "Multiple (" + Str(UBound(Self.mEntries) + 1, "0") + " Entries)")
		    NameField.Text = if(UBound(Self.mEntries) = 0, Self.mEntries(0).Label, "Multiple (" + Str(UBound(Self.mEntries) + 1, "0") + " Entries)")
		    
		    Dim MinQuantities(), MaxQuantities() As Integer
		    Dim MinQualities(), MaxQualities() As Beacon.Qualities
		    Dim TotalWeight, TotalChance As Double
		    Dim CanBeBlueprint As Boolean
		    For Each Entry As Beacon.SetEntry In Self.mEntries
		      MinQuantities.Append(Entry.MinQuantity)
		      MaxQuantities.Append(Entry.MaxQuantity)
		      TotalWeight = TotalWeight + Entry.Weight
		      TotalChance = TotalChance + Entry.ChanceToBeBlueprint
		      MinQualities.Append(Entry.MinQuality)
		      MaxQualities.Append(Entry.MaxQuality)
		      CanBeBlueprint = CanBeBlueprint Or Entry.CanBeBlueprint
		    Next
		    
		    MinQuantities.Sort
		    MaxQuantities.Sort
		    MinQualities.Sort
		    MaxQualities.Sort
		    
		    Self.mIgnoreChanges = True
		    MinQuantityField.Text = Str(MinQuantities(0))
		    MaxQuantityField.Text = Str(MaxQuantities(UBound(MaxQuantities)))
		    WeightSlider.Value = 100 * (TotalWeight / (UBound(Self.mEntries) + 1))
		    If CanBeBlueprint Then
		      ChanceSlider.Value = 100 * (TotalChance / (UBound(Self.mEntries) + 1))
		      ChanceSlider.Enabled = True
		      ChanceLabel.Enabled = True
		      ChanceField.Enabled = True
		      EditChanceCheck.Enabled = True
		    Else
		      ChanceSlider.Value = 0
		      ChanceSlider.Enabled = False
		      ChanceLabel.Enabled = False
		      ChanceField.Enabled = False
		      EditChanceCheck.Enabled = False
		    End If
		    MinQualityMenu.SelectByTag(MinQualities(0))
		    MaxQualityMenu.SelectByTag(MaxQualities(UBound(MaxQualities)))
		    Self.mIgnoreChanges = False
		  End Select
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
#tag Events NextButton
	#tag Event
		Sub Action()
		  Select Case Self.mMode
		  Case EntryEditor.Modes.NewEntry
		    Redim Self.mEntries(-1)
		    
		    If BehaviorMultipleEntriesRadio.Value Then
		      For Each Engram As Beacon.Engram In Self.mSelectedEngrams
		        Dim Entry As New Beacon.SetEntry
		        Entry.Append(New Beacon.SetEntryOption(Engram, 1))
		        Self.mEntries.Append(Entry)
		      Next
		    Else
		      Dim Entry As New Beacon.SetEntry
		      For Each Engram As Beacon.Engram In Self.mSelectedEngrams
		        Entry.Append(New Beacon.SetEntryOption(Engram, 1))
		      Next
		      Self.mEntries.Append(Entry)
		    End If
		  Case EntryEditor.Modes.SingleEdit
		    Dim Entry As Beacon.SetEntry = Self.mEntries(0)
		    While Entry.Count > 0
		      Entry.Remove(0)
		    Wend
		    For Each Engram As Beacon.Engram In Self.mSelectedEngrams
		      Entry.Append(New Beacon.SetEntryOption(Engram, 1))
		    Next
		  End Select
		  
		  PagePanel1.Value = 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BackButton
	#tag Event
		Sub Action()
		  If Self.mMode = EntryEditor.Modes.MultiEdit Then
		    Self.mCancelled = True
		    Self.Hide
		  Else
		    Self.PagePanel1.Value = 0
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoneButton
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
		    If EditWeightCheck.Value Then
		      Entry.Weight = WeightSlider.Value / 100
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
		  If Column <> 0 Then
		    Return
		  End If
		  
		  Dim Selected As Boolean = Me.CellCheck(Row, Column)
		  Dim Engram As Beacon.Engram = Me.RowTag(Row)
		  Dim Idx As Integer = -1
		  
		  For I As Integer = 0 To UBound(Self.mSelectedEngrams)
		    If Self.mSelectedEngrams(I).ClassString = Engram.ClassString Then
		      Idx = I
		      Exit For I
		    End If
		  Next
		  
		  If Selected = True And Idx = -1 Then
		    Self.mSelectedEngrams.Append(Engram)
		  ElseIf Selected = False And Idx > -1 Then
		    Self.mSelectedEngrams.Remove(Idx)
		  End If
		  
		  Self.UpdateSelectionUI()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = Listbox.TypeCheckbox
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinQuantityField
	#tag Event
		Sub TextChange()
		  If Self.mIgnoreChanges Then
		    Return
		  End If
		  
		  EditMinQuantityCheck.Value = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxQuantityField
	#tag Event
		Sub TextChange()
		  If Self.mIgnoreChanges Then
		    Return
		  End If
		  
		  EditMaxQuantityCheck.Value = True
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
		  If Self.mIgnoreChanges Then
		    Return
		  End If
		  
		  Select Case Index
		  Case 0 // Min
		    EditMinQualityCheck.Value = True
		  Case 1 // Max
		    EditMaxQualityCheck.Value = True
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightSlider
	#tag Event
		Sub ValueChanged()
		  WeightField.Text = Str(Me.Value, "-0")
		  
		  If Self.mIgnoreChanges Then
		    Return
		  End If
		  
		  EditWeightCheck.Value = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChanceSlider
	#tag Event
		Sub ValueChanged()
		  ChanceField.Text = Str(Me.Value, "-0") + "%"
		  
		  If Self.mIgnoreChanges Then
		    Return
		  End If
		  
		  EditChanceCheck.Value = True
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
