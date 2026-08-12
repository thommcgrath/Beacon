#tag Module
Protected Module BeaconHostingAPI
	#tag Method, Flags = &h1
		Protected Sub Init()
		  mBaseUrlLock = New CriticalSection
		  mBaseUrls = New Dictionary
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseUrlLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBaseUrls As Dictionary
	#tag EndProperty


	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"BeaconHostingAPI", Scope = Protected
	#tag EndConstant


End Module
#tag EndModule
