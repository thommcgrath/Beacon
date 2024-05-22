#tag Class
Protected Class BlueprintMigrator
	#tag Method, Flags = &h0
		Sub Constructor(ContentPackIds As Beacon.StringList, Pool As Beacon.DataSourcePool)
		  Self.mEnabledModIds = New Dictionary
		  For Each ModId As String In ContentPackIds
		    Self.mEnabledModIds.Value(ModId) = True
		  Next
		  
		  Self.mCache = New Dictionary
		  Self.mDataSourcePool = Pool
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(ContentPackId As String) As Boolean
		  Return Self.mEnabledModIds.Lookup(ContentPackId, False).BooleanValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CounterpartContentPack(OldContentPackId As String) As Beacon.ContentPack
		  If Self.mCache.HasKey(OldContentPackId) = False Then
		    If Self.mDataSource Is Nil Then
		      Self.mDataSource = Self.mDataSourcePool.Get(False)
		    End If
		    Self.mCache.Value(OldContentPackId) = Self.mDataSource.FindContentPackCounterpart(OldContentPackId)
		  End If
		  
		  Var NewPack As Beacon.ContentPack = Self.mCache.Value(OldContentPackId)
		  If NewPack Is Nil Or Self.ContentPackEnabled(NewPack.ContentPackId) = False Then
		    Return Nil
		  End If
		  
		  Return NewPack
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDataSource As Beacon.DataSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDataSourcePool As Beacon.DataSourcePool
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabledModIds As Dictionary
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
			Name="mEnabledModIds"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
