#tag Window
Begin BeaconWindow PresetManagerWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   True
   MinWidth        =   600
   Placement       =   2
   Resizeable      =   True
   Title           =   "Preset Library"
   Visible         =   True
   Width           =   600
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
      Height          =   328
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   360
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   360
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   360
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   360
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  If Self = mInstance Then
		    mInstance = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
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
		Sub Open()
		  Self.UpdatePresets()
		  Self.AcceptFileDrop(BeaconFileTypes.BeaconPreset)
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
		Shared Function SharedWindow(Create As Boolean = True) As PresetManagerWindow
		  If mInstance = Nil And Create = True Then
		    mInstance = New PresetManagerWindow
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ShowPreset(Preset As Beacon.Preset)
		  Dim Win As PresetManagerWindow = PresetManagerWindow.SharedWindow(False)
		  If Win = Nil Then
		    // Not visible, show it
		    Win = PresetManagerWindow.SharedWindow(True)
		    Win.Show
		  End If
		  Win.UpdatePresets(Preset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub UpdateIfVisible(SelectPreset As Beacon.Preset = Nil)
		  Dim Win As PresetManagerWindow = SharedWindow(False)
		  If Win <> Nil Then
		    Win.UpdatePresets(SelectPreset)
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


	#tag Property, Flags = &h21
		Private Shared mInstance As PresetManagerWindow
	#tag EndProperty


#tag EndWindowCode

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
#tag Events AddButton
	#tag Event
		Sub Action()
		  PresetWindow.Present()
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
#tag Events DeleteButton
	#tag Event
		Sub Action()
		  Dim Preset As Beacon.Preset = List.RowTag(List.ListIndex)
		  Beacon.Data.RemovePreset(Preset)
		  Self.UpdatePresets()
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
