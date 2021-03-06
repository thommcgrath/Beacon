#tag Window
Begin BeaconSubview PresetEditorView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   556
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
   Width           =   740
   Begin PagePanel Pages
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   515
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      Top             =   41
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   740
      BeginSegmentedButton SegmentedButton MapSelector
         Enabled         =   True
         Height          =   24
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         Segments        =   "The Island\n\nFalse\rScorched Earth\n\nFalse\rAberration\n\nFalse\rExtinction\n\nFalse\rGenesis\n\nFalse\rThe Center\n\nFalse\rRagnarok\n\nFalse\rValguero\n\nFalse\rCrystal Isles\n\nFalse"
         SelectionStyle  =   1
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Visible         =   True
         Width           =   660
      End
      Begin Label LockExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Checking the box next to a quantity, quality, or blueprint chance will allow the values to be adjusted by modifiers."
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   516
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   700
      End
      Begin UpDownArrows MaxItemsStepper
         AcceptFocus     =   False
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   163
         Transparent     =   False
         Visible         =   True
         Width           =   13
      End
      Begin UpDownArrows MinItemsStepper
         AcceptFocus     =   False
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   129
         Transparent     =   False
         Visible         =   True
         Width           =   13
      End
      Begin UITweaks.ResizedTextField MaxItemsField
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
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
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
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   163
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin UITweaks.ResizedLabel MaxItemsLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Max Items:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   163
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedTextField MinItemsField
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
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
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
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   129
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   60
      End
      Begin UITweaks.ResizedLabel MinItemsLabels
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Min Items:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   129
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label GroupingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Grouping:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   95
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label NameLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   61
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedTextField GroupingField
         AcceptTabs      =   False
         Alignment       =   0
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
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   95
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   588
      End
      Begin UITweaks.ResizedTextField NameField
         AcceptTabs      =   False
         Alignment       =   0
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
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   61
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   588
      End
      Begin UITweaks.ResizedPushButton AddModifierButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Add Modifier"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   114
      End
      Begin UITweaks.ResizedPushButton EditModifierButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Edit"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   154
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DeleteModifierButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   246
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox ContentsList
         AllowInfiniteScroll=   False
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   5
         ColumnsResizable=   False
         ColumnWidths    =   "30,*,100,120,100"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         EditCaption     =   "Edit"
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   "#ColumnDescription"
         Height          =   399
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   " 	Engram	Quantity	Quality	Blueprint %"
         Italic          =   False
         Left            =   20
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
         SelectionChangeBlocked=   False
         SelectionType   =   1
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   105
         Transparent     =   True
         TypeaheadColumn =   1
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   700
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconListbox ModifiersList
         AllowInfiniteScroll=   False
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   5
         ColumnsResizable=   False
         ColumnWidths    =   "40%,15%,15%,15%,15%"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         EditCaption     =   "Edit"
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   435
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Group	Min Quality Change	Max Quality Change	Quantity Multiplier	Blueprint % Multiplier"
         Italic          =   False
         Left            =   20
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
         SelectionChangeBlocked=   False
         SelectionType   =   1
         ShowDropIndicator=   False
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   101
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   700
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin OmniBar PresetToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   740
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  If Self.Changed Then
		    FileSave.Enable
		    If Self.mSaveFile <> Nil Then
		      FileSaveAs.Enable
		    End If
		  End If
		  If Self.mSaveFile = Nil Then
		    FileExport.Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.MapSelector.RemoveAllSegments
		  Var AllMaps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In AllMaps
		    Var MapSegment As New Segment
		    MapSegment.Title = Map.Name
		    MapSegment.Enabled = True
		    Self.MapSelector.AddSegment(MapSegment)
		  Next
		  
		  Self.MapSelector.Width = Self.MapSelector.SegmentCount * 110 // Because the design-time size is not being respected
		  Self.MapSelector.ResizeCells
		  Self.MinimumWidth = Self.MapSelector.Width + 40
		  Self.UpdateUI()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma unused Initial
		  
		  Self.MapSelector.Left = Self.ContentsList.Left + ((Self.ContentsList.Width - Self.MapSelector.Width) / 2)
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  Self.Save()
		  Return True
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			If Self.IsFrontmost = False Then
			Return False
			End If
			
			Var Dialog As New SaveFileDialog
			Dialog.Filter = BeaconFileTypes.BeaconPreset
			Dialog.SuggestedFileName = Self.mPreset.Label + Beacon.FileExtensionPreset
			
			Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
			If File <> Nil Then
			Var Writer As New Beacon.JSONWriter(Self.mPreset.ToDictionary, File)
			Writer.Start
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			If Self.IsFrontmost = False Then
			Return False
			End If
			
			Self.Save()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			If Self.IsFrontmost = False Then
			Return False
			End If
			
			Var Dialog As New SaveFileDialog
			Dialog.Filter = BeaconFileTypes.BeaconPreset
			Dialog.SuggestedFileName = Self.mPreset.Label + Beacon.FileExtensionPreset
			
			Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
			If File <> Nil Then
			Self.mSaveFile = File
			Self.Save()
			End If
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddEntriesToList(Entries() As Beacon.PresetEntry)
		  Var Maps() As Beacon.Map = Self.FilteredMaps()
		  For Each Entry As Beacon.PresetEntry In Entries
		    Self.ContentsList.AddRow("")
		    Self.PutEntryInRow(Entry, Self.ContentsList.LastAddedRowIndex, Maps)
		  Next
		  Self.ContentsList.Sort
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Preset As Beacon.Preset, SourceFile As FolderItem = Nil)
		  Self.mPreset = New Beacon.MutablePreset(Preset)
		  Self.ViewID = Preset.PresetID
		  Self.mSaveFile = SourceFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelectedEntries(Warn As Boolean)
		  If Self.ContentsList.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  If Warn And Not Self.ShowConfirm(if(Self.ContentsList.SelectedRowCount = 1, "Are you sure you want to delete this entry?", "Are you sure you want to delete these " + Self.ContentsList.SelectedRowCount.ToString(Locale.Raw, "0") + " entries?"), "This action cannot be undone.", "Delete", "Cancel") Then
		    Return
		  End If
		  
		  For I As Integer = Self.ContentsList.RowCount - 1 DownTo 0
		    If Not Self.ContentsList.Selected(I) Then
		      Continue
		    End If
		    Var Entry As Beacon.PresetEntry = Self.ContentsList.RowTagAt(I)
		    Var Idx As Integer = Self.mPreset.IndexOf(Entry)
		    If Idx > -1 Then
		      Self.mPreset.Remove(Idx)  
		      Self.Changed = True
		    End If
		    Self.ContentsList.RemoveRowAt(I)
		  Next
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelectedEntries()
		  Var Entries() As Beacon.PresetEntry
		  For I As Integer = 0 To ContentsList.RowCount - 1
		    If Not ContentsList.Selected(I) Then
		      Continue
		    End If
		    
		    Var Entry As Beacon.PresetEntry = ContentsList.RowTagAt(I)
		    Call Entry.UniqueID // Triggers generation if necessary so we can compare when done
		    Entries.Add(Entry)
		  Next
		  
		  If Entries.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var NewEntries() As Beacon.SetEntry = EntryEditor.Present(Self.TrueWindow, New Beacon.StringList, Entries)
		  If NewEntries = Nil Then
		    Return
		  End If
		  
		  Var Maps() As Beacon.Map = Self.FilteredMaps()
		  For Each NewEntry As Beacon.SetEntry In NewEntries
		    Var OriginalEntry As Beacon.PresetEntry
		    Var OriginalIndex As Integer = -1
		    For I As Integer = 0 To Self.mPreset.LastRowIndex
		      If Self.mPreset(I).UniqueID = NewEntry.UniqueID Then
		        OriginalEntry = Self.mPreset(I)
		        OriginalIndex = I
		        Exit For I
		      End If
		    Next
		    If OriginalIndex = -1 Then
		      System.DebugLog("Unable to find original entry " + NewEntry.UniqueID)
		      Break
		      Return
		    End If
		    
		    Var Item As New Beacon.PresetEntry(NewEntry)
		    Item.Availability = OriginalEntry.Availability
		    Item.RespectQualityModifier = OriginalEntry.RespectQualityModifier
		    Item.RespectQuantityMultiplier = OriginalEntry.RespectQuantityMultiplier
		    Self.mPreset(OriginalIndex) = Item
		    
		    For I As Integer = 0 To ContentsList.RowCount - 1
		      If Beacon.PresetEntry(ContentsList.RowTagAt(I)).UniqueID = OriginalEntry.UniqueID Then
		        Self.PutEntryInRow(Item, I, Maps)
		        Exit For I
		      End If
		    Next
		  Next
		  
		  ContentsList.Sort
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilteredMaps() As Beacon.Map()
		  Var Maps() As Beacon.Map
		  Var AllMaps() As Beacon.Map = Beacon.Maps.All
		  For Idx As Integer = 0 To Self.MapSelector.SegmentCount - 1
		    Var Cell As Segment = Self.MapSelector.SegmentAt(Idx)
		    If Not Cell.Selected Then
		      Continue
		    End If
		    
		    Maps.Add(AllMaps(Idx))
		  Next
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinHeight() As UInteger
		  Return 455
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinWidth() As UInteger
		  Return 740
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PutEntryInRow(Entry As Beacon.PresetEntry, Index As Integer, Maps() As Beacon.Map, SelectIt As Boolean = False)
		  If Index = -1 Then
		    Self.ContentsList.AddRow("")
		    Index = Self.ContentsList.LastAddedRowIndex
		  End If
		  
		  Var MapsValid, MapsInvalid As Integer
		  For Each Map As Beacon.Map In Maps
		    If Entry.ValidForMap(Map) Then
		      MapsValid = MapsValid + 1
		    Else
		      MapsInvalid = MapsInvalid + 1
		    End If
		  Next
		  
		  If MapsValid = 0 Then
		    Self.ContentsList.CellCheckBoxStateAt(Index, Self.ColumnIncluded) = Checkbox.VisualStates.Unchecked
		  ElseIf MapsInvalid = 0 Then
		    Self.ContentsList.CellCheckBoxStateAt(Index, Self.ColumnIncluded) = Checkbox.VisualStates.Checked
		  Else
		    Self.ContentsList.CellCheckBoxStateAt(Index, Self.ColumnIncluded) = Checkbox.VisualStates.Indeterminate
		  End If
		  
		  Self.ContentsList.RowTagAt(Index) = Entry
		  Self.ContentsList.CellValueAt(Index, Self.ColumnDescription) = Entry.Label
		  Self.ContentsList.CellValueAt(Index, Self.ColumnQuantity) = if(Entry.MinQuantity = Entry.MaxQuantity, Entry.MinQuantity.ToString(Locale.Current, "0"), Entry.MinQuantity.ToString(Locale.Current, "0") + "-" + Entry.MaxQuantity.ToString(Locale.Current, "0"))
		  Self.ContentsList.CellValueAt(Index, Self.ColumnQuality) = if(Entry.MinQuality = Entry.MaxQuality, Language.LabelForQuality(Entry.MinQuality), Language.LabelForQuality(Entry.MinQuality, True) + "-" + Language.LabelForQuality(Entry.MaxQuality, True))
		  Self.ContentsList.CellValueAt(Index, Self.ColumnBlueprint) = if(Entry.CanBeBlueprint, Entry.ChanceToBeBlueprint.ToString(Locale.Current, "0%"), "N/A")
		  Self.ContentsList.CellCheckBoxValueAt(Index, Self.ColumnQuantity) = Entry.RespectQuantityMultiplier
		  Self.ContentsList.CellCheckBoxValueAt(Index, Self.ColumnQuality) = Entry.RespectQualityModifier
		  Self.ContentsList.CellCheckBoxValueAt(Index, Self.ColumnBlueprint) = Entry.RespectBlueprintMultiplier
		  
		  If SelectIt Then
		    Self.ContentsList.Selected(Index) = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Save()
		  If Self.mSaveFile = Nil Then
		    Beacon.Data.SavePreset(Self.mPreset)
		    Self.ViewID = Self.mPreset.PresetID
		  Else
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		    Var Writer As New Beacon.JSONWriter(Self.mPreset.ToDictionary, Self.mSaveFile)
		    AddHandler Writer.Finished, AddressOf Writer_Finished
		    Writer.Start
		  End If
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.Caption = Self.mPreset.Label
		  End If
		  Self.Changed = False
		  NotificationKit.Post("Preset Saved", Self.mPreset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedEntries() As Beacon.PresetEntry()
		  Var Entries() As Beacon.PresetEntry
		  For I As Integer = Self.ContentsList.RowCount - 1 DownTo 0
		    If Self.ContentsList.Selected(I) Then
		      Entries.Add(Self.ContentsList.RowTagAt(I))
		    End If
		  Next
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddDialog()
		  Var Entries() As Beacon.SetEntry = EntryEditor.Present(Self.TrueWindow, New Beacon.StringList)
		  If Entries = Nil Or Entries.LastIndex = -1 Then
		    Return
		  End If
		  Self.ContentsList.SelectedRowIndex = -1
		  Var Maps() As Beacon.Map = Self.FilteredMaps
		  For Each Entry As Beacon.SetEntry In Entries
		    Var Item As New Beacon.PresetEntry(Entry)
		    Self.PutEntryInRow(Item, -1, Maps, True)
		    Self.mPreset.Append(Item)
		    Self.Changed = True
		  Next
		  Self.ContentsList.Sort
		  Self.Pages.SelectedPanelIndex = Self.PageContents
		  Self.ContentsList.EnsureSelectionIsVisible
		  Self.UpdateMinAndMaxFields
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowModifierEditor(Edit As Boolean)
		  Var EditID As String
		  If Edit And Self.ModifiersList.SelectedRowCount = 1 Then
		    EditID = Self.ModifiersList.RowTagAt(Self.ModifiersList.SelectedRowIndex)
		  End If
		  If PresetModifierEditor.Present(Self, Self.mPreset, EditID) Then
		    Self.UpdateUI
		    Self.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMinAndMaxFields()
		  Var Focus As RectControl = Self.Window.Focus
		  
		  If Focus <> Self.MinItemsField Then
		    Self.MinItemsField.Text = Self.mPreset.MinItems.ToString(Locale.Current, "0")
		  End If
		  If Focus <> Self.MaxItemsField Then
		    Self.MaxItemsField.Text = Self.mPreset.MaxItems.ToString(Locale.Current, "0")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  If Self.mSaveFile <> Nil Then
		    Self.Title = Self.mSaveFile.DisplayName
		  Else
		    Self.Title = Self.mPreset.Label
		  End If
		  Self.ViewTitle = Self.Title
		  Self.mUpdating = True
		  Self.Changed = False
		  
		  Var Mask As UInt64 = Preferences.LastPresetMapFilter
		  Var AllMaps() As Beacon.Map = Beacon.Maps.All
		  For Idx As Integer = 0 To AllMaps.LastIndex
		    Self.MapSelector.SegmentAt(Idx).Selected = (Mask And AllMaps(Idx).Mask) = AllMaps(Idx).Mask
		  Next
		  
		  Var Maps() As Beacon.Map = Self.FilteredMaps()
		  Var SelectedEntries() As String
		  For I As Integer = 0 To Self.ContentsList.RowCount - 1
		    If Self.ContentsList.Selected(I) Then
		      Var Entry As Beacon.PresetEntry = Self.ContentsList.RowTagAt(I)
		      SelectedEntries.Add(Entry.UniqueID)
		    End If
		  Next
		  Self.ContentsList.RemoveAllRows()
		  For Each Entry As Beacon.PresetEntry In Self.mPreset
		    Self.PutEntryInRow(Entry, -1, Maps, SelectedEntries.IndexOf(Entry.UniqueID) > -1)
		  Next
		  Self.ContentsList.Sort
		  
		  Self.NameField.Text = Self.mPreset.Label
		  Self.GroupingField.Text = Self.mPreset.Grouping
		  Self.UpdateMinAndMaxFields
		  
		  Var AppliedModifiers() As String = Self.mPreset.ActiveModifierIDs
		  Var Modifiers() As Beacon.PresetModifier = LocalData.SharedInstance.AllPresetModifiers
		  Self.ModifiersList.RemoveAllRows()
		  For Each Modifier As Beacon.PresetModifier In Modifiers
		    If AppliedModifiers.IndexOf(Modifier.ModifierID) = -1 Then
		      Continue
		    End If
		    
		    Var QuantityMultiplier As Double = Self.mPreset.QuantityMultiplier(Modifier)
		    Var MinQualityModifier As Integer = Self.mPreset.MinQualityModifier(Modifier)
		    Var MaxQualityModifier As Integer = Self.mPreset.MaxQualityModifier(Modifier)
		    Var BlueprintMultiplier As Double = Self.mPreset.BlueprintMultiplier(Modifier)
		    
		    Var QuantityLabel As String = "x " + QuantityMultiplier.PrettyText(True)
		    Var BlueprintLabel As String = "x " + BlueprintMultiplier.PrettyText(True)
		    Var MinQualityLabel, MaxQualityLabel As String
		    If MinQualityModifier = 0 Then
		      MinQualityLabel = "No Change"
		    Else
		      MinQualityLabel = MinQualityModifier.ToString(Locale.Current, "+0;-0") + " Tier" + If(Abs(MinQualityModifier) <> 1, "s", "")
		    End If
		    If MaxQualityModifier = 0 Then
		      MaxQualityLabel = "No Change"
		    Else
		      MaxQualityLabel = MaxQualityModifier.ToString(Locale.Current, "+0;-0") + " Tier" + If(Abs(MaxQualityModifier) <> 1, "s", "")
		    End If
		    
		    Self.ModifiersList.AddRow(Modifier.Label, MinQualityLabel, MaxQualityLabel, QuantityLabel, BlueprintLabel)
		    Self.ModifiersList.RowTagAt(Self.ModifiersList.LastAddedRowIndex) = Modifier.ModifierID
		  Next
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewType(Plural As Boolean, Lowercase As Boolean) As String
		  If Plural Then
		    Return If(Lowercase, "presets", "Presets")
		  Else
		    Return If(Lowercase, "preset", "Preset")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Writer_Finished(Sender As Beacon.JSONWriter, Destination As FolderItem)
		  #Pragma Unused Sender
		  
		  Self.Progress = BeaconSubview.ProgressNone
		  Self.ViewID = EncodeHex(Crypto.MD5(Destination.NativePath))
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPreset As Beacon.MutablePreset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnBlueprint, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnDescription, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIncluded, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ModifierClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.presetmodifier", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageContents, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageModifiers, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSettings, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Pages
	#tag Event
		Sub Change()
		  Var GeneralTab As OmniBarItem = Self.PresetToolbar.Item("GeneralTab")
		  If (GeneralTab Is Nil) = False Then
		    GeneralTab.Toggled = Me.SelectedPanelIndex = Self.PageSettings
		  End If
		  
		  Var ContentsTab As OmniBarItem = Self.PresetToolbar.Item("ContentsTab")
		  If (ContentsTab Is Nil) = False Then
		    ContentsTab.Toggled = Me.SelectedPanelIndex = Self.PageContents
		  End If
		  
		  Var ModifiersTab As OmniBarItem = Self.PresetToolbar.Item("ModifiersTab")
		  If (ModifiersTab Is Nil) = False Then
		    ModifiersTab.Toggled = Me.SelectedPanelIndex = Self.PageModifiers
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapSelector
	#tag Event
		Sub Pressed(segmentIndex as integer)
		  #Pragma Unused segmentIndex
		  
		  If Self.mUpdating = True Then
		    Return
		  End If
		  
		  Self.mUpdating = True
		  
		  Var Maps() As Beacon.Map = Self.FilteredMaps
		  Preferences.LastPresetMapFilter = Maps.Mask
		  
		  For I As Integer = ContentsList.RowCount - 1 DownTo 0
		    Var Entry As Beacon.PresetEntry = ContentsList.RowTagAt(I)
		    Self.PutEntryInRow(Entry, I, Maps, ContentsList.Selected(I))
		  Next
		  
		  Self.mUpdating = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsStepper
	#tag Event
		Sub Down()
		  Var NewValue As Integer = CDbl(Self.MaxItemsField.Text) - 1
		  Self.MaxItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Var NewValue As Integer = CDbl(Self.MaxItemsField.Text) + 1
		  Self.MaxItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsStepper
	#tag Event
		Sub Down()
		  Var NewValue As Integer = CDbl(Self.MinItemsField.Text) - 1
		  Self.MinItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Var NewValue As Integer = CDbl(Self.MinItemsField.Text) + 1
		  Self.MinItemsField.Text = NewValue.ToString(Locale.Current, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As Integer = Max(CDbl(Me.Text), 1)
		  If Self.mPreset.MaxItems <> Value Then
		    Self.mPreset.MaxItems = Value
		    Self.Changed = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Text = Self.mPreset.MaxItems.ToString(Locale.Raw, "0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Me.Text = Self.mPreset.MaxItems.ToString(Locale.Raw, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As Integer = Max(CDbl(Me.Text), 1)
		  If Self.mPreset.MinItems <> Value Then
		    Self.mPreset.MinItems = Value
		    Self.Changed = True
		  End If
		  
		  If Self.Window.Focus <> Me Then
		    Me.Text = Self.mPreset.MinItems.ToString(Locale.Raw, "0")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Me.Text = Self.mPreset.MinItems.ToString(Locale.Raw, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GroupingField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As String = Me.Text.Trim
		  If Value <> "" And Self.mPreset.Grouping.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mPreset.Grouping = Value
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var Value As String = Me.Text.Trim
		  If Value <> "" And Self.mPreset.Label.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mPreset.Label = Value
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddModifierButton
	#tag Event
		Sub Action()
		  Self.ShowModifierEditor(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditModifierButton
	#tag Event
		Sub Action()
		  Self.ShowModifierEditor(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeleteModifierButton
	#tag Event
		Sub Action()
		  Self.ModifiersList.DoClear()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentsList
	#tag Event
		Sub Open()
		  Me.ColumnTypeAt(Self.ColumnIncluded) = Listbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnQuantity) = Listbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnQuality) = Listbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnBlueprint) = Listbox.CellTypes.CheckBox
		  Me.TypeaheadColumn = Self.ColumnDescription
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Select Case Column
		  Case Self.ColumnIncluded
		    Var State As Checkbox.VisualStates = Me.CellCheckBoxStateAt(Row, Column)
		    If State = Checkbox.VisualStates.Indeterminate Then
		      Return
		    End If
		    
		    Var Entry As Beacon.PresetEntry = Me.RowTagAt(Row)
		    Var Maps() As Beacon.Map = Self.FilteredMaps
		    For Each Map As Beacon.Map In Maps
		      If Entry.ValidForMap(Map) <> (State = Checkbox.VisualStates.Checked) Then
		        Entry.ValidForMap(Map) = (State = Checkbox.VisualStates.Checked)
		        Self.Changed = True
		      End If
		    Next
		    Return
		  Case Self.ColumnQuantity
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Entry As Beacon.PresetEntry = Me.RowTagAt(Row)
		    If Entry.RespectQuantityMultiplier <> Checked Then
		      Entry.RespectQuantityMultiplier = Checked
		      Self.Changed = True
		    End If
		  Case Self.ColumnQuality
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Entry As Beacon.PresetEntry = Me.RowTagAt(Row)
		    If Entry.RespectQualityModifier <> Checked Then
		      Entry.RespectQualityModifier = Checked
		      Self.Changed = True
		    End If
		  Case Self.ColumnBlueprint
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Entry As Beacon.PresetEntry = Me.RowTagAt(Row)
		    If Entry.RespectBlueprintMultiplier <> Checked Then
		      Entry.RespectBlueprintMultiplier = Checked
		      Self.Changed = True
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var Item As MenuItem
		  
		  Item = New MenuItem
		  Item.Text = "Create Blueprint Entry"
		  Item.Enabled = Me.SelectedRowCount > 0
		  Item.Tag = "createblueprintentry"
		  Base.AddMenu(Item)
		  
		  Item = New MenuItem
		  Item.Text = "Match Official Availability"
		  Item.Enabled = Me.SelectedRowCount > 0
		  Item.Tag = "matchavailability"
		  Base.AddMenu(Item)
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  Select Case hitItem.Tag
		  Case "createblueprintentry"
		    Var Maps() As Beacon.Map = Beacon.Maps.All
		    Var NewEntries As New Dictionary
		    For Each Map As Beacon.Map In Maps
		      Var Entries() As Beacon.PresetEntry
		      For I As Integer = 0 To Me.RowCount - 1
		        If Not Me.Selected(I) Then
		          Continue
		        End If
		        
		        Var Entry As Beacon.PresetEntry = Me.RowTagAt(I)
		        If Entry.ValidForMap(Map) Then
		          Entries.Add(Entry)
		        End If
		      Next
		      
		      Var BlueprintEntry As Beacon.SetEntry = Beacon.SetEntry.CreateBlueprintEntry(Entries)
		      If BlueprintEntry <> Nil Then
		        Var Hash As String = BlueprintEntry.Hash
		        If NewEntries.HasKey(Hash) Then
		          Var Entry As Beacon.PresetEntry = NewEntries.Value(Hash)
		          Entry.ValidForMap(Map) = True
		          NewEntries.Value(Hash) = Entry
		        Else
		          Var Entry As New Beacon.PresetEntry(BlueprintEntry)
		          Entry.Availability = 0
		          Entry.ValidForMap(Map) = True
		          NewEntries.Value(Hash) = Entry
		        End If
		      End If
		    Next
		    
		    If NewEntries.KeyCount = 0 Then
		      System.Beep
		      Return True
		    End If
		    
		    For I As Integer = 0 To Me.RowCount - 1
		      If Me.Selected(I) Then
		        Beacon.PresetEntry(Me.RowTagAt(I)).ChanceToBeBlueprint = 0.0
		      End If
		    Next
		    Me.SelectedRowIndex = -1
		    
		    Var SelectedMaps() As Beacon.Map = Self.FilteredMaps()
		    For Each Entry As DictionaryEntry In NewEntries
		      Var Item As Beacon.PresetEntry = Entry.Value
		      Item.RespectQualityModifier = False
		      Item.RespectQuantityMultiplier = False
		      Self.PutEntryInRow(Item, -1, SelectedMaps, True)
		      Self.mPreset.Append(Item)
		    Next
		    
		    Me.Sort
		    Me.EnsureSelectionIsVisible()
		    Self.Changed = True
		  Case "matchavailability"
		    Var Changed As Boolean
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.Selected(Idx) = False Then
		        Continue
		      End If
		      
		      Var Entry As Beacon.PresetEntry = Me.RowTagAt(Idx)
		      Var Availability As UInt64
		      For Each Option As Beacon.SetEntryOption In Entry
		        Availability = Availability Or Option.Engram.Availability
		      Next
		      If Entry.Availability <> Availability Then
		        Entry.Availability = Availability
		        Changed = True
		        Self.PutEntryInRow(Entry, Idx, Self.FilteredMaps)
		      End If
		    Next
		    
		    If Changed Then
		      Me.Sort
		      Me.EnsureSelectionIsVisible()
		      Self.Changed = True
		    End If
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Self.DeleteSelectedEntries(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  Var EditEntriesButton As OmniBarItem = Self.PresetToolbar.Item("EditEntriesButton")
		  If (EditEntriesButton Is Nil) = False Then
		    EditEntriesButton.Enabled = Me.CanEdit()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModifiersList
	#tag Event
		Sub Change()
		  EditModifierButton.Enabled = Me.SelectedRowCount = 1
		  DeleteModifierButton.Enabled = Me.SelectedRowCount > 0
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
		  Return Board.RawDataAvailable(Self.ModifierClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn And Not Self.ShowConfirm(if(Self.ModifiersList.SelectedRowCount = 1, "Are you sure you want to delete this modifier?", "Are you sure you want to delete these " + Self.ModifiersList.SelectedRowCount.ToString(Locale.Raw, "0") + " modifiers?"), "This action cannot be undone.", "Delete", "Cancel") Then
		    Return
		  End If
		  
		  For I As Integer = Self.ModifiersList.RowCount - 1 DownTo 0
		    If Not Self.ModifiersList.Selected(I) Then
		      Continue
		    End If
		    
		    Var ModifierID As String = Self.ModifiersList.RowTagAt(I)
		    Self.mPreset.ClearModifier(ModifierID)
		    Self.ModifiersList.RemoveRowAt(I)
		    Self.Changed = True
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Modifiers As New Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var ModifierID As String = Me.RowTagAt(I)
		    Var Dict As New Dictionary
		    Dict.Value("Quantity") = Self.mPreset.QuantityMultiplier(ModifierID)
		    Dict.Value("MinQuality") = Self.mPreset.MinQualityModifier(ModifierID)
		    Dict.Value("MaxQuality") = Self.mPreset.MaxQualityModifier(ModifierID)
		    Dict.Value("Blueprint") = Self.mPreset.BlueprintMultiplier(ModifierID)
		    Modifiers.Value(ModifierID) = Dict
		  Next
		  
		  Board.RawData(Self.ModifierClipboardType) = Beacon.GenerateJSON(Modifiers, False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Board.RawDataAvailable(Self.ModifierClipboardType) Then
		    Return
		  End If
		  
		  Try
		    Var Data As String = Board.RawData(Self.ModifierClipboardType).DefineEncoding(Encodings.UTF8)
		    Var Modifiers As Dictionary = Beacon.ParseJSON(Data)
		    
		    For Each Entry As DictionaryEntry In Modifiers
		      Var ModifierID As String = Entry.Key
		      Var Dict As Dictionary = Entry.Value
		      
		      If Dict.HasKey("Quantity") Then
		        Self.mPreset.QuantityMultiplier(ModifierID) = Dict.Value("Quantity")
		      End If
		      If Dict.HasKey("MinQuality") And Dict.HasKey("MaxQuality") Then
		        Self.mPreset.MinQualityModifier(ModifierID) = Dict.Value("MinQuality")
		        Self.mPreset.MaxQualityModifier(ModifierID) = Dict.Value("MaxQuality")
		      ElseIf Dict.HasKey("Quality") Then
		        Self.mPreset.MinQualityModifier(ModifierID) = Dict.Value("Quality")
		        Self.mPreset.MaxQualityModifier(ModifierID) = Dict.Value("Quality")
		      End If
		      If Dict.HasKey("Blueprint") Then
		        Self.mPreset.BlueprintMultiplier(ModifierID) = Dict.Value("Blueprint")
		      End If
		    Next
		    
		    Self.UpdateUI()
		    Self.Changed = True
		  Catch Err As RuntimeException
		    Return
		  End Try
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Self.ShowModifierEditor(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PresetToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTab("GeneralTab", "General"))
		  Me.Append(OmniBarItem.CreateTab("ContentsTab", "Contents"))
		  Me.Append(OmniBarItem.CreateTab("ModifiersTab", "Modifiers"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddEntriesButton", "New Entry", IconToolbarAdd, "Add engrams to this preset."))
		  Me.Append(OmniBarItem.CreateButton("EditEntriesButton", "Edit", IconToolbarEdit, "Edit the selected entries.", False))
		  
		  Me.Item("GeneralTab").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddEntriesButton"
		    Self.ShowAddDialog()
		  Case "EditEntriesButton"
		    Self.EditSelectedEntries()
		  Case "GeneralTab"
		    Self.Pages.SelectedPanelIndex = Self.PageSettings
		  Case "ContentsTab"
		    Self.Pages.SelectedPanelIndex = Self.PageContents
		  Case "ModifiersTab"
		    Self.Pages.SelectedPanelIndex = Self.PageModifiers
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="LockRight"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
#tag EndViewBehavior
