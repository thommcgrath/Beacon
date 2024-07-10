#tag DesktopWindow
Begin ModsListView CommunityModsListView Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
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
   Width           =   854
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   584
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
      Left            =   584
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   270
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
      Left            =   594
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   2
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
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowInfiniteScroll=   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   5
      ColumnWidths    =   "*,200,100,200,125"
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Download"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   328
      Index           =   -2147483648
      InitialValue    =   "Name	Game	Mod ID	Last Updated	Status"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   5
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
      Width           =   854
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
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
      Width           =   854
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, DataUpdater.Notification_ImportStopped)
		  
		  RaiseEvent Closing()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  Self.List.PauseScrollWatching()
		  RaiseEvent Hidden()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening()
		  
		  NotificationKit.Watch(Self, DataUpdater.Notification_ImportStopped)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshMods(SelectedModIds() As String)
		  If Self.List Is Nil Then
		    Return
		  End If
		  
		  Self.mSelectedModIds = SelectedModIds
		  Self.List.ReloadAllPages()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  Self.List.ResumeScrollWatching()
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateUI()
		  Self.Status.CenterCaption = Self.List.StatusMessage("Mod", "Mods")
		  
		  Self.List.SizeColumnToFit(Self.ColumnGameId, 100)
		  Self.List.SizeColumnToFit(Self.ColumnModId, 100)
		  Self.List.SizeColumnToFit(Self.ColumnStatus, 100)
		  Self.List.SizeColumnToFit(Self.ColumnUpdated, 100)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DownloadMod(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.List Is Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  Self.FinishJob()
		  
		  If Not Response.Success Then
		    Return
		  End If
		  
		  DataUpdater.Import(Response.Content)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListMods(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.List Is Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  Self.FinishJob()
		  
		  If Response.Success Then
		    Var Results() As Variant
		    Var Page As Integer
		    Try
		      Var Parsed As Dictionary = Beacon.ParseJSON(Response.Content)
		      Page = Parsed.Value("page")
		      Self.TotalResults = Parsed.Value("totalResults")
		      Self.TotalPages = Parsed.Value("pages")
		      Results = Parsed.Value("results")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing page of results.")
		      Self.List.CompleteRowLoadRequest(Request.Tag)
		      Return
		    End Try
		    
		    Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		    Var StartIdx As Integer = Self.List.RowIndexOfPage(Page)
		    For Idx As Integer = 0 To Results.LastIndex
		      Var Dict As Dictionary = Results(Idx)
		      Var RowIdx As Integer = StartIdx + Idx
		      
		      Var ModInfo As New BeaconAPI.ContentPack(Dict)
		      Var GameName As String = Language.GameName(ModInfo.GameId)
		      Var LastUpdate As New DateTime(ModInfo.LastUpdate, TimeZone.Current)
		      Var Status As String = ""
		      
		      Var Pack As Beacon.ContentPack = DataSource.GetContentPackWithId(ModInfo.ContentPackId)
		      If (Pack Is Nil) = False Then
		        If Floor(Pack.LastUpdate) < Floor(ModInfo.LastUpdate) Then
		          Status = "Update Available"
		        Else
		          Status = "Downloaded"
		        End If
		      End If
		      
		      Self.List.RowTagAt(RowIdx) = ModInfo
		      Self.List.CellTextAt(RowIdx, Self.ColumnName) = ModInfo.Name
		      Self.List.CellTextAt(RowIdx, Self.ColumnGameId) = GameName
		      Self.List.CellTextAt(RowIdx, Self.ColumnModId) = ModInfo.MarketplaceId
		      Self.List.CellTextAt(RowIdx, Self.ColumnUpdated) = LastUpdate.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium)
		      Self.List.CellTextAt(RowIdx, Self.ColumnStatus) = Status
		      Self.List.RowSelectedAt(RowIdx) = Self.mSelectedModIds.IndexOf(ModInfo.ContentPackId) > -1
		    Next
		  End If
		  
		  Self.List.CompleteRowLoadRequest(Request.Tag)
		  Self.UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.ViewID = "CommunityModsListView"
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case DataUpdater.Notification_ImportStopped
		    Var OpenEditors As Boolean = Self.mPendingDownloads.Count <= 4
		    
		    Var DataSources() As Beacon.DataSource = App.DataSources
		    For Idx As Integer = Self.mPendingDownloads.LastIndex DownTo 0
		      Var Pack As Beacon.ContentPack
		      For Each DataSource As Beacon.DataSource In DataSources
		        Pack = DataSource.GetContentPackWithId(Self.mPendingDownloads(Idx))
		        If Pack Is Nil Then
		          Continue For DataSource
		        End If
		        
		        If OpenEditors Then
		          Self.ShowMod(Pack, ModsListView.ViewModes.Local)
		        End If
		        Self.mPendingDownloads.RemoveAt(Idx)
		        Self.mDownloadCount = Self.mDownloadCount + 1
		        
		        Exit For DataSource
		      Next
		    Next
		    
		    If Self.IsFrontmost Then
		      Self.RefreshMods()
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedModIds() As String()
		  If Self.Working Or Self.List Is Nil Then
		    Return Self.mSelectedModIds
		  End If
		  
		  Var Ids() As String
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var ModInfo As BeaconAPI.ContentPack = Self.List.RowTagAt(Idx)
		    If ModInfo Is Nil Then
		      Continue
		    End If
		    
		    Ids.Add(ModInfo.ContentPackId)
		  Next
		  Return Ids
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedModIds(Assigns ModIds() As String)
		  Self.mSelectedModIds = ModIds
		  
		  Var List As BeaconListbox = Self.List
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
		Function TotalPages() As Integer
		  Return Self.List.TotalPages
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TotalPages(Assigns Value As Integer)
		  Self.List.TotalPages = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalResults() As Integer
		  Return Self.List.RowCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TotalResults(Assigns Value As Integer)
		  Self.List.RowCount = Value
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Hidden()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDownloadCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingDownloads() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedModIds() As String
	#tag EndProperty


	#tag Constant, Name = ColumnGameId, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnModId, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnStatus, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnUpdated, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ModsToolbar
	#tag Event
		Sub Opening()
		  Var DownloadButton As OmniBarItem = OmniBarItem.CreateButton("DownloadButton", "Download", IconToolbarUpdate, "Copy the selected mod to your copy of Beacon.", False)
		  Me.Append(DownloadButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "DownloadButton"
		    Self.List.DoEdit()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.List.ReloadAllPages()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Function LoadMoreRows(Page As Integer, RequestToken As String) As Boolean
		  If Self.HasBeenShown = False Then
		    Me.PauseScrollWatching()
		    Return True
		  End If
		  
		  Self.StartJob()
		  
		  Var Params As New Dictionary
		  Params.Value("page") = Page
		  Params.Value("pageSize") = Me.PageSize
		  
		  Var Filter As String = Self.FilterField.Text.Trim
		  If Filter.IsEmpty = False Then
		    Params.Value("search") = Filter
		  End If
		  
		  Var SortingColumn As Integer = Me.SortingColumn
		  If SortingColumn = -1 Then
		    SortingColumn = Self.ColumnName
		  End If
		  
		  Select Case SortingColumn
		  Case Self.ColumnName
		    Params.Value("sort") = "name"
		  Case Self.ColumnGameId
		    Params.Value("sort") = "gameId"
		  Case Self.ColumnModId
		    Params.Value("sort") = "marketplaceId"
		  Case Self.ColumnUpdated
		    Params.Value("sort") = "lastUpdate"
		  End Select
		  
		  If Me.ColumnSortDirectionAt(SortingColumn) = DesktopListbox.SortDirections.Descending Then
		    Params.Value("direction") = "desc"
		  Else
		    Params.Value("direction") = "asc"
		  End If
		  
		  Var Request As New BeaconAPI.Request("/discovery", "GET", Params, AddressOf APICallback_ListMods)
		  Request.Tag = RequestToken
		  BeaconAPI.Send(Request)
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Self.StartJob()
		    Var ModInfo As BeaconAPI.ContentPack = Me.RowTagAt(Idx)
		    Var Request As New BeaconAPI.Request("/discovery/" + ModInfo.ContentPackId, "GET", AddressOf APICallback_DownloadMod)
		    BeaconAPI.Send(Request)
		    
		    If Self.mPendingDownloads.IndexOf(ModInfo.ContentPackId) = -1 Then
		      Self.mPendingDownloads.Add(ModInfo.ContentPackId)
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Var DownloadButton As OmniBarItem = Self.ModsToolbar.Item("DownloadButton")
		  If (DownloadButton Is Nil) = False Then
		    If Me.SelectedRowCount > 1 Then
		      DownloadButton.HelpTag = "Copy the selected mods to your copy of Beacon."
		    Else
		      DownloadButton.HelpTag = "Copy the selected mod to your copy of Beacon."
		    End If
		    DownloadButton.Enabled = Me.SelectedRowCount > 0
		  End If
		  
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(Self.ColumnModId) = DesktopListBox.Alignments.Right
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column = Self.ColumnStatus Then
		    Return False
		  End If
		  
		  Var Mod1 As BeaconAPI.ContentPack = Me.RowTagAt(Row1)
		  Var Mod2 As BeaconAPI.ContentPack = Me.RowTagAt(Row2)
		  
		  If (Mod1 Is Nil) = False And Mod2 Is Nil Then
		    Result = 1
		    Return True
		  ElseIf Mod1 Is Nil And (Mod2 Is Nil) = False Then
		    Result = -1
		    Return True
		  ElseIf Mod1 Is Nil And Mod2 Is Nil Then
		    Result = 0
		    Return True
		  End If
		  
		  Select Case Column
		  Case Self.ColumnName
		    Result = Mod1.Name.Compare(Mod2.Name, ComparisonOptions.CaseInsensitive)
		  Case Self.ColumnGameId
		    Result = Mod1.GameId.Compare(Mod2.GameId, ComparisonOptions.CaseInsensitive)
		  Case Self.ColumnModId
		    If IsNumeric(Mod1.MarketplaceId) And IsNumeric(Mod2.MarketplaceId) Then
		      Try
		        Var Mod1Id As Integer = Integer.FromString(Mod1.MarketplaceId, Locale.Raw)
		        Var Mod2Id As Integer = Integer.FromString(Mod2.MarketplaceId, Locale.Raw)
		        If Mod1Id > Mod2Id Then
		          Result = 1
		        ElseIf Mod2Id > Mod1Id Then
		          Result = -1
		        Else
		          Result = 0
		        End If
		        Return True
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    Result = Mod1.MarketplaceId.Compare(Mod2.MarketplaceId, ComparisonOptions.CaseSensitive)
		  Case Self.ColumnUpdated
		    If Mod1.LastUpdate > Mod2.LastUpdate Then
		      Result = 1
		    ElseIf Mod2.LastUpdate > Mod1.LastUpdate Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ColumnSorted(column As Integer) As Boolean
		  If Column = Self.ColumnStatus Then
		    Return True
		  End If
		  
		  Me.ReloadAllPages()
		  Return True
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
#tag EndViewBehavior
