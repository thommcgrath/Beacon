#tag DesktopWindow
Begin BeaconSubview ArkSASpawnWeightsEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   508
   Index           =   -2147483648
   InitialParent   =   ""
   IsFrontmost     =   False
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Modified        =   False
   Progress        =   0.0
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   ViewIcon        =   0
   ViewTitle       =   "Untitled"
   Visible         =   True
   Width           =   914
   Begin StatusContainer StatusBar
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      CenterCaption   =   ""
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   31
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftCaption     =   ""
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      RightCaption    =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   477
      Transparent     =   True
      Visible         =   True
      Width           =   914
   End
   Begin OmniBar CommandBar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   914
   End
   Begin BeaconListbox List
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
      ColumnWidths    =   ""
      DefaultRowHeight=   34
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   436
      Index           =   -2147483648
      InitialValue    =   "Name Tag	Weight Multiplier	Override Limit	New Limit"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   914
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.UpdateList()
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Config(ForWriting As Boolean) As ArkSA.Configs.SpawnPoints
		  Return RaiseEvent GetConfig(ForWriting)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Project() As ArkSA.Project
		  Return RaiseEvent GetProject()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowMultiplierInRow(RowIdx As Integer, DinoNameTag As String, Multiplier As ArkSA.DinoSpawnWeightMultiplier)
		  Var ContentPacks As Beacon.StringList = Self.Project.ContentPacks
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  Self.ShowMultiplierInRow(RowIdx, DinoNameTag, Multiplier, DataSource, ContentPacks)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowMultiplierInRow(RowIdx As Integer, DinoNameTag As String, Multiplier As ArkSA.DinoSpawnWeightMultiplier, DataSource As ArkSA.DataSource, ContentPacks As Beacon.StringList)
		  Var Creatures() As ArkSA.Creature = DataSource.GetCreaturesWithNameTag(DinoNameTag, ContentPacks)
		  Var Unique As New Dictionary
		  For Each Creature As ArkSA.Creature In Creatures
		    Unique.Value(Creature.Label) = True
		  Next
		  Var Names() As String
		  For Each Entry As DictionaryEntry In Unique
		    Names.Add(Entry.Key)
		  Next
		  Names.Sort
		  
		  Var RowLabel As String = DinoNameTag
		  If Names.Count > 0 Then
		    RowLabel = RowLabel + EndOfLine + Language.EnglishOxfordList(Names, "and", 5)
		  End If
		  
		  Self.List.CellTextAt(RowIdx, Self.ColumnNameTag) = RowLabel
		  Self.List.CellTextAt(RowIdx, Self.ColumnMultiplier) = Multiplier.Multiplier.ToString(Locale.Current, "0.0#####")
		  Self.List.CellCheckBoxValueAt(RowIdx, Self.ColumnOverrideLimit) = (Multiplier.Limit Is Nil) = False
		  If (Multiplier.Limit Is Nil) = False Then
		    Var Percent As Double = Multiplier.Limit.DoubleValue * 100
		    Self.List.CellTextAt(RowIdx, Self.ColumnLimitPercent) = Percent.PrettyText(True) + "%"
		    Self.List.CellTypeAt(RowIdx, Self.ColumnLimitPercent) = DesktopListBox.CellTypes.TextField
		  Else
		    Self.List.CellTextAt(RowIdx, Self.ColumnLimitPercent) = "N/A"
		    Self.List.CellTypeAt(RowIdx, Self.ColumnLimitPercent) = DesktopListBox.CellTypes.Normal
		  End If
		  Self.List.RowTagAt(RowIdx) = DinoNameTag
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var NameTags() As String
		  For RowIdx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Var DinoNameTag As String = Self.List.RowTagAt(RowIdx)
		    NameTags.Add(DinoNameTag)
		  Next
		  Self.UpdateList(NameTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectNameTags() As String)
		  Var Config As ArkSA.Configs.SpawnPoints = Self.Config(False)
		  Var ContentPacks As Beacon.StringList = Self.Project.ContentPacks
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  Var NameTags() As String = Config.DinoNameTags
		  Self.List.SelectionChangeBlocked = True
		  Self.List.RowCount = NameTags.Count
		  For RowIdx As Integer = 0 To NameTags.LastIndex
		    Var DinoNameTag As String = NameTags(RowIdx)
		    Self.ShowMultiplierInRow(RowIdx, DinoNameTag, Config.WeightMultiplier(DinoNameTag), DataSource, ContentPacks)
		    Self.List.RowSelectedAt(RowIdx) = SelectNameTags.IndexOf(DinoNameTag) > -1
		  Next
		  Self.List.Sort
		  Self.List.EnsureSelectionIsVisible
		  Self.List.SelectionChangeBlocked = False
		  
		  Self.List.SizeColumnToFit(Self.ColumnMultiplier, 70)
		  Self.List.SizeColumnToFit(Self.ColumnOverrideLimit, 70)
		  Self.List.SizeColumnToFit(Self.ColumnLimitPercent, 70)
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectNameTag As String)
		  Var NameTags() As String
		  If SelectNameTag.IsEmpty = False Then
		    NameTags.Add(SelectNameTag)
		  End If
		  Self.UpdateList(NameTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Self.StatusBar.CenterCaption = Self.List.StatusMessage("Weight Multiplier", "Weight Multipliers")
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetConfig(Writable As Boolean) As ArkSA.Configs.SpawnPoints
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetProject() As ArkSA.Project
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Constant, Name = ColumnLimitPercent, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnMultiplier, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnNameTag, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnOverrideLimit, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.arksa.spawn.weightmultiplier", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events CommandBar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("AddButton", "New Multiplier", IconToolbarAdd, "Define a new spawn weight multiplier."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddButton"
		    Var DinoNameTag As String = ArkSANameTagDialog.Present(Self, Self.Project.ContentPacks)
		    If DinoNameTag.IsEmpty = False Then
		      Var Config As ArkSA.Configs.SpawnPoints = Self.Config(False)
		      If Config.HasWeightMultiplier(DinoNameTag) And Self.ShowConfirm("This name tag has already been defined. Do you want to replace it?", "The new weight multiplier will have default settings.", "Replace", "Cancel") = False Then
		        Return
		      End If
		      
		      Config = Self.Config(True)
		      Var WeightMultiplier As New ArkSA.DinoSpawnWeightMultiplier(1.0)
		      Config.WeightMultiplier(DinoNameTag) = WeightMultiplier
		      Self.Modified = True
		      
		      Self.UpdateList(DinoNameTag)
		    End If
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(Self.ColumnMultiplier) = DesktopListBox.CellTypes.TextField
		  Me.ColumnTypeAt(Self.ColumnOverrideLimit) = DesktopListBox.CellTypes.CheckBox
		  
		  Me.ColumnAlignmentAt(Self.ColumnMultiplier) = DesktopListBox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnOverrideLimit) = DesktopListBox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnLimitPercent) = DesktopListBox.Alignments.Right
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateStatus()
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
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Var DinoNameTag As String = Me.RowTagAt(Row)
		  Var OverrideLimit As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		  Var WeightMultiplier As ArkSA.DinoSpawnWeightMultiplier = Self.Config(False).WeightMultiplier(DinoNameTag)
		  Var Mutable As ArkSA.MutableDinoSpawnWeightMultiplier = WeightMultiplier.MutableVersion
		  Select Case Column
		  Case Self.ColumnMultiplier
		    Mutable.Multiplier = Double.FromString(Me.CellTextAt(Row, Column), Locale.Current)
		  Case Self.ColumnOverrideLimit
		    If OverrideLimit Then
		      Mutable.Limit = 1.0
		    Else
		      Mutable.Limit = Nil
		    End If
		  Case Self.ColumnLimitPercent
		    Mutable.Limit = Max(Min(Double.FromString(Me.CellTextAt(Row, Column).ReplaceAll("%", ""), Locale.Current) / 100, 1.0), 0.0)
		  End Select
		  Self.Config(True).WeightMultiplier(DinoNameTag) = Mutable
		  Self.Modified = Self.Config(False).Modified
		  Self.ShowMultiplierInRow(Row, DinoNameTag, Mutable)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var DinoNameTags() As String
		  For RowIdx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    DinoNameTags.Add(Me.RowTagAt(RowIdx))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(DinoNameTags, "weight multiplier", "weight multipliers") = False Then
		    Return
		  End If
		  
		  Var Config As ArkSA.Configs.SpawnPoints = Self.Config(True)
		  For Each DinoNameTag As String In DinoNameTags
		    Config.WeightMultiplier(DinoNameTag) = Nil
		  Next
		  
		  Self.UpdateList()
		  Self.Modified = Config.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var SaveData As New JSONItem
		  Var Config As ArkSA.Configs.SpawnPoints = Self.Config(False)
		  For RowIdx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Var DinoNameTag As String = Me.RowTagAt(RowIdx)
		    Var WeightMultiplier As ArkSA.DinoSpawnWeightMultiplier = Config.WeightMultiplier(DinoNameTag)
		    SaveData.Child(DinoNameTag) = WeightMultiplier.ToJSON
		  Next
		  Board.AddClipboardData(Self.kClipboardType, SaveData)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Me.EditCellAt(Me.SelectedRowIndex, Self.ColumnMultiplier)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var PasteData As JSONItem = Board.GetClipboardData(Self.kClipboardType)
		  Var Config As ArkSA.Configs.SpawnPoints
		  Var SelectNameTags() As String
		  For Idx As Integer = 0 To PasteData.LastRowIndex
		    Try
		      Var DinoNameTag As String = PasteData.KeyAt(Idx)
		      Var WeightMultiplier As ArkSA.DinoSpawnWeightMultiplier = ArkSA.DinoSpawnWeightMultiplier.FromSaveData(PasteData.Child(DinoNameTag))
		      If Config Is Nil Then
		        Config = Self.Config(True)
		      End If
		      Config.WeightMultiplier(DinoNameTag) = WeightMultiplier
		      Self.Modified = Config.Modified
		      SelectNameTags.Add(DinoNameTag)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  Self.UpdateList(SelectNameTags)
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Var DinoNameTag1 As String = Me.RowTagAt(Row1)
		  Var DinoNameTag2 As String = Me.RowTagAt(Row2)
		  
		  If Column = Self.ColumnNameTag Then
		    Result = DinoNameTag1.Compare(DinoNameTag2, ComparisonOptions.CaseInsensitive)
		    Return True
		  End If
		  
		  Var Multiplier1 As ArkSA.DinoSpawnWeightMultiplier = Self.Config(False).WeightMultiplier(DinoNameTag1)
		  Var Multiplier2 As ArkSA.DinoSpawnWeightMultiplier = Self.Config(False).WeightMultiplier(DinoNameTag2)
		  
		  Select Case Column
		  Case Self.ColumnMultiplier
		    If Multiplier1.Multiplier > Multiplier2.Multiplier Then
		      Result = 1
		    ElseIf Multiplier1.Multiplier < Multiplier2.Multiplier Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    Return True
		  Case Self.ColumnOverrideLimit
		    If (Multiplier1.Limit Is Nil) = False And Multiplier2.Limit Is Nil Then
		      Result = 1
		    ElseIf Multiplier1.Limit Is Nil And (Multiplier2.Limit Is Nil) = False Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    Return True
		  Case Self.ColumnLimitPercent
		    Var Limit1 As Double = If((Multiplier1.Limit Is Nil) = False, Multiplier1.Limit.DoubleValue, 0.0)
		    Var Limit2 As Double = If((Multiplier2.Limit Is Nil) = False, Multiplier2.Limit.DoubleValue, 0.0)
		    
		    If Limit1 > Limit2 Then
		      Result = 1
		    ElseIf Limit1 < Limit2 Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    Return True
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
