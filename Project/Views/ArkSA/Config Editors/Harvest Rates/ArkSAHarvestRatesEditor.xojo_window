#tag DesktopWindow
Begin ArkSAConfigEditor ArkSAHarvestRatesEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
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
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel HarvestAmountMultiplierLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin FadedSeparator FadedSeparator2
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
      Tooltip         =   ""
      Top             =   205
      Transparent     =   True
      Visible         =   True
      Width           =   764
   End
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
      ColumnCount     =   3
      ColumnWidths    =   "*,150,150"
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
      Height          =   231
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
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   206
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   764
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopCheckBox UseOptimizedRatesCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Use Optimized Harvest Rates"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   393
   End
   Begin UITweaks.ResizedTextField HarvestHealthMultiplierField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   95
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel HarvestHealthMultiplierLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   95
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin UITweaks.ResizedTextField PlayerHarvestDamageMultiplierField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   129
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel PlayerHarvestDamageMultiplierLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   129
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin UITweaks.ResizedTextField DinoHarvestDamageMultiplierField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   259
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   163
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel DinoHarvestDamageMultiplierLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   163
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   227
   End
   Begin DesktopCheckBox ClampHarvestDamageCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Clamp Harvesting Damage"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   96
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
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
      Width           =   496
   End
   Begin DelayedSearchField FilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Rates"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   505
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   9
      Transparent     =   False
      Visible         =   True
      Width           =   250
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin OmniBarSeparator FilterSeparator
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
      Left            =   496
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   269
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
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   437
      Transparent     =   True
      Visible         =   True
      Width           =   764
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function ParsingFinished(Project As ArkSA.Project) As Boolean
		  // Don't import the properties, it would likely be confusing for users
		  
		  If Project Is Nil Or Project.HasConfigGroup(ArkSA.Configs.NameHarvestRates) = False Then
		    Return True
		  End If
		  
		  Var OtherConfig As ArkSA.Configs.HarvestRates = ArkSA.Configs.HarvestRates(Project.ConfigGroup(ArkSA.Configs.NameHarvestRates))
		  If OtherConfig = Nil Or OtherConfig.Count = CType(0, UInteger) Then
		    Return True
		  End If
		  
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Var Engrams() As ArkSA.Engram = OtherConfig.Engrams
		  For Each Engram As ArkSA.Engram In Engrams
		    Config.Override(Engram) = OtherConfig.Override(Engram)
		  Next
		  Self.Modified = True
		  Self.UpdateList(Engrams)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub RunTool(Tool As ArkSA.ProjectTool)
		  Select Case Tool.UUID
		  Case "5265adcd-5c7e-437c-bce2-d10721afde43"
		    Self.ConvertGlobalHarvestRate()
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(False)
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
		Protected Function Config(ForWriting As Boolean) As ArkSA.Configs.HarvestRates
		  Return ArkSA.Configs.HarvestRates(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConvertGlobalHarvestRate()
		  If Self.Config(False).HarvestAmountMultiplier = 1.0 Then
		    Return
		  End If
		  
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Var GlobalRate As Double = Config.HarvestAmountMultiplier
		  Var SkippedEngrams As New Dictionary
		  Var Engrams() As ArkSA.Engram = Config.Engrams
		  For Each Engram As ArkSA.Engram In Engrams
		    SkippedEngrams.Value(Engram.EngramId) = True
		    Config.Override(Engram) = Round(Config.Override(Engram) * GlobalRate)
		  Next
		  
		  Engrams = ArkSA.ActiveBlueprintProviders.GetEngrams("", Self.Project.ContentPacks, New Beacon.TagSpec(Array("harvestable"), Nil))
		  For Each Engram As ArkSA.Engram In Engrams
		    If SkippedEngrams.HasKey(Engram.EngramId) Then
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
		  Return ArkSA.Configs.NameHarvestRates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddOverride()
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(False)
		  Var CurrentEngrams() As ArkSA.Engram = Config.Engrams
		  
		  Var NewEngrams() As ArkSA.Engram = ArkSABlueprintSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Project.ContentPacks, ArkSABlueprintSelectorDialog.SelectModes.ImpliedMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As ArkSA.Engram In NewEngrams
		    Config.Override(Engram) = 1.0
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicateOverride()
		  If Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(False)
		  Var CurrentEngrams() As ArkSA.Engram = Config.Engrams
		  
		  Var NewEngrams() As ArkSA.Engram = ArkSABlueprintSelectorDialog.Present(Self, "Harvesting", CurrentEngrams, Self.Project.ContentPacks, ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var SourceEngram As ArkSA.Engram = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Var Rate As Double = Config.Override(SourceEngram)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As ArkSA.Engram In NewEngrams
		    Config.Override(Engram) = Rate
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Selections() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Selections.Add(ArkSA.Engram(Self.List.RowTagAt(I)).EngramId)
		  Next
		  Self.UpdateList(Selections)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As ArkSA.Engram)
		  Var Selections() As String
		  For Each Engram As ArkSA.Engram In SelectEngrams
		    Selections.Add(Engram.EngramId)
		  Next
		  Self.UpdateList(Selections) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selections() As String)
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(False)
		  Var Engrams() As ArkSA.Engram = Config.Engrams
		  
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Var Filter As String = Self.FilterField.Text.Trim
		  
		  Self.List.RemoveAllRows()
		  For Each Engram As ArkSA.Engram In Engrams
		    If Filter.IsEmpty = False And Engram.Label.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Var Rate As Double = Config.Override(Engram)
		    Var EffectiveRate As Double = Round(Rate) * Round(Config.HarvestAmountMultiplier)
		    Self.List.AddRow(Engram.Label, Rate.PrettyText, EffectiveRate.PrettyText)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Engram
		    Self.List.RowSelectedAt(Self.List.LastAddedRowIndex) = Selections.IndexOf(Engram.EngramId) > -1
		  Next Engram
		  
		  Self.List.Sort
		  Self.List.ScrollPosition = ScrollPosition
		  Self.List.SelectionChangeBlocked = False
		  Self.UpdateStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Var TotalItems As Integer = Self.List.RowCount
		  Var SelectedItems As Integer = Self.List.SelectedRowCount
		  Var Noun As String = If(TotalItems = 1, "Harvest Rate Override", "Harvest Rate Overrides")
		  
		  If SelectedItems > 0 Then
		    Self.Status.CenterCaption = SelectedItems.ToString(Locale.Current, "#,##0") + " of " + TotalItems.ToString(Locale.Current, "#,##0") + " " + Noun + " Selected"
		  Else
		    Self.Status.CenterCaption = TotalItems.ToString(Locale.Raw, "0") + " " + Noun
		  End If
		End Sub
	#tag EndMethod


	#tag Constant, Name = ColumnEffectiveRate, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnEngram, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRate, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.arksa.harvestrates", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events HarvestAmountMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Config.HarvestAmountMultiplier = CDbl(Me.Text)
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(Self.ColumnRate) = DesktopListbox.Alignments.Right
		  Me.ColumnAlignmentAt(Self.ColumnEffectiveRate) = DesktopListbox.Alignments.Right
		  Me.ColumnTypeAt(Self.ColumnRate) = DesktopListbox.CellTypes.TextField
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Var DuplicateButton As OmniBarItem = Self.ConfigToolbar.Item("Duplicate")
		  If (DuplicateButton Is Nil) = False Then
		    DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  End If
		  Self.UpdateStatus
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> Self.ColumnRate Then
		    Return
		  End If
		  
		  Var Rate As Double = CDbl(Me.CellTextAt(Row, Column))
		  If Rate <= 0 Then
		    Rate = 1
		  End If
		  Var Engram As ArkSA.Engram = Me.RowTagAt(Row)
		  
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Config.Override(Engram) = Rate
		  Self.Modified = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.Project.ReadOnly = False
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Var Message As String
		    If Me.SelectedRowCount = 1 Then
		      Message = "Are you sure you want to delete the """ + Me.CellTextAt(Me.SelectedRowIndex, 0) + """ harvest rate override?"
		    Else
		      Message = "Are you sure you want to delete these " + Me.SelectedRowCount.ToString(Locale.Raw, "0") + " harvest rate overrides?"
		    End If
		    
		    If Not Self.ShowConfirm(Message, "This action cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Engram As ArkSA.Engram = Me.RowTagAt(I)
		    Config.Override(Engram) = 0
		  Next
		  Self.Modified = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items As New Dictionary
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Engram As ArkSA.Engram = Me.RowTagAt(I)
		    Var Rate As Double = Config.Override(Engram)
		    Items.Value(Engram.EngramId) = Rate
		  Next
		  
		  If Items.KeyCount = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(Self.kClipboardType, Items)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As Variant = Board.GetClipboardData(Self.kClipboardType)
		  If Contents.IsNull = False Then
		    Try
		      Var Rates As Dictionary = Contents
		      If Rates.KeyCount = 0 Then
		        Return
		      End If
		      
		      Var SelectEngrams() As ArkSA.Engram
		      Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		      Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		      For Each Entry As DictionaryEntry In Rates
		        Var EngramId As String = Entry.Key
		        Var Engram As ArkSA.Engram = DataSource.GetEngram(EngramId)
		        If Engram Is Nil Then
		          Continue
		        End If
		        
		        Var Rate As Double = Entry.Value
		        Config.Override(Engram) = Rate
		        SelectEngrams.Add(Engram)
		      Next
		      
		      If SelectEngrams.Count > 0 Then
		        Self.Modified = True
		        Self.UpdateList(SelectEngrams)
		      End If
		    Catch Err As RuntimeException
		      Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    End Try
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
		Sub ValueChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Config.UseOptimizedRates = Me.Value
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HarvestHealthMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Config.HarvestHealthMultiplier = CDbl(Me.Text)
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlayerHarvestDamageMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Config.PlayerHarvestingDamageMultiplier = CDbl(Me.Text)
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DinoHarvestDamageMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Config.DinoHarvestingDamageMultiplier = CDbl(Me.Text)
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClampHarvestDamageCheck
	#tag Event
		Sub ValueChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As ArkSA.Configs.HarvestRates = Self.Config(True)
		  Config.ClampResourceHarvestDamage = Me.Value
		  Self.Modified = Config.Modified
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
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
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateList
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
