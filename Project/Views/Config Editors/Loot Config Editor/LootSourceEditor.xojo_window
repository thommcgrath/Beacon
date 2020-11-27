#tag Window
Begin BeaconContainer LootSourceEditor Implements AnimationKit.ValueAnimator
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   464
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
   Width           =   598
   Begin BeaconListbox SetList
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      EditCaption     =   "Edit"
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   0
      Height          =   120
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   140
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   250
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      BorderTop       =   False
      Caption         =   "Item Sets"
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
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   464
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
      Value           =   "0"
      Visible         =   True
      Width           =   347
      Begin ItemSetEditor Editor
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   False
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   464
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
         Width           =   347
      End
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "No Selection"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   443
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
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   347
      End
      Begin StatusBar NoSelectionStatusBar
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Borders         =   1
         Caption         =   ""
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
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   443
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   347
      End
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   464
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
   Begin SimulatorView Simulator
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   183
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   281
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   250
   End
   Begin FadedSeparator FadedSeparator3
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
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
   Begin LootSourceSettingsContainer SettingsContainer
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   23
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   41
      Transparent     =   True
      UseFocusRing    =   False
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
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   260
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
   Begin LootSourceHintsContainer HintsContainer
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   76
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Notes           =   ""
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   64
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   250
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  If Initial Then
		    Self.Simulator.Height = Preferences.SimulatorSize
		    If Self.SimulatorVisible Then
		      Self.SimulatorPosition = Self.Height - Self.Simulator.Height
		    Else
		      Self.SimulatorPosition = Self.Height
		    End If
		    
		    Self.SetListWidth(Preferences.ItemSetsSplitterPosition, False)
		  Else
		    Self.SetListWidth(Self.Header.Width)
		  End If
		  
		  Self.mSavePositions = True
		  Self.Header.ResizerEnabled = Self.Width > Self.MinEditorWidth
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DocumentRemoveItemSet() As Boolean Handles DocumentRemoveItemSet.Action
			Self.SetList.DoClear
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Function ActiveMask() As UInt64
		  Var CombinedMask As UInt64
		  For Each Source As Beacon.LootSource In Self.mSources
		    CombinedMask = CombinedMask Or Source.Availability
		  Next
		  Return CombinedMask And Self.Document.MapCompatibility
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddSet(ParamArray Sets() As Beacon.ItemSet)
		  Self.AddSets(Sets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddSets(Sets() As Beacon.ItemSet)
		  For Each Source As Beacon.LootSource In Self.mSources
		    For Each NewSet As Beacon.ItemSet In Sets
		      Call Source.ItemSets.Append(New Beacon.ItemSet(NewSet))
		    Next
		  Next
		  
		  Self.UpdateUI(Sets)
		  RaiseEvent Updated
		  
		  Self.Editor.ShowSettings(True)
		  Self.Editor.SetFocus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AnimationStep(Identifier As String, Value As Double)
		  // Part of the AnimationKit.ValueAnimator interface.
		  
		  Select Case Identifier
		  Case "simulator position"
		    Self.SimulatorPosition = Round(Value)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildPresetMenu(Parent As MenuItem)
		  Var Presets() As Beacon.Preset = Beacon.Data.Presets
		  Var Groups As New Dictionary
		  Var GroupNames() As String
		  For Each Preset As Beacon.Preset In Presets
		    Var Arr() As Beacon.Preset
		    If Groups.HasKey(Preset.Grouping) Then
		      Arr = Groups.Value(Preset.Grouping)
		    End If
		    Arr.Add(Preset)
		    Groups.Value(Preset.Grouping) = Arr
		    
		    If GroupNames.IndexOf(Preset.Grouping) = -1 Then
		      GroupNames.Add(Preset.Grouping)
		    End If
		  Next
		  GroupNames.Sort
		  
		  For I As Integer = Parent.Count - 1 DownTo 0
		    Parent.RemoveMenuAt(I)
		  Next
		  
		  Var EmptySetItem As New MenuItem("New Empty Set", Nil)
		  AddHandler EmptySetItem.Action, WeakAddressOf Self.HandlePresetMenu
		  Parent.AddMenu(EmptySetItem)
		  
		  Var HasTarget As Boolean = Self.mSources.LastIndex > -1
		  
		  For Each Group As String In GroupNames
		    Var Arr() As Beacon.Preset = Groups.Value(Group)
		    Var Names() As String
		    Var Items() As Beacon.Preset
		    For Each Preset As Beacon.Preset In Arr
		      If Preset.ValidForMask(Self.Document.MapCompatibility) Then
		        Names.Add(Preset.Label)
		        Items.Add(Preset)
		      End If
		    Next
		    If Names.LastIndex = -1 Then
		      Continue For Group
		    End If
		    
		    Names.SortWith(Items)
		    
		    Parent.AddMenu(New MenuItem(MenuItem.TextSeparator))
		    
		    Var Header As New MenuItem(Group)
		    Header.Enabled = False
		    Parent.AddMenu(Header)
		    
		    For Each Preset As Beacon.Preset In Items
		      Var PresetItem As New MenuItem(Preset.Label, Preset)
		      PresetItem.Enabled = HasTarget
		      AddHandler PresetItem.Action, WeakAddressOf Self.HandlePresetMenu
		      Parent.AddMenu(PresetItem)
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CancelImport()
		  If Self.mImporter <> Nil Then
		    Self.mImporter.Stop
		  End If
		  
		  If Self.mImportProgress <> Nil Then
		    Self.mImportProgress.Close
		    Self.mImportProgress = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Document() As Beacon.Document
		  Return RaiseEvent GetDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GoToChild(ItemSet As Beacon.ItemSet, Entry As Beacon.SetEntry = Nil, Option As Beacon.SetEntryOption = Nil) As Boolean
		  For I As Integer = 0 To Self.SetList.RowCount - 1
		    If ItemSetOrganizer(Self.SetList.RowTagAt(I)).Template = ItemSet Then
		      Self.SetList.SelectedRowIndex = I
		      Self.SetList.EnsureSelectionIsVisible()
		      If Entry <> Nil Then
		        Return Self.Editor.GoToChild(Entry, Option)
		      Else
		        Return True
		      End If
		    End If
		  Next
		  Self.SetList.SelectedRowIndex = -1
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandlePresetMenu(Sender As MenuItem) As Boolean
		  Var SelectedPreset As Beacon.Preset = Sender.Tag
		  
		  Var Mask As UInt64 = Self.Document.MapCompatibility
		  Var Mods As Beacon.StringList = Self.Document.Mods
		  Var NewItemSets() As Beacon.ItemSet
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    Var Set As Beacon.ItemSet
		    If SelectedPreset <> Nil Then
		      Set = Beacon.ItemSet.FromPreset(SelectedPreset, Source, Mask, Mods)
		    End If
		    If Set = Nil Then
		      Set = New Beacon.ItemSet()
		    End If
		    
		    NewItemSets.Add(Source.ItemSets.Append(Set))
		  Next
		  
		  Self.UpdateUI(NewItemSets)
		  RaiseEvent Updated
		  
		  Self.Editor.ShowSettings(True)
		  Self.Editor.SetFocus()
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String, Source As String)
		  Self.mImportProgress = New ImporterWindow
		  Self.mImportProgress.Source = Source
		  Self.mImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.mImportProgress.ShowWithin(Self.TrueWindow)
		  
		  Var Data As New Beacon.DiscoveredData
		  Data.GameIniContent = Content
		  
		  Self.mImporter = New Beacon.ImportThread(Data, Self.Document)
		  AddHandler mImporter.Finished, WeakAddressOf mImporter_Finished
		  AddHandler mImporter.UpdateUI, WeakAddressOf mImporter_UpdateUI
		  Self.mImporter.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImporter_Finished(Sender As Beacon.ImportThread, Document As Beacon.Document)
		  #Pragma Unused Sender
		  
		  If Self.mImportProgress <> Nil Then
		    Self.mImportProgress.Close
		    Self.mImportProgress = Nil
		  End If
		  
		  If Not Document.HasConfigGroup(BeaconConfigs.LootDrops.ConfigName) Then
		    Return
		  End If
		  
		  Var Drops As BeaconConfigs.LootDrops = BeaconConfigs.LootDrops(Document.ConfigGroup(BeaconConfigs.LootDrops.ConfigName))
		  Var NewItemSets() As Beacon.ItemSet
		  For Each SourceDrop As Beacon.LootSource In Drops
		    For Each ItemSet As Beacon.ItemSet In SourceDrop.ItemSets
		      NewItemSets.Add(ItemSet)
		    Next
		  Next
		  Self.AddSets(NewItemSets)
		  
		  #if false
		    Var Dicts() As Variant
		    #Pragma BreakOnExceptions Off
		    Try
		      Dicts = ParsedData.Value("ConfigOverrideSupplyCrateItems")
		    Catch Err As TypeMismatchException
		      Dicts.Add(ParsedData.Value("ConfigOverrideSupplyCrateItems"))
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    Var Difficulty As BeaconConfigs.Difficulty = Self.Document.Difficulty
		    
		    Var SourceLootSources() As Beacon.LootSource
		    For Each ConfigDict As Dictionary In Dicts
		      Var Source As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(ConfigDict, Difficulty)
		      If Source <> Nil Then
		        SourceLootSources.Add(Source)
		      End If
		    Next
		    
		    Var NewItemSets() As Beacon.ItemSet
		    For Each Source As Beacon.LootSource In SourceLootSources
		      For Each Set As Beacon.ItemSet In Source
		        NewItemSets.Add(Set)
		      Next
		    Next
		    Self.AddSets(NewItemSets)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImporter_UpdateUI(Sender As Beacon.ImportThread)
		  If Self.mImportProgress <> Nil Then
		    Self.mImportProgress.Progress = Sender.Progress
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MinEditorWidth() As Integer
		  Return ListMinWidth + ItemSetEditor.MinEditorWidth + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MinSimulatorPosition() As Integer
		  Return Self.SettingsContainer.Top + Self.SettingsContainer.Height + Self.HintsContainer.Height + 200
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer, Remember As Boolean = True)
		  #Pragma Unused Remember
		  
		  Var ListWidth, EditorWidth As Integer
		  If Self.Width <= Self.MinEditorWidth Then
		    ListWidth = Self.ListMinWidth
		    EditorWidth = ItemSetEditor.MinEditorWidth
		  Else
		    Var AvailableSpace As Integer = Self.Width - Self.FadedSeparator1.Width
		    ListWidth = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - ItemSetEditor.MinEditorWidth)
		    EditorWidth = AvailableSpace - ListWidth
		  End If
		  
		  Self.Header.Width = ListWidth
		  Self.HintsContainer.Width = ListWidth
		  Self.FadedSeparator1.Left = ListWidth
		  Self.SetList.Width = ListWidth
		  Self.Simulator.Width = ListWidth
		  Self.SettingsContainer.Width = ListWidth
		  Self.FadedSeparator3.Width = ListWidth
		  Self.StatusBar1.Width = ListWidth
		  Self.Panel.Left = Self.FadedSeparator1.Left + Self.FadedSeparator1.Width
		  Self.Panel.Width = EditorWidth
		  
		  If Self.mSavePositions Then
		    Preferences.ItemSetsSplitterPosition = ListWidth
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SimulatorPosition() As Integer
		  Return Self.Simulator.Top
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SimulatorPosition(Assigns Pos As Integer)
		  // This does not save the position in preferences, it is only for coordinating
		  // the size and position of controls
		  
		  Pos = Max(Pos, Self.MinSimulatorPosition)
		  
		  Self.Simulator.Top = Pos
		  Self.StatusBar1.Top = Pos - Self.StatusBar1.Height
		  Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SimulatorVisible() As Boolean
		  Return Preferences.SimulatorVisible
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SimulatorVisible(Animated As Boolean = True, Assigns Value As Boolean)
		  If Value = Self.SimulatorVisible Then
		    Return
		  End If
		  
		  Preferences.SimulatorVisible = Value
		  
		  Var NewPosition As Integer
		  If Value Then
		    NewPosition = Self.Height - Preferences.SimulatorSize
		    Self.Simulator.Height = Preferences.SimulatorSize
		  Else
		    NewPosition = Self.Height
		  End If
		  NewPosition = Max(NewPosition, Self.MinSimulatorPosition)
		  
		  If Not Animated Then
		    Self.SimulatorPosition = NewPosition
		    Return
		  End If
		  
		  Var Curve As AnimationKit.Curve = AnimationKit.Curve.CreateEaseOut
		  Var Duration As Double = 0.15
		  
		  If Self.mSimulatorTask <> Nil Then
		    Self.mSimulatorTask.Cancel
		    Self.mSimulatorTask = Nil
		  End If
		  
		  Self.mSimulatorTask = New AnimationKit.ValueTask(Self, "simulator position", Self.SimulatorPosition, NewPosition)
		  Self.mSimulatorTask.DurationInSeconds = Duration
		  Self.mSimulatorTask.Curve = Curve
		  Self.mSimulatorTask.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sources() As Beacon.LootSource()
		  // Clone the array, but not the items
		  Var Results() As Beacon.LootSource
		  For Each Source As Beacon.LootSource In Self.mSources
		    Results.Add(Source)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sources(Assigns Values() As Beacon.LootSource)
		  If Values = Nil Then
		    Self.mSources.ResizeTo(-1)
		  Else
		    Self.mSources.ResizeTo(Values.LastIndex)
		    For I As Integer = 0 To Values.LastIndex
		      Self.mSources(I) = Values(I)
		    Next
		  End If
		  
		  Var CommonNotes As String
		  If Self.mSources.LastIndex > -1 Then
		    CommonNotes = Self.mSources(0).Notes
		    For I As Integer = 1 To Self.mSources.LastIndex
		      If Self.mSources(I).Notes <> CommonNotes Then
		        CommonNotes = ""
		        Exit For I
		      End If
		    Next
		  End If
		  If CommonNotes = "" And Self.HintsContainer.Visible Then
		    Self.HintsContainer.Visible = False
		    Self.SetList.Top = Self.SettingsContainer.Top + Self.SettingsContainer.Height
		    Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		  ElseIf CommonNotes <> "" And Not Self.HintsContainer.Visible Then
		    Self.HintsContainer.Visible = True
		    Self.HintsContainer.Top = Self.SettingsContainer.Top + Self.SettingsContainer.Height
		    Self.SetList.Top = Self.HintsContainer.Top + Self.HintsContainer.Height
		    Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		  End If
		  Self.HintsContainer.Notes = CommonNotes
		  
		  Self.SettingsContainer.LootSources = Values
		  
		  Self.UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Caption As String
		  If Self.SetList.SelectedRowCount > 0 Then
		    Caption = Self.SetList.SelectedRowCount.ToString(Locale.Current, ",##0") + " of " + Self.SetList.RowCount.ToString(Locale.Current, ",##0") + " Item " + If(Self.SetList.RowCount = 1, "Set", "Sets") + " Selected"
		  Else
		    Caption = Self.SetList.RowCount.ToString(Locale.Current, ",##0") + " Item " + If(Self.SetList.RowCount = 1, "Set", "Sets")
		  End If
		  
		  Self.StatusBar1.Caption = Caption
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.UpdateUI(Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI(SelectSets() As Beacon.ItemSet)
		  Self.SetList.SelectionChangeBlocked = True
		  
		  Var CombinedSets As New Dictionary
		  For Each Source As Beacon.LootSource In Self.mSources
		    For Each Set As Beacon.ItemSet In Source.ItemSets
		      Var Hash As String = Set.Hash
		      Var Organizer As ItemSetOrganizer
		      If CombinedSets.HasKey(Hash) Then
		        Organizer = CombinedSets.Value(Hash)
		      Else
		        Organizer = New ItemSetOrganizer(Set)
		        CombinedSets.Value(Hash) = Organizer
		      End If
		      Organizer.Attach(Source, Set)
		    Next
		  Next
		  
		  If CombinedSets <> Nil And CombinedSets.KeyCount > 0 Then
		    Var SelectedSets() As String
		    If SelectSets = Nil Then
		      For I As Integer = 0 To Self.SetList.RowCount - 1
		        If Self.SetList.Selected(I) Then
		          SelectedSets.Add(ItemSetOrganizer(Self.SetList.RowTagAt(I)).Template.ID)
		        End If
		      Next
		    Else
		      For Each Set As Beacon.ItemSet In SelectSets
		        SelectedSets.Add(Set.Hash)
		      Next
		    End If
		    
		    Var ExtendedLabels As Boolean = Self.mSources.LastIndex > 0
		    
		    Self.SetList.RowCount = CombinedSets.KeyCount
		    Self.SetList.DefaultRowHeight = If(ExtendedLabels, 34, 26)
		    For RowIndex As Integer = 0 To CombinedSets.KeyCount - 1
		      Var Hash As String = CombinedSets.Key(RowIndex)
		      Var Organizer As ItemSetOrganizer = CombinedSets.Value(Hash)
		      
		      Self.SetList.CellValueAt(RowIndex, 0) = Organizer.Label(ExtendedLabels)
		      Self.SetList.RowTagAt(RowIndex) = Organizer
		      Self.SetList.Selected(RowIndex) = Organizer.Matches(SelectedSets)
		    Next
		  Else
		    Self.SetList.RowCount = 0
		  End If
		  
		  Self.UpdateStatus
		  
		  Self.SetList.SortingColumn = 0
		  Self.SetList.Sort
		  Self.SetList.SelectionChangeBlocked = False
		  
		  If Self.mSources.LastIndex = 0 Then
		    Self.Header.Simulate.Enabled = True
		    Self.Simulator.Simulate(Self.mSources(0))
		  Else
		    Self.Header.Simulate.Enabled = False
		    Self.Simulator.Clear()
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetDocument() As Beacon.Document
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PresentLootSourceEditor(Source As Beacon.LootSource)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Updated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mImporter As Beacon.ImportThread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportProgress As ImporterWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSavePositions As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSimulatorTask As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSorting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSources() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalSetCount As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVisibleSetCount As UInteger
	#tag EndProperty


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.itemset", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"225", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events SetList
	#tag Event
		Sub Change()
		  If Self.mSorting = True Then
		    Return
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Editor.Set = ItemSetOrganizer(Me.RowTagAt(Me.SelectedRowIndex)).Template
		    Editor.Enabled = True
		    Panel.SelectedPanelIndex = 1
		  Else
		    Editor.Enabled = False
		    Editor.Set = Nil
		    Panel.SelectedPanelIndex = 0
		  End If
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Board.Text.Left(1) = "(")
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Organizers() As ItemSetOrganizer
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Organizers.Add(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Organizers, "item set", "item sets") = False Then
		    Return
		  End If
		  
		  For Each Organizer As ItemSetOrganizer In Organizers
		    Var Sources() As Beacon.LootSource = Organizer.Sources
		    For Each Source As Beacon.LootSource In Sources
		      Var Set As Beacon.ItemSet = Organizer.SetForSource(Source)
		      Source.ItemSets.Remove(Set)
		    Next
		  Next
		  
		  RaiseEvent Updated
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Organizer As ItemSetOrganizer = Me.RowTagAt(I)
		    Var Dict As Dictionary = Organizer.Template.SaveData
		    If Dict <> Nil Then
		      Dicts.Add(Dict)
		    End If
		  Next
		  If Dicts.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Contents As String
		  If Dicts.LastIndex = 0 Then
		    Contents = Beacon.GenerateJSON(Dicts(0), False)
		  Else
		    Contents = Beacon.GenerateJSON(Dicts, False)
		  End If
		  
		  Board.RawData(Self.kClipboardType) = Contents
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Self.mSources.LastIndex = -1 Then
		    Return
		  End If
		  
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
		    
		    Var NewItemSets() As Beacon.ItemSet
		    For Each Dict As Dictionary In Dicts
		      Var Set As Beacon.ItemSet = Beacon.ItemSet.FromSaveData(Dict)
		      If Set = Nil Then
		        Continue
		      End If
		      
		      NewItemSets.Add(Set)
		    Next
		    Self.AddSets(NewItemSets)
		  ElseIf Board.TextAvailable And Board.Text.Left(1) = "(" Then
		    Var Contents As String = Board.Text
		    If Contents.Left(2) = "((" Then
		      // This may be multiple item sets from the dev kit, so wrap it up like a full loot source
		      // No additional wrapping necessary, but we need to make sure the next clause is not hit
		    ElseIf Contents.Left(1) = "(" Then
		      // This may be a single item set from the dev kit, so wrap it up like a full loot source
		      Contents = "(" + Contents + ")"
		    End If
		    
		    Var Lines() As String
		    For Each Source As Beacon.LootSource In Self.mSources
		      Lines.Add("ConfigOverrideSupplyCrateItems=(SupplyCrateClassString=""" + Source.ClassString + """,MinItemSets=1,MaxItemSets=3,NumItemSetsPower=1.000000,bSetsRandomWithoutReplacement=true,ItemSets=" + Contents + ")")
		    Next
		    Self.Import(Lines.Join(EndOfLine), "Clipboard")
		  End
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  Var Targets() As ItemSetOrganizer
		  If Me.SelectedRowCount = 0 Then
		    Var Idx As Integer = Me.RowFromXY(X, Y)
		    If Idx = -1 Then
		      Return False
		    End If
		    Targets.Add(Me.RowTagAt(Idx))
		  Else
		    For I As Integer = 0 To Me.RowCount - 1
		      If Me.Selected(I) Then
		        Targets.Add(Me.RowTagAt(I))
		      End If
		    Next
		  End If
		  
		  If Targets.LastIndex = -1 Then
		    Return False
		  End If
		  
		  Var Preset As Beacon.Preset
		  For Each Organizer As ItemSetOrganizer In Targets
		    If Organizer.Template.SourcePresetID = "" Or Preset <> Nil Then
		      Continue
		    End If
		    
		    Preset = Beacon.Data.GetPreset(Organizer.Template.SourcePresetID)
		  Next
		  
		  Var CreateItem As New MenuItem("Create Preset…", Targets)
		  CreateItem.Name = "createpreset"
		  CreateItem.Enabled = Targets.LastIndex = 0
		  If Preset <> Nil And CreateItem.Enabled Then
		    CreateItem.Text = "Update """ + Preset.Label + """ Preset…"
		  End If
		  Base.AddMenu(CreateItem)
		  
		  Var ReconfigureItem As New MenuItem("Rebuild From Preset", Targets)
		  ReconfigureItem.Name = "reconfigure"
		  ReconfigureItem.Enabled = Preset <> Nil
		  If ReconfigureItem.Enabled Then
		    If Targets.LastIndex = 0 Then
		      ReconfigureItem.Text = "Rebuild From """ + Preset.Label + """ Preset"
		    Else
		      ReconfigureItem.Text = "Rebuild From Presets"
		    End If
		  End If
		  Base.AddMenu(ReconfigureItem)
		  
		  If Keyboard.OptionKey Then
		    Base.AddMenu(New MenuItem(MenuItem.TextSeparator))
		    
		    Var CopyJSONItem As New MenuItem("Copy JSON", Targets)
		    CopyJSONItem.Name = "copyjson"
		    CopyJSONItem.Enabled = True
		    Base.AddMenu(CopyJSONItem)
		    
		    Var CopyConfigItem As New MenuItem("Copy Config Part", Targets)
		    CopyConfigItem.Name = "copyconfig"
		    CopyConfigItem.Enabled = True
		    Base.AddMenu(CopyConfigItem)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  If HitItem = Nil Then
		    Return False
		  End If
		  
		  Var Targets() As ItemSetOrganizer = HitItem.Tag
		  
		  Select Case HitItem.Name
		  Case "createpreset"
		    If Targets.LastIndex = 0 Then
		      Var Organizer As ItemSetOrganizer = Targets(0)
		      
		      Var NewPreset As Beacon.Preset = App.MainWindow.Presets.CreatePreset(Organizer.Template)
		      If NewPreset = Nil Then
		        Return True
		      End If
		      
		      Var AffectedItemSets() As Beacon.ItemSet
		      Var Sources() As Beacon.LootSource = Organizer.Sources
		      For Each Source As Beacon.LootSource In Sources
		        Var Set As Beacon.ItemSet = Organizer.SetForSource(Source)
		        If Set = Nil Then
		          Continue
		        End If
		        
		        If Set.ReconfigureWithPreset(NewPreset, Source, Self.Document) Then
		          AffectedItemSets.Add(Set)
		        End If
		      Next
		      
		      If AffectedItemSets.LastIndex > -1 Then
		        Self.UpdateUI(AffectedItemSets)
		        RaiseEvent Updated
		      End If
		    End If
		  Case "reconfigure"
		    Var AffectedItemSets() As Beacon.ItemSet
		    Var Presets As New Dictionary
		    For Each Organizer As ItemSetOrganizer In Targets
		      Var Sources() As Beacon.LootSource = Organizer.Sources
		      
		      For Each Source As Beacon.LootSource In Sources
		        Var Set As Beacon.ItemSet = Organizer.SetForSource(Source)
		        If Set = Nil Or Set.SourcePresetID = "" Then
		          Continue
		        End If
		        
		        If Not Presets.HasKey(Set.SourcePresetID) Then
		          Var LoadedPreset As Beacon.Preset = Beacon.Data.GetPreset(Set.SourcePresetID)
		          If LoadedPreset = Nil Then
		            Continue
		          End If
		          Presets.Value(Set.SourcePresetID) = LoadedPreset
		        End If
		        
		        Var Preset As Beacon.Preset = Presets.Value(Set.SourcePresetID)
		        
		        If Set.ReconfigureWithPreset(Preset, Source, Self.Document) Then
		          AffectedItemSets.Add(Set)
		        End If
		      Next
		    Next
		    
		    If AffectedItemSets.LastIndex = -1 Then
		      If Targets.LastIndex = 0 Then
		        Self.ShowAlert("No changes made", "This item set is already identical to the preset.")
		      Else
		        Self.ShowAlert("No changes made", "All item sets already match their preset.")
		      End If
		      Return True
		    End If
		    
		    Self.UpdateUI(AffectedItemSets)
		    RaiseEvent Updated
		    
		    If Targets.LastIndex > 0 Then
		      // Editor will be disabled, so it won't be obvious something happened.
		      Self.ShowAlert("Rebuild complete", "All selected item sets have been rebuilt according to their preset.")
		    End If
		  Case "copyjson"
		    If Targets.LastIndex = 0 Then
		      Var Dict As Dictionary = Targets(0).Template.SaveData()
		      Var Board As New Clipboard
		      Board.Text = Beacon.GenerateJSON(Dict, True)
		    Else
		      Var Arr() As Dictionary
		      For Each Organizer As ItemSetOrganizer In Targets
		        Arr.Add(Organizer.Template.SaveData())
		      Next
		      Var Board As New Clipboard
		      Board.Text = Beacon.GenerateJSON(Arr, True)
		    End If
		  Case "copyconfig"
		    Var Multipliers As Beacon.Range
		    Var UseBlueprints As Boolean = False
		    Var Difficulty As BeaconConfigs.Difficulty = Self.Document.Difficulty
		    If Self.mSources.LastIndex = 0 Then
		      Multipliers = Self.mSources(0).Multipliers
		    Else
		      Multipliers = New Beacon.Range(1, 1)
		    End If
		    
		    Var Parts() As String
		    For Each Organizer As ItemSetOrganizer In Targets
		      Parts.Add(Organizer.Template.StringValue(Multipliers, UseBlueprints, Difficulty))
		    Next
		    
		    Var Board As New Clipboard
		    If Parts.LastIndex = 0 Then
		      Board.Text = Parts(0)
		    Else
		      Board.Text = "ItemSets=(" + Parts.Join(",") + ")"
		    End If
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Open()
		  Var AddButton As New BeaconToolbarItem("AddSet", IconToolbarAdd)
		  AddButton.HasMenu = True
		  AddButton.HelpTag = "Add a new empty item set. Hold to add a preset from a menu."
		  
		  Var SimulateButton As New BeaconToolbarItem("Simulate", IconToolbarSimulate)
		  SimulateButton.Enabled = False
		  SimulateButton.HelpTag = "Simulate loot selection for this loot source."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.RightItems.Append(SimulateButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddSet"
		    Self.AddSet(New Beacon.ItemSet)
		  Case "Simulate"
		    Self.SimulatorVisible = True
		    Self.Simulator.Simulate(Self.mSources(0))
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub BuildMenu(Item As BeaconToolbarItem, Menu As MenuItem)
		  Select Case Item.Name
		  Case "AddSet"
		    Self.BuildPresetMenu(Menu)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub HandleMenuAction(Item As BeaconToolbarItem, ChosenItem As MenuItem)
		  Select Case Item.Name
		  Case "AddSet"
		    Call Self.HandlePresetMenu(ChosenItem)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  Self.SetListWidth(NewSize)
		  NewSize = Self.Header.Width
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub Updated()
		  // The set needs to be cloned into each loot source
		  
		  If SetList.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Organizer As ItemSetOrganizer = Self.SetList.RowTagAt(Self.SetList.SelectedRowIndex)
		  Organizer.Replicate()
		  Self.SetList.CellValueAt(Self.SetList.SelectedRowIndex, 0) = Organizer.Template.Label
		  
		  Self.mSorting = True
		  SetList.Sort
		  Self.mSorting = False
		  
		  RaiseEvent Updated
		  
		  If Self.SimulatorVisible And Self.mSources.LastIndex = 0 Then
		    Self.Simulator.Simulate(Self.mSources(0))
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDocument() As Beacon.Document
		  Return Self.Document
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Simulator
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  NewSize = Min(NewSize, Self.Height - Self.MinSimulatorPosition)
		  
		  Me.Height = NewSize
		  Me.Top = Self.Height - NewSize
		  Self.StatusBar1.Top = Self.Height - (NewSize + Self.StatusBar1.Height)
		  Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		End Sub
	#tag EndEvent
	#tag Event
		Sub ResizeFinished()
		  If Me.Height < 100 Then
		    Self.SimulatorVisible = False
		  ElseIf Self.mSavePositions Then
		    Preferences.SimulatorSize = Me.Height
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldClose()
		  Self.SimulatorVisible = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SettingsContainer
	#tag Event
		Sub Resized()
		  Var ListTop As Integer = Me.Top + Me.Height
		  
		  If Self.HintsContainer.Visible Then
		    If Self.HintsContainer.Top = ListTop Then
		      Return
		    End If
		    
		    Self.HintsContainer.Top = ListTop
		    Self.SetList.Top = Self.HintsContainer.Top + Self.HintsContainer.Height
		    Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		  Else
		    If Self.SetList.Top = ListTop Then
		      Return
		    End If
		    
		    Self.SetList.Top = ListTop
		    Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		  End If
		  
		  #if false
		    If Self.HintsContainer.Visible And Self.HintsContainer.Top = ListTop Then
		      Return
		    ElseIf Not Self.HintsContainers.Visible And Self.SetList.Top = ListTop Then
		      Return
		    End If
		    
		    Var Diff As Integer = ListTop - Self.SetList.Top
		    Self.SetList.Top = Self.SetList.Top + Diff
		    Self.SetList.Height = Self.SetList.Height - Diff
		  #endif
		End Sub
	#tag EndEvent
	#tag Event
		Sub SettingsChanged()
		  RaiseEvent Updated
		  
		  If Self.SimulatorVisible Then
		    Self.Simulator.Simulate(Self.mSources(0))
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
