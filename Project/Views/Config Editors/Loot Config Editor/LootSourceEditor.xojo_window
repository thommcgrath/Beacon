#tag Window
Begin BeaconContainer LootSourceEditor Implements AnimationKit.ValueAnimator
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   464
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
   Width           =   598
   Begin BeaconListbox SetList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
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
      DropIndicatorVisible=   False
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontal=   "0"
      GridLinesHorizontalStyle=   "0"
      GridLinesVertical=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   False
      HasHeading      =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
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
      RequiresSelection=   False
      RowSelectionType=   "1"
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionRequired=   False
      SelectionType   =   "1"
      ShowDropIndicator=   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Tooltip         =   ""
      Top             =   140
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   250
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Beacon.ImportThread Importer
      Enabled         =   True
      GameIniContent  =   ""
      GameUserSettingsIniContent=   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   0
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Item Sets"
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
      Resizer         =   "1"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
   Begin PagePanel Panel
      AllowAutoDeactivate=   True
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
      SelectedPanelIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   347
      Begin ItemSetEditor Editor
         AcceptFocus     =   False
         AcceptTabs      =   True
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         DoubleBuffer    =   False
         Enabled         =   False
         HasBackColor    =   False
         HasBackgroundColor=   False
         Height          =   464
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
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   347
      End
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "No Selection"
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
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   347
      End
      Begin StatusBar NoSelectionStatusBar
         AcceptFocus     =   False
         AcceptTabs      =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Borders         =   1
         Caption         =   ""
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
         Tooltip         =   ""
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
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
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
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin SimulatorView Simulator
      AcceptFocus     =   False
      AcceptTabs      =   True
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      HasBackColor    =   False
      HasBackgroundColor=   False
      Height          =   183
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   281
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   250
   End
   Begin FadedSeparator FadedSeparator3
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
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
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
   Begin LootSourceSettingsContainer SettingsContainer
      AcceptFocus     =   False
      AcceptTabs      =   True
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      HasBackColor    =   False
      HasBackgroundColor=   False
      Height          =   23
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   250
   End
   Begin StatusBar StatusBar1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Borders         =   1
      Caption         =   ""
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
      Tooltip         =   ""
      Top             =   260
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
   Begin LootSourceHintsContainer HintsContainer
      AcceptFocus     =   False
      AcceptTabs      =   True
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      HasBackColor    =   False
      HasBackgroundColor=   False
      Height          =   76
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Notes           =   ""
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
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
		Sub EmbeddingFinished()
		  Self.Simulator.Height = Preferences.SimulatorSize
		  If Self.SimulatorVisible Then
		    Self.SimulatorPosition = Self.Height - Self.Simulator.Height
		  Else
		    Self.SimulatorPosition = Self.Height
		  End If
		  
		  Self.SetListWidth(Preferences.ItemSetsSplitterPosition)
		  Self.mSavePositions = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub MenuSelected()
		  Self.BuildPresetMenu(DocumentAddItemSet)
		  If Self.SetList.SelectedRowCount > 0 Then
		    DocumentRemoveItemSet.Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  If Self.mSavePositions Then
		    Self.SetListWidth(Self.Header.Width)
		  End If
		  
		  Self.Header.ResizerEnabled = Self.Width > Self.MinimumWidth
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DocumentRemoveItemSet() As Boolean Handles DocumentRemoveItemSet.Action
			Self.RemoveSelectedItemSets(True)
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddSet(Set As Beacon.ItemSet)
		  Dim Added As Boolean
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    If Source.IndexOf(Set) = -1 Then
		      Source.Append(New Beacon.ItemSet(Set))
		      Added = True
		    End If
		  Next
		  
		  If Added Then
		    SetList.AddRow(Set.Label)
		    SetList.RowTag(SetList.LastAddedRowIndex) = Set
		    SetList.SelectedIndex = SetList.LastAddedRowIndex
		    Self.mSorting = True
		    SetList.Sort
		    Self.mSorting = False
		    RaiseEvent Updated
		  End If
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
		  Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		  Dim Groups As New Dictionary
		  Dim GroupNames() As String
		  For Each Preset As Beacon.Preset In Presets
		    Dim Arr() As Beacon.Preset
		    If Groups.HasKey(Preset.Grouping) Then
		      Arr = Groups.Value(Preset.Grouping)
		    End If
		    Arr.Append(Preset)
		    Groups.Value(Preset.Grouping) = Arr
		    
		    If GroupNames.IndexOf(Preset.Grouping) = -1 Then
		      GroupNames.Append(Preset.Grouping)
		    End If
		  Next
		  GroupNames.Sort
		  
		  For I As Integer = Parent.Count - 1 DownTo 0
		    Parent.Remove(I)
		  Next
		  
		  Dim EmptySetItem As New MenuItem("New Empty Set", Nil)
		  AddHandler EmptySetItem.Action, WeakAddressOf Self.HandlePresetMenu
		  Parent.Append(EmptySetItem)
		  
		  Dim HasTarget As Boolean = Self.mSources.LastRowIndex > -1
		  
		  For Each Group As String In GroupNames
		    Dim Arr() As Beacon.Preset = Groups.Value(Group)
		    Dim Names() As String
		    Dim Items() As Beacon.Preset
		    For Each Preset As Beacon.Preset In Arr
		      If Preset.ValidForMask(Self.Document.MapCompatibility) Then
		        Names.Append(Preset.Label)
		        Items.Append(Preset)
		      End If
		    Next
		    If Names.LastRowIndex = -1 Then
		      Continue For Group
		    End If
		    
		    Names.SortWith(Items)
		    
		    Parent.Append(New MenuItem(MenuItem.TextSeparator))
		    
		    Dim Header As New MenuItem(Group)
		    Header.Enabled = False
		    Parent.Append(Header)
		    
		    For Each Preset As Beacon.Preset In Items
		      Dim PresetItem As New MenuItem(Preset.Label, Preset)
		      PresetItem.Enabled = HasTarget
		      AddHandler PresetItem.Action, WeakAddressOf Self.HandlePresetMenu
		      Parent.Append(PresetItem)
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CancelImport()
		  Importer.Stop
		  
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.Close
		    Self.ImportProgress = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Document() As Beacon.Document
		  Return RaiseEvent GetDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableMenuItems()
		  Self.BuildPresetMenu(DocumentAddItemSet)
		  
		  #if false
		    AddItemSetEmpty.Enable
		    AddItemSetDesertClothClothing.Enable
		    AddItemSetPlatformSaddles.Enable
		    AddItemSetAdobeHousing.Enable
		    AddItemSetAdvancedFirearms.Enable
		    AddItemSetAdvancedFurniture.Enable
		    AddItemSetBasicFurniture.Enable
		    AddItemSetChitinArmor.Enable
		    AddItemSetClothClothing.Enable
		    AddItemSetFlakArmor.Enable
		    AddItemSetGhillieSuit.Enable
		    AddItemSetHideClothing.Enable
		    AddItemSetLargeSaddles.Enable
		    AddItemSetMediumSaddles.Enable
		    AddItemSetMetalHousing.Enable
		    AddItemSetMetalTools.Enable
		    AddItemSetRiotArmor.Enable
		    AddItemSetSimpleFirearms.Enable
		    AddItemSetSmallSaddles.Enable
		    AddItemSetStoneHousing.Enable
		    AddItemSetStoneTools.Enable
		    AddItemSetSupplies.Enable
		    AddItemSetThatchHousing.Enable
		    AddItemSetWoodHousing.Enable
		    AddItemSetFurArmor.Enable
		    AddItemSetGardening.Enable
		  #endif
		  If SetList.SelectedRowCount > 0 Then
		    DocumentRemoveItemSet.Enable
		  End If
		  If SetList.SelectedRowCount = 1 Then
		    Editor.EnableMenuItems
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GoToChild(ItemSet As Beacon.ItemSet, Entry As Beacon.SetEntry = Nil, Option As Beacon.SetEntryOption = Nil) As Boolean
		  For I As Integer = 0 To Self.SetList.RowCount - 1
		    If Self.SetList.RowTag(I) = ItemSet Then
		      Self.SetList.SelectedIndex = I
		      Self.SetList.EnsureSelectionIsVisible()
		      If Entry <> Nil Then
		        Return Self.Editor.GoToChild(Entry, Option)
		      Else
		        Return True
		      End If
		    End If
		  Next
		  Self.SetList.SelectedIndex = -1
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandlePresetMenu(Sender As MenuItem) As Boolean
		  Dim SelectedPreset As Beacon.Preset = Sender.Tag
		  
		  If SelectedPreset = Nil Then
		    Self.ShowNewSet()
		    Return True
		  End If
		  
		  Dim Added As Boolean
		  For Each Source As Beacon.LootSource In Self.mSources
		    Dim Set As Beacon.ItemSet = Beacon.ItemSet.FromPreset(SelectedPreset, Source, Self.Document.MapCompatibility, Self.Document.Mods)
		    If Source.IndexOf(Set) = -1 Then
		      Source.Append(Set)
		      Added = True
		    End If
		  Next
		  
		  If Added Then
		    Self.RebuildSetList()
		    Dim Found As Boolean
		    For I As Integer = 0 To SetList.RowCount - 1
		      Dim Set As Beacon.ItemSet = SetList.RowTag(I)
		      If Set.SourcePresetID = SelectedPreset.PresetID Then
		        Found = True
		        SetList.SelectedIndex = I
		        Exit
		      End If
		    Next
		    If Not Found Then
		      Self.ShowAlert("Preset added but not shown", "Because you have multiple loot sources selected, the preset was added to each source, but was configured differently for each. It is not common to all your selected sources, so it isn't currently listed.")
		    Else
		      Self.SetList.SetFocus
		    End If
		    RaiseEvent Updated
		  End If
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String, Source As String)
		  Self.ImportProgress = New ImporterWindow
		  Self.ImportProgress.Source = Source
		  Self.ImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.ImportProgress.ShowWithin(Self.TrueWindow)
		  Self.Importer.Clear
		  Self.Importer.GameIniContent = Content
		  Self.Importer.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MinSimulatorPosition() As Integer
		  Return Self.SettingsContainer.Top + Self.SettingsContainer.Height + Self.HintsContainer.Height + 200
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildSetList()
		  Dim SelectedSetNames() As String
		  For I As Integer = 0 To SetList.RowCount - 1
		    If SetList.Selected(I) Then
		      SelectedSetNames.Append(SetList.Cell(I, 0))
		    End If
		  Next
		  
		  Self.RebuildSetList(SelectedSetNames)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildSetList(SelectedSetNames() As String)
		  Self.mUpdating = True
		  
		  // Find sets that are common to all sources
		  Dim Sets As New Dictionary
		  Dim Weights As New Dictionary
		  Dim MatchWeight As Integer = Self.mSources.LastRowIndex + 1
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    For Each Set As Beacon.ItemSet In Source
		      Dim Hash As String = Set.Hash
		      Sets.Value(Hash) = Set
		      Weights.Value(Hash) = Weights.Lookup(Hash, 0).IntegerValue + 1
		    Next
		  Next
		  
		  // Now each common set will have a value of MatchWeight in Weights
		  Dim Hashes() As Variant = Weights.Keys
		  Dim CommonSets() As Beacon.ItemSet
		  For Each Hash As String In Hashes
		    If Weights.Value(Hash).IntegerValue = MatchWeight Then
		      CommonSets.Append(New Beacon.ItemSet(Sets.Value(Hash)))
		    End If
		  Next
		  
		  Self.mTotalSetCount = Sets.KeyCount
		  Self.mVisibleSetCount = CommonSets.LastRowIndex + 1
		  
		  SetList.DeleteAllRows
		  For Each Set As Beacon.ItemSet In CommonSets
		    SetList.AddRow(Set.Label)
		    SetList.RowTag(SetList.LastAddedRowIndex) = Set
		    SetList.Selected(SetList.LastAddedRowIndex) = SelectedSetNames.IndexOf(Set.Label) > -1
		  Next
		  Self.mSorting = True
		  SetList.Sort
		  Self.mSorting = False
		  
		  #if false
		    If Self.mSources.LastRowIndex > -1 Then
		      Dim DuplicatesState As CheckBox.CheckedStates = if(Self.mSources(0).SetsRandomWithoutReplacement, CheckBox.CheckedStates.Checked, CheckBox.CheckedStates.Unchecked)
		      Dim Label As String = Self.mSources(0).Label
		      Dim MinSets As Integer = Self.mSources(0).MinItemSets
		      Dim MaxSets As Integer = Self.mSources(0).MaxItemSets
		      
		      For I As Integer = 1 To Self.mSources.LastRowIndex
		        MinSets = Min(MinSets, Self.mSources(I).MinItemSets)
		        MaxSets = Max(MaxSets, Self.mSources(I).MaxItemSets)
		        
		        If Self.mSources(I).Label <> Label Then
		          Label = ""
		        End If
		        
		        Dim State As CheckBox.CheckedStates = if(Self.mSources(I).SetsRandomWithoutReplacement, CheckBox.CheckedStates.Checked, CheckBox.CheckedStates.Unchecked)
		        If State <> DuplicatesState Then
		          DuplicatesState = CheckBox.CheckedStates.Indeterminate
		        End If
		      Next
		    End If
		  #endif
		  
		  If Self.SimulatorVisible Then
		    Self.Simulator.Simulate()
		  End If
		  Self.mUpdating = False
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedItemSets(RequireConfirmation As Boolean)
		  If SetList.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Dim Sets() As Beacon.ItemSet
		  For I As Integer = 0 To SetList.RowCount - 1
		    If SetList.Selected(I) Then
		      Sets.Append(SetList.RowTag(I))
		    End If
		  Next
		  
		  If RequireConfirmation Then
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    If SetList.SelectedRowCount = 1 Then
		      Dialog.Message = "Are you sure you want to delete the item set """ + Sets(0).Label + """?"
		    Else
		      Dialog.Message = "Are you sure you want to delete these " + Str(SetList.SelectedRowCount, "-0") + " item sets?"
		    End If
		    Dialog.Explanation = "This action cannot be undone."
		    Dialog.ActionButton.Caption = "Delete"
		    Dialog.CancelButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		    If Choice = Dialog.CancelButton Then
		      Return
		    End If
		  End If
		  
		  Dim Updated As Boolean
		  For Each Set As Beacon.ItemSet In Sets
		    For Each Source As Beacon.LootSource In Self.mSources
		      Dim Idx As Integer = Source.IndexOf(Set)
		      If Idx > -1 Then
		        Source.Remove(Idx)
		        Updated = True
		      End If
		    Next
		  Next
		  For I As Integer = SetList.RowCount - 1 DownTo 0
		    If SetList.Selected(I) Then
		      SetList.RemoveRow(I)
		    End If
		  Next
		  If Updated Then
		    RaiseEvent Updated
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer)
		  If Self.Width < Self.MinimumWidth Then
		    // Don't compute anything
		    Return
		  End If
		  
		  Dim AvailableSpace As Integer = Self.Width - Self.FadedSeparator1.Width
		  Dim ListWidth As Integer = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - Self.EditorMinWidth)
		  Dim EditorWidth As Integer = AvailableSpace - ListWidth
		  
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
		Private Sub ShowNewSet()
		  Self.AddSet(New Beacon.ItemSet)
		  RaiseEvent Updated()
		  Self.Editor.ShowSettings(True)
		  Self.Editor.SetFocus()
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
		  
		  Dim NewPosition As Integer
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
		  
		  Dim Curve As AnimationKit.Curve = AnimationKit.Curve.CreateEaseOut
		  Dim Duration As Double = 0.15
		  
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
		  Dim Results() As Beacon.LootSource
		  For Each Source As Beacon.LootSource In Self.mSources
		    Results.Append(Source)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sources(Assigns Values() As Beacon.LootSource)
		  Redim Self.mSources(Values.LastRowIndex)
		  For I As Integer = 0 To Self.mSources.LastRowIndex
		    Self.mSources(I) = Values(I)
		  Next
		  If Self.mSources.LastRowIndex = 0 Then
		    Self.Header.Simulate.Enabled = True
		    Self.Simulator.Simulate(Self.mSources(0))
		  Else
		    Self.Header.Simulate.Enabled = False
		    Self.Simulator.Clear()
		  End If
		  
		  Dim CommonNotes As String
		  If Self.mSources.LastRowIndex > -1 Then
		    CommonNotes = Self.mSources(0).Notes
		    For I As Integer = 1 To Self.mSources.LastRowIndex
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
		  Self.RebuildSetList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Dim HiddenSetCount As Integer = Self.mTotalSetCount - Self.mVisibleSetCount
		  Dim Caption As String
		  If Self.SetList.SelectedRowCount > 0 Then
		    Caption = Format(Self.SetList.SelectedRowCount, "0") + " of " + Str(Self.mVisibleSetCount, "0") + " Item " + If(Self.mVisibleSetCount = 1, "Set", "Sets") + " Selected"
		  Else
		    Caption = Str(Self.mVisibleSetCount, "0") + " Item " + If(Self.mVisibleSetCount = 1, "Set", "Sets")
		  End If
		  If HiddenSetCount > 0 Then
		    Caption = Caption + ", " + Str(HiddenSetCount, "0") + " Item " + If(HiddenSetCount = 1, "Set", "Sets") + " Hidden"
		  End If
		  
		  Self.StatusBar1.Caption = Caption
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
		Private ImportProgress As ImporterWindow
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


	#tag Constant, Name = EditorMinWidth, Type = Double, Dynamic = False, Default = \"498", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.itemset", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MinimumWidth, Type = Double, Dynamic = False, Default = \"749", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events SetList
	#tag Event
		Sub SelectionChanged()
		  If Self.mSorting = True Then
		    Return
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Editor.Set = New Beacon.ItemSet(Me.RowTag(Me.SelectedIndex))
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
		  Return Me.SelectedRowCount > -1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Left(Board.Text, 1) = "(")
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Self.RemoveSelectedItemSets(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Dicts() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Set As Beacon.ItemSet = Me.RowTag(I)
		    Dim Dict As Dictionary = Set.Export
		    If Dict <> Nil Then
		      Dicts.Append(Dict)
		    End If
		  Next
		  If Dicts.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim Contents As String
		  If Dicts.LastRowIndex = 0 Then
		    Contents = Beacon.GenerateJSON(Dicts(0), False)
		  Else
		    Contents = Beacon.GenerateJSON(Dicts, False)
		  End If
		  
		  Board.AddRawData(Contents, Self.kClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Self.mSources.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim Contents As String = DefineEncoding(Board.RawData(Self.kClipboardType), Encodings.UTF8)
		    Dim Parsed As Variant
		    Try
		      Parsed = Beacon.ParseJSON(Contents)
		    Catch Err As RuntimeException
		      Beep
		      Return
		    End Try
		    
		    Dim Info As Introspection.TypeInfo = Introspection.GetType(Parsed)
		    Dim Dicts() As Dictionary
		    If Info.FullName = "Dictionary" Then
		      Dicts.Append(Parsed)
		    ElseIf Info.FullName = "Auto()" Then
		      Dim Values() As Variant = Parsed
		      For Each Dict As Dictionary In Values
		        Dicts.Append(Dict)
		      Next
		    Else
		      Beep
		      Return
		    End If
		    
		    Dim Updated As Boolean
		    Dim SetNames() As String
		    For Each Source As Beacon.LootSource In Self.mSources
		      For Each Dict As Dictionary In Dicts
		        Dim Set As Beacon.ItemSet = Beacon.ItemSet.ImportFromBeacon(Dict)
		        If Set <> Nil Then
		          Source.Append(Set)
		          Updated = True
		          If SetNames.IndexOf(Set.Label) = -1 Then
		            SetNames.Append(Set.Label)
		          End If
		        End If
		      Next
		    Next
		    
		    Self.RebuildSetList(SetNames)
		    If Updated Then
		      RaiseEvent Updated
		    End If
		  ElseIf Board.TextAvailable And Left(Board.Text, 1) = "(" Then
		    Dim Contents As String = Board.Text
		    If Left(Contents, 2) = "((" Then
		      // This may be multiple item sets from the dev kit, so wrap it up like a full loot source
		      // No additional wrapping necessary, but we need to make sure the next clause is not hit
		    ElseIf Left(Contents, 1) = "(" Then
		      // This may be a single item set from the dev kit, so wrap it up like a full loot source
		      Contents = "(" + Contents + ")"
		    End If
		    
		    Dim Lines() As String
		    For Each Source As Beacon.LootSource In Self.mSources
		      Lines.Append("ConfigOverrideSupplyCrateItems=(SupplyCrateClassString=""" + Source.ClassString + """,MinItemSets=1,MaxItemSets=3,NumItemSetsPower=1.000000,bSetsRandomWithoutReplacement=true,ItemSets=" + Contents + ")")
		    Next
		    Self.Import(Join(Lines, EndOfLine), "Clipboard")
		  End
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > -1
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  Dim Targets() As Beacon.ItemSet
		  If Me.SelectedRowCount = 0 Then
		    Dim Idx As Integer = Me.RowFromXY(X, Y)
		    If Idx = -1 Then
		      Return False
		    End If
		    Targets.Append(Me.RowTag(Idx))
		  Else
		    For I As Integer = 0 To Me.RowCount - 1
		      If Me.Selected(I) Then
		        Targets.Append(Me.RowTag(I))
		      End If
		    Next
		  End If
		  
		  If Targets.LastRowIndex = -1 Then
		    Return False
		  End If
		  
		  Dim Presets(), Preset As Beacon.Preset
		  Dim PresetFound As Boolean
		  For Each Set As Beacon.ItemSet In Targets
		    If Set.SourcePresetID = "" Or PresetFound = True Then
		      Continue
		    End If
		    
		    If Presets.LastRowIndex = -1 Then
		      Presets = Beacon.Data.Presets
		    End If
		    
		    For I As Integer = 0 To Presets.LastRowIndex
		      If Presets(I).PresetID = Set.SourcePresetID Then
		        Preset = Presets(I)
		        PresetFound = True
		        Exit For I
		      End If
		    Next
		  Next
		  
		  Dim CreateItem As New MenuItem("Create Preset…", Targets)
		  CreateItem.Name = "createpreset"
		  CreateItem.Enabled = Targets.LastRowIndex = 0
		  If PresetFound And CreateItem.Enabled Then
		    CreateItem.Value = "Update """ + Preset.Label + """ Preset…"
		  End If
		  Base.Append(CreateItem)
		  
		  Dim ReconfigureItem As New MenuItem("Rebuild From Preset", Targets)
		  ReconfigureItem.Name = "reconfigure"
		  ReconfigureItem.Enabled = PresetFound
		  If ReconfigureItem.Enabled Then
		    If Targets.LastRowIndex = 0 Then
		      ReconfigureItem.Value = "Rebuild From """ + Preset.Label + """ Preset"
		    Else
		      ReconfigureItem.Value = "Rebuild From Presets"
		    End If
		  End If
		  Base.Append(ReconfigureItem)
		  
		  If Keyboard.OptionKey Then
		    Base.Append(New MenuItem(MenuItem.TextSeparator))
		    
		    Dim CopyJSONItem As New MenuItem("Copy JSON", Targets)
		    CopyJSONItem.Name = "copyjson"
		    CopyJSONItem.Enabled = True
		    Base.Append(CopyJSONItem)
		    
		    Dim CopyConfigItem As New MenuItem("Copy Config Part", Targets)
		    CopyConfigItem.Name = "copyconfig"
		    CopyConfigItem.Enabled = True
		    Base.Append(CopyConfigItem)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  If HitItem = Nil Then
		    Return False
		  End If
		  
		  Dim Targets() As Beacon.ItemSet = HitItem.Tag
		  
		  Select Case HitItem.Name
		  Case "createpreset"
		    If Targets.LastRowIndex = 0 Then
		      Dim Target As Beacon.ItemSet = Targets(0)
		      Dim NewPreset As Beacon.Preset = MainWindow.Presets.CreatePreset(Target)
		      Dim Updated As Boolean
		      If NewPreset <> Nil Then
		        For Each Source As Beacon.LootSource In Self.mSources
		          Dim Idx As Integer = Source.IndexOf(Target)
		          If Idx > -1 Then
		            Dim NewSet As New Beacon.ItemSet(Target)
		            Call NewSet.ReconfigureWithPreset(NewPreset, Source, Self.Document)
		            Source(Idx) = NewSet
		            Updated = True
		          End If
		        Next
		        
		        If Updated Then
		          Self.RebuildSetList()
		          RaiseEvent Updated
		        End If
		      End If
		    End If
		  Case "reconfigure"
		    Dim Updated As Boolean
		    For Each Set As Beacon.ItemSet In Targets
		      If Set.SourcePresetID = "" Then
		        Continue
		      End If
		      
		      // Yes, ItemSet.ReconfigureWithPreset can get its own preset. But thanks to multi-editing, it is faster to grab it once first.
		      Dim Preset As Beacon.Preset = Beacon.Data.GetPreset(Set.SourcePresetID)
		      If Preset = Nil Then
		        Continue
		      End If
		      
		      For Each Source As Beacon.LootSource In Self.mSources
		        Dim NewSet As New Beacon.ItemSet(Set)
		        If Not NewSet.ReconfigureWithPreset(Preset, Source, Self.Document) Then
		          Continue
		        End If
		        
		        Dim Idx As Integer = Source.IndexOf(Set)
		        If Idx > -1 Then
		          Source(Idx) = NewSet
		          Updated = True
		        End If
		      Next
		    Next
		    
		    If Not Updated Then
		      If Targets.LastRowIndex = 0 Then
		        Self.ShowAlert("No changes made", "This item set is already identical to the preset.")
		      Else
		        Self.ShowAlert("No changes made", "All item sets already match their preset.")
		      End If
		      Return True
		    End If
		    
		    Self.RebuildSetList()
		    RaiseEvent Updated
		    
		    If Targets.LastRowIndex > 0 Then
		      // Editor will be disabled, so it won't be obvious something happened.
		      Self.ShowAlert("Rebuild complete", "All selected item sets have been rebuilt according to their preset.")
		    End If
		  Case "copyjson"
		    If Targets.LastRowIndex = 0 Then
		      Dim Dict As Dictionary = Targets(0).Export()
		      Dim Board As New Clipboard
		      Board.Text = Beacon.GenerateJSON(Dict, False)
		    Else
		      Dim Arr() As Dictionary
		      For Each Target As Beacon.ItemSet In Targets
		        Arr.Append(Target.Export())
		      Next
		      Dim Board As New Clipboard
		      Board.Text = Beacon.GenerateJSON(Arr, False)
		    End If
		  Case "copyconfig"
		    Dim Multipliers As Beacon.Range
		    Dim UseBlueprints As Boolean
		    Dim Difficulty As BeaconConfigs.Difficulty = Self.Document.Difficulty
		    If Self.mSources.LastRowIndex = 0 Then
		      Multipliers = Self.mSources(0).Multipliers
		      UseBlueprints = Self.mSources(0).UseBlueprints
		    Else
		      Multipliers = New Beacon.Range(1, 1)
		      UseBlueprints = False
		    End If
		    
		    Dim Parts() As String
		    For Each Target As Beacon.ItemSet In Targets
		      Parts.Append(Target.TextValue(Multipliers, UseBlueprints, Difficulty))
		    Next
		    
		    Dim Board As New Clipboard
		    If Parts.LastRowIndex = 0 Then
		      Board.Text = Parts(0)
		    Else
		      Board.Text = "ItemSets=(" + Parts.Join(",") + ")"
		    End If
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function RowIsInvalid(Row As Integer) As Boolean
		  Dim Set As Beacon.ItemSet = Me.RowTag(Row)
		  Return Not Set.IsValid(Self.Document)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.Progress = Me.Progress
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(ParsedData As Dictionary)
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.Close
		    Self.ImportProgress = Nil
		  End If
		  
		  Dim Dicts() As Variant
		  Try
		    Dicts = ParsedData.Value("ConfigOverrideSupplyCrateItems")
		  Catch Err As TypeMismatchException
		    Dicts.Append(ParsedData.Value("ConfigOverrideSupplyCrateItems"))
		  End Try
		  
		  Dim Difficulty As BeaconConfigs.Difficulty = Self.Document.Difficulty
		  
		  Dim SourceLootSources() As Beacon.LootSource
		  For Each ConfigDict As Dictionary In Dicts
		    Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(ConfigDict, Difficulty)
		    If Source <> Nil Then
		      SourceLootSources.Append(Source)
		    End If
		  Next
		  
		  Dim Updated As Boolean
		  Dim SetNames() As String
		  For Each SourceLootSource As Beacon.LootSource In SourceLootSources
		    Dim DestinationLootSource As Beacon.LootSource
		    For I As Integer = 0 To Self.mSources.LastRowIndex
		      If SourceLootSource.ClassString = Self.mSources(I).ClassString Then
		        DestinationLootSource = Self.mSources(I)
		        Exit For I
		      End If
		    Next
		    If DestinationLootSource <> Nil Then
		      For Each Set As Beacon.ItemSet In SourceLootSource
		        DestinationLootSource.Append(Set)
		        Updated = True
		        If SetNames.IndexOf(Set.Label) = -1 Then
		          SetNames.Append(Set.Label)
		        End If
		      Next
		    End If
		  Next
		  
		  Self.RebuildSetList(SetNames)
		  If Updated Then
		    RaiseEvent Updated
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Opening()
		  Dim AddButton As New BeaconToolbarItem("AddSet", IconAdd)
		  AddButton.HasMenu = True
		  AddButton.HelpTag = "Add a new empty item set. Hold to add a preset from a menu."
		  
		  Dim SimulateButton As New BeaconToolbarItem("Simulate", IconToolbarSimulate)
		  SimulateButton.Enabled = False
		  SimulateButton.HelpTag = "Simulate loot selection for this loot source."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.RightItems.Append(SimulateButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddSet"
		    Self.ShowNewSet()
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
		  
		  Dim SelIndex As Integer = SetList.SelectedIndex
		  Dim OriginalSet As Beacon.ItemSet = SetList.RowTag(SelIndex)
		  Dim NewSet As Beacon.ItemSet = Editor.Set
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    Dim Idx As Integer = Source.IndexOf(OriginalSet)
		    If Idx > -1 Then
		      Source(Idx) = New Beacon.ItemSet(NewSet)
		    End If
		  Next
		  
		  SetList.Cell(SelIndex, 0) = NewSet.Label
		  SetList.RowTag(SelIndex) = New Beacon.ItemSet(NewSet)
		  
		  Self.mSorting = True
		  SetList.Sort
		  Self.mSorting = False
		  
		  RaiseEvent Updated
		  
		  If Self.SimulatorVisible Then
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
		  Dim ListTop As Integer = Me.Top + Me.Height
		  
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
		    
		    Dim Diff As Integer = ListTop - Self.SetList.Top
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
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
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		EditorType="Boolean"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
