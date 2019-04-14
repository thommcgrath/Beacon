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
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AsFormData() As Dictionary
		  Dim Fields As New Dictionary
		  Fields.Value("host") = Self.Host
		  Fields.Value("port") = Str(Self.Port, "0")
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
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Not (Other IsA Beacon.FTPServerProfile) Then
		    Return Super.Operator_Compare(Other)
		  End If
		  
		  Return StrComp(Self.ServerID, Beacon.FTPServerProfile(Other).ServerID, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As String
		  Return Self.Username + "@" + Self.Host + ":" + Str(Self.Port, "-0")
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
			  If StrComp(Self.mGameIniPath, Value, 0) <> 0 Then
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
			  If StrComp(Self.mGameUserSettingsIniPath, Value, 0) <> 0 Then
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
			  If StrComp(Self.mHost, Value, 0) <> 0 Then
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
			  
			  If StrComp(Self.mMode, Value, 0) = 0 Then
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
			  If StrComp(Self.mPassword, Value, 0) <> 0 Then
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
			  If StrComp(Self.mUsername, Value, 0) <> 0 Then
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
			Name="GameIniPath"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GameUserSettingsIniPath"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Host"
			Group="Behavior"
			Type="Text"
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
			Name="Password"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
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
			Name="Username"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
