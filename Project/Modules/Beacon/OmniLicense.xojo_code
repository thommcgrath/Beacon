#tag Class
Protected Class OmniLicense
	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
		  Var ProductID As String = Source.Value("product_id").StringValue
		  Var Flags As Integer = Source.Value("flags").IntegerValue
		  Var ExpirationString As String = Source.Lookup("expires", "").StringValue
		  
		  Self.Constructor(ProductID, Flags, ExpirationString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ProductID As String, Flags As Integer, ExpirationString As String)
		  Self.mProductID = ProductID
		  Self.mFlags = Flags
		  Self.mValidationString = ProductID.Lowercase + ":" + Flags.ToString(Locale.Raw, "0")
		  
		  If ExpirationString.IsEmpty = False Then
		    Self.mExpirationString = ExpirationString
		    Self.mValidationString = Self.mValidationString + ":" + ExpirationString
		    
		    Try
		      Self.mExpiration = NewDateFromSQLDateTime(ExpirationString)
		    Catch Err As RuntimeException
		      Self.mExpiration = DateTime.Now
		    End Try
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expiration() As DateTime
		  Return Self.mExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExpirationString() As String
		  Return Self.mExpirationString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flags() As Integer
		  Return Self.mFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsExpired() As Boolean
		  If Self.mExpiration Is Nil Then
		    Return False
		  End If
		  
		  Var Now As DateTime = DateTime.Now
		  Return Self.mExpiration.SecondsFrom1970 < Now.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLifetime() As Boolean
		  Return Self.mExpiration Is Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProductID() As String
		  Return Self.mProductID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("product_id") = Self.mProductID
		  Dict.Value("flags") = Self.mFlags
		  If (Self.mExpiration Is Nil) = False Then
		    Dict.Value("expires") = Self.mExpirationString
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidationString() As String
		  Return Self.mValidationString
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExpiration As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpirationString As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProductID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValidationString As String
	#tag EndProperty


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
