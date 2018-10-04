#tag Window
Begin LibrarySubview LibraryPaneDocuments Implements NotificationKit.Receiver
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
   UseFocusRing    =   False
   Visible         =   True
   Width           =   300
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   "*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
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
      RowCount        =   0
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   1
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
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Documents"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
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
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
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
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      DrawCaptions    =   True
      Enabled         =   True
      EraseBackground =   True
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
      Scope           =   0
      ScrollSpeed     =   20
      TabIndex        =   0
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
      TabIndex        =   3
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
		Sub Close()
		  NotificationKit.Ignore(Self, Preferences.Notification_OnlineStateChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  #if false
		    Self.UpdateLocalDocuments()
		    Self.UpdateCloudDocuments()
		    Self.UpdateCommunityDocuments()
		  #endif
		  
		  Self.ToolbarIcon = IconDocuments
		  Self.ToolbarCaption = "Documents"
		  
		  NotificationKit.Watch(Self, Preferences.Notification_OnlineStateChanged)
		  Self.SwitcherVisible = Preferences.OnlineEnabled
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_CloudDocumentsList(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused Message
		  
		  If Not Success Then
		    Return
		  End If
		  
		  Dim Dicts() As Auto = Details
		  For I As Integer = Self.mDocuments.Ubound DownTo 0
		    If Self.mDocuments(I).Scheme = Beacon.DocumentURL.TypeCloud Then
		      Self.mDocuments.Remove(I)
		    End If
		  Next
		  For Each Dict As Xojo.Core.Dictionary In Dicts
		    Dim Document As New BeaconAPI.Document(Dict)
		    Dim URL As Text = Beacon.DocumentURL.TypeCloud + "://" + Document.ResourceURL.Mid(Document.ResourceURL.IndexOf("://") + 3)
		    
		    Self.mDocuments.Append(URL)
		  Next
		  
		  If Self.View = Self.ViewCloudDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_CommunityDocumentsList(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused Message
		  
		  If Not Success Then
		    Return
		  End If
		  
		  Dim Dicts() As Auto = Details
		  For I As Integer = Self.mDocuments.Ubound DownTo 0
		    If Self.mDocuments(I).Scheme = Beacon.DocumentURL.TypeWeb Then
		      Self.mDocuments.Remove(I)
		    End If
		  Next
		  For Each Dict As Xojo.Core.Dictionary In Dicts
		    Dim Document As New BeaconAPI.Document(Dict)
		    Self.mDocuments.Append(Document.ResourceURL)
		  Next
		  
		  If Self.View = Self.ViewCommunityDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentDelete(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused Details
		  
		  If Success Then
		    If Self.View = Self.ViewCloudDocuments Then
		      Self.UpdateDocumentsList()
		    End If
		    Return
		  End If
		  
		  If Self.View = Self.ViewCloudDocuments Then
		    Self.UpdateCloudDocuments()
		  End If
		  
		  Self.ShowAlert("Cloud document was not deleted", Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_DeleteError(Sender As Beacon.DocumentController)
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_DeleteSuccess(Sender As Beacon.DocumentController)
		  Dim URL As Beacon.DocumentURL = Sender.URL
		  
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
		    If Self.List.RowTag(I) = URL Then
		      Self.List.RemoveRow(I)
		    End If
		  Next
		  
		  For I As Integer = Self.mDocuments.Ubound DownTo 0
		    If Self.mDocuments(I) = URL Then
		      Self.mDocuments.Remove(I)
		    End If
		  Next
		  
		  LocalData.SharedInstance.ForgetDocument(URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_Loaded(Sender As Beacon.DocumentController, Document As Beacon.Document)
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  RemoveHandler Sender.Loaded, WeakAddressOf Controller_Loaded
		  RemoveHandler Sender.LoadError, WeakAddressOf Controller_LoadError
		  RemoveHandler Sender.LoadProgress, WeakAddressOf Controller_LoadProgress
		  
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
		  View.ContentsChanged = Sender.Document.Modified
		  Self.ShowView(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadError(Sender As Beacon.DocumentController)
		  If Sender.URL.Scheme = Beacon.DocumentURL.TypeLocal Then
		    LocalData.SharedInstance.ForgetDocument(Sender)
		    Self.UpdateDocumentsList()
		  End If
		  
		  Self.ShowAlert("Unable to load " + Sender.Name, "The document may no longer exist so it has been removed from this list.")
		  
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Controller_LoadProgress(Sender As Beacon.DocumentController, BytesReceived As Int64, BytesTotal As Int64)
		  If Self.mProgress = Nil Then
		    Self.mProgress = New DocumentDownloadWindow
		    Self.mProgress.URL = Sender.URL
		    Self.mProgress.ShowWithin(Self.TrueWindow)
		  End If
		  
		  Self.mProgress.Progress = BytesReceived / BytesTotal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFile(File As FolderItem)
		  Call DocumentImportWindow.Present(AddressOf NewDocument, New Beacon.Document, File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewDocument(Document As Beacon.Document = Nil)
		  If Document = Nil Then
		    Document = New Beacon.Document
		    
		    Static NewDocumentNumber As Integer = 1
		    Document.Title = "Untitled Document " + NewDocumentNumber.ToText
		    Document.Modified = False
		    NewDocumentNumber = NewDocumentNumber + 1
		  End If
		  
		  Self.OpenController(New Beacon.DocumentController(Document))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case "Beacon.Document.TitleChanged"
		    Dim Document As Beacon.Document = Notification.UserData
		    Break
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
		  
		  //Self.mDocuments.Append(URL)
		  
		  AddHandler Controller.Loaded, WeakAddressOf Controller_Loaded
		  AddHandler Controller.LoadError, WeakAddressOf Controller_LoadError
		  AddHandler Controller.LoadProgress, WeakAddressOf Controller_LoadProgress
		  Controller.Load(App.Identity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenFile(File As FolderItem)
		  Dim URL As Beacon.DocumentURL = Beacon.DocumentURL.URLForFile(File)
		  Self.OpenController(New Beacon.DocumentController(URL))
		  LocalData.SharedInstance.RememberDocument(URL)
		  Self.UpdateLocalDocuments()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenURL(URL As Beacon.DocumentURL)
		  Self.OpenController(New Beacon.DocumentController(URL))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SelectDocument(Document As Beacon.DocumentURL)
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
		    Self.List.Selected(I) = Beacon.DocumentURL(Self.List.RowTag(I)) = Document
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedDocuments() As Beacon.DocumentURL()
		  Dim Documents() As Beacon.DocumentURL
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Self.List.Selected(I) Then
		      Documents.Append(Self.List.RowTag(I))
		    End If
		  Next
		  Return Documents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedDocuments(Assigns Documents() As Beacon.DocumentURL)
		  Dim Selected() As Text
		  For Each URL As Beacon.DocumentURL In Documents
		    Selected.Append(URL)
		  Next
		  
		  For I As Integer = 0 To Self.List.ListCount - 1
		    Dim URL As Text = Beacon.DocumentURL(Self.List.RowTag(I))
		    Self.List.Selected(I) = Selected.IndexOf(URL) > -1
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowOpenDocument()
		  Dim Dialog As New OpenDialog
		  Dialog.Filter = BeaconFileTypes.BeaconDocument + BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File <> Nil Then
		    App.OpenDocument(File)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCloudDocuments()
		  Dim Params As New Xojo.Core.Dictionary
		  Params.Value("user_id") = App.Identity.Identifier
		  
		  Dim Request As New BeaconAPI.Request("document.php", "GET", Params, AddressOf APICallback_CloudDocumentsList)
		  Request.Sign(App.Identity)
		  Self.APISocket.Start(Request)
		  
		  If Self.View = Self.ViewCloudDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCommunityDocuments()
		  Dim Params As New Xojo.Core.Dictionary
		  
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
		  For Each Document As Beacon.DocumentURL In Self.mDocuments
		    If (View = Self.ViewRecentDocuments And (Document.Scheme = Beacon.DocumentURL.TypeLocal Or Document.Scheme = Beacon.DocumentURL.TypeTransient)) Or (View = Self.ViewCloudDocuments And Document.Scheme = Beacon.DocumentURL.TypeCloud) Or (View = Self.ViewCommunityDocuments And Document.Scheme = Beacon.DocumentURL.TypeWeb) Then
		      Documents.Append(Document)
		    End If
		  Next
		  
		  Dim RowBound As Integer = Self.List.ListCount - 1
		  Dim SelectedURLs() As Text
		  For I As Integer = 0 To RowBound
		    If Self.List.Selected(I) Then
		      Dim URL As Beacon.DocumentURL = Self.List.RowTag(I)
		      SelectedURLs.Append(URL)
		    End If
		  Next
		  
		  Self.List.RowCount = Documents.Ubound + 1
		  
		  For I As Integer = 0 To Documents.Ubound
		    Dim URL As Beacon.DocumentURL = Documents(I)
		    Self.List.Cell(I, 0) = URL.Name
		    Self.List.RowTag(I) = URL
		    Self.List.Selected(I) = SelectedURLs.IndexOf(URL) > -1
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLocalDocuments()
		  Dim Documents() As Beacon.DocumentURL = LocalData.SharedInstance.LocalDocuments
		  If Documents.Ubound = -1 Then
		    Dim Files() As FolderItem = App.RecentDocuments
		    For Each File As FolderItem In Files
		      If File <> Nil And File.Exists Then
		        Dim URL As Beacon.DocumentURL = Beacon.DocumentURL.URLForFile(File)
		        LocalData.SharedInstance.RememberDocument(URL)
		        Documents.Append(URL)
		      End If
		    Next
		  End If
		  
		  For I As Integer = Self.mDocuments.Ubound DownTo 0
		    If Self.mDocuments(I).Scheme = Beacon.DocumentURL.TypeLocal Then
		      Self.mDocuments.Remove(I)
		    End If
		  Next
		  For I As Integer = 0 To Documents.Ubound
		    Self.mDocuments.Append(Documents(I))
		  Next
		  
		  If Self.View = Self.ViewRecentDocuments Then
		    Self.UpdateDocumentsList()
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldResize(ByRef NewSize As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDocuments() As Beacon.DocumentURL
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
			  If Self.Switcher.SelectedIndex <> Value Then
			    Self.Switcher.SelectedIndex = Value
			  End If
			  
			  Select Case Value
			  Case Self.ViewRecentDocuments
			    Self.UpdateLocalDocuments()
			  Case Self.ViewCloudDocuments
			    Self.UpdateCloudDocuments()
			  Case Self.ViewCommunityDocuments
			    Self.UpdateCommunityDocuments()
			  End Select
			End Set
		#tag EndSetter
		View As Integer
	#tag EndComputedProperty


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
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
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
		  If Me.SelCount = 0 Then
		    Return False
		  End If
		  
		  For I As Integer = Me.ListCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue For I
		    End If
		    
		    Dim Controller As New Beacon.DocumentController(Beacon.DocumentURL(Me.RowTag(I)))
		    If Not Controller.CanWrite Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  // Temporary and local can be deleted directly
		  // User cloud can be deleted via api
		  // Community cloud cannot be deleted
		  
		  Dim Controllers() As Beacon.DocumentController
		  For I As Integer = Me.ListCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue For I
		    End If
		    
		    Dim URL As Beacon.DocumentURL = Me.RowTag(I)
		    Dim Controller As New Beacon.DocumentController(URL)
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
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
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="View"
		Group="Behavior"
		Type="Integer"
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
	#tag EndViewProperty
#tag EndViewBehavior
