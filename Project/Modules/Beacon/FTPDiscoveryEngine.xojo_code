#tag Class
Protected Class FTPDiscoveryEngine
Implements Beacon.DiscoveryEngine
	#tag Method, Flags = &h0
		Sub Begin()
		  Self.DiscoverServer()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildFTPParameters(File As Text = "") As Xojo.Core.Dictionary
		  Dim Fields As Xojo.Core.Dictionary = Self.mProfile.AsFormData
		  If File <> "" Then
		    Fields.Value("path") = File
		  End If
		  Return Fields
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DiscoverServer(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused HTTPStatus
		  #Pragma Unused RawReply
		  
		  If Not Success Then
		    Self.SetError(Message)
		    Return
		  End If
		  
		  Dim Dict As Xojo.Core.Dictionary = Details
		  If Not Dict.HasAllKeys("Game.ini", "GameUserSettings.ini") Then
		    Self.SetError("Unable to find Game.ini and GameUserSettings.ini files")
		    Return
		  End If
		  
		  If Dict.HasKey("Options") Then
		    Self.mCommandLineOptions = Dict.Value("Options")
		  Else
		    Self.mCommandLineOptions = New Xojo.Core.Dictionary
		  End If
		  
		  If Dict.HasKey("Maps") Then
		    Dim Maps() As Auto = Dict.Value("Maps")
		    For Each Map As Text In Maps
		      Select Case Map
		      Case "ScorchedEarth_P"
		        Self.mMap = Self.mMap Or Beacon.Maps.ScorchedEarth.Mask
		      Case "Aberration_P"
		        Self.mMap = Self.mMap Or Beacon.Maps.Aberration.Mask
		      Case "TheCenter"
		        Self.mMap = Self.mMap Or Beacon.Maps.TheCenter.Mask
		      Case "Ragnarok"
		        Self.mMap = Self.mMap Or Beacon.Maps.Ragnarok.Mask
		      Else
		        // Unofficial maps will be tagged as The Island
		        Self.mMap = Self.mMap Or Beacon.Maps.TheIsland.Mask
		      End Select
		    Next
		  Else
		    Self.mMap = Beacon.Maps.TheIsland.Mask
		  End If
		  
		  Self.mStatus = "Downloading config files…"
		  
		  Self.mProfile.GameIniPath = Dict.Value("Game.ini")
		  Self.mProfile.GameUserSettingsIniPath = Dict.Value("GameUserSettings.ini")
		  
		  Self.DownloadGameIni()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused HTTPStatus
		  #Pragma Unused RawReply
		  
		  If Success = False Then
		    Self.SetError(Message)
		    Return
		  End If
		  
		  Try
		    Dim Dict As Xojo.Core.Dictionary = Details
		    
		    Dim TextContent As Text = Dict.Value("content")
		    Self.mGameIniContent = TextContent.Trim
		    
		    Self.DownloadGameUserSettingsIni()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused HTTPStatus
		  #Pragma Unused RawReply
		  
		  If Success = False Then
		    Self.SetError(Message)
		    Return
		  End If
		  
		  Try
		    Dim Dict As Xojo.Core.Dictionary = Details
		    
		    Dim TextContent As Text = Dict.Value("content")
		    Self.mGameUserSettingsIniContent = TextContent.Trim
		    
		    Self.mFinished = True
		    Self.mErrored = False
		    Self.mStatus = "Finished"
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CommandLineOptions() As Xojo.Core.DIctionary
		  Return Self.mCommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.FTPServerProfile, InitialPath As Text, Identity As Beacon.Identity)
		  Self.mProfile = Profile
		  Self.mInitialPath = InitialPath
		  Self.mIdentity = Identity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DiscoverServer()
		  Dim DiscoveryRequest As New BeaconAPI.Request("ftp/discover", "GET", Self.BuildFTPParameters(Self.mInitialPath), AddressOf Callback_DiscoverServer)
		  DiscoveryRequest.Sign(Self.mIdentity)
		  BeaconAPI.Send(DiscoveryRequest)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni()
		  Dim SettingsRequest As New BeaconAPI.Request("ftp", "GET", Self.BuildFTPParameters(Self.mProfile.GameIniPath), AddressOf Callback_DownloadGameIni)
		  SettingsRequest.Sign(Self.mIdentity)
		  BeaconAPI.Send(SettingsRequest)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameUserSettingsIni()
		  Dim SettingsRequest As New BeaconAPI.Request("ftp", "GET", Self.BuildFTPParameters(Self.mProfile.GameUserSettingsIniPath), AddressOf Callback_DownloadGameUserSettingsIni)
		  SettingsRequest.Sign(Self.mIdentity)
		  BeaconAPI.Send(SettingsRequest)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As Text
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As Text
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Map() As UInt64
		  Return Self.mMap
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Beacon.ServerProfile
		  Return Self.mProfile
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
		  Return Self.mStatus
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCommandLineOptions As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitialPath As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMap As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.FTPServerProfile
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
