#tag Window
Begin BeaconSubview DocumentEditorView Implements ObservationKit.Observer
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
      Top             =   41
      Transparent     =   False
      Value           =   0
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
   Begin BeaconPopupMenu ConfigMenu
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Config Types"
      Count           =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      LastIndex       =   0
      Left            =   9
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   9
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   215
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
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Activate()
		  Self.ContentsChanged = Self.Document.Modified
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
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
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  If Self.mController.CanWrite And Self.mController.URL.Scheme <> Beacon.DocumentURL.TypeTransient Then
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
			Call Self.SaveAs()
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub BeginDeploy()
		  If Self.mDeployWindow <> Nil And Self.mDeployWindow.Value <> Nil And Self.mDeployWindow.Value IsA DocumentDeployWindow Then
		    DocumentDeployWindow(Self.mDeployWindow.Value).Show()
		  Else
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
		  DocumentExportWindow.Present(Self, Self.Document)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As Beacon.DocumentController)
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
		  For I As Integer = 0 To Self.ConfigMenu.Count - 1
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
		  Xojo.Core.Timer.CallLater(1, WeakAddressOf CopyFromDocuments, Documents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteError(Sender As Beacon.DocumentController, Reason As Text)
		  Dim Notification As New Beacon.UserNotification("Uh oh, the document " + Sender.Name + " did not save!")
		  Notification.SecondaryMessage = Reason
		  Notification.UserData = New Xojo.Core.Dictionary
		  Notification.UserData.Value("DocumentID") = Sender.Document.DocumentID
		  Notification.UserData.Value("DocumentURL") = Sender.URL
		  Notification.UserData.Value("Reason") = Reason
		  LocalData.SharedInstance.SaveNotification(Notification)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WriteSuccess(Sender As Beacon.DocumentController)
		  Self.ContentsChanged = Sender.Document.Modified
		  Self.Title = Self.mController.Name
		  Self.BeaconToolbar1.ShareButton.Enabled = (Self.mController.URL.Scheme = Beacon.DocumentURL.TypeCloud)
		  LocalData.SharedInstance.RememberDocument(Sender)
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHelpDrawerAnimation_Completed(Sender As AnimationKit.MoveTask)
		  #Pragma Unused Sender
		  
		  If Not Self.mHelpDrawerOpen Then
		    Self.HelpDrawer.Visible = False
		    Self.BeaconToolbar1.HelpButton.Enabled = (Self.CurrentPanel <> Nil And Self.HelpDrawer.Body <> "")
		    Self.MinimumWidth = If(Self.CurrentPanel <> Nil, Max(Self.CurrentPanel.MinimumWidth, Self.LocalMinWidth), Self.LocalMinWidth)
		  End If
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
		  
		  Self.ContentsChanged = Self.Document.Modified
		  Self.BeaconToolbar1.ExportButton.Enabled = Self.ReadyToExport
		  #if DeployEnabled
		    Self.BeaconToolbar1.DeployButton.Enabled = Self.ReadyToDeploy
		  #endif
		  
		  Self.BeaconToolbar1.IssuesButton.Enabled = Not Self.Document.IsValid
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadyForCloud() As Boolean
		  If Not Preferences.OnlineEnabled Then
		    Return False
		  End If
		  
		  Return (Self.mController.URL.Scheme <> Beacon.DocumentURL.TypeCloud And Self.mController.URL.Scheme <> Beacon.DocumentURL.TypeWeb)
		End Function
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
		  If Self.ReadyForCloud And DocumentSaveToCloudWindow.Present(Self.TrueWindow, Self.mController) Then
		    Self.Title = Self.mController.Name
		    Return
		  End If
		  
		  Dim Dialog As New SaveAsDialog
		  Dialog.SuggestedFileName = Self.mController.Name + BeaconFileTypes.BeaconDocument.PrimaryExtension
		  Dialog.Filter = BeaconFileTypes.BeaconDocument
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File = Nil Then
		    Return
		  End If
		  
		  If Self.Title.BeginsWith("Untitled Document") Then
		    Dim Filename As Text = File.Name.ToText
		    If Filename.EndsWith(".beacon") Then
		      Filename = Filename.Left(Filename.Length - 7).Trim
		    End If
		    Self.Document.Title = Filename
		  End If
		  Self.mController.SaveAs(Beacon.DocumentURL.TypeLocal + "://" + File.NativePath.ToText, App.Identity)
		  Self.Title = Self.mController.Name
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


#tag EndWindowCode

#tag Events ConfigMenu
	#tag Event
		Sub Open()
		  Me.AddRow("Maps", "maps")
		  #if DeployEnabled
		    Me.AddRow("Servers", "deployments")
		  #endif
		  
		  Dim Names() As Text = BeaconConfigs.AllConfigNames
		  For Each Name As Text In Names
		    Me.AddRow(Language.LabelForConfig(Name), Name)
		  Next
		  
		  Me.Sort
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Dim Tag As Variant = Me.Tag
		  Dim NewPanel As ConfigEditor
		  Dim Embed As Boolean
		  If Tag <> Nil And (Tag.Type = Variant.TypeString Or Tag.Type = Variant.TypeText) Then
		    Self.UpdateHelpForConfig(Tag.StringValue)
		    
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
		    If Embed Then
		      AddHandler Self.CurrentPanel.ContentsChanged, WeakAddressOf Panel_ContentsChanged
		      Self.CurrentPanel.EmbedWithinPanel(Self.PagePanel1, 1, 0, 0, Self.PagePanel1.Width, Self.PagePanel1.Height)
		    End If
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
#tag Events BeaconToolbar1
	#tag Event
		Sub Open()
		  Dim ImportButton As New BeaconToolbarItem("ImportButton", IconToolbarImport, "Import config files…")
		  Dim ExportButton As New BeaconToolbarItem("ExportButton", IconToolbarExport, Self.ReadyToExport, "Save new config files…")
		  #if DeployEnabled
		    Dim DeployButton As New BeaconToolbarItem("DeployButton", IconToolbarDeploy, Self.ReadyToDeploy, "Make config changes live.")
		  #endif
		  Dim ShareButton As New BeaconToolbarItem("ShareButton", IconToolbarShare, Self.mController.URL.Scheme = Beacon.DocumentURL.TypeCloud, "Copy link to this document")
		  
		  Dim HelpButton As New BeaconToolbarItem("HelpButton", IconToolbarHelp, False, "Toggle help panel.")
		  Dim IssuesButton As New BeaconToolbarItem("IssuesButton", IconToolbarIssues, Not Self.Document.IsValid, "Show document issues.")
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
		      Self.mImportWindowRef = New WeakRef(DocumentImportWindow.Present(AddressOf ImportCallback, Self.Document))
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
#tag ViewBehavior
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
		Name="ToolbarIcon"
		Group="Behavior"
		Type="Picture"
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
