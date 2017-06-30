#tag Class
Protected Class WorkshopMod
	#tag Method, Flags = &h0
		Function AsDictionary() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("mod_id") = Self.mModID
		  If Self.mPullURL <> "" Then
		    Dict.Value("pull_url") = Self.mPullURL
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmationCode() As Text
		  Return Self.mConfirmationCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Confirmed() As Boolean
		  Return Self.mConfirmed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmURL() As Text
		  Return Self.mConfirmURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Xojo.Core.Dictionary)
		  Self.mConfirmationCode = Source.Value("confirmation_code")
		  Self.mConfirmed = Source.Value("confirmed")
		  Self.mConfirmURL = Source.Value("confirm_url")
		  Self.mEngramsURL = Source.Value("engrams_url")
		  Self.mModID = Source.Value("mod_id")
		  Self.mName = Source.Value("name")
		  Self.mResourceURL = Source.Value("resource_url")
		  Self.mWorkshopURL = Source.Value("workshop_url")
		  If Source.Value("pull_url") <> Nil Then
		    Self.mPullURL = Source.Value("pull_url")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsURL() As Text
		  Return Self.mEngramsURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As Text
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As BeaconAPI.WorkshopMod) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mModID.Compare(Other.mModID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourceURL() As Text
		  Return Self.mResourceURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WorkshopURL() As Text
		  Return Self.mWorkshopURL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfirmationCode As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramsURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModID As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPullURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResourceURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorkshopURL As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPullURL
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value.Trim
			  If (Value.Length > 7 And Value.Left(7) = "http://") Or (Value.Length > 8 And Value.Left(8) = "https://") Or Value.Length = 0 Then
			    Self.mPullURL = Value
			  End If
			End Set
		#tag EndSetter
		PullURL As Text
	#tag EndComputedProperty


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
			Name="PullURL"
			Group="Behavior"
			Type="Text"
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
