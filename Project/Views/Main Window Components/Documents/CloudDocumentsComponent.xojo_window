#tag DesktopWindow
Begin DocumentsComponentView CloudDocumentsComponent Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "True"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   508
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
   Width           =   804
   Begin BeaconAPI.Socket APISocket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DocumentFilterControl FilterBar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      Composited      =   False
      ConsoleSafe     =   False
      Enabled         =   True
      GameId          =   ""
      HasBackgroundColor=   False
      Height          =   62
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      RequireAllMaps  =   False
      Scope           =   2
      SearchDelayPeriod=   250
      ShowFullControls=   True
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   804
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   6
      ColumnWidths    =   "46,2*,*,100,70,220"
      DefaultRowHeight=   26
      DefaultSortColumn=   "#ColumnUpdated"
      DefaultSortDirection=   -1
      DropIndicatorVisible=   False
      EditCaption     =   "Open"
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
      Height          =   414
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Name	Map	Console Safe	Revision	Last Updated"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   "Cloud Documents"
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   63
      Transparent     =   False
      TypeaheadColumn =   "#ColumnName"
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   804
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
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   62
      Transparent     =   True
      Visible         =   True
      Width           =   804
   End
   Begin DesktopLabel StatusbarLabel
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
      Selectable      =   True
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Untitled"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   483
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   764
   End
   Begin FadedSeparator StatusbarSeparator
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   477
      Transparent     =   True
      Visible         =   True
      Width           =   804
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  If Self.mVersionProgressKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mVersionProgressKey)
		    Self.mVersionProgressKey = ""
		  End If
		  
		  If (Self.mVersionProgress Is Nil) = False Then
		    Self.mVersionProgress.Close
		    Self.mVersionProgress = Nil
		  End If
		  
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged, Preferences.Notification_OnlineStateChanged, Preferences.Notification_OnlineTokenChanged)
		  
		  RaiseEvent Closing
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged, Preferences.Notification_OnlineStateChanged, Preferences.Notification_OnlineTokenChanged)
		  RaiseEvent Opening
		  Self.UpdateStatusbar()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  If Self.mHasBeenShown = False Then
		    Self.mHasBeenShown = True
		    Self.Load
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteProject(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Response.Success Then
		    // Remove from recents
		    Var Recents() As Beacon.ProjectURL = Preferences.RecentDocuments
		    Var Changed As Boolean
		    For Idx As Integer = Recents.LastIndex DownTo 0
		      If Recents(Idx).URL(Beacon.ProjectURL.URLTypes.Writing) = Request.URL Then
		        Recents.RemoveAt(Idx)
		        Changed = True
		      End If
		    Next
		    If Changed Then
		      Preferences.RecentDocuments = Recents
		    End If
		    
		    Return
		  End If
		  
		  Var Message As String = Response.Message
		  If Message.IsEmpty Then
		    Message = "An unknown error occurred."
		  End If
		  
		  Self.ShowAlert("A project was not deleted.", Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListProjects(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.mRefreshing = False
		  
		  If Not Response.Success Then
		    Break
		    Return
		  End If
		  
		  Var TotalResults, TotalPages As Integer
		  Var Results() As Variant
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Response.Content)
		    TotalResults = Parsed.Value("totalResults")
		    TotalPages = Parsed.Value("pages")
		    Results = Parsed.Value("results")
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing page of results.")
		    Return
		  End Try
		  
		  Self.mTotalPages = TotalPages
		  Self.mTotalResults = TotalResults
		  
		  Var SelectedProjects() As String
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) Then
		      Var Project As BeaconAPI.Project = Self.List.RowTagAt(Idx)
		      SelectedProjects.Add(Project.ProjectId)
		    End If
		  Next
		  
		  For Each Member As Variant In Results
		    If Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Try
		      Var Project As New BeaconAPI.Project(Dictionary(Member.ObjectValue))
		      Self.List.AddRow("")
		      Var RowIdx As Integer = Self.List.LastAddedRowIndex
		      Self.List.CellTextAt(RowIdx, Self.ColumnName) = Project.Name
		      Self.List.CellTextAt(RowIdx, Self.ColumnMaps) = Ark.Maps.ForMask(Project.ArkMapMask).Label
		      Self.List.CellTextAt(RowIdx, Self.ColumnConsole) = If(Project.ConsoleSafe, "Yes", "")
		      Self.List.CellTextAt(RowIdx, Self.ColumnUpdated) = Project.LastUpdated(TimeZone.Current).ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium)
		      Self.List.CellTextAt(RowIdx, Self.ColumnRevision) = Project.Revision.ToString(Locale.Current, "#,##0")
		      Self.List.RowTagAt(RowIdx) = Project
		      Self.List.RowSelectedAt(RowIdx) = SelectedProjects.IndexOf(Project.ProjectId) > -1
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Adding result to list.")
		      Continue
		    End Try
		  Next
		  
		  Self.List.InvalidateScrollPosition
		  Self.UpdateStatusbar()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListVersions(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.mVersionProgressKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mVersionProgressKey)
		    Self.mVersionProgressKey = ""
		  End If
		  
		  If (Self.mVersionProgress Is Nil) = False Then
		    Var Cancel As Boolean = Self.mVersionProgress.CancelPressed
		    Self.mVersionProgress.Close
		    Self.mVersionProgress = Nil
		    If Cancel Then
		      Return
		    End If
		  End If
		  
		  If Response.Success = False Then
		    If Response.HTTPStatus = 0 Then
		      Self.ShowAlert("Could not list versions due to a connection error", Response.Message)
		      Return
		    End If
		    
		    If Response.Message.IsEmpty = False Then
		      Self.ShowAlert("Could not list versions", Response.Message)
		    Else
		      Self.ShowAlert("Could not list versions", "There was an HTTP " + Response.HTTPStatus.ToString(Locale.Current, "0") + " error.")
		    End If
		    Return
		  End If
		  
		  If Not Response.JSONParsed Then
		    Self.ShowAlert("Could not list versions", "The server replied with something that is not JSON.")
		    Return
		  End If
		  
		  Var Parsed As Variant = Response.JSON
		  Var Versions() As Dictionary
		  Try
		    Versions = Parsed.DictionaryArrayValue
		  Catch Err As RuntimeException
		    Self.ShowAlert("Could not find any older versions", "There are no older versions of this project available.")
		    Return
		  End Try
		  
		  DocumentVersionListWindow.Present(Self, Versions)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Load()
		  If Not Self.mHasBeenShown Then
		    Return
		  End If
		  
		  // This should trigger List.LoadMoreRows which will do the actual work.
		  Self.List.ScrollPosition = 0
		  Self.List.RemoveAllRows()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case IdentityManager.Notification_IdentityChanged, Preferences.Notification_OnlineStateChanged, Preferences.Notification_OnlineTokenChanged
		    Self.Load()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowVersionProgress()
		  Self.mVersionProgressKey = ""
		  
		  Var Progress As New ProgressWindow("Finding older versions…", "Just a moment…")
		  Progress.Show(Self)
		  Self.mVersionProgress = Progress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatusbar()
		  Var Status As String
		  If Self.List.SelectedRowCount > 0 Then
		    Status = Self.List.SelectedRowCount.ToString(Locale.Current, "0,##") + " of " + Language.NounWithQuantity(Self.mTotalResults, "project", "projects") + " selected"
		  Else
		    Status = Language.NounWithQuantity(Self.mTotalResults, "project", "projects")
		  End If
		  If Self.StatusbarLabel.Text <> Status Then
		    Self.StatusbarLabel.Text = Status
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Attributes( Deprecated = "URLForProject" ) Private Shared Function URLForDocument(Document As BeaconAPI.Project) As Beacon.ProjectURL
		  Return URLForProject(Document)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function URLForProject(Project As BeaconAPI.Project) As Beacon.ProjectURL
		  Return Project.URL(Beacon.ProjectURL.TypeCloud)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mHasBeenShown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjects() As BeaconAPI.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalPages As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalResults As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVersionProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVersionProgressKey As String
	#tag EndProperty


	#tag Constant, Name = ColumnConsole, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIcon, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnMaps, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRevision, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnUpdated, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageError, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageList, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLoading, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLogin, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PagePermission, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events APISocket
	#tag Event
		Sub WorkCompleted()
		  Self.Progress = BeaconSubview.ProgressNone
		End Sub
	#tag EndEvent
	#tag Event
		Sub WorkProgress(Request As BeaconAPI.Request, BytesReceived As Int64, BytesTotal As Int64)
		  #Pragma Unused Request
		  
		  Self.Progress = BytesReceived / BytesTotal
		End Sub
	#tag EndEvent
	#tag Event
		Sub WorkStarted()
		  Self.Progress = BeaconSubview.ProgressIndeterminate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterBar
	#tag Event
		Sub Changed()
		  Self.Load
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Mask = Ark.Maps.UniversalMask
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewProject()
		  Self.NewProject()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub PaintCellBackground(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  
		  If Column <> Self.ColumnIcon Or Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Var Project As BeaconAPI.Project = Me.RowTagAt(Row)
		  If Project Is Nil Then
		    Return
		  End If
		  
		  Var IconColor As Color = TextColor.AtOpacity(0.5)
		  Var Icon As Picture
		  If Project.IsGuest Then
		  Else
		    Icon = BeaconUI.IconWithColor(IconCloudDocument, IconColor)
		  End If
		  
		  If Icon Is Nil Then
		    Return
		  End If
		  
		  G.DrawPicture(Icon, (G.Width - Icon.Width) / 2, (G.Height - Icon.Height) / 2)
		End Sub
	#tag EndEvent
	#tag Event
		Function PaintCellText(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused G
		  #Pragma Unused Row
		  #Pragma Unused Line
		  #Pragma Unused TextColor
		  #Pragma Unused HorizontalPosition
		  #Pragma Unused VerticalPosition
		  #Pragma Unused IsHighlighted
		  
		  Return Column = Self.ColumnIcon
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case Self.ColumnUpdated
		    Var Row1Project As BeaconAPI.Project = Me.RowTagAt(Row1)
		    Var Row2Project As BeaconAPI.Project = Me.RowTagAt(Row2)
		    
		    If Row1Project.LastUpdated.SecondsFrom1970 > Row2Project.LastUpdated.SecondsFrom1970 Then
		      Result = 1
		    ElseIf Row1Project.LastUpdated.SecondsFrom1970 < Row2Project.LastUpdated.SecondsFrom1970 Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    
		    Return True
		  Case Self.ColumnRevision
		    Var Row1Project As BeaconAPI.Project = Me.RowTagAt(Row1)
		    Var Row2Project As BeaconAPI.Project = Me.RowTagAt(Row2)
		    
		    If Row1Project.Revision > Row2Project.Revision Then
		      Result = 1
		    ElseIf Row1Project.Revision < Row2Project.Revision Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var URLs() As Beacon.ProjectURL
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Row) = False Then
		      Continue
		    End If
		    
		    Var Project As BeaconAPI.Project = Me.RowTagAt(Row)
		    URLs.Add(Self.URLForProject(Project))
		  Next
		  
		  If URLs.Count = 0 Then
		    Return
		  End If
		  
		  If Warn Then
		    Var Names() As String
		    For Each URL As Beacon.ProjectURL In URLs
		      Names.Add(URL.Name)
		    Next
		    
		    If Self.ShowDeleteConfirmation(Names, "project", "projects") = False Then
		      Return
		    End If
		  End If
		  
		  Var ShouldRefresh As Boolean
		  For Each URL As Beacon.ProjectURL In URLs
		    If Self.CloseProject(URL) = False Then
		      Continue
		    End If
		    
		    Var Request As New BeaconAPI.Request(URL.URL(Beacon.ProjectURL.URLTypes.Writing), "DELETE", AddressOf APICallback_DeleteProject)
		    Self.APISocket.Start(Request)
		    ShouldRefresh = True
		  Next
		  
		  If ShouldRefresh Then
		    Self.Load()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Row) = False Then
		      Continue
		    End If
		    
		    Var Project As BeaconAPI.Project = Me.RowTagAt(Row)
		    Self.OpenProject(Self.URLForProject(Project))
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var VersionsItem As New DesktopMenuItem("Older Versions…", "versions")
		  VersionsItem.Enabled = Me.SelectedRowCount = 1 And (Preferences.BeaconAuth Is Nil) = False
		  Base.AddMenu(VersionsItem)
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(HitItem As DesktopMenuItem) As Boolean
		  If HitItem Is Nil Then
		    Return False
		  End If
		  
		  If HitItem.Tag.IsNull = False And HitItem.Tag.Type = Variant.TypeString And HitItem.Tag.StringValue = "versions" Then
		    If Me.SelectedRowCount = 1 Then
		      Var Project As BeaconAPI.Project = Me.RowTagAt(Me.SelectedRowIndex)
		      Var Request As New BeaconAPI.Request("projects/" + Project.ProjectId + "/versions", "GET", WeakAddressOf APICallback_ListVersions)
		      BeaconAPI.Send(Request)
		      
		      Self.mVersionProgressKey = CallLater.Schedule(2000, WeakAddressOf ShowVersionProgress)
		    End If
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub LoadMoreRows(Page As Integer)
		  If Self.mHasBeenShown = False Or (Page > 1 And Page > Self.mTotalPages) Then
		    Return
		  End If
		  
		  #if DebugBuild
		    Var LowerBound As Integer = ((Page - 1) * Me.PageSize) + 1
		    Var UpperBound As Integer = Page * Me.PageSize
		    System.DebugLog("Looking for user projects " + LowerBound.ToString + "-" + UpperBound.ToString + "…")
		  #endif
		  
		  Var Params As New Dictionary
		  Params.Value("page") = Page
		  Params.Value("pageSize") = Me.PageSize
		  Params.Value("gameId") = Self.FilterBar.GameId
		  If Self.FilterBar.Mask > CType(0, UInt64) Then
		    Params.Value("mask") = Self.FilterBar.Mask
		  End If
		  
		  Var Filter As String = Self.FilterBar.SearchText
		  If Filter.IsEmpty = False Then
		    Params.Value("search") = Filter
		  End If
		  
		  If Self.FilterBar.ConsoleSafe Then
		    Params.Value("consoleSafe") = True
		  End If
		  
		  If Self.FilterBar.RequireAllMaps Then
		    Params.Value("maskRequireAll") = True
		  End If
		  
		  Select Case Me.SortingColumn
		  Case Self.ColumnName
		    Params.Value("sort") = "name"
		  Case Self.ColumnMaps
		    Params.Value("sort") = "map"
		  Case Self.ColumnConsole
		    Params.Value("sort") = "consoleSafe"
		  Case Self.ColumnUpdated
		    Params.Value("sort") = "lastUpdate"
		  Case Self.ColumnRevision
		    Params.Value("sort") = "revision"
		  End Select
		  
		  If Me.ColumnSortDirectionAt(Me.SortingColumn) = DesktopListbox.SortDirections.Descending Then
		    Params.Value("direction") = "desc"
		  Else
		    Params.Value("direction") = "asc"
		  End If
		  
		  Var Request As New BeaconAPI.Request("/user/projects", "GET", Params, AddressOf APICallback_ListProjects)
		  Self.APISocket.Start(Request)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateStatusbar()
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
