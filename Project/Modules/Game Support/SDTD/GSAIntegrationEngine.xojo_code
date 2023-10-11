#tag Class
Protected Class GSAIntegrationEngine
Inherits SDTD.IntegrationEngine
	#tag CompatibilityFlags = false
	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  // Simply changing the scope of the constructor
		  Super.Constructor(Nil, Profile)
		End Sub
	#tag EndMethod


End Class
#tag EndClass
