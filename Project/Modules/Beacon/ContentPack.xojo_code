#tag Class
Protected Class ContentPack
	#tag Method, Flags = &h0
		Function ConfirmationCode() As String
		  Return Self.mConfirmationCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ContentPack)
		  Self.mContentPackId = Source.mContentPackId
		  Self.mGameId = Source.mGameId
		  Self.mType = Source.mType
		  Self.mIsConsoleSafe = Source.mIsConsoleSafe
		  Self.mIsDefaultEnabled = Source.mIsDefaultEnabled
		  Self.mLastUpdate = Source.mLastUpdate
		  Self.mMarketplace = Source.mMarketplace
		  Self.mMarketplaceId = Source.mMarketplaceId
		  Self.mName = Source.mName
		  Self.mRequired = Source.mRequired
		  Self.mIsConfirmed = Source.mIsConfirmed
		  Self.mConfirmationCode = Source.mConfirmationCode
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GameId As String, Name As String, ContentPackId As String = "")
		  If ContentPackId.IsEmpty Then
		    ContentPackId = Beacon.UUID.v4
		  End If
		  
		  Self.mGameId = GameId
		  Self.mContentPackId = ContentPackId
		  Self.mIsConsoleSafe = False
		  Self.mIsDefaultEnabled = False
		  Self.mType = Self.TypeLocal
		  Self.mLastUpdate = DateTime.Now.SecondsFrom1970
		  Self.mName = Name
		  Self.mRequired = False
		  Self.mIsConfirmed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateUserContentPack(GameId As String, Name As String, ContentPackId As String) As Beacon.ContentPack
		  Var Pack As New Beacon.ContentPack(GameId, Name, ContentPackId)
		  Pack.mIsConsoleSafe = True
		  Pack.mLastUpdate = DateTime.Now.SecondsFrom1970
		  Pack.mIsDefaultEnabled = True
		  Pack.mType = Beacon.ContentPack.TypeLocal
		  Pack.mRequired = False
		  Return Pack
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDatabase(Row As DatabaseRow) As Beacon.ContentPack
		  Try
		    Var Pack As New Beacon.ContentPack
		    Pack.mContentPackId = Row.Column("content_pack_id").StringValue
		    Pack.mGameId = Row.Column("game_id").StringValue
		    Pack.mType = Row.Column("type").IntegerValue
		    Pack.mIsConsoleSafe = Row.Column("console_safe").BooleanValue
		    Pack.mIsDefaultEnabled = Row.Column("default_enabled").BooleanValue
		    Pack.mName = Row.Column("name").StringValue
		    If Row.Column("marketplace").Value.IsNull = False And Row.Column("marketplace_id").Value.IsNull = False Then
		      Pack.mMarketplace = Row.Column("marketplace").StringValue
		      Pack.mMarketplaceId = Row.Column("marketplace_id").StringValue
		    End If
		    Pack.mLastUpdate = Row.Column("last_update").DoubleValue
		    Pack.mRequired = Row.Column("required").BooleanValue
		    Pack.mIsConfirmed = True
		    Return Pack
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building Beacon.ContentPack from DatabaseRow")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDatabase(Rows As RowSet) As Beacon.ContentPack()
		  Var Packs() As Beacon.ContentPack
		  For Each Row As DatabaseRow In Rows
		    Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Row)
		    If (Pack Is Nil) = False Then
		      Packs.Add(Pack)
		    End If
		  Next
		  Return Packs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.ContentPack
		  Var Json As New JSONItem(SaveData)
		  Return FromSaveData(Json)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As JSONItem) As Beacon.ContentPack
		  If SaveData Is Nil Or SaveData.HasAllKeys("contentPackId", "gameId", "name", "isConsoleSafe", "isDefaultEnabled", "minVersion") = False Then
		    Return Nil
		  End If
		  
		  Try
		    If SaveData.Value("minVersion").IntegerValue > App.BuildNumber Then
		      Return Nil
		    End If
		    
		    Var Pack As New Beacon.ContentPack
		    Pack.mContentPackId = SaveData.Value("contentPackId")
		    Pack.mGameId = SaveData.Value("gameId")
		    If SaveData.HasKey("type") Then
		      Pack.mType = SaveData.Value("type")
		    ElseIf SaveData.HasKey("isOfficial") Then
		      If SaveData.Value("isOfficial").BooleanValue Then
		        Pack.mType = Beacon.ContentPack.TypeOfficial
		      Else
		        Pack.mType = Beacon.ContentPack.TypeThirdParty
		      End If
		    Else
		      Pack.mType = Beacon.ContentPack.TypeLocal
		    End If
		    Pack.mIsConsoleSafe = SaveData.Value("isConsoleSafe")
		    Pack.mIsDefaultEnabled = SaveData.Value("isDefaultEnabled")
		    Pack.mName = SaveData.Value("name")
		    Pack.mLastUpdate = SaveData.Value("lastUpdate")
		    If SaveData.HasKey("marketplace") And SaveData.HasKey("marketplaceId") Then
		      Pack.mMarketplace = SaveData.Value("marketplace")
		      Pack.mMarketplaceId = SaveData.Value("marketplaceId")
		    End If
		    If SaveData.HasKey("required") Then
		      Pack.mRequired = SaveData.Value("required")
		    End If
		    If SaveData.HasKey("isConfirmed") Then
		      Pack.mIsConfirmed = SaveData.Value("isConfirmed")
		    Else
		      Pack.mIsConfirmed = True
		    End If
		    If SaveData.HasKey("confirmationCode") Then
		      Pack.mConfirmationCode = SaveData.Value("confirmationCode")
		    End If
		    Return Pack
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building Beacon.ContentPack from Dictionary")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Self.mGameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GenerateLocalContentPackId(Marketplace As String, MarketplaceId As String) As String
		  If Marketplace.IsEmpty Or MarketplaceId.IsEmpty Then
		    Return Beacon.UUID.v4
		  End If
		  
		  Return Beacon.UUID.v5("Local " + Marketplace + ": " + MarketplaceId).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As Beacon.ContentPack
		  Return New Beacon.ContentPack(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.ContentPack
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConfirmed() As Boolean
		  Return Self.mIsConfirmed
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
		  Return Self.mType = Self.TypeLocal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOfficial() As Boolean
		  Return Self.mType = Self.TypeOfficial
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsThirdParty() As Boolean
		  Return Self.mType = Self.TypeThirdParty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Marketplace() As String
		  Return Self.mMarketplace
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MarketplaceId() As String
		  Return Self.mMarketplaceId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As Beacon.MutableContentPack
		  Return New Beacon.MutableContentPack(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableContentPack
		  Return Self.MutableCopy()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ContentPack) As Integer
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
		Function Required() As Boolean
		  Return Self.mRequired
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("contentPackId") = Self.mContentPackId
		  SaveData.Value("gameId") = Self.mGameId
		  If Self.mMarketplace.IsEmpty = False And Self.mMarketplaceId.IsEmpty = False Then
		    SaveData.Value("marketplace") = Self.mMarketplace
		    SaveData.Value("marketplaceId") = Self.mMarketplaceId
		  End If
		  SaveData.Value("name") = Self.mName
		  SaveData.Value("type") = Self.mType
		  SaveData.Value("isConsoleSafe") = Self.mIsConsoleSafe
		  SaveData.Value("isDefaultEnabled") = Self.mIsDefaultEnabled
		  SaveData.Value("minVersion") = 20000000
		  SaveData.Value("lastUpdate") = Self.mLastUpdate
		  SaveData.Value("required") = Self.mRequired
		  SaveData.Value("isConfirmed") = Self.mIsConfirmed
		  SaveData.Value("confirmationCode") = Self.mConfirmationCode
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Integer
		  Return Self.mType
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfirmationCode As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGameId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsConfirmed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsDefaultEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastUpdate As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMarketplace As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMarketplaceId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequired As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mType As Integer
	#tag EndProperty


	#tag Constant, Name = TypeAny, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeLocal, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeOfficial, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeThirdParty, Type = Double, Dynamic = False, Default = \"4", Scope = Public
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
