#tag Class
Protected Class DocumentController
	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  Return Self.mActiveThread <> Nil And Self.mActiveThread.State <> Thread.States.NotRunning
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
		  Self.mDocumentURL = Beacon.DocumentURL.TypeTransient + "://" + Document.DocumentID + "?name=" + Beacon.EncodeURLComponent(Document.Title)
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
		  Self.Constructor(Beacon.DocumentURL.TypeTransient + "://" + Beacon.CreateUUID, WithIdentity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  If Self.Busy Then
		    Return
		  End If
		  
		  Self.mActiveThread = New Thread
		  Self.mActiveThread.Priority = Thread.PriorityHigh
		  AddHandler Self.mActiveThread.Run, WeakAddressOf Thread_Delete
		  Self.mActiveThread.Run
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
		Private Shared Function ErrorMessageFromSocket(Socket As SimpleHTTP.SynchronousHTTPSocket) As Text
		  Dim Message As Text = "The error reason is unknown"
		  If Socket.LastContent <> Nil Then
		    Try
		      Message = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Socket.LastContent, True)
		      Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Message)
		      If Dict.HasKey("message") Then
		        Message = Dict.Value("message")
		      ElseIf Dict.HasKey("description") Then
		        Message = Dict.Value("description")
		      End If
		    Catch Err As RuntimeException
		      
		    End Try
		  ElseIf Socket.LastException <> Nil Then
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
		  Self.mActiveThread.Run
		  
		  Self.mLoadStartedCallbackKey = CallLater.Schedule(1500, WeakAddressOf TriggerLoadStarted)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Loaded() As Boolean
		  Return Self.mLoaded
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
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
		  
		  Dim Controller As New Beacon.DocumentController(Self.mDocument, Self.mIdentity)
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
		    Dim Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Authorization") = "Session " + Preferences.OnlineToken
		    Socket.Send("DELETE", Self.mDocumentURL.WithScheme("https").URL)
		    If Socket.LastHTTPStatus = 200 Then
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Else
		      Dim Message As Text = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteError, Message)
		    End If
		  Case Beacon.DocumentURL.TypeLocal
		    Try
		      Dim File As New Beacon.FolderItem(Self.mDocumentURL.Path)
		      If File.Exists Then
		        File.Delete  
		      End If
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Catch Err As RuntimeException
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteError, Err.Explanation)
		    End Try
		  Case Beacon.DocumentURL.TypeTransient
		    Dim Path As Text = Self.mDocumentURL.URL.Mid(Beacon.DocumentURL.TypeTransient.Length + 3)
		    Try
		      Dim File As Beacon.FolderItem = Beacon.FolderItem.Temporary.Child(Path + BeaconFileTypes.BeaconDocument.PrimaryExtension.ToText)
		      If File.Exists Then
		        File.Delete
		      End If
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteSuccess)
		    Catch Err As RuntimeException
		      Call CallLater.Schedule(0, AddressOf TriggerDeleteError, Err.Explanation)
		    End Try
		  Else
		    Call CallLater.Schedule(0, AddressOf TriggerDeleteError, "Unknown storage scheme " + Self.mDocumentURL.Scheme)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Load(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Dim FileContent As Xojo.Core.MemoryBlock
		  Dim ClearPublishStatus As Boolean
		  
		  Select Case Self.mDocumentURL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    // authenticated api request
		    Dim Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Accept-Encoding") = "gzip"
		    Socket.RequestHeader("Authorization") = "Session " + Preferences.OnlineToken
		    Socket.Send("GET", Self.mDocumentURL.WithScheme("https").URL)
		    If Socket.LastHTTPStatus >= 200 Then
		      FileContent = Socket.LastContent
		    Else
		      Dim Message As Text = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		    End If
		  Case Beacon.DocumentURL.TypeWeb
		    // basic https request
		    Dim Socket As New SimpleHTTP.SynchronousHTTPSocket
		    Socket.RequestHeader("Accept-Encoding") = "gzip"
		    Socket.Send("GET", Self.mDocumentURL.URL)
		    If Socket.LastHTTPStatus >= 200 Then
		      FileContent = Socket.LastContent
		      ClearPublishStatus = True
		    Else
		      Dim Message As Text = Self.ErrorMessageFromSocket(Socket)
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, Message)
		    End If
		  Case Beacon.DocumentURL.TypeLocal
		    // just a local file
		    Dim Success As Boolean
		    Dim Message As Text = "Could not load data from file"
		    Try
		      Dim File As Beacon.FolderItem
		      If Self.mDocumentURL.HasParam("saveinfo") Then
		        File = Beacon.FolderItem.FromSaveInfo(Self.mDocumentURL.Param("saveinfo"))
		      Else
		        File = New Beacon.FolderItem(Self.mDocumentURL.Path)
		      End If
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
		    // just a local file stored in the the temp directory
		    Dim File As Beacon.FolderItem = Beacon.FolderItem.Temporary.Child(Self.mDocumentURL.Path + BeaconFileTypes.BeaconDocument.PrimaryExtension.ToText)
		    If File.Exists Then
		      FileContent = File.Read()
		    Else
		      Dim Temp As New Beacon.Document
		      FileContent = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Xojo.Data.GenerateJSON(Temp.ToDictionary(Self.mIdentity)))
		    End If
		  Else
		    Return
		  End Select
		  
		  If FileContent = Nil Then
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, "File is empty")
		    Return
		  End If
		  
		  Dim TextContent As Text
		  If FileContent.Size > 2 And FileContent.UInt8Value(0) = &h1F And FileContent.UInt8Value(1) = &h8B Then
		    #if Not TargetiOS
		      Dim Compressor As New _GZipString
		      Dim Decompressed As String = Compressor.Decompress(Beacon.ConvertMemoryBlock(FileContent))
		      If Decompressed <> "" Then
		        TextContent = Decompressed.DefineEncoding(Encodings.UTF8).ToText
		      Else
		        Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Unable to decompress file")
		        Return
		      End If
		    #else
		      Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Compressed files are not supported in this version")
		      Return
		    #endif
		  Else
		    TextContent = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(FileContent)
		  End If
		  
		  Dim Document As Beacon.Document = Beacon.Document.FromText(TextContent, Self.mIdentity)
		  If Document = Nil Then
		    Call CallLater.Schedule(0, AddressOf TriggerLoadError, "Unable to parse document")
		    Return
		  End If
		  
		  If Document.Title.Trim = "" Then
		    Document.Title = Self.Name
		  End If
		  If ClearPublishStatus Then
		    Document.IsPublic = False
		  End If
		  
		  Self.mDocument = Document
		  Self.mLoaded = True
		  Call CallLater.Schedule(0, AddressOf TriggerLoadSuccess)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Thread_Upload(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Dim JSON As Text = Xojo.Data.GenerateJSON(Self.mDocument.ToDictionary(Self.mIdentity))
		  Dim Body As Xojo.Core.MemoryBlock
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Session " + Preferences.OnlineToken
		  #if Not TargetiOS
		    Dim Compressor As New _GZipString
		    Compressor.UseHeaders = True
		    
		    Dim Bytes As Global.MemoryBlock = Compressor.Compress(JSON, _GZipString.DefaultCompression)
		    Headers.Value("Content-Encoding") = "gzip"
		    Body = Beacon.ConvertMemoryBlock(Bytes)
		  #else
		    Body = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(JSON)
		  #endif
		  
		  Dim Socket As New SimpleHTTP.SynchronousHTTPSocket
		  For Each Entry As Xojo.Core.DictionaryEntry In Headers
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
		    Dim Message As Text = Self.ErrorMessageFromSocket(Socket)
		    Call CallLater.Schedule(0, AddressOf TriggerWriteError, Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerDeleteError(Reason As Auto)
		  RaiseEvent DeleteError(Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerDeleteSuccess()
		  RaiseEvent DeleteSuccess
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerLoadError(Reason As Auto)
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
		Private Sub TriggerWriteError(Reason As Auto)
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
		Private Sub Writer_Finished(Sender As Beacon.JSONWriter, Destination As Beacon.FolderItem)
		  If Sender = Nil Or Destination = Nil Then
		    Return
		  End If
		  
		  If Sender.Success Then
		    If Self.mClearModifiedOnWrite And Self.mDocument <> Nil Then
		      Self.mDocument.Modified = False
		    End If
		    
		    // Update the document url to regenerate saveinfo/bookmarks
		    Self.mDocumentURL = Beacon.DocumentURL.URLForFile(Destination)
		    
		    RaiseEvent WriteSuccess()
		  Else
		    Dim Reason As Text
		    Dim Err As RuntimeException = Sender.Error
		    If Err <> Nil Then
		      If Err.Reason <> "" Then
		        Reason = Err.Reason
		      ElseIf Err.Message <> "" Then
		        Reason = Err.Message.ToText
		      Else
		        Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Err)
		        Reason = Info.Name + " from JSONWriter"
		      End If
		    Else
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
		    Self.mActiveThread.Priority = Thread.PriorityLow
		    AddHandler Self.mActiveThread.Run, WeakAddressOf Thread_Upload
		    Self.mActiveThread.Run
		  Case Beacon.DocumentURL.TypeLocal
		    Dim Writer As New Beacon.JSONWriter(Self.mDocument, Self.mIdentity, New Beacon.FolderItem(Destination.Path))
		    AddHandler Writer.Finished, AddressOf Writer_Finished
		    Writer.Run
		  End Select
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DeleteError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DeleteSuccess()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Loaded(Document As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadProgress(BytesReceived As Int64, BytesTotal As Int64)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteSuccess()
	#tag EndHook


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
		Private mFileRef As Beacon.FolderItem
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
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
