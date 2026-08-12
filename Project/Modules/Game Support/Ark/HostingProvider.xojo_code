#tag Interface
Protected Interface HostingProvider
Implements Beacon.HostingProvider
	#tag Method, Flags = &h0
		Function CommandLineOptions(Project As Ark.Project, Profile As Ark.ServerProfile) As Dictionary
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommandLineOptions(Project As Ark.Project, Profile As Ark.ServerProfile, Assigns Options As Dictionary)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As Ark.Project, Profile As Ark.ServerProfile)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
