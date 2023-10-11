#tag Interface
Protected Interface HostingProvider
	#tag Method, Flags = &h0
		Sub CreateCheckpoint(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Name As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameSetting(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameSetting(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting, Assigns Value As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Logger As Beacon.LogProducer, Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchProviderToken(Token As BeaconAPI.ProviderToken) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketStatus() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartServer(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, StopMessage As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsGameSettings() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStopMessage() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UploadFile(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
