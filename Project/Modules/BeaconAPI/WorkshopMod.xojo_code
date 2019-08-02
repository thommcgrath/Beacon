#tag Class
Protected Class WorkshopMod
	#tag Method, Flags = &h0
		Function AsDictionary() As Dictionary
		  Dim Dict As New Dictionary
		  Dict.Value("mod_id") = Self.mModID
		  If Self.mPullURL <> "" Then
		    Dict.Value("pull_url") = Self.mPullURL
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmationCode() As String
		  Return Self.mConfirmationCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Confirmed() As Boolean
		  Return Self.mConfirmed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmURL() As String
		  Return Self.mConfirmURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
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
		Function EngramsURL() As String
		  Return Self.mEngramsURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As BeaconAPI.WorkshopMod) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mModID.Compare(Other.mModID, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourceURL() As String
		  Return Self.mResourceURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WorkshopURL() As String
		  Return Self.mWorkshopURL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfirmationCode As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramsURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPullURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResourceURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorkshopURL As String
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
		PullURL As String
	#tag EndComputedProperty


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
			Name="PullURL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
