#tag DesktopWindow
Begin BeaconSubview ModsListView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   300
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
   Width           =   494
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
      ColumnCount     =   2
      ColumnWidths    =   "*,200"
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
      Height          =   259
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Status"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
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
      Width           =   494
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
      Width           =   494
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
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.RefreshMods()
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

	#tag Method, Flags = &h21
		Private Sub APICallback_ListMods(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.ModsList Is Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  Self.FinishJob()
		  
		  Var SelectedModID As String
		  Var ScrollPosition As Integer = -1
		  If Self.ModsList.SelectedRowIndex > -1 Then
		    SelectedModID = BeaconAPI.WorkshopMod(Self.ModsList.RowTagAt(Self.ModsList.SelectedRowIndex)).ModID
		    ScrollPosition = Self.ModsList.ScrollPosition
		  End If
		  
		  Self.ModsList.RemoveAllRows
		  
		  If Response.Success Then
		    Var Arr() As Variant = Response.JSON
		    For Each Dict As Dictionary In Arr
		      Var ModInfo As New BeaconAPI.WorkshopMod(Dict)
		      Self.ModsList.AddRow(ModInfo.Name, If(ModInfo.Confirmed, "Confirmed", "Waiting Confirmation"))
		      Self.ModsList.RowTagAt(Self.ModsList.LastAddedRowIndex) = ModInfo
		      If SelectedModID = ModInfo.ModID Then
		        Self.ModsList.SelectedRowIndex = Self.ModsList.LastAddedRowIndex
		      End If
		    Next
		  End If
		  
		  Var Packs() As Ark.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks(Ark.ContentPack.Types.Custom)
		  For Each Pack As Ark.ContentPack In Packs
		    Self.ModsList.AddRow(Pack.Name, "Custom")
		    Var Idx As Integer = Self.ModsList.LastAddedRowIndex
		    Self.ModsList.RowTagAt(Idx) = New BeaconAPI.WorkshopMod(Pack)
		    If SelectedModID = Pack.UUID Then
		      Self.ModsList.SelectedRowIndex = Idx
		    End If
		  Next
		  Self.ModsList.Sort
		  
		  If ScrollPosition > -1 Then
		    Self.ModsList.ScrollPosition = ScrollPosition
		  End If
		  Self.ModsList.EnsureSelectionIsVisible
		  
		  If Self.mOpenModWhenRefreshed.IsEmpty = False Then
		    For Idx As Integer = 0 To Self.ModsList.LastRowIndex
		      If BeaconAPI.WorkshopMod(Self.ModsList.RowTagAt(Idx)).ModID = Self.mOpenModWhenRefreshed Then
		        Self.ModsList.SelectedRowIndex = Idx
		        Self.ModsList.DoEdit
		        Exit For Idx
		      End If
		    Next Idx
		    Self.mOpenModWhenRefreshed = ""
		  Else
		    If Self.ModsList.RowCount = 1 And Self.mDidFirstRefresh = False Then
		      Var Idx As Integer = Self.ModsList.SelectedRowIndex
		      Self.ModsList.SelectedRowIndex = 0
		      Self.ModsList.DoEdit
		      Self.ModsList.SelectedRowIndex = Idx
		    End If
		  End If
		  Self.mDidFirstRefresh = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.ViewID = "ModsListView"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DiscoveryCheckMod(WorkshopID As String) As Boolean
		  Return RaiseEvent CloseModView(WorkshopID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DiscoveryCompleted(DiscoveredMods() As Ark.ContentPack)
		  #Pragma Unused DiscoveredMods
		  Self.RefreshMods()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishJob()
		  Self.mJobCount = Self.mJobCount - 1
		  If Self.mJobCount > 0 Then
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Else
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshMods()
		  If Preferences.OnlineEnabled = False Then
		    Var FakeResponse As New BeaconAPI.Response("", 0, New MemoryBlock(0), New Dictionary)
		    Self.APICallback_ListMods(Nil, FakeResponse)
		    Return
		  End If
		  
		  If Self.Working Then
		    Return
		  End If
		  
		  Self.StartJob()
		  
		  Var Request As New BeaconAPI.Request("ark/mod", "GET", AddressOf APICallback_ListMods)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
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

	#tag Method, Flags = &h21
		Private Sub StartJob()
		  Self.mJobCount = Self.mJobCount + 1
		  If Self.mJobCount > 0 Then
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Else
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Working() As Boolean
		  Return Self.mJobCount > 0
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CloseModView(ModUUID As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShowMod(ModInfo As BeaconAPI.WorkshopMod)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDidFirstRefresh As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDiscoveryDialog As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJobCount As Integer
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
		  If Me.SelectedRowCount = 1 And BeaconAPI.WorkshopMod(Me.RowTagAt(Me.SelectedRowIndex)).ModID = Ark.UserContentPackUUID Then
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
		  Var Mods() As BeaconAPI.WorkshopMod
		  If Warn Then
		    Var Names() As String
		    For Row As Integer = 0 To Me.LastRowIndex
		      Var ModInfo As BeaconAPI.WorkshopMod = Me.RowTagAt(Row)
		      If Me.RowSelectedAt(Row) And ModInfo.ModID <> Ark.UserContentPackUUID Then
		        Names.Add(ModInfo.Name)
		        Mods.Add(ModInfo)
		      End If
		    Next
		    
		    If Not Self.ShowDeleteConfirmation(Names, "mod", "mods") Then
		      Return
		    End If
		  End If
		  
		  // Make sure they do not have unsaved changes
		  Var WorkshopIDs() As String
		  For Idx As Integer = Mods.LastIndex DownTo 0
		    If Not CloseModView(Mods(Idx).ModID) Then
		      Mods.RemoveAt(Idx)
		    Else
		      If Mods(Idx).IsLocalMod Then
		        Self.mModUUIDsToDelete.Add(Mods(Idx).ModID)
		      ElseIf (Mods(Idx).WorkshopID Is Nil) = False Then
		        WorkshopIDs.Add(Mods(Idx).WorkshopID)
		      End If
		    End If
		  Next Idx
		  
		  If Self.mModUUIDsToDelete.Count > 0 And Self.ModDeleterThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.ModDeleterThread.Start
		  End If
		  
		  If WorkshopIDs.Count > 0 Then
		    Self.StartJob()
		    
		    Var Body As String = WorkshopIDs.Join(",")
		    Var Request As New BeaconAPI.Request("ark/mod", "DELETE", Body, "text/plain", AddressOf APICallback_DeleteMods)
		    Request.Authenticate(Preferences.OnlineToken)
		    BeaconAPI.Send(Request)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var ModInfo As BeaconAPI.WorkshopMod = Me.RowTagAt(Me.SelectedRowIndex)
		  RaiseEvent ShowMod(ModInfo)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  If (Self.ModsToolbar.Item("EditModBlueprints") Is Nil) = False Then
		    Self.ModsToolbar.Item("EditModBlueprints").Enabled = Me.SelectedRowCount = 1
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("RegisterMod", "Register Mod", IconToolbarAdd, "Register your mod with Beacon."))
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
		    Var ModUUID As String =  RegisterModDialog.Present(Self)
		    If ModUUID.IsEmpty = False Then
		      Self.mOpenModWhenRefreshed = ModUUID
		      Self.RefreshMods()
		    End If
		  Case "EditModBlueprints"
		    Self.ModsList.DoEdit()
		  Case "DiscoverMods"
		    Self.RunModDiscovery()
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
		        If BeaconAPI.WorkshopMod(Self.ModsList.RowTagAt(Row)).ModID = ModUUID Then
		          Self.ModsList.RemoveRowAt(Row)
		          Exit For Row
		        End If
		      Next
		    End Select
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
