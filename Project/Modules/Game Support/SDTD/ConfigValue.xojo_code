#tag Class
Protected Class ConfigValue
	#tag Method, Flags = &h0
		Sub Constructor(Key As SDTD.ConfigOption, Value As String, SortKey As String = "")
		  If SortKey.IsEmpty Then
		    SortKey = Key.Key
		  End If
		  
		  Self.mValue = Value
		  Self.mSortKey = SortKey
		  Self.mKeyDetails = Key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Key As String, Value As String, SortKey As String = "")
		  Var Keys() As SDTD.ConfigOption = SDTD.DataSource.Pool.Get(False).GetConfigOptions(File, Key)
		  Var Option as SDTD.ConfigOption
		  If Keys.Count >= 1 Then
		    Option = Keys(0)
		  Else
		    Option = New SDTD.ConfigOption(File, Key)
		  End If
		  
		  Self.Constructor(Option, Value, SortKey)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKeyDetails
			End Get
		#tag EndGetter
		Details As SDTD.ConfigOption
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKeyDetails.File
			End Get
		#tag EndGetter
		File As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKeyDetails.Key
			End Get
		#tag EndGetter
		Key As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCommand As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyDetails As SDTD.ConfigOption
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSortKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mKeyDetails Is Nil Then
			    Return False
			  Else
			    Return (Self.mKeyDetails.MaxAllowed Is Nil) = False And Self.mKeyDetails.MaxAllowed.DoubleValue = 1
			  End If
			End Get
		#tag EndGetter
		SingleInstance As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSortKey
			End Get
		#tag EndGetter
		SortKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mValue
			End Get
		#tag EndGetter
		Value As String
	#tag EndComputedProperty


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
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="File"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SortKey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SingleInstance"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
