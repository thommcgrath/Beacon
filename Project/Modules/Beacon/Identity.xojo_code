#tag Class
Protected Class Identity
	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim PrivateKey, PublicKey As Xojo.Core.MemoryBlock
		  If Xojo.Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) = False Or Xojo.Crypto.RSAVerifyKey(PrivateKey) = False Or Xojo.Crypto.RSAVerifyKey(PublicKey) = False Then
		    Raise New Xojo.Crypto.CryptoException
		  End If
		  
		  Self.mIdentifier = Beacon.CreateUUID
		  Self.mPrivateKey = PrivateKey
		  Self.mPublicKey = PublicKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Identifier") = Self.mIdentifier
		  Dict.Value("Public") = Beacon.EncodeHex(Self.mPublicKey)
		  Dict.Value("Private") = Beacon.EncodeHex(Self.mPrivateKey)
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
		  
		  Dim PublicKey As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Source.Value("Public"))
		  If Not Xojo.Crypto.RSAVerifyKey(PublicKey) Then
		    Return Nil
		  End If
		  
		  Dim PrivateKey As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Source.Value("Private"))
		  If Not Xojo.Crypto.RSAVerifyKey(PrivateKey) Then
		    Return Nil
		  End If
		  
		  Dim Iden As New Beacon.Identity
		  Iden.mIdentifier = Source.Value("Identifier")
		  Iden.mPublicKey = PublicKey
		  Iden.mPrivateKey = PrivateKey
		  Return Iden
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey() As xojo.Core.MemoryBlock
		  Return Self.mPublicKey
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
			Name="mIdentifier"
			Group="Behavior"
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
