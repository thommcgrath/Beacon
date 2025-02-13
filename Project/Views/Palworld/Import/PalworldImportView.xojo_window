#tag DesktopWindow
Begin DocumentImportView PalworldImportView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   "False"
   Composited      =   False
   DefaultLocation =   "2"
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   FullScreen      =   "False"
   HasBackgroundColor=   False
   HasCloseButton  =   "True"
   HasFullScreenButton=   "False"
   HasMaximizeButton=   "True"
   HasMinimizeButton=   "True"
   Height          =   480
   ImplicitInstance=   "True"
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   MacProcID       =   "0"
   MaximumHeight   =   "32000"
   MaximumWidth    =   "32000"
   MenuBar         =   "0"
   MenuBarVisible  =   "False"
   MinimumHeight   =   "64"
   MinimumWidth    =   "64"
   Resizeable      =   "True"
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Title           =   "Untitled"
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Type            =   "0"
   Visible         =   True
   Width           =   720
   Begin DesktopPagePanel Views
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   480
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   8
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   720
      Begin FTPDiscoveryView FTPDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   480
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
      Begin PalworldFilesDiscoveryView FilesDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   480
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
      Begin DesktopLabel StatusMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Import Status"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   680
      End
      Begin UITweaks.ResizedPushButton StatusCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   620
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   440
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel OtherDocsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         TabPanelIndex   =   6
         TabStop         =   True
         Text            =   "Import from Other Projects"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   680
      End
      Begin UITweaks.ResizedPushButton OtherDocsActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   620
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   6
         TabStop         =   True
         Tooltip         =   ""
         Top             =   440
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton OtherDocsCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   528
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   6
         TabStop         =   True
         Tooltip         =   ""
         Top             =   440
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox StatusList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   1
         ColumnWidths    =   ""
         DefaultRowHeight=   40
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   360
         Index           =   -2147483648
         InitialParent   =   "Views"
         InitialValue    =   ""
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PageSize        =   100
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   60
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   680
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconListbox OtherDocsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   2
         ColumnWidths    =   "26,*"
         DefaultRowHeight=   26
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   1
         Height          =   360
         Index           =   -2147483648
         InitialParent   =   "Views"
         InitialValue    =   ""
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PageSize        =   100
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   6
         TabStop         =   True
         Tooltip         =   ""
         Top             =   60
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   680
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin DocumentImportSourcePicker SourcePicker
         AllowAutoDeactivate=   True
         AllowedSources  =   63
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         EnabledSources  =   63
         HasBackgroundColor=   False
         Height          =   282
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
      Begin UITweaks.ResizedPushButton StatusActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Import"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   528
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   440
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   80
      End
      Begin PalworldClipboardDiscoveryView ClipboardDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   480
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   8
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
      Begin MultiSelectDiscoveryView NitradoDiscoveryView1
         AddressColumnLabel=   "Address"
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   480
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
      Begin MultiSelectDiscoveryView GSADiscoveryView1
         AddressColumnLabel=   "Template Id"
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   480
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   7
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   720
      End
   End
   Begin Timer DiscoveryWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   100
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Cleanup()
		  Self.ClipboardDiscoveryView1.Cleanup
		  Self.FilesDiscoveryView1.Cleanup
		  Self.FTPDiscoveryView1.Cleanup
		  Self.GSADiscoveryView1.Cleanup
		  Self.NitradoDiscoveryView1.Cleanup
		End Sub
	#tag EndEvent

	#tag Event
		Sub Discover(Profiles() As Beacon.ServerProfile)
		  Self.mIntegrations.ResizeTo(Profiles.LastIndex)
		  Self.StatusList.RowCount = Profiles.Count
		  
		  For Idx As Integer = Self.mIntegrations.FirstRowIndex To Self.mIntegrations.LastIndex
		    If (Profiles(Idx) IsA Palworld.ServerProfile) = False Then
		      Continue
		    End If
		    
		    Var Integration As New Palworld.DiscoverIntegration(Self.mDestinationProject, Profiles(Idx))
		    Integration.Begin()
		    Self.mIntegrations(Idx) = Integration
		    
		    Self.StatusList.CellTextAt(Idx, 0) = Profiles(Idx).Name + EndOfLine + "Starting parser…"
		    Self.StatusList.RowTagAt(Idx) = Integration
		  Next
		  
		  Self.SetThreadPriorities()
		  Self.DiscoveryWatcher.RunMode = Timer.RunModes.Multiple
		  Self.Views.SelectedPanelIndex = Self.PageStatus
		End Sub
	#tag EndEvent

	#tag Event
		Sub ImportFile(File As FolderItem)
		  Self.QuickCancel = True
		  Self.Views.SelectedPanelIndex = 3
		  Self.FilesDiscoveryView1.AddFile(File)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  
		  Self.SwapButtons
		  Self.Reset
		End Sub
	#tag EndEvent

	#tag Event
		Sub PullValuesFromProject(Project As Beacon.Project)
		  If (Project IsA Palworld.Project) = False Then
		    Return
		  End If
		  
		  Var ArkProject As Palworld.Project = Palworld.Project(Project)
		  Self.mDestinationProject = ArkProject
		  Self.FTPDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.FilesDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.ClipboardDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.NitradoDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.GSADiscoveryView1.PullValuesFromProject(ArkProject)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Reset()
		  For Idx As Integer = 0 To Self.mIntegrations.LastIndex
		    If (Self.mIntegrations(Idx) Is Nil) = False And Not Self.mIntegrations(Idx).Finished Then
		      Self.mIntegrations(Idx).Cancel
		    End If
		  Next
		  
		  Self.mIntegrations.ResizeTo(-1)
		  
		  If (Self.Views Is Nil) = False Then
		    If Self.Views.SelectedPanelIndex <> 0 Then
		      Self.Views.SelectedPanelIndex = 0
		    Else
		      Self.SetPageHeight(Self.SourcePicker.Height)
		      Self.SourcePicker.ActionButtonEnabled = True
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetOtherProjects(Projects() As Beacon.Project)
		  Var DestinationProjectId As String
		  If (Self.mDestinationProject Is Nil) = False Then
		    DestinationProjectId = Self.mDestinationProject.ProjectId
		  End If
		  
		  Self.mOtherProjects = Projects
		  
		  If Projects.Count > 0 Then
		    Self.SourcePicker.EnabledSources = Self.SourcePicker.EnabledSources Or Self.SourcePicker.SourceOtherProject
		  Else
		    Self.SourcePicker.EnabledSources = Self.SourcePicker.EnabledSources And Not Self.SourcePicker.SourceOtherProject
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Finish()
		  Var Projects() As Beacon.Project
		  For Idx As Integer = Self.mIntegrations.FirstRowIndex To Self.mIntegrations.LastIndex
		    If (Self.mIntegrations(Idx).Project Is Nil) = False Then
		      Projects.Add(Self.mIntegrations(Idx).Project)
		    End If
		  Next
		  Self.Finish(Projects)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MigrateThread_Run(Sender As Beacon.Thread)
		  Var SourceProject As Ark.Project = Sender.UserData
		  Var NewProject As New Palworld.Project
		  Var ConfigSets() As Beacon.ConfigSet = SourceProject.ConfigSets
		  For Each ConfigSet As Beacon.ConfigSet In ConfigSets
		    Var ClonedConfigSet As Beacon.ConfigSet
		    If ConfigSet.IsBase Then
		      ClonedConfigSet = NewProject.ConfigSet("Base")
		    Else
		      ClonedConfigSet = New Beacon.ConfigSet(ConfigSet.Name)
		      NewProject.AddConfigSet(ClonedConfigSet)
		    End If
		    
		    For Each Group As Beacon.ConfigGroup In SourceProject.ImplementedConfigs(ConfigSet)
		      // Skip servers and accounts
		      Var GroupName As String
		      Select Case Group.InternalName
		      Case Ark.Configs.NameCustomConfig
		        GroupName = Palworld.Configs.NameCustomConfig
		      Case Ark.Configs.NameGeneralSettings
		        GroupName = Palworld.Configs.NameGeneralSettings
		      Case Ark.Configs.NameProjectSettings
		        GroupName = Palworld.Configs.NameProjectSettings
		      Else
		        Continue
		      End Select
		      
		      Try
		        Var SaveData As JSONItem = Group.SaveData
		        If SaveData Is Nil Then
		          Continue
		        End If
		        
		        Var EncryptedData As JSONItem
		        If SaveData.HasAllKeys("Plain", "Encrypted") Then
		          EncryptedData = SaveData.Child("Encrypted")
		          SaveData = SaveData.Child("Plain")
		        End If
		        
		        Var NewGroup As Palworld.ConfigGroup = Palworld.Configs.CreateInstance(GroupName, SaveData, EncryptedData)
		        If NewGroup Is Nil Then
		          Continue
		        End If
		        
		        NewProject.AddConfigGroup(NewGroup, ClonedConfigSet)
		      Catch Err As RuntimeException
		      End Try
		    Next
		  Next
		  
		  // Cleanup stuff
		  NewProject.PruneUnknownContent()
		  
		  Var Update As New Dictionary
		  Update.Value("Event") = "Finished"
		  Update.Value("Project") = NewProject
		  Sender.AddUserInterfaceUpdate(Update)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MigrateThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  For Each Update As Dictionary In Updates
		    Var EventName As String = Update.Lookup("Event", "").StringValue
		    Select Case EventName
		    Case "Finished"
		      Var Project As Palworld.Project = Update.Value("Project")
		      Self.mSourceProjects.Add(Project)
		      
		      Var Idx As Integer = Self.mMigrationThreads.IndexOf(Sender)
		      If Idx > -1 Then
		        Self.mMigrationThreads.RemoveAt(Idx)
		      End If
		      
		      If Self.mMigrationThreads.Count = 0 Then
		        If (Self.mMigrationProgress Is Nil) = False Then
		          Self.mMigrationProgress.Close
		          Self.mMigrationProgress = Nil
		        End If
		        Self.Finish(Self.mSourceProjects)
		      End If
		    End Select
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetThreadPriorities()
		  // Dynamically adjusts thread priority depending on the number that are actively running
		  
		  Var ActiveIntegrations() As Palworld.DiscoverIntegration
		  For Each Integration As Palworld.DiscoverIntegration In Self.mIntegrations
		    If Integration Is Nil Then
		      Continue
		    End If
		    
		    If Integration.ThreadState <> Global.Thread.ThreadStates.NotRunning Then
		      ActiveIntegrations.Add(Integration)
		    End If
		  Next
		  
		  Var Priority As Integer = If(ActiveIntegrations.Count > 3, Global.Thread.LowestPriority, Global.Thread.NormalPriority)
		  For Each Integration As Palworld.DiscoverIntegration In ActiveIntegrations
		    If Integration.ThreadPriority <> Priority Then
		      Integration.ThreadPriority = Priority
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DocumentsImported(Documents() As Beacon.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDestinationProject As Palworld.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIntegrations() As Palworld.DiscoverIntegration
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMigrationProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMigrationThreads() As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOtherProjects() As Beacon.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourceProjects() As Beacon.Project
	#tag EndProperty

	#tag Property, Flags = &h0
		QuickCancel As Boolean
	#tag EndProperty


	#tag Constant, Name = MigrationMessagePlural, Type = String, Dynamic = True, Default = \"Migrating \?1 Projects", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MigrationMessageSingular, Type = String, Dynamic = True, Default = \"Migrating \?1 Project", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageClipboard, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageFiles, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageFTP, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageGSA, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNitrado, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageOtherDocuments, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSources, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageStatus, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusPageHeight, Type = Double, Dynamic = False, Default = \"456", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Views
	#tag Event
		Sub PanelChanged()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageSources
		    Self.SetPageHeight(Self.SourcePicker.Height)
		    Self.SourcePicker.ActionButtonEnabled = True
		  Case Self.PageNitrado
		    Self.NitradoDiscoveryView1.Begin
		  Case Self.PageFTP
		    Self.FTPDiscoveryView1.Begin
		  Case Self.PageFiles
		    Self.FilesDiscoveryView1.Begin
		  Case Self.PageClipboard
		    Self.ClipboardDiscoveryView1.Begin
		  Case Self.PageStatus, Self.PageOtherDocuments
		    Self.SetPageHeight(Self.StatusPageHeight)
		  Case Self.PageGSA
		    Self.GSADiscoveryView1.Begin
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FTPDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Profiles() As Beacon.ServerProfile)
		  Self.Discover(Profiles)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Beacon.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
	#tag Event
		Function CreateServerProfile(Name As String) As Beacon.ServerProfile
		  Return New Palworld.ServerProfile(FTP.Identifier, Name)
		End Function
	#tag EndEvent
	#tag Event
		Function GameId() As String
		  Return Palworld.Identifier
		End Function
	#tag EndEvent
	#tag Event
		Function Satisfied(Path As String) As Boolean
		  // Allow the selection of any file, because the user might have renamed them or using a symlink
		  Return Path.EndsWith("/") = False
		End Function
	#tag EndEvent
	#tag Event
		Function Discover(Provider As FTP.HostingProvider, InitialProfile As Beacon.ServerProfile, SenderThread As Beacon.Thread) As Beacon.ServerProfile()
		  // Do not trap exceptions here. The caller has its own handler so that error messages can reach the user.
		  
		  #Pragma Unused SenderThread
		  
		  Var Profiles() As Beacon.ServerProfile
		  Var RootFilenames() As String
		  RootFilenames = Provider.ListFiles(Self.mDestinationProject, InitialProfile, "/")
		  If RootFilenames Is Nil Or RootFilenames.Count = 0 Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "The server did not list any files."
		    Raise Err
		  End If
		  
		  Var IPMatch As New Regex
		  IPMatch.SearchPattern = "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}_\d{1,5}$"
		  
		  Var PotentialPaths() As String
		  For Each Filename As String In RootFilenames
		    If Filename.EndsWith("/") = False Then
		      Continue
		    End If
		    
		    Filename = Filename.Left(Filename.Length - 1)
		    If Filename = "Palworld" Or Filename = "arkserver" Then
		      PotentialPaths.Add("/" + FileName + "/ShooterGame/Saved")
		      PotentialPaths.Add("/" + Filename + "/ShooterGame/SavedArks")
		    ElseIf Filename = "ShooterGame" Then
		      PotentialPaths.Add("/" + FileName + "/Saved")
		      PotentialPaths.Add("/" + FileName + "/SavedArks")
		    ElseIf Filename = "Saved" Or Filename = "SavedArks" Then
		      PotentialPaths.Add("/" + Filename)
		    ElseIf IPMatch.Search(Filename) <> Nil Then
		      PotentialPaths.Add("/" + Filename + "/ShooterGame/Saved")
		      PotentialPaths.Add("/" + Filename + "/ShooterGame/SavedArks")
		    End If
		  Next
		  
		  For Each Path As String In PotentialPaths
		    Var Filenames() As String
		    Try
		      Filenames = Provider.ListFiles(Self.mDestinationProject, InitialProfile, Path + "/")
		    Catch Err As RuntimeException
		      Continue
		    End Try
		    Var LogsPath, ConfigPath As String
		    For Each Filename As String In Filenames
		      Select Case FileName
		      Case "Config/"
		        ConfigPath = Path + "/Config"
		      Case "Logs/"
		        LogsPath = Path + "/Logs"
		      End Select
		    Next
		    If ConfigPath.IsEmpty Then
		      Continue
		    End If
		    
		    Try
		      Filenames = Provider.ListFiles(Self.mDestinationProject, InitialProfile, ConfigPath + "/")
		    Catch Err As RuntimeException
		      Continue
		    End Try
		    Var Found As Boolean
		    For Each Filename As String In Filenames
		      If Filename.EndsWith("/") = False Then
		        Continue
		      End If
		      
		      If Filename.EndsWith("Server/") Or Filename.EndsWith("NoEditor/") Then
		        ConfigPath = ConfigPath + "/" + Filename.Left(Filename.Length - 1)
		        Found = True
		      End If
		    Next
		    
		    If Not Found Then
		      Continue
		    End If
		    
		    Var SettingsIniPath As String = ConfigPath + "/" + Palworld.ConfigFileSettings
		    Var ProfileId As String = Beacon.UUID.v5(FTP.Identifier + ":" + InitialProfile.HostConfig.Hash + ":" + SettingsIniPath)
		    Var Profile As New Palworld.ServerProfile(FTP.Identifier, ProfileId, InitialProfile.Name, InitialProfile.Nickname, InitialProfile.SecondaryName)
		    Profile.HostConfig = InitialProfile.HostConfig
		    Profile.SettingsIniPath = SettingsIniPath
		    Profile.LogsPath = LogsPath
		    Profiles.Add(Profile)
		  Next
		  
		  If Profiles.Count = 0 Then
		    Var SettingsIniPath As String = Me.ChoosePath(Palworld.ConfigFileSettings, FTPDiscoveryView.ChooserOptionAllowFiles Or FTPDiscoveryView.ChooserOptionStrictNames)
		    If SettingsIniPath.IsEmpty Then
		      // Cancelled
		      Return Profiles
		    End If
		    
		    Var PathComponents() As String = SettingsIniPath.Split("/")
		    PathComponents.RemoveAt(PathComponents.LastIndex)
		    
		    Var LogsPath As String
		    If PathComponents.Count >= 2 Then
		      PathComponents.RemoveAt(PathComponents.LastIndex)
		      PathComponents.RemoveAt(PathComponents.LastIndex)
		      
		      Var SavedPath As String = String.FromArray(PathComponents, "/")
		      Var Children() As String = Provider.ListFiles(Self.mDestinationProject, InitialProfile, SavedPath + "/")
		      If Children.IndexOf("Logs/") > -1 Then
		        LogsPath = SavedPath + "/Logs"
		      Else
		        LogsPath = Me.ChoosePath("Logs", FTPDiscoveryView.ChooserOptionAllowFolders Or FTPDiscoveryView.ChooserOptionOptional Or FTPDiscoveryView.ChooserOptionStrictNames)
		      End If
		      If LogsPath.EndsWith("/") Then
		        LogsPath = LogsPath.Left(LogsPath.Length -1)
		      End If
		    End If
		    
		    Var ProfileId As String = Beacon.UUID.v5(FTP.Identifier + ":" + InitialProfile.HostConfig.Hash + ":" + SettingsIniPath)
		    Var Profile As New Palworld.ServerProfile(FTP.Identifier, ProfileId, InitialProfile.Name, InitialProfile.Nickname, InitialProfile.SecondaryName)
		    Profile.HostConfig = InitialProfile.HostConfig
		    Profile.SettingsIniPath = SettingsIniPath
		    Profile.LogsPath = LogsPath
		    Profiles.Add(Profile)
		  End If
		  
		  Return Profiles
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events FilesDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Profiles() As Beacon.ServerProfile)
		  Self.Discover(Profiles)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Beacon.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events StatusCancelButton
	#tag Event
		Sub Pressed()
		  If Self.QuickCancel Then
		    Self.Close
		  Else
		    Self.Reset()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsActionButton
	#tag Event
		Sub Pressed()
		  Self.mSourceProjects.ResizeTo(-1)
		  For I As Integer = 0 To OtherDocsList.RowCount - 1
		    If Not OtherDocsList.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Var SourceProject As Beacon.Project = OtherDocsList.RowTagAt(I)
		    Select Case SourceProject
		    Case IsA Palworld.Project
		      Self.mSourceProjects.Add(Palworld.Project(SourceProject).Clone(App.IdentityManager.CurrentIdentity))
		    Case IsA Ark.Project
		      // We need to export to ini, then import from that, and finally prune it.
		      Var MigrateThread As New Beacon.Thread
		      MigrateThread.UserData = SourceProject
		      MigrateThread.DebugIdentifier = "Palworld Migrator Thread"
		      AddHandler MigrateThread.Run, WeakAddressOf MigrateThread_Run
		      AddHandler MigrateThread.UserInterfaceUpdate, WeakAddressOf MigrateThread_UserInterfaceUpdate
		      MigrateThread.Start
		      Self.mMigrationThreads.Add(MigrateThread)
		    End Select
		  Next
		  If Self.mMigrationThreads.Count = 0 Then
		    Self.Finish(Self.mSourceProjects)
		  Else
		    Self.mMigrationProgress = New ProgressWindow
		    Self.mMigrationProgress.Message = Language.ReplacePlaceholders(If(Self.mMigrationThreads.Count = 1, Self.MigrationMessageSingular, Self.MigrationMessagePlural), Language.GameName(Ark.Identifier))
		    Self.mMigrationProgress.Progress = Nil
		    Self.mMigrationProgress.Show(Self)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsCancelButton
	#tag Event
		Sub Pressed()
		  Views.SelectedPanelIndex = Self.PageSources
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  
		  If Column <> 0 Then
		    Return
		  End If
		  
		  Var Enabled As Boolean
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.CellCheckBoxValueAt(I, Column) Then
		      Enabled = True
		      Exit For I
		    End If
		  Next
		  
		  OtherDocsActionButton.Enabled = Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourcePicker
	#tag Event
		Sub Cancelled()
		  Self.Dismiss()
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SourceChosen(Source As Integer)
		  Select Case Source
		  Case Me.SourceFTP
		    Self.Views.SelectedPanelIndex = Self.PageFTP
		  Case Me.SourceGSA
		    Self.Views.SelectedPanelIndex = Self.PageGSA
		  Case Me.SourceFiles
		    Self.Views.SelectedPanelIndex = Self.PageFiles
		  Case Me.SourceClipboard
		    Self.Views.SelectedPanelIndex = Self.PageClipboard
		  Case Me.SourceNitrado
		    Self.Views.SelectedPanelIndex = Self.PageNitrado
		  Case Me.SourceOtherProject
		    Self.OtherDocsList.RemoveAllRows
		    Self.OtherDocsList.ColumnTypeAt(0) = DesktopListBox.CellTypes.CheckBox
		    For Each Project As Beacon.Project In Self.mOtherProjects
		      Self.OtherDocsList.AddRow("", Project.Title)
		      Self.OtherDocsList.RowTagAt(Self.OtherDocsList.LastAddedRowIndex) = Project
		    Next
		    Self.OtherDocsList.Sort()
		    Self.OtherDocsActionButton.Enabled = False
		    
		    Self.Views.SelectedPanelIndex = Self.PageOtherDocuments
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function CompatibleGameIds() As String()
		  Return Array(Palworld.Identifier)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events StatusActionButton
	#tag Event
		Sub Pressed()
		  Self.Finish()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClipboardDiscoveryView1
	#tag Event
		Sub Finished(Profiles() As Beacon.ServerProfile)
		  Self.Discover(Profiles)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Beacon.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NitradoDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Profiles() As Beacon.ServerProfile)
		  Self.Discover(Profiles)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Beacon.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
	#tag Event
		Function GameId() As String
		  Return Palworld.Identifier
		End Function
	#tag EndEvent
	#tag Event
		Function CreateHostingProvider() As Beacon.HostingProvider
		  Return New Nitrado.HostingProvider
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events GSADiscoveryView1
	#tag Event
		Sub Finished(Profiles() As Beacon.ServerProfile)
		  Self.Discover(Profiles)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Beacon.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
	#tag Event
		Function CreateHostingProvider() As Beacon.HostingProvider
		  Return New GameServerApp.HostingProvider
		End Function
	#tag EndEvent
	#tag Event
		Function GameId() As String
		  Return Palworld.Identifier
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events DiscoveryWatcher
	#tag Event
		Sub Action()
		  Self.SetThreadPriorities()
		  
		  Var AllFinished As Boolean = True
		  Var ErrorCount, SuccessCount As Integer
		  For I As Integer = 0 To Self.StatusList.LastRowIndex
		    Var Integration As Palworld.DiscoverIntegration = Self.StatusList.RowTagAt(I)
		    AllFinished = AllFinished And Integration.Finished
		    Self.StatusList.CellTextAt(I, 0) = Integration.Name + EndOfLine + Integration.StatusMessage
		    
		    If Integration.Finished Then
		      If Integration.Project Is Nil Then
		        ErrorCount = ErrorCount + 1
		      Else
		        SuccessCount = SuccessCount + 1
		      End If
		    End If
		  Next
		  
		  If AllFinished Then
		    Me.RunMode = Timer.RunModes.Off
		    If ErrorCount = 0 Then
		      If Preferences.PlaySoundAfterImport Then
		        SoundDeploySuccess.Play
		      End If
		      Self.Finish()
		    ElseIf SuccessCount > 0 Then
		      If Preferences.PlaySoundAfterImport Then
		        SoundDeployFailed.Play
		      End If
		      If Self.ShowConfirm("There were import errors.", "Not all files imported successfully. Do you want to continue importing with the files that did import?", "Continue Import", "Review Errors") Then
		        Self.Finish()
		      Else
		        Self.StatusActionButton.Visible = True
		        Self.StatusActionButton.Default = True
		        UITweaks.SwapButtons(Self.StatusActionButton, Self.StatusCancelButton)
		      End If
		    Else
		      If Preferences.PlaySoundAfterImport Then
		        SoundDeployFailed.Play
		      End If
		      Self.ShowAlert("No files imported.", "Beacon was not able to import anything from the selected files.")
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="QuickCancel"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
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
		EditorType=""
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
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
