#tag DesktopWindow
Begin BeaconDialog ArkSASaveBlueprintsDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   False
   MinimumHeight   =   400
   MinimumWidth    =   500
   Resizeable      =   True
   Title           =   "Save Embedded Blueprints"
   Type            =   8
   Visible         =   True
   Width           =   600
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Save"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      Text            =   "Save Embedded Blueprints"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   55
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "This project contains user-generated blueprints that are either not part of your Beacon account, or are newer versions of blueprints you've already saved. You can save these blueprints to your Beacon account for future use."
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   True
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   229
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   119
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopProgressWheel Spinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   364
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin Thread SaveThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Var Packs() As Beacon.ContentPack = Self.mProject.EmbeddedContentPacks
		  Var PackNames() As String
		  PackNames.ResizeTo(Packs.LastIndex)
		  For Idx As Integer = 0 To PackNames.LastIndex
		    PackNames(Idx) = Packs(Idx).Name
		  Next
		  PackNames.SortWith(Packs)
		  
		  For Each Pack As Beacon.ContentPack In Packs
		    Var Blueprints() As ArkSA.Blueprint = Self.mProject.EmbeddedBlueprints(Pack, True)
		    If Blueprints.Count = 0 Then
		      Continue
		    End If
		    
		    Var BlueprintNames() As String
		    BlueprintNames.ResizeTo(Blueprints.LastIndex)
		    For Idx As Integer = 0 To BlueprintNames.LastIndex
		      BlueprintNames(Idx) = Blueprints(Idx).Label
		    Next
		    BlueprintNames.SortWith(Blueprints)
		    
		    Self.mUnsavedBlueprints.Value(Pack.ContentPackId) = Blueprints
		    
		    Self.List.AddExpandableRow(Pack.Name)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Pack
		    Self.List.CellCheckBoxStateAt(Self.List.LastAddedRowIndex, 0) = DesktopCheckBox.VisualStates.Checked
		    Self.mStates.Value(Pack.ContentPackId) = DesktopCheckBox.VisualStates.Checked
		  Next
		  Self.List.ColumnTypeAt(0) = DesktopListBox.CellTypes.CheckBox
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Project As ArkSA.Project)
		  Self.mProject = Project
		  Self.mStates = New Dictionary
		  Self.mUnsavedBlueprints = New Dictionary
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As DesktopWindow, Project As ArkSA.Project)
		  If (Parent Is Nil) = False Then
		    Parent = Parent.TrueWindow
		  End If
		  
		  Var Win As New ArkSASaveBlueprintsDialog(Project)
		  Win.ShowModal(Parent)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprints() As ArkSA.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPacks() As Beacon.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As ArkSA.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStates As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUnsavedBlueprints As Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var ContentPacks() As Beacon.ContentPack
		  Var Blueprints() As ArkSA.Blueprint
		  
		  Var Packs() As Beacon.ContentPack = Self.mProject.EmbeddedContentPacks
		  For Each Pack As Beacon.ContentPack In Packs
		    Var PackState As DesktopCheckBox.VisualStates = Self.mStates.Lookup(Pack.ContentPackId, DesktopCheckBox.VisualStates.Unchecked)
		    Select Case PackState
		    Case DesktopCheckBox.VisualStates.Unchecked
		      Continue
		    Case DesktopCheckBox.VisualStates.Checked
		      ContentPacks.Add(Pack)
		      Var Temp() As ArkSA.Blueprint = Self.mUnsavedBlueprints.Value(Pack.ContentPackId)
		      For Each Blueprint As ArkSA.Blueprint In Temp
		        Blueprints.Add(Blueprint)
		      Next
		    Case DesktopCheckBox.VisualStates.Indeterminate
		      ContentPacks.Add(Pack)
		      Var Temp() As ArkSA.Blueprint = Self.mUnsavedBlueprints.Value(Pack.ContentPackId)
		      For Each Blueprint As ArkSA.Blueprint In Temp
		        Var BlueprintState As DesktopCheckBox.VisualStates = Self.mStates.Lookup(Blueprint.BlueprintId, DesktopCheckBox.VisualStates.Unchecked)
		        If BlueprintState = DesktopCheckBox.VisualStates.Checked Then
		          Blueprints.Add(Blueprint)
		        End If
		      Next
		    End Select
		  Next
		  
		  Self.mBlueprints = Blueprints
		  Self.mContentPacks = ContentPacks
		  Me.Enabled = False
		  Self.List.Enabled = False
		  Self.CancelButton.Enabled = False
		  Self.Spinner.Visible = True
		  
		  Self.SaveThread.Start
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub RowExpanded(row As Integer)
		  Var Pack As Beacon.ContentPack = Me.RowTagAt(Row)
		  Var Blueprints() As ArkSA.Blueprint = Self.mUnsavedBlueprints.Value(Pack.ContentPackId)
		  Var PackState As DesktopCheckBox.VisualStates = Self.mStates.Lookup(Pack.ContentPackId, DesktopCheckBox.VisualStates.Checked)
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Me.AddRow(Blueprint.Label)
		    Me.RowTagAt(Me.LastAddedRowIndex) = Blueprint
		    If Self.mStates.HasKey(Blueprint.BlueprintId) = False Then
		      If PackState = DesktopCheckBox.VisualStates.Indeterminate Then
		        Self.mStates.Value(Blueprint.BlueprintId) = DesktopCheckBox.VisualStates.Checked
		      Else
		        Self.mStates.Value(Blueprint.BlueprintId) = PackState
		      End If
		    End If
		    Me.CellCheckBoxStateAt(Me.LastAddedRowIndex, 0) = Self.mStates.Value(Blueprint.BlueprintId)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Var RowTag As Variant = Me.RowTagAt(Row)
		  Var SomethingSelected As Boolean
		  Select Case RowTag.ObjectValue
		  Case IsA Beacon.ContentPack
		    Var Checked As Boolean = Me.CellCheckBoxValueAt(Row, Column)
		    Var Pack As Beacon.ContentPack = RowTag
		    Self.mStates.Value(Pack.ContentPackId) = Checked
		    
		    Var Blueprints() As ArkSA.Blueprint = Self.mUnsavedBlueprints.Value(Pack.ContentPackId)
		    For Each Blueprint As ArkSA.Blueprint In Blueprints
		      Self.mStates.Value(Blueprint.BlueprintId) = Checked
		    Next
		    
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.RowTagAt(Idx).ObjectValue IsA ArkSA.Blueprint And ArkSA.Blueprint(Me.RowTagAt(Idx)).ContentPackId = Pack.ContentPackId Then
		        Me.CellCheckBoxValueAt(Idx, Column) = Checked
		      End If
		      SomethingSelected = SomethingSelected Or Me.CellCheckBoxValueAt(Idx, Column)
		    Next
		  Case IsA ArkSA.Blueprint
		    Var Blueprint As ArkSA.Blueprint = RowTag
		    Var ContentPackId As String = Blueprint.ContentPackId
		    Var First As Boolean = True
		    Var State As DesktopCheckBox.VisualStates
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If (Me.RowTagAt(Idx).ObjectValue IsA ArkSA.Blueprint) = False Or ArkSA.Blueprint(Me.RowTagAt(Idx)).ContentPackId <> ContentPackId Then
		        Continue
		      End If
		      
		      If First Then
		        State = Me.CellCheckBoxStateAt(Idx, Column)
		        First = False
		      Else
		        If State <> Me.CellCheckBoxStateAt(Idx, Column) Then
		          State = DesktopCheckBox.VisualStates.Indeterminate
		          Exit For Idx
		        End If
		      End If
		    Next
		    
		    Self.mStates.Value(ContentPackId) = State
		    Self.mStates.Value(Blueprint.BlueprintId) = Me.CellCheckBoxStateAt(Row, Column)
		    
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.RowTagAt(Idx).ObjectValue IsA Beacon.ContentPack And Beacon.ContentPack(Me.RowTagAt(Idx)).ContentPackId = ContentPackId Then
		        Me.CellCheckBoxStateAt(Idx, Column) = State
		      End If
		      SomethingSelected = SomethingSelected Or Me.CellCheckBoxValueAt(Idx, Column)
		    Next
		  End Select
		  
		  Self.ActionButton.Enabled = SomethingSelected
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SaveThread
	#tag Event
		Sub Run()
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(True)
		  For Each Pack As Beacon.ContentPack In Self.mContentPacks
		    Call DataSource.SaveContentPack(Pack, True)
		  Next
		  Var Delete() As ArkSA.Blueprint
		  Call DataSource.SaveBlueprints(Self.mBlueprints, Delete, Nil, True)
		  Self.mProject.ProcessEmbeddedContent()
		  Me.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("Finished", False).BooleanValue Then
		      Self.Close
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
			"9 - Modeless Dialog"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
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
#tag EndViewBehavior
