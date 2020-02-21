#tag Window
Begin DiscoveryView NitradoDiscoveryView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   400
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
   Width           =   600
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   400
      HelpTag         =   ""
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   "True"
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedPushButton FindingCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label FindingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Finding Servers…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   190
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar FindingProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   "True"
         Top             =   222
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
      End
      Begin BeaconListbox List
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,200"
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
         Height          =   296
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   " 	Name	Address"
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
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label ListMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Select Servers"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton ListCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ListActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton NewAuthButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Link Another Nitrado Account"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   214
      End
   End
   Begin Beacon.OAuth2Client AuthClient
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Timer LookupStartTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.mAuthQueue = Self.mAccounts.ForProvider(Beacon.ExternalAccount.ProviderNitrado)
		  If Self.mAuthQueue.Count = 0 Then
		    Self.mAuthQueue.AddRow(New Beacon.ExternalAccount(New v4UUID, Beacon.ExternalAccount.ProviderNitrado, "", "", Nil))
		  End If
		  
		  Self.DesiredHeight = 124
		  Self.LookupStartTimer.RunMode = Timer.RunModes.Single
		  Self.PagePanel1.SelectedPanelIndex = 0
		End Sub
	#tag EndEvent

	#tag Event
		Sub GetValuesFromDocument(Document As Beacon.Document)
		  Self.mAccounts.Import(Document.Accounts)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.SwapButtons()
		  RaiseEvent Open
		  Self.CheckActionEnabled
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Var ContentHeight As Integer = FindingLabel.Height + 12 + FindingProgress.Height
		  Var AvailableHeight As Integer = Self.Height - (52 + FindingCancelButton.Height)
		  
		  Var ContentTop As Integer = 20 + ((AvailableHeight - ContentHeight) / 2)
		  FindingLabel.Top = ContentTop
		  FindingProgress.Top = ContentTop + FindingLabel.Height + 12
		  
		  AvailableHeight = Self.Height - 40
		  ContentTop = 20 + ((AvailableHeight - ContentHeight) / 2)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AdvanceAuthQueue()
		  If Self.mAuthQueue.Count = 0 Then
		    // Finished
		    Return
		  End If
		  
		  Call Self.AuthClient.SetAccount(Self.mAuthQueue(0))
		  Self.mAuthQueue.RemoveRowAt(0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Busy() As Boolean
		  Return Self.mAuthQueue.Count > 0 Or Self.AuthClient.Busy Or Self.mPendingListActions > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ListServers(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  Self.mPendingListActions = Self.mPendingListActions - 1
		  
		  Select Case Status
		  Case 401
		    Self.ShowAlert("Nitrado API Error", "Authorization failed.")
		    Self.ShouldCancel()
		    Return
		  Case 429
		    Self.ShowAlert("Nitrado API Error", "The rate limit has been exceeded.")
		    Self.ShouldCancel()
		    Return
		  Case 503
		    Self.ShowAlert("Nitrado API Error", "Nitrado is currently offline for maintenance. Please try again later.")
		    Self.ShouldCancel()
		    Return
		  Case 200
		    // Good
		  Else
		    Self.ShowAlert("Nitrado API Error", "An unexpected error with the Nitrado API occurred. HTTP status " + Status.ToString + " was returned.")
		    Self.ShouldCancel()
		    Return
		  End Select
		  
		  Var Account As Beacon.ExternalAccount = Self.mAccounts.GetByUUID(Tag.StringValue)
		  
		  Try
		    Var Reply As Dictionary = Beacon.ParseJSON(Content)
		    If Reply.HasKey("status") = False Or Reply.Value("status") <> "success" Then
		      Self.ShowAlert("Nitrado API Error", "The request to list services was not successful.")
		      Self.ShouldCancel()
		      Return
		    End If
		    
		    Var Data As Dictionary = Reply.Value("data")
		    Var Services() As Variant = Data.Value("services")
		    For Each Service As Dictionary In Services
		      Var Type As String = Service.Value("type")
		      If Type <> "gameserver" Then
		        Continue
		      End If
		      
		      Var Details As Dictionary = Service.Value("details")
		      If IsNull(Details) Or Details.HasKey("game") = False Then
		        Continue
		      End If
		      
		      Var Game As String = Details.Value("game")
		      If Not Game.BeginsWith("Ark: Survival Evolved") Then
		        Continue
		      End If
		      
		      Var ServerName As String = Details.Value("name")
		      If Service.Lookup("comment", Nil) <> Nil Then
		        ServerName = Service.Value("comment")
		      End If
		      
		      Var ServiceID As Integer = Service.Value("id")
		      For I As Integer = 0 To Self.List.LastRowIndex
		        If Self.List.RowTagAt(I) IsA Beacon.NitradoServerProfile And Beacon.NitradoServerProfile(Self.List.RowTagAt(I)).ServiceID = ServiceID Then
		          // This service is already listed
		          Continue For Service
		        End If
		      Next
		      
		      Var Profile As New Beacon.NitradoServerProfile
		      Profile.Name = ServerName
		      Profile.Address = Details.Value("address")
		      Profile.ServiceID = ServiceID
		      Profile.ExternalAccountUUID = Account.UUID
		      
		      Self.List.AddRow("", Profile.Name, Profile.Address)
		      Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Profile
		    Next
		    
		    If Self.PagePanel1.SelectedPanelIndex <> 1 And Self.Busy = False Then
		      Self.List.Sort
		      Self.DesiredHeight = 400
		      Self.PagePanel1.SelectedPanelIndex = 1
		    End If
		  Catch Err As RuntimeException
		    
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		    Self.ShowAlert("Nitrado API Error", "The Nitrado API responded in an unexpected manner. An unhandled " + Info.FullName + " was encountered.")
		    Self.ShouldCancel()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckActionEnabled()
		  If Not Self.Busy Then
		    For I As Integer = 0 To Self.List.RowCount - 1
		      If Self.List.CellCheckBoxValueAt(I, 0) Then
		        Self.ListActionButton.Enabled = True
		        Return
		      End If
		    Next
		  End If
		  
		  Self.ListActionButton.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAccounts = New Beacon.ExternalAccountManager
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If Self.mOAuthWindow <> Nil Then
		    Self.mOAuthWindow.Close
		    Self.mOAuthWindow = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListServers(Account As Beacon.ExternalAccount)
		  Var Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Account.AccessToken
		  
		  Var URL As String = "https://api.nitrado.net/services"
		  SimpleHTTP.Get(URL, AddressOf Callback_ListServers, Account.UUID.StringValue, Headers)
		  
		  Self.mPendingListActions = Self.mPendingListActions + 1
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthQueue() As Beacon.ExternalAccount
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthWindow As OAuthAuthorizationWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingListActions As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedServers As Dictionary
	#tag EndProperty


	#tag Structure, Name = MacVersionInfo, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		MajorVersion As Integer
		  MinorVersion As Integer
		BugVersion As Integer
	#tag EndStructure


#tag EndWindowCode

#tag Events FindingCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Self.List.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  #Pragma Unused Column
		  
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListActionButton
	#tag Event
		Sub Action()
		  Var Engines() As Beacon.NitradoDiscoveryEngine
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Var Profile As Beacon.NitradoServerProfile = Self.List.RowTagAt(I)
		    Var Account As Beacon.ExternalAccount = Self.mAccounts.GetByUUID(Profile.ExternalAccountUUID)
		    Engines.AddRow(New Beacon.NitradoDiscoveryEngine(Profile, Account.AccessToken))
		  Next
		  Self.ShouldFinish(Engines, Self.mAccounts)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NewAuthButton
	#tag Event
		Sub Action()
		  Var Account As New Beacon.ExternalAccount(New v4UUID, Beacon.ExternalAccount.ProviderNitrado, "", "", Nil)
		  
		  If Self.AuthClient.Busy Then
		    Self.mAuthQueue.AddRow(Account)
		  Else
		    Call Self.AuthClient.SetAccount(Account)
		    Self.AuthClient.Authenticate(App.IdentityManager.CurrentIdentity, True)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AuthClient
	#tag Event
		Sub Authenticated()
		  Self.mAccounts.Add(Me.Account)
		  Self.ListServers(Me.Account)
		  Self.AdvanceAuthQueue()
		End Sub
	#tag EndEvent
	#tag Event
		Sub AuthenticationError()
		  Self.ShowAlert("Unable to communicate with Nitrado", "Sorry, the Nitrado API is not available at this time.")
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
	#tag Event
		Function StartAuthentication(URL As String, Provider As String) As Boolean
		  If Not Self.ShowConfirm("Open your browser to authorize with " + Provider + "?", "To continue discovering servers, you must authorize " + Provider + " to allow Beacon to access your servers.", "Continue", "Cancel") Then
		    Return False
		  End If
		  
		  ShowURL(URL)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub DismissWaitingWindow()
		  If Self.mOAuthWindow <> Nil Then
		    Self.mOAuthWindow.Close
		    Self.mOAuthWindow = Nil
		  End If
		  
		  Self.NewAuthButton.Enabled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShowWaitingWindow()
		  Self.mOAuthWindow = New OAuthAuthorizationWindow(Me)
		  Self.NewAuthButton.Enabled = False
		  Self.mOAuthWindow.Show()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Busy()
		  Self.NewAuthButton.Enabled = False
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Idle()
		  Self.NewAuthButton.Enabled = True
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LookupStartTimer
	#tag Event
		Sub Action()
		  Self.AdvanceAuthQueue()
		  
		  Self.AuthClient.Authenticate(App.IdentityManager.CurrentIdentity)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		EditorType=""
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
