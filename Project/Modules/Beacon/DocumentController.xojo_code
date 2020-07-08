#tag Class
Protected Class DocumentController
	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  Return Self.mActiveThread <> Nil And Self.mActiveThread.ThreadState <> Thread.ThreadStates.NotRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanWrite() As Boolean
		  If Self.mDocumentURL.Scheme = Beacon.DocumentURL.TypeWeb Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Document As Beacon.Document, WithIdentity As Beacon.Identity)
		  Self.mDocumentURL = Beacon.DocumentURL.TypeTransient + "://" + Document.DocumentID + "?name=" + EncodeURLComponent(Document.Title)
		  Self.mLoaded = True
		  Self.mDocument = Document
		  Self.mIdentity = WithIdentity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(URL As Beacon.DocumentURL, WithIdentity As Beacon.Identity)
		  Self.mDocumentURL = URL
		  Self.mIdentity = WithIdentity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(WithIdentity As Beacon.Identity)
		  Self.Constructor(Beacon.DocumentURL.TypeTransient + "://" + v4UUID.Create, WithIdentity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  If Self.Busy Then
		    Return
		  End If
		  
		  Self.mActiveThread = New Thread
		  Self.mActiveThread.Priority = 10
		  AddHandler Self.mActiveThread.Run, WeakAddressOf Thread_Delete
		  Self.mActiveThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mLoadStartedCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Document() As Beacon.Document
		  Return Self.mDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Document(Assigns Replacement As Beacon.Document)
		  Self.mDocument = Replacement
		  Self.mLoaded = True
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
		Sub Load()
		  If Self.Loaded Then
		    RaiseEvent Loaded(Self.mDocument)
		    Return
		  End If
		  
		  If Self.Busy Then
		    Return
		  End If
		  
		  Self.mActiveThread = New Thread
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
		  If Self.mDocument <> Nil Then
		    Return Self.mDocument.Title
		  Else
		    Return Self.mDocumentURL.Name
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  If Self.Busy Or Self.Loaded = False Then
		    Return
		  End If
		  
		  If Self.mDocument.Title <> "" Then
		    Self.mDocumentURL.Name = Self.mDocument.Title
		  End If
		  Self.WriteTo(Self.mDocumentURL, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveACopy(Destination As Beacon.DocumentURL) As Beacon.DocumentController
		  // Like Save As, but the destination is not saved
		  If Self.Loaded = False Then
		    Return Nil
		  End If
		  
		  Var Controller As New Beacon.DocumentController(Self.mDocument, Self.mIdentity)
		  Controller.mDocumentURL = Destination
		  If Self.mDocument.Title <> "" Then
		    Destination.Name = Self.mDocument.Title
		  End If
		  Controller.WriteTo(Destination, False)
		  Return Controller
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(Destination As Beacon.DocumentURL)
		  If Self.Busy Or Self.Loaded = False Then
		    Return
		  End If
		  
		  Self.mDocumentURL = Destination
		  Self.Save()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Delete(Sender As Thread)
		  #Pragma Unused Sender
		  
		  If Not Self.CanWrite Then
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteError, "Document is not writable")
		    Return
		  End If
		  
		  Select Case Self.mDocumentURL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Authorization") = "Session " + Preferences.OnlineToken
		    Socket.Send("DELETE", Self.mDocumentURL.WithScheme("https").URL)
		    If Socket.LastHTTPStatus = 200 Then
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Else
		      Var Message As String = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteError, Message)
		    End If
		  Case Beacon.DocumentURL.TypeLocal
		    Try
		      If Self.mFileRef <> Nil And Self.mFileRef.Exists Then
		        Self.mFileRef.Remove
		      End If
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Catch Err As RuntimeException
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteError, Err.Explanation)
		    End Try
		  Case Beacon.DocumentURL.TypeTransient
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		  Else
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteError, "Unknown storage scheme " + Self.mDocumentURL.Scheme)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Load(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Var FileContent As MemoryBlock
		  
		  Select Case Self.mDocumentURL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    // authenticated api request
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Accept-Encoding") = "gzip"
		    Socket.RequestHeader("Authorization") = "Session " + Preferences.OnlineToken
		    Socket.RequestHeader("Cache-Control") = "no-cache"
		    Socket.Send("GET", Self.mDocumentURL.WithScheme("https").URL)
		    If Socket.LastHTTPStatus >= 200 Then
		      FileContent = Socket.LastContent
		    Else
		      Var Message As String = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		    End If
		  Case Beacon.DocumentURL.TypeWeb
		    // basic https request
		    Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Accept-Encoding") = "gzip"
		    Socket.RequestHeader("Cache-Control") = "no-cache"
		    Socket.Send("GET", Self.mDocumentURL.URL)
		    If Socket.LastHTTPStatus >= 200 Then
		      FileContent = Socket.LastContent
		    Else
		      Var Message As String = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		    End If
		  Case Beacon.DocumentURL.TypeLocal
		    // just a local file
		    Var Success As Boolean
		    Var Message As String = "Could not load data from file"
		    Try
		      Var File As BookmarkedFolderItem = Self.mDocumentURL.File
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
		  Case Beacon.DocumentURL.TypeTransient
		    Var Temp As New Beacon.Document
		    FileContent = Beacon.GenerateJSON(Temp.ToDictionary(Self.mIdentity), False)
		  Else
		    Return
		  End Select
		  
		  If FileContent = Nil Then
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, "File is empty")
		    Return
		  End If
		  
		  If FileContent.Size > 2 And FileContent.UInt8Value(0) = &h1F And FileContent.UInt8Value(1) = &h8B Then
		    #if Not TargetiOS
		      Var Compressor As New _GZipString
		      Var Decompressed As String = Compressor.Decompress(FileContent)
		      If Decompressed <> "" Then
		        FileContent = Decompressed.DefineEncoding(Encodings.UTF8)
		      Else
		        Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Unable to decompress file")
		        Return
		      End If
		    #else
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Compressed files are not supported in this version")
		      Return
		    #endif
		  End If
		  
		  Var Document As Beacon.Document = Beacon.Document.FromString(FileContent, Self.mIdentity)
		  If Document = Nil Then
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Unable to parse document")
		    Return
		  End If
		  
		  If Document.Title.Trim = "" Then
		    Document.Title = Self.Name
		  End If
		  
		  Self.mDocument = Document
		  Self.mLoaded = True
		  Call CallLater.Schedule(0, AddressOf TriggerLoadSuccess)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Upload(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Var JSON As String = Beacon.GenerateJSON(Self.mDocument.ToDictionary(Self.mIdentity), False)
		  Var Headers As New Dictionary
		  Headers.Value("Authorization") = "Session " + Preferences.OnlineToken
		  
		  Var Compressor As New _GZipString
		  Compressor.UseHeaders = True
		  
		  Var Body As MemoryBlock = Compressor.Compress(JSON, _GZipString.DefaultCompression)
		  Headers.Value("Content-Encoding") = "gzip"
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  For Each Entry As DictionaryEntry In Headers
		    Socket.RequestHeader(Entry.Key) = Entry.Value
		  Next
		  Socket.SetRequestContent(Body, "application/json")
		  Socket.Send("POST", Self.mDocumentURL.WithScheme("https").URL)
		  If Socket.LastHTTPStatus = 200 Or Socket.LastHTTPStatus = 201 Then
		    If Self.mClearModifiedOnWrite Then
		      Self.mDocument.Modified = False
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
		  
		  RaiseEvent Loaded(Self.mDocument)
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
		Function URL() As DocumentURL
		  Return Self.mDocumentURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Writer_Finished(Sender As Beacon.JSONWriter, Destination As FolderItem)
		  If Sender = Nil Or Destination = Nil Then
		    Return
		  End If
		  
		  If Sender.Success Then
		    If Self.mClearModifiedOnWrite And Self.mDocument <> Nil Then
		      Self.mDocument.Modified = False
		    End If
		    
		    // Update the document url to regenerate saveinfo/bookmarks
		    If Destination IsA BookmarkedFolderItem Then
		      Self.mDocumentURL = Beacon.DocumentURL.URLForFile(BookmarkedFolderItem(Destination))
		    Else
		      Self.mDocumentURL = Beacon.DocumentURL.URLForFile(New BookmarkedFolderItem(Destination))
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
		Private Sub WriteTo(Destination As Beacon.DocumentURL, ClearModified As Boolean)
		  If Self.Busy Or Self.Loaded = False Or Destination.Scheme = Beacon.DocumentURL.TypeWeb Then
		    Return
		  End If
		  
		  Self.mClearModifiedOnWrite = ClearModified
		  
		  Select Case Destination.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    Self.mActiveThread = New Thread
		    Self.mActiveThread.Priority = 1
		    AddHandler Self.mActiveThread.Run, WeakAddressOf Thread_Upload
		    Self.mActiveThread.Start
		  Case Beacon.DocumentURL.TypeLocal
		    Var Writer As New Beacon.JSONWriter(Self.mDocument, Self.mIdentity, Destination.File)
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
		Event Loaded(Document As Beacon.Document)
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
		AutosaveURL As Beacon.DocumentURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mActiveThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClearModifiedOnWrite As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocumentURL As Beacon.DocumentURL
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
