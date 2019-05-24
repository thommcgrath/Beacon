#tag Class
Protected Class KeyPair
	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim PublicKey, PrivateKey As Xojo.Core.MemoryBlock
		  If Not Xojo.Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) Then
		    Dim Err As New Xojo.Crypto.CryptoException
		    Err.Reason = "Unable to generate new key pair"
		    Raise Err
		  End If
		  Self.Constructor(PublicKey, PrivateKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(PublicKey As Xojo.Core.MemoryBlock, PrivateKey As Xojo.Core.MemoryBlock)
		  If Not (Xojo.Crypto.RSAVerifyKey(PublicKey) And Xojo.Crypto.RSAVerifyKey(PrivateKey)) Then
		    Dim Err As New Xojo.Crypto.CryptoException
		    Err.Reason = "Key pair not valid"
		    Raise Err
		  End If
		  
		  Self.mPrivateKey = PrivateKey
		  Self.mPublicKey = PublicKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey(Password As Xojo.Core.MemoryBlock, PEMFormat As Boolean) As Text
		  Dim Key As Xojo.Core.MemoryBlock
		  If PEMFormat Then
		    Key = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(BeaconEncryption.PEMEncodePrivateKey(Self.mPrivateKey))
		  Else
		    Key = Self.mPrivateKey
		  End If
		  
		  Return Beacon.EncodeHex(BeaconEncryption.SymmetricEncrypt(Password, Key))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey(PEMFormat As Boolean) As Text
		  If PEMFormat Then
		    Return BeaconEncryption.PEMEncodePublicKey(Self.mPublicKey)
		  Else
		    Return Beacon.EncodeHex(Self.mPublicKey)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sign(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Return Xojo.Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Verify(Data As Xojo.Core.MemoryBlock, Signature As Xojo.Core.MemoryBlock) As Boolean
		  Return Xojo.Crypto.RSAVerifySignature(Data, Signature, Self.mPublicKey)
		End Function
	#tag EndMethod


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
