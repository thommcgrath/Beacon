#tag Window
Begin ArkConfigEditor ArkLootDropsEditor
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
   Height          =   436
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
   Width           =   702
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   436
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   250
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin BeaconListbox List
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "50,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   34
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      EditCaption     =   "Edit"
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   333
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   82
      Transparent     =   True
      TypeaheadColumn =   1
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   250
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   436
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   451
      Begin ArkLootDropEditor Editor
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   436
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   251
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   451
      End
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "No Selection"
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   415
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   251
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   451
      End
      Begin StatusBar NoSelectionStatusBar
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Borders         =   1
         Caption         =   ""
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   21
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   251
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   415
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   451
      End
   End
   Begin StatusBar StatusBar1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Borders         =   1
      Caption         =   ""
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   21
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   415
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
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
      LockRight       =   False
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
   Begin DelayedSearchField FilterField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Drops"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   9
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumRecentItems=   -1
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   50
      Transparent     =   False
      Visible         =   True
      Width           =   232
   End
   Begin OmniBarSeparator FilterSeparator
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
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   81
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function ParsingFinished(Project As Ark.Project) As Boolean
		  If Project Is Nil Or Project.HasConfigGroup(Ark.Configs.NameLootDrops) = False Then
		    Return False
		  End If
		  
		  Var OtherConfig As Ark.Configs.LootDrops = Ark.Configs.LootDrops(Project.ConfigGroup(Ark.Configs.NameLootDrops))
		  If OtherConfig Is Nil Then
		    Return False
		  End If
		  
		  Var Containers() As Ark.LootContainer = OtherConfig.Containers
		  Var TotalNewContainers As Integer = Containers.Count
		  If TotalNewContainers = 0 Then
		    Return False
		  End If
		  
		  Var DuplicateContainerCount As Integer
		  Var Config As Ark.Configs.LootDrops = Self.Config(True)
		  For Each Container As Ark.LootContainer In Containers
		    If Config.HasContainer(Container) Then
		      DuplicateContainerCount = DuplicateContainerCount + 1
		    End If
		  Next
		  
		  Var Replace As Boolean = True
		  If DuplicateContainerCount > 0 Then
		    Replace = Self.ShowConfirm("Replace " + Language.NounWithQuantity(DuplicateContainerCount, "loot drop", "loot drops") + "?", DuplicateContainerCount.ToString + " of " + Language.NounWithQuantity(TotalNewContainers, " loot drop has already been defined in this project. Would you like to replace it?", " loot drops are already defined in this project. Would you like to replace them?"), "Replace", "Cancel")
		  End If
		  
		  Var AddedContainers() As Ark.LootContainer
		  For Each Container As Ark.LootContainer In OtherConfig
		    If Config.HasContainer(Container) Then
		      If Replace Then
		        Config.Remove(Container)
		      Else
		        Continue
		      End If
		    End If
		    
		    AddedContainers.Add(Container)
		    Config.Add(Container)
		  Next
		  
		  If AddedContainers.LastIndex > -1 Then
		    Self.Changed = True
		    Self.UpdateContainerList(AddedContainers)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  If Initial Then
		    Self.SetListWidth(Preferences.SourcesSplitterPosition, False)
		  Else
		    Self.SetListWidth(Self.ConfigToolbar.Width)
		  End If
		  
		  Var Resizer As OmniBarItem = Self.ConfigToolbar.Item("Resizer")
		  If (Resizer Is Nil) = False Then
		    Resizer.Enabled = Self.Width > Self.MinEditorWidth
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RunTool(Tool As Ark.ProjectTool)
		  Select Case Tool.UUID
		  Case "08efc49c-f39f-4147-820d-201637c206b5"
		    Self.RebuildAllItemSets()
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateContainerList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShowIssue(Issue As Beacon.Issue)
		  Var LocationParts() As String = Issue.Location.Split(".")
		  // ConfigSet is 0, ConfigName is 1
		  Var DropClass As String = LocationParts(2)
		  Var ItemSetUUID, EntryUUID, EngramClass As String
		  If LocationParts.LastIndex > 2 Then
		    ItemSetUUID = LocationParts(3)
		  End If
		  If LocationParts.LastIndex > 3 Then
		    EntryUUID = LocationParts(4)
		  End If
		  If LocationParts.LastIndex > 4 Then
		    EngramClass = LocationParts(5)
		  End If
		  
		  Call Self.GoToChild(DropClass, ItemSetUUID, EntryUUID, EngramClass)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddLootContainer(Container As Ark.LootContainer)
		  Var Arr(0) As Ark.LootContainer
		  Arr(0) = Container
		  Self.AddLootContainers(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddLootContainers(Containers() As Ark.LootContainer)
		  If Containers.LastIndex = -1 Then
		    Return
		  End If
		  
		  For Each Container As Ark.LootContainer In Containers
		    If Container.Experimental And Not Preferences.HasShownExperimentalWarning Then
		      If Self.ShowConfirm(Language.ExperimentalWarningMessage, Language.ReplacePlaceholders(Language.ExperimentalWarningExplanation, Container.Label), Language.ExperimentalWarningActionCaption, Language.ExperimentalWarningCancelCaption) Then
		        Preferences.HasShownExperimentalWarning = True
		        Exit
		      Else
		        Return
		      End If
		    End If
		  Next
		  
		  Var Config As Ark.Configs.LootDrops = Self.Config(True)
		  For Each Container As Ark.LootContainer In Containers
		    If Config.HasContainer(Container) Then
		      Config.Remove(Container)
		    End If
		    
		    Config.Add(Container)
		    Self.Changed = Self.Project.Modified
		  Next
		  
		  Self.UpdateContainerList(Containers)
		  Self.List.EnsureSelectionIsVisible()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildQuickDropMenu(Menu As MenuItem)
		  Var Data As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var Containers() As Ark.LootContainer = Data.GetLootContainers("", Self.Project.ContentPacks, "", Preferences.ShowExperimentalLootSources)
		  Var HasExperimentalContainers As Boolean = Data.HasExperimentalLootContainers(Self.Project.ContentPacks)
		  Var Config As Ark.Configs.LootDrops = Self.Config(False)
		  Var Mask As UInt64 = Self.Project.MapMask
		  If Config <> Nil Then
		    For I As Integer = Containers.LastIndex DownTo 0
		      Var Container As Ark.LootContainer = Containers(I)
		      If Config.HasContainer(Container) Or Container.ValidForMask(Mask) = False Then
		        Containers.RemoveAt(I)
		        Continue For I
		      End If
		    Next
		  End If
		  
		  Var Labels As Dictionary = Config.Containers.Disambiguate(Self.Project.MapMask)
		  
		  If Containers.LastIndex = -1 Then
		    Var Warning As MenuItem
		    If Mask = CType(0, UInt64) Then
		      Warning = New MenuItem("List is empty because no maps have been selected.")
		    Else
		      Warning = New MenuItem("List is empty because all drops have been implemented.")
		    End If
		    Warning.Enabled = False
		    Menu.AddMenu(Warning)
		    Return
		  End If
		  
		  Containers.Sort
		  
		  For Each Container As Ark.LootContainer In Containers
		    Menu.AddMenu(New MenuItem(Labels.Lookup(Container.ObjectID, Container.Label), Container))
		  Next
		  
		  If HasExperimentalContainers Then
		    Menu.AddMenu(New MenuItem(MenuItem.TextSeparator))
		    
		    Var ExpItem As New MenuItem("Show Experimental Containers", "toggle_experimental")
		    ExpItem.HasCheckMark = Preferences.ShowExperimentalLootSources
		    Menu.AddMenu(ExpItem)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As Ark.Configs.LootDrops
		  Return Ark.Configs.LootDrops(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GoToChild(DropClass As String, ItemSetUUID As String = "", EntryUUID As String = "", EngramClass As String = "") As Boolean
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Var Container As Ark.LootContainer = Self.List.RowTagAt(Idx)
		    If Container Is Nil Or Container.ClassString <> DropClass Then
		      Continue
		    End If
		    
		    Self.List.SelectedRowIndex = Idx
		    Self.List.EnsureSelectionIsVisible()
		    
		    If ItemSetUUID.IsEmpty = False Then
		      Return Self.Editor.GoToChild(ItemSetUUID, EntryUUID, EngramClass)
		    Else
		      Return True
		    End If
		  Next Idx
		  
		  Self.List.SelectedRowIndex = -1
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleQuickDropMenu(ChosenItem As MenuItem)
		  Var Tag As Variant = ChosenItem.Tag
		  If Tag.IsNull Then
		    Return
		  End If
		  
		  If Tag.Type = Variant.TypeString Then
		    Select Case Tag.StringValue
		    Case "toggle_experimental"
		      Preferences.ShowExperimentalLootSources = Not Preferences.ShowExperimentalLootSources
		      Self.UpdateContainerList()
		    End Select
		  ElseIf Tag.Type = Variant.TypeObject And Tag.ObjectValue IsA Ark.LootContainer Then
		    Var Container As Ark.LootContainer = ChosenItem.Tag
		    Self.AddLootContainer(Container)
		    Self.Focus = Self.List
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameLootDrops
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MinEditorWidth() As Integer
		  Return ListMinWidth + ArkLootDropEditor.MinEditorWidth + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildAllItemSets()
		  Var NumChanges As Integer = Self.Config(True).RebuildItemSets(Self.Project.MapMask, Self.Project.ContentPacks)
		  If NumChanges = 0 Then
		    Self.ShowAlert("No item sets changed", "All item sets are already configured according to their templates.")
		    Return
		  End If
		  
		  Self.UpdateContainerList()
		  Self.Changed = Self.Changed Or Self.Project.Modified
		  
		  If NumChanges = 1 Then
		    Self.ShowAlert("1 item set changed", "Rebuilding changed 1 item set to match its template.")
		  Else
		    Self.ShowAlert(NumChanges.ToString(Locale.Current, ",##0") + " item sets changed", "Rebuilding changed " + NumChanges.ToString(Locale.Current, ",##0") + " item sets to match their templates.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer, Remember As Boolean = True)
		  Var ListWidth, EditorWidth As Integer
		  If Self.Width <= Self.MinEditorWidth Then
		    ListWidth = Self.ListMinWidth
		    EditorWidth = ArkLootDropEditor.MinEditorWidth
		  Else
		    Var AvailableSpace As Integer = Self.Width - Self.FadedSeparator1.Width
		    ListWidth = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - ArkLootDropEditor.MinEditorWidth)
		    EditorWidth = AvailableSpace - ListWidth
		  End If
		  
		  Self.ConfigToolbar.Width = ListWidth
		  Self.FadedSeparator1.Left = ListWidth
		  Self.List.Width = ListWidth
		  Self.StatusBar1.Width = ListWidth
		  Self.FilterSeparator.Width = ListWidth
		  Self.FilterField.Width = ListWidth - (Self.FilterField.Left * 2)
		  Self.Panel.Left = Self.FadedSeparator1.Left + Self.FadedSeparator1.Width
		  Self.Panel.Width = EditorWidth
		  
		  If Remember Then
		    Preferences.SourcesSplitterPosition = ListWidth
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddLootContainer(DuplicateSelected As Boolean = False)
		  If DuplicateSelected And Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Config As Ark.Configs.LootDrops = Self.Config(False)
		  Var CurrentContainers() As Ark.LootContainer = Config.Containers
		  Var Map As New Dictionary
		  For Each Container As Ark.LootContainer In CurrentContainers
		    Map.Value(Container.ClassString) = True
		  Next
		  
		  Var DuplicateContainer As Ark.LootContainer
		  If DuplicateSelected Then
		    DuplicateContainer = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  End If
		  
		  If ArkAddLootDropDialog.Present(Self, Config, Self.Project.MapMask, Self.Project.ContentPacks, DuplicateContainer, DuplicateSelected) Then
		    Call Self.Config(True) // Actually saves the config to the document 
		    CurrentContainers = Config.Containers
		    Var NewContainers() As Ark.LootContainer
		    For Each Container As Ark.LootContainer In CurrentContainers
		      If Not Map.HasKey(Container.ClassString) Then
		        NewContainers.Add(Container)
		      End If
		    Next
		    Self.UpdateContainerList(NewContainers)
		    Self.Changed = Self.Project.Modified
		    Self.Focus = Self.List
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateContainerList(SelectedContainers() As Ark.LootContainer = Nil)
		  Var VisibleContainers() As Ark.LootContainer = Self.Config(False).Containers(Self.FilterField.Text)
		  Var Labels As Dictionary = VisibleContainers.Disambiguate(Self.Project.MapMask)
		  VisibleContainers.Sort
		  
		  Var SelectedClasses() As String
		  If SelectedContainers <> Nil Then
		    For Each Container As Ark.LootContainer In SelectedContainers
		      SelectedClasses.Add(Container.ClassString)
		    Next
		  Else
		    Var Bound As Integer = Self.List.RowCount - 1
		    For I As Integer = 0 To Bound
		      If Self.List.Selected(I) Then
		        SelectedClasses.Add(Ark.LootContainer(Self.List.RowTagAt(I)).ClassString)
		      End If
		    Next
		  End If
		  
		  Self.List.RowCount = VisibleContainers.LastIndex + 1
		  
		  Self.mBlockSelectionChanged = True
		  Var Selection() As Ark.LootContainer
		  For I As Integer = 0 To VisibleContainers.LastIndex
		    Self.List.RowTagAt(I) = VisibleContainers(I)
		    Self.List.CellValueAt(I, 0) = "" // Causes a redraw of the cell
		    Self.List.CellValueAt(I, 1) = Labels.Lookup(VisibleContainers(I).ObjectID, VisibleContainers(I).Label)
		    If SelectedClasses.IndexOf(VisibleContainers(I).ClassString) > -1 Then
		      Self.List.Selected(I) = True
		      Selection.Add(VisibleContainers(I))
		    Else
		      Self.List.Selected(I) = False
		    End If
		  Next
		  Self.mBlockSelectionChanged = False
		  
		  Editor.Containers = Selection
		  If Selection.LastIndex = -1 Then
		    Panel.SelectedPanelIndex = 0
		  Else
		    Panel.SelectedPanelIndex = 1
		  End If
		  
		  Var RebuildButton As OmniBarItem = Self.ConfigToolbar.Item("RebuildButton")
		  If (RebuildButton Is Nil) = False Then
		    RebuildButton.Enabled = VisibleContainers.LastIndex > -1
		  End If
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Var TotalCount As Integer = Self.List.RowCount
		  Var SelectedCount As Integer = Self.List.SelectedRowCount
		  
		  Var Caption As String = TotalCount.ToString(Locale.Current, ",##0") + " " + If(TotalCount = 1, "Loot Drop", "Loot Drops")
		  If SelectedCount > 0 Then
		    Caption = SelectedCount.ToString(Locale.Current, ",##0") + " of " + Caption + " Selected"
		  End If
		  Self.StatusBar1.Caption = Caption
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlockSelectionChanged As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty


	#tag Constant, Name = HelpExplanation, Type = String, Dynamic = False, Default = \"Fill This In", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.loot.drop", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ListDefaultWidth, Type = Double, Dynamic = False, Default = \"345", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  #Pragma Unused TextColor
		  
		  If Row >= Me.RowCount Then
		    Return
		  End If
		  
		  If Column = 0 Then
		    Var Container As Ark.LootContainer = Me.RowTagAt(Row)
		    Var Icon As Picture
		    If Me.Selected(Row) And IsHighlighted Then
		      Icon = Ark.DataSource.Pool.Get(False).GetLootContainerIcon(Container, TextColor, BackgroundColor)
		    Else
		      Icon = Ark.DataSource.Pool.Get(False).GetLootContainerIcon(Container, BackgroundColor)
		    End If
		    
		    G.DrawPicture(Icon, NearestMultiple((G.Width - Icon.Width) / 2, G.ScaleX), NearestMultiple((G.Height - Icon.Height) / 2, G.ScaleY))
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("ConfigOverrideSupplyCrateItems") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Self.List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var Containers() As Ark.LootContainer
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(I) = False Then
		      Continue
		    End If
		    
		    Containers.Add(Self.List.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Containers, "loot drop", "loot drops") = False Then
		    Return
		  End If
		  
		  Var Config As Ark.Configs.LootDrops = Self.Config(True)
		  For Each Container As Ark.LootContainer In Containers
		    Config.Remove(Container)
		  Next
		  
		  Self.Changed = Self.Project.Modified
		  Self.UpdateContainerList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  If Me.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var Dicts() As Dictionary
		  Var Configs() As Ark.ConfigValue
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Var Container As Ark.LootContainer = Me.RowTagAt(I)
		      Dicts.Add(Container.SaveData)
		      Ark.Configs.LootDrops.BuildOverrides(Container, Configs, Self.Project.Difficulty.DifficultyValue)
		    End If
		  Next
		  
		  Var Lines() As String
		  For Each Config As Ark.ConfigValue In Configs
		    Lines.Add(Config.Command)
		  Next
		  
		  Var RawData As String
		  If Dicts.LastIndex = 0 Then
		    RawData = Beacon.GenerateJSON(Dicts(0), False)
		  Else
		    RawData = Beacon.GenerateJSON(Dicts, False)
		  End If
		  
		  Board.RawData(Self.kClipboardType) = RawData
		  Board.Text = Lines.Join(Encodings.UTF8.Chr(10))
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Var Contents As String = DefineEncoding(Board.RawData(Self.kClipboardType), Encodings.UTF8)
		    Var Parsed As Variant
		    Try
		      Parsed = Beacon.ParseJSON(Contents)
		    Catch Err As RuntimeException
		      System.Beep
		      Return
		    End Try
		    
		    Var Info As Introspection.TypeInfo = Introspection.GetType(Parsed)
		    Var Dicts() As Dictionary
		    If Info.FullName = "Dictionary" Then
		      Dicts.Add(Parsed)
		    ElseIf Info.FullName = "Object()" Then
		      Var Values() As Variant = Parsed
		      For Each Dict As Dictionary In Values
		        Dicts.Add(Dict)
		      Next
		    Else
		      System.Beep
		      Return
		    End If
		    
		    Var Containers() As Ark.LootContainer
		    For Each Dict As Dictionary In Dicts
		      Var Container As Ark.LootContainer = Ark.LootContainer.FromSaveData(Dict)
		      If (Container Is Nil) = False Then
		        Containers.Add(Container)
		      End If
		    Next
		    Self.AddLootContainers(Containers)
		  ElseIf Board.TextAvailable And Board.Text.IndexOf("ConfigOverrideSupplyCrateItems") > -1 Then
		    Self.Parse("", Board.Text, "Clipboard")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Var DuplicateButton As OmniBarItem = Self.ConfigToolbar.Item("DuplicateButton")
		  If (DuplicateButton Is Nil) = False Then
		    DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  End If
		  
		  If Self.mBlockSelectionChanged Then
		    Return
		  End If
		  
		  Var Containers() As Ark.LootContainer
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Containers.Add(Me.RowTagAt(I))
		    End If
		  Next
		  
		  Editor.Containers = Containers
		  If Containers.LastIndex = -1 Then
		    Panel.SelectedPanelIndex = 0
		  Else
		    Panel.SelectedPanelIndex = 1
		  End If
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Config As Ark.Configs.LootDrops = Self.Config(False)
		    If ArkAddLootDropDialog.Present(Self, Config, Self.Project.MapMask, Self.Project.ContentPacks, Me.RowTagAt(I)) Then
		      Call Self.Config(True) // Actually saves the config to the document
		      Self.UpdateContainerList()
		      Self.Changed = True
		    End If
		    
		    Return
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.TypeaheadColumn = 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub Updated()
		  Var Config As Ark.Configs.LootDrops = Self.Config(True)
		  Var Containers() As Ark.LootContainer = Me.Containers
		  Var Map As New Dictionary
		  For Each Container As Ark.LootContainer In Containers
		    Config.Add(Container)
		    Map.Value(Container.ClassString) = Container
		  Next Container
		  For RowIdx As Integer = 0 To Self.List.LastRowIndex
		    Var Container As Ark.LootContainer = Self.List.RowTagAt(RowIdx)
		    If Map.HasKey(Container.ClassString) = False Then
		      Continue For RowIdx
		    End If
		    
		    Self.List.RowTagAt(RowIdx) = Map.Value(Container.ClassString)
		  Next RowIdx
		  
		  Self.Changed = Self.Config(False).Modified
		End Sub
	#tag EndEvent
	#tag Event
		Function GetProject() As Ark.Project
		  Return Self.Project
		End Function
	#tag EndEvent
	#tag Event
		Sub PresentDropEditor(Container As Ark.LootContainer)
		  Var Config As Ark.Configs.LootDrops = Self.Config(False)
		  If ArkAddLootDropDialog.Present(Self, Config, Self.Project.MapMask, Self.Project.ContentPacks, Container) Then
		    Call Self.Config(True) // Actually saves the config to the document
		    Self.UpdateContainerList()
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTitle("Title", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator("TitleSeparator"))
		  Me.Append(OmniBarItem.CreateButton("AddContainerButton", "New Drop", IconToolbarAddMenu, "Define an additional loot drop override. Hold to quickly add a container from a menu."))
		  Me.Append(OmniBarItem.CreateButton("DuplicateButton", "Duplicate", IconToolbarClone, "Duplicate the selected loot drop.", False))
		  Me.Append(OmniBarItem.CreateButton("RebuildButton", "Rebuild", IconToolbarRebuild, "Rebuild all item sets using their templates.", False))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateHorizontalResizer("Resizer"))
		  
		  Me.Item("Title").Priority = 5
		  Me.Item("TitleSeparator").Priority = 5
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddContainerButton"
		    Self.ShowAddLootContainer()
		  Case "DuplicateButton"
		    Self.ShowAddLootContainer(True)
		  Case "RebuildButton"
		    Self.RebuildAllItemSets()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Resize(DraggedResizer As OmniBarItem, DeltaX As Integer, DeltaY As Integer)
		  #Pragma Unused DraggedResizer
		  #Pragma Unused DeltaY
		  
		  Var NewWidth As Integer = Me.Width + DeltaX
		  Self.SetListWidth(NewWidth)
		End Sub
	#tag EndEvent
	#tag Event
		Function ItemHeld(Item As OmniBarItem, ItemRect As Rect) As Boolean
		  Select Case Item.Name
		  Case "AddContainerButton"
		    Var Base As New MenuItem
		    Self.BuildQuickDropMenu(Base)
		    
		    Var Position As Point = Me.Window.GlobalPosition
		    Var Choice As MenuItem = Base.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		    If (Choice Is Nil) = False Then
		      Call Self.HandleQuickDropMenu(Choice)
		    End If
		    Return True
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.UpdateContainerList()
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
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
#tag EndViewBehavior
