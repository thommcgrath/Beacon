#tag Class
Protected Class FTPDeploymentEngine
Implements Beacon.DeploymentEngine
	#tag Method, Flags = &h0
		Function BackupGameIni() As Text
		  Return Self.mGameIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupGameUserSettingsIni() As Text
		  Return Self.mGameUserSettingsIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Begin(Label As Text, Document As Beacon.Document, Identity As Beacon.Identity)
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  #Pragma Unused Label
		  
		  Self.mIdentity = Identity
		  Self.mDocument = Document
		  
		  Self.DownloadGameIni()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildFTPParameters(File As Text) As Xojo.Core.Dictionary
		  Dim Fields As Xojo.Core.Dictionary = Self.mProfile.AsFormData
		  If File <> "" Then
		    Fields.Value("path") = File
		  End If
		  Return Fields
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.mCancelled Then
		    Return
		  ElseIf Response.Success = False Then
		    Self.SetError(Response.Message)
		    Return
		  End If
		  
		  Try
		    Dim Dict As Xojo.Core.Dictionary = Response.JSON
		    If Dict.HasKey("ftp_mode") Then
		      Self.mProfile.Mode = Dict.Value("ftp_mode")
		    End If
		    Self.mGameIniOriginal = Dict.Value("content")
		    
		    Self.DownloadGameUserSettingsIni()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.mCancelled Then
		    Return
		  ElseIf Response.Success = False Then
		    Self.SetError(Response.Message)
		    Return
		  End If
		  
		  Try
		    Dim Dict As Xojo.Core.Dictionary = Response.JSON
		    If Dict.HasKey("ftp_mode") Then
		      Self.mProfile.Mode = Dict.Value("ftp_mode")
		    End If
		    Self.mGameUserSettingsIniOriginal = Dict.Value("content")
		    
		    Self.UploadGameIni()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameIni(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.mCancelled Then
		    Return
		  ElseIf Response.Success = False Then
		    Self.SetError(Response.Message)
		    Return
		  End If
		  
		  Self.UploadGameUserSettingsIni()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameUserSettingsIni(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.mCancelled Then
		    Return
		  ElseIf Response.Success = False Then
		    Self.SetError(Response.Message)
		    Return
		  End If
		  
		  Self.mStatus = "Finished"
		  Self.mFinished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.FTPServerProfile)
		  Self.mProfile = Profile
		  Self.mSocket = New BeaconAPI.Socket
		  
		  Self.mGameIniRewriter = New Beacon.Rewriter
		  AddHandler mGameIniRewriter.Finished, WeakAddressOf mGameIniRewriter_Finished
		  
		  Self.mGameUserSettingsIniRewriter = New Beacon.Rewriter
		  AddHandler mGameUserSettingsIniRewriter.Finished, WeakAddressOf mGameUserSettingsIniRewriter_Finished
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni()
		  Self.mStatus = "Downloading Game.ini…"
		  
		  Dim Request As New BeaconAPI.Request("ftp", "GET", Self.BuildFTPParameters(Self.mProfile.GameIniPath), AddressOf Callback_DownloadGameIni)
		  Request.Sign(Self.mIdentity)
		  Self.mSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameUserSettingsIni()
		  Self.mStatus = "Downloading GameUserSettings.ini…"
		  
		  Dim Request As New BeaconAPI.Request("ftp", "GET", Self.BuildFTPParameters(Self.mProfile.GameUserSettingsIniPath), AddressOf Callback_DownloadGameUserSettingsIni)
		  Request.Sign(Self.mIdentity)
		  Self.mSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mGameIniRewriter_Finished(Sender As Beacon.Rewriter)
		  If Sender.Errored Then
		    Self.SetError("Unable to generate updated Game.ini file")
		    Return
		  End If
		  
		  Dim Content As Text = Sender.UpdatedContent.ToText
		  
		  Self.mStatus = "Uploading Game.ini"
		  Dim Request As New BeaconAPI.Request("ftp?" + BeaconAPI.Request.URLEncodeFormData(Self.BuildFTPParameters(Self.mProfile.GameIniPath)), "POST", Content, "text/plain", AddressOf Callback_UploadGameIni)
		  Request.Sign(Self.mIdentity)
		  Self.mSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mGameUserSettingsIniRewriter_Finished(Sender As Beacon.Rewriter)
		  If Sender.Errored Then
		    Self.SetError("Unable to generate updated GameUserSettings.ini file")
		    Return
		  End If
		  
		  Dim Content As Text = Sender.UpdatedContent.ToText
		  
		  Self.mStatus = "Uploading GameUserSettings.ini"
		  Dim Request As New BeaconAPI.Request("ftp?" + BeaconAPI.Request.URLEncodeFormData(Self.BuildFTPParameters(Self.mProfile.GameUserSettingsIniPath)), "POST", Content, "text/plain", AddressOf Callback_UploadGameUserSettingsIni)
		  Request.Sign(Self.mIdentity)
		  Self.mSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerIsStarting() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(Err As RuntimeException)
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Err)
		  Dim Reason As Text
		  If Err.Reason <> "" Then
		    Reason = Err.Reason
		  ElseIf Err.Message <> "" Then
		    Reason = Err.Message.ToText
		  Else
		    Reason = "No details available"
		  End If
		  
		  Self.SetError("Unhandled " + Info.FullName + ": '" + Reason + "'")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(Message As Text)
		  Self.mStatus = "Error: " + Message
		  Self.mFinished = True
		  Self.mErrored = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Text
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameIni()
		  Self.mStatus = "Generating Game.ini"
		  Self.mGameIniRewriter.Rewrite(Self.mGameIniOriginal, Beacon.RewriteModeGameIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameUserSettingsIni()
		  Self.mStatus = "Generating GameUserSettings.ini"
		  Self.mGameUserSettingsIniRewriter.Rewrite(Self.mGameUserSettingsIniOriginal, Beacon.RewriteModeGameUserSettingsIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniOriginal As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniOriginal As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.FTPServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As BeaconAPI.Socket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
