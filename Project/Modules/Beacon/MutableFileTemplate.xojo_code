#tag Class
Protected Class MutableFileTemplate
Inherits Beacon.FileTemplate
	#tag Method, Flags = &h0
		Sub Add(Vr As Beacon.FileTemplateVariable)
		  If Vr Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mVariables.LastIndex
		    If Self.mVariables(Idx).Name = Vr.Name Or Self.mVariables(Idx).VariableId = Vr.VariableId Then
		      If Self.mVariables(Idx).Fingerprint <> Vr.Fingerprint Then
		        Self.mVariables(Idx) = Vr.ImmutableVersion
		        Self.mModified = True
		      End If
		      Return
		    End If
		  Next
		  
		  Self.mVariables.Add(Vr.ImmutableVersion)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Body(Assigns Value As String)
		  If Self.mBody.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mBody = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.FileTemplate
		  Return New Beacon.FileTemplate(Self)
		End Function
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
		Function MutableVersion() As Beacon.MutableFileTemplate
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Vr As Beacon.FileTemplateVariable)
		  If Vr Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mVariables.LastIndex
		    If Self.mVariables(Idx).Name = Vr.Name Or Self.mVariables(Idx).VariableId = Vr.VariableId Then
		      Self.mVariables.RemoveAt(Idx)
		      Self.mModified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
		  Self.mVariables.RemoveAt(Idx)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Variables(Assigns Vars() As Beacon.FileTemplateVariable)
		  For Idx As Integer = Vars.LastIndex DownTo 0
		    If Vars(Idx) Is Nil Then
		      Vars.RemoveAt(Idx)
		    End If
		  Next
		  
		  If Self.mVariables.LastIndex <> Vars.LastIndex Then
		    Self.mVariables.ResizeTo(Vars.LastIndex)
		    Self.mModified = True
		  End If
		  
		  For Idx As Integer = 0 To Self.mVariables.LastIndex
		    If Self.mVariables(Idx).Fingerprint <> Vars(Idx).Fingerprint Then
		      Self.mVariables(Idx) = Vars(Idx).ImmutableVersion
		      Self.mModified = True
		    End If
		  Next
		End Sub
	#tag EndMethod


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
