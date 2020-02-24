#tag Window
Begin ConfigEditor HarvestRatesConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   468
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
      Top             =   53
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
      Top             =   53
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
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
      Caption         =   "Harvest Rate Overrides"
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
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   764
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
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   189
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   764
   End
   Begin BeaconListbox List
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
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   278
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
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   190
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   764
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   764
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
      Top             =   54
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
      Top             =   87
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
      Top             =   87
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
      Top             =   121
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
      Top             =   121
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
      Top             =   155
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
      Top             =   155
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
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   393
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  If Self.Config(False).HarvestAmountMultiplier <> 1.0 Then
		    EditorMenu.Child("ConvertGlobalHarvestRate").Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  Var ConvertGlobalItem As New MenuItem("Convert Global Harvest Rate to Individual Rates")
		  ConvertGlobalItem.AutoEnabled = False
		  ConvertGlobalItem.Name = "ConvertGlobalHarvestRate"
		  Items.AddRow(ConvertGlobalItem)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ParsingFinished(ParsedData As Dictionary)
		  // Don't import the properties, it would likely be confusing for users
		  
		  If ParsedData = Nil Then
		    Return
		  End If
		  
		  Var OtherConfig As BeaconConfigs.HarvestRates = BeaconConfigs.HarvestRates.FromImport(ParsedData, New Dictionary, Self.Document.MapCompatibility, Self.Document.Difficulty)
		  If OtherConfig = Nil Or OtherConfig.Count = 0 Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Var Engrams() As Beacon.Engram = OtherConfig.Engrams
		  For Each Engram As Beacon.Engram In Engrams
		    Config.Override(Engram) = OtherConfig.Override(Engram)
		  Next
		  Self.Changed = True
		  Self.UpdateList(Engrams)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.HarvestRates.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Self.HarvestAmountMultiplierField.Value = Format(Config.HarvestAmountMultiplier, "0.0#####")
		  Self.HarvestHealthMultiplierField.Value = Format(Config.HarvestHealthMultiplier, "0.0#####")
		  Self.PlayerHarvestDamageMultiplierField.Value = Format(Config.PlayerHarvestingDamageMultiplier, "0.0#####")
		  Self.DinoHarvestDamageMultiplierField.Value = Format(Config.DinoHarvestingDamageMultiplier, "0.0#####")
		  Self.ClampHarvestDamageCheck.Value = Config.ClampResourceHarvestDamage
		  Self.UseOptimizedRatesCheck.Value = Config.UseOptimizedRates
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function ConvertGlobalHarvestRate() As Boolean Handles ConvertGlobalHarvestRate.Action
			Self.ConvertGlobalHarvestRate()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.HarvestRates
		  Static ConfigName As String = BeaconConfigs.HarvestRates.ConfigName
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.HarvestRates
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.HarvestRates(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.HarvestRates(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.HarvestRates
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
		  Return Language.LabelForConfig(BeaconConfigs.HarvestRates.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConvertGlobalHarvestRate()
		  If Self.Config(False).HarvestAmountMultiplier = 1.0 Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Var GlobalRate As Double = Config.HarvestAmountMultiplier
		  Var SkipPaths As New Dictionary
		  Var Engrams() As Beacon.Engram = Config.Engrams
		  For Each Engram As Beacon.Engram In Engrams
		    SkipPaths.Value(Engram.Path) = True
		    Config.Override(Engram) = Round(Config.Override(Engram) * GlobalRate)
		  Next
		  
		  Engrams = Beacon.Data.SearchForEngrams("", Self.Document.Mods, "harvestable")
		  For Each Engram As Beacon.Engram In Engrams
		    If SkipPaths.HasKey(Engram.Path) Then
		      Continue
		    End If
		    Config.Override(Engram) = Round(Config.Override(Engram) * GlobalRate)
		  Next
		  Config.HarvestAmountMultiplier = 1.0
		  Self.SetupUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddOverride()
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Var CurrentEngrams() As Beacon.Engram = Config.Engrams
		  
		  Var NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Document.Mods, False)
		  If NewEngrams = Nil Or NewEngrams.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
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
		  
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Var CurrentEngrams() As Beacon.Engram = Config.Engrams
		  
		  Var NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Document.Mods, True)
		  If NewEngrams = Nil Or NewEngrams.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Var SourceEngram As Beacon.Engram = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Var Rate As Double = Config.Override(SourceEngram)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram) = Rate
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Paths() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Paths.AddRow(Beacon.Engram(Self.List.RowTagAt(I)).Path)
		  Next
		  Self.UpdateList(Paths)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As Beacon.Engram)
		  Var Paths() As String
		  For Each Engram As Beacon.Engram In SelectEngrams
		    Paths.AddRow(Engram.Path)
		  Next
		  Self.UpdateList(Paths) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectPaths() As String)
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Var Engrams() As Beacon.Engram = Config.Engrams
		  
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Self.List.RemoveAllRows()
		  For Each Engram As Beacon.Engram In Engrams
		    Var Rate As Double = Config.Override(Engram)
		    Var EffectiveRate As Double = Round(Rate) * Round(Config.HarvestAmountMultiplier)
		    Self.List.AddRow(Engram.Label, Rate.PrettyText, EffectiveRate.PrettyText)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Engram
		    Self.List.Selected(Self.List.LastAddedRowIndex) = SelectPaths.IndexOf(Engram.Path) > -1
		  Next
		  
		  Self.List.Sort
		  Self.List.ScrollPosition = ScrollPosition
		  Self.List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty


	#tag Constant, Name = ColumnEffectiveRate, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnEngram, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRate, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.harvestrates", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events HarvestAmountMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Config.HarvestAmountMultiplier = CDbl(Me.Value)
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Open()
		  Var AddButton As New BeaconToolbarItem("AddEngram", IconToolbarAdd)
		  AddButton.HelpTag = "Override the harvest rate of an engram."
		  
		  Var DuplicateButton As New BeaconToolbarItem("Duplicate", IconToolbarClone, False)
		  DuplicateButton.HelpTag = "Duplicate the selected harvest rate override."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.LeftItems.Append(DuplicateButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddEngram"
		    Self.ShowAddOverride()
		  Case "Duplicate"
		    Self.ShowDuplicateOverride()
		  End Select
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
		  Self.Header.Duplicate.Enabled = Me.SelectedRowCount = 1
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
		  Var Engram As Beacon.Engram = Me.RowTagAt(Row)
		  
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
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
		      Message = "Are you sure you want to delete these " + Str(Me.SelectedRowCount, "-0") + " harvest rate overrides?"
		    End If
		    
		    If Not Self.ShowConfirm(Message, "This action cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Engram As Beacon.Engram = Me.RowTagAt(I)
		    Config.Override(Engram) = 0
		  Next
		  Self.Changed = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items As New Dictionary
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Engram As Beacon.Engram = Me.RowTagAt(I)
		    Var Rate As Double = Config.Override(Engram)
		    Items.Value(Engram.Path) = Rate
		  Next
		  
		  Board.AddRawData(Beacon.GenerateJSON(Items, False), Self.kClipboardType)
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
		    
		    Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		    Var SelectEngrams() As Beacon.Engram
		    For Each Entry As DictionaryEntry In Items
		      Var Path As String = Entry.Key
		      Var Engram As Beacon.Engram
		      If Path.BeginsWith("/Game/") Then
		        Engram = Beacon.Data.GetEngramByPath(Path)
		        If IsNull(Engram) Then
		          Engram = Beacon.Engram.CreateFromPath(Path)
		        End If
		      Else
		        Engram = Beacon.Data.GetEngramByClass(Path)
		        If IsNull(Engram) Then
		          Engram = Beacon.Engram.CreateFromClass(Path)
		        End If
		      End If
		      
		      Var Rate As Double = Entry.Value
		      SelectEngrams.AddRow(Engram)
		      Config.Override(Engram) = Rate
		    Next
		    Self.Changed = True
		    Self.UpdateList(SelectEngrams)
		    Return
		  End If
		  
		  If Board.TextAvailable Then
		    Var ImportText As String = Board.Text.GuessEncoding
		    Self.Parse(ImportText, "Clipboard")
		    Return
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UseOptimizedRatesCheck
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
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
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Config.HarvestHealthMultiplier = CDbl(Me.Value)
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
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Config.PlayerHarvestingDamageMultiplier = CDbl(Me.Value)
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
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Config.DinoHarvestingDamageMultiplier = CDbl(Me.Value)
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
		  Var Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Config.ClampResourceHarvestDamage = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
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
