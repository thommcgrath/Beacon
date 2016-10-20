#tag Class
Protected Class Identity
	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim PrivateKey, PublicKey As Xojo.Core.MemoryBlock
		  If Xojo.Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) = False Or Xojo.Crypto.RSAVerifyKey(PrivateKey) = False Or Xojo.Crypto.RSAVerifyKey(PublicKey) = False Then
		    Raise New Xojo.Crypto.CryptoException
		  End If
		  
		  // Keys are already hex encoded, despite being MemoryBlock objects. Brilliant.
		  
		  Self.mIdentifier = Beacon.CreateUUID
		  Self.mPrivateKey = PrivateKey
		  Self.mPublicKey = PublicKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Identifier As Text, PublicKey As Xojo.Core.MemoryBlock, PrivateKey As Xojo.Core.MemoryBlock)
		  Self.mIdentifier = Identifier
		  Self.mPublicKey = PublicKey
		  Self.mPrivateKey = PrivateKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Identifier") = Self.mIdentifier
		  Dict.Value("Public") = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPublicKey)
		  Dict.Value("Private") = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPrivateKey)
		  Dict.Value("Version") = 2
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As Text
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Source As Xojo.Core.Dictionary) As Beacon.Identity
		  If Source.HasKey("Identifier") = False Or Source.HasKey("Public") = False Or Source.HasKey("Private") = False Then
		    Return Nil
		  End If
		  
		  Dim PublicKey, PrivateKey As Xojo.Core.MemoryBlock
		  If Source.HasKey("Version") And Source.Value("Version") = 2 Then
		    PublicKey = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Source.Value("Public"))
		    PrivateKey = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Source.Value("Private"))
		  Else
		    PublicKey = Beacon.DecodeHex(Source.Value("Public"))
		    PrivateKey = Beacon.DecodeHex(Source.Value("Private"))
		  End If
		  
		  If Not Xojo.Crypto.RSAVerifyKey(PublicKey) Then
		    Return Nil
		  End If
		  
		  If Not Xojo.Crypto.RSAVerifyKey(PrivateKey) Then
		    Return Nil
		  End If
		  
		  Return New Beacon.Identity(Source.Value("Identifier"), PublicKey, PrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey() As Text
		  Return Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPublicKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sign(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Return Xojo.Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As Xojo.Core.MemoryBlock
	#tag EndProperty


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Class
#tag EndClass
