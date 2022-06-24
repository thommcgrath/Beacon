#tag Class
Protected Class ContentPack
	#tag Method, Flags = &h0
		Function ConsoleSafe() As Boolean
		  Return Self.mConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(UUID As String, Name As String, ConsoleSafe As Boolean, DefaultEnabled As Boolean, IsLocal As Boolean, WorkshopID As NullableString = Nil)
		  Self.mUUID = UUID
		  Self.mName = Name.Trim
		  Self.mConsoleSafe = ConsoleSafe
		  Self.mDefaultEnabled = DefaultEnabled
		  Self.mIsLocal = IsLocal
		  Self.mWorkshopID = WorkshopID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultEnabled() As Boolean
		  Return Self.mDefaultEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLocal() As Boolean
		  Return Self.mIsLocal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.ContentPack) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Other.mUUID = Self.mUUID Then
		    Return 0
		  End If
		  
		  Var MyValue As String = Self.mUUID + ":" + Self.mName
		  Var OtherValue As String = Other.mUUID + ":" + Other.mName
		  Return MyValue.Compare(OtherValue, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Ark.ContentPack.Types
		  If Self.mIsLocal Then
		    Return Ark.ContentPack.Types.Custom
		  ElseIf Self.mConsoleSafe Then
		    Return Ark.ContentPack.Types.Universal
		  Else
		    Return Ark.ContentPack.Types.Steam
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WorkshopID() As NullableString
		  Return Self.mWorkshopID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefaultEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsLocal As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorkshopID As NullableString
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Universal
		  Steam
		Custom
	#tag EndEnum


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
