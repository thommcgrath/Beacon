#tag Window
Begin ContainerControl BeaconEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   0
      Height          =   408
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
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   31
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   190
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   464
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Left            =   190
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin SetEditor Editor
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   False
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   464
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   191
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   407
   End
   Begin FooterBar Footer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   25
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   439
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   190
   End
   Begin ListHeader Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   31
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
      SegmentIndex    =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TintColor       =   &cEAEEF100
      Title           =   "Item Sets"
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   190
   End
   Begin Beacon.ImportThread Importer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   0
      Scope           =   0
      StackSize       =   ""
      State           =   ""
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag MenuHandler
		Function DocumentRemoveItemSet() As Boolean Handles DocumentRemoveItemSet.Action
			Self.RemoveSelectedItemSet()
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
		    SetList.RowTag(SetList.LastIndex) = Set
		    SetList.ListIndex = SetList.LastIndex
		    Self.mSorting = True
		    SetList.Sort
		    Self.mSorting = False
		    RaiseEvent Updated
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddTemplate(Set As Beacon.ItemSet, ClassString As String, MinQuantity As Integer, MaxQuantity As Integer, Weight As Double = 1, MinQuality As Beacon.Qualities = Beacon.Qualities.Primitive, MaxQuality As Beacon.Qualities = Beacon.Qualities.Primitive)
		  Dim Entry As New Beacon.SetEntry
		  Entry.Append(New Beacon.SetEntryOption(Beacon.Engram.Lookup(ClassString.ToText), 1))
		  Entry.MinQuantity = MinQuantity
		  Entry.MaxQuantity = MaxQuantity
		  Entry.MinQuality = MinQuality
		  Entry.MaxQuality = MaxQuality
		  Entry.Weight = Weight
		  Entry.ChanceToBeBlueprint = 0.1
		  Set.Append(Entry)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildPresetMenu(Parent As MenuItem)
		  Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		  Dim Groups As New Dictionary
		  Dim GroupNames() As Text
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
		  
		  For Each Group As Text In GroupNames
		    Parent.Append(New MenuItem(MenuItem.TextSeparator))
		    
		    Dim Header As New MenuItem(Group)
		    Header.Enabled = False
		    Parent.Append(Header)
		    
		    Dim Arr() As Beacon.Preset = Groups.Value(Group)
		    For Each Preset As Beacon.Preset In Arr
		      If Preset.ValidForPackage(Self.mSources(0).Package) Then
		        Dim PresetItem As New MenuItem(Preset.Label, Preset)
		        AddHandler PresetItem.Action, WeakAddressOf Self.HandlePresetMenu
		        Parent.Append(PresetItem)
		      End If
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
		  If SetList.ListIndex > -1 Then
		    DocumentRemoveItemSet.Enable
		    Editor.EnableMenuItems
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandlePresetMenu(Sender As MenuItem) As Boolean
		  Dim SelectedPreset As Beacon.Preset = Sender.Tag
		  
		  If SelectedPreset = Nil Then
		    Self.AddSet(New Beacon.ItemSet)
		  Else
		    Dim Set As Beacon.ItemSet = Beacon.ItemSet.FromPreset(SelectedPreset, Self.mSources(0))
		    Self.AddSet(Set)
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
		  Self.Importer.Run(Content.ToText)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedItemSet()
		  If SetList.ListIndex = -1 Then
		    Return
		  End If
		  
		  Dim Set As Beacon.ItemSet = SetList.RowTag(SetList.ListIndex)
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Are you sure you want to delete the item set """ + Set.Label + """?"
		  Dialog.Explanation = "This action cannot be undone."
		  Dialog.ActionButton.Caption = "Delete"
		  Dialog.CancelButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		  If Choice = Dialog.CancelButton Then
		    Return
		  End If
		  
		  Dim Updated As Boolean
		  For Each Source As Beacon.LootSource In Self.mSources
		    Dim Idx As Integer = Source.IndexOf(Set)
		    If Idx > -1 Then
		      Source.Remove(Idx)
		      Updated = True
		    End If
		  Next
		  SetList.RemoveRow(SetList.ListIndex)
		  If Updated Then
		    RaiseEvent Updated
		  End If
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
		  Self.mUpdating = True
		  
		  Dim SelectedSetNames() As String
		  For I As Integer = 0 To SetList.ListCount - 1
		    If SetList.Selected(I) Then
		      SelectedSetNames.Append(SetList.Cell(I, 0))
		    End If
		  Next
		  
		  Redim Self.mSources(UBound(Values))
		  For I As Integer = 0 To UBound(Self.mSources)
		    Self.mSources(I) = Values(I)
		  Next
		  
		  // Find sets that are common to all sources
		  Dim Sets As New Dictionary
		  Dim Weights As New Dictionary
		  Dim MatchWeight As Integer = UBound(Self.mSources) + 1
		  
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
		  
		  SetList.DeleteAllRows
		  For Each Set As Beacon.ItemSet In CommonSets
		    SetList.AddRow(Set.Label)
		    SetList.RowTag(SetList.LastIndex) = Set
		    SetList.Selected(SetList.LastIndex) = SelectedSetNames.IndexOf(Set.Label) > -1
		  Next
		  Self.mSorting = True
		  SetList.Sort
		  Self.mSorting = False
		  
		  If UBound(Self.mSources) > -1 Then
		    Dim DuplicatesState As CheckBox.CheckedStates = if(Self.mSources(0).SetsRandomWithoutReplacement, CheckBox.CheckedStates.Checked, CheckBox.CheckedStates.Unchecked)
		    Dim Label As Text = Self.mSources(0).Label
		    Dim MinSets As Integer = Self.mSources(0).MinItemSets
		    Dim MaxSets As Integer = Self.mSources(0).MaxItemSets
		    
		    For I As Integer = 1 To UBound(Self.mSources)
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
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Updated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private ImportProgress As ImporterWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSorting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSources() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.itemset", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events SetList
	#tag Event
		Sub Change()
		  If Self.mSorting = True Then
		    Return
		  End If
		  
		  Footer.Button("DeleteButton").Enabled = Me.ListIndex > -1
		  
		  If Me.ListIndex = -1 Then
		    Editor.Enabled = False
		    Editor.Set = Nil
		  Else
		    Editor.Set = New Beacon.ItemSet(Me.RowTag(Me.ListIndex))
		    Editor.Enabled = True
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.ListIndex > -1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Left(Board.Text, 1) = "(")
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear()
		  Self.RemoveSelectedItemSet()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Set As Beacon.ItemSet = Me.RowTag(Me.ListIndex)
		  Dim Dict As Xojo.Core.Dictionary = Set.Export
		  If Dict <> Nil Then
		    Dim Contents As Text = Xojo.Data.GenerateJSON(Dict)
		    Board.AddRawData(Contents, Self.kClipboardType)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If UBound(Self.mSources) = -1 Then
		    Return
		  End If
		  
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim Contents As String = DefineEncoding(Board.RawData(Self.kClipboardType), Encodings.UTF8)
		    Dim Dict As Xojo.Core.Dictionary
		    Try
		      Dict = Xojo.Data.ParseJSON(Contents.ToText)
		    Catch Err As RuntimeException
		      Beep
		      Return
		    End Try
		    
		    Dim Set As Beacon.ItemSet = Beacon.ItemSet.Import(Dict, Self.mSources(0))
		    Self.AddSet(Set)
		  ElseIf Board.TextAvailable And Left(Board.Text, 1) = "(" Then
		    Dim Contents As String = Board.Text
		    If Left(Contents, 2) = "((" Then
		      // This may be multiple item sets from the dev kit, so wrap it up like a full loot source
		      Contents = "ConfigOverrideSupplyCrateItems=(SupplyCrateClassString=""SupplyCrate_Level03_C"",MinItemSets=1,MaxItemSets=3,NumItemSetsPower=1.000000,bSetsRandomWithoutReplacement=true,ItemSets=" + Contents + ")"
		      Self.Import(Contents, "Clipboard")
		    ElseIf Left(Contents, 1) = "(" Then
		      // This may be a single item set from the dev kit, so wrap it up like a full loot source
		      Contents = "ConfigOverrideSupplyCrateItems=(SupplyCrateClassString=""SupplyCrate_Level03_C"",MinItemSets=1,MaxItemSets=3,NumItemSetsPower=1.000000,bSetsRandomWithoutReplacement=true,ItemSets=(" + Contents + "))"
		      Self.Import(Contents, "Clipboard")
		    End If
		  End
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.ListIndex > -1
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim Idx As Integer = Me.RowFromXY(X, Y)
		  If Idx = -1 Then
		    Return False
		  End If
		  
		  Dim Set As Beacon.ItemSet = Me.RowTag(Idx)
		  Dim Preset As Beacon.Preset
		  If Set.SourcePresetID <> "" Then
		    Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		    For I As Integer = 0 To UBound(Presets)
		      If Presets(I).PresetID = Set.SourcePresetID Then
		        Preset = Presets(I)
		        Exit For I
		      End If
		    Next
		  End If
		  
		  Dim PresetItem As New MenuItem("Create Preset…", Set)
		  If Preset <> Nil Then
		    PresetItem.Text = "Update """ + Preset.Label + """ Preset…"
		  End If
		  PresetItem.Name = "createpreset"
		  PresetItem.Enabled = Set.Count > 0
		  Base.Append(PresetItem)
		  
		  Dim ReconfigureItem As New MenuItem("Reconfigure From Preset", Set)
		  If Preset <> Nil Then
		    ReconfigureItem.Text = "Reconfigure From """ + Preset.Label + """ Preset"
		    ReconfigureItem.Enabled = True
		  Else
		    ReconfigureItem.Enabled = False
		  End If
		  ReconfigureItem.Name = "reconfigure"
		  Base.Append(ReconfigureItem)
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If HitItem = Nil Then
		    Return False
		  End If
		  
		  Select Case HitItem.Name
		  Case "createpreset"
		    Dim Set As Beacon.ItemSet = HitItem.Tag
		    PresetWindow.Present(Set)
		  Case "reconfigure"
		    Dim Set As Beacon.ItemSet = HitItem.Tag
		    Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		    For Each Preset As Beacon.Preset In Presets
		      If Set.SourcePresetID = Preset.PresetID Then
		        Dim OriginalHash As Text = Set.Hash
		        Dim NewSet As Beacon.ItemSet = New Beacon.ItemSet(Set)
		        NewSet.ReconfigureWithPreset(Preset, Self.mSources(0))
		        If NewSet.Hash = OriginalHash Then
		          // No changes
		          Dim Dialog As New MessageDialog
		          Dialog.Title = ""
		          Dialog.Message = "No changes made"
		          Dialog.Explanation = "This item set is already identical to the preset."
		          Call Dialog.ShowModalWithin(Self.TrueWindow)
		          Return True
		        End If
		        
		        For Each Source As Beacon.LootSource In Self.mSources
		          Dim Idx As Integer = Source.IndexOf(Set)
		          If Idx > -1 Then
		            Source(Idx) = NewSet
		          End If
		        Next
		        
		        Editor.Set = NewSet
		        SetList.RowTag(SetList.ListIndex) = NewSet
		        RaiseEvent Updated
		        Exit For Preset
		      End If
		    Next
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Separators
	#tag Event
		Sub Paint(index as Integer, g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = &cCCCCCC
		  G.FillRect(-1, -1, G.Width + 2, G.Height + 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub Updated()
		  // The set needs to be cloned into each loot source
		  
		  If SetList.ListIndex = -1 Then
		    Return
		  End If
		  
		  Dim OriginalSet As Beacon.ItemSet = SetList.RowTag(SetList.ListIndex)
		  Dim NewSet As Beacon.ItemSet = Editor.Set
		  
		  SetList.Cell(SetList.ListIndex, 0) = NewSet.Label
		  Self.mSorting = True
		  SetList.Sort
		  Self.mSorting = False
		  For Each Source As Beacon.LootSource In Self.mSources
		    Dim Idx As Integer = Source.IndexOf(OriginalSet)
		    If Idx > -1 Then
		      Source(Idx) = New Beacon.ItemSet(NewSet)
		    End If
		  Next
		  
		  SetList.RowTag(SetList.ListIndex) = New Beacon.ItemSet(NewSet)
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Footer
	#tag Event
		Sub Action(Button As FooterBarButton)
		  Select Case Button.Name
		  Case "AddButton"
		    Self.AddSet(New Beacon.ItemSet)
		  Case "DeleteButton"
		    Self.RemoveSelectedItemSet()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Dim AddButton As New FooterBarButton("AddButton", IconAddWithMenu)
		  Dim DeleteButton As New FooterBarButton("DeleteButton", IconRemove)
		  
		  DeleteButton.Enabled = False
		  
		  Me.Append(AddButton)
		  Me.Append(DeleteButton)
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseHold(Button As FooterBarButton) As Boolean
		  Select Case Button.Name
		  Case "AddButton"
		    Dim Base As New MenuItem
		    Self.BuildPresetMenu(Base)
		    
		    Dim Position As Xojo.Core.Point = Self.GlobalPosition
		    Dim Choice As MenuItem = Base.PopUp(Position.X + Me.Left + Button.Left, Position.Y + Me.Top + Button.Top + Button.Height)
		    If Choice = Nil Then
		      Return True
		    End If
		    
		    Call Self.HandlePresetMenu(Choice)
		    Return True
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Resize(NewSize As Integer)
		  Me.Height = NewSize
		  SetList.Top = NewSize
		  SetList.Height = Separators(2).Top - NewSize
		  Self.Refresh(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If Me.LootSourcesProcessed = Me.BeaconCount Then
		    If Self.ImportProgress <> Nil Then
		      Self.ImportProgress.Close
		      Self.ImportProgress = Nil
		    End If
		    
		    Dim LootSources() As Beacon.LootSource = Me.LootSources
		    Me.Reset
		    
		    For Each LootSource As Beacon.LootSource In LootSources
		      For Each Set As Beacon.ItemSet In LootSource
		        Self.AddSet(Set)
		      Next
		    Next
		    Return
		  End If
		  
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.BeaconCount = Me.BeaconCount
		    Self.ImportProgress.LootSourcesProcessed = Me.LootSourcesProcessed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
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
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Type="Integer"
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
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
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
	#tag EndViewProperty
#tag EndViewBehavior
