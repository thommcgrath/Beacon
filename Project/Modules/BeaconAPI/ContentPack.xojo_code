#tag Class
Protected Class ContentPack
	#tag Method, Flags = &h0
		Function AsDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("contentPackId") = Self.mContentPackId
		  Dict.Value("gameId") = Self.mGameId
		  Dict.Value("marketplace") = Self.mMarketplace
		  Dict.Value("marketplaceId") = Self.mMarketplaceId
		  Dict.Value("name") = Self.mName
		  Dict.Value("isConfirmed") = Self.mConfirmed
		  Dict.Value("confirmationCode") = Self.mConfirmationCode
		  Dict.Value("minVersion") = Self.mMinVersion
		  Dict.Value("lastUpdate") = Self.mLastUpdate
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmationCode() As String
		  Return Self.mConfirmationCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Confirmed() As Boolean
		  Return Self.mConfirmed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Details As Beacon.ContentPack)
		  Self.mContentPackId = Details.ContentPackId
		  Self.mName = Details.Name
		  Self.mMarketplace = Details.Marketplace
		  Self.mMarketplaceId = Details.MarketplaceId
		  Self.mIsLocal = Details.IsLocal
		  Self.mConfirmed = True
		  Self.mLastUpdate = Details.LastUpdate
		  Self.mGameId = Details.GameId
		  Self.mMinVersion = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
		  // For mod info from the API
		  
		  Self.mMarketplace = Source.Lookup("marketplace", "")
		  Self.mMarketplaceId = Source.Lookup("marketplaceId", "")
		  Self.mConfirmationCode = Source.Lookup("confirmationCode", "")
		  Self.mConfirmed = Source.Lookup("isConfirmed", "")
		  Self.mGameId = Source.Lookup("gameId", Ark.Identifier)
		  Self.mIsLocal = False
		  Self.mLastUpdate = Source.Lookup("lastUpdate", 0)
		  Self.mMinVersion = Source.Lookup("minVersion", 0)
		  Self.mContentPackId = Source.Value("contentPackId")
		  Self.mName = Source.Value("name")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As JsonItem)
		  // For mod info from the API
		  
		  Self.mMarketplace = Source.Lookup("marketplace", "")
		  Self.mMarketplaceId = Source.Lookup("marketplaceId", "")
		  Self.mConfirmationCode = Source.Lookup("confirmationCode", "")
		  Self.mConfirmed = Source.Lookup("isConfirmed", "")
		  Self.mGameId = Source.Lookup("gameId", Ark.Identifier)
		  Self.mIsLocal = False
		  Self.mLastUpdate = Source.Lookup("lastUpdate", 0)
		  Self.mMinVersion = Source.Lookup("minVersion", 0)
		  Self.mContentPackId = Source.Value("contentPackId")
		  Self.mName = Source.Value("name")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Self.mGameId
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
		Function MarketplaceUrl() As String
		  Select Case Self.mMarketplace
		  Case Beacon.MarketplaceSteam
		    Return "https://store.steampowered.com/app/" + Self.mMarketplaceId
		  Case Beacon.MarketplaceSteamWorkshop
		    Return "https://steamcommunity.com/sharedfiles/filedetails/?id=" + Self.mMarketplaceId
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As BeaconAPI.ContentPack) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mContentPackId.Compare(Other.mContentPackId, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function UserBlueprintsContentPack() As BeaconAPI.ContentPack
		  Var PackInfo As New BeaconAPI.ContentPack
		  PackInfo.mConfirmed = True
		  PackInfo.mContentPackId = Ark.UserContentPackId
		  PackInfo.mName = Ark.UserContentPackName
		  PackInfo.mMarketplace = Beacon.MarketplaceSteamWorkshop
		  PackInfo.mMarketplaceId = ""
		  Return PackInfo
		End Function
	#tag EndMethod


	#tag Note, Name = What
		This class exists because the normal Beacon.ContentPack represents an actual mod that exists in the database. This
		object exists at the api.
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mConfirmationCode As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsLocal As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastUpdate As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMarketplace As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMarketplaceId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
