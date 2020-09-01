#tag Window
Begin BeaconSubview ModEditorView
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
   Height          =   432
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   844
   Begin BeaconListbox BlueprintList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "*,80"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   391
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
      RowSelectionType=   "1"
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
      Width           =   844
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BeaconToolbar BlueprintHeader
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderBottom    =   True
      BorderLeft      =   False
      BorderRight     =   False
      BorderTop       =   False
      Caption         =   "Blueprints"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   844
   End
   Begin ClipboardWatcher Watcher
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   "2"
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Shared Function ClipboardHasCodes() As Boolean
		  Var Board As New Clipboard
		  If Not Board.TextAvailable Then
		    Return False
		  End If
		  
		  Var Content As String = Board.Text
		  Return Content.IndexOf("Blueprint") > -1 Or Content.IndexOf("giveitem") > -1 Or Content.IndexOf("spawndino") > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_BlueprintsLoaded(Sender As BlueprintController)
		  Var Blueprints() As Beacon.Blueprint = Sender.Blueprints
		  Var SelectedBlueprints() As String
		  For Row As Integer = 0 To Self.BlueprintList.LastRowIndex
		    If Self.BlueprintList.Selected(Row) Then
		      SelectedBlueprints.AddRow(Self.BlueprintList.RowTagAt(Row))
		    End If
		  Next
		  
		  Self.BlueprintList.SelectionChangeBlocked = True
		  Self.BlueprintList.RowCount = Blueprints.Count
		  
		  For Row As Integer = 0 To Self.BlueprintList.LastRowIndex
		    Var Blueprint As Beacon.Blueprint = Blueprints(Row)
		    Var ObjectID As String = Blueprint.ObjectID
		    Var Type As String = "Blueprint"
		    Select Case Blueprint
		    Case IsA Beacon.Engram
		      Type = "Engram"
		    Case IsA Beacon.Creature
		      Type = "Creature"
		    Case IsA Beacon.SpawnPoint
		      Type = "Spawn"
		    End Select
		    
		    Self.BlueprintList.CellValueAt(Row, 0) = Blueprint.Label
		    Self.BlueprintList.CellValueAt(Row, 1) = Type
		    Self.BlueprintList.RowTagAt(Row) = ObjectID
		    Self.BlueprintList.Selected(Row) = SelectedBlueprints.IndexOf(ObjectID) > -1
		  Next
		  
		  Self.BlueprintList.SortingColumn = 0
		  Self.BlueprintList.Sort
		  Self.BlueprintList.EnsureSelectionIsVisible
		  Self.BlueprintList.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_PublishFinished(Sender As BlueprintController, Success As Boolean, Reason As String)
		  Self.UpdatePublishButton()
		  
		  If Success Then
		    Self.mController.LoadBlueprints()
		  Else
		    Self.ShowAlert("Beacon was unable to publish the requested changes.", Reason)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkFinished(Sender As BlueprintController)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkStarted(Sender As BlueprintController)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PromptForImportFile(Parent As Window) As FolderItem
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.Text + BeaconFileTypes.CSVFile
		  Return Dialog.ShowModalWithin(Parent.TrueWindow)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PromptForImportURL(Parent As Window) As String
		  Return LibraryEngramsURLDialog.Present(Parent)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetController(Controller As BlueprintController) As Boolean
		  If Self.mController = Controller Then
		    Return False
		  End If
		  
		  If (Self.mController Is Nil) = False Then
		    If Self.mController.HasUnpublishedChanges Then
		      Return False
		    End If
		    
		    RemoveHandler Self.mController.BlueprintsLoaded, WeakAddressOf mController_BlueprintsLoaded
		    RemoveHandler Self.mController.PublishFinished, WeakAddressOf mController_PublishFinished
		    RemoveHandler Self.mController.WorkStarted, WeakAddressOf mController_WorkStarted
		    RemoveHandler Self.mController.WorkFinished, WeakAddressOf mController_WorkFinished
		    Self.mController = Nil
		    Self.BlueprintList.RemoveAllRows
		  End If
		  
		  If (Controller Is Nil) = False Then
		    AddHandler Controller.BlueprintsLoaded, WeakAddressOf mController_BlueprintsLoaded
		    AddHandler Controller.PublishFinished, WeakAddressOf mController_PublishFinished
		    AddHandler Controller.WorkStarted, WeakAddressOf mController_WorkStarted
		    AddHandler Controller.WorkFinished, WeakAddressOf mController_WorkFinished
		    
		    Self.mController = Controller
		    Self.UpdatePublishButton()
		    Self.mController.LoadBlueprints()
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePublishButton()
		  Self.mPublishButton.Enabled = (Self.mController Is Nil) = False And Self.mController.HasUnpublishedChanges
		  Self.mRevertButton.Enabled = Self.mPublishButton.Enabled
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mController As BlueprintController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublishButton As BeaconToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRevertButton As BeaconToolbarItem
	#tag EndProperty


#tag EndWindowCode

#tag Events BlueprintList
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(1) = Listbox.Alignments.Right
		End Sub
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
		Sub PerformClear(Warn As Boolean)
		  If Self.mController Is Nil Then
		    Return
		  End If
		  
		  Var Blueprints() As Beacon.Blueprint
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Not Me.Selected(Row) Then
		      Continue
		    End If
		    
		    Var ObjectID As String = Me.RowTagAt(Row)
		    Var Blueprint As Beacon.Blueprint = Self.mController.Blueprint(ObjectID)
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    Blueprints.AddRow(Blueprint)
		  Next
		  
		  If Warn And Not Self.ShowDeleteConfirmation(Blueprints, "blueprint", "blueprints") Then
		    Return
		  End If
		  
		  Self.mController.DeleteBlueprints(Blueprints)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  If Self.mController Is Nil Then
		    Return
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Var ObjectID As String = Me.RowTagAt(Me.SelectedRowIndex)
		    Var Blueprint As Beacon.Blueprint = Self.mController.Blueprint(ObjectID)
		    If Blueprint Is Nil Then
		      Return
		    End If
		    
		    Blueprint = BlueprintEditorDialog.Present(Self, Blueprint)
		    If Blueprint Is Nil Then
		      Return
		    End If
		    
		    Self.mController.SaveBlueprint(Blueprint)
		  ElseIf Me.SelectedRowCount > 1 Then
		    Var Blueprints() As Beacon.Blueprint
		    For Row As Integer = 0 To Me.LastRowIndex
		      If Me.Selected(Row) Then
		        Blueprints.AddRow(Self.mController.Blueprint(Me.RowTagAt(Row).StringValue))
		      End If
		    Next
		    
		    Var ModifiedBlueprints() As Beacon.Blueprint = BlueprintMultiEditor.Present(Self, Blueprints)
		    If (ModifiedBlueprints Is Nil) = False Then
		      For Each Blueprint As Beacon.Blueprint In Blueprints
		        Self.mController.SaveBlueprint(Blueprint)
		      Next
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BlueprintHeader
	#tag Event
		Sub Open()
		  Var AddButton As New BeaconToolbarItem("AddButton", IconToolbarAdd, "Add a new blueprint to this mod")
		  Me.LeftItems.Append(AddButton)
		  
		  Var ImportFileButton As New BeaconToolbarItem("ImportFile", IconToolbarFile, "Import from file")
		  Me.LeftItems.Append(ImportFileButton)
		  
		  Var ImportURLButton As New BeaconToolbarItem("ImportURL", IconToolbarLink, "Import from website")
		  Me.LeftItems.Append(ImportURLButton)
		  
		  Var ImportClipboardButton As New BeaconToolbarItem("ImportClipboard", IconToolbarCopied, Self.ClipboardHasCodes, "Import from copied text")
		  Me.LeftItems.Append(ImportClipboardButton)
		  
		  Self.mPublishButton = New BeaconToolbarItem("PublishButton", IconToolbarPublish, False, "Make changes live")
		  Self.mRevertButton = New BeaconToolbarItem("RevertButton", IconToolbarRevert, False, "Cancel changes and revert to the blueprints on the server.")
		  
		  Me.RightItems.Append(Self.mRevertButton)
		  Me.RightItems.Append(Self.mPublishButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  If Self.mController Is Nil Then
		    Return
		  End If
		  
		  Select Case Item.Name
		  Case "AddButton"
		    Var Blueprint As Beacon.Blueprint = BlueprintEditorDialog.Present(Self, Nil)
		    If (Blueprint Is Nil) = False Then
		      Self.mController.SaveBlueprint(Blueprint)
		    End If
		  Case "ImportFile"
		    
		  Case "ImportURL"
		    
		  Case "ImportClipboard"
		    
		  Case "PublishButton"
		    Self.mController.Publish()
		  Case "RevertButton"
		    Self.mController.DiscardChanges()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Watcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  Self.BlueprintHeader.ImportClipboard.Enabled = Self.ClipboardHasCodes
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
