#tag DesktopWindow
Begin BeaconDialog SharingDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   563
   ImplicitInstance=   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   563
   MinimizeButton  =   False
   MinWidth        =   750
   Placement       =   0
   Resizable       =   "False"
   Resizeable      =   True
   Title           =   "Project Sharing"
   Visible         =   True
   Width           =   750
   Begin DesktopGroupBox WriteAccessGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Write Access"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   299
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   710
      Begin UITweaks.ResizedPushButton AddUserButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add User"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   311
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin DesktopLabel WriteAccessLabel
         AllowAutoDeactivate=   True
         Bold            =   False
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
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Users listed here will be able to make changes to this project and deploy changes to servers. Only the project owner and admins may add, remove, or change users."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   88
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   670
      End
      Begin BeaconListbox UserList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   3
         ColumnWidths    =   "*,320,100"
         DefaultRowHeight=   26
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   0
         Height          =   151
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         InitialValue    =   "Username	Identifier	Role"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PageSize        =   100
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   140
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   670
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton UserListRefreshButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Refresh"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         Italic          =   False
         Left            =   630
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   311
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton RemoveUserButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Remove"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "WriteAccessGroup"
         Italic          =   False
         Left            =   142
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   311
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      Text            =   "Project Sharing"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Done"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   650
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   523
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopGroupBox CommunityAccessGroup
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   363
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   710
      Begin DesktopLabel CommunityAccessLabel
         AllowAutoDeactivate=   True
         Bold            =   False
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
         Text            =   "Projects shared with the community will be available for download from the Beacon website and the Community section of the Projects tab. Community members will have read-only access, unless listed below."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   399
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   670
      End
      Begin DesktopLabel CommunityStatusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
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
         Text            =   "Current Status:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   471
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel CommunityStatusField
         AllowAutoDeactivate=   True
         Bold            =   False
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
         Text            =   "Checking…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   471
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   466
      End
      Begin UITweaks.ResizedPushButton CommunityShareButton
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
         Left            =   630
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   471
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin Timer StatusCheckTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   200
      RunMode         =   1
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopProgressWheel ActivitySpinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   527
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.UpdateUserList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_AddUser(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount()
		  
		  If Not Response.Success Then
		    Select Case Response.HTTPStatus
		    Case 403
		      Self.ShowAlert("Could not add user", If(Response.Message.IsEmpty = False, Response.Message, "You do not have permission to add or remove users."))
		    Else
		      Self.ShowAlert("There was an error adding the user", If(Response.Message.IsEmpty = False, Response.Message, "The server returned a " + Response.HTTPStatus.ToString(Locale.Raw, "0") + " status."))
		    End Select
		    Return
		  End If
		  
		  Try
		    Var MemberInfo As Dictionary = Response.JSON
		    Var UserId As String = MemberInfo.Value("userId")
		    Var Member As New Beacon.ProjectMember(UserId, MemberInfo)
		    
		    Call Self.mProject.AddMember(Member)
		    
		    Self.UpdateUserList()
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteUser(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Self.DecrementRequestCount()
		  
		  Var Member As Beacon.ProjectMember = Request.Tag
		  
		  If Response.Success Then
		    Call Self.mProject.RemoveMember(Member)
		  End If
		  
		  Self.UpdateUserList()
		  
		  If Not Response.Success Then
		    Self.ShowAlert("The user was not removed from the project", If(Response.Message.IsEmpty = False, Response.Message, "Users can remove themselves by deleting the project from their cloud list, or the user can be removed by the owner or admin."))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_FindUser(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Self.DecrementRequestCount()
		  
		  Var RequestDetails As Dictionary = Request.Tag
		  Var UserIdentifier As String = RequestDetails.Value("UserIdentifier")
		  Var Role As String = RequestDetails.Value("Role")
		  
		  If Not Response.Success Then
		    If Response.HTTPStatus = 404 Then
		      Self.ShowAlert("Could not find user '" + UserIdentifier + "'", "Please enter the UUID, email address, or full username with suffix (such as User#ABCD1234) to continue.")
		      Self.ShowAddUser(UserIdentifier, Role)
		    Else
		      Self.ShowAlert("Could not find user '" + UserIdentifier + "'", If(Response.Message.IsEmpty = False, Response.Message, "The server returned a " + Response.HTTPStatus.ToString(Locale.Raw, "0") + " status."))
		    End If
		    
		    Return
		  End If
		  
		  Try
		    Var UserInfo As Dictionary = Response.JSON
		    Var Identity As Beacon.Identity = Beacon.Identity.FromUserApi(UserInfo)
		    Var Member As New Beacon.ProjectMember(Identity, Role)
		    Call Member.SetPassword(Self.mProject.Password)
		    
		    Var MemberInfo As Dictionary = Member.DictionaryValue
		    BeaconAPI.Send(New BeaconAPI.Request("/projects/" + EncodeURLComponent(Self.mProject.ProjectId) + "/members/" + EncodeURLComponent(Member.UserId), "PUT", Beacon.GenerateJson(MemberInfo, False), "application/json", AddressOf APICallback_AddUser))
		    Self.IncrementRequestCount()
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing user lookup response")
		    Self.ShowAlert("There was an error adding the user", If(Response.Message.IsEmpty = False, Response.Message, "Beacon encountered an exception while processing the user lookup."))
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_GetCommunityStatus(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount()
		  
		  If Response.HTTPStatus <> 200 Or Response.JSONParsed = False Then
		    If Response.HTTPStatus = 403 Then
		      Self.CommunityStatusField.Text = "Not Authorized"
		    Else
		      Self.CommunityStatusField.Text = "Unknown"
		    End If
		    Self.CommunityShareButton.Caption = "Share"
		    Self.CommunityShareButton.Enabled = False
		    Return
		  End If
		  
		  Try
		    Var Payload As Dictionary = Response.JSON
		    Var Status As String = Payload.Value("communityStatus")
		    
		    Select Case Status
		    Case "Requested"
		      Self.CommunityStatusField.Text = "Private (Sharing Request Pending)"
		      Self.CommunityShareButton.Caption = "Share"
		      Self.CommunityShareButton.Enabled = False
		    Case "Approved"
		      Self.CommunityStatusField.Text = "Shared"
		      Self.CommunityShareButton.Caption = "Unshare"
		      Self.CommunityShareButton.Enabled = Self.mHasAdminPermission
		    Case "Private", "Approved But Private"
		      Self.CommunityStatusField.Text = "Private"
		      Self.CommunityShareButton.Caption = "Share"
		      Self.CommunityShareButton.Enabled = Self.mHasAdminPermission
		    Case "Denied"
		      Self.CommunityStatusField.Text = "Private (Sharing Request Denied)"
		      Self.CommunityShareButton.Caption = "Share"
		      Self.CommunityShareButton.Enabled = False
		    End Select
		  Catch Err As RuntimeException
		    Self.CommunityStatusField.Text = "Unknown"
		    Self.CommunityShareButton.Caption = "Share"
		    Self.CommunityShareButton.Enabled = False
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_LoadMembers(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount()
		  
		  If Response.Success = False Then
		    Self.UpdateUserList
		    Return
		  End If
		  
		  Try
		    Var Members() As Beacon.ProjectMember = Self.mProject.GetMembers
		    Var Map As New Dictionary
		    For Each Member As Beacon.ProjectMember In Members
		      Map.Value(Member.UserId) = Member
		    Next
		    
		    Var MemberDicts() As Variant = Response.JSON
		    For Each MemberInfo As Variant In MemberDicts
		      If MemberInfo.Type <> Variant.TypeObject Or (MemberInfo.ObjectValue IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var UserId As String = Dictionary(MemberInfo.ObjectValue).Value("userId")
		      Var Member As New Beacon.ProjectMember(UserId, Dictionary(MemberInfo.ObjectValue))
		      If Map.HasKey(Member.UserId) Then
		        Map.Remove(Member.UserId)
		      End If
		      
		      // Add the user to make sure the public key is up to date
		      Call Self.mProject.AddMember(Member)
		    Next
		    
		    // Clean out unnecessary keys
		    For Each Entry As DictionaryEntry In Map
		      Call Self.mProject.RemoveMember(Entry.Key.StringValue)
		    Next
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.UpdateUserList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Project As Beacon.Project)
		  Self.mProject = Project
		  Self.mHasAdminPermission = (Self.mProject.Role = Beacon.ProjectMember.RoleOwner Or Self.mProject.Role = Beacon.ProjectMember.RoleAdmin)
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DecrementRequestCount()
		  Self.mRequestCount = Self.mRequestCount - 1
		  Self.ActivitySpinner.Visible = Self.mRequestCount > 0
		  Self.UserListRefreshButton.Enabled = Self.mRequestCount = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IncrementRequestCount()
		  Self.mRequestCount = Self.mRequestCount + 1
		  Self.ActivitySpinner.Visible = Self.mRequestCount > 0
		  Self.UserListRefreshButton.Enabled = Self.mRequestCount = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadGuests()
		  Var Request As New BeaconAPI.Request("/projects/" + EncodeURLComponent(Self.mProject.ProjectId) + "/members", "GET", AddressOf APICallback_LoadMembers)
		  BeaconAPI.Send(Request)
		  Self.IncrementRequestCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As DesktopWindow, Project As Beacon.Project)
		  If Parent = Nil Then
		    Return
		  End If
		  
		  Var Win As New SharingDialog(Project)
		  Win.ShowModal(Parent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddUser()
		  Self.ShowAddUser("", Beacon.ProjectMember.RoleEditor)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddUser(DefaultValue As String, DefaultRole As String)
		  Var UserIdentifier As String = DefaultValue
		  Var Role As String = DefaultRole
		  
		  If Not ShareWithUserDialog.Present(Self, UserIdentifier, Role) Then
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request("/users/" + EncodeURLComponent(UserIdentifier), "GET", AddressOf APICallback_FindUser)
		  Request.Tag = New Dictionary("UserIdentifier": UserIdentifier, "Role": Role)
		  BeaconAPI.Send(Request)
		  Self.IncrementRequestCount()
		  
		  // Var MemberData As New Dictionary
		  // MemberData.Value("role") = Role
		  // 
		  // Var Request As New BeaconAPI.Request("/projects/" + EncodeURLComponent(Self.mProject.ProjectId) + "/members/" + EncodeURLComponent(UserIdentifier), "PUT", Beacon.GenerateJson(MemberData, False), "application/json", AddressOf APICallback_AddUser)
		  // Request.Tag = New Dictionary("UserIdentifier": UserIdentifier, "Role": Role)
		  // BeaconAPI.Send(Request)
		  // Self.IncrementRequestCount()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUserList()
		  Var Members() As Beacon.ProjectMember = Self.mProject.GetMembers
		  For Idx As Integer = Members.LastIndex DownTo 0
		    If Members(Idx).Role = Beacon.ProjectMember.RoleOwner Then
		      Members.RemoveAt(Idx)
		      Exit For Idx
		    End If
		  Next
		  
		  Var SelectedIds() As String
		  For Idx As Integer = 0 To Self.UserList.LastRowIndex
		    If Self.UserList.RowSelectedAt(Idx) Then
		      SelectedIds.Add(Beacon.ProjectMember(Self.UserList.RowTagAt(Idx)).UserId)
		    End If
		  Next
		  
		  Self.UserList.SelectionChangeBlocked = True
		  Self.UserList.RowCount = Members.Count
		  For Idx As Integer = 0 To Self.UserList.LastRowIndex
		    Self.UserList.CellTextAt(Idx, 0) = Members(Idx).Username
		    Self.UserList.CellTextAt(Idx, 1) = Members(Idx).UserId
		    Self.UserList.CellTextAt(Idx, 2) = Members(Idx).Role
		    Self.UserList.RowTagAt(Idx) = Members(Idx)
		    Self.UserList.RowSelectedAt(Idx) = SelectedIds.IndexOf(Members(Idx).UserId) > -1
		  Next
		  Self.UserList.Sort
		  Self.UserList.SelectionChangeBlocked = False
		  Self.AddUserButton.Enabled = Self.mHasAdminPermission
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHasAdminPermission As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwnerId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Beacon.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestCount As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events AddUserButton
	#tag Event
		Sub Pressed()
		  Self.ShowAddUser()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserList
	#tag Event
		Sub Opening()
		  Me.SortingColumn = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Var UserCount As Integer = Me.SelectedRowCount
		    If Not Self.ShowConfirm("Are you sure you want to stop sharing this project with " + Language.NounWithQuantity(UserCount, "user", "users") + "?", "Changes will not be made until the project is saved. This project will no longer appear in the user's cloud projects and the user will be unable to save a new version.", "Stop Sharing", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For Idx As Integer = Me.RowCount - 1 DownTo 0
		    If Me.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Member As Beacon.ProjectMember = Me.RowTagAt(Idx)
		    Var Request As New BeaconAPI.Request("/projects/" + EncodeURLComponent(Self.mProject.ProjectId) + "/members/" + EncodeURLComponent(Member.UserId), "DELETE", AddressOf APICallback_DeleteUser)
		    Request.Tag = Member
		    BeaconAPI.Send(Request)
		    Self.IncrementRequestCount()
		    
		    Me.RemoveRowAt(Idx)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.mHasAdminPermission
		End Function
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.RemoveUserButton.Enabled = Me.CanDelete
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1 And Self.mHasAdminPermission
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var Idx As Integer = Me.SelectedRowIndex
		  Self.ShowAddUser(Me.CellTextAt(Idx, 1), Me.CellTextAt(Idx, 2))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UserListRefreshButton
	#tag Event
		Sub Pressed()
		  Self.LoadGuests()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveUserButton
	#tag Event
		Sub Pressed()
		  Self.UserList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.ActivitySpinner.Visible Then
		    Self.ShowAlert("Wait until the current action is finished", "This window is still doing work. Give it a chance to finish.")
		    Return
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CommunityShareButton
	#tag Event
		Sub Pressed()
		  Var DesiredStatus As String
		  If Me.Caption = "Share" Then
		    Var Description As String = Self.mProject.Description.Trim
		    If Description.IsEmpty Then
		      Self.ShowAlert("Your project has no description and will be rejected if shared.", "This might be the best project ever, but nobody will download it if they don't know anything about it. Before sharing it to the world, go give it a nice description.")
		      Try
		        App.MainWindow.Documents.EditorForProject(Self.mProject).SwitchToEditor(Ark.Configs.NameMetadataPsuedo)
		      Catch Err As RuntimeException
		      End Try
		      Self.Close()
		      Return
		    End If
		    
		    If Self.mProject.Modified Then
		      Var ShouldCancel As Boolean = Self.ShowConfirm("Your project should be saved first.", "Your publish request will be based on the last time your saved your project. You have made changes since your last save, so you should save before requesting the project be published.", "Cancel", "Request Anyway")
		      If ShouldCancel Then
		        Return
		      End If
		    End If
		    
		    DesiredStatus = "Requested"
		  Else
		    DesiredStatus = "Private"
		  End If
		  
		  Var Payload As New Dictionary
		  Payload.Value("communityStatus") = DesiredStatus
		  
		  Var Request As New BeaconAPI.Request(BeaconAPI.URL("projects/" + EncodeUrlComponent(Self.mProject.ProjectId) + "/metadata"), "PATCH", Beacon.GenerateJSON(Payload, False), "application/json", AddressOf APICallback_GetCommunityStatus)
		  BeaconAPI.Send(Request)
		  
		  Me.Enabled = False
		  Self.CommunityStatusField.Text = "Sharing…"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StatusCheckTimer
	#tag Event
		Sub Action()
		  Var Request As New BeaconAPI.Request(BeaconAPI.URL("projects/" + EncodeUrlComponent(Self.mProject.ProjectId) + "/metadata"), "GET", AddressOf APICallback_GetCommunityStatus)
		  BeaconAPI.Send(Request)
		  Self.IncrementRequestCount()
		  
		  Self.LoadGuests()
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
			"9 - Modeless Dialog"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Type="DesktopMenuBar"
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
