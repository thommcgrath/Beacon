#tag Class
Protected Class FTPProfile
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.FTPProfile)
		  Self.Constructor()
		  
		  If Source <> Nil Then
		    Self.Host = Source.Host
		    Self.Port = Source.Port
		    Self.Username = Source.Username
		    Self.Password = Source.Password
		    Self.Path = Source.Path
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As Text
		  Dim Output As Text = Self.Username + "@" + Self.Host
		  If Self.Port <> 21 Then
		    Output = Output + ":" + Self.Port.ToText
		  End If
		  Return Output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity) As Beacon.FTPProfile
		  If Not Dict.HasAllKeys("Host", "Port", "User", "Pass", "Path") Then
		    Return Nil
		  End If
		  
		  Dim Pass As Xojo.Core.MemoryBlock = Identity.Decrypt(Beacon.DecodeHex(Dict.Value("Pass")))
		  If Pass = Nil Then
		    Return Nil
		  End If
		  
		  Dim Profile As New Beacon.FTPProfile
		  Profile.Host = Dict.Value("Host")
		  Profile.Port = Dict.Value("Port")
		  Profile.Username = Dict.Value("User")
		  Profile.Password = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Pass)
		  Profile.Path = Dict.Value("Path")
		  Return Profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As Text
		  Return Beacon.EncodeHex(Xojo.Crypto.MD5(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Self.QueryString)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.FTPProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.Hash = Other.Hash Then
		    Return 0
		  End If
		  
		  Return Self.Description.Compare(Other.Description)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QueryString() As Text
		  Dim Pieces() As Text
		  Pieces.Append("host=" + Beacon.EncodeURLComponent(Self.Host))
		  Pieces.Append("port=" + Self.Port.ToText)
		  Pieces.Append("user=" + Beacon.EncodeURLComponent(Self.Username))
		  Pieces.Append("pass=" + Beacon.EncodeURLComponent(Self.Password))
		  Pieces.Append("path=" + Beacon.EncodeURLComponent(Self.Path))
		  Return Text.Join(Pieces, "&")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary(Identity As Beacon.Identity) As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Host") = Self.Host
		  Dict.Value("Port") = Self.Port
		  Dict.Value("User") = Self.Username
		  Dict.Value("Pass") = Beacon.EncodeHex(Identity.Encrypt(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Self.Password)))
		  Dict.Value("Path") = Self.Path
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Host As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Password As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Path As Text
	#tag EndProperty

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
			  Self.mPort = Value
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Username As Text
	#tag EndProperty


	#tag ViewBehavior
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
			Name="Path"
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
	#tag EndViewBehavior
End Class
#tag EndClass
