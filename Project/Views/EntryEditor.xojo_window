#tag Window
Begin BeaconDialog EntryEditor
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   534
   ImplicitInstance=   False
   LiveResize      =   "False"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   534
   MinimizeButton  =   False
   MinWidth        =   900
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Set Entry"
   Visible         =   True
   Width           =   900
   Begin GroupBox EngramsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Possible Items"
      Enabled         =   True
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
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Search"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
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
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   340
      End
      Begin CheckBox SingleEntryCheck
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Merge selections into one entry"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
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
         State           =   0
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
         Width           =   340
      End
      Begin TagPicker Picker
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Border          =   15
         DoubleBuffer    =   False
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
      Begin BeaconListbox EngramList
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
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
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
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   169
         Transparent     =   False
         TypeaheadColumn =   1
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   340
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin GroupBox SettingsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Quantities And Qualities"
      Enabled         =   True
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
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   209
         HelpTag         =   ""
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
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Simulation"
      Enabled         =   True
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
      Begin UITweaks.ResizedPushButton SimulateButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Refresh"
         Default         =   False
         Enabled         =   True
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
      Begin BeaconListbox SimulatedResultsList
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
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
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
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   313
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   428
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
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
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
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
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Var PreferredSize As Size = Preferences.EntryEditorSize
		  
		  Self.Picker.Tags = LocalData.SharedInstance.AllTags(Beacon.CategoryEngrams)
		  Self.Picker.Spec = Preferences.SelectedTag(Beacon.CategoryEngrams, "Looting")
		  Self.Width = Max(PreferredSize.Width, Self.MinimumWidth)
		  Self.Height = Max(PreferredSize.Height, Self.MinimumHeight)
		  
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
		  Self.ActionButton.Enabled = Self.mSelectedEngrams.KeyCount >= 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListUnknownEngrams()
		  For Each Entry As DictionaryEntry In Self.mSelectedEngrams
		    Var Path As String = Entry.Key
		    Var Option As Beacon.SetEntryOption = Entry.Value
		    
		    Var Idx As Integer = Self.mEngramRowIndexes.Lookup(Path, -1)
		    If Idx = -1 Then
		      Var WeightValue As Double = Option.Weight * 100
		      Var Weight As String = WeightValue.PrettyText
		      
		      EngramList.AddRow("", Option.Engram.Label, Option.Engram.ModName, Weight)
		      EngramList.RowTagAt(EngramList.LastAddedRowIndex) = Option.Engram
		      Self.mEngramRowIndexes.Value(Path) = EngramList.LastAddedRowIndex
		      Idx = EngramList.LastAddedRowIndex
		      EngramList.CellCheckBoxValueAt(Idx, Self.ColumnIncluded) = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Mods As Beacon.StringList, Sources() As Beacon.SetEntry = Nil, Prefilter As String = "") As Beacon.SetEntry()
		  If Sources <> Nil And Sources.LastRowIndex > 0 Then
		    // Need to use the multi-edit window
		    Return EntryMultiEditor.Present(Parent, Sources)
		  End If
		  
		  Var Win As New EntryEditor(Mods)
		  
		  If Sources <> Nil And Sources.LastRowIndex = 0 Then
		    Win.mOriginalEntry = New Beacon.SetEntry(Sources(0))
		  End If
		  
		  Win.EntryPropertiesEditor1.Setup(Win.mOriginalEntry) // This is ok to be nil
		  Win.SetupUI(Prefilter)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  Var Entries() As Beacon.SetEntry = Win.mCreatedEntries
		  Win.Close
		  If Entries.LastRowIndex = -1 Then
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
		    If EngramList.CellCheckBoxValueAt(I, 0) Then
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
		  Var SearchText As String = Self.FilterField.Value
		  Var Tags As String = Self.Picker.Spec
		  
		  Var Engrams() As Beacon.Engram = Beacon.Data.SearchForEngrams(SearchText, Self.mMods, Tags)
		  EngramList.RemoveAllRows
		  
		  Self.mEngramRowIndexes = New Dictionary
		  For Each Engram As Beacon.Engram In Engrams
		    Var Weight As String = ""
		    If Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Var WeightValue As Double = Beacon.SetEntryOption(Self.mSelectedEngrams.Value(Engram.Path)).Weight * 100
		      Weight = WeightValue.PrettyText
		    End If
		    
		    EngramList.AddRow("", Engram.Label, Engram.ModName, Weight)
		    EngramList.RowTagAt(EngramList.LastAddedRowIndex) = Engram
		    Self.mEngramRowIndexes.Value(Engram.Path) = EngramList.LastAddedRowIndex
		    EngramList.CellCheckBoxValueAt(EngramList.LastAddedRowIndex, Self.ColumnIncluded) = Self.mSelectedEngrams.HasKey(Engram.Path)
		  Next
		  
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
		  SimulatedResultsList.RemoveAllRows
		  If Self.mSelectedEngrams.KeyCount = 0 Then
		    Return
		  End If
		  
		  Var FullSimulation As Boolean = Self.mSelectedEngrams.KeyCount = 1 Or Self.AllowMultipleEntries = False Or (Self.SingleEntryCheck.Value And Self.SingleEntryCheck.Visible)
		  
		  Var Entry As New Beacon.SetEntry
		  For Each Item As DictionaryEntry In Self.mSelectedEngrams
		    Var Option As Beacon.SetEntryOption = Item.Value
		    Entry.Append(Option)
		    If Not FullSimulation Then
		      SimulationGroup.Caption = "Simulation of " + Option.Engram.Label
		      Exit
		    End If
		  Next
		  
		  EntryPropertiesEditor1.ApplyTo(Entry)
		  
		  Var Selections() As Beacon.SimulatedSelection = Entry.Simulate
		  Var GroupedItems As New Dictionary
		  For Each Selection As Beacon.SimulatedSelection In Selections
		    Var Description As String = Selection.Description
		    Var Quantity As Integer
		    If GroupedItems.HasKey(Description) Then
		      Quantity = GroupedItems.Value(Description)
		    End If
		    GroupedItems.Value(Description) = Quantity + 1
		  Next
		  
		  For Each Item As DictionaryEntry In GroupedItems
		    Var Description As String = Item.Key
		    Var Quantity As Integer = Item.Value
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
		Sub TextChange()
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SingleEntryCheck
	#tag Event
		Sub Action()
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
#tag Events EngramList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Var Engram As Beacon.Engram = Me.RowTagAt(Row)
		  
		  Select Case Column
		  Case Self.ColumnIncluded
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    If Checked Then
		      If Self.mSelectedEngrams.HasKey(Engram.Path) = False Then
		        Var WeightString As String = Me.CellValueAt(Row, Self.ColumnWeight)
		        If WeightString = "" Then
		          WeightString = "50"
		          Me.CellValueAt(Row, Self.ColumnWeight) = WeightString
		        End If
		        
		        Var Weight As Double = Abs(CDbl(WeightString)) / 100
		        Var Option As New Beacon.SetEntryOption(Engram, Weight)
		        Self.mSelectedEngrams.Value(Engram.Path) = Option
		      Else
		        Return
		      End If
		    Else
		      If Self.mSelectedEngrams.HasKey(Engram.Path) = True Then
		        Self.mSelectedEngrams.Remove(Engram.Path)
		      Else
		        Return
		      End If
		    End If
		  Case Self.ColumnWeight
		    If Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Var Weight As Double = Abs(CDbl(Me.CellValueAt(Row, Column))) / 100
		      Self.mSelectedEngrams.Value(Engram.Path) = New Beacon.SetEntryOption(Engram, Weight)
		    End If
		  Else
		    Return
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnTypeAt(Self.ColumnIncluded) = Listbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnWeight) = Listbox.CellTypes.TextField
		  Me.ColumnAlignmentAt(Self.ColumnWeight) = Listbox.Alignments.Center
		  Me.TypeaheadColumn = Self.ColumnLabel
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case Self.ColumnIncluded
		    If Me.CellCheckBoxValueAt(Row1, Column) = True And Me.CellCheckBoxValueAt(Row2, Column) = False Then
		      Result = -1
		    ElseIf Me.CellCheckBoxValueAt(Row1, Column) = False And Me.CellCheckBoxValueAt(Row2, Column) = True Then
		      Result = 1
		    Else
		      Var Engram1 As Beacon.Engram = Me.RowTagAt(Row1)
		      Var Engram2 As Beacon.Engram = Me.RowTagAt(Row2)
		      
		      Result = StrComp(Engram1.Label, Engram2.Label, 0)
		    End If
		  Case Self.ColumnWeight
		    Var Weight1 As Double = Val(Me.CellValueAt(Row1, Column))
		    Var Weight2 As Double = Val(Me.CellValueAt(Row2, Column))
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
		Sub BulkColumnChangeFinished(Column As Integer)
		  #Pragma Unused Column
		  
		  Self.UpdateSelectionUI()
		  Self.UpdateSimulation()
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
		Sub Action()
		  Self.UpdateSimulation()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If Self.mSelectedEngrams.KeyCount = 0 Then
		    Return
		  End If
		  
		  Var Options() As Beacon.SetEntryOption
		  For Each Entry As DictionaryEntry In Self.mSelectedEngrams
		    Options.AddRow(Entry.Value)
		  Next
		  
		  Var Entries() As Beacon.SetEntry
		  If Self.mOriginalEntry <> Nil Then
		    Var Entry As New Beacon.SetEntry(Self.mOriginalEntry)
		    Entry.ResizeTo(-1)
		    For Each Option As Beacon.SetEntryOption In Options
		      Entry.Append(Option)
		    Next
		    Entries.AddRow(Entry)
		  ElseIf Options.LastRowIndex > 0 Then
		    If SingleEntryCheck.Value Then
		      // Merge all into one
		      Var Entry As New Beacon.SetEntry
		      For Each Option As Beacon.SetEntryOption In Options
		        Entry.Append(Option)
		      Next
		      Entries.AddRow(Entry)
		    Else
		      // Multiple entries
		      For Each Option As Beacon.SetEntryOption In Options
		        Var Entry As New Beacon.SetEntry
		        Entry.Append(Option)    
		        Entries.AddRow(Entry)
		      Next
		    End If
		  ElseIf Options.LastRowIndex = 0 Then
		    Var Entry As New Beacon.SetEntry
		    Entry.Append(Options(0))
		    Entries.AddRow(Entry)
		  Else
		    System.Beep
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
		Sub Action()
		  Self.Hide
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
		Type="Color"
		EditorType="Color"
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
		Type="MenuBar"
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
