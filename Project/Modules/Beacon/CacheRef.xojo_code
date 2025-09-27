#tag Class
Protected Class CacheRef
	#tag Method, Flags = &h0
		Sub Constructor(Ref As Variant, TimeToLive As Double)
		  Self.mTimeToLive = TimeToLive
		  Self.mRef = Ref
		  Self.Renew()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expired() As Boolean
		  Return DateTime.Now.SecondsFrom1970 > Self.mExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Renew()
		  Self.mExpiration = DateTime.Now.SecondsFrom1970 + Self.mTimeToLive
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  Return Self.mRef
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExpiration As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRef As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimeToLive As Double
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
		#tag ViewProperty
			Name="mExpiration"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
