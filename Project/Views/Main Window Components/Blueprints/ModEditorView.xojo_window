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
      AllowInfiniteScroll=   False
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
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   391
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Type"
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
      Width           =   844
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ClipboardWatcher Watcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin OmniBar ModToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   844
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.ViewTitle = Self.mController.ModName
		  
		  Self.UpdatePublishButton()
		  Self.mController.LoadBlueprints()
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  Self.mController.Publish
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function ClipboardHasCodes() As Boolean
		  Var Board As New Clipboard
		  Return ClipboardHasCodes(Board)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ClipboardHasCodes(Board As Clipboard) As Boolean
		  If Not Board.TextAvailable Then
		    Return False
		  End If
		  
		  Var Content As String = Board.Text
		  Return Content.IndexOf("Blueprint") > -1 Or Content.IndexOf("giveitem") > -1 Or Content.IndexOf("spawndino") > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As BlueprintController)
		  AddHandler Controller.BlueprintsLoaded, WeakAddressOf mController_BlueprintsLoaded
		  AddHandler Controller.PublishFinished, WeakAddressOf mController_PublishFinished
		  AddHandler Controller.WorkStarted, WeakAddressOf mController_WorkStarted
		  AddHandler Controller.WorkFinished, WeakAddressOf mController_WorkFinished
		  
		  Self.mController = Controller
		  Self.ViewID = Controller.ModID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Export()
		  Var Dialog As New SaveFileDialog
		  Dialog.SuggestedFileName = "Exported Blueprints.json"
		  Dialog.Filter = BeaconFileTypes.JsonFile
		  
		  Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Var Packed() As Dictionary
		  Var SelectAll As Boolean = Self.BlueprintList.SelectedRowCount = 0
		  For Idx As Integer = 0 To Self.BlueprintList.LastRowIndex
		    If SelectAll Or Self.BlueprintList.Selected(Idx) Then
		      Var ObjectID As String = Self.BlueprintList.RowTagAt(Idx)
		      Var Blueprint As Beacon.Blueprint = Self.mController.Blueprint(ObjectID)
		      If Blueprint Is Nil Then
		        Continue
		      End If
		      
		      Packed.Add(Blueprint.Pack)
		    End If
		  Next
		  
		  Var JSON As String
		  Try
		    JSON = Beacon.GenerateJSON(Packed, True)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Could not export blueprints", "There was an error while generating the JSON content: " + Err.Message)
		    Return
		  End Try
		  
		  If Not File.Write(JSON) Then
		    Self.ShowAlert("Could not export blueprints", "Beacon was unable to save the JSON file to disk.")
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Import(Contents As String)
		  If Not Self.ImportAsJSON(Contents) Then
		    Self.ImportAsPlain(Contents)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportAsJSON(Contents As String) As Boolean
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Contents)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Var Dictionaries() As Variant
		  Try
		    Dictionaries = Parsed
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Var Blueprints() As Beacon.Blueprint
		  For Idx As Integer = 0 To Dictionaries.LastIndex
		    Try
		      Var Dict As Dictionary = Dictionaries(Idx)
		      Var Blueprint As Beacon.Blueprint = Beacon.UnpackBlueprint(Dict)
		      If (Blueprint Is Nil) = False Then
		        Blueprints.Add(Blueprint)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  If Blueprints.Count = 0 Then
		    Self.ShowAlert("Importing Has Finished", "Beacon did not find any blueprints to import.")
		    Return True // It was still JSON data, even if nothing was found.
		  End If
		  
		  Self.mController.SaveBlueprints(Blueprints)
		  Self.UpdateList(Blueprints)
		  Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(Blueprints.Count, "blueprint", "blueprints") + " to import.")
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportAsPlain(Contents As String)
		  Var Searcher As New Beacon.EngramSearcherThread
		  AddHandler Searcher.Started, WeakAddressOf Searcher_Started
		  AddHandler Searcher.Finished, WeakAddressOf Searcher_Finished
		  Searcher.Search(Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromClipboard()
		  Var Board As New Clipboard
		  
		  If Not Self.ClipboardHasCodes(Board) Then
		    Return
		  End If
		  
		  Self.Import(Board.Text)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromFile()
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.Text + BeaconFileTypes.CSVFile
		  
		  Var File As FolderItem = Dialog.ShowModalWithin(Parent.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Var Contents As String
		  Try
		    Contents = File.Read
		  Catch Err As RuntimeException
		    Self.ShowAlert("Could not open file", "Beacon was unable to open the selected file: " + Err.Message)
		    Return
		  End Try
		  
		  Self.Import(Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromURL()
		  Var Contents As String = LibraryEngramsURLDialog.Present(Self)
		  If Contents.IsEmpty Then
		    Return
		  End If
		  
		  Self.Import(Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_BlueprintsLoaded(Sender As BlueprintController)
		  #Pragma Unused Sender
		  
		  Self.UpdateList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_PublishFinished(Sender As BlueprintController, Success As Boolean, Reason As String)
		  If Success Then
		    Self.mController.LoadBlueprints()
		  Else
		    Self.UpdatePublishButton()
		  End If
		  
		  If Sender.AutoPublish = False Then
		    If Success Then
		      Self.ShowAlert("Your changes have been published.", "Because Beacon generates new update files every 15 minutes, it may take some time for the changes to be available to users.")
		    Else
		      Self.ShowAlert("Beacon was unable to publish the requested changes.", Reason)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkFinished(Sender As BlueprintController)
		  Self.Progress = Self.ProgressNone
		  
		  If Sender.CacheErrored Then
		    Self.ShowAlert("There was an error loading the blueprints.", Sender.CacheErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkStarted(Sender As BlueprintController)
		  #Pragma Unused Sender
		  
		  Self.Progress = Self.ProgressIndeterminate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  Return Self.mController.ModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Searcher_Finished(Sender As Beacon.EngramSearcherThread)
		  Self.Progress = BeaconSubview.ProgressNone
		  
		  Var Blueprints() As Beacon.Blueprint = Sender.Blueprints(True)
		  If Blueprints.Count = 0 Then
		    Self.ShowAlert("Importing Has Finished", "Beacon did not find any blueprints to import.")
		    Return
		  End If
		  Self.mController.SaveBlueprints(Blueprints)
		  Self.UpdateList(Blueprints)
		  Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(Blueprints.Count, "blueprint", "blueprints") + " to import.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Searcher_Started(Sender As Beacon.EngramSearcherThread)
		  #Pragma Unused Sender
		  Self.Progress = BeaconSubview.ProgressIndeterminate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var SelectedBlueprints() As String
		  For Row As Integer = 0 To Self.BlueprintList.LastRowIndex
		    If Self.BlueprintList.Selected(Row) Then
		      SelectedBlueprints.Add(Self.BlueprintList.RowTagAt(Row))
		    End If
		  Next
		  
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected() As Beacon.Blueprint)
		  Var SelectedBlueprints() As String
		  For Each Blueprint As Beacon.Blueprint In Selected
		    SelectedBlueprints.Add(Blueprint.ObjectID)
		  Next
		  
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected As Beacon.Blueprint)
		  Var SelectedBlueprints() As String = Array(Selected.ObjectID)
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected() As String)
		  Var Blueprints() As Beacon.Blueprint = Self.mController.Blueprints
		  
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
		    Case IsA Beacon.LootSource
		      Type = "Loot Container"
		    End Select
		    
		    Self.BlueprintList.CellValueAt(Row, 0) = Blueprint.Label
		    Self.BlueprintList.CellValueAt(Row, 1) = Type
		    Self.BlueprintList.RowTagAt(Row) = ObjectID
		    Self.BlueprintList.Selected(Row) = Selected.IndexOf(ObjectID) > -1
		  Next
		  
		  Self.BlueprintList.SortingColumn = 0
		  Self.BlueprintList.Sort
		  If Self.BlueprintList.SelectedRowCount > 0 Then
		    Self.BlueprintList.EnsureSelectionIsVisible
		  End If
		  Self.BlueprintList.SelectionChangeBlocked = False
		  If (Self.ModToolbar.Item("ExportFile") Is Nil) = False Then
		    Self.ModToolbar.Item("ExportFile").Enabled = Self.BlueprintList.RowCount > 0
		  End If
		  
		  Self.UpdatePublishButton()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePublishButton()
		  Var PublishEnabled As Boolean = (Self.mController Is Nil) = False And Self.mController.HasUnpublishedChanges
		  If (Self.ModToolbar.Item("Publish") Is Nil) = False Then
		    Self.ModToolbar.Item("Publish").Enabled = PublishEnabled
		  End If
		  If (Self.ModToolbar.Item("Discard") Is Nil) = False Then
		    Self.ModToolbar.Item("Discard").Enabled = PublishEnabled
		  End If
		  Self.Changed = PublishEnabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewType(Plural As Boolean, Lowercase As Boolean) As String
		  If Plural Then
		    Return If(Lowercase, "mods", "Mods")
		  Else
		    Return If(Lowercase, "mod", "Mod")
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mController As BlueprintController
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
		  Return Me.SelectedRowCount > 0
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
		    
		    Blueprints.Add(Blueprint)
		  Next
		  
		  If Warn And Not Self.ShowDeleteConfirmation(Blueprints, "blueprint", "blueprints") Then
		    Return
		  End If
		  
		  Self.mController.DeleteBlueprints(Blueprints)
		  Self.UpdateList()
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
		    Self.UpdateList(Blueprint)
		  ElseIf Me.SelectedRowCount > 1 Then
		    Var Blueprints() As Beacon.Blueprint
		    For Row As Integer = 0 To Me.LastRowIndex
		      If Me.Selected(Row) Then
		        Blueprints.Add(Self.mController.Blueprint(Me.RowTagAt(Row).StringValue))
		      End If
		    Next
		    
		    Var ModifiedBlueprints() As Beacon.Blueprint = BlueprintMultiEditor.Present(Self, Blueprints)
		    If (ModifiedBlueprints Is Nil) = False Then
		      For Each Blueprint As Beacon.Blueprint In Blueprints
		        Self.mController.SaveBlueprint(Blueprint)
		      Next
		    End If
		    Self.UpdateList(ModifiedBlueprints)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Watcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  #Pragma Unused Content
		  
		  If (Self.ModToolbar.Item("ImportClipboard") Is Nil) = False Then
		    Self.ModToolbar.Item("ImportClipboard").Enabled = Self.ClipboardHasCodes
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateButton("AddBlueprint", "New Blueprint", IconToolbarAdd, "Create a new blueprint."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ImportFile", "Import File", IconToolbarFile, "Import blueprints from a file on your computer."))
		  Me.Append(OmniBarItem.CreateButton("ImportURL", "Import URL", IconToolbarLink, "Import blueprints from cheat codes on a website."))
		  Me.Append(OmniBarItem.CreateButton("ImportClipboard", "Import Copied", IconToolbarCopied, "Import blueprints from copied cheat codes.", Self.ClipboardHasCodes))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ExportFile", "Export", IconToolbarExport, "Export selected blueprints to a file on your computer."))
		  
		  If Self.mController.AutoPublish Then
		    Return
		  End If
		  
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateButton("Publish", "Publish", IconToolbarPublish, "Publish your changes to Beacon's users.", False))
		  Me.Append(OmniBarItem.CreateButton("Discard", "Revert", IconToolbarRevert, "Revert your changes.", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddBlueprint"
		    Var Blueprint As Beacon.Blueprint = BlueprintEditorDialog.Present(Self, Self.mController.ModID, Self.mController.ModName)
		    If (Blueprint Is Nil) = False Then
		      Self.mController.SaveBlueprint(Blueprint)
		      Self.UpdateList()
		    End If
		  Case "ImportFile"
		    Self.ImportFromFile()
		  Case "ImportURL"
		    Self.ImportFromURL()
		  Case "ImportClipboard"
		    Self.ImportFromClipboard()
		  Case "ExportFile"
		    Self.Export()
		  Case "Publish"
		    Self.mController.Publish()
		  Case "Discard"
		    Self.mController.DiscardChanges()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
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
