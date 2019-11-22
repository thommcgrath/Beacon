#tag Module
Protected Module Tests
	#tag Method, Flags = &h1
		Protected Function Assert(Value As Boolean, Message As String) As Boolean
		  If Value = False Then
		    System.DebugLog(Message)
		  End If
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RunTests()
		  #if DebugBuild
		    TestQualities()
		    TestMemoryBlockExtensions()
		    TestStrings()
		    TestEncryption()
		    TestUUID()
		    TestObjectResolution()
		    TestBlueprintSerialization()
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestBlueprintSerialization()
		  TestBlueprintSerialization(Beacon.Data.GetEngramByClass("PrimalItemArmor_RockDrakeSaddle_C"))
		  TestBlueprintSerialization(Beacon.Data.GetCreatureByClass("Spindles_Character_BP_C"))
		  TestBlueprintSerialization(Beacon.Data.GetSpawnPointByClass("DinoSpawnEntries_DarkWater_Mosa_Caves_C"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestBlueprintSerialization(SourceBlueprint As Beacon.Blueprint)
		  If Not Assert(SourceBlueprint <> Nil, "Source blueprint is nil") Then
		    Return
		  End If
		  
		  Var Serialized As Dictionary = SourceBlueprint.ToDictionary
		  If Not Assert(Serialized <> Nil, "Unable to produce serialized blueprint") Then
		    Return
		  End If
		  
		  Var Unserialized As Beacon.Blueprint = Beacon.BlueprintFromDictionary(Serialized)
		  If Not Assert(Unserialized <> Nil, "Unable to unserialize blueprint") Then
		    Return
		  End If
		  
		  Call Assert(SourceBlueprint.Hash = Unserialized.Hash, "Source blueprint and unserialized blueprint hashes do not match")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestEncryption()
		  Dim Identity As New Beacon.Identity
		  Dim PublicKey As String = Identity.PublicKey
		  Dim PrivateKey As String = Identity.PrivateKey
		  Call Assert(Crypto.RSAVerifyKey(PublicKey), "Unable to validate public key")
		  Call Assert(Crypto.RSAVerifyKey(PrivateKey), "Unable to validate private key")
		  
		  Dim PEMPublic As String = BeaconEncryption.PEMEncodePublicKey(PublicKey)
		  Call Assert(PEMPublic.BeginsWith("-----BEGIN PUBLIC KEY-----"), "Public key was not PEM encoded")
		  Call Assert(BeaconEncryption.PEMDecodePublicKey(PEMPublic) = PublicKey, "PEM public key was not decoded")
		  
		  Dim PEMPrivate As String = BeaconEncryption.PEMEncodePrivateKey(PrivateKey)
		  Call Assert(PEMPrivate.BeginsWith("-----BEGIN PRIVATE KEY-----"), "Private key was not PEM encoded")
		  Call Assert(BeaconEncryption.PEMDecodePrivateKey(PEMPrivate) = PrivateKey, "PEM private key was not decoded")
		  
		  Dim TestValue As MemoryBlock = Crypto.GenerateRandomBytes(24)
		  Dim Encrypted, Decrypted As MemoryBlock
		  
		  Try
		    Encrypted = Identity.Encrypt(TestValue)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to encrypt test value")
		  End Try
		  
		  Try
		    Decrypted = Identity.Decrypt(Encrypted)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to decrypt encrypted test value")
		  End Try
		  
		  Call Assert(TestValue = Decrypted, "Decrypted value does not match original")
		  
		  Dim Key As MemoryBlock = Crypto.GenerateRandomBytes(24)
		  
		  Try
		    Encrypted = BeaconEncryption.SymmetricEncrypt(Key, TestValue, 2)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to symmetric encrypt test value")
		  End Try
		  
		  Try
		    Decrypted = BeaconEncryption.SymmetricDecrypt(Key, Encrypted)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to symmetric decrypt encrypted test value")
		  End Try
		  
		  Call Assert(TestValue = Decrypted, "Symmetric decrypted value does not match original")
		  
		  Try
		    Encrypted = BeaconEncryption.SymmetricEncrypt(Key, TestValue, 1)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to symmetric(legacy) encrypt test value")
		  End Try
		  
		  Try
		    Decrypted = BeaconEncryption.SymmetricDecrypt(Key, Encrypted)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to symmetric(legacy) decrypt encrypted test value")
		  End Try
		  
		  Call Assert(TestValue = Decrypted, "Symmetric(legacy) decrypted value does not match original")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestMemoryBlockExtensions()
		  Dim Original As MemoryBlock = "Frog blast the vent core!"
		  Original.LittleEndian = True
		  Dim Clone As MemoryBlock = Original.Clone
		  Call Assert(EncodeHex(Original) = EncodeHex(Clone) And Original.LittleEndian = Clone.LittleEndian, "Cloning MemoryBlocks does not work")
		  
		  Dim LeftRead As MemoryBlock = Original.Left(4)
		  Dim RightRead As MemoryBlock = Original.Right(5)
		  Dim MidRead As MemoryBlock = Original.Middle(5, 5)
		  Call Assert(LeftRead = "Frog", "Incorrect MemoryBlock.Left read result.")
		  Call Assert(RightRead = "core!", "Incorrect MemoryBlock.Right read result.")
		  Call Assert(MidRead = "blast", "Incorrect MemoryBlock.Middle read result.")
		  
		  Clone.Left(4) = "Lion"
		  Call Assert(Clone = "Lion blast the vent core!", "Incorrect MemoryBlock.Left assignment when lengths are equal.")
		  Clone = Original.Clone
		  Clone.Left(4) = "Cat"
		  Call Assert(Clone = "Cat blast the vent core!", "Incorrect MemoryBlock.Left assignment when new length is shorter.")
		  Clone = Original.Clone
		  Clone.Left(4) = "Bobcat"
		  Call Assert(Clone = "Bobcat blast the vent core!", "Incorrect MemoryBlock.Left assignment when new length is longer.")
		  
		  Clone = Original.Clone
		  Clone.Right(5) = "tube!"
		  Call Assert(Clone = "Frog blast the vent tube!", "Incorrect MemoryBlock.Right assignment when lengths are equal.")
		  Clone = Original.Clone
		  Clone.Right(5) = "bar!"
		  Call Assert(Clone = "Frog blast the vent bar!", "Incorrect MemoryBlock.Right assignment when new length is shorter.")
		  Clone = Original.Clone
		  Clone.Right(5) = "grill!"
		  Call Assert(Clone = "Frog blast the vent grill!", "Incorrect MemoryBlock.Right assignment when new length is longer.")
		  
		  Clone = Original.Clone
		  Clone.Middle(5, 5) = "taste"
		  Call Assert(Clone = "Frog taste the vent core!", "Incorrect MemoryBlock.Middle assignment when lengths are equal.")
		  Clone = Original.Clone
		  Clone.Middle(5, 5) = "grab"
		  Call Assert(Clone = "Frog grab the vent core!", "Incorrect MemoryBlock.Middle assignment when new length is shorter.")
		  Clone = Original.Clone
		  Clone.Middle(5, 5) = "annihilate"
		  Call Assert(Clone = "Frog annihilate the vent core!", "Incorrect MemoryBlock.Middle assignment when new length is longer.")
		  
		  MidRead = Original.Middle(5, 200)
		  Call Assert(MidRead = "blast the vent core!", "Incorrect MemoryBlock.Middle read when length is greater than size.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestObjectResolution()
		  // Ark object identifiers come in 3 forms: Blueprint'/Game/Path/Class.Class', BlueprintGeneratedClass'/Game/Path/Class.Class_C', and 'Class_C'
		  // and all need to resolve to some object. Worse, that object could be known or unknown by Beacon.
		  
		  Const ExpectedOfficialPath = "/Game/Aberration/Dinos/RockDrake/PrimalItemArmor_RockDrakeSaddle.PrimalItemArmor_RockDrakeSaddle"
		  Const ExpectedUnofficialPath = "/Game/Mods/CrystalWyverns/Wyvern_Character_Blue_BP_PetCraftToo.Wyvern_Character_Blue_BP_PetCraftToo"
		  Const ExpectedUnknownPath = "/Game/BeaconUserBlueprints/Creatures/Wyvern_Character_Blue_BP_PetCraftToo.Wyvern_Character_Blue_BP_PetCraftToo"
		  
		  Var NormalizedPath As String = Beacon.NormalizeBlueprintPath("BlueprintGeneratedClass'/Game/Aberration/Dinos/RockDrake/PrimalItemArmor_RockDrakeSaddle.PrimalItemArmor_RockDrakeSaddle_C'", "Engrams")
		  Call Assert(NormalizedPath = ExpectedOfficialPath, "Failed to resolve path correctly. Expected " + ExpectedOfficialPath + ", got " + NormalizedPath)
		  
		  NormalizedPath = Beacon.NormalizeBlueprintPath(ExpectedOfficialPath, "Engrams")
		  Call Assert(NormalizedPath = ExpectedOfficialPath, "Failed to resolve path correctly. Expected " + ExpectedOfficialPath + ", got " + NormalizedPath)
		  
		  NormalizedPath = Beacon.NormalizeBlueprintPath("PrimalItemArmor_RockDrakeSaddle_C", "Engrams")
		  Call Assert(NormalizedPath = ExpectedOfficialPath, "Failed to resolve path correctly. Expected " + ExpectedOfficialPath + ", got " + NormalizedPath)
		  
		  
		  NormalizedPath = Beacon.NormalizeBlueprintPath("BlueprintGeneratedClass'/Game/Mods/CrystalWyverns/Wyvern_Character_Blue_BP_PetCraftToo.Wyvern_Character_Blue_BP_PetCraftToo_C'", "Creatures")
		  Call Assert(NormalizedPath = ExpectedUnofficialPath, "Failed to resolve path correctly. Expected " + ExpectedUnofficialPath + ", got " + NormalizedPath)
		  
		  NormalizedPath = Beacon.NormalizeBlueprintPath(ExpectedUnofficialPath, "Creatures")
		  Call Assert(NormalizedPath = ExpectedUnofficialPath, "Failed to resolve path correctly. Expected " + ExpectedUnofficialPath + ", got " + NormalizedPath)
		  
		  
		  NormalizedPath = Beacon.NormalizeBlueprintPath("Wyvern_Character_Blue_BP_PetCraftToo_C", "Creatures")
		  Call Assert(NormalizedPath = ExpectedUnknownPath, "Failed to resolve path correctly. Expected " + ExpectedUnknownPath + ", got " + NormalizedPath)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestQualities()
		  #if DebugBuild
		    Dim Quality As Beacon.Quality = Beacon.Qualities.Tier4
		    Dim StandardDifficulty As New BeaconConfigs.Difficulty(5)
		    Dim HighDifficulty As New BeaconConfigs.Difficulty(15)
		    Dim ExtremeDifficulty As New BeaconConfigs.Difficulty(100)
		    Dim Source As Beacon.LootSource = LocalData.SharedInstance.GetLootSource("SupplyCrate_Cave_QualityTier3_ScorchedEarth_C")
		    
		    Dim QualityStandardMin As Double = Quality.Value(Source.Multipliers.Min, StandardDifficulty)
		    Dim QualityStandardMax As Double = Quality.Value(Source.Multipliers.Max, StandardDifficulty)
		    Dim QualityHighMin As Double = Quality.Value(Source.Multipliers.Min, HighDifficulty)
		    Dim QualityHighMax As Double = Quality.Value(Source.Multipliers.Max, HighDifficulty)
		    Dim QualityExtremeMin As Double = Quality.Value(Source.Multipliers.Min, ExtremeDifficulty)
		    Dim QualityExtremeMax As Double = Quality.Value(Source.Multipliers.Max, ExtremeDifficulty)
		    
		    // Compare backwards because we expect lower values for higher difficulties
		    Call Assert(QualityExtremeMin < QualityHighMin And QualityHighMin < QualityStandardMin And QualityExtremeMax < QualityHighMax And QualityHighMax < QualityStandardMax, "Qualities are equal regardless of difficulty")
		    
		    Dim StandardQualityMin As Beacon.Quality = Beacon.Qualities.ForValue(QualityStandardMin, Source.Multipliers.Min, StandardDifficulty)
		    Dim StandardQualityMax As Beacon.Quality = Beacon.Qualities.ForValue(QualityStandardMax, Source.Multipliers.Max, StandardDifficulty)
		    Dim HighQualityMin As Beacon.Quality = Beacon.Qualities.ForValue(QualityHighMin, Source.Multipliers.Min, HighDifficulty)
		    Dim HighQualityMax As Beacon.Quality = Beacon.Qualities.ForValue(QualityHighMax, Source.Multipliers.Max, HighDifficulty)
		    Dim ExtremeQualityMin As Beacon.Quality = Beacon.Qualities.ForValue(QualityExtremeMin, Source.Multipliers.Min, ExtremeDifficulty)
		    Dim ExtremeQualityMax As Beacon.Quality = Beacon.Qualities.ForValue(QualityExtremeMax, Source.Multipliers.Max, ExtremeDifficulty)
		    
		    Const Formatter = "-0.0000"
		    Call Assert(StandardQualityMin = Quality, "Expected quality min " + Language.LabelForQuality(Quality) + "(" + Str(Quality.BaseValue, Formatter) + ") but got " + Language.LabelForQuality(StandardQualityMin) + "(" + Str(StandardQualityMin.BaseValue, Formatter) + ") for difficulty 5")
		    Call Assert(StandardQualityMax = Quality, "Expected quality max " + Language.LabelForQuality(Quality) + "(" + Str(Quality.BaseValue, Formatter) + ") but got " + Language.LabelForQuality(StandardQualityMax) + "(" + Str(StandardQualityMax.BaseValue, Formatter) + ") for difficulty 5")
		    Call Assert(HighQualityMin = Quality, "Expected quality min " + Language.LabelForQuality(Quality) + "(" + Str(Quality.BaseValue, Formatter) + ") but got " + Language.LabelForQuality(HighQualityMin) + "(" + Str(HighQualityMax.BaseValue, Formatter) + ") for difficulty 15")
		    Call Assert(HighQualityMax = Quality, "Expected quality max " + Language.LabelForQuality(Quality) + "(" + Str(Quality.BaseValue, Formatter) + ") but got " + Language.LabelForQuality(HighQualityMax) + "(" + Str(HighQualityMax.BaseValue, Formatter) + ") for difficulty 15")
		    Call Assert(ExtremeQualityMin = Quality, "Expected quality min " + Language.LabelForQuality(Quality) + "(" + Str(Quality.BaseValue, Formatter) + ") but got " + Language.LabelForQuality(ExtremeQualityMin) + "(" + Str(ExtremeQualityMax.BaseValue, Formatter) + ") for difficulty 100")
		    Call Assert(ExtremeQualityMin = Quality, "Expected quality max " + Language.LabelForQuality(Quality) + "(" + Str(Quality.BaseValue, Formatter) + ") but got " + Language.LabelForQuality(ExtremeQualityMax) + "(" + Str(ExtremeQualityMax.BaseValue, Formatter) + ") for difficulty 100")
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestStrings()
		  Dim StringValue As String = "Human"
		  Call Assert(StringValue.IndexOf("u") = 1, "String.IndexOf returns incorrect result. Expected 1, got " + StringValue.IndexOf("u").ToString + ".")
		  Call Assert(StringValue.Middle(2) = "man", "String.Middle returns incorrect result. Expected 'man', got '" + StringValue.Middle(2) + "'.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestUUID()
		  Dim UUID As New v4UUID
		  
		  Try
		    UUID = v4UUID.CreateNull
		    Call Assert(UUID = "00000000-0000-0000-0000-000000000000", "Null UUID is not correct")
		    Call Assert(UUID = Nil, "Null UUID does not compare against Nil correctly")
		  Catch Err As UnsupportedFormatException
		    System.DebugLog("Validator will not accept null UUID")
		  End Try
		  
		  Try
		    UUID = "ffc93232-2484-4947-8c9a-a691cf938d75"
		    Call Assert(UUID.IsNull = False, "UUID is listed as null when it should not be")
		    Call Assert(UUID <> Nil, "Valid UUID is successfully matching against Nil")
		  Catch Err As UnsupportedFormatException
		    System.DebugLog("Validator will not accept valid UUID")
		  End Try
		  
		  Try
		    Dim V As Variant = "ffc93232-2484-4947-8c9a-a691cf938d75"
		    UUID = V.StringValue
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to convert string in variant to UUID")
		  End Try
		  
		  Try
		    Dim V As Variant = New v4UUID
		    UUID = v4UUID(V.ObjectValue)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to convert UUID in variant to UUID")
		  End Try
		  
		  Try
		    UUID = Nil
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to assign UUID to Nil")
		  End Try
		  
		  Try
		    UUID = v4UUID.FromHash(Crypto.Algorithm.MD5, "Frog Blast The Vent Core")
		    Call Assert(UUID = "7e05d5d6-bf10-445d-9512-d3a650670061", "Incorrect UUID generated from MD5 hash")
		  Catch Err As UnsupportedFormatException
		    System.DebugLog("MD5UUID generated bad format")
		  End Try
		End Sub
	#tag EndMethod


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
End Module
#tag EndModule
