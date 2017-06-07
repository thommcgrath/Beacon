#tag Window
Begin DeveloperView DeveloperDocumentsView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
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
   Width           =   1100
   Begin APISocket Socket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin UITweaks.ResizedPopupMenu ViewMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Recently Updated\nMost Downloaded\nMy Documents"
      Italic          =   False
      Left            =   464
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   172
   End
   Begin Listbox DocList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   5
      ColumnsResizable=   False
      ColumnWidths    =   "200,*,80,140,80"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   339
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Description	Downloads	Updated	Revision"
      Italic          =   False
      Left            =   20
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   60
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1060
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton OpenButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Open"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton PublishButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Publish"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   1000
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton DeleteButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Delete"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   204
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton ShareButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Share"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   112
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
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Resized()
		  Self.Resize
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentDelete(Success As Boolean, Message As Text, Details As Auto)
		  If Success Then
		    Self.RefreshDocuments()
		    Return
		  End If
		  
		  Self.ShowAlert("Document was not deleted", Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentsList(Success As Boolean, Message As Text, Details As Auto)
		  Dim Dicts() As Auto = Details
		  Dim Documents() As APIDocument
		  For Each Dict As Xojo.Core.Dictionary In Dicts
		    Documents.Append(New APIDocument(Dict))
		  Next
		  
		  Self.ShowDocuments(Documents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshDocuments()
		  Dim Params As New Xojo.Core.Dictionary
		  Select Case ViewMenu.ListIndex
		  Case 0
		    Params.Value("sort") = "last_updated"
		    Params.Value("direction") = "desc"
		  Case 1
		    Params.Value("sort") = "download_count"
		    Params.Value("direction") = "desc"
		  Case 2
		    Params.Value("user_id") = App.Identity.Identifier
		  End Select
		  
		  Dim Request As New APIRequest("document.php", "GET", Params, AddressOf APICallback_DocumentsList)
		  Self.Socket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  ViewMenu.Left = (Self.Width - ViewMenu.Width) / 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDocuments(Documents() As APIDocument)
		  Dim SelectedDocument As APIDocument
		  If DocList.ListIndex > -1 Then
		    SelectedDocument = DocList.RowTag(DocList.ListIndex)
		  End If
		  
		  DocList.DeleteAllRows()
		  
		  For Each Document As APIDocument In Documents
		    DocList.AddRow(Document.Name, Document.Description, Document.DownloadCount.ToText, Document.LastUpdated.ToText(Xojo.Core.Locale.Current, Xojo.Core.Date.FormatStyles.Medium, Xojo.Core.Date.FormatStyles.None), Document.Revision.ToText)
		    DocList.RowTag(DocList.LastIndex) = Document
		    
		    If Document = SelectedDocument Then
		      DocList.ListIndex = DocList.LastIndex
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchedTo()
		  Self.RefreshDocuments()
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events ViewMenu
	#tag Event
		Sub Change()
		  Self.RefreshDocuments()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DocList
	#tag Event
		Sub Change()
		  OpenButton.Enabled = Me.ListIndex > -1
		  ShareButton.Enabled = Me.ListIndex > -1
		  DeleteButton.Enabled = Me.ListIndex > -1 And APIDocument(Me.RowTag(Me.ListIndex)).UserID = App.Identity.Identifier
		End Sub
	#tag EndEvent
	#tag Event
		Function SortColumn(column As Integer) As Boolean
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnAlignment(2) = Listbox.AlignRight
		  Me.ColumnAlignment(3) = Listbox.AlignRight
		  Me.ColumnAlignment(4) = Listbox.AlignRight
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OpenButton
	#tag Event
		Sub Action()
		  // This isn't good enough.
		  Self.ShowAlert("Downloading", "The document is now downloading. It'll open in just a moment.")
		  
		  Dim Document As APIDocument = DocList.RowTag(DocList.ListIndex)
		  App.DownloadDocument(Document.ResourceURL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PublishButton
	#tag Event
		Sub Action()
		  Dim Dialog As New OpenDialog
		  Dialog.Filter = BeaconFileTypes.BeaconDocument
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File = Nil Then
		    Return
		  End If
		  
		  Dim Document As Beacon.Document = Beacon.Document.Read(File)
		  If Document = Nil Then
		    Self.ShowAlert("Unable to open document", "It doesn't appear to be a Beacon document.")
		    Return
		  End If
		  
		  If DocumentPublishWindow.Present(Self.TrueWindow, Document) Then
		    Self.RefreshDocuments()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeleteButton
	#tag Event
		Sub Action()
		  Dim Document As APIDocument = DocList.RowTag(DocList.ListIndex)
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Are you sure you want to delete this document?"
		  Dialog.Explanation = "This action cannot be undone, but you can always republish if you have a backup copy."
		  Dialog.ActionButton.Caption = "Delete"
		  Dialog.CancelButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		  If Choice = Dialog.ActionButton Then
		    Dim Request As New APIRequest(Document.ResourceURL, "DELETE", AddressOf APICallback_DocumentDelete)
		    Request.Sign(App.Identity)
		    Self.Socket.Start(Request)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ShareButton
	#tag Event
		Sub Action()
		  Dim Document As APIDocument = DocList.RowTag(DocList.ListIndex)
		  Dim C As New Clipboard
		  C.Text = Document.ResourceURL
		  
		  Self.ShowAlert("Link has been copied", "Tip: if you want to make the link open the document directly in Beacon, replace the https:// at the beginning with beacon://")
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
