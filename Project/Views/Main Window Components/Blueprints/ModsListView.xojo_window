#tag Window
Begin BeaconSubview ModsListView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   300
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
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      DefaultSortColumn=   0
      DefaultSortDirection=   1
      DropIndicatorVisible=   False
      EditCaption     =   "Edit Blueprints"
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
      SelectionChangeBlocked=   False
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
      ContentHeight   =   0
      DoubleBuffer    =   False
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
End
#tag EndWindow

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
		  
		  If Self.ModsList = Nil Then
		    // This view already closed
		    Return
		  End If
		  
		  Self.FinishJob()
		  
		  Var SelectedModID As String
		  If Self.ModsList.SelectedRowIndex > -1 Then
		    SelectedModID = BeaconAPI.WorkshopMod(Self.ModsList.RowTagAt(Self.ModsList.SelectedRowIndex)).ModID
		  End If
		  
		  Self.ModsList.RemoveAllRows
		  
		  If Response.Success Then
		    Var Arr() As Variant = Response.JSON
		    For Each Dict As Dictionary In Arr
		      Var ModInfo As New BeaconAPI.WorkshopMod(Dict)
		      Self.ModsList.AddRow(ModInfo.Name, If(ModInfo.Confirmed, "Confirmed", "Waiting Confirmation"))
		      Self.ModsList.RowTagAt(Self.ModsList.LastRowIndex) = ModInfo
		      If SelectedModID = ModInfo.ModID Then
		        Self.ModsList.SelectedRowIndex = Self.ModsList.LastRowIndex
		      End If
		    Next
		  End If
		  
		  Self.ModsList.AddRowAt(0, Beacon.UserModName)
		  Self.ModsList.CellValueAt(0, 1) = "Built-In"
		  Self.ModsList.RowTagAt(0) = BeaconAPI.WorkshopMod.UserBlueprintsMod
		  If SelectedModID = Beacon.UserModID Then
		    Self.ModsList.SelectedRowIndex = 0
		  End If
		  Self.ModsList.Sort
		  
		  If Self.ModsList.RowCount = 1 And Self.mDidFirstRefresh = False Then
		    Var Idx As Integer = Self.ModsList.SelectedRowIndex
		    Self.ModsList.SelectedRowIndex = 0
		    Self.ModsList.DoEdit
		    Self.ModsList.SelectedRowIndex = Idx
		  End If
		  Self.mDidFirstRefresh = True
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
		  
		  Var Request As New BeaconAPI.Request("mod", "GET", AddressOf APICallback_ListMods)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
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

	#tag Method, Flags = &h0
		Function ViewID() As String
		  Return "ModsListView"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Working() As Boolean
		  Return Self.mJobCount > 0
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShowMod(ModInfo As BeaconAPI.WorkshopMod)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDidFirstRefresh As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJobCount As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events ModsList
	#tag Event
		Function CanDelete() As Boolean
		  If Me.SelectedRowCount = 1 And BeaconAPI.WorkshopMod(Me.RowTagAt(Me.SelectedRowIndex)).ModID = Beacon.UserModID Then
		    Return False
		  Else
		    Return Me.SelectedRowIndex > 0
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
		  Var WorkshopIDs() As String
		  If Warn Then
		    Var Names() As String
		    For Row As Integer = 0 To Me.LastRowIndex
		      Var ModInfo As BeaconAPI.WorkshopMod = Me.RowTagAt(Row)
		      If Me.Selected(Row) And ModInfo.ModID <> Beacon.UserModID Then
		        Names.Add(ModInfo.Name)
		        WorkshopIDs.Add(ModInfo.WorkshopID.ToString(Locale.Raw, "0"))
		      End If
		    Next
		    
		    If Not Self.ShowDeleteConfirmation(Names, "mod", "mods") Then
		      Return
		    End If
		  End If
		  
		  Self.StartJob()
		  
		  Var Body As String = WorkshopIDs.Join(",")
		  Var Request As New BeaconAPI.Request("/mod", "DELETE", Body, "text/plain", AddressOf APICallback_DeleteMods)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var ModInfo As BeaconAPI.WorkshopMod = Me.RowTagAt(Me.SelectedRowIndex)
		  RaiseEvent ShowMod(ModInfo)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  If (Self.ModsToolbar.Item("EditModBlueprints") Is Nil) = False Then
		    Self.ModsToolbar.Item("EditModBlueprints").Enabled = Me.SelectedRowCount = 1
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateButton("RegisterMod", "Register Mod", IconToolbarAdd, "Register your mod with Beacon."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditModBlueprints", "Edit Blueprints", IconToolbarEdit, "Edit the blueprints provided by the selected mod.", Self.ModsList.SelectedRowCount = 1))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "RegisterMod"
		    Var Status As Integer =  RegisterModDialog.Present(Self)
		    If (Status And RegisterModDialog.FlagShouldRefresh) = RegisterModDialog.FlagShouldRefresh Then
		      Self.RefreshMods()
		    End If
		  Case "EditModBlueprints"
		    Self.ModsList.DoEdit()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
