#tag DesktopWindow
Begin ModsListView RemoteModsListView
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
   Width           =   600
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
      TabIndex        =   0
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   270
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
      TabIndex        =   2
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   330
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
      TabIndex        =   4
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
		  Self.List.PauseScrollWatching()
		  RaiseEvent Hidden()
		End Sub
	#tag EndEvent

	#tag Event
		Sub JobsFinished()
		  If Self.mRefreshWhenFinished Then
		    Self.RefreshMods()
		    Self.mRefreshWhenFinished = False
		  End If
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
		  Var Status As String
		  If Self.List.SelectedRowCount > 0 Then
		    Status = Self.List.SelectedRowCount.ToString(Locale.Current, "#,##0") + " of " + Language.NounWithQuantity(Self.TotalResults, "mod", "mods") + " selected"
		  Else
		    Status = Language.NounWithQuantity(Self.TotalResults, "mod", "mods")
		  End If
		  Self.Status.CenterCaption = Status
		  
		  Self.List.SizeColumnToFit(Self.ColumnGameId, 100)
		  Self.List.SizeColumnToFit(Self.ColumnModId, 100)
		  Self.List.SizeColumnToFit(Self.ColumnStatus, 100)
		  Self.List.SizeColumnToFit(Self.ColumnUpdated, 100)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteMod(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Self.List Is Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  Var ModId As String = Request.Tag
		  
		  If Response.Success Then
		    Self.mRefreshWhenFinished = True
		  Else
		    Var ModName As String = ModId
		    For Idx As Integer = 0 To Self.List.LastRowIndex
		      Var ContentPack As BeaconAPI.ContentPack = Self.List.RowTagAt(Idx)
		      If ContentPack.ContentPackId = ModId Then
		        ModName = ContentPack.Name
		        Exit
		      End If
		    Next
		    
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
		    
		    Self.ShowAlert("Mod """ + ModName + """ was not deleted", Explanation)
		  End If
		  
		  Self.FinishJob
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
		      Return
		    End Try
		    
		    Var StartIdx As Integer = Self.List.RowIndexOfPage(Page)
		    Self.List.SelectionChangeBlocked = True
		    For Idx As Integer = 0 To Results.LastIndex
		      Var Dict As Dictionary = Results(Idx)
		      Var RowIdx As Integer = StartIdx + Idx
		      
		      Var ModInfo As New BeaconAPI.ContentPack(Dict)
		      Var GameName As String = Language.GameName(ModInfo.GameId)
		      Var LastUpdate As New DateTime(ModInfo.LastUpdate, TimeZone.Current)
		      Var Status As String = If(ModInfo.Confirmed, "Confirmed", "Waiting Confirmation")
		      
		      Self.List.RowTagAt(RowIdx) = ModInfo
		      Self.List.CellTextAt(RowIdx, Self.ColumnName) = ModInfo.Name
		      Self.List.CellTextAt(RowIdx, Self.ColumnGameId) = GameName
		      Self.List.CellTextAt(RowIdx, Self.ColumnModId) = ModInfo.MarketplaceId
		      Self.List.CellTextAt(RowIdx, Self.ColumnUpdated) = LastUpdate.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium)
		      Self.List.CellTextAt(RowIdx, Self.ColumnStatus) = Status
		      Self.List.RowSelectedAt(RowIdx) = Self.mSelectedModIds.IndexOf(ModInfo.ContentPackId) > -1
		    Next
		    Self.List.SelectionChangeBlocked(False) = False
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
		  Self.ViewID = "RemoteModsListView"
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedModIds() As String()
		  If Self.Working Then
		    Return Self.mSelectedModIds
		  End If
		  
		  Var Ids() As String
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Ids.Add(BeaconAPI.ContentPack(Self.List.RowTagAt(Idx)).ContentPackId)
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
		Event Hidden()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mRefreshWhenFinished As Boolean
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
		    Return True // Cancel
		  End If
		  
		  Self.StartJob()
		  
		  Var Params As New Dictionary
		  Params.Value("page") = Page
		  Params.Value("pageSize") = Me.PageSize
		  Params.Value("userId") = App.IdentityManager.CurrentUserId
		  
		  Var Filter As String = Self.FilterField.Text.Trim
		  If Filter.IsEmpty = False Then
		    Params.Value("search") = Filter
		  End If
		  
		  Var Request As New BeaconAPI.Request("contentPacks", "GET", Params, AddressOf APICallback_ListMods)
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
		    
		    Var ModInfo As BeaconAPI.ContentPack = Me.RowTagAt(Idx)
		    Self.ShowMod(ModInfo)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  If (Self.ModsToolbar.Item("EditModBlueprints") Is Nil) = False Then
		    Self.ModsToolbar.Item("EditModBlueprints").Enabled = (Me.SelectedRowCount > 0)
		  End If
		  
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var ModIds() As String
		  If Warn Then
		    Var Names() As String
		    For Row As Integer = 0 To Me.LastRowIndex
		      If Me.RowSelectedAt(Row) = False Then
		        Continue
		      End If
		      
		      Var ModInfo As BeaconAPI.ContentPack = Me.RowTagAt(Row)
		      Names.Add(ModInfo.Name)
		      ModIds.Add(ModInfo.ContentPackId)
		    Next
		    
		    If Not Self.ShowDeleteConfirmation(Names, "mod", "mods") Then
		      Return
		    End If
		  End If
		  
		  // Make sure they do not have unsaved changes
		  For Idx As Integer = ModIds.LastIndex DownTo 0
		    If Self.CloseModView(ModIds(Idx)) = False Then
		      Continue
		    End If
		    
		    Self.StartJob
		    Var Request As New BeaconAPI.Request("contentPacks/" + ModIds(Idx), "DELETE", WeakAddressOf APICallback_DeleteMod)
		    Request.Tag = ModIds(Idx)
		    BeaconAPI.Send(Request)
		  Next
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
		  Me.Append(OmniBarItem.CreateButton("RegisterMod", "Register Mod", IconToolbarAdd, "Register your mod with Beacon."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditModBlueprints", "Edit Blueprints", IconToolbarEdit, "Edit the blueprints provided by the selected mod.", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "RegisterMod"
		    Var GameId As String = GameSelectorWindow.Present(Self, Beacon.Game.FeatureMods, False)
		    If GameId.IsEmpty Then
		      Return
		    End If
		    
		    Select Case GameId
		    Case Ark.Identifier
		      Var ModId As String =  ArkRegisterModDialog.Present(Self, ArkRegisterModDialog.ModeRemote)
		      If ModId.IsEmpty = False Then
		        Self.RefreshMods(Array(ModId))
		        Self.List.SetFocus()
		      End If
		    Case ArkSA.Identifier
		      Var ModId As String =  ArkSARegisterModDialog.Present(Self, ArkSARegisterModDialog.ModeRemote)
		      If ModId.IsEmpty = False Then
		        Self.RefreshMods(Array(ModId))
		        Self.List.SetFocus()
		      End If
		    Else
		      Self.ShowAlert("Beacon does not support mods for " + Language.GameName(GameId), "This feature may or may not be added in the future.")
		      Return
		    End Select
		  Case "EditModBlueprints"
		    Self.List.DoEdit()
		  End Select
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
#tag EndViewBehavior
