#tag Class
Protected Class HTTPClientSocket
	#tag Method, Flags = &h0
		Shared Function BuildQueryString(FormData As Dictionary) As String
		  #if XojoVersion >= 2019.02
		    Var Parts() As String
		    If (FormData Is Nil) = False Then
		      For Each Entry As DictionaryEntry In FormData
		        Parts.AddRow(EncodeURLComponent(Entry.Key.StringValue) + "=" + EncodeURLComponent(Entry.Value.StringValue))
		      Next
		    End If
		    Return String.FromArray(Parts, "&")
		  #else
		    Dim Parts() As String
		    If (FormData Is Nil) = False Then
		      Dim Keys() As Variant = FormData.Keys
		      For Each Key As Variant In Keys
		        Parts.Append(EncodeURLComponent(Key.StringValue) + "=" + EncodeURLComponent(FormData.Value(Key).StringValue))
		      Next
		    End If
		    Return Join(Parts, "&")
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearRequestHeaders()
		  Self.mRequestHeaders = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSocket = New CURLSMBS
		  Call Self.mSocket.UseSystemCertificates
		  Self.mSocket.YieldTime = True
		  Self.mSocket.OptionSSLVerifyHost = 2
		  Self.mSocket.OptionSSLVerifyPeer = 1
		  Self.mSocket.OptionSSLVersion = CURLSMBS.kSSLVersionTLSv10
		  Self.mSocket.OptionFollowLocation = True
		  Self.mSocket.OptionMaxRedirs = 10
		  Self.mSocket.OptionTransferEncoding = True
		  Self.mSocket.OptionAcceptEncoding = "gzip, deflate, identity"
		  AddHandler mSocket.Header, WeakAddressOf mSocket_Header
		  AddHandler mSocket.Progress, WeakAddressOf mSocket_Progress
		  
		  Self.mWorkerThread = New Thread
		  AddHandler mWorkerThread.Run, WeakAddressOf mWorkerThread_Run
		  #if XojoVersion >= 2019.02
		    AddHandler mWorkerThread.UserInterfaceUpdate, WeakAddressOf mWorkerThread_UserInterfaceUpdate
		  #endif
		  
		  Self.mRequestHeaders = New Dictionary
		  Self.mResponseHeaders = New Dictionary
		  
		  #if XojoVersion < 2019.02
		    Self.mUpdateTimer = New Timer
		    Self.mUpdateTimer.Period = 20
		    Self.mUpdateTimer.Mode = Timer.ModeOff
		    AddHandler mUpdateTimer.Action, WeakAddressOf mUpdateTimer_Action
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.mSocket.Cancel = True
		  
		  RemoveHandler mSocket.Header, WeakAddressOf mSocket_Header
		  RemoveHandler mSocket.Progress, WeakAddressOf mSocket_Progress
		  
		  RemoveHandler mWorkerThread.Run, WeakAddressOf mWorkerThread_Run
		  #if XojoVersion >= 2019.02
		    RemoveHandler mWorkerThread.UserInterfaceUpdate, WeakAddressOf mWorkerThread_UserInterfaceUpdate
		  #else
		    RemoveHandler mUpdateTimer.Action, WeakAddressOf mUpdateTimer_Action
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Disconnect()
		  Self.mSocket.Cancel = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Get(URL As String)
		  Call Self.Send("GET", URL, Nil, -1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(URL As String, Timeout As Integer) As String
		  Return Self.Send("GET", URL, Nil, Timeout)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleUpdateDictionary(Dict As Dictionary)
		  Dim EventName As String = Dict.Lookup("Event", "")
		  Select Case EventName
		  Case "Finished"
		    Dim ByteCount As Int64 = Self.mSocket.GetInfoContentLengthDownload
		    RaiseEvent ReceivingProgressed(ByteCount, ByteCount, "")
		    If Self.mSaveToFile <> Nil Then
		      RaiseEvent FileReceived(Dict.Value("URL"), Dict.Value("HTTPStatus"), Self.mSaveToFile)
		    Else
		      RaiseEvent ContentReceived(Dict.Value("URL"), Dict.Value("HTTPStatus"), Dict.Value("Content"))
		    End If
		  Case "HeadersReceived"
		    RaiseEvent HeadersReceived(Dict.Value("URL"), Dict.Value("HTTPStatus"))
		  Case "AuthenticationRequested"
		    Dim Username, Password As String
		    Dim Handled As Boolean = AuthenticationRequested(Dict.Value("Realm"), Username, Password)
		    If Handled Then
		      Self.mSocket.OptionUsername = Username
		      Self.mSocket.OptionPassword = Password
		      Self.mSocket.OptionHTTPAuth = Dict.Value("Type")
		      Self.mResponseHeaders = New Dictionary
		      #if XojoVersion >= 2019.02
		        Self.mWorkerThread.Start
		      #else
		        Self.mWorkerThread.Run
		      #endif
		    End If
		  Case "Error"
		    RaiseEvent Error(Dict.Value("Err"))
		  Case "ReceivingProgressed"
		    RaiseEvent ReceivingProgressed(Dict.Value("ReceivedBytes"), Dict.Value("TotalBytes"), "")
		  Case "SendingProgressed"
		    RaiseEvent SendingProgressed(Dict.Value("SentBytes"), Dict.Value("TotalBytes"))
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mSocket_Header(Sender As CURLSMBS, Data As String, DataSize As Integer) As Integer
		  If Data = Encodings.ASCII.Chr(13) + Encodings.ASCII.Chr(10) Then
		    If Self.HTTPStatusCode = 401 Then
		      Dim Auth As String = Self.mResponseHeaders.Lookup("WWW-Authenticate", "")
		      Dim Realm As String
		      #if XojoVersion >= 2019.02
		        Dim RealmStart As Integer = Auth.IndexOf(" realm=")
		        If RealmStart > -1 Then
		          Realm = Auth.Middle(RealmStart + 7)
		          If Realm.Left(1) = """" Then
		            Realm = Realm.Middle(1)
		            Dim RealmEnd As Integer = Realm.IndexOf("""")
		            If RealmEnd > -1 Then
		              Realm = Realm.Left(RealmEnd)
		            End If
		          End If
		        End If
		      #else
		        Dim RealmStart As Integer = InStr(Auth, " realm=") - 1
		        If RealmStart > -1 Then
		          Realm = Mid(Auth, RealmStart + 8)
		          If Left(Realm, 1) = """" Then
		            Realm = Realm.Mid(2)
		            Dim RealmEnd As Integer = InStr(Realm, """") - 1
		            If RealmEnd > -1 Then
		              Realm = Left(Realm, RealmEnd)
		            End If
		          End If
		        End If
		      #endif
		      
		      Sender.Cancel = True
		      
		      Dim Dict As New Dictionary
		      Dict.Value("Event") = "AuthenticationRequested"
		      Dict.Value("Realm") = Realm
		      Dict.Value("URL") = Sender.OptionURL
		      #if XojoVersion >= 2019.02
		        Dim TypeLen As Integer = Auth.IndexOf(" ")
		      #else
		        Dim TypeLen As Integer = InStr(Auth, " ") - 1
		      #endif
		      Dim Type As String = Auth.Left(TypeLen)
		      Select Case Type
		      Case "Basic"
		        Dict.Value("Type") = CURLSMBS.kAUTH_BASIC
		      Case "Digest"
		        Dict.Value("Type") = CURLSMBS.kAUTH_DIGEST
		      End Select
		      If Dict.HasKey("Type") Then
		        Self.mSilenceResponse = True
		        Self.ScheduleUpdateDictionary(Dict)
		        Return DataSize
		      End If
		    End If
		    
		    Dim Dict As New Dictionary
		    Dict.Value("Event") = "HeadersReceived"
		    Dict.Value("URL") = Sender.OptionURL
		    Dict.Value("HTTPStatus") = Self.HTTPStatusCode
		    #if XojoVersion >= 2019.02
		      Dict.Value("Headers") = Self.mResponseHeaders.Clone
		    #else
		      Dim Clone As New Dictionary
		      Dim Keys() As Variant = Self.mResponseHeaders.Keys
		      For Each Key As Variant In Keys
		        Clone.Value(Key) = Self.mResponseHeaders.Value(Key)
		      Next
		      Dict.Value("Headers") = Clone
		    #endif
		    Self.ScheduleUpdateDictionary(Dict)
		    
		    Return DataSize
		  End If
		  
		  #if XojoVersion >= 2019.02
		    Dim Pos As Integer = Data.IndexOf(":")
		    If Pos = -1 Then
		      Return DataSize
		    End If
		    Dim Header As String = Data.Left(Pos)
		    Dim Value As String = Data.Middle(Pos + 1).Trim
		  #else
		    Dim Pos As Integer = InStr(Data, ":")
		    If Pos = 0 Then
		      Return DataSize
		    End If
		    Dim Header As String = Left(Data, Pos - 1)
		    Dim Value As String = Trim(Mid(Data, Pos + 1))
		  #endif
		  Self.mResponseHeaders.Value(Header) = Value
		  
		  Return DataSize
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mSocket_Progress(Sender As CURLSMBS, DownloadTotal As Int64, DownloadNow As Int64, UploadTotal As Int64, UploadNow As Int64, Percent As Double) As Boolean
		  #Pragma Unused Percent
		  
		  // Terminates transfer
		  If Sender.Cancel Then
		    Return True
		  End If
		  
		  If DownloadTotal > 0 Then
		    Dim Dict As New Dictionary
		    Dict.Value("Event") = "ReceivingProgressed"
		    Dict.Value("TotalBytes") = DownloadTotal
		    Dict.Value("ReceivedBytes") = DownloadNow
		    Self.ScheduleUpdateDictionary(Dict)
		  End If
		  If UploadTotal > 0 Then
		    Dim Dict As New Dictionary
		    Dict.Value("Event") = "SendingProgressed"
		    Dict.Value("TotalBytes") = UploadTotal
		    Dict.Value("SentBytes") = UploadNow
		    Self.ScheduleUpdateDictionary(Dict)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateTimer_Action(Sender As Timer)
		  #if XojoVersion >= 2019.02
		    #Pragma Unused Sender
		  #else
		    While Self.mUpdateQueue.Ubound > -1
		      Dim Dict As Dictionary = Self.mUpdateQueue(0)
		      Self.mUpdateQueue.Remove(0)
		      Self.HandleUpdateDictionary(Dict)
		    Wend
		    
		    Sender.Mode = Timer.ModeOff
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mWorkerThread_Run(Sender As Thread)
		  #Pragma Unused Sender
		  Call Self.Perform(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mWorkerThread_UserInterfaceUpdate(Sender As Thread, Data() As Dictionary)
		  #Pragma Unused Sender
		  
		  #if XojoVersion >= 2019.02
		    For Each Dict As Dictionary In Data
		      Self.HandleUpdateDictionary(Dict)
		    Next
		  #else
		    #Pragma Unused Data
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Perform(FireEvents As Boolean) As String
		  Self.mSilenceResponse = False
		  Self.mResponseHeaders = New Dictionary
		  If Self.mSaveToFile <> Nil Then
		    If Not Self.mSocket.CreateMTOutputFile(Self.mSaveToFile) Then
		      Self.mSaveToFile = Nil
		    End If
		  End If
		  Dim Err As Integer = Self.mSocket.PerformMT
		  If Self.mSaveToFile <> Nil Then
		    Self.mSocket.CloseMTOutputFile
		    If Self.mSocket.Cancel Then
		      #if XojoVersion >= 2019.02
		        Self.mSaveToFile.Remove
		      #else
		        Self.mSaveToFile.Delete
		      #endif
		    End If
		  End If
		  If Self.mSilenceResponse Then
		    Return ""
		  End If
		  If Err = 0 Then
		    If FireEvents Then
		      Dim ResponseData As New Dictionary
		      ResponseData.Value("URL") = Self.mSocket.OptionURL
		      ResponseData.Value("Content") = Self.mSocket.OutputData
		      ResponseData.Value("HTTPStatus") = Self.HTTPStatusCode
		      #if XojoVersion >= 2019.02
		        ResponseData.Value("Headers") = Self.mResponseHeaders.Clone
		      #else
		        Dim Clone As New Dictionary
		        Dim Keys() As Variant = Self.mResponseHeaders.Keys
		        For Each Key As Variant In Keys
		          Clone.Value(Key) = Self.mResponseHeaders.Value(Key)
		        Next
		        ResponseData.Value("Headers") = Clone
		      #endif
		      ResponseData.Value("Event") = "Finished"
		      Self.ScheduleUpdateDictionary(ResponseData)
		    End If
		    Return Self.mSocket.OutputData
		  Else
		    Dim Except As New RuntimeException
		    Except.ErrorNumber = Err
		    Except.Message = Self.mSocket.LasterrorMessage
		    If FireEvents Then
		      Dim Dict As New Dictionary
		      Dict.Value("Event") = "Error"
		      Dict.Value("Err") = Except
		      Dict.Value("URL") = Self.mSocket.OptionURL
		      Self.ScheduleUpdateDictionary(Dict)
		    End If
		    Self.mLastError = Except
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Post(URL As String, FormData As Dictionary)
		  Self.SetRequestContent(BuildQueryString(FormData), "application/x-www-form-urlencoded")
		  Call Self.Send("POST", URL, Nil, -1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Post(URL As String, FormData As Dictionary, Timeout As Integer) As String
		  Self.SetRequestContent(BuildQueryString(FormData), "application/x-www-form-urlencoded")
		  Return Self.Send("POST", URL, Nil, Timeout)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Post(URL As String, ContentType As String, Content As String)
		  Self.SetRequestContent(Content, ContentType)
		  Call Self.Send("POST", URL, Nil, -1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Post(URL As String, ContentType As String, Content As String, Timeout As Integer) As String
		  Self.SetRequestContent(Content, ContentType)
		  Return Self.Send("POST", URL, Nil, Timeout)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestHeader(Name As String) As String
		  Return Self.mRequestHeaders.Lookup(Name, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestHeader(Name As String, Assigns Value As String)
		  Self.mRequestHeaders.Value(Name) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResponseHeader(Name As String) As String
		  Return Self.mResponseHeaders.Lookup(Name, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResponseHeaders() As Pair()
		  #if XojoVersion >= 2019.02
		    Var Pairs() As Pair
		    For Each Entry As DictionaryEntry In Self.mResponseHeaders
		      Pairs.AddRow(Entry.Key : Entry.Value)
		    Next
		    Return Pairs
		  #else
		    Dim Pairs() As Pair
		    Dim Keys() As Variant = Self.mResponseHeaders.Keys
		    For Each Key As Variant In Keys
		      Pairs.AddRow(Key : Self.mResponseHeaders.Value(Key))
		    Next
		    Return Pairs
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScheduleUpdateDictionary(Dict As Dictionary)
		  Dim CurrentThread As Thread = App.CurrentThread
		  If CurrentThread = Nil Then
		    Self.HandleUpdateDictionary(Dict)
		  Else
		    #if XojoVersion >= 2019.02
		      CurrentThread.AddUserInterfaceUpdate(Dict)
		    #else
		      Self.mUpdateQueue.Append(Dict)
		      If Self.mUpdateQueue.Ubound = 0 Then
		        Self.mUpdateTimer.Mode = Timer.ModeSingle
		      End If
		    #endif
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Method As String, URL As String, File As FolderItem = Nil)
		  Call Self.Send(Method, URL, File, -1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Send(Method As String, URL As String, File As FolderItem, Timeout As Integer) As String
		  Self.mSocket.OptionCustomRequest = Method
		  Self.mSocket.OptionURL = URL
		  
		  Dim Headers() As String
		  #if XojoVersion >= 2019.02
		    For Each Entry As DictionaryEntry In Self.mRequestHeaders
		      Headers.AddRow(Entry.Key.StringValue + ": " + Entry.Value.StringValue)
		    Next
		  #else
		    Dim Keys() As Variant = Self.mRequestHeaders.Keys
		    For Each Key As Variant In Keys
		      Headers.Append(Key.StringValue + ": " + Self.mRequestHeaders.Value(Key).StringValue)
		    Next
		  #endif
		  Self.mSocket.SetOptionHTTPHeader(Headers)
		  
		  Self.mSaveToFile = File
		  If Timeout < 0 Then
		    Self.mSocket.OptionConnectionTimeout = 60
		    #if XojoVersion >= 2019.02
		      Self.mWorkerThread.Start
		    #else
		      Self.mWorkerThread.Run
		    #endif
		  Else
		    Self.mSocket.OptionConnectionTimeout = Timeout
		    Return Self.Perform(False)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendSync(Method As String, URL As String, File As FolderItem, Timeout As Integer)
		  Call Self.Send(Method, URL, File, Timeout)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendSync(Method As String, URL As String, Timeout As Integer) As String
		  Return Self.Send(Method, URL, Nil, Timeout)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRequestContent(Content As String, MimeType As String)
		  Self.RequestHeader("Content-Type") = MimeType
		  Self.mSocket.OptionUpload = True
		  Self.mSocket.InputData = Content
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AuthenticationRequested(Realm As String, ByRef Name As String, ByRef Password As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContentReceived(URL As String, HTTPStatus As Integer, Content As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(E As RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event FileReceived(URL As String, HTTPStatus As Integer, File As FolderItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HeadersReceived(URL As String, HTTPStatus As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReceivingProgressed(BytesReceived As Int64, TotalBytes As Int64, NewData As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SendingProgressed(BytesSent As Int64, BytesLeft As Int64)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSocket.OptionSSLVerifyHost = 2 And Self.mSocket.OptionSSLVerifyPeer = 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.mSocket.OptionSSLVerifyHost = 2
			    Self.mSocket.OptionSSLVerifyPeer = 1
			  Else
			    Self.mSocket.OptionSSLVerifyHost = 0
			    Self.mSocket.OptionSSLVerifyPeer = 0
			  End If
			End Set
		#tag EndSetter
		AllowCertificateValidation As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSocket.OptionFollowLocation
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSocket.OptionFollowLocation = Value
			End Set
		#tag EndSetter
		FollowRedirects As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSocket.GetInfoResponseCode
			End Get
		#tag EndGetter
		HTTPStatusCode As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLastError
			End Get
		#tag EndGetter
		LastError As RuntimeException
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case Self.mSocket.OptionSSLVersion
			  Case CURLSMBS.kSSLVersionTLSv13
			    Return TLSVersions.v1_3
			  Case CURLSMBS.kSSLVersionTLSv12
			    Return TLSVersions.v1_2
			  Case CURLSMBS.kSSLVersionTLSv11
			    Return TLSVersions.v1_1
			  Case CURLSMBS.kSSLVersionTLSv10
			    Return TLSVersions.v1_0
			  Else
			    Return CType(Self.mSocket.OptionSSLVersion, TLSVersions)
			  End Select
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Select Case Value
			  Case TLSVersions.v1_3
			    Self.mSocket.OptionSSLVersion = CURLSMBS.kSSLVersionTLSv13
			  Case TLSVersions.v1_2
			    Self.mSocket.OptionSSLVersion = CURLSMBS.kSSLVersionTLSv12
			  Case TLSVersions.v1_1
			    Self.mSocket.OptionSSLVersion = CURLSMBS.kSSLVersionTLSv11
			  Else
			    Self.mSocket.OptionSSLVersion = CURLSMBS.kSSLVersionTLSv10
			  End Select
			End Set
		#tag EndSetter
		MinTLSVersion As TLSVersions
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestHeaders As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResponseHeaders As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveToFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSilenceResponse As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As CURLSMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateQueue() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorkerThread As Thread
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSocket.OptionSSLVerifyStatus = 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSocket.OptionSSLVerifyStatus = If(Value, 1, 0)
			End Set
		#tag EndSetter
		RequireOCSPStapling As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSocket.OptionUserAgent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSocket.OptionUserAgent = Value
			End Set
		#tag EndSetter
		UserAgent As String
	#tag EndComputedProperty


	#tag Enum, Name = CommonErrors, Type = Integer, Flags = &h0
		FunctionMissing = -1
		  UnsupportedProtocol = 1
		  MalformedURL = 3
		  HostResolutionError = 6
		  ConnectionFailed = 7
		  OutOfMemory = 27
		  SecureConnectionError = 35
		  TooManyRedirects = 47
		  RemoteCertificateRejected = 51
		  NoCommonCiphers = 59
		CertificateAuthorityRejected = 60
	#tag EndEnum

	#tag Enum, Name = TLSVersions, Type = Integer, Flags = &h0
		v1_0
		  v1_1
		  v1_2
		v1_3
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
		#tag ViewProperty
			Name="AllowCertificateValidation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinTLSVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="TLSVersions"
			EditorType="Enum"
			#tag EnumValues
				"0 - v1_0"
				"1 - v1_1"
				"2 - v1_2"
				"3 - v1_3"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequireOCSPStapling"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FollowRedirects"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserAgent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
