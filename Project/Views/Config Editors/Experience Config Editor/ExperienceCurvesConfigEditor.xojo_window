#tag Window
Begin ConfigEditor ExperienceCurvesConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   422
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
   Width           =   710
   Begin BeaconToolbar LeftButtons
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   ""
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
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   10
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   201
   End
   Begin Shelf Switcher
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      DrawCaptions    =   True
      Enabled         =   True
      Height          =   60
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      IsVertical      =   False
      Left            =   201
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   308
   End
   Begin FadedSeparator FadedSeparator1
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
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   60
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   710
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   5
      ColumnsResizable=   False
      ColumnWidths    =   "75,*,*,*,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   361
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Level	Level XP	Total XP	Ascension Required	Time in Tek Bed"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
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
      Top             =   61
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   710
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.MinimumWidth = 710
		  Self.MinimumHeight = 368
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.ExperienceCurves.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShowIssue(Issue As Beacon.Issue)
		  If Issue.UserData = Nil Then
		    Return
		  End If
		  
		  Var Tag As String = Issue.UserData
		  Var Parts() As String = Tag.Split(":")
		  Var Level As Integer = Integer.FromString(Parts(1))
		  Select Case Parts(0)
		  Case "Player"
		    Self.Switcher.SelectedIndex = 1
		  Case "Dino"
		    Self.Switcher.SelectedIndex = 2
		  End Select
		  
		  Var Levels(0) As Integer
		  Levels(0) = Level
		  Self.UpdateList(Levels)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.ExperienceCurves
		  Static ConfigName As String = BeaconConfigs.ExperienceCurves.ConfigName
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.ExperienceCurves
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.ExperienceCurves(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.ExperienceCurves(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.ExperienceCurves
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
		  Return Language.LabelForConfig(BeaconConfigs.ExperienceCurves.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadDefaultDinoXP()
		  If Self.Config(False).DinoLevelCap > 1 And Not Self.ShowConfirm("Are you sure you want to replace the current experience values?", "Loading Ark's default dino experience will replace your current values. Would you like to continue?", "Load", "Cancel") Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.ExperienceCurves = Self.Config(True)
		  Config.DinoLevelCap = LocalData.SharedInstance.GetIntegerVariable("Dino Level Cap")
		  
		  Var TextList As String = LocalData.SharedInstance.GetStringVariable("Dino Default Experience")
		  Var List() As String = TextList.Split(",")
		  For I As Integer = 0 To List.LastRowIndex
		    Config.DinoExperience(I) = UInt64.FromString(List(I))
		  Next
		  
		  Self.UpdateList()
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadDefaultPlayerXP()
		  If Self.Config(False).PlayerLevelCap > 1 And Not Self.ShowConfirm("Are you sure you want to replace the current experience values?", "Loading Ark's default player experience will replace your current values. Would you like to continue?", "Load", "Cancel") Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.ExperienceCurves = Self.Config(True)
		  Config.PlayerLevelCap = LocalData.SharedInstance.GetIntegerVariable("Player Level Cap")
		  
		  Var TextList As String = LocalData.SharedInstance.GetStringVariable("Player Default Experience")
		  Var List() As String = TextList.Split(",")
		  For I As Integer = 0 To List.LastRowIndex
		    Config.PlayerExperience(I) = UInt64.FromString(List(I))
		  Next
		  
		  Self.UpdateList()
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddExperience()
		  Var Level As Integer
		  Var LevelXP, MinXP As UInt64
		  Var Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  
		  If Self.ViewingPlayerStats Then
		    Level = Config.PlayerLevelCap + 1
		    MinXP = Config.PlayerMaxExperience
		  Else
		    Level = Config.DinoLevelCap + 1
		    MinXP = Config.DinoMaxExperience
		  End If
		  LevelXP = MinXP
		  
		  If MinXP > BeaconConfigs.ExperienceCurves.MaxSupportedXP Then
		    Self.ShowAlert("No more levels possible", "Current Max XP is greater than Ark's supported maximum of " + Format(BeaconConfigs.ExperienceCurves.MaxSupportedXP, "0,"))
		    Return
		  End If
		  
		  If ExperienceLevelEditor.Present(Self, Level, LevelXP, MinXP, BeaconConfigs.ExperienceCurves.MaxSupportedXP) Then
		    Config = Self.Config(True)
		    If Self.ViewingPlayerStats Then
		      Config.AppendPlayerExperience(LevelXP)
		    Else
		      Config.AppendDinoExperience(LevelXP)
		    End If
		    Var SelectLevels(0) As Integer
		    SelectLevels(0) = Level
		    Self.UpdateList(SelectLevels)
		    Self.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddExperienceWizard()
		  Var Level As Integer
		  Var MinXP As UInt64
		  Var Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  Var Players As Boolean = Self.ViewingPlayerStats
		  
		  If Players Then
		    Level = Config.PlayerLevelCap + 1
		    MinXP = Config.PlayerMaxExperience
		  Else
		    Level = Config.DinoLevelCap + 1
		    MinXP = Config.DinoMaxExperience
		  End If
		  
		  Var Levels() As UInt64 = ExperienceWizard.Present(Self, Level, MinXP)
		  If Levels.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  For Each LevelXP As UInt64 In Levels
		    If Players Then
		      Config.AppendPlayerExperience(LevelXP)
		    Else
		      Config.AppendDinoExperience(LevelXP)
		    End If
		  Next
		  
		  Self.UpdateList()
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowEditExperience()
		  Var Level, Index, CapIndex As Integer
		  Var LevelXP, MinXP, MaxXP As UInt64
		  Var Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  
		  Index = Self.List.SelectedRowIndex
		  Level = Index + 2
		  
		  If Self.ViewingPlayerStats Then
		    CapIndex = Config.PlayerLevelCap - 2
		    LevelXP = Config.PlayerExperience(Index)
		    MinXP = If(Index > 0, Config.PlayerExperience(Index - 1), 0)
		    MaxXP = If(Index < CapIndex, Config.PlayerExperience(Index + 1), BeaconConfigs.ExperienceCurves.MaxSupportedXP)
		  Else
		    CapIndex = Config.DinoLevelCap - 2
		    LevelXP = Config.DinoExperience(Index)
		    MinXP = If(Index > 0, Config.DinoExperience(Index - 1), 0)
		    MaxXP = If(Index < CapIndex, Config.DinoExperience(Index + 1), BeaconConfigs.ExperienceCurves.MaxSupportedXP)
		  End If
		  
		  If ExperienceLevelEditor.Present(Self, Level, LevelXP, MinXP, MaxXP) Then
		    Config = Self.Config(True)
		    If Self.ViewingPlayerStats Then
		      Config.PlayerExperience(Index) = LevelXP
		    Else
		      Config.DinoExperience(Index) = LevelXP
		    End If
		    Var SelectLevels(0) As Integer
		    SelectLevels(0) = Level
		    Self.UpdateList(SelectLevels)
		    Self.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var SelectedLevels() As Integer
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(I) Then
		      SelectedLevels.AddRow(Val(Self.List.CellValueAt(I, 0)))
		    End If
		  Next
		  Self.UpdateList(SelectedLevels)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectLevels() As Integer)
		  Self.List.RemoveAllRows
		  
		  Const TekBedMultiplier = 0.0003
		  Const TekBedMinRate = 0.05
		  Const TekBedMaxRate = 0.8
		  
		  Var Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  Var Levels() As UInt64
		  Var AscensionLevels, MaxLevel As Integer
		  Var IndexOffset As Integer
		  If Self.ViewingPlayerStats Then
		    Levels = Config.PlayerLevels
		    AscensionLevels = Config.AscensionLevels
		    MaxLevel = Config.PlayerLevelCap
		    IndexOffset = 2
		  Else
		    Levels = Config.DinoLevels
		    MaxLevel = Config.DinoLevelCap
		    IndexOffset = 1
		  End If
		  
		  Var LastXP As UInt64
		  For I As Integer = 0 To Levels.LastRowIndex
		    Var Level As Integer = I + IndexOffset
		    Var TotalXP As UInt64 = Levels(I)
		    Var LevelXP As UInt64 = TotalXP - LastXP
		    Var IsAscensionLevel As Boolean = Level > (MaxLevel - AscensionLevels)
		    LastXP = TotalXP
		    
		    Var TekBedRate As Double = Min(Max(LevelXP * TekBedMultiplier, TekBedMinRate), TekBedMaxRate)
		    Var TekBedSeconds As UInt64 = Round(LevelXP / TekBedRate)
		    
		    Var Columns(-1) As String
		    Columns.ResizeTo(Max(Self.ColumnAscension, Self.ColumnLevel, Self.ColumnLevelXP, Self.ColumnTime, Self.ColumnTotalXP))
		    Columns(Self.ColumnLevel) = Format(Level, "0,")
		    Columns(Self.ColumnLevelXP) = Format(LevelXP, "-0,")
		    Columns(Self.ColumnTotalXP) = Format(TotalXP, "-0,")
		    Columns(Self.ColumnAscension) = If(IsAscensionLevel, "Yes", "No")
		    Columns(Self.ColumnTime) = Beacon.SecondsToString(TekBedSeconds)
		    
		    Self.List.AddRow(Columns)
		    Self.List.Selected(Self.List.LastAddedRowIndex) = SelectLevels.IndexOf(Level) > -1
		  Next
		  
		  Self.List.EnsureSelectionIsVisible(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ViewingPlayerStats() As Boolean
		  Return Self.Switcher.SelectedIndex = 1
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty


	#tag Constant, Name = ColumnAscension, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLevel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLevelXP, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnTime, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnTotalXP, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events LeftButtons
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddButton"
		    Self.ShowAddExperience()
		  Case "WizardButton"
		    Self.ShowAddExperienceWizard()
		  Case "EditButton"
		    Self.ShowEditExperience()
		  Case "LoadXPButton"
		    If Self.ViewingPlayerStats Then
		      Self.LoadDefaultPlayerXP()
		    Else
		      Self.LoadDefaultDinoXP()
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("AddButton", IconToolbarAdd, "Add a level"))
		  Me.LeftItems.Append(New BeaconToolbarItem("WizardButton", IconToolbarWizard, "Add multiple levels using a configuration wizard"))
		  Me.LeftItems.Append(New BeaconToolbarItem("EditButton", IconToolbarEdit, False, "Edit the selected level"))
		  Me.LeftItems.Append(New BeaconToolbarItem("LoadXPButton", IconToolbarExperience, "Load the default experience values"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconPlayers, "Players", "players")
		  Me.Add(IconTames, "Tames", "tames")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  Var SettingUp As Boolean = Self.SettingUp
		  Self.SettingUp = True
		  Var SelectedLevels() As Integer
		  Self.UpdateList(SelectedLevels)
		  Self.SettingUp = SettingUp
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(Self.ColumnLevel) = Listbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnLevelXP) = Listbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnTotalXP) = Listbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnAscension) = Listbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnTime) = Listbox.Alignments.Left
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Self.List.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Var Count As Integer = Self.List.SelectedRowCount
		    If Count = 1 Then
		      If Not Self.ShowConfirm("Are you sure you want to delete this experience requirement?", "You will be removing the experience requirement for the selected level. All later level requirements will be moved down. For example, when deleting level 2, level 3's requirement would become the new level 2 requirement.", "Delete", "Cancel") Then
		        Return
		      End If
		    Else
		      If Not Self.ShowConfirm("Are you sure you want to delete these experience requirements?", "You will be removing the experience requirements for the selected levels. All later level requirements will be moved down. For example, when deleting level 2, level 3's requirement would become the new level 2 requirement.", "Delete", "Cancel") Then
		        Return
		      End If
		    End If
		  End If
		  
		  Var Player As Boolean = Self.ViewingPlayerStats
		  Var Config As BeaconConfigs.ExperienceCurves
		  Var Modified As Boolean = Self.Changed
		  
		  For I As Integer = Self.List.RowCount - 1 DownTo 0
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    If Config = Nil Then
		      Config = Self.Config(True)
		    End If
		    
		    If Player Then
		      Config.RemovePlayerExperience(I)
		    Else
		      Config.RemoveDinoExperience(I)
		    End If
		    
		    Modified = True
		  Next
		  
		  Var Levels() As Integer
		  Self.UpdateList(Levels)
		  Self.Changed = Modified
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.LeftButtons.EditButton.Enabled = Me.SelectedRowCount = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  If Me.SelectedRowCount = 1 Then
		    Self.ShowEditExperience()
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
