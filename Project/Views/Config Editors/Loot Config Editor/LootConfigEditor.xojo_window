#tag Window
Begin ConfigEditor LootConfigEditor
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
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   702
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      BorderTop       =   False
      Caption         =   "Sources"
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Resizer         =   1
      ResizerEnabled  =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
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
      Height          =   374
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
      SelectionChangeBlocked=   False
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
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
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   451
      Begin LootSourceEditor Editor
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
   Begin FadedSeparator FadedSeparator2
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
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
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  Self.EnableEditorMenuItem("DocumentRebuildPresets")
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  #if false
		    Var AddLootSourceItem As New MenuItem("Add Loot Source…")
		    AddLootSourceItem.Name = "DocumentAddBeacon"
		    AddLootSourceItem.AutoEnabled = False
		    Items.Add(AddLootSourceItem)
		    
		    Var DuplicateLootSourceItem As New MenuItem("Duplicate Loot Source")
		    DuplicateLootSourceItem.Name = "DocumentDuplicateBeacon"
		    DuplicateLootSourceItem.AutoEnabled = False
		    Items.Add(DuplicateLootSourceItem)
		    
		    Var RemoveLootSourceItem As New MenuItem("Remove Loot Source")
		    RemoveLootSourceItem.Name = "DocumentRemoveBeacon"
		    RemoveLootSourceItem.AutoEnabled = False
		    Items.Add(RemoveLootSourceItem)
		    
		    Items.Add(New MenuItem(MenuItem.TextSeparator))
		    
		    Var AddItemSetItem As New MenuItem("Add Item Set")
		    AddItemSetItem.Name = "DocumentAddItemSet"
		    AddItemSetItem.AutoEnabled = False
		    Items.Add(AddItemSetItem)
		    
		    Var RemoveItemSetItem As New MenuItem("Remove Item Set")
		    RemoveItemSetItem.Name = "DocumentRemoveItemSet"
		    RemoveItemSetItem.AutoEnabled = False
		    Items.Add(RemoveItemSetItem)
		    
		    Items.Add(New MenuItem(MenuItem.TextSeparator))
		  #endif
		  
		  Var RebuildItem As New MenuItem("Rebuild Item Sets from Presets")
		  RebuildItem.Name = "DocumentRebuildPresets"
		  RebuildItem.AutoEnabled = False
		  Items.Add(RebuildItem)
		End Sub
	#tag EndEvent

	#tag Event
		Function ParsingFinished(Document As Beacon.Document) As Boolean
		  If Document Is Nil Or Document.HasConfigGroup(BeaconConfigs.LootDrops.ConfigName, Self.ConfigSetName) = False Then
		    Return False
		  End If
		  
		  Var OtherConfig As BeaconConfigs.LootDrops = BeaconConfigs.LootDrops(Document.ConfigGroup(BeaconConfigs.LootDrops.ConfigName, Self.ConfigSetName))
		  If OtherConfig Is Nil Then
		    Return False
		  End If
		  
		  Var Sources() As Beacon.LootSource = OtherConfig.DefinedSources
		  Var TotalNewSources As Integer = Sources.Count
		  If TotalNewSources = 0 Then
		    Return False
		  End If
		  
		  Var DuplicateSourceCount As Integer
		  Var Config As BeaconConfigs.LootDrops = Self.Config(True)
		  For Each Source As Beacon.LootSource In Sources
		    If Config.HasLootSource(Source) Then
		      DuplicateSourceCount = DuplicateSourceCount + 1
		    End If
		  Next
		  
		  Var Replace As Boolean = True
		  If DuplicateSourceCount > 0 Then
		    Replace = Self.ShowConfirm("Replace " + Language.NounWithQuantity(DuplicateSourceCount, "loot source", "loot sources") + "?", DuplicateSourceCount.ToString + " of " + Language.NounWithQuantity(TotalNewSources, " loot source has already been defined in this project. Would you like to replace it?", " loot sources are already defined in this project. Would you like to replace them?"), "Replace", "Cancel")
		  End If
		  
		  Var AddedSources() As Beacon.LootSource
		  For Each Source As Beacon.LootSource In OtherConfig
		    If Config.HasLootSource(Source) Then
		      If Replace Then
		        Config.Remove(Source)
		      Else
		        Continue
		      End If
		    End If
		    
		    AddedSources.Add(Source)
		    Config.Append(Source)
		  Next
		  
		  If AddedSources.LastIndex > -1 Then
		    Self.Changed = True
		    Self.UpdateSourceList(AddedSources)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  If Initial Then
		    Self.SetListWidth(Preferences.SourcesSplitterPosition, False)
		  Else
		    Self.SetListWidth(Self.Header.Width)
		  End If
		  
		  Self.Header.ResizerEnabled = Self.Width > Self.MinEditorWidth
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.LootDrops.ConfigName, Self.ConfigSetName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateSourceList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShowIssue(Issue As Beacon.Issue)
		  If Issue.UserData = Nil Then
		    Return
		  End If
		  
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Issue.UserData)
		  Select Case Info.FullName
		  Case "Beacon.LootContainer"
		    Var Source As Beacon.LootContainer = Issue.UserData
		    Call Self.GoToChild(Source)
		  Case "Dictionary"
		    Var Dict As Dictionary = Issue.UserData
		    Var Source As Beacon.LootSource
		    Var Set As Beacon.ItemSet
		    Var Entry As Beacon.SetEntry
		    Var Option As Beacon.SetEntryOption
		    If Dict.HasKey("LootSource") Then
		      Source = Dict.Value("LootSource")
		      If Dict.HasKey("ItemSet") Then
		        Set = Dict.Value("ItemSet")
		        If Dict.HasKey("Entry") Then
		          Entry = Dict.Value("Entry")
		          If Dict.HasKey("Option") Then
		            Option = Dict.Value("Option")
		          End If
		        End If
		      End If
		    End If
		    Call Self.GoToChild(Source, Set, Entry, Option)
		  Case "Beacon.ItemSet"
		    
		  Case "Beacon.SetEntry"
		    
		  Case "Beacon.SetEntryOption"
		    
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.UpdateSourceList()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DocumentAddBeacon() As Boolean Handles DocumentAddBeacon.Action
			Self.ShowAddLootSource()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentDuplicateBeacon() As Boolean Handles DocumentDuplicateBeacon.Action
			Self.ShowAddLootSource(True)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentRebuildPresets() As Boolean Handles DocumentRebuildPresets.Action
			Self.RebuildAllItemSets()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DocumentRemoveBeacon() As Boolean Handles DocumentRemoveBeacon.Action
			If Self.List.CanDelete Then
			Self.List.DoClear
			End If
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddLootSource(LootSource As Beacon.LootSource)
		  Var Arr(0) As Beacon.LootSource
		  Arr(0) = LootSource
		  Self.AddLootSources(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddLootSources(Sources() As Beacon.LootSource)
		  If Sources.LastIndex = -1 Then
		    Return
		  End If
		  
		  For Each Source As Beacon.LootSource In Sources
		    If Source.Experimental And Not Preferences.HasShownExperimentalWarning Then
		      If Self.ShowConfirm(Language.ExperimentalWarningMessage, Language.ReplacePlaceholders(Language.ExperimentalWarningExplanation, Source.Label), Language.ExperimentalWarningActionCaption, Language.ExperimentalWarningCancelCaption) Then
		        Preferences.HasShownExperimentalWarning = True
		        Exit
		      Else
		        Return
		      End If
		    End If
		  Next
		  
		  Var Config As BeaconConfigs.LootDrops = Self.Config(True)
		  For Each Source As Beacon.LootSource In Sources
		    If Config.HasLootSource(Source) Then
		      Config.Remove(Source)
		    End If
		    
		    Config.Append(Source)
		    Self.Changed = Self.Document.Modified
		  Next
		  
		  Self.UpdateSourceList(Sources)
		  Self.List.EnsureSelectionIsVisible()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.LootDrops
		  Static ConfigName As String = BeaconConfigs.LootDrops.ConfigName
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.LootDrops
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.LootDrops(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName, Self.ConfigSetName) Then
		    Config = BeaconConfigs.LootDrops(Document.ConfigGroup(ConfigName, Self.ConfigSetName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.LootDrops
		    Self.mConfigRef = New WeakRef(Config)
		  End If
		  
		  If ForWriting And Not Document.HasConfigGroup(ConfigName, Self.ConfigSetName) Then
		    Document.AddConfigGroup(Config, Self.ConfigSetName)
		  End If
		  
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return Language.LabelForConfig(BeaconConfigs.LootDrops.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GoToChild(Source As Beacon.LootSource, ItemSet As Beacon.ItemSet = Nil, Entry As Beacon.SetEntry = Nil, Option As Beacon.SetEntryOption = Nil) As Boolean
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.RowTagAt(I) = Source Then
		      Self.List.SelectedRowIndex = I
		      Self.List.EnsureSelectionIsVisible()
		      If ItemSet <> Nil Then
		        Return Self.Editor.GoToChild(ItemSet, Entry, Option)
		      Else
		        Return True
		      End If
		    End If
		  Next
		  Self.List.SelectedRowIndex = -1
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MinEditorWidth() As Integer
		  Return ListMinWidth + LootSourceEditor.MinEditorWidth + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildAllItemSets()
		  Var NumChanges As Integer = Self.Config(True).ReconfigurePresets(Self.Document.MapCompatibility, Self.Document.Mods)
		  If NumChanges = 0 Then
		    Self.ShowAlert("No item sets changed", "All item sets are already configured according to their presets.")
		    Return
		  End If
		  
		  Self.UpdateSourceList()
		  Self.Changed = Self.Changed Or Self.Document.Modified
		  
		  If NumChanges = 1 Then
		    Self.ShowAlert("1 item set changed", "Rebuilding changed 1 item set to match its preset.")
		  Else
		    Self.ShowAlert(NumChanges.ToString(Locale.Current, ",##0") + " item sets changed", "Rebuilding changed " + NumChanges.ToString(Locale.Current, ",##0") + " item sets to match their presets.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer, Remember As Boolean = True)
		  Var ListWidth, EditorWidth As Integer
		  If Self.Width <= Self.MinEditorWidth Then
		    ListWidth = Self.ListMinWidth
		    EditorWidth = LootSourceEditor.MinEditorWidth
		  Else
		    Var AvailableSpace As Integer = Self.Width - Self.FadedSeparator1.Width
		    ListWidth = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - LootSourceEditor.MinEditorWidth)
		    EditorWidth = AvailableSpace - ListWidth
		  End If
		  
		  Self.Header.Width = ListWidth
		  Self.FadedSeparator1.Left = ListWidth
		  Self.List.Width = ListWidth
		  Self.FadedSeparator2.Width = ListWidth
		  Self.StatusBar1.Width = ListWidth
		  Self.Panel.Left = Self.FadedSeparator1.Left + Self.FadedSeparator1.Width
		  Self.Panel.Width = EditorWidth
		  
		  If Remember Then
		    Preferences.SourcesSplitterPosition = ListWidth
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddLootSource(DuplicateSelected As Boolean = False)
		  If DuplicateSelected And Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.LootDrops = Self.Config(False)
		  Var CurrentSources() As Beacon.LootSource = Config.DefinedSources
		  Var Map As New Dictionary
		  For Each Source As Beacon.LootSource In CurrentSources
		    Map.Value(Source.ClassString) = True
		  Next
		  
		  Var DuplicateSource As Beacon.LootSource
		  If DuplicateSelected Then
		    DuplicateSource = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  End If
		  
		  If LootSourceWizard.Present(Self, Config, Self.Document.MapCompatibility, Self.Document.Mods, DuplicateSource, DuplicateSelected) Then
		    Call Self.Config(True) // Actually saves the config to the document 
		    CurrentSources = Config.DefinedSources
		    Var NewSources() As Beacon.LootSource
		    For Each Source As Beacon.LootSource In CurrentSources
		      If Not Map.HasKey(Source.ClassString) Then
		        NewSources.Add(Source)
		      End If
		    Next
		    Self.UpdateSourceList(NewSources)
		    Self.Focus = Self.List
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSourceList(SelectedSources() As Beacon.LootSource = Nil)
		  Var Labels As Dictionary = LocalData.SharedInstance.LootSourceLabels(Self.Document.MapCompatibility)
		  
		  Var VisibleSources() As Beacon.LootSource = Self.Config(False).DefinedSources
		  Beacon.Sort(VisibleSources)
		  
		  Var SelectedClasses() As String
		  If SelectedSources <> Nil Then
		    For Each Source As Beacon.LootSource In SelectedSources
		      SelectedClasses.Add(Source.ClassString)
		    Next
		  Else
		    Var Bound As Integer = Self.List.RowCount - 1
		    For I As Integer = 0 To Bound
		      If Self.List.Selected(I) Then
		        SelectedClasses.Add(Beacon.LootSource(Self.List.RowTagAt(I)).ClassString)
		      End If
		    Next
		  End If
		  
		  Self.List.RowCount = VisibleSources.LastIndex + 1
		  
		  Self.mBlockSelectionChanged = True
		  Var Selection() As Beacon.LootSource
		  For I As Integer = 0 To VisibleSources.LastIndex
		    Self.List.RowTagAt(I) = VisibleSources(I)
		    Self.List.CellValueAt(I, 0) = "" // Causes a redraw of the cell
		    Self.List.CellValueAt(I, 1) = Labels.Lookup(VisibleSources(I).Path, VisibleSources(I).Label)
		    If SelectedClasses.IndexOf(VisibleSources(I).ClassString) > -1 Then
		      Self.List.Selected(I) = True
		      Selection.Add(VisibleSources(I))
		    Else
		      Self.List.Selected(I) = False
		    End If
		  Next
		  Self.mBlockSelectionChanged = False
		  
		  Editor.Sources = Selection
		  If Selection.LastIndex = -1 Then
		    Panel.SelectedPanelIndex = 0
		  Else
		    Panel.SelectedPanelIndex = 1
		  End If
		  
		  Self.Header.Rebuild.Enabled = VisibleSources.LastIndex > -1
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Var TotalCount As Integer = Self.List.RowCount
		  Var SelectedCount As Integer = Self.List.SelectedRowCount
		  
		  Var Caption As String = TotalCount.ToString(Locale.Current, ",##0") + " " + If(TotalCount = 1, "Loot Source", "Loot Sources")
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

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.beacon", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"225", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub Open()
		  Var AddButton As New BeaconToolbarItem("AddSource", IconToolbarAdd)
		  AddButton.HasMenu = True
		  AddButton.HelpTag = "Define an additional loot source. Hold to quickly add a source from a menu."
		  
		  Var DuplicateButton As New BeaconToolbarItem("Duplicate", IconToolbarClone, False)
		  DuplicateButton.HelpTag = "Duplicate the selected loot source."
		  
		  Var RebuildButton As New BeaconToolbarItem("Rebuild", IconToolbarRebuild, Self.Config(False).LastRowIndex > -1)
		  RebuildButton.HelpTag = "Rebuild all item sets using their presets."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.LeftItems.Append(DuplicateButton)
		  Me.RightItems.Append(RebuildButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  Self.SetListWidth(NewSize)
		  NewSize = Me.Width
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddSource"
		    Self.ShowAddLootSource()
		  Case "Duplicate"
		    Self.ShowAddLootSource(True)
		  Case "Rebuild"
		    Self.RebuildAllItemSets()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub BuildMenu(Item As BeaconToolbarItem, Menu As MenuItem)
		  Select Case Item.Name
		  Case "AddSource"
		    Var Data As LocalData = LocalData.SharedInstance
		    Var Labels As Dictionary = Data.LootSourceLabels(Self.Document.MapCompatibility)
		    Var LootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("", Self.Document.Mods, Preferences.ShowExperimentalLootSources)
		    Var HasExperimentalSources As Boolean = LocalData.SharedInstance.HasExperimentalLootSources(Self.Document.Mods)
		    Var Config As BeaconConfigs.LootDrops = Self.Config(False)
		    Var Mask As UInt64 = Self.Document.MapCompatibility
		    If Config <> Nil Then
		      For I As Integer = LootSources.LastIndex DownTo 0
		        Var Source As Beacon.LootSource = LootSources(I)
		        If Config.HasLootSource(Source) Or Source.ValidForMask(Mask) = False Then
		          LootSources.RemoveAt(I)
		          Continue For I
		        End If
		      Next
		    End If
		    
		    If LootSources.LastIndex = -1 Then
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
		    
		    Beacon.Sort(LootSources)
		    
		    For Each LootSource As Beacon.LootSource In LootSources
		      Menu.AddMenu(New MenuItem(Labels.Lookup(LootSource.Path, LootSource.Label), LootSource))
		    Next
		    
		    If HasExperimentalSources Then
		      Menu.AddMenu(New MenuItem(MenuItem.TextSeparator))
		      
		      Var ExpItem As New MenuItem("Show Experimental Sources", "toggle_experimental")
		      ExpItem.HasCheckMark = Preferences.ShowExperimentalLootSources
		      Menu.AddMenu(ExpItem)
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub HandleMenuAction(Item As BeaconToolbarItem, ChosenItem As MenuItem)
		  Select Case Item.Name
		  Case "AddSource"
		    If ChosenItem = Nil Then
		      Return
		    End If
		    
		    Var Tag As Variant = ChosenItem.Tag
		    If Tag = Nil Then
		      Return
		    End If
		    
		    If Tag.Type = Variant.TypeString Then
		      Select Case Tag.StringValue
		      Case "toggle_experimental"
		        Preferences.ShowExperimentalLootSources = Not Preferences.ShowExperimentalLootSources
		        Self.UpdateSourceList()
		      End Select
		    ElseIf Tag.Type = Variant.TypeObject And Tag.ObjectValue IsA Beacon.LootSource Then
		      Var Source As Beacon.LootSource = ChosenItem.Tag
		      Self.AddLootSource(Source)
		      Self.Focus = Self.List
		    End If
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
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
		    Var Source As Beacon.LootSource = Me.RowTagAt(Row)
		    Var Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, BackgroundColor)
		    
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
		  
		  Var Sources() As Beacon.LootSource
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(I) = False Then
		      Continue
		    End If
		    
		    Sources.Add(Self.List.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Sources, "loot source", "loot sources") = False Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.LootDrops = Self.Config(True)
		  For Each Source As Beacon.LootSource In Sources
		    Config.Remove(Source)
		  Next
		  
		  Self.Changed = Self.Document.Modified
		  Self.UpdateSourceList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  If Me.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var Dicts() As Dictionary
		  Var Configs() As Beacon.ConfigValue
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Var Source As Beacon.LootSource = Me.RowTagAt(I)
		      Dicts.Add(Source.SaveData)
		      BeaconConfigs.LootDrops.BuildOverrides(Source, Configs, Self.Document.Difficulty)
		    End If
		  Next
		  
		  Var Lines() As String
		  For Each Config As Beacon.ConfigValue In Configs
		    Lines.Add(Config.Key + "=" + Config.Value)
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
		    
		    Var Sources() As Beacon.LootSource
		    For Each Dict As Dictionary In Dicts
		      Var Source As Beacon.LootSource = Beacon.LoadLootSourceSaveData(Dict)
		      If (Source Is Nil) = False Then
		        Sources.Add(Source)
		      End If
		    Next
		    Self.AddLootSources(Sources)
		  ElseIf Board.TextAvailable And Board.Text.IndexOf("ConfigOverrideSupplyCrateItems") > -1 Then
		    Self.Parse(Board.Text, "Clipboard")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Header.Duplicate.Enabled = Me.SelectedRowCount = 1
		  
		  If Self.mBlockSelectionChanged Then
		    Return
		  End If
		  
		  Var Sources() As Beacon.LootSource
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Sources.Add(Me.RowTagAt(I))
		    End If
		  Next
		  
		  Editor.Sources = Sources
		  If Sources.LastIndex = -1 Then
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
		    
		    Var Config As BeaconConfigs.LootDrops = Self.Config(False)
		    If LootSourceWizard.Present(Self, Config, Self.Document.MapCompatibility, Self.Document.Mods, Me.RowTagAt(I)) Then
		      Call Self.Config(True) // Actually saves the config to the document
		      Self.UpdateSourceList()
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
		  Self.Changed = Self.Document.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Sub PresentLootSourceEditor(Source As Beacon.LootSource)
		  Var Config As BeaconConfigs.LootDrops = Self.Config(False)
		  If LootSourceWizard.Present(Self, Config, Self.Document.MapCompatibility, Self.Document.Mods, Source) Then
		    Call Self.Config(True) // Actually saves the config to the document
		    Self.UpdateSourceList()
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDocument() As Beacon.Document
		  Return Self.Document
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
