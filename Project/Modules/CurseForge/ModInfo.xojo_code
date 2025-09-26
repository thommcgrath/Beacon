#tag Class
Protected Class ModInfo
	#tag Method, Flags = &h0
		Sub Constructor(Source As FolderItem)
		  Var Parsed As New JSONItem(Source.Read(Encodings.UTF8))
		  Self.Constructor(Parsed)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As JSONItem)
		  Self.mSource = Source
		  Self.mGameId = Source.Value("gameId")
		  Self.mLastUpdateString = Source.Value("dateReleased")
		  Self.mModId = Source.Value("id")
		  Self.mModName = Source.Value("name")
		  Self.mSlug = Source.Value("slug")
		  Self.mMainFileId = Source.Value("mainFileId")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As Integer
		  Return Self.mGameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsArkSA() As Boolean
		  Return Self.mGameId = 83374
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdateString() As String
		  Return Self.mLastUpdateString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainFileId() As Integer
		  Return Self.mMainFileId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModId() As Integer
		  Return Self.mModId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  Return Self.mModName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Slug() As String
		  Return Self.mSlug
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(Pretty As Boolean) As String
		  Return Self.mSource.ToString(Not Pretty)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mGameId As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastUpdateString As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainFileId As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModId As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSlug As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As JSONItem
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
