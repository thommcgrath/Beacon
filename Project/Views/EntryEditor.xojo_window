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
   Height          =   322
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
   Width           =   592
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   322
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
      Width           =   592
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
         Left            =   400
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
         Top             =   282
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
         Left            =   492
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
         Top             =   282
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
         Left            =   400
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
         Top             =   282
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
         Left            =   492
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
         Top             =   282
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
         Width           =   552
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
         Width           =   552
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
         LockRight       =   False
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
         Width           =   244
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
         LockRight       =   False
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
         Width           =   244
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
         Left            =   472
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
         Left            =   472
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
         Left            =   472
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
         Left            =   472
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
         Left            =   472
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
         Left            =   472
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
         Top             =   282
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   368
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.Search("")
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
		  If Sources <> Nil And UBound(Sources) > -1 Then
		    Win.mEditing = True
		    Redim Win.mSelectedEngrams(UBound(Sources))
		    For I As Integer = 0 To UBound(Sources)
		      Dim Source As Beacon.SetEntry = Sources(I)
		      Win.mSelectedEngrams(I) = Source(0).Engram
		    Next
		    Win.NameField.Text = if(UBound(Sources) = 0, Win.mSelectedEngrams(0).Label, "Multiple")
		    Win.ClassField.Text = if(UBound(Sources) = 0, Win.mSelectedEngrams(0).ClassString, "Multiple")
		    Win.PagePanel1.Value = 1
		    Win.BackButton.Caption = "Cancel"
		    Win.DoneButton.Caption = "Save"
		    
		    Dim MinQuantities(), MaxQuantities() As Integer
		    Dim MinQualities(), MaxQualities() As Beacon.Qualities
		    Dim TotalWeight, TotalChance As Double
		    For Each Source As Beacon.SetEntry In Sources
		      MinQuantities.Append(Source.MinQuantity)
		      MaxQuantities.Append(Source.MaxQuantity)
		      TotalWeight = TotalWeight + Source.Weight
		      TotalChance = TotalChance + Source.ChanceToBeBlueprint
		      MinQualities.Append(Source.MinQuality)
		      MaxQualities.Append(Source.MaxQuality)
		    Next
		    
		    MinQuantities.Sort
		    MaxQuantities.Sort
		    MinQualities.Sort
		    MaxQualities.Sort
		    
		    Win.MinQuantityField.Text = Str(MinQuantities(0))
		    Win.MaxQuantityField.Text = Str(MaxQuantities(UBound(MaxQuantities)))
		    Win.WeightSlider.Value = 100 * (TotalWeight / (UBound(Sources) + 1))
		    Win.ChanceSlider.Value = 100 * (TotalChance / (UBound(Sources) + 1))
		    
		    Win.MinQualityMenu.SelectByTag(MinQualities(0))
		    Win.MaxQualityMenu.SelectByTag(MaxQualities(UBound(MaxQualities)))
		    
		    If UBound(Sources) > 0 Then
		      Win.EditChanceCheck.Visible = True
		      Win.EditMaxQualityCheck.Visible = True
		      Win.EditMaxQuantityCheck.Visible = True
		      Win.EditMinQualityCheck.Visible = True
		      Win.EditMinQuantityCheck.Visible = True
		      Win.EditWeightCheck.Visible = True
		    End If
		  End If
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  If Win.mCancelled Then
		    Win.Close
		    Return Nil
		  End If
		  
		  Dim Entries() As Beacon.SetEntry
		  If Win.mEditing Then
		    For Each Source As Beacon.SetEntry In Sources
		      Entries.Append(New Beacon.SetEntry(Source))
		    Next
		  Else
		    For Each Engram As Beacon.Engram In Win.mSelectedEngrams
		      Dim Entry As New Beacon.SetEntry
		      Entry.Append(New Beacon.SetEntryOption(Engram, 1))
		      Entries.Append(Entry)
		    Next
		  End If
		  
		  For Each Entry As Beacon.SetEntry In Entries
		    If Win.EditMaxQuantityCheck.Value Then
		      Entry.MaxQuantity = Val(Win.MaxQuantityField.Text)
		    End If
		    If Win.EditMinQuantityCheck.Value Then
		      Entry.MinQuantity = Val(Win.MinQuantityField.Text)
		    End If
		    If Win.EditChanceCheck.Value Then
		      Entry.ChanceToBeBlueprint = Win.ChanceSlider.Value / 100
		    End If
		    If Win.EditWeightCheck.Value Then
		      Entry.Weight = Win.WeightSlider.Value / 100
		    End If
		    If Win.EditMaxQualityCheck.Value Then
		      Entry.MaxQuality = Win.MaxQualityMenu.Tag
		    End If
		    If Win.EditMinQualityCheck.Value Then
		      Entry.MinQuality = Win.MinQualityMenu.Tag
		    End If
		  Next
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


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedEngrams() As Beacon.Engram
	#tag EndProperty


#tag EndWindowCode

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
		  PagePanel1.Value = 1
		  
		  ClassField.Text = if(UBound(Self.mSelectedEngrams) = 0, Self.mSelectedEngrams(0).ClassString, "Multiple")
		  NameField.Text = if(UBound(Self.mSelectedEngrams) = 0, Self.mSelectedEngrams(0).Label, "Multiple")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BackButton
	#tag Event
		Sub Action()
		  If Self.mEditing Then
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
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = Listbox.TypeCheckbox
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
#tag EndEvents
#tag Events WeightSlider
	#tag Event
		Sub ValueChanged()
		  WeightField.Text = Str(Me.Value, "-0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChanceSlider
	#tag Event
		Sub ValueChanged()
		  ChanceField.Text = Str(Me.Value, "-0") + "%"
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
