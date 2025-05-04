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
   Height          =   422
   ImplicitInstance=   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   422
   MinimizeButton  =   False
   MinWidth        =   750
   Placement       =   0
   Resizable       =   "False"
   Resizeable      =   True
   Title           =   "Project Sharing"
   Visible         =   True
   Width           =   750
   Begin Timer StatusCheckTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   200
      RunMode         =   1
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin OmniBar Tabs
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      HasBottomBorder =   True
      HasTopBorder    =   False
      Height          =   41
      Index           =   -2147483648
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   750
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   381
      Index           =   -2147483648
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
      TabStop         =   False
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   750
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   382
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   122
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   382
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   214
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   382
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
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
         Height          =   257
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Username	Identifier	Role"
         Italic          =   False
         Left            =   20
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
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   113
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   710
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Users listed here will be able to make changes to this project and deploy changes to servers. Only the project owner and admins may add, remove, or change users."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   710
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   650
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   133
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Checking…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   133
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   506
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
         InitialParent   =   "Pages"
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
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Current Status:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   133
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopLabel CommunityAccessLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   60
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Projects shared with the community will be available for download from the Beacon website and the Community section of the Projects tab. Community members will have read-only access, unless otherwise listed in the Members tab."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   710
      End
      Begin DesktopLabel InviteIntroLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   60
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Invites are an alternative way of adding users to the project. Instead of collecting the user's email or username, you can generate an invite link and send it to them in any way you like, such as text, email, or Discord. Once an invite is accepted, the user is added to the Members tab and the invite is deleted."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   710
      End
      Begin BeaconListbox InvitesList
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
         ColumnWidths    =   ""
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
         HeadingIndex    =   2
         Height          =   237
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Code	Role	Expires"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PageSize        =   100
         PreferencesKey  =   ""
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   133
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         Width           =   710
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton NewInviteButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "New Invite"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   382
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedPushButton RemoveInviteButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   122
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   382
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedPushButton RefreshInvitesButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   326
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   382
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin ReactionButton CopyInviteButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Copy Link"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   224
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   382
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
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
      Left            =   773
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   382
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  Var Pusher As Beacon.PusherSocket = App.Pusher
		  If (Pusher Is Nil) = False Then
		    Pusher.Unbind("membersUpdated", WeakAddressOf Pusher_MembersUpdated)
		    Pusher.Unbind("invitesUpdated", WeakAddressOf Pusher_InvitesUpdated)
		    Pusher.Unbind("publishStatusUpdated", WeakAddressOf Pusher_CommunityStatusUpdated)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.UpdateUserList()
		  
		  Self.WriteAccessLabel.Height = Self.WriteAccessLabel.IdealHeight
		  Self.UserList.Top = Self.WriteAccessLabel.Bottom + 20
		  Self.UserList.Height = Self.AddUserButton.Top - (Self.UserList.Top + 20)
		  
		  Self.InviteIntroLabel.Height = Self.InviteIntroLabel.IdealHeight
		  Self.InvitesList.Top = Self.InviteIntroLabel.Bottom + 20
		  Self.InvitesList.Height = Self.NewInviteButton.Top - (Self.InvitesList.Top + 20)
		  
		  Self.NewInviteButton.Enabled = Self.mHasAdminPermission
		  
		  // Done button starts out of the page panel, so we move it back so it can exist over all tabs.
		  Self.ActionButton.Top = Self.Height - (Self.ActionButton.Height + 20)
		  Self.ActionButton.Left = Self.Width - (Self.ActionButton.Width + 20)
		  
		  Var Pusher As Beacon.PusherSocket = App.Pusher
		  If (Pusher Is Nil) = False Then
		    Pusher.Bind("membersUpdated", WeakAddressOf Pusher_MembersUpdated)
		    Pusher.Bind("invitesUpdated", WeakAddressOf Pusher_InvitesUpdated)
		    Pusher.Bind("publishStatusUpdated", WeakAddressOf Pusher_CommunityStatusUpdated)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_AddUser(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount(Self.MembersTab)
		  
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
		Private Sub APICallback_DeleteInvite(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount(Self.InvitesTab)
		  
		  If Response.Success Then
		    Return
		  End If
		  
		  Self.LoadInvites()
		  Self.ShowAlert("Invite not deleted", "There was an error deleting the invite")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteUser(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Self.DecrementRequestCount(Self.MembersTab)
		  
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
		  Self.DecrementRequestCount(Self.MembersTab)
		  
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
		    Self.IncrementRequestCount(Self.MembersTab)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing user lookup response")
		    Self.ShowAlert("There was an error adding the user", If(Response.Message.IsEmpty = False, Response.Message, "Beacon encountered an exception while processing the user lookup."))
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_GetCommunityStatus(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount(Self.CommunityTab)
		  
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
		    Self.UpdateCommunityStatus(Status)
		  Catch Err As RuntimeException
		    Self.UpdateCommunityStatus("")
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_LoadInvites(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount(Self.InvitesTab)
		  
		  If Response.Success = False Then
		    Self.UpdateInvitesList
		    Return
		  End If
		  
		  Try
		    Var Invites() As Beacon.ProjectInvite
		    Var Parsed As New JSONItem(Response.Content)
		    Var Results As JSONItem = Parsed.Child("results")
		    For Idx As Integer = 0 To Results.LastRowIndex
		      Var Invite As Beacon.ProjectInvite = Beacon.ProjectInvite.FromJSON(Results.ChildAt(Idx))
		      If (Invite Is Nil) = False Then
		        Invites.Add(Invite)
		      End If
		    Next
		    Self.mInvites = Invites
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing invites response")
		  End Try
		  
		  Self.UpdateInvitesList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_LoadMembers(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount(Self.MembersTab)
		  
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
		Private Sub APICallback_NewInvite(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.DecrementRequestCount(Self.InvitesTab)
		  
		  If Not Response.Success Then
		    Select Case Response.HTTPStatus
		    Case 403
		      Self.ShowAlert("Could not create invite", If(Response.Message.IsEmpty = False, Response.Message, "You do not have permission to create or delete invites."))
		    Else
		      Self.ShowAlert("There was an error creating the invite", If(Response.Message.IsEmpty = False, Response.Message, "The server returned a " + Response.HTTPStatus.ToString(Locale.Raw, "0") + " status."))
		    End Select
		    Return
		  End If
		  
		  Try
		    Var Parsed As New JSONItem(Response.Content)
		    Var Created As JSONItem = Parsed.Child("created")
		    Var Multiple As Boolean = Created.Count > 1
		    For Idx As Integer = 0 To Created.LastRowIndex
		      Var Invite As Beacon.ProjectInvite = Beacon.ProjectInvite.FromJSON(Created.ChildAt(Idx))
		      If (Invite Is Nil) = False Then
		        Self.mInvites.Add(Invite)
		        
		        If Not Multiple Then
		          Var Board As New Clipboard
		          Board.Text = Invite.RedeemUrl
		          
		          Self.ShowAlert("Invite created", "The link has been copied to your clipboard so you can paste it where you need it.")
		        End If
		      End If
		    Next
		    Self.UpdateInvitesList()
		  Catch Err As RuntimeException
		    Self.LoadInvites()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CommunityTab() As OmniBarItem
		  Return Self.Tabs.Item("CommunityItem")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Project As Beacon.Project)
		  Self.mProject = Project
		  Self.mHasAdminPermission = (Self.mProject.Role = Beacon.ProjectMember.RoleOwner Or Self.mProject.Role = Beacon.ProjectMember.RoleAdmin)
		  Self.mRequestCounts = New Dictionary
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DecrementRequestCount(ForTab As OmniBarItem)
		  If ForTab Is Nil Then
		    Return
		  End If
		  
		  Var NewCount As Integer = Max(Self.mRequestCounts.Lookup(ForTab, 0).IntegerValue - 1, 0)
		  Self.mRequestCounts.Value(ForTab) = NewCount
		  ForTab.HasProgressIndicator = NewCount > 0
		  ForTab.Progress = OmniBarItem.ProgressIndeterminate
		  
		  Select Case ForTab.Name
		  Case "MembersItem"
		    Self.UserListRefreshButton.Enabled = NewCount = 0
		  Case "InvitesItem"
		    Self.RefreshInvitesButton.Enabled = NewCount = 0
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasActivity(ForTab As OmniBarItem) As Boolean
		  If ForTab Is Nil Then
		    Return False
		  End If
		  
		  Return Self.mRequestCounts.Lookup(ForTab, 0).IntegerValue > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IncrementRequestCount(ForTab As OmniBarItem)
		  If ForTab Is Nil Then
		    Return
		  End If
		  
		  Var NewCount As Integer = Self.mRequestCounts.Lookup(ForTab, 0).IntegerValue + 1
		  Self.mRequestCounts.Value(ForTab) = NewCount
		  ForTab.HasProgressIndicator = NewCount > 0
		  ForTab.Progress = OmniBarItem.ProgressIndeterminate
		  
		  Select Case ForTab.Name
		  Case "MembersItem"
		    Self.UserListRefreshButton.Enabled = NewCount = 0
		  Case "InvitesItem"
		    Self.RefreshInvitesButton.Enabled = NewCount = 0
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InvitesTab() As OmniBarItem
		  Return Self.Tabs.Item("InvitesItem")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadCommunityStatus()
		  Var CommunityTab As OmniBarItem = Self.CommunityTab
		  
		  If Self.HasActivity(CommunityTab) Then
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request(BeaconAPI.URL("projects/" + EncodeUrlComponent(Self.mProject.ProjectId) + "/metadata"), "GET", AddressOf APICallback_GetCommunityStatus)
		  BeaconAPI.Send(Request)
		  Self.IncrementRequestCount(CommunityTab)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadGuests()
		  Var MembersTab As OmniBarItem = Self.MembersTab
		  
		  If Self.HasActivity(MembersTab) Then
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request("/projects/" + EncodeURLComponent(Self.mProject.ProjectId) + "/members", "GET", AddressOf APICallback_LoadMembers)
		  BeaconAPI.Send(Request)
		  Self.IncrementRequestCount(MembersTab)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadInvites()
		  Var InvitesTab As OmniBarItem = Self.InvitesTab
		  
		  If Self.HasActivity(InvitesTab) Then
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request("/projectInvites?projectId=" + EncodeURLComponent(Self.mProject.ProjectId), "GET", AddressOf APICallback_LoadInvites)
		  BeaconAPI.Send(Request)
		  Self.IncrementRequestCount(InvitesTab)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MembersTab() As OmniBarItem
		  Return Self.Tabs.Item("MembersItem")
		End Function
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
		Private Sub Pusher_CommunityStatusUpdated(ChannelName As String, EventName As String, EventBody As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  
		  // We don't need to load the status because it's in EventBody
		  Self.UpdateCommunityStatus(EventBody)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_InvitesUpdated(ChannelName As String, EventName As String, EventBody As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  #Pragma Unused EventBody
		  
		  Self.LoadInvites()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_MembersUpdated(ChannelName As String, EventName As String, EventBody As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  #Pragma Unused EventBody
		  
		  Self.LoadGuests()
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
		  Self.IncrementRequestCount(Self.MembersTab)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCommunityStatus(Status As String)
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
		  Else
		    Self.CommunityStatusField.Text = "Unknown"
		    Self.CommunityShareButton.Caption = "Share"
		    Self.CommunityShareButton.Enabled = False
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateInvitesList()
		  Var SelectedIds() As String
		  For Idx As Integer = 0 To Self.InvitesList.LastRowIndex
		    If Self.InvitesList.RowSelectedAt(Idx) Then
		      SelectedIds.Add(Beacon.ProjectInvite(Self.InvitesList.RowTagAt(Idx)).Code)
		    End If
		  Next
		  
		  Self.InvitesList.SelectionChangeBlocked = True
		  Self.InvitesList.RowCount = Self.mInvites.Count
		  For Idx As Integer = 0 To Self.InvitesList.LastRowIndex
		    Var Expiration As New DateTime(Self.mInvites(Idx).Expiration)
		    
		    Self.InvitesList.CellTextAt(Idx, 0) = Self.mInvites(Idx).Code
		    Self.InvitesList.CellTextAt(Idx, 1) = Self.mInvites(Idx).Role
		    Self.InvitesList.CellTextAt(Idx, 2) = Expiration.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium)
		    Self.InvitesList.CellTagAt(Idx, 2) = Self.mInvites(Idx).Expiration
		    Self.InvitesList.RowTagAt(Idx) = Self.mInvites(Idx)
		    Self.InvitesList.RowSelectedAt(Idx) = SelectedIds.IndexOf(Self.mInvites(Idx).Code) > -1
		  Next
		  Self.InvitesList.Sort
		  Self.InvitesList.SelectionChangeBlocked = False
		  Self.AddUserButton.Enabled = Self.mHasAdminPermission
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
		Private mInvites() As Beacon.ProjectInvite
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwnerId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Beacon.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestCounts As Dictionary
	#tag EndProperty


	#tag Constant, Name = PageCommunity, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageInvites, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageMembers, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events StatusCheckTimer
	#tag Event
		Sub Action()
		  Self.LoadGuests()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Tabs
	#tag Event
		Sub Opening()
		  Var MembersItem As OmniBarItem = OmniBarItem.CreateTab("MembersItem", "Members")
		  MembersItem.Toggled = True
		  MembersItem.Tag = Self.PageMembers
		  
		  Var InvitesItem As OmniBarItem = OmniBarItem.CreateTab("InvitesItem", "Invites")
		  InvitesItem.Tag = Self.PageInvites
		  
		  Var CommunityItem As OmniBarItem = OmniBarItem.CreateTab("CommunityItem", "Community")
		  CommunityItem.Tag = Self.PageCommunity
		  
		  Me.Append(OmniBarItem.CreateTitle("TitleItem", "Project Sharing"))
		  Me.Append(OmniBarItem.CreateSeparator("TitleSeparator"))
		  Me.Append(MembersItem, InvitesItem, CommunityItem)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  If Item Is Nil Then
		    // How?
		    Return
		  End If
		  
		  For Idx As Integer = 2 To 4
		    Var OtherItem As OmniBarItem = Me.Item(Idx)
		    If OtherItem Is Nil Then
		      Continue
		    End If
		    OtherItem.Toggled = (OtherItem.Name = Item.Name)
		  Next
		  
		  Self.Pages.SelectedPanelIndex = Item.Tag.IntegerValue
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageMembers
		    Self.LoadGuests()
		  Case Self.PageInvites
		    Self.LoadInvites()
		  Case Self.PageCommunity
		    Self.LoadCommunityStatus()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddUserButton
	#tag Event
		Sub Pressed()
		  Self.ShowAddUser()
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
#tag Events UserListRefreshButton
	#tag Event
		Sub Pressed()
		  Self.LoadGuests()
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
		    If Not Self.ShowConfirm("Are you sure you want to stop sharing this project with " + Language.NounWithQuantity(UserCount, "user", "users") + "?", "Changes will happen immediately. This project will no longer appear in the user's cloud projects and the user will be unable to save a new version.", "Stop Sharing", "Cancel") Then
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
		    Self.IncrementRequestCount(Self.MembersTab)
		    
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
#tag Events CommunityShareButton
	#tag Event
		Sub Pressed()
		  Var DesiredStatus As String
		  If Me.Caption = "Share" Then
		    Var Description As String = Self.mProject.Description.Trim
		    If Description.IsEmpty Then
		      Self.ShowAlert("Your project has no description and will be rejected if shared.", "This might be the best project ever, but nobody will download it if they don't know anything about it. Before sharing it to the world, go give it a nice description.")
		      Try
		        App.MainWindow.Documents.EditorForProject(Self.mProject).SwitchToEditor(Ark.Configs.NameProjectSettings)
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
		  Self.IncrementRequestCount(Self.CommunityTab)
		  
		  Me.Enabled = False
		  Self.CommunityStatusField.Text = "Sharing…"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events InvitesList
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.mHasAdminPermission
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Var InviteCount As Integer = Me.SelectedRowCount
		    If Not Self.ShowConfirm("Are you sure you want to delete " + Language.NounWithQuantity(InviteCount, "invite", "invites") + "?", "This cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For Idx As Integer = Me.RowCount - 1 DownTo 0
		    If Me.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Invite As Beacon.ProjectInvite = Me.RowTagAt(Idx)
		    Var Request As New BeaconAPI.Request("/projectInvites/" + EncodeURLComponent(Invite.Code), "DELETE", AddressOf APICallback_DeleteInvite)
		    Request.Tag = Invite
		    BeaconAPI.Send(Request)
		    Self.IncrementRequestCount(Self.InvitesTab)
		    
		    Self.mInvites.RemoveAt(Idx)
		    Me.RemoveRowAt(Idx)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function RowComparison(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If Column <> 2 Then
		    Return False
		  End If
		  
		  Var Value1 As Double = Me.CellTagAt(Row1, Column)
		  Var Value2 As Double = Me.CellTagAt(Row2, Column)
		  If Value1 > Value2 Then
		    Result = 1
		  ElseIf Value1 < Value2 Then
		    Result = -1
		  Else
		    Result = 0
		  End If
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Invite As Beacon.ProjectInvite = Me.RowTagAt(Me.SelectedRowIndex)
		  Board.Text = Invite.RedeemUrl
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.RemoveInviteButton.Enabled = Me.CanDelete
		  If Self.CopyInviteButton.IsReacted Then
		    Self.CopyInviteButton.Restore
		  End If
		  Self.CopyInviteButton.Enabled = Me.CanCopy
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NewInviteButton
	#tag Event
		Sub Pressed()
		  Var Base As New DesktopMenuItem
		  Base.AddMenu(New DesktopMenuItem("Guest", "Guest"))
		  Base.AddMenu(New DesktopMenuItem("Editor", "Editor"))
		  Base.AddMenu(New DesktopMenuItem("Admin", "Admin"))
		  
		  Var Position As Point = Me.GlobalPosition
		  Var Choice As DesktopMenuItem = Base.PopUp(Position.X, Position.Y + Me.Height)
		  If Choice Is Nil Then
		    Return
		  End If
		  
		  Var InviteData As New JSONItem
		  InviteData.Value("projectId") = Self.mProject.ProjectId
		  InviteData.Value("role") = Choice.Tag
		  InviteData.Value("projectPassword") = Self.mProject.PasswordDecrypted
		  
		  Var Request As New BeaconAPI.Request("/projectInvites", "POST", InviteData.ToString, "application/json", WeakAddressOf APICallback_NewInvite)
		  BeaconAPI.Send(Request)
		  Self.IncrementRequestCount(Self.InvitesTab)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveInviteButton
	#tag Event
		Sub Pressed()
		  Self.InvitesList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshInvitesButton
	#tag Event
		Sub Pressed()
		  Self.LoadInvites()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CopyInviteButton
	#tag Event
		Sub Pressed()
		  Self.InvitesList.DoCopy
		  Me.Caption = "Copied!"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var HasActivity As Boolean
		  For Each Entry As DictionaryEntry In Self.mRequestCounts
		    HasActivity = HasActivity Or Entry.Value.IntegerValue > 0
		  Next
		  
		  If HasActivity Then
		    Self.ShowAlert("Wait until the current action is finished", "This window is still doing work. Give it a chance to finish.")
		    Return
		  End If
		  
		  Self.Close
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
