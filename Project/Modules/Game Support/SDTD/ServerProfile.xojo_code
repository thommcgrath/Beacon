#tag Class
Protected Class ServerProfile
Inherits Beacon.ServerProfile
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary, Version As Integer)
		  Self.mDescription = Dict.Value("description")
		  Self.mMap = Dict.Value("map")
		  Self.mMapSeed = Dict.Lookup("mapSeed", "")
		  Self.mMapSize = Dict.Lookup("mapSize", 6144)
		  Self.mPassword = NullableString.FromVariant(Dict.Lookup("password", Nil))
		  Self.mPort = NullableDouble.FromVariant(Dict.Lookup("port", Nil))
		  Self.mTelnetPort = NullableDouble.FromVariant(Dict.Lookup("telnetPort", Nil))
		  Self.mPaths = Dict.Value("paths")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("description") = Self.mDescription
		  Dict.Value("map") = Self.mMap
		  If Self.mMap = "RWG" Then
		    Dict.Value("mapSeed") = Self.mMapSeed
		    Dict.Value("mapSize") = Self.mMapSize
		  End If
		  If (Self.mPassword Is Nil) = False Then
		    Dict.Value("password") = Self.mPassword.StringValue
		  End If
		  If (Self.mPort Is Nil) = False Then
		    Dict.Value("port") = Self.mPort.IntegerValue
		  End If
		  If (Self.mTelnetPort Is Nil) = False Then
		    Dict.Value("telnetPort") = Self.mTelnetPort.IntegerValue
		  End If
		  Dict.Value("paths") = Self.mPaths
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
		  Self.mPaths = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As String, Name As String)
		  // Making the constructor public
		  Self.Constructor()
		  Super.Constructor(Provider, Name)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As String, ProfileId As String, Name As String, Nickname As String, SecondaryName As String)
		  // Making the constructor public
		  Self.Constructor()
		  Super.Constructor(Provider, ProfileId, Name, Nickname, SecondaryName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Filenames() As String()
		  Var Names() As String
		  For Each Entry As DictionaryEntry In Self.mPaths
		    Names.Add(Entry.Key.StringValue)
		  Next
		  Names.Sort
		  Return Names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return SDTD.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path(Filename As String) As String
		  Return Self.mPaths.Lookup(Filename, "").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Filename As String, Assigns Value As String)
		  If Self.Path(Filename).Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) = 0 Then
		    Return
		  End If
		  
		  Self.mPaths.Value(Filename) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Platform(Assigns Value As Integer)
		  Super.Platform = Value
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Attributes( Deprecated ) Event ReadFromDictionary(Dict As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Attributes( Deprecated ) Event UpdateDetailsFrom(Profile As SDTD.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Attributes( Deprecated ) Event WriteToDictionary(Dict As Dictionary)
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
		Private mPaths As Dictionary
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
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Map"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MapSeed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
