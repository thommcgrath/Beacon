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
   Width           =   600
   Begin OmniBar ModsToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
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
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   330
   End
   Begin OmniBarSeparator FilterSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
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
   End
   Begin FadedSeparator StatusSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
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
      TabIndex        =   4
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
      ColumnCount     =   4
      ColumnWidths    =   "*,200,200,125"
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
      InitialValue    =   "Name	Game	Last Updated	Status"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      Width           =   600
      _ScrollWidth    =   -1
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
		Sub Opening()
		  RaiseEvent Opening()
		  
		  NotificationKit.Watch(Self, DataUpdater.Notification_ImportStopped)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshMods()
		  If Self.List Is Nil Then
		    Return
		  End If
		  
		  Self.List.ScrollPosition = 0
		  Self.List.RemoveAllRows()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  
		  Self.RefreshMods()
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateUI()
		  Var Status As String
		  If Self.List.SelectedRowCount > 0 Then
		    Status = Self.List.SelectedRowCount.ToString(Locale.Current, "0,##") + " of " + Language.NounWithQuantity(Self.TotalResults, "mod", "mods") + " selected"
		  Else
		    Status = Language.NounWithQuantity(Self.TotalResults, "mod", "mods")
		  End If
		  If Self.StatusLabel.Text <> Status Then
		    Self.StatusLabel.Text = Status
		  End If
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
		  
		  DataUpdater.ImportString(Response.Content)
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
		    Try
		      Var Parsed As Dictionary = Beacon.ParseJSON(Response.Content)
		      Self.TotalResults = Parsed.Value("totalResults")
		      Self.TotalPages = Parsed.Value("pages")
		      Results = Parsed.Value("results")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing page of results.")
		      Return
		    End Try
		    
		    Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		    For Each Dict As Dictionary In Results
		      Var ModInfo As New BeaconAPI.WorkshopMod(Dict)
		      Var GameName As String = Language.GameName(ModInfo.GameId)
		      Var LastUpdate As New DateTime(ModInfo.LastUpdate, TimeZone.Current)
		      Var Status As String = ""
		      
		      Var Pack As Ark.ContentPack = DataSource.GetContentPackWithId(ModInfo.ModID)
		      If (Pack Is Nil) = False Then
		        If Pack.LastUpdate < ModInfo.LastUpdate Then
		          Status = "Update Available"
		        Else
		          Status = "Downloaded"
		        End If
		      End If
		      
		      Self.List.AddRow(ModInfo.Name, GameName, LastUpdate.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium), Status)
		      Self.List.RowTagAt(Self.List.LastAddedRowIndex) = ModInfo
		    Next
		  End If
		  
		  Self.List.InvalidateScrollPosition
		End Sub
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
		    Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		    For Idx As Integer = Self.mPendingDownloads.LastIndex DownTo 0
		      Var Pack As Ark.ContentPack = DataSource.GetContentPackWithId(Self.mPendingDownloads(Idx))
		      If (Pack Is Nil) = False Then
		        Var ModInfo As New BeaconAPI.WorkshopMod(Pack)
		        Self.ShowMod(ModInfo)
		        Self.mPendingDownloads.RemoveAt(Idx)
		        Self.mDownloadCount = Self.mDownloadCount + 1
		      End If
		    Next
		    
		    If Self.IsFrontmost Then
		      Self.RefreshMods()
		    End If
		  End Select
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
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


#tag EndWindowCode

#tag Events ModsToolbar
	#tag Event
		Sub Opening()
		  Var DownloadButton As OmniBarItem = OmniBarItem.CreateButton("DownloadButton", "Download", IconToolbarImport, "Copy the selected mod to your copy of Beacon.", False)
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
		  Self.List.ScrollPosition = 0
		  Self.List.RemoveAllRows
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub LoadMoreRows(Page As Integer)
		  If Self.HasBeenShown = False Or (Page > 1 And Page > Self.TotalPages) Then
		    Return
		  End If
		  
		  Self.StartJob()
		  
		  Var Params As New Dictionary
		  Params.Value("page") = Page
		  Params.Value("pageSize") = Me.PageSize
		  
		  Var Filter As String = Self.FilterField.Text.Trim
		  If Filter.IsEmpty = False Then
		    Params.Value("search") = Filter
		  End If
		  
		  Var Request As New BeaconAPI.Request("/discovery", "GET", Params, AddressOf APICallback_ListMods)
		  BeaconAPI.Send(Request)
		End Sub
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
		    Var ModInfo As BeaconAPI.WorkshopMod = Me.RowTagAt(Idx)
		    Var Request As New BeaconAPI.Request("/discovery/" + ModInfo.ModID, "GET", AddressOf APICallback_DownloadMod)
		    BeaconAPI.Send(Request)
		    
		    If Self.mPendingDownloads.IndexOf(ModInfo.ModID) = -1 Then
		      Self.mPendingDownloads.Add(ModInfo.ModID)
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
