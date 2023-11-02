#tag DesktopWindow
Begin BeaconDialog UserMigratorDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   222
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   92
   MaximumWidth    =   600
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   92
   MinimumWidth    =   400
   Resizeable      =   False
   Title           =   "#DialogTitle"
   Type            =   0
   Visible         =   False
   Width           =   600
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   222
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   600
      Begin DesktopLabel MessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
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
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "#MessageLabelPlural"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopProgressBar Bar
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Value           =   50.0
         Visible         =   True
         Width           =   560
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopButton FinishedButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "#FinishedCaption"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   182
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel ResultsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
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
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "#MigrationResultsMessage"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel ResultsExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   118
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
         Selectable      =   True
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "#MultiSuccessMultiErrorExplanation"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
   End
   Begin Beacon.Thread MigratorThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   ""
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  If mInstance = Self Then
		    mInstance = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.Height = 92
		  Self.MigratorThread.DebugIdentifier = "User Migrator"
		  Self.MigratorThread.Start
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Authenticate(Identity As Beacon.Identity) As BeaconAPI.OAuthToken
		  Var OAuthState As String = Beacon.UUID.v4
		  Var Params As New Dictionary
		  Params.Value("state") = OAuthState
		  Params.Value("client_id") = BeaconAPI.ClientId
		  Params.Value("no_redirect") = "true"
		  Params.Value("device_id") = Beacon.HardwareId
		  Params.Value("scope") = "common users:read users:update users:delete auth.public_key:create"
		  
		  Var Expiration As String = Ceiling(DateTime.Now.SecondsFrom1970 + 90).ToString(Locale.Raw, "0")
		  Var StringToSign As String = Identity.UserId + ";" + Expiration
		  Var Signature As String = EncodeBase64URLMBS(Identity.Sign(StringToSign))
		  
		  Params.Value("user_id") = Identity.UserId
		  Params.Value("expiration") = Expiration
		  Params.Value("signature") = Signature
		  Params.Value("public_key") = Identity.PublicKey()
		  
		  Var AuthRequest As New BeaconAPI.Request("/login", "GET", Params)
		  AuthRequest.RequiresAuthentication = False
		  Var AuthResponse As BeaconAPI.Response = BeaconAPI.SendSync(AuthRequest)
		  If AuthResponse.Success = False Then
		    App.Log("Failed to authenticate with anonymous account.")
		    Return Nil
		  End If
		  
		  Try
		    Return BeaconAPI.OAuthToken.Load(AuthResponse.Content)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing anonymous account authorization.")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Candidates() As Beacon.Identity, Silent As Boolean)
		  Self.mCandidates = Candidates
		  Self.mResults = New Dictionary
		  Self.mSilent = Silent
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MigrateCloudFiles(Identity As Beacon.Identity, Token As BeaconAPI.OAuthToken) As Boolean
		  Var CloudKey As String = Identity.UserCloudKey
		  If CloudKey.IsEmpty Then
		    Return True // Fake success
		  End If
		  
		  Var ListRequest As New BeaconAPI.Request("/files", "GET")
		  ListRequest.ForceAuthorize(Token)
		  Var ListResponse As BeaconAPI.Response = BeaconAPI.SendSync(ListRequest)
		  If ListResponse.Success = False Then
		    App.Log("Failed to list user files.")
		    Return False
		  End If
		  
		  Var Paths As New JSONItem(ListResponse.Content)
		  If Paths.IsArray = False Then
		    App.Log("User file list is not an array.")
		    Return False
		  End If
		  
		  For Idx As Integer = 0 To Paths.LastRowIndex
		    Var PathInfo As JSONItem = Paths.ChildAt(Idx)
		    Var IsDeleted As Boolean = PathInfo.Value("deleted")
		    If IsDeleted Then
		      Continue
		    End If
		    
		    Var Path As String = PathInfo.Value("path")
		    If UserCloud.FileExists(Path) Then
		      // Do not overwrite new files with old content
		      Continue
		    End If
		    
		    Var DownloadRequest As New BeaconAPI.Request("/files" + Path, "GET")
		    DownloadRequest.ForceAuthorize(Token)
		    Var DownloadResponse As BeaconAPI.Response = BeaconAPI.SendSync(DownloadRequest)
		    If DownloadResponse.Success = False Then
		      App.Log("Failed to download file " + Path + ".")
		      Return False
		    End If
		    
		    Var Content As MemoryBlock = DownloadResponse.Content
		    If BeaconEncryption.IsEncrypted(Content) Then
		      Try
		        Content = BeaconEncryption.SymmetricDecrypt(Content, CloudKey)
		      Catch Err As RuntimeException
		        App.Log("Failed to decrypt file " + Path + ".")
		        Return False
		      End Try
		    End If
		    
		    Var Written As Boolean = UserCloud.Write(Path, Content)
		    If Not Written Then
		      App.Log("Failed to upload file " + Path + ".")
		      Return False
		    End If
		  Next
		  
		  UserCloud.Sync
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Silent As Boolean)
		  If mInstance Is Nil Then
		    Var Manager As IdentityManager = App.IdentityManager
		    If Manager.CurrentIdentity Is Nil Or Manager.CurrentIdentity.IsAnonymous Then
		      If Silent = False Then
		        BeaconUI.ShowAlert("Account migration is not possible", "You are currently using an anonymous account. Account migration is only possible from anonymous accounts into named accounts.")
		      End If
		      Return
		    End If
		    
		    Var Candidates() As Beacon.Identity = Manager.MergeCandidates
		    If Candidates.Count = 0 Then
		      If Silent = False Then
		        BeaconUI.ShowAlert("All anonymous accounts have been migrated", "Beacon did not find any anonymous accounts on your computer that can be migrated into your account.")
		      End If
		      Return
		    End If
		    
		    mInstance = New UserMigratorDialog(Candidates, Silent)
		  End If
		  
		  If Silent = False Then
		    mInstance.Visible = True
		    mInstance.Show()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowResults()
		  If Self.mSilent Then
		    Self.Close()
		    Return
		  End If
		  
		  Self.Pages.SelectedPanelIndex = Self.PageResults
		  
		  Var SuccessCount, ErrorCount As Integer
		  For Each Entry As DictionaryEntry In Self.mResults
		    If Entry.Value.Type = Variant.TypeBoolean And Entry.Value.BooleanValue = True Then
		      SuccessCount = SuccessCount + 1
		    Else
		      ErrorCount = ErrorCount + 1
		    End If
		  Next
		  
		  Var Explanation As String
		  If SuccessCount = Self.mResults.KeyCount Then
		    // All Success
		    If SuccessCount = 1 Then
		      Explanation = AllSuccessExplanationSingular
		    Else
		      Explanation = Language.ReplacePlaceholders(AllSuccessExplanationPlural, SuccessCount.ToString(Locale.Current, ",##0"))
		    End If
		  ElseIf ErrorCount = Self.mResults.KeyCount Then
		    // All Error
		    If ErrorCount = 1 Then
		      Explanation = AllErrorExplanationSingular
		    Else
		      Explanation = Language.ReplacePlaceholders(AllErrorExplanationPlural, ErrorCount.ToString(Locale.Current, ",##0"))
		    End If
		  Else
		    // Mix
		    If SuccessCount = 1 And ErrorCount = 1 Then
		      Explanation = SingleSuccessSingleErrorExplanation
		    ElseIf SuccessCount > 1 And ErrorCount = 1 Then
		      Explanation = Language.ReplacePlaceholders(MultiSuccessSingleErrorExplanation, SuccessCount.ToString(Locale.Current, ",##0"))
		    ElseIf SuccessCount = 1 And ErrorCount > 1 Then
		      Explanation = Language.ReplacePlaceholders(SingleSuccessMultiErrorExplanation, ErrorCount.ToString(Locale.Current, ",##0"))
		    Else
		      Explanation = Language.ReplacePlaceholders(MultiSuccessMultiErrorExplanation, SuccessCount.ToString(Locale.Current, ",##0"), ErrorCount.ToString(Locale.Current, ",##0"))
		    End If
		  End If
		  
		  Self.ResultsExplanationLabel.Text = Explanation
		  Self.ResultsExplanationLabel.Height = Self.ResultsExplanationLabel.IdealHeight
		  
		  Self.MaximumHeight = Self.ResultsExplanationLabel.Bottom + Self.FinishedButton.Height + 32
		  Self.Height = Self.MaximumHeight
		  Self.MinimumHeight = Self.Height
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCandidates() As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As UserMigratorDialog
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResults As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSilent As Boolean
	#tag EndProperty


	#tag Constant, Name = AllErrorExplanationPlural, Type = String, Dynamic = True, Default = \"All \?1 anonymous accounts were not migrated. Beacon\'s log files may have more information.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = AllErrorExplanationSingular, Type = String, Dynamic = True, Default = \"Your previous anonymous account was not migrated. Beacon\'s log files may have more information.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = AllSuccessExplanationPlural, Type = String, Dynamic = True, Default = \"All \?1 anonymous accounts were successfully migrated.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = AllSuccessExplanationSingular, Type = String, Dynamic = True, Default = \"Your previous anonymous account was migrated successfully.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DialogTitle, Type = String, Dynamic = True, Default = \"Migrate Anonymous Accounts", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FinishedCaption, Type = String, Dynamic = True, Default = \"Done", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MessageLabelPlural, Type = String, Dynamic = True, Default = \"Migrating \?1 Accounts", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MessageLabelSingular, Type = String, Dynamic = True, Default = \"Migrating Your Account", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MigrationResultsMessage, Type = String, Dynamic = True, Default = \"Migration Results", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MultiSuccessMultiErrorExplanation, Type = String, Dynamic = True, Default = \"\?1 anonymous accounts were migrated\x2C but \?2 anonymous accounts were not. Beacon\'s log files may have more information.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MultiSuccessSingleErrorExplanation, Type = String, Dynamic = True, Default = \"\?1 anonymous accounts were migrated\x2C but one anonymous account was not. Beacon\'s log files may have more information.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageResults, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageStatus, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SingleSuccessMultiErrorExplanation, Type = String, Dynamic = True, Default = \"One anonymous account was migrated\x2C but \?1 anonymous accounts were not. Beacon\'s log files may have more information.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SingleSuccessSingleErrorExplanation, Type = String, Dynamic = True, Default = \"One anonymous account was migrated\x2C but one anonymous account was not. Beacon\'s log files may have more information.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events MessageLabel
	#tag Event
		Sub Opening()
		  If Self.mCandidates.Count = 1 Then
		    Me.Text = Language.ReplacePlaceholders(Self.MessageLabelSingular, "1")
		  Else
		    Me.Text = Language.ReplacePlaceholders(Self.MessageLabelPlural, Self.mCandidates.Count.ToString(Locale.Current, ",##0"))
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Bar
	#tag Event
		Sub Opening()
		  If Self.mCandidates.Count = 1 Then
		    Me.Indeterminate = True
		  Else
		    Me.Indeterminate = False
		    Me.MaximumValue = Self.mCandidates.Count
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FinishedButton
	#tag Event
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MigratorThread
	#tag Event
		Sub Run()
		  While UserCloud.IsBusy
		    Me.Sleep(100)
		  Wend
		  
		  Var Manager As IdentityManager = App.IdentityManager
		  For Each Identity As Beacon.Identity In Self.mCandidates
		    Try
		      Var RequestContent As New JSONItem
		      RequestContent.Value("userId") = Identity.UserId
		      RequestContent.Value("privateKey") = Identity.PrivateKey
		      
		      Var Response As BeaconAPI.Response = BeaconAPI.SendSync(New BeaconAPI.Request("/user/merge", "POST", RequestContent.ToString(), "application/json"))
		      If Response.Success = False Then
		        If Response.HTTPStatus = 404 Then
		          // User doesn't exist, mark it as merged so we don't try again
		          Manager.MarkedMerged(Identity)
		        End If
		        
		        Var MigrateErr As New UnsupportedOperationException
		        MigrateErr.Message = "Failed: " + Response.Message
		        Raise MigrateErr
		      End If
		      
		      Var Token As BeaconAPI.OAuthToken = Self.Authenticate(Identity)
		      If Token Is Nil Then
		        Var LoginErr As New UnsupportedOperationException
		        LoginErr.Message = "Failed: Could not authenticate as anonymous user."
		        Raise LoginErr
		      End If
		      
		      If Self.MigrateCloudFiles(Identity, Token) = False Then
		        Var FilesErr As New UnsupportedOperationException
		        FilesErr.Message = "Failed: Cloud files were not moved."
		        Raise FilesErr
		      End If
		      
		      Var DeleteRequest As New BeaconAPI.Request("/user", "DELETE")
		      DeleteRequest.ForceAuthorize(Token)
		      Var DeleteResponse As BeaconAPI.Response = BeaconAPI.SendSync(DeleteRequest)
		      If DeleteResponse.Success = False Then
		        App.Log("Anonymous user `" + Identity.UserId + "` was not deleted.")
		        
		        // At least try to sign out
		        Var LogoutRequest As New BeaconAPI.Request("/session", "DELETE")
		        LogoutRequest.ForceAuthorize(Token)
		        Var LogoutResponse As BeaconAPI.Response = BeaconAPI.SendSync(LogoutRequest)
		        If LogoutResponse.Success = False Then
		          App.Log("Anonymous user `" + Identity.UserId + "` was not signed out.")
		        End If
		      End If
		      
		      Manager.MarkedMerged(Identity)
		      Self.mResults.Value(Identity.UserId) = True
		    Catch Err As RuntimeException
		      Self.mResults.Value(Identity.UserId) = Err
		    End Try
		    
		    Var Update As New Dictionary
		    Update.Value("Event") = "Refresh"
		    Me.AddUserInterfaceUpdate(Update)
		    Me.Sleep(100)
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Var EventName As String = Update.Lookup("Event", "").StringValue
		    Select Case EventName
		    Case "Refresh"
		      Self.Bar.Value = Self.mResults.KeyCount
		      
		      If Self.mResults.KeyCount = Self.mCandidates.Count Then
		        Self.ShowResults()
		      End If
		    End Select
		  Next
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
