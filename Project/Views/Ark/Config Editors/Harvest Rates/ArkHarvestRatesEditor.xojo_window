#tag Window
Begin ArkConfigEditor ArkHarvestRatesEditor
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
   Height          =   468
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
   Width           =   764
   Begin UITweaks.ResizedTextField HarvestAmountMultiplierField
      AcceptTabs      =   False
      Alignment       =   2
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values increase harvest yields, smaller values decrease harvest yields."
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel HarvestAmountMultiplierLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Global Harvest Rate Multiplier:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin FadedSeparator FadedSeparator2
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
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
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   205
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   764
   End
   Begin BeaconListbox List
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "*,150,150"
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
      HasHeading      =   True
      HeadingIndex    =   0
      Height          =   262
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Engram	Rate Multiplier	Effective Multiplier"
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
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   206
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   764
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin CheckBox UseOptimizedRatesCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Use Optimized Harvest Rates"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   "Significantly reduces lag at higher harvest amount values, but reduces number of rare resources granted."
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   351
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   393
   End
   Begin UITweaks.ResizedTextField HarvestHealthMultiplierField
      AcceptTabs      =   False
      Alignment       =   2
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values will require more damage to break, smaller values reduced required damage."
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   95
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel HarvestHealthMultiplierLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Global Harvest Health Multiplier:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   95
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin UITweaks.ResizedTextField PlayerHarvestDamageMultiplierField
      AcceptTabs      =   False
      Alignment       =   2
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values increase damage players do to harvestable resources, smaller values decrease player damage."
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   129
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel PlayerHarvestDamageMultiplierLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Player Harvest Damage Multiplier:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   129
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin UITweaks.ResizedTextField DinoHarvestDamageMultiplierField
      AcceptTabs      =   False
      Alignment       =   2
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values increase damage creatures do to harvestable resources, smaller values decrease creature damage."
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   163
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel DinoHarvestDamageMultiplierLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Creature Harvest Damage Multiplier:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   163
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin CheckBox ClampHarvestDamageCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Clamp Harvesting Damage"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   "Limits the amount of possible damage that can be done to resources during each harvest action."
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   351
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   96
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   393
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
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   764
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function ParsingFinished(Project As Ark.Project) As Boolean
		  // Don't import the properties, it would likely be confusing for users
		  
		  If Project Is Nil Or Project.HasConfigGroup(Ark.Configs.NameHarvestRates) = False Then
		    Return True
		  End If
		  
		  Var OtherConfig As Ark.Configs.HarvestRates = Ark.Configs.HarvestRates(Project.ConfigGroup(Ark.Configs.NameHarvestRates))
		  If OtherConfig = Nil Or OtherConfig.Count = CType(0, UInteger) Then
		    Return True
		  End If
		  
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Var Engrams() As Ark.Engram = OtherConfig.Engrams
		  For Each Engram As Ark.Engram In Engrams
		    Config.Override(Engram) = OtherConfig.Override(Engram)
		  Next
		  Self.Changed = True
		  Self.UpdateList(Engrams)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub RunTool(Tool As Ark.ProjectTool)
		  Select Case Tool.UUID
		  Case "5265adcd-5c7e-437c-bce2-d10721afde43"
		    Self.ConvertGlobalHarvestRate()
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Var Config As Ark.Configs.HarvestRates = Self.Config(False)
		  Self.HarvestAmountMultiplierField.Text = Config.HarvestAmountMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.HarvestHealthMultiplierField.Text = Config.HarvestHealthMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.PlayerHarvestDamageMultiplierField.Text = Config.PlayerHarvestingDamageMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.DinoHarvestDamageMultiplierField.Text = Config.DinoHarvestingDamageMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.ClampHarvestDamageCheck.Value = Config.ClampResourceHarvestDamage
		  Self.UseOptimizedRatesCheck.Value = Config.UseOptimizedRates
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As Ark.Configs.HarvestRates
		  Return Ark.Configs.HarvestRates(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConvertGlobalHarvestRate()
		  If Self.Config(False).HarvestAmountMultiplier = 1.0 Then
		    Return
		  End If
		  
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Var GlobalRate As Double = Config.HarvestAmountMultiplier
		  Var SkippedEngrams As New Dictionary
		  Var Engrams() As Ark.Engram = Config.Engrams
		  For Each Engram As Ark.Engram In Engrams
		    SkippedEngrams.Value(Engram.ObjectID) = True
		    Config.Override(Engram) = Round(Config.Override(Engram) * GlobalRate)
		  Next
		  
		  Engrams = Ark.DataSource.SharedInstance.GetEngrams("", Self.Project.ContentPacks, "harvestable")
		  For Each Engram As Ark.Engram In Engrams
		    If SkippedEngrams.HasKey(Engram.ObjectID) Then
		      Continue
		    End If
		    Config.Override(Engram) = Round(Config.Override(Engram) * GlobalRate)
		  Next
		  Config.HarvestAmountMultiplier = 1.0
		  Self.SetupUI
		  Self.List.EnsureSelectionIsVisible
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameHarvestRates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddOverride()
		  Var Config As Ark.Configs.HarvestRates = Self.Config(False)
		  Var CurrentEngrams() As Ark.Engram = Config.Engrams
		  
		  Var NewEngrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Project.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.ImpliedMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Ark.Engram In NewEngrams
		    Config.Override(Engram) = 1.0
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicateOverride()
		  If Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Config As Ark.Configs.HarvestRates = Self.Config(False)
		  Var CurrentEngrams() As Ark.Engram = Config.Engrams
		  
		  Var NewEngrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Project.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var SourceEngram As Ark.Engram = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Var Rate As Double = Config.Override(SourceEngram)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Ark.Engram In NewEngrams
		    Config.Override(Engram) = Rate
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Selections() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Selections.Add(Ark.Engram(Self.List.RowTagAt(I)).ObjectID)
		  Next
		  Self.UpdateList(Selections)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As Ark.Engram)
		  Var Selections() As String
		  For Each Engram As Ark.Engram In SelectEngrams
		    Selections.Add(Engram.ObjectID)
		  Next
		  Self.UpdateList(Selections) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selections() As String)
		  Var Config As Ark.Configs.HarvestRates = Self.Config(False)
		  Var Engrams() As Ark.Engram = Config.Engrams
		  
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Self.List.RemoveAllRows()
		  For Each Engram As Ark.Engram In Engrams
		    Var Rate As Double = Config.Override(Engram)
		    Var EffectiveRate As Double = Round(Rate) * Round(Config.HarvestAmountMultiplier)
		    Self.List.AddRow(Engram.Label, Rate.PrettyText, EffectiveRate.PrettyText)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Engram
		    Self.List.Selected(Self.List.LastAddedRowIndex) = Selections.IndexOf(Engram.ObjectID) > -1
		  Next
		  
		  Self.List.Sort
		  Self.List.ScrollPosition = ScrollPosition
		  Self.List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod


	#tag Constant, Name = ColumnEffectiveRate, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnEngram, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRate, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.harvestrates", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events HarvestAmountMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Config.HarvestAmountMultiplier = CDbl(Me.Text)
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(Self.ColumnRate) = Listbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnEffectiveRate) = Listbox.Alignments.Right
		  Me.ColumnTypeAt(Self.ColumnRate) = Listbox.CellTypes.TextField
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Var DuplicateButton As OmniBarItem = Self.ConfigToolbar.Item("Duplicate")
		  If (DuplicateButton Is Nil) = False Then
		    DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> Self.ColumnRate Then
		    Return
		  End If
		  
		  Var Rate As Double = CDbl(Me.CellValueAt(Row, Column))
		  If Rate <= 0 Then
		    Rate = 1
		  End If
		  Var Engram As Ark.Engram = Me.RowTagAt(Row)
		  
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Config.Override(Engram) = Rate
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
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("HarvestAmountMultiplier") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Var Message As String
		    If Me.SelectedRowCount = 1 Then
		      Message = "Are you sure you want to delete the """ + Me.CellValueAt(Me.SelectedRowIndex, 0) + """ harvest rate override?"
		    Else
		      Message = "Are you sure you want to delete these " + Me.SelectedRowCount.ToString(Locale.Raw, "0") + " harvest rate overrides?"
		    End If
		    
		    If Not Self.ShowConfirm(Message, "This action cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Engram As Ark.Engram = Me.RowTagAt(I)
		    Config.Override(Engram) = 0
		  Next
		  Self.Changed = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items As New Dictionary
		  Var Config As Ark.Configs.HarvestRates = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Engram As Ark.Engram = Me.RowTagAt(I)
		    Var Rate As Double = Config.Override(Engram)
		    Items.Value(Engram.ObjectID) = Rate
		  Next
		  
		  Board.RawData(Self.kClipboardType) = Beacon.GenerateJSON(Items, False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Var JSON As String = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8)
		    Var Items As Dictionary
		    Try
		      Items = Beacon.ParseJSON(JSON)
		    Catch Err As RuntimeException
		      Items = New Dictionary
		    End Try
		    
		    If Items.KeyCount = 0 Then
		      Return
		    End If
		    
		    Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		    Var SelectEngrams() As Ark.Engram
		    For Each Entry As DictionaryEntry In Items
		      Var UUID As String = Entry.Key
		      Var Engram As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramByUUID(UUID)
		      If Engram Is Nil Then
		        Continue
		      End If
		      
		      Var Rate As Double = Entry.Value
		      SelectEngrams.Add(Engram)
		      Config.Override(Engram) = Rate
		    Next
		    Self.Changed = True
		    Self.UpdateList(SelectEngrams)
		    Return
		  End If
		  
		  If Board.TextAvailable Then
		    Var ImportText As String = Board.Text.GuessEncoding
		    Self.Parse("", ImportText, "Clipboard")
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events UseOptimizedRatesCheck
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Config.UseOptimizedRates = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HarvestHealthMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Config.HarvestHealthMultiplier = CDbl(Me.Text)
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlayerHarvestDamageMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Config.PlayerHarvestingDamageMultiplier = CDbl(Me.Text)
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DinoHarvestDamageMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Config.DinoHarvestingDamageMultiplier = CDbl(Me.Text)
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClampHarvestDamageCheck
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.HarvestRates = Self.Config(True)
		  Config.ClampResourceHarvestDamage = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddEngram", "New Rate", IconToolbarAdd, "Override the harvest rate of an engram."))
		  Me.Append(OmniBarItem.CreateButton("Duplicate", "Duplicate", IconToolbarClone, "Duplicate the selected harvest rate override.", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddEngram"
		    Self.ShowAddOverride()
		  Case "Duplicate"
		    Self.ShowDuplicateOverride()
		  End Select
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
