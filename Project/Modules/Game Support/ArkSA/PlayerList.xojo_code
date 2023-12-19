#tag Class
Protected Class PlayerList
Implements Beacon.Countable, Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.PlayerList)
		  Self.Constructor(Source.mName, Source.mMembers, Source.mPlayerListId)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String)
		  Self.mName = Name
		  Self.mPlayerListId = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Members() As ArkSA.PlayerInfo)
		  Self.Constructor(Name, Members, Beacon.UUID.v4)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Name As String, Members() As ArkSA.PlayerInfo, PlayerListId As String)
		  Self.mName = Name
		  Self.mPlayerListId = PlayerListId
		  Self.mMembers.ResizeTo(Members.LastIndex)
		  For Idx As Integer = 0 To Members.LastIndex
		    Self.mMembers(Idx) = Members(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mMembers.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FileContent() As String
		  Var Lines() As String
		  For Each Player As ArkSA.PlayerInfo In Self.mMembers
		    If Player.EpicId.IsEmpty Then
		      Continue
		    End If
		    
		    Lines.Add(Player.EpicId)
		  Next
		  
		  Return String.FromArray(Lines, EndOfLine) + EndOfLine // Include trailing newline
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As ArkSA.PlayerList
		  If SaveData Is Nil Or SaveData.HasAllKeys("name", "playerListId", "members") = False Then
		    Return Nil
		  End If
		  
		  Try
		    Var Name As String = SaveData.Value("name")
		    Var PlayerListId As String = SaveData.Value("playerListId")
		    Var Members() As ArkSA.PlayerInfo
		    Var MemberDicts() As Dictionary = SaveData.Value("members").DictionaryArrayValue
		    For Each MemberDict As Dictionary In MemberDicts
		      Var Member As ArkSA.PlayerInfo = ArkSa.PlayerInfo.FromSaveData(MemberDict)
		      If Member Is Nil Then
		        Continue
		      End If
		      
		      Members.Add(Member)
		    Next
		    
		    Return New ArkSA.PlayerList(Name, Members, PlayerListId)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Loading player list")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Var MemberHashes() As String
		  For Each Member As ArkSA.PlayerInfo In Self.mMembers
		    MemberHashes.Add(Member.Hash)
		  Next
		  Var HashParts() As String = Array(Self.mName.Lowercase, Self.mPlayerListId.Lowercase, String.FromArray(MemberHashes, ","))
		  Return EncodeHex(Crypto.SHA1(String.FromArray(HashParts, ":"))).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As ArkSA.PlayerList
		  Return New ArkSA.PlayerList(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.PlayerList
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Player As ArkSA.PlayerInfo) As Integer
		  If Player Is Nil Then
		    Return -1
		  End If
		  
		  For Idx As Integer = 0 To Self.mMembers.LastIndex
		    If Self.mMembers(Idx).Equals(Player) Then
		      Return Idx
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Members() As Variant
		  Members.ResizeTo(Self.mMembers.LastIndex)
		  For Idx As Integer = 0 To Self.mMembers.LastIndex
		    Members(Idx) = Self.mMembers(Idx)
		  Next
		  Return New Beacon.GenericIterator(Members)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Member(AtIndex As Integer) As ArkSA.PlayerInfo
		  Return Self.mMembers(AtIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Members() As ArkSA.PlayerInfo()
		  Var Arr() As ArkSA.PlayerInfo
		  Arr.ResizeTo(Self.mMembers.LastIndex)
		  For Idx As Integer = 0 To Self.mMembers.LastIndex
		    Arr(Idx) = Self.mMembers(Idx)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As ArkSA.MutablePlayerList
		  Return New ArkSA.MutablePlayerList(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutablePlayerList
		  Return New ArkSA.MutablePlayerList(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.PlayerList) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyHash As String = Self.Hash
		  Var TheirHash As String = Other.Hash
		  If MyHash = TheirHash Then
		    Return 0
		  End If
		  
		  Var MySort As String = Self.mName + ":" + MyHash
		  Var TheirSort As String = Other.mName + ":" + TheirHash
		  Return MySort.Compare(TheirSort, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(AtIndex As Integer) As ArkSA.PlayerInfo
		  Return Self.Member(AtIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerListId() As String
		  Return Self.mPlayerListId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Members() As Dictionary
		  Members.ResizeTo(Self.mMembers.LastIndex)
		  For Idx As Integer = 0 To Self.mMembers.LastIndex
		    Members(Idx) = Self.mMembers(Idx).SaveData
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("playerListId") = Self.mPlayerListId
		  Dict.Value("name") = Self.mName
		  Dict.Value("members") = Members
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mMembers() As ArkSA.PlayerInfo
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPlayerListId As String
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
