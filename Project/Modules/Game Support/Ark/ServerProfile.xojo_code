#tag Class
Protected Class ServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  Self.mMask = Dict.Lookup("Map", 0)
		  
		  If Dict.HasKey("Message of the Day") Then
		    Var MOTD As Variant = Dict.Value("Message of the Day")
		    If MOTD.Type = Variant.TypeString Then
		      #if Not TargetiOS
		        Self.mMessageOfTheDay = Ark.ArkML.FromRTF(MOTD)
		      #endif
		    Else
		      Var Info As Introspection.TypeInfo = Introspection.GetType(MOTD)
		      If Info.FullName = "Dictionary()" Then
		        Self.mMessageOfTheDay = Ark.ArkML.FromArray(MOTD)
		      ElseIf Info.FullName = "Object()" Then
		        Self.mMessageOfTheDay = Ark.ArkML.FromObjects(MOTD)
		      End If
		    End If
		    Self.mMessageDuration = Dict.Lookup("Message Duration", 30).IntegerValue
		  End If
		  
		  If Self.mMessageOfTheDay Is Nil Then
		    Self.mMessageOfTheDay = New Ark.ArkML
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
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("Game") = Ark.Identifier
		  Dict.Value("Map") = Self.mMask
		  
		  If (Self.mMessageOfTheDay Is Nil) = False And Self.mMessageOfTheDay.IsEmpty = False Then
		    Dict.Value("Message of the Day") = Self.mMessageOfTheDay.ArrayValue
		    Dict.Value("Message Duration") = Self.mMessageDuration
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
		  
		  RaiseEvent WriteToDictionary(Dict)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Clone() As Ark.ServerProfile
		  Return Ark.ServerProfile(Super.Clone)
		End Function
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

	#tag Property, Flags = &h21
		Private mAdminPassword As NullableString
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mMask = CType(0, UInt64) Then
			    Return Ark.Maps.UniversalMask
			  Else
			    Return Self.mMask
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMask <> Value Then
			    Self.mMask = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Mask As UInt64
	#tag EndComputedProperty

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
		MessageOfTheDay As Ark.ArkML
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageDuration As Integer = 30
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageOfTheDay As Ark.ArkML
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Nickname"
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
		#tag ViewProperty
			Name="Mask"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
