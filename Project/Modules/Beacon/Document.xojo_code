#tag Class
Protected Class Document
Implements Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Add(LootSource As Beacon.LootSource)
		  Dim Bound As Integer = Self.mLootSources.Ubound
		  For I As Integer = 0 To Bound
		    If Self.mLootSources(I) = LootSource Then
		      Return
		    End If
		  Next
		  Self.mLootSources.Append(LootSource)
		  Beacon.Sort(Self.mLootSources)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Profile As Beacon.ServerProfile)
		  If Profile = Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To Self.mServerProfiles.Ubound
		    If Self.mServerProfiles(I) = Profile Then
		      Self.mServerProfiles(I) = Profile.Clone
		      Self.mModified = True
		      Return
		    End If
		  Next
		  
		  Self.mServerProfiles.Append(Profile.Clone)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mIdentifier = Beacon.CreateUUID
		  Self.mDifficultyValue = 4.0
		  Self.mMapCompatibility = Beacon.Maps.TheIsland.Mask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  For Each Source As Beacon.LootSource In Self.mLootSources
		    Source.ConsumeMissingEngrams(Engrams)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentID() As Text
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "Beacon.Document.ToDictionary" )  Function Export(Identity As Beacon.Identity) As Xojo.Core.Dictionary
		  // Legacy alias
		  Return Self.ToDictionary(Identity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromText(Contents As Text, Identity As Beacon.Identity) As Beacon.Document
		  Dim Parsed As Auto
		  Try
		    Parsed = Xojo.Data.ParseJSON(Contents)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Dim Doc As New Beacon.Document
		  Dim LootSources() As Auto
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  Dim Version As Integer
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    // New style document
		    Dim Dict As Xojo.Core.Dictionary = Parsed
		    Try
		      If Dict.HasKey("LootSources") Then
		        LootSources = Dict.Value("LootSources")
		      Else
		        LootSources = Dict.Value("Beacons")
		      End If
		      Doc.mIdentifier = Dict.Value("Identifier")
		      Version = Dict.Lookup("Version", 0)
		      
		      If Dict.HasKey("Title") Then
		        Doc.mTitle = Dict.Value("Title")
		      End If
		      If Dict.HasKey("Description") Then
		        Doc.mDescription = Dict.Value("Description")
		      End If
		      If Dict.HasKey("Public") Then
		        Doc.mIsPublic = Dict.Value("Public")
		      End If
		      If Dict.HasKey("Map") Then
		        Doc.mMapCompatibility = Dict.Value("Map")
		      ElseIf Dict.HasKey("MapPreference") Then
		        Doc.mMapCompatibility = Dict.Value("MapPreference")
		      Else
		        Doc.mMapCompatibility = 0
		      End If
		      If Dict.HasKey("DifficultyValue") Then
		        Doc.DifficultyValue = Dict.Value("DifficultyValue")
		      Else
		        Doc.mDifficultyValue = -1
		      End If
		      If Dict.HasKey("Secure") Then
		        Dim SecureDict As Xojo.Core.Dictionary = ReadSecureData(Dict.Value("Secure"), Identity)
		        If SecureDict <> Nil Then
		          Doc.mLastSecureDict = Dict.Value("Secure")
		          Doc.mLastSecureHash = Doc.mLastSecureDict.Value("Hash")
		          
		          Dim ServerDicts() As Auto = SecureDict.Value("Servers")
		          For Each ServerDict As Xojo.Core.Dictionary In ServerDicts
		            Dim Profile As Beacon.ServerProfile = Beacon.ServerProfile.FromDictionary(ServerDict)
		            If Profile <> Nil Then
		              Doc.mServerProfiles.Append(Profile)
		            End If
		          Next
		          
		          If SecureDict.HasKey("OAuth") Then
		            Doc.mOAuthDicts = SecureDict.Value("OAuth")
		          End If
		        End If
		      ElseIf Dict.HasKey("FTPServers") Then
		        Dim ServerDicts() As Auto = Dict.Value("FTPServers")
		        For Each ServerDict As Xojo.Core.Dictionary In ServerDicts
		          Dim FTPInfo As Xojo.Core.Dictionary = ReadSecureData(ServerDict, Identity, True)
		          If FTPInfo <> Nil And FTPInfo.HasAllKeys("Description", "Host", "Port", "User", "Pass", "Path") Then
		            Dim Profile As New Beacon.FTPServerProfile
		            Profile.Name = FTPInfo.Value("Description")
		            Profile.Host = FTPInfo.Value("Host")
		            Profile.Port = FTPInfo.Value("Port")
		            Profile.Username = FTPInfo.Value("User")
		            Profile.Password = FTPInfo.Value("Pass")
		            
		            Dim Path As Text = FTPInfo.Value("Path")
		            Dim Components() As Text = Path.Split("/")
		            If Components.Ubound > -1 Then
		              Dim LastComponent As Text = Components(Components.Ubound)
		              If LastComponent.Length > 4 And LastComponent.Right(4) = ".ini" Then
		                Components.Remove(Components.Ubound)
		              End If
		            End If
		            Components.Append("Game.ini")
		            Profile.GameIniPath = Text.Join(Components, "/")
		            
		            Components(Components.Ubound) = "GameUserSettings.ini"
		            Profile.GameUserSettingsIniPath = Text.Join(Components, "/")
		            
		            Doc.mServerProfiles.Append(Profile)
		          End If
		        Next
		      End If
		    Catch Err As RuntimeException
		      // Likely a KeyNotFoundException or TypeMismatchException, either way, we can't handle it
		      Return Nil
		    End Try
		  ElseIf Info.FullName = "Auto()" Then
		    // Old style document
		    LootSources = Parsed
		  Else
		    // What on earth is this?
		    Return Nil
		  End If
		  
		  Dim Presets() As Beacon.Preset
		  If Version < 2 Then
		    // Will need this in a few lines
		    Presets = Beacon.Data.Presets
		  End If
		  For Each LootSource As Xojo.Core.Dictionary In LootSources
		    Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromBeacon(LootSource)
		    If Source <> Nil Then
		      If Version < 2 Then
		        // Match item set names to presets
		        For Each Set As Beacon.ItemSet In Source
		          For Each Preset As Beacon.Preset In Presets
		            If Set.Label = Preset.Label Then
		              // Here's a hack to make assigning a preset possible: save current entries
		              Dim Entries() As Beacon.SetEntry
		              For Each Entry As Beacon.SetEntry In Set
		                Entries.Append(New Beacon.SetEntry(Entry))
		              Next
		              
		              // Reconfigure
		              Set.ReconfigureWithPreset(Preset, Source, Beacon.Maps.TheIsland.Mask)
		              
		              // Now "deconfigure" it
		              Redim Set(UBound(Entries))
		              For I As Integer = 0 To UBound(Entries)
		                Set(I) = Entries(I)
		              Next
		              Continue For Set
		            End If
		          Next
		        Next
		      End If
		      Doc.mLootSources.Append(Source)
		    End If
		  Next
		  
		  Doc.mModified = Version < Beacon.Document.DocumentVersion
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasLootSource(LootSource As Beacon.LootSource) As Boolean
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "Beacon.Document.DocumentID" )  Function Identifier() As Text
		  // Legacy alias
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  If Self.mMapCompatibility = 0 Then
		    Return False
		  End If
		  If Self.DifficultyValue = -1 Then
		    Return False
		  End If
		  For Each Source As Beacon.LootSource In Self.mLootSources
		    If Not Self.SupportsLootSource(Source) Then
		      Return False
		    End If
		    If Not Source.IsValid Then
		      Return False
		    End If
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSource(Index As Integer) As Beacon.LootSource
		  Return Self.mLootSources(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSourceCount() As UInteger
		  Return Self.mLootSources.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSources() As Beacon.LootSourceCollection
		  Dim Results As New Beacon.LootSourceCollection
		  For Each LootSource As Beacon.LootSource In Self.mLootSources
		    Results.Append(LootSource)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As Beacon.Map()
		  Dim Possibles() As Beacon.Map = Beacon.Maps.All
		  Dim Matches() As Beacon.Map
		  For Each Map As Beacon.Map In Possibles
		    If Map.Matches(Self.mMapCompatibility) Then
		      Matches.Append(Map)
		    End If
		  Next
		  Return Matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Source As Beacon.LootSource In Self.mLootSources
		    If Source.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Not Value Then
		    For Each Source As Beacon.LootSource In Self.mLootSources
		      Source.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OAuthData(Provider As Text) As Xojo.Core.Dictionary
		  If Self.mOAuthDicts <> Nil And Self.mOAuthDicts.HasKey(Provider) Then
		    Return Beacon.Clone(Self.mOAuthDicts.Value(Provider))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OAuthData(Provider As Text, Assigns Dict As Xojo.Core.Dictionary)
		  If Self.mOAuthDicts = Nil Then
		    Self.mOAuthDicts = New Xojo.Core.Dictionary
		  End If
		  If Dict = Nil Then
		    If Self.mOAuthDicts.HasKey(Provider) Then
		      Self.mOAuthDicts.Remove(Provider)
		      Self.mModified = True
		    End If
		  Else
		    Self.mOAuthDicts.Value(Provider) = Beacon.Clone(Dict)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Document) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mIdentifier.Compare(Other.mIdentifier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "Beacon.Document.FromText" )  Shared Function Read(Contents As Text, Identity As Beacon.Identity) As Beacon.Document
		  // Legacy alias
		  Return Beacon.Document.FromText(Contents, Identity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Shared Function ReadSecureData(SecureDict As Xojo.Core.Dictionary, Identity As Beacon.Identity, SkipHashVerification As Boolean = False) As Xojo.Core.Dictionary
		  If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		    Return Nil
		  End If
		  
		  Dim Key As Xojo.Core.MemoryBlock = Identity.Decrypt(Beacon.DecodeHex(SecureDict.Value("Key")))
		  If Key = Nil Then
		    Return Nil
		  End If
		  
		  Dim ExpectedHash As Text = SecureDict.Lookup("Hash", "")
		  Dim Vector As Xojo.Core.MemoryBlock = Beacon.DecodeHex(SecureDict.Value("Vector"))
		  Dim Encrypted As Xojo.Core.MemoryBlock = Beacon.DecodeHex(SecureDict.Value("Content"))
		  Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		  AES.SetKey(CType(Key.Data, MemoryBlock).StringValue(0, Key.Size))
		  AES.SetInitialVector(CType(Vector.Data, MemoryBlock).StringValue(0, Vector.Size))
		  
		  Dim Decrypted As String
		  Try
		    Decrypted = AES.DecryptCBC(CType(Encrypted.Data, MemoryBlock).StringValue(0, Encrypted.Size))
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If SkipHashVerification = False Then
		    Dim ComputedHash As Text = Beacon.Hash(Decrypted)
		    If ComputedHash <> ExpectedHash Then
		      Return Nil
		    End If
		  End If
		  
		  If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		    Return Nil
		  End If
		  Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		  
		  Dim DecryptedDict As Xojo.Core.Dictionary
		  Try
		    DecryptedDict = Xojo.Data.ParseJSON(Decrypted.ToText)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Return DecryptedDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReconfigurePresets()
		  If Self.mMapCompatibility = 0 Then
		    Return
		  End If
		  
		  For Each Source As Beacon.LootSource In Self.mLootSources
		    Source.ReconfigurePresets(Self.mMapCompatibility)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(LootSource As Beacon.LootSource)
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Self.mLootSources.Remove(I)
		      Self.mModified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Profile As Beacon.ServerProfile)
		  For I As Integer = 0 To Self.mServerProfiles.Ubound
		    If Self.mServerProfiles(I) = Profile Then
		      Self.mServerProfiles.Remove(I)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfile(Index As Integer) As Beacon.ServerProfile
		  Return Self.mServerProfiles(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerProfile(Index As Integer, Assigns Profile As Beacon.ServerProfile)
		  Self.mServerProfiles(Index) = Profile.Clone
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfileCount() As Integer
		  Return Self.mServerProfiles.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsLootSource(Source As Beacon.LootSource) As Boolean
		  Return (Source.Availability And Self.mMapCompatibility) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMap(Map As Beacon.Map) As Boolean
		  Return Map.Matches(Self.mMapCompatibility)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SupportsMap(Map As Beacon.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.mMapCompatibility = Self.mMapCompatibility Or Map.Mask
		  Else
		    Self.mMapCompatibility = Self.mMapCompatibility And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary(Identity As Beacon.Identity) As Xojo.Core.Dictionary
		  Dim LootSources() As Xojo.Core.Dictionary
		  For Each LootSource As Beacon.LootSource In Self.mLootSources
		    Dim Dict As Xojo.Core.Dictionary = LootSource.Export()
		    If Dict <> Nil Then
		      LootSources.Append(Dict)
		    End If
		  Next
		  
		  Dim Document As New Xojo.Core.Dictionary
		  Document.Value("Version") = Self.DocumentVersion
		  Document.Value("Identifier") = Self.Identifier
		  Document.Value("LootSources") = LootSources
		  Document.Value("Title") = Self.Title
		  Document.Value("Description") = Self.Description
		  Document.Value("Public") = Self.IsPublic
		  
		  If Self.mMapCompatibility > 0 Then
		    Document.Value("Map") = Self.mMapCompatibility
		  End If
		  
		  If Self.DifficultyValue > -1 Then
		    Document.Value("DifficultyValue") = Self.DifficultyValue
		  End If
		  
		  Dim EncryptedData As New Xojo.Core.Dictionary
		  Dim Profiles() As Xojo.Core.Dictionary
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    Profiles.Append(Profile.ToDictionary)
		  Next
		  EncryptedData.Value("Servers") = Profiles
		  If Self.mOAuthDicts <> Nil Then
		    EncryptedData.Value("OAuth") = Self.mOAuthDicts
		  End If
		  
		  Dim Content As Text = Xojo.Data.GenerateJSON(EncryptedData)
		  Dim Hash As Text = Beacon.Hash(Content)
		  If Hash <> Self.mLastSecureHash Then
		    Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		    Dim Key As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(128)
		    Dim Vector As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(16)
		    AES.SetKey(CType(Key.Data, MemoryBlock).StringValue(0, Key.Size))
		    AES.SetInitialVector(CType(Vector.Data, MemoryBlock).StringValue(0, Vector.Size))
		    Dim Encrypted As Global.MemoryBlock = AES.EncryptCBC(Content)
		    
		    Dim SecureDict As New Xojo.Core.Dictionary
		    SecureDict.Value("Key") = Beacon.EncodeHex(Identity.Encrypt(Key))
		    SecureDict.Value("Vector") = Beacon.EncodeHex(Vector)
		    SecureDict.Value("Content") = Beacon.EncodeHex(Encrypted)
		    SecureDict.Value("Hash") = Hash
		    
		    Self.mLastSecureHash = Hash
		    Self.mLastSecureDict = SecureDict
		  End If
		  Document.Value("Secure") = Beacon.Clone(Self.mLastSecureDict)
		  
		  Return Document
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDescription
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDescription.Compare(Value, Text.CompareCaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mDescription = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		Description As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDifficultyValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 0.5)
			  If Self.mDifficultyValue = Value Then
			    Return
			  End If
			  
			  Self.mModified = True
			  Self.mDifficultyValue = Value
			End Set
		#tag EndSetter
		DifficultyValue As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIsPublic
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIsPublic = Value Then
			    Return
			  End If
			  
			  Self.mIsPublic = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		IsPublic As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMapCompatibility
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Limit As UInt64 = Beacon.Maps.All.Mask
			  Self.mMapCompatibility = Value And Limit
			End Set
		#tag EndSetter
		MapCompatibility As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDescription As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDifficultyValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsPublic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureDict As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureHash As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLootSources() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapCompatibility As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthDicts As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerProfiles() As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mTitle.Compare(Value, Text.CompareCaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mTitle = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		Title As Text
	#tag EndComputedProperty


	#tag Constant, Name = DocumentVersion, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DifficultyValue"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsPublic"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MapCompatibility"
			Group="Behavior"
			Type="UInt64"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
