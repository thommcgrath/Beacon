#tag Class
Protected Class Subscription
	#tag Method, Flags = &h0
		Sub Constructor(Source As JSONItem)
		  Self.mSubscriptionId = Source.Lookup("subscriptionId", "").StringValue
		  Self.mProductId = Source.Lookup("productId", "").StringValue
		  Self.mProductName = Source.Lookup("productName", "").StringValue
		  Self.mProductGameId = Source.Lookup("productGameId", "").StringValue
		  Self.mProductFlags = Source.Lookup("productFlags", 0).IntegerValue
		  Self.mCreation = Source.Lookup("created", 0).DoubleValue
		  Self.mExpiration = Source.Lookup("expiration", 0).DoubleValue
		  Self.mUnitsUsed = Source.Lookup("unitsUsed", 0).IntegerValue
		  Self.mUnitsAllowed = Source.Lookup("unitsAllowed", 0).IntegerValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creation() As Double
		  Return Self.mCreation
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expiration() As Double
		  Return Self.mExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasFlags(Flags As Integer) As Boolean
		  Return (Self.mProductFlags And Flags) = Flags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProductFlags() As Integer
		  Return Self.mProductFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProductGameId() As String
		  Return Self.mProductGameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProductId() As String
		  Return Self.mProductId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProductName() As String
		  Return Self.mProductName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemainingUnits() As Integer
		  Return Self.mUnitsAllowed - Self.mUnitsUsed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubscriptionId() As String
		  Return Self.mSubscriptionId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnitsAllowed() As Integer
		  Return Self.mUnitsAllowed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnitsUsed() As Integer
		  Return Self.mUnitsUsed
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCreation As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpiration As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProductFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProductGameId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProductId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProductName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubscriptionId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUnitsAllowed As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUnitsUsed As Integer
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
		#tag ViewProperty
			Name="mSubscriptionId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
