#tag DesktopWindow
Begin BeaconDialog ArkAddLootDropDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   False
   MinWidth        =   450
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Add Loot Drop"
   Visible         =   True
   Width           =   550
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   400
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   550
      Begin UITweaks.ResizedPushButton SelectionActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   450
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton SelectionCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   358
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel SelectionMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Add Loot Drop"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   249
      End
      Begin UITweaks.ResizedPushButton CustomizeActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Done"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   450
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CustomizeCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Back"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   358
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel CustomizeMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Customize Loot Drop"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   510
      End
      Begin UITweaks.ResizedTextField CustomizeMinSetsField
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel CustomizeMinSetsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Min Item Sets:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   54
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedTextField CustomizeMaxSetsField
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   88
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel CustomizeMaxSetsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Max Item Sets:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   88
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin DesktopCheckBox CustomizePreventDuplicatesCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Prevent Duplicates"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   122
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   394
      End
      Begin DesktopLabel CustomizeTemplatesLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Templates:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   186
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin DesktopCheckBox CustomizeReconfigureCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Rebuild Existing Item Sets"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   394
      End
      Begin DesktopCheckBox SelectionExperimentalCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Show Experimental Loot Drops"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   326
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
         Hint            =   "Search Loot Drops"
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   281
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumRecentItems=   -1
         PanelIndex      =   0
         RecentItemsValue=   "Recent Searches"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Visible         =   True
         Width           =   249
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin BeaconListbox SourceList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   2
         ColumnWidths    =   "50,*"
         DefaultRowHeight=   "#BeaconListbox.DoubleLineRowHeight"
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   0
         Height          =   230
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   " 	Label	Kind	Package"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   510
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconListbox CustomizeTemplatesList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   2
         ColumnWidths    =   "22,*"
         DefaultRowHeight=   22
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   1
         Height          =   130
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   ""
         Italic          =   False
         Left            =   136
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   186
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   394
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin DesktopCheckBox CustomizeAppendItemSetsCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Add Item Sets to Default"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   136
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   154
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   394
      End
      Begin DesktopCheckBox LoadDefaultsCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Load Default Contents When Available"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   296
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   510
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  If Self.mShowAsDuplicate Then
		    Self.SelectionMessageLabel.Text = "Duplicate Loot Drop"
		    Self.LoadDefaultsCheckbox.Visible = False
		  End If
		  
		  Var HasExperimentalSources As Boolean = Ark.DataSource.Pool.Get(False).HasExperimentalLootContainers(Self.mContentPacks)
		  If HasExperimentalSources Then
		    Self.SelectionExperimentalCheck.Value = Preferences.ShowExperimentalLootSources
		  Else
		    Self.SelectionExperimentalCheck.Visible = False
		  End If
		  
		  Self.ResizeUI()
		  Self.BuildSourceList()
		  
		  If (Self.mSource Is Nil) = False Then
		    If Self.mShowAsDuplicate Then
		      Self.ShowSelect()
		    Else
		      Self.CustomizeCancelButton.Caption = "Cancel"
		      Self.mDestinations.ResizeTo(0)
		      Self.mDestinations(0) = Self.mSource
		      Self.ShowCustomize()
		    End If
		  End If
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BuildSourceList()
		  Var Data As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  
		  
		  Var CurrentContainers() As Ark.LootContainer = Self.mConfig.Containers
		  Var Labels As Dictionary = CurrentContainers.Disambiguate(Self.mMask)
		  Var AllowedLootContainers() As Ark.LootContainer = Data.GetLootContainers(Self.FilterField.Text.MakeUTF8, Self.mContentPacks, "", Preferences.ShowExperimentalLootSources)
		  For X As Integer = AllowedLootContainers.LastIndex DownTo 0
		    If Not AllowedLootContainers(X).ValidForMask(Self.mMask) Then
		      AllowedLootContainers.RemoveAt(X)
		    End If
		  Next
		  
		  For X As Integer = 0 To CurrentContainers.LastIndex
		    For Y As Integer = AllowedLootContainers.LastIndex DownTo 0
		      If AllowedLootContainers(Y).Path = CurrentContainers(X).Path Then
		        AllowedLootContainers.RemoveAt(Y)
		        Exit For Y
		      End If
		    Next
		  Next
		  AllowedLootContainers.Sort
		  
		  Var Selections() As String
		  For I As Integer = 0 To Self.SourceList.RowCount - 1
		    If Not Self.SourceList.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Container As Ark.LootContainer = Self.SourceList.RowTagAt(I)
		    Selections.Add(Container.Path)
		  Next
		  
		  Var ScrollPosition As Integer = Self.SourceList.ScrollPosition
		  Self.SourceList.RemoveAllRows
		  
		  Var MapLabels As New Dictionary
		  For Each Container As Ark.LootContainer In AllowedLootContainers
		    Var RowText As String = Labels.Lookup(Container.ObjectID, Container.Label)
		    If Container.Notes.IsEmpty = False Then
		      RowText = RowText + EndOfLine + Container.Notes
		    Else
		      Var ComboMask As UInt64 = Container.Availability And Self.mMask
		      If Not MapLabels.HasKey(ComboMask) Then
		        MapLabels.Value(ComboMask) = Ark.Maps.ForMask(ComboMask).Label
		      End If
		      RowText = RowText + EndOfLine + "Spawns on " + MapLabels.Value(ComboMask)
		    End If
		    Self.SourceList.AddRow("", RowText)
		    Self.SourceList.RowTagAt(Self.SourceList.LastAddedRowIndex) = Container
		    Self.SourceList.RowSelectedAt(Self.SourceList.LastAddedRowIndex) = Selections.IndexOf(Container.Path) > -1
		  Next
		  Self.SourceList.Sort
		  Self.SourceList.ScrollPosition = ScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ChooseSelectedLootSources()
		  If Self.SourceList.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Self.mDestinations.ResizeTo(-1)
		  
		  For I As Integer = 0 To Self.SourceList.RowCount - 1
		    If Not Self.SourceList.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Source As Ark.LootContainer = SourceList.RowTagAt(I)
		    
		    If Source.Experimental And Not Preferences.HasShownExperimentalWarning Then
		      If Self.ShowConfirm(Language.ExperimentalWarningMessage, Language.ReplacePlaceholders(Language.ExperimentalWarningExplanation, Source.Label), Language.ExperimentalWarningActionCaption, Language.ExperimentalWarningCancelCaption) Then
		        Preferences.HasShownExperimentalWarning = True
		      Else
		        Return
		      End If
		    End If
		    
		    Self.mDestinations.Add(Source.Clone)
		  Next
		  
		  If Self.LoadDefaultsCheckbox.Visible And Self.LoadDefaultsCheckbox.Value Then
		    // Skip the customize step, load defaults, and finish
		    Var Instance As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		    For Each Destination As Ark.LootContainer In Self.mDestinations
		      Var Mutable As New Ark.MutableLootContainer(Destination)
		      Instance.LoadDefaults(Mutable)
		      Self.mConfig.Add(Mutable)
		    Next
		    
		    Self.mCancelled = False
		    Self.Hide
		  Else
		    Self.ShowCustomize()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Config As Ark.Configs.LootDrops, Mask As UInt64, ContentPacks As Beacon.StringList, Source As Ark.LootContainer, ShowAsDuplicate As Boolean)
		  // Calling the overridden superclass constructor.
		  Self.mConfig = Config
		  Self.mMask = Mask
		  Self.mContentPacks = ContentPacks
		  Self.mSource = Source
		  Self.mShowAsDuplicate = ShowAsDuplicate
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Config As Ark.Configs.LootDrops, Mask As UInt64, ContentPacks As Beacon.StringList, Source As Ark.LootContainer = Nil, ShowAsDuplicate As Boolean = False) As Boolean
		  If Parent Is Nil Or Config Is Nil Then
		    Return False
		  End If
		  Parent = Parent.TrueWindow
		  
		  Var Maps() As Ark.Map = Ark.Maps.ForMask(Mask)
		  If Maps.LastIndex = -1 Then
		    Parent.ShowAlert("Beacon does not know which loot drops to show because no maps have been selected.", "Use the maps button at the top of the project to set the maps.")
		    Return False
		  End If
		  
		  ShowAsDuplicate = ShowAsDuplicate And (Source Is Nil) = False
		  Var Win As New ArkAddLootDropDialog(Config, Mask, ContentPacks, Source, ShowAsDuplicate)
		  Win.ShowModal(Parent)
		  
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResizeUI()
		  Var CheckboxBottom As Integer = Self.Height - 20
		  Var ListBottom As Integer = Self.Height - 60
		  If Self.SelectionExperimentalCheck.Visible Then
		    Self.SelectionExperimentalCheck.Top = CheckboxBottom - Self.SelectionExperimentalCheck.Height
		    CheckboxBottom = Self.SelectionExperimentalCheck.Top - 12
		    ListBottom = Min(ListBottom, Self.SelectionExperimentalCheck.Top - 20)
		  End If
		  If Self.LoadDefaultsCheckbox.Visible Then
		    Self.LoadDefaultsCheckbox.Top = CheckboxBottom - Self.LoadDefaultsCheckbox.Height
		    CheckboxBottom = Self.LoadDefaultsCheckbox.Top - 12
		    ListBottom = Min(ListBottom, Self.LoadDefaultsCheckbox.Top - 20)
		  End If
		  
		  Self.SourceList.Top = 60
		  Self.SourceList.Height = ListBottom - Self.SourceList.Top
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowCustomize()
		  Var BasedOn As Ark.LootContainer
		  If (Self.mSource Is Nil) = False Then
		    BasedOn = Self.mSource
		  Else
		    BasedOn = New Ark.MutableLootContainer()
		  End If
		  
		  Self.CustomizeMinSetsField.Text = BasedOn.MinItemSets.ToString(Locale.Current, "0")
		  Self.CustomizeMaxSetsField.Text = BasedOn.MaxItemSets.ToString(Locale.Current, "0")
		  Self.CustomizePreventDuplicatesCheck.Value = BasedOn.PreventDuplicates
		  Self.CustomizeAppendItemSetsCheck.Value = BasedOn.AppendMode
		  
		  Var Templates() As Ark.LootTemplate = Ark.DataSource.Pool.Get(False).GetLootTemplates()
		  
		  Self.CustomizeTemplatesList.RemoveAllRows()
		  For Each Template As Ark.LootTemplate In Templates
		    If Template.ValidForMask(Self.mMask) Then
		      Self.CustomizeTemplatesList.AddRow("", Template.Label)
		      Self.CustomizeTemplatesList.RowTagAt(Self.CustomizeTemplatesList.LastAddedRowIndex) = Template
		    End If
		  Next
		  Self.CustomizeTemplatesList.Sort
		  
		  Var Scrolled, HasUsedTemplates As Boolean
		  For I As Integer = 0 To Self.CustomizeTemplatesList.RowCount - 1
		    Var Template As Ark.LootTemplate = Self.CustomizeTemplatesList.RowTagAt(I)
		    For Each Set As Ark.LootItemSet In BasedOn
		      If Set.TemplateUUID = Template.UUID Then
		        HasUsedTemplates = True
		        Self.CustomizeTemplatesList.CellCheckBoxValueAt(I, 0) = True
		        If Set.Label <> Template.Label Then
		          Self.CustomizeTemplatesList.CellTextAt(I, 1) = Set.Label + " (" + Template.Label + ")"
		        End If
		        If Not Scrolled Then
		          Self.CustomizeTemplatesList.ScrollPosition = I
		          Scrolled = True
		        End If
		        Continue For I
		      End If
		    Next
		    
		    Self.CustomizeTemplatesList.CellCheckBoxValueAt(I, 0) = False
		  Next
		  
		  If HasUsedTemplates = False Then
		    Self.CustomizeReconfigureCheckbox.Visible = False
		    Self.CustomizeTemplatesList.Height = (Self.CustomizeReconfigureCheckbox.Top + Self.CustomizeReconfigureCheckbox.Height) - Self.CustomizeTemplatesList.Top
		  End If
		  
		  Self.Panel.SelectedPanelIndex = Self.PaneCustomize
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowSelect()
		  Self.Panel.SelectedPanelIndex = Self.PaneSelection
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfig As Ark.Configs.LootDrops
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPacks As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinations() As Ark.LootContainer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShowAsDuplicate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Ark.LootContainer
	#tag EndProperty


	#tag Constant, Name = PaneCustomize, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PaneSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events SelectionActionButton
	#tag Event
		Sub Pressed()
		  Self.ChooseSelectedLootSources()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionCancelButton
	#tag Event
		Sub Pressed()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizeActionButton
	#tag Event
		Sub Pressed()
		  Var MinItemSets As Integer = Floor(CDbl(Self.CustomizeMinSetsField.Text))
		  Var MaxItemSets As Integer = Floor(CDbl(Self.CustomizeMaxSetsField.Text))
		  Var PreventDuplicates As Boolean = Self.CustomizePreventDuplicatesCheck.Value
		  Var AppendMode As Boolean = Self.CustomizeAppendItemSetsCheck.Value
		  Var ReconfigureTemplates As Boolean = Self.CustomizeReconfigureCheckbox.Value
		  
		  Var AllowedTemplates(), AdditionalTemplates() As String
		  For I As Integer = 0 To Self.CustomizeTemplatesList.RowCount - 1
		    If Not Self.CustomizeTemplatesList.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Var Template As Ark.LootTemplate = Self.CustomizeTemplatesList.RowTagAt(I)
		    AllowedTemplates.Add(Template.UUID)
		    AdditionalTemplates.Add(Template.UUID)
		  Next
		  
		  Var SourceSets() As Ark.LootItemSet
		  If (Self.mSource Is Nil) = False Then
		    For Each Set As Ark.LootItemSet In Self.mSource
		      If Set.TemplateUUID.IsEmpty Or AllowedTemplates.IndexOf(Set.TemplateUUID) > -1 Or Ark.DataSource.Pool.Get(False).GetLootTemplateByUUID(Set.TemplateUUID) Is Nil Then
		        SourceSets.Add(Set)
		      End If
		      
		      Var Idx As Integer = AdditionalTemplates.IndexOf(Set.TemplateUUID)
		      If Idx > -1 Then
		        AdditionalTemplates.RemoveAt(Idx)
		      End If
		    Next
		  End If
		  
		  For Each Destination As Ark.LootContainer In Self.mDestinations
		    Var Mutable As New Ark.MutableLootContainer(Destination)
		    Mutable.MinItemSets = MinItemSets
		    Mutable.MaxItemSets = MaxItemSets
		    Mutable.PreventDuplicates = PreventDuplicates
		    Mutable.AppendMode = AppendMode
		    
		    // Add the clones
		    For Each Set As Ark.LootItemSet In SourceSets
		      Mutable.Add(Set)
		    Next
		    
		    // Add newly selected templates
		    For Each TemplateID As String In AdditionalTemplates
		      Var Template As Ark.LootTemplate = Ark.DataSource.Pool.Get(False).GetLootTemplateByUUID(TemplateID)
		      If Template Is Nil Then
		        Continue
		      End If
		      
		      Mutable.Add(Ark.LootItemSet.FromTemplate(Template, Mutable, Self.mMask, Self.mContentPacks))
		    Next
		    
		    // Rebuild if necessary
		    If ReconfigureTemplates Then
		      Call Mutable.RebuildItemSets(Self.mMask, Self.mContentPacks)
		    End If
		    
		    Self.mConfig.Add(Mutable)
		  Next
		  
		  Self.mCancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizeCancelButton
	#tag Event
		Sub Pressed()
		  If Me.Caption = "Cancel" Then
		    Self.mCancelled = True
		    Self.Hide
		    Return
		  End If
		  
		  Self.ShowSelect()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectionExperimentalCheck
	#tag Event
		Sub ValueChanged()
		  If Preferences.ShowExperimentalLootSources = Me.Value Then
		    Return
		  End If
		  
		  Preferences.ShowExperimentalLootSources = Me.Value
		  Self.BuildSourceList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.BuildSourceList
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceList
	#tag Event
		Sub SelectionChanged()
		  SelectionActionButton.Enabled = Me.SelectedRowIndex > -1
		End Sub
	#tag EndEvent
	#tag Event
		Sub PaintCellBackground(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  #Pragma Unused TextColor
		  
		  If Column <> 0 Or Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Var Container As Ark.LootContainer = Me.RowTagAt(Row)
		  Var Icon As Picture
		  If Me.RowSelectedAt(Row) And IsHighlighted Then
		    Icon = Ark.DataSource.Pool.Get(False).GetLootContainerIcon(Container, TextColor, BackgroundColor)
		  Else
		    Icon = Ark.DataSource.Pool.Get(False).GetLootContainerIcon(Container, BackgroundColor)
		  End If
		  
		  G.DrawPicture(Icon, NearestMultiple((G.Width - Icon.Width) / 2, G.ScaleX), NearestMultiple((G.Height - Icon.Height) / 2, G.ScaleY))
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 0 Then
		    Return False
		  End If
		  
		  Var Source1 As Ark.LootContainer = Me.RowTagAt(Row1)
		  Var Source2 As Ark.LootContainer = Me.RowTagAt(Row2)
		  
		  If Source1.SortValue > Source2.SortValue Then
		    Result = 1
		  ElseIf Source1.SortValue < Source2.SortValue Then
		    Result = -1
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.TypeaheadColumn = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoublePressed()
		  Self.ChooseSelectedLootSources()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CustomizeTemplatesList
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(0) = DesktopListbox.CellTypes.CheckBox
		  Me.TypeaheadColumn = 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoadDefaultsCheckbox
	#tag Event
		Sub ValueChanged()
		  Var Caption As String = If(Me.Value, "Done", "Next")
		  If Self.SelectionActionButton.Caption <> Caption Then
		    Self.SelectionActionButton.Caption = Caption
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
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
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
