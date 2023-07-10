#tag Class
Protected Class ContentPack
	#tag Method, Flags = &h0
		Attributes( Deprecated = "IsConsoleSafe" )  Function ConsoleSafe() As Boolean
		  Return Self.mIsConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "IsDefaultEnabled" )  Function DefaultEnabled() As Boolean
		  Return Self.mIsDefaultEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDatabase(Row As DatabaseRow) As Ark.ContentPack
		  Try
		    Var Pack As New Ark.ContentPack
		    Pack.mContentPackId = Row.Column("content_pack_id").StringValue
		    Pack.mIsConsoleSafe = Row.Column("console_safe").BooleanValue
		    Pack.mIsDefaultEnabled = Row.Column("default_enabled").BooleanValue
		    Pack.mIsLocal = Row.Column("is_local").BooleanValue
		    Pack.mName = Row.Column("name").StringValue
		    Pack.mSteamId = NullableDouble.FromVariant(Row.Column("workshop_id").Value)
		    Pack.mLastUpdate = Row.Column("last_update").DoubleValue
		    Return Pack
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building Ark.ContentPack from DatabaseRow")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDatabase(Rows As RowSet) As Ark.ContentPack()
		  Var Packs() As Ark.ContentPack
		  For Each Row As DatabaseRow In Rows
		    Var Pack As Ark.ContentPack = Ark.ContentPack.FromDatabase(Row)
		    If (Pack Is Nil) = False Then
		      Packs.Add(Pack)
		    End If
		  Next
		  Return Packs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Ark.ContentPack
		  If SaveData Is Nil Or SaveData.KeyCount = 0 Or SaveData.HasAllKeys("contentPackId", "name", "isConsoleSafe", "isDefaultEnabled", "minVersion") = False Then
		    Return Nil
		  End If
		  
		  Try
		    If SaveData.Value("minVersion").IntegerValue > App.BuildNumber Then
		      Return Nil
		    End If
		    
		    Var Pack As New Ark.ContentPack
		    Pack.mContentPackId = SaveData.Value("contentPackId")
		    Pack.mIsConsoleSafe = SaveData.Value("isConsoleSafe")
		    Pack.mIsDefaultEnabled = SaveData.Value("isDefaultEnabled")
		    Pack.mIsLocal = True
		    Pack.mName = SaveData.Value("name")
		    Pack.mLastUpdate = SaveData.Value("lastUpdate")
		    If SaveData.HasKey("steamId") Then
		      Pack.mSteamId = NullableDouble.FromVariant(SaveData.Value("steamId"))
		    End If
		    Return Pack
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building Ark.ContentPack from Dictionary")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConsoleSafe() As Boolean
		  Return Self.mIsConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDefaultEnabled() As Boolean
		  Return Self.mIsDefaultEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLocal() As Boolean
		  Return Self.mIsLocal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.ContentPack) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Other.mContentPackId = Self.mContentPackId Then
		    Return 0
		  End If
		  
		  Var MyValue As String = Self.mName + ":" + Self.mContentPackId
		  Var OtherValue As String = Other.mName + ":" + Other.mContentPackId
		  Return MyValue.Compare(OtherValue, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("contentPackId") = Self.mContentPackId
		  If (Self.mSteamId Is Nil) = False THen
		    SaveData.Value("steamId") = Self.mSteamId.DoubleValue
		    SaveData.Value("steamUrl") = "https://steamcommunity.com/sharedfiles/filedetails/?id=" + Self.mSteamId.DoubleValue.ToString(Locale.Raw, "0")
		  End If
		  SaveData.Value("name") = Self.mName
		  SaveData.Value("isConsoleSafe") = Self.mIsConsoleSafe
		  SaveData.Value("isDefaultEnabled") = Self.mIsDefaultEnabled
		  SaveData.Value("minVersion") = 10700000
		  SaveData.Value("lastUpdate") = Self.mLastUpdate
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SteamId() As NullableDouble
		  Return Self.mSteamId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Ark.ContentPack.Types
		  If Self.mIsLocal Then
		    Return Ark.ContentPack.Types.Custom
		  ElseIf Self.mIsConsoleSafe Then
		    Return Ark.ContentPack.Types.Universal
		  Else
		    Return Ark.ContentPack.Types.Steam
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "SteamId" )  Function WorkshopId() As NullableString
		  If Self.mSteamId Is Nil Then
		    Return Nil
		  End If
		  
		  Return Self.mSteamId.DoubleValue.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsDefaultEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsLocal As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastUpdate As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSteamId As NullableDouble
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Universal
		  Steam
		Custom
	#tag EndEnum


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
