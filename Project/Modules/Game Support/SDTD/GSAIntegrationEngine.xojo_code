#tag Class
Protected Class GSAIntegrationEngine
Inherits SDTD.IntegrationEngine
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  // Simply changing the scope of the constructor
		  Super.Constructor(Profile)
		End Sub
	#tag EndMethod


End Class
#tag EndClass
