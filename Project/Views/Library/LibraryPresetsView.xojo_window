#tag Window
Begin BeaconSubview LibraryPresetsView Implements NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
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
   Width           =   800
   Begin UITweaks.ResizedPushButton AddButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "New"
      Default         =   False
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
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CloneButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Duplicate"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   204
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton DeleteButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Delete"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   296
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton EditButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Edit"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   0
      Height          =   339
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Type"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   60
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   760
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #Pragma Unused action
		  
		  Do
		    If Obj.FolderItemAvailable And Obj.FolderItem.IsType(BeaconFileTypes.BeaconPreset) Then
		      Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(Obj.FolderItem)
		      If Preset <> Nil Then
		        Beacon.Data.SavePreset(Preset)
		        Self.UpdatePresets(Preset)
		      End If
		    End If
		  Loop Until Obj.NextItem = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  If List.ListIndex > -1 Then
		    FileExport.Enable
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
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Auto = Nil)
		  NotificationKit.Watch(Self, "Preset Saved")
		  
		  Self.UpdatePresets(UserData)
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			If List.ListIndex > -1 Then
			Dim Preset As Beacon.Preset = List.RowTag(List.ListIndex)
			Dim Dialog As New SaveAsDialog
			Dialog.Filter = BeaconFileTypes.BeaconPreset
			Dialog.SuggestedFileName = Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension
			
			Dim File As FolderItem = Dialog.ShowModalWithin(Self)
			If File <> Nil Then
			Preset.ToFile(File)
			End If
			
			Return True
			End If
		End Function
	#tag EndMenuHandler


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
		Private Sub UpdatePresets(SelectPreset As Beacon.Preset = Nil)
		  Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		  Dim PresetCount As Integer = UBound(Presets) + 1
		  
		  Dim Selected As Text
		  If SelectPreset <> Nil Then
		    Selected = SelectPreset.PresetID
		  ElseIf List.ListIndex > -1 Then
		    Selected = Beacon.Preset(List.RowTag(List.ListIndex)).PresetID
		  End If
		  
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
		  
		  If Selected <> "" Then
		    For I As Integer = 0 To List.ListCount - 1
		      If Beacon.Preset(List.RowTag(I)).PresetID = Selected Then
		        List.ListIndex = I
		        List.ScrollPosition = I
		        Exit For I
		      End If
		    Next
		  Else
		    List.ListIndex = -1
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


#tag EndWindowCode

#tag Events AddButton
	#tag Event
		Sub Action()
		  PresetWindow.Present()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CloneButton
	#tag Event
		Sub Action()
		  Dim Source As Beacon.Preset = List.RowTag(List.ListIndex)
		  Dim Clone As New Beacon.MutablePreset
		  Clone.Label = Source.Label
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
		  
		  PresetWindow.Present(Clone)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeleteButton
	#tag Event
		Sub Action()
		  Dim Preset As Beacon.Preset = List.RowTag(List.ListIndex)
		  Beacon.Data.RemovePreset(Preset)
		  Self.UpdatePresets()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditButton
	#tag Event
		Sub Action()
		  Dim Preset As Beacon.Preset = List.RowTag(List.ListIndex)
		  PresetWindow.Present(Preset)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  If Me.ListIndex = -1 Then
		    EditButton.Enabled = False
		    CloneButton.Enabled = False
		    DeleteButton.Enabled = False
		    DeleteButton.Caption = "Delete"
		    Return
		  End If
		  
		  Dim Preset As Beacon.Preset = Me.RowTag(Me.ListIndex)
		  EditButton.Enabled = True
		  CloneButton.Enabled = True
		  
		  Select Case Preset.Type
		  Case Beacon.Preset.Types.BuiltIn
		    DeleteButton.Enabled = False
		    DeleteButton.Caption = "Delete"
		  Case Beacon.Preset.Types.Custom
		    DeleteButton.Enabled = True
		    DeleteButton.Caption = "Delete"
		  Case Beacon.Preset.Types.CustomizedBuiltIn
		    DeleteButton.Enabled = True
		    DeleteButton.Caption = "Revert"
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
