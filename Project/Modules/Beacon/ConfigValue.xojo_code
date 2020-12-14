#tag Class
Protected Class ConfigValue
	#tag Method, Flags = &h0
		Sub Constructor(Key As Beacon.ConfigKey, AttributedKey As String, Value As String, OverrideCommand As String = "")
		  Self.mKeyDetails = Key
		  Self.mFile = Key.File
		  Self.mHeader = Key.Header
		  Self.mAttributedKey = AttributedKey
		  Self.mSimplifiedKey = Key.SimplifiedKey
		  Self.mValue = Value
		  Self.mHash = Key.Hash
		  
		  If OverrideCommand.IsEmpty Then
		    Self.mCommand = AttributedKey + "=" + Value
		  Else
		    Self.mCommand = OverrideCommand
		  End If
		  
		  Var SortKey As String
		  Var Pos As Integer = AttributedKey.IndexOf("[")
		  If Pos > -1 Then
		    Var EndPos As Integer = AttributedKey.IndexOf(Pos + 1, "]")
		    Var AttributeStringValue As String = AttributedKey.Middle(Pos + 1, EndPos - (Pos + 1))
		    Var AttributeValue As Integer
		    Try
		      AttributeValue = Double.FromString(AttributeStringValue, Locale.Raw)
		      SortKey = AttributedKey.Left(Pos) + ":" + AttributeValue.ToString(Locale.Raw, "000000.000000")
		    Catch Err As RuntimeException
		      SortKey = AttributedKey.Left(Pos) + ":" + AttributeStringValue
		    End Try
		  Else
		    SortKey = AttributedKey
		  End If
		  
		  Self.mSortValue = Key.File.Lowercase + ":" + Key.Header.Lowercase + ":" + SortKey.Lowercase + ":" + Value.Lowercase
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Header As String, AttributedKey As String, Value As String, OverrideCommand As String = "")
		  Var SimplifiedKey As String = Self.SimplifyKey(AttributedKey)
		  
		  Var Keys() As Beacon.ConfigKey = Beacon.Data.SearchForConfigKey(File, Header, SimplifiedKey)
		  Var ConfigKey As Beacon.ConfigKey
		  If Keys.Count >= 1 Then
		    ConfigKey = Keys(0)
		  Else
		    ConfigKey = New Beacon.ConfigKey(File, Header, SimplifiedKey)
		  End If
		  
		  Self.Constructor(ConfigKey, AttributedKey, Value, OverrideCommand)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SimplifyKey(Key As String) As String
		  Var Idx As Integer = Key.IndexOf("[")
		  If Idx = -1 Then
		    Return Key
		  Else
		    Return Key.Left(Idx)
		  End If
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAttributedKey
			End Get
		#tag EndGetter
		AttributedKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCommand
			End Get
		#tag EndGetter
		Command As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKeyDetails
			End Get
		#tag EndGetter
		Details As Beacon.ConfigKey
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFile
			End Get
		#tag EndGetter
		File As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHash
			End Get
		#tag EndGetter
		Hash As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHeader
			End Get
		#tag EndGetter
		Header As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAttributedKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommand As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFile As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeader As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyDetails As Beacon.ConfigKey
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSimplifiedKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSortValue As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSimplifiedKey
			End Get
		#tag EndGetter
		SimplifiedKey As String
	#tag EndComputedProperty

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
			  Return Self.mSortValue
			End Get
		#tag EndGetter
		SortValue As String
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
			Name="Header"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SimplifiedKey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Command"
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
			Name="SingleInstance"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hash"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AttributedKey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
