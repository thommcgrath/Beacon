#tag Window
Begin BeaconDialog EngramSelectorDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   1
   Resizeable      =   True
   Title           =   "Select Engram"
   Visible         =   True
   Width           =   600
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      Text            =   "Select an Engram"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedTextField FilterField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   "Search Engrams"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   212
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   368
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "*,200"
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
      Height          =   262
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Engram	Mod"
      Italic          =   False
      Left            =   20
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
      SelectionChangeBlocked=   False
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   86
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Select"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
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
      Top             =   360
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
      Left            =   408
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
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox SelectedList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
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
      Height          =   262
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Selected Engrams"
      Italic          =   False
      Left            =   714
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowCount        =   0
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   86
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   200
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton AddToSelectionsButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   ">>"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   662
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   191
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin UITweaks.ResizedPushButton RemoveFromSelectionsButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "<<"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   662
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   223
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin UITweaks.ResizedPopupMenu TagMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   53
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   180
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim SelectedTag As String = Preferences.SelectedTag
		  Self.TagMenu.AddRow("All Engrams", "")
		  Dim Tags() As String = LocalData.SharedInstance.AllTags
		  For Each Tag As String In Tags
		    Self.TagMenu.AddRow(Tag.TitleCase, Tag)
		    If Tag = SelectedTag Then
		      Self.TagMenu.ListIndex = Self.TagMenu.ListCount - 1
		    End If
		  Next
		  If SelectedTag = "" Then
		    Self.TagMenu.ListIndex = 0
		  End If
		  
		  Self.UpdateFilter()
		  Self.SwapButtons()
		  Self.ActionButton.Enabled = False
		  Self.Resize()
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
		Private Sub Constructor(ExcludeEngrams() As Beacon.Engram, Mods As Beacon.TextList, AllowMultipleSelection As Boolean)
		  For Each Engram As Beacon.Engram In ExcludeEngrams
		    Self.mExcludedEngrams.Append(Engram.Path)
		  Next
		  Self.mMods = Mods
		  Self.mAllowMultipleSelection = AllowMultipleSelection
		  Super.Constructor
		  If AllowMultipleSelection Then
		    Self.Width = Self.Width + 150
		    Self.List.ColumnWidths = "*,150"
		    Self.List.SelectionType = Listbox.SelectionMultiple
		    Self.List.Width = Self.List.Width - (24 + Self.SelectedList.Width + Self.AddToSelectionsButton.Width)
		    Self.AddToSelectionsButton.Left = Self.List.Left + Self.List.Width + 12
		    Self.RemoveFromSelectionsButton.Left = Self.AddToSelectionsButton.Left
		    Self.SelectedList.Left = Self.AddToSelectionsButton.Left + Self.AddToSelectionsButton.Width + 12
		    Self.MessageLabel.Text = "Select Engrams"
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MakeSelection()
		  If Not Self.mAllowMultipleSelection Then
		    Self.SelectedList.DeleteAllRows()
		  End If
		  
		  If Self.List.SelCount > 1 Then
		    For I As Integer = Self.List.ListCount - 1 DownTo 0
		      If Not Self.List.Selected(I) Then
		        Continue
		      End If
		      
		      Self.SelectedList.AddRow(Self.List.Cell(I, 0))
		      Self.SelectedList.RowTag(Self.SelectedList.LastIndex) = Self.List.RowTag(I)
		      If Self.mAllowMultipleSelection Then
		        Self.mExcludedEngrams.Append(Beacon.Engram(Self.List.RowTag(I)).Path)
		        Self.List.RemoveRow(I)
		      End If
		    Next
		  ElseIf Self.List.SelCount = 1 Then
		    Self.SelectedList.AddRow(Self.List.Cell(Self.List.ListIndex, 0))
		    Self.SelectedList.RowTag(Self.SelectedList.LastIndex) = Self.List.RowTag(Self.List.ListIndex)
		    If Self.mAllowMultipleSelection Then
		      Self.mExcludedEngrams.Append(Beacon.Engram(Self.List.RowTag(Self.List.ListIndex)).Path)
		      Self.List.RemoveRow(Self.List.ListIndex)
		    End If
		  End If
		  
		  Self.ActionButton.Enabled = Self.SelectedList.ListCount > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, ExcludeEngrams() As Beacon.Engram, Mods As Beacon.TextList, AllowMultipleSelection As Boolean) As Beacon.Engram()
		  Dim Engrams() As Beacon.Engram
		  If Parent = Nil Then
		    Return Engrams
		  End If
		  
		  Dim Win As New EngramSelectorDialog(ExcludeEngrams, Mods, AllowMultipleSelection)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  If Win.mCancelled Then
		    Win.Close
		    Return Engrams
		  End If
		  
		  For I As Integer = 0 To Win.SelectedList.ListCount - 1
		    Engrams.Append(Win.SelectedList.RowTag(I))
		  Next
		  
		  Win.Close
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Dim ButtonsHeight As Integer = (Self.RemoveFromSelectionsButton.Top + Self.RemoveFromSelectionsButton.Height) - Self.AddToSelectionsButton.Top
		  Dim ButtonsTop As Integer = Self.SelectedList.Top + ((Self.SelectedList.Height - ButtonsHeight) / 2)
		  Self.AddToSelectionsButton.Top = ButtonsTop
		  Self.RemoveFromSelectionsButton.Top = Self.AddToSelectionsButton.Top + Self.AddToSelectionsButton.Height + 12
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UnmakeSelection()
		  Dim SelectPaths() As Text
		  For I As Integer = Self.SelectedList.ListCount - 1 DownTo 0
		    If Not Self.SelectedList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Engram As Beacon.Engram = Self.SelectedList.RowTag(I)
		    Dim Idx As Integer = Self.mExcludedEngrams.IndexOf(Engram.Path)
		    If Idx > -1 Then
		      Self.mExcludedEngrams.Remove(Idx)
		    End If
		    SelectPaths.Append(Engram.Path)
		    Self.SelectedList.RemoveRow(I)
		  Next
		  Self.ActionButton.Enabled = Self.SelectedList.ListCount > 0
		  
		  Self.List.SelectionChangeBlocked = True
		  Self.UpdateFilter()
		  For I As Integer = 0 To Self.List.ListCount - 1
		    Dim Engram As Beacon.Engram = Self.List.RowTag(I)
		    Self.List.Selected(I) = SelectPaths.IndexOf(Engram.Path) > -1
		  Next
		  Self.List.EnsureSelectionIsVisible
		  Self.List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFilter()
		  Dim SearchText As String = Self.FilterField.Text
		  Dim Tags As Text
		  #Pragma Warning "Does not respect tags"
		  
		  Dim Engrams() As Beacon.Engram = Beacon.Data.SearchForEngrams(SearchText.ToText, Self.mMods, Tags)
		  Dim ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.DeleteAllRows
		  For Each Engram As Beacon.Engram In Engrams
		    If Self.mExcludedEngrams.IndexOf(Engram.Path) > -1 Then
		      Continue
		    End If
		    
		    Self.List.AddRow(Engram.Label, Engram.ModName)
		    Self.List.RowTag(Self.List.LastIndex) = Engram
		  Next
		  Self.List.ScrollPosition = ScrollPosition
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAllowMultipleSelection As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExcludedEngrams() As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.TextList
	#tag EndProperty


#tag EndWindowCode

#tag Events FilterField
	#tag Event
		Sub TextChange()
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  If Not Self.mAllowMultipleSelection Then
		    Self.MakeSelection()
		  End If
		  
		  Self.AddToSelectionsButton.Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Self.MakeSelection()
		  
		  If Not Self.mAllowMultipleSelection Then
		    Self.mCancelled = False
		    Self.Hide
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Self.mCancelled = False
		  Self.Hide()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.mCancelled = True
		  Self.Hide()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectedList
	#tag Event
		Sub Change()
		  Self.RemoveFromSelectionsButton.Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
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
		Sub Action()
		  Self.MakeSelection()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveFromSelectionsButton
	#tag Event
		Sub Action()
		  Self.UnmakeSelection()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TagMenu
	#tag Event
		Sub Change()
		  If Me.ListIndex = -1 Then
		    Return
		  End If
		  
		  Preferences.SelectedTag = Me.RowTag(Me.ListIndex).StringValue.ToText
		  Self.UpdateFilter()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
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
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
