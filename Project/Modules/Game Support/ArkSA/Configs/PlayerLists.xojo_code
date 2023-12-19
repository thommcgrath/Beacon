#tag Class
Protected Class PlayerLists
Inherits ArkSA.ConfigGroup
	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("lists") = False Then
		    Return
		  End If
		  
		  Var Lists() As Dictionary = SaveData.Value("lists").DictionaryArrayValue
		  Self.mLists.ResizeTo(-1)
		  
		  For Each ListData As Dictionary In Lists
		    Var List As ArkSA.PlayerList = ArkSA.PlayerList.FromSaveData(ListData)
		    If List Is Nil Then
		      Continue
		    End If
		    Self.mLists.Add(List)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Var Lists() As Dictionary
		  For Each List As ArkSA.PlayerList In Self.mLists
		    Var ListData As Dictionary = List.SaveData
		    If ListData Is Nil Then
		      Continue
		    End If
		    Lists.Add(ListData)
		  Next
		  
		  SaveData.Value("lists") = Lists
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(List As ArkSA.PlayerList)
		  If List Is Nil Then
		    Return
		  End If
		  
		  // See if this list is already added
		  Var ListIdx As Integer = -1
		  For Idx As Integer = 0 To Self.mLists.LastIndex
		    If Self.mLists(Idx).PlayerListId = List.PlayerListId Then
		      ListIdx = Idx
		      Exit
		    End If
		  Next
		  If ListIdx > -1 And Self.mLists(ListIdx) = List Then
		    // Already added and identical
		    Return
		  End If
		  
		  // Make sure the name does not conflict with another item
		  For Idx As Integer = 0 To Self.mLists.LastIndex
		    If Self.mLists(Idx).Name = List.Name And Idx <> ListIdx Then
		      Var Err As New UnsupportedOperationException
		      Err.Message = "Name already in use"
		      Raise Err
		    End If
		  Next
		  
		  If ListIdx > -1 Then
		    Self.mLists(ListIdx) = List.ImmutableVersion
		  Else
		    Self.mLists.Add(List.ImmutableVersion)
		  End If
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.Configs.PlayerLists
		  #Pragma Unused ParsedData
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused ContentPacks
		  
		  // There's nothing to be collected from the ini files
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NamePlayerLists
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListNamed(ListName As String) As ArkSA.PlayerList
		  For Each List As ArkSA.PlayerList In Self.mLists
		    If List.Name = ListName Then
		      Return List
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListNames() As String()
		  Var Names() As String
		  For Each List As ArkSA.PlayerList In Self.mLists
		    Names.Add(List.Name)
		  Next
		  Names.SortWith(Self.mLists)
		  Return Names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lists() As ArkSA.PlayerList()
		  Var Arr() As ArkSA.PlayerList
		  Arr.ResizeTo(Self.mLists.LastIndex)
		  For Idx As Integer = 0 To Self.mLists.LastIndex
		    Arr(Idx) = Self.mLists(Idx)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(List As ArkSA.PlayerList)
		  If List Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = Self.mLists.LastIndex DownTo 0
		    If Self.mLists(Idx).PlayerListId = List.PlayerListId Then
		      Self.mLists.RemoveAt(Idx)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsConfigSets() As Boolean
		  Return False
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLists() As ArkSA.PlayerList
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
