#tag Window
Begin ConfigEditor SpawnPointsConfigEditor
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
   Height          =   548
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
   Width           =   980
   Begin BeaconToolbar ControlToolbar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderBottom    =   True
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   "Spawn Points"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
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
      Visible         =   True
      Width           =   250
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   486
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
      SelectionChangeBlocked=   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   250
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin StatusBar ListStatus
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Borders         =   1
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   21
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   527
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
   Begin FadedSeparator MainSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   548
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
      Visible         =   True
      Width           =   1
   End
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   548
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
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   729
      Begin SpawnPointEditor Editor
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
         Height          =   548
         InitialParent   =   "Pages"
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
         Visible         =   True
         Width           =   729
      End
      Begin StatusBar NoSelectionStatusBar
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Borders         =   2
         Caption         =   ""
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   21
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         Top             =   527
         Transparent     =   True
         Visible         =   True
         Width           =   729
      End
      Begin LogoFillCanvas NoSelectionFillCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Caption         =   "No Selection"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   527
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         Visible         =   True
         Width           =   729
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  EditorMenu.Child("ConvertCreatureReplacementsToSpawnPointAdditions").Enable
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  Var ConvertReplacements As New MenuItem("Convert Creature Replacements to Spawn Point Additions")
		  ConvertReplacements.Enabled = True
		  ConvertReplacements.AutoEnabled = False
		  ConvertReplacements.Name = "ConvertCreatureReplacementsToSpawnPointAdditions"
		  Items.AddRow(ConvertReplacements)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.MinimumWidth = Self.ListMinWidth + Self.MainSeparator.Width + SpawnPointEditor.MinimumWidth
		  Self.MinimumHeight = 350
		End Sub
	#tag EndEvent

	#tag Event
		Sub ParsingFinished(ParsedData As Dictionary)
		  Var ParsedConfig As BeaconConfigs.SpawnPoints = BeaconConfigs.SpawnPoints.FromImport(ParsedData, New Dictionary, Self.Document.MapCompatibility, Self.Document.Difficulty)
		  If ParsedConfig = Nil Or ParsedConfig.Count = 0 Then
		    Self.ShowAlert("No spawn points to import", "The parsed ini content did not contain any spawn point data.")
		    Return
		  End If
		  
		  Self.HandlePastedSpawnPoints(ParsedConfig.All)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  If Initial Then
		    Self.SetListWidth(Preferences.SpawnPointsSplitterPosition)
		  Else
		    Self.SetListWidth(Self.ControlToolbar.Width)
		  End If
		  
		  Self.ControlToolbar.ResizerEnabled = Self.Width > Self.MinimumWidth
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.SpawnPoints.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function ConvertCreatureReplacementsToSpawnPointAdditions() As Boolean Handles ConvertCreatureReplacementsToSpawnPointAdditions.Action
			Var Changes As Integer = Self.Document.ConvertDinoReplacementsToSpawnOverrides()
			Self.SetupUI()
			If Changes = 0 Then
			Self.ShowAlert("No changes made", "Beacon was unable to find any replaced creatures in Creature Adjustments that it could convert into spawn point additions.")
			ElseIf Changes = 1 Then
			Self.ShowAlert("Converted 1 creature replacement", "Beacon found 1 creature in Creature Adjustments that it was able to convert into spawn point additions. The replaced creature has been disabled in Creature Adjustments.")
			Else
			Self.ShowAlert("Converted " + Changes.ToString + " creature replacements", "Beacon found " + Changes.ToString + " creatures in Creature Adjustments that it was able to convert into spawn point additions. The replaced creatures have been disabled in Creature Adjustments.")
			End If
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.SpawnPoints
		  Static ConfigName As String = BeaconConfigs.SpawnPoints.ConfigName
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.SpawnPoints
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.SpawnPoints(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.SpawnPoints(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.SpawnPoints
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
		  Return Language.LabelForConfig(BeaconConfigs.SpawnPoints.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandlePastedSpawnPoints(SpawnPoints() As Beacon.SpawnPoint)
		  If SpawnPoints.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.SpawnPoints = Self.Config(True)
		  For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		    Config.Add(SpawnPoint)
		  Next
		  
		  Self.Changed = Config.Modified
		  Self.UpdateList(SpawnPoints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer)
		  If Self.Width < Self.MinimumWidth Then
		    // Don't compute anything
		    Return
		  End If
		  
		  Var AvailableSpace As Integer = Self.Width - Self.MainSeparator.Width
		  Var ListWidth As Integer = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - SpawnPointEditor.MinimumWidth)
		  Var EditorWidth As Integer = AvailableSpace - ListWidth
		  
		  Self.ControlToolbar.Width = ListWidth
		  Self.MainSeparator.Left = ListWidth
		  Self.List.Width = ListWidth
		  Self.ListStatus.Width = ListWidth
		  Self.Pages.Left = Self.MainSeparator.Left + Self.MainSeparator.Width
		  Self.Pages.Width = EditorWidth
		  
		  Preferences.SpawnPointsSplitterPosition = ListWidth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var SpawnPoints() As Beacon.SpawnPoint
		  Var Bound As Integer = Self.List.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Self.List.Selected(I) Then
		      SpawnPoints.AddRow(Self.List.RowTagAt(I))
		    End If
		  Next
		  Self.UpdateList(SpawnPoints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectedPoints() As Beacon.SpawnPoint)
		  Var Config As BeaconConfigs.SpawnPoints = Self.Config(False)
		  Var SpawnPoints() As Beacon.SpawnPoint = Config.All
		  Var Selected As New Dictionary
		  For Each SpawnPoint As Beacon.SpawnPoint In SelectedPoints
		    Selected.Value(SpawnPoint.UniqueKey) = True
		  Next
		  
		  Var Labels As Dictionary = LocalData.SharedInstance.SpawnPointLabels(Self.Document.MapCompatibility)
		  
		  Self.List.SelectionChangeBlocked = True
		  Self.List.RowCount = Config.Count
		  For I As Integer = 0 To SpawnPoints.LastRowIndex
		    Var Prefix As String
		    Select Case SpawnPoints(I).Mode
		    Case Beacon.SpawnPoint.ModeOverride
		      Prefix = "Replace"
		    Case Beacon.SpawnPoint.ModeAppend
		      Prefix = "Add to"
		    Case Beacon.SpawnPoint.ModeRemove
		      Prefix = "Remove from"
		    End Select
		    
		    Self.List.CellValueAt(I, 0) = Prefix + " " + Labels.Lookup(SpawnPoints(I).Path, SpawnPoints(I).Label).StringValue
		    Self.List.RowTagAt(I) = SpawnPoints(I)
		    Self.List.Selected(I) = Selected.HasKey(SpawnPoints(I).UniqueKey)
		  Next
		  Self.List.SortingColumn = 0
		  Self.List.Sort
		  Self.List.SelectionChangeBlocked = False
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  If Self.List.SelectedRowCount > 0 Then
		    Self.ListStatus.Caption = Self.List.SelectedRowCount.ToString + " of " + Language.NounWithQuantity(Self.List.RowCount, "Spawn Point", "Spawn Points") + " Selected"
		  Else
		    Self.ListStatus.Caption = Language.NounWithQuantity(Self.List.RowCount, "Spawn Point", "Spawn Points")
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.spawnpoint", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events ControlToolbar
	#tag Event
		Sub Open()
		  Var AddButton As New BeaconToolbarItem("AddButton", IconToolbarAdd)
		  AddButton.HelpTag = "Override a spawn point."
		  
		  Var DuplicateButton As New BeaconToolbarItem("DuplicateButton", IconToolbarClone, False)
		  DuplicateButton.HelpTag = "Duplicate the selected spawn point."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.LeftItems.Append(DuplicateButton)
		  
		  // Sometimes Xojo feels like changing the value of this property for... reasons
		  Me.Borders = BeaconUI.BorderBottom
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddButton"
		    Var SpawnPoints() As Beacon.SpawnPoint = AddSpawnPointDialog.Present(Self, Self.Document)
		    If SpawnPoints.LastRowIndex = -1 Then
		      Return
		    End If
		    
		    Var Config As BeaconConfigs.SpawnPoints = Self.Config(True)
		    For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		      Config.Add(SpawnPoint)
		    Next
		    
		    Self.Changed = Config.Modified
		    Self.UpdateList(SpawnPoints)
		  Case "DuplicateButton"
		    Var TargetSpawnPoints() As Beacon.SpawnPoint = AddSpawnPointDialog.Present(Self, Self.Document, AddSpawnPointDialog.UIModeDuplicate)
		    If TargetSpawnPoints.LastRowIndex = -1 Then
		      Return
		    End If
		    
		    Var SourceSpawnPoint As Beacon.SpawnPoint = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		    Var SourceLimits As String = SourceSpawnPoint.LimitsString
		    Var SourceSets As String = SourceSpawnPoint.SetsString
		    Var Config As BeaconConfigs.SpawnPoints = Self.Config(True)
		    For Each Target As Beacon.SpawnPoint In TargetSpawnPoints
		      Var SpawnPoint As New Beacon.MutableSpawnPoint(Target)
		      SpawnPoint.Mode = SourceSpawnPoint.Mode
		      SpawnPoint.LimitsString = SourceLimits
		      SpawnPoint.SetsString = SourceSets
		      Config.Add(SpawnPoint)
		    Next
		    
		    Self.Changed = Config.Modified
		    Self.UpdateList(TargetSpawnPoints)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  Self.SetListWidth(NewSize)
		  NewSize = Me.Width
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  Var SpawnPoints() As Beacon.SpawnPoint
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) Then
		      SpawnPoints.AddRow(Me.RowTagAt(I))
		    End If
		  Next
		  
		  Self.Editor.SpawnPoints = SpawnPoints
		  Self.ControlToolbar.DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  Self.Pages.SelectedPanelIndex = If(SpawnPoints.LastRowIndex = -1, 0, 1)
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
		  Var Bound As Integer = Me.RowCount - 1
		  Var Config As BeaconConfigs.SpawnPoints = Self.Config(True)
		  Var Points() As Beacon.SpawnPoint
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Points.AddRow(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Points, "spawn point", "spawn points") = False Then
		    Return
		  End If
		  
		  For Each Point As Beacon.SpawnPoint In Points
		    Config.Remove(Point)
		  Next
		  
		  Self.UpdateList()
		  Self.Changed = Config.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var SaveData() As Dictionary
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var SpawnPoint As Beacon.SpawnPoint = Me.RowTagAt(I)
		    SaveData.AddRow(SpawnPoint.SaveData)
		  Next
		  
		  Board.AddRawData(Beacon.GenerateJSON(SaveData, False), Self.kClipboardType)
		  
		  If Not BeaconConfigs.ConfigPurchased(BeaconConfigs.SpawnPoints.ConfigName, App.IdentityManager.CurrentIdentity.OmniVersion) Then
		    Return
		  End If
		  
		  Var Lines() As String
		  For I As Integer = 0 To Bound
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var SpawnPoint As Beacon.SpawnPoint = Me.RowTagAt(I)
		    Var Value As Beacon.ConfigValue = BeaconConfigs.SpawnPoints.ConfigValueForSpawnPoint(SpawnPoint)
		    If Value <> Nil Then
		      Lines.AddRow(Value.Key + "=" + Value.Value)
		    End If
		  Next
		  
		  Board.Text = Lines.Join(EndOfLine)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Return True
		  End If
		  
		  If Not Board.TextAvailable Then
		    Return False
		  End If
		  
		  Var CopiedText As String = Board.Text.Left(38)
		  Return CopiedText.IndexOf("ConfigOverrideNPCSpawnEntriesContainer") > -1 Or CopiedText.IndexOf("ConfigAddNPCSpawnEntriesContainer") > -1 Or CopiedText.IndexOf("ConfigSubtractNPCSpawnEntriesContainer") > -1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Try
		      Var Parsed() As Variant = Beacon.ParseJSON(Board.RawData(Self.kClipboardType))
		      Var SpawnPoints() As Beacon.SpawnPoint
		      For Each Dict As Dictionary In Parsed
		        Var SpawnPoint As Beacon.SpawnPoint = Beacon.SpawnPoint.FromSaveData(Dict)
		        If SpawnPoint <> Nil Then
		          SpawnPoints.AddRow(SpawnPoint)
		        End If
		      Next
		      Self.HandlePastedSpawnPoints(SpawnPoints)
		    Catch Err As RuntimeException
		    End Try
		  ElseIf Board.TextAvailable Then
		    Self.Parse(Board.Text, "Clipboard")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 0 Then
		    Return False
		  End If
		  
		  Var Point1 As Beacon.SpawnPoint = Me.RowTagAt(Row1)
		  Var Point2 As Beacon.SpawnPoint = Me.RowTagAt(Row2)
		  
		  If Point1 = Nil Or Point2 = Nil Then
		    Return False
		  End If
		  
		  Result = Point1.Label.Compare(Point2.Label)
		  If Result <> 0 Then
		    Return True
		  End If
		  
		  If Point1.Mode < Point2.Mode Then
		    Result = -1
		  ElseIf Point1.Mode > Point2.Mode Then
		    Result = 1
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Function GetDocument() As Beacon.Document
		  Return Self.Document
		End Function
	#tag EndEvent
	#tag Event
		Sub Changed()
		  Var Config As BeaconConfigs.SpawnPoints = Self.Config(True)
		  Var Points() As Beacon.SpawnPoint = Me.SpawnPoints
		  Var PathMap As New Dictionary
		  For Each Point As Beacon.SpawnPoint In Points
		    Config.Add(Point)
		    PathMap.Value(Point.UniqueKey) = Point
		  Next
		  For I As Integer = 0 To Self.List.RowCount - 1
		    Var Point As Beacon.SpawnPoint = Self.List.RowTagAt(I)
		    If Not PathMap.HasKey(Point.UniqueKey) Then
		      Continue
		    End If
		    
		    Var NewPoint As Beacon.SpawnPoint = PathMap.Value(Point.UniqueKey)
		    Self.List.RowTagAt(I) = NewPoint
		  Next
		  
		  Self.Changed = Self.Config(False).Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
