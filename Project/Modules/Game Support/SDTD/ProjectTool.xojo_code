#tag Class
Protected Class ProjectTool
	#tag Method, Flags = &h0
		Function Caption() As String
		  Return Self.mCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Caption As String, ToolId As String, RelevantGroups() As String)
		  Self.mCaption = Caption
		  Self.mToolId = ToolId
		  
		  Self.mGroups.ResizeTo(RelevantGroups.LastIndex)
		  For Idx As Integer = 0 To Self.mGroups.LastIndex
		    Self.mGroups(Idx) = RelevantGroups(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Caption As String, ToolId As String, ParamArray RelevantGroups() As String)
		  Self.Constructor(Caption, ToolId, RelevantGroups)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FirstGroup() As String
		  Return Self.mGroups(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRelevantForGroup(Group As SDTD.ConfigGroup) As Boolean
		  If Group Is Nil Then
		    Return False
		  End If
		  
		  Return Self.IsRelevantForGroup(Group.InternalName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRelevantForGroup(GroupName As String) As Boolean
		  Return Self.mGroups.IndexOf(GroupName) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As SDTD.ProjectTool) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mToolId = Other.mToolId Then
		    Return 0
		  End If
		  
		  Return Self.mCaption.Compare(Other.mCaption, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToolId() As String
		  Return Self.mToolId
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGroups() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToolId As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
