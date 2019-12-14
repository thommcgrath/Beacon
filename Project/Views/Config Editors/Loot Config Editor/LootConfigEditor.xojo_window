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
      Borders         =   0
      BorderTop       =   False
      Caption         =   "Sources"
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
      Resizer         =   "1"
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
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
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
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "30,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   34
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
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
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
      TabStop         =   "True"
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
		  DocumentAddBeacon.Enable
		  
		  If Self.List.SelectedRowCount > 0 Then
		    DocumentDuplicateBeacon.Enable
		    DocumentRemoveBeacon.Enable
		    DocumentRebuildPresets.Enable
		    
		    Self.Editor.EnableMenuItems()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.MinimumWidth = Self.FadedSeparator1.Width + Self.ListMinWidth + LootSourceEditor.MinimumWidth
		  Self.MinimumHeight = 547
		End Sub
	#tag EndEvent

	#tag Event
		Sub ParsingFinished(ParsedData As Dictionary)
		  If ParsedData = Nil Then
		    Return
		  End If
		  
		  Var OtherConfig As BeaconConfigs.LootDrops = BeaconConfigs.LootDrops.FromImport(ParsedData, New Dictionary, Self.Document.MapCompatibility, Self.Document.Difficulty)
		  If OtherConfig = Nil Then
		    Return
		  End If
		  
		  Var Sources() As Beacon.LootSource = OtherConfig.DefinedSources
		  Var TotalNewSources As Integer = Sources.LastRowIndex + 1
		  If TotalNewSources = 0 Then
		    Return
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
		    Replace = Self.ShowConfirm("Replace " + Language.NounWithQuantity(DuplicateSourceCount, "loot source", "loot sources") + "?", DuplicateSourceCount.ToString + " of " + Language.NounWithQuantity(TotalNewSources, " loot source has already been defined in this document. Would you like to replace it?", " loot sources are already defined in this document. Would you like to replace them?"), "Replace", "Cancel")
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
		    
		    AddedSources.AddRow(Source)
		    Config.Append(Source)
		  Next
		  
		  If AddedSources.LastRowIndex > -1 Then
		    Self.Changed = True
		    Self.UpdateSourceList(AddedSources)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  If Initial Then
		    Self.SetListWidth(Preferences.SourcesSplitterPosition)
		  Else
		    Self.SetListWidth(Self.Header.Width)
		  End If
		  
		  Self.Header.ResizerEnabled = Self.Width > Self.MinimumWidth
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.LootDrops.ConfigName)
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
		  
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Issue.UserData)
		  Select Case Info.FullName
		  Case "Beacon.LootSource"
		    Dim Source As Beacon.LootSource = Issue.UserData
		    Call Self.GoToChild(Source)
		  Case "Dictionary"
		    Dim Dict As Dictionary = Issue.UserData
		    Dim Source As Beacon.LootSource
		    Dim Set As Beacon.ItemSet
		    Dim Entry As Beacon.SetEntry
		    Dim Option As Beacon.SetEntryOption
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
			Self.RemoveSelectedBeacons(True)
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddLootSource(LootSource As Beacon.LootSource)
		  Dim Arr(0) As Beacon.LootSource
		  Arr(0) = LootSource
		  Self.AddLootSources(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddLootSources(Sources() As Beacon.LootSource)
		  If Sources.LastRowIndex = -1 Then
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
		  
		  Dim Config As BeaconConfigs.LootDrops = Self.Config(True)
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
		  
		  Dim Document As Beacon.Document = Self.Document
		  Dim Config As BeaconConfigs.LootDrops
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.LootDrops(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.LootDrops(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.LootDrops
		    Self.mConfigRef = New WeakRef(Config)
		  End If
		  
		  If ForWriting And Not Document.HasConfigGroup(ConfigName) Then
		    Document.AddConfigGroup(Config)
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

	#tag Method, Flags = &h21
		Private Sub RebuildAllItemSets()
		  Dim NumChanges As UInteger = Self.Config(True).ReconfigurePresets(Self.Document.MapCompatibility, Self.Document.Mods)
		  If NumChanges = 0 Then
		    Self.ShowAlert("No item sets changed", "All item sets are already configured according to their presets.")
		    Return
		  End If
		  
		  Self.UpdateSourceList()
		  Self.Changed = Self.Changed Or Self.Document.Modified
		  
		  If NumChanges = 1 Then
		    Self.ShowAlert("1 item set changed", "Rebuilding changed 1 item set to match its preset.")
		  Else
		    Self.ShowAlert(Str(NumChanges, "-0") + " item sets changed", "Rebuilding changed " + Str(NumChanges, "-0") + " item sets to match their presets.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedBeacons(RequireConfirmation As Boolean)
		  If Self.List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  If RequireConfirmation Then
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    If Self.List.SelectedRowCount = 1 Then
		      Dialog.Message = "Are you sure you want to delete the selected loot source?"
		    Else
		      Dialog.Message = "Are you sure you want to delete these " + Str(Self.List.SelectedRowCount, "-0") + " loot sources?"
		    End If
		    Dialog.Explanation = "This action cannot be undone."
		    Dialog.ActionButton.Caption = "Delete"
		    Dialog.CancelButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		    If Choice = Dialog.CancelButton Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = Self.List.RowCount - 1 DownTo 0
		    If Self.List.Selected(I) Then
		      Self.Config(True).Remove(Beacon.LootSource(Self.List.RowTagAt(I)))
		      Self.List.RemoveRowAt(I)
		    End If
		  Next
		  
		  Self.Changed = Self.Document.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer)
		  If Self.Width < Self.MinimumWidth Then
		    // Don't compute anything
		    Return
		  End If
		  
		  Dim AvailableSpace As Integer = Self.Width - Self.FadedSeparator1.Width
		  Dim ListWidth As Integer = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - LootSourceEditor.MinimumWidth)
		  Dim EditorWidth As Integer = AvailableSpace - ListWidth
		  
		  Self.Header.Width = ListWidth
		  Self.FadedSeparator1.Left = ListWidth
		  Self.List.Width = ListWidth
		  Self.FadedSeparator2.Width = ListWidth
		  Self.StatusBar1.Width = ListWidth
		  Self.Panel.Left = Self.FadedSeparator1.Left + Self.FadedSeparator1.Width
		  Self.Panel.Width = EditorWidth
		  
		  Preferences.SourcesSplitterPosition = ListWidth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddLootSource(DuplicateSelected As Boolean = False)
		  If DuplicateSelected And Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Dim Config As BeaconConfigs.LootDrops = Self.Config(False)
		  Dim CurrentSources() As Beacon.LootSource = Config.DefinedSources
		  Dim Map As New Dictionary
		  For Each Source As Beacon.LootSource In CurrentSources
		    Map.Value(Source.ClassString) = True
		  Next
		  
		  Dim DuplicateSource As Beacon.LootSource
		  If DuplicateSelected Then
		    DuplicateSource = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  End If
		  
		  If LootSourceWizard.Present(Self, Config, Self.Document.MapCompatibility, Self.Document.Mods, DuplicateSource, DuplicateSelected) Then
		    Call Self.Config(True) // Actually saves the config to the document 
		    CurrentSources = Config.DefinedSources
		    Dim NewSources() As Beacon.LootSource
		    For Each Source As Beacon.LootSource In CurrentSources
		      If Not Map.HasKey(Source.ClassString) Then
		        NewSources.AddRow(Source)
		      End If
		    Next
		    Self.UpdateSourceList(NewSources)
		    Self.Focus = Self.List
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSourceList(SelectedSources() As Beacon.LootSource = Nil)
		  Dim VisibleSources() As Beacon.LootSource = Self.Config(False).DefinedSources
		  Beacon.Sort(VisibleSources)
		  
		  Dim SelectedClasses() As String
		  If SelectedSources <> Nil Then
		    For Each Source As Beacon.LootSource In SelectedSources
		      SelectedClasses.AddRow(Source.ClassString)
		    Next
		  Else
		    Dim Bound As Integer = Self.List.RowCount - 1
		    For I As Integer = 0 To Bound
		      If Self.List.Selected(I) Then
		        SelectedClasses.AddRow(Beacon.LootSource(Self.List.RowTagAt(I)).ClassString)
		      End If
		    Next
		  End If
		  
		  Self.List.RowCount = VisibleSources.LastRowIndex + 1
		  
		  Self.mBlockSelectionChanged = True
		  Dim Selection() As Beacon.LootSource
		  For I As Integer = 0 To VisibleSources.LastRowIndex
		    Self.List.RowTagAt(I) = VisibleSources(I)
		    Self.List.CellValueAt(I, 0) = "" // Causes a redraw of the cell
		    Self.List.CellValueAt(I, 1) = VisibleSources(I).Label
		    If SelectedClasses.IndexOf(VisibleSources(I).ClassString) > -1 Then
		      Self.List.Selected(I) = True
		      Selection.AddRow(VisibleSources(I))
		    Else
		      Self.List.Selected(I) = False
		    End If
		  Next
		  Self.mBlockSelectionChanged = False
		  
		  Editor.Sources = Selection
		  If Selection.LastRowIndex = -1 Then
		    Panel.SelectedPanelIndex = 0
		  Else
		    Panel.SelectedPanelIndex = 1
		  End If
		  
		  Self.Header.Rebuild.Enabled = VisibleSources.LastRowIndex > -1
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Dim TotalCount As UInteger = Self.List.RowCount
		  Dim SelectedCount As UInteger = Self.List.SelectedRowCount
		  
		  Dim Caption As String = Format(TotalCount, "0,") + " " + If(TotalCount = 1, "Loot Source", "Loot Sources")
		  If SelectedCount > 0 Then
		    Caption = Format(SelectedCount, "0,") + " of " + Caption + " Selected"
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

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub Open()
		  Dim AddButton As New BeaconToolbarItem("AddSource", IconToolbarAdd)
		  AddButton.HasMenu = True
		  AddButton.HelpTag = "Define an additional loot source. Hold to quickly add a source from a menu."
		  
		  Dim DuplicateButton As New BeaconToolbarItem("Duplicate", IconToolbarClone, False)
		  DuplicateButton.HelpTag = "Duplicate the selected loot source."
		  
		  Dim RebuildButton As New BeaconToolbarItem("Rebuild", IconToolbarRebuild, Self.Config(False).LastRowIndex > -1)
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
		    Dim LootSources() As Beacon.LootSource = Beacon.Data.SearchForLootSources("", Self.Document.Mods, Preferences.ShowExperimentalLootSources)
		    Dim HasExperimentalSources As Boolean = LocalData.SharedInstance.HasExperimentalLootSources(Self.Document.Mods)
		    Dim Config As BeaconConfigs.LootDrops = Self.Config(False)
		    Dim Mask As UInt64 = Self.Document.MapCompatibility
		    If Config <> Nil Then
		      For I As Integer = LootSources.LastRowIndex DownTo 0
		        Dim Source As Beacon.LootSource = LootSources(I)
		        If Config.HasLootSource(Source) Or Source.ValidForMask(Mask) = False Then
		          LootSources.RemoveRowAt(I)
		          Continue For I
		        End If
		      Next
		    End If
		    
		    If LootSources.LastRowIndex = -1 Then
		      Dim Warning As MenuItem
		      If Mask = 0 Then
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
		      Menu.AddMenu(New MenuItem(LootSource.Label, LootSource))
		    Next
		    
		    If HasExperimentalSources Then
		      Menu.AddMenu(New MenuItem(MenuItem.TextSeparator))
		      
		      Dim ExpItem As New MenuItem("Show Experimental Sources", "toggle_experimental")
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
		    
		    Dim Tag As Variant = ChosenItem.Tag
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
		      Dim Source As Beacon.LootSource = ChosenItem.Tag
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
		  
		  Dim PrecisionX As Double = 1 / G.ScaleX
		  Dim PrecisionY As Double = 1 / G.ScaleY
		  
		  If Column = 0 Then
		    Dim Source As Beacon.LootSource = Me.RowTagAt(Row)
		    Dim Icon As Picture = LocalData.SharedInstance.IconForLootSource(Source, BackgroundColor)
		    Dim SpaceWidth As Integer = Me.ColumnAt(Column).WidthActual
		    Dim SpaceHeight As Integer = Me.DefaultRowHeight
		    
		    G.DrawPicture(Icon, NearestMultiple((SpaceWidth - Icon.Width) / 2, PrecisionX), NearestMultiple((SpaceHeight - Icon.Height) / 2, PrecisionY))
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
		  Self.RemoveSelectedBeacons(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  If Me.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Dim Lines() As String
		  Dim Dicts() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Dim Source As Beacon.LootSource = Me.RowTagAt(I)
		      Dicts.AddRow(Source.Export)
		      If Source.IsValid(Self.Document) Then
		        Lines.AddRow("ConfigOverrideSupplyCrateItems=" + Source.StringValue(Self.Document.Difficulty))
		      End If
		    End If
		  Next
		  
		  Dim RawData As String
		  If Dicts.LastRowIndex = 0 Then
		    RawData = Beacon.GenerateJSON(Dicts(0), False)
		  Else
		    RawData = Beacon.GenerateJSON(Dicts, False)
		  End If
		  
		  Board.AddRawData(RawData, Self.kClipboardType)
		  Board.Text = Lines.Join(Encodings.UTF8.Chr(10))
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim Contents As String = DefineEncoding(Board.RawData(Self.kClipboardType), Encodings.UTF8)
		    Dim Parsed As Variant
		    Try
		      Parsed = Beacon.ParseJSON(Contents)
		    Catch Err As RuntimeException
		      System.Beep
		      Return
		    End Try
		    
		    Dim Info As Introspection.TypeInfo = Introspection.GetType(Parsed)
		    Dim Dicts() As Dictionary
		    If Info.FullName = "Dictionary" Then
		      Dicts.AddRow(Parsed)
		    ElseIf Info.FullName = "Object()" Then
		      Dim Values() As Variant = Parsed
		      For Each Dict As Dictionary In Values
		        Dicts.AddRow(Dict)
		      Next
		    Else
		      System.Beep
		      Return
		    End If
		    
		    Dim Sources() As Beacon.LootSource
		    For Each Dict As Dictionary In Dicts
		      Sources.AddRow(Beacon.LootSource.ImportFromBeacon(Dict))
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
		  
		  Dim Sources() As Beacon.LootSource
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Sources.AddRow(Me.RowTagAt(I))
		    End If
		  Next
		  
		  Editor.Sources = Sources
		  If Sources.LastRowIndex = -1 Then
		    Panel.SelectedPanelIndex = 0
		  Else
		    Panel.SelectedPanelIndex = 1
		  End If
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function RowIsInvalid(Row As Integer) As Boolean
		  Dim Source As Beacon.LootSource = Me.RowTagAt(Row)
		  Return Not Source.IsValid(Self.Document)
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Config As BeaconConfigs.LootDrops = Self.Config(False)
		    If LootSourceWizard.Present(Self, Config, Self.Document.MapCompatibility, Self.Document.Mods, Me.RowTagAt(I)) Then
		      Call Self.Config(True) // Actually saves the config to the document
		      Self.UpdateSourceList()
		      Self.Changed = True
		    End If
		    
		    Return
		  Next
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
		  Dim Config As BeaconConfigs.LootDrops = Self.Config(False)
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
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
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
