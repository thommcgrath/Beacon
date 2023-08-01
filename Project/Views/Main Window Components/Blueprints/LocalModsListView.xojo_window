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
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, DataUpdater.Notification_ImportStopped)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshMods()
		  Var SelectedModIds() As String
		  Var ScrollPosition As Integer = Self.ModsList.ScrollPosition
		  For Idx As Integer = 0 To Self.ModsList.LastRowIndex
		    If Self.ModsList.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    SelectedModIds.Add(BeaconAPI.ContentPack(Self.ModsList.RowTagAt(Idx)).ContentPackId)
		  Next
		  
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
		Private Function DiscoveryCheckMod(WorkshopID As String) As Boolean
		  Return Self.CloseModView(WorkshopID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DiscoveryCompleted(DiscoveredMods() As Beacon.ContentPack)
		  #Pragma Unused DiscoveredMods
		  Self.RefreshMods()
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
		  If Self.mDiscoveryDialog Is Nil Or Self.mDiscoveryDialog.Value Is Nil Then
		    Var Dialog As New ModDiscoveryDialog(AddressOf DiscoveryCheckMod, AddressOf DiscoveryCompleted)
		    Self.mDiscoveryDialog = New WeakRef(Dialog)
		  End If
		  
		  ModDiscoveryDialog(Self.mDiscoveryDialog.Value).Show()
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
		Private mDiscoveryDialog As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModUUIDsToDelete() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpenModWhenRefreshed As String
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
		    Var ModId As String =  RegisterModDialog.Present(Self, RegisterModDialog.ModeLocal)
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
