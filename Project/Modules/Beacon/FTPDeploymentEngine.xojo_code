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
		  
		  Dim Options() As Beacon.ConfigValue
		  Self.mGameIniDict = New Xojo.Core.Dictionary
		  Self.mGameUserSettingsIniDict = New Xojo.Core.Dictionary
		  Document.CreateConfigObjects(Options, Self.mGameIniDict, Self.mGameUserSettingsIniDict, Self.mProfile.Mask, Identity, Self.mProfile)
		  
		  Dim SessionSettingsValues() As Text = Array("SessionName=" + Self.mProfile.Name)
		  Dim SessionSettings As New Xojo.Core.Dictionary
		  SessionSettings.Value("SessionName") = SessionSettingsValues
		  Self.mGameUserSettingsIniDict.Value("SessionSettings") = SessionSettings
		  
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
		Sub Constructor(Profile As Beacon.FTPServerProfile, Identity As Beacon.Identity)
		  Self.mProfile = Profile
		  Self.mSocket = New BeaconAPI.Socket
		  Self.mIdentity = Identity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni()
		  If Self.mGameIniDict.Count = 0 Then
		    Self.DownloadGameUserSettingsIni
		    Return
		  End If
		  
		  Self.mStatus = "Downloading Game.ini…"
		  
		  Dim Request As New BeaconAPI.Request("ftp", "GET", Self.BuildFTPParameters(Self.mProfile.GameIniPath), AddressOf Callback_DownloadGameIni)
		  Request.Sign(Self.mIdentity)
		  Self.mSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameUserSettingsIni()
		  If Self.mGameUserSettingsIniDict.Count = 0 Then
		    Self.UploadGameIni()
		    Return
		  End If
		  
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
		  If Self.mGameIniDict.Count = 0 Then
		    Self.UploadGameUserSettingsIni
		    Return
		  End If
		  
		  Self.mStatus = "Uploading Game.ini"
		  
		  Dim Content As Text = Beacon.RewriteIniContent(Self.mGameIniOriginal, Self.mGameIniDict)
		  Dim Request As New BeaconAPI.Request("ftp?" + BeaconAPI.Request.URLEncodeFormData(Self.BuildFTPParameters(Self.mProfile.GameIniPath)), "POST", Content, "text/plain", AddressOf Callback_UploadGameIni)
		  Request.Sign(App.IdentityManager.CurrentIdentity)
		  Self.mSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameUserSettingsIni()
		  If Self.mGameUserSettingsIniDict.Count = 0 Then
		    Self.mStatus = "Finished"
		    Self.mFinished = True
		    Return
		  End If
		  
		  Self.mStatus = "Uploading GameUserSettings.ini"
		  
		  Dim Content As Text = Beacon.RewriteIniContent(Self.mGameUserSettingsIniOriginal, Self.mGameUserSettingsIniDict)
		  Dim Request As New BeaconAPI.Request("ftp?" + BeaconAPI.Request.URLEncodeFormData(Self.BuildFTPParameters(Self.mProfile.GameUserSettingsIniPath)), "POST", Content, "text/plain", AddressOf Callback_UploadGameUserSettingsIni)
		  Request.Sign(App.IdentityManager.CurrentIdentity)
		  Self.mSocket.Start(Request)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniDict As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniOriginal As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniDict As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniOriginal As Text
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
