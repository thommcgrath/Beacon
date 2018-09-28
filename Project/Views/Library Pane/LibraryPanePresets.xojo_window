#tag Window
Begin LibrarySubview LibraryPanePresets Implements NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      Caption         =   "Presets"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
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
      RequiresSelection=   False
      RowCount        =   0
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
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
      EraseBackground =   True
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
      TabIndex        =   2
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
		  
		  Dim AddedPresets() As Beacon.Preset
		  
		  Do
		    If Not Obj.FolderItemAvailable Then
		      Continue
		    End If
		    
		    Dim File As Beacon.FolderItem = Obj.FolderItem
		    If Not File.IsType(BeaconFileTypes.BeaconPreset) Then
		      Continue
		    End If
		    
		    Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
		    If Preset <> Nil Then
		      Beacon.Data.SavePreset(Preset)
		      AddedPresets.Append(Preset)
		    End If
		  Loop Until Obj.NextItem = False
		  
		  If AddedPresets.Ubound > -1 Then
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
		  Self.ToolbarIcon = IconPresets
		  Self.ToolbarCaption = "Presets"
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Auto = Nil)
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
		  Dim Clone As New Beacon.MutablePreset
		  Clone.Label = Source.Label + " Copy"
		  Clone.Grouping = Source.Grouping
		  Clone.MaxItems = Source.MaxItems
		  Clone.MinItems = Source.MinItems
		  Clone.QualityModifier(Beacon.LootSource.Kinds.Standard) = Source.QualityModifier(Beacon.LootSource.Kinds.Standard)
		  Clone.QualityModifier(Beacon.LootSource.Kinds.Bonus) = Source.QualityModifier(Beacon.LootSource.Kinds.Bonus)
		  Clone.QualityModifier(Beacon.LootSource.Kinds.Cave) = Source.QualityModifier(Beacon.LootSource.Kinds.Cave)
		  Clone.QualityModifier(Beacon.LootSource.Kinds.Sea) = Source.QualityModifier(Beacon.LootSource.Kinds.Sea)
		  Clone.QuantityMultiplier(Beacon.LootSource.Kinds.Standard) = Source.QuantityMultiplier(Beacon.LootSource.Kinds.Standard)
		  Clone.QuantityMultiplier(Beacon.LootSource.Kinds.Bonus) = Source.QuantityMultiplier(Beacon.LootSource.Kinds.Bonus)
		  Clone.QuantityMultiplier(Beacon.LootSource.Kinds.Cave) = Source.QuantityMultiplier(Beacon.LootSource.Kinds.Cave)
		  Clone.QuantityMultiplier(Beacon.LootSource.Kinds.Sea) = Source.QuantityMultiplier(Beacon.LootSource.Kinds.Sea)
		  For Each Entry As Beacon.PresetEntry In Source
		    Clone.Append(New Beacon.PresetEntry(Entry))
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CloneSelected()
		  If List.SelCount = 0 Then
		    Return
		  End If
		  
		  Dim Clones() As Beacon.Preset
		  For I As Integer = 0 To List.ListCount - 1
		    If List.Selected(I) Then
		      Clones.Append(Self.ClonePreset(List.RowTag(I)))
		    End If
		  Next
		  
		  If Clones.Ubound = -1 Then
		    Return
		  End If
		  
		  For Each Clone As Beacon.Preset In Clones
		    Beacon.Data.SavePreset(Clone)
		  Next
		  
		  Self.UpdatePresets(Clones)
		  
		  If Clones.Ubound = 0 Then
		    Self.OpenPreset(Clones(0))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ClosePreset(Preset As Beacon.Preset) As Boolean
		  If Preset = Nil Then
		    Return True
		  End If
		  
		  Dim View As BeaconSubview = Self.View(Preset.PresetID)
		  Return Self.DiscardView(View)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelected()
		  If List.SelCount = 0 Then
		    Return
		  End If
		  
		  For I As Integer = 0 To List.ListCount - 1
		    If List.Selected(I) Then
		      Dim Preset As Beacon.Preset = List.RowTag(I)
		      If Self.ClosePreset(Preset) Then
		        Beacon.Data.RemovePreset(Preset)
		      End If
		    End If
		  Next    
		  Self.UpdatePresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportSelected()
		  If List.SelCount = 0 Then
		    Return
		  End If
		  
		  If List.SelCount = 1 Then
		    Dim Preset As Beacon.Preset = List.RowTag(List.ListIndex)
		    Dim Dialog As New SaveAsDialog
		    Dialog.Filter = BeaconFileTypes.BeaconPreset
		    Dialog.SuggestedFileName = Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension
		    
		    Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If File <> Nil Then
		      Preset.ToFile(File)
		    End If
		    
		    Return
		  End If
		  
		  Dim Dialog As New SelectFolderDialog
		  Dialog.PromptText = "Select Folder For Bulk Export"
		  
		  Dim Folder As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If Folder = Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To List.ListCount - 1
		    If Not List.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Preset As Beacon.Preset = List.RowTag(I)
		    Preset.ToFile(Folder.Child(Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension))
		  Next
		  
		  Folder.Launch
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewPreset()
		  Dim Preset As New Beacon.MutablePreset
		  Beacon.Data.SavePreset(Preset)
		  Self.UpdatePresets(Preset)
		  Self.OpenPreset(Preset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  If Notification.Name = "Preset Saved" Then
		    Dim Preset As Beacon.Preset = Notification.UserData
		    Self.UpdatePresets(Preset)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenPreset(Preset As Beacon.Preset)
		  If Preset = Nil Then
		    Return
		  End If
		  
		  Dim View As BeaconSubview = Self.View(Preset.PresetID)
		  If View = Nil Then
		    View = New PresetEditorView(Preset)
		  End If
		  Self.ShowView(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePresets(SelectPresets() As Beacon.Preset)
		  Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		  Dim PresetCount As Integer = UBound(Presets) + 1
		  
		  If SelectPresets.Ubound = -1 Then
		    For I As Integer = 0 To List.ListCount - 1
		      If List.Selected(I) Then
		        SelectPresets.Append(List.RowTag(I))
		      End If
		    Next
		  End If
		  
		  Dim SelectIDs() As Text
		  For Each Preset As Beacon.Preset In SelectPresets
		    SelectIDs.Append(Preset.PresetID)
		  Next
		  
		  While List.ListCount > PresetCount
		    List.RemoveRow(0)
		  Wend
		  While List.ListCount < PresetCount
		    List.AddRow("")
		  Wend
		  
		  For I As Integer = 0 To List.ListCount - 1
		    List.Cell(I, 0) = Presets(I).Label
		    Select Case Presets(I).Type
		    Case Beacon.Preset.Types.BuiltIn
		      List.Cell(I, 1) = "Built-In"
		    Case Beacon.Preset.Types.Custom
		      List.Cell(I, 1) = "Custom"
		    Case Beacon.Preset.Types.CustomizedBuiltIn
		      List.Cell(I, 1) = "Customized Built-In"
		    End Select
		    List.RowTag(I) = Presets(I)
		  Next
		  
		  List.Sort
		  
		  For I As Integer = 0 To List.ListCount - 1
		    List.Selected(I) = (SelectIDs.IndexOf(Beacon.Preset(List.RowTag(I)).PresetID) > -1)
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
		  Header.Duplicate.Enabled = Me.SelCount > 0
		  Header.Export.Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  If Me.ListIndex > -1 Then
		    Dim Preset As Beacon.Preset = Me.RowTag(Me.ListIndex)
		    Self.OpenPreset(Preset)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnAlignment(1) = Listbox.AlignRight
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  For I As Integer = Me.ListCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Preset As Beacon.Preset = Me.RowTag(I)
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
		  Dim DeleteCount, RevertCount, DisallowCount As Integer
		  For I As Integer = Me.ListCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Preset As Beacon.Preset = Me.RowTag(I)
		    Select Case Preset.Type
		    Case Beacon.Preset.Types.BuiltIn
		      DisallowCount = DisallowCount + 1
		    Case Beacon.Preset.Types.Custom
		      DeleteCount = DeleteCount + 1
		    Case Beacon.Preset.Types.CustomizedBuiltIn
		      RevertCount = RevertCount + 1
		    End Select
		  Next
		  
		  Dim Message, Action As String
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
		  
		  Dim Explanation As String = "This action cannot be undone."
		  If DisallowCount > 0 Then
		    Explanation = "Built-in presets will not be deleted. " + Explanation
		  End If
		  
		  If Warn And Not Self.ShowConfirm(Message, Explanation, Action, "Cancel") Then
		    Return
		  End If
		  
		  Self.DeleteSelected()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
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
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarIcon"
		Group="Behavior"
		Type="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
