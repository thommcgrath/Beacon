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
		    Clone.AddRow(State)
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
		    For Idx As Integer = 0 To States.LastRowIndex
		      If Self.mConfigSetStates(Idx) <> States(Idx) Then
		        Different = True
		        Exit
		      End If
		    Next
		  End If
		  
		  If Not Different Then
		    Return
		  End If
		  
		  Self.mConfigSetStates.ResizeTo(States.LastRowIndex)
		  For Idx As Integer = 0 To States.LastRowIndex
		    Self.mConfigSetStates(Idx) = States(Idx)
		  Next
		  Self.Modified = True
		End Sub
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
		  
		  If Dict.HasKey("Message of the Day") Then
		    If Dict.Value("Message of the Day").Type = Variant.TypeString Then
		      #if Not TargetiOS
		        Self.mMessageOfTheDay = Beacon.ArkML.FromRTF(Dict.Value("Message of the Day"))
		      #endif
		    Else
		      Self.mMessageOfTheDay = Beacon.ArkML.FromObjects(Dict.Value("Message of the Day"))
		    End If
		    Self.mMessageDuration = Dict.Lookup("Message Duration", 30).IntegerValue
		  End If
		  
		  If Self.mMessageOfTheDay Is Nil Then
		    Self.mMessageOfTheDay = New Beacon.ArkML
		  End If
		  
		  If Dict.HasKey("Config Sets") Then
		    Var Sets() As Variant = Dict.Value("Config Sets")
		    For Each Set As Dictionary In Sets
		      Var State As Beacon.ConfigSetState = Beacon.ConfigSetState.FromDictionary(Set)
		      If (State Is Nil) = False Then
		        Self.mConfigSetStates.AddRow(State)
		      End If
		    Next
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
		  If Self.mMask = CType(0, UInt64) Then
		    Return Beacon.Maps.All.Mask
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
		  If Self.mMessageOfTheDay.IsEmpty = False Then
		    Dict.Value("Message of the Day") = Self.mMessageOfTheDay.ArrayValue
		    Dict.Value("Message Duration") = Self.mMessageDuration
		  End If
		  If Self.mConfigSetStates.Count > 0 Then
		    Var Priorities() As Dictionary
		    For Each State As Beacon.ConfigSetState In Self.mConfigSetStates
		      Priorities.AddRow(State.ToDictionary)
		    Next
		    Dict.Value("Config Sets") = Priorities
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
		#tag ViewProperty
			Name="MessageDuration"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MessageOfTheDay"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackupFolderName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
