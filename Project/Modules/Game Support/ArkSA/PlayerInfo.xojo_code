#tag Class
Protected Class PlayerInfo
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Constructor(Name As String, SpecimenId As Integer)
		  Self.Constructor(Name, "", SpecimenId)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, EpicId As String, SpecimenId As Integer = 0)
		  Self.mName = Name
		  Self.mEpicId = EpicId
		  Self.mSpecimenId = SpecimenId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EpicId() As String
		  Return Self.mEpicId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Equals(Other As ArkSA.PlayerInfo) As Boolean
		  If Other Is Nil Then
		    Return False
		  End If
		  
		  If Self.mEpicId.IsEmpty = False Then
		    Return Self.mEpicId = Other.mEpicId
		  Else
		    Return Self.mSpecimenId = Other.mSpecimenId
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromPlayerFile(File As FolderItem) As ArkSA.PlayerInfo
		  Try
		    Var FileContent As MemoryBlock = File.Read
		    Return ArkSA.PlayerInfo.FromPlayerFile(FileContent)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading player file")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromPlayerFile(FileContent As MemoryBlock) As ArkSA.PlayerInfo
		  If FileContent Is Nil Or FileContent.Size <= 0 Then
		    Return Nil
		  End If
		  
		  Var Name, EpicId As String
		  Var SpecimenId As Integer
		  Var StringValue As String = FileContent
		  
		  Var SpecimenIdPos As Integer = StringValue.IndexOfBytes("PlayerDataID")
		  If SpecimenIdPos > -1 Then
		    Try
		      SpecimenId = FileContent.Int32Value(SpecimenIdPos + 41)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Var NamePos As Integer = StringValue.IndexOfBytes("PlayerName")
		  If NamePos > -1 Then
		    Try
		      Var NameLength As Integer = FileContent.Int32Value(NamePos + 36)
		      Name = FileContent.StringValue(NamePos + 40, NameLength - 1).DefineEncoding(Encodings.UTF8)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Var EpicIdPos As Integer = StringValue.IndexOfBytes("RedpointEOS")
		  If EpicIdPos > -1 Then
		    Try
		      EpicId = EncodeHex(FileContent.StringValue(EpicIdPos + 13, 16)).Lowercase
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Name.IsEmpty Or (EpicId.IsEmpty And SpecimenId = 0) Then
		    // Not enough information loaded
		    Return Nil
		  End If
		  
		  Return New ArkSA.PlayerInfo(Name, EpicId, SpecimenId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As ArkSA.PlayerInfo
		  If SaveData Is Nil Or SaveData.HasAllKeys("name", "epicId", "specimenId") = False Then
		    Return Nil
		  End If
		  
		  Try
		    Var Name As String = SaveData.Value("name")
		    Var EpicId As String = SaveData.Value("epicId")
		    Var SpecimenId As Integer = SaveData.Value("specimenId")
		    Return New ArkSA.PlayerInfo(Name, EpicId, SpecimenId)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading player info save data")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Var HashParts() As String = Array(Self.mName, Self.mEpicId, Self.mSpecimenId.ToString(Locale.Raw, "0"))
		  Return EncodeHex(Crypto.SHA1(String.FromArray(HashParts, ":"))).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.PlayerInfo) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyValue As String = Self.mName + ":" + Self.mEpicId + ":" + Self.mSpecimenId.ToString(Locale.Raw, "0")
		  Var TheirValue As String = Other.mName + ":" + Other.mEpicId + ":" + Other.mSpecimenId.ToString(Locale.Raw, "0")
		  Return MyValue.Compare(TheirValue, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Data As New Dictionary
		  Data.Value("name") = Self.mName
		  Data.Value("epicId") = Self.mEpicId
		  Data.Value("specimenId") = Self.mSpecimenId
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpecimenId() As Integer
		  Return Self.mSpecimenId
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEpicId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpecimenId As Integer
	#tag EndProperty


	#tag Constant, Name = ClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.arksa.playerinfo", Scope = Public
	#tag EndConstant


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
