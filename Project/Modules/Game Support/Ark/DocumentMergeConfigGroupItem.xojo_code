#tag Class
Protected Class DocumentMergeConfigGroupItem
Inherits Beacon.DocumentMergeItem
	#tag Method, Flags = &h0
		Sub Constructor(Group As Ark.ConfigGroup, SourceProject As Ark.Project, SourceConfigSet As Beacon.ConfigSet)
		  Self.Group = Group
		  Self.Label = Language.LabelForConfig(Group)
		  Self.SourceProject = SourceProject
		  Self.SourceConfigSet = SourceConfigSet
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return Self.Group.IsDefaultImported
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OrganizationKey() As String
		  Return Self.DestinationConfigSet.ConfigSetId + ":" + Self.Group.InternalName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SourceKey() As String
		  Return Self.SourceProject.UUID + ":" + If((Self.SourceConfigSet Is Nil) = False, Self.SourceConfigSet.ConfigSetId, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return Self.Group.SupportsMerging
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		DestinationConfigSet As Beacon.ConfigSet
	#tag EndProperty

	#tag Property, Flags = &h0
		Group As Ark.ConfigGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceConfigSet As Beacon.ConfigSet
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceProject As Ark.Project
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
