#tag DesktopWindow
Begin ArkSAConfigEditor ArkSAServersEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
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
      Height          =   346
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
      InitialParent   =   ""
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
   Begin DelayedSearchField FilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
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
      TabStop         =   True
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
      InitialParent   =   ""
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
   Begin Thread RefreshThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
   Begin StatusContainer Status
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      CenterCaption   =   ""
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   31
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftCaption     =   ""
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      RightCaption    =   ""
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   469
      Transparent     =   True
      Visible         =   True
      Width           =   299
   End
   Begin OmniBar AltToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      HasBottomBorder =   False
      HasTopBorder    =   True
      Height          =   41
      Index           =   -2147483648
      Left            =   0
      LeftPadding     =   7
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      RightPadding    =   7
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   428
      Transparent     =   True
      Visible         =   True
      Width           =   299
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  Var Container As ArkSAServerViewContainer = Self.CurrentView
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
		  
		  Var Container As ArkSAServerViewContainer = Self.CurrentView
		  If (Container Is Nil) = False Then
		    Container.SwitchedTo(UserData)
		  End If
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function CopyMOTDToAllServers() As Boolean Handles CopyMOTDToAllServers.Action
		  If Self.IsFrontmost = False Then
		    Return False
		  End If
		  
		  Var CurrentProfileID As String = Self.CurrentProfileID
		  If CurrentProfileID.IsEmpty Then
		    Return True
		  End If
		  Self.CurrentProfileID = ""
		  
		  Var SourceProfile As ArkSA.ServerProfile
		  Var Bound As Integer = Self.Project.ServerProfileCount - 1
		  For Idx As Integer = 0 To Bound
		    If Self.Project.ServerProfile(Idx).ProfileID = CurrentProfileID And Self.Project.ServerProfile(Idx) IsA ArkSA.ServerProfile Then
		      SourceProfile = ArkSA.ServerProfile(Self.Project.ServerProfile(Idx))
		      Exit
		    End If
		  Next
		  
		  If SourceProfile Is Nil Then
		    Self.CurrentProfileID = CurrentProfileID
		    Return True
		  End If
		  
		  Var Message As ArkSA.ArkML = SourceProfile.MessageOfTheDay
		  Var Duration As Integer = SourceProfile.MessageDuration
		  
		  For Idx As Integer = 0 To Bound
		    If Self.Project.ServerProfile(Idx).ProfileID <> CurrentProfileID And Self.Project.ServerProfile(Idx) IsA ArkSA.ServerProfile Then
		      ArkSA.ServerProfile(Self.Project.ServerProfile(Idx)).MessageOfTheDay = Message.Clone
		      ArkSA.ServerProfile(Self.Project.ServerProfile(Idx)).MessageDuration = Duration
		      Self.Modified = Self.Modified Or Self.Project.Modified
		    End If
		  Next
		  
		  Self.CurrentProfileID = CurrentProfileID
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddToSentinel(Profiles() As ArkSA.ServerProfile)
		  Var RequestBody As New JSONItem("[]")
		  For Each Profile As ArkSA.ServerProfile In Profiles
		    Var Server As New JSONItem("{}")
		    Server.Value("serviceId") = Profile.ProfileId
		    Server.Value("name") = ""
		    If Profile.Nickname.IsEmpty = False Then
		      Server.Value("nickname") = Profile.Nickname
		    Else
		      Server.Value("nickname") = Profile.Name
		    End If
		    Server.Value("gameId") = ArkSA.Identifier
		    Server.Value("gameSpecific") = New JSONItem("{}")
		    Server.Value("platform") = "Universal"
		    Server.Value("languages") = New JSONItem("[""en""]")
		    
		    Var ProfileColor As Variant
		    Select Case Profile.ProfileColor
		    Case Beacon.ServerProfile.Colors.Blue
		      ProfileColor = "Blue"
		    Case Beacon.ServerProfile.Colors.Brown
		      ProfileColor = "Brown"
		    Case Beacon.ServerProfile.Colors.Green
		      ProfileColor = "Green"
		    Case Beacon.ServerProfile.Colors.Grey
		      ProfileColor = "Grey"
		    Case Beacon.ServerProfile.Colors.Indigo
		      ProfileColor = "Indigo"
		    Case Beacon.ServerProfile.Colors.None
		      ProfileColor = "None"
		    Case Beacon.ServerProfile.Colors.Orange
		      ProfileColor = "Organge"
		    Case Beacon.ServerProfile.Colors.Pink
		      ProfileColor = "Pink"
		    Case Beacon.ServerProfile.Colors.Purple
		      ProfileColor = "Purple"
		    Case Beacon.ServerProfile.Colors.Red
		      ProfileColor = "Red"
		    Case Beacon.ServerProfile.Colors.Teal
		      ProfileColor = "Teal"
		    Case Beacon.ServerProfile.Colors.Yellow
		      ProfileColor = "Yellow"
		    End Select
		    Server.Value("color") = ProfileColor
		    
		    RequestBody.Add(Server)
		  Next
		  
		  Var Request As New BeaconAPI.Request("/sentinel/services", "POST", RequestBody.ToString, "application/json", WeakAddressOf APICallback_AddSentinelServers)
		  Request.Tag = Profiles
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_AddSentinelServers(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    // Data could be stale
		    Try
		      Var Parsed As New JSONItem(Response.Content)
		      If Parsed.Lookup("type", "").StringValue = "beacon.error" Then
		        Select Case Parsed.Lookup("code", "").StringValue
		        Case "tooManyResources"
		          Self.ShowAlert("Could not add server to Beacon Sentinel", "This would put you over your plan limit. If you need more servers, consider upgrading your plan.")
		          Return
		        End Select
		      End If
		    Catch Err As RuntimeException
		    End Try
		    
		    Self.ShowAlert("Could not add server to Beacon Sentinel", "The server said '" + Response.Message + "'")
		    Return
		  End If
		  
		  Var Map As New Dictionary
		  Try
		    Var Parsed As New JSONItem(Response.Content)
		    Var Created As JSONItem = Parsed.Child("created")
		    For Idx As Integer = 0 To Created.LastRowIndex
		      Var Child As JSONItem = Created.ChildAt(Idx)
		      Map.Value(Child.Value("serviceId")) = Child
		    Next
		    Var Updated As JSONItem = Parsed.Child("updated")
		    For Idx As Integer = 0 To Updated.LastRowIndex
		      Var Child As JSONItem = Updated.ChildAt(Idx)
		      Map.Value(Child.Value("serviceId")) = Child
		    Next
		  Catch Err As RuntimeException
		    Self.ShowAlert("There was an unexpected response from Beacon", "It is unknown if any server was added to Beacon Sentinel. Check the Sentinel website to determine what changes were made.")
		    Return
		  End Try
		  
		  Var Key As ArkSA.ConfigOption = ArkSA.DataSource.Pool.Get(False).GetConfigOption("6cbb5deb-e6da-54a9-91e2-b6efabec12b8")
		  If Key Is Nil Then
		    Key = New ArkSA.ConfigOption(ArkSA.ConfigFileGameUserSettings, "BeaconSentinel", "AccessKey")
		  End If
		  Var Profiles() As ArkSA.ServerProfile = Request.Tag
		  For Each Profile As ArkSA.ServerProfile In Profiles
		    If Map.HasKey(Profile.ProfileId) = False Then
		      Continue
		    End If
		    
		    Var ServiceInfo As JSONItem = Map.Value(Profile.ProfileId)
		    Var Organizer As New ArkSA.ConfigOrganizer(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, Profile.CustomGUS)
		    Var Value As New ArkSA.ConfigValue(Key, "AccessKey=" + ServiceInfo.Value("accessKey").StringValue)
		    Organizer.Add(Value, False)
		    Profile.CustomGUS = Organizer.Build(ArkSA.ConfigFileGameUserSettings)
		  Next
		  
		  // Force the view to refresh
		  Var CurrentProfileId As String = Self.CurrentProfileId
		  Self.CurrentProfileId = ""
		  Self.CurrentProfileId = CurrentProfileId
		  
		  Var Summary As String
		  If Profiles.Count > 1 Then
		    Summary = "The servers have been added to Beacon Sentinel"
		  Else
		    Summary = "The server has been added to Beacon Sentinel"
		  End If
		  Self.ShowAlert(Summary, "Don't forget to install mod 1193015 and deploy the new config to complete the job.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_FindSentinelService(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Not Response.Success Then
		    // Api failure
		    Self.ShowAlert("Unable to find server", "There was an error locating the server in Sentinel.")
		    Return
		  End If
		  
		  Try
		    Var JsonResponse As New JSONItem(Response.Content)
		    If JsonResponse.Value("totalResults") = 0 Then
		      // No match
		      Self.ShowAlert("Unable to find server", "Your Sentinel access key was found, but Sentinel couldn't match it to any server.")
		      Return
		    End If
		    
		    Var Server As JSONItem = JsonResponse.Child("results").ChildAt(0)
		    System.GotoURL("https://sentinel.usebeacon.app/servers/" + Server.Value("serviceId").StringValue)
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As ArkSA.Project)
		  Self.mViews = New Dictionary
		  Super.Constructor(Project)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DeployProfiles() As ArkSA.ServerProfile()
		  Var Profiles() As ArkSA.ServerProfile
		  Var List As ServersListbox = Self.ServerList
		  For Idx As Integer = 0 To List.LastRowIndex
		    If List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    Var Profile As ArkSA.ServerProfile = List.RowTagAt(Idx)
		    If Profile.DeployCapable Then
		      Profiles.Add(Profile)
		    End If
		  Next
		  Return Profiles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishRefreshingDetails()
		  Var Profiles() As Beacon.ServerProfile = Self.ServerList.SelectedProfiles
		  Self.ServerList.SelectedRowIndex = -1
		  
		  Var ViewIds() As Variant = Self.mViews.Keys
		  For Each ViewId As Variant In ViewIds
		    Var Panel As ArkSAServerViewContainer = Self.mViews.Value(ViewId)
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
		Private Sub HandleSentinelMenu(ItemRect As Rect)
		  If App.IdentityManager.CurrentIdentity Is Nil Or App.IdentityManager.CurrentIdentity.HasSentinelSubscription = False Then
		    Var Choice As BeaconUI.ConfirmResponses = BeaconUI.ShowConfirm("Would you like to learn more about Beacon Sentinel?", "Beacon Sentinel is a monitoring and moderation service for Ark: Survival Ascended. You do not have a Beacon Sentinel subscription in your account. If this is not correct, choose the refresh option to have Beacon load your latest subscription information.", "Learn More", "Cancel", "Refresh")
		    Select Case Choice
		    Case BeaconUI.ConfirmResponses.Action
		      System.GotoURL("https://sentinel.usebeacon.app/")
		    Case BeaconUI.ConfirmResponses.Alternate
		      Call App.HandleURL("beacon://action/refreshuser?silent=false")
		    End Select
		    Return
		  End If
		  
		  Var Base As New DesktopMenuItem
		  Var List As ServersListbox = Self.ServerList
		  Var UnaddedProfiles() As ArkSA.ServerProfile
		  Var AddedProfiles() As ArkSA.ServerProfile
		  For Idx As Integer = 0 To List.LastRowIndex
		    If List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Profile As ArkSA.ServerProfile = List.RowTagAt(Idx)
		    Var CustomGUS As String = Profile.CustomGUS
		    If CustomGUS.Contains("[BeaconSentinel]") And CustomGUS.Contains("AccessKey=") Then
		      AddedProfiles.Add(Profile)
		    Else
		      UnaddedProfiles.Add(Profile)
		    End If
		  Next
		  
		  Var AddToItem As New DesktopMenuItem("Add to Sentinel", "addto")
		  AddToItem.Enabled = UnaddedProfiles.Count > 0
		  Base.AddMenu(AddToItem)
		  
		  Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  
		  Var ShowItem As New DesktopMenuItem("Show Game Events", "show")
		  ShowItem.Enabled = AddedProfiles.Count = 1
		  Base.AddMenu(ShowItem)
		  
		  Var Position As Point = Self.AltToolbar.GlobalPosition
		  Var Choice As DesktopMenuItem = Base.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		  If Choice Is Nil Then
		    Return
		  End If
		  
		  Select Case Choice.Tag
		  Case "addto"
		    Self.AddToSentinel(UnaddedProfiles)
		  Case "show"
		    Self.ShowInSentinel(AddedProfiles(0))
		  End Select
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
		  Return ArkSA.Configs.NameServers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProfilesWithProvider(ProviderId As String) As ArkSA.ServerProfile()
		  Var Profiles() As ArkSA.ServerProfile
		  Var List As ServersListbox = Self.ServerList
		  For Idx As Integer = 0 To List.LastRowIndex
		    If List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    Var Profile As ArkSA.ServerProfile = List.RowTagAt(Idx)
		    If Profile.ProviderId = ProviderId Then
		      Profiles.Add(Profile)
		    End If
		  Next
		  Return Profiles
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
		Private Sub ShowInSentinel(Profile As ArkSA.ServerProfile)
		  Var Lines() As String = Profile.CustomGUS.ReplaceLineEndings(EndOfLine).Split(EndOfLine)
		  Var FoundSection As Boolean
		  Var AccessKey As String
		  For Each Line As String In Lines
		    If Line = "[BeaconSentinel]" Then
		      FoundSection = True
		    ElseIf FoundSection And Line.BeginsWith("[") And Line.EndsWith("]") Then
		      FoundSection = False
		    ElseIf FoundSection And Line.BeginsWith("AccessKey=") Then
		      AccessKey = Line.Middle(10).Trim
		      Exit
		    End If
		  Next
		  
		  If AccessKey.IsEmpty Then
		    BeaconUI.ShowAlert("Could not find the Sentinel access key", "Beacon is looking for an AccessKey line in the [BeaconSentinel] section of the 'Custom' tab of the server.")
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request("/sentinel/services?accessKey=" + AccessKey, "GET", WeakAddressOf APICallback_FindSentinelService)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartDeploy()
		  Var Profiles() As ArkSA.ServerProfile = Self.DeployProfiles()
		  Self.StartDeploy(Profiles)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartDeploy(Profiles() As ArkSA.ServerProfile)
		  If Profiles.Count = 0 Then
		    Self.ShowAlert("None of the selected servers are ready for deploy", "Use the Import button in the project toolbar to add deploy-capable server records to this project.")
		    Return
		  End If
		  
		  RaiseEvent ShouldDeployProfiles(Profiles)
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
		Private Sub UpdateStatus()
		  Self.Status.CenterCaption = Self.ServerList.StatusMessage("Server", "Servers")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub View_ContentsChanged(Sender As ArkSAServerViewContainer)
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
			  Return Self.mCurrentProfileID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCurrentProfileID = Value Then
			    Return
			  End If
			  
			  If Self.mCurrentProfileID.IsEmpty = False Then
			    Var View As ArkSAServerViewContainer = Self.mViews.Value(Self.mCurrentProfileID)
			    View.Visible = False
			    View.SwitchedFrom()
			    Self.mCurrentProfileID = ""
			  End If
			  
			  If Not Self.mViews.HasKey(Value) Then
			    Return
			  End If
			  
			  Var View As ArkSAServerViewContainer = Self.mViews.Value(Value)
			  View.SwitchedTo()
			  View.Visible = True
			  Self.mCurrentProfileID = Value
			End Set
		#tag EndSetter
		CurrentProfileID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mViews.HasKey(Self.mCurrentProfileID) Then
			    Return ArkSAServerViewContainer(Self.mViews.Value(Self.mCurrentProfileID))
			  End If
			End Get
		#tag EndGetter
		CurrentView As ArkSAServerViewContainer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentProfileID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViews As Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events ServerList
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateStatus
		  
		  Var SelectedRowCount As Integer = Me.SelectedRowCount
		  
		  Var DeployButton As OmniBarItem = Self.AltToolbar.Item("DeployButton")
		  If (DeployButton Is Nil) = False Then
		    DeployButton.Enabled = SelectedRowCount > 0
		  End If
		  Var SentinelButton As OmniBarItem = Self.AltToolbar.Item("SentinelButton")
		  If (SentinelButton Is Nil) = False Then
		    SentinelButton.Enabled = SelectedRowCount > 0
		  End If
		  
		  Select Case SelectedRowCount
		  Case 0
		    Self.CurrentProfileID = ""
		    Return
		  Case 1
		    Var Profile As ArkSA.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    Var ProfileID As String = Profile.ProfileID
		    If Not Self.mViews.HasKey(ProfileID) Then
		      // Create the view
		      Var View As ArkSAServerViewContainer
		      Select Case Profile.ProviderId
		      Case Nitrado.Identifier
		        View = New ArkSANitradoServerView(Self.Project, Profile)
		      Case FTP.Identifier
		        View = New ArkSAFTPServerView(Self.Project, Profile)
		      Case Local.Identifier
		        View = New ArkSALocalServerView(Self.Project, Profile)
		      Case GameServerApp.Identifier
		        View = New ArkSAGSAServerView(Self.Project, Profile)
		      Else
		        Self.CurrentProfileID = ""
		        Return
		      End Select
		      
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileID) = View
		    End If
		    Self.CurrentProfileID = ProfileID
		  Else
		    Var Profiles() As ArkSA.ServerProfile
		    Var Parts() As String
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Not Me.RowSelectedAt(Idx) Then
		        Continue
		      End If
		      
		      Profiles.Add(Me.RowTagAt(Idx))
		      Parts.Add(Profiles(Profiles.LastIndex).ProfileID)
		    Next
		    
		    Var ProfileID As String = Parts.Join(",")
		    If Not Self.mViews.HasKey(ProfileID) Then
		      Var View As New ArkSAMultiServerView(Self.Project, Profiles)
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileID) = View
		    End If
		    
		    Self.CurrentProfileID = ProfileID
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
		      Var Profile As ArkSA.ServerProfile = Me.RowTagAt(I)
		      If Self.mViews.HasKey(Profile.ProfileID) Then
		        If Self.CurrentProfileID = Profile.ProfileID Then
		          Self.CurrentProfileID = ""
		        End If
		        
		        Var Panel As ArkSAServerViewContainer = Self.mViews.Value(Profile.ProfileID)
		        Panel.Close
		        Self.mViews.Remove(Profile.ProfileID)
		      End If
		      Self.Project.RemoveServerProfile(Profile)
		      Self.Modified = True
		      Me.RemoveRowAt(I)
		    End If
		  Next
		  
		  Self.UpdateRefreshButton()
		  Self.UpdateStatus
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var CopyProfileMenuItem As New DesktopMenuItem("Copy Profile ID")
		  CopyProfileMenuItem.Enabled = False
		  Base.AddMenu(CopyProfileMenuItem)
		  
		  Var DeployItem As DesktopMenuItem
		  If Me.SelectedRowCount > 1 Then
		    DeployItem = New DesktopMenuItem("Deploy These Servers…")
		  Else
		    DeployItem = New DesktopMenuItem("Deploy This Server…")
		  End If
		  Var DeployProfiles() As Beacon.ServerProfile = Self.DeployProfiles
		  Var NitradoProfiles() As ArkSA.ServerProfile = Self.ProfilesWithProvider(Nitrado.Identifier)
		  Var LocalProfiles() As ArkSA.ServerProfile = Self.ProfilesWithProvider(Local.Identifier)
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
		    Var Profile As ArkSA.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    CopyProfileMenuItem.Tag = Profile.ProfileID.Left(8)
		    CopyProfileMenuItem.Enabled = True
		    
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
		  Case "Copy Profile ID"
		    Var ProfileID As String = HitItem.Tag
		    Var Board As New Clipboard
		    Board.Text = ProfileID
		  Case "Deploy These Servers…", "Deploy This Server…"
		    Var SelectedProfiles() As ArkSA.ServerProfile = HitItem.Tag
		    Self.StartDeploy(SelectedProfiles)
		  Case "Open Nitrado Dashboard"
		    Var NitradoProfiles() As ArkSA.ServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To NitradoProfiles.LastIndex
		      System.GotoURL(Beacon.WebURL("/redirect?destination=nitradodash&serviceid=" + Nitrado.HostConfig(NitradoProfiles(Idx).HostConfig).ServiceID.ToString(Locale.Raw, "0")))
		    Next Idx
		  Case "Show Config Files"
		    Var LocalProfiles() As ArkSA.ServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To LocalProfiles.LastIndex
		      Var File As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(LocalProfiles(Idx).GameIniPath)
		      If File Is Nil Or File.Exists = False Then
		        File = BookmarkedFolderItem.FromSaveInfo(LocalProfiles(Idx).GameUserSettingsIniPath)
		      End If
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
	#tag Event
		Sub ListUpdated()
		  Self.UpdateStatus
		End Sub
	#tag EndEvent
#tag EndEvents
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
		    Var Profile As New ArkSA.ServerProfile(Local.Identifier, Language.DefaultServerName(ArkSA.Identifier))
		    
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
		    
		    Var Profiles() As Beacon.ServerProfile
		    Try
		      Profiles = Provider.ListServers(Config, ArkSA.Identifier)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Refreshing server profiles")
		      Continue
		    End Try
		    
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
#tag Events AltToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("DeployButton", "Deploy", IconToolbarDeploy, "Deploy the selected server or servers.", False))
		  Me.Append(OmniBarItem.CreateButton("SentinelButton", "Sentinel", IconToolbarSentinel, "Add the selected server to Beacon Sentinel.", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "DeployButton"
		    Self.StartDeploy(Self.DeployProfiles)
		  Case "SentinelButton"
		    Self.HandleSentinelMenu(ItemRect)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ItemHeld(Item As OmniBarItem, ItemRect As Rect) As Boolean
		  Select Case Item.Name
		  Case "SentinelButton"
		    Self.HandleSentinelMenu(ItemRect)
		  End Select
		End Function
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
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
		InitialValue=""
		Type="Integer"
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
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="TabStop"
		Visible=true
		Group="Position"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="CurrentProfileID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
