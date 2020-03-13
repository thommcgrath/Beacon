#tag Window
Begin BeaconAutopositionWindow DeployManager
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "2"
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
   Type            =   "0"
   Visible         =   True
   Width           =   800
   Begin BeaconListbox ServerList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "22,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
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
      RequiresSelection=   False
      RowSelectionType=   "0"
      Scope           =   2
      SelectionChangeBlocked=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   300
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator ServerListSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
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
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   301
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   499
      Begin Label OptionsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
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
         Left            =   321
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
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   201
         Transparent     =   False
         Underline       =   False
         Value           =   "Choose Deploy Options"
         Visible         =   True
         Width           =   459
      End
      Begin CheckBox CreateBackupCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Back up Game.ini and GameUserSettings.ini before making changes"
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
         Left            =   321
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   233
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   459
      End
      Begin CheckBox ReviewChangesCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Allow me to review changes before updating server"
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
         Left            =   321
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   265
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   459
      End
      Begin PushButton OptionsActionButton
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
         Left            =   700
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   329
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin CheckBox RunAdvisorCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Run advisor on content before updating server"
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
         Left            =   321
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   297
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   False
         VisualState     =   "0"
         Width           =   459
      End
      Begin Label LogsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
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
         Left            =   321
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
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Value           =   "Status Messages"
         Visible         =   True
         Width           =   459
      End
      Begin TextArea LogsArea
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
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
         Left            =   321
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
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   459
      End
      Begin Shelf ReviewSwitcher
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         DoubleBuffer    =   False
         DrawCaptions    =   True
         Enabled         =   True
         Height          =   72
         Index           =   -2147483648
         InitialParent   =   "Pages"
         IsVertical      =   False
         Left            =   301
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   False
         Visible         =   True
         Width           =   499
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
         MacButtonStyle  =   "0"
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
         MacButtonStyle  =   "0"
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
      Begin CheckBox ReviewConfirmationCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Both config files are correct"
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
         Left            =   321
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
         VisualState     =   "0"
         Width           =   255
      End
      Begin FadedSeparator ReviewBottomSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   301
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   489
         Transparent     =   True
         Visible         =   True
         Width           =   499
      End
      Begin FadedSeparator ReviewTopSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   301
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   72
         Transparent     =   True
         Visible         =   True
         Width           =   499
      End
      Begin CodeArea ReviewArea
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   False
         HasHorizontalScrollbar=   True
         HasVerticalScrollbar=   True
         Height          =   416
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   301
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
         TabPanelIndex   =   3
         TabStop         =   True
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   73
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   499
      End
      Begin LogoFillCanvas NoSelectionCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Caption         =   "No Selection"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   550
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   301
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   499
      End
   End
   Begin Timer DeployWatcher
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   50
      RunMode         =   "0"
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Beacon.OAuth2Client Authorizer
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  If Not Self.Working Then
		    Return False
		  End If
		  
		  Return Not Self.ShowConfirm("There is still a deploy operation in progress. Closing this window now will leave unfinished jobs in an unknown state.", "Please don't complain if your config files are only partially uploaded.", If(AppQuitting, "Quit Anyway", "Close Anyway"), "Cancel")
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  For Each Entry As DictionaryEntry In Engines
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    Engine.Terminate
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.Title = "Deploy: " + Self.Document.Title
		  
		  Self.CreateBackupCheckbox.Value = Preferences.DeployCreateBackup
		  Self.ReviewChangesCheckbox.Value = Preferences.DeployReviewChanges
		  Self.RunAdvisorCheckbox.Value = Preferences.DeployRunAdvisor
		  
		  Var ProfileBound As Integer = Self.Document.ServerProfileCount - 1
		  For Idx As Integer = 0 To ProfileBound
		    Var Profile As Beacon.ServerProfile = Self.Document.ServerProfile(Idx)
		    Var Label As String = Profile.Name
		    If Profile.SecondaryName.Length > 0 Then
		      Label = Label + EndOfLine + Profile.SecondaryName
		    End If
		    Self.ServerList.AddRow("", Label)
		    Self.ServerList.RowTagAt(Self.ServerList.LastAddedRowIndex) = Profile
		    Self.ServerList.CellCheckBoxValueAt(Self.ServerList.LastAddedRowIndex, 0) = Profile.Enabled
		  Next
		  
		  Self.ServerList.DefaultRowHeight = BeaconListbox.DoubleLineRowHeight
		  Self.ServerList.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		  Self.ServerList.SortingColumn = 1
		  Self.ServerList.Sort
		  
		  Self.CheckOptionsActionEnabled
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateControlPositions()
		  Const MaxOptionsWidth = 460
		  
		  Var AvailableWidth As Integer = Self.Pages.Width - 20
		  Var OptionsWidth As Integer = Min(AvailableWidth, MaxOptionsWidth)
		  Var OptionsLeft As Integer = Round((AvailableWidth - OptionsWidth) / 2)
		  Self.OptionsMessageLabel.Left = Self.Pages.Left + OptionsLeft
		  Self.OptionsMessageLabel.Width = OptionsWidth
		  Self.CreateBackupCheckbox.Left = Self.Pages.Left + OptionsLeft
		  Self.CreateBackupCheckbox.Width = OptionsWidth
		  Self.ReviewChangesCheckbox.Left = Self.Pages.Left + OptionsLeft
		  Self.ReviewChangesCheckbox.Width = OptionsWidth
		  Self.RunAdvisorCheckbox.Left = Self.Pages.Left + OptionsLeft
		  Self.RunAdvisorCheckbox.Width = OptionsWidth
		  Self.OptionsActionButton.Left = (Self.Pages.Left + OptionsLeft + OptionsWidth) - Self.OptionsActionButton.Width
		  
		  Var OptionControlsHeight As Integer = Self.OptionsMessageLabel.Height + 12 + Self.OptionsActionButton.Height
		  If Self.CreateBackupCheckbox.Visible Then
		    OptionControlsHeight = OptionControlsHeight + 12 + Self.CreateBackupCheckbox.Height
		  End If
		  If Self.ReviewChangesCheckbox.Visible Then
		    OptionControlsHeight = OptionControlsHeight + 12 + Self.ReviewChangesCheckbox.Height
		  End If
		  If Self.RunAdvisorCheckbox.Visible Then
		    OptionControlsHeight = OptionControlsHeight + 12 + Self.RunAdvisorCheckbox.Height
		  End If
		  
		  Var OptionControlsTop As Integer = Round((Self.Pages.Height - OptionControlsHeight) / 2) + Self.Pages.Top
		  Self.OptionsMessageLabel.Top = OptionControlsTop
		  Var Pos As Integer = Self.OptionsMessageLabel.Top + Self.OptionsMessageLabel.Height
		  If Self.CreateBackupCheckbox.Visible Then
		    Self.CreateBackupCheckbox.Top = Pos + 12
		    Pos = Pos + 12 + Self.CreateBackupCheckbox.Height
		  End If
		  If Self.ReviewChangesCheckbox.Visible Then
		    Self.ReviewChangesCheckbox.Top = Pos + 12
		    Pos = Pos + 12 + Self.ReviewChangesCheckbox.Height
		  End If
		  If Self.RunAdvisorCheckbox.Visible Then
		    Self.RunAdvisorCheckbox.Top = Pos + 12
		    Pos = Pos + 12 + Self.RunAdvisorCheckbox.Height
		  End If
		  Self.OptionsActionButton.Top = Pos + 12
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function ActiveWaitController() As Beacon.TaskWaitController
		  Var Engine As Beacon.IntegrationEngine = Self.SelectedEngine
		  If Engine = Nil Then
		    Return Nil
		  End If
		  
		  Return Engine.ActiveWaitController
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Begin()
		  Var NowGMT As New DateTime(DateTime.Now.SecondsFrom1970, New TimeZone(0))
		  Var Now As DateTime = DateTime.Now
		  Self.DeployLabel = Str(NowGMT.Year, "0000") + "-" + Str(NowGMT.Month, "00") + "-" + Str(NowGMT.Day, "00") + " " + Str(NowGMT.Hour, "00") + ":" + Str(NowGMT.Minute, "00") + ":" + Str(NowGMT.Second, "00") + " GMT (" + Now.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Short) + " " + Now.Timezone.Abbreviation + ")"
		  
		  Self.Engines = New Dictionary
		  For I As Integer = Self.ServerList.LastRowIndex DownTo 0
		    If Not Self.ServerList.CellCheckBoxValueAt(I, 0) Then
		      Self.ServerList.RemoveRowAt(I)
		      Continue
		    End If
		    
		    Var Profile As Beacon.ServerProfile = Self.ServerList.RowTagAt(I)
		    Var Engine As Beacon.IntegrationEngine
		    Select Case Profile
		    Case IsA Beacon.NitradoServerProfile
		      Engine = New Beacon.NitradoIntegrationEngine(Profile)
		    Case IsA Beacon.FTPServerProfile
		      //DeploymentEngine = New Beacon.FTPDeploymentEngine(Beacon.FTPServerProfile(Profile))
		    Case IsA Beacon.ConnectorServerProfile
		      //DeploymentEngine = New Beacon.ConnectorDeploymentEngine(Beacon.ConnectorServerProfile(Profile))
		    Case IsA Beacon.LocalServerProfile
		      Engine = New Beacon.LocalIntegrationEngine(Profile)
		    End Select
		    If IsNull(Engine) Then
		      Continue
		    End If
		    
		    AddHandler Engine.Wait, WeakAddressOf Engine_Wait
		    
		    Self.Engines.Value(Engine) = Profile
		    Self.ServerList.CellTagAt(I, 1) = Engine
		  Next
		  
		  // Hide the checkbox column
		  Self.ServerList.ColumnWidths = "0,*"
		  
		  // Mark that we're doing something
		  Self.Working = True
		  Self.Changed = True
		  
		  // Watch for changes
		  Self.DeployWatcher.RunMode = Timer.RunModes.Multiple
		  
		  // Show the log view
		  Self.Pages.SelectedPanelIndex = Self.PageLog
		  If Self.ServerList.SelectedRowIndex = -1 Then
		    Self.ServerList.SelectedRowIndex = 0
		  End If
		  
		  // Start the engines!
		  Var Options As UInt64
		  If Self.CreateBackupCheckbox.Value Then
		    Options = Options Or Beacon.IntegrationEngine.OptionBackup
		  End If
		  If Self.ReviewChangesCheckbox.Value Then
		    Options = Options Or Beacon.IntegrationEngine.OptionReview
		  End If
		  If Self.RunAdvisorCheckbox.Value Then
		    Options = Options Or Beacon.IntegrationEngine.OptionAnalyze
		  End If
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    Engine.BeginDeploy(Self.DeployLabel, Self.Document, App.IdentityManager.CurrentIdentity, "", Options)
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
		Sub Constructor(Document As Beacon.Document)
		  Self.Document = Document
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Engine_Wait(Sender As Beacon.IntegrationEngine, Controller As Beacon.TaskWaitController)
		  Select Case Controller.Action
		  Case "Backup"
		    Var UserData As Dictionary = Controller.UserData
		    Try
		      Var BackupsFolder As FolderItem = App.BackupsFolder
		      If Not BackupsFolder.Exists Then
		        BackupsFolder.CreateFolder
		      End If
		      
		      Var EngineFolder As FolderItem = BackupsFolder.Child(Beacon.SanitizeFilename(Sender.Name))
		      If Not EngineFolder.Exists Then
		        EngineFolder.CreateFolder
		      End If
		      
		      Var MomentFolder As FolderItem = EngineFolder.Child(Beacon.SanitizeFilename(Self.DeployLabel))
		      If Not MomentFolder.Exists Then
		        MomentFolder.CreateFolder
		      End If
		      
		      Var OutStream As TextOutputStream
		      
		      OutStream = TextOutputStream.Create(MomentFolder.Child("Game.ini"))
		      OutStream.Write(UserData.Value("Game.ini").StringValue)
		      OutStream.Close
		      
		      OutStream = TextOutputStream.Create(MomentFolder.Child("GameUserSettings.ini"))
		      OutStream.Write(UserData.Value("GameUserSettings.ini").StringValue)
		      OutStream.Close
		    Catch Err As RuntimeException
		      Controller.Cancelled = True
		      
		      Self.ShowAlert("Beacon was unable to backup the ini files for " + Sender.Name + ".", "Check that there is space available on the disk. Use ""Open Data Folder"" from the ""Help"" menu to find the backup destination.")
		    End Try
		    
		    Controller.ShouldResume = True
		  Case "Review Files"
		    Self.UpdateMainView()
		  Case "Auth External"
		    Self.UpdateMainView()
		    
		    Var UserData As Dictionary = Controller.UserData
		    Var Account As Beacon.ExternalAccount
		    If UserData.HasKey("Account") Then
		      Account = UserData.Value("Account")
		    End If
		    If Account = Nil Then
		      If UserData.HasKey("Provider") Then
		        Account = New Beacon.ExternalAccount(New v4UUID, UserData.Value("Provider").StringValue, "", "", Nil)
		      Else
		        Controller.Cancelled = True
		        Controller.ShouldResume = True
		        Return
		      End If
		    End If
		    
		    UserData.Value("Account UUID") = Account.UUID.StringValue
		    Self.AuthQueue.AddRow(Account)
		    If Self.Authorizer.Busy = False And Self.AuthQueue.Count = 1 Then
		      Self.RunNextAuth()
		    End If
		  Case "Needs Expert Mode"
		    Var Message As String = Sender.Name + " must be converted into Expert Mode"
		    Var Explanation As String = "Beacon cannot manage Nitrado's Beginner Mode settings. If you choose to continue, Beacon will restart the server to ensure the latest settings are converted into Expert Mode before enabling Expert Mode."
		    
		    Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm(Message, Explanation, "Turn on Expert Mode", "Cancel", "Learn More")
		    Select Case Choice
		    Case BeaconUI.ConfirmResponses.Cancel
		      Controller.Cancelled = True
		    Case BeaconUI.ConfirmResponses.Alternate
		      Controller.Cancelled = True
		      ShowURL(Beacon.WebURL("/help/nitrado_expert_mode"))
		    End Select
		    
		    Controller.ShouldResume = True
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FindEngineForAccount(Account As Beacon.ExternalAccount) As Beacon.IntegrationEngine
		  Var AccountUUID As String = Account.UUID
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    Var Controller As Beacon.TaskWaitController = Engine.ActiveWaitController
		    If Controller = Nil Or Controller.Action <> "Auth External" Then
		      Continue
		    End If
		    
		    Var UserData As Dictionary = Controller.UserData
		    If UserData.Lookup("Account UUID", "").StringValue = AccountUUID Then
		      Return Engine
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunNextAuth()
		  If Self.AuthQueue.Count = 0 Then
		    Return
		  End If
		  
		  Var Account As Beacon.ExternalAccount = Self.AuthQueue(0)
		  
		  If Not Self.Authorizer.SetAccount(Account) Then
		    Self.ShowAlert("This version of Beacon does not support " + Account.Provider + " servers.", "This probably means an upgrade is available.")
		    Return
		  End If
		  
		  Self.Authorizer.Authenticate(App.IdentityManager.CurrentIdentity)
		  Self.AuthQueue.RemoveRowAt(0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedEngine() As Beacon.IntegrationEngine
		  If Self.ServerList.SelectedRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Var Engine As Beacon.IntegrationEngine = Self.ServerList.CellTagAt(Self.ServerList.SelectedRowIndex, 1)
		  Return Engine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLogsView()
		  If Self.Pages.SelectedPanelIndex <> Self.PageLog Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.ServerList.SelectedRowIndex
		  If Idx = -1 Then
		    Self.LogsArea.Value = ""
		    Return
		  End If
		  
		  Var Engine As Beacon.IntegrationEngine = Self.ServerList.CellTagAt(Self.ServerList.SelectedRowIndex, 1)
		  Var ShouldScroll As Boolean = True// = Self.LogsArea.VerticalScrollPosition = Self.LogsArea.
		  Self.LogsArea.Value = Engine.Logs
		  If ShouldScroll Then
		    Self.LogsArea.VerticalScrollPosition = 99999999
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMainView()
		  If Not Self.Working Then
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
		  Self.ReviewArea.Value = UserData.Lookup("GameUserSettings.ini", "").StringValue
		  Self.UpdatingReviewContent = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AuthQueue() As Beacon.ExternalAccount
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DeployLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Document As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Engines As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UpdatingReviewContent As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Working As Boolean
	#tag EndProperty


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
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.UpdateMainView()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CreateBackupCheckbox
	#tag Event
		Sub Action()
		  If Self.Opened Then
		    Preferences.DeployCreateBackup = Me.Value
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewChangesCheckbox
	#tag Event
		Sub Action()
		  If Self.Opened Then
		    Preferences.DeployReviewChanges = Me.Value
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OptionsActionButton
	#tag Event
		Sub Action()
		  Self.Begin()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RunAdvisorCheckbox
	#tag Event
		Sub Action()
		  If Self.Opened Then
		    Preferences.DeployRunAdvisor = Me.Value
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewSwitcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconGameUserSettingsIni, "GameUserSettings.ini", "gameusersettings.ini")
		  Me.Add(IconGameIni, "Game.ini", "game.ini")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  If Self.UpdatingReviewContent Then
		    Return
		  End If
		  
		  Var State As New TextAreaState
		  State.ApplyTo(Self.ReviewArea)
		  
		  Var Controller As Beacon.TaskWaitController = Self.ActiveWaitController
		  If Controller = Nil Or (Controller.UserData IsA Dictionary) = False Then
		    Self.ReviewArea.Value = ""
		    Return
		  End If
		  
		  Self.UpdatingReviewContent = True
		  Var UserData As Dictionary = Controller.UserData
		  Select Case Me.SelectedIndex
		  Case 1
		    Self.ReviewArea.Value = UserData.Lookup("GameUserSettings.ini", "").StringValue
		  Case 2
		    Self.ReviewArea.Value = UserData.Lookup("Game.ini", "").StringValue
		  End Select
		  Self.UpdatingReviewContent = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewActionButton
	#tag Event
		Sub Action()
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
		Sub Action()
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
		Sub Action()
		  Self.ReviewActionButton.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeployWatcher
	#tag Event
		Sub Action()
		  If Not Self.Working Then
		    Return
		  End If
		  
		  Var AllFinished As Boolean = True
		  For I As Integer = 0 To Self.ServerList.LastRowIndex
		    Var Profile As Beacon.ServerProfile = Self.ServerList.RowTagAt(I)
		    Var Label As String = Profile.Name
		    
		    Var Engine As Beacon.IntegrationEngine = Self.ServerList.CellTagAt(I, 1)
		    If IsNull(Engine) = False Then
		      Var Status As String
		      If Engine.Cancelled Then
		        Status = "Cancelled"
		      ElseIf Engine.Finished And Engine.Errored = False Then
		        Status = "Finished"
		      Else
		        Status = Engine.Logs(True)
		      End If
		      Label = Label + EndOfLine + Status
		      
		      AllFinished = AllFinished And Engine.Finished
		      
		      If Self.ServerList.Selected(I) Then
		        Self.UpdateLogsView()
		      End If
		    End If
		    If Self.ServerList.CellValueAt(I, 1) <> Label Then
		      Self.ServerList.CellValueAt(I, 1) = Label
		    End If
		  Next
		  
		  If AllFinished Then
		    Self.Working = False
		    Self.Changed = False
		    Me.RunMode = Timer.RunModes.Off
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Authorizer
	#tag Event
		Sub Authenticated()
		  Var Engine As Beacon.IntegrationEngine = Self.FindEngineForAccount(Me.Account)
		  Var Controller As Beacon.TaskWaitController = Engine.ActiveWaitController
		  If Controller <> Nil Then
		    Dictionary(Controller.UserData).Value("Account") = Me.Account
		    Controller.Cancelled = False
		    Controller.ShouldResume = True
		  End If
		  
		  Self.UpdateMainView()
		  Self.RunNextAuth()
		End Sub
	#tag EndEvent
	#tag Event
		Sub AuthenticationError()
		  Var Engine As Beacon.IntegrationEngine = Self.FindEngineForAccount(Me.Account)
		  Var Controller As Beacon.TaskWaitController = Engine.ActiveWaitController
		  If Controller <> Nil Then
		    Dictionary(Controller.UserData).Value("Account") = Nil
		    Controller.Cancelled = True
		    Controller.ShouldResume = True
		  End If
		  
		  Self.UpdateMainView()
		  Self.RunNextAuth()
		End Sub
	#tag EndEvent
	#tag Event
		Function StartAuthentication(URL As String, Provider As String) As Boolean
		  If Not Self.ShowConfirm("You must reauthorize " + Provider + " to allow Beacon to access your servers.", "The authorization tokens expires. If it has been a while since you've deployed, this can happen.", "Continue", "Cancel") Then
		    Var Engine As Beacon.IntegrationEngine = Self.FindEngineForAccount(Me.Account)
		    If Engine <> Nil And Engine.ActiveWaitController <> Nil Then
		      Engine.ActiveWaitController.Cancelled = True
		      Engine.ActiveWaitController.ShouldResume = True
		    End If
		    
		    Return False
		  End If
		  
		  ShowURL(URL)
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
