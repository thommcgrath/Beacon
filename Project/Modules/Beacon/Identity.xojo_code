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
		  
		  #Pragma Warning "Handle KeyNotFoundException"
		  
		  Dim Signature As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Dict.Value("validation"))
		  Dim IsPatreonSupporter As Boolean = Dict.Lookup("is_patreon_supporter", False)
		  Dim PatreonUserID As Integer = If(Dict.Lookup("patreon_user_id", Nil) <> Nil, Dict.Value("patreon_user_id"), 0)
		  Dim Changed As Boolean
		  
		  If Self.mSignature <> Signature Then
		    Self.mSignature = Signature
		    Changed = True
		  End If
		  
		  If Self.mIsPatreonSupporter <> IsPatreonSupporter Then
		    Self.mIsPatreonSupporter = IsPatreonSupporter
		    Changed = True
		  End If
		  
		  If Self.mPatreonUserID <> PatreonUserID Then
		    Self.mPatreonUserID = PatreonUserID
		    Changed = True
		  End If
		  
		  Return Changed
		  
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
		  If Self.mPatreonUserID > 0 Then
		    Dict.Value("PatreonUserID") = Self.mPatreonUserID
		  End If
		  Dict.Value("IsPatreonSupporter") = Self.mIsPatreonSupporter
		  If Self.mSignature <> Nil Then
		    Dict.Value("Signature") = Beacon.EncodeHex(Self.mSignature)
		  End If
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
		  
		  If Source.HasKey("IsPatreonSupporter") Then
		    Identity.mIsPatreonSupporter = Source.Value("IsPatreonSupporter")
		  End If
		  
		  If Source.HasKey("PatreonUserID") Then
		    Identity.mPatreonUserID = Source.Value("PatreonUserID")
		  End If
		  
		  If Source.HasKey("Signature") Then
		    Identity.mSignature = Beacon.DecodeHex(Source.Value("Signature"))
		  End If
		  
		  Return Identity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPatreonSupporter() As Boolean
		  Return Self.mIsPatreonSupporter
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
		Function Sign(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Return Xojo.Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate()
		  If Self.mSignature = Nil Then
		    Self.mIsPatreonSupporter = False
		    Return
		  End If
		  
		  Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		  Dim Time As Integer = Xojo.Math.Floor(Now.SecondsFrom1970 / 604800)
		  Dim PatreonUserID As Text = If(Self.mPatreonUserID > 0, Self.mPatreonUserID.ToText(Xojo.Core.Locale.Raw), "")
		  
		  Dim PublicKey As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(BeaconAPI.PublicKey)
		  Dim CheckData As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Self.mIdentifier.Lowercase + " " + Time.ToText(Xojo.Core.Locale.Raw) + " " + PatreonUserID + " " + If(Self.mIsPatreonSupporter, "1", "0"))
		  If Not Xojo.Crypto.RSAVerifySignature(CheckData, Self.mSignature, PublicKey) Then
		    Self.mIsPatreonSupporter = False
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsPatreonSupporter As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPatreonUserID As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As Xojo.Core.MemoryBlock
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
