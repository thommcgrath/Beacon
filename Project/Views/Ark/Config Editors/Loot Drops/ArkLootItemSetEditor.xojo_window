#tag Window
Begin BeaconContainer ArkLootItemSetEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   428
   HelpTag         =   ""
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
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   560
   Begin BeaconListbox EntryList
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   4
      ColumnsResizable=   False
      ColumnWidths    =   "*,80,120,140"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      EditCaption     =   "Edit"
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   1
      GridLinesVertical=   1
      HasHeading      =   True
      HeadingIndex    =   0
      Height          =   343
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Description	Quantity	Quality	Figures"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   64
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ArkLootItemSetSettingsContainer Settings
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
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   41
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   560
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
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   407
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
   End
   Begin OmniBar EditorToolbar
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
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   560
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Var ShouldUseCompactMode As Boolean = Self.Width < 600
		  If ShouldUseCompactMode = Self.mUsingCompactMode Then
		    Return
		  End If
		  
		  If ShouldUseCompactMode Then
		    Self.mExpandedSortColumn = Self.EntryList.HeadingIndex
		    Self.mExpandedSortDirection = Self.EntryList.ColumnSortDirectionAt(Self.EntryList.HeadingIndex)
		    
		    Self.EntryList.ColumnCount = 1
		    
		    Self.EntryList.HeadingIndex = 0
		    Self.EntryList.ColumnSortDirectionAt(0) = Self.mCompactSortDirection
		    Self.EntryList.DefaultRowHeight = BeaconListbox.DoubleLineRowHeight
		  Else
		    Self.mCompactSortDirection = Self.EntryList.ColumnSortDirectionAt(0)
		    
		    Self.EntryList.ColumnCount = 4
		    
		    Self.EntryList.HeadingIndex = Self.mExpandedSortColumn
		    Self.EntryList.ColumnSortDirectionAt(Self.mExpandedSortColumn) = Self.mExpandedSortDirection
		    Self.EntryList.DefaultRowHeight = BeaconListbox.StandardRowHeight
		  End If
		  
		  Self.mUsingCompactMode = ShouldUseCompactMode
		  
		  Self.UpdateEntryList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mCompactSortDirection = Listbox.SortDirections.Ascending
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelectedEntries(Prefilter As String = "")
		  Var Sources() As Ark.LootItemSetEntry
		  For I As Integer = 0 To EntryList.RowCount - 1
		    If Not EntryList.Selected(I) Then
		      Continue
		    End If
		    
		    Sources.Add(EntryList.RowTagAt(I))
		  Next
		  
		  Var Entries() As Ark.LootItemSetEntry = ArkLootEntryEditor.Present(Self, Self.Project.ContentPacks, Sources, Prefilter)
		  If Entries Is Nil Or Entries.Count <> Sources.Count Then
		    Return
		  End If
		  
		  Var ItemSet As Ark.MutableLootItemSet = Self.LootItemSet
		  If ItemSet Is Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To Entries.LastIndex
		    Var Source As Ark.LootItemSetEntry = Sources(I)
		    Var Idx As Integer = ItemSet.IndexOf(Source)
		    If Idx > -1 Then
		      ItemSet(Idx) = Entries(I)
		    End If
		  Next
		  
		  Self.UpdateEntryList(Entries)
		  RaiseEvent Updated
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GoToChild(EntryUUID As String, EngramClass As String = "") As Boolean
		  For Idx As Integer = 0 To Self.EntryList.LastRowIndex
		    Var Entry As Ark.LootItemSetEntry = Self.EntryList.RowTagAt(Idx)
		    If Entry Is Nil Or Entry.UUID <> EntryUUID Then
		      Continue
		    End If
		    
		    Self.EntryList.SelectedRowIndex = Idx
		    Self.EntryList.EnsureSelectionIsVisible()
		    
		    If EngramClass.IsEmpty = False Then
		      Self.EditSelectedEntries(EngramClass)
		    End If
		    
		    Return True
		  Next Idx
		  
		  Self.EntryList.SelectedRowIndex = -1
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootItemSet() As Ark.MutableLootItemSet
		  If (Self.mRef Is Nil) = False And (Self.mRef.Value Is Nil) = False Then
		    Return Ark.MutableLootItemSet(Self.mRef.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LootItemSet(Assigns ItemSet As Ark.MutableLootItemSet)
		  Var CurrentItemSet As Ark.MutableLootItemSet = Self.LootItemSet
		  Var OldHash As String = If(CurrentItemSet Is Nil, "", CurrentItemSet.Hash)
		  Var NewHash As String = If(ItemSet Is Nil, "", ItemSet.Hash)
		  
		  If OldHash = NewHash Then
		    Return
		  End If
		  
		  If ItemSet Is Nil Then
		    Self.mRef = Nil
		  Else
		    Self.mRef = New WeakRef(ItemSet)
		  End If
		  
		  Self.Settings.ItemSet = ItemSet
		  Self.UpdateEntryList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Project() As Ark.Project
		  Return RaiseEvent GetProject()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedEntries()
		  Var Changed As Boolean
		  Var ItemSet As Ark.MutableLootItemSet = Self.LootItemSet
		  If ItemSet Is Nil Then
		    Return
		  End If
		  
		  For I As Integer = EntryList.RowCount - 1 DownTo 0
		    If Not EntryList.Selected(I) Then
		      Continue
		    End If
		    
		    Var Entry As Ark.LootItemSetEntry = EntryList.RowTagAt(I)
		    Var Idx As Integer = ItemSet.IndexOf(Entry)
		    If Idx > -1 Then
		      ItemSet.RemoveAt(Idx)
		      Changed = True
		    End If
		  Next
		  
		  If Changed Then
		    Self.UpdateEntryList()
		    RaiseEvent Updated
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowSettings(FocusOnName As Boolean = False)
		  Self.Settings.Expand()
		  If FocusOnName Then
		    Self.Settings.EditName()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEntryList(SelectEntries() As Ark.LootItemSetEntry)
		  Var Selected() As String
		  Var ScrollToSelection As Boolean
		  If (SelectEntries Is Nil) = False Then
		    For Each Entry As Ark.LootItemSetEntry In SelectEntries
		      If (Entry Is Nil) = False Then
		        Selected.Add(Entry.UUID)
		      End If
		    Next
		    ScrollToSelection = True
		  Else
		    For I As Integer = 0 To EntryList.RowCount - 1
		      If EntryList.Selected(I) Then
		        Var Entry As Ark.LootItemSetEntry = EntryList.RowTagAt(I)
		        Selected.Add(Entry.UUID)
		      End If
		    Next
		  End If
		  
		  Var OriginalScrollPosition As Integer = Self.EntryList.ScrollPosition
		  Self.EntryList.RemoveAllRows()
		  
		  Var ItemSet As Ark.MutableLootItemSet = Self.LootItemSet
		  If ItemSet Is Nil Then
		    Self.UpdateStatus()
		    Return
		  End If
		  
		  Var RangeSeparator As String = " - "
		  If Self.mUsingCompactMode Then
		    RangeSeparator = "-"
		  End If
		  
		  For I As Integer = 0 To ItemSet.LastIndex
		    Var Entry As Ark.LootItemSetEntry = ItemSet(I)
		    If Entry Is Nil Then
		      Continue
		    End If
		    Var BlueprintChance As Double = if(Entry.CanBeBlueprint, Entry.ChanceToBeBlueprint, 0)
		    Var RelativeWeight As Double = ItemSet.RelativeWeight(I)
		    Var ChanceText As String
		    If RelativeWeight < 0.01 Then
		      Var OnePercent As Double = 0.01
		      ChanceText = "< " + OnePercent.ToString(Locale.Current, "0%")
		    Else
		      ChanceText = RelativeWeight.ToString(Locale.Current, "0%")
		    End If
		    
		    Var QualityText As String
		    If Entry.MinQuality = Entry.MaxQuality Then
		      QualityText = Entry.MinQuality.Label
		    Else
		      QualityText = Entry.MinQuality.Label(False) + RangeSeparator + Entry.MaxQuality.Label(False)
		    End If
		    
		    Var QuantityText As String
		    If Entry.MinQuantity = Entry.MaxQuantity Then
		      QuantityText = Entry.MinQuantity.ToString
		    Else
		      QuantityText = Entry.MinQuantity.ToString + RangeSeparator + Entry.MaxQuantity.ToString
		    End If
		    
		    Var WeightText As String
		    Var Weight As Double = Entry.RawWeight
		    If Floor(Weight) = Weight Then
		      WeightText = Weight.ToString(Locale.Current, ",##0")
		    Else
		      WeightText = Weight.ToString(Locale.Current, ",##0.0####")
		    End If
		    
		    Var BlueprintText As String = BlueprintChance.ToString(Locale.Current, "0%")
		    
		    Var FiguresText As String
		    
		    Var MainColumnTag As String = Entry.Label
		    Var MainColumnText As String
		    If Self.mUsingCompactMode Then
		      If Entry.Count > 1 Then
		        MainColumnText = QuantityText + " of " + MainColumnTag
		      Else
		        MainColumnText = QuantityText + " " + MainColumnTag
		      End If
		      MainColumnText = MainColumnText + EndOfLine + "Quality: " + QualityText + Encodings.UTF8.Chr(9) + "Weight: " + WeightText 
		      If Entry.CanBeBlueprint Then
		        MainColumnText = MainColumnText + Encodings.UTF8.Chr(9) + "Blueprint Chance: " + BlueprintText
		      End If
		    Else
		      MainColumnText = MainColumnTag
		      
		      FiguresText = WeightText + " wt"
		      
		      If Entry.CanBeBlueprint Then
		        FiguresText = FiguresText + ", " + BlueprintText + " bp"
		      End If
		    End If
		    
		    EntryList.AddRow("")
		    Var Idx As Integer = EntryList.LastAddedRowIndex
		    EntryList.CellValueAt(Idx, Self.ColumnLabel) = MainColumnText
		    If Self.mUsingCompactMode Then
		    Else
		      EntryList.CellValueAt(Idx, Self.ColumnQuality) = QualityText
		      EntryList.CellValueAt(Idx, Self.ColumnQuantity) = QuantityText
		      EntryList.CellValueAt(Idx, Self.ColumnFigures) = FiguresText
		    End If
		    
		    EntryList.CellTagAt(Idx, Self.ColumnLabel) = MainColumnTag
		    EntryList.RowTagAt(Idx) = Entry
		    EntryList.Selected(Idx) = Selected.IndexOf(Entry.UUID) > -1
		  Next
		  
		  Self.EntryList.Sort
		  
		  If ScrollToSelection And Self.EntryList.SelectedRowCount > 0 Then
		    Self.EntryList.EnsureSelectionIsVisible()
		  Else
		    Self.EntryList.ScrollPosition = OriginalScrollPosition
		  End If
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEntryList(ParamArray SelectEntries() As Ark.LootItemSetEntry)
		  Self.UpdateEntryList(SelectEntries)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Var TotalCount As Integer = Self.EntryList.RowCount
		  Var SelectedCount As Integer = Self.EntryList.SelectedRowCount
		  
		  Var Caption As String = TotalCount.ToString(Locale.Current, ",##0") + " " + If(TotalCount = 1, "Item Set Entry", "Item Set Entries")
		  If SelectedCount > 0 Then
		    Caption = SelectedCount.ToString(Locale.Current, ",##0") + " of " + Caption + " Selected"
		  End If
		  Self.StatusBar1.Caption = Caption
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetProject() As Ark.Project
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Updated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCompactSortDirection As Listbox.SortDirections
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpandedSortColumn As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpandedSortDirection As Listbox.SortDirections
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsingCompactMode As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnFigures, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.loot.itemsetentry", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinEditorWidth, Type = Double, Dynamic = False, Default = \"300", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events EntryList
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowIndex > -1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  #Pragma Unused Warn
		  
		  Self.RemoveSelectedEntries()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Entries() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Entries.Add(Ark.LootItemSetEntry(Me.RowTagAt(I)).SaveData)
		    End If
		  Next
		  
		  If Entries.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Contents As String
		  If Entries.LastIndex = 0 Then
		    Contents = Beacon.GenerateJSON(Entries(0), False)
		  Else
		    Contents = Beacon.GenerateJSON(Entries, False)
		  End If
		  
		  Board.RawData(Self.kClipboardType) = Contents
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Board.RawDataAvailable(Self.kClipboardType) Then
		    Return
		  End If
		  
		  Var Contents As String = DefineEncoding(Board.RawData(Self.kClipboardType), Encodings.UTF8)
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Contents)
		  Catch Err As RuntimeException
		    System.Beep
		    Return
		  End Try
		  
		  Var Modified As Boolean
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Parsed)
		  If Info.FullName = "Dictionary" Then
		    // Single item
		    Var Entry As Ark.LootItemSetEntry = Ark.LootItemSetEntry.FromSaveData(Parsed, True)
		    If (Entry Is Nil) = False Then
		      Self.LootItemSet.Add(Entry)
		      Modified = True
		    End If
		  ElseIf Info.FullName = "Object()" Then
		    // Multiple items
		    Var Dicts() As Variant = Parsed
		    For Each Dict As Dictionary In Dicts
		      Var Entry As Ark.LootItemSetEntry = Ark.LootItemSetEntry.FromSaveData(Dict, True)
		      If Entry <> Nil Then
		        Self.LootItemSet.Add(Entry)
		        Modified = True
		      End If
		    Next
		  End If
		  
		  If Modified Then
		    Self.UpdateEntryList()
		    RaiseEvent Updated
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowIndex > -1
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var CreateBlueprintItem As New MenuItem("Create Blueprint Entry", "createblueprintentry")
		  CreateBlueprintItem.Enabled = Me.SelectedRowCount > 0
		  Base.AddMenu(CreateBlueprintItem)
		  
		  Var SplitEngramsItem As New MenuItem("Split Engrams", "splitengrams")
		  SplitEngramsItem.Enabled = False
		  For I As Integer = 0 To Me.LastRowIndex
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    Var Entry As Ark.LootItemSetEntry = Me.RowTagAt(I)
		    If Entry.Count > 1 Then
		      SplitEngramsItem.Enabled = True
		      Exit
		    End If
		  Next
		  Base.AddMenu(SplitEngramsItem)
		  
		  Var MergeEngramsItem As New MenuItem("Merge Engrams", "mergeengrams")
		  MergeEngramsItem.Enabled = Me.SelectedRowCount > 1
		  Base.AddMenu(MergeEngramsItem)
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  Select Case hitItem.Tag
		  Case "createblueprintentry"
		    Var Entries() As Ark.MutableLootItemSetEntry
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.Selected(Idx) Then
		        Entries.Add(Ark.LootItemSetEntry(Me.RowTagAt(Idx)).MutableClone)
		      End If
		    Next Idx
		    
		    Var BlueprintEntry As Ark.LootItemSetEntry = Self.LootItemSet.AddBlueprintEntry(Entries)
		    If (BlueprintEntry Is Nil) = False Then
		      Self.UpdateEntryList(BlueprintEntry)
		      RaiseEvent Updated
		    Else
		      Self.ShowAlert("No changes necessary", "This feature only works on item set entries with a chance to become a blueprint.")
		    End If
		    Return True
		  Case "splitengrams"
		    Var ItemSet As Ark.MutableLootItemSet = Self.LootItemSet
		    If ItemSet Is Nil Then
		      Return True
		    End If
		    
		    Var Entries() As Ark.LootItemSetEntry
		    For I As Integer = 0 To Me.LastRowIndex
		      If Me.Selected(I) And Ark.LootItemSetEntry(Me.RowTagAt(I)).Count > 1 Then
		        Entries.Add(Me.RowTagAt(I))
		      End If
		    Next
		    
		    Var Replacements() As Ark.LootItemSetEntry = Ark.LootItemSetEntry.Split(Entries)
		    If Replacements = Nil Or Replacements.LastIndex = -1 Then
		      Return True
		    End If
		    
		    // This is probably not very fast, but it's accurate.
		    For Each Entry As Ark.LootItemSetEntry In Entries
		      Var Idx As Integer = ItemSet.IndexOf(Entry)
		      If Idx > -1 Then
		        ItemSet.RemoveAt(Idx)
		      End If
		    Next
		    
		    For Each Replacement As Ark.LootItemSetEntry In Replacements
		      ItemSet.Add(Replacement)
		    Next
		    Self.UpdateEntryList(Replacements)
		    RaiseEvent Updated
		    Return True
		  Case "mergeengrams"
		    Var ItemSet As Ark.MutableLootItemSet = Self.LootItemSet
		    If ItemSet Is Nil Then
		      Return True
		    End If
		    
		    Var Entries() As Ark.LootItemSetEntry
		    For I As Integer = 0 To Me.LastRowIndex
		      If Me.Selected(I) Then
		        Entries.Add(Me.RowTagAt(I))
		      End If
		    Next
		    
		    Var Replacement As Ark.LootItemSetEntry = Ark.LootItemSetEntry.Merge(Entries)
		    If Replacement = Nil Then
		      Return True
		    End If
		    
		    // This is probably not very fast, but it's accurate.
		    For Each Entry As Ark.LootItemSetEntry In Entries
		      Var Idx As Integer = ItemSet.IndexOf(Entry)
		      If Idx > -1 Then
		        ItemSet.RemoveAt(Idx)
		      End If
		    Next
		    
		    ItemSet.Add(Replacement)
		    Self.UpdateEntryList(Replacement)
		    RaiseEvent Updated
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  Var EditButton As OmniBarItem = Self.EditorToolbar.Item("EditEntryButton")
		  If (EditButton Is Nil) = False Then
		    EditButton.Enabled = Me.CanEdit
		  End If
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Var Entry1 As Ark.LootItemSetEntry = Me.RowTagAt(Row1)
		  Var Entry2 As Ark.LootItemSetEntry = Me.RowTagAt(Row2)
		  
		  Var Value1, Value2 As Double
		  Select Case Column
		  Case Self.ColumnLabel
		    Result = Me.CellTagAt(Row1, Column).StringValue.Compare(Me.CellTagAt(Row2, Column).StringValue, ComparisonOptions.CaseInsensitive, Locale.Raw)
		    Return True
		  Case Self.ColumnQuantity
		    If Entry1.MinQuantity = Entry2.MinQuantity Then
		      Value1 = Entry1.MaxQuantity
		      Value2 = Entry2.MaxQuantity
		    Else
		      Value1 = Entry1.MinQuantity
		      Value2 = Entry2.MinQuantity
		    End If
		  Case Self.ColumnQuality
		    If Entry1.MinQuality = Entry2.MinQuality Then
		      Value1 = Entry1.MaxQuality.BaseValue
		      Value2 = Entry2.MaxQuality.BaseValue
		    Else
		      Value1 = Entry1.MinQuality.BaseValue
		      Value2 = Entry2.MinQuality.BaseValue
		    End If
		  Case Self.ColumnFigures
		    Value1 = Entry1.RawWeight
		    Value2 = Entry2.RawWeight
		  End Select
		  
		  If Value1 = Value2 Then
		    Result = 0
		  ElseIf Value1 > Value2 Then
		    Result = 1
		  Else
		    Result = -1
		  End If
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Settings
	#tag Event
		Sub Resized()
		  Var ListTop As Integer = Me.Top + Me.Height
		  If Self.EntryList.Top = ListTop Then
		    Return
		  End If
		  
		  Var Diff As Integer = ListTop - Self.EntryList.Top
		  Self.EntryList.Top = Self.EntryList.Top + Diff
		  Self.EntryList.Height = Self.EntryList.Height - Diff
		End Sub
	#tag EndEvent
	#tag Event
		Sub SettingsChanged()
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditorToolbar
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddEntryButton"
		    Var Entries() As Ark.LootItemSetEntry = ArkLootEntryEditor.Present(Self, Self.Project.ContentPacks)
		    If Entries = Nil Then
		      Return
		    End If
		    
		    Var ItemSet As Ark.MutableLootItemSet = Self.LootItemSet
		    If ItemSet Is Nil Then
		      Return
		    End If
		    For Each Entry As Ark.LootItemSetEntry In Entries
		      ItemSet.Add(Entry)
		    Next
		    
		    Self.UpdateEntryList(Entries)
		    RaiseEvent Updated
		  Case "EditEntryButton"
		    Self.EditSelectedEntries()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTitle("Title", "Item Set Entries"))
		  Me.Append(OmniBarItem.CreateSeparator("TitleSeparator"))
		  Me.Append(OmniBarItem.CreateButton("AddEntryButton", "New Entry", IconToolbarAdd, "Add engrams to this item set."))
		  Me.Append(OmniBarItem.CreateButton("EditEntryButton", "Edit", IconToolbarEdit, "Edit the selected entries.", False))
		  
		  Me.Item("Title").Priority = 5
		  Me.Item("TitleSeparator").Priority = 5
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
