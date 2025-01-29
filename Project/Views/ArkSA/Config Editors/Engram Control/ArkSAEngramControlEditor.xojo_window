#tag DesktopWindow
Begin ArkSAConfigEditor ArkSAEngramControlEditor Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   672
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
   Width           =   982
   Begin FadedSeparator PointsListSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   672
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   681
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
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
      Width           =   1
   End
   Begin BeaconListbox EngramList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   3
      ColumnWidths    =   "2*,2*,*"
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   True
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
      Height          =   600
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Engram	Behaviors	Mod"
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      TotalPages      =   -1
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   681
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BeaconListbox PointsList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   ""
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
      HeadingIndex    =   0
      Height          =   600
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Player Level	Points"
      Italic          =   False
      Left            =   682
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   8
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
      Width           =   300
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin OmniBar EngramToolbar
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   462
   End
   Begin OmniBar PointsToolbar
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
      Left            =   682
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   300
   End
   Begin DelayedSearchField EngramFilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      AllowTabStop    =   True
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Engrams"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   471
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   10
      Transparent     =   False
      Visible         =   True
      Width           =   200
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin OmniBarSeparator EngramFilterFieldSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   461
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   220
   End
   Begin StatusContainer EngramListStatus
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
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   641
      Transparent     =   True
      Visible         =   True
      Width           =   681
   End
   Begin StatusContainer PointsListStatus
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
      Left            =   682
      LeftCaption     =   ""
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      RightCaption    =   ""
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   641
      Transparent     =   True
      Visible         =   True
      Width           =   300
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
		  Self.MinimumWidth = 601
		End Sub
	#tag EndEvent

	#tag Event
		Function ParsingFinished(Project As ArkSA.Project) As Boolean
		  If Project.HasConfigGroup(ArkSA.Configs.NameEngramControl) = False Then
		    Return False
		  End If
		  
		  Var NewGroup As ArkSA.Configs.EngramControl = ArkSA.Configs.EngramControl(Project.ConfigGroup(ArkSA.Configs.NameEngramControl))
		  Var CurrentGroup As ArkSA.Configs.EngramControl = Self.Config(False)
		  Var OldEngramRows As Dictionary = Self.PrepareEngramComparison()
		  Var Groups(1) As ArkSA.ConfigGroup
		  Groups(0) = CurrentGroup
		  Groups(1) = NewGroup
		  
		  Var MergedGroup As ArkSA.ConfigGroup = ArkSA.Configs.Merge(Groups, False)
		  Self.Project.AddConfigGroup(MergedGroup)
		  Self.InvalidateConfigRef()
		  Self.SetupUI()
		  Self.Modified = True
		  Self.ProcessEngramComparison(OldEngramRows)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Const MaxPointsWidth = 300
		  Const PointsPercent = 0.3
		  
		  Var PointsWidth As Integer = Min(Self.Width * PointsPercent, MaxPointsWidth)
		  Var EngramsWidth As Integer = Self.Width - (PointsWidth + 1)
		  Var PointsLeft As Integer = EngramsWidth + 1
		  
		  Self.EngramList.Width = EngramsWidth
		  Self.EngramToolbar.Width = EngramsWidth - Self.EngramFilterFieldSeparator.Width
		  Self.EngramListStatus.Width = EngramsWidth
		  Self.EngramFilterFieldSeparator.Left = Self.EngramToolbar.Left + Self.EngramToolbar.Width
		  Self.EngramFilterField.Left = Self.EngramFilterFieldSeparator.Left + 10
		  
		  Self.PointsListSeparator.Left = EngramsWidth
		  Self.PointsList.Left = PointsLeft
		  Self.PointsList.Width = PointsWidth
		  Self.PointsToolbar.Left = PointsLeft
		  Self.PointsToolbar.Width = PointsWidth
		  Self.PointsListStatus.Left = PointsLeft
		  Self.PointsListStatus.Width = PointsWidth
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.SetupEngramsList()
		  Self.SetupPointsList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShowIssue(Issue As Beacon.Issue)
		  Var Location As String = Issue.Location
		  Var Parts() As String = Location.Split(Beacon.Issue.Separator)
		  Var UnlockString As String = Parts(Parts.LastIndex)
		  Self.EngramFilterField.SetNow(UnlockString)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused UserData
		  #Pragma Unused FireSetupUI
		  
		  NotificationKit.Watch(Self, ArkSA.Project.Notification_SinglePlayerChanged)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As ArkSA.Configs.EngramControl
		  Return ArkSA.Configs.EngramControl(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function EngramMatchesFilter(Config As ArkSA.Configs.EngramControl, Engram As ArkSA.Engram, Filter As String) As Boolean
		  If Engram Is Nil Then
		    Return False
		  End If
		  
		  If Engram.Label.Contains(Filter) Or Engram.Path.Contains(Filter) Or Engram.ClassString.Contains(Filter) Then
		    Return True
		  End If
		  
		  If (Engram.AlternateLabel Is Nil) = False And Engram.AlternateLabel.Contains(Filter) Then
		    Return True
		  End If
		  
		  Var UnlockString As String = Config.EntryString(Engram)
		  If UnlockString.IsEmpty = False And UnlockString.Contains(Filter) Then
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameEngramControl
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case ArkSA.Project.Notification_SinglePlayerChanged
		    Var UserData As Dictionary = Notification.UserData
		    If UserData.Value("ProjectId") = Self.Project.ProjectId Then
		      Self.SetupPointsList()
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PrepareEngramComparison() As Dictionary
		  Var OldEngramRows As New Dictionary
		  For Idx As Integer = 0 To Self.EngramList.LastRowIndex
		    Var Engram As ArkSA.Engram = Self.EngramList.RowTagAt(Idx)
		    OldEngramRows.Value(Engram.EngramId) = Self.EngramList.CellTextAt(Idx, 1)
		  Next Idx
		  Return OldEngramRows
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessEngramComparison(OldEngramRows As Dictionary)
		  Var SelectEngrams() As ArkSA.Engram
		  For Idx As Integer = 0 To Self.EngramList.LastRowIndex
		    Var Engram As ArkSA.Engram = Self.EngramList.RowTagAt(Idx)
		    If OldEngramRows.HasKey(Engram.EngramId) = False Or OldEngramRows.Value(Engram.EngramId).StringValue <> Self.EngramList.CellTextAt(Idx, 1) Then
		      SelectEngrams.Add(Engram)
		    End If
		  Next Idx
		  If SelectEngrams.Count > 0 Then
		    Self.SetupEngramsList(SelectEngrams)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reload()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SettingsPopoverController_Finished(Sender As PopoverController, Cancelled As Boolean)
		  If Not Cancelled Then
		    Var Config As ArkSA.Configs.EngramControl = Self.Config(True)
		    Config.OnlyAllowSpecifiedEngrams = ArkSAEngramControlSettingsView(Sender.Container).OnlyAllowSpecifiedEngrams
		    Config.AutoUnlockAllEngrams = ArkSAEngramControlSettingsView(Sender.Container).AutoUnlockEngrams
		    Self.SetupEngramsList
		    Self.Modified = Self.Project.Modified
		  End If
		  
		  Self.EngramToolbar.Item("SettingsButton").Toggled = False
		  Self.mSettingsPopoverController = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupEngramsList(SelectEngrams() As ArkSA.Engram = Nil)
		  Var Config As ArkSA.Configs.EngramControl = Self.Config(False)
		  Var Engrams() As ArkSA.Engram = Config.Engrams
		  Var Providers() As ArkSA.BlueprintProvider = ArkSA.ActiveBlueprintProviders
		  Var ContentPackIds As Beacon.StringList = Self.Project.ContentPacks
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    Engrams = Engrams.Merge(Provider.GetEngramEntries("", ContentPackIds, Nil))
		  Next
		  
		  Var LabelCounts As New Dictionary
		  For Each Engram As ArkSA.Engram In Engrams
		    LabelCounts.Value(Engram.Label) = LabelCounts.Lookup(Engram.Label, 0) + 1
		  Next
		  
		  Var Filter As String = Self.EngramFilterField.Text.Trim
		  If Filter.IsEmpty = False Then
		    Var Filtered() As ArkSA.Engram
		    For Idx As Integer = Engrams.FirstIndex To Engrams.LastIndex
		      If Self.EngramMatchesFilter(Config, Engrams(Idx), Filter) Then
		        Filtered.Add(Engrams(Idx))
		      End If
		    Next Idx
		    Engrams = Filtered
		  End If
		  
		  Var Selected() As String
		  If SelectEngrams = Nil Then
		    Var Bound As Integer = Self.EngramList.LastRowIndex
		    For Idx As Integer = 0 To Bound
		      If Self.EngramList.RowSelectedAt(Idx) Then
		        Selected.Add(ArkSA.Engram(Self.EngramList.RowTagAt(Idx)).EngramId)
		      End If
		    Next
		  Else
		    For Each Engram As ArkSA.Engram In SelectEngrams
		      Selected.Add(Engram.EngramId)
		    Next
		  End If
		  
		  Self.EngramList.RowCount = Engrams.Count
		  Var Bound As Integer = Engrams.LastIndex
		  For Idx As Integer = 0 To Bound
		    Var Engram As ArkSA.Engram = Engrams(Idx)
		    Self.EngramList.RowTagAt(Idx) = Engram
		    If LabelCounts.Lookup(Engram.Label, 0) > 1 Then
		      Self.EngramList.CellTextAt(Idx, 0) = Engram.Label.Disambiguate(Engram.ContentPackName)
		    Else
		      Self.EngramList.CellTextAt(Idx, 0) = Engram.Label
		    End If
		    Self.EngramList.CellTextAt(Idx, 2) = Engram.ContentPackName
		    
		    Var Behaviors() As String
		    
		    Var IsEnabled As Boolean = Not Config.EffectivelyHidden(Engram)
		    If Engram.IsDefaultUnlocked Then
		      If Config.OnlyAllowSpecifiedEngrams And IsEnabled = False Then
		        Behaviors.Add("Disabled by default")
		      Else
		        Behaviors.Add("Unlocked by default")
		      End If
		    ElseIf Not IsEnabled Then
		      Var Hidden As NullableBoolean = Config.Hidden(Engram)
		      If IsNull(Hidden) Then
		        Behaviors.Add("Disabled by default")
		      Else
		        Behaviors.Add("Disabled")
		      End If
		      
		      Self.EngramList.CellTagAt(Idx, 1) = 2147483647
		    Else
		      Var RequiredLevel As NullableDouble = Config.RequiredPlayerLevel(Engram)
		      If IsNull(RequiredLevel) Then
		        RequiredLevel = Engram.RequiredPlayerLevel
		      End If
		      
		      Var RequiredPoints As NullableDouble = Config.RequiredPoints(Engram)
		      If IsNull(RequiredPoints) Then
		        RequiredPoints = Engram.RequiredUnlockPoints
		      End If
		      
		      Var AutoUnlock As NullableBoolean = Config.AutoUnlockEngram(Engram)
		      If IsNull(AutoUnlock) And Config.AutoUnlockAllEngrams Then
		        AutoUnlock = True
		      End If
		      
		      If Config.AutoUnlockAllEngrams Or (IsNull(AutoUnlock) = False And AutoUnlock.BooleanValue = True) Then
		        If IsNull(RequiredLevel) = False And RequiredLevel.IntegerValue > 0 Then
		          Behaviors.Add("Auto unlocks at " + If(RequiredLevel.IntegerValue > 1, "level " + RequiredLevel.IntegerValue.ToString, "spawn"))
		        Else
		          Behaviors.Add("Auto unlocks at spawn")
		        End If
		      Else
		        If ((Engram.RequiredPlayerLevel Is Nil) = False Or ArkSA.DataSource.Pool.Get(False).BlueprintIsCustom(Engram)) And IsNull(RequiredLevel) = False And IsNull(RequiredPoints) = False Then
		          Behaviors.Add("Unlockable at " + If(RequiredLevel.IntegerValue > 1, "level " + RequiredLevel.IntegerValue.ToString, "spawn") + " for " + If(RequiredPoints.IntegerValue > 0, RequiredPoints.IntegerValue.ToString + " points", "free"))
		        Else
		          Behaviors.Add("Auto unlocks by special event")
		        End If
		      End If
		      
		      Var RemovePreq As NullableBoolean = Config.RemovePrerequisites(Engram)
		      If IsNull(RemovePreq) = False And RemovePreq.BooleanValue Then
		        Behaviors.Add("Prerequisites removed")
		      End If
		      
		      If IsNull(RequiredLevel) = False Then
		        Self.EngramList.CellTagAt(Idx, 1) = RequiredLevel.IntegerValue
		      Else
		        Self.EngramList.CellTagAt(Idx, 1) = 2147483646
		      End If
		    End If
		    
		    Self.EngramList.CellTextAt(Idx, 1) = Behaviors.Join("; ")
		    Self.EngramList.RowSelectedAt(Idx) = Selected.IndexOf(Engram.EngramId) > -1
		  Next
		  
		  Self.EngramList.Sort()
		  Self.EngramList.EnsureSelectionIsVisible()
		  Self.UpdateEngramsListStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupPointsList()
		  Var Config As ArkSA.Configs.EngramControl = Self.Config(False)
		  Var Selected() As Integer
		  For I As Integer = 0 To Self.PointsList.LastRowIndex
		    If Self.PointsList.RowSelectedAt(I) Then
		      Selected.Add(Self.PointsList.RowTagAt(I).IntegerValue)
		    End If
		  Next
		  
		  Var SinglePlayer As Boolean = Self.Project.IsFlagged(ArkSA.Project.FlagSinglePlayer)
		  Var OfficialLevels As ArkSA.PlayerLevelData = ArkSA.DataSource.Pool.Get(False).OfficialPlayerLevelData(SinglePlayer)
		  Var OfficialMaxLevel As Integer = If(OfficialLevels Is Nil, 0, OfficialLevels.MaxLevel)
		  Self.PointsList.RowCount = Max(Config.LevelsDefined, OfficialMaxLevel)
		  For Idx As Integer = 0 To Self.PointsList.LastRowIndex
		    Var Level As Integer = Idx + 1
		    Var PointsForLevel As NullableDouble = Config.PointsForLevel(Level)
		    Var PointsActual As Integer
		    If IsNull(PointsForLevel) Then
		      PointsActual = OfficialLevels.PointsForLevel(Level)
		    Else
		      PointsActual = PointsForLevel.IntegerValue
		    End If
		    
		    Self.PointsList.CellTextAt(Idx, 0) = Level.ToString
		    Self.PointsList.CellTextAt(Idx, 1) = PointsActual.ToString
		    Self.PointsList.RowSelectedAt(Idx) = Selected.IndexOf(Level) > -1
		    Self.PointsList.RowTagAt(Idx) = Level
		  Next
		  
		  Self.PointsList.Sort
		  Self.PointsList.EnsureSelectionIsVisible
		  
		  Self.UpdatePointsListStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEngramsListStatus()
		  Self.EngramListStatus.CenterCaption = Self.EngramList.StatusMessage("Engram Override", "Engram Overrides")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePointsListStatus()
		  Self.PointsListStatus.CenterCaption = Self.PointsList.StatusMessage("Level", "Levels")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSettingsPopoverController As PopoverController
	#tag EndProperty


	#tag Constant, Name = kEngramsClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.arksa.engramoverride", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPointsClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.arksa.unlockpointoverride", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events EngramList
	#tag Event
		Sub SelectionChanged()
		  Var EditButton As OmniBarItem = Self.EngramToolbar.Item("EditButton")
		  If (EditButton Is Nil) = False Then
		    EditButton.Enabled = Me.CanEdit
		  End If
		  Self.UpdateEngramsListStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Members() As ArkSA.Engram
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.RowSelectedAt(I) Then
		      Members.Add(Me.RowTagAt(I))
		    End If
		  Next
		  
		  If Warn And Not Self.ShowDeleteConfirmation(Members, "engram override", "engram overrides", True) Then
		    Return
		  End If
		  
		  Var Config As ArkSA.Configs.EngramControl = Self.Config(True)
		  For Each Member As ArkSA.Engram In Members
		    Config.Remove(Member)
		  Next
		  
		  Self.SetupUI
		  Self.Modified = Config.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.Project.ReadOnly = False
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Engrams() As ArkSA.Engram
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Engram As ArkSA.Engram = Me.RowTagAt(Idx)
		    Engrams.Add(Engram)
		  Next
		  
		  Var Config As ArkSA.Configs.EngramControl = Self.Config(False)
		  Var Overrides() As Dictionary = Config.Export(Engrams)
		  If Overrides.Count = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(Self.kEngramsClipboardType, Overrides)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kEngramsClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As Variant = Board.GetClipboardData(Self.kEngramsClipboardType)
		  If Contents.IsNull = False Then
		    Try
		      Var Config As ArkSA.Configs.EngramControl = Self.Config(False)
		      Var OldEngramRows As Dictionary = Self.PrepareEngramComparison()
		      Var Changed As Boolean = Config.Import(Contents)
		      If Changed Then
		        Call Self.Config(True) // Will cause the previous retreival to become permanent since we still have a reference
		        Self.SetupUI
		        Self.Modified = Config.Modified
		        Self.ProcessEngramComparison(OldEngramRows)
		      End If
		    Catch Err As RuntimeException
		      Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    End Try
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var Engrams() As ArkSA.Engram
		  For I As Integer = 0 To Me.LastRowIndex
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Engrams.Add(Me.RowTagAt(I))
		  Next
		  
		  Engrams = ArkSAEngramControlEngramOverrideWizard.Present(Self, Self.Project, Engrams)
		  If Engrams <> Nil And Engrams.LastIndex > -1 Then
		    Self.Modified = True
		    Self.SetupEngramsList(Engrams)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 1 Then
		    Return False
		  End If
		  
		  Var Value1 As Integer = Me.CellTagAt(Row1, Column)
		  Var Value2 As Integer = Me.CellTagAt(Row2, Column)
		  If Value1 > Value2 Then
		    Result = 1
		  ElseIf Value1 < Value2 Then
		    Result = -1
		  Else
		    Var Engram1 As ArkSA.Engram = Me.RowTagAt(Row1)
		    Var Engram2 As ArkSA.Engram = Me.RowTagAt(Row2)
		    Result = Engram1.Label.Compare(Engram2.Label, ComparisonOptions.CaseInsensitive, Locale.Current)
		  End If
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events PointsList
	#tag Event
		Sub SelectionChanged()
		  Var EditButton As OmniBarItem = Self.PointsToolbar.Item("EditButton")
		  If (EditButton Is Nil) = False Then
		    EditButton.Enabled = Me.SelectedRowCount > 0
		  End If
		  Self.UpdatePointsListStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Names() As String
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) Then
		      Names.Add(Me.RowTagAt(Idx).IntegerValue.ToString)
		    End If
		  Next
		  
		  If Warn And Not Self.ShowDeleteConfirmation(Names, "level", "levels", True) Then
		    Return
		  End If
		  
		  Var Config As ArkSA.Configs.EngramControl = Self.Config(True)
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Not Me.RowSelectedAt(Idx) Then
		      Continue
		    End If
		    
		    Var Level As Integer = Me.RowTagAt(Idx)
		    Config.PointsForLevel(Level) = Nil
		  Next
		  
		  Self.SetupUI
		  Self.Modified = Config.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  Var Config As ArkSA.Configs.EngramControl = Self.Config(False)
		  For I As Integer = 0 To Me.LastRowIndex
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Level As Integer = Me.RowTagAt(I)
		    Var Points As NullableDouble = Config.PointsForLevel(Level)
		    
		    Var Dict As New Dictionary
		    Dict.Value("level") = Level
		    If IsNull(Points) Then
		      Dict.Value("points") = Nil
		    Else
		      Dict.Value("points") = Points.IntegerValue
		    End If
		    
		    Dicts.Add(Dict)
		  Next
		  
		  If Dicts.Count = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(Self.kPointsClipboardType, Dicts)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kPointsClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As Variant = Board.GetClipboardData(Self.kPointsClipboardType)
		  If Contents.IsNull = False Then
		    Try
		      Var Config As ArkSA.Configs.EngramControl
		      Var Changed As Boolean
		      Var Dicts() As Variant = Contents
		      For Each Dict As Dictionary In Dicts
		        Var Level As Integer = Dict.Value("level")
		        Var Points As NullableDouble = NullableDouble.FromVariant(Dict.Value("points"))
		        
		        If Config Is Nil Then
		          Config = Self.Config(True)
		        End If
		        
		        Config.PointsForLevel(Level) = Points
		        Changed = True
		      Next
		      
		      If Changed Then
		        Self.SetupUI
		      End If
		      If (Config Is Nil) = False Then
		        Self.Modified = Config.Modified
		      End If
		    Catch Err As RuntimeException
		      Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    End Try
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(0) = DesktopListbox.Alignments.Right
		  Me.ColumnAlignmentAt(1) = DesktopListbox.Alignments.Right
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var Levels() As Integer
		  For I As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(I) Then
		      Levels.Add(Me.RowTagAt(I))
		    End If
		  Next
		  
		  If Levels.LastIndex = -1 Then
		    Return
		  End If
		  
		  If ArkSAEngramControlPointOverrideWindow.Present(Self, Self.Project, Levels) Then
		    Self.SetupPointsList()
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Var Value1 As Integer = Me.CellTextAt(Row1, Column).ToInteger
		  Var Value2 As Integer = Me.CellTextAt(Row2, Column).ToInteger
		  
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
#tag Events EngramToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddButton", "New Engram", IconToolbarAdd, "Inform Beacon of an unlockable engram that it does not already know about."))
		  Me.Append(OmniBarItem.CreateButton("EditButton", "Edit", IconToolbarEdit, "Edit the selected engram overrides.", False))
		  Me.Append(OmniBarItem.CreateButton("WizardButton", "Auto Control", IconToolbarWizard, "Quickly set engram behaviors."))
		  Me.Append(OmniBarItem.CreateButton("SettingsButton", "Advanced", IconToolbarSettings, "Changed uncommon engram settings."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "AddButton"
		    Var Engrams() As ArkSA.Engram
		    Engrams = ArkSAEngramControlEngramOverrideWizard.Present(Self, Self.Project, Engrams)
		    If Engrams <> Nil And Engrams.LastIndex > -1 Then
		      Self.SetupEngramsList(Engrams)
		      Self.EngramList.EnsureSelectionIsVisible()
		      Self.Modified = Self.Project.Modified
		    End If
		  Case "EditButton"
		    Self.EngramList.DoEdit()
		  Case "WizardButton"
		    If ArkSAEngramControlWizard.Present(Self, Self.Project) Then
		      Self.SetupUI()
		      Self.Modified = Self.Config(False).Modified
		    End If
		  Case "SettingsButton"
		    If (Self.mSettingsPopoverController Is Nil) = False And Self.mSettingsPopoverController.Visible Then
		      Self.mSettingsPopoverController.Dismiss(False)
		      Self.mSettingsPopoverController = Nil
		      Item.Toggled = False
		      Return
		    End If
		    
		    Var Config As ArkSA.Configs.EngramControl = Self.Config(False)
		    Var SettingsView As New ArkSAEngramControlSettingsView
		    Var Controller As New PopoverController("Advanced Engram Options", SettingsView)
		    SettingsView.AutoUnlockEngrams = Config.AutoUnlockAllEngrams
		    SettingsView.OnlyAllowSpecifiedEngrams = Config.OnlyAllowSpecifiedEngrams
		    Controller.Show(Me, ItemRect)
		    
		    Item.Toggled = True
		    
		    AddHandler Controller.Finished, WeakAddressOf SettingsPopoverController_Finished
		    Self.mSettingsPopoverController = Controller
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PointsToolbar
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddButton"
		    Var Levels() As Integer
		    If ArkSAEngramControlPointOverrideWindow.Present(Self, Self.Project, Levels) Then
		      Self.SetupPointsList()
		      Self.Modified = True
		    End If
		  Case "EditButton"
		    Self.PointsList.DoEdit
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", "Unlock Points"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddButton", "New Level", IconToolbarAdd, "Define a new level to override engram points."))
		  Me.Append(OmniBarItem.CreateButton("EditButton", "Edit", IconToolbarEdit, "Edit one or more levels.", False))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramFilterField
	#tag Event
		Sub TextChanged()
		  Self.SetupEngramsList()
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
#tag EndViewBehavior
