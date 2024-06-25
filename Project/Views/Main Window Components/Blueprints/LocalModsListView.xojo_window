#tag DesktopWindow
Begin ModsListView LocalModsListView Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   400
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
   Width           =   600
   Begin BeaconListbox ModsList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   5
      ColumnWidths    =   "*,100,200,100,200"
      DefaultRowHeight=   -1
      DefaultSortColumn=   0
      DefaultSortDirection=   1
      DropIndicatorVisible=   False
      EditCaption     =   "Edit Blueprints"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   328
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Type	Game	Mod ID	Last Updated"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   5
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   600
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin OmniBar ModsToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   2
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
      Width           =   330
   End
   Begin Thread ModDeleterThread
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
      Hint            =   "Filter Mods"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   340
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   9
      Transparent     =   False
      Visible         =   True
      Width           =   250
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
      Left            =   330
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   270
   End
   Begin Ark.ModDiscoveryEngine ArkDiscoveryEngine
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin ArkSA.ModDiscoveryEngine ArkSADiscoveryEngine
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin StatusContainer Status
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      CenterCaption   =   "Loading Mods"
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
      LockRight       =   True
      LockTop         =   False
      RightCaption    =   ""
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   369
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, DataUpdater.Notification_ImportStopped, Beacon.DataSource.Notification_ImportCloudFilesFinished)
		  RaiseEvent Hidden
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshMods(SelectedModIds() As String)
		  #Pragma Unused SelectedModIds
		  
		  Self.mPacksData.ExecuteSQL("UPDATE packs SET should_delete = TRUE;")
		  Var DataSources() As Beacon.DataSource = App.DataSources
		  For Each DataSource As Beacon.DataSource In DataSources
		    Var Packs() As Beacon.ContentPack = DataSource.GetContentPacks("", Beacon.ContentPack.TypeAny)
		    For Each Pack As Beacon.ContentPack In Packs
		      Self.AddPackToData(Pack)
		    Next
		  Next
		  Self.FetchRemoteMods()
		  Self.UpdateModsList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  NotificationKit.Watch(Self, DataUpdater.Notification_ImportStopped, Beacon.DataSource.Notification_ImportCloudFilesFinished)
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateUI()
		  Self.Status.CenterCaption = Self.ModsList.StatusMessage("Mod", "Mods")
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddPackToData(Pack As Beacon.ContentPack)
		  Var ViewMode As ModsListView.ViewModes
		  Select Case Pack.Type
		  Case Beacon.ContentPack.TypeLocal
		    ViewMode = ModsListView.ViewModes.Local
		  Case Beacon.ContentPack.TypeOfficial, Beacon.ContentPack.TypeThirdParty
		    ViewMode = ModsListView.ViewModes.LocalReadOnly
		  End Select
		  Self.AddPackToData(Pack, ViewMode)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddPackToData(Pack As Beacon.ContentPack, OverrideViewMode As ModsListView.ViewModes)
		  Self.mPacksData.ExecuteSQL("INSERT INTO packs (content_pack_id, name, game_id, marketplace_id, json, should_delete, view_mode) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7) ON CONFLICT (content_pack_id) DO UPDATE SET name = ?2, game_id = ?3, marketplace_id = ?4, json = ?5, should_delete = ?6, view_mode = ?7;", Pack.ContentPackId, Pack.Name, Pack.GameId, Pack.MarketplaceId, Beacon.GenerateJson(Pack.SaveData, False), False, CType(OverrideViewMode, Integer))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteMod(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Self.ModsList Is Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  Self.FinishJob()
		  Var Pack As Beacon.ContentPack = Request.Tag
		  
		  If Response.Success Then
		    Self.mPacksData.ExecuteSQL("DELETE FROM packs WHERE content_pack_id = ?1;", Pack.ContentPackId)
		    Self.UpdateModsList()
		    Return
		  End If
		  
		  Var Explanation As String = Response.Message
		  If Explanation.IsEmpty Then
		    Select Case Response.HTTPStatus
		    Case 401, 403
		      Explanation = "You are not authorized to delete this mod."
		    Case 429
		      Explanation = "You have performed too many actions too quickly. Wait a minute and try again."
		    Case 500
		      Explanation = "Internal server error. Please report this to help@usebeacon.app."
		    Case 503
		      Explanation = "Gateway error. This could be a temporary issue. Try again in a minute."
		    Else
		      Explanation = "The server returned an HTTP " + Response.HTTPStatus.ToString(Locale.Raw, "0") + " status."
		    End Select
		  End If 
		  
		  Self.ShowAlert("Mod '" + Pack.Name + "' was not deleted", Explanation)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListMods(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.ModsList Is Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  Self.FinishJob()
		  Self.mFetchingRemote = False
		  
		  If Response.Success Then
		    Var Results() As Variant
		    Var Page, PageCount As Integer
		    Try
		      Var Parsed As Dictionary = Beacon.ParseJSON(Response.Content)
		      Page = Parsed.Value("page")
		      PageCount = Parsed.Value("pages")
		      Results = Parsed.Value("results")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing page of results.")
		      Return
		    End Try
		    
		    For Each Dict As Dictionary In Results
		      Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromSaveData(Dict)
		      If Pack Is Nil Then
		        Continue
		      End If
		      Self.AddPackToData(Pack, ModsListView.ViewModes.Remote)
		    Next
		    
		    If Page < PageCount Then
		      Self.FetchRemoteMods(Page + 1)
		    End If
		  End If
		  
		  If Self.mFetchingRemote = False Then
		    Self.mPacksData.ExecuteSQL("DELETE FROM packs WHERE should_delete = TRUE;")
		  End If
		  
		  Self.UpdateModsList
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_UploadMod(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  #Pragma Unused Response
		  
		  If Response.Success Then
		    Self.mUploadSuccessCount = Self.mUploadSuccessCount + 1
		  Else
		    Self.mUploadErrorCount = Self.mUploadErrorCount + 1
		    
		    App.Log("Upload to " + Request.URL + " failed with status " + Response.HTTPStatus.ToString(Locale.Raw, "0"))
		    If (Response.Content Is Nil) = False Then
		      App.Log(EncodeBase64MBS(Response.Content))
		    Else
		      App.Log("Null response body")
		    End If
		  End If
		  
		  Self.mRemainingUploads = Self.mRemainingUploads - 1
		  If Self.mRemainingUploads = 0 Then
		    Self.mUploadProgress.Close
		    Self.mUploadProgress = Nil
		    
		    If Self.mUploadSuccessCount > 0 And Self.mUploadErrorCount = 0 Then
		      Self.ShowAlert("All mods uploaded successfully", "Beacon uploaded " + Language.NounWithQuantity(Self.mUploadSuccessCount, "mod", "mods") + " to the community.")
		    ElseIf Self.mUploadSuccessCount = 0 And Self.mUploadErrorCount > 0 Then
		      Self.ShowAlert("Mod upload failed", "Beacon did not upload any mods to the community.")
		    Else
		      Self.ShowAlert("Some mods were not uploaded", "Beacon uploaded " + Language.NounWithQuantity(Self.mUploadSuccessCount, "mod", "mods") + " to the community. " + Language.NounWithQuantity(Self.mUploadErrorCount, "mod", "mods") + " were not uploaded.")
		    End If
		  Else
		    Self.mUploadProgress.Detail = Language.NounWithQuantity(Self.mRemainingUploads, "mod", "mods") + " remaining"
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.ViewID = "LocalModsListView"
		  
		  Self.mPacksData = New SQLiteDatabase
		  Self.mPacksData.Connect
		  Self.mPacksData.ExecuteSQL("CREATE TABLE packs (content_pack_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, name TEXT COLLATE NOCASE NOT NULL, game_id TEXT COLLATE NOCASE NOT NULL, marketplace_id TEXT COLLATE NOCASE NOT NULL, json TEXT NOT NULL, should_delete BOOLEAN NOT NULL DEFAULT FALSE, view_mode INTEGER NOT NULL);")
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportSelectedMods()
		  Var Packs() As Beacon.ContentPack
		  
		  For Idx As Integer = 0 To Self.ModsList.LastRowIndex
		    If Self.ModsList.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = Self.ModsList.RowTagAt(Idx)
		    If Pack Is Nil Then
		      Continue
		    End If
		    
		    Packs.Add(Pack)
		  Next
		  
		  If Packs.Count = 0 Then
		    Return
		  End If
		  
		  Var Dialog As New SaveFileDialog
		  If Packs.Count = 1 Then
		    Dialog.SuggestedFileName = Beacon.SanitizeFilename(Packs(0).Name + Beacon.FileExtensionDelta)
		  Else
		    Dialog.SuggestedFileName = "Exported Mods" + Beacon.FileExtensionDelta
		  End If
		  Dialog.Filter = BeaconFileTypes.BeaconData
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  If Beacon.BuildExport(Packs, File, True) = False Then
		    Self.ShowAlert("Export failed", "The selected " + If(Self.ModsList.SelectedRowCount = 1, "mod was", "mods were") + " not exported. Mods must have at least one blueprint to be exported.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FetchRemoteMods(Page As Integer = 1)
		  If Page = 1 And Self.mFetchingRemote = True Then
		    Return
		  End If
		  
		  Self.mFetchingRemote = True
		  
		  Var Params As New Dictionary
		  Params.Value("page") = Page
		  Params.Value("pageSize") = 100
		  Params.Value("userId") = App.IdentityManager.CurrentUserId
		  
		  Var Filter As String = Self.FilterField.Text.Trim
		  If Filter.IsEmpty = False Then
		    Params.Value("search") = Filter
		  End If
		  
		  Var Request As New BeaconAPI.Request("contentPacks", "GET", Params, AddressOf APICallback_ListMods)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FilterPopoverController_Finished(Sender As PopoverController, Cancelled As Boolean)
		  If Not Cancelled Then
		    Var Settings As ModFilterSettings = ModFilterView(Sender.Container).Settings
		    Preferences.ModFilters = Settings
		    Self.UpdateModsList()
		  End If
		  
		  Var FilterModsButton As OmniBarItem = Self.ModsToolbar.Item("FilterMods")
		  If (FilterModsButton Is Nil) = False Then
		    Var IsFiltered As Boolean = Preferences.ModFilters.IsFiltered
		    FilterModsButton.Toggled = False
		    FilterModsButton.AlwaysUseActiveColor = IsFiltered
		    FilterModsButton.ActiveColor = If(IsFiltered, OmniBarItem.ActiveColors.Blue, OmniBarItem.ActiveColors.Accent)
		    FilterModsButton.Icon = If(IsFiltered, IconToolbarFilterActive, IconToolbarFilter)
		  End If
		  
		  Self.mFilterPopoverController = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsUserContentPack(Pack As Beacon.ContentPack) As Boolean
		  If Pack Is Nil Then
		    Return False
		  End If
		  
		  Select Case Pack.ContentPackId
		  Case Ark.UserContentPackId, ArkSA.UserContentPackId, Palworld.UserContentPackId, SDTD.UserContentPackId
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mProgress_CancelPressed(Sender As ProgressWindow)
		  #Pragma Unused Sender
		  
		  If (Self.ArkDiscoveryEngine Is Nil) = False Then
		    Self.ArkDiscoveryEngine.Cancel
		  End If
		  
		  If (Self.ArkSADiscoveryEngine Is Nil) = False Then
		    Self.ArkSADiscoveryEngine.Cancel
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case DataUpdater.Notification_ImportStopped, Beacon.DataSource.Notification_ImportCloudFilesFinished
		    Self.RefreshMods()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunArkModDiscovery()
		  Var Settings As Ark.ModDiscoverySettings = ArkModDiscoveryDialog.Present(Self)
		  If Settings Is Nil Then
		    Return
		  End If
		  
		  Var ModIds() As String = Settings.ModIds
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var OfficialModNames() As String
		  Var OfficialModIds() As String
		  For Each ModId As String In ModIds
		    If ModId = "2171967557" Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = DataSource.GetContentPackWithSteamId(ModId)
		    If (Pack Is Nil) = False And Pack.IsLocal = False Then
		      OfficialModNames.Add(Pack.Name + " (" + ModId + ")")
		      OfficialModIds.Add(ModID)
		    End If
		    
		    If Self.CloseModView(ModID) = False Then
		      Self.ShowAlert("Close your mod editors to continue", "There is an editor open for mod " + ModID + " that needs to be closed first.")
		      Return
		    End If
		  Next
		  
		  If OfficialModNames.Count > 0 Then
		    Var RemainingMods As Integer = ModIds.Count - OfficialModNames.Count
		    Var SkipCaption As String = "Skip Them"
		    
		    Var Message As String = If(RemainingMods > 0, "Beacon already supports some of your mods", "Beacon already supports your mods")
		    Var Explanation As String
		    If OfficialModNames.Count > 8 Then
		      Explanation = OfficialModNames.Count.ToString(Locale.Current, "#,##0") + " mods are already built into Beacon and do not need to be discovered."
		    ElseIf OfficialModNames.Count > 1 Then
		      Explanation = "The mods " + Language.EnglishOxfordList(OfficialModNames) + " are already built into Beacon and do not need to be discovered."
		    Else
		      Message = If(RemainingMods > 0, "Beacon already supports one of your mods", "Beacon already supports your mod")
		      Explanation = "The mod " + OfficialModNames(0) + " is already built into Beacon and does not need to be discovered."
		      SkipCaption = "Skip It"
		    End If
		    
		    Var ShouldSkip As Boolean
		    Var Choice As BeaconUI.ConfirmResponses
		    If RemainingMods > 0 Then
		      Choice = BeaconUI.ShowConfirm(Message, Explanation, SkipCaption, "Cancel Discovery", "Discover Anyway")
		      ShouldSkip = (Choice = BeaconUI.ConfirmResponses.Action)
		    Else
		      Choice = BeaconUI.ShowConfirm(Message, Explanation, "Discover Anyway", "Cancel Discovery", "")
		    End If
		    If Choice = BeaconUI.ConfirmResponses.Cancel Then
		      Return
		    End If
		    
		    If ShouldSkip Then
		      For Idx As Integer = ModIDs.LastIndex DownTo 0
		        If OfficialModIds.IndexOf(ModIds(Idx)) > -1 Then
		          ModIDs.RemoveAt(Idx)
		        End If
		      Next
		    End If
		  End If
		  
		  Try
		    Var ArkFolder As FolderItem = Settings.ArkFolder
		    Self.mDiscoveryShouldDelete = Settings.DeleteBlueprints
		    Self.ArkDiscoveryEngine.Start(ArkFolder, ModIds)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Beacon could not start mod discovery", Err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunArkSAModDiscovery()
		  Var Settings As ArkSA.ModDiscoverySettings = ArkSAModDiscoveryDialog.Present(Self)
		  If Settings Is Nil Then
		    Return
		  End If
		  
		  Var ModIds() As String = Settings.ModIds
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  Var OfficialModNames() As String
		  Var OfficialModIds() As String
		  For Each ModId As String In ModIds
		    Var Pack As Beacon.ContentPack = DataSource.GetContentPack(Beacon.MarketplaceCurseForge, ModId, Beacon.ContentPack.TypeThirdParty Or Beacon.ContentPack.TypeOfficial)
		    If (Pack Is Nil) = False Then
		      OfficialModNames.Add(Pack.Name + " (" + ModId + ")")
		      OfficialModIds.Add(ModID)
		    End If
		    
		    If Self.CloseModView(ModID) = False Then
		      Self.ShowAlert("Close your mod editors to continue", "There is an editor open for mod " + ModID + " that needs to be closed first.")
		      Return
		    End If
		  Next
		  
		  If OfficialModNames.Count > 0 Then
		    Var RemainingMods As Integer = ModIds.Count - OfficialModNames.Count
		    Var SkipCaption As String = "Skip Them"
		    
		    Var Message As String = If(RemainingMods > 0, "Beacon already supports some of your mods", "Beacon already supports your mods")
		    Var Explanation As String
		    If OfficialModNames.Count > 8 Then
		      Explanation = OfficialModNames.Count.ToString(Locale.Current, "#,##0") + " mods are already built into Beacon and do not need to be discovered."
		    ElseIf OfficialModNames.Count > 1 Then
		      Explanation = "The mods " + Language.EnglishOxfordList(OfficialModNames) + " are already built into Beacon and do not need to be discovered."
		    Else
		      Message = If(RemainingMods > 0, "Beacon already supports one of your mods", "Beacon already supports your mod")
		      Explanation = "The mod " + OfficialModNames(0) + " is already built into Beacon and does not need to be discovered."
		      SkipCaption = "Skip It"
		    End If
		    
		    Var ShouldSkip As Boolean
		    Var Choice As BeaconUI.ConfirmResponses
		    If RemainingMods > 0 Then
		      Choice = BeaconUI.ShowConfirm(Message, Explanation, SkipCaption, "Cancel Discovery", "Discover Anyway")
		      ShouldSkip = (Choice = BeaconUI.ConfirmResponses.Action)
		    Else
		      Choice = BeaconUI.ShowConfirm(Message, Explanation, "Discover Anyway", "Cancel Discovery", "")
		    End If
		    If Choice = BeaconUI.ConfirmResponses.Cancel Then
		      Return
		    End If
		    
		    If ShouldSkip Then
		      For Idx As Integer = ModIDs.LastIndex DownTo 0
		        If OfficialModIds.IndexOf(ModIds(Idx)) > -1 Then
		          ModIDs.RemoveAt(Idx)
		        End If
		      Next
		    End If
		  End If
		  
		  Try
		    Self.mDiscoveryShouldDelete = Settings.DeleteBlueprints
		    Self.ArkSADiscoveryEngine.Start(Settings)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Beacon could not start mod discovery", Err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunModDiscovery()
		  Var GameId As String = GameSelectorWindow.Present(Self, Beacon.Game.FeatureMods, False)
		  If GameId.IsEmpty Then
		    Return
		  End If
		  
		  Select Case GameId
		  Case Ark.Identifier
		    #if Not TargetWindows
		      Self.ShowAlert("Mod discovery for " + Language.GameName(Ark.Identifier) + " requires Windows.", "Mod discovery will launch an Ark server to do its work. There is no Ark server process for macOS.")
		      Return
		    #endif
		    
		    Self.RunArkModDiscovery()
		  Case ArkSA.Identifier
		    Self.RunArkSAModDiscovery()
		  End Select
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedModIds() As String()
		  Var Ids() As String
		  For Idx As Integer = 0 To Self.ModsList.LastRowIndex
		    If Self.ModsList.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Ids.Add(Beacon.ContentPack(Self.ModsList.RowTagAt(Idx)).ContentPackId)
		  Next
		  Return Ids
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedModIds(Assigns ModIds() As String)
		  Var List As BeaconListbox = Self.ModsList
		  Var Bound As Integer = List.LastRowIndex
		  List.SelectionChangeBlocked = True
		  For Idx As Integer = 0 To Bound
		    Var Pack As Beacon.ContentPack = List.RowTagAt(Idx)
		    List.RowSelectedAt(Idx) = ModIds.IndexOf(Pack.ContentPackId) > -1
		  Next
		  List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowImportDialog()
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.BeaconData // This isn't a mistake, it only supports archive files because it's the only format to reliably contain mod info
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  DataUpdater.Import(File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateModsList()
		  Var Filter As String = Self.FilterField.Text.Trim.ReplaceAll("%", "\%").ReplaceAll("_", "\_")
		  Var FilterSettings As ModFilterSettings = Preferences.ModFilters
		  Var Clauses() As String
		  Var Values() As Variant
		  Var NextPlaceholder As Integer = 1
		  
		  If FilterSettings.IsFiltered Then
		    If FilterSettings.Types > 0 Then
		      Clauses.Add("view_mode & ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " > 0")
		      Values.Add(FilterSettings.Types)
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    
		    Var GameIds() As String = FilterSettings.GameIds
		    If GameIds.Count > 0 Then
		      Var GameIdPlaceholders() As String
		      For Each GameId As String In GameIds
		        GameIdPlaceholders.Add("?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		        Values.Add(GameId)
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.Add("game_id IN (" + String.FromArray(GameIdPlaceholders, ", ") + ")")
		    End If
		  End If
		  If Filter.IsEmpty = False Then
		    Clauses.Add("(name LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\' OR marketplace_id LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\')")
		    Values.Add("%" + Filter + "%")
		    NextPlaceholder = NextPlaceholder + 1
		  End If
		  
		  Var SQL As String = "SELECT json, view_mode FROM packs" + If(Clauses.Count > 0, " WHERE " + String.FromArray(Clauses, " AND "), "") + " ORDER BY name;"
		  Var Rows As RowSet = Self.mPacksData.SelectSQL(SQL, Values)
		  #if DebugBuild
		    For Param As Integer = 1 To Values.Count
		      SQL = SQL.Replace("?" + Param.ToString(Locale.Raw, "0"), "'" + Values(Param - 1).StringValue + "'")
		    Next
		    System.DebugLog(SQL)
		  #endif
		  Var SelectedIds As New Dictionary
		  For RowIdx As Integer = 0 To Self.ModsList.LastRowIndex
		    If Self.ModsList.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    Var Pack As Beacon.ContentPack = Self.ModsList.RowTagAt(RowIdx)
		    SelectedIds.Value(Pack.ContentPackId) = True
		  Next
		  
		  Self.ModsList.SelectionChangeBlocked = True
		  Self.ModsList.RowCount = Rows.RowCount
		  Var RowIdx As Integer = 0
		  While Not Rows.AfterLastRow
		    Var PackData As Dictionary = Beacon.ParseJson(Rows.Column("json").StringValue)
		    Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromSaveData(PackData)
		    Var LastUpdate As New DateTime(Pack.LastUpdate, TimeZone.Current)
		    Var ViewMode As ModsListView.ViewModes = CType(Rows.Column("view_mode").IntegerValue, ModsListView.ViewModes)
		    
		    Self.ModsList.CellTextAt(RowIdx, Self.ColumnName) = Pack.Name
		    Self.ModsList.CellTextAt(RowIdx, Self.ColumnGameId) = Language.GameName(Pack.GameId)
		    Self.ModsList.CellTextAt(RowIdx, Self.ColumnModId) = Pack.MarketplaceId
		    Self.ModsList.CellTextAt(RowIdx, Self.ColumnUpdate) = LastUpdate.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium)
		    Select Case Pack.Type
		    Case Beacon.ContentPack.TypeLocal
		      Self.ModsList.CellTextAt(RowIdx, Self.ColumnType) = Self.TypeCaptionLocal
		    Case Beacon.ContentPack.TypeOfficial
		      Self.ModsList.CellTextAt(RowIdx, Self.ColumnType) = Self.TypeCaptionOfficial
		    Case Beacon.ContentPack.TypeThirdParty
		      Self.ModsList.CellTextAt(RowIdx, Self.ColumnType) = Pack.Marketplace
		    End Select
		    Self.ModsList.CellTagAt(RowIdx, Self.ColumnType) = ViewMode
		    Self.ModsList.RowTagAt(RowIdx) = Pack
		    Self.ModsList.RowSelectedAt(RowIdx) = SelectedIds.HasKey(Pack.ContentPackId)
		    
		    RowIdx = RowIdx + 1
		    Rows.MoveToNextRow
		  Wend
		  Self.ModsList.Sort
		  Self.ModsList.SelectionChangeBlocked = False
		  
		  Self.ModsList.SizeColumnToFit(Self.ColumnGameId, 100)
		  Self.ModsList.SizeColumnToFit(Self.ColumnModId, 100)
		  Self.ModsList.SizeColumnToFit(Self.ColumnUpdate, 100)
		  Self.ModsList.SizeColumnToFit(Self.ColumnType, 100)
		  
		  Self.UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadSelectedMods()
		  If Self.mRemainingUploads > 0 Or (Self.mUploadProgress Is Nil) = False Then
		    Self.ShowAlert("There is already an upload running", "Wait for the uploads to finish")
		    Return
		  End If
		  
		  Var Packs() As Beacon.ContentPack
		  
		  For Idx As Integer = 0 To Self.ModsList.LastRowIndex
		    If Self.ModsList.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = Self.ModsList.RowTagAt(Idx)
		    If Pack Is Nil Then
		      Continue
		    End If
		    
		    If Pack.MarketplaceId.IsEmpty Then
		      Self.ShowAlert("Cannot upload to community", "The mod '" + Pack.Name + "' does not have an official id and cannot be uploaded.")
		      Return
		    End If
		    
		    If Self.CloseModView(Pack.ContentPackId) = False Then
		      Self.ShowAlert("Close your mod editors to continue", "There is an editor open for mod '" + Pack.Name + "' that needs to be closed first.")
		      Return
		    End If
		    
		    Packs.Add(Pack)
		  Next
		  
		  If Packs.Count = 0 Then
		    Return
		  End If
		  
		  Self.mRemainingUploads = Packs.Count
		  Self.mUploadErrorCount = 0
		  Self.mUploadSuccessCount = 0
		  Self.mUploadProgress = New ProgressWindow
		  Self.mUploadProgress.Message = "Uploading " + Language.NounWithQuantity(Self.mRemainingUploads, "mod", "mods")
		  
		  For Each Pack As Beacon.ContentPack In Packs
		    Var Exported As MemoryBlock = Beacon.BuildExport(True, Pack)
		    If Exported Is Nil Then
		      Self.mRemainingUploads = Self.mRemainingUploads - 1
		      Self.mUploadErrorCount = Self.mUploadErrorCount + 1
		      Continue
		    End If
		    
		    Var Request As New BeaconAPI.Request("discovery/" + Pack.ContentPackId, "PUT", Exported, "application/octet-stream", AddressOf APICallback_UploadMod)
		    BeaconAPI.Send(Request)
		  Next
		  
		  If Self.mRemainingUploads <= 0 Then
		    Self.mUploadProgress.Close
		    Self.mUploadProgress = Nil
		    Self.ShowAlert("Nothing to upload", "The mod(s) could not be exported. Usually this happens whent he mod is empty.")
		    Return
		  End If
		  
		  Self.mUploadProgress.Detail = Language.NounWithQuantity(Self.mRemainingUploads, "mod", "mods") + " remaining"
		  Self.mUploadProgress.Show(Self)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Hidden()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDiscoveredMods() As Beacon.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDiscoveryShouldDelete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFetchingRemote As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFilterPopoverController As PopoverController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModUUIDsToDelete() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumAddedBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumAddedMods As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumErrorBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumRemovedBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpenModWhenRefreshed As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPacksData As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemainingUploads As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadErrorCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadSuccessCount As Integer
	#tag EndProperty


	#tag Constant, Name = ColumnGameId, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnModId, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnType, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnUpdate, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TypeCaptionLocal, Type = String, Dynamic = True, Default = \"Custom", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TypeCaptionOfficial, Type = String, Dynamic = True, Default = \"Official", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ModsList
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Packs() As Beacon.ContentPack
		  If Warn Then
		    Var Names() As String
		    For RowIdx As Integer = 0 To Me.LastRowIndex
		      Var Pack As Beacon.ContentPack = Me.RowTagAt(RowIdx)
		      If Me.RowSelectedAt(RowIdx) = False Then
		        Continue
		      End If
		      
		      If Me.CellTagAt(RowIdx, Self.ColumnType) = ModsListView.ViewModes.LocalReadOnly Then
		        Continue
		      End If
		      
		      If Self.IsUserContentPack(Pack) Then
		        Continue
		      End If
		      
		      Names.Add(Pack.Name)
		      Packs.Add(Pack)
		    Next
		    
		    If Packs.Count = 0 Then
		      If Me.SelectedRowCount > 1 Then
		        Self.ShowAlert("None of the selected mods can be deleted.", "The selected mods are either required, such as the 'User Content' mods, or are official / third party mods that you do not have permission to delete.")
		      Else
		        Var Pack As Beacon.ContentPack = Me.RowTagAt(Me.SelectedRowIndex)
		        Select Case Pack.Type
		        Case Beacon.ContentPack.TypeOfficial, Beacon.ContentPack.TypeThirdParty
		          Self.ShowAlert("The selected mod can not be deleted.", "You do not have permission to delete the mod '" + Pack.Name + "'.")
		        Else
		          Self.ShowAlert("The selected mod can not be deleted.", "The '" + Pack.Name + "' mod is required by Beacon and can not be deleted.")
		        End Select
		      End
		      Return
		    End If
		    
		    If Not Self.ShowDeleteConfirmation(Names, "mod", "mods") Then
		      Return
		    End If
		  End If
		  
		  // Make sure they do not have unsaved changes
		  For Idx As Integer = Packs.LastIndex DownTo 0
		    If Self.CloseModView(Packs(Idx).ContentPackId) = False Then
		      Packs.RemoveAt(Idx)
		      Continue
		    End If
		    
		    If Packs(Idx).Type = Beacon.ContentPack.TypeLocal Then
		      Self.mModUUIDsToDelete.Add(Packs(Idx).ContentPackId)
		    Else
		      Self.StartJob
		      Var Request As New BeaconAPI.Request("contentPacks/" + Packs(Idx).ContentPackId, "DELETE", WeakAddressOf APICallback_DeleteMod)
		      Request.Tag = Packs(Idx)
		      BeaconAPI.Send(Request)
		    End If
		  Next
		  
		  If Self.mModUUIDsToDelete.Count > 0 And Self.ModDeleterThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.ModDeleterThread.Start
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var Pack As Beacon.ContentPack = Me.RowTagAt(Me.SelectedRowIndex)
		  Var Mode As ModsListView.ViewModes = Me.CellTagAt(Me.SelectedRowIndex, Self.ColumnType)
		  Self.ShowMod(Pack, Mode)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Var EnableOpening, EnableEditing, EnableSettings As Boolean
		  If Me.SelectedRowCount = 1 Then
		    EnableOpening = True
		    Var Pack As Beacon.ContentPack = Me.RowTagAt(Me.SelectedRowIndex)
		    If Pack.IsLocal Or Me.CellTagAt(Me.SelectedRowIndex, Self.ColumnType) = ModsListView.ViewModes.Remote Then
		      EnableEditing = True
		      EnableSettings = (Self.IsUserContentPack(Pack) = False)
		    End If
		  End If
		  
		  If (Self.ModsToolbar.Item("EditModBlueprints") Is Nil) = False Then
		    Self.ModsToolbar.Item("EditModBlueprints").Enabled = EnableOpening
		    Self.ModsToolbar.Item("EditModBlueprints").Caption = If(EnableEditing, "Edit Blueprints", "View Blueprints")
		  End If
		  
		  If (Self.ModsToolbar.Item("ExportButton") Is Nil) = False Then
		    Self.ModsToolbar.Item("ExportButton").Enabled = Me.SelectedRowCount > 0
		  End If
		  
		  If (Self.ModsToolbar.Item("EditMod") Is Nil) = False Then
		    Self.ModsToolbar.Item("EditMod").Enabled = EnableSettings
		  End If
		  
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(Self.ColumnModId) = DesktopListBox.Alignments.Right
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("AddLocalMod", "Add Mod", IconToolbarAdd, "Add a mod so you can use its content in Beacon."))
		  Me.Append(OmniBarItem.CreateButton("RegisterMod", "Register Mod", IconToolbarAddOutline, "Register a mod you have created with Beacon."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ImportButton", "Import", IconToolbarImport, "Import mod info that was exported from Beacon."))
		  Me.Append(OmniBarItem.CreateButton("ExportButton", "Export", IconToolbarExport, "Export the selected mod or mods to be shared with other Beacon users.", False))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditModBlueprints", "Edit Blueprints", IconToolbarEdit, "Edit the blueprints provided by the selected mod.", Self.ModsList.SelectedRowCount = 1))
		  Me.Append(OmniBarItem.CreateButton("EditMod", "Mod Settings", IconToolbarSettings, "Change settings for the selected mod.", False))
		  Me.Append(OmniBarItem.CreateSpace)
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateSpace)
		  Me.Append(OmniBarItem.CreateButton("DiscoverMods", "Discover Mods", IconToolbarDiscover, "Launch a dedicated server to discover mod data."))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  
		  Var FilterModsButton As OmniBarItem = OmniBarItem.CreateButton("FilterMods", "Filter Mods", IconToolbarFilter, "Decide which mods show in the list.")
		  Var IsFiltered As Boolean = Preferences.ModFilters.IsFiltered
		  FilterModsButton.AlwaysUseActiveColor = IsFiltered
		  FilterModsButton.ActiveColor = If(IsFiltered, OmniBarItem.ActiveColors.Blue, OmniBarItem.ActiveColors.Accent)
		  FilterModsButton.Icon = If(IsFiltered, IconToolbarFilterActive, IconToolbarFilter)
		  Me.Append(FilterModsButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "AddLocalMod", "RegisterMod"
		    Var GameId As String = GameSelectorWindow.Present(Self, Beacon.Game.FeatureMods, False)
		    If GameId.IsEmpty Then
		      Return
		    End If
		    
		    Select Case GameId
		    Case Ark.Identifier
		      Var ModId As String =  ArkRegisterModDialog.Present(Self, If(Item.Name = "AddLocalMod", ArkRegisterModDialog.ModeLocal, ArkRegisterModDialog.ModeRemote))
		      If ModId.IsEmpty = False Then
		        Self.RefreshMods(Array(ModId))
		        Self.ModsList.SetFocus()
		      End If
		    Case ArkSA.Identifier
		      Var ModId As String =  ArkSARegisterModDialog.Present(Self, If(Item.Name = "AddLocalMod", ArkSARegisterModDialog.ModeLocal, ArkSARegisterModDialog.ModeRemote))
		      If ModId.IsEmpty = False Then
		        Self.RefreshMods(Array(ModId))
		        Self.ModsList.SetFocus()
		      End If
		    Else
		      Self.ShowAlert("Beacon does not support mods for " + Language.GameName(GameId), "This feature may or may not be added in the future.")
		      Return
		    End Select
		  Case "EditModBlueprints"
		    Self.ModsList.DoEdit()
		  Case "EditMod"
		    Var Pack As Beacon.ContentPack = Self.ModsList.RowTagAt(Self.ModsList.SelectedRowIndex)
		    If Self.CloseModView(Pack.ContentPackId) = False Then
		      Self.ShowAlert("Mod content editor must be closed to edit settings.", "Save or discard your work, close the view, and try again.")
		      Return
		    End If
		    If ModSettingsDialog.Present(Self, Pack) Then
		      Self.RefreshMods()
		    End If
		  Case "DiscoverMods"
		    Self.RunModDiscovery()
		  Case "ImportButton"
		    Self.ShowImportDialog()
		  Case "ExportButton"
		    Var IsCurator As Boolean = (App.IdentityManager Is Nil) = False And (App.IdentityManager.CurrentIdentity Is Nil) = False And App.IdentityManager.CurrentIdentity.IsCurator
		    If IsCurator = False Then
		      Self.ExportSelectedMods()
		      Return
		    End If
		    
		    Var ExportFileItem As New DesktopMenuItem("Export To File")
		    Var ExportCommunityItem As New DesktopMenuItem("Export To Community")
		    ExportCommunityItem.Enabled = Self.ModsList.SelectedRowCount <> 0
		    
		    Var ExportMenu As New DesktopMenuItem
		    ExportMenu.AddMenu(ExportFileItem)
		    ExportMenu.AddMenu(ExportCommunityItem)
		    
		    Var Position As Point = Me.GlobalPosition
		    Var Choice As DesktopMenuItem = ExportMenu.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		    If (Choice Is Nil) = False Then
		      Select Case Choice
		      Case ExportFileItem
		        Self.ExportSelectedMods()
		      Case ExportCommunityItem
		        Self.UploadSelectedMods()
		      End Select
		    End If
		  Case "FilterMods"
		    If (Self.mFilterPopoverController Is Nil) = False And Self.mFilterPopoverController.Visible Then
		      Self.mFilterPopoverController.Dismiss(False)
		      Self.mFilterPopoverController = Nil
		      Item.Toggled = False
		      Return
		    End If
		    
		    Var SettingsView As New ModFilterView(Preferences.ModFilters)
		    Var Controller As New PopoverController("Mod Filters", SettingsView)
		    Controller.Show(Me, ItemRect)
		    
		    Item.Toggled = True
		    
		    AddHandler Controller.Finished, WeakAddressOf FilterPopoverController_Finished
		    Self.mFilterPopoverController = Controller
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModDeleterThread
	#tag Event
		Sub Run()
		  Var DataSources() As Beacon.DataSource = App.DataSources
		  For Each DataSource As Beacon.DataSource In DataSources
		    Var Writable As Beacon.DataSource = DataSource.WriteableInstance
		    For Each ModId As String In Self.mModUUIDsToDelete
		      Try
		        If Writable.DeleteContentPack(ModId, True) Then
		          Me.AddUserInterfaceUpdate(New Dictionary("Action": "Mod Deleted", "Mod UUID": ModId))
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		  Next
		  Self.mModUUIDsToDelete.ResizeTo(-1)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    Var Action As String = Dict.Lookup("Action", "").StringValue
		    
		    Select Case Action
		    Case "Mod Deleted"
		      Var ContentPackId As String = Dict.Value("Mod UUID")
		      Self.mPacksData.ExecuteSQL("DELETE FROM packs WHERE content_pack_id = ?1;", ContentPackId)
		      Self.UpdateModsList()
		    End Select
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateModsList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ArkDiscoveryEngine
	#tag Event
		Sub Error(ErrorMessage As String)
		  Self.ShowAlert("There was an error with mod discovery", ErrorMessage)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished()
		  If (Self.mProgress Is Nil) = False Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  If Me.WasSuccessful Then
		    Self.RefreshMods()
		  Else
		    Return
		  End If
		  
		  Var Message As String = "Added " + Language.NounWithQuantity(Self.mNumAddedMods, "new mod", "new mods") + ", " + Language.NounWithQuantity(Self.mNumAddedBlueprints, "new or updated blueprint", "new or updated blueprints") + ", and removed " + Language.NounWithQuantity(Self.mNumRemovedBlueprints, "blueprint", "blueprints") + "."
		  If Self.mNumErrorBlueprints > 0 Then
		    Message = Message + " " + Language.NounWithQuantity(Self.mNumErrorBlueprints, "blueprint", "blueprints") + " had errors and could not be imported."
		  End If
		  
		  Self.ShowAlert("Mod discovery has finished", Message)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Import(LogContents As String)
		  Var Importer As Ark.BlueprintImporter = Ark.BlueprintImporter.ImportAsDataDumper(LogContents)
		  If Importer Is Nil Or Importer.BlueprintCount = 0 Then
		    Return
		  End If
		  
		  Var Database As Ark.DataSource = Ark.DataSource.Pool.Get(True)
		  
		  // Always skip DataDumper
		  Var ForbiddenWorkshopIds As New Dictionary
		  ForbiddenWorkshopIds.Value("2171967557") = True
		  
		  Var TitleFinder As New Regex
		  TitleFinder.SearchPattern = "<div class=""workshopItemTitle"">(.+)</div>"
		  TitleFinder.Options.Greedy = False
		  
		  Var Packs As New Dictionary
		  Var ModIds() As String = Me.ModIds
		  Var ModsFilter As New Beacon.StringList()
		  Var Now As Double = DateTime.Now.SecondsFrom1970
		  For Each WorkshopId As String In ModIds
		    If WorkshopId = "2171967557" Then
		      Continue
		    End If
		    
		    Var PackName As String
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("User-Agent") = App.UserAgent
		    Socket.Send("GET", "https://steamcommunity.com/sharedfiles/filedetails/?id=" + WorkshopId)
		    If Socket.LastHTTPStatus = 200 Then
		      Var TitleMatch As RegexMatch = TitleFinder.Search(Socket.LastContent)
		      If (TitleMatch Is Nil) = False Then
		        PackName = DecodingFromHTMLMBS(TitleMatch.SubExpressionString(1))
		      End If
		    End If
		    
		    Var Pack As Beacon.ContentPack = Database.GetContentPackWithSteamId(WorkshopId, Beacon.ContentPack.TypeLocal)
		    If Pack Is Nil Then
		      If PackName.IsEmpty Then
		        Var Tag As String = Me.GetTagForModId(WorkshopId)
		        If Tag.IsEmpty = False Then
		          PackName = Tag
		        Else
		          PackName = WorkshopId
		        End If
		      End If
		      
		      Pack = Database.CreateLocalContentPack(PackName, WorkshopId, True)
		      Self.mNumAddedMods = Self.mNumAddedMods + 1
		    Else
		      If PackName.IsEmpty Then
		        PackName = Pack.Name
		      End If
		      
		      Var Mutable As New Beacon.MutableContentPack(Pack)
		      Mutable.Name = PackName
		      Mutable.LastUpdate = Now
		      Pack = New Beacon.ContentPack(Mutable)
		      Call Database.SaveContentPack(Pack, True)
		    End If
		    
		    ModsFilter.Append(Pack.ContentPackId)
		    Packs.Value(WorkshopId) = Pack
		  Next
		  
		  Var CurrentBlueprints() As Ark.Blueprint = Database.GetBlueprints("", ModsFilter, "")
		  Var CurrentBlueprintMap As New Dictionary
		  For Each Blueprint As Ark.Blueprint In CurrentBlueprints
		    CurrentBlueprintMap.Value(Blueprint.Path) = Blueprint
		  Next
		  
		  Var BlueprintsToSave() As Ark.Blueprint
		  Var Blueprints() As Ark.Blueprint = Importer.Blueprints
		  Var NewBlueprintIds As New Dictionary
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Try
		      Var Path As String = Blueprint.Path
		      Var OriginalBlueprint As Ark.Blueprint
		      If CurrentBlueprintMap.HasKey(Path) Then
		        OriginalBlueprint = CurrentBlueprintMap.Value(Path)
		        CurrentBlueprintMap.Remove(Path)
		      End If
		      
		      Var PathComponents() As String = Path.Split("/")
		      Var Tag As String = PathComponents(3)
		      Var WorkshopId As String = Me.GetModIdForTag(Tag)
		      If Packs.HasKey(WorkshopId) = False Or ForbiddenWorkshopIDs.HasKey(WorkshopId) Then
		        Continue
		      End If
		      
		      Var Pack As Beacon.ContentPack = Packs.Value(WorkshopId)
		      
		      Var Mutable As Ark.MutableBlueprint
		      If (OriginalBlueprint Is Nil) = False Then
		        Mutable = OriginalBlueprint.MutableVersion
		        If Mutable.CopyFrom(Blueprint) = False Then
		          Continue
		        End If
		        Mutable.BlueprintId = OriginalBlueprint.BlueprintId
		        Mutable.ContentPackName = Pack.Name
		        Mutable.ContentPackId = Pack.ContentPackId
		      Else
		        Mutable = Blueprint.MutableVersion
		        Mutable.ContentPackName = Pack.Name
		        Mutable.ContentPackId = Pack.ContentPackId
		        Mutable.RegenerateBlueprintId()
		      End If
		      BlueprintsToSave.Add(Mutable)
		      NewBlueprintIds.Value(Blueprint.BlueprintId) = True
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Pairing blueprint to mod")
		    End Try
		  Next
		  
		  Var BlueprintsToDelete() As Ark.Blueprint
		  Var DeleteBlueprintIDs As New Dictionary
		  If Self.mDiscoveryShouldDelete Then
		    For Each Entry As DictionaryEntry In CurrentBlueprintMap
		      BlueprintsToDelete.Add(Ark.Blueprint(Entry.Value))
		      DeleteBlueprintIDs.Value(Ark.Blueprint(Entry.Value).BlueprintId) = True
		    Next
		  End If
		  
		  Var Errors As New Dictionary
		  Call Database.SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, Errors, True)
		  Self.mNumErrorBlueprints = Errors.KeyCount
		  Self.mNumAddedBlueprints = BlueprintsToSave.Count
		  Self.mNumRemovedBlueprints = BlueprintsToDelete.Count
		  
		  For Each Entry As DictionaryEntry In Errors
		    App.Log(RuntimeException(Entry.Value), CurrentMethodName, "Automatic mod discovery")
		    
		    Var BlueprintId As String = Entry.Key
		    If NewBlueprintIds.HasKey(BlueprintId) Then
		      Self.mNumAddedBlueprints = Self.mNumAddedBlueprints - 1
		    ElseIf DeleteBlueprintIDs.HasKey(BlueprintId) Then
		      Self.mNumRemovedBlueprints = Self.mNumRemovedBlueprints - 1
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In Packs
		    Var WorkshopId As String = Entry.Key
		    Var Pack As Beacon.ContentPack = Entry.Value
		    
		    If ForbiddenWorkshopIds.HasKey(WorkshopId) Then
		      Continue
		    End If
		    
		    Self.mDiscoveredMods.Add(Pack)
		    
		    If Preferences.OnlineEnabled = False Then
		      Continue
		    End If
		    
		    Try
		      Var Exported As MemoryBlock = Beacon.BuildExport(True, Pack)
		      If Exported Is Nil Then
		        Call Database.DeleteContentPack(Pack, True)
		        Self.mNumAddedMods = Max(Self.mNumAddedMods - 1, 0)
		        Continue
		      End If
		      
		      Var Request As New BeaconAPI.Request("discovery/" + Pack.ContentPackId, "PUT", Exported, "application/octet-stream")
		      Call BeaconAPI.SendSync(Request) // Response doesn't actually matter
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Uploading discovery results")
		    End Try
		  Next
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.mProgress = New ProgressWindow("Running mod discovery", Me.StatusMessage)
		  AddHandler mProgress.CancelPressed, WeakAddressOf mProgress_CancelPressed
		  Self.mProgress.Show(Self.TrueWindow)
		End Sub
	#tag EndEvent
	#tag Event
		Sub StatusUpdated()
		  If (Self.mProgress Is Nil) = False Then
		    Self.mProgress.Detail = Me.StatusMessage
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ArkSADiscoveryEngine
	#tag Event
		Sub ContentPackDiscovered(ContentPack As Beacon.ContentPack, Blueprints() As ArkSA.Blueprint)
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(True)
		  Var ShouldDelete As Boolean = Self.mDiscoveryShouldDelete
		  
		  // Save the new content pack
		  If Blueprints.Count > 0 Then
		    If DataSource.SaveContentPack(ContentPack, False) Then
		      Self.mNumAddedMods = Self.mNumAddedMods + 1
		    Else
		      ContentPack = DataSource.GetContentPackWithId(ArkSA.UserContentPackId)
		      ShouldDelete = False
		    End If
		  End If
		  
		  // Find existing blueprints
		  Var Map As New Dictionary
		  Var ExistingBlueprints() As ArkSA.Blueprint = DataSource.GetBlueprints("", New Beacon.StringList(ContentPack.ContentPackId), "")
		  For Each Blueprint As ArkSA.Blueprint In ExistingBlueprints
		    Map.Value(Blueprint.BlueprintId) = Blueprint
		  Next
		  
		  // Existing blueprints should not be saved over
		  Var BlueprintsToSave() As ArkSA.Blueprint
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    If Map.HasKey(Blueprint.BlueprintId) Then
		      Map.Remove(Blueprint.BlueprintId)
		    Else
		      If Blueprint.ContentPackId <> ContentPack.ContentPackId Then
		        Var Mutable As ArkSA.MutableBlueprint = Blueprint.MutableVersion
		        Mutable.ContentPackId = ContentPack.ContentPackId
		        Mutable.ContentPackName = ContentPack.Name
		        Mutable.RegenerateBlueprintId()
		        Blueprint = Mutable.ImmutableVersion
		      End If
		      BlueprintsToSave.Add(Blueprint)
		    End If
		  Next
		  
		  // Setup blueprints to be deleted, if necessary
		  Var BlueprintsToDelete() As ArkSA.Blueprint
		  If ShouldDelete Then
		    For Each Entry As DictionaryEntry In Map
		      BlueprintsToDelete.Add(Entry.Value)
		    Next
		  End If
		  
		  Var ErrorDict As New Dictionary
		  Call DataSource.SaveBlueprints(Blueprints, BlueprintsToDelete, ErrorDict, True)
		  
		  Self.mNumAddedBlueprints = Self.mNumAddedBlueprints + BlueprintsToSave.Count
		  Self.mNumRemovedBlueprints = Self.mNumRemovedBlueprints + BlueprintsToDelete.Count
		  Self.mNumErrorBlueprints = Self.mNumErrorBlueprints + ErrorDict.KeyCount
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(ErrorMessage As String)
		  Self.ShowAlert("There was an error with mod discovery", ErrorMessage)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished()
		  If (Self.mProgress Is Nil) = False Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  If Me.WasSuccessful Then
		    Self.RefreshMods()
		  Else
		    Return
		  End If
		  
		  Var Message As String = "Added " + Language.NounWithQuantity(Self.mNumAddedMods, "new mod", "new mods") + ", " + Language.NounWithQuantity(Self.mNumAddedBlueprints, "new or updated blueprint", "new or updated blueprints") + ", and removed " + Language.NounWithQuantity(Self.mNumRemovedBlueprints, "blueprint", "blueprints") + "."
		  If Self.mNumErrorBlueprints > 0 Then
		    Message = Message + " " + Language.NounWithQuantity(Self.mNumErrorBlueprints, "blueprint", "blueprints") + " had errors and could not be imported."
		  End If
		  
		  Self.ShowAlert("Mod discovery has finished", Message)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.mNumAddedBlueprints = 0
		  Self.mNumErrorBlueprints = 0
		  Self.mNumAddedMods = 0
		  Self.mNumRemovedBlueprints = 0
		  
		  Self.mProgress = New ProgressWindow("Running mod discovery", Me.StatusMessage)
		  AddHandler mProgress.CancelPressed, WeakAddressOf mProgress_CancelPressed
		  Self.mProgress.Show(Self.TrueWindow)
		End Sub
	#tag EndEvent
	#tag Event
		Sub StatusUpdated()
		  If (Self.mProgress Is Nil) = False Then
		    Self.mProgress.Detail = Me.StatusMessage
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
#tag EndViewBehavior
