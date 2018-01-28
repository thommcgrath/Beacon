#tag Class
Protected Class NitradoServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Xojo.Core.Dictionary)
		  Self.Address = Dict.Value("Address")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Xojo.Core.Dictionary)
		  Dict.Value("Address") = Self.Address
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SupportsCapability(Capability As Beacon.ServerProfile.Capabilities) As Boolean
		  Select Case Capability
		  Case Beacon.ServerProfile.Capabilities.DiscoverServer
		    Return True
		  Case Beacon.ServerProfile.Capabilities.ListSevers
		    Return True
		  Case Beacon.ServerProfile.Capabilities.RestartServer
		    Return False
		  Case Beacon.ServerProfile.Capabilities.UpdateConfig
		    Return True
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Address As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
