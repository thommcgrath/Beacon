#tag Window
Begin BeaconSubview DocumentEditorView Implements ObservationKit.Observer,NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      Left            =   0
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
      TabStop         =   True
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   858
      Begin LogoFillCanvas LogoFillCanvas1
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         Caption         =   "Select A Config To Begin"
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         Height          =   487
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   0
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
         Width           =   858
      End
      Begin Canvas OmniNoticeBanner
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         Height          =   31
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   0
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
         Width           =   858
      End
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
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
      Caption         =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   233
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
      Width           =   625
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
      EraseBackground =   True
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
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   60000
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin UITweaks.ResizedPopupMenu ConfigMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   9
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   10
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   215
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Activate()
		  Self.ContentsChanged = Self.Document.Modified
		End Sub
	#tag EndEvent

	#tag Event
		Sub CleanupDiscardedChanges()
		  Self.CleanupAutosave()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged)
		  
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
		  Else
		    DocumentRestoreConfigToDefault.Text = "Restore Config to Default"
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  If Self.mController.Document <> Nil Then
		    Dim DocumentID As Text = Self.mController.Document.DocumentID
		    Dim ConfigName As Text = Preferences.LastUsedConfigName(DocumentID)
		    For I As Integer = 0 To Self.ConfigMenu.ListCount - 1
		      Dim Tag As Variant = Self.ConfigMenu.RowTag(I)
		      If (Tag.Type = Variant.TypeText And Tag.TextValue = ConfigName) Or (Tag.Type = Variant.TypeString And Tag.StringValue = ConfigName) Then
		        Self.ConfigMenu.ListIndex = I
		        Exit For I
		      End If
		    Next
		  End If
		  
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  If Self.mController.CanWrite And Self.mController.URL.Scheme <> Beacon.DocumentURL.TypeTransient Then  
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		    Self.mController.Save(App.Identity)
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
		  
		  Dim File As FolderItem = Self.AutosaveFile(True)
		  If File <> Nil And Self.mController.SaveACopy(Beacon.DocumentURL.URLForFile(File), App.Identity) <> Nil Then
		    Self.AutosaveTimer.Reset
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AutosaveFile(CreateFolder As Boolean = False) As FolderItem
		  If Self.Document = Nil Then
		    Return Nil
		  End If
		  
		  Dim Folder As FolderItem = App.AutosaveFolder(CreateFolder)
		  If Folder = Nil Then
		    Return Nil
		  End If
		  Return Folder.Child(Self.Document.DocumentID + BeaconFileTypes.BeaconDocument.PrimaryExtension)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginDeploy()
		  If Self.mDeployWindow <> Nil And Self.mDeployWindow.Value <> Nil And Self.mDeployWindow.Value IsA DocumentDeployWindow Then
		    DocumentDeployWindow(Self.mDeployWindow.Value).Show()
		  Else
		    Self.Autosave()
		    
		    Dim Win As DocumentDeployWindow = DocumentDeployWindow.Create(Self.Document)
		    If Win <> Nil Then
		      Self.mDeployWindow = New WeakRef(Win)
		      Win.Show()
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginExport()
		  Self.Autosave()
		  
		  DocumentExportWindow.Present(Self, Self.Document)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupAutosave()
		  Dim AutosaveFile As FolderItem = Self.AutosaveFile()
		  If AutosaveFile <> Nil And AutosaveFile.Exists Then
		    AutosaveFile.Delete
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmClose(Callback As BeaconSubview.BringToFrontDelegate) As Boolean
		  If Self.Progress <> BeaconSubview.ProgressNone Then
		    If Callback <> Nil Then
		      Callback.Invoke(Self)
		    End If
		    
		    Self.ShowAlert(Self.Title + " cannot be closed right now because it is busy.", "Wait for the progress indicator at the top of the tab to go away before trying to close it.")
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
		  Self.Title = Controller.Name
		  
		  Self.Panels = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CopyFromDocuments(SourceDocuments As Auto)
		  Dim Documents() As Beacon.Document = SourceDocuments
		  DocumentMergerWindow.Present(Self, Documents, Self.Document, WeakAddressOf MergeCallback)
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
		  
		  Dim ConfigName As Text = Issue.ConfigName
		  For I As Integer = 0 To Self.ConfigMenu.ListCount - 1
		    If Self.ConfigMenu.RowTag(I) = ConfigName Then
		      Self.ConfigMenu.ListIndex = I
		      Exit For I
		    End If
		  Next
		  
		  Dim View As ConfigEditor = Self.CurrentPanel
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
		Private Sub ImportCallback(Documents() As Beacon.Document)
		  Call CallLater.Schedule(0, WeakAddressOf CopyFromDocuments, Documents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteError(Sender As Beacon.DocumentController, Reason As Text)
		  If Not Self.Closed Then
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		  
		  Dim Notification As New Beacon.UserNotification("Uh oh, the document " + Sender.Name + " did not save!")
		  Notification.SecondaryMessage = Reason
		  Notification.UserData = New Xojo.Core.Dictionary
		  Notification.UserData.Value("DocumentID") = If(Sender.Document <> Nil, Sender.Document.DocumentID, "")
		  Notification.UserData.Value("DocumentURL") = Sender.URL.URL // To force convert to text
		  Notification.UserData.Value("Reason") = Reason
		  LocalData.SharedInstance.SaveNotification(Notification)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteSuccess(Sender As Beacon.DocumentController)
		  If Not Self.Closed Then
		    Self.ContentsChanged = Sender.Document <> Nil And Sender.Document.Modified
		    Self.Title = Sender.Name
		    Self.BeaconToolbar1.ShareButton.Enabled = (Sender.URL.Scheme = Beacon.DocumentURL.TypeCloud)
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		  
		  Preferences.AddToRecentDocuments(Sender.URL)
		  
		  If Self.Document = Nil Or Sender.Document.Modified = False Then
		    // Safe to cleanup the autosave
		    Self.CleanupAutosave()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MergeCallback()
		  Dim Keys() As Variant = Self.Panels.Keys
		  For Each Key As Variant In Keys
		    Dim Panel As ConfigEditor = Self.Panels.Value(Key)
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
		    Dim ListIndex As Integer = Self.ConfigMenu.ListIndex
		    Self.ConfigMenu.ListIndex = -1
		    Self.ConfigMenu.ListIndex = ListIndex
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As Text, Value As Auto)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Value
		  
		  Select Case Key
		  Case "MinimumWidth", "MinimumHeight"
		    Self.UpdateMinimumDimensions()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Panel_ContentsChanged(Sender As ConfigEditor)
		  #Pragma Unused Sender
		  
		  Self.ToolbarCaption = Self.mController.Name
		  Self.Title = Self.mController.Name
		  Self.ContentsChanged = Self.Document.Modified
		  Self.BeaconToolbar1.ExportButton.Enabled = Self.ReadyToExport
		  #if DeployEnabled
		    Self.BeaconToolbar1.DeployButton.Enabled = Self.ReadyToDeploy
		  #endif
		  Self.BeaconToolbar1.IssuesButton.Enabled = Not Self.Document.IsValid
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadyToDeploy() As Boolean
		  Return Self.Document <> Nil And Self.Document.IsValid And Self.Document.ServerProfileCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadyToExport() As Boolean
		  Return Self.Document <> Nil And Self.Document.IsValid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveAs()
		  Select Case DocumentSaveToCloudWindow.Present(Self.TrueWindow, Self.mController)
		  Case DocumentSaveToCloudWindow.StateSaved
		    Self.Title = Self.mController.Name
		    Self.ToolbarCaption = Self.mController.Name
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Case DocumentSaveToCloudWindow.StateSaveLocal
		    Dim Dialog As New SaveAsDialog
		    Dialog.SuggestedFileName = Self.mController.Name + BeaconFileTypes.BeaconDocument.PrimaryExtension
		    Dialog.Filter = BeaconFileTypes.BeaconDocument
		    
		    Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If File = Nil Then
		      Return
		    End If
		    
		    If Self.Document.Title.BeginsWith("Untitled Document") Then
		      Dim Filename As Text = File.Name.ToText
		      Dim Extension As Text = BeaconFileTypes.BeaconDocument.PrimaryExtension.ToText
		      If Filename.EndsWith(Extension) Then
		        Filename = Filename.Left(Filename.Length - Extension.Length).Trim
		      End If
		      Self.Document.Title = Filename
		    End If
		    Self.mController.SaveAs(Beacon.DocumentURL.URLForFile(File), App.Identity)
		    Self.Title = Self.mController.Name
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
		  Self.ContentsChanged = Self.Document.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateHelpForConfig(ConfigName As String)
		  Dim Title, Body, DetailURL As String
		  Call LocalData.SharedInstance.GetConfigHelp(ConfigName, Title, Body, DetailURL)
		  Self.HelpDrawer.Title = Title
		  Self.HelpDrawer.Body = Body
		  Self.HelpDrawer.DetailURL = DetailURL
		  Self.BeaconToolbar1.HelpButton.Enabled = Self.mHelpDrawerOpen Or (Self.HelpDrawer.Body <> "")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateMinimumDimensions()
		  Self.MinimumWidth = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumWidth, Self.LocalMinWidth), Self.LocalMinWidth) + If(Self.mHelpDrawerOpen, Self.HelpDrawer.Width, 0)
		  Self.MinimumHeight = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumHeight, Self.LocalMinHeight), Self.LocalMinHeight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Beacon.DocumentURL
		  Return Self.mController.URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewID() As Text
		  Return Self.mController.URL.Hash
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private CurrentPanel As ConfigEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As Beacon.DocumentController
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
		Private Panels As Dictionary
	#tag EndProperty


	#tag Constant, Name = DeployEnabled, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LocalMinHeight, Type = Double, Dynamic = False, Default = \"400", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LocalMinWidth, Type = Double, Dynamic = False, Default = \"500", Scope = Private
	#tag EndConstant

	#tag Constant, Name = OmniWarningText, Type = String, Dynamic = False, Default = \"This config type requires Beacon Omni. Click this banner to learn more.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events OmniNoticeBanner
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim BaseColor As Color = SystemColors.SystemYellowColor
		  Dim BackgroundColor As Color = BaseColor.AtOpacity(0.2)
		  Dim TextColor As Color = SystemColors.LabelColor
		  Dim BorderColor As Color = SystemColors.SeparatorColor
		  
		  G.ForeColor = BackgroundColor
		  G.FillRect(0, 0, G.Width, G.Height - 1)
		  G.ForeColor = BorderColor
		  G.DrawLine(0, G.Height - 1, G.Width, G.Height - 1)
		  
		  Dim TextWidth As Double = G.StringWidth(Self.OmniWarningText)
		  Dim TextLeft As Double = (G.Width - TextWidth) / 2
		  Dim TextBaseline As Double = (G.Height / 2) + (G.CapHeight / 2)
		  G.ForeColor = TextColor
		  G.DrawString(Self.OmniWarningText, TextLeft, TextBaseline, G.Width - 40, True)
		  
		  If Self.mDrawOmniBannerPressed Then
		    G.ForeColor = &c00000080
		    G.FillRect(0, 0, G.Width, G.Height - 1)
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
		  Dim ShouldBePressed As Boolean = X >= 0 And X < Me.Width And Y >= 0 And Y < Me.Height
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
		  Dim ImportButton As New BeaconToolbarItem("ImportButton", IconToolbarImport, "Import config files…")
		  Dim ExportButton As New BeaconToolbarItem("ExportButton", IconToolbarExport, Self.ReadyToExport, "Save new config files…")
		  #if DeployEnabled
		    Dim DeployButton As New BeaconToolbarItem("DeployButton", IconToolbarDeploy, Self.ReadyToDeploy, "Make config changes live")
		  #endif
		  Dim ShareButton As New BeaconToolbarItem("ShareButton", IconToolbarShare, Self.mController.URL.Scheme = Beacon.DocumentURL.TypeCloud, "Copy link to this document")
		  
		  Dim HelpButton As New BeaconToolbarItem("HelpButton", IconToolbarHelp, False, "Toggle help panel")
		  Dim IssuesButton As New BeaconToolbarItem("IssuesButton", IconToolbarIssues, Not Self.Document.IsValid, "Show document issues")
		  IssuesButton.IconColor = BeaconToolbarItem.IconColors.Red
		  
		  Me.LeftItems.Append(ImportButton)
		  Me.LeftItems.Append(ExportButton)
		  #if DeployEnabled
		    Me.LeftItems.Append(DeployButton)
		  #endif
		  Me.LeftItems.Append(ShareButton)
		  Me.LeftItems.Append(IssuesButton)
		  
		  Me.RightItems.Append(HelpButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "ImportButton"
		    If Self.mImportWindowRef <> Nil And Self.mImportWindowRef.Value <> Nil Then
		      DocumentImportWindow(Self.mImportWindowRef.Value).Show()
		    Else
		      Dim OtherDocuments() As Beacon.Document
		      For I As Integer = 0 To Self.mEditorRefs.Count - 1
		        Dim Key As Variant = Self.mEditorRefs.Key(I)
		        Dim Ref As WeakRef = Self.mEditorRefs.Value(Key)
		        If Ref <> Nil And Ref.Value <> Nil And Ref.Value IsA DocumentEditorView And DocumentEditorView(Ref.Value).Document.DocumentID <> Self.Document.DocumentID Then
		          OtherDocuments.Append(DocumentEditorView(Ref.Value).Document)
		        End If
		      Next
		      Self.mImportWindowRef = New WeakRef(DocumentImportWindow.Present(AddressOf ImportCallback, Self.Document, OtherDocuments))
		    End If
		  Case "ExportButton"
		    Self.BeginExport()
		  Case "HelpButton"
		    If Self.mHelpDrawerOpen Then
		      Self.HideHelpDrawer()
		    Else
		      Self.ShowHelpDrawer()
		    End If
		  Case "ShareButton"
		    Dim Board As New Clipboard
		    Board.Text = Self.mController.URL.WithScheme(Beacon.DocumentURL.TypeWeb)
		    
		    Dim Notification As New Beacon.UserNotification("Link to " + Self.mController.Name + " has been copied to the clipboard.")
		    LocalData.SharedInstance.SaveNotification(Notification)
		  Case "DeployButton"
		    Self.BeginDeploy()
		  Case "IssuesButton"
		    Self.ShowIssues()
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
#tag Events ConfigMenu
	#tag Event
		Sub Open()
		  Dim Labels(), Tags() As Text
		  Labels.Append("Maps")
		  Tags.Append("maps")
		  #if DeployEnabled
		    Labels.Append("Servers")
		    Tags.Append("deployments")
		  #endif
		  
		  Dim Names() As Text = BeaconConfigs.AllConfigNames
		  For Each Name As Text In Names
		    Labels.Append(Language.LabelForConfig(Name))
		    Tags.Append(Name)
		  Next
		  
		  Labels.SortWith(Tags)
		  
		  For I As Integer = 0 To Labels.Ubound
		    Me.AddRow(Labels(I), Tags(I))
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Dim Tag As Variant
		  If Me.ListIndex > -1 Then
		    Tag = Me.RowTag(Me.ListIndex)
		  End If
		  Dim NewPanel As ConfigEditor
		  Dim Embed As Boolean
		  If Tag <> Nil And (Tag.Type = Variant.TypeString Or Tag.Type = Variant.TypeText) Then
		    Self.UpdateHelpForConfig(Tag.StringValue)
		    
		    If Self.mController.Document <> Nil Then
		      Preferences.LastUsedConfigName(Self.mController.Document.DocumentID) = Tag.StringValue.ToText
		    End If
		    
		    If Self.Panels.HasKey(Tag.StringValue) Then
		      NewPanel = Self.Panels.Value(Tag.StringValue)
		    Else
		      Select Case Tag.StringValue
		      Case "maps"
		        NewPanel = New MapsConfigEditor(Self.mController)
		      Case "deployments"
		        NewPanel = New ServersConfigEditor(Self.mController)
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
		      End Select
		      If NewPanel <> Nil Then
		        Self.Panels.Value(Tag.StringValue) = NewPanel
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
		    Dim RequiresPurchase As Boolean
		    If Tag <> Nil And (Tag.Type = Variant.TypeString Or Tag.Type = Variant.TypeText) Then
		      RequiresPurchase = Not BeaconConfigs.ConfigPurchased(Tag.TextValue, If(App.Identity <> Nil, App.Identity.OmniVersion, 0))
		    End If
		    Dim TopOffset As Integer
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
		    Self.PagePanel1.Value = 1
		  Else
		    Self.PagePanel1.Value = 0
		  End If
		  
		  Self.UpdateMinimumDimensions()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Progress"
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
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
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
