#tag DesktopWindow
Begin SDTDConfigEditor SDTDServersEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   500
   Index           =   -2147483648
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
   Width           =   800
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      HasBottomBorder =   True
      HasTopBorder    =   False
      Height          =   41
      Index           =   -2147483648
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   299
   End
   Begin FadedSeparator FadedSeparator1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   500
      Index           =   -2147483648
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
   Begin DelayedSearchField FilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      AllowTabStop    =   True
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Servers"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   9
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   50
      Transparent     =   False
      Visible         =   True
      Width           =   280
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin OmniBarSeparator FilterSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   81
      Transparent     =   True
      Visible         =   True
      Width           =   299
   End
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
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   40
      DefaultSortColumn=   0
      DefaultSortDirection=   1
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
      HeadingIndex    =   0
      Height          =   418
      Index           =   -2147483648
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
      RowSelectionType=   1
      Scope           =   2
      SingleLineMode  =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   82
      TotalPages      =   -1
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   299
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Thread RefreshThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  Var Container As SDTDServerViewContainer = Self.CurrentView
		  If (Container Is Nil) = False Then
		    Container.SwitchedFrom()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.ServerList.UpdateList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.ServerList.UpdateList()
		  Self.UpdateRefreshButton()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused FireSetupUI
		  
		  Var Container As SDTDServerViewContainer = Self.CurrentView
		  If (Container Is Nil) = False Then
		    Container.SwitchedTo(UserData)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Project As SDTD.Project)
		  Self.mViews = New Dictionary
		  Super.Constructor(Project)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishRefreshingDetails()
		  Var Profiles() As Beacon.ServerProfile = Self.ServerList.SelectedProfiles
		  Self.ServerList.SelectedRowIndex = -1
		  
		  Var ViewIds() As Variant = Self.mViews.Keys
		  For Each ViewId As Variant In ViewIds
		    Var Panel As SDTDServerViewContainer = Self.mViews.Value(ViewId)
		    Panel.Close
		    Self.mViews.Remove(ViewId)
		  Next
		  
		  Self.mRefreshing = False
		  Self.UpdateRefreshButton()
		  Self.ServerList.UpdateList(Profiles, True)
		  
		  Var Explanation As String = "The information shown in the list is the most up-to-date Beacon has available."
		  If Self.Modified Then
		    Explanation = Explanation + " Don't forget to save your project."
		  End If 
		  Self.ShowAlert("Server Refresh Finished", Explanation)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleViewMenu(ItemRect As Rect)
		  Var Base As New DesktopMenuItem
		  
		  Var ViewFullNames As New DesktopMenuItem("Use Full Server Names", ServersListbox.NamesFull)
		  Var ViewAbbreviatedNames As New DesktopMenuItem("Use Abbreviated Server Names", ServersListbox.NamesAbbreviated)
		  Var SortByName As New DesktopMenuItem("Sort By Name", ServersListbox.SortByName)
		  Var SortByAddress As New DesktopMenuItem("Sort By Address", ServersListbox.SortByAddress)
		  Var SortByColor As New DesktopMenuItem("Sort By Color", ServersListbox.SortByColor)
		  Var ShowServerIds As New DesktopMenuItem("Show Server Ids")
		  ViewFullNames.HasCheckMark = Preferences.ServersListNameStyle = ServersListbox.NamesFull
		  ViewAbbreviatedNames.HasCheckMark = Preferences.ServersListNameStyle = ServersListbox.NamesAbbreviated
		  SortByName.HasCheckMark = Preferences.ServersListSortedValue = ServersListbox.SortByName
		  SortByAddress.HasCheckMark = Preferences.ServersListSortedValue = ServersListbox.SortByAddress
		  SortByColor.HasCheckMark = Preferences.ServersListSortedValue = ServersListbox.SortByColor
		  ShowServerIds.HasCheckMark = Preferences.ServersListShowIds
		  Base.AddMenu(ViewFullNames)
		  Base.AddMenu(ViewAbbreviatedNames)
		  Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  Base.AddMenu(SortByName)
		  Base.AddMenu(SortByAddress)
		  Base.AddMenu(SortByColor)
		  Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  Base.AddMenu(ShowServerIds)
		  
		  Var Position As Point = Self.ConfigToolbar.GlobalPosition
		  Var Choice As DesktopMenuItem = Base.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		  If Choice Is Nil Then
		    Return
		  End If
		  
		  Select Case Choice
		  Case ViewFullNames, ViewAbbreviatedNames
		    Preferences.ServersListNameStyle = Choice.Tag.StringValue
		    Self.ServerList.UpdateList()
		  Case SortByName, SortByAddress, SortByColor
		    Preferences.ServersListSortedValue = Choice.Tag.StringValue
		    Self.ServerList.UpdateList()
		  Case ShowServerIds
		    Preferences.ServersListShowIds = Not Preferences.ServersListShowIds
		    Self.ServerList.UpdateList()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return SDTD.Configs.NameServers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshDetails()
		  If Self.mRefreshing = True Then
		    Return
		  End If
		  
		  Self.RefreshThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateRefreshButton()
		  If Self.ConfigToolbar Is Nil Then
		    Return
		  End If
		  
		  Var RefreshButton As OmniBarItem = Self.ConfigToolbar.Item("RefreshButton")
		  If RefreshButton Is Nil Then
		    Return
		  End If
		  
		  RefreshButton.HasProgressIndicator = Self.mRefreshing
		  RefreshButton.Progress = OmniBarItem.ProgressIndeterminate
		  RefreshButton.ActiveColor = If(Self.mRefreshing, OmniBarItem.ActiveColors.Blue, OmniBarItem.ActiveColors.Accent)
		  RefreshButton.AlwaysUseActiveColor = Self.mRefreshing
		  RefreshButton.Enabled = Self.mRefreshing = False And Self.Project.ServerProfileCount > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub View_ContentsChanged(Sender As SDTDServerViewContainer)
		  Self.Modified = Sender.Modified
		  Self.ServerList.UpdateList()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldDeployProfiles(SelectedProfiles() As Beacon.ServerProfile)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentProfileId
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCurrentProfileId = Value Then
			    Return
			  End If
			  
			  If Self.mCurrentProfileId.IsEmpty = False Then
			    Var View As SDTDServerViewContainer = Self.mViews.Value(Self.mCurrentProfileId)
			    View.Visible = False
			    View.SwitchedFrom()
			    Self.mCurrentProfileId = ""
			  End If
			  
			  If Not Self.mViews.HasKey(Value) Then
			    Return
			  End If
			  
			  Var View As SDTDServerViewContainer = Self.mViews.Value(Value)
			  View.SwitchedTo()
			  View.Visible = True
			  Self.mCurrentProfileId = Value
			End Set
		#tag EndSetter
		CurrentProfileId As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mViews.HasKey(Self.mCurrentProfileId) Then
			    Return SDTDServerViewContainer(Self.mViews.Value(Self.mCurrentProfileId))
			  End If
			End Get
		#tag EndGetter
		CurrentView As SDTDServerViewContainer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentProfileId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViews As Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator("ConfigTitleSeparator"))
		  Me.Append(OmniBarItem.CreateButton("AddServerButton", "New Server", IconToolbarAdd, "Add a new simple server."))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateButton("RefreshButton", "Refresh", IconToolbarRefresh, "Refresh server details.", Self.Project.ServerProfileCount > 0))
		  Me.Append(OmniBarItem.CreateButton("ViewOptionsButton", "View", IconToolbarView, "Change server list view options."))
		  
		  Me.Item("ConfigTitle").Priority = 5
		  Me.Item("ConfigTitleSeparator").Priority = 5
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "AddServerButton"
		    Var Profile As New SDTD.ServerProfile(Local.Identifier, Language.DefaultServerName(SDTD.Identifier))
		    
		    Self.Project.AddServerProfile(Profile)
		    Self.ServerList.UpdateList(Profile, True)
		    Self.UpdateRefreshButton()
		  Case "ViewOptionsButton"
		    Self.HandleViewMenu(ItemRect)
		  Case "RefreshButton"
		    Self.RefreshDetails()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ItemHeld(Item As OmniBarItem, ItemRect As Rect) As Boolean
		  Select Case Item.Name
		  Case "ViewOptionsButton"
		    Self.HandleViewMenu(ItemRect)
		    Return True
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.ServerList.Filter = Me.Text.Trim
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerList
	#tag Event
		Sub SelectionChanged()
		  Select Case Me.SelectedRowCount
		  Case 0
		    Self.CurrentProfileId = ""
		    Return
		  Case 1
		    Var Profile As SDTD.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    Var ProfileId As String = Profile.ProfileId
		    If Not Self.mViews.HasKey(ProfileId) Then
		      // Create the view
		      Var View As SDTDServerViewContainer
		      Select Case Profile.ProviderId
		      Case Nitrado.Identifier
		        View = New SDTDNitradoServerView(Self.Project, Profile)
		      Case FTP.Identifier
		        View = New SDTDFTPServerView(Self.Project, Profile)
		      Case Local.Identifier
		        View = New SDTDLocalServerView(Self.Project, Profile)
		      Case GameServerApp.Identifier
		        View = New SDTDGSAServerView(Self.Project, Profile)
		      Else
		        Self.CurrentProfileId = ""
		        Return
		      End Select
		      
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileId) = View
		    End If
		    Self.CurrentProfileId = ProfileId
		  Else
		    Var Profiles() As SDTD.ServerProfile
		    Var Parts() As String
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Not Me.RowSelectedAt(Idx) Then
		        Continue
		      End If
		      
		      Profiles.Add(Me.RowTagAt(Idx))
		      Parts.Add(Profiles(Profiles.LastIndex).ProfileId)
		    Next
		    
		    Var ProfileId As String = Parts.Join(",")
		    If Not Self.mViews.HasKey(ProfileId) Then
		      Var View As New SDTDMultiServerView(Self.Project, Profiles)
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileId) = View
		    End If
		    
		    Self.CurrentProfileId = ProfileId
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var SelCount As Integer = Me.SelectedRowCount
		  If SelCount = 0 Then
		    Return
		  End If
		  
		  If Warn Then
		    Var Subject As String = If(SelCount = 1, "server", "servers")
		    Var DemonstrativeAdjective As String = If(SelCount = 1, "this", "these " + SelCount.ToString)
		    If Not Self.ShowConfirm("Are you sure you want to delete " + DemonstrativeAdjective + " " + Subject + "?", "The " + Subject + " can be added again later using the ""Import"" feature next to the ""Config Type"" menu.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = Me.LastRowIndex DownTo 0
		    If Me.RowSelectedAt(I) Then
		      Var Profile As SDTD.ServerProfile = Me.RowTagAt(I)
		      If Self.mViews.HasKey(Profile.ProfileId) Then
		        If Self.CurrentProfileId = Profile.ProfileId Then
		          Self.CurrentProfileId = ""
		        End If
		        
		        Var Panel As SDTDServerViewContainer = Self.mViews.Value(Profile.ProfileId)
		        Panel.Close
		        Self.mViews.Remove(Profile.ProfileId)
		      End If
		      Self.Project.RemoveServerProfile(Profile)
		      Self.Modified = True
		      Me.RemoveRowAt(I)
		    End If
		  Next
		  
		  Self.UpdateRefreshButton()
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var DeployItem As DesktopMenuItem
		  If Me.SelectedRowCount > 1 Then
		    DeployItem = New DesktopMenuItem("Deploy These Servers…")
		  Else
		    DeployItem = New DesktopMenuItem("Deploy This Server…")
		  End If
		  Var DeployProfiles() As Beacon.ServerProfile
		  Var NitradoProfiles() As SDTD.ServerProfile
		  Var LocalProfiles() As SDTD.ServerProfile
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    Var Profile As SDTD.ServerProfile = Me.RowTagAt(Idx)
		    If Profile.DeployCapable Then
		      DeployProfiles.Add(Profile)
		    End If
		    If Profile.ProviderId = Nitrado.Identifier Then
		      NitradoProfiles.Add(Profile)
		    End If
		    If Profile.ProviderId = Local.Identifier Then
		      LocalProfiles.Add(Profile)
		    End If
		  Next Idx
		  DeployItem.Enabled = DeployProfiles.Count > 0
		  DeployItem.Tag = DeployProfiles
		  Base.AddMenu(DeployItem)
		  
		  Var BackupsItem As New DesktopMenuItem("Show Config Backups")
		  Base.AddMenu(BackupsItem)
		  
		  If NitradoProfiles.Count > 0 Then
		    Base.AddMenu(New DesktopMenuItem("Open Nitrado Dashboard", NitradoProfiles))
		  End If
		  
		  If LocalProfiles.Count > 0 Then
		    #if Not TargetMacOS
		      // Sandbox prevents this from working on macOS
		      Base.AddMenu(New DesktopMenuItem("Show Config Files", LocalProfiles))
		    #endif
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Var Profile As SDTD.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    BackupsItem.Tag = App.BackupsFolder.Child(Profile.BackupFolderName)
		  Else
		    BackupsItem.Tag = App.BackupsFolder
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(HitItem As DesktopMenuItem) As Boolean
		  Select Case HitItem.Text
		  Case "Show Config Backups"
		    Var Folder As FolderItem = HitItem.Tag
		    If Folder = Nil Then
		      Return True
		    End If
		    If Not Folder.Exists Then
		      Folder.CreateFolder
		    End If
		    Folder.Open
		  Case "Deploy These Servers…", "Deploy This Server…"
		    Var SelectedProfiles() As Beacon.ServerProfile = HitItem.Tag
		    RaiseEvent ShouldDeployProfiles(SelectedProfiles)
		  Case "Open Nitrado Dashboard"
		    Var NitradoProfiles() As SDTD.ServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To NitradoProfiles.LastIndex
		      System.GotoURL(Beacon.WebURL("/redirect?destination=nitradodash&serviceid=" + Nitrado.HostConfig(NitradoProfiles(Idx).HostConfig).ServiceId.ToString(Locale.Raw, "0")))
		    Next Idx
		  Case "Show Config Files"
		    Var LocalProfiles() As SDTD.ServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To LocalProfiles.LastIndex
		      Var File As FolderItem
		      #if DebugBuild Or SDTD.Enabled = False
		        #Pragma Warning "Show local files"
		      #else
		        #Pragma Error "Show local files"
		      #endif
		      If (File Is Nil) = False And File.Exists Then
		        File.Parent.Open
		      End If
		    Next Idx
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function GetProject() As Beacon.Project
		  Return Self.Project
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events RefreshThread
	#tag Event
		Sub Run()
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  If Identity Is Nil Then
		    Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": True, "Finished": True))
		    Return
		  End If
		  
		  Self.mRefreshing = True
		  Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": True))
		  
		  Var Tokens() As BeaconAPI.ProviderToken = BeaconAPI.GetProviderTokens(Identity.UserId)
		  Var Filter As New Dictionary
		  For Each Token As BeaconAPI.ProviderToken In Tokens
		    Filter.Value(Token.TokenId) = Token
		  Next
		  
		  Var TokenIds() As String = Self.Project.ProviderTokenIds
		  For Each TokenId As String In TokenIds
		    If Filter.HasKey(TokenId) Then
		      Continue
		    End If
		    
		    Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(TokenId, Self.Project, True)
		    If (Token Is Nil) = False Then
		      Tokens.Add(Token)
		      Filter.Value(Token.TokenId) = Token
		    End If
		  Next
		  
		  Var AllProfiles() As Beacon.ServerProfile = Self.Project.ServerProfiles
		  Var ProfileMap As New Dictionary
		  For Each Profile As Beacon.ServerProfile in AllProfiles
		    ProfileMap.Value(Profile.ProfileId) = Profile
		  Next
		  
		  For Each Token As BeaconAPI.ProviderToken In Tokens
		    Var Provider As Beacon.HostingProvider
		    Var Config As Beacon.HostConfig
		    Select Case Token.Provider
		    Case BeaconAPI.ProviderToken.ProviderNitrado
		      Provider = New Nitrado.HostingProvider
		      Config = New Nitrado.HostConfig
		      Nitrado.HostConfig(Config).TokenId = Token.TokenId
		    Case BeaconAPI.ProviderToken.ProviderGameServerApp
		      Provider = New GameServerApp.HostingProvider
		      Config = New GameServerApp.HostConfig
		      GameServerApp.HostConfig(Config).TokenId = Token.TokenId
		    End Select
		    If Provider Is Nil Then
		      Continue
		    End If
		    
		    Var Profiles() As Beacon.ServerProfile = Provider.ListServers(Config, SDTD.Identifier)
		    For Each Profile As Beacon.ServerProfile In Profiles
		      If ProfileMap.HasKey(Profile.ProfileId) Then
		        Beacon.ServerProfile(ProfileMap.Value(Profile.ProfileId).ObjectValue).SecondaryName = Profile.SecondaryName
		      End If
		    Next
		  Next
		  
		  Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": True, "Finished": True))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Var UpdateUI As Boolean = Update.Lookup("UpdateUI", False).BooleanValue
		    Var Finished As Boolean = Update.Lookup("Finished", False).BooleanValue
		    
		    If UpdateUI Then
		      If Finished Then
		        Self.FinishRefreshingDetails()
		      Else
		        Self.UpdateRefreshButton()
		      End If
		    End If
		  Next
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
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
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
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="CurrentProfileId"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
