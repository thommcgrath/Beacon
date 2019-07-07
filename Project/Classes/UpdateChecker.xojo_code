#tag Class
Protected Class UpdateChecker
	#tag Method, Flags = &h0
		Sub Cancel()
		  If Self.mSocket <> Nil Then
		    Self.mSocket.Disconnect
		    Self.mSocket = Nil
		  End If
		  
		  Self.mChecking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Check(Silent As Boolean)
		  If Self.mChecking Then
		    Return
		  End If
		  
		  Self.mSilent = Silent
		  Self.mChecking = True
		  
		  Self.mSocket = New Xojo.Net.HTTPSocket
		  Self.mSocket.ValidateCertificates = True
		  AddHandler Self.mSocket.Error, WeakAddressOf Self.mSocket_Error
		  AddHandler Self.mSocket.HeadersReceived, WeakAddressOf Self.mSocket_HeadersReceived
		  AddHandler Self.mSocket.PageReceived, WeakAddressOf Self.mSocket_PageReceived
		  Self.mSocket.RequestHeader("Cache-Control") = "no-cache"
		  
		  Dim Params As New Xojo.Core.Dictionary
		  Params.Value("build") = App.BuildNumber.ToText
		  Params.Value("stage") = App.StageCode.ToText
		  If Self.Is64Bit Then
		    Params.Value("arch") = "x86_64"
		  Else
		    Params.Value("arch") = "x86"
		  End If
		  Params.Value("osversion") = OSVersion.ToText
		  #if TargetMacOS
		    Params.Value("platform") = "mac"
		  #elseif TargetWin32
		    Params.Value("platform") = "win"
		  #endif
		  
		  Self.mSocket.Send("GET", Beacon.WebURL("/updates.php?" + BeaconAPI.Request.URLEncodeFormData(Params)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Is64Bit() As Boolean
		  #If TargetWin32 Then
		    Soft Declare Function GetCurrentProcess Lib "kernel32"  As Integer
		    Dim ProcessID As Integer = GetCurrentProcess
		    
		    Soft Declare Function IsWow64Process Lib "kernel32" (Handle As Integer, ByRef Result As Boolean) As Integer
		    
		    If System.IsFunctionAvailable("IsWow64Process", "Kernel32") Then
		      Dim Value As Boolean
		      Call IsWow64Process(ProcessID, Value)
		      Return Value
		    Else
		      Return False
		    End If
		  #ElseIf TargetMacOS
		    Return True
		  #Endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As Xojo.Net.HTTPSocket, Error As RuntimeException)
		  Sender.Disconnect
		  Self.mChecking = False
		  
		  If Self.mSocket <> Nil Then
		    Self.mSocket = Nil
		  End If
		  
		  If Not Self.mSilent Then
		    RaiseEvent CheckError(Error.Reason)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_HeadersReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer)
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    Self.mChecking = False
		    Sender.Disconnect
		    If Not Self.mSilent Then
		      RaiseEvent CheckError("The update definition was not found.")
		    End If
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  #Pragma Unused HTTPStatus
		  
		  If Self.mSocket <> Nil Then
		    Self.mSocket = Nil
		  End If
		  
		  Self.mChecking = False
		  
		  Dim Body As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  Dim Dict As Xojo.Core.Dictionary
		  Try
		    Dict = Xojo.Data.ParseJSON(Body)
		  Catch Err As Xojo.Data.InvalidJSONException
		    If Not Self.mSilent Then
		      RaiseEvent CheckError("Invalid definition file.")
		    End If
		    Return
		  End Try
		  
		  If Dict.HasKey("notices") Then
		    Dim Notices() As Auto = Dict.Value("notices")
		    Dict.Remove("notices")
		    
		    For Each Notice As Xojo.Core.Dictionary In Notices
		      Dim Notification As New Beacon.UserNotification(Notice.Value("message"))
		      Notification.SecondaryMessage = Notice.Value("secondary_message")
		      Notification.ActionURL = Notice.Value("action_url")
		      Notification.DoNotResurrect = True
		      LocalData.SharedInstance.SaveNotification(Notification)
		    Next
		  End If
		  
		  If Dict.Count = 0 Then
		    // No update
		    If Not Self.mSilent Then
		      RaiseEvent NoUpdate()
		    End If
		    Return
		  End If
		  
		  Try
		    Dim LatestBuild As Integer = Dict.Value("build")
		    If LatestBuild <= App.BuildNumber Then
		      If Not Self.mSilent Then
		        RaiseEvent NoUpdate()
		      End If
		      Return
		    End If
		    
		    Dim Version As Text = Dict.Value("version")
		    Dim NotesHTML As Text = Dict.Value("notes")
		    Dim PreviewText As Text = Dict.Lookup("preview", "")
		    Dim Location As Xojo.Core.Dictionary
		    #if TargetMacOS
		      Location = Dict.Value("mac")
		    #elseif TargetWin32
		      Location = Dict.Value("win")
		    #endif
		    Dim PackageURL As Text = Location.Value("url")
		    Dim Signature As Text = Location.Value("signature")
		    
		    RaiseEvent UpdateAvailable(Version, PreviewText, NotesHTML, PackageURL, Signature)
		  Catch Err As KeyNotFoundException
		    If Not Self.mSilent Then
		      RaiseEvent CheckError("Invalid definition file.")
		    End If
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function OSVersion() As String
		  #if TargetMacOS
		    Declare Function NSClassFromString Lib "AppKit" (ClassName As CFStringRef) As Ptr
		    Declare Function ProcessInfo Lib "AppKit" Selector "processInfo" (ClassRef As Ptr) As Ptr
		    Declare Function OperatingSystemVersion Lib "AppKit" Selector "operatingSystemVersion" (NSProcessInfo As Ptr) As MacOSVersion
		    
		    Dim Info As Ptr = ProcessInfo(NSClassFroMString("NSProcessInfo"))
		    Dim Struct As MacOSVersion = OperatingSystemVersion(Info)
		    Return Str(Struct.Major, "-0") + "." + Str(Struct.Minor, "-0") + "." + Str(Struct.Bug, "-0")
		  #elseif TargetWin32
		    If System.IsFunctionAvailable("RtlGetVersion", "ntdll.dll") Then
		      Soft Declare Function RtlGetVersion Lib "ntdll.dll" (ByRef VersionInformation As WinOSVersion) As Int32
		      
		      Dim Struct As WinOSVersion
		      Struct.OSVersionInfoSize = WinOSVersion.Size
		      
		      Call RtlGetVersion(Struct)
		      
		      Return Str(Struct.MajorVersion, "-0") + "." + Str(Struct.MinorVersion, "-0") + "." + Str(Struct.BuildNumber, "-0")
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function VerifyFile(File As Global.FolderItem, Signature As String) As Boolean
		  Dim Stream As BinaryStream = BinaryStream.Open(File, False)
		  Dim Contents As MemoryBlock = Stream.Read(Stream.Length)
		  Stream.Close
		  
		  Return Crypto.RSAVerifySignature(Contents, DecodeHex(Signature), PublicKey)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CheckError(Message As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NoUpdate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateAvailable(Version As String, PreviewText As String, Notes As String, URL As String, Signature As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mChecking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSilent As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As Xojo.Net.HTTPSocket
	#tag EndProperty


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
