#tag Window
Begin LibrarySubview LibraryPanePresets Implements NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   300
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
   Width           =   300
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   "Presets"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "50%,50%"
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
      HasHeading      =   False
      HeadingIndex    =   0
      Height          =   259
      HelpTag         =   ""
      Hierarchical    =   False
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
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   300
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
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
		    If Not File.IsType(BeaconFileTypes.BeaconPreset) Then
		      Continue
		    End If
		    
		    Var Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
		    If Preset <> Nil Then
		      Beacon.Data.SavePreset(Preset)
		      AddedPresets.AddRow(Preset)
		    End If
		  Loop Until Obj.NextItem = False
		  
		  If AddedPresets.LastRowIndex > -1 Then
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
		  Self.ToolbarCaption = "Presets"
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
		      Clones.AddRow(Self.ClonePreset(List.RowTagAt(I)))
		    End If
		  Next
		  
		  If Clones.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  For Each Clone As Beacon.Preset In Clones
		    Beacon.Data.SavePreset(Clone)
		  Next
		  
		  Self.UpdatePresets(Clones)
		  
		  If Clones.LastRowIndex = 0 Then
		    Self.OpenPreset(Clones(0))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ClosePreset(Preset As Beacon.Preset) As Boolean
		  If Preset = Nil Then
		    Return True
		  End If
		  
		  Var View As BeaconSubview = Self.View(Preset.PresetID)
		  Return Self.DiscardView(View)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatePreset(ItemSet As Beacon.ItemSet) As Beacon.Preset
		  Var Preset As Beacon.MutablePreset
		  If ItemSet.SourcePresetID <> "" Then
		    Var SourcePreset As Beacon.Preset = LocalData.SharedInstance.GetPreset(ItemSet.SourcePresetID)
		    If SourcePreset <> Nil Then
		      Preset = New Beacon.MutablePreset(SourcePreset)
		    End If
		  End If
		  If Preset = Nil Then
		    Preset = New Beacon.MutablePreset()
		  End If
		  
		  Preset.Label = ItemSet.Label
		  Preset.MinItems = ItemSet.MinNumItems
		  Preset.MaxItems = ItemSet.MaxNumItems
		  
		  Preset.ResizeTo(-1)
		  For Each Entry As Beacon.SetEntry In ItemSet
		    Preset.Append(New Beacon.PresetEntry(Entry))
		  Next
		  
		  Self.OpenPreset(Preset, True)
		  Return Preset
		End Function
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
		    Dialog.SuggestedFileName = Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension
		    
		    Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If File <> Nil Then
		      Preset.ToFile(File)
		    End If
		    
		    Return
		  End If
		  
		  Var Dialog As New SelectFolderDialog
		  Dialog.PromptText = "Select Folder For Bulk Export"
		  
		  Var Folder As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If Folder = Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To List.RowCount - 1
		    If Not List.Selected(I) Then
		      Continue
		    End If
		    
		    Var Preset As Beacon.Preset = List.RowTagAt(I)
		    Preset.ToFile(Folder.Child(Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension))
		  Next
		  
		  Folder.Open
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewPreset()
		  Self.OpenPreset(New Beacon.MutablePreset)
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
		Private Sub OpenPreset(Preset As Beacon.Preset, DefaultModified As Boolean = False)
		  If Preset = Nil Then
		    Return
		  End If
		  
		  Var View As BeaconSubview = Self.View(Preset.PresetID)
		  If View = Nil Then
		    View = New PresetEditorView(Preset)
		  End If
		  Self.ShowView(View)
		  If DefaultModified Then
		    View.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenPreset(File As FolderItem, Import As Boolean, DefaultModified As Boolean = False)
		  Var Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
		  If Preset = Nil Then
		    Self.ShowAlert("Unable to open preset file", "The file may be damaged or a newer format.")
		    Return
		  End If
		  
		  If Import Then
		    LocalData.SharedInstance.SavePreset(Preset)
		    Self.OpenPreset(Preset, DefaultModified)
		    Return
		  End If
		  
		  Var ViewID As String = EncodeHex(Crypto.MD5(File.NativePath))
		  Var View As BeaconSubview = Self.View(ViewID)
		  If View = Nil Then
		    View = New PresetEditorView(Preset, File)
		  End If
		  Self.ShowView(View)
		  If DefaultModified Then
		    View.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePresets(SelectPresets() As Beacon.Preset)
		  Var Presets() As Beacon.Preset = Beacon.Data.Presets
		  Var PresetCount As Integer = Presets.LastRowIndex + 1
		  
		  If SelectPresets.LastRowIndex = -1 Then
		    For I As Integer = 0 To List.RowCount - 1
		      If List.Selected(I) Then
		        SelectPresets.AddRow(List.RowTagAt(I))
		      End If
		    Next
		  End If
		  
		  Var SelectIDs() As String
		  For Each Preset As Beacon.Preset In SelectPresets
		    SelectIDs.AddRow(Preset.PresetID)
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

	#tag Method, Flags = &h21
		Private Sub UpdatePresets(ParamArray SelectPresets() As Beacon.Preset)
		  Self.UpdatePresets(SelectPresets)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(ByRef NewSize As Integer)
	#tag EndHook


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("Add", IconToolbarAdd))
		  Me.LeftItems.Append(New BeaconToolbarItem("Duplicate", IconToolbarClone, False))
		  Me.RightItems.Append(New BeaconToolbarItem("Export", IconToolbarExport, False))
		  
		  Me.ItemWithName("Add").HelpTag = "Create a new preset from scratch."
		  Me.ItemWithName("Duplicate").HelpTag = "Duplicate the selected preset or presets."
		  Me.ItemWithName("Export").HelpTag = "Export the selected preset or presets to disk for sharing."
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "Export"
		    Self.ExportSelected()
		  Case "Duplicate"
		    Self.CloneSelected()
		  Case "Add"
		    Self.NewPreset()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  Header.Duplicate.Enabled = Me.SelectedRowCount > 0
		  Header.Export.Enabled = Me.SelectedRowCount > 0
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
		    Message = "Are you sure you want to delete or revert these " + Str(DeleteCount + RevertCount, "-0") + " presets?"
		    Action = "Delete"
		  ElseIf DeleteCount = 1 Then
		    Message = "Are you sure you want to delete this preset?"
		    Action = "Delete"
		  ElseIf DeleteCount > 1 Then
		    Message = "Are you sure you want to delete these " + Str(DeleteCount, "-0") + " presets?"
		    Action = "Delete"
		  ElseIf RevertCount = 1 Then
		    Message = "Are you sure you want to revert this preset?"
		    Action = "Revert"
		  ElseIf RevertCount > 1 Then
		    Message = "Are you sure you want to revert these " + Str(RevertCount, "-0") + " presets?"
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
		Sub DoubleClick()
		  If Me.SelectedRowIndex > -1 Then
		    Var Preset As Beacon.Preset = Me.RowTagAt(Me.SelectedRowIndex)
		    Self.OpenPreset(Preset)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="ToolbarIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
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
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
