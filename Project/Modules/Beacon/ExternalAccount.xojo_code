#tag Class
Protected Class ExternalAccount
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function AccessToken() As String
		  Return Self.mAccessToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("UUID") = Self.mUUID.StringValue
		  Dict.Value("Provider") = Self.mProvider
		  Dict.Value("AccessToken") = Self.mAccessToken
		  Dict.Value("RefreshToken") = Self.mRefreshToken
		  Dict.Value("Expires") = If(IsNull(Self.mExpiration), 0, Self.mExpiration.SecondsFrom1970)
		  Dict.Value("Label") = Self.mLabel
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As String)
		  // Used as a placeholder for authorization tracking
		  Self.Constructor(New v4UUID, "", Provider, "", "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(AccountUUID As v4UUID, Provider As String)
		  // Used as a placeholder for authorization tracking
		  Self.Constructor(AccountUUID, "", Provider, "", "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(AccountUUID As v4UUID, Label As String, Provider As String, AccessToken As String, RefreshToken As String, Expiration As DateTime)
		  If AccountUUID = Nil Then
		    AccountUUID = New v4UUID
		  End If
		  
		  Self.mUUID = AccountUUID
		  Self.mLabel = Label
		  Self.mProvider = Provider
		  Self.mAccessToken = AccessToken
		  Self.mRefreshToken = RefreshToken
		  Self.mExpiration = Expiration
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(AccountUUID As v4UUID, Label As String, Provider As String, AccessToken As String, RefreshToken As String, Expiration As Double)
		  Var Expires As New DateTime(Expiration, New TimeZone(0))
		  Self.Constructor(AccountUUID, Label, Provider, AccessToken, RefreshToken, Expires)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expiration() As DateTime
		  Return Self.mExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.ExternalAccount
		  If Not Dict.HasAllKeys("UUID", "Provider", "AccessToken", "RefreshToken", "Expires") Then
		    Return Nil
		  End If
		  
		  Try
		    Var UUID As String = Dict.Value("UUID").StringValue
		    Var Provider As String = Dict.Value("Provider").StringValue
		    Var AccessToken As String = Dict.Value("AccessToken").StringValue
		    Var RefreshToken As String = Dict.Value("RefreshToken").StringValue
		    Var Expiration As Double = Dict.Value("Expires").DoubleValue
		    Var Label As String
		    If Dict.HasKey("Label") Then
		      Label = Dict.Value("Label").StringValue
		    End If
		    Return New Beacon.ExternalAccount(UUID, Label, Provider, AccessToken, RefreshToken, Expiration)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsExpired() As Boolean
		  If Self.mExpiration = Nil Then
		    Return True
		  End If
		  
		  Var Now As DateTime = DateTime.Now
		  Return Self.mExpiration.SecondsFrom1970 <= Now.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ExternalAccount) As Integer
		  If IsNull(Other) Then
		    Return 1
		  End If
		  
		  Var SelfString As String = EncodeHex(Crypto.MD5(Beacon.GenerateJSON(Self.AsDictionary, False)))
		  Var OtherString As String = EncodeHex(Crypto.MD5(Beacon.GenerateJSON(Other.AsDictionary, False)))
		  Return SelfString.Compare(OtherString, ComparisonOptions.CaseInsensitive, Locale.Raw)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Provider() As String
		  Return Self.mProvider
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RefreshToken() As String
		  Return Self.mRefreshToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As v4UUID
		  Return Self.mUUID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccessToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpiration As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProvider As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As v4UUID
	#tag EndProperty


	#tag Constant, Name = ProviderGameServerApp, Type = String, Dynamic = False, Default = \"GameServerApp.com", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProviderNitrado, Type = String, Dynamic = False, Default = \"Nitrado", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
