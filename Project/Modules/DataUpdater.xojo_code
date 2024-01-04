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
		    Var LastSync As Double = App.OldestSync
		    If LastSync > 0 Then
		      CheckURL = CheckURL + "&since=" + EncodeURLComponent(LastSync.ToString(Locale.Raw, "0"))
		    End If
		  End If
		  If (App.IdentityManager Is Nil) = False And (App.IdentityManager.CurrentIdentity Is Nil) = False Then
		    CheckURL = CheckURL + "&userId=" + EncodeURLComponent(App.IdentityManager.CurrentIdentity.UserID)
		  End If
		  
		  mForceImport = Refresh
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
		Protected Sub Import(Data As DataUpdater.PendingDataImport)
		  mPendingImports.Add(Data)
		  
		  If mPendingImports.Count > 0 Then
		    If mImportThread Is Nil Then
		      mImportThread = New Thread
		      mImportThread.Priority = Thread.LowestPriority
		      mImportThread.DebugIdentifier = "DataUpdater.mImportThread"
		      AddHandler mImportThread.Run, AddressOf mImportThread_Run
		    End If
		    
		    If mImportThread.ThreadState = Thread.ThreadStates.NotRunning Then
		      mImportThread.Start
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Import(File As FolderItem, Flags As Integer = 0)
		  Try
		    Var Data As New DataUpdater.PendingDataImport(File, Flags)
		    Import(Data)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading local file for import")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Import(Content As String, Flags As Integer = 0)
		  Try
		    Var Data As New DataUpdater.PendingDataImport(Content, Flags)
		    Import(Data)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading content string for import")
		  End Try
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
		  
		  Import(Contents)
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
		    mForceImport = False
		    Return
		  End If
		  
		  Sender.YieldToNext
		  
		  NotificationKit.Post(Notification_ImportBegin, Nil)
		  
		  Var Sources() As Beacon.DataSource
		  Var DefinedSources() As Beacon.DataSource = App.DataSources()
		  For Each DefinedSource As Beacon.DataSource In DefinedSources
		    Sources.Add(DefinedSource.WriteableInstance)
		  Next
		  
		  For Each Source As Beacon.DataSource In Sources
		    Source.ImportChainBegin()
		  Next
		  
		  Var SourcesToOptimize As New Dictionary
		  
		  While mPendingImports.Count > 0
		    Var ImportData As DataUpdater.PendingDataImport = mPendingImports(mPendingImports.FirstIndex)
		    Var Content As String = ImportData.Content
		    mPendingImports.RemoveAt(mPendingImports.FirstIndex)
		    
		    Var Archive As Beacon.Archive
		    Try
		      Archive = Beacon.Archive.Open(Content)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to open archive")
		      Continue
		    End Try
		    
		    Var ManifestSource As String = Archive.GetFile("Manifest.json")
		    Var Manifest As Dictionary
		    Try
		      Manifest = Beacon.ParseJSON(ManifestSource)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to parse manifest")
		      Continue
		    End Try
		    
		    Var FileList() As Variant
		    Var IsFull As Boolean
		    Var Version As Integer
		    Var Timestamp As NullableDouble
		    Var IsUserData As Boolean
		    Try
		      FileList = Manifest.Value("files")
		      IsFull = Manifest.Value("isFull")
		      Version = Manifest.Value("version")
		      Timestamp = NullableDouble.FromVariant(Manifest.Lookup("timestamp", Nil))
		      IsUserData = Manifest.Lookup("isUserData", False).BooleanValue
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Loading values from manifest")
		      Continue
		    End Try
		    If ImportData.SupressExport Then
		      IsUserData = False
		    End If
		    
		    Var Payloads() As Dictionary
		    For Each Filename As Variant In FileList
		      Try
		        #if DebugBuild
		          Var StartTime As Double = System.Microseconds
		        #endif
		        Var PayloadContent As MemoryBlock = Archive.GetFile(Filename.StringValue)
		        Var Payload As Dictionary = Beacon.ParseJSON(PayloadContent)
		        #if DebugBuild
		          Var ParseTime As Double = System.Microseconds - StartTime
		          System.DebugLog("Took " + ParseTime.ToString(Locale.Raw, "#,##0") + " microseconds to parse " + Filename.StringValue + " (" + Beacon.BytesToString(PayloadContent.Size) + ").")
		        #endif
		        Payloads.Add(Payload)
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Parsing update payload")
		      End Try
		    Next
		    
		    For Each Source As Beacon.DataSource In Sources
		      If mForceImport = False And (Timestamp Is Nil) = False And Source.LastSyncTimestamp >= Timestamp Then
		        // No need to import this one
		        Continue
		      End If
		      
		      Var Imported As Boolean
		      Var OriginalChangeCount As Integer = Source.TotalChanges()
		      Try
		        Imported = Source.Import(IsFull, Payloads, Timestamp, IsUserData)
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Trying to import delta updates for " + Source.Identifier)
		      End Try
		      
		      If Imported And Source.TotalChanges() > OriginalChangeCount Then
		        SourcesToOptimize.Value(Source) = True
		      End If
		      
		      If Imported = False Then
		        // Something has gone wrong
		        mPendingImports.ResizeTo(-1)
		        If IsFull = False Then
		          // Perform a full refresh
		          Source.LastSyncTimestamp = 0
		          CheckNow(True)
		        End If
		      End If
		    Next
		    
		    If mPendingImports.Count = 0 Then
		      // About to finish up, but if something gets added to mPendingImports, then the loop will restart to avoid missing anything
		      For Each Entry As DictionaryEntry In SourcesToOptimize
		        Beacon.DataSource(Entry.Key).Optimize()
		      Next
		    End If
		  Wend
		  
		  For Each Source As Beacon.DataSource In Sources
		    Source.ImportChainFinished()
		  Next
		  
		  NotificationKit.Post(Notification_ImportStopped, Nil)
		  mForceImport = False
		  
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
		Private mForceImport As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingImports() As DataUpdater.PendingDataImport
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

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
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
