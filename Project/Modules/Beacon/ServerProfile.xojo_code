#tag Class
Protected Class ServerProfile
	#tag Method, Flags = &h0
		Function Clone() As Beacon.ServerProfile
		  Return Beacon.ServerProfile.FromDictionary(Self.ToDictionary())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Var Err As New UnsupportedOperationException
		  Err.Reason = "Do not instantiate this class, only its subclasses."
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Dict As Dictionary)
		  If Not Dict.HasAllKeys("Name", "Profile ID", "Enabled") Then
		    Var Err As New KeyNotFoundException
		    Err.Reason = "Incomplete server profile"
		    Raise Err
		  End If
		  
		  Self.Name = Dict.Value("Name")
		  Self.Enabled = Dict.Value("Enabled")
		  Self.mProfileID = Dict.Value("Profile ID")
		  Self.mPlatform = Dict.Lookup("Platform", Self.PlatformUnknown)
		  Self.mMask = Dict.Lookup("Map", 0)
		  
		  If Dict.HasKey("External Account") Then
		    Self.mExternalAccountUUID = Dict.Value("External Account").StringValue
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
		  Case "Local"
		    Return New Beacon.LocalServerProfile(Dict)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LinkPrefix() As String
		  Return "Server"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask() As UInt64
		  Return Self.mMask
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
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Other.ProfileID = Self.ProfileID Then
		    Return 0
		  Else
		    Return Self.Name.Compare(Other.Name, ComparisonOptions.CaseSensitive)
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
		    Err.Reason = "No provider was set in Beacon.ServerProfile.WriteToDictionary"
		    Raise Err
		  End If
		  Dict.Value("Name") = Self.Name
		  Dict.Value("Profile ID") = Self.ProfileID // Do not call mProfileID here in order to force generation
		  Dict.Value("Enabled") = Self.Enabled
		  Dict.Value("Platform") = Self.mPlatform
		  Dict.Value("Map") = Self.mMask
		  If Self.mExternalAccountUUID <> Nil Then
		    Dict.Value("External Account") = Self.mExternalAccountUUID.StringValue
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
			  Return Self.mPlatform = Beacon.ServerProfile.PlatformXbox Or Self.mPlatform = Beacon.ServerProfile.PlatformPlayStation Or Self.mPlatform = Beacon.ServerProfile.PlatformSwitch
			End Get
		#tag EndGetter
		IsConsole As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExternalAccountUUID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
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
		Private mProfileID As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mName <> "" Then
			    Return Self.mName
			  Else
			    Return Self.SecondaryName
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mName.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mName = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Name As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
