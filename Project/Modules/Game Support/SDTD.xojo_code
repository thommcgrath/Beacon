#tag Module
Protected Module SDTD
	#tag Method, Flags = &h1
		Protected Function OmniPurchased(Identity As Beacon.Identity) As Boolean
		  Return (Identity Is Nil) = False And Identity.IsOmniFlagged(SDTD.OmniFlag)
		End Function
	#tag EndMethod


	#tag Constant, Name = FullName, Type = String, Dynamic = False, Default = \"7 Days to Die", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"7DaysToDie", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniFlag, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackId, Type = String, Dynamic = False, Default = \"51740154-f9eb-49d3-aaab-1f5acdfbb31e", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackName, Type = String, Dynamic = False, Default = \"User Content", Scope = Protected
	#tag EndConstant


End Module
#tag EndModule
