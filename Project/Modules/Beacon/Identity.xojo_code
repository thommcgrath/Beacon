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
		Function ConsumeUserDictionary(Dict As Xojo.Core.Dictionary) As Boolean
		  Dim UserID As Text = Dict.Value("user_id")
		  If Self.mIdentifier <> UserID Then
		    Return False
		  End If
		  
		  Try
		    Self.mLoginKey = Dict.Lookup("login_key", "")
		  Catch Err As RuntimeException
		    Self.mLoginKey = ""
		  End Try
		  
		  Try
		    Self.mPurchasedOmniVersion = Dict.Lookup("omni_version", 0)
		  Catch Err As RuntimeException
		    Self.mPurchasedOmniVersion = 0
		  End Try
		  
		  Try
		    If Dict.HasKey("signatures") Then
		      Dim SignaturesDict As Xojo.Core.Dictionary = Dict.Value("signatures")
		      Self.mSignature = Beacon.DecodeHex(SignaturesDict.Lookup(Self.SignatureVersion.ToText, ""))
		    Else
		      Self.mSignature = Nil
		    End If
		  Catch Err As RuntimeException
		    Self.mSignature = Nil
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Try
		    Dim Decrypted As Xojo.Core.MemoryBlock = Xojo.Crypto.RSADecrypt(Data, Self.mPrivateKey)
		    Return Decrypted
		  Catch Err As Xojo.Crypto.CryptoException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encrypt(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Return Xojo.Crypto.RSAEncrypt(Data, Self.mPublicKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Identifier") = Self.mIdentifier
		  Dict.Value("Public") = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPublicKey)
		  Dict.Value("Private") = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPrivateKey)
		  Dict.Value("Version") = 2
		  Dict.Value("Omni Version") = Self.mPurchasedOmniVersion
		  Dict.Value("LoginKey") = Self.mLoginKey
		  If Self.mSignature <> Nil And Self.mSignature.Size > 0 Then
		    Dict.Value("Signature") = Beacon.EncodeHex(Self.mSignature)
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromUserDictionary(Dict As Xojo.Core.Dictionary, Password As Text) As Beacon.Identity
		  Try
		    Dim PrivateKey As Xojo.Core.MemoryBlock
		    
		    If Password = "" Then
		      Return Nil
		    End If
		    
		    Try
		      Dim Salt As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Dict.Value("private_key_salt"))
		      Dim Iterations As Integer = Dict.Value("private_key_iterations")
		      Dim Key As Xojo.Core.MemoryBlock = Xojo.Crypto.PBKDF2(Salt, Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Password), Iterations, 56, Xojo.Crypto.HashAlgorithms.SHA512)
		      Dim Decrypted As Xojo.Core.MemoryBlock = BeaconEncryption.BlowfishDecrypt(Key, Beacon.DecodeHex(Dict.Value("private_key")))
		      PrivateKey = BeaconEncryption.PEMDecodePrivateKey(Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Decrypted, False))
		    Catch Err As Xojo.Crypto.CryptoException
		      Return Nil
		    End Try
		    
		    Dim PublicKey As Xojo.Core.MemoryBlock = BeaconEncryption.PEMDecodePublicKey(Dict.Value("public_key"))
		    Dim UserID As Text = Dict.Value("user_id")
		    
		    Dim Identity As New Beacon.Identity(UserID, PublicKey, PrivateKey)
		    If Not Identity.ConsumeUserDictionary(Dict) Then
		      Return Nil
		    End If
		    Identity.Validate()
		    Return Identity
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
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
		  If Source.HasKey("Version") Then
		    Select Case Source.Value("Version")
		    Case 2
		      PublicKey = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Source.Value("Public"))
		      PrivateKey = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Source.Value("Private"))
		    Else
		      Return Nil
		    End Select
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
		  
		  Dim Identity As New Beacon.Identity(Source.Value("Identifier"), PublicKey, PrivateKey)
		  
		  If Source.HasKey("Omni Version") Then
		    Identity.mPurchasedOmniVersion = Source.Value("Omni Version")
		  End If
		  
		  If Source.HasKey("Signature") Then
		    Identity.mSignature = Beacon.DecodeHex(Source.Value("Signature"))
		  End If
		  
		  If Source.HasKey("LoginKey") Then
		    Identity.mLoginKey = Source.Value("LoginKey")
		  End If
		  
		  Identity.Validate()
		  
		  Return Identity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoginKey() As Text
		  Return Self.mLoginKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey() As Text
		  Return Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey() As Text
		  Return Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPublicKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PurchasedOmni() As Boolean
		  Return Self.mPurchasedOmniVersion >= Beacon.OmniVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sign(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Return Xojo.Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate()
		  If Self.mSignature <> Nil Then
		    Dim Fields(3) As Text
		    Fields(0) = Beacon.HardwareID
		    Fields(1) = Self.mIdentifier.Lowercase
		    Fields(2) = Self.mLoginKey.Lowercase
		    Fields(3) = Self.mPurchasedOmniVersion.ToText(Xojo.Core.Locale.Raw)
		    
		    Dim PublicKey As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(BeaconAPI.PublicKey)
		    Dim CheckData As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Fields.Join(" "))
		    If Xojo.Crypto.RSAVerifySignature(CheckData, Self.mSignature, PublicKey) Then
		      // It is valid, now return so the reset code below does not fire
		      Return
		    End If
		  End If
		  
		  Self.mLoginKey = ""
		  Self.mPurchasedOmniVersion = 0
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginKey As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPurchasedOmniVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As Xojo.Core.MemoryBlock
	#tag EndProperty


	#tag Constant, Name = SignatureVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


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
