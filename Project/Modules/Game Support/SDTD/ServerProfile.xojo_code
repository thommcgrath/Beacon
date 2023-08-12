#tag Class
Protected Class ServerProfile
Inherits Beacon.ServerProfile
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Function Clone() As SDTD.ServerProfile
		  Return SDTD.ServerProfile(Super.Clone)
		End Function
	#tag EndMethod


End Class
#tag EndClass
