#tag DesktopWindow
Begin ModEditorView ArkModEditorView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
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
   Width           =   900
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
   Begin Ark.ModDiscoveryEngine DiscoveryEngine
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   432
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   900
      Begin OmniBarSeparator FilterSeparator
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   540
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   40
         Transparent     =   True
         Visible         =   True
         Width           =   360
      End
      Begin DelayedSearchField FilterField
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowRecentItems=   False
         AllowTabStop    =   True
         ClearMenuItemValue=   "Clear"
         DelayPeriod     =   250
         Enabled         =   True
         Height          =   22
         Hint            =   "Filter Engrams"
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   630
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumRecentItems=   -1
         PanelIndex      =   0
         RecentItemsValue=   "Recent Searches"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         Text            =   ""
         Tooltip         =   ""
         Top             =   10
         Transparent     =   False
         Visible         =   True
         Width           =   250
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin OmniBar TabsToolbar
         Alignment       =   1
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
         InitialParent   =   "Pages"
         Left            =   360
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
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   180
      End
      Begin OmniBar ButtonsToolbar
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
         InitialParent   =   "Pages"
         Left            =   0
         LeftPadding     =   -1
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         RightPadding    =   0
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   360
      End
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
         ColumnCount     =   3
         ColumnWidths    =   "*,*"
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
         HeadingIndex    =   0
         Height          =   360
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Name	Class String	Unlock String"
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   900
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin DesktopLabel DiscoveryStatusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   262
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Initializing"
         TextAlignment   =   2
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   190
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   375
      End
      Begin DesktopProgressBar DiscoveryStatusBar
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   262
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumValue    =   100
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         Tooltip         =   ""
         Top             =   222
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   375
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin StatusContainer Status
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         CenterCaption   =   ""
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   31
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LeftCaption     =   ""
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         RightCaption    =   ""
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   401
         Transparent     =   True
         Visible         =   True
         Width           =   900
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.ViewTitle = Self.mController.ContentPackName
		  Self.SwitchMode(Ark.BlueprintController.ModeEngrams)
		  Self.Status.RightCaption = Self.mController.ContentPackId
		  
		  If Self.mReadOnly Then
		    Self.Status.LeftCaption = "Read Only"
		    Self.BlueprintList.EditCaption = "View"
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Var Group As New ControlGroup(Self.DiscoveryStatusLabel, Self.DiscoveryStatusBar)
		  Group.Top = (Self.Height - Group.Height) / 2.5
		  Group.Left = (Self.Width - Group.Width) / 2
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShouldSave(CloseWhenFinished As Boolean)
		  Self.mCloseAfterPublish = CloseWhenFinished
		  Try
		    Self.mController.Publish
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Publishing blueprints")
		    If Self.mController.UseSaveTerminology Then
		      Self.ShowAlert("Could not save changes", Err.Message)
		    Else
		      Self.ShowAlert("Could not publish changes", Err.Message)
		    End If
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  RaiseEvent Shown(UserData)
		  Self.mHasBeenShown = True
		  Self.SwitchMode(Self.mMode)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BlueprintDictionary() As Dictionary
		  Return Self.mBlueprints(Self.mMode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BlueprintDictionary(Blueprint As Ark.Blueprint) As Dictionary
		  Return Self.BlueprintDictionary(Self.ModeForBlueprint(Blueprint))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BlueprintDictionary(Mode As Integer) As Dictionary
		  Return Self.mBlueprints(Mode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildRegEx(Pattern As String) As PCRE2CodeMBS
		  Try
		    Var Compiler As New PCRE2CompilerMBS
		    Compiler.Pattern = Pattern
		    Return Compiler.Compile
		  Catch Err As RuntimeException
		    Break
		  End Try
		End Function
	#tag EndMethod

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
		Sub Constructor(Controller As Ark.BlueprintController, ReadOnly As Boolean)
		  Self.mBlueprints.ResizeTo(Ark.BlueprintController.LastMode)
		  Self.mHasRequestedBlueprints.ResizeTo(Ark.BlueprintController.LastMode)
		  Self.mLoadTotals.ResizeTo(Ark.BlueprintController.LastMode)
		  For Idx As Integer = Ark.BlueprintController.FirstMode To Ark.BlueprintController.LastMode
		    Self.mBlueprints(Idx) = New Dictionary
		  Next
		  
		  AddHandler Controller.BlueprintsLoaded, WeakAddressOf mController_BlueprintsLoaded
		  AddHandler Controller.BlueprintsChanged, WeakAddressOf mController_BlueprintsChanged
		  AddHandler Controller.PublishFinished, WeakAddressOf mController_PublishFinished
		  AddHandler Controller.WorkStarted, WeakAddressOf mController_WorkStarted
		  AddHandler Controller.WorkFinished, WeakAddressOf mController_WorkFinished
		  
		  Self.mController = Controller
		  Self.ViewID = Controller.ContentPackId
		  Self.mReadOnly = ReadOnly
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mController.ContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DiscoveryCheckMod(WorkshopID As String) As Boolean
		  #Pragma Unused WorkshopId
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DiscoveryCompleted(DiscoveredMods() As Beacon.ContentPack)
		  #Pragma Unused DiscoveredMods
		  Self.UpdateList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Export()
		  Var ModeLabel As String
		  Select Case Self.mMode
		  Case Ark.BlueprintController.ModeEngrams
		    ModeLabel = "Engrams"
		  Case Ark.BlueprintController.ModeCreatures
		    ModeLabel = "Creatures"
		  Case Ark.BlueprintController.ModeLootDrops
		    ModeLabel = "Loot Drops"
		  Case Ark.BlueprintController.ModeSpawnPoints
		    ModeLabel = "Spawn Points"
		  End Select
		  
		  Var Dialog As New SaveFileDialog
		  Dialog.SuggestedFileName = Beacon.SanitizeFilename(Self.mController.ContentPackName) + " " + ModeLabel + Beacon.FileExtensionDelta
		  Dialog.Filter = BeaconFileTypes.BeaconData + BeaconFileTypes.CSVFile
		  
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
		    
		    Var Blueprint As Ark.Blueprint = Self.BlueprintList.RowTagAt(Idx)
		    Blueprints.Add(Blueprint)
		  Next
		  
		  If Blueprints.Count = 0 Then
		    Self.ShowAlert("Export failed", "There are no blueprints to export.")
		    Return
		  End If
		  
		  If File.Name.EndsWith(Beacon.FileExtensionDelta) Then
		    If Ark.BuildExport(Blueprints, File, True) = False Then
		      Self.ShowAlert("Export failed", "The selected " + If(SelectAll = False And Self.BlueprintList.SelectedRowCount = 1, "blueprint was", "blueprints were") + " not exported. Beacon's log files may have more information.")
		    End If
		  ElseIf File.Name.EndsWith(Beacon.FileExtensionCSV) Then
		    Var CSVContent As String = Ark.ExportToCSV(Blueprints)
		    If CSVContent.IsEmpty Then
		      Return
		    End If
		    
		    Try
		      File.Write(CSVContent)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Writing CSV to disk")
		      Self.ShowAlert("Export failed", "Writing the file to disk failed: " + Err.Message)
		    End Try
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
		  Self.mContentToImport = Contents.GuessEncoding("/script/")
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
		Private Sub mController_BlueprintsChanged(Sender As Ark.BlueprintController, BlueprintsSaved() As Ark.Blueprint, BlueprintsDeleted() As Ark.Blueprint)
		  #Pragma Unused Sender
		  
		  For Each Blueprint As Ark.Blueprint In BlueprintsDeleted
		    Var Mode As Integer = Self.ModeForBlueprint(Blueprint)
		    If Self.mBlueprints(Mode).HasKey(Blueprint.BlueprintId) Then
		      Self.mBlueprints(Mode).Remove(Blueprint.BlueprintId)
		    End If
		  Next
		  
		  For Each Blueprint As Ark.Blueprint In BlueprintsSaved
		    Var Mode As Integer = Self.ModeForBlueprint(Blueprint)
		    Self.mBlueprints(Mode).Value(Blueprint.BlueprintId) = Blueprint
		  Next
		  
		  Self.UpdateList(BlueprintsSaved, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_BlueprintsLoaded(Sender As Ark.BlueprintController, Task As Ark.BlueprintControllerFetchTask)
		  Var CurrentBlueprints As Dictionary = Self.BlueprintDictionary(Task.Mode)
		  Var Blueprints() As Ark.Blueprint = Task.Blueprints
		  For Idx As Integer = 0 To Blueprints.LastIndex
		    CurrentBlueprints.Value(Blueprints(Idx).BlueprintId) = Blueprints(Idx)
		  Next
		  
		  If Task.Page < Task.TotalPages Then
		    Self.mLoadTotals(Task.Mode) = Task.TotalResults
		    Sender.LoadBlueprints(Task.Mode, Task.Page + 1, Task.PageSize)
		  Else
		    Self.mLoadTotals(Task.Mode) = -1
		  End If
		  
		  Self.UpdateList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_PublishFinished(Sender As Ark.BlueprintController, Task As Ark.BlueprintControllerTaskGroup)
		  If Task.Errored Then
		    Self.UpdateUI()
		    
		    Var SaveOrPublish As String = If(Sender.UseSaveTerminology, "save", "publish")
		    If Task.ErrorCount = Task.Count Then
		      // All errored
		      Self.ShowAlert("Beacon was unable to " + SaveOrPublish + " your changes.", Task.ErrorMessage)
		    Else
		      // Some errored
		      Self.ShowAlert("Beacon was able to " + SaveOrPublish + " some of your changes, but there were errors.", Task.ErrorMessage)
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
		    Self.UpdateList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkFinished(Sender As Ark.BlueprintController)
		  #Pragma Unused Sender
		  Self.Progress = Self.ProgressNone
		  Self.UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkStarted(Sender As Ark.BlueprintController)
		  #Pragma Unused Sender
		  Self.UpdateUI
		  
		  Self.Progress = Self.ProgressIndeterminate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ModeForBlueprint(Blueprint As Ark.Blueprint) As Integer
		  If Blueprint Is Nil Then
		    Return Self.mMode
		  End If
		  
		  Select Case Blueprint
		  Case IsA Ark.Engram
		    Return Ark.BlueprintController.ModeEngrams
		  Case IsA Ark.Creature
		    Return Ark.BlueprintController.ModeCreatures
		  Case IsA Ark.LootContainer
		    Return Ark.BlueprintController.ModeLootDrops
		  Case IsA Ark.SpawnPoint
		    Return Ark.BlueprintController.ModeSpawnPoints
		  End Select
		  
		  Return Self.mMode
		End Function
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
		Private Sub Reload()
		  For Idx As Integer = Ark.BlueprintController.FirstMode To Ark.BlueprintController.LastMode
		    Self.mBlueprints(Idx) = New Dictionary
		    Self.mHasRequestedBlueprints(Idx) = False
		  Next
		  
		  Var Blueprints() As Ark.Blueprint = Self.mController.AllBlueprints()
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Var ModeDict As Dictionary = Self.BlueprintDictionary(Blueprint)
		    If (ModeDict Is Nil) = False Then
		      ModeDict.Value(Blueprint.BlueprintId) = Blueprint
		    End If
		  Next
		  
		  Self.SwitchMode(Self.mMode)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartDiscovery()
		  If Self.mController.IsBusy Then
		    Self.ShowAlert("The editor is currently busy", "Wait for the current task to complete before starting a mod discovery.")
		    Return
		  End If
		  
		  Var Settings As Ark.ModDiscoverySettings = ArkModDiscoveryDialog.Present(Self.TrueWindow, Self.mController.MarketplaceId)
		  If Settings Is Nil Then
		    Return
		  End If
		  
		  For Mode As Integer = Ark.BlueprintController.FirstMode To Ark.BlueprintController.LastMode
		    If Self.mHasRequestedBlueprints(Mode) = False Then
		      Self.mLoadTotals(Mode) = -2
		      Self.mController.LoadBlueprints(Mode, 1, Self.PageSize)
		      Self.mHasRequestedBlueprints(Mode) = True
		    End If
		  Next
		  
		  Var ModIds() As String = Settings.ModIds
		  Var ArkFolder As FolderItem = Settings.ArkFolder
		  Self.mDiscoveryShouldDelete = Settings.DeleteBlueprints
		  Try
		    Self.DiscoveryEngine.Start(ArkFolder, ModIds)
		  Catch Err As RuntimeException
		    If Err.Message.IsEmpty Then
		      Var ErrType As Introspection.TypeInfo = Introspection.GetType(Err)
		      Err.Message = "Unhandled " + ErrType.FullName
		    End If
		    Self.ShowAlert("Could not start mod discovery", Err.Message)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwitchMode(Mode As Integer, UpdateUI As Boolean = True)
		  Var EngramsButton As OmniBarItem = Self.TabsToolbar.Item("EngramsButton")
		  Var CreaturesButton As OmniBarItem = Self.TabsToolbar.Item("CreaturesButton")
		  Var LootDropsButton As OmniBarItem = Self.TabsToolbar.Item("LootDropsButton")
		  Var SpawnPointsButton As OmniBarItem = Self.TabsToolbar.Item("SpawnPointsButton")
		  Self.BlueprintList.ColumnCount = If(Mode = ArkSA.BlueprintController.ModeEngrams, 3, 2)
		  
		  If (EngramsButton Is Nil) = False Then
		    EngramsButton.Toggled = (Mode = Ark.BlueprintController.ModeEngrams)
		  End If
		  If (CreaturesButton Is Nil) = False Then
		    CreaturesButton.Toggled = (Mode = Ark.BlueprintController.ModeCreatures)
		  End If
		  If (LootDropsButton Is Nil) = False Then
		    LootDropsButton.Toggled = (Mode = Ark.BlueprintController.ModeLootDrops)
		  End If
		  If (SpawnPointsButton Is Nil) = False Then
		    SpawnPointsButton.Toggled = (Mode = Ark.BlueprintController.ModeSpawnPoints)
		  End If
		  
		  If Self.mHasRequestedBlueprints(Mode) = False Then
		    Self.mLoadTotals(Mode) = -2
		    Self.mController.LoadBlueprints(Mode, 1, Self.PageSize)
		    Self.mHasRequestedBlueprints(Mode) = True
		  End If
		  
		  Self.mMode = Mode
		  
		  If UpdateUI Then
		    Self.UpdateList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var List As BeaconListbox = Self.BlueprintList
		  Var SelectedBlueprintIds() As String
		  For RowIdx As Integer = 0 To List.LastRowIndex
		    If List.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Var Blueprint As Ark.Blueprint = List.RowTagAt(RowIdx)
		    SelectedBlueprintIds.Add(Blueprint.BlueprintId)
		  Next
		  Self.UpdateList(SelectedBlueprintIds, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectedBlueprints() As Ark.Blueprint, ScrollToSelection As Boolean)
		  Var SelectedBlueprintIds() As String
		  For Each Blueprint As Ark.Blueprint In SelectedBlueprints
		    SelectedBlueprintIds.Add(Blueprint.BlueprintId)
		  Next
		  Self.UpdateList(SelectedBlueprintIds, ScrollToSelection)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectedBlueprintIds() As String, ScrollToSelection As Boolean)
		  Var Blueprints As Dictionary = Self.BlueprintDictionary()
		  
		  Var List As BeaconListbox = Self.BlueprintList
		  Var ScrollPosition As Integer = List.ScrollPosition
		  List.SelectionChangeBlocked = True
		  
		  Var Filter As String = Self.FilterField.Text.Trim
		  Var Filtered As Boolean = Filter.IsEmpty = False
		  Var Rx As PCRE2CodeMBS
		  If Filtered Then
		    List.RemoveAllRows
		    
		    If Filter.BeginsWith("/") And Filter.EndsWith("/") Then
		      Rx = Self.BuildRegEx(Filter.Middle(1, Filter.Length - 2))
		    End If
		  Else
		    List.RowCount = Blueprints.KeyCount
		  End If
		  
		  Var BlueprintIds() As Variant = Blueprints.Keys
		  For Idx As Integer = 0 To BlueprintIds.LastIndex
		    Var BlueprintId As String = BlueprintIds(Idx)
		    Var Blueprint As Ark.Blueprint = Blueprints.Value(BlueprintId)
		    
		    Var RowIdx As Integer = Idx
		    If Filtered Then
		      If ((Rx Is Nil) = False And Blueprint.Matches(Rx) = False) Or (Rx Is Nil And Blueprint.Matches(Filter) = False) Then
		        Continue
		      End If
		      List.AddRow("")
		      RowIdx = List.LastAddedRowIndex
		    End If
		    
		    List.RowTagAt(RowIdx) = Blueprint
		    List.CellTextAt(RowIdx, 0) = Blueprint.Label
		    List.CellTextAt(RowIdx, 1) = Blueprint.ClassString
		    If Self.mMode = Ark.BlueprintController.ModeEngrams Then
		      If Blueprint IsA Ark.Engram Then
		        List.CellTextAt(RowIdx, 2) = Ark.Engram(Blueprint).EntryString
		      Else
		        List.CellTextAt(RowIdx, 2) = ""
		      End If
		    End If
		    List.RowSelectedAt(RowIdx) = SelectedBlueprintIds.IndexOf(BlueprintId) > -1
		  Next
		  
		  Self.BlueprintList.SizeColumnToFit(1)
		  If Self.mMode = ArkSA.BlueprintController.ModeEngrams Then
		    Self.BlueprintList.SizeColumnToFit(2)
		  End If
		  
		  List.Sort
		  List.ScrollPosition = ScrollPosition
		  List.SelectionChangeBlocked(False) = False
		  
		  If ScrollToSelection Then
		    List.EnsureSelectionIsVisible
		  End If
		  
		  Self.UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Var NounSingle, NounPlural As String
		  Select Case Self.mMode
		  Case Ark.BlueprintController.ModeEngrams
		    NounSingle = "engram"
		    NounPlural = "engrams"
		  Case Ark.BlueprintController.ModeCreatures
		    NounSingle = "creature"
		    NounPlural = "creatures"
		  Case Ark.BlueprintController.ModeLootDrops
		    NounSingle = "loot drop"
		    NounPlural = "loot drops"
		  Case Ark.BlueprintController.ModeSpawnPoints
		    NounSingle = "spawn point"
		    NounPlural = "spawn points"
		  End Select
		  Self.FilterField.Hint = "Filter " + NounPlural.Titlecase
		  
		  Var TotalResults As Integer = Self.mLoadTotals(Self.mMode)
		  If TotalResults = -1 Then
		    TotalResults = Self.BlueprintList.RowCount
		  ElseIf TotalResults = -2 Then
		    Self.Status.CenterCaption = "Loading " + NounPlural + "…"
		    Return
		  End If
		  
		  Var Status As String = Self.BlueprintList.StatusMessage(NounSingle, NounPlural)
		  If Self.BlueprintList.RowCount < TotalResults Then
		    // Partial results
		    Status = Status + " (" + Self.BlueprintList.RowCount.ToString(Locale.Current, "#,##0") + " loaded)"
		  End If
		  Self.Status.CenterCaption = Status
		  
		  Var PublishEnabled As Boolean = Self.mReadOnly = False And (Self.mController Is Nil) = False And Self.mController.HasUnpublishedChanges
		  If (Self.ButtonsToolbar.Item("Publish") Is Nil) = False Then
		    Self.ButtonsToolbar.Item("Publish").Enabled = PublishEnabled
		  End If
		  If (Self.ButtonsToolbar.Item("Discard") Is Nil) = False Then
		    Self.ButtonsToolbar.Item("Discard").Enabled = PublishEnabled
		  End If
		  Self.Modified = PublishEnabled
		  
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
		Private mBlueprints() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCloseAfterPublish As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentToImport As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As Ark.BlueprintController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDiscoveryShouldDelete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasBeenShown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasRequestedBlueprints() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImporter As Ark.BlueprintImporter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoadRequestToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoadTotals() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReadOnly As Boolean
	#tag EndProperty


	#tag Constant, Name = PageSize, Type = Double, Dynamic = False, Default = \"100", Scope = Private
	#tag EndConstant


#tag EndWindowCode

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
		        ElseIf Self.mImporter.ModCount < 2 Then
		          // Just import what was found
		          Var FoundBlueprints() As Ark.Blueprint = Self.mImporter.Blueprints
		          Try
		            Self.mController.SaveBlueprints(FoundBlueprints)
		            Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(FoundBlueprints.Count, "blueprint", "blueprints") + " to import.")
		          Catch Err As RuntimeException
		            App.Log(Err, CurrentMethodName, "Saving imported blueprints")
		            Self.ShowAlert("Could not save imported blueprints", Err.Message)
		          End Try
		        Else
		          // Show a prompt
		          Var ChosenTags() As String = ArkSelectModPrefixDialog.Present(Self, Self.mImporter)
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
		            
		            Try
		              Self.mController.SaveBlueprints(ChosenBlueprints)
		              Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(ChosenBlueprints.Count, "blueprint", "blueprints") + " to import.")
		            Catch Err As RuntimeException
		              App.Log(Err, CurrentMethodName, "Saving imported blueprints")
		              Self.ShowAlert("Could not save imported blueprints", Err.Message)
		            End Try
		          End If
		        End If
		      End If
		      
		      Self.mImporter = Nil
		    End Select
		  Next Dict
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DiscoveryEngine
	#tag Event
		Sub Error(ErrorMessage As String)
		  Self.ShowAlert("There was an error with mod discovery", ErrorMessage)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished()
		  Self.Pages.SelectedPanelIndex = 0
		  Self.Reload
		  Self.UpdateUI
		End Sub
	#tag EndEvent
	#tag Event
		Sub Import(LogContents As String)
		  Var Importer As Ark.BlueprintImporter = Ark.BlueprintImporter.ImportAsDataDumper(LogContents)
		  If Importer Is Nil Or Importer.BlueprintCount = 0 Then
		    Return
		  End If
		  
		  // Wait for the controller to be finished
		  While Self.mController.IsBusy
		    Thread.Current.Sleep(100)
		  Wend
		  
		  Var CurrentBlueprints() As Ark.Blueprint = Self.mController.AllBlueprints
		  Var CurrentBlueprintMap As New Dictionary
		  For Each Blueprint As Ark.Blueprint In CurrentBlueprints
		    CurrentBlueprintMap.Value(Blueprint.Path) = Blueprint
		  Next
		  
		  Var PathPrefix As String = "/Game/Mods/" + Me.GetTagForModId(Self.mController.MarketplaceId) + "/"
		  Var Blueprints() As Ark.Blueprint = Importer.Blueprints
		  Var NewBlueprints() As Ark.Blueprint
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Try
		      Var Path As String = Blueprint.Path
		      If Path.BeginsWith(PathPrefix) = False Then
		        Continue
		      End If
		      
		      Var OriginalBlueprint As Ark.Blueprint
		      If CurrentBlueprintMap.HasKey(Path) Then
		        OriginalBlueprint = CurrentBlueprintMap.Value(Path)
		        CurrentBlueprintMap.Remove(Path)
		      End If
		      
		      Var Mutable As Ark.MutableBlueprint
		      If (OriginalBlueprint Is Nil) = False Then
		        Mutable = OriginalBlueprint.MutableVersion
		        If Mutable.CopyFrom(Blueprint) = False Then
		          Continue
		        End If
		        Mutable.BlueprintId = OriginalBlueprint.BlueprintId
		        Mutable.ContentPackName = Self.mController.ContentPackId
		        Mutable.ContentPackId = Self.mController.ContentPackName
		      Else
		        Mutable = Blueprint.MutableVersion
		        Mutable.ContentPackName = Self.mController.ContentPackId
		        Mutable.ContentPackId = Self.mController.ContentPackName
		        Mutable.RegenerateBlueprintId()
		      End If
		      NewBlueprints.Add(Mutable)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Preparing blueprint to save")
		    End Try
		  Next
		  Self.mController.SaveBlueprints(NewBlueprints)
		  
		  If Self.mDiscoveryShouldDelete Then
		    Var DeleteBlueprints() As Ark.Blueprint
		    Var DeleteBlueprintIds As New Dictionary
		    For Each Entry As DictionaryEntry In CurrentBlueprintMap
		      DeleteBlueprints.Add(Ark.Blueprint(Entry.Value))
		      DeleteBlueprintIds.Value(Ark.Blueprint(Entry.Value).BlueprintId) = True
		    Next
		    Self.mController.DeleteBlueprints(DeleteBlueprints)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.DiscoveryStatusLabel.Text = Me.StatusMessage
		  Self.Pages.SelectedPanelIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub StatusUpdated()
		  Self.DiscoveryStatusLabel.Text = Me.StatusMessage
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TabsToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateTab("EngramsButton", "Engrams"))
		  Me.Append(OmniBarItem.CreateTab("CreaturesButton", "Creatures"))
		  Me.Append(OmniBarItem.CreateTab("LootDropsButton", "Loot Drops"))
		  Me.Append(OmniBarItem.CreateTab("SpawnPointsButton", "Spawn Points"))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  
		  Me.Item("EngramsButton").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Self.BlueprintList.ScrollPosition = 0
		  Select Case Item.Name
		  Case "EngramsButton"
		    Self.SwitchMode(Ark.BlueprintController.ModeEngrams)
		  Case "CreaturesButton"
		    Self.SwitchMode(Ark.BlueprintController.ModeCreatures)
		  Case "LootDropsButton"
		    Self.SwitchMode(Ark.BlueprintController.ModeLootDrops)
		  Case "SpawnPointsButton"
		    Self.SwitchMode(Ark.BlueprintController.ModeSpawnPoints)
		  End Select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonsToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("AddBlueprint", "New Blueprint", IconToolbarAdd, "Create a new blueprint.", Not Self.mReadOnly))
		  Me.Append(OmniBarItem.CreateSeparator)
		  If Self.mController.UseSaveTerminology Then
		    Me.Append(OmniBarItem.CreateButton("Publish", "Save", IconToolbarSaveToDisk, "Save your changes.", False))
		  Else
		    Me.Append(OmniBarItem.CreateButton("Publish", "Publish", IconToolbarPublish, "Publish your changes to Beacon's users.", False))
		  End If
		  Me.Append(OmniBarItem.CreateButton("Discard", "Revert", IconToolbarRevert, "Revert your changes.", False))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("Import", "Import", IconToolbarImport, "Import blueprints from a file, url, or your " + Language.Clipboard.Lowercase + ".", Not Self.mReadOnly))
		  Me.Append(OmniBarItem.CreateButton("ExportFile", "Export", IconToolbarExport, "Export selected blueprints to a file on your computer."))
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "AddBlueprint"
		    Var Blueprint As Ark.Blueprint = ArkBlueprintEditorDialog.Present(Self, Self.mController.ContentPackId, Self.mController.ContentPackName)
		    If (Blueprint Is Nil) = False Then
		      Try
		        Self.mController.SaveBlueprint(Blueprint)
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Saving new blueprint")
		        Self.ShowAlert("Could not save blueprint", Err.Message)
		        Return
		      End Try
		      
		      Var DesiredMode As Integer = Self.ModeForBlueprint(Blueprint)
		      If DesiredMode <> Self.mMode Then
		        Self.SwitchMode(DesiredMode)
		      End If
		    End If
		  Case "Import"
		    Var ImportFileItem As New DesktopMenuItem("Import From File")
		    Var ImportUrlItem As New DesktopMenuItem("Import From URL")
		    Var ImportClipboardItem As New DesktopMenuItem("Import From " + Language.Clipboard)
		    Var DiscoverItem As DesktopMenuItem
		    ImportClipboardItem.Enabled = Self.ClipboardHasCodes
		    
		    Var ImportMenu As New DesktopMenuItem
		    ImportMenu.AddMenu(ImportFileItem)
		    ImportMenu.AddMenu(ImportUrlItem)
		    ImportMenu.AddMenu(ImportClipboardItem)
		    
		    #if TargetWindows
		      ImportMenu.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		      
		      DiscoverItem = New DesktopMenuItem("Run Mod Discovery")
		      DiscoverItem.Enabled = Self.mController.Marketplace = Beacon.MarketplaceSteamWorkshop And Self.mController.MarketplaceId.IsEmpty = False
		      ImportMenu.AddMenu(DiscoverItem)
		    #endif
		    
		    Var Position As Point = Me.GlobalPosition
		    Var Choice As DesktopMenuItem = ImportMenu.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		    If (Choice Is Nil) = False Then
		      Select Case Choice
		      Case ImportFileItem
		        Self.ImportFromFile()
		      Case ImportUrlItem
		        Self.ImportFromURL()
		      Case ImportClipboardItem
		        Self.ImportFromClipboard()
		      Case DiscoverItem
		        #if TargetWindows
		          Self.StartDiscovery()
		        #endif
		      End Select
		    End If
		  Case "ExportFile"
		    Self.Export()
		  Case "Publish"
		    Try
		      Self.mController.Publish()
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Publishing changes")
		      If Self.mController.UseSaveTerminology Then
		        Self.ShowAlert("Could not save changes", Err.Message)
		      Else
		        Self.ShowAlert("Could not publish changes", Err.Message)
		      End If
		      Return
		    End Try
		  Case "Discard"
		    Try
		      Self.mController.DiscardChanges()
		      Self.Reload()
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reverting changes")
		      Self.ShowAlert("Could not revert changes", Err.Message)
		      Return
		    End Try
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BlueprintList
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.mReadOnly = False
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Self.mController Is Nil Or Me.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var Blueprints() As Ark.Blueprint
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Not Me.RowSelectedAt(Row) Then
		      Continue
		    End If
		    
		    Var Blueprint As Ark.Blueprint = Me.RowTagAt(Row)
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    Blueprints.Add(Blueprint)
		  Next
		  
		  If Blueprints.Count = 0 Then
		    Return
		  End If
		  
		  If Warn And Not Self.ShowDeleteConfirmation(Blueprints, "blueprint", "blueprints") Then
		    Return
		  End If
		  
		  Try
		    Self.mController.DeleteBlueprints(Blueprints)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Deleting blueprints")
		    Self.ShowAlert("Could not delete " + Language.NounWithQuantity(Blueprints.Count, "blueprint", "blueprints"), Err.Message)
		    Return
		  End Try
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  If Self.mController Is Nil Then
		    Return
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Var RowIdx As Integer = Me.SelectedRowIndex
		    Var Blueprint As Ark.Blueprint = Me.RowTagAt(RowIdx)
		    If Blueprint Is Nil Then
		      Return
		    End If
		    
		    Blueprint = ArkBlueprintEditorDialog.Present(Self, Blueprint, Self.mReadOnly)
		    If Blueprint Is Nil Then
		      Return
		    End If
		    
		    Try
		      Self.mController.SaveBlueprint(Blueprint)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Saving edited blueprint")
		      Self.ShowAlert("Could not save blueprint", Err.Message)
		      Return
		    End Try
		    
		    Var CurrentBlueprints As Dictionary = Self.BlueprintDictionary(Blueprint)
		    CurrentBlueprints.Value(Blueprint.BlueprintId) = Blueprint
		    
		    Var BlueprintIds(0) As String
		    BlueprintIds(0) = Blueprint.BlueprintId
		    Self.UpdateList(BlueprintIds, True)
		  ElseIf Me.SelectedRowCount > 1 And Self.mReadOnly = False Then
		    Var Blueprints() As Ark.Blueprint
		    Var Indexes As New Dictionary
		    For Row As Integer = 0 To Me.LastRowIndex
		      If Me.RowSelectedAt(Row) = False Then
		        Continue
		      End If
		      
		      Var Blueprint As Ark.Blueprint = Me.RowTagAt(Row)
		      Indexes.Value(Blueprint.BlueprintId) = Row
		      Blueprints.Add(Blueprint)
		    Next
		    
		    Var ModifiedBlueprints() As Ark.Blueprint = ArkBlueprintMultiEditor.Present(Self, Blueprints)
		    If ModifiedBlueprints Is Nil Or ModifiedBlueprints.Count = 0 Then
		      Return
		    End If
		    
		    Try
		      Self.mController.SaveBlueprints(ModifiedBlueprints)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Saving edited blueprints")
		      Self.ShowAlert("Could not save blueprints", Err.Message)
		      Return
		    End Try
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateUI()
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
