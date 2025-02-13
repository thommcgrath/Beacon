#tag Module
Protected Module Tests
	#tag Method, Flags = &h1
		Protected Function Assert(Value As Boolean, Message As String) As Boolean
		  If Value = False Then
		    #if DebugBuild
		      System.Beep
		    #endif
		    System.DebugLog(Message)
		  End If
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateEncryptionTest(Name As String, KeySizeBytes As Integer)
		  Var Key As MemoryBlock = Crypto.GenerateRandomBytes(KeySizeBytes)
		  Var Message As String = Beacon.UUID.v4
		  Var EncryptedLegacy As MemoryBlock = BeaconEncryption.SymmetricEncrypt(Key, Message, 1)
		  Var EncryptedModern As MemoryBlock = BeaconEncryption.SymmetricEncrypt(Key, Message, 2)
		  
		  System.DebugLog("TestEncryptionPortability(""" + Name + """, """ + EncodeBase64(Key, 0) + """, """ + Message + """, """ + EncodeBase64(EncryptedLegacy, 0) + """, """ + EncodeBase64(EncryptedModern, 0) + """)")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RunTests()
		  #if DebugBuild
		    App.Log("Running tests")
		    TestJSON
		    TestQualities()
		    TestMemoryBlockExtensions()
		    TestStrings()
		    TestEncryption()
		    TestUUID()
		    TestObjectResolution()
		    TestBlueprintSerialization()
		    TestLimitCalculations()
		    TestNamingThings()
		    TestConfigOptions()
		    TestNumberFormatting()
		    TestArkML()
		    TestFilenames()
		    TestIntervalParsing()
		    TestIniValidation()
		    TestArkClassStrings()
		    TestCachingTimes()
		    TestXmlParsing()
		    TestSaveInfo()
		    TestDelegateDetection()
		    TestHumanReadable()
		    TestEnglishLists()
		    App.Log("Tests complete")
		  #endif
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub SampleDelegate()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub SampleDelegateTarget()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestArkClassStrings()
		  Const NormalPath = "/Game/Aberration/CoreBlueprints/AB_DinoSpawnEntriesRockDrake.AB_DinoSpawnEntriesRockDrake_C"
		  Const ScorpionPath = "/Game/Mods/LostIsland/Assets/Spawners/Scorpion/DinoSpawnEntriesCave2-LowSpiderScorp_C.DinoSpawnEntriesCave2-LowSpiderScorp_C"
		  Const ReaperPath = "/Game/Genesis2/Dinos/BiomeVariants/Xenomorph_Character_Female_BP_Gen2.Xenomorph_Character_BP_Female_Gen2"
		  
		  Var NormalClass As String = Ark.ClassStringFromPath(NormalPath)
		  Var ScorpionClass As String = Ark.ClassStringFromPath(ScorpionPath)
		  Var ReaperClass As String = Ark.ClassStringFromPath(ReaperPath)
		  
		  Call Assert(NormalClass = "AB_DinoSpawnEntriesRockDrake_C", "Class from path is wrong. Expected AB_DinoSpawnEntriesRockDrake_C, got " + NormalClass + ".")
		  Call Assert(ScorpionClass = "DinoSpawnEntriesCave2-LowSpiderScorp_C_C", "Class from path is wrong. Expected DinoSpawnEntriesCave2-LowSpiderScorp_C_C, got " + ScorpionClass + ".")
		  Call Assert(ReaperClass = "Xenomorph_Character_BP_Female_Gen2_C", "Class from path is wrong. Expected Xenomorph_Character_BP_Female_Gen2_C, got " + ReaperClass + ".")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestArkML()
		  Var InputString As String = "This is a &quot;string&quot; with characters &amp; &lt;stuff&gt; like 'discord.gg/invite' that\nneed to be encoded."
		  
		  Var ArkML As Ark.ArkML = Ark.ArkML.FromArkML(InputString)
		  Var ArkMLString As String = ArkML.ArkMLValue()
		  
		  Call Assert(ArkMLString = InputString, "ArkML did not parse the same as was generated. Input: `" + InputString + "` Output: `" + ArkMLString + "`")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestBlueprintSerialization()
		  // Use object ids here just in case
		  
		  TestBlueprintSerialization(Ark.DataSource.Pool.Get(False).GetEngram("d45d0691-a430-4443-98e3-bcc501067317")) // PrimalItemArmor_RockDrakeSaddle_C
		  TestBlueprintSerialization(Ark.DataSource.Pool.Get(False).GetCreature("d4d0a3d3-8a26-494a-887c-ef992cdf7d52")) // Spindles_Character_BP_C
		  TestBlueprintSerialization(Ark.DataSource.Pool.Get(False).GetSpawnPoint("34f7776e-46f3-4251-85a6-9cc4998f340a")) // DinoSpawnEntries_DarkWater_Mosa_Caves_C
		  TestBlueprintSerialization(Ark.DataSource.Pool.Get(False).GetLootContainer("40f02506-f341-46c5-85c0-31e0d37509b6")) // SupplyCrate_IceCaveTier2_C
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestBlueprintSerialization(SourceBlueprint As Ark.Blueprint)
		  If Not Assert(SourceBlueprint <> Nil, "Source blueprint is nil") Then
		    Return
		  End If
		  
		  Var Serialized As JSONItem = Ark.PackBlueprint(SourceBlueprint, False)
		  If Not Assert(Serialized <> Nil, "Unable to produce serialized blueprint") Then
		    Return
		  End If
		  
		  Var Unserialized As Ark.Blueprint = Ark.UnpackBlueprint(Serialized)
		  If Not Assert(Unserialized <> Nil, "Unable to unserialize blueprint") Then
		    Return
		  End If
		  
		  Var SourceHash As String = SourceBlueprint.Hash
		  Var UnserializedHash As String = Unserialized.Hash
		  
		  If Not Assert(SourceHash = UnserializedHash, "Source blueprint and unserialized blueprint hashes do not match. Expected `" + SourceHash + "` but got `" + UnserializedHash + "`.") Then
		    Break
		  End If
		  
		  // Also test unserializing from json
		  Var JSON As String = Beacon.GenerateJSON(Serialized, False)
		  Serialized = Beacon.ParseJSON(JSON)
		  Unserialized = Ark.UnpackBlueprint(Serialized)
		  UnserializedHash = Unserialized.Hash
		  
		  If Not Assert(SourceHash = UnserializedHash, "Source blueprint and unserialized blueprint hashes do not match. Expected `" + SourceHash + "` but got `" + UnserializedHash + "`.") Then
		    Break
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestCachingTimes()
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var StartTime As Double = System.Microseconds
		  Var Container As Ark.LootContainer = DataSource.GetLootContainer("b537ea4d-e0a8-4c92-9763-24d3df5e1562")
		  Var InitialDuration As Double = System.Microseconds - StartTime
		  
		  StartTime = System.Microseconds
		  Container = DataSource.GetLootContainer("b537ea4d-e0a8-4c92-9763-24d3df5e1562")
		  Var CachedDuration As Double = System.Microseconds - StartTime
		  
		  System.DebugLog("Single initial duration: " + InitialDuration.ToString(Locale.Current, "#,##0") + " microseconds")
		  System.DebugLog("Single cached duration: " + CachedDuration.ToString(Locale.Current, "#,##0") + " microseconds")
		  
		  StartTime = System.Microseconds
		  Call DataSource.GetBlueprints("", New Beacon.StringList("38b6b5ae-1a60-4f2f-9bc6-9a23620b56d8"), Nil)
		  InitialDuration = System.Microseconds - StartTime
		  
		  StartTime = System.Microseconds
		  Call DataSource.GetBlueprints("", New Beacon.StringList("38b6b5ae-1a60-4f2f-9bc6-9a23620b56d8"), Nil)
		  CachedDuration = System.Microseconds - StartTime
		  
		  System.DebugLog("Search initial duration: " + InitialDuration.ToString(Locale.Current, "#,##0") + " microseconds")
		  System.DebugLog("Search cached duration: " + CachedDuration.ToString(Locale.Current, "#,##0") + " microseconds")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestConfigOptions()
		  Var Source As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  
		  Var AllConfigOptions() As Ark.ConfigOption = Source.GetConfigOptions("", "", "", False)
		  Call Assert(AllConfigOptions.Count > 0, "No config keys returned.")
		  
		  Var SpecificConfigOption As Ark.ConfigOption = Source.GetConfigOption(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DayTimeSpeedScale")
		  Call Assert((SpecificConfigOption Is Nil) = False, "Could not find DayTimeSpeedScale key.")
		  
		  Var SpeedScales() As Ark.ConfigOption = Source.GetConfigOptions(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "*SpeedScale", False)
		  Call Assert(SpeedScales.Count = 3, "Found incorrect number of *SpeedScale keys, expected 3, got " + SpeedScales.Count.ToString + ".")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestDelegateDetection()
		  Var ModuleDelegate As SampleDelegate = AddressOf SampleDelegateTarget
		  Var ModuleTarget As Variant = GetDelegateTargetMBS(ModuleDelegate)
		  Var ModuleWeak As Boolean = GetDelegateWeakMBS(ModuleDelegate)
		  
		  Var ClassInstance As New DelegateClass
		  Var ClassDelegate As SampleDelegate = WeakAddressOf ClassInstance.TriggerMethod
		  Var ClassTarget As Variant = GetDelegateTargetMBS(ClassDelegate)
		  Var ClassWeak As Boolean = GetDelegateWeakMBS(ClassDelegate)
		  
		  Call Assert(ModuleTarget.IsNull = True, "Module method delegate has a target when it should not.")
		  Call Assert(ModuleWeak = False, "Module method delegate is weak but that should not be possible.")
		  
		  Call Assert(ClassTarget.IsNull = False, "Instance method delegate does not have a target.")
		  Call Assert(ClassWeak = True, "Instance method delegate is not weak.")
		  
		  ClassInstance = Nil
		  ClassTarget = Nil
		  Var UnsafeClassTarget As Variant = GetDelegateTargetMBS(ClassDelegate)
		  Var UnsafeClassWeak As Boolean = GetDelegateWeakMBS(ClassDelegate)
		  
		  Call Assert(UnsafeClassTarget.IsNull = True, "Unsafe instance method delegate has a target.")
		  Call Assert(UnsafeClassWeak = True, "Unsafe instance method delegate is not weak.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestEncryption()
		  Var PublicKey, PrivateKey As String 
		  Call Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey)
		  Call Assert(Crypto.RSAVerifyKey(PublicKey), "Unable to validate public key")
		  Call Assert(Crypto.RSAVerifyKey(PrivateKey), "Unable to validate private key")
		  
		  Var PEMPublic As String = BeaconEncryption.PEMEncodePublicKey(PublicKey)
		  Call Assert(PEMPublic.BeginsWith("-----BEGIN PUBLIC KEY-----"), "Public key was not PEM encoded")
		  Call Assert(BeaconEncryption.PEMDecodePublicKey(PEMPublic) = PublicKey, "PEM public key was not decoded")
		  
		  Var PEMPrivate As String = BeaconEncryption.PEMEncodePrivateKey(PrivateKey)
		  Call Assert(PEMPrivate.BeginsWith("-----BEGIN PRIVATE KEY-----"), "Private key was not PEM encoded")
		  Call Assert(BeaconEncryption.PEMDecodePrivateKey(PEMPrivate) = PrivateKey, "PEM private key was not decoded")
		  
		  Var TestValue As MemoryBlock = Crypto.GenerateRandomBytes(24)
		  Var Encrypted, Decrypted As MemoryBlock
		  
		  Try
		    Encrypted = Crypto.RSAEncrypt(TestValue, PublicKey)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to encrypt test value")
		  End Try
		  
		  Try
		    Decrypted = Crypto.RSADecrypt(Encrypted, PrivateKey)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to decrypt encrypted test value")
		  End Try
		  
		  Call Assert(TestValue = Decrypted, "Decrypted value does not match original")
		  
		  // Test symmetric with different key lengths
		  TestSymmetricEncryption(8) // Half necessary for even blowfish
		  TestSymmetricEncryption(9) // Nonsense number
		  TestSymmetricEncryption(32) // Too much for blowfish, perfect for aes
		  TestSymmetricEncryption(40) // Too much for both
		  
		  // These values come from from Beacon with a small key size
		  TestEncryptionPortability("ciphermbs", "qQ23fPYb+g8wwsFeGpN3AsOn1+BMlXgR3SuwcdMrnQUwFyzIzVva4g==", "5816ee7a-3f6f-4f9b-97b6-a88ed37b970b", "igFZ8b5/g/RMGgAAACT/EkJO3XHIp0vvpPN9avbjfrL9968SkmkgcHbSSR+ua4N1VbKfRlE6993ZWQ==", "igJDzasT1dzBjUcPef2nW+4ZAAAAJP8SQk7hQaKY5TwH5kMB4S0IZb9HMvVtNGuavDaWbEb9jXoC4CSlC9TewsjSSj84zzcXTB0=")
		  TestEncryptionPortability("ciphermbs-small-key", "v/5Zs+9xnaU=", "6a38eb67-145d-4ff4-a270-e42ba0758e63", "igEbMzNWKJSVgAAAACR0JWyyZF7FKoaN0zgoDZ46MHpeczJuckDkvEmh5dAfPSMCj+Wj2Vi9ExOjRg==", "igLdb7Q4sr6V31D1mXX1vm76AAAAJHQlbLK4BBQOKdFad/mcjcDVQI7yR+ak8tw3ktPZ209/ar4f5qwAel3chTdhlfRy2dvpfXM=")
		  
		  // These values come from PHP
		  TestEncryptionPortability("php", "xNPUcwVM+TrisKjmQtYb6hQoYG+6LnCZYp2qZYgtqRSLSBSDOCZBvw==", "ecf83b98-8285-418f-88f8-5b789392b30b", "igHRJFCVtL2H3AAAACS1SWEOrO2a2eul3N+cB4GhmCOETi4lqt/z8vyQfP6uWxRvnYsDDd5O9dHe1A==", "igLzyZkDYLaDRNUhYYWH0X12AAAAJLVJYQ7pVEuanCARqgMPPGVcQkKvdS3HXW461MbYN9/ooG88LzXClOHYRUE8arDyI7mhhEQ=")
		  
		  // These values come from M_Crypto versions of Beacon (1.4.7 and earlier)
		  TestEncryptionPortability("m_crypto", "Eq/Ypo2Kw3RNA2te31fp19EP/dMGSR4IlWmjtoYn8tBnKYgA+Sr2LA==", "3456efca-c48c-41cc-a01e-3713301d9a38", "igEeFJyHv42YOAAAACQTaroA7hSPqLmalHvZflHwhZtOiTYNUZD4JOdfusagXzlKt5PH2j8vUhxV0Q==", "igKh3O68LgyGZPABtA7OI0pzAAAAJBNqugBO2kDGdvIXrkfA5femIzmdRnDSSWI3xFA9diRZiHqdbbjH+qS/5Hi9Acjh26lGfmg=")
		  
		  // Create a test usable by other versions (don't need it enabled right now)
		  // CreateEncryptionTest("ciphermbs", 40)
		  // CreateEncryptionTest("ciphermbs-small-key", 8)
		  
		  // Make sure slow encryption works
		  Try
		    Var SlowKey As String = Beacon.UUID.v4
		    Var SlowData As MemoryBlock = Crypto.GenerateRandomBytes(32)
		    Var SlowEncrypted As String = BeaconEncryption.SlowEncrypt(SlowKey, SlowData)
		    Var SlowDecrypted As MemoryBlock = BeaconEncryption.SlowDecrypt(SlowKey, SlowEncrypted)
		    Call Assert(SlowData = SlowDecrypted, "Slow decrypted value does not match original")
		  Catch Err As RuntimeException
		    System.DebugLog("Slow encryption exception")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestEncryptionPortability(Source As String, Key As String, DesiredMessage As String, LegacyPayload As String, ModernPayload As String)
		  Var KeyDecoded As MemoryBlock = DecodeBase64(Key)
		  Var LegacyPayloadDecoded As MemoryBlock = DecodeBase64(LegacyPayload)
		  Var ModernPayloadDecoded As MemoryBlock = DecodeBase64(ModernPayload)
		  Var Failed As Boolean
		  
		  Try
		    Var Decrypted As MemoryBlock = BeaconEncryption.SymmetricDecrypt(KeyDecoded, LegacyPayloadDecoded)
		    If Decrypted <> DesiredMessage Then
		      Failed = True
		      System.DebugLog(Source + ": Constant value was decrypted to the wrong value.")
		    End If
		  Catch Err As RuntimeException
		    Failed = True
		    System.DebugLog(Source + ": Unable to symmetric decrypt constant legacy values.")
		  End Try
		  
		  Try
		    Var Decrypted As MemoryBlock = BeaconEncryption.SymmetricDecrypt(KeyDecoded, ModernPayloadDecoded)
		    If Decrypted <> DesiredMessage Then
		      Failed = True
		      System.DebugLog(Source + ": Constant value was decrypted to the wrong value.")
		    End If
		  Catch Err As RuntimeException
		    Failed = True
		    System.DebugLog(Source + ": Unable to symmetric decrypt constant modern values.")
		  End Try
		  
		  If Failed Then
		    System.Beep
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestEnglishLists()
		  Var Words() As String = Array("One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")
		  Var Unlimited As String = Language.EnglishOxfordList(Words)
		  Var FiveExplicit As String = Language.EnglishOxfordList(Words, "and", 5)
		  Var TenExplicit As String = Language.EnglishOxfordList(Words, "and", 10)
		  Var NineExplicit As String = Language.EnglishOxfordList(Words, "and", 9)
		  Var SingleWord As String = Language.EnglishOxfordList(Array("One"))
		  Var TwoWords As String = Language.EnglishOxfordList(Array("One", "Two"))
		  
		  Call Assert(Unlimited = "One, Two, Three, Four, Five, Six, Seven, Eight, Nine, and Ten", "Incorrect uncapped list string. Got `" + Unlimited + "`")
		  Call Assert(FiveExplicit = "One, Two, Three, Four, and 6 others", "Incorrect capped list string. Got `" + FiveExplicit + "`")
		  Call Assert(TenExplicit = "One, Two, Three, Four, Five, Six, Seven, Eight, Nine, and Ten", "Incorrect capped list string. Got `" + TenExplicit + "`")
		  Call Assert(NineExplicit = "One, Two, Three, Four, Five, Six, Seven, Eight, and 2 others", "Incorrect capped list string. Got `" + NineExplicit + "`")
		  Call Assert(SingleWord = "One", "Incorrect single item list string. Got `" + SingleWord + "`")
		  Call Assert(TwoWords = "One and Two", "Incorrect two item list string. Got `" + SingleWord + "`")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestFilenames()
		  Const Filename = "Frog Blast: The Vent Core.extension"
		  Const Servername = "Capture the Flag 2.0 by Reptar's Raptors"
		  
		  Var Sanitized As String = Beacon.SanitizeFilename(Filename)
		  Var SanitizedAndShort As String = Beacon.SanitizeFilename(Filename, 20)
		  Var SanitizedAndVeryShort As String = Beacon.SanitizeFilename(Filename, 11)
		  
		  Call Assert(Sanitized = "Frog Blast The Vent Core.extension", "Did not sanitize filename `" + Filename + "` correctly. Expected `Frog Blast- The Vent Core.extension`, got `" + Sanitized + "`.")
		  Call Assert(SanitizedAndShort = "Frog…Core.extension", "Did not sanitize filename `" + Filename + "` to 20 characters correctly. Expected `Frog…Core.extension`, got `" + SanitizedAndShort + "`.")
		  Call Assert(SanitizedAndVeryShort = "F.extension", "Did not sanitize filename `" + Filename + "` to 11 characters correctly. Expected `F.extension`, got `" + SanitizedAndVeryShort + "`.")
		  
		  Sanitized = Beacon.SanitizeFilename(Servername)
		  SanitizedAndShort = Beacon.SanitizeFilename(Servername, 20)
		  SanitizedAndVeryShort = Beacon.SanitizeFilename(Servername, 11)
		  
		  Call Assert(Sanitized = "Capture the Flag 2.0 by Reptar's Raptors", "Did not sanitize filename `" + Servername + "` correctly. Expected `Capture the Flag 2.0 by Reptar's Raptors`, got `" + Sanitized + "`.")
		  Call Assert(SanitizedAndShort = "Capture th…s Raptors", "Did not sanitize filename `" + Servername + "` to 20 characters correctly. Expected `Capture th…s Raptors`, got `" + SanitizedAndShort + "`.")
		  Call Assert(SanitizedAndVeryShort = "Captu…ptors", "Did not sanitize filename `" + Servername + "` to 11 characters correctly. Expected `Captu…ptors`, got `" + SanitizedAndVeryShort + "`.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestHumanReadable()
		  Var LabelConversions As New Dictionary
		  LabelConversions.Value("PrimalItemResource_AmargaSpike_ASA_C") = "Amarga Spike ASA"
		  LabelConversions.Value("PrimalItemResource_ASA_AmargaSpike_C") = "ASA Amarga Spike"
		  LabelConversions.Value("PrimalItemResource_ASAAmargaSpike_C") = "ASA Amarga Spike"
		  LabelConversions.Value("PrimalItemResource_AmargaASASpike_C") = "Amarga ASA Spike"
		  LabelConversions.Value("PrimalItemResource_ASA_amargaSpike_C") = "ASA Amarga Spike"
		  
		  For Each Entry As DictionaryEntry In LabelConversions
		    Var ClassString As String = Entry.Key
		    Var DesiredLabel As String = Entry.Value
		    Var ComputedLabel As String = ArkSA.LabelFromClassString(ClassString)
		    Call Assert(DesiredLabel.Compare(ComputedLabel, ComparisonOptions.CaseSensitive) = 0, "Label from class string is incorrect. Expected `" + DesiredLabel + "` from `" + ClassString + "`, but got `" + ComputedLabel + "`.")
		  Next
		  
		  Var WordConversions As New Dictionary
		  WordConversions.Value("PrimalItemResource_AmargaSpike_ASA_C") = "primal item resource amarga spike asa"
		  WordConversions.Value("PrimalItemResource_ASA_AmargaSpike_C") = "primal item resource asa amarga spike"
		  WordConversions.Value("PrimalItemResource_ASAAmargaSpike_C") = "primal item resource asa amarga spike"
		  WordConversions.Value("PrimalItemResource_AmargaASASpike_C") = "primal item resource amarga asa spike"
		  WordConversions.Value("PrimalItemResource_ASA_amargaSpike_C") = "primal item resource asa amarga spike"
		  
		  For Each Entry As DictionaryEntry In WordConversions
		    Var ClassString As String = Entry.Key
		    Var DesiredWords As String = Entry.Value.StringValue
		    Var ComputedWords As String = String.FromArray(ArkSA.ClassStringToWords(ClassString), " ")
		    Call Assert(DesiredWords.Compare(ComputedWords, ComparisonOptions.CaseSensitive) = 0, "Words from class string is incorrect. Expected `" + DesiredWords + "` from `" + ClassString + "`, but got `" + ComputedWords + "`.")
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestIniValidation()
		  Const EOL = &u10
		  Const GameIni = "[" + Ark.HeaderShooterGame + "]" + EOL + "Setting=Value"
		  Const GameIniUWP = "[" + Ark.HeaderShooterGameUWP + "]" + EOL + "Setting=Value"
		  Const GameUserSettings = "[" + Ark.HeaderSessionSettings + "]" + EOL + "SessionName=Toast" + EOL + "[" + Ark.HeaderServerSettings + "]" + EOL + "Setting=Value" + EOL + "[" + Ark.HeaderShooterGameUserSettings + "]" + EOL + "Graphics=High"
		  
		  Call Assert(Ark.ValidateIniContent(GameIni, Ark.ConfigFileGame).Count = 0, "Game.ini failed validation in normal mode")
		  Call Assert(Ark.ValidateIniContent(GameIniUWP, Ark.ConfigFileGame).Count = 0, "Game.ini failed validation in uwp mode")
		  Call Assert(Ark.ValidateIniContent(GameUserSettings, Ark.ConfigFileGameUserSettings).Count = 0, "GameUserSettings.ini failed validation")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestIntervalParsing()
		  Var Interval As DateInterval
		  
		  Interval = Beacon.ParseInterval("2d3h4m5s")
		  If Assert((Interval Is Nil) = False, "Failed to parse interval `2d3h4m5s`, result is nil.") Then
		    Call Assert(Interval.TotalSeconds = 183845, "Failed to parse interval `2d3h4m5s` into 183845, got " + Interval.TotalSeconds.ToString(Locale.Raw, "0.0") + ".")
		  End If
		  
		  Interval = Beacon.ParseInterval("4m")
		  If Assert((Interval Is Nil) = False, "Failed to parse interval `4m`, result is nil.") Then
		    Call Assert(Interval.TotalSeconds = 240, "Failed to parse interval `4m` into 240, got " + Interval.TotalSeconds.ToString(Locale.Raw, "0.0") + ".")
		  End If
		  
		  Interval = Beacon.ParseInterval("4 minutes")
		  If Assert((Interval Is Nil) = False, "Failed to parse interval `4 minutes`, result is nil.") Then
		    Call Assert(Interval.TotalSeconds = 240, "Failed to parse interval `4 minutes` into 240, got " + Interval.TotalSeconds.ToString(Locale.Raw, "0.0") + ".")
		  End If
		  
		  Interval = Beacon.ParseInterval("4 minutes 6 seconds")
		  If Assert((Interval Is Nil) = False, "Failed to parse interval `4 minutes 6 seconds`, result is nil.") Then
		    Call Assert(Interval.TotalSeconds = 246, "Failed to parse interval `4 minutes 6 seconds` into 246, got " + Interval.TotalSeconds.ToString(Locale.Raw, "0.0") + ".")
		  End If
		  
		  Interval = Beacon.ParseInterval("6.5 seconds")
		  If Assert((Interval Is Nil) = False, "Failed to parse interval `6.5 seconds`, result is nil.") Then
		    Call Assert(Interval.TotalSeconds = 6.5, "Failed to parse interval `6.5 seconds` into 6.5, got " + Interval.TotalSeconds.ToString(Locale.Raw, "0.0") + ".")
		  End If
		  
		  Var TimeString As String = Beacon.SecondsToString(6.45)
		  Call Assert(TimeString = "6.45s", "Failed to generate fractional time string: expected `6.45s`, got `" + TimeString + "`.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestJSON()
		  Var Members() As String = Array("One", "Two", "Three")
		  Var Dict As New Dictionary
		  Dict.Value("Key") = "Value"
		  Dict.Value("Number") = 1
		  Dict.Value("List") = Members
		  Dict.Value("Key With Spaces") = "Yep"
		  
		  Var GeneratedCompactJSON As String = Xojo.GenerateJSON(Dict, False)
		  Var GeneratedPrettyJSON As String = Xojo.GenerateJSON(Dict, True)
		  
		  Call Assert(GeneratedCompactJSON = CompactJSON, "Compact JSON does not match the expected output")
		  Call Assert(GeneratedPrettyJSON = PrettyJSON, "Pretty JSON does not match the expected output")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestLimitCalculations()
		  Const InitialValueConstant = 100.0
		  Const StateModifierScale = 0.001
		  Const RandomizerRangeMultiplier = 0.1
		  
		  Var Limit As Double = Ark.Configs.StatLimits.ComputeEffectiveLimit(19800.0, InitialValueConstant, StateModifierScale, RandomizerRangeMultiplier)
		  Call Assert(Limit = 298.0, "Longneck effective damage limit computed as " + Limit.PrettyText + " instead of 298.0.")
		  
		  Var Value As Double = Ark.Configs.StatLimits.SolveForDesiredLimit(298.0, InitialValueConstant, StateModifierScale, RandomizerRangeMultiplier)
		  Call Assert(Value = 19800.0, "Longneck damage limit value computed as " + Value.PrettyText + " instead of 19800.0.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestMemoryBlockExtensions()
		  Var Original As MemoryBlock = "Frog blast the vent core!"
		  Original.LittleEndian = True
		  Var Clone As MemoryBlock = Original.Clone
		  Call Assert(EncodeHex(Original) = EncodeHex(Clone) And Original.LittleEndian = Clone.LittleEndian, "Cloning MemoryBlocks does not work")
		  
		  Var LeftRead As MemoryBlock = Original.Left(4)
		  Var RightRead As MemoryBlock = Original.Right(5)
		  Var MidRead As MemoryBlock = Original.Middle(5, 5)
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
		Private Sub TestNamingThings()
		  Var Siblings() As String
		  Siblings.Add("New Item Set")
		  
		  // This is a test for proper incrementing
		  Var Label As String = Beacon.FindUniqueLabel("New Item Set", Siblings)
		  If Not Assert(Label = "New Item Set 2", "Name not unique, expected ""New Item Set 2"" but got """ + Label + """") Then
		    Return
		  End If
		  Siblings.Add(Label)
		  
		  // This test confirms the incrementing is sequential and will not return 2 again
		  Label = Beacon.FindUniqueLabel("New Item Set", Siblings)
		  If Not Assert(Label = "New Item Set 3", "Name not unique, expected ""New Item Set 3"" but got """ + Label + """") Then
		    Return
		  End If
		  Siblings.Add(Label)
		  
		  // This test confirms the sequence continues even if the desired label already has a trailing number
		  Label = Beacon.FindUniqueLabel("New Item Set 3", Siblings)
		  If Not Assert(Label = "New Item Set 4", "Name not unique, expected ""New Item Set 4"" but got """ + Label + """") Then
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestNumberFormatting()
		  Var FormatWhole As String = Beacon.PrettyText(1.0, 4)
		  Var FormatFraction As String = Beacon.PrettyText(1.1, 4)
		  Var FormatPrecise As String = Beacon.PrettyText(1.234567, 4)
		  Var FormatMicro As String = Beacon.PrettyText(0.00000001, 9)
		  Var FormatNegative As String = Beacon.PrettyText(-1.334, 4)
		  
		  Call Assert(FormatWhole = "1", "Format of whole number is incorrect. Expected '1' but got '" + FormatWhole + "'.")
		  Call Assert(FormatFraction = "1.1", "Format of fractional number is incorrect. Expected '1.1' but got '" + FormatFraction + "'.")
		  Call Assert(FormatPrecise = "1.2346", "Format of high precision number is incorrect. Expected '1.2346' but got '" + FormatPrecise + "'.")
		  Call Assert(FormatMicro = "0.00000001", "Format of micro scale number is incorrect. Expected '0.00000001' but got '" + FormatMicro + "'.")
		  Call Assert(FormatNegative = "-1.334", "Format of negative number is incorrect. Expected '-1.334' but got '" + FormatNegative + "'.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestObjectResolution()
		  // Ark object identifiers come in 3 forms: Blueprint'/Game/Path/Class.Class', BlueprintGeneratedClass'/Game/Path/Class.Class_C', and 'Class_C'
		  // and all need to resolve to some object. Worse, that object could be known or unknown by Beacon.
		  
		  Const ExpectedOfficialPath = "/Game/Aberration/Dinos/RockDrake/PrimalItemArmor_RockDrakeSaddle.PrimalItemArmor_RockDrakeSaddle"
		  Const ExpectedUnofficialPath = "/Game/Mods/CrystalWyverns/Wyvern_Character_Blue_BP_PetCraftToo.Wyvern_Character_Blue_BP_PetCraftToo"
		  Const ExpectedUnknownPath = "/Game/BeaconUserBlueprints/Creatures/Wyvern_Character_Blue_BP_PetCraftToo.Wyvern_Character_Blue_BP_PetCraftToo"
		  
		  Var NormalizedPath As String = Ark.NormalizeBlueprintPath("BlueprintGeneratedClass'/Game/Aberration/Dinos/RockDrake/PrimalItemArmor_RockDrakeSaddle.PrimalItemArmor_RockDrakeSaddle_C'", "Engrams")
		  Call Assert(NormalizedPath = ExpectedOfficialPath, "Failed to resolve path correctly. Expected " + ExpectedOfficialPath + ", got " + NormalizedPath)
		  
		  NormalizedPath = Ark.NormalizeBlueprintPath(ExpectedOfficialPath, "Engrams")
		  Call Assert(NormalizedPath = ExpectedOfficialPath, "Failed to resolve path correctly. Expected " + ExpectedOfficialPath + ", got " + NormalizedPath)
		  
		  NormalizedPath = Ark.NormalizeBlueprintPath("PrimalItemArmor_RockDrakeSaddle_C", "Engrams")
		  Call Assert(NormalizedPath = ExpectedOfficialPath, "Failed to resolve path correctly. Expected " + ExpectedOfficialPath + ", got " + NormalizedPath)
		  
		  
		  NormalizedPath = Ark.NormalizeBlueprintPath("BlueprintGeneratedClass'/Game/Mods/CrystalWyverns/Wyvern_Character_Blue_BP_PetCraftToo.Wyvern_Character_Blue_BP_PetCraftToo_C'", "Creatures")
		  Call Assert(NormalizedPath = ExpectedUnofficialPath, "Failed to resolve path correctly. Expected " + ExpectedUnofficialPath + ", got " + NormalizedPath)
		  
		  NormalizedPath = Ark.NormalizeBlueprintPath(ExpectedUnofficialPath, "Creatures")
		  Call Assert(NormalizedPath = ExpectedUnofficialPath, "Failed to resolve path correctly. Expected " + ExpectedUnofficialPath + ", got " + NormalizedPath)
		  
		  NormalizedPath = Ark.NormalizeBlueprintPath("Wyvern_Character_Blue_BP_PetCraftToo_C", "Creatures")
		  Call Assert(NormalizedPath = ExpectedUnknownPath, "Failed to resolve path correctly. Expected " + ExpectedUnknownPath + ", got " + NormalizedPath)
		  
		  
		  // Now we need to test Beacon's ability to resolve saved data into various objects
		  Const DrakeSaddleID = "d45d0691-a430-4443-98e3-bcc501067317"
		  Var ObjectData As New Dictionary
		  ObjectData.Value("EngramId") = DrakeSaddleID
		  ObjectData.Value("Path") = "/Game/Aberration/Dinos/RockDrake/PrimalItemArmor_RockDrakeSaddle.PrimalItemArmor_RockDrakeSaddle"
		  ObjectData.Value("Class") = "PrimalItemArmor_RockDrakeSaddle_C"
		  
		  Var Engram As Ark.Engram = Ark.ResolveEngram(ObjectData, "EngramId", "Path", "Class", Nil)
		  Call Assert(Engram <> Nil And Engram.EngramId = DrakeSaddleID, "Failed to resolve engram data, expected " + DrakeSaddleID + ", got " + Engram.EngramId)
		  
		  Engram = Ark.ResolveEngram(ObjectData, "EngramId", "", "", Nil)
		  Call Assert(Engram <> Nil And Engram.EngramId = DrakeSaddleID, "Failed to resolve engram data by id, expected " + DrakeSaddleID + ", got " + Engram.EngramId)
		  
		  Engram = Ark.ResolveEngram(ObjectData, "", "", "Class", Nil)
		  Call Assert(Engram <> Nil And Engram.EngramId = DrakeSaddleID, "Failed to resolve engram data by class, expected " + DrakeSaddleID + ", got " + Engram.EngramId)
		  
		  Engram = Ark.ResolveEngram(ObjectData, "", "Path", "", Nil)
		  Call Assert(Engram <> Nil And Engram.EngramId = DrakeSaddleID, "Failed to resolve engram data by path, expected " + DrakeSaddleID + ", got " + Engram.EngramId)
		  
		  // Now use faulty data and see how it resolves
		  Const BadEngramID = "fd8b3b03-781b-4211-bc42-38a8639df878"
		  ObjectData.Value("EngramId") = BadEngramID
		  
		  Engram = Ark.ResolveEngram(ObjectData, "EngramId", "Path", "Class", Nil)
		  Call Assert(Engram <> Nil And Engram.EngramId = DrakeSaddleID, "Failed to resolve engram data, expected " + DrakeSaddleID + ", got " + Engram.EngramId)
		  
		  Engram = Ark.ResolveEngram(ObjectData, "EngramId", "", "", Nil)
		  Call Assert(Engram <> Nil And Engram.EngramId = BadEngramID, "Failed to resolve engram data, expected " + BadEngramID + ", got " + Engram.EngramId)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestQualities()
		  #if DebugBuild
		    Var Quality As Ark.Quality = Ark.Qualities.Tier4
		    Var StandardDifficulty As New Ark.Configs.Difficulty(5)
		    Var HighDifficulty As New Ark.Configs.Difficulty(15)
		    Var ExtremeDifficulty As New Ark.Configs.Difficulty(100)
		    Var Containers() As Ark.LootContainer = Ark.DataSource.Pool.Get(False).GetLootContainersByClass("SupplyCrate_Cave_QualityTier3_ScorchedEarth_C", New Beacon.StringList)
		    If Assert(Containers.Count = 1, "Wrong number of containers returned for SupplyCrate_Cave_QualityTier3_ScorchedEarth_C") = False Then
		      Return
		    End If
		    Var Container As Ark.LootContainer = Containers(0)
		    
		    Var QualityStandardMin As Double = Quality.Value(Container.Multipliers.Min, StandardDifficulty.BaseArbitraryQuality)
		    Var QualityStandardMax As Double = Quality.Value(Container.Multipliers.Max, StandardDifficulty.BaseArbitraryQuality)
		    Var QualityHighMin As Double = Quality.Value(Container.Multipliers.Min, HighDifficulty.BaseArbitraryQuality)
		    Var QualityHighMax As Double = Quality.Value(Container.Multipliers.Max, HighDifficulty.BaseArbitraryQuality)
		    Var QualityExtremeMin As Double = Quality.Value(Container.Multipliers.Min, ExtremeDifficulty.BaseArbitraryQuality)
		    Var QualityExtremeMax As Double = Quality.Value(Container.Multipliers.Max, ExtremeDifficulty.BaseArbitraryQuality)
		    
		    // Compare backwards because we expect lower values for higher difficulties
		    Call Assert(QualityExtremeMin < QualityHighMin And QualityHighMin < QualityStandardMin And QualityExtremeMax < QualityHighMax And QualityHighMax < QualityStandardMax, "Qualities are equal regardless of difficulty")
		    
		    Var StandardQualityMin As Ark.Quality = Ark.Qualities.ForValue(QualityStandardMin, Container.Multipliers.Min, StandardDifficulty.BaseArbitraryQuality)
		    Var StandardQualityMax As Ark.Quality = Ark.Qualities.ForValue(QualityStandardMax, Container.Multipliers.Max, StandardDifficulty.BaseArbitraryQuality)
		    Var HighQualityMin As Ark.Quality = Ark.Qualities.ForValue(QualityHighMin, Container.Multipliers.Min, HighDifficulty.BaseArbitraryQuality)
		    Var HighQualityMax As Ark.Quality = Ark.Qualities.ForValue(QualityHighMax, Container.Multipliers.Max, HighDifficulty.BaseArbitraryQuality)
		    Var ExtremeQualityMin As Ark.Quality = Ark.Qualities.ForValue(QualityExtremeMin, Container.Multipliers.Min, ExtremeDifficulty.BaseArbitraryQuality)
		    Var ExtremeQualityMax As Ark.Quality = Ark.Qualities.ForValue(QualityExtremeMax, Container.Multipliers.Max, ExtremeDifficulty.BaseArbitraryQuality)
		    
		    Const Formatter = "0.0000"
		    Call Assert(StandardQualityMin = Quality, "Expected quality min " + Quality.Label + "(" + Quality.BaseValue.ToString(Locale.Raw, Formatter) + ") but got " + StandardQualityMin.Label + "(" + StandardQualityMin.BaseValue.ToString(Locale.Raw, Formatter) + ") for difficulty 5")
		    Call Assert(StandardQualityMax = Quality, "Expected quality max " + Quality.Label + "(" + Quality.BaseValue.ToString(Locale.Raw, Formatter) + ") but got " + StandardQualityMax.Label + "(" + StandardQualityMax.BaseValue.ToString(Locale.Raw, Formatter) + ") for difficulty 5")
		    Call Assert(HighQualityMin = Quality, "Expected quality min " + Quality.Label + "(" + Quality.BaseValue.ToString(Locale.Raw, Formatter) + ") but got " + HighQualityMin.Label + "(" + HighQualityMax.BaseValue.ToString(Locale.Raw, Formatter) + ") for difficulty 15")
		    Call Assert(HighQualityMax = Quality, "Expected quality max " + Quality.Label + "(" + Quality.BaseValue.ToString(Locale.Raw, Formatter) + ") but got " + HighQualityMax.Label + "(" + HighQualityMax.BaseValue.ToString(Locale.Raw, Formatter) + ") for difficulty 15")
		    Call Assert(ExtremeQualityMin = Quality, "Expected quality min " + Quality.Label + "(" + Quality.BaseValue.ToString(Locale.Raw, Formatter) + ") but got " + ExtremeQualityMin.Label + "(" + ExtremeQualityMax.BaseValue.ToString(Locale.Raw, Formatter) + ") for difficulty 100")
		    Call Assert(ExtremeQualityMin = Quality, "Expected quality max " + Quality.Label + "(" + Quality.BaseValue.ToString(Locale.Raw, Formatter) + ") but got " + ExtremeQualityMax.Label + "(" + ExtremeQualityMax.BaseValue.ToString(Locale.Raw, Formatter) + ") for difficulty 100")
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestSaveInfo()
		  #if TargetMacOS
		    Const LegacySaveInfo = "Ym9va9ACAAAAAAQQMAAAAM6I4fbCN9XOSgfPNDeYh52bNsTKTJMhWHVwjfqBytzmzAEAAAQAAAADAwAAAAgAKAUAAAABAQAAVXNlcnMAAAALAAAAAQEAAHRob21tY2dyYXRoAAcAAAABAQAAU2NyYXRjaAAdAAAAAQEAAE5pdHJhZG8gTWlncmF0aW9uIFRlc3QuYmVhY29uAAAAEAAAAAEGAAAQAAAAIAAAADQAAABEAAAACAAAAAQDAAC5XAAAAAAAAAgAAAAEAwAAgbQDAAAAAAAIAAAABAMAAPE3IQAAAAAACAAAAAQDAAAqxsMFAAAAABAAAAABBgAAhAAAAJQAAACkAAAAtAAAAAgAAAAABAAAQcVUK13hI4AYAAAAAQIAAAEAAAAAAAAADwAAAAAAAAAAAAAAAAAAAAgAAAAEAwAAAgAAAAAAAAAEAAAAAwMAAPUBAAAIAAAAAQkAAGZpbGU6Ly8vDAAAAAEBAABNYWNpbnRvc2ggSEQIAAAABAMAAAAgRYzQAQAACAAAAAAEAABBxT0uhwAAACQAAAABAQAAREIwOTI5RDItOUQ1MS00NTM2LUE5MEUtOEMzNUZBQjQxRUFCGAAAAAECAACBAAAAAQAAAO8TAAABAAAAAAAAAAAAAAABAAAAAQEAAC8AAAAAAAAAAQUAAMwAAAD+////AQAAAAAAAAAQAAAABBAAAGwAAAAAAAAABRAAAMQAAAAAAAAAEBAAAOwAAAAAAAAAQBAAANwAAAAAAAAAAiAAALgBAAAAAAAABSAAACgBAAAAAAAAECAAADgBAAAAAAAAESAAAGwBAAAAAAAAEiAAAEwBAAAAAAAAEyAAAFwBAAAAAAAAICAAAJgBAAAAAAAAMCAAAMQBAAAAAAAAAcAAAAwBAAAAAAAAEcAAACAAAAAAAAAAEsAAABwBAAAAAAAAENAAAAQAAAAAAAAA"
		    Var LegacyFile As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(LegacySaveInfo)
		    Call Assert((LegacyFile Is Nil) = False, "Did not get FolderItem from legacy save info.")
		  #endif
		  
		  Var TempFile As FolderItem = FolderItem.TemporaryFile
		  Var Stream As TextOutputStream = TextOutputStream.Create(TempFile)
		  Stream.Write("Hello World")
		  Stream.Close
		  Var NewSaveInfo As String = BookmarkedFolderItem.CreateSaveInfo(TempFile)
		  Var Restored As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(NewSaveInfo)
		  If Assert((Restored Is Nil) = False, "Did not restore temporary FolderItem from save info.") And Assert(Restored.Exists, "Temporary FolderItem was restored but does not exist.") Then
		    // Do nothing
		  End If
		  TempFile.Remove
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestStrings()
		  Var StringValue As String = "Human"
		  Call Assert(StringValue.IndexOf("u") = 1, "String.IndexOf returns incorrect result. Expected 1, got " + StringValue.IndexOf("u").ToString + ".")
		  Call Assert(StringValue.Middle(2) = "man", "String.Middle returns incorrect result. Expected 'man', got '" + StringValue.Middle(2) + "'.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestSymmetricEncryption(KeyLength As Integer)
		  Var Key As MemoryBlock = Crypto.GenerateRandomBytes(KeyLength)
		  Var TestValue As MemoryBlock = Crypto.GenerateRandomBytes(33) // Use a strange number that will always require padding
		  Var Encrypted, Decrypted As MemoryBlock
		  
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
		Private Sub TestUUID()
		  Var UUID As Beacon.UUID
		  
		  Try
		    UUID = Beacon.UUID.Null
		    Call Assert(UUID = "00000000-0000-0000-0000-000000000000", "Null UUID is not correct")
		    Call Assert(UUID = Nil, "Null UUID does not compare against Nil correctly")
		  Catch Err As RuntimeException
		    System.DebugLog("Validator will not accept null UUID")
		  End Try
		  
		  Try
		    UUID = "ffc93232-2484-4947-8c9a-a691cf938d75"
		    Call Assert(UUID.IsNull = False, "UUID is listed as null when it should not be")
		    Call Assert(UUID <> Nil, "Valid UUID is successfully matching against Nil")
		  Catch Err As RuntimeException
		    System.DebugLog("Validator will not accept valid UUID")
		  End Try
		  
		  Try
		    Var V As Variant = "ffc93232-2484-4947-8c9a-a691cf938d75"
		    UUID = V.StringValue
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to convert string in variant to UUID")
		  End Try
		  
		  Try
		    Var V As Variant = Beacon.UUID.v4
		    UUID = Beacon.UUID(V.ObjectValue)
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to convert UUID in variant to UUID")
		  End Try
		  
		  Try
		    UUID = Nil
		  Catch Err As RuntimeException
		    System.DebugLog("Unable to assign UUID to Nil")
		  End Try
		  
		  Try
		    UUID = Beacon.UUID.v5("Frog Blast The Vent Core")
		    Call Assert(UUID = "99fac599-25d2-595a-aea3-12f756d2961b", "Incorrect v5 UUID, computed " + UUID.StringValue)
		  Catch Err As RuntimeException
		    System.DebugLog("Incorrect v5 UUID, computed " + UUID.StringValue)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestXmlParsing()
		  #if SDTD.Enabled
		    Const TestXml = "<?xml version=""1.0""?><ServerSettings><property name=""ServerName"" value=""3bc0f2f0"" /><property name=""Region"" value=""NorthAmericaEast"" /></ServerSettings>"
		    
		    Var ServerSettings As SDTD.ServerConfigXml = SDTD.ServerConfigXml.Create(TestXml)
		    Var Regenerated As String = ServerSettings.BuildString
		  #endif
		End Sub
	#tag EndMethod


	#tag Constant, Name = CompactJSON, Type = String, Dynamic = False, Default = \"{\"Key\":\"Value\"\x2C\"Number\":1\x2C\"List\":[\"One\"\x2C\"Two\"\x2C\"Three\"]\x2C\"Key With Spaces\":\"Yep\"}", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PrettyJSON, Type = String, Dynamic = False, Default = \"{\n    \"Key\": \"Value\"\x2C\n    \"Number\": 1\x2C\n    \"List\": [\n        \"One\"\x2C\n        \"Two\"\x2C\n        \"Three\"\n    ]\x2C\n    \"Key With Spaces\": \"Yep\"\n}\n", Scope = Private
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
End Module
#tag EndModule
