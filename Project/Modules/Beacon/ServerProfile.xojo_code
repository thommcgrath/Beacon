#tag Class
Protected Class ServerProfile
	#tag Method, Flags = &h0
		Function Clone() As Beacon.ServerProfile
		  Return Beacon.ServerProfile.FromDictionary(Self.ToDictionary())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Dim Err As New UnsupportedOperationException
		  Err.Reason = "Do not instantiate this class, only its subclasses."
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Dict As Xojo.Core.Dictionary)
		  If Not Dict.HasAllKeys("Name", "Profile ID", "Enabled") Then
		    Dim Err As New KeyNotFoundException
		    Err.Reason = "Incomplete server profile"
		    Raise Err
		  End If
		  
		  Self.Name = Dict.Value("Name")
		  Self.Enabled = Dict.Value("Enabled")
		  Self.mProfileID = Dict.Value("Profile ID")
		  Self.mPlatform = Dict.Lookup("Platform", Self.PlatformUnknown)
		  
		  RaiseEvent ReadFromDictionary(Dict)
		  
		  Self.Modified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Xojo.Core.Dictionary) As Beacon.ServerProfile
		  // This isn't a great design because the factory needs to know about all its subclasses, but
		  // there aren't better alternatives. Xojo's dead code stripping prevents a lookup from working.
		  
		  If Not Dict.HasAllKeys("Name", "Provider", "Profile ID") Then
		    Return Nil
		  End If
		  
		  Dim Provider As Text = Dict.Value("Provider")
		  Select Case Provider
		  Case "Nitrado"
		    Return New Beacon.NitradoServerProfile(Dict)
		  Case "FTP"
		    Return New Beacon.FTPServerProfile(Dict)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OAuthProvider() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Other.ProfileID = Self.ProfileID Then
		    Return 0
		  Else
		    Return Self.Name.Compare(Other.Name)
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
		Function ProfileID() As Text
		  If Self.mProfileID = "" Then
		    Self.mProfileID = Beacon.CreateUUID
		  End If
		  Return Self.mProfileID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestart() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  RaiseEvent WriteToDictionary(Dict)
		  If Not Dict.HasKey("Provider") Then
		    Dim Err As New KeyNotFoundException
		    Err.Reason = "No provider was set in Beacon.ServerProfile.WriteToDictionary"
		    Raise Err
		  End If
		  Dict.Value("Name") = Self.Name
		  Dict.Value("Profile ID") = Self.ProfileID // Do not call mProfileID here in order to force generation
		  Dict.Value("Enabled") = Self.Enabled
		  Dict.Value("Platform") = Self.mPlatform
		  Return Dict
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadFromDictionary(Dict As Xojo.Core.Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteToDictionary(Dict As Xojo.Core.Dictionary)
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
			  Return Self.mPlatform = Beacon.ServerProfile.PlatformXbox Or Self.mPlatform = Beacon.ServerProfile.PlatformPlayStation Or Self.mPlatform = Beacon.ServerProfile.PlatformSwitch
			End Get
		#tag EndGetter
		IsConsole As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Modified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlatform As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileID As Text
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
			  If Self.mName.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mName = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Name As Text
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
			Type="String"
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
		#tag ViewProperty
			Name="Enabled"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Modified"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
