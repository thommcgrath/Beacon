#tag Window
Begin BeaconPagedSubview DocumentsComponent
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
   Height          =   570
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
   Width           =   896
   Begin OmniBar Nav
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   38
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
      Width           =   896
   End
   Begin PagePanel Views
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   532
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   38
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   896
      Begin RecentDocumentsComponent RecentDocumentsComponent1
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
         Height          =   532
         InitialParent   =   "Views"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Recents"
         Visible         =   True
         Width           =   896
      End
      Begin CloudDocumentsComponent CloudDocumentsComponent1
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
         Height          =   532
         InitialParent   =   "Views"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Cloud"
         Visible         =   True
         Width           =   896
      End
      Begin CommunityDocumentsComponent CommunityDocumentsComponent1
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
         Height          =   532
         InitialParent   =   "Views"
         IsFrontmost     =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Progress        =   0.0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Community"
         Visible         =   True
         Width           =   896
      End
   End
   Begin Timer AutosavePromptTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   2000
      RunMode         =   1
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function GetPagePanel() As PagePanel
		  Return Self.Views
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.AppendPage(Self.RecentDocumentsComponent1)
		  Self.AppendPage(Self.CloudDocumentsComponent1)
		  Self.AppendPage(Self.CommunityDocumentsComponent1)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReviewChanges(NumPages As Integer, ByRef ShouldClose As Boolean, ByRef ShouldFocus As Boolean)
		  Var Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "You have " + NumPages.ToString + " projects with unsaved changes. Do you want to review these changes before quitting?"
		  Dialog.Explanation = "If you don't review your projects, all your changes will be lost."
		  Dialog.ActionButton.Caption = "Review Changes…"
		  Dialog.CancelButton.Visible = True
		  Dialog.AlternateActionButton.Caption = "Discard Changes"
		  Dialog.AlternateActionButton.Visible = True
		  
		  Var Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		  Select Case Choice
		  Case Dialog.ActionButton
		    ShouldClose = False
		    ShouldFocus = True
		  Case Dialog.CancelButton
		    ShouldClose = False
		    ShouldFocus = False
		  Case Dialog.AlternateActionButton
		    ShouldClose = True
		    ShouldFocus = False // Doesn't matter
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AttachControllerEvents(Controller As Beacon.DocumentController)
		  AddHandler Controller.Loaded, WeakAddressOf Controller_Loaded
		  AddHandler Controller.LoadError, WeakAddressOf Controller_LoadError
		  AddHandler Controller.LoadProgress, WeakAddressOf Controller_LoadProgress
		  AddHandler Controller.LoadStarted, WeakAddressOf Controller_LoadStarted
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AutosaveController_Loaded(Sender As Beacon.DocumentController, Document As Beacon.Document)
		  RemoveHandler Sender.Loaded, AddressOf AutosaveController_Loaded
		  
		  // Create a modified transient document
		  Document.Modified = True
		  Var Controller As New Beacon.DocumentController(Document, App.IdentityManager.CurrentIdentity)
		  Controller.AutosaveURL = Sender.URL
		  Self.OpenController(Controller, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AutosaveController_LoadError(Sender As Beacon.DocumentController, Reason As String)
		  App.Log("Failed to restore autosave file: " + Reason)
		  Sender.Delete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_Loaded(Sender As Beacon.DocumentController, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Self.DetachControllerEvents(Sender)
		  
		  Var View As New DocumentEditorView(Sender)
		  View.Changed = Sender.Document.Modified
		  View.LinkedOmniBarItem = Self.Nav.Item(Sender.URL.Hash)
		  View.LinkedOmniBarItem.CanBeClosed = True
		  View.LinkedOmniBarItem.HasUnsavedChanges = View.Changed
		  
		  Select Case Sender.URL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    View.ViewIcon = IconCloudDocument
		  Case Beacon.DocumentURL.TypeWeb
		    View.ViewIcon = IconCommunityDocument
		  End Select
		  
		  // Self.Views.AddPanel
		  // Var PanelIndex As Integer = Self.Views.LastAddedPanelIndex
		  // View.EmbedWithinPanel(Self.Views, PanelIndex, 0, 0, Self.Views.Width, Self.Views.Height)
		  
		  Self.AppendPage(View)
		  Self.CurrentPage = View
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadError(Sender As Beacon.DocumentController, Reason As String)
		  #Pragma Unused Reason
		  
		  Self.DetachControllerEvents(Sender)
		  
		  Var NavItem As OmniBarItem = Self.Nav.Item(Sender.URL.Hash)
		  If (NavItem Is Nil) = False Then
		    Self.Nav.Remove(NavItem)
		  End If
		  
		  Var RecentIdx As Integer = -1
		  Var Recents() As Beacon.DocumentURL = Preferences.RecentDocuments
		  For I As Integer = 0 To Recents.LastIndex
		    If Recents(I) = Sender.URL Then
		      RecentIdx = I
		      Exit For I
		    End If
		  Next
		  
		  If RecentIdx > -1 Then
		    If Self.ShowConfirm("Unable to load """ + Sender.Name + """", "The project could not be loaded. It may have been deleted. Would you like to remove it from the recent projects list?", "Remove", "Keep") Then
		      Recents.RemoveAt(RecentIdx)
		      Preferences.RecentDocuments = Recents
		    End If
		  Else
		    Self.ShowAlert("Unable to load """ + Sender.Name + """", "The project could not be loaded. It may have been deleted.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadProgress(Sender As Beacon.DocumentController, BytesReceived As Int64, BytesTotal As Int64)
		  #Pragma Unused Sender
		  
		  Var NavItem As OmniBarItem = Self.Nav.Item(Sender.URL.Hash)
		  If (NavItem Is Nil) = False Then
		    NavItem.Progress = BytesReceived / BytesTotal
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadStarted(Sender As Beacon.DocumentController)
		  Var NavItem As OmniBarItem = Self.Nav.Item(Sender.URL.Hash)
		  If NavItem Is Nil Then
		    Return
		  End If
		  
		  NavItem.HasProgressIndicator = True
		  NavItem.Progress = OmniBarItem.ProgressIndeterminate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DetachControllerEvents(Controller As Beacon.DocumentController)
		  RemoveHandler Controller.Loaded, WeakAddressOf Controller_Loaded
		  RemoveHandler Controller.LoadError, WeakAddressOf Controller_LoadError
		  RemoveHandler Controller.LoadProgress, WeakAddressOf Controller_LoadProgress
		  RemoveHandler Controller.LoadStarted, WeakAddressOf Controller_LoadStarted
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DiscardView(View As BeaconSubview) As Boolean
		  If (View IsA DocumentEditorView) = False Then
		    Return False
		  End If
		  
		  Var Page As DocumentEditorView = DocumentEditorView(View)
		  If Not Page.ConfirmClose(AddressOf ShowView) Then
		    Return False
		  End If
		  
		  Var NavItem As OmniBarItem = Page.LinkedOmniBarItem
		  If (NavItem Is Nil) = False Then
		    Self.Nav.Remove(NavItem)
		  End If
		  
		  Self.RemovePage(Page)
		  Page.Close
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentEditors() As DocumentEditorView()
		  Var Editors() As DocumentEditorView
		  Var Bound As Integer = Self.PageCount - 1
		  For Idx As Integer = 0 To Bound
		    Var Page As BeaconSubview = Self.Page(Idx)
		    If Page IsA DocumentEditorView Then
		      Editors.Add(DocumentEditorView(Page))
		    End If
		  Next
		  Return Editors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFile(File As FolderItem)
		  Call DocumentImportWindow.Present(WeakAddressOf LoadImportedDocuments, New Beacon.Document, File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadImportedDocuments(Documents() As Beacon.Document)
		  For Each Document As Beacon.Document In Documents
		    Self.NewDocument(Document)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewDocument(Document As Beacon.Document = Nil)
		  If Document Is Nil Then
		    Document = New Beacon.Document
		    
		    Static NewDocumentNumber As Integer = 1
		    Document.Title = "Untitled Project " + NewDocumentNumber.ToString
		    Document.Modified = False
		    NewDocumentNumber = NewDocumentNumber + 1
		  End If
		  
		  Var Controller As New Beacon.DocumentController(Document, App.IdentityManager.CurrentIdentity)
		  Var NavItem As OmniBarItem = OmniBarItem.CreateTab(Controller.URL.Hash, Controller.Name)
		  NavItem.IsFlexible = True
		  Self.Nav.Append(NavItem)
		  
		  Self.AttachControllerEvents(Controller)
		  
		  Controller.Load()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenController(Controller As Beacon.DocumentController, AddToRecents As Boolean = True)
		  Var NavItem As OmniBarItem = OmniBarItem.CreateTab(Controller.URL.Hash, Controller.Name)
		  NavItem.IsFlexible = True
		  Self.Nav.Append(NavItem)
		  
		  Self.AttachControllerEvents(Controller)
		  
		  Controller.Load()
		  
		  If AddToRecents Then
		    Preferences.AddToRecentDocuments(Controller.URL)
		  End If
		  
		  Self.RequestFrontmost()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenDocument(URL As Beacon.DocumentURL, AddToRecents As Boolean = True)
		  Var Hash As String = URL.Hash
		  Var NavItem As OmniBarItem = Self.Nav.Item(Hash)
		  If (NavItem Is Nil) = False Then
		    // We've already started loading this item
		    For Idx As Integer = 0 To Self.LastPageIndex
		      Var Page As BeaconSubview = Self.Page(Idx)
		      If Page.LinkedOmniBarItem = NavItem Then
		        Self.CurrentPage = Page
		        Return
		      End If
		    Next
		    
		    Return
		  End If
		  
		  Var Controller As New Beacon.DocumentController(URL, App.IdentityManager.CurrentIdentity)
		  Self.OpenController(Controller, AddToRecents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenDocument(File As FolderItem, AddToRecents As Boolean = True)
		  Var URL As Beacon.DocumentURL = Beacon.DocumentURL.URLForFile(New BookmarkedFolderItem(File))
		  Self.OpenDocument(URL, AddToRecents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RestoreAutosave()
		  Var AutosaveFolder As FolderItem = App.AutosaveFolder()
		  If AutosaveFolder Is Nil Then
		    Return
		  End If
		  
		  Var Extension As String = Beacon.FileExtensionProject
		  Var Files() As FolderItem
		  For Each Child As FolderItem In AutosaveFolder.Children
		    If Child.Name.EndsWith(Extension) Then
		      Files.Add(Child)
		    End If
		  Next
		  
		  If Files.Count = 0 Then
		    Return
		  End If
		  
		  If Self.ShowConfirm("Beacon found " + Language.NounWithQuantity(Files.Count, "unsaved document", "unsaved documents") + ". Would you like to recover the " + If(Files.Count = 1, "file", "files") + "?", "This can happen if Beacon finishes unexpectedly, such as during a crash. If the " + If(Files.Count = 1, "file is", "files are") + " not restored, " + If(Files.Count = 1, "it", "they") + " will be permanently deleted.", "Recover", "Discard") Then
		    For Idx As Integer = 0 To Files.LastIndex
		      Var File As BookmarkedFolderItem = New BookmarkedFolderItem(Files(Idx))
		      
		      Var FileURL As Beacon.DocumentURL = Beacon.DocumentURL.URLForFile(File)
		      App.Log("Attempting to restore autosave " + FileURL.URL(Beacon.DocumentURL.URLTypes.Reading))
		      
		      Var Controller As New Beacon.DocumentController(FileURL, App.IdentityManager.CurrentIdentity)
		      AddHandler Controller.Loaded, AddressOf AutosaveController_Loaded
		      AddHandler Controller.LoadError, AddressOf AutosaveController_LoadError
		      Controller.Load()
		    Next
		  Else
		    For Idx As Integer = Files.LastIndex DownTo 0
		      Var File As BookmarkedFolderItem = New BookmarkedFolderItem(Files(Idx))
		      
		      Try
		        File.Remove
		      Catch Err As IOException
		      End Try
		    Next
		  End If
		End Sub
	#tag EndMethod


	#tag Constant, Name = PageCloud, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageCommunity, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageRecents, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Nav
	#tag Event
		Sub Open()
		  Var Recents As OmniBarItem = OmniBarItem.CreateTab("NavRecents", "Recents")
		  Var Cloud As OmniBarItem = OmniBarItem.CreateTab("NavCloud", "Cloud")
		  Var Community As OmniBarItem = OmniBarItem.CreateTab("NavCommunity", "Community")
		  
		  Recents.Toggled = True
		  
		  Me.Append(Recents, Cloud, Community)
		  
		  Self.RecentDocumentsComponent1.LinkedOmniBarItem = Recents
		  Self.CloudDocumentsComponent1.LinkedOmniBarItem = Cloud
		  Self.CommunityDocumentsComponent1.LinkedOmniBarItem = Community
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  For Idx As Integer = 0 To Self.LastPageIndex
		    Var Page As BeaconSubview = Self.Page(Idx)
		    If Page.LinkedOmniBarItem = Item Then
		      Self.CurrentPageID = Page.ViewID
		      Return
		    End If
		  Next
		  
		  Self.ShowAlert(Item.Caption + " is still loading", "Sit tight, the file is loading. Older projects will take longer to load than normal, but will load faster than ever once saved in the new format.")
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldCloseItem(Item As OmniBarItem)
		  For Idx As Integer = 0 To Self.LastPageIndex
		    Var Page As BeaconSubview = Self.Page(Idx)
		    If Page.LinkedOmniBarItem = Item Then
		      Call Self.DiscardView(Page)
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Views
	#tag Event
		Sub Change()
		  Var CurrentPage As BeaconSubview = Self.CurrentPage
		  Var CurrentItemName As String
		  If (CurrentPage Is Nil) = False And (CurrentPage.LinkedOmniBarItem Is Nil) = False Then
		    CurrentItemName = CurrentPage.LinkedOmniBarItem.Name
		  End If
		  For Idx As Integer = 0 To Self.Nav.LastIndex
		    Self.Nav.Item(Idx).Toggled = (Self.Nav.Item(Idx).Name = CurrentItemName)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RecentDocumentsComponent1
	#tag Event
		Sub OpenDocument(URL As Beacon.DocumentURL)
		  Self.OpenDocument(URL)
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewDocument()
		  Self.NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CloudDocumentsComponent1
	#tag Event
		Sub OpenDocument(URL As Beacon.DocumentURL)
		  Self.OpenDocument(URL)
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewDocument()
		  Self.NewDocument()
		End Sub
	#tag EndEvent
	#tag Event
		Function CloseDocument(URL As Beacon.DocumentURL) As Boolean
		  Var Hash As String = URL.Hash
		  Var NavItem As OmniBarItem = Self.Nav.Item(Hash)
		  If NavItem Is Nil Then
		    // Document is not open
		    Return True
		  End If
		  
		  For Idx As Integer = 0 To Self.LastPageIndex
		    Var Page As BeaconSubview = Self.Page(Idx)
		    If Page.LinkedOmniBarItem <> NavItem Then
		      Continue
		    End If
		    
		    Return Self.DiscardView(Page)
		  Next
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events CommunityDocumentsComponent1
	#tag Event
		Sub OpenDocument(URL As Beacon.DocumentURL)
		  Self.OpenDocument(URL)
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewDocument()
		  Self.NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutosavePromptTimer
	#tag Event
		Sub Action()
		  Self.RestoreAutosave()
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
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
#tag EndViewBehavior
