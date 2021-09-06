#tag Class
Protected Class CommonData
Inherits Beacon.DataSource
	#tag Event
		Sub BuildSchema()
		  Self.SQLExecute("CREATE TABLE news (uuid TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, title TEXT NOT NULL, detail TEXT, url TEXT, min_version INTEGER, max_version INTEGER, moment TEXT NOT NULL, min_os_version TEXT);")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
		  If mInstance = Self Then
		    mInstance = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function GetIdentifier() As String
		  Return "Common"
		End Function
	#tag EndEvent

	#tag Event
		Function GetSchemaVersion() As Integer
		  Return 100
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.UpdateNews()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function GetNews() As NewsItem()
		  Var OSMajor, OSMinor, OSBug As Integer
		  #if TargetMacOS
		    OSMajor = SystemInformationMBS.MacMajorVersion
		    OSMinor = SystemInformationMBS.MacMinorVersion
		    OSBug = SystemInformationMBS.MacBugFixVersion
		  #elseif TargetWin32
		    OSMajor = SystemInformationMBS.WinMajorVersion
		    OSMinor = SystemInformationMBS.WinMinorVersion
		    OSBug = SystemInformationMBS.WinBuildNumber
		  #endif
		  
		  Var BuildNumber As Integer = App.BuildNumber
		  Var Rows As RowSet = Self.SQLSelect("SELECT uuid, title, COALESCE(detail, '') AS detail, COALESCE(url, '') AS url, min_os_version FROM news WHERE (min_version IS NULL OR min_version <= ?1) AND (max_version IS NULL OR max_version >= ?1) ORDER BY moment DESC;", BuildNumber)
		  Var Items() As NewsItem
		  While Rows.AfterLastRow = False
		    If Rows.Column("min_os_version").Value.IsNull = False Then
		      Var MinOSVersionParts() As String = Rows.Column("min_os_version").StringValue.Split(".")
		      Var MinOSMajor As Integer = MinOSVersionParts(0).ToInteger
		      Var MinOSMinor As Integer = MinOSVersionParts(1).ToInteger
		      Var MinOSBug As Integer = MinOSVersionParts(2).ToInteger
		      Var Supported As Boolean = OSMajor > MinOSMajor Or (OSMajor = MinOSMajor And OSMinor > MinOSMinor) Or (OSMajor = MinOSMajor And OSMinor = MinOSMinor AND OSBug >= MinOSBug)
		      If Not Supported Then
		        Rows.MoveToNextRow
		        Continue
		      End If
		    End If
		    
		    Var Item As New NewsItem
		    Item.UUID = Rows.Column("uuid").StringValue
		    Item.Title = Rows.Column("title").StringValue
		    Item.Detail = Rows.Column("detail").StringValue
		    Item.URL = Rows.Column("url").StringValue
		    Items.Add(Item)
		    Rows.MoveToNextRow
		  Wend
		  Return Items
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance(Create As Boolean = True) As Beacon.CommonData
		  If mInstance Is Nil And Create = True Then
		    mInstance = New Beacon.CommonData
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateNews()
		  If (Self.mUpdateNewsThread Is Nil) = False Then
		    Return
		  End If
		  
		  Var Th As New Thread
		  Th.Priority = Thread.LowestPriority
		  Th.DebugIdentifier = "News Updater"
		  AddHandler Th.Run, WeakAddressOf UpdateNewsThread_Run
		  Th.Start
		  Self.mUpdateNewsThread = Th
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateNewsThread_Run(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Var Socket As New URLConnection
		  Socket.RequestHeader("User-Agent") = App.UserAgent
		  Var Content As String = Socket.SendSync("GET", Beacon.WebURL("/news?stage=" + App.StageCode.ToString))
		  
		  If Socket.HTTPStatusCode <> 200 Then
		    Return
		  End If
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Items() As Dictionary
		  Try
		    Items = Parsed.DictionaryArrayValue
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Self.BeginTransaction()
		  
		  Var Changed As Boolean
		  Var Rows As RowSet = Self.SQLSelect("SELECT uuid FROM news")
		  Var ItemsToRemove() As String
		  While Rows.AfterLastRow = False
		    ItemsToRemove.Add(Rows.Column("uuid").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  
		  For Each Item As Dictionary In Items
		    Try
		      Var UUID As String = Item.Value("uuid")
		      Var Title As String = Item.Value("title")
		      Var Detail As Variant = Item.Value("detail")
		      Var ItemURL As Variant = Item.Value("url")
		      Var MinVersion As Variant = Item.Value("min_version")
		      Var MaxVersion As Variant = Item.Value("max_version")
		      Var Moment As String = Item.Value("timestamp")
		      Var MinOSVersion As Variant
		      #if TargetMacOS
		        MinOSVersion = Item.Value("mac_min_os")
		      #elseif TargetWindows
		        MinOSVersion = Item.Value("win_min_os")
		      #endif
		      
		      Var Idx As Integer = ItemsToRemove.IndexOf(UUID)
		      If Idx > -1 Then
		        ItemsToRemove.RemoveAt(Idx)
		      Else
		        Self.SQLExecute("INSERT INTO news (uuid, title, detail, url, min_version, max_version, moment, min_os_version) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8);", UUID, Title, Detail, ItemURL, MinVersion, MaxVersion, Moment, MinOSVersion)
		        Changed = True
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Changed = Changed Or ItemsToRemove.Count > 0
		  
		  If ItemsToRemove.Count > 0 Then
		    Self.SQLExecute("DELETE FROM news WHERE uuid IN ('" + ItemsToRemove.Join("','") + "');")
		  End If
		  
		  Self.CommitTransaction()
		  
		  If Changed Then
		    NotificationKit.Post(Self.Notification_NewsUpdated, Nil)
		  End If
		  
		  Self.mUpdateNewsThread = Nil
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mInstance As Beacon.CommonData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateNewsThread As Thread
	#tag EndProperty


	#tag Constant, Name = Notification_NewsUpdated, Type = String, Dynamic = False, Default = \"News Updated", Scope = Public
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
End Class
#tag EndClass
