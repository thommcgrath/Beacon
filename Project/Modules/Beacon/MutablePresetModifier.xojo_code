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


End Class
#tag EndClass
