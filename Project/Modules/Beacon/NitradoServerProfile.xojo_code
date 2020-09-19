#tag Class
Protected Class NitradoServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  Self.Address = Dict.Value("Address")
		  Self.ServiceID = Dict.Value("Service ID")
		  Self.ConfigPath = Dict.Value("Path")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
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
		Function DeployCapable() As Boolean
		  Return True
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
		  
		  Var OtherServiceID As Integer = Beacon.NitradoServerProfile(Other).ServiceID
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
		Sub Platform(Assigns Value As UInteger)
		  Super.Platform = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As String
		  Return Self.Address
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCustomStopMessage() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestart() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateDetailsFrom(Profile As Beacon.ServerProfile)
		  Super.UpdateDetailsFrom(Profile)
		  
		  If Not (Profile IsA Beacon.NitradoServerProfile) Then
		    Return
		  End If
		  
		  Var NitradoProfile As Beacon.NitradoServerProfile = Beacon.NitradoServerProfile(Profile)
		  Self.Address = NitradoProfile.Address
		  Self.ConfigPath = NitradoProfile.ConfigPath
		  Self.Mask = NitradoProfile.Mask
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
			Name="BackupFolderName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="IsConsole"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Address"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfigPath"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ServiceID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
