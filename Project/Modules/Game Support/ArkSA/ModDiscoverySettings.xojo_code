#tag Class
Protected Class ModDiscoverySettings
	#tag Method, Flags = &h0
		Function ArkFolder() As FolderItem
		  Return New FolderItem(Self.mArkFolder)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ArkFolder As FolderItem, ModIds() As String, DeleteBlueprints As Boolean)
		  Self.mArkFolder = New FolderItem(ArkFolder)
		  Self.mModIds = ModIds
		  Self.mDeleteBlueprints = DeleteBlueprints
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteBlueprints() As Boolean
		  #Pragma StackOverflowChecking False
		  Return Self.mDeleteBlueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModIds() As String()
		  Var ModIds() As String
		  ModIds.ResizeTo(Self.mModIds.LastIndex)
		  For Idx As Integer = 0 To ModIds.LastIndex
		    ModIds(Idx) = Self.mModIds(Idx)
		  Next
		  Return ModIds
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mArkFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeleteBlueprints As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModIds() As String
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
