#tag Class
Protected Class UpdateChecker
	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mSocket.Disconnect
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
		  Self.mSocket.Send("GET", Beacon.WebURL + "/updates.php")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSocket = New Xojo.Net.HTTPSocket
		  Self.mSocket.ValidateCertificates = True
		  AddHandler Self.mSocket.Error, WeakAddressOf Self.mSocket_Error
		  AddHandler Self.mSocket.HeadersReceived, WeakAddressOf Self.mSocket_HeadersReceived
		  AddHandler Self.mSocket.PageReceived, WeakAddressOf Self.mSocket_PageReceived
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As Xojo.Net.HTTPSocket, Error As RuntimeException)
		  Sender.Disconnect
		  Self.mChecking = False
		  
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
		  
		  Try
		    Dim LatestBuild As Integer = Dict.Value("build")
		    If LatestBuild <= App.NonReleaseVersion Then
		      If Not Self.mSilent Then
		        RaiseEvent NoUpdate()
		      End If
		      Return
		    End If
		    
		    Dim Version As Text = Dict.Value("version")
		    Dim NotesHTML As Text = Dict.Value("notes")
		    Dim Location As Xojo.Core.Dictionary
		    #if TargetMacOS
		      Location = Dict.Value("mac")
		    #elseif TargetWin32
		      Location = Dict.Value("win")
		    #endif
		    Dim PackageURL As Text = Location.Value("url")
		    Dim Signature As Text = Location.Value("signature")
		    
		    RaiseEvent UpdateAvailable(Version, NotesHTML, PackageURL, Signature)
		  Catch Err As KeyNotFoundException
		    If Not Self.mSilent Then
		      RaiseEvent CheckError("Invalid definition file.")
		    End If
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function VerifyFile(File As Global.FolderItem, Signature As String) As Boolean
		  Dim Stream As BinaryStream = BinaryStream.Open(File, False)
		  Dim Contents As MemoryBlock = Stream.Read(Stream.Length)
		  Stream.Close
		  
		  Dim Hash As String = EncodeHex(Crypto.MD5(Contents))
		  System.DebugLog("Hash is " + Hash)
		  
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
		Event UpdateAvailable(Version As String, Notes As String, URL As String, Signature As String)
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
