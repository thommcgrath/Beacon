#tag Class
Protected Class FTPServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  If Not Dict.HasAllKeys("Host", "Port", "User", "Pass", "Game.ini Path", "GameUserSettings.ini Path") Then
		    Dim Err As KeyNotFoundException
		    Err.Message = "Missing FTPServerProfile keys"
		    Raise Err
		  End If
		  
		  Self.mHost = Dict.Value("Host")
		  Self.mPort = Dict.Value("Port")
		  Self.mUsername = Dict.Value("User")
		  Self.mPassword = Dict.Value("Pass")
		  Self.mGameIniPath = Dict.Value("Game.ini Path")
		  Self.mGameUserSettingsIniPath = Dict.Value("GameUserSettings.ini Path")
		  Self.mMode = Dict.Lookup("Mode", ModeAuto)
		  Self.mMask = Dict.Lookup("Mask", Beacon.Maps.All.Mask)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("Provider") = "FTP"
		  Dict.Value("Host") = Self.mHost
		  Dict.Value("Port") = Self.mPort
		  Dict.Value("User") = Self.mUsername
		  Dict.Value("Pass") = Self.mPassword
		  Dict.Value("Game.ini Path") = Self.mGameIniPath
		  Dict.Value("GameUserSettings.ini Path") = Self.mGameUserSettingsIniPath
		  Dict.Value("Mode") = Self.mMode
		  Dict.Value("Mask") = Self.mMask
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AsFormData() As Dictionary
		  Dim Fields As New Dictionary
		  Fields.Value("host") = Self.Host
		  Fields.Value("port") = Self.Port.ToString
		  Fields.Value("user") = Self.Username
		  Fields.Value("pass") = Self.Password
		  Fields.Value("mode") = Self.Mode
		  Return Fields
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		  Self.mMode = Self.ModeAuto
		End Sub
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
		  
		  If Not (Other IsA Beacon.FTPServerProfile) Then
		    Return Super.Operator_Compare(Other)
		  End If
		  
		  Return Self.ServerID.Compare(Beacon.FTPServerProfile(Other).ServerID, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As String
		  Return Self.Username + "@" + Self.Host + ":" + Self.Port.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerID() As String
		  Return Self.mUsername.Lowercase + "@" + Self.mHost.Lowercase + If(Self.mGameIniPath.BeginsWith("/"), "", "/") + Self.mGameIniPath
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGameIniPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGameIniPath.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mGameIniPath = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GameIniPath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGameUserSettingsIniPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGameUserSettingsIniPath.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mGameUserSettingsIniPath = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GameUserSettingsIniPath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHost
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHost.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mHost = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Host As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGameIniPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHost As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Select Case Value
			  Case Self.ModeFTP, Self.ModeFTPTLS, Self.ModeSFTP
			    // Whitelist
			  Else
			    Value = Self.ModeAuto
			  End Select
			  
			  If Self.mMode.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mMode = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Mode As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPassword.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mPassword = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mPort = 0 Then
			    Self.mPort = 21
			  End If
			  Return Self.mPort
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = 0 Then
			    Value = 21
			  End If
			  If Self.mPort <> Value Then
			    Self.mPort = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUsername
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mUsername.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mUsername = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Username As String
	#tag EndComputedProperty


	#tag Constant, Name = ModeAuto, Type = String, Dynamic = False, Default = \"auto", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeFTP, Type = String, Dynamic = False, Default = \"ftp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeFTPTLS, Type = String, Dynamic = False, Default = \"ftp+tls", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeSFTP, Type = String, Dynamic = False, Default = \"sftp", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
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
			Name="GameIniPath"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GameUserSettingsIniPath"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Host"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Password"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
			Name="Username"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
