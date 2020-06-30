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
      Height          =   487
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
      Top             =   41
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   627
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "There was an error loading the editor"
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   487
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
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   41
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   627
      End
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
         Top             =   41
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   False
         Width           =   627
      End
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
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
      Width           =   858
   End
   Begin BeaconToolbar BeaconToolbar1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
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
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   858
   End
   Begin HelpDrawer HelpDrawer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Body            =   ""
      Borders         =   8
      DetailURL       =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   487
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
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Title           =   ""
      Top             =   41
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   False
      Width           =   300
   End
   Begin Timer AutosaveTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   60000
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin SourceList ConfigList
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   487
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      SelectedRowIndex=   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   True
      Visible         =   True
      Width           =   230
   End
   Begin FadedSeparator SourceSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   487
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   230
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   1
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
		    Self.CurrentConfigName = Preferences.LastUsedConfigName(DocumentID)
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
		      Self.mAutosaveFile = New BookmarkedFolderItem(Folder.Child(Self.Document.DocumentID + BeaconFileTypes.BeaconDocument.PrimaryExtension))
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
		      If Self.ShowConfirm("This document is not ready for deploy.", "You must link at least one server with this document to use the deploy feature.", "Link a Server", "Cancel") Then 
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
		        OtherDocuments.AddRow(DocumentEditorView(Ref.Value).Document)
		      End If
		    Next
		    
		    Var Ref As DocumentImportWindow
		    If ForDeployment Then
		      Ref = DocumentImportWindow.Present(AddressOf ImportAndDeployCallback, Self.Document, OtherDocuments, True)
		    Else
		      Ref = DocumentImportWindow.Present(AddressOf ImportCallback, Self.Document, OtherDocuments, False)
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
		    If Callback <> Nil Then
		      Callback.Invoke(Self)
		    End If
		    
		    Self.ShowAlert(Self.ToolbarCaption + " cannot be closed right now because it is busy.", "Wait for the progress indicator at the top of the tab to go away before trying to close it.")
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
		  Self.ToolbarCaption = Controller.Name
		  Self.UpdateToolbarIcon
		  
		  Self.Panels = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ContinueWithoutExcludedConfigs() As Boolean
		  Var ExcludedConfigs() As Beacon.ConfigGroup = Self.Document.UsesOmniFeaturesWithoutOmni(App.IdentityManager.CurrentIdentity)
		  If ExcludedConfigs.LastRowIndex = -1 Then
		    Return True
		  End If
		  
		  Var HumanNames() As String
		  For Each Config As Beacon.ConfigGroup In ExcludedConfigs
		    HumanNames.AddRow("""" + Language.LabelForConfig(Config) + """")
		  Next
		  HumanNames.Sort
		  
		  Var Message, Explanation As String
		  If HumanNames.LastRowIndex = 0 Then
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
		Private Sub HideHelpDrawer()
		  If Not Self.mHelpDrawerOpen Then
		    Return
		  End If
		  Self.mHelpDrawerOpen = False
		  Self.BeaconToolbar1.HelpButton.Toggled = False
		  
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
		Private Sub mController_WriteError(Sender As Beacon.DocumentController, Reason As String)
		  If Not Self.Closed Then
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		  
		  Var Notification As New Beacon.UserNotification("Uh oh, the document " + Sender.Name + " did not save!", Beacon.UserNotification.Severities.Elevated)
		  Notification.SecondaryMessage = Reason
		  Notification.UserData = New Dictionary
		  Notification.UserData.Value("DocumentID") = If(Sender.Document <> Nil, Sender.Document.DocumentID, "")
		  Notification.UserData.Value("DocumentURL") = Sender.URL.URL // To force convert to text
		  Notification.UserData.Value("Reason") = Reason
		  LocalData.SharedInstance.SaveNotification(Notification)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteSuccess(Sender As Beacon.DocumentController)
		  If Not Self.Closed Then
		    Self.Changed = Sender.Document <> Nil And Sender.Document.Modified
		    Self.ToolbarCaption = Sender.Name
		    Self.Progress = BeaconSubview.ProgressNone
		    Self.UpdateToolbarIcon()
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
		    Self.BeaconToolbar1.HelpButton.Enabled = (Self.CurrentPanel <> Nil And Self.HelpDrawer.Body <> "")
		    Self.MinimumWidth = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumWidth, Self.LocalMinWidth), Self.LocalMinWidth)
		  End If
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
		    Self.ToolbarCaption = Self.mController.Document.Title
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
		    Self.ToolbarCaption = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Case DocumentSaveToCloudWindow.StateSaveLocal
		    Var Dialog As New SaveFileDialog
		    Dialog.SuggestedFileName = Self.mController.Name + BeaconFileTypes.BeaconDocument.PrimaryExtension
		    Dialog.Filter = BeaconFileTypes.BeaconDocument
		    
		    Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If File = Nil Then
		      Return
		    End If
		    
		    If Self.Document.Title.BeginsWith("Untitled Document") Then
		      Var Filename As String = File.Name
		      Var Extension As String = BeaconFileTypes.BeaconDocument.PrimaryExtension
		      If Filename.EndsWith(Extension) Then
		        Filename = Filename.Left(Filename.Length - Extension.Length).Trim
		      End If
		      Self.Document.Title = Filename
		    End If
		    
		    Self.mController.SaveAs(Beacon.DocumentURL.URLForFile(New BookmarkedFolderItem(File)))
		    Self.ToolbarCaption = Self.mController.Name
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
		  Self.BeaconToolbar1.HelpButton.Toggled = True
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
		Private Sub UpdateHelpForConfig(ConfigName As String)
		  Var Title, Body, DetailURL As String
		  Call LocalData.SharedInstance.GetConfigHelp(ConfigName, Title, Body, DetailURL)
		  Self.HelpDrawer.Title = Title
		  Self.HelpDrawer.Body = Body
		  Self.HelpDrawer.DetailURL = DetailURL
		  Self.BeaconToolbar1.HelpButton.Enabled = Self.mHelpDrawerOpen Or (Self.HelpDrawer.Body <> "")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMinimumDimensions()
		  Self.MinimumWidth = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumWidth, Self.LocalMinWidth), Self.LocalMinWidth) + If(Self.mHelpDrawerOpen, Self.HelpDrawer.Width, 0) + Self.PagePanel1.Left
		  Self.MinimumHeight = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumHeight, Self.LocalMinHeight), Self.LocalMinHeight) + Self.PagePanel1.Top
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateToolbarIcon()
		  Select Case Self.mController.URL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    Self.ToolbarIcon = IconCloudTab
		  Case Beacon.DocumentURL.TypeWeb
		    Self.ToolbarIcon = IconCommunityTab
		  Else
		    Self.ToolbarIcon = Nil
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.ToolbarCaption = Self.mController.Name
		  Self.BeaconToolbar1.ExportButton.Enabled = Self.ReadyToExport
		  #if DeployEnabled
		    Self.BeaconToolbar1.DeployButton.Enabled = Self.ReadyToExport
		  #endif
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
			  If Value.Length > 0 Then
			    Self.UpdateHelpForConfig(Value)
			    
			    If Self.mController.Document <> Nil Then
			      Preferences.LastUsedConfigName(Self.mController.Document.DocumentID) = Value
			    End If
			    
			    Var HistoryIndex As Integer = Self.mPanelHistory.IndexOf(Value)
			    If HistoryIndex > 0 Then
			      Self.mPanelHistory.RemoveRowAt(HistoryIndex)
			    End If
			    Self.mPanelHistory.AddRowAt(0, Value)
			    
			    // Close older panels
			    If Self.mPanelHistory.LastRowIndex > 2 Then
			      For I As Integer = Self.mPanelHistory.LastRowIndex DownTo 3
			        Var PanelTag As String = Self.mPanelHistory(I)
			        If Self.Panels.HasKey(PanelTag) Then
			          Var Panel As ConfigEditor = Self.Panels.Value(PanelTag)
			          RemoveHandler Panel.ContentsChanged, WeakAddressOf Panel_ContentsChanged
			          Panel.Close
			          Self.Panels.Remove(PanelTag)
			        End If
			      Next
			    End If
			    
			    If Self.Panels.HasKey(Value) Then
			      NewPanel = Self.Panels.Value(Value)
			    Else
			      Select Case Value
			      Case "maps"
			        NewPanel = New MapsConfigEditor(Self.mController)
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
			        Self.Panels.Value(Value) = NewPanel
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
			    Self.CurrentPanel.RemoveObserver(Self, "MinimumWidth")
			    Self.CurrentPanel.RemoveObserver(Self, "MinimumHeight")
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
			    Self.CurrentPanel.AddObserver(Self, "MinimumWidth")
			    Self.CurrentPanel.AddObserver(Self, "MinimumHeight")
			    Self.PagePanel1.SelectedPanelIndex = 1
			  Else
			    Self.PagePanel1.SelectedPanelIndex = 0
			  End If
			  
			  Self.ConfigList.SelectByTag(Value)
			  
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
#tag Events BeaconToolbar1
	#tag Event
		Sub Open()
		  Var ImportButton As New BeaconToolbarItem("ImportButton", IconToolbarImport, "Import config files…")
		  Var ExportButton As New BeaconToolbarItem("ExportButton", IconToolbarExport, Self.ReadyToExport, "Save new config files…")
		  #if DeployEnabled
		    Var DeployButton As New BeaconToolbarItem("DeployButton", IconToolbarDeploy, Self.ReadyToExport, "Make config changes live")
		  #endif
		  Var ShareButton As New BeaconToolbarItem("ShareButton", IconToolbarShare, "Copy link to this document")
		  
		  Var HelpButton As New BeaconToolbarItem("HelpButton", IconToolbarHelp, False, "Toggle help panel")
		  
		  Me.LeftItems.Append(ImportButton)
		  Me.LeftItems.Append(ExportButton)
		  #if DeployEnabled
		    Me.LeftItems.Append(DeployButton)
		  #endif
		  Me.LeftItems.Append(ShareButton)
		  
		  Me.RightItems.Append(HelpButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
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
		      Self.ShowAlert("Document sharing is only available to cloud documents", "Use ""Save As…"" under the file menu to save a new copy of this document to the cloud if you would like to use Beacon's sharing features.")
		    Else
		      Self.ShowAlert("Document sharing is only available to cloud documents", "If you would like to use Beacon's sharing features, first save your document using ""Save"" under the file menu.")
		    End If
		  Case "DeployButton"
		    Self.BeginDeploy()
		  End Select
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
		  Var Labels(), Tags() As String
		  Labels.AddRow("Maps")
		  Tags.AddRow("maps")
		  #if DeployEnabled
		    Labels.AddRow("Servers")
		    Tags.AddRow("deployments")
		  #endif
		  Labels.AddRow("Accounts")
		  Tags.AddRow("accounts")
		  
		  Var Names() As String = BeaconConfigs.AllConfigNames
		  For Each Name As String In Names
		    Labels.AddRow(Language.LabelForConfig(Name))
		    Tags.AddRow(Name)
		  Next
		  
		  Labels.SortWith(Tags)
		  
		  For I As Integer = 0 To Labels.LastRowIndex
		    Me.Append(New SourceListItem(Labels(I), Tags(I)))
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
#tag EndViewBehavior
