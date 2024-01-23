#tag Class
Protected Class OmniLicense
	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.OmniLicense)
		  Self.mExpiration = Source.mExpiration
		  Self.mFirstUsed = Source.mFirstUsed
		  Self.mFlags = Source.mFlags
		  Self.mLicenseId = Source.mLicenseId
		  Self.mProductId = Source.mProductId
		  Self.mMaxBuild = Source.mMaxBuild
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
		  Self.mExpiration = Source.Lookup("expires", "").StringValue
		  Self.mFirstUsed = Source.Lookup("firstUsed", "").StringValue
		  Self.mFlags = Source.Lookup("flags", 0).IntegerValue
		  Self.mLicenseId = Source.Lookup("licenseId", "").StringValue
		  Self.mProductId = Source.Lookup("productId", "").StringValue
		  Self.mMaxBuild = Source.Lookup("maxBuild", 999999999).IntegerValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expiration() As String
		  Return Self.mExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExpirationDateTime() As DateTime
		  If Self.mExpiration.IsEmpty Then
		    Return Nil
		  Else
		    Return NewDateFromSQLDateTime(Self.mExpiration)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flags() As Integer
		  Return Self.mFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBeenUsed() As Boolean
		  Return Self.mFirstUsed.IsEmpty = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsExpired() As Boolean
		  If Self.mExpiration.IsEmpty Then
		    Return False
		  End If
		  
		  Var Now As DateTime = DateTime.Now
		  Var Expires As DateTime = NewDateFromSQLDateTime(Self.mExpiration)
		  Return Expires.SecondsFrom1970 < Now.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsFlagged(Flags As Integer) As Boolean
		  Return (Self.mFlags And Flags) = Flags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLifetime() As Boolean
		  Return Self.mExpiration.IsEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValidForBuild(BuildNumber As Integer) As Boolean
		  Return Self.mMaxBuild >= BuildNumber
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValidForCurrentBuild() As Boolean
		  Return Self.IsValidForBuild(App.BuildNumber)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LicenseId() As String
		  Return Self.mLicenseId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxBuild() As Integer
		  Return Self.mMaxBuild
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProductId() As String
		  Return Self.mProductId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("licenseId") = Self.mLicenseId
		  Dict.Value("productId") = Self.mProductId
		  Dict.Value("flags") = Self.mFlags
		  If Self.mFirstUsed.IsEmpty Then
		    Dict.Value("firstUsed") = Nil
		  Else
		    Dict.Value("firstUsed") = Self.mFirstUsed
		  End If
		  If Self.mExpiration.IsEmpty Then
		    Dict.Value("expires") = Nil
		  Else
		    Dict.Value("expires") = Self.mExpiration
		  End If
		  Dict.Value("maxBuild") = Self.mMaxBuild
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExpiration As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFirstUsed As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLicenseId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxBuild As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProductId As String
	#tag EndProperty


	#tag Constant, Name = CuratorFlag, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MinimalGamesFlag, Type = Double, Dynamic = False, Default = \"16", Scope = Public
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
