#tag Window
Begin Window EntryEditor
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   534
   ImplicitInstance=   False
   LiveResize      =   False
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
   Resizeable      =   True
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
      Begin UITweaks.ResizedTextField FilterField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Search or Enter Spawn Command"
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
         Width           =   312
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
         Height          =   340
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
         RowCount        =   0
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   340
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
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
      Begin ProgressWheel SearchSpinner
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
         RowCount        =   0
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
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
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   428
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton SimulateButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
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
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
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
      ButtonStyle     =   "0"
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
   Begin Beacon.EngramSearcherThread EngramSearcher
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   "0"
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim PreferredSize As Xojo.Core.Size = Preferences.EntryEditorSize
		  
		  Self.Width = Max(PreferredSize.Width, Self.MinWidth)
		  Self.Height = Max(PreferredSize.Height, Self.MinHeight)
		  Self.SearchSpinnerVisible = False
		  
		  Self.SwapButtons()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Preferences.EntryEditorSize = New Xojo.Core.Size(Self.Width, Self.Height)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AllowMultipleEntries() As Boolean
		  Return Self.mOriginalEntry = Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSelectedEngrams = New Xojo.Core.Dictionary
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EnableButtons()
		  Dim Enabled As Boolean = Self.EngramSearcher.State = Beacon.Thread.States.NotRunning
		  Self.ActionButton.Enabled = Enabled And Self.mSelectedEngrams.Count >= 1
		  Self.CancelButton.Enabled = Enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListUnknownEngrams()
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mSelectedEngrams
		    Dim Path As Text = Entry.Key
		    Dim Option As Beacon.SetEntryOption = Entry.Value
		    
		    Dim Idx As Integer = Self.mEngramRowIndexes.Lookup(Path, -1)
		    If Idx = -1 Then
		      Dim WeightValue As Double = Option.Weight * 100
		      Dim Weight As String = WeightValue.PrettyText
		      
		      EngramList.AddRow("", Option.Engram.Label, Option.Engram.ModName, Weight)
		      EngramList.RowTag(EngramList.LastIndex) = Option.Engram
		      Self.mEngramRowIndexes.Value(Path) = EngramList.LastIndex
		      Idx = EngramList.LastIndex
		      EngramList.CellCheck(Idx, Self.ColumnIncluded) = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, ConsoleSafe As Boolean, Sources() As Beacon.SetEntry = Nil, Prefilter As String = "") As Beacon.SetEntry()
		  If Sources <> Nil And UBound(Sources) > 0 Then
		    // Need to use the multi-edit window
		    Return EntryMultiEditor.Present(Parent, Sources)
		  End If
		  
		  Dim Win As New EntryEditor
		  Win.mConsoleSafe = ConsoleSafe
		  
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

	#tag Method, Flags = &h0
		Sub Search(SearchText As String)
		  If FilterField.Text <> SearchText Then
		    FilterField.Text = SearchText
		  End If
		  
		  Dim Engrams() As Beacon.Engram = Beacon.Data.SearchForEngrams(SearchText.ToText, Self.mConsoleSafe)
		  EngramList.DeleteAllRows
		  
		  Dim PerfectMatch As Boolean
		  Self.mEngramRowIndexes = New Xojo.Core.Dictionary
		  For Each Engram As Beacon.Engram In Engrams
		    Dim Weight As String = ""
		    If Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Dim WeightValue As Double = Beacon.SetEntryOption(Self.mSelectedEngrams.Value(Engram.Path)).Weight * 100
		      Weight = WeightValue.PrettyText
		    End If
		    
		    EngramList.AddRow("", Engram.Label, Engram.ModName, Weight)
		    EngramList.RowTag(EngramList.LastIndex) = Engram
		    Self.mEngramRowIndexes.Value(Engram.Path) = EngramList.LastIndex
		    EngramList.CellCheck(EngramList.LastIndex, Self.ColumnIncluded) = Self.mSelectedEngrams.HasKey(Engram.Path)
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
		Private Sub SetupUI(Prefilter As String = "")
		  If Self.mOriginalEntry <> Nil Then
		    For Each Option As Beacon.SetEntryOption In Self.mOriginalEntry
		      Self.mSelectedEngrams.Value(Option.Engram.Path) = Option
		    Next
		  End If
		  
		  Self.Search(Prefilter)
		  SingleEntryCheck.Value = Self.mSelectedEngrams.Count > 1
		  
		  For I As Integer = 0 To EngramList.ListCount - 1
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
		Private Sub UpdateSelectionUI()
		  If Self.mSelectedEngrams.Count > 1 And Self.AllowMultipleEntries Then
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
		  If Self.mSelectedEngrams.Count = 0 Then
		    Return
		  End If
		  
		  Dim FullSimulation As Boolean = Self.mSelectedEngrams.Count = 1 Or Self.AllowMultipleEntries = False Or (Self.SingleEntryCheck.Value And Self.SingleEntryCheck.Visible)
		  
		  Dim Entry As New Beacon.SetEntry
		  For Each Item As Xojo.Core.DictionaryEntry In Self.mSelectedEngrams
		    Dim Option As Beacon.SetEntryOption = Item.Value
		    Entry.Append(Option)
		    If Not FullSimulation Then
		      SimulationGroup.Caption = "Simulation of " + Option.Engram.Label
		      Exit
		    End If
		  Next
		  
		  EntryPropertiesEditor1.ApplyTo(Entry)
		  
		  Dim Selections() As Beacon.SimulatedSelection = Entry.Simulate
		  Dim GroupedItems As New Xojo.Core.Dictionary
		  For Each Selection As Beacon.SimulatedSelection In Selections
		    Dim Description As Text = Selection.Description
		    Dim Quantity As Integer
		    If GroupedItems.HasKey(Description) Then
		      Quantity = GroupedItems.Value(Description)
		    End If
		    GroupedItems.Value(Description) = Quantity + 1
		  Next
		  
		  For Each Item As Xojo.Core.DictionaryEntry In GroupedItems
		    Dim Description As Text = Item.Key
		    Dim Quantity As Integer = Item.Value
		    SimulatedResultsList.AddRow(Str(Quantity, "0") + "x " + Description)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatedEntries() As Beacon.SetEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		mEngramRowIndexes As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalEntry As Beacon.SetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedEngrams As Xojo.Core.Dictionary
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
			    Self.FilterField.Width = Self.EngramList.Width
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
		Sub TextChange()
		  Self.Search(Me.Text)
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
		Sub Open()
		  Me.ColumnType(Self.ColumnIncluded) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnWeight) = Listbox.TypeEditable
		  Me.ColumnAlignment(Self.ColumnWeight) = Listbox.AlignRight
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
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
#tag EndEvents
#tag Events SingleEntryCheck
	#tag Event
		Sub Action()
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
		  If Self.mSelectedEngrams.Count = 0 Then
		    Return
		  End If
		  
		  Dim Options() As Beacon.SetEntryOption
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mSelectedEngrams
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
		Sub Action()
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
		  Dim ParsedEngrams() As Beacon.Engram = Me.Engrams(True)
		  For Each Engram As Beacon.Engram In ParsedEngrams
		    #if DebugBuild
		      System.DebugLog("Found engram " + Engram.Path)
		    #endif
		    Dim Weight As String = ""
		    If Self.mSelectedEngrams.HasKey(Engram.Path) Then
		      Dim WeightValue As Double = Beacon.SetEntryOption(Self.mSelectedEngrams.Value(Engram.Path)).Weight * 100
		      Weight = WeightValue.PrettyText
		    End If
		    
		    EngramList.AddRow("", Engram.Label, Engram.ModName, Weight)
		    EngramList.RowTag(EngramList.LastIndex) = Engram
		    Self.mEngramRowIndexes.Value(Engram.Path) = EngramList.LastIndex
		    EngramList.CellCheck(EngramList.LastIndex, Self.ColumnIncluded) = Self.mSelectedEngrams.HasKey(Engram.Path)
		  Next
		  Self.ListUnknownEngrams()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
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
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
	#tag EndViewProperty
#tag EndViewBehavior
