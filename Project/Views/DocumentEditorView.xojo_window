#tag Window
Begin BeaconSubview DocumentEditorView Implements ObservationKit.Observer,NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   528
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
   Width           =   858
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   478
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   231
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      Top             =   50
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   627
      Begin Canvas OmniNoticeBanner
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   31
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   231
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   50
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   False
         Width           =   627
      End
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "There was an error loading the editor"
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   478
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   231
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   50
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   627
      End
   End
   Begin HelpDrawer HelpDrawer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Body            =   ""
      Borders         =   8
      ContentHeight   =   0
      DetailURL       =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   478
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   858
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Title           =   ""
      Top             =   50
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   False
      Width           =   300
   End
   Begin Timer AutosaveTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   60000
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin FadedSeparator SourceSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   478
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   230
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   50
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin OmniBar OmniBar1
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   50
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   858
   End
   Begin SourceList ConfigList
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
      Height          =   437
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   91
      Transparent     =   True
      Visible         =   True
      Width           =   230
   End
   Begin ControlCanvas ConfigSetPicker
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   50
      Transparent     =   True
      Visible         =   True
      Width           =   230
   End
   Begin FadedSeparator FadedSeparator2
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   90
      Transparent     =   True
      Visible         =   True
      Width           =   230
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Activate()
		  Self.Changed = Self.Document.Modified
		End Sub
	#tag EndEvent

	#tag Event
		Sub CleanupDiscardedChanges()
		  Self.CleanupAutosave()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged, Self.Notification_SwitchEditors)
		  
		  If Self.mController.Document <> Nil Then
		    Self.mController.Document.RemoveObserver(Self, "Title")
		  End If
		  
		  If Self.mImportWindowRef <> Nil And Self.mImportWindowRef.Value <> Nil Then
		    DocumentImportWindow(Self.mImportWindowRef.Value).Cancel
		    Self.mImportWindowRef = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileSaveAs.Enable
		  
		  If Self.ReadyToDeploy Then
		    FileDeploy.Enable
		  End If
		  
		  If Self.ReadyToExport Then
		    FileExport.Enable
		  End If
		  
		  If Self.CurrentPanel <> Nil Then
		    Self.CurrentPanel.EnableMenuItems()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetEditorMenuItems(Items() As MenuItem)
		  If Self.CurrentPanel <> Nil Then
		    Self.CurrentPanel.GetEditorMenuItems(Items)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  If Self.mController.Document <> Nil Then
		    Var DocumentID As String = Self.mController.Document.DocumentID
		    Var LastConfig As String = Preferences.LastUsedConfigName(DocumentID)
		    If LastConfig.IsEmpty Then
		      If Self.mController.URL.Scheme = Beacon.DocumentURL.TypeWeb Then
		        LastConfig = BeaconConfigs.Metadata.ConfigName
		      Else
		        LastConfig = BeaconConfigs.LootDrops.ConfigName
		      End If
		    End If
		    Self.CurrentConfigName = LastConfig
		    
		    Self.mController.Document.AddObserver(Self, "Title")
		  End If
		  
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged, Self.Notification_SwitchEditors)
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  If Self.mUpdateUITag <> "" Then
		    CallLater.Cancel(Self.mUpdateUITag)
		    Self.mUpdateUITag = ""
		    Self.UpdateUI()
		  End If
		  
		  If Self.mController.CanWrite And Self.mController.URL.Scheme <> Beacon.DocumentURL.TypeTransient Then  
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		    Self.mController.Save()
		  Else
		    Self.SaveAs()
		  End If
		  Return True
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileDeploy() As Boolean Handles FileDeploy.Action
			Self.BeginDeploy()
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			Self.BeginExport()
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			Self.Document.NewIdentifier()
			Call Self.SaveAs()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub Autosave()
		  If Not Self.Document.Modified Then
		    Return
		  End If
		  
		  Var File As BookmarkedFolderItem = Self.AutosaveFile(True)
		  If File <> Nil And Self.mController.SaveACopy(Beacon.DocumentURL.URLForFile(File)) <> Nil Then
		    Self.AutosaveTimer.Reset
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AutosaveFile(CreateFolder As Boolean = False) As BookmarkedFolderItem
		  If Self.Document = Nil Then
		    Return Nil
		  End If
		  
		  If Self.mAutosaveFile Is Nil Or Not Self.mAutosaveFile.Exists Then
		    If (Self.mController.AutosaveURL Is Nil) = False Then
		      Try
		        Self.mAutosaveFile = Self.mController.AutosaveURL.File
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If Self.mAutosaveFile Is Nil Or Not Self.mAutosaveFile.Exists Then
		      Var Folder As FolderItem = App.AutosaveFolder(CreateFolder)
		      If Folder = Nil Then
		        Return Nil
		      End If
		      Self.mAutosaveFile = New BookmarkedFolderItem(Folder.Child(Self.Document.DocumentID + Beacon.FileExtensionProject))
		    End If
		  End If
		  
		  Return Self.mAutosaveFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginDeploy()
		  Const UseNewDeploy = True
		  
		  If Self.mDeployWindow <> Nil And Self.mDeployWindow.Value <> Nil And Self.mDeployWindow.Value IsA DeployManager Then
		    DeployManager(Self.mDeployWindow.Value).BringToFront()
		  Else
		    Self.Autosave()
		    
		    If Not Self.ReadyToDeploy Then
		      If Self.ShowConfirm("This project is not ready for deploy.", "You must import at least one server with this project to use the deploy feature.", "Import a Server", "Cancel") Then 
		        Self.BeginImport(True)
		      End If
		      Return
		    End If
		    
		    If Not Self.ContinueWithoutExcludedConfigs() Then
		      Return
		    End If
		    
		    If Self.Document.IsValid(App.IdentityManager.CurrentIdentity) = False Then
		      Self.ShowIssues()
		      Return
		    End If
		    
		    #if UseNewDeploy
		      Var Win As DeployManager = New DeployManager(Self.Document)
		      Self.mDeployWindow = New WeakRef(Win)
		      Win.BringToFront()
		    #else
		      Var Win As DocumentDeployWindow = DocumentDeployWindow.Create(Self.Document)
		      If Win <> Nil Then
		        Self.mDeployWindow = New WeakRef(Win)
		        Win.Show()
		      End If
		    #endif
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginExport()
		  Self.Autosave()
		  
		  If Not Self.ContinueWithoutExcludedConfigs() Then
		    Return
		  End If
		  
		  If Self.Document.IsValid(App.IdentityManager.CurrentIdentity) = False Then
		    Self.ShowIssues()
		    Return
		  End If
		  
		  DocumentExportWindow.Present(Self, Self.Document)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginImport(ForDeployment As Boolean)
		  If Self.mImportWindowRef <> Nil And Self.mImportWindowRef.Value <> Nil Then
		    DocumentImportWindow(Self.mImportWindowRef.Value).Show()
		  Else
		    Var OtherDocuments() As Beacon.Document
		    For I As Integer = 0 To Self.mEditorRefs.KeyCount - 1
		      Var Key As Variant = Self.mEditorRefs.Key(I)
		      Var Ref As WeakRef = Self.mEditorRefs.Value(Key)
		      If Ref <> Nil And Ref.Value <> Nil And Ref.Value IsA DocumentEditorView And DocumentEditorView(Ref.Value).Document.DocumentID <> Self.Document.DocumentID Then
		        OtherDocuments.Add(DocumentEditorView(Ref.Value).Document)
		      End If
		    Next
		    
		    Var Ref As DocumentImportWindow
		    If ForDeployment Then
		      Ref = DocumentImportWindow.Present(AddressOf ImportAndDeployCallback, Self.Document, OtherDocuments)
		    Else
		      Ref = DocumentImportWindow.Present(AddressOf ImportCallback, Self.Document, OtherDocuments)
		    End If
		    Self.mImportWindowRef = New WeakRef(Ref)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupAutosave()
		  Var AutosaveFile As FolderItem = Self.AutosaveFile()
		  If AutosaveFile <> Nil And AutosaveFile.Exists Then
		    Try
		      AutosaveFile.Remove
		    Catch Err As IOException
		      App.Log("Autosave " + AutosaveFile.NativePath + " did not delete: " + Err.Message + " (code: " + Err.ErrorNumber.ToString + ")")
		      Try
		        Var Destination As FolderItem = SpecialFolder.Temporary.Child("Beacon Autosave")
		        If Not Destination.Exists Then
		          Destination.CreateFolder
		        End If
		        Destination = Destination.Child(v4UUID.Create + ".beacon")
		        AutosaveFile.MoveTo(Destination)
		      Catch DeeperError As RuntimeException
		        App.Log("And unable to move the file to system temp for cleanup later: " + DeeperError.Message + " (code: " + DeeperError.ErrorNumber.ToString + ")")
		      End Try
		    End Try
		    Self.mAutosaveFile = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmClose(Callback As BeaconSubview.BringToFrontDelegate) As Boolean
		  If Self.Progress <> BeaconSubview.ProgressNone Then
		    If Beacon.SafeToInvoke(Callback) Then
		      Callback.Invoke(Self)
		    End If
		    
		    Self.ShowAlert(Self.ViewTitle + " cannot be closed right now because it is busy.", "Wait for the progress indicator at the top of the tab to go away before trying to close it.")
		    Return False
		  End If
		  
		  Return Super.ConfirmClose(Callback)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController)
		  If Self.mEditorRefs = Nil Then
		    Self.mEditorRefs = New Dictionary
		  End If
		  Self.mEditorRefs.Value(Controller.Document.DocumentID) = New WeakRef(Self)
		  
		  Self.mController = Controller
		  AddHandler Controller.WriteSuccess, WeakAddressOf mController_WriteSuccess
		  AddHandler Controller.WriteError, WeakAddressOf mController_WriteError
		  Self.ViewTitle = Controller.Name
		  Self.UpdateViewIcon
		  
		  Self.Panels = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ContinueWithoutExcludedConfigs() As Boolean
		  Var ExcludedConfigs() As Beacon.ConfigGroup = Self.Document.UsesOmniFeaturesWithoutOmni(App.IdentityManager.CurrentIdentity)
		  If ExcludedConfigs.LastIndex = -1 Then
		    Return True
		  End If
		  
		  Var HumanNames() As String
		  For Each Config As Beacon.ConfigGroup In ExcludedConfigs
		    HumanNames.Add("""" + Language.LabelForConfig(Config) + """")
		  Next
		  HumanNames.Sort
		  
		  Var Message, Explanation As String
		  If HumanNames.LastIndex = 0 Then
		    Message = "You are using an editor that will not be included in your config files."
		    Explanation = "The " + HumanNames(0) + " editor requires Beacon Omni, which you have not purchased. Beacon will not generate its content for your config files. Do you still want to continue?"
		  Else
		    Var GroupList As String = HumanNames.EnglishOxfordList()
		    Message = "You are using editors that will not be included in your config files."
		    Explanation = "The " + GroupList + " editors require Beacon Omni, which you have not purchased. Beacon will not generate their content for your config files. Do you still want to continue?"
		  End If
		  
		  Return Self.ShowConfirm(Message, Explanation, "Continue", "Cancel")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CopyFromDocuments(SourceDocuments As Variant)
		  Var Documents() As Beacon.Document = SourceDocuments
		  DocumentMergerWindow.Present(Self, Documents, Self.Document, WeakAddressOf MergeCallback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CopyFromDocumentsAndDeploy(SourceDocuments As Variant)
		  Var Documents() As Beacon.Document = SourceDocuments
		  DocumentMergerWindow.Present(Self, Documents, Self.Document, WeakAddressOf MergeAndDeployCallback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If Self.mController <> Nil Then
		    RemoveHandler Self.mController.WriteSuccess, WeakAddressOf mController_WriteSuccess
		    RemoveHandler Self.mController.WriteError, WeakAddressOf mController_WriteError
		  End If
		  
		  If Self.mEditorRefs <> Nil And Self.mEditorRefs.HasKey(Self.mController.Document.DocumentID) Then
		    Self.mEditorRefs.Remove(Self.mController.Document.DocumentID)
		  End If
		  
		  If (Self.mMapsPopoverController Is Nil) = False Then
		    RemoveHandler mMapsPopoverController.Finished, WeakAddressOf MapsPopoverController_Finished
		    Self.mModsPopoverController.Dismiss(True)
		    Self.mMapsPopoverController = Nil
		  End If
		  
		  If (Self.mModsPopoverController Is Nil) = False Then
		    RemoveHandler mModsPopoverController.Finished, WeakAddressOf ModsPopoverController_Finished
		    Self.mModsPopoverController.Dismiss(True)
		    Self.mModsPopoverController = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Document() As Beacon.Document
		  Return Self.mController.Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GoToIssue(Issue As Beacon.Issue)
		  If Issue = Nil Then
		    Return
		  End If
		  
		  Self.CurrentConfigName = Issue.ConfigName
		  
		  Var View As ConfigEditor = Self.CurrentPanel
		  If View <> Nil Then
		    View.GoToIssue(Issue)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleConfigPickerClick()
		  Var SetNames() As String = Self.Document.ConfigSetNames
		  SetNames.Sort
		  
		  Var Menu As New MenuItem
		  For Each SetName As String In SetNames
		    Var Item As New MenuItem(SetName, SetName)
		    Item.HasCheckMark = SetName = Self.ActiveConfigSet 
		    Menu.AddMenu(Item)
		  Next
		  
		  Menu.AddMenu(New MenuItem(MenuItem.TextSeparator))
		  Menu.AddMenu(New MenuItem("Manage Config Sets…", "beacon:manage"))
		  Menu.AddMenu(New MenuItem("Learn more about Config Sets…", "beacon:help"))
		  
		  Var Origin As Point = Self.ConfigSetPicker.GlobalizeCoordinate(Self.mConfigPickerMenuOrigin)
		  Var Choice As MenuItem = Menu.PopUp(Origin.X, Origin.Y)
		  If (Choice Is Nil) = False Then
		    If Choice.Tag.StringValue.BeginsWith("beacon:") Then
		      Var Tag As String = Choice.Tag.StringValue.Middle(7)
		      Select Case Tag
		      Case "manage"
		        If ConfigSetManagerWindow.Present(Self, Self.Document) Then
		          Self.ActiveConfigSet = Self.ActiveConfigSet
		        End If
		      Case "help"
		        Break
		      End Select
		    Else
		      Self.ActiveConfigSet = Choice.Tag.StringValue
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HideHelpDrawer()
		  If Not Self.mHelpDrawerOpen Then
		    Return
		  End If
		  Self.mHelpDrawerOpen = False
		  
		  If Self.mHelpDrawerAnimation <> Nil Then
		    Self.mHelpDrawerAnimation.Cancel
		    Self.mHelpDrawerAnimation = Nil
		  End If
		  If Self.mPagesAnimation <> Nil Then
		    Self.mPagesAnimation.Cancel
		    Self.mPagesAnimation = Nil
		  End If
		  
		  Self.mHelpDrawerAnimation = New AnimationKit.MoveTask(Self.HelpDrawer)
		  Self.mHelpDrawerAnimation.Left = Self.Width
		  Self.mHelpDrawerAnimation.DurationInSeconds = 0.15
		  Self.mHelpDrawerAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		  AddHandler Self.mHelpDrawerAnimation.Completed, WeakAddressOf Self.mHelpDrawerAnimation_Completed
		  Self.mHelpDrawerAnimation.Run
		  
		  Self.mPagesAnimation = New AnimationKit.MoveTask(Self.PagePanel1)
		  Self.mPagesAnimation.Width = Self.Width
		  Self.mPagesAnimation.DurationInSeconds = 0.15
		  Self.mPagesAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		  Self.mPagesAnimation.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportAndDeployCallback(Documents() As Beacon.Document)
		  Call CallLater.Schedule(0, WeakAddressOf CopyFromDocumentsAndDeploy, Documents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportCallback(Documents() As Beacon.Document)
		  Call CallLater.Schedule(0, WeakAddressOf CopyFromDocuments, Documents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MapsPopoverController_Finished(Sender As PopoverController, Cancelled As Boolean)
		  If Not Cancelled Then
		    Self.Document.MapCompatibility = MapSelectionGrid(Sender.Container).Mask
		    Self.Changed = Self.Document.Modified
		  End If
		  
		  Self.OmniBar1.Item("MapsButton").Toggled = False
		  Self.mMapsPopoverController = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteError(Sender As Beacon.DocumentController, Reason As String)
		  If Not Self.Closed Then
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		  
		  If Reason.Encoding = Nil Then
		    Reason = Reason.GuessEncoding
		  End If
		  
		  // This has been made thread safe
		  Self.ShowAlert("Uh oh, the project " + Sender.Name + " did not save!", Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteSuccess(Sender As Beacon.DocumentController)
		  If Not Self.Closed Then
		    Self.Changed = Sender.Document <> Nil And Sender.Document.Modified
		    Self.ViewTitle = Sender.Name
		    Self.Progress = BeaconSubview.ProgressNone
		    Self.UpdateViewIcon()
		  End If
		  
		  Preferences.AddToRecentDocuments(Sender.URL)
		  
		  If Self.Document = Nil Or Sender.Document.Modified = False Then
		    // Safe to cleanup the autosave
		    Self.CleanupAutosave()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MergeAndDeployCallback()
		  Self.MergeCallback()
		  Self.BeginDeploy()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MergeCallback()
		  Var Keys() As Variant = Self.Panels.Keys
		  For Each Key As Variant In Keys
		    Var Panel As ConfigEditor = Self.Panels.Value(Key)
		    If Panel <> Nil Then
		      Panel.ImportFinished()
		    End If
		  Next
		  
		  Self.Autosave()
		  Self.Panel_ContentsChanged(Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHelpDrawerAnimation_Completed(Sender As AnimationKit.MoveTask)
		  #Pragma Unused Sender
		  
		  If Self.Closed = False And Self.mHelpDrawerOpen = False Then
		    Self.HelpDrawer.Visible = False
		    Self.MinimumWidth = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumWidth, Self.LocalMinWidth), Self.LocalMinWidth)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ModsPopoverController_Finished(Sender As PopoverController, Cancelled As Boolean)
		  If Not Cancelled Then
		    Var Editor As ModSelectionGrid = ModSelectionGrid(Sender.Container)
		    Var Mods() As Beacon.ModDetails = LocalData.SharedInstance.AllMods
		    For Each Details As Beacon.ModDetails In Mods
		      Self.Document.ModEnabled(Details.ModID) = Editor.ModEnabled(Details.ModID)
		    Next
		    
		    Self.Changed = Self.Document.Modified
		  End If
		  
		  Self.OmniBar1.Item("ModsButton").Toggled = False
		  Self.mModsPopoverController = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case IdentityManager.Notification_IdentityChanged
		    // Simply toggle the menu to force a redraw
		    Var CurrentConfig As String = Self.CurrentConfigName
		    Self.CurrentConfigName = ""
		    Self.CurrentConfigName = CurrentConfig
		  Case Self.Notification_SwitchEditors
		    Var UserData As Dictionary = Notification.UserData
		    If Self.Document.DocumentID = UserData.Value("DocumentID").StringValue Then
		      Self.CurrentConfigName = UserData.Value("ConfigName").StringValue
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, Value As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Value
		  
		  Select Case Key
		  Case "MinimumWidth", "MinimumHeight"
		    Self.UpdateMinimumDimensions()
		  Case "Title"
		    Self.ViewTitle = Self.mController.Document.Title
		    Self.Changed = True
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Panel_ContentsChanged(Sender As ConfigEditor)
		  #Pragma Unused Sender
		  
		  If Self.Changed <> Self.Document.Modified Then
		    Self.Changed = Self.Document.Modified
		  End If
		  
		  If Self.mUpdateUITag <> "" Then
		    CallLater.Cancel(Self.mUpdateUITag)
		    Self.mUpdateUITag = ""
		  End If
		  
		  Self.mUpdateUITag = CallLater.Schedule(500, AddressOf UpdateUI)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadyToDeploy() As Boolean
		  If Self.Document = Nil Or Self.Document.ServerProfileCount = 0 Then
		    Return False
		  End If
		  
		  Var Bound As Integer = Self.Document.ServerProfileCount - 1
		  For I As Integer = 0 To Bound
		    If Self.Document.ServerProfile(I) <> Nil And Self.Document.ServerProfile(I).DeployCapable Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadyToExport() As Boolean
		  Return Self.Document <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveAs()
		  Select Case DocumentSaveToCloudWindow.Present(Self.TrueWindow, Self.mController)
		  Case DocumentSaveToCloudWindow.StateSaved
		    Self.ViewTitle = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Case DocumentSaveToCloudWindow.StateSaveLocal
		    Var Dialog As New SaveFileDialog
		    Dialog.SuggestedFileName = Self.mController.Name + Beacon.FileExtensionProject
		    Dialog.Filter = BeaconFileTypes.BeaconDocument
		    
		    Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If File = Nil Then
		      Return
		    End If
		    
		    If Self.Document.Title.BeginsWith("Untitled Project") Then
		      Var Filename As String = File.Name
		      Var Extension As String = Beacon.FileExtensionProject
		      If Filename.EndsWith(Extension) Then
		        Filename = Filename.Left(Filename.Length - Extension.Length).Trim
		      End If
		      Self.Document.Title = Filename
		    End If
		    
		    Self.mController.SaveAs(Beacon.DocumentURL.URLForFile(New BookmarkedFolderItem(File)))
		    Self.ViewTitle = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHelpDrawer()
		  If Self.mHelpDrawerOpen Then
		    Return
		  End If
		  Self.mHelpDrawerOpen = True
		  Self.MinimumWidth = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumWidth, Self.LocalMinWidth), Self.LocalMinWidth) + Self.HelpDrawer.Width
		  
		  If Self.mHelpDrawerAnimation <> Nil Then
		    Self.mHelpDrawerAnimation.Cancel
		    Self.mHelpDrawerAnimation = Nil
		  End If
		  If Self.mPagesAnimation <> Nil Then
		    Self.mPagesAnimation.Cancel
		    Self.mPagesAnimation = Nil
		  End If
		  
		  Self.HelpDrawer.Visible = True
		  
		  Self.mHelpDrawerAnimation = New AnimationKit.MoveTask(Self.HelpDrawer)
		  Self.mHelpDrawerAnimation.Left = Self.Width - Self.HelpDrawer.Width
		  Self.mHelpDrawerAnimation.DurationInSeconds = 0.15
		  Self.mHelpDrawerAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		  Self.mHelpDrawerAnimation.Run
		  
		  Self.mPagesAnimation = New AnimationKit.MoveTask(Self.PagePanel1)
		  Self.mPagesAnimation.Width = Self.Width - Self.HelpDrawer.Width
		  Self.mPagesAnimation.DurationInSeconds = 0.15
		  Self.mPagesAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		  Self.mPagesAnimation.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowIssues()
		  ResolveIssuesDialog.Present(Self, Self.Document, AddressOf GoToIssue)
		  Self.Changed = Self.Document.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub SwitchToEditor(Document As Beacon.Document, ConfigName As String)
		  Var UserData As New Dictionary
		  UserData.Value("DocumentID") = Document.DocumentID
		  UserData.Value("ConfigName") = ConfigName
		  
		  NotificationKit.Post(Notification_SwitchEditors, UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateConfigList()
		  Var Labels(), Tags() As String
		  
		  Var ActiveConfigSet As String = Self.ActiveConfigSet
		  Var IsBase As Boolean = ActiveConfigSet = Beacon.Document.BaseConfigSetName
		  If IsBase Then
		    // Show everything
		    #if DeployEnabled
		      Labels.Add("Servers")
		      Tags.Add("deployments")
		    #endif
		    Labels.Add("Accounts")
		    Tags.Add("accounts")
		  End If
		  
		  Var Names() As String = BeaconConfigs.AllConfigNames
		  For Each Name As String In Names
		    Labels.Add(Language.LabelForConfig(Name))
		    Tags.Add(Name)
		  Next
		  
		  Labels.SortWith(Tags)
		  
		  Var SourceItems() As SourceListItem
		  For I As Integer = 0 To Labels.LastIndex
		    Var Item As New SourceListItem(Labels(I), Tags(I))
		    If Not IsBase Then
		      Var Group As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(Tags(I))
		      If Group.SupportsConfigSets = False Then
		        Continue
		      End If
		      
		      Item.Unemphasized = Self.Document.HasConfigGroup(Tags(I)) = False Or Self.Document.ConfigGroup(Tags(I)).IsImplicit = True
		    End If
		    SourceItems.Add(Item)
		  Next
		  
		  Self.ConfigList.ReplaceContents(SourceItems)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateHelpForConfig(ConfigName As String)
		  Var Title, Body, DetailURL As String
		  Call LocalData.SharedInstance.GetConfigHelp(ConfigName, Title, Body, DetailURL)
		  Self.HelpDrawer.Title = Title
		  Self.HelpDrawer.Body = Body
		  Self.HelpDrawer.DetailURL = DetailURL
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMinimumDimensions()
		  Self.MinimumWidth = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumWidth, Self.LocalMinWidth), Self.LocalMinWidth) + If(Self.mHelpDrawerOpen, Self.HelpDrawer.Width, 0) + Self.PagePanel1.Left
		  Self.MinimumHeight = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumHeight, Self.LocalMinHeight), Self.LocalMinHeight) + Self.PagePanel1.Top
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.ViewTitle = Self.mController.Name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateViewIcon()
		  Select Case Self.mController.URL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    Self.ViewIcon = IconCloudDocument
		  Case Beacon.DocumentURL.TypeWeb
		    Self.ViewIcon = IconCommunityDocument
		  Else
		    Self.ViewIcon = Nil
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Beacon.DocumentURL
		  Return Self.mController.URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewID() As String
		  Return Self.mController.URL.Hash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewType(Plural As Boolean, Lowercase As Boolean) As String
		  If Plural Then
		    Return If(Lowercase, "projects", "Projects")
		  Else
		    Return If(Lowercase, "project", "Project")
		  End If
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.Document.ActiveConfigSet
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var ConfigName As String = Self.CurrentConfigName
			  Self.CurrentConfigName = "" // To unload the current version
			  
			  Self.Document.ActiveConfigSet = Value
			  Self.ConfigSetPicker.Invalidate
			  Self.UpdateConfigList
			  
			  Self.CurrentConfigName = ConfigName
			End Set
		#tag EndSetter
		ActiveConfigSet As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentConfigName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCurrentConfigName = Value Then
			    Return
			  End If
			  Self.mCurrentConfigName = Value
			  
			  Var NewPanel As ConfigEditor
			  Var Embed As Boolean
			  If Value.IsEmpty = False Then
			    Var CacheKey As String = Self.ActiveConfigSet + ":" + Value
			    
			    Self.UpdateHelpForConfig(Value)
			    
			    If Self.mController.Document <> Nil Then
			      Preferences.LastUsedConfigName(Self.mController.Document.DocumentID) = Value
			    End If
			    
			    Var HistoryIndex As Integer = Self.mPanelHistory.IndexOf(CacheKey)
			    If HistoryIndex > 0 Then
			      Self.mPanelHistory.RemoveAt(HistoryIndex)
			    End If
			    Self.mPanelHistory.AddAt(0, CacheKey)
			    
			    // Close older panels
			    If Self.mPanelHistory.LastIndex > 2 Then
			      For I As Integer = Self.mPanelHistory.LastIndex DownTo 3
			        Var PanelTag As String = Self.mPanelHistory(I)
			        If Self.Panels.HasKey(PanelTag) Then
			          Var Panel As ConfigEditor = Self.Panels.Value(PanelTag)
			          RemoveHandler Panel.ContentsChanged, WeakAddressOf Panel_ContentsChanged
			          Panel.Close
			          Self.Panels.Remove(PanelTag)
			        End If
			      Next
			    End If
			    
			    If Self.Panels.HasKey(CacheKey) Then
			      NewPanel = Self.Panels.Value(CacheKey)
			    Else
			      Select Case Value
			      Case "deployments"
			        NewPanel = New ServersConfigEditor(Self.mController)
			      Case "accounts"
			        NewPanel = New AccountsConfigEditor(Self.mController)
			      Case BeaconConfigs.LootDrops.ConfigName
			        NewPanel = New LootConfigEditor(Self.mController)
			      Case BeaconConfigs.Difficulty.ConfigName
			        NewPanel = New DifficultyConfigEditor(Self.mController)
			      Case BeaconConfigs.LootScale.ConfigName
			        NewPanel = New LootScaleConfigEditor(Self.mController)
			      Case BeaconConfigs.Metadata.ConfigName
			        NewPanel = New MetaDataConfigEditor(Self.mController)
			      Case BeaconConfigs.ExperienceCurves.ConfigName
			        NewPanel = New ExperienceCurvesConfigEditor(Self.mController)
			      Case BeaconConfigs.CustomContent.ConfigName
			        NewPanel = New CustomContentConfigEditor(Self.mController)
			      Case BeaconConfigs.CraftingCosts.ConfigName
			        NewPanel = New CraftingCostsConfigEditor(Self.mController)
			      Case BeaconConfigs.StackSizes.ConfigName
			        NewPanel = New StackSizesConfigEditor(Self.mController)
			      Case BeaconConfigs.BreedingMultipliers.ConfigName
			        NewPanel = New BreedingMultipliersConfigEditor(Self.mController)
			      Case BeaconConfigs.HarvestRates.ConfigName
			        NewPanel = New HarvestRatesConfigEditor(Self.mController)
			      Case BeaconConfigs.DinoAdjustments.ConfigName
			        NewPanel = New DinoAdjustmentsConfigEditor(Self.mController)
			      Case BeaconConfigs.StatMultipliers.ConfigName
			        NewPanel = New StatMultipliersConfigEditor(Self.mController)
			      Case BeaconConfigs.DayCycle.ConfigName
			        NewPanel = New DayCycleConfigEditor(Self.mController)
			      Case BeaconConfigs.SpawnPoints.ConfigName
			        NewPanel = New SpawnPointsConfigEditor(Self.mController)
			      Case BeaconConfigs.StatLimits.ConfigName
			        NewPanel = New StatLimitsConfigEditor(Self.mController)
			      Case BeaconConfigs.EngramControl.ConfigName
			        NewPanel = New EngramControlConfigEditor(Self.mController)
			      End Select
			      If NewPanel <> Nil Then
			        Self.Panels.Value(CacheKey) = NewPanel
			        Embed = True
			      End If
			    End If
			  Else
			    Self.UpdateHelpForConfig("")
			  End If
			  
			  If Self.CurrentPanel = NewPanel Then
			    Return
			  End If
			  
			  If Self.CurrentPanel <> Nil Then
			    Self.CurrentPanel.SwitchedFrom()
			    Self.CurrentPanel.Visible = False
			    Self.CurrentPanel = Nil
			  End If
			  
			  Self.CurrentPanel = NewPanel
			  
			  If Self.CurrentPanel <> Nil Then
			    Var RequiresPurchase As Boolean
			    If Value.Length > 0 Then
			      RequiresPurchase = Not BeaconConfigs.ConfigPurchased(Value, If(App.IdentityManager.CurrentIdentity <> Nil, App.IdentityManager.CurrentIdentity.OmniVersion, 0))
			    End If
			    Var TopOffset As Integer
			    If RequiresPurchase Then
			      TopOffset = (Self.OmniNoticeBanner.Top + Self.OmniNoticeBanner.Height) - Self.PagePanel1.Top
			    End If
			    If Embed Then
			      AddHandler Self.CurrentPanel.ContentsChanged, WeakAddressOf Panel_ContentsChanged
			      Self.CurrentPanel.EmbedWithinPanel(Self.PagePanel1, 1, 0, TopOffset, Self.PagePanel1.Width, Self.PagePanel1.Height - TopOffset)
			    Else
			      Self.CurrentPanel.Top = Self.PagePanel1.Top + TopOffset
			      Self.CurrentPanel.Height = Self.PagePanel1.Height - TopOffset
			    End If
			    Self.OmniNoticeBanner.Visible = RequiresPurchase
			    Self.CurrentPanel.Visible = True
			    Self.CurrentPanel.SwitchedTo()
			    Self.PagePanel1.SelectedPanelIndex = 1
			  Else
			    Self.PagePanel1.SelectedPanelIndex = 0
			  End If
			  
			  Self.ConfigList.SelectedTag = Value
			  
			  Self.UpdateMinimumDimensions()
			End Set
		#tag EndSetter
		CurrentConfigName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private CurrentPanel As ConfigEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutosaveFile As BookmarkedFolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPickerMenuOrigin As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPickerMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPickerMouseHover As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As Beacon.DocumentController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentConfigName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeployWindow As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDrawOmniBannerPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mEditorRefs As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHelpDrawerAnimation As AnimationKit.MoveTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHelpDrawerOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportWindowRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapsPopoverController As PopoverController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModsPopoverController As PopoverController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPagesAnimation As AnimationKit.MoveTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPanelHistory() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateUITag As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Panels As Dictionary
	#tag EndProperty


	#tag Constant, Name = DeployEnabled, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LocalMinHeight, Type = Double, Dynamic = False, Default = \"400", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LocalMinWidth, Type = Double, Dynamic = False, Default = \"500", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Notification_SwitchEditors, Type = String, Dynamic = False, Default = \"Switch Editors", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OmniWarningText, Type = String, Dynamic = False, Default = \"This config type requires Beacon Omni. Click this banner to learn more.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events OmniNoticeBanner
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Var BaseColor As Color = SystemColors.SystemYellowColor
		  Var BackgroundColor As Color = BaseColor.AtOpacity(0.2)
		  Var TextColor As Color = SystemColors.LabelColor
		  Var BorderColor As Color = SystemColors.SeparatorColor
		  
		  G.DrawingColor = BackgroundColor
		  G.FillRectangle(0, 0, G.Width, G.Height - 1)
		  G.DrawingColor = BorderColor
		  G.DrawLine(0, G.Height - 1, G.Width, G.Height - 1)
		  
		  Var TextWidth As Double = G.TextWidth(Self.OmniWarningText)
		  Var TextLeft As Double = (G.Width - TextWidth) / 2
		  Var TextBaseline As Double = (G.Height / 2) + (G.CapHeight / 2)
		  G.DrawingColor = TextColor
		  G.DrawText(Self.OmniWarningText, TextLeft, TextBaseline, G.Width - 40, True)
		  
		  If Self.mDrawOmniBannerPressed Then
		    G.DrawingColor = &c00000080
		    G.FillRectangle(0, 0, G.Width, G.Height - 1)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Self.mDrawOmniBannerPressed = True
		  Self.OmniNoticeBanner.Invalidate
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var ShouldBePressed As Boolean = X >= 0 And X < Me.Width And Y >= 0 And Y < Me.Height
		  If Self.mDrawOmniBannerPressed <> ShouldBePressed Then
		    Self.mDrawOmniBannerPressed = ShouldBePressed
		    Self.OmniNoticeBanner.Invalidate
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Self.mDrawOmniBannerPressed = False
		  Self.OmniNoticeBanner.Invalidate
		  If X >= 0 And X < Me.Width And Y >= 0 And Y < Me.Height Then
		    ShowURL(Beacon.WebURL("/omni"))
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutosaveTimer
	#tag Event
		Sub Action()
		  Self.Autosave()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OmniBar1
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateButton("ImportButton", "Import", IconToolbarImport, "Import config files"))
		  Me.Append(OmniBarItem.CreateSpace())
		  Me.Append(OmniBarItem.CreateButton("ExportButton", "Export", IconToolbarExport, "Save new config file"))
		  
		  #if DeployEnabled
		    Me.Append(OmniBarItem.CreateButton("DeployButton", "Deploy", IconToolbarDeploy, "Make config changes live"))
		  #endif
		  
		  Me.Append(OmniBarItem.CreateSpace())
		  Me.Append(OmniBarItem.CreateButton("ShareButton", "Share", IconToolbarShare, "Share this project with other users"))
		  
		  Me.Append(OmniBarItem.CreateSeparator())
		  Me.Append(OmniBarItem.CreateButton("MapsButton", "Maps", IconToolbarMaps, "Change the maps for this project"))
		  Me.Append(OmniBarItem.CreateButton("ModsButton", "Mods", IconToolbarMods, "Enable or disable Beacon's built-in mods"))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "ImportButton"
		    Self.BeginImport(False)
		  Case "ExportButton"
		    Self.BeginExport()
		  Case "HelpButton"
		    If Self.mHelpDrawerOpen Then
		      Self.HideHelpDrawer()
		    Else
		      Self.ShowHelpDrawer()
		    End If
		  Case "ShareButton"
		    If Self.mController.URL.Scheme = Beacon.DocumentURL.TypeCloud Then
		      SharingDialog.Present(Self, Self.Document)
		    ElseIf Self.mController.URL.Scheme = Beacon.DocumentURL.TypeLocal Then
		      Self.ShowAlert("Project sharing is only available to cloud projects", "Use ""Save As…"" under the file menu to save a new copy of this project to the cloud if you would like to use Beacon's sharing features.")
		    Else
		      Self.ShowAlert("Project sharing is only available to cloud projects", "If you would like to use Beacon's sharing features, first save your project using ""Save"" under the file menu.")
		    End If
		  Case "DeployButton"
		    Self.BeginDeploy()
		  Case "MapsButton"
		    If (Self.mMapsPopoverController Is Nil) = False And Self.mMapsPopoverController.Visible Then
		      Self.mMapsPopoverController.Dismiss(False)
		      Self.mMapsPopoverController = Nil
		      Item.Toggled = False
		      Return
		    End If
		    
		    Var Editor As New MapSelectionGrid
		    Var Controller As New PopoverController(Editor)
		    Editor.Mask = Self.Document.MapCompatibility
		    Controller.Show(Me, ItemRect)
		    
		    Item.Toggled = True
		    
		    AddHandler Controller.Finished, WeakAddressOf MapsPopoverController_Finished
		    Self.mMapsPopoverController = Controller
		  Case "ModsButton"
		    If (Self.mModsPopoverController Is Nil) = False And Self.mModsPopoverController.Visible Then
		      Self.mModsPopoverController.Dismiss(False)
		      Self.mModsPopoverController = Nil
		      Item.Toggled = False
		      Return
		    End If
		    
		    Var Editor As New ModSelectionGrid(Self.Document.Mods)
		    Var Controller As New PopoverController(Editor)
		    Controller.Show(Me, ItemRect)
		    
		    Item.Toggled = True
		    
		    AddHandler Controller.Finished, WeakAddressOf ModsPopoverController_Finished
		    Self.mModsPopoverController = Controller
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigList
	#tag Event
		Sub Change()
		  Var TagVar As Variant
		  If Me.SelectedRowIndex > -1 Then
		    TagVar = Me.Item(Me.SelectedRowIndex).Tag
		  End If
		  If IsNull(TagVar) = False And (TagVar.Type = Variant.TypeString Or TagVar.Type = Variant.TypeText) Then
		    Self.CurrentConfigName = TagVar.StringValue
		  Else
		    Self.CurrentConfigName = ""
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Self.UpdateConfigList()
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldChange(DesiredIndex As Integer) As Boolean
		  #Pragma Unused DesiredIndex
		  
		  Var CurrentItem As SourceListItem = Me.SelectedItem
		  If (CurrentItem Is Nil) = False Then
		    Try
		      Var GroupName As String = CurrentItem.Tag
		      CurrentItem.Unemphasized = Self.ActiveConfigSet <> Beacon.Document.BaseConfigSetName And (Self.Document.HasConfigGroup(GroupName) = False Or Self.Document.ConfigGroup(GroupName).IsImplicit = True)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ConfigSetPicker
	#tag Event
		Sub Paint(G As Graphics, Areas() As REALbasic.Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused SafeArea
		  
		  Var Caption As String = "Config Set: " + Self.ActiveConfigSet
		  Var CaptionBaseline As Double = (G.Height / 2) + (G.CapHeight / 2)
		  Var CaptionLeft As Double = G.Height - CaptionBaseline
		  
		  Var DropdownLeft As Double = G.Width - (CaptionLeft + 8)
		  Var DropdownTop As Double = (G.Height - 4) / 2
		  
		  Var Path As New GraphicsPath
		  Path.MoveToPoint(NearestMultiple(DropdownLeft, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 2, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 4, G.ScaleX), NearestMultiple(DropdownTop + 2, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 6, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 8, G.ScaleX), NearestMultiple(DropdownTop, G.ScaleY))
		  Path.AddLineToPoint(NearestMultiple(DropdownLeft + 4, G.ScaleX), NearestMultiple(DropdownTop + 4, G.ScaleY))
		  
		  If Self.mConfigPickerMouseHover And Highlighted Then
		    G.DrawingColor = SystemColors.ControlAccentColor
		  Else
		    G.DrawingColor = SystemColors.LabelColor
		  End If
		  
		  G.DrawText(Caption, NearestMultiple(CaptionLeft, G.ScaleX), NearestMultiple(CaptionBaseline, G.ScaleY), NearestMultiple(G.Width - ((CaptionLeft * 3) + 8), G.ScaleX), True)
		  G.FillPath(Path)
		  
		  If Self.mConfigPickerMouseDown Then
		    G.DrawingColor = &c000000A5
		    G.FillRectangle(0, 0, G.Width, G.Height)
		  End If
		  
		  Self.mConfigPickerMenuOrigin = New Point(CaptionLeft, CaptionBaseline)
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  If Self.mConfigPickerMouseDown = False Then
		    Self.mConfigPickerMouseDown = True
		    Me.Invalidate
		  End If
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var Pressed As Boolean = (X >= 0 And Y >= 0 And X <= Me.Width And Y <= Me.Height)
		  If Self.mConfigPickerMouseDown <> Pressed Then
		    Self.mConfigPickerMouseDown = Pressed
		    Me.Invalidate
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  If Self.mConfigPickerMouseHover = False Then
		    Self.mConfigPickerMouseHover = True
		    Me.Invalidate
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  If Self.mConfigPickerMouseHover = True Then
		    Self.mConfigPickerMouseHover = False
		    Me.Invalidate
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  If Self.mConfigPickerMouseHover = False Then
		    Self.mConfigPickerMouseHover = True
		    Me.Invalidate
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Var Pressed As Boolean = (X >= 0 And Y >= 0 And X <= Me.Width And Y <= Me.Height)
		  If Pressed Then
		    Call CallLater.Schedule(10, WeakAddressOf HandleConfigPickerClick)
		  End If
		  If Self.mConfigPickerMouseDown = True Or Self.mConfigPickerMouseHover <> Pressed Then
		    Self.mConfigPickerMouseDown = False
		    Self.mConfigPickerMouseHover = Pressed
		    Me.Invalidate
		  End If
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
		InitialValue=""
		Type="Integer"
		EditorType=""
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
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="TabStop"
		Visible=true
		Group="Position"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
	#tag ViewProperty
		Name="CurrentConfigName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ActiveConfigSet"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
