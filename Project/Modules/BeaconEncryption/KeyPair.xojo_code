#tag Class
Protected Class KeyPair
	#tag Method, Flags = &h0
		Sub Constructor()
		  Var PublicKey, PrivateKey As String
		  If Not Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) Then
		    Var Err As New CryptoException
		    Err.Message = "Unable to generate new key pair"
		    Raise Err
		  End If
		  Self.Constructor(PublicKey, PrivateKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(PublicKey As MemoryBlock, PrivateKey As MemoryBlock)
		  If Not (Crypto.RSAVerifyKey(PublicKey) And Crypto.RSAVerifyKey(PrivateKey)) Then
		    Var Err As New CryptoException
		    Err.Reason = "Key pair not valid"
		    Raise Err
		  End If
		  
		  Self.mPrivateKey = PrivateKey
		  Self.mPublicKey = PublicKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey(Password As MemoryBlock, PEMFormat As Boolean) As String
		  Var Key As MemoryBlock
		  If PEMFormat Then
		    Key = BeaconEncryption.PEMEncodePrivateKey(Self.mPrivateKey)
		  Else
		    Key = Self.mPrivateKey
		  End If
		  
		  Return EncodeHex(BeaconEncryption.SymmetricEncrypt(Password, Key))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey(PEMFormat As Boolean) As String
		  If PEMFormat Then
		    Return BeaconEncryption.PEMEncodePublicKey(Self.mPublicKey)
		  Else
		    Return EncodeHex(Self.mPublicKey)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sign(Data As MemoryBlock) As MemoryBlock
		  Return Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Verify(Data As MemoryBlock, Signature As MemoryBlock) As Boolean
		  Return Crypto.RSAVerifySignature(Data, Signature, Self.mPublicKey)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPrivateKey As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As MemoryBlock
	#tag EndProperty


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Class
#tag EndClass
