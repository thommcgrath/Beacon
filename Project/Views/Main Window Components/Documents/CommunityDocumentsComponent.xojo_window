#tag Window
Begin DocumentsComponentView CommunityDocumentsComponent
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   True
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   520
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
   Width           =   776
   Begin DocumentFilterControl FilterBar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      ConsoleSafe     =   False
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
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
      ShowFullControls=   True
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   776
   End
   Begin FadedSeparator FadedSeparator1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   62
      Transparent     =   True
      Visible         =   True
      Width           =   776
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
      ColumnCount     =   5
      ColumnWidths    =   "2*,*,100,*,125"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DefaultSortColumn=   "#ColumnDownloads"
      DefaultSortDirection=   -1
      DropIndicatorVisible=   False
      EditCaption     =   "Open"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   457
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Map	Console Safe	Last Updated	Downloads"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   "Community Documents"
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
      Width           =   776
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BeaconAPI.Socket APISocket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
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
		Private Sub APICallback_ListDocuments(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Not Response.Success Then
		    Break
		    Return
		  End If
		  
		  Var Dicts() As Variant = Response.JSON
		  If Dicts.Count = 0 Then
		    Return
		  End If
		  
		  Var SelectedDocuments() As String
		  For I As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.Selected(I) Then
		      Var Document As BeaconAPI.Document = Self.List.RowTagAt(I)
		      SelectedDocuments.Add(Document.ResourceURL)
		    End If
		  Next
		  
		  For Each Dict As Dictionary In Dicts
		    Var Document As New BeaconAPI.Document(Dict)
		    
		    Self.List.AddRow("")
		    Var Idx As Integer = Self.List.LastAddedRowIndex
		    Self.List.CellValueAt(Idx, Self.ColumnName) = Document.Name
		    Self.List.CellValueAt(Idx, Self.ColumnMaps) = Ark.Maps.ForMask(Document.MapMask).Label
		    Self.List.CellValueAt(Idx, Self.ColumnConsole) = If(Document.ConsoleSafe, "Yes", "")
		    Self.List.CellValueAt(Idx, Self.ColumnUpdated) = Document.LastUpdated(TimeZone.Current).ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium)
		    Self.List.CellValueAt(Idx, Self.ColumnDownloads) = Document.DownloadCount.ToString(Locale.Raw, ",##0")
		    Self.List.RowTagAt(Idx) = Document
		    Self.List.Selected(Idx) = SelectedDocuments.IndexOf(Document.ResourceURL) > -1
		  Next
		  
		  Self.List.InvalidateScrollPosition
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


	#tag Property, Flags = &h21
		Private mHasBeenShown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoadedBound As Integer
	#tag EndProperty


	#tag Constant, Name = ColumnConsole, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnDownloads, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnMaps, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnUpdated, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events FilterBar
	#tag Event
		Sub Open()
		  Me.Mask = Ark.Maps.UniversalMask
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewDocument()
		  Self.NewDocument()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Changed()
		  Self.Load
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub LoadMoreRows(Offset As Integer, RowCount As Integer)
		  If Not Self.mHasBeenShown Then
		    Return
		  End If
		  
		  Var Bound As Integer = Offset + RowCount
		  If Bound > Self.mLoadedBound Then
		    
		  End If
		  Self.mLoadedBound = Bound
		  
		  #if DebugBuild
		    System.DebugLog("Looking for projects " + Offset.ToString + "-" + Bound.ToString + "…")
		  #endif
		  
		  Var Params As New Dictionary
		  Params.Value("offset") = Offset
		  Params.Value("count") = RowCount
		  If Self.FilterBar.Mask > CType(0, UInt64) Then
		    Params.Value("mask") = Self.FilterBar.Mask
		  End If
		  
		  Var Filter As String = Self.FilterBar.SearchText
		  If Filter.IsEmpty = False Then
		    Params.Value("search") = Filter
		  End If
		  
		  If Self.FilterBar.ConsoleSafe Then
		    Params.Value("console_only") = True
		  End If
		  
		  If Self.FilterBar.RequireAllMaps Then
		    Params.Value("mask_require_all") = True
		  End If
		  
		  Select Case Me.SortingColumn
		  Case Self.ColumnName
		    Params.Value("sort") = "name"
		  Case Self.ColumnMaps
		    Params.Value("sort") = "map"
		  Case Self.ColumnConsole
		    Params.Value("sort") = "console_safe"
		  Case Self.ColumnUpdated
		    Params.Value("sort") = "last_update"
		  Case Self.ColumnDownloads
		    Params.Value("sort") = "download_count"
		  End Select
		  
		  If Me.ColumnSortDirectionAt(Me.SortingColumn) = Listbox.SortDirections.Descending Then
		    Params.Value("direction") = "desc"
		  Else
		    Params.Value("direction") = "asc"
		  End If
		  
		  Var Request As New BeaconAPI.Request("document", "GET", Params, AddressOf APICallback_ListDocuments)
		  Self.APISocket.Start(Request)
		End Sub
	#tag EndEvent
	#tag Event
		Function SortColumn(column As Integer) As Boolean
		  #Pragma Unused Column
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function HeaderPressed(column as Integer) As Boolean
		  #Pragma Unused Column
		  
		  Self.Load()
		  
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Me.Selected(Row) = False Then
		      Continue
		    End If
		    
		    Var Document As BeaconAPI.Document = Me.RowTagAt(Row)
		    Self.OpenDocument(Document.ResourceURL)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
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
#tag ViewBehavior
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
		Type="Color"
		EditorType="Color"
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
		Name="EraseBackground"
		Visible=false
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
