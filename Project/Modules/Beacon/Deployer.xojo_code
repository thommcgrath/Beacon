#tag Interface
Protected Interface Deployer
	#tag Method, Flags = &h0
		Sub Begin(CommandLineOptions() As Beacon.ConfigValue, GameIniDict As Xojo.Core.Dictionary, GameUserSettingsIniDict As Xojo.Core.Dictionary)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerIsStarting() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Text
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
