#tag Window
Begin BeaconDialog SharingDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   630
   ImplicitInstance=   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   630
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   0
   Resizable       =   "False"
   Resizeable      =   True
   Title           =   "Document Sharing"
   Visible         =   True
   Width           =   600
   Begin GroupBox WriteAccessGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Write Access"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   278
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   300
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
      Begin UITweaks.ResizedPushButton AddUserButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Add User"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   538
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin BeaconListbox UserList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   False
         ColumnWidths    =   "*,312"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   26
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   130
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         InitialValue    =   "Username	Identifier"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   388
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   520
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label WriteAccessLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   40
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   336
         Transparent     =   False
         Underline       =   False
         Value           =   "Users listed here will be able to make changes to this document and deploy changes to servers. Only the document owner may add or remove users."
         Visible         =   True
         Width           =   520
      End
      Begin ProgressWheel UsernameLookupSpinner
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         Left            =   544
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   542
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
   End
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
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
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Document Sharing"
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Done"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   590
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin GroupBox ReadOnlyGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Read-Only Access"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   76
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
      Begin Label DownloadLinkLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ReadOnlyGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   True
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
         Transparent     =   False
         Underline       =   False
         Value           =   "https://api.beaconapp.cc/v1/document"
         Visible         =   True
         Width           =   428
      End
      Begin ReactionButton CopyLinkButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Copy"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ReadOnlyGroup"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin GroupBox CommunityAccessGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Community Sharing"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   148
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   140
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
      Begin Label CommunityAccessLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   60
         Index           =   -2147483648
         InitialParent   =   "CommunityAccessGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   176
         Transparent     =   False
         Underline       =   False
         Value           =   "Documents shared with the community will be available for download from the Beacon website and the Community section of the Documents list. Community members will have read-only access, unless listed below."
         Visible         =   True
         Width           =   520
      End
      Begin Label CommunityStatusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "CommunityAccessGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   248
         Transparent     =   False
         Underline       =   False
         Value           =   "Current Status:"
         Visible         =   True
         Width           =   100
      End
      Begin Label CommunityStatusField
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "CommunityAccessGroup"
         Italic          =   False
         Left            =   152
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   248
         Transparent     =   False
         Underline       =   False
         Value           =   "Checking…"
         Visible         =   True
         Width           =   316
      End
      Begin PushButton CommunityShareButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Share"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "CommunityAccessGroup"
         Italic          =   False
         Left            =   480
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   248
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin Timer StatusCheckTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   200
      RunMode         =   "1"
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin BeaconAPI.Socket APISocket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Constructor(Document As Beacon.Document)
		  Self.mDocument = Document
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, Document As Beacon.Document)
		  If Parent = Nil Then
		    Return
		  End If
		  
		  Dim Win As New SharingDialog(Document)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  If Win.mUsersChanged Then
		    Parent.TrueWindow.ShowAlert("Write access changes will not be made effective until you save your document.", "Adding or removing a user updates the encryption keys inside your document, so it is necessary to save the document before newly authorized users are able to access it.")
		  End If
		  
		  Win.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StatusCheckReplyCallback(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus <> 200 Or Response.JSONParsed = False Then
		    If Response.HTTPStatus = 403 Then
		      Self.CommunityStatusField.Value = "Not Authorized"
		    Else
		      Self.CommunityStatusField.Value = "Unknown"
		    End If
		    Self.CommunityShareButton.Caption = "Share"
		    Self.CommunityShareButton.Enabled = False
		    Return
		  End If
		  
		  Try
		    Var Payload As Dictionary = Response.JSON
		    Var Status As String = Payload.Value("status")
		    
		    Select Case Status
		    Case "Requested"
		      Self.CommunityStatusField.Value = "Private (Sharing Request Pending)"
		      Self.CommunityShareButton.Caption = "Share"
		      Self.CommunityShareButton.Enabled = False
		    Case "Approved"
		      Self.CommunityStatusField.Value = "Shared"
		      Self.CommunityShareButton.Caption = "Unshare"
		      Self.CommunityShareButton.Enabled = True
		    Case "Private", "Approved But Private"
		      Self.CommunityStatusField.Value = "Private"
		      Self.CommunityShareButton.Caption = "Share"
		      Self.CommunityShareButton.Enabled = True
		    Case "Denied"
		      Self.CommunityStatusField.Value = "Private (Sharing Request Denied)"
		      Self.CommunityShareButton.Caption = "Share"
		      Self.CommunityShareButton.Enabled = False
		    End Select
		  Catch Err As RuntimeException
		    Self.CommunityStatusField.Value = "Unknown"
		    Self.CommunityShareButton.Caption = "Share"
		    Self.CommunityShareButton.Enabled = False
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UserLookupReplyCallback(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Try
		    Var Dicts() As Variant
		    Var Parsed As Variant = Response.JSON
		    If IsNull(Parsed) = False And Parsed.Type = Variant.TypeObject And Parsed.ObjectValue IsA Dictionary Then
		      Dicts.AddRow(Parsed)
		    Else
		      Dicts = Parsed
		    End If
		    
		    Var Usernames As New Dictionary
		    For Each UserDict As Dictionary In Dicts
		      Var UserID As String = UserDict.Value("user_id").StringValue
		      Var Username As String = UserDict.Value("username_full").StringValue
		      Usernames.Value(UserID) = Username
		    Next
		    
		    For I As Integer = 0 To Self.UserList.RowCount - 1
		      Var UserID As String = Self.UserList.CellValueAt(I, 1)
		      If Usernames.HasKey(UserID) Then
		        Self.UserList.CellValueAt(I, 0) = Usernames.Value(UserID).StringValue
		      End If
		    Next
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Self.UsernameLookupSpinner.Visible = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsersChanged As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events AddUserButton
	#tag Event
		Sub Action()
		  Dim UserID, Username, PublicKey As String
		  If ShareWithUserDialog.Present(Self, UserID, Username, PublicKey) Then
		    If Self.mDocument.HasUser(UserID) = False Then
		      Self.UserList.AddRow(Username, UserID)
		      Self.UserList.Sort
		    End If
		    
		    // Even if the user is already on the document, call AddUser in case the public key has changed
		    Self.mDocument.AddUser(UserID, PublicKey)
		    Self.mUsersChanged = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserList
	#tag Event
		Sub Open()
		  Dim Users() As String = Self.mDocument.GetUsers()
		  Users.Sort
		  
		  For Each UserID As String In Users
		    If UserID = App.IdentityManager.CurrentIdentity.Identifier Then
		      Continue
		    End If
		    Me.AddRow("", UserID)
		  Next
		  
		  Me.SortingColumn = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Dim UserCount As Integer = Me.SelectedRowCount
		    If Not Self.ShowConfirm("Are you sure you want to stop sharing this document with " + Language.NounWithQuantity(UserCount, "user", "users") + "?", "Changes will not be made until the document is saved. This document will no longer appear in the user's cloud documents and the user will be unable to save a new version.", "Stop Sharing", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Me.Selected(I) Then
		      Self.mDocument.RemoveUser(Me.CellValueAt(I, 0))
		      Me.RemoveRowAt(I)
		      Self.mUsersChanged = True
		    End If
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DownloadLinkLabel
	#tag Event
		Sub Open()
		  Me.Value = BeaconAPI.URL("/document/" + EncodeURLComponent(Self.mDocument.DocumentID) + "?name=" + EncodeURLComponent(Self.mDocument.Title))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CopyLinkButton
	#tag Event
		Sub Action()
		  Dim Board As New Clipboard
		  Board.Text = Self.DownloadLinkLabel.Value
		  
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CommunityShareButton
	#tag Event
		Sub Action()
		  Var DesiredStatus As String
		  If Me.Caption = "Share" Then
		    DesiredStatus = "Requested"
		  Else
		    DesiredStatus = "Private"
		  End If
		  
		  Var Payload As New Dictionary
		  Payload.Value("status") = DesiredStatus
		  
		  Var Request As New BeaconAPI.Request(BeaconAPI.URL("/document/" + Self.mDocument.DocumentID + "/publish"), "POST", Beacon.GenerateJSON(Payload, False), "application/json", AddressOf StatusCheckReplyCallback)
		  Request.Authenticate(Preferences.OnlineToken)
		  APISocket.Start(Request)
		  
		  Me.Enabled = False
		  Self.CommunityStatusField.Value = "Sharing…"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StatusCheckTimer
	#tag Event
		Sub Action()
		  Var Request As New BeaconAPI.Request(BeaconAPI.URL("/document/" + Self.mDocument.DocumentID + "/publish"), "GET", AddressOf StatusCheckReplyCallback)
		  APISocket.Start(Request)
		  
		  Var Users() As String = Self.mDocument.GetUsers
		  If Users.LastRowIndex > -1 Then
		    Var UsersLookup As New BeaconAPI.Request(BeaconAPI.URL("/user/" + EncodeURLComponent(Users.Join(","))), "GET", AddressOf UserLookupReplyCallback)
		    APISocket.Start(UsersLookup)
		    Self.UsernameLookupSpinner.Visible = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
