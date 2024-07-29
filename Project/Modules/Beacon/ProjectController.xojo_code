#tag Class
Protected Class ProjectController
	#tag Method, Flags = &h0
		Function AddAction(ParamArray Actions() As Beacon.ScriptAction) As Boolean
		  Return Self.AddActions(Actions)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddActions(Actions() As Beacon.ScriptAction) As Boolean
		  If Self.Loaded Then
		    Return False
		  End If
		  
		  For Each NewAction As Beacon.ScriptAction In Actions
		    Var NewHash As String = NewAction.Hash
		    For Each PendingAction As Beacon.ScriptAction In Self.mActions
		      If NewHash = PendingAction.Hash Then
		        Continue For NewAction
		      End If
		    Next
		    
		    Self.mActions.Add(NewAction)
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BuildDeployURL(Settings As Beacon.DeploySettings) As String
		  If Settings Is Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "No deploy settings provided to BuildDeployURL."
		    Raise Err
		  ElseIf Settings.Servers Is Nil Or Settings.Servers.Count < 1 Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Deploy settings do not have any selected servers."
		    Raise Err
		  End If
		  
		  Var SaveInfo As String
		  Select Case Self.mProjectURL.Type
		  Case Beacon.ProjectURL.TypeCloud, Beacon.ProjectURL.TypeWeb, Beacon.ProjectURL.TypeShared
		    SaveInfo = Self.mProjectURL
		  Case Beacon.ProjectURL.TypeLocal
		    Var File As BookmarkedFolderItem = Self.mProjectURL.File
		    SaveInfo = File.SaveInfo(True)
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Target project must be a local or cloud project."
		    Raise Err
		  End Select
		  
		  SaveInfo = EncodeBase64URL(Beacon.Compress(SaveInfo))
		  
		  Var Servers() As String
		  For Each Profile As Beacon.ServerProfile In Settings.Servers
		    Servers.Add(Profile.ProfileID)
		  Next
		  
		  Var Action As New Beacon.ScriptAction("Deploy")
		  Action.Value("Options") = Settings.Options.ToString(Locale.Raw, "0")
		  Action.Value("Servers") = String.FromArray(Servers, ",")
		  Action.Value("StopMessage") = Settings.StopMessage
		  Action.Value("Plan") = CType(Settings.Plan, Integer).ToString(Locale.Raw, "0")
		  
		  Return "beacon://run/" + SaveInfo + "?" + Action.ToQueryString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  Return (Self.mActiveThread Is Nil) = False And Self.mActiveThread.ThreadState <> Thread.ThreadStates.NotRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanWrite() As Boolean
		  If Self.mProjectURL.Type = Beacon.ProjectURL.TypeWeb Or Self.mProjectURL.Type = Beacon.ProjectURL.TypeCommunity Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As Beacon.Project, WithIdentity As Beacon.Identity, CustomProjectUrl As Beacon.ProjectURL = Nil)
		  If (CustomProjectUrl Is Nil) = False Then
		    Self.mProjectURL = CustomProjectUrl
		  Else
		    Self.mProjectURL = Beacon.ProjectURL.TypeTransient + "://" + Project.ProjectId + "?name=" + EncodeURLComponent(Project.Title) + "&game=" + EncodeURLComponent(Project.GameId.Lowercase)
		  End If
		  Self.mLoaded = True
		  Self.mProject = Project
		  Self.mIdentity = WithIdentity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(URL As Beacon.ProjectURL, WithIdentity As Beacon.Identity)
		  Self.mProjectURL = URL
		  Self.mIdentity = WithIdentity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GameId As String, WithIdentity As Beacon.Identity)
		  Self.Constructor(Beacon.ProjectURL.TypeTransient + "://" + Beacon.UUID.v4 + "?game=" + EncodeURLComponent(GameId.Lowercase), WithIdentity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  If Self.Busy Then
		    Return
		  End If
		  
		  Self.mActiveThread = New Beacon.Thread
		  Self.mActiveThread.Priority = Thread.LowestPriority
		  Self.mActiveThread.DebugIdentifier = CurrentMethodName
		  AddHandler Self.mActiveThread.Run, AddressOf Thread_Delete
		  Self.mActiveThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mLoadStartedCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ErrorMessageFromResponse(Response As BeaconAPI.Response) As String
		  If Response.HTTPStatus = 401 Then
		    Return "Unauthorized"
		  ElseIf Response.HTTPStatus = 403 Then
		    Return "You do not have permission to access this project."
		  End If
		  
		  Var Message As String = "The error reason is unknown"
		  If (Response.Content Is Nil) = False Then
		    Try
		      Message = Response.Content
		      Var Dict As Dictionary = Beacon.ParseJSON(Message)
		      If Dict.HasKey("message") Then
		        Message = Dict.Value("message")
		      ElseIf Dict.HasKey("description") Then
		        Message = Dict.Value("description")
		      End If
		    Catch Err As RuntimeException
		      
		    End Try
		  ElseIf Response.Message.IsEmpty = False Then
		    Message = Response.Message
		  End If
		  Return Message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ErrorMessageFromSocket(Socket As SimpleHTTP.SynchronousHTTPSocket) As String
		  If Socket.HTTPStatusCode = 401 Then
		    Return "Unauthorized"
		  ElseIf Socket.HTTPStatusCode = 403 Then
		    Return "You do not have permission to access this project."
		  End If
		  
		  Var Message As String = "The error reason is unknown"
		  If (Socket.LastContent Is Nil) = False Then
		    Try
		      Message = Socket.LastContent
		      Var Dict As Dictionary = Beacon.ParseJSON(Message)
		      If Dict.HasKey("message") Then
		        Message = Dict.Value("message")
		      ElseIf Dict.HasKey("description") Then
		        Message = Dict.Value("description")
		      End If
		    Catch Err As RuntimeException
		      
		    End Try
		  ElseIf (Socket.LastException Is Nil) = False Then
		    Message = Socket.LastException.Explanation
		  End If
		  Return Message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  If (Self.mProject Is Nil) = False Then
		    Return Self.mProject.GameId
		  Else
		    Return Self.mProjectURL.GameId
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load()
		  Var EmptyArray() As Beacon.ScriptAction
		  Self.Load(EmptyArray)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load(Actions() As Beacon.ScriptAction)
		  Call Self.AddActions(Actions)
		  
		  If Self.Loaded Then
		    Self.TriggerLoadSuccess()
		    Return
		  End If
		  
		  If Self.Busy Then
		    Return
		  End If
		  
		  Self.mActiveThread = New Beacon.Thread
		  Self.mActiveThread.Priority = Thread.LowestPriority
		  Self.mActiveThread.DebugIdentifier = CurrentMethodName
		  AddHandler Self.mActiveThread.Run, AddressOf Thread_Load
		  Self.mActiveThread.Start
		  
		  Self.mLoadStartedCallbackKey = CallLater.Schedule(1500, AddressOf TriggerLoadStarted)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Loaded() As Boolean
		  Return Self.mLoaded
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  If Self.mProject <> Nil And Self.mProject.Title.IsEmpty = False Then
		    Return Self.mProject.Title
		  Else
		    Return Self.mProjectURL.Name
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Beacon.Project
		  Return Self.mProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Project(Assigns Replacement As Beacon.Project)
		  Self.mProject = Replacement
		  Self.mLoaded = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  If Self.Busy Or Self.Loaded = False Then
		    Return
		  End If
		  
		  If Self.mProject.Title.Compare(Self.mProjectUrl.Name, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mProjectUrl = Beacon.ProjectUrl.Create(Self.mProject, Self.mProjectUrl)
		  End If
		  
		  Self.WriteTo(Self.mProjectURL, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveACopy(Destination As Beacon.ProjectURL) As Beacon.ProjectController
		  // Like Save As, but the destination is not saved
		  If Self.Loaded = False Then
		    Return Nil
		  End If
		  
		  Var Controller As New Beacon.ProjectController(Self.mProject, Self.mIdentity)
		  If Self.mProject.Title.Compare(Destination.Name, ComparisonOptions.CaseSensitive) <> 0 Then
		    Destination = Beacon.ProjectUrl.Create(Self.mProject, Destination)
		  End If
		  
		  Controller.mProjectURL = Destination
		  If Destination.Autosave Then
		    Controller.mOriginalUrl = Self.mProjectURL
		  End If
		  
		  Controller.WriteTo(Destination, False)
		  Return Controller
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(Destination As Beacon.ProjectURL)
		  If Self.Busy Or Self.Loaded = False Then
		    Return
		  End If
		  
		  Self.mProjectURL = Destination
		  Self.Save()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Delete(Sender As Beacon.Thread)
		  If Not Self.CanWrite Then
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteError, "Project is not writeable")
		    Return
		  End If
		  
		  Select Case Self.mProjectURL.Type
		  Case Beacon.ProjectURL.TypeCloud, Beacon.ProjectURL.TypeShared
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(New BeaconAPI.Request(Self.mProjectURL.Path, "DELETE"))
		    If Response.HTTPStatus = 200 Then
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Else
		      Var Message As String = Self.ErrorMessageFromResponse(Response)
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteError, Message)
		    End If
		  Case Beacon.ProjectURL.TypeLocal
		    Try
		      If Self.mFileRef <> Nil And Self.mFileRef.Exists Then
		        Self.mFileRef.Remove
		      End If
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Catch Err As RuntimeException
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteError, Err.Explanation)
		    End Try
		  Case Beacon.ProjectURL.TypeTransient
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		  Else
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteError, "Unknown storage url type " + Self.mProjectURL.Type)
		  End Select
		  
		  RemoveHandler Sender.Run, AddressOf Thread_Delete
		  If Self.mActiveThread = Sender Then
		    Self.mActiveThread = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Load(Sender As Beacon.Thread)
		  Var FileContent As MemoryBlock
		  
		  Select Case Self.mProjectURL.Type
		  Case Beacon.ProjectURL.TypeCloud, Beacon.ProjectURL.TypeShared, Beacon.ProjectURL.TypeCommunity
		    // authenticated api request
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(New BeaconAPI.Request(Self.mProjectURL.Path, "GET"))
		    If Response.HTTPStatus >= 200 And Response.HTTPStatus < 300 Then
		      FileContent = Response.Content
		    Else
		      Var Message As String = Self.ErrorMessageFromResponse(Response)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		      Return
		    End If
		  Case Beacon.ProjectURL.TypeWeb
		    // basic https request
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Cache-Control") = "no-cache"
		    Socket.Send("GET", Self.mProjectURL.Path)
		    If Socket.LastHTTPStatus >= 200 And Socket.LastHTTPStatus < 300 Then
		      FileContent = Socket.LastContent
		    Else
		      Var Message As String = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		      Return
		    End If
		  Case Beacon.ProjectURL.TypeLocal
		    // just a local file
		    Var Success As Boolean
		    Var Message As String
		    Try
		      Var File As BookmarkedFolderItem = Self.mProjectURL.File
		      If File <> Nil And File.Exists Then
		        FileContent = File.Read()
		        Self.mFileRef = File // Just to keep the security scoped bookmark open
		        Success = True
		      End If
		    Catch Err As RuntimeException
		      If Err.ErrorNumber = 1 And TargetMacOS Then
		        Message = "The macOS sandbox denied Beacon permission to read the file. This can happen if the project is locked in Finder. Open the project using the File menu or by dragging it to the Beacon icon in the dock."
		      Else
		        Message = Err.Explanation
		        If Message.IsEmpty Then
		          Message = "Could not load any data from file."
		        End If
		      End If
		    End Try
		    
		    If Not Success Then
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		      Return
		    End If
		  Case Beacon.ProjectURL.TypeTransient
		    Var Temp As Beacon.Project = Beacon.Project.CreateForGameId(Self.mProjectURL.GameId)
		    FileContent = Beacon.GenerateJSON(Temp.SaveData(Self.mIdentity), False)
		  Else
		    Return
		  End Select
		  
		  If FileContent Is Nil Then
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, "File is empty")
		    Return
		  End If
		  
		  Var Project As Beacon.Project
		  Var AdditionalProperties As New Dictionary
		  Try
		    Project = Beacon.Project.FromSaveData(FileContent, Self.mIdentity, AdditionalProperties)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Loading project")
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, Err.Message)
		    Return
		  End Try
		  
		  If Project.Title.Trim = "" Then
		    Project.Title = Self.Name
		  End If
		  
		  If AdditionalProperties.HasKey("OriginalUrl") Then
		    Try
		      Var OriginalUrlString As String = Beacon.Decompress(DecodeBase64MBS(AdditionalProperties.Value("OriginalUrl").StringValue)).DefineEncoding(Encodings.UTF8)
		      Var OriginalUrl As New Beacon.ProjectURL(OriginalUrlString)
		      Self.mProjectURL = OriginalUrl
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Restoring original url")
		    End Try
		  End If
		  
		  Self.mProject = Project
		  Self.UpdateProjectMembers()
		  
		  Self.mLoaded = True
		  Call CallLater.Schedule(0, AddressOf TriggerLoadSuccess)
		  
		  RemoveHandler Sender.Run, AddressOf Thread_Load
		  If Self.mActiveThread = Sender Then
		    Self.mActiveThread = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_UpdateProjectMembers(Sender As Beacon.Thread)
		  Self.UpdateProjectMembers()
		  RemoveHandler Sender.Run, AddressOf Thread_UpdateProjectMembers
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Upload(Sender As Beacon.Thread)
		  Var SaveData As MemoryBlock
		  Var Saved As Boolean
		  Var Message As String
		  Try
		    Self.UpdateProjectMembers()
		    
		    // Download the most recent token keys for the user
		    Var TokenIds() As String = Self.mProject.ProviderTokenIds
		    If (TokenIds Is Nil) = False And TokenIds.Count > 0 Then
		      Var Tokens() As BeaconAPI.ProviderToken = BeaconAPI.GetProviderTokens(Self.mIdentity.UserId, TokenIds)
		      If (Tokens Is Nil) = False Then
		        For Each Token As BeaconAPI.ProviderToken In Tokens
		          Try
		            Self.mProject.AddProviderToken(Token)
		          Catch Err As RuntimeException
		          End Try
		        Next
		      End If
		    End If
		    
		    SaveData = Self.mProject.SaveData(Self.mIdentity, True)
		    
		    If (SaveData Is Nil) = False And SaveData.Size > 0 Then
		      Var Request As New BeaconAPI.Request("/projects", "POST", SaveData, "application/x-beacon-project")
		      If App.Pusher.SocketId.IsEmpty = False Then
		        Request.RequestHeader("X-Beacon-Pusher-Id") = App.Pusher.SocketId
		      End If
		      Request.RequestHeader("X-Beacon-Device-Id") = Beacon.HardwareId
		      Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		      Saved = Response.HTTPStatus = 200 Or Response.HTTPStatus = 201
		      Message = Self.ErrorMessageFromResponse(Response)
		    End If
		    
		    If Self.mProject.KeepLocalBackup Then
		      Var BackupFolder As FolderItem = App.BackupsFolder.Child("Projects")
		      If BackupFolder.CheckIsFolder Then
		        Var BackupFile As FolderItem = BackupFolder.Child(Self.mProject.ProjectId + ".beacon")
		        Try
		          BackupFile.Write(SaveData)
		          Saved = True
		        Catch LocalErr As RuntimeException
		          App.Log(LocalErr, CurrentMethodName, "Writing local backup")
		        End Try
		      End If
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Uploading cloud project")
		    Message = Err.Message
		  End Try
		  
		  If Saved Then
		    If Self.mClearModifiedOnWrite Then
		      Self.mProject.Modified = False
		    End If
		    Call CallLater.Schedule(0, AddressOf TriggerWriteSuccess)
		  Else
		    If Message.IsEmpty Then
		      Message = "Unknown error"
		    End If
		    Call CallLater.Schedule(0, AddressOf TriggerWriteError, Message)
		  End If
		  
		  RemoveHandler Sender.Run, AddressOf Thread_Upload
		  If Self.mActiveThread = Sender Then
		    Self.mActiveThread = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Write(Sender As Beacon.Thread)
		  Var SaveData As MemoryBlock
		  Var Saved As Boolean
		  Var Message As String
		  Try
		    Self.UpdateProjectMembers()
		    
		    Var AdditionalProperties As New Dictionary
		    If (Self.mOriginalUrl Is Nil) = False Then
		      AdditionalProperties.Value("OriginalUrl") = EncodeBase64MBS(Beacon.Compress(Self.mOriginalUrl.StringValue))
		    End If
		    
		    SaveData = Self.mProject.SaveData(Self.mIdentity, AdditionalProperties)
		    If (SaveData Is Nil) = False And SaveData.Size > 0 Then
		      Self.mDestination.File.Write(SaveData)
		      Saved = True
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Writing save data to disk")
		    Message = Err.Message
		  End Try
		  
		  If Saved Then
		    If Self.mClearModifiedOnWrite Then
		      Self.mProject.Modified = False
		    End If
		    Call CallLater.Schedule(0, AddressOf TriggerWriteSuccess)
		  Else
		    If Message.IsEmpty Then
		      Message = "Unknown error"
		    End If
		    Call CallLater.Schedule(0, AddressOf TriggerWriteError, Message)
		  End If
		  
		  RemoveHandler Sender.Run, AddressOf Thread_Write
		  If Self.mActiveThread = Sender Then
		    Self.mActiveThread = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerDeleteError(Reason As Variant)
		  RaiseEvent DeleteError(Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerDeleteSuccess()
		  RaiseEvent DeleteSuccess
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerLoadError(Reason As Variant)
		  CallLater.Cancel(Self.mLoadStartedCallbackKey)
		  
		  RaiseEvent LoadError(Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerLoadStarted()
		  RaiseEvent LoadStarted()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerLoadSuccess()
		  CallLater.Cancel(Self.mLoadStartedCallbackKey)
		  
		  Var Actions() As Beacon.ScriptAction = Self.mActions
		  Var NewActions() As Beacon.ScriptAction
		  Self.mActions = NewActions
		  
		  RaiseEvent Loaded(Self.mProject, Actions)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerWriteError(Reason As Variant)
		  RaiseEvent WriteError(Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerWriteSuccess()
		  RaiseEvent WriteSuccess
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateProjectMembers()
		  // This routine will download the member list and update the project if necessary
		  
		  If Global.Thread.Current Is Nil Then
		    Var UpdaterThread As New Beacon.Thread
		    UpdaterThread.DebugIdentifier = CurrentMethodName
		    AddHandler UpdaterThread.Run, AddressOf Thread_UpdateProjectMembers
		    UpdaterThread.Retain
		    UpdaterThread.Start
		    Return
		  End If
		  
		  Var CurrentThread As Global.Thread = Global.Thread.Current
		  
		  If Self.mMemberUpdateLock Is Nil Then
		    Self.mMemberUpdateLock = New CriticalSection
		  End If
		  Self.mMemberUpdateLock.Enter
		  
		  Try
		    // If we don't know the password, don't do anything
		    If Project.PasswordDecrypted = False Then
		      Self.mMemberUpdateLock.Leave
		      Return
		    End If
		    
		    Select Case Self.mProjectURL.Type
		    Case Beacon.ProjectURL.TypeCloud, Beacon.ProjectURL.TypeShared
		      Var Response As BeaconAPI.Response = BeaconAPI.SendSync(New BeaconAPI.Request("/projects/" + EncodeURLComponent(Project.ProjectId) + "/members", "GET"))
		      If Response.Success Then
		        // Could be 404 error because the project is new, which is ok
		        Var Members() As Beacon.ProjectMember
		        Var MemberList() As Variant = Response.JSON
		        For Each MemberInfo As Variant In MemberList
		          Var MemberDict As Dictionary = MemberInfo
		          Var UserId As String = MemberDict.Value("userId")
		          Members.Add(New Beacon.ProjectMember(UserId, MemberDict))
		        Next
		        
		        Self.UpdateProjectMembers(Members)
		      End If
		    Case Beacon.ProjectURL.TypeLocal, Beacon.ProjectURL.TypeTransient
		      Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		      If (Identity Is Nil) = False Then
		        Var Member As New Beacon.ProjectMember(Identity, Beacon.ProjectMember.RoleOwner)
		        Member.SetPassword(Project.Password)
		        Var Members(0) As Beacon.ProjectMember
		        Members(0) = Member
		        Self.UpdateProjectMembers(Members)
		      End If
		    End Select
		  Catch MemberListError As RuntimeException
		    App.Log(MemberListError, CurrentMethodName, "Updating project members")
		  End Try
		  
		  Self.mMemberUpdateLock.Leave
		  
		  If CurrentThread IsA Beacon.Thread Then
		    Beacon.Thread(CurrentThread).Release
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateProjectMembers(Members() As Beacon.ProjectMember)
		  Var Project As Beacon.Project = Self.Project
		  Var CurrentMembers() As Beacon.ProjectMember = Project.GetMembers
		  Var RemoveMembers As New Dictionary
		  For Each Member As Beacon.ProjectMember In CurrentMembers
		    RemoveMembers.Value(Member.UserId) = True
		  Next
		  
		  For Each Member As Beacon.ProjectMember In Members
		    // Returns true only if changes are needed and they were made
		    If Project.AddMember(Member) Then
		      App.Log("Encrypted project password for user `" + Member.UserId + "` was updated…")
		    End If
		    
		    If RemoveMembers.HasKey(Member.UserId) Then
		      RemoveMembers.Remove(Member.UserId)
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In RemoveMembers
		    Call Project.RemoveMember(Entry.Key.StringValue)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As ProjectURL
		  Return Self.mProjectURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Writer_Finished(Sender As Beacon.JSONWriter, Destination As FolderItem)
		  If Sender = Nil Or Destination = Nil Then
		    Return
		  End If
		  
		  If Sender.Success Then
		    If Self.mClearModifiedOnWrite And Self.mProject <> Nil Then
		      Self.mProject.Modified = False
		    End If
		    
		    // Update the project url to regenerate saveinfo/bookmarks
		    If Destination IsA BookmarkedFolderItem Then
		      Self.mProjectURL = Beacon.ProjectURL.Create(Self.mProject, BookmarkedFolderItem(Destination))
		    Else
		      Self.mProjectURL = Beacon.ProjectURL.Create(Self.mProject, New BookmarkedFolderItem(Destination))
		    End If
		    
		    RaiseEvent WriteSuccess()
		  Else
		    Var Reason As String
		    Var Err As RuntimeException = Sender.Error
		    If (Err Is Nil) = False Then
		      Reason = Err.Explanation
		      If Reason = "" Then
		        Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		        If Info <> Nil Then
		          Reason = Info.Name + " from JSONWriter"
		        End If
		      End If
		    End If
		    
		    If Reason.IsEmpty Then
		      Reason = "Unknown JSONWriter error"
		    End If
		    
		    RaiseEvent WriteError(Reason)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteTo(Destination As Beacon.ProjectURL, ClearModified As Boolean)
		  If Self.Busy Or Self.Loaded = False Or Destination.Type.OneOf(Beacon.ProjectURL.TypeCloud, Beacon.ProjectURL.TypeShared, Beacon.ProjectURL.TypeLocal) = False Then
		    Return
		  End If
		  
		  Self.mClearModifiedOnWrite = ClearModified
		  Self.mDestination = Destination
		  
		  Select Case Destination.Type
		  Case Beacon.ProjectURL.TypeCloud, Beacon.ProjectURL.TypeShared
		    Self.mActiveThread = New Beacon.Thread
		    Self.mActiveThread.DebugIdentifier = CurrentMethodName
		    Self.mActiveThread.Priority = Thread.LowestPriority
		    AddHandler Self.mActiveThread.Run, AddressOf Thread_Upload
		    Self.mActiveThread.Start
		  Case Beacon.ProjectURL.TypeLocal
		    Self.mActiveThread = New Beacon.Thread
		    Self.mActiveThread.DebugIdentifier = CurrentMethodName
		    Self.mActiveThread.Priority = Thread.LowestPriority
		    AddHandler Self.mActiveThread.Run, AddressOf Thread_Write
		    Self.mActiveThread.Start
		  End Select
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DeleteError(Reason As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DeleteSuccess()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Loaded(Project As Beacon.Project, Actions() As Beacon.ScriptAction)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadError(Reason As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadProgress(BytesReceived As Int64, BytesTotal As Int64)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteError(Reason As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteSuccess()
	#tag EndHook


	#tag Property, Flags = &h0
		AutosaveURL As Beacon.ProjectURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mActions() As Beacon.ScriptAction
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mActiveThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClearModifiedOnWrite As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestination As Beacon.ProjectURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileRef As BookmarkedFolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoaded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoadStartedCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMemberUpdateLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalUrl As Beacon.ProjectURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Beacon.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectURL As Beacon.ProjectURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadThread As Beacon.Thread
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
