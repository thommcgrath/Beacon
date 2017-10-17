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
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
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
      SelectionType   =   0
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

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mViews = New Xojo.Core.Dictionary
		  Self.mDocumentURLs = New Xojo.Core.Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DocumentOpenCallback(Ref As Beacon.DocumentRef, Document As Beacon.Document)
		  Break
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

	#tag Method, Flags = &h0
		Sub NewDocument()
		  //DocumentSetupSheet.ShowCreate(Self.TrueWindow)
		  
		  Dim Arr(0) As Beacon.DocumentRef
		  Arr(0) = New TemporaryDocumentRef
		  Self.AddDocuments(Arr, DocumentTypes.Unknown)
		  Self.OpenDocument(Arr(0))
		  Self.SelectedDocuments = Arr
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
		Private mDownloadQueue() As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadQueueRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViews As Xojo.Core.Dictionary
	#tag EndProperty


	#tag Enum, Name = DocumentTypes, Type = Integer, Flags = &h21
		Unknown
		  Local
		  UserCloud
		  CommunityCloud
		Temporary
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
		  
		  Dim Win As New DocWindow(Document)
		  Win.Show
		End Sub
	#tag EndEvent
	#tag Event
		Sub ReceiveProgress(BytesReceived as Int64, TotalBytes as Int64, NewData as xojo.Core.MemoryBlock)
		  
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
