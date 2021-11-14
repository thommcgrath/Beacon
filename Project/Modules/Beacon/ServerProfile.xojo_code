#tag Class
Protected Class ServerProfile
	#tag Method, Flags = &h0
		Function Clone() As Beacon.ServerProfile
		  Return Beacon.ServerProfile.FromDictionary(Self.ToDictionary())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates() As Beacon.ConfigSetState()
		  // Make sure to return a clone of the array. Do not need to clone the members since they are immutable.
		  Var Clone() As Beacon.ConfigSetState
		  For Each State As Beacon.ConfigSetState In Self.mConfigSetStates
		    Clone.Add(State)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConfigSetStates(Assigns States() As Beacon.ConfigSetState)
		  // First decide if the States() array is different from the mConfigSetStates() array. Then, 
		  // update mConfigSetStates() to match. Do not need to clone the members since they are immutable.
		  
		  Var Different As Boolean
		  If Self.mConfigSetStates.Count <> States.Count Then
		    Different = True
		  Else
		    For Idx As Integer = 0 To States.LastIndex
		      If Self.mConfigSetStates(Idx) <> States(Idx) Then
		        Different = True
		        Exit
		      End If
		    Next
		  End If
		  
		  If Not Different Then
		    Return
		  End If
		  
		  Self.mConfigSetStates.ResizeTo(States.LastIndex)
		  For Idx As Integer = 0 To States.LastIndex
		    Self.mConfigSetStates(Idx) = States(Idx)
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates(ForDocument As Beacon.Document) As Beacon.ConfigSetState()
		  // Make sure to return a clone of the array. Do not need to clone the members since they are immutable.
		  Var States(0) As Beacon.ConfigSetState
		  States(0) = New Beacon.ConfigSetState(Beacon.Document.BaseConfigSetName, True)
		  
		  Var Names() As String = ForDocument.ConfigSetNames
		  Var Filter As New Dictionary
		  For Each Name As String In Names
		    If Name = Beacon.Document.BaseConfigSetName Then
		      Continue
		    End If
		    
		    Filter.Value(Name) = True
		  Next
		  
		  For Each State As Beacon.ConfigSetState In Self.mConfigSetStates
		    If Filter.HasKey(State.Name) = False Then
		      Continue
		    End If
		    
		    States.Add(State)
		    
		    Filter.Remove(State.Name)
		  Next
		  
		  For Each Entry As DictionaryEntry In Filter
		    States.Add(New Beacon.ConfigSetState(Entry.Key, False))
		  Next
		  
		  Return States
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Var Err As New UnsupportedOperationException
		  Err.Message = "Do not instantiate this class, only its subclasses."
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Dict As Dictionary)
		  If Not Dict.HasAllKeys("Name", "Profile ID", "Enabled") Then
		    Var Err As New KeyNotFoundException
		    Err.Message = "Incomplete server profile"
		    Raise Err
		  End If
		  
		  Self.Name = Dict.Value("Name")
		  Self.Enabled = Dict.Value("Enabled")
		  Self.mProfileID = Dict.Value("Profile ID")
		  Self.mPlatform = Dict.Lookup("Platform", Self.PlatformUnknown)
		  Self.mMask = Dict.Lookup("Map", 0)
		  Self.mAdminNotes = Dict.Lookup("Admin Notes", "")
		  Self.mProfileColor = CType(Dict.Lookup("Color", 0).IntegerValue, Beacon.ServerProfile.Colors)
		  
		  If Dict.HasKey("External Account") Then
		    Self.mExternalAccountUUID = Dict.Value("External Account").StringValue
		  End If
		  
		  If Dict.HasKey("Message of the Day") Then
		    Var MOTD As Variant = Dict.Value("Message of the Day")
		    If MOTD.Type = Variant.TypeString Then
		      #if Not TargetiOS
		        Self.mMessageOfTheDay = Beacon.ArkML.FromRTF(MOTD)
		      #endif
		    Else
		      Var Info As Introspection.TypeInfo = Introspection.GetType(MOTD)
		      If Info.FullName = "Dictionary()" Then
		        Self.mMessageOfTheDay = Beacon.ArkML.FromArray(MOTD)
		      ElseIf Info.FullName = "Object()" Then
		        Self.mMessageOfTheDay = Beacon.ArkML.FromObjects(MOTD)
		      End If
		    End If
		    Self.mMessageDuration = Dict.Lookup("Message Duration", 30).IntegerValue
		  End If
		  
		  If Self.mMessageOfTheDay Is Nil Then
		    Self.mMessageOfTheDay = New Beacon.ArkML
		  End If
		  
		  If Dict.HasKey("Config Sets") Then
		    Var Sets() As Dictionary
		    Try
		      Sets = Dict.Value("Config Sets").DictionaryArrayValue
		    Catch Err As RuntimeException
		    End Try
		    For Each Set As Dictionary In Sets
		      Var State As Beacon.ConfigSetState = Beacon.ConfigSetState.FromDictionary(Set)
		      If (State Is Nil) = False Then
		        Self.mConfigSetStates.Add(State)
		      End If
		    Next
		  End If
		  
		  If Dict.HasKey("Admin Password") Then
		    Self.mAdminPassword = Dict.Value("Admin Password").StringValue
		  End If
		  
		  If Dict.HasKey("Server Password") Then
		    Self.mServerPassword = Dict.Value("Server Password").StringValue
		  End If
		  
		  If Dict.HasKey("Spectator Password") Then
		    Self.mSpectatorPassword = Dict.Value("Spectator Password").StringValue
		  End If
		  
		  RaiseEvent ReadFromDictionary(Dict)
		  
		  Self.Modified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeployCapable() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.ServerProfile
		  // This isn't a great design because the factory needs to know about all its subclasses, but
		  // there aren't better alternatives. Xojo's dead code stripping prevents a lookup from working.
		  
		  If Not Dict.HasAllKeys("Name", "Provider", "Profile ID") Then
		    Return Nil
		  End If
		  
		  Var Provider As String = Dict.Value("Provider")
		  Select Case Provider
		  Case "Nitrado"
		    Return New Beacon.NitradoServerProfile(Dict)
		  Case "FTP"
		    Return New Beacon.FTPServerProfile(Dict)
		  Case "Connector"
		    Return New Beacon.ConnectorServerProfile(Dict)
		  Case "Local", "Simple"
		    Return New Beacon.LocalServerProfile(Dict)
		  Case "GameServerApp"
		    Return New Beacon.GSAServerProfile(Dict)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Var Raw As String
		  Try
		    Raw = Beacon.GenerateJSON(Self.ToDictionary, False)
		  Catch Err As RuntimeException
		    Raw = Self.Name + "    " + Self.ProfileID
		  End Try
		  Return EncodeHex(Crypto.SHA256(Raw)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LinkPrefix() As String
		  Return "Server"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask() As UInt64
		  If Self.mMask = CType(0, UInt64) Then
		    Return Beacon.Maps.UniversalMask
		  Else
		    Return Self.mMask
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Mask(Assigns Value As UInt64)
		  If Self.mMask <> Value Then
		    Self.mMask = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyHash As String = Self.Hash
		  Var TheirHash As String = Other.Hash
		  
		  If MyHash = TheirHash Then
		    Return 0
		  Else
		    // Don't just compare names. We know these are not equal, but we need them to be sortable.
		    Var SelfCompare As String = Self.Name + "    " + MyHash
		    Var OtherCompare As String = Other.Name + "    " + TheirHash
		    Return SelfCompare.Compare(OtherCompare, ComparisonOptions.CaseInsensitive)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Platform() As UInteger
		  Return Self.mPlatform
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Platform(Assigns Value As UInteger)
		  If Self.mPlatform <> Value Then
		    Self.mPlatform = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProfileID() As String
		  If Self.mProfileID = "" Then
		    Self.mProfileID = New v4UUID
		  End If
		  Return Self.mProfileID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCustomStopMessage() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestart() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  RaiseEvent WriteToDictionary(Dict)
		  If Not Dict.HasKey("Provider") Then
		    Var Err As New KeyNotFoundException
		    Err.Message = "No provider was set in Beacon.ServerProfile.WriteToDictionary"
		    Raise Err
		  End If
		  Dict.Value("Name") = Self.Name
		  Dict.Value("Profile ID") = Self.ProfileID // Do not call mProfileID here in order to force generation
		  Dict.Value("Enabled") = Self.Enabled
		  Dict.Value("Platform") = Self.mPlatform
		  Dict.Value("Map") = Self.mMask
		  Dict.Value("Admin Notes") = Self.mAdminNotes
		  Dict.Value("Color") = CType(Self.mProfileColor, Integer)
		  If Self.mExternalAccountUUID <> Nil Then
		    Dict.Value("External Account") = Self.mExternalAccountUUID.StringValue
		  End If
		  If (Self.mMessageOfTheDay Is Nil) = False And Self.mMessageOfTheDay.IsEmpty = False Then
		    Dict.Value("Message of the Day") = Self.mMessageOfTheDay.ArrayValue
		    Dict.Value("Message Duration") = Self.mMessageDuration
		  End If
		  If Self.mConfigSetStates.Count > 0 Then
		    Var Priorities() As Dictionary
		    For Each State As Beacon.ConfigSetState In Self.mConfigSetStates
		      Priorities.Add(State.ToDictionary)
		    Next
		    Dict.Value("Config Sets") = Priorities
		  End If
		  If (Self.mAdminPassword Is Nil) = False Then
		    Dict.Value("Admin Password") = Self.mAdminPassword.StringValue
		  End If
		  If (Self.mServerPassword Is Nil) = False Then
		    Dict.Value("Server Password") = Self.mServerPassword.StringValue
		  End If
		  If (Self.mSpectatorPassword Is Nil) = False Then
		    Dict.Value("Spectator Password") = Self.mSpectatorPassword.StringValue
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateDetailsFrom(Profile As Beacon.ServerProfile)
		  // Doesn't normally do anything
		  
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadFromDictionary(Dict As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteToDictionary(Dict As Dictionary)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAdminNotes
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value.Encoding Is Nil Then
			    Value = Value.GuessEncoding
			  ElseIf Value.Encoding <> Encodings.UTF8 Then
			    Value = Value.ConvertEncoding(Encodings.UTF8)
			  End If
			  Value = Value.Trim
			  If Self.mAdminNotes.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mAdminNotes = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AdminNotes As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAdminPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAdminPassword <> Value Then
			    Self.mAdminPassword = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AdminPassword As NullableString
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Beacon.SanitizeFilename(Self.Name, 60)
			End Get
		#tag EndGetter
		BackupFolderName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEnabled <> Value Then
			    Self.mEnabled = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Enabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mExternalAccountUUID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mExternalAccountUUID <> Value Then
			    Self.mExternalAccountUUID = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ExternalAccountUUID As v4UUID
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlatform = CType(Beacon.ServerProfile.PlatformXbox, UInteger) Or Self.mPlatform = CType(Beacon.ServerProfile.PlatformPlayStation, UInteger) Or Self.mPlatform = CType(Beacon.ServerProfile.PlatformSwitch, UInteger)
			End Get
		#tag EndGetter
		IsConsole As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAdminNotes As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAdminPassword As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetStates() As Beacon.ConfigSetState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMessageDuration
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMessageDuration <> Value Then
			    Self.mMessageDuration = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		MessageDuration As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMessageOfTheDay
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMessageOfTheDay <> Value Then
			    Self.mMessageOfTheDay = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		MessageOfTheDay As Beacon.ArkML
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mExternalAccountUUID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageDuration As Integer = 30
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageOfTheDay As Beacon.ArkML
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Modified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlatform As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileColor As Beacon.ServerProfile.Colors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerPassword As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpectatorPassword As NullableString
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mName.IsEmpty = False Then
			    Return Self.mName.Trim
			  ElseIf Self.SecondaryName.IsEmpty = False Then
			    Return Self.SecondaryName.Trim
			  Else
			    Return "An Unnamed ARK Server"
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value.Trim
			  
			  If Self.mName.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mName = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProfileColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProfileColor <> Value Then
			    Self.mProfileColor = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ProfileColor As Beacon.ServerProfile.Colors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mServerPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mServerPassword <> Value Then
			    Self.mServerPassword = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ServerPassword As NullableString
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSpectatorPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSpectatorPassword <> Value Then
			    Self.mSpectatorPassword = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		SpectatorPassword As NullableString
	#tag EndComputedProperty


	#tag Constant, Name = PlatformPC, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformPlayStation, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformSwitch, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformUnknown, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformXbox, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Colors, Type = Integer, Flags = &h0
		None
		  Blue
		  Brown
		  Grey
		  Green
		  Indigo
		  Orange
		  Pink
		  Purple
		  Red
		  Teal
		Yellow
	#tag EndEnum


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
			Name="MessageDuration"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
	#tag EndViewBehavior
End Class
#tag EndClass
