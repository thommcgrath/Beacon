#tag Module
Protected Module UpdatesKit
	#tag Method, Flags = &h1
		Protected Function AvailableDisplayVersion() As String
		  Return mAvailableDisplayVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableDownloadURL() As String
		  Return mAvailableDownloadURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableNotes() As String
		  Return mAvailableNotes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableNotesURL() As String
		  Return mAvailableNotesURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailablePreview() As String
		  Return mAvailablePreview
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableSignature() As String
		  Return mAvailableSignature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableUpdateRequired() As Boolean
		  Return mAvailableUpdateRequired
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Cancel()
		  If (mSocket Is Nil) = False Then
		    mSocket.Disconnect
		    mSocket = Nil
		  End If
		  
		  mChecking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Check()
		  If mChecking Then
		    Return
		  End If
		  
		  mChecking = True
		  mLastCheckTime = DateTime.Now
		  
		  mSocket = New URLConnection
		  mSocket.AllowCertificateValidation = True
		  AddHandler mSocket.Error, AddressOf mSocket_Error
		  AddHandler mSocket.HeadersReceived, AddressOf mSocket_HeadersReceived
		  AddHandler mSocket.ContentReceived, AddressOf mSocket_ContentReceived
		  mSocket.RequestHeader("Cache-Control") = "no-cache"
		  mSocket.RequestHeader("User-Agent") = App.UserAgent
		  
		  Var Params As New Dictionary
		  Params.Value("build") = App.BuildNumber.ToString
		  Params.Value("stage") = App.StageCode.ToString
		  Params.Value("arch") = If(IsARM, "arm", "x86")
		  If Is64Bit Then
		    Params.Value("arch") = Params.Value("arch").StringValue + "_64"
		  End If
		  Params.Value("osversion") = OSVersion
		  #if TargetMacOS
		    Params.Value("platform") = "mac"
		  #elseif TargetWin32
		    Params.Value("platform") = "win"
		  #elseif TargetLinux
		    Params.Value("platform") = "lin"
		    
		    Try
		      Var DebianFile As New FolderItem("/etc/debian_version", FolderItem.PathModes.Native)
		      Params.Value("installer_format") = If(DebianFile.Exists, "deb", "rpm")
		    Catch Err As RuntimeException
		      Params.Value("installer_format") = "rpm"
		    End Try
		  #endif
		  
		  mSocket.Send("GET", Beacon.WebURL("/updates?" + SimpleHTTP.BuildFormData(Params)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Is64Bit() As Boolean
		  #If Target64Bit
		    // If we're already executing 64-bit code, then we know it's a 64-bit system
		    Return True
		  #endif
		  
		  #If TargetWin32 Then
		    Soft Declare Function GetCurrentProcess Lib "kernel32"  As Integer
		    Var ProcessID As Integer = GetCurrentProcess
		    
		    If System.IsFunctionAvailable("IsWow64Process2", "kernel32") Then
		      Soft Declare Function IsWow64Process2 Lib "kernel32" (Handle As Integer, ByRef ProcessMachine As UInt16, ByRef NativeMachine As UInt16) As Boolean
		      
		      Var ProcessMachine, NativeMachine As UInt16
		      If Not IsWow64Process2(ProcessID, ProcessMachine, NativeMachine) Then
		        Return False
		      End If
		      
		      Return NativeMachine = &h200 Or NativeMachine = &h8664 Or NativeMachine = &hAA64 Or NativeMachine = &h284
		    ElseIf System.IsFunctionAvailable("IsWow64Process", "kernel32") Then
		      Soft Declare Function IsWow64Process Lib "kernel32" (Handle As Integer, ByRef Wow64Process As Boolean) As Boolean
		      
		      Var Wow64Process As Boolean
		      If Not IsWow64Process(ProcessID, Wow64Process) Then
		        Return False
		      End If
		      
		      Return Wow64Process
		    End If
		  #Endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsARM() As Boolean
		  #if TargetARM
		    // Since the code is already compiled ARM, we know this to be true
		    Return True
		  #endif
		  
		  Return SystemInformationMBS.IsARM Or SystemInformationMBS.IsTranslated = 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsBusy() As Boolean
		  Return mChecking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsCheckingAutomatically() As Boolean
		  Return (mAutoCheckTimer Is Nil) = False And mAutoCheckTimer.RunMode = Timer.RunModes.Multiple
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub IsCheckingAutomatically(Assigns Value As Boolean)
		  If IsCheckingAutomatically = Value Then
		    // No changes necessary
		    Return
		  End If
		  
		  If mAutoCheckTimer Is Nil Then
		    If Value = False Then
		      Return
		    End If
		    
		    mAutoCheckTimer = New Timer
		    mAutoCheckTimer.Period = 60000 // Does not actually check every minute, that is throttled by the event
		    AddHandler mAutoCheckTimer.Action, AddressOf mAutoCheckTimer_Action
		  End If
		  
		  If Value And mAutoCheckTimer.RunMode <> Timer.RunModes.Multiple Then
		    App.Log("Automatic update checking is enabled.")
		    mAutoCheckTimer_Action(mAutoCheckTimer) // Force fire it now to catch up
		    mAutoCheckTimer.RunMode = Timer.RunModes.Multiple
		  ElseIf Value = False And mAutoCheckTimer.RunMode <> Timer.RunModes.Off Then
		    App.Log("Automatic update checking has been stopped.")
		    mAutoCheckTimer.RunMode = Timer.RunModes.Off
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsUpdateAvailable() As Boolean
		  Return mAvailableDisplayVersion.IsEmpty = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAutoCheckTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If (mLastCheckTime Is Nil) Or DateTime.Now.SecondsFrom1970 - mLastCheckTime.SecondsFrom1970 >= 3600 Then
		    Check()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  #Pragma Unused HTTPStatus
		  
		  If Sender = mSocket Then
		    mChecking = False
		    mSocket = Nil
		  End If
		  
		  Var Dict As Dictionary
		  Try
		    Dict = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    NotificationKit.Post(Notification_Error, "Invalid definition file.")
		    Return
		  End Try
		  
		  If Dict.HasKey("notices") Then
		    // Not needed anymore
		    Dict.Remove("notices")
		  End If
		  
		  If Dict.KeyCount = 0 Then
		    // No update
		    NotificationKit.Post(Notification_NoUpdates, Nil)
		    Return
		  End If
		  
		  Try
		    Var LatestBuild As Integer = Dict.Value("build")
		    If LatestBuild <= App.BuildNumber Then
		      NotificationKit.Post(Notification_NoUpdates, Nil)
		      Return
		    End If
		    
		    mAvailableDisplayVersion = Dict.Value("version")
		    mAvailableNotes = Dict.Value("notes")
		    mAvailableNotesURL = Dict.Lookup("notes_url", "")
		    mAvailablePreview = Dict.Lookup("preview", "")
		    mAvailableUpdateRequired = Dict.Lookup("required", False)
		    Var Location As Dictionary
		    #if TargetMacOS
		      Location = Dict.Value("mac")
		    #elseif TargetWin32
		      Location = Dict.Value("win")
		    #elseif TargetLinux
		      If Dict.HasKey("lin") Then
		        Location = Dict.Value("lin")
		      Else
		        NotificationKit.Post(Notification_NoUpdates)
		      End If
		    #endif
		    mAvailableDownloadURL = Location.Value("url")
		    mAvailableSignature = Location.Value("signature")
		    
		    NotificationKit.Post(Notification_UpdateAvailable, LatestBuild)
		  Catch Err As RuntimeException
		    NotificationKit.Post(Notification_Error, "Invalid definition file.")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As URLConnection, Error As RuntimeException)
		  Sender.Disconnect
		  
		  If Sender = mSocket Then
		    mChecking = False
		    mSocket = Nil
		  End If
		  
		  NotificationKit.Post(Notification_Error, Error.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_HeadersReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer)
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    Sender.Disconnect
		    
		    If Sender = mSocket Then
		      mChecking = False
		      mSocket = Nil
		    End If
		    
		    NotificationKit.Post(Notification_Error, "The update definition was not found.")
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OSVersion() As String
		  Var MajorVersion, MinorVersion, BugVersion As Integer
		  OSVersion(MajorVersion, MinorVersion, BugVersion)
		  Return MajorVersion.ToString(Locale.Raw, "0") + "." + MinorVersion.ToString(Locale.Raw, "0") + "." + BugVersion.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OSVersion(ByRef MajorVersion As Integer, ByRef MinorVersion As Integer, ByRef BugVersion As Integer)
		  #if TargetMacOS
		    Declare Function NSClassFromString Lib "AppKit" (ClassName As CFStringRef) As Ptr
		    Declare Function ProcessInfo Lib "AppKit" Selector "processInfo" (ClassRef As Ptr) As Ptr
		    Declare Function OperatingSystemVersion Lib "AppKit" Selector "operatingSystemVersion" (NSProcessInfo As Ptr) As MacOSVersion
		    
		    Var Info As Ptr = ProcessInfo(NSClassFromString("NSProcessInfo"))
		    Var Struct As MacOSVersion = OperatingSystemVersion(Info)
		    
		    MajorVersion = Struct.Major
		    MinorVersion = Struct.Minor
		    BugVersion = Struct.Bug
		  #elseif TargetWin32
		    If System.IsFunctionAvailable("RtlGetVersion", "ntdll.dll") Then
		      Soft Declare Function RtlGetVersion Lib "ntdll.dll" (ByRef VersionInformation As WinOSVersion) As Int32
		      
		      Var Struct As WinOSVersion
		      Struct.OSVersionInfoSize = WinOSVersion.Size
		      
		      Call RtlGetVersion(Struct)
		      
		      MajorVersion = Struct.MajorVersion
		      MinorVersion = Struct.MinorVersion
		      BugVersion = Struct.BuildNumber
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VerifyFile(File As Global.FolderItem, Signature As String) As Boolean
		  If File = Nil Or File.Exists = False Then
		    Return False
		  End If
		  
		  Try
		    Var Contents As MemoryBlock = File.Read
		    Return Crypto.RSAVerifySignature(Contents, DecodeHex(Signature), PublicKey)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAutoCheckTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableDisplayVersion As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableDownloadURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableNotes As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableNotesURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailablePreview As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableUpdateRequired As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChecking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCheckTime As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As URLConnection
	#tag EndProperty


	#tag Constant, Name = Notification_Error, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.error", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_NoUpdates, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.none", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_UpdateAvailable, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.available", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PublicKey, Type = String, Dynamic = False, Default = \"30820120300D06092A864886F70D01010105000382010D003082010802820101008F9D9B313D28FDE0FD2100032D2E1A7F968A2E4975AF93A507823A95EFFE6A73176BD76D1286CC5DE513D3F4163F6F4E3D2A2FC472D540533020035FA0ED3FDFA33CBA289A94753D70546544459BE69E99B3B08AACBF489DEFA45BA1CC04DE0976DE2DABDC523A13FCEAE701468D994FEC116F30D44B307FD80AB13B1E15E76EA8B1366EC22E814F15D8021993FAE0BA39DF440EEF17550BC3A6CE2831A1B479E93088F2CAACFD19179D1C0744F0293A94C06D8F7D1D73C089D950F86953C2605F70462A889C4A1160B70192C1F97964F0741ED74713E10FF9CDC5BE6205385E5245297D41C31A75067699CB85D9FA6F806E8C770C5E91D706BCD5426C3080B1020111", Scope = Private
	#tag EndConstant


	#tag Structure, Name = MacOSVersion, Flags = &h21
		Major As Integer
		  Minor As Integer
		Bug As Integer
	#tag EndStructure

	#tag Structure, Name = WinOSVersion, Flags = &h21
		OSVersionInfoSize As UInt32
		  MajorVersion As UInt32
		  MinorVersion As UInt32
		  BuildNumber As UInt32
		  PlatformId As UInt32
		  CSDVersion As String * 256
		  ServicePackMajor As UInt16
		  ServicePackMinor As UInt16
		  SuiteMask As UInt16
		  ProductType As UInt8
		Reserved As UInt8
	#tag EndStructure


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
