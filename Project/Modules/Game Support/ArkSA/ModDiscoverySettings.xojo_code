#tag Class
Protected Class ModDiscoverySettings
	#tag Method, Flags = &h0
		Sub Constructor(ContentPackIds As Dictionary, DeleteBlueprints As Boolean, IgnoreBuiltInClasses As Boolean, Threshold As Double, UseNewDiscovery As Boolean, UploadToCommunity As Boolean)
		  Self.mContentPackIds = ContentPackIds.Clone
		  Self.mDeleteBlueprints = DeleteBlueprints
		  Self.mIgnoreBuiltInClasses = IgnoreBuiltInClasses
		  Self.mThreshold = Threshold
		  Self.mUseNewDiscovery = UseNewDiscovery And ArkSA.ModDiscoveryEngine2.IsAvailable
		  Self.mUploadToCommunity = UploadToCommunity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId(ModId As String) As String
		  Return Self.mContentPackIds.Value(ModId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteBlueprints() As Boolean
		  Return Self.mDeleteBlueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IgnoreBuiltInClasses() As Boolean
		  Return Self.mIgnoreBuiltInClasses
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModIds() As String()
		  Var ModIds() As String
		  For Each Entry As DictionaryEntry In Self.mContentPackIds
		    ModIds.Add(Entry.Key)
		  Next
		  Return ModIds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Threshold() As Double
		  Return Self.mThreshold
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UploadToCommunity() As Boolean
		  Return Self.mUploadToCommunity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseNewDiscovery() As Boolean
		  Return Self.mUseNewDiscovery
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContentPackIds As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeleteBlueprints As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIgnoreBuiltInClasses As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreshold As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadToCommunity As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseNewDiscovery As Boolean
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
