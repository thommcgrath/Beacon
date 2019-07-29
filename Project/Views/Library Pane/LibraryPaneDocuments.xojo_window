#tag Window
Begin LibrarySubview LibraryPaneDocuments Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   300
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
   Visible         =   True
   Width           =   300
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "22,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      DropIndicatorVisible=   False
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontal=   "0"
      GridLinesHorizontalStyle=   "0"
      GridLinesVertical=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   False
      HasHeading      =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   198
      HelpTag         =   ""
      Hierarchical    =   False
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
      RequiresSelection=   False
      RowCount        =   "0"
      RowSelectionType=   "1"
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionRequired=   False
      SelectionType   =   "1"
      ShowDropIndicator=   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   102
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   300
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BeaconAPI.Socket APISocket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Documents"
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "False"
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
      Width           =   300
   End
   Begin Shelf Switcher
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   "False"
      DrawCaptions    =   True
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   61
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      IsVertical      =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "True"
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
      Top             =   101
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, Preferences.Notification_OnlineStateChanged, IdentityManager.Notification_IdentityChanged, Preferences.Notification_RecentsChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.ToolbarCaption = "Documents"
		  
		  NotificationKit.Watch(Self, Preferences.Notification_OnlineStateChanged, IdentityManager.Notification_IdentityChanged, Preferences.Notification_RecentsChanged)
		  Self.SwitcherVisible = Preferences.OnlineEnabled
		  
		  Dim AutosaveFolder As FolderItem = App.AutosaveFolder()
		  If AutosaveFolder <> Nil Then
		    For I As Integer = 1 To AutosaveFolder.Count
		      Dim File As BookmarkedFolderItem = New BookmarkedFolderItem(AutosaveFolder.Item(I))
		      If Not File.Name.EndsWith(BeaconFileTypes.BeaconDocument.PrimaryExtension) Then
		        Continue
		      End If
		      
		      Dim FileURL As Beacon.DocumentURL = Beacon.DocumentURL.URLForFile(File)
		      App.Log("Attempting to restore autosave " + FileURL.URL)
		      
		      Dim Controller As New Beacon.DocumentController(FileURL, App.IdentityManager.CurrentIdentity)
		      AddHandler Controller.Loaded, AddressOf AutosaveController_Loaded
		      Controller.Load()
		    Next
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_CloudDocumentsList(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Redim Self.mCloudDocuments(-1)
		  
		  If Response.Success Then
		    Dim Dicts() As Variant = Response.JSON
		    For Each Dict As Dictionary In Dicts
		      Dim Document As New BeaconAPI.Document(Dict)
		      Dim URL As String = Beacon.DocumentURL.TypeCloud + "://" + Document.ResourceURL.Middle(Document.ResourceURL.IndexOf("://") + 3)
		      Self.mCloudDocuments.Append(URL)
		    Next
		  End If
		  
		  If Self.View = Self.ViewCloudDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_CommunityDocumentsList(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Redim Self.mCommunityDocuments(-1)
		  
		  If Response.Success Then
		    Dim Dicts() As Variant = Response.JSON
		    For Each Dict As Dictionary In Dicts
		      Dim Document As New BeaconAPI.Document(Dict)
		      Self.mCommunityDocuments.Append(Document.ResourceURL)
		    Next
		  End If
		  
		  If Self.View = Self.ViewCommunityDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod

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
		  Dim Controller As New Beacon.DocumentController(Document, App.IdentityManager.CurrentIdentity)
		  Self.OpenController(Controller)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_DeleteError(Sender As Beacon.DocumentController, Reason As String)
		  Dim Notification As New Beacon.UserNotification("The document " + Sender.Name + " could not be deleted.")
		  Notification.SecondaryMessage = Reason
		  Notification.UserData = New Dictionary
		  Notification.UserData.Value("DocumentID") = If(Sender.Document <> Nil, Sender.Document.DocumentID, "")
		  Notification.UserData.Value("DocumentURL") = Sender.URL.URL // To force convert to text
		  Notification.UserData.Value("Reason") = Reason
		  LocalData.SharedInstance.SaveNotification(Notification)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_DeleteSuccess(Sender As Beacon.DocumentController)
		  Dim URL As Beacon.DocumentURL = Sender.URL
		  
		  For I As Integer = Self.List.RowCount - 1 DownTo 0
		    If Self.List.RowTag(I) = URL Then
		      Self.List.RemoveRow(I)
		    End If
		  Next
		  
		  Select Case URL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    For I As Integer = Self.mCloudDocuments.Ubound DownTo 0
		      If Self.mCloudDocuments(I) = URL Then
		        Self.mCloudDocuments.Remove(I)
		        Exit For I
		      End If
		    Next
		  Case Beacon.DocumentURL.TypeWeb
		    For I As Integer = Self.mCommunityDocuments.Ubound DownTo 0
		      If Self.mCommunityDocuments(I) = URL Then
		        Self.mCommunityDocuments.Remove(I)
		        Exit For I
		      End If
		    Next
		  End Select
		  
		  Dim Recents() As Beacon.DocumentURL = Preferences.RecentDocuments
		  For I As Integer = Recents.Ubound DownTo 0
		    If Recents(I) = URL Then
		      Recents.Remove(I)
		      Exit For I
		    End If
		  Next
		  Preferences.RecentDocuments = Recents // Will trigger a notification, which updates the list
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_Loaded(Sender As Beacon.DocumentController, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  Self.DetachControllerEvents(Sender)
		  
		  Dim URL As Beacon.DocumentURL = Sender.URL
		  Select Case URL.Scheme
		  Case Beacon.DocumentURL.TypeLocal, Beacon.DocumentURL.TypeTransient
		    Self.View = Self.ViewRecentDocuments
		  Case Beacon.DocumentURL.TypeCloud
		    Self.View = Self.ViewCloudDocuments
		  Case Beacon.DocumentURL.TypeWeb
		    Self.View = Self.ViewCommunityDocuments
		  End Select
		  Self.SelectDocument(URL)
		  
		  Dim View As New DocumentEditorView(Sender)
		  View.Changed = Sender.Document.Modified
		  Self.ShowView(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadError(Sender As Beacon.DocumentController, Reason As String)
		  #Pragma Unused Reason
		  
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  Self.DetachControllerEvents(Sender)
		  
		  Dim RecentIdx As Integer = -1
		  Dim Recents() As Beacon.DocumentURL = Preferences.RecentDocuments
		  For I As Integer = 0 To Recents.Ubound
		    If Recents(I) = Sender.URL Then
		      RecentIdx = I
		      Exit For I
		    End If
		  Next
		  
		  If RecentIdx > -1 Then
		    If Self.ShowConfirm("Unable to load """ + Sender.Name + """", "The document could not be loaded. It may have been deleted. Would you like to remove it from the recent documents list?", "Remove", "Keep") Then
		      Recents.Remove(RecentIdx)
		      Preferences.RecentDocuments = Recents
		    End If
		  Else
		    Self.ShowAlert("Unable to load """ + Sender.Name + """", "The document could not be loaded. It may have been deleted.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadProgress(Sender As Beacon.DocumentController, BytesReceived As Int64, BytesTotal As Int64)
		  #Pragma Unused Sender
		  
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Progress = BytesReceived / BytesTotal
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadStarted(Sender As Beacon.DocumentController)
		  If Self.mProgress = Nil Then
		    Self.mProgress = New DocumentDownloadWindow
		    Self.mProgress.URL = Sender.URL
		    Self.mProgress.Progress = -1
		    Self.mProgress.ShowWithin(Self.TrueWindow)
		  End If
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
		Sub ImportFile(File As FolderItem)
		  Call DocumentImportWindow.Present(AddressOf NewDocuments, New Beacon.Document, File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewDocument(Document As Beacon.Document = Nil)
		  If Document = Nil Then
		    Document = New Beacon.Document
		    
		    Static NewDocumentNumber As Integer = 1
		    Document.Title = "Untitled Document " + NewDocumentNumber.ToString
		    Document.Modified = False
		    NewDocumentNumber = NewDocumentNumber + 1
		  End If
		  
		  Self.OpenController(New Beacon.DocumentController(Document, App.IdentityManager.CurrentIdentity))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewDocuments(Documents() As Beacon.Document)
		  For Each Document As Beacon.Document In Documents
		    Self.NewDocument(Document)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case "Beacon.Document.TitleChanged", Preferences.Notification_RecentsChanged
		    Self.UpdateDocumentsList()
		  Case IdentityManager.Notification_IdentityChanged
		    If Self.View = Self.ViewCloudDocuments Then
		      Self.UpdateCloudDocuments()
		    End If
		  Case Preferences.Notification_OnlineStateChanged
		    Self.SwitcherVisible = Preferences.OnlineEnabled
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenController(Controller As Beacon.DocumentController)
		  Dim URL As Beacon.DocumentURL = Controller.URL
		  Dim View As BeaconSubview = Self.View(URL.Hash)
		  If View <> Nil Then
		    Self.ShowView(View)
		    Return
		  End If
		  
		  Self.AttachControllerEvents(Controller)
		  Controller.Load()
		  
		  Preferences.AddToRecentDocuments(URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenFile(File As FolderItem)
		  Dim URL As Beacon.DocumentURL = Beacon.DocumentURL.URLForFile(New BookmarkedFolderItem(File))
		  Self.OpenController(New Beacon.DocumentController(URL, App.IdentityManager.CurrentIdentity))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenURL(URL As Beacon.DocumentURL)
		  Self.OpenController(New Beacon.DocumentController(URL, App.IdentityManager.CurrentIdentity))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SelectDocument(Document As Beacon.DocumentURL)
		  For I As Integer = Self.List.RowCount - 1 DownTo 0
		    Self.List.Selected(I) = Beacon.DocumentURL(Self.List.RowTag(I)) = Document
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedDocuments() As Beacon.DocumentURL()
		  Dim Documents() As Beacon.DocumentURL
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(I) Then
		      Documents.Append(Self.List.RowTag(I))
		    End If
		  Next
		  Return Documents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedDocuments(Assigns Documents() As Beacon.DocumentURL)
		  Dim Selected() As String
		  For Each URL As Beacon.DocumentURL In Documents
		    Selected.Append(URL)
		  Next
		  
		  For I As Integer = 0 To Self.List.RowCount - 1
		    Dim URL As String = Beacon.DocumentURL(Self.List.RowTag(I))
		    Self.List.Selected(I) = Selected.IndexOf(URL) > -1
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowOpenDocument()
		  Dim Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.BeaconDocument + BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.BeaconIdentity
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File <> Nil Then
		    App.OpenDocument(File)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCloudDocuments()
		  If App.IdentityManager.CurrentIdentity <> Nil Then
		    Dim Params As New Dictionary
		    Params.Value("user_id") = App.IdentityManager.CurrentIdentity.Identifier
		    
		    Dim Request As New BeaconAPI.Request("document.php", "GET", Params, AddressOf APICallback_CloudDocumentsList)
		    Request.Sign(App.IdentityManager.CurrentIdentity)
		    Self.APISocket.Start(Request)
		  Else
		    Redim Self.mCloudDocuments(-1)
		  End If
		  
		  If Self.View = Self.ViewCloudDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCommunityDocuments()
		  Dim Params As New Dictionary
		  
		  // Do not sign this request so we get only truly public documents
		  Dim Request As New BeaconAPI.Request("document.php", "GET", Params, AddressOf APICallback_CommunityDocumentsList)
		  Self.APISocket.Start(Request)
		  
		  If Self.View = Self.ViewCommunityDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateDocumentsList()
		  Dim View As Integer = Self.Switcher.SelectedIndex
		  Dim Documents() As Beacon.DocumentURL
		  Select Case View
		  Case Self.ViewRecentDocuments
		    Documents = Preferences.RecentDocuments
		  Case Self.ViewCloudDocuments
		    Documents = Self.mCloudDocuments
		  Case Self.ViewCommunityDocuments
		    Documents = Self.mCommunityDocuments
		  End Select
		  
		  Dim RowBound As Integer = Self.List.RowCount - 1
		  Dim SelectedURLs() As String
		  For I As Integer = 0 To RowBound
		    If Self.List.Selected(I) Then
		      Dim URL As Beacon.DocumentURL = Self.List.RowTag(I)
		      SelectedURLs.Append(URL)
		    End If
		  Next
		  
		  Self.List.RowCount = Documents.Ubound + 1
		  
		  For I As Integer = 0 To Documents.Ubound
		    Dim URL As Beacon.DocumentURL = Documents(I)
		    Self.List.Cell(I, Self.ColumnName) = URL.Name
		    Self.List.RowTag(I) = URL
		    Self.List.Selected(I) = SelectedURLs.IndexOf(URL) > -1
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldResize(ByRef NewSize As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCloudDocuments() As Beacon.DocumentURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommunityDocuments() As Beacon.DocumentURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As DocumentDownloadWindow
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.Switcher.Visible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.Switcher.Visible = Value Then
			    Return
			  End If
			  
			  Self.Switcher.Visible = Value
			  Dim Top As Integer = Self.Switcher.Top
			  If Value Then
			    Top = Top + Self.Switcher.Height
			  End If
			  
			  Self.FadedSeparator1.Top = Top
			  Self.List.Top = Self.FadedSeparator1.Top + Self.FadedSeparator1.Height
			  Self.List.Height = Self.Height - Self.List.Top
			End Set
		#tag EndSetter
		Private SwitcherVisible As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.Switcher.SelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.Closed Then
			    Return
			  End If
			  
			  If Self.Switcher.SelectedIndex <> Value Then
			    Self.Switcher.SelectedIndex = Value
			  End If
			  
			  Select Case Value
			  Case Self.ViewCloudDocuments
			    Self.UpdateCloudDocuments()
			  Case Self.ViewCommunityDocuments
			    Self.UpdateCommunityDocuments()
			  Else
			    Self.UpdateDocumentsList()
			  End Select
			End Set
		#tag EndSetter
		View As Integer
	#tag EndComputedProperty


	#tag Constant, Name = ColumnIcon, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ViewCloudDocuments, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ViewCommunityDocuments, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ViewRecentDocuments, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub DoubleClick()
		  For I As Integer = Self.List.RowCount - 1 DownTo 0
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Self.OpenURL(Beacon.DocumentURL(Self.List.RowTag(I)))
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case 0
		    Dim Row1URL As Beacon.DocumentURL = Me.RowTag(Row1)
		    Dim Row2URL As Beacon.DocumentURL = Me.RowTag(Row2)
		    
		    Result = Row1URL.Name.Compare(Row2URL.Name)
		    
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  If Me.SelectedRowCount = 0 Then
		    Return False
		  End If
		  
		  If Self.View = Self.ViewRecentDocuments Then
		    Return True
		  Else
		    For I As Integer = Me.RowCount - 1 DownTo 0
		      If Not Me.Selected(I) Then
		        Continue For I
		      End If
		      
		      Dim Controller As New Beacon.DocumentController(Beacon.DocumentURL(Me.RowTag(I)), App.IdentityManager.CurrentIdentity)
		      If Not Controller.CanWrite Then
		        Return False
		      End If
		    Next
		    
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  // Temporary and local can be deleted directly
		  // User cloud can be deleted via api
		  // Community cloud cannot be deleted
		  
		  If Self.View = Self.ViewRecentDocuments Then
		    // Not deleting something, just removing from the list
		    Dim Recents() As Beacon.DocumentURL = Preferences.RecentDocuments
		    Dim Changed As Boolean
		    For I As Integer = Me.RowCount - 1 DownTo 0
		      If Not Me.Selected(I) Then
		        Continue For I
		      End If
		      
		      Dim SelectedURL As Beacon.DocumentURL = Me.RowTag(I)
		      For X As Integer = Recents.Ubound DownTo 0
		        If Recents(X) = SelectedURL Then
		          Changed = True
		          Recents.Remove(X)
		          Continue For I
		        End If
		      Next
		    Next
		    If Changed Then
		      Preferences.RecentDocuments = Recents
		    End If
		    Return
		  End If
		  
		  Dim Controllers() As Beacon.DocumentController
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue For I
		    End If
		    
		    Dim URL As Beacon.DocumentURL = Me.RowTag(I)
		    Dim Controller As New Beacon.DocumentController(URL, App.IdentityManager.CurrentIdentity)
		    If Controller.CanWrite() Then
		      Controllers.Append(Controller)
		    End If
		  Next
		  
		  If Warn Then
		    Dim Message, Explanation As String
		    If Controllers.Ubound = 0 Then
		      Message = "Are you sure you want to delete the document """ + Controllers(0).Name + """?"
		    Else
		      Message = "Are you sure you want to delete these " + Str(Controllers.Ubound + 1, "-0") + " documents?"
		    End If
		    Explanation = "Files will be deleted immediately and cannot be recovered."
		    
		    If Not Self.ShowConfirm(Message, Explanation, "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For Each Controller As Beacon.DocumentController In Controllers
		    Dim View As BeaconSubview = Self.View(Controller.URL.Hash)
		    If View <> Nil Then
		      If Not Self.DiscardView(View) Then
		        Continue
		      End If
		    End If
		    
		    AddHandler Controller.DeleteSuccess, AddressOf Controller_DeleteSuccess
		    AddHandler Controller.DeleteError, AddressOf Controller_DeleteError
		    
		    Controller.Delete()
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused G
		  #Pragma Unused Row
		  #Pragma Unused Line
		  #Pragma Unused TextColor
		  #Pragma Unused HorizontalPosition
		  #Pragma Unused VerticalPosition
		  #Pragma Unused IsHighlighted
		  
		  Return Column = Self.ColumnIcon
		End Function
	#tag EndEvent
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  
		  If Column <> Self.ColumnIcon Or Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Dim URL As Beacon.DocumentURL = Me.RowTag(Row)
		  If URL = Nil Then
		    Return
		  End If
		  
		  Dim IconColor As Color = TextColor.AtOpacity(0.5)
		  Dim Icon As Picture
		  Select Case URL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    Icon = BeaconUI.IconWithColor(IconCloudDocument, IconColor)
		  Case Beacon.DocumentURL.TypeWeb
		    Icon = BeaconUI.IconWithColor(IconCommunityDocument, IconColor)
		  End Select
		  
		  If Icon = Nil Then
		    Return
		  End If
		  
		  G.DrawPicture(Icon, (Me.Column(Column).WidthActual - Icon.Width) / 2, (Me.DefaultRowHeight - Icon.Height) / 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("Add", IconToolbarAdd, "Start a new Beacon document."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  RaiseEvent ShouldResize(NewSize)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "Add"
		    Self.NewDocument()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconRecentDocuments, "Recent", "recent")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconCloudDocuments, "Cloud", "cloud")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconCommunityDocuments, "Community", "community")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = Self.ViewRecentDocuments
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.View = Me.SelectedIndex
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="LockRight"
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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="View"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
