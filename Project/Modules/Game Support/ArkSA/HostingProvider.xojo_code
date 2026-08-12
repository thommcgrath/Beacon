#tag Interface
Protected Interface HostingProvider
Implements Beacon.HostingProvider
	#tag Method, Flags = &h0
		Function CommandLineOptions(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As Dictionary
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommandLineOptions(Project As ArkSA.Project, Profile As ArkSA.ServerProfile, Assigns Options As Dictionary)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As ArkSA.Project, Profile As ArkSA.ServerProfile)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
