#tag Window
Begin ConfigEditor CraftingCostsConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   396
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
   Width           =   650
   Begin StatusBar ListStatusBar
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   375
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   250
   End
   Begin BeaconListbox List
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
      DefaultRowHeight=   26
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
      Height          =   334
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
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
   Begin FadedSeparator ListSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   396
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin PagePanel Panel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   396
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   399
      Begin CraftingCostEditor Editor
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   396
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
         Width           =   399
      End
      Begin LogoFillCanvas FillCanvas
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "No Selection"
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   396
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
         Width           =   399
      End
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "Multiple Selection"
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   396
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
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   399
      End
   End
   Begin Thread FibercraftBuilderThread
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
   Begin Thread AdjusterThread
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
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
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
      RightPadding    =   10
      Scope           =   2
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
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  Self.EnableEditorMenuItem("CreateFibercraftServer")
		  Self.EnableEditorMenuItem("AdjustCosts")
		  Self.EnableEditorMenuItem("SetupElementTransfer")
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  Var CreateFibercraftItem As New MenuItem("Setup Fibercraft Server")
		  CreateFibercraftItem.Name = "CreateFibercraftServer"
		  CreateFibercraftItem.AutoEnabled = False
		  Items.Add(CreateFibercraftItem)
		  
		  Var AdjustCostsItem As New MenuItem("Adjust All Crafting Costs")
		  AdjustCostsItem.Name = "AdjustCosts"
		  AdjustCostsItem.AutoEnabled = False
		  Items.Add(AdjustCostsItem)
		  
		  Var SetupElementTransferItem As New MenuItem("Setup Transferrable Element")
		  SetupElementTransferItem.Name = "SetupElementTransfer"
		  SetupElementTransferItem.AutoEnabled = False
		  Items.Add(SetupElementTransferItem)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.SetListWidth(Self.ListMinWidth)
		  Self.MinimumWidth = Self.ListMinWidth + Self.ListSeparator.Width + Self.Editor.MinimumWidth
		End Sub
	#tag EndEvent

	#tag Event
		Function ParsingFinished(Document As Beacon.Document) As Boolean
		  If Document Is Nil Or Document.HasConfigGroup(BeaconConfigs.CraftingCosts.ConfigName) = False Then
		    Return True
		  End If
		  
		  Var OtherConfig As BeaconConfigs.CraftingCosts = BeaconConfigs.CraftingCosts(Document.ConfigGroup(BeaconConfigs.CraftingCosts.ConfigName))
		  If OtherConfig = Nil Or OtherConfig.Count = 0 Then
		    Return True
		  End If
		  
		  Var Config As BeaconConfigs.CraftingCosts = Self.Config(True)
		  Var NewCosts() As Beacon.CraftingCost
		  Var NewEngrams() As Beacon.Engram = OtherConfig.Engrams
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Cost(Engram) = OtherConfig.Cost(Engram)
		    NewCosts.Add(Config.Cost(Engram))
		  Next
		  
		  Self.Changed = True
		  Self.UpdateList(NewCosts)
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Self.SetListWidth(Self.Width * 0.4)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.CraftingCosts.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShowIssue(Issue As Beacon.Issue)
		  If Issue = Nil Or Issue.UserData = Nil Then
		    Return
		  End If
		  
		  Try
		    Var Cost As Beacon.CraftingCost = Issue.UserData
		    If Cost <> Nil Then
		      Self.UpdateList(Cost)
		    End If
		  Catch Err As RuntimeException
		    Return
		  End Try
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function AdjustCosts() As Boolean Handles AdjustCosts.Action
			Self.AdjustCosts()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CreateFibercraftServer() As Boolean Handles CreateFibercraftServer.Action
			Self.CreateFibercraftServer()
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SetupElementTransfer() As Boolean Handles SetupElementTransfer.Action
			Var Config As BeaconConfigs.CraftingCosts = Self.Config(False)
			If SetupTransferrableElementDialog.Present(Self, Config, Self.Document.Mods) Then
			Call Self.Config(True) // Forces adding the config to the file
			Self.UpdateList()
			Self.Changed = Config.Modified
			End If
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AdjustCosts()
		  // We need to adjust the currently defined costs, as well as inject new costs at the adjusted rate
		  Var Multiplier As Double = AdjustCostDialog.Present(Self)
		  If Multiplier = 1.0 Then
		    Return
		  End If
		  
		  If Self.AdjusterThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Return
		  End If
		  
		  Self.mCostMultiplier = Multiplier
		  Self.mProgressWindow = New ProgressWindow("Calculating new costs")
		  Self.mProgressWindow.ShowWithin(Self.TrueWindow)
		  Self.AdjusterThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.CraftingCosts
		  Static ConfigName As String = BeaconConfigs.CraftingCosts.ConfigName
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.CraftingCosts
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.CraftingCosts(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.CraftingCosts(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.CraftingCosts
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
		  Return Language.LabelForConfig(BeaconConfigs.CraftingCosts.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateFibercraftServer()
		  If Self.FibercraftBuilderThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Return
		  End If
		  
		  Self.mProgressWindow = New ProgressWindow("Setting up fibercraft config")
		  Self.mProgressWindow.ShowWithin(Self.TrueWindow)
		  Self.FibercraftBuilderThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer)
		  If Self.Width < Self.MinimumWidth Then
		    // Don't compute anything
		    Return
		  End If
		  
		  Var AvailableSpace As Integer = Self.Width - Self.ListSeparator.Width
		  Var ListWidth As Integer = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - CraftingCostEditor.MinimumWidth)
		  Var EditorWidth As Integer = AvailableSpace - ListWidth
		  
		  Self.ConfigToolbar.Width = ListWidth
		  Self.List.Width = ListWidth
		  Self.ListSeparator.Left = ListWidth
		  Self.ListStatusBar.Width = ListWidth
		  Self.Panel.Left = Self.ListSeparator.Left + Self.ListSeparator.Width
		  Self.Panel.Width = EditorWidth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddEngram()
		  Var Config As BeaconConfigs.CraftingCosts = Self.Config(False)
		  Var CurrentEngrams() As Beacon.Engram = Config.Engrams
		  
		  Var WithDefaults As Boolean = True
		  Var NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Crafting", CurrentEngrams, Self.Document.Mods, EngramSelectorDialog.SelectModes.ImpliedMultiple, WithDefaults)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  Var NewCosts() As Beacon.CraftingCost
		  For Each Engram As Beacon.Engram In NewEngrams
		    Var Cost As New Beacon.CraftingCost(Engram, WithDefaults)
		    Config.Add(Cost)
		    NewCosts.Add(Cost)
		  Next
		  
		  Self.UpdateList(NewCosts)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicateSelection()
		  If Self.List.SelectedRowCount <> 1 Or Self.List.SelectedRowIndex < 0 Or Self.List.SelectedRowIndex >= Self.List.RowCount Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.CraftingCosts = Self.Config(False)
		  Var CurrentEngrams() As Beacon.Engram = Config.Engrams
		  
		  Var NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Crafting", CurrentEngrams, Self.Document.Mods, EngramSelectorDialog.SelectModes.ExplicitMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var SourceCost As Beacon.CraftingCost = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Config = Self.Config(True)
		  
		  Var NewCosts() As Beacon.CraftingCost
		  For Each Engram As Beacon.Engram In NewEngrams
		    Var Cost As New Beacon.CraftingCost(SourceCost)
		    Cost.Engram = Engram
		    Config.Add(Cost)
		    NewCosts.Add(Cost)
		  Next
		  
		  Self.UpdateList(NewCosts)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Arr() As Beacon.CraftingCost
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Arr.Add(Self.List.RowTagAt(I))
		  Next
		  Self.UpdateList(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectItems() As Beacon.CraftingCost)
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Var ObjectIDs() As String
		  For Each Item As Beacon.CraftingCost In SelectItems
		    ObjectIDs.Add(Item.ObjectID)
		  Next
		  
		  Self.List.RemoveAllRows
		  Var Config As BeaconConfigs.CraftingCosts = Self.Config(False)
		  Var Engrams() As Beacon.Engram = Config.Engrams
		  For I As Integer = 0 To Engrams.LastIndex
		    Var Cost As Beacon.CraftingCost = Config.Cost(Engrams(I))
		    Self.List.AddRow(Cost.Engram.Label)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Cost
		    Self.List.Selected(Self.List.LastAddedRowIndex) = ObjectIDs.IndexOf(Cost.ObjectID) > -1
		  Next
		  
		  Self.List.Sort
		  Self.List.ScrollPosition = ScrollPosition
		  Self.List.SelectionChangeBlocked = False
		  Self.UpdateStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectItem As Beacon.CraftingCost)
		  Var Arr() As Beacon.CraftingCost
		  If SelectItem <> Nil Then
		    Arr.Add(SelectItem)
		  End If
		  Self.UpdateList(Arr)
		  Self.List.EnsureSelectionIsVisible()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Var TotalItems As Integer = Self.List.RowCount
		  Var SelectedItems As Integer = Self.List.SelectedRowCount
		  
		  Var Noun As String = If(TotalItems = 1, "Engram", "Engrams")
		  
		  If SelectedItems > 0 Then
		    Self.ListStatusBar.Caption = SelectedItems.ToString(Locale.Current, ",##0") + " of " + TotalItems.ToString(Locale.Current, ",##0") + " " + Noun + " Selected"
		  Else
		    Self.ListStatusBar.Caption = TotalItems.ToString(Locale.Raw, "0") + " " + Noun
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCostMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgressWindow As ProgressWindow
	#tag EndProperty


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.craftingcost", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"400", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PageMultipleSelection, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNoSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSingleSelection, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Change()
		  If Me.SelectedRowCount = 1 Then
		    Self.Editor.Target = Me.RowTagAt(Me.SelectedRowIndex)
		  Else
		    Self.Editor.Target = Nil
		  End If
		  
		  If Me.SelectedRowCount = 0 Then
		    Self.Panel.SelectedPanelIndex = Self.PageNoSelection
		  ElseIf Me.SelectedRowCount = 1 Then
		    Self.Panel.SelectedPanelIndex = Self.PageSingleSelection
		  Else
		    Self.Panel.SelectedPanelIndex = Self.PageMultipleSelection
		  End If
		  
		  Var DuplicateButton As OmniBarItem = Self.ConfigToolbar.Item("DuplicateButton")
		  If (DuplicateButton Is Nil) = False Then
		    DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  End If
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Costs() As Beacon.CraftingCost
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Costs.Add(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Costs, "crafting cost override", "crafting cost overrides") = False Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.CraftingCosts = Self.Config(True)
		  For Each Cost As Beacon.CraftingCost In Costs
		    Config.Remove(Cost)
		  Next
		  Self.Changed = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Return True
		  End If
		  
		  If Not Board.TextAvailable Then
		    Return False
		  End If
		  
		  Return Board.Text.IndexOf("ConfigOverrideItemCraftingCosts") > -1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  Var SelectedCosts() As Beacon.CraftingCost
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Cost As Beacon.CraftingCost = Me.RowTagAt(I)
		    SelectedCosts.Add(Cost)
		    Dicts.Add(Cost.Export)
		  Next
		  
		  Board.RawData(Self.kClipboardType) = Beacon.GenerateJSON(Dicts, False)
		  
		  If Not BeaconConfigs.ConfigPurchased(BeaconConfigs.CraftingCosts.ConfigName, App.IdentityManager.CurrentIdentity.OmniVersion) Then
		    Return
		  End If
		  
		  Var Lines() As String
		  For Each Cost As Beacon.CraftingCost In SelectedCosts
		    If Cost.Engram Is Nil Or Cost.Engram.ValidForDocument(Self.Document) = False Then
		      Continue
		    End If
		    
		    Var Config As Beacon.ConfigValue = BeaconConfigs.CraftingCosts.ConfigValueForCraftingCost(Cost)
		    If (Config Is Nil) = False Then
		      Lines.Add(Config.Command)
		    End If
		  Next
		  
		  If Lines.Count = 0 Then
		    Return
		  End If
		  
		  Board.Text = Lines.Join(EndOfLine)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.TextAvailable And Board.Text.IndexOf("ConfigOverrideItemCraftingCosts") > -1 Then
		    Var ImportText As String = Board.Text.GuessEncoding
		    Self.Parse(ImportText, "Clipboard")
		    Return
		  End If
		  
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Var Dicts() As Variant
		    Try
		      Var Contents As String = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8)
		      Dicts = Beacon.ParseJSON(Contents)
		      
		      Var Costs() As Beacon.CraftingCost
		      Var Config As BeaconConfigs.CraftingCosts = Self.Config(True)
		      For Each Dict As Dictionary In Dicts
		        Var Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromBeacon(Dict)
		        If Cost <> Nil Then
		          Config.Add(Cost)
		          Costs.Add(Cost)
		        End If
		      Next
		      
		      Self.UpdateList(Costs)
		      Self.Changed = True
		    Catch Err As RuntimeException
		      System.Beep
		    End Try
		    Return
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub ContentsChanged()
		  If Self.List.SelectedRowCount = 1 Then
		    Self.List.CellValueAt(Self.List.SelectedRowIndex, 0) = Me.Target.Label
		    Self.List.Sort
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function GetActiveMods() As Beacon.StringList
		  If Self.Document <> Nil Then
		    Return Self.Document.Mods
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events FibercraftBuilderThread
	#tag Event
		Sub Run()
		  Var Fiber As Beacon.Engram = Beacon.Data.GetEngramByID("244bc843-2540-486e-af4a-8824500c0e56")
		  
		  Var Config As BeaconConfigs.CraftingCosts = Self.Config(False)
		  Var Engrams() As Beacon.Engram = Config.Engrams
		  Var EngramDict As New Dictionary
		  For Each Engram As Beacon.Engram In Engrams
		    If Self.mProgressWindow.CancelPressed Then
		      Self.mProgressWindow.Close
		      Self.mProgressWindow = Nil
		      Return
		    End If
		    
		    EngramDict.Value(Engram.ObjectID) = Engram
		  Next
		  
		  Engrams = Beacon.Data.SearchForEngrams("", Self.Document.Mods, "blueprintable")
		  For Each Engram As Beacon.Engram In Engrams
		    If Self.mProgressWindow.CancelPressed Then
		      Self.mProgressWindow.Close
		      Self.mProgressWindow = Nil
		      Return
		    End If
		    
		    EngramDict.Value(Engram.ObjectID) = Engram
		  Next
		  
		  Config = New BeaconConfigs.CraftingCosts
		  Var NumItems As Integer = EngramDict.KeyCount
		  Var ProcessedItems As Integer
		  Self.mProgressWindow.Progress = ProcessedItems / NumItems
		  For Each Entry As DictionaryEntry In EngramDict
		    If Self.mProgressWindow.CancelPressed Then
		      Self.mProgressWindow.Close
		      Self.mProgressWindow = Nil
		      Return
		    End If
		    
		    Var Engram As Beacon.Engram = Entry.Value
		    Var Cost As New Beacon.CraftingCost(Engram)
		    Cost.Append(Fiber, 1.0, False)
		    Config.Add(Cost)
		    ProcessedItems = ProcessedItems + 1
		    Self.mProgressWindow.Progress = ProcessedItems / NumItems
		    Self.mProgressWindow.Detail = "Configured " + ProcessedItems.ToString(Locale.Current, "#,##0") + " of " + NumItems.ToString(Locale.Current, "#,##0") + " engrams"
		  Next
		  
		  Self.Document.AddConfigGroup(Config)
		  Self.mConfigRef = New WeakRef(Config)
		  
		  Self.mProgressWindow.Close
		  Self.mProgressWindow = Nil
		  
		  Var NotifyDict As New Dictionary
		  NotifyDict.Value("Finished") = True
		  Me.AddUserInterfaceUpdate(NotifyDict)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    If Dict.HasKey("Finished") And Dict.Value("Finished").BooleanValue = True THen
		      Self.SetupUI()
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AdjusterThread
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    If Dict.HasKey("Finished") And Dict.Value("Finished").BooleanValue = True THen
		      Self.SetupUI()
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub Run()
		  Var OriginalConfig As BeaconConfigs.CraftingCosts = Self.Config(False)
		  Var Engrams() As Beacon.Engram = OriginalConfig.Engrams
		  Var Filter As New Dictionary
		  For Each Engram As Beacon.Engram In Engrams
		    Filter.Value(Engram.ObjectID) = True
		  Next
		  
		  Var ObjectIDs() As String = LocalData.SharedInstance.GetObjectIDsWithCraftingCosts(Self.Document.Mods, Self.Document.MapCompatibility)
		  For Each ObjectID As String In ObjectIDs
		    If Filter.HasKey(ObjectID) Then
		      Continue
		    End If
		    
		    Var Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByID(ObjectID)
		    If (Engram Is Nil) = False Then
		      Engrams.Add(Engram)
		    End If
		  Next
		  
		  Var NumProcessed As Integer
		  Var ReplacementConfig As New BeaconConfigs.CraftingCosts
		  For Each Engram As Beacon.Engram In Engrams
		    If Self.mProgressWindow.CancelPressed Then
		      Self.mProgressWindow.Close
		      Self.mProgressWindow = Nil
		      Return
		    End If
		    
		    NumProcessed = NumProcessed + 1
		    Var Cost As Beacon.CraftingCost = OriginalConfig.Cost(Engram)
		    If Cost Is Nil Then
		      Cost = New Beacon.CraftingCost(Engram, True)
		    End If
		    
		    If Cost Is Nil Or Cost.Count = 0 Then
		      Continue
		    End If
		    
		    For IngredientIdx As Integer = 0 To Cost.LastRowIndex
		      Cost.Quantity(IngredientIdx) = Ceiling(Cost.Quantity(IngredientIdx) * Self.mCostMultiplier)
		    Next
		    
		    ReplacementConfig.Add(Cost)
		    
		    Self.mProgressWindow.Progress = NumProcessed / Engrams.Count
		    Self.mProgressWindow.Detail = "Updated " + NumProcessed.ToString(Locale.Current, ",##0") + " of " + Engrams.Count.ToString(Locale.Current, ",##0")
		  Next
		  
		  Self.Document.AddConfigGroup(ReplacementConfig)
		  Self.mConfigRef = New WeakRef(ReplacementConfig)
		  
		  Self.mProgressWindow.Close
		  Self.mProgressWindow = Nil
		  
		  Var NotifyDict As New Dictionary
		  NotifyDict.Value("Finished") = True
		  Me.AddUserInterfaceUpdate(NotifyDict)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddEngramButton"
		    Self.ShowAddEngram()
		  Case "DuplicateButton"
		    Self.ShowDuplicateSelection()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTitle("EngramsTitle", "Engrams"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddEngramButton", "New Recipe", IconToolbarAdd, "Change the recipe for a new item."))
		  Me.Append(OmniBarItem.CreateButton("DuplicateButton", "Duplicate", IconToolbarClone, "Duplicate the selected recipe.", False))
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
		InitialValue=""
		Type="Integer"
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
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="TabStop"
		Visible=true
		Group="Position"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
