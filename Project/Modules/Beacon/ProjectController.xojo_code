#tag Class
Protected Class ProjectController
	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  Return Self.mActiveThread <> Nil And Self.mActiveThread.ThreadState <> Thread.ThreadStates.NotRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanWrite() As Boolean
		  If Self.mProjectURL.Scheme = Beacon.ProjectURL.TypeWeb Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As Beacon.Project, WithIdentity As Beacon.Identity)
		  Self.mProjectURL = Beacon.ProjectURL.TypeTransient + "://" + Project.UUID + "?name=" + EncodeURLComponent(Project.Title) + "&game=" + EncodeURLComponent(Project.GameID.Lowercase)
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
		Sub Constructor(GameID As String, WithIdentity As Beacon.Identity)
		  Self.Constructor(Beacon.ProjectURL.TypeTransient + "://" + v4UUID.Create + "?game=" + EncodeURLComponent(GameID.Lowercase), WithIdentity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  If Self.Busy Then
		    Return
		  End If
		  
		  Self.mActiveThread = New Thread
		  Self.mActiveThread.Priority = Thread.LowestPriority
		  AddHandler Self.mActiveThread.Run, WeakAddressOf Thread_Delete
		  Self.mActiveThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mLoadStartedCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ErrorMessageFromSocket(Socket As SimpleHTTP.SynchronousHTTPSocket) As String
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
		Function GameID() As String
		  Return Self.mProjectURL.GameID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load()
		  If Self.Loaded Then
		    RaiseEvent Loaded(Self.mProject)
		    Return
		  End If
		  
		  If Self.Busy Then
		    Return
		  End If
		  
		  Self.mActiveThread = New Thread
		  Self.mActiveThread.Priority = Thread.LowestPriority
		  AddHandler Self.mActiveThread.Run, WeakAddressOf Thread_Load
		  Self.mActiveThread.Start
		  
		  Self.mLoadStartedCallbackKey = CallLater.Schedule(1500, WeakAddressOf TriggerLoadStarted)
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
		  
		  If Self.mProject.Title <> "" Then
		    Self.mProjectURL.Name = Self.mProject.Title
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
		  Controller.mProjectURL = Destination
		  If Self.mProject.Title <> "" Then
		    Destination.Name = Self.mProject.Title
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
		Private Sub Thread_Delete(Sender As Thread)
		  #Pragma Unused Sender
		  
		  If Not Self.CanWrite Then
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteError, "Project is not writeable")
		    Return
		  End If
		  
		  Select Case Self.mProjectURL.Scheme
		  Case Beacon.ProjectURL.TypeCloud
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Authorization") = "Session " + Preferences.OnlineToken
		    Socket.Send("DELETE", Self.mProjectURL.URL(Beacon.ProjectURL.URLTypes.Writing))
		    If Socket.LastHTTPStatus = 200 Then
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Else
		      Var Message As String = Self.ErrorMessageFromSocket(Socket)
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
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteError, "Unknown storage scheme " + Self.mProjectURL.Scheme)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Load(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Var FileContent As MemoryBlock
		  
		  Select Case Self.mProjectURL.Scheme
		  Case Beacon.ProjectURL.TypeCloud
		    // authenticated api request
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Accept-Encoding") = "gzip=1.0, identity=0.5"
		    Socket.RequestHeader("Authorization") = "Session " + Preferences.OnlineToken
		    Socket.RequestHeader("Cache-Control") = "no-cache"
		    Socket.Send("GET", Self.mProjectURL.URL(Beacon.ProjectURL.URLTypes.Reading))
		    If Socket.LastHTTPStatus >= 200 And Socket.LastHTTPStatus < 300 Then
		      FileContent = Socket.LastContent
		    Else
		      Var Message As String = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		      Return
		    End If
		  Case Beacon.ProjectURL.TypeWeb
		    // basic https request
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Accept-Encoding") = "gzip=1.0, identity=0.5"
		    Socket.RequestHeader("Cache-Control") = "no-cache"
		    Socket.Send("GET", Self.mProjectURL.URL(Beacon.ProjectURL.URLTypes.Reading))
		    If Socket.LastHTTPStatus >= 200 Then
		      FileContent = Socket.LastContent
		    Else
		      Var Message As String = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		      Return
		    End If
		  Case Beacon.ProjectURL.TypeLocal
		    // just a local file
		    Var Success As Boolean
		    Var Message As String = "Could not load data from file"
		    Try
		      Var File As BookmarkedFolderItem = Self.mProjectURL.File
		      If File <> Nil And File.Exists Then
		        FileContent = File.Read()
		        Self.mFileRef = File // Just to keep the security scoped bookmark open
		        Success = True
		      End If
		    Catch Err As RuntimeException
		      Message = Err.Explanation
		    End Try
		    
		    If Not Success Then
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		      Return
		    End If
		  Case Beacon.ProjectURL.TypeTransient
		    Var Temp As Beacon.Project = Beacon.Project.CreateForGameID(Self.mProjectURL.GameID)
		    FileContent = Beacon.GenerateJSON(Temp.SaveData(Self.mIdentity), False)
		  Else
		    Return
		  End Select
		  
		  If FileContent = Nil Then
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, "File is empty")
		    Return
		  End If
		  
		  If FileContent.Size >= 8 And (FileContent.UInt64Value(0) = Beacon.Project.BinaryFormatBEBOM Or FileContent.UInt64Value(0) = Beacon.Project.BinaryFormatLEBOM) Then
		    // New binary project format
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Project format is newer than this version of Beacon understands")
		    Return
		  ElseIf FileContent.Size >= 2 And FileContent.UInt8Value(0) = &h1F And FileContent.UInt8Value(1) = &h8B Then
		    Var Decompressed As String = Beacon.Decompress(FileContent)
		    If Decompressed.IsEmpty = False Then
		      FileContent = Decompressed.DefineEncoding(Encodings.UTF8)
		    Else
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Unable to decompress file")
		      Return
		    End If
		  End If
		  
		  Var FailureReason As String
		  Var Project As Beacon.Project = Beacon.Project.FromSaveData(FileContent, Self.mIdentity, FailureReason)
		  If Project = Nil Then
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, FailureReason)
		    Return
		  End If
		  
		  If Project.Title.Trim = "" Then
		    Project.Title = Self.Name
		  End If
		  
		  Self.mProject = Project
		  Self.mLoaded = True
		  Call CallLater.Schedule(0, AddressOf TriggerLoadSuccess)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Upload(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Var EOL As String = EndOfLine.Windows
		  Var Parts() As String
		  Parts.Add("Content-Disposition: form-data; name=""contents""; filename=""" + Self.mProject.UUID + ".beacon""" + EOL + "Content-Type: application/octet-stream" + EOL + EOL + Beacon.Compress(Beacon.GenerateJSON(Self.mProject.SaveData(Self.mIdentity), False)))
		  
		  Var SaveData As Dictionary = Self.mProject.CloudSaveData()
		  For Each Entry As DictionaryEntry In SaveData
		    Parts.Add("Content-Disposition: form-data; name=""" + Entry.Key.StringValue + """;" + EOL + EOL + Entry.Value.StringValue)
		  Next
		  
		  Var Boundary As String = new v4UUID
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Session " + Preferences.OnlineToken
		  Socket.SetRequestContent("--" + Boundary + EOL + Parts.Join(EOL + "--" + Boundary + EOL) + EOL + "--" + Boundary + "--", "multipart/form-data; charset=utf-8; boundary=" + Boundary)
		  Socket.Send("POST", Self.mProjectURL.URL(Beacon.ProjectURL.URLTypes.Writing))
		  If Socket.LastHTTPStatus = 200 Or Socket.LastHTTPStatus = 201 Then
		    If Self.mClearModifiedOnWrite Then
		      Self.mProject.Modified = False
		    End If
		    Call CallLater.Schedule(0, AddressOf TriggerWriteSuccess)
		  Else
		    Var Message As String = Self.ErrorMessageFromSocket(Socket)
		    Call CallLater.Schedule(0, AddressOf TriggerWriteError, Message)
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
		  
		  RaiseEvent Loaded(Self.mProject)
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
		      Self.mProjectURL = Beacon.ProjectURL.URLForFile(BookmarkedFolderItem(Destination))
		    Else
		      Self.mProjectURL = Beacon.ProjectURL.URLForFile(New BookmarkedFolderItem(Destination))
		    End If
		    
		    RaiseEvent WriteSuccess()
		  Else
		    Var Reason As String
		    Var Err As RuntimeException = Sender.Error
		    If Err <> Nil Then
		      Reason = Err.Explanation
		      If Reason = "" Then
		        Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		        If Info <> Nil Then
		          Reason = Info.Name + " from JSONWriter"
		        End If
		      End If
		    End If
		    If Reason = "" Then
		      Reason = "Unknown JSONWriter error"
		    End If
		    
		    RaiseEvent WriteError(Reason)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteTo(Destination As Beacon.ProjectURL, ClearModified As Boolean)
		  If Self.Busy Or Self.Loaded = False Or Destination.Scheme = Beacon.ProjectURL.TypeWeb Then
		    Return
		  End If
		  
		  Self.mClearModifiedOnWrite = ClearModified
		  
		  Select Case Destination.Scheme
		  Case Beacon.ProjectURL.TypeCloud
		    Self.mActiveThread = New Thread
		    Self.mActiveThread.Priority = Thread.LowestPriority
		    AddHandler Self.mActiveThread.Run, WeakAddressOf Thread_Upload
		    Self.mActiveThread.Start
		  Case Beacon.ProjectURL.TypeLocal
		    Var Writer As New Beacon.JSONWriter(Self.mProject, Self.mIdentity, Destination.File)
		    AddHandler Writer.Finished, AddressOf Writer_Finished
		    Writer.Start
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
		Event Loaded(Project As Beacon.Project)
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
		Private mActiveThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClearModifiedOnWrite As Boolean
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
