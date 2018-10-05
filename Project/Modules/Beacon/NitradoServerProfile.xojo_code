#tag Class
Protected Class NitradoServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Xojo.Core.Dictionary)
		  Self.Address = Dict.Value("Address")
		  Self.ServiceID = Dict.Value("Service ID")
		  Self.ConfigPath = Dict.Value("Path")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Xojo.Core.Dictionary)
		  Dict.Value("Address") = Self.Address
		  Dict.Value("Service ID") = Self.ServiceID
		  Dict.Value("Path") = Self.ConfigPath
		  Dict.Value("Provider") = "Nitrado"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OAuthProvider() As Text
		  Return "Nitrado"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Not (Other IsA Beacon.NitradoServerProfile) Then
		    Return Super.Operator_Compare(Other)
		  End If
		  
		  Dim OtherServiceID As Integer = Beacon.NitradoServerProfile(Other).ServiceID
		  If Self.ServiceID > OtherServiceID Then
		    Return 1
		  ElseIf Self.ServiceID < OtherServiceID Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As Text
		  Return Self.Address
		End Function
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

	#tag Method, Flags = &h0
		Function SupportsRestart() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAddress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAddress.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mAddress = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Address As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mConfigPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mConfigPath.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mConfigPath = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ConfigPath As Text
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAddress As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPath As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceID As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mServiceID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mServiceID <> Value Then
			    Self.mServiceID = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ServiceID As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="mAddress"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mConfigPath"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
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
			Name="mServiceID"
			Group="Behavior"
			Type="Integer"
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
