#tag DesktopWindow
Begin BeaconAutopositionWindow DeployManager
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   550
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   550
   MinimumWidth    =   800
   Resizeable      =   True
   Title           =   "Deploy"
   Type            =   0
   Visible         =   True
   Width           =   800
   Begin ServersListbox ServerList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "22,*"
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      Filter          =   ""
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      SingleLineMode  =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   1
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   299
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator ServerListSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   299
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   500
      Begin DesktopLabel OptionsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
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
         Text            =   "Choose Deploy Options"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   201
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   459
      End
      Begin UITweaks.ResizedPushButton OptionsActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Begin"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   699
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   393
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel LogsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
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
         Text            =   "Status Messages"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   460
      End
      Begin DesktopTextArea LogsArea
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   478
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         ValidationMask  =   ""
         Visible         =   True
         Width           =   460
      End
      Begin UITweaks.ResizedPushButton ReviewActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Approve"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   690
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   510
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedPushButton ReviewCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   588
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   510
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin DesktopCheckBox ReviewConfirmationCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Both config files are correct"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   510
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   256
      End
      Begin CodeEditor ReviewArea
         AutoDeactivate  =   True
         Enabled         =   True
         HasBorder       =   False
         Height          =   416
         HorizontalScrollPosition=   0
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   300
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectionLength =   0
         ShowInfoBar     =   False
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   73
         VerticalScrollPosition=   0
         Visible         =   True
         Width           =   500
      End
      Begin Shelf ReviewSwitcher
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         DrawCaptions    =   True
         Enabled         =   True
         Height          =   72
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsVertical      =   False
         Left            =   300
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   False
         Visible         =   True
         Width           =   500
      End
      Begin FadedSeparator ReviewBottomSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   300
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   489
         Transparent     =   True
         Visible         =   True
         Width           =   500
      End
      Begin FadedSeparator ReviewTopSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   300
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   72
         Transparent     =   True
         Visible         =   True
         Width           =   500
      End
      Begin LogoFillCanvas NoSelectionCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Caption         =   "No Selection"
         ContentHeight   =   0
         Enabled         =   True
         Height          =   550
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   300
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   500
      End
      Begin ReactionButton CopyTriggerButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Copy Trigger"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "Copies a link to perform this deploy using automation tools."
         Top             =   510
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   113
      End
      Begin UITweaks.ResizedPopupMenu PlanMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   ""
         Italic          =   False
         Left            =   520
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "#TooltipDeployPlan"
         Top             =   361
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   259
      End
      Begin UITweaks.ResizedLabel PlanLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
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
         Text            =   "#CaptionDeployPlan"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "#TooltipDeployPlan"
         Top             =   361
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   188
      End
      Begin DesktopLabel CreateBackupLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "#CaptionBackupConfigFiles"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "#TooltipBackupConfigFiles"
         Top             =   233
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   188
      End
      Begin DesktopLabel ReviewChangesLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
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
         Text            =   "#CaptionReviewChanges"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "#TooltipReviewChanges"
         Top             =   265
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   188
      End
      Begin DesktopLabel RunAdvisorLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "#CaptionRunAdvisor"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "#TooltipRunAdvisor"
         Top             =   297
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   188
      End
      Begin DesktopLabel NukeConfigLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   320
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "#CaptionEraseConfigFiles"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "#TooltipEraseConfigFiles"
         Top             =   329
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   188
      End
      Begin SwitchControl CreateBackupSwitch
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   520
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   14
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "#TooltipBackupConfigFiles"
         Top             =   233
         Transparent     =   True
         Visible         =   True
         Width           =   40
      End
      Begin SwitchControl ReviewChangesSwitch
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   520
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   15
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "#TooltipReviewChanges"
         Top             =   265
         Transparent     =   True
         Visible         =   True
         Width           =   40
      End
      Begin SwitchControl RunAdvisorSwitch
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   520
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   16
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "#TooltipRunAdvisor"
         Top             =   297
         Transparent     =   True
         Visible         =   True
         Width           =   40
      End
      Begin SwitchControl NukeConfigSwitch
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   520
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   17
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "#TooltipEraseConfigFiles"
         Top             =   329
         Transparent     =   True
         Visible         =   True
         Width           =   40
      End
   End
   Begin Timer DeployWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   250
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function CancelClosing(appQuitting As Boolean) As Boolean
		  If Not Self.Working Then
		    Return False
		  End If
		  
		  Return Not Self.ShowConfirm("There is still a deploy operation in progress. Closing this window now will leave unfinished jobs in an unknown state.", "Please don't complain if your config files are only partially uploaded.", If(AppQuitting, "Quit Anyway", "Close Anyway"), "Cancel")
		End Function
	#tag EndEvent

	#tag Event
		Sub Closing()
		  If (Self.Engines Is Nil) Then
		    Return
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.DeployIntegration = Entry.Key
		    Engine.Terminate
		  Next
		  
		  Self.Engines.RemoveAll
		  Self.Engines = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.Title = "Deploy: " + Self.Project.Title
		  
		  Var OptionLabels() As DesktopLabel = Array(Self.CreateBackupLabel, Self.ReviewChangesLabel, Self.NukeConfigLabel, DesktopLabel(Self.PlanLabel))
		  #if Self.AdvisorEnabled
		    OptionLabels.Add(Self.RunAdvisorLabel)
		  #else
		    Self.RunAdvisorLabel.Visible = False
		    Self.RunAdvisorSwitch.Visible = False
		  #endif
		  BeaconUI.SizeToFit(OptionLabels)
		  Var OptionControlsLeft As Integer = Self.CreateBackupLabel.Right + 12
		  Self.CreateBackupSwitch.Left = OptionControlsLeft
		  Self.ReviewChangesSwitch.Left = OptionControlsLeft
		  Self.NukeConfigSwitch.Left = OptionControlsLeft
		  Self.PlanMenu.Left = OptionControlsLeft
		  Self.RunAdvisorSwitch.Left = OptionControlsLeft
		  
		  Self.CreateBackupSwitch.Value(False) = (Self.Settings.Options And CType(Beacon.DeploySettings.OptionBackup, UInt64)) = CType(Beacon.DeploySettings.OptionBackup, UInt64)
		  Self.ReviewChangesSwitch.Value(False) = (Self.Settings.Options And CType(Beacon.DeploySettings.OptionBackup, UInt64)) = CType(Beacon.DeploySettings.OptionReview, UInt64)
		  Self.RunAdvisorSwitch.Value(False) = (Self.Settings.Options And CType(Beacon.DeploySettings.OptionBackup, UInt64)) = CType(Beacon.DeploySettings.OptionAdvise, UInt64)
		  
		  Self.ServerList.DefaultRowHeight = BeaconListbox.DoubleLineRowHeight
		  Self.ServerList.ColumnTypeAt(0) = DesktopListbox.CellTypes.CheckBox
		  Self.ServerList.UpdateList()
		  
		  Self.CheckOptionsActionEnabled
		  
		  Self.UpdateDeployPlans(Self.Settings.Plan)
		  
		  If (Self.Settings.Options And CType(Beacon.DeploySettings.OptionRunImmediately, UInt64)) = CType(Beacon.DeploySettings.OptionRunImmediately, UInt64) Then
		    Self.Begin()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateControlPositions()
		  Const MinOptionsWidth = 460
		  Const MaxOptionsWidth = 560
		  Var OptionsWidth As Integer = Max(Min(Self.Pages.Width - 40, MaxOptionsWidth), MinOptionsWidth)
		  
		  Var Groups() As ControlGroup
		  If Self.CreateBackupLabel.Visible Then
		    Groups.Add(New ControlGroup(Self.CreateBackupLabel, Self.CreateBackupSwitch))
		  End If
		  If Self.NukeConfigLabel.Visible Then
		    Groups.Add(New ControlGroup(Self.NukeConfigLabel, Self.NukeConfigSwitch))
		  End If
		  If Self.ReviewChangesLabel.Visible Then
		    Groups.Add(New ControlGroup(Self.ReviewChangesLabel, Self.ReviewChangesSwitch))
		  End If
		  If Self.RunAdvisorLabel.Visible Then
		    Groups.Add(New ControlGroup(Self.RunAdvisorLabel, Self.RunAdvisorSwitch))
		  End If
		  If Self.PlanLabel.Visible Then
		    Groups.Add(New ControlGroup(Self.PlanLabel, Self.PlanMenu))
		  End If
		  
		  Var NextTop As Integer = Self.OptionsMessageLabel.Bottom + 12
		  For Each Group As ControlGroup In Groups
		    Group.Top = NextTop
		    NextTop = Group.Bottom + 12
		  Next
		  Self.OptionsActionButton.Top = NextTop
		  
		  Self.OptionsMessageLabel.Width = OptionsWidth
		  Self.OptionsActionButton.Left = Self.OptionsMessageLabel.Right - Self.OptionsActionButton.Width
		  Self.PlanMenu.Width = OptionsWidth - (Self.PlanLabel.Width + 12)
		  
		  Var MasterGroup As New ControlGroup(Self.OptionsMessageLabel, Self.OptionsActionButton)
		  For Each Group As ControlGroup In Groups
		    MasterGroup.Append(Group)
		  Next
		  MasterGroup.Left = Self.Pages.Left + Round((Self.Pages.Width - MasterGroup.Width) / 2)
		  MasterGroup.Top = Self.Pages.Top + Round((Self.Pages.Height - MasterGroup.Height) / 2)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function ActiveWaitController() As Beacon.TaskWaitController
		  Var Engine As Beacon.DeployIntegration = Self.SelectedEngine
		  If Engine = Nil Then
		    Return Nil
		  End If
		  
		  Return Engine.ActiveWaitController
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Begin()
		  If Self.PlanMenu.RowCount = 0 Then
		    Self.ShowAlert("No common update strategy is available.", "The chosen servers do not share any common update strategy. Try choosing servers from the same hosting provider.")
		  ElseIf Self.PlanMenu.SelectedRowIndex = -1 Then
		    Self.ShowAlert("An update strategy must be chosen.", "Beacon uses the update strategy to determine when to start or stop servers.")
		  End If
		  
		  Var NowGMT As New DateTime(DateTime.Now.SecondsFrom1970, New TimeZone(0))
		  Var Now As DateTime = DateTime.Now
		  Self.DeployLabel = NowGMT.Year.ToString(Locale.Raw, "0000") + "-" + NowGMT.Month.ToString(Locale.Raw, "00") + "-" + NowGMT.Day.ToString(Locale.Raw, "00") + " " + NowGMT.Hour.ToString(Locale.Raw, "00") + ":" + NowGMT.Minute.ToString(Locale.Raw, "00") + ":" + NowGMT.Second.ToString(Locale.Raw, "00") + " GMT (" + Now.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Short).ReplaceAll(&u202f, " ") + " " + Now.Timezone.Abbreviation + ")"
		  
		  Var ProfileProblems As New Dictionary
		  
		  Self.Engines = New Dictionary
		  For I As Integer = Self.ServerList.LastRowIndex DownTo 0
		    If Not Self.ServerList.CellCheckBoxValueAt(I, 0) Then
		      Self.ServerList.RemoveRowAt(I)
		      Continue
		    End If
		    
		    Var Profile As Beacon.ServerProfile = Self.ServerList.RowTagAt(I)
		    If Profile Is Nil Then
		      ProfileProblems.Value("profile at row " + I.ToString(Locale.Raw, "0")) = "Nil profile"
		      Continue
		    End If
		    
		    Var Engine As Beacon.DeployIntegration
		    Select Case Profile
		    Case IsA Ark.ServerProfile
		      Engine = New Ark.DeployIntegration(Project, Profile)
		    Case IsA SDTD.ServerProfile
		      #if DebugBuild Or SDTD.Enabled = False
		        #Pragma Warning "Need 7DTD DeployIntegration"
		      #else
		        #Pragma Error "Need 7DTD DeployIntegration"
		      #endif
		    Case IsA ArkSA.ServerProfile
		      Engine = New ArkSA.DeployIntegration(Project, Profile)
		    Case IsA Palworld.ServerProfile
		      Engine = New Palworld.DeployIntegration(Project, Profile)
		    End Select
		    If Engine Is Nil Then
		      Self.ShowAlert("The developer messed up.", "There is no DeployIntegration defined for server profile " + Profile.Name + ".")
		      Continue
		    End If
		    
		    AddHandler Engine.Wait, WeakAddressOf Engine_Wait
		    
		    Self.Engines.Value(Engine) = Profile
		    Self.ServerList.CellTagAt(I, 1) = Engine
		  Next
		  
		  If ProfileProblems.KeyCount > 0 Then
		    Var Problems() As String
		    For Each Entry As DictionaryEntry In ProfileProblems
		      Problems.Add("Problem with " + Entry.Key.StringValue + " is """ + Entry.Value.StringValue + """")
		    Next
		    
		    Var Explanation As String = "The following problems were reported. Please report this issue." + EndOfLine + EndOfLine + Problems.Join(EndOfLine) + EndOfLine + EndOfLine + "Importing again may solve the problem, but the issue should still be reported."
		    Self.ShowAlert("There was a problem starting the deploy. One or more server profiles did not setup correctly.", Explanation)
		    Self.Close
		    Return
		  End If
		  
		  // Prompt for the stop message
		  Var StopMessage As String
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.DeployIntegration = Entry.Key
		    If Not Engine.Provider.SupportsStopMessage Then
		      Continue
		    End If
		    
		    If (Self.Settings Is Nil) = False And Self.Settings.StopMessage.IsEmpty = False Then
		      StopMessage = Self.Settings.StopMessage
		    Else
		      StopMessage = StopMessageDialog.Present(Self)
		    End If
		    If StopMessage.IsEmpty Then
		      Return
		    Else
		      Exit
		    End If
		  Next
		  
		  // Hide the checkbox column
		  Self.ServerList.ColumnWidths = "0,*"
		  
		  // Mark that we're doing something
		  Self.Working = True
		  Self.Modified = True
		  
		  // Watch for changes
		  Self.DeployWatcher.RunMode = Timer.RunModes.Multiple
		  
		  // Show the log view
		  Self.Pages.SelectedPanelIndex = Self.PageLog
		  If Self.ServerList.SelectedRowIndex = -1 Then
		    Self.ServerList.SelectedRowIndex = 0
		  End If
		  
		  // Start the engines!
		  Var Settings As Beacon.DeploySettings = Self.CreateSettings
		  Settings.StopMessage = StopMessage
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.DeployIntegration = Entry.Key
		    Engine.Begin(Self.DeployLabel, App.IdentityManager.CurrentIdentity, Settings)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckOptionsActionEnabled()
		  Var Enabled As Boolean
		  For I As Integer = 0 To Self.ServerList.LastRowIndex
		    If Self.ServerList.CellCheckBoxValueAt(I, 0) Then
		      Enabled = True
		      Exit For I
		    End If
		  Next
		  
		  If Self.OptionsActionButton.Enabled <> Enabled Then
		    Self.OptionsActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ProjectController As Beacon.ProjectController, Settings As Beacon.DeploySettings)
		  Self.Controller = ProjectController
		  Self.Settings = Settings
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateSettings() As Beacon.DeploySettings
		  Var Settings As New Beacon.DeploySettings
		  If Self.CreateBackupSwitch.Value Then
		    Settings.Options = Settings.Options Or CType(Beacon.DeploySettings.OptionBackup, UInt64)
		  End If
		  If Self.NukeConfigSwitch.Value Then
		    Settings.Options = Settings.Options Or CType(Beacon.DeploySettings.OptionErase, UInt64)
		  End If
		  If Self.ReviewChangesSwitch.Value Then
		    Settings.Options = Settings.Options Or CType(Beacon.DeploySettings.OptionReview, UInt64)
		  End If
		  If Self.RunAdvisorSwitch.Value Then
		    Settings.Options = Settings.Options Or CType(Beacon.DeploySettings.OptionAdvise, UInt64)
		  End If
		  If Self.PlanMenu.SelectedRowIndex > -1 Then
		    Settings.Plan = Self.PlanMenu.SelectedRowTag
		  End If
		  Return Settings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Engine_Wait(Sender As Beacon.DeployIntegration, Controller As Beacon.TaskWaitController) As Boolean
		  Select Case Controller.Action
		  Case "Backup"
		    Try
		      Var UserData As Dictionary = Controller.UserData
		      Var BackupsFolder As FolderItem = App.BackupsFolder
		      If Not BackupsFolder.Exists Then
		        BackupsFolder.CreateFolder
		      End If
		      
		      Var EngineFolder As FolderItem = BackupsFolder.Child(Sender.Profile.BackupFolderName)
		      If Not EngineFolder.Exists Then
		        EngineFolder.CreateFolder
		      End If
		      
		      Var MomentFolder As FolderItem = EngineFolder.Child(Beacon.SanitizeFilename(Self.DeployLabel, 60))
		      If Not MomentFolder.Exists Then
		        MomentFolder.CreateFolder
		      End If
		      
		      Var OldFiles As Dictionary = UserData.Value("Old Files")
		      For Each Entry As DictionaryEntry In OldFiles
		        Var Filename As String = Entry.Key
		        Var Content As String = Entry.Value
		        Var OutStream As TextOutputStream = TextOutputStream.Create(MomentFolder.Child(Filename))
		        OutStream.Write(Content)
		        OutStream.Close
		      Next
		      
		      Var CurrentFolder As FolderItem = EngineFolder.Child("Current")
		      If CurrentFolder.Exists Then
		        Call CurrentFolder.DeepDelete
		      End If
		      CurrentFolder.CreateFolder
		      
		      Var NewFiles As Dictionary = UserData.Value("New Files")
		      For Each Entry As DictionaryEntry In NewFiles
		        Var Filename As String = Entry.Key
		        Var Content As String = Entry.Value
		        Var OutStream As TextOutputStream = TextOutputStream.Create(CurrentFolder.Child(Filename))
		        OutStream.Write(Content)
		        OutStream.Close
		      Next
		    Catch Err As RuntimeException
		      Controller.Cancelled = True
		      
		      App.Log(Err, CurrentMethodName)
		      Self.ShowAlert("Beacon was unable to save ini files for " + Sender.Name + ".", "Check that there is space available on the disk. Use ""Open Data Folder"" from the ""Help"" menu to find the backup destination.")
		    End Try
		    
		    Controller.ShouldResume = True
		  Case "Review Files"
		    If Sender = Self.SelectedEngine Then
		      Self.UpdateMainView()
		    End If
		  Case "Needs Expert Mode"
		    Var Message As String = Sender.Name + " must be converted into expert mode"
		    Var Explanation As String
		    Var UserData As Dictionary = Controller.UserData
		    Var OffendingKey As String = UserData.Lookup("OffendingKey", "")
		    Var ContentLength As Integer = UserData.Lookup("ContentLength", 0)
		    If ContentLength = 0 Then
		      If OffendingKey.IsEmpty = False Then
		        Explanation = "The config key '" + OffendingKey + "' needs to be placed in your GameUserSettings.ini file but Nitrado does not have a built-in config for it."
		      Else
		        Explanation = "There are one or more settings that need to be placed in your GameUserSettings.ini file, but Nitrado does not have a built-in config for them."
		      End If
		      Explanation = Explanation + " In order to build your GameUserSettings.ini correctly, the server must be switched to expert mode. Beacon will restart the server to ensure the latest settings are converted into expert mode before enabling expert mode."
		    Else
		      If OffendingKey.IsEmpty = False Then
		        Explanation = "The config key '" + OffendingKey + "' needs " + ContentLength.ToString(Locale.Current, "#,##0") + " characters of content, but Nitrado limits fields to 65,535 characters."
		      Else
		        Explanation = "There is a config key that needs " + ContentLength.ToString(Locale.Current, "#,##0") + " characters of content, but Nitrado limits fields to 65,535 characters."
		      End If
		      Explanation = Explanation + " In order to build your ini files correctly, the server must be switched to expert mode. Beacon will restart the server to ensure the latest settings are converted into expert mode before enabling expert mode."
		    End If
		    
		    Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm(Message, Explanation, "Turn on expert mode", "Cancel", "Learn More")
		    Select Case Choice
		    Case BeaconUI.ConfirmResponses.Cancel
		      Controller.Cancelled = True
		    Case BeaconUI.ConfirmResponses.Alternate
		      Controller.Cancelled = True
		      System.GotoURL(Beacon.WebURL("/help/nitrado_expert_mode"))
		    End Select
		    
		    Controller.ShouldResume = True
		  Case "ValidationFailed"
		    Var UserData As Dictionary = Controller.UserData
		    Var Message As String = "Beacon was not able to verify the new files will not harm your server."
		    Var Explanation As String = UserData.Value("Message").StringValue + " Check the " + UserData.Value("File").StringValue + " on your server."
		    Var ShouldStop As Boolean = Self.ShowConfirm(Message, Explanation, "Cancel Deploy", "Continue Anyway")
		    Controller.Cancelled = ShouldStop
		    Controller.ShouldResume = True
		  Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedEngine() As Beacon.DeployIntegration
		  If Self.ServerList.SelectedRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Var Engine As Beacon.DeployIntegration = Self.ServerList.CellTagAt(Self.ServerList.SelectedRowIndex, 1)
		  Return Engine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateDeployPlans()
		  Var SelectedPlan As Beacon.DeployPlan
		  If Self.PlanMenu.SelectedRowIndex > -1 Then
		    SelectedPlan = Self.PlanMenu.SelectedRowTag
		  Else
		    SelectedPlan = Preferences.DeployPlan
		  End If
		  Self.UpdateDeployPlans(SelectedPlan)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateDeployPlans(SelectedPlan As Beacon.DeployPlan)
		  Var PlanCounts As New Dictionary
		  Var RequiredPlanCount As Integer
		  
		  For Idx As Integer = 0 To Self.ServerList.LastRowIndex
		    If Self.ServerList.CellCheckBoxValueAt(Idx, 0) = False Then
		      Continue
		    End If
		    RequiredPlanCount = RequiredPlanCount + 1
		    
		    Var Profile As Beacon.ServerProfile = Self.ServerList.RowTagAt(Idx)
		    Var Plans() As Beacon.DeployPlan = Profile.SupportedDeployPlans
		    For Each Plan As Beacon.DeployPlan In Plans
		      PlanCounts.Value(Plan) = PlanCounts.Lookup(Plan, 0) + 1
		    Next
		  Next
		  
		  Var CommonPlans() As Beacon.DeployPlan
		  For Each Entry As DictionaryEntry In PlanCounts
		    Var Plan As Beacon.DeployPlan = Entry.Key
		    Var Count As Integer = Entry.Value
		    If Count <> RequiredPlanCount Then
		      Continue
		    End If
		    CommonPlans.Add(Plan)
		  Next
		  
		  Self.PlanMenu.RemoveAllRows
		  
		  For Each Plan As Beacon.DeployPlan In CommonPlans
		    Var Caption As String
		    Select Case Plan
		    Case Beacon.DeployPlan.StopUploadStart
		      Caption = "Stop server, update config files, then start server."
		    Case Beacon.DeployPlan.UploadRestart
		      Caption = "Update config files, then restart the server."
		    Case Beacon.DeployPlan.UploadOnly
		      Caption = "Update config files. The server will not be restarted."
		    End Select
		    
		    Self.PlanMenu.AddRow(Caption)
		    Self.PlanMenu.RowTagAt(Self.PlanMenu.LastAddedRowIndex) = Plan
		    If SelectedPlan = Plan Then
		      Self.PlanMenu.SelectedRowIndex = Self.PlanMenu.LastAddedRowIndex
		    End If
		  Next
		  
		  Self.PlanMenu.Enabled = CommonPlans.Count > 1
		  Self.PlanLabel.Enabled = Self.PlanMenu.Enabled
		  If Self.PlanMenu.RowCount = 1 Then
		    Self.PlanMenu.SelectedRowIndex = 0
		  End If
		  
		  Self.UpdateControlPositions()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLogsView()
		  If Self.Pages.SelectedPanelIndex <> Self.PageLog Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.ServerList.SelectedRowIndex
		  If Idx = -1 Then
		    If Self.LogsArea.Text.IsEmpty = False Then
		      Self.LogsArea.Text = ""
		      Self.LogsArea.VerticalScrollPosition = 0
		    End If
		    Return
		  End If
		  
		  Var Engine As Beacon.DeployIntegration = Self.ServerList.CellTagAt(Self.ServerList.SelectedRowIndex, 1)
		  
		  Var Logs As String = Engine.Logs
		  If Self.LogsArea.Text = Logs Then
		    Return
		  End If
		  
		  Var ScrollPosition As Integer = Self.LogsArea.VerticalScrollPosition
		  Var IsAtBottom As Boolean = ScrollPosition = Self.LogsArea.LineNumber(Self.LogsArea.Text.Length)
		  Self.LogsArea.Text = Logs
		  If IsAtBottom Then
		    Self.LogsArea.VerticalScrollPosition = 99999999
		  ElseIf Self.LogsArea.VerticalScrollPosition <> ScrollPosition Then // Just in case changing the content changes the scroll position
		    Self.LogsArea.VerticalScrollPosition = ScrollPosition
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMainView()
		  If Self.DeployFinished = False And Self.Working = False Then
		    Self.Pages.SelectedPanelIndex = Self.PageOptions
		    Return
		  End If
		  
		  If Self.SelectedEngine = Nil Then
		    Self.Pages.SelectedPanelIndex = Self.PageNoSelection
		    Return
		  End If
		  
		  Var Controller As Beacon.TaskWaitController = Self.ActiveWaitController
		  If Controller <> Nil Then
		    Select Case Controller.Action
		    Case "Review Files"
		      Self.UpdateReview(Controller)
		      Self.Pages.SelectedPanelIndex = Self.PageReview
		      Return
		    Case "Auth External"
		      Self.Pages.SelectedPanelIndex = Self.PageWaitingAuth
		    End Select
		  End If
		  
		  Self.UpdateLogsView
		  Self.Pages.SelectedPanelIndex = Self.PageLog
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateReview(Controller As Beacon.TaskWaitController)
		  Self.ReviewConfirmationCheck.Value = False
		  
		  Var UserData As Dictionary
		  If Controller.UserData IsA Dictionary Then
		    UserData = Controller.UserData
		  Else
		    UserData = New Dictionary
		  End If
		  
		  Self.UpdatingReviewContent = True
		  Var State As New TextAreaState
		  State.ApplyTo(Self.ReviewArea)
		  Self.ReviewSwitcher.SelectedIndex = 1
		  Try
		    Self.ReviewArea.Text = UserData.Lookup(Self.ReviewSwitcher.SelectedItem.Caption, "").StringValue
		  Catch Err As RuntimeException
		    Self.ReviewArea.Text = ""
		  End Try
		  Self.UpdatingReviewContent = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Controller As Beacon.ProjectController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DeployFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DeployLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Engines As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.Controller.Project
			End Get
		#tag EndGetter
		Private Project As Beacon.Project
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Settings As Beacon.DeploySettings
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UpdatingReviewContent As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Working As Boolean
	#tag EndProperty


	#tag Constant, Name = AdvisorEnabled, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CaptionBackupConfigFiles, Type = String, Dynamic = True, Default = \"Back up config files:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CaptionDeployPlan, Type = String, Dynamic = True, Default = \"Update strategy:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CaptionEraseConfigFiles, Type = String, Dynamic = True, Default = \"Erase server config files:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CaptionReviewChanges, Type = String, Dynamic = True, Default = \"Allow me to review changes:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CaptionRunAdvisor, Type = String, Dynamic = True, Default = \"Run advisor:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLog, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNoSelection, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageOptions, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageReview, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageWaitingAuth, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipBackupConfigFiles, Type = String, Dynamic = True, Default = \"Beacon will keep a copy of your config files from before it makes any changes\x2C as well as after it makes changes. This not only provides a recovery mechanism\x2C but can also help Beacon support diagnose deploy issues.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipDeployPlan, Type = String, Dynamic = True, Default = \"Controls how Beacon will update the server\x2C such as when the server should be started or stopped.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipEraseConfigFiles, Type = String, Dynamic = True, Default = \"Before making its normal changes\x2C Beacon will erase the config files. This can be a useful debugging technique to help clear out content mistakes such as syntax errors\x2C but should not normally be used. Because of the damage potential\x2C config backups must be turned on.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipReviewChanges, Type = String, Dynamic = True, Default = \"Before any changes are made to a server\x2C the new config files will be presented for review and approval. This will require approval for every server\x2C so is not recommended when deploying to more than a few servers.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TooltipRunAdvisor, Type = String, Dynamic = True, Default = \"Beacon\'s deploy advisor will look for common mistakes and recommend changes before continuing with the deploy.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ServerList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> 0 Then
		    Return
		  End If
		  
		  Var Profile As Beacon.ServerProfile = Me.RowTagAt(Row)
		  Profile.Enabled = Me.CellCheckBoxValueAt(Row, Column)
		  
		  Self.CheckOptionsActionEnabled
		  Self.UpdateDeployPlans
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateMainView()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.TypeaheadColumn = 1
		  Me.SortingColumn = 1
		End Sub
	#tag EndEvent
	#tag Event
		Function GetProject() As Beacon.Project
		  Return Self.Project
		End Function
	#tag EndEvent
	#tag Event
		Sub CustomizeProfileRow(Profile As Beacon.ServerProfile, RowIndex As Integer)
		  If Self.Settings.Servers.Count = 0 Then
		    Me.CellCheckBoxValueAt(RowIndex, 0) = Profile.Enabled
		    Return
		  End If
		  
		  For Each OtherProfile As Beacon.ServerProfile In Self.Settings.Servers
		    If OtherProfile = Profile Then
		      Me.CellCheckBoxValueAt(RowIndex, 0) = True
		      Return
		    End If
		  Next
		  
		  Me.CellCheckBoxValueAt(RowIndex, 0) = False
		End Sub
	#tag EndEvent
	#tag Event
		Function BlockUpdate() As Boolean
		  Return Me.ColumnAttributesAt(0).WidthActual = 0
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events OptionsActionButton
	#tag Event
		Sub Pressed()
		  Self.Begin()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewActionButton
	#tag Event
		Sub Pressed()
		  Var Controller As Beacon.TaskWaitController = Self.ActiveWaitController
		  If Controller <> Nil Then
		    Controller.Cancelled = False
		    Controller.ShouldResume = True
		    Self.UpdateMainView()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewCancelButton
	#tag Event
		Sub Pressed()
		  Var Controller As Beacon.TaskWaitController = Self.ActiveWaitController
		  If Controller <> Nil Then
		    Controller.Cancelled = True
		    Controller.ShouldResume = True
		    Self.UpdateMainView()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewConfirmationCheck
	#tag Event
		Sub ValueChanged()
		  Self.ReviewActionButton.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewArea
	#tag Event
		Sub SetupNeeded()
		  Ark.SetupCodeEditor(Me)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ReadOnly = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewSwitcher
	#tag Event
		Sub Opening()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Select Case Self.Project.GameId
		  Case Ark.Identifier
		    Me.Add(IconFileIniFilled, Ark.ConfigFileGameUserSettings, Ark.ConfigFileGameUserSettings)
		    Me.Add(IconFileIni, Ark.ConfigFileGame, Ark.ConfigFileGame)
		  Case ArkSA.Identifier
		    Me.Add(IconFileIniFilled, ArkSA.ConfigFileGameUserSettings, ArkSA.ConfigFileGameUserSettings)
		    Me.Add(IconFileIni, ArkSA.ConfigFileGame, ArkSA.ConfigFileGame)
		  Case Palworld.Identifier
		    Me.Add(IconFileIniFilled, Palworld.ConfigFileSettings, Palworld.ConfigFileSettings)
		  End Select
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		  
		  Select Case Me.Count
		  Case 3
		    Self.ReviewConfirmationCheck.Caption = "The config file is correct"
		  Case 4
		    Self.ReviewConfirmationCheck.Caption = "Both config files are correct"
		  Else
		    Self.ReviewConfirmationCheck.Caption = "All config files are correct"
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  If Self.UpdatingReviewContent Then
		    Return
		  End If
		  
		  Var State As New TextAreaState
		  State.ApplyTo(Self.ReviewArea)
		  
		  Var Controller As Beacon.TaskWaitController = Self.ActiveWaitController
		  If Controller = Nil Or (Controller.UserData IsA Dictionary) = False Then
		    Self.ReviewArea.Text = ""
		    Return
		  End If
		  
		  Self.UpdatingReviewContent = True
		  Var UserData As Dictionary = Controller.UserData
		  Try
		    Var Filename As String = Me.SelectedItem.Caption
		    Self.ReviewArea.Text = UserData.Lookup(Filename, "").StringValue
		  Catch Err As RuntimeException
		    Self.ReviewArea.Text = ""
		  End Try
		  Self.UpdatingReviewContent = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CopyTriggerButton
	#tag Event
		Sub Pressed()
		  Var Settings As Beacon.DeploySettings = Self.CreateSettings
		  Settings.Options = Settings.Options Or Beacon.DeploySettings.OptionRunImmediately
		  
		  Var UseStopMessage As Boolean
		  For I As Integer = 0 To Self.ServerList.LastRowIndex
		    If Not Self.ServerList.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Var Profile As Beacon.ServerProfile = Self.ServerList.RowTagAt(I)
		    Settings.Servers.Add(Profile)
		    UseStopMessage = UseStopMessage Or Profile.SupportsCustomStopMessage
		  Next
		  
		  If UseStopMessage Then
		    Var StopMessage As String = StopMessageDialog.Present(Self)
		    If StopMessage.IsEmpty Then
		      Return
		    End If
		    Settings.StopMessage = StopMessage
		  End If
		  
		  Var TriggerURL As String
		  Try
		    TriggerURL = Self.Controller.BuildDeployURL(Settings)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Unable to Copy Trigger URL", Err.Message)
		    Return
		  End Try
		  Var Board As New Clipboard
		  Board.Text = TriggerURL
		  
		  Me.Caption = "Copied!"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlanMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  If Self.Opened And (Item Is Nil) = False Then
		    Preferences.DeployPlan = Item.Tag
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CreateBackupSwitch
	#tag Event
		Sub Pressed()
		  If Self.Opened Then
		    Preferences.DeployCreateBackup = Me.Value
		  End If
		  If Me.Value = False Then
		    Self.NukeConfigSwitch.Value = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewChangesSwitch
	#tag Event
		Sub Pressed()
		  If Self.Opened Then
		    Preferences.DeployReviewChanges = Me.Value
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RunAdvisorSwitch
	#tag Event
		Sub Pressed()
		  If Self.Opened Then
		    Preferences.DeployRunAdvisor = Me.Value
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NukeConfigSwitch
	#tag Event
		Sub Pressed()
		  If Me.Value Then
		    Self.CreateBackupSwitch.Value = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeployWatcher
	#tag Event
		Sub Action()
		  If Not Self.Working Then
		    Return
		  End If
		  
		  Var AnyCancelled As Boolean = False
		  Var AllFinished As Boolean = True
		  Var NumSuccess, NumErrored As Integer
		  For I As Integer = 0 To Self.ServerList.LastRowIndex
		    Var Profile As Beacon.ServerProfile = Self.ServerList.RowTagAt(I)
		    Var Label As String = Profile.Name
		    
		    Var Engine As Beacon.DeployIntegration = Self.ServerList.CellTagAt(I, 1)
		    If IsNull(Engine) = False Then
		      If Engine.Cancelled Then
		        AnyCancelled = True
		      End If
		      
		      Label = Label + EndOfLine + Engine.StatusMessage
		      
		      If Engine.Finished then
		        If Engine.Errored Then
		          NumErrored = NumErrored + 1
		        Else
		          NumSuccess = NumSuccess + 1
		        End If
		      End If
		      
		      AllFinished = AllFinished And Engine.Finished
		      
		      If Self.ServerList.RowSelectedAt(I) Then
		        Self.UpdateLogsView()
		      End If
		    End If
		    If Self.ServerList.CellTextAt(I, 1) <> Label Then
		      Self.ServerList.CellTextAt(I, 1) = Label
		    End If
		  Next
		  
		  If AllFinished Then
		    Self.Working = False
		    Self.Modified = False
		    Self.DeployFinished = True
		    Me.RunMode = Timer.RunModes.Off
		    
		    If AnyCancelled Then
		      Return
		    End If
		    
		    Var Explanation As String
		    If NumSuccess > 0 And NumErrored = 0 Then
		      // Full success
		      Explanation = "Your server" + If(NumSuccess > 1, "s have", " has") + " been updated. " + If(NumSuccess > 1, "If a restart option was selected, any servers that were running when the deploy started will now be starting up.", "If the server was running when the deploy started and a restart option was selected, it will now be starting up.")
		      If Preferences.PlaySoundAfterDeploy Then
		        SoundDeploySuccess.Play
		      End If
		    ElseIf NumSuccess > 0 And NumErrored > 0 Then
		      // Partial success
		      Explanation = Language.NounWithQuantity(NumSuccess, "server", "servers") + " deployed successfully, but " + Language.NounWithQuantity(NumErrored, "server", "servers") + " did not. To view the logs for a server, select it on the left."
		      If Preferences.PlaySoundAfterDeploy Then
		        SoundDeployFailed.Play
		      End If
		    ElseIf NumSuccess = 0 And NumErrored > 0 Then
		      // Full failure
		      Explanation = "Your server" + If(NumErrored > 1, "s", "") + " did not update successfully. To view the logs for a server, select it on the left. Use your host's control panel to check on the status of your server" + If(NumErrored > 1, "s", "") + " because " + If(NumErrored > 1, "they", "it") + " may or may not be running."
		      If Preferences.PlaySoundAfterDeploy Then
		        SoundDeployFailed.Play
		      End If
		    Else
		      // What?
		    End If
		    
		    // If this was an auto-run, just close the deploy window.
		    If (Self.Settings.Options And CType(Beacon.DeploySettings.OptionRunImmediately, UInt64)) = CType(Beacon.DeploySettings.OptionRunImmediately, UInt64) Then
		      Self.Close
		    Else
		      Self.ShowAlert("The deploy process has finished.", Explanation)
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
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
			"9 - Modeless Dialog"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Type="DesktopMenuBar"
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
