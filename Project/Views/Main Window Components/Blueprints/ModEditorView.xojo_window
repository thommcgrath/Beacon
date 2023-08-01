#tag DesktopWindow
Begin BeaconSubview ModEditorView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   432
   Index           =   -2147483648
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
      AllowInfiniteScroll=   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "*,120"
      DefaultRowHeight=   -1
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   360
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
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
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
      BackgroundColor =   ""
      ContentHeight   =   0
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
   Begin Thread ImporterThread
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
   Begin DesktopLabel StatusLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Loading Blueprints"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   407
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   804
   End
   Begin FadedSeparator StatusSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   401
      Transparent     =   True
      Visible         =   True
      Width           =   844
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.ViewTitle = Self.mController.ContentPackName
		  
		  Self.UpdatePublishButton()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShouldSave(CloseWhenFinished As Boolean)
		  Self.mCloseAfterPublish = CloseWhenFinished
		  Self.mController.Publish
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  
		  If Self.mHasBeenShown = False Then
		    Self.BlueprintList.ScrollPosition = 0
		    Self.BlueprintList.RemoveAllRows
		  End If
		  
		  Self.mHasBeenShown = True
		End Sub
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
		  Self.ViewID = Controller.ContentPackId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mController.ContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Export()
		  Var Dialog As New SaveFileDialog
		  Dialog.SuggestedFileName = Beacon.SanitizeFilename(Self.mController.ContentPackName) + Beacon.FileExtensionDelta
		  Dialog.Filter = BeaconFileTypes.BeaconData
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Var Blueprints() As Ark.Blueprint
		  Var SelectAll As Boolean = Self.BlueprintList.SelectedRowCount = 0
		  For Idx As Integer = 0 To Self.BlueprintList.LastRowIndex
		    If SelectAll = False And Self.BlueprintList.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var BlueprintId As String = Self.BlueprintList.RowTagAt(Idx)
		    Blueprints.Add(Self.mController.Blueprint(BlueprintId))
		  Next
		  
		  If Ark.BuildExport(Blueprints, File) = False Then
		    Self.ShowAlert("Export failed", "The selected " + If(SelectAll = False And Self.BlueprintList.SelectedRowCount = 1, "blueprint was", "blueprints were") + " not exported. Beacon's log files may have more information.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasModifications() As Boolean
		  Return Self.mController.HasUnpublishedChanges
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Import(Contents As String)
		  If Self.ImporterThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Return
		  End If
		  
		  Self.mProgress = New ProgressWindow("Importing blueprints…", "Getting started…")
		  Self.mProgress.ShowDelayed(Self.TrueWindow)
		  
		  Self.mImporter = Nil
		  Self.mContentToImport = Contents.GuessEncoding
		  Self.ImporterThread.Start
		  
		  Self.Progress = BeaconSubview.ProgressIndeterminate
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
		  Dialog.Filter = BeaconFileTypes.BeaconData + BeaconFileTypes.JsonFile + BeaconFileTypes.Text + BeaconFileTypes.CSVFile
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
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
		  If Success = False Then
		    Self.UpdatePublishButton()
		    
		    If Sender.UseSaveTerminology Then
		      Self.ShowAlert("Beacon was unable to save the changes.", Reason)
		    Else
		      Self.ShowAlert("Beacon was unable to publish the requested changes.", Reason)
		    End If
		    
		    Return
		  End If
		  
		  Self.Modified = False
		  
		  If Sender.UseSaveTerminology = False Then
		    Self.ShowAlert("Your changes have been published.", "Because Beacon generates new update files every 15 minutes, it may take some time for the changes to be available to users.")
		  End If
		  
		  // No reason to load the blueprints if we're about to close
		  If Self.mCloseAfterPublish Then
		    Self.RequestClose()
		  Else
		    Self.BlueprintList.RemoveAllRows
		    Self.BlueprintList.ScrollPosition = 0
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkFinished(Sender As BlueprintController)
		  Self.Progress = Self.ProgressNone
		  Self.UpdateUI
		  
		  If Sender.CacheErrored Then
		    Self.ShowAlert("There was an error loading the blueprints.", Sender.CacheErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkStarted(Sender As BlueprintController)
		  #Pragma Unused Sender
		  Self.UpdateUI
		  
		  Self.Progress = Self.ProgressIndeterminate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseDataDumperLine(Line As String) As Dictionary
		  Var Values As New Dictionary
		  Var Offset As Integer
		  While Offset > -1
		    Var KeyStartPos As Integer = Line.IndexOf(Offset, "{")
		    If KeyStartPos = -1 Then
		      Return Values
		    End If
		    KeyStartPos = KeyStartPos + 1
		    
		    Var KeyEndPos As Integer = Line.IndexOf(KeyStartPos, "}")
		    Var Key As String = Line.Middle(KeyStartPos, KeyEndPos - KeyStartPos)
		    
		    Var ValueStartPos As Integer = KeyEndPos + 1
		    Var ValueEndPos As Integer = Line.IndexOf(ValueStartPos, "{")
		    Var Value As String
		    If ValueEndPos = -1 Then
		      Value = Line.Middle(ValueStartPos)
		      Offset = Line.Length
		    Else
		      Value = Line.Middle(ValueStartPos, ValueEndPos - ValueStartPos)
		      Offset = ValueEndPos
		    End If
		    
		    Values.Value(Key) = Value
		  Wend
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var SelectedBlueprints() As String
		  For Row As Integer = 0 To Self.BlueprintList.LastRowIndex
		    If Self.BlueprintList.RowSelectedAt(Row) Then
		      SelectedBlueprints.Add(Self.BlueprintList.RowTagAt(Row))
		    End If
		  Next
		  
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected() As Ark.Blueprint)
		  Var SelectedBlueprints() As String
		  For Each Blueprint As Ark.Blueprint In Selected
		    SelectedBlueprints.Add(Blueprint.BlueprintId)
		  Next
		  
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected As Ark.Blueprint)
		  Var SelectedBlueprints() As String = Array(Selected.BlueprintId)
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected() As String)
		  Var Blueprints() As Ark.Blueprint = Self.mController.Blueprints
		  
		  Self.BlueprintList.SelectionChangeBlocked = True
		  Self.BlueprintList.RowCount = Blueprints.Count
		  
		  For Row As Integer = 0 To Self.BlueprintList.LastRowIndex
		    Var Blueprint As Ark.Blueprint = Blueprints(Row)
		    Var ObjectID As String = Blueprint.BlueprintId
		    
		    Var Type As String = "Blueprint"
		    Select Case Blueprint
		    Case IsA Ark.Engram
		      Type = "Engram"
		    Case IsA Ark.Creature
		      Type = "Creature"
		    Case IsA Ark.SpawnPoint
		      Type = "Spawn"
		    Case IsA Ark.LootContainer
		      Type = "Loot Drop"
		    End Select
		    
		    Self.BlueprintList.CellTextAt(Row, 0) = Blueprint.Label
		    Self.BlueprintList.CellTextAt(Row, 1) = Type
		    Self.BlueprintList.RowTagAt(Row) = ObjectID
		    Self.BlueprintList.RowSelectedAt(Row) = Selected.IndexOf(ObjectID) > -1
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
		  Self.Modified = PublishEnabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Var Status As String
		  If Self.BlueprintList.SelectedRowCount > 0 Then
		    Status = Self.BlueprintList.SelectedRowCount.ToString(Locale.Current, "#,##0") + " of " + Language.NounWithQuantity(Self.mController.BlueprintCount, "blueprint", "blueprints") + " selected"
		  Else
		    Status = Language.NounWithQuantity(Self.mController.BlueprintCount, "blueprint", "blueprints")
		  End If
		  If Self.StatusLabel.Text <> Status Then
		    Self.StatusLabel.Text = Status
		  End If
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


	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCloseAfterPublish As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentToImport As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As BlueprintController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasBeenShown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImporter As Ark.BlueprintImporter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressWindow
	#tag EndProperty


#tag EndWindowCode

#tag Events BlueprintList
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(1) = DesktopListbox.Alignments.Right
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
		  
		  Var Blueprints() As Ark.Blueprint
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Not Me.RowSelectedAt(Row) Then
		      Continue
		    End If
		    
		    Var ObjectID As String = Me.RowTagAt(Row)
		    Var Blueprint As Ark.Blueprint = Self.mController.Blueprint(ObjectID)
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
		    Var Blueprint As Ark.Blueprint = Self.mController.Blueprint(ObjectID)
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
		    Var Blueprints() As Ark.Blueprint
		    For Row As Integer = 0 To Me.LastRowIndex
		      If Me.RowSelectedAt(Row) Then
		        Blueprints.Add(Self.mController.Blueprint(Me.RowTagAt(Row).StringValue))
		      End If
		    Next
		    
		    Var ModifiedBlueprints() As Ark.Blueprint = BlueprintMultiEditor.Present(Self, Blueprints)
		    If (ModifiedBlueprints Is Nil) = False Then
		      For Each Blueprint As Ark.Blueprint In ModifiedBlueprints
		        Self.mController.SaveBlueprint(Blueprint)
		      Next
		    End If
		    Self.UpdateList(ModifiedBlueprints)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub LoadMoreRows(Page As Integer)
		  If Self.mHasBeenShown = False Then
		    Return
		  End If
		  
		  Self.mController.LoadBlueprints(Page, Me.PageSize)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateUI()
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
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("AddBlueprint", "New Blueprint", IconToolbarAdd, "Create a new blueprint."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  If Self.mController.UseSaveTerminology Then
		    Me.Append(OmniBarItem.CreateButton("Publish", "Save", IconToolbarSaveToDisk, "Save your changes.", False))
		  Else
		    Me.Append(OmniBarItem.CreateButton("Publish", "Publish", IconToolbarPublish, "Publish your changes to Beacon's users.", False))
		  End If
		  Me.Append(OmniBarItem.CreateButton("Discard", "Revert", IconToolbarRevert, "Revert your changes.", False))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ImportFile", "Import File", IconToolbarFile, "Import blueprints from a file on your computer."))
		  Me.Append(OmniBarItem.CreateButton("ImportURL", "Import URL", IconToolbarLink, "Import blueprints from cheat codes on a website."))
		  Me.Append(OmniBarItem.CreateButton("ImportClipboard", "Import Copied", IconToolbarCopied, "Import blueprints from copied cheat codes.", Self.ClipboardHasCodes))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ExportFile", "Export", IconToolbarExport, "Export selected blueprints to a file on your computer."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddBlueprint"
		    Var Blueprint As Ark.Blueprint = BlueprintEditorDialog.Present(Self, Self.mController.ContentPackId, Self.mController.ContentPackName)
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
#tag Events ImporterThread
	#tag Event
		Sub Run()
		  Self.mImporter = Ark.BlueprintImporter.Import(Self.mContentToImport, Self.mProgress)
		  
		  Var Dict As New Dictionary
		  Dict.Value("Action") = "Finished"
		  Me.AddUserInterfaceUpdate(Dict)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    Var Action As String = Dict.Lookup("Action", "").StringValue
		    Select Case Action
		    Case "Finished"
		      Var Cancelled As Boolean = Self.mProgress.CancelPressed
		      Self.mProgress.Close
		      Self.mProgress = Nil
		      
		      Self.Progress = BeaconSubview.ProgressNone
		      
		      If Cancelled = False Then
		        If Self.mImporter Is Nil Or Self.mImporter.BlueprintCount = 0 Then
		          Self.ShowAlert("Importing Has Finished", "Beacon did not find any blueprints to import.")
		        ElseIf Self.mImporter.ModCount = 1 Then
		          // Just import what was found
		          Var FoundBlueprints() As Ark.Blueprint = Self.mImporter.Blueprints
		          Self.mController.SaveBlueprints(FoundBlueprints)
		          Self.UpdateList(FoundBlueprints)
		          Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(FoundBlueprints.Count, "blueprint", "blueprints") + " to import.")
		        Else
		          // Show a prompt
		          Var ChosenTags() As String = SelectModPrefixDialog.Present(Self, Self.mImporter)
		          If ChosenTags.Count > 0 Then
		            Var ChosenBlueprints() As Ark.Blueprint
		            Var FoundBlueprints() As Ark.Blueprint = Self.mImporter.Blueprints
		            For Each Tag As String In ChosenTags
		              Var Prefix As String = "/Game/Mods/" + Tag + "/"
		              For Each Blueprint As Ark.Blueprint In FoundBlueprints
		                If Blueprint.Path.BeginsWith(Prefix) = False Then
		                  Continue
		                End If
		                
		                ChosenBlueprints.Add(Blueprint)
		              Next Blueprint
		            Next Tag
		            
		            Self.mController.SaveBlueprints(ChosenBlueprints)
		            Self.UpdateList(ChosenBlueprints)
		            Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(ChosenBlueprints.Count, "blueprint", "blueprints") + " to import.")
		          End If
		        End If
		      End If
		      
		      Self.mImporter = Nil
		    End Select
		  Next Dict
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
