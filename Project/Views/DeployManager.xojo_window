#tag Window
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
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
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
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      TypeaheadColumn =   1
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
      ContentHeight   =   0
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
      TabStop         =   True
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
         TextAlignment   =   0
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
         VisualState     =   0
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
         VisualState     =   0
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
         Left            =   700
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
         Top             =   361
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
         VisualState     =   0
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
         TextAlignment   =   0
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
         AllowStyledText =   False
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
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   459
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
         VisualState     =   0
         Width           =   255
      End
      Begin CodeEditor ReviewArea
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   416
         HorizontalScrollPosition=   0
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   301
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
         Width           =   499
      End
      Begin Shelf ReviewSwitcher
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
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
         Width           =   499
      End
      Begin FadedSeparator ReviewBottomSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
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
         Width           =   499
      End
      Begin FadedSeparator ReviewTopSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
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
         Width           =   499
      End
      Begin LogoFillCanvas NoSelectionCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Caption         =   "No Selection"
         ContentHeight   =   0
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
         Width           =   499
      End
      Begin CheckBox NukeConfigCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Erase server Game.ini and GameUserSettings.ini files"
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   329
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   459
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
		  If (Self.Engines Is Nil) Then
		    Return
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    Engine.Terminate
		  Next
		  
		  Self.Engines.RemoveAll
		  Self.Engines = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.Title = "Deploy: " + Self.Project.Title
		  
		  Self.CreateBackupCheckbox.Value = Preferences.DeployCreateBackup
		  Self.ReviewChangesCheckbox.Value = Preferences.DeployReviewChanges
		  Self.RunAdvisorCheckbox.Value = Preferences.DeployRunAdvisor
		  
		  
		  
		  // Var ProfileBound As Integer = Self.Project.ServerProfileCount - 1
		  // For Idx As Integer = 0 To ProfileBound
		  // Var Profile As Beacon.ServerProfile = Self.Project.ServerProfile(Idx)
		  // If Profile.DeployCapable = False Then
		  // Continue
		  // End If
		  // 
		  // Var Label As String = Profile.Name
		  // If Profile.SecondaryName.Length > 0 Then
		  // Label = Label + EndOfLine + Profile.SecondaryName
		  // End If
		  // Self.ServerList.AddRow("", Label)
		  // Self.ServerList.RowTagAt(Self.ServerList.LastAddedRowIndex) = Profile
		  // If Self.PreselectProfileUUIDs.Count = 0 Then
		  // Self.ServerList.CellCheckBoxValueAt(Self.ServerList.LastAddedRowIndex, 0) = Profile.Enabled
		  // Else
		  // Self.ServerList.CellCheckBoxValueAt(Self.ServerList.LastAddedRowIndex, 0) = Self.PreselectProfileUUIDs.IndexOf(Profile.ProfileID) > -1
		  // End If
		  // Next
		  
		  Self.ServerList.DefaultRowHeight = BeaconListbox.DoubleLineRowHeight
		  Self.ServerList.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		  Self.ServerList.UpdateList()
		  
		  Self.CheckOptionsActionEnabled
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateControlPositions()
		  Const MaxOptionsWidth = 460
		  
		  Var OptionCheckboxes() As CheckBox = Array(Self.CreateBackupCheckbox, Self.NukeConfigCheckbox, Self.ReviewChangesCheckbox, Self.RunAdvisorCheckbox)
		  For Idx As Integer = OptionCheckboxes.LastIndex DownTo OptionCheckboxes.FirstIndex
		    If OptionCheckboxes(Idx).Visible = False Then
		      OptionCheckboxes.RemoveAt(Idx)
		    End If
		  Next Idx
		  
		  Var AvailableWidth As Integer = Self.Pages.Width - 20
		  Var OptionsWidth As Integer = Min(AvailableWidth, MaxOptionsWidth)
		  Var OptionsLeft As Integer = Self.Pages.Left + Round((AvailableWidth - OptionsWidth) / 2)
		  Var Position As Integer = Self.OptionsMessageLabel.Top + Self.OptionsMessageLabel.Height + 12
		  Self.OptionsMessageLabel.Left = OptionsLeft
		  Self.OptionsMessageLabel.Width = OptionsWidth
		  For Idx As Integer = OptionCheckboxes.FirstIndex To OptionCheckboxes.LastIndex
		    OptionCheckboxes(Idx).Left = OptionsLeft
		    OptionCheckboxes(Idx).Width = OptionsWidth
		    OptionCheckboxes(Idx).Top = Position
		    Position = Position + OptionCheckboxes(Idx).Height + 12
		  Next Idx
		  Self.OptionsActionButton.Top = Position
		  Self.OptionsActionButton.Left = (OptionsLeft + OptionsWidth) - Self.OptionsActionButton.Width
		  
		  Var Group As New ControlGroup(Self.OptionsMessageLabel, Self.OptionsActionButton)
		  For Idx As Integer = OptionCheckboxes.FirstIndex To OptionCheckboxes.LastIndex
		    Group.Append(OptionCheckboxes(Idx))
		  Next Idx
		  Group.Top = Self.Pages.Top + Round((Self.Pages.Height - Group.Height) / 2)
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
		  Self.DeployLabel = NowGMT.Year.ToString(Locale.Raw, "0000") + "-" + NowGMT.Month.ToString(Locale.Raw, "00") + "-" + NowGMT.Day.ToString(Locale.Raw, "00") + " " + NowGMT.Hour.ToString(Locale.Raw, "00") + ":" + NowGMT.Minute.ToString(Locale.Raw, "00") + ":" + NowGMT.Second.ToString(Locale.Raw, "00") + " GMT (" + Now.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Short) + " " + Now.Timezone.Abbreviation + ")"
		  
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
		    
		    Var Engine As Beacon.IntegrationEngine
		    Select Case Profile
		    Case IsA Ark.NitradoServerProfile
		      Engine = New Ark.NitradoIntegrationEngine(Profile)
		    Case IsA Ark.FTPServerProfile
		      Engine = New Ark.FTPIntegrationEngine(Profile)
		    Case IsA Ark.ConnectorServerProfile
		      //DeploymentEngine = New Beacon.ConnectorDeploymentEngine(Beacon.ConnectorServerProfile(Profile))
		    Case IsA Ark.LocalServerProfile
		      Engine = New Ark.LocalIntegrationEngine(Profile)
		    Case IsA Ark.GSAServerProfile
		      Engine = New Ark.GSAIntegrationEngine(Profile)
		    End Select
		    If Engine Is Nil Then
		      Var ProfileInfo As Introspection.TypeInfo = Introspection.GetType(Profile)
		      ProfileProblems.Value("profile """ + Profile.Name + """") = "Unknown profile class: " + ProfileInfo.FullName
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
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    If Not Engine.SupportsStopMessage Then
		      Continue
		    End If
		    
		    StopMessage = StopMessageDialog.Present(Self)
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
		    Options = Options Or CType(Beacon.IntegrationEngine.OptionBackup, UInt64)
		  End If
		  If Self.ReviewChangesCheckbox.Value Then
		    Options = Options Or CType(Beacon.IntegrationEngine.OptionReview, UInt64)
		  End If
		  If Self.RunAdvisorCheckbox.Value Then
		    Options = Options Or CType(Beacon.IntegrationEngine.OptionAnalyze, UInt64)
		  End If
		  If Self.NukeConfigCheckbox.Value Then
		    Options = Options Or CType(Beacon.IntegrationEngine.OptionNuke, UInt64)
		  End If
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    Engine.BeginDeploy(Self.DeployLabel, Self.Project, App.IdentityManager.CurrentIdentity, StopMessage, Options)
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
		Sub Constructor(Project As Beacon.Project, PreselectServers() As Beacon.ServerProfile)
		  Self.Project = Project
		  For Each Profile As Beacon.ServerProfile In PreselectServers
		    Self.PreselectProfileUUIDs.Add(Profile.ProfileID)
		  Next Profile
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Engine_Wait(Sender As Beacon.IntegrationEngine, Controller As Beacon.TaskWaitController) As Boolean
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
		  Case "Auth External"
		    Self.UpdateMainView()
		    
		    Var UserData As Dictionary = Controller.UserData
		    Var Account As Beacon.ExternalAccount
		    If UserData.HasKey("Account") And IsNull(UserData.Value("Account")) = False Then
		      Account = UserData.Value("Account")
		    End If
		    If Account Is Nil And UserData.HasKey("Account UUID") And UserData.Value("Account UUID").StringValue.IsEmpty = False Then
		      Account = New Beacon.ExternalAccount(UserData.Value("Account UUID").StringValue, "", UserData.Value("Provider").StringValue, "", "", Nil)
		    End If
		    If Account Is Nil Then
		      If UserData.HasKey("Provider") Then
		        Account = New Beacon.ExternalAccount(UserData.Value("Provider").StringValue)
		      Else
		        Controller.Cancelled = True
		        Controller.ShouldResume = True
		        Return True
		      End If
		    End If
		    
		    UserData.Value("Account UUID") = Account.UUID.StringValue
		    
		    Var FoundInQueue As Boolean = False
		    For Each QueueItem As Beacon.ExternalAccount In Self.AuthQueue
		      If QueueItem.UUID = Account.UUID Then
		        FoundInQueue = True
		        Exit
		      End If
		    Next
		    If FoundInQueue = False Then
		      Self.AuthQueue.Add(Account)
		      If Self.Authorizer.Busy = False And Self.AuthQueue.Count = 1 Then
		        Self.RunNextAuth()
		      End If
		    End If
		  Case "Needs Expert Mode"
		    Var Message As String = Sender.Name + " must be converted into expert mode"
		    Var Explanation As String
		    #if Ark.NitradoIntegrationEngine.GuidedModeSupportEnabled
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
		          Explanation = "The config key '" + OffendingKey + "' needs " + ContentLength.ToString(Locale.Current, ",##0") + " characters of content, but Nitrado limits fields to 65,535 characters."
		        Else
		          Explanation = "There is a config key that needs " + ContentLength.ToString(Locale.Current, ",##0") + " characters of content, but Nitrado limits fields to 65,535 characters."
		        End If
		        Explanation = Explanation + " In order to build your ini files correctly, the server must be switched to expert mode. Beacon will restart the server to ensure the latest settings are converted into expert mode before enabling expert mode."
		      End If
		    #else
		      Explanation = "Beacon cannot manage Nitrado's beginner mode settings. If you choose to continue, Beacon will restart the server to ensure the latest settings are converted into expert mode before enabling expert mode."
		    #endif
		    
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
		Private Function FindEnginesForAccount(Account As Beacon.ExternalAccount) As Beacon.IntegrationEngine()
		  Var AccountUUID As String = Account.UUID
		  Var Engines() As Beacon.IntegrationEngine
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    Var Controller As Beacon.TaskWaitController = Engine.ActiveWaitController
		    If Controller = Nil Or Controller.Action <> "Auth External" Then
		      Continue
		    End If
		    
		    Var UserData As Dictionary = Controller.UserData
		    If UserData.Lookup("Account UUID", "").StringValue = AccountUUID Then
		      Engines.Add(Engine)
		    End If
		  Next
		  Return Engines
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
		  Self.AuthQueue.RemoveAt(0)
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
		    Self.LogsArea.Text = ""
		    Return
		  End If
		  
		  Var Engine As Beacon.IntegrationEngine = Self.ServerList.CellTagAt(Self.ServerList.SelectedRowIndex, 1)
		  Var ShouldScroll As Boolean = True// = Self.LogsArea.VerticalScrollPosition = Self.LogsArea.
		  Self.LogsArea.Text = Engine.Logs
		  If ShouldScroll Then
		    Self.LogsArea.VerticalScrollPosition = 99999999
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
		  Self.ReviewArea.Text = UserData.Lookup(Ark.ConfigFileGameUserSettings, "").StringValue
		  Self.UpdatingReviewContent = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AuthQueue() As Beacon.ExternalAccount
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

	#tag Property, Flags = &h21
		Private PreselectProfileUUIDs() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Project As Beacon.Project
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
	#tag Event
		Sub Open()
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
		  If Self.PreselectProfileUUIDs.Count = 0 Then
		    Me.CellCheckBoxValueAt(RowIndex, 0) = Profile.Enabled
		  Else
		    Me.CellCheckBoxValueAt(RowIndex, 0) = Self.PreselectProfileUUIDs.IndexOf(Profile.ProfileID) > -1
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function BlockUpdate() As Boolean
		  Return Me.ColumnAt(0).WidthActual = 0
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events CreateBackupCheckbox
	#tag Event
		Sub Action()
		  If Self.Opened Then
		    Preferences.DeployCreateBackup = Me.Value
		  End If
		  If Me.Value = False Then
		    Self.NukeConfigCheckbox.Value = False
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
#tag Events ReviewArea
	#tag Event
		Sub SetupNeeded()
		  Ark.SetupCodeEditor(Me)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ReadOnly = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewSwitcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconGameUserSettingsIni, Ark.ConfigFileGameUserSettings, Ark.ConfigFileGameUserSettings)
		  Me.Add(IconGameIni, Ark.ConfigFileGame, Ark.ConfigFileGame)
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
		    Self.ReviewArea.Text = ""
		    Return
		  End If
		  
		  Self.UpdatingReviewContent = True
		  Var UserData As Dictionary = Controller.UserData
		  Select Case Me.SelectedIndex
		  Case 1
		    Self.ReviewArea.Text = UserData.Lookup(Ark.ConfigFileGameUserSettings, "").StringValue
		  Case 2
		    Self.ReviewArea.Text = UserData.Lookup(Ark.ConfigFileGame, "").StringValue
		  End Select
		  Self.UpdatingReviewContent = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NukeConfigCheckbox
	#tag Event
		Sub Action()
		  If Me.Value Then
		    Self.CreateBackupCheckbox.Value = True
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
		    
		    Var Engine As Beacon.IntegrationEngine = Self.ServerList.CellTagAt(I, 1)
		    If IsNull(Engine) = False Then
		      If Engine.Cancelled Then
		        AnyCancelled = True
		      End If
		      
		      Label = Label + EndOfLine + Engine.Status
		      
		      If Engine.Finished then
		        If Engine.Errored Then
		          NumErrored = NumErrored + 1
		        Else
		          NumSuccess = NumSuccess + 1
		        End If
		      End If
		      
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
		    Self.DeployFinished = True
		    Me.RunMode = Timer.RunModes.Off
		    
		    If AnyCancelled Then
		      Return
		    End If
		    
		    Var Explanation As String
		    If NumSuccess > 0 And NumErrored = 0 Then
		      // Full success
		      Explanation = "Your server" + If(NumSuccess > 1, "s have", " has") + " been updated. " + If(NumSuccess > 1, "Any servers that were running when the deploy started will now be starting up.", "If the server was running when the deploy started, it will now be starting up.")
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
		    
		    Self.ShowAlert("The deploy process has finished.", Explanation)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Authorizer
	#tag Event
		Sub Authenticated()
		  Var Engines() As Beacon.IntegrationEngine = Self.FindEnginesForAccount(Me.Account)
		  For Each Engine As Beacon.IntegrationEngine In Engines
		    Var Controller As Beacon.TaskWaitController = Engine.ActiveWaitController
		    If (Controller Is Nil) = False Then
		      Dictionary(Controller.UserData).Value("Account") = Me.Account
		      Controller.Cancelled = False
		      Controller.ShouldResume = True
		    End If
		  Next
		  
		  Self.UpdateMainView()
		  Self.RunNextAuth()
		End Sub
	#tag EndEvent
	#tag Event
		Sub AuthenticationError(Reason As String)
		  #Pragma Unused Reason
		  
		  Var Engines() As Beacon.IntegrationEngine = Self.FindEnginesForAccount(Me.Account)
		  For Each Engine As Beacon.IntegrationEngine In Engines
		    Var Controller As Beacon.TaskWaitController = Engine.ActiveWaitController
		    If (Controller Is Nil) = False Then
		      Dictionary(Controller.UserData).Value("Account") = Nil
		      Controller.Cancelled = True
		      Controller.ShouldResume = True
		    End If
		  Next
		  
		  Self.UpdateMainView()
		  Self.RunNextAuth()
		End Sub
	#tag EndEvent
	#tag Event
		Function StartAuthentication(Account As Beacon.ExternalAccount, URL As String) As Boolean
		  If Not Self.ShowConfirm(Account) Then
		    Var Engines() As Beacon.IntegrationEngine = Self.FindEnginesForAccount(Account)
		    For Each Engine As Beacon.IntegrationEngine In Engines
		      If Engine <> Nil And Engine.ActiveWaitController <> Nil Then
		        Engine.ActiveWaitController.Cancelled = True
		        Engine.ActiveWaitController.ShouldResume = True
		      End If
		    Next
		    
		    Return False
		  End If
		  
		  System.GotoURL(URL)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub AccountUUIDChanged(OldUUID As v4UUID)
		  Self.Project.ReplaceAccount(OldUUID, Me.Account)
		  
		  Var AccountUUID As String = Me.Account.UUID
		  For Each Entry As DictionaryEntry In Self.Engines
		    Var Engine As Beacon.IntegrationEngine = Entry.Key
		    Var Controller As Beacon.TaskWaitController = Engine.ActiveWaitController
		    If Controller = Nil Or Controller.Action <> "Auth External" Then
		      Continue
		    End If
		    
		    Var UserData As Dictionary = Controller.UserData
		    If UserData.HasKey("Account UUID") And UserData.Value("Account UUID").StringValue = OldUUID Then
		      UserData.Value("Account UUID") = AccountUUID
		    End If
		    
		    If Engine.Profile.ExternalAccountUUID = OldUUID Then
		      Engine.Profile.ExternalAccountUUID = AccountUUID
		    End If
		  Next
		End Sub
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
