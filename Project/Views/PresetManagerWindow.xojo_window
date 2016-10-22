#tag Window
Begin Window PresetManagerWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   680
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   680
   MinimizeButton  =   True
   MinWidth        =   932
   Placement       =   2
   Resizeable      =   True
   Title           =   "Preset Library"
   Visible         =   True
   Width           =   932
   Begin PresetEditor Editor
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   False
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   680
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   200
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   732
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
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
      HasHeading      =   False
      HeadingIndex    =   0
      Height          =   680
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
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   200
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Self.SavePreset()
		  
		  If Self = mInstance Then
		    mInstance = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.UpdatePresets()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandleSelectionChange()
		  Self.SavePreset()
		  
		  If List.ListIndex > -1 Then
		    Editor.Preset = List.RowTag(List.ListIndex)
		    Editor.Enabled = True
		  Else
		    Editor.Enabled = False
		    Editor.Preset = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewPreset(Source As Beacon.ItemSet)
		  Self.mBlockSelectionChange = True
		  List.ListIndex = -1
		  Self.mBlockSelectionChange = False
		  
		  Dim Preset As New Beacon.MutablePreset
		  Preset.Label = Source.Label
		  Preset.MinItems = Source.MinNumItems
		  Preset.MaxItems = Source.MaxNumItems
		  For Each Entry As Beacon.SetEntry In Source
		    Preset.Append(New Beacon.PresetEntry(Entry))
		  Next
		  
		  Editor.Preset = Preset
		  Editor.Enabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SavePreset()
		  If Not Editor.ContentsChanged Then
		    Return
		  End If
		  
		  Dim Preset As Beacon.Preset = Editor.Preset
		  If Preset <> Nil Then
		    Beacon.Data.SavePreset(Preset)
		    For I As Integer = 0 To List.ListCount - 1
		      If Beacon.Preset(List.RowTag(I)).PresetID = Preset.PresetID Then
		        List.RowTag(I) = Preset
		        List.Cell(I, 0) = Preset.Label
		        Self.mBlockSelectionChange = True
		        List.Sort
		        Self.mBlockSelectionChange = False
		        Return
		      End If
		    Next
		    List.AddRow(Preset.Label)
		    List.RowTag(List.LastIndex) = Preset
		    Self.mBlockSelectionChange = True
		    List.Sort
		    Self.mBlockSelectionChange = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedWindow(Create As Boolean = True) As PresetManagerWindow
		  If mInstance = Nil And Create = True Then
		    mInstance = New PresetManagerWindow
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowPreset(Preset As Beacon.Preset)
		  Self.mBlockSelectionChange = True
		  Dim Scrolled As Boolean
		  For I As Integer = 0 To List.ListCount - 1
		    List.Selected(I) = (Beacon.Preset(List.RowTag(I)).PresetID = Preset.PresetID)
		    If Scrolled = False And List.Selected(I) Then
		      Scrolled = True
		      List.ScrollPosition = I
		    End If
		  Next
		  Self.mBlockSelectionChange = False
		  Self.HandleSelectionChange()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdatePresets()
		  Dim Presets() As Beacon.Preset = Beacon.Data.Presets
		  Dim PresetCount As Integer = UBound(Presets) + 1
		  
		  Dim Selected() As Text
		  For I As Integer = 0 To List.ListCount - 1
		    Selected.Append(Beacon.Preset(List.RowTag(I)).PresetID)
		  Next
		  
		  Self.mBlockSelectionChange = True
		  
		  While List.ListCount > PresetCount
		    List.RemoveRow(0)
		  Wend
		  While List.ListCount < PresetCount
		    List.AddRow("")
		  Wend
		  
		  For I As Integer = 0 To List.ListCount - 1
		    List.Cell(I, 0) = Presets(I).Label
		    List.RowTag(I) = Presets(I)
		    List.Selected(I) = Selected.IndexOf(Presets(I).PresetID) > -1
		  Next
		  
		  List.Sort
		  Self.mBlockSelectionChange = False
		  Self.HandleSelectionChange()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlockSelectionChange As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As PresetManagerWindow
	#tag EndProperty


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Change()
		  If Self.mBlockSelectionChange Then
		    Return
		  End If
		  
		  Self.HandleSelectionChange()
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
