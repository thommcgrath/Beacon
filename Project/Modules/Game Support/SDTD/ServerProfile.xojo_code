#tag Class
Protected Class ServerProfile
Inherits Beacon.ServerProfile
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  Self.mDescription = Dict.Value("Description")
		  Self.mMap = Dict.Value("Map")
		  Self.mMapSeed = Dict.Lookup("Map Seed", "")
		  Self.mMapSize = Dict.Lookup("Map Size", 6144)
		  Self.mPassword = NullableString.FromVariant(Dict.Lookup("Password", Nil))
		  Self.mPort = NullableDouble.FromVariant(Dict.Lookup("Port", Nil))
		  Self.mTelnetPort = NullableDouble.FromVariant(Dict.Lookup("Telnet Port", Nil))
		  
		  RaiseEvent ReadFromDictionary(Dict)
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateDetailsFrom(Profile As Beacon.ServerProfile)
		  If (Profile IsA SDTD.ServerProfile) = False Then
		    Return
		  End If
		  
		  // Use the public accessors to update the modified status correctly
		  Var Casted As SDTD.ServerProfile = SDTD.ServerProfile(Profile)
		  Self.Description = Casted.Description
		  Self.Map = Casted.Map
		  Self.MapSeed = Casted.MapSeed
		  Self.MapSize = Casted.MapSize
		  Self.Password = Casted.Password
		  Self.Port = Casted.Port
		  Self.TelnetPort = Casted.TelnetPort
		  
		  RaiseEvent UpdateDetailsFrom(Casted)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("Game") = SDTD.Identifier
		  
		  Dict.Value("Description") = Self.mDescription
		  Dict.Value("Map") = Self.mMap
		  If Self.mMap = "RWG" Then
		    Dict.Value("Map Seed") = Self.mMapSeed
		    Dict.Value("Map Size") = Self.mMapSize
		  End If
		  If (Self.mPassword Is Nil) = False Then
		    Dict.Value("Password") = Self.mPassword.StringValue
		  End If
		  If (Self.mPort Is Nil) = False Then
		    Dict.Value("Port") = Self.mPort.IntegerValue
		  End If
		  If (Self.mTelnetPort Is Nil) = False Then
		    Dict.Value("Telnet Port") = Self.mTelnetPort.IntegerValue
		  End If
		  
		  RaiseEvent WriteToDictionary(Dict)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Clone() As SDTD.ServerProfile
		  Return SDTD.ServerProfile(Super.Clone)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mMap = "Navezgane"
		  Self.mMapSeed = Beacon.GenerateRandomKey()
		  Self.mMapSize = 6144
		  Self.mPassword = Nil
		  Self.mPort = 26900
		  Self.mTelnetPort = 8081
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DefaultName() As String
		  Return "An Unnamed " + FullName + " Server"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Platform(Assigns Value As Integer)
		  Super.Platform = Value
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadFromDictionary(Dict As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateDetailsFrom(Profile As SDTD.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteToDictionary(Dict As Dictionary)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDescription
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDescription.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mDescription = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Description As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMap
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMap = Value Then
			    Return
			  End If
			  
			  Self.mMap = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Map As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMapSeed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMapSeed.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mMapSeed = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MapSeed As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMapSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMapSize = Value Then
			    Return
			  End If
			  
			  Self.mMapSize = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MapSize As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMap As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapSeed As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTelnetPort As NullableDouble
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If (Self.mPassword Is Nil And Value Is Nil) Or ((Self.mPassword Is Nil) = False And (Value Is Nil) = False And Self.mPassword.StringValue.Compare(Value.StringValue, ComparisonOptions.CaseSensitive) = 0) Then
			    Return
			  End If
			  
			  Self.mPassword = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Password As NullableString
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPort
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If (Self.mPort Is Nil And Value Is Nil) Or ((Self.mPort Is Nil) = False And (Value Is Nil) = False And Self.mPort.IntegerValue = Value.IntegerValue) Then
			    Return
			  End If
			  
			  Self.mPort = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Port As NullableDouble
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTelnetPort
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If (Self.mTelnetPort Is Nil And Value Is Nil) Or ((Self.mTelnetPort Is Nil) = False And (Value Is Nil) = False And Self.mTelnetPort.IntegerValue = Value.IntegerValue) Then
			    Return
			  End If
			  
			  Self.mTelnetPort = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		TelnetPort As NullableDouble
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ExternalAccountId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Modified"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsConsole"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackupFolderName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AdminNotes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProfileColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Beacon.ServerProfile.Colors"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Blue"
				"2 - Brown"
				"3 - Grey"
				"4 - Green"
				"5 - Indigo"
				"6 - Orange"
				"7 - Pink"
				"8 - Purple"
				"9 - Red"
				"10 - Teal"
				"11 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Nickname"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProviderTokenId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Map"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MapSeed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MapSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
