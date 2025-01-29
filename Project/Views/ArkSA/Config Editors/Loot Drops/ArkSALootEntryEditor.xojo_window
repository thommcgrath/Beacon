#tag DesktopWindow
Begin BeaconDialog ArkSALootEntryEditor
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   600
   ImplicitInstance=   False
   LiveResize      =   "False"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   600
   MinimizeButton  =   False
   MinWidth        =   900
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Set Entry"
   Visible         =   True
   Width           =   900
   Begin DesktopGroupBox EngramsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Possible Items"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   528
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   380
      Begin DesktopCheckBox SingleEntryCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Merge selections into one entry"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   476
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   340
      End
      Begin DelayedSearchField FilterField
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowRecentItems=   False
         ClearMenuItemValue=   "Clear"
         DelayPeriod     =   250
         Enabled         =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumRecentItems=   -1
         PanelIndex      =   0
         RecentItemsValue=   "Recent Searches"
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         Tooltip         =   ""
         Top             =   56
         Transparent     =   False
         Visible         =   True
         Width           =   263
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin BeaconListbox EngramList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   4
         ColumnWidths    =   "24,*,100,72"
         DefaultRowHeight=   24
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   1
         Height          =   295
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         InitialValue    =   " 	Name	Mod	Weight"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PageSize        =   100
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   169
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   1
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   340
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin TagPicker Picker
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Border          =   15
         ContentHeight   =   0
         Enabled         =   True
         ExcludeTagCaption=   ""
         Height          =   67
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         NeutralTagCaption=   ""
         RequireTagCaption=   ""
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         Spec            =   ""
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   90
         Transparent     =   True
         Visible         =   True
         Width           =   340
      End
      Begin UITweaks.ResizedPushButton ModsButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Mods"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Italic          =   False
         Left            =   315
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   57
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   65
      End
      Begin DesktopCheckBox SingleItemCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Choose only one item"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   "With this option off, the quantity will be distributed between all selected items. When turned on, only one item is selected for the entire quantity. The simulator will help visualize what effect this has."
         Top             =   508
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   340
      End
   End
   Begin DesktopGroupBox SettingsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Quantity and Stats"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   311
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   412
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   468
      Begin ArkSALootEntryPropertiesEditor EntryPropertiesEditor1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   275
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Left            =   422
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   46
         Transparent     =   True
         Visible         =   True
         Width           =   448
      End
   End
   Begin DesktopGroupBox SimulationGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Simulation"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   205
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   412
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   343
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   468
      Begin UITweaks.ResizedPushButton SimulateButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Refresh"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "SimulationGroup"
         Italic          =   False
         Left            =   780
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   508
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox SimulatedResultsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   1
         ColumnWidths    =   ""
         DefaultRowHeight=   22
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   117
         Index           =   -2147483648
         InitialParent   =   "SimulationGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   432
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PageSize        =   100
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   379
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   428
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   800
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   560
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   708
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   560
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Var PreferredSize As Size = Preferences.EntryEditorSize
		  
		  Self.Picker.Tags = ArkSA.DataSource.Pool.Get(False).GetTags(Self.mMods, ArkSA.CategoryEngrams)
		  Self.Picker.Spec = Preferences.SelectedTag(ArkSA.CategoryEngrams, "Looting")
		  Self.Width = Max(PreferredSize.Width, Self.MinimumWidth)
		  Self.Height = Max(PreferredSize.Height, Self.MinimumHeight)
		  
		  If Self.mShowModsButton = False Then
		    Self.ModsButton.Visible = False
		    Self.FilterField.Width = Self.EngramsGroup.Width - 40
		  Else
		    #if TargetMacOS
		      Self.ModsButton.Top = Self.FilterField.Top
		    #endif
		  End If
		  
		  Self.SwapButtons()
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Preferences.EntryEditorSize = New Size(Self.Width, Self.Height)
		  Self.Picker.AutoResize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Picker.AutoResize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AllowMultipleEntries() As Boolean
		  Return Self.mOriginalEntry Is Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Mods As Beacon.StringList, WithModsButton As Boolean)
		  Self.mSelectedEngrams = New Dictionary
		  Self.mMods = Mods
		  Self.mSettingUp = True
		  Self.mShowModsButton = WithModsButton
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EnableButtons()
		  Self.ActionButton.Enabled = Self.mSelectedEngrams.KeyCount >= 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListUnknownEngrams()
		  For Each Entry As DictionaryEntry In Self.mSelectedEngrams
		    Var Path As String = Entry.Key
		    Var Option As ArkSA.LootItemSetEntryOption = Entry.Value
		    
		    Var Idx As Integer = Self.mEngramRowIndexes.Lookup(Path, -1)
		    If Idx = -1 Then
		      Var WeightValue As Double = Option.RawWeight * 100
		      Var Weight As String = WeightValue.PrettyText
		      
		      EngramList.AddRow("", Option.Engram.Label, Option.Engram.ContentPackName, Weight)
		      EngramList.RowTagAt(EngramList.LastAddedRowIndex) = Option.Engram
		      Self.mEngramRowIndexes.Value(Path) = EngramList.LastAddedRowIndex
		      Idx = EngramList.LastAddedRowIndex
		      EngramList.CellCheckBoxValueAt(Idx, Self.ColumnIncluded) = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mModSelectionController_Finished(Sender As PopoverController, Cancelled As Boolean)
		  If Not Cancelled Then
		    Var ContentPacks() As Beacon.ContentPack = ArkSA.DataSource.Pool.Get(False).GetContentPacks
		    Var Editor As ModSelectionGrid = ModSelectionGrid(Sender.Container)
		    Var ModList As New Beacon.StringList
		    Var PrefsDict As New Dictionary
		    For Each Pack As Beacon.ContentPack In ContentPacks
		      If Editor.ModEnabled(Pack.ContentPackId) Then
		        ModList.Append(Pack.ContentPackId)
		        PrefsDict.Value(Pack.ContentPackId) = True
		      Else
		        PrefsDict.Value(Pack.ContentPackId) = False
		      End If
		    Next
		    Self.mMods = ModList
		    Preferences.PresetsEnabledMods = PrefsDict
		    Var Spec As Beacon.TagSpec = Self.Picker.Spec
		    Self.Picker.Tags = ArkSA.DataSource.Pool.Get(False).GetTags(Self.mMods, ArkSA.CategoryEngrams)
		    Self.Picker.Spec = Spec
		    Self.UpdateFilter
		  End If
		  
		  Self.mModSelectionController = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Sources() As ArkSA.LootItemSetEntry = Nil, Prefilter As String = "") As ArkSA.LootItemSetEntry()
		  Var TemplatePacksDict As JSONItem = Preferences.PresetsEnabledMods
		  If TemplatePacksDict Is Nil Then
		    TemplatePacksDict = New JSONItem
		  End If
		  Var PackList As New Beacon.StringList
		  Var ContentPacks() As Beacon.ContentPack = ArkSA.DataSource.Pool.Get(False).GetContentPacks
		  For Each Pack As Beacon.ContentPack In ContentPacks
		    If TemplatePacksDict.Lookup(Pack.ContentPackId, Pack.IsDefaultEnabled).BooleanValue = True Then
		      PackList.Append(Pack.ContentPackId)
		    End If
		  Next
		  
		  Return Present(Parent, PackList, True, Sources, Prefilter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, ContentPacks As Beacon.StringList, Sources() As ArkSA.LootItemSetEntry = Nil, Prefilter As String = "") As ArkSA.LootItemSetEntry()
		  Return Present(Parent, ContentPacks, False, Sources, Prefilter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Present(Parent As DesktopWindow, ContentPacks As Beacon.StringList, WithModsButton As Boolean, Sources() As ArkSA.LootItemSetEntry, Prefilter As String) As ArkSA.LootItemSetEntry()
		  If Sources <> Nil And Sources.Count > 1 Then
		    // Need to use the multi-edit window
		    Return ArkSALootEntryMultiEditor.Present(Parent, Sources)
		  End If
		  
		  Var Win As New ArkSALootEntryEditor(ContentPacks, WithModsButton)
		  
		  If Sources <> Nil And Sources.LastIndex = 0 Then
		    Win.mOriginalEntry = New ArkSA.LootItemSetEntry(Sources(0))
		  End If
		  
		  Var DefaultEntry As ArkSA.LootItemSetEntry
		  If Win.mOriginalEntry Is Nil Then
		    Try
		      Var Defaults As JSONItem = Preferences.ArkSALootItemSetEntryDefaults
		      If (Defaults Is Nil) = False Then
		        Var DefaultsDict As Dictionary = Beacon.ParseJSON(Defaults.ToString)
		        DefaultEntry = ArkSA.LootItemSetEntry.FromSaveData(DefaultsDict, ArkSA.LootItemSetEntry.OptionLoadEmpty)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Else
		    DefaultEntry = Win.mOriginalEntry
		  End If
		  Win.EntryPropertiesEditor1.Setup(DefaultEntry) // This is ok to be nil
		  
		  Win.SetupUI(Prefilter)
		  Win.ShowModal(Parent)
		  
		  Var Entries() As ArkSA.LootItemSetEntry = Win.mCreatedEntries
		  Win.Close
		  If Entries.LastIndex = -1 Then
		    Return Nil
		  Else
		    Return Entries
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI(Prefilter As String = "")
		  If Self.mOriginalEntry <> Nil Then
		    For Each Option As ArkSA.LootItemSetEntryOption In Self.mOriginalEntry
		      Self.mSelectedEngrams.Value(Option.Engram.EngramId) = Option
		    Next
		    Self.SingleItemCheckbox.Value = Self.mOriginalEntry.SingleItemQuantity
		  End If
		  
		  Self.FilterField.Text = Prefilter
		  Self.UpdateFilter()
		  Self.SingleEntryCheckbox.Value = Self.mSelectedEngrams.KeyCount > 1
		  
		  For I As Integer = 0 To EngramList.RowCount - 1
		    If EngramList.CellCheckBoxValueAt(I, 0) Then
		      EngramList.ScrollPosition = I
		      Exit For I
		    End If
		  Next
		  
		  Self.UpdateSelectionUI()
		  Self.UpdateSimulation()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFilter()
		  Var SearchText As String = Self.FilterField.Text.MakeUTF8
		  Var Tags As Beacon.TagSpec = Self.Picker.Spec
		  
		  Var Engrams() As ArkSA.Engram = ArkSA.ActiveBlueprintProviders.GetEngrams(SearchText, Self.mMods, Tags)
		  EngramList.RemoveAllRows
		  
		  Self.mEngramRowIndexes = New Dictionary
		  For Each Engram As ArkSA.Engram In Engrams
		    Var Weight As String = ""
		    If Self.mSelectedEngrams.HasKey(Engram.EngramId) Then
		      Var WeightValue As Double = ArkSA.LootItemSetEntryOption(Self.mSelectedEngrams.Value(Engram.EngramId)).RawWeight * 100
		      Weight = WeightValue.PrettyText
		    End If
		    
		    EngramList.AddRow("", Engram.Label, Engram.ContentPackName, Weight)
		    EngramList.RowTagAt(EngramList.LastAddedRowIndex) = Engram
		    Self.mEngramRowIndexes.Value(Engram.EngramId) = EngramList.LastAddedRowIndex
		    EngramList.CellCheckBoxValueAt(EngramList.LastAddedRowIndex, Self.ColumnIncluded) = Self.mSelectedEngrams.HasKey(Engram.EngramId)
		  Next
		  
		  Self.ListUnknownEngrams()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSelectionUI()
		  Var ListBottom As Integer = (Self.EngramsGroup.Top + Self.EngramsGroup.Height) - 20
		  
		  If Self.mSelectedEngrams.KeyCount > 1 Then
		    Self.SingleItemCheckbox.Visible = True
		    ListBottom = Self.SingleItemCheckbox.Top - 12
		    
		    If Self.AllowMultipleEntries Then
		      Self.SingleEntryCheckbox.Visible = True
		      ListBottom = Self.SingleEntryCheckbox.Top - 12
		      Self.SingleItemCheckbox.Enabled = Self.SingleEntryCheckbox.Value
		    Else
		      Self.SingleItemCheckbox.Enabled = True
		      Self.SingleEntryCheckbox.Visible = False
		    End If
		  Else
		    Self.SingleEntryCheckbox.Visible = False
		    Self.SingleItemCheckbox.Visible = False
		  End If
		  
		  Self.EngramList.Height = ListBottom - Self.EngramList.Top
		  Self.EnableButtons
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSimulation()
		  SimulationGroup.Caption = "Simulation"
		  SimulatedResultsList.RemoveAllRows
		  If Self.mSelectedEngrams.KeyCount = 0 Then
		    Return
		  End If
		  
		  Var FullSimulation As Boolean = Self.mSelectedEngrams.KeyCount = 1 Or Self.AllowMultipleEntries = False Or (Self.SingleEntryCheckbox.Value And Self.SingleEntryCheckbox.Visible)
		  
		  Var Entry As New ArkSA.MutableLootItemSetEntry
		  Entry.SingleItemQuantity = Self.SingleItemCheckbox.Visible And Self.SingleItemCheckbox.Enabled And Self.SingleItemCheckbox.Value
		  For Each Item As DictionaryEntry In Self.mSelectedEngrams
		    Var Option As ArkSA.LootItemSetEntryOption = Item.Value
		    Entry.Add(Option)
		    If Not FullSimulation Then
		      SimulationGroup.Caption = "Simulation of " + Option.Engram.Label
		      Exit
		    End If
		  Next
		  
		  EntryPropertiesEditor1.ApplyTo(Entry)
		  
		  Var Selections() As ArkSA.LootSimulatorSelection = Entry.Simulate
		  Var GroupedItems As New Dictionary
		  For Each Selection As ArkSA.LootSimulatorSelection In Selections
		    Var Description As String = Selection.Description
		    Var Quantity As Integer
		    If GroupedItems.HasKey(Description) Then
		      Quantity = GroupedItems.Value(Description)
		    End If
		    GroupedItems.Value(Description) = Quantity + 1
		  Next
		  
		  For Each Item As DictionaryEntry In GroupedItems
		    Var Description As String = Item.Key
		    Var Quantity As Integer = Item.Value
		    SimulatedResultsList.AddRow(Quantity.ToString(Locale.Raw, "0") + "x " + Description)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCreatedEntries() As ArkSA.LootItemSetEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		mEngramRowIndexes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModSelectionController As PopoverController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalEntry As ArkSA.LootItemSetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedEngrams As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShowModsButton As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnIncluded, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnMod, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWeight, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events SingleEntryCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.UpdateSelectionUI()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Var Engram As ArkSA.Engram = Me.RowTagAt(Row)
		  
		  Select Case Column
		  Case Self.ColumnIncluded
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    If Checked Then
		      If Self.mSelectedEngrams.HasKey(Engram.EngramId) = False Then
		        Var WeightString As String = Me.CellTextAt(Row, Self.ColumnWeight)
		        If WeightString = "" Then
		          WeightString = "50"
		          Me.CellTextAt(Row, Self.ColumnWeight) = WeightString
		        End If
		        
		        Var Weight As Double = Abs(CDbl(WeightString)) / 100
		        Var Option As New ArkSA.LootItemSetEntryOption(Engram, Weight)
		        Self.mSelectedEngrams.Value(Engram.EngramId) = Option
		      Else
		        Return
		      End If
		    Else
		      If Self.mSelectedEngrams.HasKey(Engram.EngramId) = True Then
		        Self.mSelectedEngrams.Remove(Engram.EngramId)
		      Else
		        Return
		      End If
		    End If
		  Case Self.ColumnWeight
		    If Self.mSelectedEngrams.HasKey(Engram.EngramId) Then
		      Var Weight As Double = Abs(CDbl(Me.CellTextAt(Row, Column))) / 100
		      Self.mSelectedEngrams.Value(Engram.EngramId) = New ArkSA.LootItemSetEntryOption(Engram, Weight)
		    End If
		  Else
		    Return
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(Self.ColumnIncluded) = DesktopListbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnWeight) = DesktopListbox.CellTypes.TextField
		  Me.ColumnAlignmentAt(Self.ColumnWeight) = DesktopListbox.Alignments.Center
		  Me.TypeaheadColumn = Self.ColumnLabel
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case Self.ColumnIncluded
		    If Me.CellCheckBoxValueAt(Row1, Column) = True And Me.CellCheckBoxValueAt(Row2, Column) = False Then
		      Result = -1
		    ElseIf Me.CellCheckBoxValueAt(Row1, Column) = False And Me.CellCheckBoxValueAt(Row2, Column) = True Then
		      Result = 1
		    Else
		      Var Engram1 As ArkSA.Engram = Me.RowTagAt(Row1)
		      Var Engram2 As ArkSA.Engram = Me.RowTagAt(Row2)
		      
		      Result = Engram1.Label.Compare(Engram2.Label, ComparisonOptions.CaseSensitive)
		    End If
		  Case Self.ColumnWeight
		    Var Weight1 As Double = Val(Me.CellTextAt(Row1, Column))
		    Var Weight2 As Double = Val(Me.CellTextAt(Row2, Column))
		    If Weight1 > Weight2 Then
		      Result = 1
		    ElseIf Weight2 > Weight1 Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		  Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub BulkColumnChangeFinished(Column As Integer)
		  #Pragma Unused Column
		  
		  Self.UpdateSelectionUI()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Picker
	#tag Event
		Sub TagsChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Preferences.SelectedTag(ArkSA.CategoryEngrams, "Looting") = Me.Spec
		  Self.UpdateFilter
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldAdjustHeight(Delta As Integer)
		  If Me = Nil Then
		    Return
		  End If
		  
		  Me.Height = Me.Height + Delta
		  Self.EngramList.Height = Self.EngramList.Height - Delta
		  Self.EngramList.Top = Self.EngramList.Top + Delta
		End Sub
	#tag EndEvent
	#tag Event
		Sub RestoreDefaults()
		  Preferences.RestoreTags(ArkSA.CategoryEngrams, "Looting")
		  Me.Spec = Preferences.SelectedTag(ArkSA.CategoryEngrams, "Looting")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsButton
	#tag Event
		Sub Pressed()
		  If (Self.mModSelectionController Is Nil) = False And Self.mModSelectionController.Visible Then
		    Self.mModSelectionController.Dismiss(False)
		    Self.mModSelectionController = Nil
		    Return
		  End If
		  
		  Var ModPicker As New ModSelectionGrid(ArkSA.DataSource.Pool.Get(False), Self.mMods, Nil)
		  Var Controller As New PopoverController("Select Mods", ModPicker)
		  Controller.Show(Me)
		  
		  AddHandler Controller.Finished, WeakAddressOf mModSelectionController_Finished
		  Self.mModSelectionController = Controller
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SingleItemCheckbox
	#tag Event
		Sub ValueChanged()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntryPropertiesEditor1
	#tag Event
		Sub Changed()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SimulateButton
	#tag Event
		Sub Pressed()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.mSelectedEngrams.KeyCount = 0 Then
		    Return
		  End If
		  
		  Self.EntryPropertiesEditor1.CheckValues()
		  
		  Var Options() As ArkSA.LootItemSetEntryOption
		  For Each Entry As DictionaryEntry In Self.mSelectedEngrams
		    Options.Add(Entry.Value)
		  Next
		  
		  Var Entries() As ArkSA.MutableLootItemSetEntry
		  If (Self.mOriginalEntry Is Nil) = False Then
		    Var Entry As New ArkSA.MutableLootItemSetEntry(Self.mOriginalEntry)
		    Entry.ResizeTo(-1)
		    For Each Option As ArkSA.LootItemSetEntryOption In Options
		      Entry.Add(Option)
		    Next
		    Entry.SingleItemQuantity = Self.SingleItemCheckbox.Visible And Self.SingleItemCheckbox.Enabled And Self.SingleItemCheckbox.Value
		    Entries.Add(Entry)
		  ElseIf Options.Count > 1 Then
		    If SingleEntryCheckbox.Value Then
		      // Merge all into one
		      Var Entry As New ArkSA.MutableLootItemSetEntry
		      For Each Option As ArkSA.LootItemSetEntryOption In Options
		        Entry.Add(Option)
		      Next
		      Entry.SingleItemQuantity = Self.SingleItemCheckbox.Visible And Self.SingleItemCheckbox.Enabled And Self.SingleItemCheckbox.Value
		      Entries.Add(Entry)
		    Else
		      // Multiple entries
		      For Each Option As ArkSA.LootItemSetEntryOption In Options
		        Var Entry As New ArkSA.MutableLootItemSetEntry
		        Entry.Add(Option)    
		        Entries.Add(Entry)
		      Next
		    End If
		  ElseIf Options.Count = 1 Then
		    Var Entry As New ArkSA.MutableLootItemSetEntry
		    Entry.Add(Options(0))
		    Entries.Add(Entry)
		  Else
		    System.Beep
		    Return
		  End If
		  
		  EntryPropertiesEditor1.ApplyTo(Entries)
		  
		  Self.mCreatedEntries.ResizeTo(Entries.LastIndex)
		  For Idx As Integer = 0 To Entries.LastIndex
		    Self.mCreatedEntries(Idx) = New ArkSA.LootItemSetEntry(Entries(Idx))
		  Next Idx
		  
		  Preferences.ArkSALootItemSetEntryDefaults = Entries(0).SaveData(True)
		  
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
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
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
