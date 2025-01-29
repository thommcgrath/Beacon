#tag DesktopWindow
Begin ArkSAConfigEditor ArkSAExperienceEditor Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   422
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
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   710
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   5
      ColumnWidths    =   "75,*,*,*,*"
      DefaultRowHeight=   26
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
      HeadingIndex    =   -1
      Height          =   350
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
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   4
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
      Width           =   710
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin OmniBar ConfigToolbar
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
      Width           =   710
   End
   Begin StatusContainer Status
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   391
      Transparent     =   True
      Visible         =   True
      Width           =   710
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, ArkSA.Project.Notification_SinglePlayerChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.MinimumWidth = 710
		  Self.MinimumHeight = 368
		  
		  
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
		  Self.ViewingPlayerStats = (Parts(0) = "Player")
		  
		  Var Level As Integer
		  Try
		    Level = Integer.FromString(Parts(1))
		  Catch Err As RuntimeException
		    Return
		  End Try
		  Var Levels(0) As Integer
		  Levels(0) = Level
		  Self.UpdateList(Levels)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused UserData
		  #Pragma Unused FireSetupUI
		  
		  NotificationKit.Watch(Self, ArkSA.Project.Notification_SinglePlayerChanged)
		  
		  Self.ReloadDefaults()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As ArkSA.Configs.ExperienceCurves
		  Return ArkSA.Configs.ExperienceCurves(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameLevelsAndXP
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadDefaultDinoXP(Force As Boolean = False)
		  If Self.Config(False).DinoLevelCap > 1 And Force = False And Self.ShowConfirm("Are you sure you want to replace the current experience values?", "Loading Ark's default dino experience will replace your current values. Would you like to continue?", "Load", "Cancel") = False Then
		    Return
		  End If
		  
		  Var LevelCapKey, ExperienceKey As String
		  If Self.Project.IsFlagged(ArkSA.Project.FlagSinglePlayer) Then
		    LevelCapKey = "Dino Level Cap (Single)"
		    ExperienceKey = "Dino Default Experience (Single)"
		  Else
		    LevelCapKey = "Dino Level Cap"
		    ExperienceKey = "Dino Default Experience"
		  End If
		  
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(True)
		  Config.DinoLevelCap = ArkSA.DataSource.Pool.Get(False).GetIntegerVariable(LevelCapKey)
		  
		  Var TextList As String = ArkSA.DataSource.Pool.Get(False).GetStringVariable(ExperienceKey)
		  Var List() As String = TextList.Split(",")
		  For I As Integer = 0 To List.LastIndex
		    Config.DinoExperience(I) = UInt64.FromString(List(I))
		  Next
		  
		  Self.UpdateList()
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadDefaultPlayerXP(Force As Boolean = False)
		  If Self.Config(False).PlayerLevelCap > 1 And Force = False And Self.ShowConfirm("Are you sure you want to replace the current experience values?", "Loading Ark's default player experience will replace your current values. Would you like to continue?", "Load", "Cancel") = False Then
		    Return
		  End If
		  
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(True)
		  Config.PlayerLevelCap = 1
		  
		  Var LevelData As ArkSA.PlayerLevelData = ArkSA.DataSource.Pool.Get(False).OfficialPlayerLevelData(Self.Project.IsFlagged(ArkSA.Project.FlagSinglePlayer))
		  Config.PlayerLevelCap = LevelData.MaxLevel
		  For Level As Integer = 2 To LevelData.MaxLevel
		    Config.PlayerExperience(Level - 2) = LevelData.ExperienceForLevel(Level)
		  Next
		  
		  Self.UpdateList()
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case ArkSA.Project.Notification_SinglePlayerChanged
		    Var UserData As Dictionary = Notification.UserData
		    If UserData.Value("ProjectId") = Self.Project.ProjectId Then
		      Self.ReloadDefaults()
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReloadDefaults()
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(False)
		  Var IsSinglePlayer As Boolean = Self.Project.IsFlagged(ArkSA.Project.FlagSinglePlayer)
		  If Config.HasPlayerLevels And Config.MatchesPlayerDefault(Not IsSinglePlayer) Then
		    Self.LoadDefaultPlayerXP(True)
		  End If
		  If Config.HasDinoLevels And Config.MatchesDinoDefault(Not IsSinglePlayer) Then
		    Self.LoadDefaultDinoXP(True)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddExperience()
		  Var Level As Integer
		  Var LevelXP, MinXP As UInt64
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(False)
		  
		  If Self.ViewingPlayerStats Then
		    Level = Config.PlayerLevelCap + 1
		    MinXP = Config.PlayerMaxExperience
		  Else
		    Level = Config.DinoLevelCap + 1
		    MinXP = Config.DinoMaxExperience
		  End If
		  LevelXP = MinXP
		  
		  If MinXP > CType(ArkSA.Configs.ExperienceCurves.MaxSupportedXP, UInt64) Then
		    Self.ShowAlert("No more levels possible", "Current Max XP is greater than Ark's supported maximum of " + ArkSA.Configs.ExperienceCurves.MaxSupportedXP.ToString(Locale.Current, "#,##0"))
		    Return
		  End If
		  
		  If ArkSAExperienceLevelEditor.Present(Self, Level, LevelXP, MinXP, ArkSA.Configs.ExperienceCurves.MaxSupportedXP) Then
		    Config = Self.Config(True)
		    If Self.ViewingPlayerStats Then
		      Config.AppendPlayerExperience(LevelXP)
		    Else
		      Config.AppendDinoExperience(LevelXP)
		    End If
		    Var SelectLevels(0) As Integer
		    SelectLevels(0) = Level
		    Self.UpdateList(SelectLevels)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddExperienceWizard()
		  Var Level As Integer
		  Var MinXP As UInt64
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(False)
		  Var Players As Boolean = Self.ViewingPlayerStats
		  
		  If Players Then
		    Level = Config.PlayerLevelCap + 1
		    MinXP = Config.PlayerMaxExperience
		  Else
		    Level = Config.DinoLevelCap + 1
		    MinXP = Config.DinoMaxExperience
		  End If
		  
		  Var Levels() As UInt64 = ArkSAExperienceWizard.Present(Self, Level, MinXP)
		  If Levels.LastIndex = -1 Then
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
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowEditExperience()
		  Var Level, Index, CapIndex As Integer
		  Var LevelXP, MinXP, MaxXP As UInt64
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(False)
		  
		  Index = Self.List.SelectedRowIndex
		  Level = Index + 2
		  
		  If Self.ViewingPlayerStats Then
		    CapIndex = Config.PlayerLevelCap - 2
		    LevelXP = Config.PlayerExperience(Index)
		    MinXP = If(Index > 0, Config.PlayerExperience(Index - 1), CType(0, UInt64))
		    MaxXP = If(Index < CapIndex, Config.PlayerExperience(Index + 1), CType(ArkSA.Configs.ExperienceCurves.MaxSupportedXP, UInt64))
		  Else
		    CapIndex = Config.DinoLevelCap - 2
		    LevelXP = Config.DinoExperience(Index)
		    MinXP = If(Index > 0, Config.DinoExperience(Index - 1), CType(0, UInt64))
		    MaxXP = If(Index < CapIndex, Config.DinoExperience(Index + 1), CType(ArkSA.Configs.ExperienceCurves.MaxSupportedXP, UInt64))
		  End If
		  
		  If ArkSAExperienceLevelEditor.Present(Self, Level, LevelXP, MinXP, MaxXP) Then
		    Config = Self.Config(True)
		    If Self.ViewingPlayerStats Then
		      Config.PlayerExperience(Index) = LevelXP
		    Else
		      Config.DinoExperience(Index) = LevelXP
		    End If
		    Var SelectLevels(0) As Integer
		    SelectLevels(0) = Level
		    Self.UpdateList(SelectLevels)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var SelectedLevels() As Integer
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.RowSelectedAt(I) Then
		      SelectedLevels.Add(Val(Self.List.CellTextAt(I, 0)))
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
		  
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(False)
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
		  For I As Integer = 0 To Levels.LastIndex
		    Var Level As Integer = I + IndexOffset
		    Var TotalXP As UInt64 = Levels(I)
		    Var LevelXP As UInt64 = If(TotalXP > LastXP, TotalXP - LastXP, CType(0, UInt64))
		    Var IsAscensionLevel As Boolean = Level > (MaxLevel - AscensionLevels)
		    LastXP = TotalXP
		    
		    Var TekBedRate As Double = Min(Max(LevelXP * TekBedMultiplier, TekBedMinRate), TekBedMaxRate)
		    Var TekBedSeconds As UInt64 = Round(LevelXP / TekBedRate)
		    
		    Var Columns(-1) As String
		    Columns.ResizeTo(Max(Self.ColumnAscension, Self.ColumnLevel, Self.ColumnLevelXP, Self.ColumnTime, Self.ColumnTotalXP))
		    Columns(Self.ColumnLevel) = Level.ToString(Locale.Current, "#,##0")
		    Columns(Self.ColumnLevelXP) = LevelXP.ToString(Locale.Current, "#,##0")
		    Columns(Self.ColumnTotalXP) = TotalXP.ToString(Locale.Current, "#,##0")
		    Columns(Self.ColumnAscension) = If(IsAscensionLevel, "Yes", "No")
		    Columns(Self.ColumnTime) = Beacon.SecondsToString(TekBedSeconds)
		    
		    Self.List.AddRow(Columns)
		    Var RowIndex As Integer = Self.List.LastAddedRowIndex
		    Self.List.CellTagAt(RowIndex, Self.ColumnLevel) = Level
		    Self.List.CellTagAt(RowIndex, Self.ColumnLevelXP) = LevelXP
		    Self.List.CellTagAt(RowIndex, Self.ColumnTotalXP) = TotalXP
		    Self.List.CellTagAt(RowIndex, Self.ColumnAscension) = IsAscensionLevel
		    Self.List.CellTagAt(RowIndex, Self.ColumnTime) = TekBedSeconds
		    
		    Self.List.RowSelectedAt(Self.List.LastAddedRowIndex) = SelectLevels.IndexOf(Level) > -1
		  Next
		  
		  Self.List.EnsureSelectionIsVisible(False)
		  Self.UpdateStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Self.Status.CenterCaption = Self.List.StatusMessage("Level", "Levels")
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return (Self.ConfigToolbar.Item("PlayersTab") Is Nil) = False And Self.ConfigToolbar.Item("PlayersTab").Toggled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var PlayersTab As OmniBarItem = Self.ConfigToolbar.Item("PlayersTab")
			  Var TamesTab As OmniBarItem = Self.ConfigToolbar.Item("TamesTab")
			  
			  If (PlayersTab Is Nil) = False Then
			    PlayersTab.Toggled = Value
			  End If
			  If (TamesTab Is Nil) = False Then
			    TamesTab.Toggled = Not Value
			  End If
			End Set
		#tag EndSetter
		Private ViewingPlayerStats As Boolean
	#tag EndComputedProperty


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

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.arksa.experience", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(Self.ColumnLevel) = DesktopListbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnLevelXP) = DesktopListbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnTotalXP) = DesktopListbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnAscension) = DesktopListbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnTime) = DesktopListbox.Alignments.Left
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
		  Var Config As ArkSA.Configs.ExperienceCurves
		  Var Modified As Boolean = Self.Modified
		  
		  For I As Integer = Self.List.RowCount - 1 DownTo 0
		    If Not Self.List.RowSelectedAt(I) Then
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
		  Self.Modified = Modified
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Var EditButton As OmniBarItem = Self.ConfigToolbar.Item("EditButton")
		  If (EditButton Is Nil) = False Then
		    EditButton.Enabled = Me.SelectedRowCount = 1
		  End If
		  Self.UpdateStatus
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  If Me.SelectedRowCount = 1 Then
		    Self.ShowEditExperience()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.Project.ReadOnly = False
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Overrides() As Dictionary
		  Var Config As ArkSA.Configs.ExperienceCurves = Self.Config(False)
		  Var Levels() As UInt64
		  Var IndexOffset As Integer
		  If Self.ViewingPlayerStats Then
		    Levels = Config.PlayerLevels
		    IndexOffset = 2
		  Else
		    Levels = Config.DinoLevels
		    IndexOffset = 1
		  End If
		  For RowIdx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Var Level As Integer = RowIdx + IndexOffset
		    Var TotalXP As UInt64 = Levels(RowIdx)
		    
		    Var Override As New Dictionary
		    Override.Value("Level") = Level
		    Override.Value("XP") = TotalXP
		    Overrides.Add(Override)
		  Next
		  
		  Board.AddClipboardData(Self.kClipboardType, Overrides)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Levels() As Variant
		  Try
		    Levels = Board.GetClipboardData(Self.kClipboardType)
		  Catch Err As RuntimeException
		    Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    Return
		  End Try
		  
		  Var NewConfig As ArkSA.Configs.ExperienceCurves = ArkSA.Configs.ExperienceCurves(ArkSA.Configs.CloneInstance(Self.Config(False)))
		  Var Issues As New Beacon.ProjectValidationResults
		  NewConfig.Validate("", Issues, Self.Project)
		  Var ViewingPlayerStats As Boolean = Self.ViewingPlayerStats
		  Var WasValid As Boolean = NewConfig.PlayerLevelCap > 1 And Issues.Count = 0
		  Var IndexOffset As Integer = If(ViewingPlayerStats, 2, 1)
		  Var AddedLevels() As Integer
		  For Idx As Integer = Levels.FirstIndex To Levels.LastIndex
		    Try
		      Var Dict As Dictionary = Levels(Idx)
		      Var Level As Integer = Dict.Value("Level").IntegerValue
		      Var XP As UInt64 = Dict.Value("XP").UInt64Value
		      
		      If ViewingPlayerStats Then
		        NewConfig.PlayerLevelCap = Max(NewConfig.PlayerLevelCap, Level)
		        NewConfig.PlayerExperience(Level - IndexOffset) = XP
		      Else
		        NewConfig.DinoLevelCap = Max(NewConfig.DinoLevelCap, Level)
		        NewConfig.DinoExperience(Level - IndexOffset) = XP
		      End If
		      
		      AddedLevels.Add(Level)
		    Catch Err As RuntimeException
		      Self.ShowAlert("Unable to paste", "Levels member at index " + Idx.ToString(Locale.Raw, "0") + " is either not a structure or is otherwise incorrect.")
		      Return
		    End Try
		  Next
		  
		  Issues = New Beacon.ProjectValidationResults
		  NewConfig.Validate("", Issues, Self.Project)
		  Var IsValid As Boolean = NewConfig.PlayerLevelCap > 1 And Issues.Count = 0
		  If WasValid = True And IsValid = False Then
		    Var Cancel As Boolean = Self.ShowConfirm("Pasting this data will create an invalid experience plan.", "Either at least one of the new levels have experience amounts lower than the previous level, or there aren't enough levels defined. Do you want to paste anyway?", "Paste Anyway", "Cancel") = False
		    If Cancel Then
		      Return
		    End If
		  End If
		  
		  Self.Project.AddConfigGroup(NewConfig)
		  Self.InvalidateConfigRef()
		  Self.Modified = NewConfig.Modified
		  Self.UpdateList(AddedLevels)
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Var Value1, Value2 As UInt64
		  Select Case Column
		  Case Self.ColumnLevel, Self.ColumnLevelXP, Self.ColumnTotalXP, Self.ColumnTime
		    Value1 = Me.CellTagAt(Row1, Column)
		    Value2 = Me.CellTagAt(Row2, Column)
		  Case Self.ColumnAscension
		    Value1 = If(Me.CellTagAt(Row1, Column).BooleanValue, 1, 0)
		    Value2 = If(Me.CellTagAt(Row2, Column).BooleanValue, 1, 0)
		  End Select
		  
		  If Value1 > Value2 Then
		    Result = 1
		  ElseIf Value1 < Value2 Then
		    Result = -1
		  Else
		    Result = 0
		  End If
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateTab("PlayersTab", "Players"))
		  Me.Append(OmniBarItem.CreateTab("TamesTab", "Tames"))
		  Me.Append(OmniBaritem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddButton", "New Level", IconToolbarAdd, "Add a level."))
		  Me.Append(OmniBarItem.CreateButton("WizardButton", "Auto Levels", IconToolbarWizard, "Add multiple levels using a configuration wizard."))
		  Me.Append(OmniBarItem.CreateButton("EditButton", "Edit", IconToolbarEdit, "Edit the selected level.", False))
		  Me.Append(OmniBarItem.CreateButton("LoadXPButton", "Load Defaults", IconToolbarExperience, "Load the default experience values."))
		  
		  Me.Item("PlayersTab").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
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
		  Case "PlayersTab", "TamesTab"
		    Var SettingUp As Boolean = Self.SettingUp
		    Self.SettingUp = True
		    Self.ViewingPlayerStats = (Item.Name = "PlayersTab")
		    Var SelectedLevels() As Integer
		    Self.UpdateList(SelectedLevels)
		    Self.SettingUp = SettingUp
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
#tag EndViewBehavior
