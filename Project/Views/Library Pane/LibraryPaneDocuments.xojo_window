#tag Window
Begin LibrarySubview LibraryPaneDocuments
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "*,22"
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
      Height          =   259
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
      Top             =   41
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
      CaptionEnabled  =   True
      CaptionIsButton =   False
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      HasResizer      =   True
      Height          =   41
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
   Begin Xojo.Net.HTTPSocket Downloader
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
      ValidateCertificates=   False
   End
   Begin Beacon.ImportThread Importer
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   0
      Scope           =   2
      StackSize       =   ""
      State           =   ""
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.UpdateLocalDocuments()
		  Self.UpdateUserDocuments()
		  Self.UpdateCommunityDocuments()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddDocuments(Documents() As Beacon.DocumentRef, ClearAllOfType As DocumentTypes)
		  Dim Selected() As Beacon.DocumentRef = Self.SelectedDocuments
		  
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
		    Dim Ref As Beacon.DocumentRef = Self.List.RowTag(I)
		    Dim Type As DocumentTypes = Self.DocumentType(Ref)
		    If Type = ClearAllOfType Then
		      Self.List.RemoveRow(I)
		    End If
		  Next
		  
		  For Each Ref As Beacon.DocumentRef In Documents
		    Dim Index As Integer = -1
		    Dim Priority As Integer = CType(Self.DocumentType(Ref), Integer)
		    
		    For I As Integer = Self.List.ListCount - 1 DownTo 0
		      Dim OtherRef As Beacon.DocumentRef = Self.List.RowTag(I)
		      If OtherRef.DocumentID = Ref.DocumentID Then
		        Dim OtherPriority As Integer = CType(Self.DocumentType(OtherRef), Integer)
		        If Priority < OtherPriority Then
		          Index = I
		          Exit For I
		        Else
		          Continue For Ref
		        End If
		      End If
		    Next
		    
		    If Index = -1 Then
		      Self.List.AddRow("")
		      Index = Self.List.LastIndex
		    End If
		    
		    Self.List.Cell(Index, 0) = Ref.Name
		    Self.List.RowTag(Index) = Ref
		  Next
		  
		  Self.List.Sort
		  Self.SelectedDocuments = Selected
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AdvanceDownloadQueue()
		  If Self.mDownloadQueue.Ubound = -1 Or Self.mDownloadQueueRunning Then
		    Return
		  End If
		  
		  Dim URL As Text = Self.mDownloadQueue(0)
		  Self.mDownloadQueue.Remove(0)
		  Self.mDownloadQueueRunning = True
		  Self.Downloader.ValidateCertificates = True
		  Self.Downloader.Send("GET", URL)
		  
		  Self.mDownloadProgress = New DocumentDownloadWindow
		  Self.mDownloadProgress.URL = URL
		  Self.mDownloadProgress.ShowWithin(Self.TrueWindow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_CommunityDocumentsList(Success As Boolean, Message As Text, Details As Auto)
		  #Pragma Unused Message
		  
		  If Not Success Then
		    Return
		  End If
		  
		  Dim Dicts() As Auto = Details
		  Dim Documents() As BeaconAPI.Document
		  For Each Dict As Xojo.Core.Dictionary In Dicts
		    Documents.Append(New BeaconAPI.Document(Dict))
		  Next
		  
		  Self.AddDocuments(Documents, DocumentTypes.CommunityCloud)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentDelete(Success As Boolean, Message As Text, Details As Auto)
		  #Pragma Unused Details
		  
		  If Success Then
		    Return
		  End If
		  
		  Self.ShowAlert("Cloud document was not deleted", Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_UserDocumentsList(Success As Boolean, Message As Text, Details As Auto)
		  #Pragma Unused Message
		  
		  If Not Success Then
		    Return
		  End If
		  
		  Dim Dicts() As Auto = Details
		  Dim Documents() As BeaconAPI.Document
		  For Each Dict As Xojo.Core.Dictionary In Dicts
		    Documents.Append(New BeaconAPI.Document(Dict))
		  Next
		  
		  Self.AddDocuments(Documents, DocumentTypes.UserCloud)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CancelImport()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mViews = New Xojo.Core.Dictionary
		  Self.mDocumentURLs = New Xojo.Core.Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DocumentType(Document As Beacon.DocumentRef) As DocumentTypes
		  If Document IsA LocalDocumentRef Then
		    Return DocumentTypes.Local
		  End If
		  
		  If Document IsA BeaconAPI.Document Then
		    If BeaconAPI.Document(Document).UserID = App.Identity.Identifier Then
		      Return DocumentTypes.UserCloud
		    Else
		      Return DocumentTypes.CommunityCloud
		    End If
		  End If
		  
		  If Document IsA TemporaryDocumentRef Then
		    Return DocumentTypes.Temporary
		  End If
		  
		  Return DocumentTypes.Unknown
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishImport(Sources() As Beacon.LootSource)
		  If UBound(Sources) = -1 Then
		    Self.ShowAlert("No loot sources imported.", "The file contained no loot sources.")
		    Return
		  End If
		  
		  Dim Document As Beacon.Document = Self.mImportedRef.Document
		  Dim GuessedMap As Beacon.Map = Beacon.Maps.GuessMap(Sources)
		  If GuessedMap <> Document.Map Then
		    If Self.ShowConfirm(GuessedMap.Name + " may be a better map selection. Would you like to change your settings?", "Beacon will only import loot sources which are valid for the selected map.", "Change Settings", "Keep Importing") Then
		      Dim OriginalMap As Beacon.Map = Document.Map
		      Document.Map = GuessedMap
		      If Not DocumentSetupSheet.Present(Self, Document, DocumentSetupSheet.Modes.Edit) Then
		        Document.Map = OriginalMap
		      End If
		    End If
		  End If
		  
		  For Each Source As Beacon.LootSource In Sources
		    If Source.ValidForMap(Document.Map) Then
		      Document.Add(Source)
		    End If
		  Next
		  If Document.BeaconCount = 0 Then
		    Self.ShowAlert("Nothing imported", "No loot sources were imported for the selected map.")
		    Return
		  End If
		  
		  Self.mTempDocuments.Append(Self.mImportedRef)
		  Self.AddDocuments(Self.mTempDocuments, DocumentTypes.Temporary)
		  Self.SelectDocument(Self.mImportedRef)
		  
		  Dim View As New DocumentEditorView(Self.mImportedRef, Document)
		  View.ContentsChanged = True
		  Self.mViews.Value(Document.Identifier) = View
		  Self.ShowView(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFile(File As FolderItem)
		  Dim Ref As New TemporaryDocumentRef
		  If DocumentSetupSheet.Present(Self, Ref.Document, DocumentSetupSheet.Modes.Import) Then
		    Self.mImportedRef = Ref
		    
		    Self.mImportProgress = New ImporterWindow
		    Self.mImportProgress.Source = File.DisplayName
		    Self.mImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		    Self.mImportProgress.ShowWithin(Self.TrueWindow)
		    
		    Self.Importer.Run(File)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewDocument()
		  Dim Ref As New TemporaryDocumentRef
		  If DocumentSetupSheet.Present(Self, Ref.Document, DocumentSetupSheet.Modes.Create) Then
		    Self.mTempDocuments.Append(Ref)
		    
		    Self.AddDocuments(Self.mTempDocuments, DocumentTypes.Temporary)
		    Self.SelectDocument(Ref)
		    Self.OpenDocument(Ref)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenDocument(Ref As Beacon.DocumentRef)
		  If Self.mViews <> Nil And Self.mViews.HasKey(Ref.DocumentID) Then
		    Dim View As BeaconSubview = Self.mViews.Value(Ref.DocumentID)
		    Self.ShowView(View)
		    Return
		  End If
		  
		  If Ref IsA LocalDocumentRef Then
		    Self.OpenLocalDocument(LocalDocumentRef(Ref))
		    Return
		  End If
		  
		  If Ref IsA BeaconAPI.Document Then
		    Self.OpenURL(BeaconAPI.Document(Ref).ResourceURL)
		    Return
		  End If
		  
		  If Ref IsA TemporaryDocumentRef Then
		    Dim View As New DocumentEditorView(Ref, TemporaryDocumentRef(Ref).Document)
		    Self.mViews.Value(Ref.DocumentID) = View
		    Self.ShowView(View)
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenFile(File As FolderItem)
		  // See if the file is already open
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mViews
		    Dim View As DocumentEditorView = Entry.Value
		    If View <> Nil And View.File <> Nil And View.File.NativePath = File.NativePath Then
		      Self.ShowView(View)
		      Return
		    End If
		  Next
		  
		  // Nope, load it
		  Dim Document As Beacon.Document = Beacon.Document.Read(File)
		  If Document = Nil Then
		    Return
		  End If
		  
		  Dim Ref As New LocalDocumentRef(File, Document.Identifier, Document.Title)
		  LocalData.SharedInstance.RememberDocument(Ref)
		  Self.UpdateLocalDocuments()
		  
		  Dim View As New DocumentEditorView(Ref, Document)
		  Self.mViews.Value(Document.Identifier) = View
		  Self.ShowView(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenLocalDocument(Ref As LocalDocumentRef)
		  Dim Document As Beacon.Document = Beacon.Document.Read(Ref.File)
		  If Document = Nil Then
		    Return
		  End If
		  
		  LocalData.SharedInstance.RememberDocument(Ref)
		  Self.UpdateLocalDocuments()
		  
		  Dim View As New DocumentEditorView(Ref, Document)
		  Self.mViews.Value(Ref.DocumentID) = View
		  Self.ShowView(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenURL(URL As Text)
		  // First determine if this url is already loaded
		  If Self.mDocumentURLs <> Nil And Self.mDocumentURLs.HasKey(URL) Then
		    Dim DocumentID As Text = Self.mDocumentURLs.Value(URL)
		    If Self.mViews <> Nil And Self.mViews.HasKey(DocumentID) Then
		      Self.ShowView(Self.mViews.Value(DocumentID))
		      Return
		    Else
		      Self.mDocumentURLs.Remove(URL)
		    End If
		  End If
		  
		  // Nope, let's download it
		  If Self.mDownloadQueue.IndexOf(URL) = -1 Then
		    Self.mDownloadQueue.Append(URL)
		    If Self.mDownloadQueue.Ubound = 0 Then
		      Self.AdvanceDownloadQueue()
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SelectDocument(Document As Beacon.DocumentRef)
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
		    Self.List.Selected(I) = Beacon.DocumentRef(Self.List.RowTag(I)).DocumentID = Document.DocumentID
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedDocuments() As Beacon.DocumentRef()
		  Dim Refs() As Beacon.DocumentRef
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Self.List.Selected(I) Then
		      Refs.Append(Self.List.RowTag(I))
		    End If
		  Next
		  Return Refs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedDocuments(Assigns Refs() As Beacon.DocumentRef)
		  Dim Selected() As Text
		  For Each Ref As Beacon.DocumentRef In Refs
		    Selected.Append(Ref.DocumentID)
		  Next
		  
		  For I As Integer = 0 To Self.List.ListCount - 1
		    Dim Ref As Beacon.DocumentRef = Self.List.RowTag(I)
		    Self.List.Selected(I) = Selected.IndexOf(Ref.DocumentID) > -1
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCommunityDocuments()
		  Dim Params As New Xojo.Core.Dictionary
		  
		  Dim Request As New BeaconAPI.Request("document.php", "GET", Params, AddressOf APICallback_CommunityDocumentsList)
		  Request.Sign(App.Identity)
		  Self.APISocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateLocalDocuments()
		  Dim Documents() As LocalDocumentRef = LocalData.SharedInstance.LocalDocuments
		  If Documents.Ubound = -1 Then
		    Dim Files() As FolderItem = App.RecentDocuments
		    For Each File As FolderItem In Files
		      If File <> Nil And File.Exists Then
		        Dim Ref As LocalDocumentRef = LocalDocumentRef.Import(File)
		        If Ref <> Nil Then
		          LocalData.SharedInstance.RememberDocument(Ref)
		        End If
		      End If
		    Next
		    Documents = LocalData.SharedInstance.LocalDocuments
		  End If
		  
		  Self.AddDocuments(Documents, DocumentTypes.Local)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateTempDocuments()
		  Self.AddDocuments(Self.mTempDocuments, DocumentTypes.Temporary)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUserDocuments()
		  Dim Params As New Xojo.Core.Dictionary
		  Params.Value("user_id") = App.Identity.Identifier
		  
		  Dim Request As New BeaconAPI.Request("document.php", "GET", Params, AddressOf APICallback_UserDocumentsList)
		  Request.Sign(App.Identity)
		  Self.APISocket.Start(Request)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldResize(ByRef NewSize As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDocumentURLs As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadProgress As DocumentDownloadWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadQueue() As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadQueueRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportedRef As TemporaryDocumentRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportProgress As ImporterWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempDocuments() As TemporaryDocumentRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViews As Xojo.Core.Dictionary
	#tag EndProperty


	#tag Enum, Name = DocumentTypes, Type = Integer, Flags = &h21
		Unknown
		  Temporary
		  Local
		  UserCloud
		CommunityCloud
	#tag EndEnum


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub DoubleClick()
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Ref As Beacon.DocumentRef = Self.List.RowTag(I)
		    Self.OpenDocument(Ref)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case 0
		    Dim Row1Ref As Beacon.DocumentRef = Me.RowTag(Row1)
		    Dim Row2Ref As Beacon.DocumentRef = Me.RowTag(Row2)
		    
		    Dim Row1Value As Integer = CType(Self.DocumentType(Row1Ref), Integer)
		    Dim Row2Value As Integer = CType(Self.DocumentType(Row2Ref), Integer)
		    
		    If Row1Value > Row2Value Then
		      Result = 1
		    ElseIf Row1Value < Row2Value Then
		      Result = -1
		    Else
		      Result = Row1Ref.Name.Compare(Row2Ref.Name)
		    End If
		    
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean) As Boolean
		  If Column <> 1 Then
		    Return False
		  End If
		  
		  If Row >= Me.ListCount Then
		    Return False
		  End If
		  
		  Dim Ref As Beacon.DocumentRef = Me.RowTag(Row)
		  Dim Type As DocumentTypes = Self.DocumentType(Ref)
		  Dim Icon As Picture
		  
		  Select Case Type
		  Case DocumentTypes.CommunityCloud
		    Icon = IconDocumentCommunity
		  Case DocumentTypes.UserCloud
		    Icon = IconDocumentCloud
		  End Select
		  
		  If Icon = Nil Then
		    Return False
		  End If
		  
		  Icon = BeaconUI.IconWithColor(Icon, RGB(TextColor.Red, TextColor.Green, TextColor.Blue, 64))
		  G.DrawPicture(Icon, (G.Width - Icon.Width) / 2, (Me.DefaultRowHeight - Icon.Height) / 2)
		  Return True
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
		    
		    Dim Ref As Beacon.DocumentRef = Me.RowTag(I)
		    Dim Type As DocumentTypes = Self.DocumentType(Ref)
		    
		    Select Case Type
		    Case DocumentTypes.Unknown, DocumentTypes.CommunityCloud
		      Return False
		    End Select
		  Next
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  // Temporary and local can be deleted directly
		  // User cloud can be deleted via api
		  // Community cloud cannot be deleted
		  
		  Dim Documents() As Beacon.DocumentRef
		  
		  For I As Integer = Me.ListCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
		      Continue For I
		    End If
		    
		    Dim Ref As Beacon.DocumentRef = Me.RowTag(I)
		    Dim Type As DocumentTypes = Self.DocumentType(Ref)
		    
		    Select Case Type
		    Case DocumentTypes.Local, DocumentTypes.Temporary, DocumentTypes.UserCloud
		      Documents.Append(Ref)
		    End Select
		  Next
		  
		  If Warn Then
		    Dim Message, Explanation As String
		    If Documents.Ubound = 0 Then
		      Message = "Are you sure you want to delete this document?"
		    Else
		      Message = "Are you sure you want to delete these " + Str(Documents.Ubound + 1, "-0") + " documents?"
		    End If
		    Explanation = "Files will be deleted immediately and cannot be recovered."
		    
		    If Not Self.ShowConfirm(Message, Explanation, "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Dim UpdateLocal, UpdateCloud, UpdateTemps As Boolean
		  For Each Ref As Beacon.DocumentRef In Documents
		    Dim DocumentID As Text = Ref.DocumentID
		    Dim View As DocumentEditorView
		    If Self.mViews.HasKey(DocumentID) Then
		      View = Self.mViews.Value(DocumentID)
		    End If
		    
		    If View <> Nil Then
		      If View.ContentsChanged Then
		        Break
		      End If
		      
		      Self.DiscardView(View)
		    End If
		    
		    If Ref IsA LocalDocumentRef Then
		      LocalDocumentRef(Ref).File.Delete
		      LocalData.SharedInstance.ForgetDocument(LocalDocumentRef(Ref))
		      UpdateLocal = True
		    ElseIf Ref IsA BeaconAPI.Document Then
		      Dim Request As New BeaconAPI.Request(BeaconAPI.Document(Ref).ResourceURL, "DELETE", AddressOf APICallback_DocumentDelete)
		      Request.Sign(App.Identity)
		      Self.APISocket.Start(Request)
		      
		      UpdateCloud = True
		    ElseIf Ref IsA TemporaryDocumentRef Then
		      For I As Integer = Self.mTempDocuments.Ubound DownTo 0
		        If Self.mTempDocuments(I).DocumentID = Ref.DocumentID Then
		          Self.mTempDocuments.Remove(I)
		          UpdateTemps = True
		        End If
		      Next
		    End If
		  Next
		  
		  If UpdateCloud Then
		    Self.UpdateUserDocuments()
		  End If
		  If UpdateLocal Then
		    Self.UpdateLocalDocuments()
		  End If
		  If UpdateTemps Then
		    Self.UpdateTempDocuments()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Open()
		  Dim Item As BeaconToolbarItem
		  
		  Item = New BeaconToolbarItem("Add", IconToolbarNew)
		  Item.HelpTag = "Start a new Beacon document."
		  Me.LeftItems.Append(Item)
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
#tag Events Downloader
	#tag Event
		Sub Error(err as RuntimeException)
		  Self.mDownloadQueueRunning = False
		  Self.AdvanceDownloadQueue()
		End Sub
	#tag EndEvent
	#tag Event
		Sub HeadersReceived(URL as Text, HTTPStatus as Integer)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub PageReceived(URL as Text, HTTPStatus as Integer, Content as xojo.Core.MemoryBlock)
		  #Pragma Unused URL
		  #Pragma Unused HTTPStatus
		  
		  If Self.mDownloadProgress <> Nil Then
		    Self.mDownloadProgress.Close
		    Self.mDownloadProgress = Nil
		  End If
		  
		  Self.mDownloadQueueRunning = False
		  Self.AdvanceDownloadQueue()
		  
		  Dim TextValue As Text
		  Try
		    TextValue = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  Catch Err As RuntimeException
		    // Cannot be converted
		    Self.ShowAlert("Cannot open document", "Sorry, not sure what was downloaded, but it isn't a UTF8 data.")
		    Return
		  End Try
		  
		  Dim Document As Beacon.Document = Beacon.Document.Read(TextValue)
		  If Document = Nil Then
		    // Cannot be parsed correctly
		    Self.ShowAlert("Cannot open document", "Sorry, not sure what was downloaded, but it isn't a Beacon document.")
		    Return
		  End If
		  
		  Self.mDocumentURLs.Value(URL) = Document.Identifier
		  
		  Dim DocumentRef As Beacon.DocumentRef
		  For I As Integer = Self.List.ListCount - 1 DownTo 0
		    Dim Ref As Beacon.DocumentRef = Self.List.RowTag(I)
		    If Ref.DocumentID = Document.Identifier Then
		      DocumentRef = Ref
		      Exit For I
		    End If
		  Next
		  
		  If DocumentRef = Nil Then
		    DocumentRef = New TemporaryDocumentRef(Document)
		    Self.mTempDocuments.Append(TemporaryDocumentRef(DocumentRef))
		    
		    Self.AddDocuments(Self.mTempDocuments, DocumentTypes.Temporary)
		    Self.SelectDocument(DocumentRef)
		  End If
		  
		  Dim View As New DocumentEditorView(DocumentRef, Document)
		  Self.mViews.Value(Document.Identifier) = View
		  Self.ShowView(View)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ReceiveProgress(BytesReceived as Int64, TotalBytes as Int64, NewData as xojo.Core.MemoryBlock)
		  If Self.mDownloadProgress <> Nil Then
		    Self.mDownloadProgress.Progress = BytesReceived / TotalBytes
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If Me.LootSourcesProcessed = Me.BeaconCount Then
		    If Self.mImportProgress <> Nil Then
		      Self.mImportProgress.Close
		      Self.mImportProgress = Nil
		    End If
		    
		    Self.FinishImport(Me.LootSources)
		    Return
		  ElseIf Self.mImportProgress <> Nil Then
		    Self.mImportProgress.BeaconCount = Me.BeaconCount
		    Self.mImportProgress.LootSourcesProcessed = Me.LootSourcesProcessed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
