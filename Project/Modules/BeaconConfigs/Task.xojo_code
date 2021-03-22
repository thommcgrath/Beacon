#tag Class
Protected Class Task
	#tag Method, Flags = &h0
		Function Caption() As String
		  Return Self.mCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Caption As String, UUID As String, RelevantEditors() As String)
		  Self.mCaption = Caption
		  Self.mUUID = UUID
		  
		  Self.mEditors.ResizeTo(RelevantEditors.LastIndex)
		  For Idx As Integer = 0 To Self.mEditors.LastIndex
		    Self.mEditors(Idx) = RelevantEditors(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Caption As String, UUID As String, ParamArray RelevantEditors() As String)
		  Self.Constructor(Caption, UUID, RelevantEditors)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FirstEditor() As String
		  Return Self.mEditors(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRelevantForEditor(Group As Beacon.ConfigGroup) As Boolean
		  If Group Is Nil Then
		    Return False
		  End If
		  
		  Return Self.IsRelevantForEditor(Group.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRelevantForEditor(GroupName As String) As Boolean
		  Return Self.mEditors.IndexOf(GroupName) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As BeaconConfigs.Task) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mUUID = Other.mUUID Then
		    Return 0
		  End If
		  
		  Return Self.mCaption.Compare(Other.mCaption, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditors() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As String
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
			Name="mCaption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
