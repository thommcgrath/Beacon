#tag Module
Protected Module DataUpdater
	#tag Method, Flags = &h1
		Protected Sub CheckNow(Refresh As Boolean = False)
		  If mCheckingOnline Then
		    Return
		  End If
		  
		  If IsImporting Then
		    // Don't check now
		    mCheckOnlineAfterImporting = True
		    Return
		  End If
		  
		  Var CheckURL As String = BeaconAPI.URL("/deltas?version=" + Version.ToString(Locale.Raw, "0"))
		  If Refresh = False Then
		    Var LastSync As String = Preferences.LastSyncTime
		    If LastSync.IsEmpty = False Then
		      CheckURL = CheckURL + "&since=" + EncodeURLComponent(LastSync)
		    End If
		  End If
		  If (App.IdentityManager Is Nil) = False And (App.IdentityManager.CurrentIdentity Is Nil) = False Then
		    CheckURL = CheckURL + "&user_id=" + EncodeURLComponent(App.IdentityManager.CurrentIdentity.UserID)
		  End If
		  
		  mCheckingOnline = True
		  NotificationKit.Post(Notification_OnlineCheckBegin, Nil)
		  App.Log("Check for data updates from " + CheckURL)
		  
		  Var Sock As New URLConnection
		  Sock.RequestHeader("User-Agent") = App.UserAgent
		  Sock.RequestHeader("Cache-Control") = "no-cache"
		  AddHandler Sock.ContentReceived, AddressOf mCheckSocket_ContentReceived
		  AddHandler Sock.Error, AddressOf mCheckSocket_Error
		  Sock.Send("GET", CheckURL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadNextURL()
		  If mContentURLs.Count = 0 Then
		    mCheckingOnline = False
		    NotificationKit.Post(Notification_OnlineCheckStopped, Nil)
		    Return
		  End If
		  
		  Var URL As String = mContentURLs(mContentURLs.FirstIndex)
		  mContentURLs.RemoveAt(mContentURLs.FirstIndex)
		  
		  Var Sock As New URLConnection
		  Sock.RequestHeader("User-Agent") = App.UserAgent
		  Sock.RequestHeader("Cache-Control") = "no-cache"
		  AddHandler Sock.ContentReceived, AddressOf mDownloadSocket_ContentReceived
		  AddHandler Sock.Error, AddressOf mDownloadSocket_Error
		  Sock.Send("GET", URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ImportFile(File As FolderItem)
		  Try
		    Var Contents As String = File.Read
		    ImportString(Contents)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading local file for import")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportString(Content As String)
		  mPendingImports.Add(Content)
		  
		  If mPendingImports.Count > 0 Then
		    If mImportThread Is Nil Then
		      mImportThread = New Thread
		      mImportThread.Priority = Thread.LowestPriority
		      AddHandler mImportThread.Run, AddressOf mImportThread_Run
		    End If
		    
		    If mImportThread.ThreadState = Thread.ThreadStates.NotRunning Then
		      mImportThread.Start
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsCheckingOnline() As Boolean
		  Return mCheckingOnline
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsImporting() As Boolean
		  Return (mImportThread Is Nil) = False And mImportThread.ThreadState <> Thread.ThreadStates.NotRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mCheckSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Contents As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus < 200 Or HTTPStatus >= 300 Then
		    mCheckingOnline = False
		    App.Log("Got " + HTTPStatus.ToString(Locale.Raw, "0") + " from data update check")
		    NotificationKit.Post(Notification_OnlineCheckError, "Server replied with HTTP status " + HTTPStatus.ToString(Locale.Raw, "0"))
		    NotificationKit.Post(Notification_OnlineCheckStopped, Nil)
		    Return
		  End If
		  
		  Var Parsed As Dictionary
		  Try
		    Parsed = Beacon.ParseJSON(Contents)
		  Catch Err As RuntimeException
		    mCheckingOnline = False
		    App.Log(Err, CurrentMethodName, "Trying to parse file list")
		    NotificationKit.Post(Notification_OnlineCheckError, "Could not parse change list")
		    NotificationKit.Post(Notification_OnlineCheckStopped, Nil)
		    Return
		  End Try
		  
		  Var Files() As Variant = Parsed.Value("files")
		  For Each Obj As Variant In Files
		    Try
		      Var FileData As Dictionary = Obj
		      Var DeltaURL As String = FileData.Value("url")
		      mContentURLs.Add(DeltaURL)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to read object in files list")
		      mCheckingOnline = False
		      mContentURLs.ResizeTo(-1)
		      NotificationKit.Post(Notification_OnlineCheckError, "An object in the changes url list is malformed")
		      NotificationKit.Post(Notification_OnlineCheckStopped, Nil)
		      Return
		    End Try
		  Next Obj
		  
		  DownloadNextURL()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mCheckSocket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  App.Log(Err, CurrentMethodName, "Online data check error")
		  mCheckingOnline = False
		  NotificationKit.Post(Notification_OnlineCheckError, Err.Message)
		  NotificationKit.Post(Notification_OnlineCheckStopped, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDownloadSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Contents As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus < 200 Or HTTPStatus >= 300 Then
		    mCheckingOnline = False
		    App.Log("Got " + HTTPStatus.ToString(Locale.Raw, "0") + " from data update download")
		    NotificationKit.Post(Notification_OnlineCheckError, "Server replied with HTTP status " + HTTPStatus.ToString(Locale.Raw, "0"))
		    NotificationKit.Post(Notification_OnlineCheckStopped, Nil)
		    Return
		  End If
		  
		  ImportString(Contents)
		  DownloadNextURL()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDownloadSocket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  App.Log(Err, CurrentMethodName, "Online data download error")
		  mCheckingOnline = False
		  NotificationKit.Post(Notification_OnlineCheckError, Err.Message)
		  NotificationKit.Post(Notification_OnlineCheckStopped, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImportThread_Run(Sender As Thread)
		  If mPendingImports.Count = 0 Then
		    Return
		  End If
		  
		  NotificationKit.Post(Notification_ImportBegin, Nil)
		  
		  Var Flags As Integer = Beacon.DataSource.FlagCreateIfNeeded Or Beacon.DataSource.FlagUseWeakRef
		  Var Sources(1) As Beacon.DataSource
		  Sources(0) = Beacon.CommonData.SharedInstance(Flags)
		  Sources(1) = Ark.DataSource.SharedInstance(Flags)
		  
		  While mPendingImports.Count > 0
		    Var Content As String = mPendingImports(mPendingImports.FirstIndex)
		    mPendingImports.RemoveAt(mPendingImports.FirstIndex)
		    
		    If Beacon.IsCompressed(Content) Then
		      Content = Beacon.Decompress(Content)
		    End If
		    
		    Var Parsed As Dictionary
		    Var Timestamp As String
		    Var IsFull As Boolean
		    Try
		      Parsed = Beacon.ParseJSON(Content)
		      Timestamp = Parsed.Value("timestamp")
		      IsFull = Parsed.Value("is_full").BooleanValue
		      
		      Var FileVersion As Integer = Parsed.Value("beacon_version")
		      If FileVersion <> Version Then
		        Continue While
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing imported JSON")
		      Continue While
		    End Try
		    
		    For Each Source As Beacon.DataSource In Sources
		      Var Imported As Boolean
		      Try
		        Imported = Source.Import(Parsed, IsFull)
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Trying to import delta updates for " + Source.Identifier)
		      End Try
		      
		      If Imported = False Then
		        // Something has gone wrong
		        mPendingImports.ResizeTo(-1)
		        If IsFull = False Then
		          // Perform a full refresh
		          Preferences.LastSyncTime = ""
		          CheckNow(True)
		        End If
		        Continue While
		      End If
		    Next Source
		    
		    If Parsed.HasKey("timestamp") Then
		      Preferences.LastSyncTime = Parsed.Value("timestamp")
		    End If
		    
		    If mPendingImports.Count = 0 Then
		      // About to finish up, but if something gets added to mPendingImports, then the loop will restart to avoid missing anything
		      For Each Source As Beacon.DataSource In Sources
		        Source.Optimize()
		      Next Source
		    End If
		  Wend
		  
		  NotificationKit.Post(Notification_ImportStopped, Nil)
		  
		  If mCheckOnlineAfterImporting Then
		    mCheckOnlineAfterImporting = False
		    CheckNow()
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCheckingOnline As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCheckOnlineAfterImporting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentURLs() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingImports() As String
	#tag EndProperty


	#tag Constant, Name = Notification_ImportBegin, Type = String, Dynamic = False, Default = \"DataUpdater:ImportBegin", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_ImportStopped, Type = String, Dynamic = False, Default = \"DataUpdater:ImportStopped", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_OnlineCheckBegin, Type = String, Dynamic = False, Default = \"DataUpdater:OnlineCheckBegin", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_OnlineCheckError, Type = String, Dynamic = False, Default = \"DataUpdater:OnlineCheckError", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_OnlineCheckStopped, Type = String, Dynamic = False, Default = \"DataUpdater:OnlineCheckStopped", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant


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
	#tag EndViewBehavior
End Module
#tag EndModule
