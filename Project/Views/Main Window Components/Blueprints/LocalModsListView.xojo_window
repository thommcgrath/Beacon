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
      ColumnCount     =   3
      ColumnWidths    =   "*,200,200"
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
      InitialValue    =   "Name	Game	Last Update"
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
      RightPadding    =   -1
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
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
   Begin DesktopLabel StatusLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Loading Mods"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   375
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin FadedSeparator StatusSeparator
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   369
      Transparent     =   True
      Visible         =   True
      Width           =   600
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
   Begin Ark.ModDiscoveryEngine DiscoveryEngine
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, DataUpdater.Notification_ImportStopped)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshMods(SelectedModIds() As String)
		  Var ScrollPosition As Integer = Self.ModsList.ScrollPosition
		  Var Filter As String = Self.FilterField.Text.Trim
		  
		  Self.ModsList.RemoveAllRows
		  Var Packs() As Beacon.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks(Filter, Beacon.ContentPack.Types.Custom)
		  For Each Pack As Beacon.ContentPack In Packs
		    Var GameName As String = Language.GameName("Ark")
		    Var LastUpdate As New DateTime(Pack.LastUpdate, TimeZone.Current)
		    Var ModInfo As New BeaconAPI.ContentPack(Pack)
		    
		    Self.ModsList.AddRow(Pack.Name, GameName, LastUpdate.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium))
		    Var Idx As Integer = Self.ModsList.LastAddedRowIndex
		    Self.ModsList.RowTagAt(Idx) = ModInfo
		    Self.ModsList.RowSelectedAt(Idx) = SelectedModIds.IndexOf(Pack.ContentPackId) > -1
		    
		    If Self.mOpenModWhenRefreshed = Pack.ContentPackId Then
		      Self.ShowMod(ModInfo)
		      Self.mOpenModWhenRefreshed = ""
		    End If
		  Next
		  Self.TotalPages = 1
		  Self.TotalResults = Self.ModsList.RowCount
		  
		  Self.ModsList.Sort
		  Self.ModsList.ScrollPosition = ScrollPosition
		  Self.ModsList.EnsureSelectionIsVisible
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  NotificationKit.Watch(Self, DataUpdater.Notification_ImportStopped)
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateUI()
		  Var Status As String
		  If Self.ModsList.SelectedRowCount > 0 Then
		    Status = Self.ModsList.SelectedRowCount.ToString(Locale.Current, "#,##0") + " of " + Language.NounWithQuantity(Self.TotalResults, "mod", "mods") + " selected"
		  Else
		    Status = Language.NounWithQuantity(Self.TotalResults, "mod", "mods")
		  End If
		  If Self.StatusLabel.Text <> Status Then
		    Self.StatusLabel.Text = Status
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteMods(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.FinishJob()
		  
		  If Response.Success Then
		    Self.RefreshMods()
		    Return
		  End If
		  
		  Self.ShowAlert("Sorry, the selected mod or mods were not deleted.", Response.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.ViewID = "LocalModsListView"
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportSelectedMods()
		  Var Packs() As Beacon.ContentPack
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  
		  For Idx As Integer = 0 To Self.ModsList.LastRowIndex
		    If Self.ModsList.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var WorkshopMod As BeaconAPI.ContentPack = Self.ModsList.RowTagAt(Idx)
		    If WorkshopMod Is Nil Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = DataSource.GetContentPackWithId(WorkshopMod.ContentPackId)
		    If Pack Is Nil Then
		      Continue
		    End If
		    
		    Packs.Add(Pack)
		  Next
		  
		  If Packs.Count = 0 Then
		    Return
		  End If
		  
		  Var Dialog As New SaveFileDialog
		  Dialog.SuggestedFileName = "Exported Mods.beacondata"
		  Dialog.Filter = BeaconFileTypes.BeaconData
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  If Ark.BuildExport(Packs, File) = False Then
		    Self.ShowAlert("Export failed", "The selected " + If(Self.ModsList.SelectedRowCount = 1, "mod was", "mods were") + " not exported. Beacon's log files may have more information.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mProgress_CancelPressed(Sender As ProgressWindow)
		  #Pragma Unused Sender
		  
		  Self.DiscoveryEngine.Cancel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case DataUpdater.Notification_ImportStopped
		    Self.RefreshMods()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunModDiscovery()
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
		    Self.DiscoveryEngine.Start(ArkFolder, ModIds)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Beacon could not start mod discovery", Err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedModIds() As String()
		  Var Ids() As String
		  For Idx As Integer = 0 To Self.ModsList.LastRowIndex
		    If Self.ModsList.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Ids.Add(BeaconAPI.ContentPack(Self.ModsList.RowTagAt(Idx)).ContentPackId)
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
		    Var Pack As BeaconAPI.ContentPack = List.RowTagAt(Idx)
		    List.RowSelectedAt(Idx) = ModIds.IndexOf(Pack.ContentPackId) > -1
		  Next
		  List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowImportDialog()
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.BeaconData
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  DataUpdater.ImportFile(File)
		End Sub
	#tag EndMethod


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
		Private mProgress As ProgressWindow
	#tag EndProperty


#tag EndWindowCode

#tag Events ModsList
	#tag Event
		Function CanDelete() As Boolean
		  If Me.SelectedRowCount = 1 And BeaconAPI.ContentPack(Me.RowTagAt(Me.SelectedRowIndex)).ContentPackId = Ark.UserContentPackId Then
		    Return False
		  Else
		    Return Me.SelectedRowCount > 0
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Mods() As BeaconAPI.ContentPack
		  If Warn Then
		    Var Names() As String
		    For Row As Integer = 0 To Me.LastRowIndex
		      Var ModInfo As BeaconAPI.ContentPack = Me.RowTagAt(Row)
		      If Me.RowSelectedAt(Row) And ModInfo.ContentPackId <> Ark.UserContentPackId Then
		        Names.Add(ModInfo.Name)
		        Mods.Add(ModInfo)
		      End If
		    Next
		    
		    If Not Self.ShowDeleteConfirmation(Names, "mod", "mods") Then
		      Return
		    End If
		  End If
		  
		  // Make sure they do not have unsaved changes
		  For Idx As Integer = Mods.LastIndex DownTo 0
		    If Self.CloseModView(Mods(Idx).ContentPackId) = False Then
		      Mods.RemoveAt(Idx)
		      Continue
		    End If
		    
		    Self.mModUUIDsToDelete.Add(Mods(Idx).ContentPackId)
		  Next
		  
		  If Self.mModUUIDsToDelete.Count > 0 And Self.ModDeleterThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.ModDeleterThread.Start
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var ModInfo As BeaconAPI.ContentPack = Me.RowTagAt(Me.SelectedRowIndex)
		  Self.ShowMod(ModInfo)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  If (Self.ModsToolbar.Item("EditModBlueprints") Is Nil) = False Then
		    Self.ModsToolbar.Item("EditModBlueprints").Enabled = Me.SelectedRowCount = 1
		  End If
		  
		  If (Self.ModsToolbar.Item("ExportButton") Is Nil) = False Then
		    Self.ModsToolbar.Item("ExportButton").Enabled = Me.SelectedRowCount > 0
		  End If
		  
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("RegisterMod", "Add Mod", IconToolbarAdd, "Add a mod to Beacon."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ImportButton", "Import", IconToolbarImport, "Import mod info that was exported from Beacon."))
		  Me.Append(OmniBarItem.CreateButton("ExportButton", "Export", IconToolbarExport, "Export the selected mod or mods to be shared with other Beacon users.", False))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditModBlueprints", "Edit Blueprints", IconToolbarEdit, "Edit the blueprints provided by the selected mod.", Self.ModsList.SelectedRowCount = 1))
		  #if TargetWindows
		    Me.Append(OmniBarItem.CreateSpace)
		    Me.Append(OmniBarItem.CreateSeparator)
		    Me.Append(OmniBarItem.CreateSpace)
		    Me.Append(OmniBarItem.CreateButton("DiscoverMods", "Discover Mods", IconToolbarDiscover, "Launch a dedicated server to discover mod data."))
		  #endif
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "RegisterMod"
		    Var ModId As String =  ArkRegisterModDialog.Present(Self, ArkRegisterModDialog.ModeLocal)
		    If ModId.IsEmpty = False Then
		      Self.mOpenModWhenRefreshed = ModId
		      Self.RefreshMods()
		    End If
		  Case "EditModBlueprints"
		    Self.ModsList.DoEdit()
		  Case "DiscoverMods"
		    Self.RunModDiscovery()
		  Case "ImportButton"
		    Self.ShowImportDialog()
		  Case "ExportButton"
		    Self.ExportSelectedMods()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModDeleterThread
	#tag Event
		Sub Run()
		  Var Database As Ark.DataSource = Ark.DataSource.Pool.Get(True)
		  For Each ModUUID As String In Self.mModUUIDsToDelete
		    If Database.DeleteContentPack(ModUUID) Then
		      Me.AddUserInterfaceUpdate(New Dictionary("Action": "Mod Deleted", "Mod UUID": ModUUID))
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    Var Action As String = Dict.Lookup("Action", "").StringValue
		    
		    Select Case Action
		    Case "Mod Deleted"
		      Var ModUUID As String = Dict.Value("Mod UUID")
		      For Row As Integer = Self.ModsList.LastRowIndex DownTo 0
		        If BeaconAPI.ContentPack(Self.ModsList.RowTagAt(Row)).ContentPackId = ModUUID Then
		          Self.ModsList.RemoveRowAt(Row)
		          Exit For Row
		        End If
		      Next
		      Self.TotalResults = Self.ModsList.RowCount
		    End Select
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.RefreshMods()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DiscoveryEngine
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
		  
		  Var Message As String = "Added " + Language.NounWithQuantity(Self.mNumAddedMods, "new mod", "new mods") + ", " + Language.NounWithQuantity(Self.mNumAddedBlueprints, "new blueprint", "new blueprints") + ", and removed " + Language.NounWithQuantity(Self.mNumRemovedBlueprints, "blueprint", "blueprints") + "."
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
		  For Each WorkshopId As String In ModIds
		    If WorkshopId = "2171967557" Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = Database.GetContentPackWithSteamId(WorkshopId, Beacon.ContentPack.Types.Custom)
		    If Pack Is Nil Then
		      Var PackName As String = Me.GetTagForModId(WorkshopId)
		      If PackName.IsEmpty Then
		        PackName = WorkshopId
		      End If
		      
		      Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		      Socket.RequestHeader("User-Agent") = App.UserAgent
		      Socket.Send("GET", "https://steamcommunity.com/sharedfiles/filedetails/?id=" + WorkshopId)
		      If Socket.LastHTTPStatus = 200 Then
		        Var TitleMatch As RegexMatch = TitleFinder.Search(Socket.LastContent)
		        If (TitleMatch Is Nil) = False Then
		          PackName = DecodingFromHTMLMBS(TitleMatch.SubExpressionString(1))
		        End If
		      End If
		      
		      Pack = Database.CreateLocalContentPack(PackName, WorkshopId)
		      Self.mNumAddedMods = Self.mNumAddedMods + 1
		    Else
		      ModsFilter.Append(Pack.ContentPackId)
		    End If
		    
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
		        Mutable.Label = Blueprint.Label
		        #Pragma Warning "Import more than just the name"
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
		  Call Database.SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, Errors)
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
		      Var Exported As MemoryBlock = Ark.BuildExport(Pack)
		      If Exported Is Nil Then
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
