#tag Window
Begin ConfigEditor ExperienceCurvesConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
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
      EraseBackground =   False
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
      EraseBackground =   True
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
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "100,200,150"
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
      InitialValue    =   "Level	Required Experience	Ascension Required"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowCount        =   0
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
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
		  
		  Dim Tag As Text = Issue.UserData
		  Dim Parts() As Text = Tag.Split(":")
		  Dim Level As Integer = Integer.FromText(Parts(1))
		  Select Case Parts(0)
		  Case "Player"
		    Self.Switcher.SelectedIndex = 1
		  Case "Dino"
		    Self.Switcher.SelectedIndex = 2
		  End Select
		  
		  Dim Levels(0) As Integer
		  Levels(0) = Level
		  Self.UpdateList(Levels)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.ExperienceCurves
		  Static ConfigName As Text = BeaconConfigs.ExperienceCurves.ConfigName
		  
		  Dim Document As Beacon.Document = Self.Document
		  Dim Config As BeaconConfigs.ExperienceCurves
		  
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
		Function ConfigLabel() As Text
		  Return Language.LabelForConfig(BeaconConfigs.ExperienceCurves.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadDefaultDinoXP()
		  If Self.Config(False).DinoLevelCap > 1 And Not Self.ShowConfirm("Are you sure you want to replace the current experience values?", "Loading Ark's default dino experience will replace your current values. Would you like to continue?", "Load", "Cancel") Then
		    Return
		  End If
		  
		  Dim Config As BeaconConfigs.ExperienceCurves = Self.Config(True)
		  Config.DinoLevelCap = LocalData.SharedInstance.GetIntegerVariable("Dino Level Cap")
		  
		  Dim TextList As Text = LocalData.SharedInstance.GetTextVariable("Dino Default Experience")
		  Dim List() As Text = TextList.Split(",")
		  For I As Integer = 0 To List.Ubound
		    Config.DinoExperience(I) = UInt64.FromText(List(I))
		  Next
		  
		  Self.UpdateList()
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadDefaultPlayerXP()
		  If Self.Config(False).PlayerLevelCap > 1 And Not Self.ShowConfirm("Are you sure you want to replace the current experience values?", "Loading Ark's default player experience will replace your current values. Would you like to continue?", "Load", "Cancel") Then
		    Return
		  End If
		  
		  Dim Config As BeaconConfigs.ExperienceCurves = Self.Config(True)
		  Config.PlayerLevelCap = LocalData.SharedInstance.GetIntegerVariable("Player Level Cap")
		  
		  Dim TextList As Text = LocalData.SharedInstance.GetTextVariable("Player Default Experience")
		  Dim List() As Text = TextList.Split(",")
		  For I As Integer = 0 To List.Ubound
		    Config.PlayerExperience(I) = UInt64.FromText(List(I))
		  Next
		  
		  Self.UpdateList()
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddExperience()
		  Dim Level As Integer
		  Dim LevelXP, MinXP As UInt64
		  Dim Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  
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
		    Dim SelectLevels(0) As Integer
		    SelectLevels(0) = Level
		    Self.UpdateList(SelectLevels)
		    Self.ContentsChanged = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddExperienceWizard()
		  Dim Level As Integer
		  Dim MinXP As UInt64
		  Dim Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  Dim Players As Boolean = Self.ViewingPlayerStats
		  
		  If Players Then
		    Level = Config.PlayerLevelCap + 1
		    MinXP = Config.PlayerMaxExperience
		  Else
		    Level = Config.DinoLevelCap + 1
		    MinXP = Config.DinoMaxExperience
		  End If
		  
		  Dim Levels() As UInt64 = ExperienceWizard.Present(Self, Level, MinXP)
		  If Levels.Ubound = -1 Then
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
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowEditExperience()
		  Dim Level, Index, CapIndex As Integer
		  Dim LevelXP, MinXP, MaxXP As UInt64
		  Dim Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  
		  Index = Self.List.ListIndex
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
		    Dim SelectLevels(0) As Integer
		    SelectLevels(0) = Level
		    Self.UpdateList(SelectLevels)
		    Self.ContentsChanged = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Dim SelectedLevels() As Integer
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Self.List.Selected(I) Then
		      SelectedLevels.Append(Val(Self.List.Cell(I, 0)))
		    End If
		  Next
		  Self.UpdateList(SelectedLevels)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectLevels() As Integer)
		  Self.List.DeleteAllRows
		  
		  Dim Config As BeaconConfigs.ExperienceCurves = Self.Config(False)
		  Dim Levels() As UInt64
		  Dim AscensionLevels, MaxLevel As Integer
		  Dim IndexOffset As Integer
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
		  
		  For I As Integer = 0 To Levels.Ubound
		    Dim Level As Integer = I + IndexOffset
		    Dim XP As UInt64 = Levels(I)
		    Dim IsAscensionLevel As Boolean = Level > (MaxLevel - AscensionLevels)
		    
		    Self.List.AddRow(Format(Level, "0,"), Format(XP, "-0,"), If(IsAscensionLevel, "Yes", "No"))
		    Self.List.Selected(Self.List.LastIndex) = SelectLevels.IndexOf(Level) > -1
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
		Sub Change()
		  Dim SettingUp As Boolean = Self.SettingUp
		  Self.SettingUp = True
		  Dim SelectedLevels() As Integer
		  Self.UpdateList(SelectedLevels)
		  Self.SettingUp = SettingUp
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnAlignment(0) = Listbox.AlignRight
		  Me.ColumnAlignment(1) = Listbox.AlignRight
		  Me.ColumnAlignment(2) = Listbox.AlignCenter
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Self.List.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Dim Count As Integer = Self.List.SelCount
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
		  
		  Dim Player As Boolean = Self.ViewingPlayerStats
		  Dim Config As BeaconConfigs.ExperienceCurves
		  Dim Modified As Boolean = Self.ContentsChanged
		  
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
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
		  
		  Dim Levels() As Integer
		  Self.UpdateList(Levels)
		  Self.ContentsChanged = Modified
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.LeftButtons.EditButton.Enabled = Me.SelCount = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  If Me.SelCount = 1 Then
		    Self.ShowEditExperience()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Progress"
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
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
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
