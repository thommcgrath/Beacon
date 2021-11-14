#tag Window
Begin PresetsComponentView ListPresetsComponent Implements NotificationKit.Receiver
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
   Height          =   438
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
   Width           =   576
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
      ColumnCount     =   2
      ColumnWidths    =   "*,200"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   397
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Preset Name	Type"
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   576
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin OmniBar PresetsToolbar
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   576
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #Pragma Unused action
		  
		  Var AddedPresets() As Beacon.Preset
		  
		  Do
		    If Not Obj.FolderItemAvailable Then
		      Continue
		    End If
		    
		    Var File As FolderItem = Obj.FolderItem
		    If Not File.ExtensionMatches(Beacon.FileExtensionPreset) Then
		      Continue
		    End If
		    
		    Var Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
		    If Preset <> Nil Then
		      Beacon.Data.SavePreset(Preset)
		      AddedPresets.Add(Preset)
		    End If
		  Loop Until Obj.NextItem = False
		  
		  If AddedPresets.LastIndex > -1 Then
		    Self.UpdatePresets(AddedPresets)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, "Preset Saved")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.AcceptFileDrop(BeaconFileTypes.BeaconPreset)
		  Self.ViewTitle = "Presets"
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  NotificationKit.Watch(Self, "Preset Saved")
		  
		  If UserData <> Nil Then
		    Self.UpdatePresets(Beacon.Preset(UserData))
		  Else
		    Self.UpdatePresets()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function ClonePreset(Source As Beacon.Preset) As Beacon.Preset
		  Var Clone As New Beacon.MutablePreset
		  Clone.Label = Source.Label + " Copy"
		  Clone.Grouping = Source.Grouping
		  Clone.MaxItems = Source.MaxItems
		  Clone.MinItems = Source.MinItems
		  Var Modifiers() As String = Clone.ActiveModifierIDs
		  For Each ModifierID As String In Modifiers
		    Clone.MinQualityModifier(ModifierID) = Source.MinQualityModifier(ModifierID)
		    Clone.MaxQualityModifier(ModifierID) = Source.MaxQualityModifier(ModifierID)
		    Clone.QuantityMultiplier(ModifierID) = Source.QuantityMultiplier(ModifierID)
		  Next
		  For Each Entry As Beacon.PresetEntry In Source
		    Clone.Append(New Beacon.PresetEntry(Entry))
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CloneSelected()
		  If List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var Clones() As Beacon.Preset
		  For I As Integer = 0 To List.RowCount - 1
		    If List.Selected(I) Then
		      Clones.Add(Self.ClonePreset(List.RowTagAt(I)))
		    End If
		  Next
		  
		  If Clones.LastIndex = -1 Then
		    Return
		  End If
		  
		  For Each Clone As Beacon.Preset In Clones
		    Beacon.Data.SavePreset(Clone)
		  Next
		  
		  Self.UpdatePresets(Clones)
		  
		  If Clones.LastIndex = 0 Then
		    Self.OpenPreset(Clones(0))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelected()
		  If List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  For I As Integer = 0 To List.RowCount - 1
		    If List.Selected(I) Then
		      Var Preset As Beacon.Preset = List.RowTagAt(I)
		      If Self.ClosePreset(Preset) Then
		        Beacon.Data.DeletePreset(Preset)
		      End If
		    End If
		  Next    
		  Self.UpdatePresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportSelected()
		  If List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  If List.SelectedRowCount = 1 Then
		    Var Preset As Beacon.Preset = List.RowTagAt(List.SelectedRowIndex)
		    Var Dialog As New SaveFileDialog
		    Dialog.Filter = BeaconFileTypes.BeaconPreset
		    Dialog.SuggestedFileName = Preset.Label + Beacon.FileExtensionPreset
		    
		    Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		    If (File Is Nil) = False Then
		      Preset.ToFile(File, Beacon.Preset.SaveFormats.Universal)
		    End If
		    
		    Return
		  End If
		  
		  Var Dialog As New SelectFolderDialog
		  Dialog.PromptText = "Select Folder For Bulk Export"
		  
		  Var Folder As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If Folder Is Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To List.RowCount - 1
		    If Not List.Selected(I) Then
		      Continue
		    End If
		    
		    Var Preset As Beacon.Preset = List.RowTagAt(I)
		    Preset.ToFile(Folder.Child(Preset.Label + Beacon.FileExtensionPreset), Beacon.Preset.SaveFormats.Universal)
		  Next
		  
		  Folder.Open
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  If Notification.Name = "Preset Saved" Then
		    Var Preset As Beacon.Preset = Notification.UserData
		    Self.UpdatePresets(Preset)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePresets(ParamArray SelectPresets() As Beacon.Preset)
		  Self.UpdatePresets(SelectPresets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePresets(SelectPresets() As Beacon.Preset)
		  Var Presets() As Beacon.Preset = Beacon.Data.Presets
		  Var PresetCount As Integer = Presets.LastIndex + 1
		  
		  If SelectPresets.LastIndex = -1 Then
		    For I As Integer = 0 To List.RowCount - 1
		      If List.Selected(I) Then
		        SelectPresets.Add(List.RowTagAt(I))
		      End If
		    Next
		  End If
		  
		  Var SelectIDs() As String
		  For Each Preset As Beacon.Preset In SelectPresets
		    SelectIDs.Add(Preset.PresetID)
		  Next
		  
		  While List.RowCount > PresetCount
		    List.RemoveRowAt(0)
		  Wend
		  While List.RowCount < PresetCount
		    List.AddRow("")
		  Wend
		  
		  For I As Integer = 0 To List.RowCount - 1
		    List.CellValueAt(I, 0) = Presets(I).Label
		    Select Case Presets(I).Type
		    Case Beacon.Preset.Types.BuiltIn
		      List.CellValueAt(I, 1) = "Built-In"
		    Case Beacon.Preset.Types.Custom
		      List.CellValueAt(I, 1) = "Custom"
		    Case Beacon.Preset.Types.CustomizedBuiltIn
		      List.CellValueAt(I, 1) = "Customized Built-In"
		    End Select
		    List.RowTagAt(I) = Presets(I)
		  Next
		  
		  List.Sort
		  
		  For I As Integer = 0 To List.RowCount - 1
		    List.Selected(I) = (SelectIDs.IndexOf(Beacon.Preset(List.RowTagAt(I)).PresetID) > -1)
		  Next
		  List.EnsureSelectionIsVisible()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Change()
		  If (Self.PresetsToolbar.Item("ClonePreset") Is Nil) = False Then
		    Self.PresetsToolbar.Item("ClonePreset").Enabled = Me.SelectedRowCount > 0
		  End If
		  If (Self.PresetsToolbar.Item("EditPreset") Is Nil) = False Then
		    Self.PresetsToolbar.Item("EditPreset").Enabled = Me.SelectedRowCount = 1
		  End If
		  If (Self.PresetsToolbar.Item("ExportPreset") Is Nil) = False Then
		    Self.PresetsToolbar.Item("ExportPreset").Enabled = Me.SelectedRowCount > 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(1) = Listbox.Alignments.Right
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Preset As Beacon.Preset = Me.RowTagAt(I)
		    If Preset.Type = Beacon.Preset.Types.BuiltIn Then
		      Continue
		    End If
		    
		    Return True
		  Next
		  
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var DeleteCount, RevertCount, DisallowCount As Integer
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Preset As Beacon.Preset = Me.RowTagAt(I)
		    Select Case Preset.Type
		    Case Beacon.Preset.Types.BuiltIn
		      DisallowCount = DisallowCount + 1
		    Case Beacon.Preset.Types.Custom
		      DeleteCount = DeleteCount + 1
		    Case Beacon.Preset.Types.CustomizedBuiltIn
		      RevertCount = RevertCount + 1
		    End Select
		  Next
		  
		  Var Message, Action As String
		  If DeleteCount > 0 And RevertCount > 0 Then
		    Var TotalCount As Integer = DeleteCount + RevertCount
		    Message = "Are you sure you want to delete or revert these " + TotalCount.ToString(Locale.Current, "0") + " presets?"
		    Action = "Delete"
		  ElseIf DeleteCount = 1 Then
		    Message = "Are you sure you want to delete this preset?"
		    Action = "Delete"
		  ElseIf DeleteCount > 1 Then
		    Message = "Are you sure you want to delete these " + DeleteCount.ToString(Locale.Current, "0") + " presets?"
		    Action = "Delete"
		  ElseIf RevertCount = 1 Then
		    Message = "Are you sure you want to revert this preset?"
		    Action = "Revert"
		  ElseIf RevertCount > 1 Then
		    Message = "Are you sure you want to revert these " + RevertCount.ToString(Locale.Current, "0") + " presets?"
		    Action = "Revert"
		  Else
		    Return
		  End If
		  
		  Var Explanation As String = "This action cannot be undone."
		  If DisallowCount > 0 Then
		    Explanation = "Built-in presets will not be deleted. " + Explanation
		  End If
		  
		  If Warn And Not Self.ShowConfirm(Message, Explanation, Action, "Cancel") Then
		    Return
		  End If
		  
		  Self.DeleteSelected()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  If Me.SelectedRowIndex > -1 Then
		    Var Preset As Beacon.Preset = Me.RowTagAt(Me.SelectedRowIndex)
		    Self.OpenPreset(Preset)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PresetsToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateButton("NewPreset", "New Preset", IconToolbarAdd, "Create a new preset."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditPreset", "Edit Preset", IconToolbarEdit, "Edit the selected preset.", Self.List.SelectedRowCount = 1))
		  Me.Append(OmniBarItem.CreateButton("ClonePreset", "Duplicate", IconToolbarClone, "Create a copy of the selected presets.", Self.List.SelectedRowCount > 0))
		  Me.Append(OmniBarItem.CreateButton("ExportPreset", "Export", IconToolbarExport, "Export the selected presets to disk for sharing or backup.", Self.List.SelectedRowCount > 0))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "NewPreset"
		    Self.OpenPreset(New Beacon.MutablePreset)
		  Case "EditPreset"
		    Self.List.DoEdit()
		  Case "ClonePreset"
		    Self.CloneSelected()
		  Case "ExportPreset"
		    Self.ExportSelected()
		  End Select
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
