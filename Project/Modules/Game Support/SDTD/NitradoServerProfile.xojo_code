#tag Class
Protected Class NitradoServerProfile
Inherits SDTD.ServerProfile
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  Self.mAddress = Dict.Value("Address")
		  Self.mConfigPath = Dict.Value("Path")
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateDetailsFrom(Profile As Beacon.ServerProfile)
		  If Not (Profile IsA SDTD.NitradoServerProfile) Then
		    Return
		  End If
		  
		  Var NitradoProfile As SDTD.NitradoServerProfile = SDTD.NitradoServerProfile(Profile)
		  Self.Address = NitradoProfile.Address
		  Self.ConfigPath = NitradoProfile.ConfigPath
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("Address") = Self.mAddress
		  Dict.Value("Path") = Self.mConfigPath
		  Dict.Value("Provider") = "Nitrado"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAddress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAddress.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mAddress = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Address As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mConfigPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mConfigPath.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mConfigPath = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ConfigPath As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPath As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.ProviderServiceID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.ProviderServiceID = Value
			End Set
		#tag EndSetter
		ServiceID As Integer
	#tag EndComputedProperty


End Class
#tag EndClass
