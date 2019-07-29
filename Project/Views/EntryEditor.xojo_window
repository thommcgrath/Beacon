#tag Window
Begin BeaconDialog EntryEditor
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   DefaultLocation =   "1"
   Frame           =   "8"
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   534
   ImplicitInstance=   False
   LiveResize      =   "False"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   534
   MinimizeButton  =   False
   MinimumHeight   =   534
   MinimumWidth    =   900
   MinWidth        =   900
   Placement       =   "1"
   Resizable       =   True
   Resizeable      =   "True"
   SystemUIVisible =   True
   Title           =   "Set Entry"
   Type            =   "8"
   Visible         =   True
   Width           =   900
   Begin GroupBox EngramsGroup
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Possible Items"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   462
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   380
      Begin DelayedTextField FilterField
         AcceptTabs      =   False
         Alignment       =   "0"
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
         CueText         =   "Search or Enter Spawn Command"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   "Search or Enter Spawn Command"
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Italic          =   False
         Left            =   40
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   312
      End
      Begin BeaconListbox EngramList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   4
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,100,70"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
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
         HasBorder       =   True
         HasHeader       =   True
         HasHeading      =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   1
         Height          =   261
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         InitialValue    =   " 	Name	Mod	Weight"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   "0"
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionRequired=   False
         SelectionType   =   "0"
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   169
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   340
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin CheckBox SingleEntryCheck
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Merge selections into one entry"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         State           =   "0"
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   442
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   340
      End
      Begin ProgressWheel SearchSpinner
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   59
         Transparent     =   False
         Visible         =   True
         Width           =   16
      End
      Begin TagPicker Picker
         AcceptFocus     =   False
         AcceptTabs      =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Border          =   15
         Enabled         =   True
         Height          =   67
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "EngramsGroup"
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         Spec            =   ""
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   90
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   340
      End
   End
   Begin GroupBox SettingsGroup
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Quantities And Qualities"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   245
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   412
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   468
      Begin EntryPropertiesEditor EntryPropertiesEditor1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         DoubleBuffer    =   False
         Enabled         =   True
         HasBackColor    =   False
         HasBackgroundColor=   False
         Height          =   209
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SettingsGroup"
         Left            =   422
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   46
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   448
      End
   End
   Begin GroupBox SimulationGroup
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Simulation"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   205
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   412
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   277
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   468
      Begin BeaconListbox SimulatedResultsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   1
         ColumnsResizable=   False
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
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
         HasBorder       =   True
         HasHeader       =   False
         HasHeading      =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   117
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "SimulationGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   432
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   "0"
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionRequired=   False
         SelectionType   =   "0"
         ShowDropIndicator=   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   313
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   428
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton SimulateButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Refresh"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "SimulationGroup"
         Italic          =   False
         Left            =   780
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   442
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   800
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   494
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   708
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   494
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Beacon.EngramSearcherThread EngramSearcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  Self.EngramSearcher.Cancel
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Dim PreferredSize As Size = Preferences.EntryEditorSize
		  
		  Self.Picker.Tags = LocalData.SharedInstance.AllTags(Beacon.CategoryEngrams)
		  Self.Picker.Spec = Preferences.SelectedTag(Beacon.CategoryEngrams, "Looting")
		  Self.Width = Max(PreferredSize.Width, Self.MinimumWidth)
		  Self.Height = Max(PreferredSize.Height, Self.MinimumHeight)
		  Self.SearchSpinnerVisible = False
		  
		  Self.SwapButtons()
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Preferences.EntryEditorSize = New Size(Self.Width, Self.Height)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AllowMultipleEntries() As Boolean
		  Return Self.mOriginalEntry = Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Mods As Beacon.StringList)
		  Self.mSelectedEngrams = New Dictionary
		  Self.mMods = Mods
		  Self.mSettingUp = True
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EnableButtons()
		  Dim Enabled As Boolean = Self.EngramSearcher.ThreadState = Thread.ThreadStates.NotRunning
		  Self.ActionButton.Enabled = Enabled And Self.mSelectedEngrams.KeyCount >= 1
		  Self.CancelButton.Enabled = Enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListUnknownEngrams()
		  For Each Entry As DictionaryEntry In Self.mSelectedEngrams
		    Dim Path As String = Entry.Key
		    Dim Option As Beacon.SetEntryOption = Entry.Value
		    
		    Dim Idx As Integer = Self.mEngramRowIndexes.Lookup(Path, -1)
		    If Idx = -1 Then
		      Dim WeightValue As Double = Option.Weight * 100
		      Dim Weight As String = WeightValue.PrettyText
		      
		      EngramList.AddRow("", Option.Engram.Label, Option.Engram.ModName, Weight)
		      EngramList.RowTag(EngramList.LastAddedRowIndex) = Option.Engram
		      Self.mEngramRowIndexes.Value(Path) = EngramList.LastAddedRowIndex
		      Idx = EngramList.LastAddedRowIndex
		      EngramList.CellCheck(Idx, Self.ColumnIncluded) = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Mods As Beacon.StringList, Sources() As Beacon.SetEntry = Nil, Prefilter As String = "") As Beacon.SetEntry()
		  If Sources <> Nil And UBound(Sources) > 0 Then
		    // Need to use the multi-edit window
		    Return EntryMultiEditor.Present(Parent, Sources)
		  End If
		  
		  Dim Win As New EntryEditor(Mods)
		  
		  If Sources <> Nil And UBound(Sources) = 0 Then
		    Win.mOriginalEntry = New Beacon.SetEntry(Sources(0))
		  End If
		  
		  Win.EntryPropertiesEditor1.Setup(Win.mOriginalEntry) // This is ok to be nil
		  Win.SetupUI(Prefilter)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  Dim Entries() As Beacon.SetEntry = Win.mCreatedEntries
		  Win.Close
		  If UBound(Entries) = -1 Then
		    Return Nil
		  Else
		    Return Entries
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI(Prefilter As String = "")
		  If Self.mOriginalEntry <> Nil Then
		    For Each Option As Beacon.SetEntryOption In Self.mOriginalEntry
		      Self.mSelectedEngrams.Value(Option.Engram.Path) = Option
		    Next
		  End If
		  
		  Self.FilterField.Value = Prefilter
		  Self.UpdateFilter()
		  SingleEntryCheck.Value = Self.mSelectedEngrams.KeyCount > 1
		  
		  For I As Integer = 0 To EngramList.RowCount - 1
		    If EngramList.CellCheck(I, 0) Then
		      EngramList.ScrollPosition = I
		      Exit For I
		    End If
		  Next
		  
		  Self.UpdateSelectionUI()
		  Self.UpdateSimulation()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFilter()
		  Dim SearchText As String = Self.FilterField.Value
		  Dim Tags As String = Self.Picker.Spec
		  
		  Dim Engrams() As Beacon.Engram = Beacon.Data.SearchForEngrams(SearchText, Self.mMods, Tags)
		  EngramList.DeleteAllRows
		  
		  Dim PerfectMatch As Boolean
		  Self.mEngramRowIndexes = New Dictionary
		  For Each Engram As Beacon.Engram In Engrams
		    Dim Weight As String = ""
		    If Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Dim WeightValue As Double = Beacon.SetEntryOption(Self.mSelectedEngrams.Value(Engram.Path)).Weight * 100
		      Weight = WeightValue.PrettyText
		    End If
		    
		    EngramList.AddRow("", Engram.Label, Engram.ModName, Weight)
		    EngramList.RowTag(EngramList.LastAddedRowIndex) = Engram
		    Self.mEngramRowIndexes.Value(Engram.Path) = EngramList.LastAddedRowIndex
		    EngramList.CellCheck(EngramList.LastAddedRowIndex, Self.ColumnIncluded) = Self.mSelectedEngrams.HasKey(Engram.Path)
		    If Engram.Path = SearchText Or Engram.Label = SearchText Then
		      PerfectMatch = True
		    End If
		  Next
		  
		  If Not PerfectMatch Then
		    Self.EngramSearcher.Search(SearchText, False)
		  Else
		    Self.EngramSearcher.Cancel()
		  End If  
		  Self.ListUnknownEngrams()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSelectionUI()
		  If Self.mSelectedEngrams.KeyCount > 1 And Self.AllowMultipleEntries Then
		    Self.SingleEntryCheck.Visible = True
		    Self.EngramList.Height = Self.SingleEntryCheck.Top - (12 + Self.EngramList.Top)
		  Else
		    Self.SingleEntryCheck.Visible = False
		    Self.EngramList.Height = (Self.SingleEntryCheck.Top + Self.SingleEntryCheck.Height) - Self.EngramList.Top
		  End If
		  Self.EnableButtons
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateSimulation()
		  SimulationGroup.Caption = "Simulation"
		  SimulatedResultsList.DeleteAllRows
		  If Self.mSelectedEngrams.KeyCount = 0 Then
		    Return
		  End If
		  
		  Dim FullSimulation As Boolean = Self.mSelectedEngrams.KeyCount = 1 Or Self.AllowMultipleEntries = False Or (Self.SingleEntryCheck.Value And Self.SingleEntryCheck.Visible)
		  
		  Dim Entry As New Beacon.SetEntry
		  For Each Item As DictionaryEntry In Self.mSelectedEngrams
		    Dim Option As Beacon.SetEntryOption = Item.Value
		    Entry.Append(Option)
		    If Not FullSimulation Then
		      SimulationGroup.Caption = "Simulation of " + Option.Engram.Label
		      Exit
		    End If
		  Next
		  
		  EntryPropertiesEditor1.ApplyTo(Entry)
		  
		  Dim Selections() As Beacon.SimulatedSelection = Entry.Simulate
		  Dim GroupedItems As New Dictionary
		  For Each Selection As Beacon.SimulatedSelection In Selections
		    Dim Description As String = Selection.Description
		    Dim Quantity As Integer
		    If GroupedItems.HasKey(Description) Then
		      Quantity = GroupedItems.Value(Description)
		    End If
		    GroupedItems.Value(Description) = Quantity + 1
		  Next
		  
		  For Each Item As DictionaryEntry In GroupedItems
		    Dim Description As String = Item.Key
		    Dim Quantity As Integer = Item.Value
		    SimulatedResultsList.AddRow(Str(Quantity, "0") + "x " + Description)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCreatedEntries() As Beacon.SetEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		mEngramRowIndexes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalEntry As Beacon.SetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedEngrams As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.SearchSpinner.Visible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.SearchSpinner.Visible = Value Then
			    Return
			  End If
			  
			  Self.SearchSpinner.Visible = Value
			  
			  If Value Then
			    Self.FilterField.Width = (Self.SearchSpinner.Left - 12) - Self.FilterField.Left
			  Else
			    Self.FilterField.Width = (Self.EngramList.Left + Self.EngramList.Width) - Self.FilterField.Left
			  End If
			End Set
		#tag EndSetter
		Private SearchSpinnerVisible As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = ColumnIncluded, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnMod, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWeight, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Dim Engram As Beacon.Engram = Me.RowTag(Row)
		  
		  Select Case Column
		  Case Self.ColumnIncluded
		    Dim Checked As Boolean = Me.CellCheck(Row, Column)
		    If Checked And Not Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Dim WeightString As String = Me.Cell(Row, Self.ColumnWeight)
		      If WeightString = "" Then
		        WeightString = "50"
		        Me.Cell(Row, Self.ColumnWeight) = WeightString
		      End
		      Dim Weight As Double = Max(Min(Val(WeightString) / 100, 1), 0)
		      Self.mSelectedEngrams.Value(Engram.Path) = New Beacon.SetEntryOption(Engram, Weight)
		    ElseIf Not Checked And Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Self.mSelectedEngrams.Remove(Engram.Path)
		    Else
		      Return
		    End If
		    Self.UpdateSelectionUI()
		    Self.UpdateSimulation()
		  Case Self.ColumnWeight
		    If Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Dim Weight As Double = Max(Min(Val(Me.Cell(Row, Column)) / 100, 1), 0)
		      Self.mSelectedEngrams.Value(Engram.Path) = New Beacon.SetEntryOption(Engram, Weight)
		      Self.UpdateSelectionUI()
		      Self.UpdateSimulation()
		    End If
		  Else
		    Return
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function RowCompared(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case Self.ColumnIncluded
		    If Me.CellCheck(Row1, Column) = True And Me.CellCheck(Row2, Column) = False Then
		      Result = -1
		    ElseIf Me.CellCheck(Row1, Column) = False And Me.CellCheck(Row2, Column) = True Then
		      Result = 1
		    Else
		      Dim Engram1 As Beacon.Engram = Me.RowTag(Row1)
		      Dim Engram2 As Beacon.Engram = Me.RowTag(Row2)
		      
		      Result = StrComp(Engram1.Label, Engram2.Label, 0)
		    End If
		  Case Self.ColumnWeight
		    Dim Weight1 As Double = Val(Me.Cell(Row1, Column))
		    Dim Weight2 As Double = Val(Me.Cell(Row2, Column))
		    If Weight1 > Weight2 Then
		      Result = 1
		    ElseIf Weight2 > Weight1 Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		  Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ColumnType(Self.ColumnIncluded) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnWeight) = Listbox.TypeEditable
		  Me.ColumnAlignment(Self.ColumnWeight) = Listbox.AlignRight
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SingleEntryCheck
	#tag Event
		Sub ValueChanged()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Picker
	#tag Event
		Sub TagsChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Preferences.SelectedTag(Beacon.CategoryEngrams, "Looting") = Me.Spec
		  Self.UpdateFilter
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldAdjustHeight(Delta As Integer)
		  If Me = Nil Then
		    Return
		  End If
		  
		  Me.Height = Me.Height + Delta
		  Self.EngramList.Height = Self.EngramList.Height - Delta
		  Self.EngramList.Top = Self.EngramList.Top + Delta
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EntryPropertiesEditor1
	#tag Event
		Sub Changed()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SimulateButton
	#tag Event
		Sub Pressed()
		  Self.UpdateSimulation()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.mSelectedEngrams.KeyCount = 0 Then
		    Return
		  End If
		  
		  Dim Options() As Beacon.SetEntryOption
		  For Each Entry As DictionaryEntry In Self.mSelectedEngrams
		    Options.Append(Entry.Value)
		  Next
		  
		  Dim Entries() As Beacon.SetEntry
		  If Self.mOriginalEntry <> Nil Then
		    Dim Entry As New Beacon.SetEntry(Self.mOriginalEntry)
		    Redim Entry(-1)
		    For Each Option As Beacon.SetEntryOption In Options
		      Entry.Append(Option)
		    Next
		    Entries.Append(Entry)
		  ElseIf UBound(Options) > 0 Then
		    If SingleEntryCheck.Value Then
		      // Merge all into one
		      Dim Entry As New Beacon.SetEntry
		      For Each Option As Beacon.SetEntryOption In Options
		        Entry.Append(Option)
		      Next
		      Entries.Append(Entry)
		    Else
		      // Multiple entries
		      For Each Option As Beacon.SetEntryOption In Options
		        Dim Entry As New Beacon.SetEntry
		        Entry.Append(Option)    
		        Entries.Append(Entry)
		      Next
		    End If
		  ElseIf UBound(Options) = 0 Then
		    Dim Entry As New Beacon.SetEntry
		    Entry.Append(Options(0))
		    Entries.Append(Entry)
		  Else
		    Beep
		    Return
		  End If
		  
		  EntryPropertiesEditor1.ApplyTo(Entries)
		  Self.mCreatedEntries = Entries
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EngramSearcher
	#tag Event
		Sub Finished()
		  Self.SearchSpinnerVisible = False
		  Self.EnableButtons()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.SearchSpinnerVisible = True
		  Self.EnableButtons()
		End Sub
	#tag EndEvent
	#tag Event
		Sub EngramsFound()
		  Dim ParsedBlueprints() As Beacon.Blueprint = Me.Blueprints(True)
		  For Each Blueprint As Beacon.Blueprint In ParsedBlueprints
		    If Not (Blueprint IsA Beacon.Engram) Then
		      Continue
		    End If
		    
		    Dim Engram As Beacon.Engram = Beacon.Engram(Blueprint)
		    Dim Weight As String = ""
		    If Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Dim WeightValue As Double = Beacon.SetEntryOption(Self.mSelectedEngrams.Value(Engram.Path)).Weight * 100
		      Weight = WeightValue.PrettyText
		    End If
		    
		    EngramList.AddRow("", Engram.Label, Engram.ModName, Weight)
		    EngramList.RowTag(EngramList.SelectedIndex) = Engram
		    Self.mEngramRowIndexes.Value(Engram.Path) = EngramList.SelectedIndex
		    EngramList.CellCheck(EngramList.SelectedIndex, Self.ColumnIncluded) = Self.mSelectedEngrams.HasKey(Engram.Path)
		  Next
		  Self.ListUnknownEngrams()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="SystemUIVisible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Type="Color"
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
		EditorType="Boolean"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		Type="MenuBar"
		EditorType="MenuBar"
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
		EditorType="Boolean"
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
