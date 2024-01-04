#tag DesktopWindow
Begin BeaconDialog ArkSABlueprintSelectorDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   471
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   471
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Select Object"
   Visible         =   True
   Width           =   600
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Select an Object"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
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
      ColumnCount     =   2
      ColumnWidths    =   "*,200"
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
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   254
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Mod"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   165
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Select"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   431
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   431
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox SelectedList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
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
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   254
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Selected Objects"
      Italic          =   False
      Left            =   714
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   165
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   200
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton AddToSelectionsButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   ">>"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   662
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   266
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin UITweaks.ResizedPushButton RemoveFromSelectionsButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "<<"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   662
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   298
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin TagPicker Picker
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Border          =   15
      ContentHeight   =   0
      Enabled         =   True
      ExcludeTagCaption=   ""
      Height          =   67
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      NeutralTagCaption=   ""
      RequireTagCaption=   ""
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      Spec            =   ""
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   86
      Transparent     =   True
      Visible         =   True
      Width           =   560
   End
   Begin DesktopCheckBox WithDefaultsCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Load Official Values When Available"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   431
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   False
      VisualState     =   0
      Width           =   376
   End
   Begin DelayedSearchField FilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      AllowTabStop    =   True
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Search Objects"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Visible         =   True
      Width           =   560
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.Picker.Tags = ArkSA.DataSource.Pool.Get(False).GetTags(Self.mMods, Self.mCategory)
		  Self.Picker.Spec = Preferences.SelectedTag(Self.mCategory, Self.mSubgroup)
		  Self.UpdateFilter()
		  Self.SwapButtons()
		  Self.ActionButton.Enabled = False
		  Self.Resize()
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddBlueprintsToList(Blueprints() As ArkSA.Blueprint, Blacklist() As String, AddToBlacklist As Boolean, CheckTags As Boolean)
		  Var RequiredTags(), ExcludedTags() As String
		  If CheckTags Then
		    Try
		      RequiredTags = Self.Picker.RequiredTags()
		      ExcludedTags = Self.Picker.ExcludedTags()
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    If Blacklist.IndexOf(Blueprint.BlueprintId) > -1 Then
		      Continue
		    End If
		    
		    If CheckTags = True And Blueprint.MatchesTags(RequiredTags, ExcludedTags) = False Then
		      Continue
		    End If
		    
		    Self.List.AddRow(Blueprint.Label, Blueprint.ContentPackName)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Blueprint
		    
		    If AddToBlacklist Then
		      Blacklist.Add(Blueprint.BlueprintId)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Category As String, Subgroup As String, Exclude() As ArkSA.Blueprint, Mods As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes, ShowLoadDefaults As Boolean)
		  Var References() As ArkSA.BlueprintReference
		  For Each Blueprint As ArkSA.Blueprint In Exclude
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    References.Add(New ArkSA.BlueprintReference(Blueprint))
		  Next
		  Self.Constructor(Category, Subgroup, References, Mods, SelectMode, ShowLoadDefaults)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Category As String, Subgroup As String, Exclude() As ArkSA.BlueprintReference, Mods As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes, ShowLoadDefaults As Boolean)
		  Self.mSettingUp = True
		  For Each Reference As ArkSA.BlueprintReference In Exclude
		    If Reference Is Nil Then
		      Continue
		    End If
		    
		    Self.mExcluded.Add(Reference.BlueprintId)
		  Next
		  Self.mMods = Mods
		  Self.mCategory = Category
		  Self.mSubgroup = Subgroup
		  Super.Constructor
		  
		  If SelectMode = ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultipleWithExcluded Then
		    For Each Reference As ArkSA.BlueprintReference In Exclude
		      If Reference Is Nil Then
		        Continue
		      End If
		      
		      Self.SelectedList.AddRow(Reference.Label)
		      Self.SelectedList.RowTagAt(Self.SelectedList.LastAddedRowIndex) = Reference.Resolve
		    Next
		    SelectMode = ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple
		  End If
		  Self.mSelectMode = SelectMode
		  
		  Self.WithDefaultsCheck.Visible = ShowLoadDefaults
		  Self.WithDefaultsCheck.Value = ShowLoadDefaults
		  
		  Select Case SelectMode
		  Case ArkSABlueprintSelectorDialog.SelectModes.Single
		    // Good news, it's already setup
		  Case ArkSABlueprintSelectorDialog.SelectModes.ImpliedMultiple
		    Self.List.RowSelectionType = DesktopListbox.RowSelectionTypes.Multiple
		  Case ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple
		    Self.Width = Self.Width + 150
		    Self.List.ColumnWidths = "*,150"
		    Self.List.RowSelectionType = DesktopListbox.RowSelectionTypes.Multiple
		    Self.List.Width = Self.List.Width - (24 + Self.SelectedList.Width + Self.AddToSelectionsButton.Width)
		    Self.AddToSelectionsButton.Left = Self.List.Left + Self.List.Width + 12
		    Self.RemoveFromSelectionsButton.Left = Self.AddToSelectionsButton.Left
		    Self.SelectedList.Left = Self.AddToSelectionsButton.Left + Self.AddToSelectionsButton.Width + 12
		    Self.MessageLabel.Text = "Select Objects"
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MakeSelection()
		  If Self.mSelectMode <> ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple Then
		    Self.SelectedList.RemoveAllRows()
		  End If
		  
		  If Self.List.SelectedRowCount > 1 Then
		    For I As Integer = Self.List.RowCount - 1 DownTo 0
		      If Not Self.List.RowSelectedAt(I) Then
		        Continue
		      End If
		      
		      Self.SelectedList.AddRow(Self.List.CellTextAt(I, 0))
		      Self.SelectedList.RowTagAt(Self.SelectedList.LastAddedRowIndex) = Self.List.RowTagAt(I)
		      If Self.mSelectMode = ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple Then
		        Self.mExcluded.Add(ArkSA.Blueprint(Self.List.RowTagAt(I)).BlueprintId)
		        Self.List.RemoveRowAt(I)
		      End If
		    Next
		  ElseIf Self.List.SelectedRowCount = 1 Then
		    Self.SelectedList.AddRow(Self.List.CellTextAt(Self.List.SelectedRowIndex, 0))
		    Self.SelectedList.RowTagAt(Self.SelectedList.LastAddedRowIndex) = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		    If Self.mSelectMode = ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple Then
		      Self.mExcluded.Add(ArkSA.Blueprint(Self.List.RowTagAt(Self.List.SelectedRowIndex)).BlueprintId)
		      Self.List.RemoveRowAt(Self.List.SelectedRowIndex)
		    End If
		  End If
		  
		  Self.ActionButton.Enabled = Self.SelectedList.RowCount > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Subgroup As String, Exclude() As ArkSA.Creature, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes) As ArkSA.Creature()
		  Var WithDefaults As Boolean
		  Return Present(Parent, Subgroup, Exclude, ContentPacks, SelectMode, WithDefaults)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Subgroup As String, Exclude() As ArkSA.Creature, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes, ByRef WithDefaults As Boolean) As ArkSA.Creature()
		  Var ExcludeBlueprints() As ArkSA.Blueprint
		  For Each Creature As ArkSA.Creature In Exclude
		    ExcludeBlueprints.Add(Creature)
		  Next
		  
		  Var Blueprints() As ArkSA.Blueprint = Present(Parent, ArkSA.CategoryCreatures, Subgroup, ExcludeBlueprints, ContentPacks, SelectMode, WithDefaults)
		  Var Creatures() As ArkSA.Creature
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    If Blueprint IsA ArkSA.Creature Then
		      Creatures.Add(ArkSA.Creature(Blueprint))
		    End If
		  Next
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Subgroup As String, Exclude() As ArkSA.Engram, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes) As ArkSA.Engram()
		  Var WithDefaults As Boolean
		  Return Present(Parent, Subgroup, Exclude, ContentPacks, SelectMode, WithDefaults)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Subgroup As String, Exclude() As ArkSA.Engram, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes, ByRef WithDefaults As Boolean) As ArkSA.Engram()
		  Var ExcludeBlueprints() As ArkSA.Blueprint
		  For Each Engram As ArkSA.Engram In Exclude
		    ExcludeBlueprints.Add(Engram)
		  Next
		  
		  Var Blueprints() As ArkSA.Blueprint = Present(Parent, ArkSA.CategoryEngrams, Subgroup, ExcludeBlueprints, ContentPacks, SelectMode, WithDefaults)
		  Var Engrams() As ArkSA.Engram
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    If Blueprint IsA ArkSA.Engram Then
		      Engrams.Add(ArkSA.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Category As String, Subgroup As String, Exclude() As ArkSA.Blueprint, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes) As ArkSA.Blueprint()
		  Var WithDefaults As Boolean
		  Return Present(Parent, Category, Subgroup, Exclude, ContentPacks, SelectMode, WithDefaults)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Category As String, Subgroup As String, Exclude() As ArkSA.Blueprint, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes, ByRef WithDefaults As Boolean) As ArkSA.Blueprint()
		  Var Blueprints() As ArkSA.Blueprint
		  If Parent = Nil Then
		    Return Blueprints
		  End If
		  
		  If ContentPacks Is Nil Then
		    ContentPacks = New Beacon.StringList
		  End If
		  
		  Var Win As New ArkSABlueprintSelectorDialog(Category, Subgroup, Exclude, ContentPacks, SelectMode, WithDefaults)
		  Win.ShowModal(Parent)
		  If Win.mCancelled Then
		    Win.Close
		    Return Blueprints
		  End If
		  
		  For Idx As Integer = 0 To Win.SelectedList.RowCount - 1
		    Blueprints.Add(Win.SelectedList.RowTagAt(Idx))
		  Next
		  
		  WithDefaults = Win.WithDefaultsCheck.Value
		  Win.Close
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Category As String, Subgroup As String, Exclude() As ArkSA.BlueprintReference, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes) As ArkSA.BlueprintReference()
		  Var WithDefaults As Boolean
		  Return Present(Parent, Category, Subgroup, Exclude, ContentPacks, SelectMode, WithDefaults)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Category As String, Subgroup As String, Exclude() As ArkSA.BlueprintReference, ContentPacks As Beacon.StringList, SelectMode As ArkSABlueprintSelectorDialog.SelectModes, ByRef WithDefaults As Boolean) As ArkSA.BlueprintReference()
		  Var Blueprints() As ArkSA.BlueprintReference
		  If Parent Is Nil Then
		    Return Blueprints
		  End If
		  
		  If ContentPacks Is Nil Then
		    ContentPacks = New Beacon.StringList
		  End If
		  
		  Var Win As New ArkSABlueprintSelectorDialog(Category, Subgroup, Exclude, ContentPacks, SelectMode, WithDefaults)
		  Win.ShowModal(Parent)
		  If Win.mCancelled Then
		    Win.Close
		    Return Blueprints
		  End If
		  
		  For Idx As Integer = 0 To Win.SelectedList.RowCount - 1
		    Var Blueprint As ArkSA.Blueprint = Win.SelectedList.RowTagAt(Idx)
		    Blueprints.Add(New ArkSA.BlueprintReference(Blueprint))
		  Next
		  
		  WithDefaults = Win.WithDefaultsCheck.Value
		  Win.Close
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Self.Picker.AutoResize()
		  Var ButtonsHeight As Integer = (Self.RemoveFromSelectionsButton.Top + Self.RemoveFromSelectionsButton.Height) - Self.AddToSelectionsButton.Top
		  Var ButtonsTop As Integer = Self.SelectedList.Top + ((Self.SelectedList.Height - ButtonsHeight) / 2)
		  Self.AddToSelectionsButton.Top = ButtonsTop
		  Self.RemoveFromSelectionsButton.Top = Self.AddToSelectionsButton.Top + Self.AddToSelectionsButton.Height + 12
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UnmakeSelection()
		  Var Selections() As String
		  For I As Integer = Self.SelectedList.RowCount - 1 DownTo 0
		    If Not Self.SelectedList.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Blueprint As ArkSA.Blueprint = Self.SelectedList.RowTagAt(I)
		    Var Idx As Integer = Self.mExcluded.IndexOf(Blueprint.BlueprintId)
		    If Idx > -1 Then
		      Self.mExcluded.RemoveAt(Idx)
		    End If
		    Selections.Add(Blueprint.BlueprintId)
		    Self.SelectedList.RemoveRowAt(I)
		  Next
		  Self.ActionButton.Enabled = Self.SelectedList.RowCount > 0
		  
		  Self.List.SelectionChangeBlocked = True
		  Self.UpdateFilter()
		  For I As Integer = 0 To Self.List.RowCount - 1
		    Var Blueprint As ArkSA.Blueprint = Self.List.RowTagAt(I)
		    Self.List.RowSelectedAt(I) = Selections.IndexOf(Blueprint.BlueprintId) > -1
		  Next
		  Self.List.EnsureSelectionIsVisible
		  Self.List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFilter()
		  Var SearchText As String = Self.FilterField.Text.MakeUTF8
		  Var Tags As String = Self.Picker.Spec
		  
		  Var Blacklist() As String
		  Blacklist.ResizeTo(Self.mExcluded.LastIndex)
		  For Idx As Integer = 0 To Blacklist.LastIndex
		    Blacklist(Idx) = Self.mExcluded(Idx)
		  Next
		  
		  Self.List.RemoveAllRows
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  Var RecentPaths() As String = Preferences.ArkSARecentBlueprints(Self.mCategory, Self.mSubgroup)
		  For Each Path As String In RecentPaths
		    Var BlueprintsAtPath() As ArkSA.Blueprint = DataSource.GetBlueprintsByPath(Path, Self.mMods)
		    Self.AddBlueprintsToList(BlueprintsAtPath, Blacklist, True, True)
		  Next
		  
		  Var Blueprints() As ArkSA.Blueprint = DataSource.GetBlueprints(Self.mCategory, SearchText, Self.mMods, Tags)
		  Self.AddBlueprintsToList(Blueprints, Blacklist, False, False)
		  Self.List.ScrollPosition = ScrollPosition
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCategory As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExcluded() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectMode As ArkSABlueprintSelectorDialog.SelectModes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubgroup As String
	#tag EndProperty


	#tag Enum, Name = SelectModes, Type = Integer, Flags = &h0
		Single
		  ImpliedMultiple
		  ExplicitMultiple
		ExplicitMultipleWithExcluded
	#tag EndEnum


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub SelectionChanged()
		  If Self.mSelectMode <> ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple Then
		    Self.MakeSelection()
		  End If
		  
		  Self.AddToSelectionsButton.Enabled = Me.SelectedRowCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoublePressed()
		  Self.MakeSelection()
		  
		  If Self.mSelectMode <> ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple Then
		    Self.mCancelled = False
		    Self.Hide
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  // Get the new recents list
		  Var SelectedPaths() As String
		  For Idx As Integer = 0 To Self.SelectedList.LastRowIndex
		    Var Blueprint As ArkSA.Blueprint = Self.SelectedList.RowTagAt(Idx)
		    SelectedPaths.Add(Blueprint.Path)
		  Next
		  
		  // Add the previous unique recents to the list
		  Var RecentPaths() As String = Preferences.ArkSARecentBlueprints(Self.mCategory, Self.mSubgroup)
		  For Each Path As String In RecentPaths
		    If SelectedPaths.IndexOf(Path) = -1 Then
		      SelectedPaths.Add(Path)
		    End If
		  Next
		  
		  // And truncate down
		  SelectedPaths.ResizeTo(Min(5, SelectedPaths.LastIndex))
		  
		  Preferences.ArkSARecentBlueprints(Self.mCategory, Self.mSubgroup) = SelectedPaths
		  Self.mCancelled = False
		  Self.Hide()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mCancelled = True
		  Self.Hide()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectedList
	#tag Event
		Sub SelectionChanged()
		  Self.RemoveFromSelectionsButton.Enabled = Me.SelectedRowCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub DoublePressed()
		  Self.UnmakeSelection
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  #Pragma Unused Warn
		  
		  Self.UnmakeSelection
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddToSelectionsButton
	#tag Event
		Sub Pressed()
		  Self.MakeSelection()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveFromSelectionsButton
	#tag Event
		Sub Pressed()
		  Self.UnmakeSelection()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Picker
	#tag Event
		Sub TagsChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Preferences.SelectedTag(Self.mCategory, Self.mSubgroup) = Me.Spec
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldAdjustHeight(Delta As Integer)
		  If Me = Nil Then
		    Return
		  End If
		  
		  Me.Height = Me.Height + Delta
		  
		  Self.List.Height = Self.List.Height - Delta
		  Self.List.Top = Self.List.Top + Delta
		  Self.SelectedList.Top = Self.List.Top
		  Self.SelectedList.Height = Self.List.Height
		  
		  Var ToggleButtonsHeight As Integer = AddToSelectionsButton.Height + RemoveFromSelectionsButton.Height + 12
		  Self.AddToSelectionsButton.Top = Self.SelectedList.Top + ((Self.SelectedList.Height - ToggleButtonsHeight) / 2)
		  Self.RemoveFromSelectionsButton.Top = Self.AddToSelectionsButton.Top + Self.AddToSelectionsButton.Height + 12
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateFilter()
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
			"9 - Modeless Dialog"
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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		InitialValue="600"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
#tag EndViewBehavior
