#tag Window
Begin ConfigEditor HarvestRatesConfigEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
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
   Visible         =   True
   Width           =   764
   Begin UITweaks.ResizedTextField HarvestAmountMultiplierField
      AcceptTabs      =   False
      Alignment       =   "2"
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values increase harvest yields, smaller values decrease harvest yields."
      Hint            =   ""
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
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   53
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      ValidationMask  =   ""
      Value           =   "1.0"
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel HarvestAmountMultiplierLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "2"
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   53
      Transparent     =   False
      Underline       =   False
      Value           =   "Global Harvest Rate Multiplier:"
      Visible         =   True
      Width           =   227
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Harvest Rate Overrides"
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "False"
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
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "True"
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
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
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
      DropIndicatorVisible=   False
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontal=   "0"
      GridLinesHorizontalStyle=   "0"
      GridLinesVertical=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   True
      HasHeading      =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
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
      RowCount        =   "0"
      RowSelectionType=   "1"
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionRequired=   False
      SelectionType   =   "1"
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
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "True"
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
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Use Optimized Harvest Rates"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      State           =   "0"
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
      VisualState     =   "0"
      Width           =   393
   End
   Begin UITweaks.ResizedTextField HarvestHealthMultiplierField
      AcceptTabs      =   False
      Alignment       =   "2"
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values will require more damage to break, smaller values reduced required damage."
      Hint            =   ""
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
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   87
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      ValidationMask  =   ""
      Value           =   "1.0"
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel HarvestHealthMultiplierLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "2"
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   87
      Transparent     =   False
      Underline       =   False
      Value           =   "Global Harvest Health Multiplier:"
      Visible         =   True
      Width           =   227
   End
   Begin UITweaks.ResizedTextField PlayerHarvestDamageMultiplierField
      AcceptTabs      =   False
      Alignment       =   "2"
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values increase damage players do to harvestable resources, smaller values decrease player damage."
      Hint            =   ""
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
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   121
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      ValidationMask  =   ""
      Value           =   "1.0"
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel PlayerHarvestDamageMultiplierLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "2"
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   121
      Transparent     =   False
      Underline       =   False
      Value           =   "Player Harvest Damage Multiplier:"
      Visible         =   True
      Width           =   227
   End
   Begin UITweaks.ResizedTextField DinoHarvestDamageMultiplierField
      AcceptTabs      =   False
      Alignment       =   "2"
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      HelpTag         =   "1.0 = Normal. Higher values increase damage creatures do to harvestable resources, smaller values decrease creature damage."
      Hint            =   ""
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
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   155
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      ValidationMask  =   ""
      Value           =   "1.0"
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel DinoHarvestDamageMultiplierLabel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      TextAlign       =   "2"
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   155
      Transparent     =   False
      Underline       =   False
      Value           =   "Creature Harvest Damage Multiplier:"
      Visible         =   True
      Width           =   227
   End
   Begin CheckBox ClampHarvestDamageCheck
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Clamp Harvesting Damage"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
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
      State           =   "0"
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
      VisualState     =   "0"
      Width           =   393
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub ParsingFinished(ParsedData As Xojo.Core.Dictionary)
		  // Don't import the properties, it would likely be confusing for users
		  
		  If ParsedData = Nil Then
		    Return
		  End If
		  
		  Dim OtherConfig As BeaconConfigs.HarvestRates = BeaconConfigs.HarvestRates.FromImport(ParsedData, New Xojo.Core.Dictionary, Self.Document.MapCompatibility, Self.Document.Difficulty)
		  If OtherConfig = Nil Or OtherConfig.Count = 0 Then
		    Return
		  End If
		  
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Dim Classes() As Text = OtherConfig.Classes
		  For Each ClassString As Text In Classes
		    Config.Override(ClassString) = OtherConfig.Override(ClassString)
		  Next
		  Self.Changed = True
		  Self.UpdateList(Classes)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.HarvestRates.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Self.HarvestAmountMultiplierField.Value = Format(Config.HarvestAmountMultiplier, "0.0#####")
		  Self.HarvestHealthMultiplierField.Value = Format(Config.HarvestHealthMultiplier, "0.0#####")
		  Self.PlayerHarvestDamageMultiplierField.Value = Format(Config.PlayerHarvestingDamageMultiplier, "0.0#####")
		  Self.DinoHarvestDamageMultiplierField.Value = Format(Config.DinoHarvestingDamageMultiplier, "0.0#####")
		  Self.ClampHarvestDamageCheck.Value = Config.ClampResourceHarvestDamage
		  Self.UseOptimizedRatesCheck.Value = Config.UseOptimizedRates
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.HarvestRates
		  Static ConfigName As Text = BeaconConfigs.HarvestRates.ConfigName
		  
		  Dim Document As Beacon.Document = Self.Document
		  Dim Config As BeaconConfigs.HarvestRates
		  
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
		Function ConfigLabel() As Text
		  Return Language.LabelForConfig(BeaconConfigs.HarvestRates.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddOverride()
		  Dim CurrentEngrams() As Beacon.Engram
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Dim Classes() As Text = Config.Classes
		  For Each ClassString As Text In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Continue
		    End If
		    
		    CurrentEngrams.Append(Engram)
		  Next
		  
		  Dim NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Document.Mods, False)
		  If NewEngrams = Nil Or NewEngrams.Ubound = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram.ClassString) = 1.0
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
		  
		  Dim CurrentEngrams() As Beacon.Engram
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Dim Classes() As Text = Config.Classes
		  For Each ClassString As Text In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Continue
		    End If
		    
		    CurrentEngrams.Append(Engram)
		  Next
		  
		  Dim NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Document.Mods, True)
		  If NewEngrams = Nil Or NewEngrams.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim SourceClass As Text = Self.List.RowTag(Self.List.SelectedIndex)
		  Dim Rate As Double = Config.Override(SourceClass)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram.ClassString) = Rate
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Dim Classes() As Text
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Classes.Append(Self.List.RowTag(I))
		  Next
		  Self.UpdateList(Classes)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As Beacon.Engram)
		  Dim Classes() As Text
		  For Each Engram As Beacon.Engram In SelectEngrams
		    Classes.Append(Engram.ClassString)
		  Next
		  Self.UpdateList(Classes) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectClasses() As Text)
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  Dim Classes() As Text = Config.Classes
		  
		  Dim ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Self.List.DeleteAllRows()
		  For Each ClassString As Text In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    Dim EngramName As Text
		    If Engram <> Nil Then
		      EngramName = Engram.Label
		    Else
		      EngramName = ClassString
		    End If
		    
		    Dim Rate As Double = Config.Override(ClassString)
		    Dim EffectiveRate As Double = Rate * Config.HarvestAmountMultiplier
		    Self.List.AddRow(EngramName, Rate.PrettyText, EffectiveRate.PrettyText)
		    Self.List.RowTag(Self.List.LastAddedRowIndex) = ClassString
		    Self.List.Selected(Self.List.LastAddedRowIndex) = SelectClasses.IndexOf(ClassString) > -1
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
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
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
		  Dim AddButton As New BeaconToolbarItem("AddEngram", IconAdd)
		  AddButton.HelpTag = "Override the harvest rate of an engram."
		  
		  Dim DuplicateButton As New BeaconToolbarItem("Duplicate", IconToolbarClone, False)
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
		  Me.ColumnAlignment(Self.ColumnRate) = Listbox.AlignRight
		  Me.ColumnAlignment(Self.ColumnEffectiveRate) = Listbox.AlignRight
		  Me.ColumnType(Self.ColumnRate) = Listbox.TypeEditable
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
		  
		  Dim Rate As Double = CDbl(Me.Cell(Row, Column))
		  If Rate <= 0 Then
		    Rate = 1
		  End If
		  Dim ClassString As Text = Me.RowTag(Row)
		  
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Config.Override(ClassString) = Rate
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
		    Dim Message As String
		    If Me.SelectedRowCount = 1 Then
		      Message = "Are you sure you want to delete the """ + Me.Cell(Me.SelectedIndex, 0) + """ harvest rate override?"
		    Else
		      Message = "Are you sure you want to delete these " + Str(Me.SelectedRowCount, "-0") + " harvest rate overrides?"
		    End If
		    
		    If Not Self.ShowConfirm(Message, "This action cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ClassString As Text = Me.RowTag(I)
		    Config.Override(ClassString) = 0
		  Next
		  Self.Changed = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Items As New Xojo.Core.Dictionary
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ClassString As Text = Me.RowTag(I)
		    Dim Rate As Double = Config.Override(ClassString)
		    Items.Value(ClassString) = Rate
		  Next
		  
		  Board.AddRawData(Xojo.Data.GenerateJSON(Items), Self.kClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim JSON As Text = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8).ToText
		    Dim Items As Xojo.Core.Dictionary
		    Try
		      Items = Xojo.Data.ParseJSON(JSON)
		    Catch Err As Xojo.Data.InvalidJSONException
		      Items = New Xojo.Core.Dictionary
		    End Try
		    
		    If Items.Count = 0 Then
		      Return
		    End If
		    
		    Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
		    Dim SelectClasses() As Text
		    For Each Entry As Xojo.Core.DictionaryEntry In Items
		      Dim ClassString As Text = Entry.Key
		      Dim Rate As Double = Entry.Value
		      SelectClasses.Append(ClassString)
		      Config.Override(ClassString) = Rate
		    Next
		    Self.Changed = True
		    Self.UpdateList(SelectClasses)
		    Return
		  End If
		  
		  If Board.TextAvailable Then
		    Dim ImportText As String = Board.Text.GuessEncoding
		    Self.Parse(ImportText.ToText, "Clipboard")
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
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
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
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
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
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
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
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
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
		  Dim Config As BeaconConfigs.HarvestRates = Self.Config(True)
		  Config.ClampResourceHarvestDamage = Me.Value
		  Self.Changed = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
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
