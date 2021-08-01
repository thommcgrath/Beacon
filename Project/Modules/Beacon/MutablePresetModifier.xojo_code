#tag Class
Protected Class MutablePresetModifier
Inherits Beacon.PresetModifier
	#tag Method, Flags = &h0
		Sub AdvancedPattern(Assigns Value As String)
		  If Self.mAdvancedPattern.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mAdvancedPattern = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  If Self.mLabel.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mLabel = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pattern(Assigns Value As String)
		  If Self.mPattern.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mPattern = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
