#tag Class
Protected Class GSAServerProfile
Inherits SDTD.ServerProfile
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		  Self.Platform = Beacon.ServerProfile.PlatformPC
		End Sub
	#tag EndMethod


End Class
#tag EndClass
