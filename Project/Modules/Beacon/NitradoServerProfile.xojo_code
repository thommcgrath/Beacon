#tag Class
Protected Class NitradoServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  Self.Address = Dict.Value("Address")
		  Self.ServiceID = Dict.Value("Service ID")
		  Self.ConfigPath = Dict.Value("Path")
		  Self.GameShortcode = Dict.Lookup("NitradoGameCode", "")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("Address") = Self.Address
		  Dict.Value("Service ID") = Self.ServiceID
		  Dict.Value("Path") = Self.ConfigPath
		  Dict.Value("Provider") = "Nitrado"
		  Dict.Value("NitradoGameCode") = Self.GameShortcode
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OAuthProvider() As String
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
		Function SecondaryName() As String
		  Return Self.Address
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
			  If StrComp(Self.mAddress, Value, 0) <> 0 Then
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
			  If StrComp(Self.mConfigPath, Value, 0) <> 0 Then
			    Self.mConfigPath = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ConfigPath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mShortcode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mShortcode = Value Then
			    Return
			  End If
			  
			  Self.mShortcode = Value
			  Self.Modified = True
			  
			  Select Case Value
			  Case "arkse"
			    Self.Platform = Beacon.ServerProfile.PlatformPC
			  Case "arkxb"
			    Self.Platform = Beacon.ServerProfile.PlatformXbox
			  Case "arkps"
			    Self.Platform = Beacon.ServerProfile.PlatformPlayStation
			  Case "arksw" // Complete guess
			    Self.Platform = Beacon.ServerProfile.PlatformSwitch
			  Else
			    Self.Platform = Beacon.ServerProfile.PlatformUnknown
			  End Select
			End Set
		#tag EndSetter
		GameShortcode As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceID As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShortcode As String
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
			Name="IsConsole"
			Group="Behavior"
			Type="Boolean"
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
		#tag ViewProperty
			Name="Address"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfigPath"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ServiceID"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GameShortcode"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
