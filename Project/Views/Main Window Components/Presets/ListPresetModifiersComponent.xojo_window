#tag Window
Begin PresetsComponentView ListPresetModifiersComponent
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   300
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   300
   Begin OmniBar ModifiersToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   300
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
      ColumnCount     =   1
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   259
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      SelectionChangeBlocked=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   300
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.ViewTitle = "Selectors"
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CloneSelected()
		  Var Siblings() As String
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Siblings.Add(Beacon.PresetModifier(Self.List.RowTagAt(Idx)).Label)
		  Next
		  
		  Var Clones() As Beacon.PresetModifier
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.Selected(Idx) = False Then
		      Continue
		    End If
		    
		    Var Modifier As Beacon.PresetModifier = Self.List.RowTagAt(Idx)
		    Var Clone As New Beacon.MutablePresetModifier(Modifier, True)
		    Clone.Label = Beacon.FindUniqueLabel(Clone.Label, Siblings)
		    Siblings.Add(Clone.Label)
		    Clones.Add(Clone)
		  Next
		  
		  LocalData.SharedInstance.AddPresetModifier(Clones)
		  Self.UpdateList(Clones)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditModifier(Modifier As Beacon.PresetModifier)
		  Var CreatedModifier As Beacon.PresetModifier = PresetModifierEditorDialog.Present(Self, Modifier)
		  If CreatedModifier Is Nil Then
		    Return
		  End If
		  
		  LocalData.SharedInstance.AddPresetModifier(CreatedModifier)
		  Self.UpdateList(CreatedModifier)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Modifiers() As Beacon.PresetModifier
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.Selected(Idx) = False Then
		      Continue
		    End If
		    Modifiers.Add(Self.List.RowTagAt(Idx))
		  Next
		  Self.UpdateList(Modifiers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectModifiers() As Beacon.PresetModifier)
		  Var SelectIDs() As String
		  For Each Modifier As Beacon.PresetModifier In SelectModifiers
		    SelectIDs.Add(Modifier.ModifierID)
		  Next
		  
		  Var Modifiers() As Beacon.PresetModifier = Beacon.Data.GetPresetModifiers(False, True)
		  
		  Self.List.RowCount = Modifiers.Count
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Self.List.CellValueAt(Idx, 0) = Modifiers(Idx).Label
		    Self.List.RowTagAt(Idx) = Modifiers(Idx)
		    Self.List.Selected(Idx) = SelectIDs.IndexOf(Modifiers(Idx).ModifierID) > -1
		  Next
		  
		  Self.List.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectModifier As Beacon.PresetModifier)
		  Var Modifiers() As Beacon.PresetModifier
		  If (SelectModifier Is Nil) = False Then
		    Modifiers.Add(SelectModifier)
		  End If
		  Self.UpdateList(Modifiers)
		  Self.List.EnsureSelectionIsVisible
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.beacon.presetmodifier", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ModifiersToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateButton("NewModifier", "New Selector", IconToolbarAdd, "Create a new loot source selector."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditModifier", "Edit Selector", IconToolbarEdit, "Edit the selected loot source selector.", Self.List.SelectedRowCount = 1))
		  Me.Append(OmniBarItem.CreateButton("CloneModifier", "Duplicate", IconToolbarClone, "Create a copy of the selected loot source selector.", Self.List.SelectedRowCount > 0))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "NewModifier"
		    Self.EditModifier(New Beacon.MutablePresetModifier)
		  Case "EditModifier"
		    Self.List.DoEdit()
		  Case "CloneModifier"
		    Self.CloneSelected()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
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
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("""ModifierID""") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Modifiers() As Beacon.PresetModifier
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.Selected(Idx) Then
		      Modifiers.Add(Me.RowTagAt(Idx))
		    End If
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Modifiers, "preset selector", "preset selectors") = False Then
		    Return
		  End If
		  
		  If Not LocalData.SharedInstance.DeletePresetModifier(Modifiers) Then
		    If Modifiers.Count = 1 Then
		      Self.ShowAlert("This preset selector is still in use by at least one preset and cannot be deleted.", "Once you have removed this selector from all presets, try to delete it again.")
		    Else
		      Self.ShowAlert("These preset selectors cannot be deleted until there are no presets that use them.", "If you have trouble figuring out which preset selector is still in use, try deleting fewer at a time.")
		    End If
		    Return
		  End If
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dictionaries() As Dictionary
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.Selected(Idx) Then
		      Dictionaries.Add(Beacon.PresetModifier(Me.RowTagAt(Idx)).ToDictionary(False))
		    End If
		  Next
		  
		  Var JSON As String = Beacon.GenerateJSON(Dictionaries, True)
		  Board.Text = JSON
		  Board.RawData(Self.kClipboardType) = JSON
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditModifier(Me.RowTagAt(Me.SelectedRowIndex))
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var JSON As String
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    JSON = Board.RawData(Self.kClipboardType)
		  ElseIf Board.TextAvailable And Board.Text.IndexOf("""ModifierID""") > -1 Then
		    JSON = Board.Text.Trim
		  Else
		    Return
		  End If
		  
		  Var Members() As Variant
		  Try
		    Members = Beacon.ParseJSON(JSON)
		  Catch Err As RuntimeException
		    System.Beep
		    Self.ShowAlert("Could not paste preset selectors", Err.Message)
		    Return
		  End Try
		  
		  Var Added() As Beacon.PresetModifier
		  For Each Member As Variant In Members
		    If (Member IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Try
		      Var Modifier As Beacon.PresetModifier = Beacon.PresetModifier.FromDictionary(Dictionary(Member))
		      If Modifier <> Nil Then
		        Added.Add(Modifier)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  LocalData.SharedInstance.AddPresetModifier(Added)
		  Self.UpdateList(Added)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  If (Self.ModifiersToolbar.Item("CloneModifier") Is Nil) = False Then
		    Self.ModifiersToolbar.Item("CloneModifier").Enabled = Me.CanCopy()
		  End If
		  If (Self.ModifiersToolbar.Item("EditModifier") Is Nil) = False Then
		    Self.ModifiersToolbar.Item("EditModifier").Enabled = Me.CanEdit()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="AllowAutoDeactivate"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
