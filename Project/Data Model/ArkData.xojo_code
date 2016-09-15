#tag Class
Protected Class ArkData
Inherits SQLiteDatabase
	#tag Method, Flags = &h0
		Function Connect() As Boolean
		  If Self.DatabaseFile.Exists Then
		    If Not Super.Connect Then
		      Return False
		    End If
		  Else
		    If Not Super.CreateDatabaseFile Then
		      Return False
		    End If
		  End If
		  
		  Dim RS As RecordSet = Self.SQLSelect("PRAGMA user_version;")
		  Dim Version As Integer = RS.IdxField(1).IntegerValue
		  While Version < Self.CurrentVersion
		    If Not Self.UpdateToVersion(Version + 1) Then
		      Return False
		    End If
		    
		    Version = Version + 1
		  Wend
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfBeacon(ClassString As String) As String
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"" FROM ""beacons"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim RS As RecordSet = Statement.SQLSelect(ClassString)
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return ClassString
		  End If
		  
		  Return RS.Field("label").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfEngram(ClassString As String) As String
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"" FROM ""engrams"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim RS As RecordSet = Statement.SQLSelect(ClassString)
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return ClassString
		  End If
		  
		  Return RS.Field("label").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForBeacons(SearchText As String) As Ark.Beacon()
		  Dim Results() As Ark.Beacon
		  
		  Dim RS As RecordSet
		  If SearchText = "" Then
		    RS = Self.SQLSelect("SELECT ""label"", ""classstring"" FROM ""beacons"" ORDER BY ""label"";")
		  Else
		    Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"", ""classstring"" FROM ""beacons"" WHERE LOWER(""label"") LIKE LOWER(?1) OR LOWER(""classstring"") LIKE LOWER(?1) ORDER BY ""label"";")
		    Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		    
		    RS = Statement.SQLSelect("%" + SearchText + "%")
		  End If
		  If RS = Nil Then
		    Return Results()
		  End If
		  
		  while Not RS.EOF
		    Results.Append(New Ark.Beacon(RS.Field("label").StringValue.ToText, RS.Field("classstring").StringValue.ToText))
		    RS.MoveNext
		  wend
		  
		  Return Results()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(SearchText As String) As ArkEngram()
		  Dim Results() As ArkEngram
		  
		  Dim RS As RecordSet
		  If SearchText = "" Then
		    RS = Self.SQLSelect("SELECT ""label"", ""classstring"" FROM ""engrams"" ORDER BY ""label"";")
		  Else
		    Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"", ""classstring"" FROM ""engrams"" WHERE LOWER(""label"") LIKE LOWER(?1) OR LOWER(""classstring"") LIKE LOWER(?1) ORDER BY ""label"";")
		    Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		    
		    RS = Statement.SQLSelect("%" + SearchText + "%")
		  End If
		  If RS = Nil Then
		    Return Results()
		  End If
		  
		  while Not RS.EOF
		    Results.Append(New ArkEngram(RS.Field("label").StringValue, RS.Field("classstring").StringValue))
		    RS.MoveNext
		  wend
		  
		  Return Results()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UpdateToVersion(Version As Integer) As Boolean
		  Static Info As Xojo.Introspection.TypeInfo
		  Static Methods() As Xojo.Introspection.MethodInfo
		  
		  If Info = Nil Then
		    Info = Xojo.Introspection.GetType(Self)
		    Methods = Info.Methods
		  End If
		  
		  Dim MethodName As Text = "UpdateToVersion" + Version.ToText()
		  Dim MethodDef As Xojo.Introspection.MethodInfo
		  For Each Candidate As Xojo.Introspection.MethodInfo In Methods
		    If Candidate.Name = MethodName And Candidate.ReturnType <> Nil And Candidate.ReturnType.FullName = "Boolean" Then
		      MethodDef = Candidate
		      Exit
		    End If
		  Next
		  If MethodDef = Nil Then
		    System.DebugLog("No method ArkData." + MethodName + " defined.")
		    Return False
		  End If
		  
		  Self.SQLExecute("BEGIN TRANSACTION")
		  If MethodDef.Invoke(Self) Then
		    Self.SQLExecute("COMMIT TRANSACTION")
		    Self.SQLExecute("PRAGMA user_version = " + Str(Version) + ";")
		    Return True
		  Else
		    Self.SQLExecute("ROLLBACK TRANSACTION")
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UpdateToVersion1() As Boolean
		  Self.SQLExecute("CREATE TABLE ""engrams"" (""classstring"" TEXT NOT NULL PRIMARY KEY, ""label"" TEXT NOT NULL);")
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("INSERT INTO ""engrams"" (""classstring"", ""label"") VALUES (?, ?);")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  Statement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Statement.SQLExecute("PrimalItemStructure_ThatchFloor_C", "Thatch Foundation")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWall_C", "Thatch Wall")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWall_Sloped_Right_C", "Thatch Sloped Wall Right")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWall_Sloped_Left_C", "Thatch Sloped Wall Left")
		  Statement.SQLExecute("PrimalItemStructure_ThatchCeiling_C", "Thatch Ceiling")
		  Statement.SQLExecute("PrimalItemStructure_ThatchRoof_C", "Thatch Sloped Roof")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWallWithDoor_C", "Thatch Doorframe")
		  Statement.SQLExecute("PrimalItemStructure_ThatchDoor_C", "Thatch Door")
		  
		  Statement.SQLExecute("PrimalItemTrophy_AlphaRex_C", "Alpha Rex Trophy")
		  Statement.SQLExecute("PrimalItemTrophy_Broodmother_C", "Broodmother Trophy")
		  Statement.SQLExecute("PrimalItemTrophy_Gorilla_C", "Megapithecus Trophy")
		  Statement.SQLExecute("PrimalItemTrophy_Dragon_C", "Dragon Trophy")
		  Statement.SQLExecute("PrimalItemTrophy_Manticore_C", "Manticore Trophy")
		  
		  Statement.SQLExecute("PrimalItem_Note_C", "Note")
		  Statement.SQLExecute("PrimalItem_RecipeNote_BattleTartare_C", "Recipe: Battle Tartare")
		  Statement.SQLExecute("PrimalItem_RecipeNote_CalienSoup_C", "Recipe: Calien Soup")
		  Statement.SQLExecute("PrimalItem_RecipeNote_EnduroStew_C", "Recipe: Enduro Stew")
		  Statement.SQLExecute("PrimalItem_RecipeNote_StaminaSoup_C", "Recipe: Energy Brew")
		  Statement.SQLExecute("PrimalItem_RecipeNote_FocalChili_C", "Recipe: Focal Chili")
		  Statement.SQLExecute("PrimalItem_RecipeNote_FriaCurry_C", "Recipe: Fria Curry")
		  Statement.SQLExecute("PrimalItem_RecipeNote_LazarusChowder_C", "Recipe: Lazarus Chowder")
		  Statement.SQLExecute("PrimalItem_RecipeNote_HealSoup_C", "Recipe: Medical Brew")
		  Statement.SQLExecute("PrimalItem_RecipeNote_RespecSoup_C", "Recipe: Mindwipe Tonic")
		  Statement.SQLExecute("PrimalItem_RecipeNote_ShadowSteak_C", "Recipe: Shadow Steak Sauté")
		  
		  Statement.SQLExecute("PrimalItemArmor_RexSaddle_C", "Rex Saddle")
		  Statement.SQLExecute("PrimalItemArmor_ParaSaddle_C", "Parasaur Saddle")
		  Statement.SQLExecute("PrimalItemArmor_RaptorSaddle_C", "Raptor Saddle")
		  Statement.SQLExecute("PrimalItemArmor_StegoSaddle_C", "Stego Saddle")
		  Statement.SQLExecute("PrimalItemArmor_TrikeSaddle_C", "Trike Saddle")
		  Statement.SQLExecute("PrimalItemArmor_ScorpionSaddle_C", "Pulmonoscorpius Saddle")
		  Statement.SQLExecute("PrimalItemArmor_PteroSaddle_C", "Pteranodon Saddle")
		  Statement.SQLExecute("PrimalItemArmor_SauroSaddle_C", "Bronto Saddle")
		  Statement.SQLExecute("PrimalItemArmor_TurtleSaddle_C", "Carbonemys Saddle")
		  Statement.SQLExecute("PrimalItemArmor_SarcoSaddle_C", "Sarco Saddle")
		  Statement.SQLExecute("PrimalItemArmor_AnkyloSaddle_C", "Ankylo Saddle")
		  Statement.SQLExecute("PrimalItemArmor_MammothSaddle_C", "Mammoth Saddle")
		  Statement.SQLExecute("PrimalItemArmor_MegalodonSaddle_C", "Megalodon Saddle")
		  Statement.SQLExecute("PrimalItemArmor_SaberSaddle_C", "Sabertooth Saddle")
		  Statement.SQLExecute("PrimalItemArmor_CarnoSaddle_C", "Carno Saddle")
		  Statement.SQLExecute("PrimalItemArmor_ArgentavisSaddle_C", "Argentavis Saddle")
		  Statement.SQLExecute("PrimalItemArmor_PhiomiaSaddle_C", "Phiomia Saddle")
		  Statement.SQLExecute("PrimalItemArmor_SpinoSaddle_C", "Spino Saddle")
		  Statement.SQLExecute("PrimalItemArmor_PlesiaSaddle_C", "Plesiosaur Saddle")
		  Statement.SQLExecute("PrimalItemArmor_DolphinSaddle_C", "Ichthyosaurus Saddle")
		  Statement.SQLExecute("PrimalItemArmor_DoedSaddle_C", "Doedicurus Saddle")
		  Statement.SQLExecute("PrimalItemArmor_SauroSaddle_Platform_C", "Bronto Platform Saddle")
		  Statement.SQLExecute("PrimalItemArmor_PachySaddle_C", "Pachy Saddle")
		  Statement.SQLExecute("PrimalItemArmor_Paracer_Saddle_C", "Paracer Saddle")
		  Statement.SQLExecute("PrimalItemArmor_ParacerSaddle_Platform_C", "Paracer Platform Saddle")
		  Statement.SQLExecute("PrimalItemArmor_ToadSaddle_C", "Beelzebufo Saddle")
		  Statement.SQLExecute("PrimalItemArmor_StagSaddle_C", "Megaloceros Saddle")
		  Statement.SQLExecute("PrimalItemArmor_PlesiSaddle_Platform_C", "Plesiosaur Platform Saddle")
		  Statement.SQLExecute("PrimalItemArmor_QuetzSaddle_Platform_C", "Quetz Platform Saddle")
		  Statement.SQLExecute("PrimalItemArmor_MosaSaddle_Platform_C", "Mosasaur Platform Saddle")
		  Statement.SQLExecute("PrimalItemArmor_MosaSaddle_C", "Mosasaur Saddle")
		  Statement.SQLExecute("PrimalItemArmor_QuetzSaddle_C", "Quetz Saddle")
		  Statement.SQLExecute("PrimalItemArmor_SpiderSaddle_C", "Araneo Saddle")
		  Statement.SQLExecute("PrimalItemArmor_GigantSaddle_C", "Giganotosaurus Saddle")
		  Statement.SQLExecute("PrimalItemArmor_ProcoptodonSaddle_C", "Procoptodon Saddle")
		  Statement.SQLExecute("PrimalItemArmor_Gallimimus_C", "Gallimimus Saddle")
		  Statement.SQLExecute("PrimalItemArmor_TerrorBirdSaddle_C", "Terror Bird Saddle")
		  Statement.SQLExecute("PrimalItemArmor_BeaverSaddle_C", "Castoroides Saddle")
		  Statement.SQLExecute("PrimalItemArmor_RhinoSaddle_C", "Woolly Rhino Saddle")
		  Statement.SQLExecute("PrimalItemArmor_DunkleosteusSaddle_C", "Dunkleosteus Saddle")
		  Statement.SQLExecute("PrimalItemArmor_DireBearSaddle_C", "Direbear Saddle")
		  Statement.SQLExecute("PrimalItemArmor_MantaSaddle_C", "Manta Saddle")
		  Statement.SQLExecute("PrimalItemArmor_ArthroSaddle_C", "Arthropluera Saddle")
		  Statement.SQLExecute("PrimalItemArmor_DiplodocusSaddle_C", "Diplodocus Saddle")
		  Statement.SQLExecute("PrimalItemArmor_TitanSaddle_Platform_C", "Titanosaur Platform Saddle")
		  Statement.SQLExecute("PrimalItemArmor_PelaSaddle_C", "Pelagornis Saddle")
		  Statement.SQLExecute("PrimalItemArmor_AlloSaddle_C", "Allosaurus Saddle")
		  Statement.SQLExecute("PrimalItemArmor_CamelsaurusSaddle_C", "Morellatops Saddle")
		  Statement.SQLExecute("PrimalItemArmor_MantisSaddle_C", "Mantis Saddle")
		  Statement.SQLExecute("PrimalItemArmor_MothSaddle_C", "Lymantria Saddle")
		  Statement.SQLExecute("PrimalItemArmor_RockGolemSaddle_C", "Rock Golem Saddle")
		  Statement.SQLExecute("PrimalItemArmor_SpineyLizardSaddle_C", "Thorny Dragon Saddle")
		  
		  Statement.SQLExecute("PrimalItemResource_Wood_C", "Wood")
		  Statement.SQLExecute("PrimalItemResource_Stone_C", "Stone")
		  Statement.SQLExecute("PrimalItemResource_Metal_C", "Metal")
		  Statement.SQLExecute("PrimalItemResource_Hide_C", "Hide")
		  Statement.SQLExecute("PrimalItemResource_Chitin_C", "Chitin")
		  Statement.SQLExecute("PrimalItemConsumable_BloodPack_C", "Blood Pack")
		  Statement.SQLExecute("PrimalItemConsumable_Fertilizer_Compost_C", "Fertilizer")
		  Statement.SQLExecute("PrimalItemResource_Flint_C", "Flint")
		  Statement.SQLExecute("PrimalItemResource_MetalIngot_C", "Metal Ingot")
		  Statement.SQLExecute("PrimalItemResource_Thatch_C", "Thatch")
		  Statement.SQLExecute("PrimalItemResource_Fibers_C", "Fiber")
		  Statement.SQLExecute("PrimalItemResource_Charcoal_C", "Charcoal")
		  Statement.SQLExecute("PrimalItemResource_Crystal_C", "Crystal")
		  Statement.SQLExecute("PrimalItemResource_Sparkpowder_C", "Sparkpowder")
		  Statement.SQLExecute("PrimalItemResource_Gunpowder_C", "Gunpowder")
		  Statement.SQLExecute("PrimalItemConsumable_Narcotic_C", "Narcotic")
		  Statement.SQLExecute("PrimalItemConsumable_Stimulant_C", "Stimulant")
		  Statement.SQLExecute("PrimalItemResource_Obsidian_C", "Obsidian")
		  Statement.SQLExecute("PrimalItemResource_ChitinPaste_C", "Cementing Paste")
		  Statement.SQLExecute("PrimalItemResource_Oil_C", "Oil")
		  Statement.SQLExecute("PrimalItemResource_Silicon_C", "Silica Pearls")
		  Statement.SQLExecute("PrimalItemResource_Gasoline_C", "Gasoline")
		  Statement.SQLExecute("PrimalItemResource_Electronics_C", "Electronics")
		  Statement.SQLExecute("PrimalItemResource_Polymer_C", "Polymer")
		  Statement.SQLExecute("PrimalItemResource_Keratin_C", "Keratin")
		  Statement.SQLExecute("PrimalItemResource_RareFlower_C", "Rare Flower")
		  Statement.SQLExecute("PrimalItemResource_RareMushroom_C", "Rare Mushroom")
		  Statement.SQLExecute("PrimalItemConsumableMiracleGro_C", "Re-Fertilizer")
		  Statement.SQLExecute("PrimalItemResource_Pelt_C", "Pelt")
		  Statement.SQLExecute("PrimalItemResource_Polymer_Organic_C", "Organic Polymer")
		  Statement.SQLExecute("PrimalItemResource_AnglerGel_C", "Angler Gel")
		  Statement.SQLExecute("PrimalItemResource_BlackPearl_C", "Black Pearl")
		  Statement.SQLExecute("PrimalItemResource_Horn_C", "Woolly Rhino Horn")
		  Statement.SQLExecute("PrimalItemResource_LeechBlood_C", "Leech Blood")
		  Statement.SQLExecute("PrimalItemResource_Sap_C", "Sap")
		  Statement.SQLExecute("PrimalItemResource_SubstrateAbsorbent_C", "Absorbent Substrate")
		  Statement.SQLExecute("PrimalItemResource_Clay_C", "Clay")
		  Statement.SQLExecute("PrimalItemResource_KeratinSpike_C", "Deathworm Horn")
		  Statement.SQLExecute("PrimalItemResource_PreservingSalt_C", "Preserving Salt")
		  Statement.SQLExecute("PrimalItemResource_Propellant_C", "Propellant")
		  Statement.SQLExecute("PrimalItemResource_RawSalt_C", "Raw Salt")
		  Statement.SQLExecute("PrimalItemResource_Sand_C", "Sand")
		  Statement.SQLExecute("PrimalItemResource_Silk_C", "Silk")
		  Statement.SQLExecute("PrimalItemResource_Sulfur_C", "Sulfur")
		  
		  Statement.SQLExecute("PrimalItem_WeaponStonePick_C", "Stone Pick")
		  Statement.SQLExecute("PrimalItem_WeaponStoneHatchet_C", "Stone Hatchet")
		  Statement.SQLExecute("PrimalItem_WeaponMetalPick_C", "Metal Pick")
		  Statement.SQLExecute("PrimalItem_WeaponMetalHatchet_C", "Metal Hatchet")
		  Statement.SQLExecute("PrimalItem_WeaponTorch_C", "Torch")
		  Statement.SQLExecute("PrimalItem_WeaponPaintbrush_C", "Paintbrush")
		  Statement.SQLExecute("PrimalItem_BloodExtractor_C", "Blood Extraction Syringe")
		  Statement.SQLExecute("PrimalItem_WeaponGPS_C", "GPS")
		  Statement.SQLExecute("PrimalItem_WeaponCompass_C", "Compass")
		  Statement.SQLExecute("PrimalItemRadio_C", "Radio")
		  Statement.SQLExecute("PrimalItem_WeaponSpyglass_C", "Spyglass")
		  Statement.SQLExecute("PrimalItem_WeaponSickle_C", "Metal Sickle")
		  Statement.SQLExecute("PrimalItem_WeaponMagnifyingGlass_C", "Magnifying Glass")
		  Statement.SQLExecute("PrimalItem_WeaponFishingRod_C", "Fishing Rod")
		  Statement.SQLExecute("PrimalItem_ChainSaw_C", "Chainsaw")
		  Statement.SQLExecute("PrimalItem_WeaponWhip_C", "Whip")
		  
		  Statement.SQLExecute("PrimalItemArmor_ClothPants_C", "Cloth Pants")
		  Statement.SQLExecute("PrimalItemArmor_ClothShirt_C", "Cloth Shirt")
		  Statement.SQLExecute("PrimalItemArmor_ClothHelmet_C", "Cloth Hat")
		  Statement.SQLExecute("PrimalItemArmor_ClothBoots_C", "Cloth Boots")
		  Statement.SQLExecute("PrimalItemArmor_ClothGloves_C", "Cloth Gloves")
		  Statement.SQLExecute("PrimalItemArmor_HidePants_C", "Hide Pants")
		  Statement.SQLExecute("PrimalItemArmor_HideShirt_C", "Hide Shirt")
		  Statement.SQLExecute("PrimalItemArmor_HideHelmet_C", "Hide Hat")
		  Statement.SQLExecute("PrimalItemArmor_HideBoots_C", "Hide Boots")
		  Statement.SQLExecute("PrimalItemArmor_HideGloves_C", "Hide Gloves")
		  Statement.SQLExecute("PrimalItemArmor_ChitinPants_C", "Chitin Leggings")
		  Statement.SQLExecute("PrimalItemArmor_ChitinShirt_C", "Chitin Chestpiece")
		  Statement.SQLExecute("PrimalItemArmor_ChitinHelmet_C", "Chitin Helmet")
		  Statement.SQLExecute("PrimalItemArmor_ChitinBoots_C", "Chitin Boots")
		  Statement.SQLExecute("PrimalItemArmor_ChitinGloves_C", "Chitin Gauntlets")
		  Statement.SQLExecute("PrimalItemConsumableBuff_Parachute_C", "Parachute")
		  Statement.SQLExecute("PrimalItemArmor_MetalPants_C", "Flak Leggings")
		  Statement.SQLExecute("PrimalItemArmor_MetalShirt_C", "Flak Chestpiece")
		  Statement.SQLExecute("PrimalItemArmor_MetalHelmet_C", "Flak Helmet")
		  Statement.SQLExecute("PrimalItemArmor_MetalBoots_C", "Flak Boots")
		  Statement.SQLExecute("PrimalItemArmor_MetalGloves_C", "Flak Gauntlets")
		  Statement.SQLExecute("PrimalItemArmor_MinersHelmet_C", "Heavy Miner's Helmet")
		  Statement.SQLExecute("PrimalItemArmor_ScubaShirt_SuitWithTank_C", "SCUBA Tank")
		  Statement.SQLExecute("PrimalItemArmor_ScubaHelmet_Goggles_C", "SCUBA Mask")
		  Statement.SQLExecute("PrimalItemArmor_ScubaBoots_Flippers_C", "SCUBA Flippers")
		  Statement.SQLExecute("PrimalItemArmor_FurPants_C", "Fur Leggings")
		  Statement.SQLExecute("PrimalItemArmor_FurShirt_C", "Fur Chestpiece")
		  Statement.SQLExecute("PrimalItemArmor_FurHelmet_C", "Fur Cap")
		  Statement.SQLExecute("PrimalItemArmor_FurBoots_C", "Fur Boots")
		  Statement.SQLExecute("PrimalItemArmor_FurGloves_C", "Fur Gauntlets")
		  Statement.SQLExecute("PrimalItemArmor_RiotPants_C", "Riot Leggings")
		  Statement.SQLExecute("PrimalItemArmor_RiotShirt_C", "Riot Chestpiece")
		  Statement.SQLExecute("PrimalItemArmor_RiotGloves_C", "Riot Gauntlets")
		  Statement.SQLExecute("PrimalItemArmor_RiotBoots_C", "Riot Boots")
		  Statement.SQLExecute("PrimalItemArmor_RiotHelmet_C", "Riot Helmet")
		  Statement.SQLExecute("PrimalItemArmor_ScubaPants_C", "SCUBA Leggings")
		  Statement.SQLExecute("PrimalItemArmor_WoodShield_C", "Wooden Shield")
		  Statement.SQLExecute("PrimalItemArmor_MetalShield_C", "Metal Shield")
		  Statement.SQLExecute("PrimalItemArmor_TransparentRiotShield_C", "Riot Shield")
		  Statement.SQLExecute("PrimalItemArmor_GhillieBoots_C", "Ghillie Boots")
		  Statement.SQLExecute("PrimalItemArmor_GhillieShirt_C", "Ghillie Chestpiece")
		  Statement.SQLExecute("PrimalItemArmor_GhillieGloves_C", "Ghillie Gauntlets")
		  Statement.SQLExecute("PrimalItemArmor_GhilliePants_C", "Ghillie Leggings")
		  Statement.SQLExecute("PrimalItemArmor_GhillieHelmet_C", "Ghillie Mask")
		  Statement.SQLExecute("PrimalItemArmor_GasMask_C", "Gas Mask")
		  Statement.SQLExecute("PrimalItemArmor_DesertClothBoots_C", "Desert Cloth Boots")
		  Statement.SQLExecute("PrimalItemArmor_DesertClothGloves_C", "Desert Cloth Gloves")
		  Statement.SQLExecute("PrimalItemArmor_DesertClothGogglesHelmet_C", "Desert Goggles and Hat")
		  Statement.SQLExecute("PrimalItemArmor_DesertClothPants_C", "Desert Cloth Pants")
		  Statement.SQLExecute("PrimalItemArmor_DesertClothShirt_C", "Desert Cloth Shirt")
		  
		  Statement.SQLExecute("PrimalItemStructure_Campfire_C", "Campfire")
		  Statement.SQLExecute("PrimalItemStructure_StandingTorch_C", "Standing Torch")
		  Statement.SQLExecute("PrimalItemStructure_SleepingBag_Hide_C", "Hide Sleeping Bag")
		  Statement.SQLExecute("PrimalItemStructure_ThatchCeiling_C", "Thatch Roof")
		  Statement.SQLExecute("PrimalItemStructure_ThatchDoor_C", "Thatch Door")
		  Statement.SQLExecute("PrimalItemStructure_ThatchFloor_C", "Thatch Foundation")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWall_C", "Thatch Wall")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWallWithDoor_C", "Thatch Doorframe")
		  Statement.SQLExecute("PrimalItemStructure_WoodCatwalk_C", "Wooden Catwalk")
		  Statement.SQLExecute("PrimalItemStructure_WoodCeiling_C", "Wooden Ceiling")
		  Statement.SQLExecute("PrimalItemStructure_WoodCeilingWithTrapdoor_C", "Wooden Hatchframe")
		  Statement.SQLExecute("PrimalItemStructure_WoodDoor_C", "Wooden Door")
		  Statement.SQLExecute("PrimalItemStructure_WoodFloor_C", "Wooden Foundation")
		  Statement.SQLExecute("PrimalItemStructure_WoodLadder_C", "Wooden Ladder")
		  Statement.SQLExecute("PrimalItemStructure_WoodPillar_C", "Wooden Pillar")
		  Statement.SQLExecute("PrimalItemStructure_WoodRamp_C", "Wooden Ramp")
		  Statement.SQLExecute("PrimalItemStructure_WoodTrapdoor_C", "Wooden Trapdoor")
		  Statement.SQLExecute("PrimalItemStructure_WoodWall_C", "Wooden Wall")
		  Statement.SQLExecute("PrimalItemStructure_WoodWallWithDoor_C", "Wooden Doorframe")
		  Statement.SQLExecute("PrimalItemStructure_WoodWallWithWindow_C", "Wooden Windowframe")
		  Statement.SQLExecute("PrimalItemStructure_WoodWindow_C", "Wooden Window")
		  Statement.SQLExecute("PrimalItemStructure_WoodSign_C", "Wooden Sign")
		  Statement.SQLExecute("PrimalItemStructure_StorageBox_Small_C", "Storage Box")
		  Statement.SQLExecute("PrimalItemStructure_StorageBox_Large_C", "Large Storage Box")
		  Statement.SQLExecute("PrimalItemStructure_MortarAndPestle_C", "Mortar And Pestle")
		  Statement.SQLExecute("PrimalItemStructure_StonePipeIntake_C", "Stone Irrigation Pipe - Intake")
		  Statement.SQLExecute("PrimalItemStructure_StonePipeStraight_C", "Stone Irrigation Pipe - Straight")
		  Statement.SQLExecute("PrimalItemStructure_StonePipeIncline_C", "Stone Irrigation Pipe - Inclined")
		  Statement.SQLExecute("PrimalItemStructure_StonePipeIntersection_C", "Stone Irrigation Pipe - Intersection")
		  Statement.SQLExecute("PrimalItemStructure_StonePipeVertical_C", "Stone Irrigation Pipe - Vertical")
		  Statement.SQLExecute("PrimalItemStructure_StonePipeTap_C", "Stone Irrigation Pipe - Tap")
		  Statement.SQLExecute("PrimalItemStructure_Forge_C", "Refining Forge")
		  Statement.SQLExecute("PrimalItemStructure_AnvilBench_C", "Smithy")
		  Statement.SQLExecute("PrimalItemStructure_CompostBin_C", "Compost Bin")
		  Statement.SQLExecute("PrimalItemStructure_CookingPot_C", "Cooking Pot")
		  Statement.SQLExecute("PrimalItemStructure_Bed_Simple_C", "Simple Bed")
		  Statement.SQLExecute("PrimalItemStructure_CropPlot_Small_C", "Small Crop Plot")
		  Statement.SQLExecute("PrimalItemStructure_WoodFenceFoundation_C", "Wooden Fence Foundation")
		  Statement.SQLExecute("PrimalItemStructure_WoodGateframe_C", "Dinosaur Gateway")
		  Statement.SQLExecute("PrimalItemStructure_WoodGate_C", "Dinosaur Gate")
		  Statement.SQLExecute("PrimalItemStructure_MetalCatwalk_C", "Metal Catwalk")
		  Statement.SQLExecute("PrimalItemStructure_MetalCeiling_C", "Metal Ceiling")
		  Statement.SQLExecute("PrimalItemStructure_MetalCeilingWithTrapdoor_C", "Metal Hatchframe")
		  Statement.SQLExecute("PrimalItemStructure_MetalDoor_C", "Metal Door")
		  Statement.SQLExecute("PrimalItemStructure_MetalFenceFoundation_C", "Metal Fence Foundation")
		  Statement.SQLExecute("PrimalItemStructure_MetalFloor_C", "Metal Foundation")
		  Statement.SQLExecute("PrimalItemStructure_MetalGate_Large_C", "Behemoth Gate")
		  Statement.SQLExecute("PrimalItemStructure_MetalGateframe_Large_C", "Behemoth Gateway")
		  Statement.SQLExecute("PrimalItemStructure_MetalLadder_C", "Metal Ladder")
		  Statement.SQLExecute("PrimalItemStructure_MetalPillar_C", "Metal Pillar")
		  Statement.SQLExecute("PrimalItemStructure_MetalRamp_C", "Metal Ramp")
		  Statement.SQLExecute("PrimalItemStructure_MetalTrapdoor_C", "Metal Trapdoor")
		  Statement.SQLExecute("PrimalItemStructure_MetalWall_C", "Metal Wall")
		  Statement.SQLExecute("PrimalItemStructure_MetalWallWithDoor_C", "Metal Doorframe")
		  Statement.SQLExecute("PrimalItemStructure_MetalWallWithWindow_C", "Metal Windowframe")
		  Statement.SQLExecute("PrimalItemStructure_MetalWindow_C", "Metal Window")
		  Statement.SQLExecute("PrimalItemStructure_Fabricator_C", "Fabricator")
		  Statement.SQLExecute("PrimalItemStructure_WaterTank_C", "Water Reservoir")
		  Statement.SQLExecute("PrimalItemStructure_AirConditioner_C", "Air Conditioner")
		  Statement.SQLExecute("PrimalItemStructure_PowerGenerator_C", "Electrical Generator")
		  Statement.SQLExecute("PrimalItemStructure_PowerOutlet_C", "Electrical Outlet")
		  Statement.SQLExecute("PrimalItemStructure_PowerCableIncline_C", "Inclined Electrical Cable")
		  Statement.SQLExecute("PrimalItemStructure_PowerCableIntersection_C", "Electrical Cable Intersection")
		  Statement.SQLExecute("PrimalItemStructure_PowerCableStraight_C", "Straight Electrical Cable")
		  Statement.SQLExecute("PrimalItemStructure_PowerCableVertical_C", "Vertical Electrical Cable")
		  Statement.SQLExecute("PrimalItemStructure_Lamppost_C", "Lamppost")
		  Statement.SQLExecute("PrimalItemStructure_IceBox_C", "Refrigerator")
		  Statement.SQLExecute("PrimalItemStructure_Turret_C", "Auto Turret")
		  Statement.SQLExecute("PrimalItemStructure_Keypad_C", "Remote Keypad")
		  Statement.SQLExecute("PrimalItemStructure_MetalPipeIncline_C", "Metal Irrigation Pipe - Inclined")
		  Statement.SQLExecute("PrimalItemStructure_MetalPipeIntake_C", "Metal Irrigation Pipe - Intake")
		  Statement.SQLExecute("PrimalItemStructure_MetalPipeIntersection_C", "Metal Irrigation Pipe - Intersection")
		  Statement.SQLExecute("PrimalItemStructure_MetalPipeStraight_C", "Metal Irrigation Pipe - Straight")
		  Statement.SQLExecute("PrimalItemStructure_MetalPipeTap_C", "Metal Irrigation Pipe - Tap")
		  Statement.SQLExecute("PrimalItemStructure_MetalPipeVertical_C", "Metal Irrigation Pipe - Vertical")
		  Statement.SQLExecute("PrimalItemStructure_MetalSign_C", "Metal Sign")
		  Statement.SQLExecute("PrimalItemStructure_WoodSign_Large_C", "Wooden Billboard")
		  Statement.SQLExecute("PrimalItemStructure_MetalSign_Large_C", "Metal Billboard")
		  Statement.SQLExecute("PrimalItemStructure_CropPlot_Medium_C", "Medium Crop Plot")
		  Statement.SQLExecute("PrimalItemStructure_CropPlot_Large_C", "Large Crop Plot")
		  Statement.SQLExecute("PrimalItemStructure_WoodSign_Wall_C", "Wooden Wall Sign")
		  Statement.SQLExecute("PrimalItemStructure_MetalGateframe_C", "Metal Dinosaur Gateway")
		  Statement.SQLExecute("PrimalItemStructure_MetalGate_C", "Metal Dinosaur Gate")
		  Statement.SQLExecute("PrimalItemStructure_MetalSign_Wall_C", "Metal Wall Sign")
		  Statement.SQLExecute("PrimalItemStructure_Flag_C", "Multi-Panel Flag")
		  Statement.SQLExecute("PrimalItemStructure_Flag_Spider_C", "Spider Flag")
		  Statement.SQLExecute("PrimalItemStructure_PreservingBin_C", "Preserving Bin")
		  Statement.SQLExecute("PrimalItemStructure_MetalSpikeWall_C", "Metal Spike Wall")
		  Statement.SQLExecute("PrimalItemStructure_StorageBox_Huge_C", "Vault")
		  Statement.SQLExecute("PrimalItemStructure_WoodSpikeWall_C", "Wooden Spike Wall")
		  Statement.SQLExecute("PrimalItemStructure_Bookshelf_C", "Bookshelf")
		  Statement.SQLExecute("PrimalItemStructure_StoneFenceFoundation_C", "Stone Fence Foundation")
		  Statement.SQLExecute("PrimalItemStructure_StoneWall_C", "Stone Wall")
		  Statement.SQLExecute("PrimalItemStructure_WaterTankMetal_C", "Metal Water Reservoir")
		  Statement.SQLExecute("PrimalItemStructure_StoneCeiling_C", "Stone Ceiling")
		  Statement.SQLExecute("PrimalItemStructure_StoneCeilingWithTrapdoor_C", "Stone Hatchframe")
		  Statement.SQLExecute("PrimalItemStructure_StoneDoor_C", "Reinforced Wooden Door")
		  Statement.SQLExecute("PrimalItemStructure_StoneFloor_C", "Stone Foundation")
		  Statement.SQLExecute("PrimalItemStructure_StoneGate_C", "Reinforced Dinosaur Gate")
		  Statement.SQLExecute("PrimalItemStructure_StoneGateframe_C", "Stone Dinosaur Gateway")
		  Statement.SQLExecute("PrimalItemStructure_StonePillar_C", "Stone Pillar")
		  Statement.SQLExecute("PrimalItemStructure_StoneWallWithDoor_C", "Stone Doorframe")
		  Statement.SQLExecute("PrimalItemStructure_StoneWallWithWindow_C", "Stone Windowframe")
		  Statement.SQLExecute("PrimalItemStructure_StoneWindow_C", "Reinforced Window")
		  Statement.SQLExecute("PrimalItemStructure_StoneTrapdoor_C", "Reinforced Trapdoor")
		  Statement.SQLExecute("PrimalItemStructure_LamppostOmni_C", "Omnidirectional Lamppost")
		  Statement.SQLExecute("PrimalItemStructure_Grill_C", "Industrial Grill")
		  Statement.SQLExecute("PrimalItemStructure_Flag_Single_C", "Single Panel Flag")
		  Statement.SQLExecute("PrimalItemStructure_FeedingTrough_C", "Feeding Trough")
		  Statement.SQLExecute("PrimalItemStructure_StoneGateframe_Large_C", "Behemoth Stone Dinosaur Gateway")
		  Statement.SQLExecute("PrimalItemStructure_StoneGateLarge_C", "Behemoth Reinforced Dinosaur Gate")
		  Statement.SQLExecute("PrimalItemStructure_ThatchRoof_C", "Sloped Thatch Roof")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWall_Sloped_Left_C", "Sloped Thatch Wall Left")
		  Statement.SQLExecute("PrimalItemStructure_ThatchWall_Sloped_Right_C", "Sloped Thatch Wall Right")
		  Statement.SQLExecute("PrimalItemStructure_WoodRoof_C", "Sloped Wooden Roof")
		  Statement.SQLExecute("PrimalItemStructure_WoodWall_Sloped_Left_C", "Sloped Wood Wall Left")
		  Statement.SQLExecute("PrimalItemStructure_WoodWall_Sloped_Right_C", "Sloped Wood Wall Right")
		  Statement.SQLExecute("PrimalItemStructure_StoneRoof_C", "Sloped Stone Roof")
		  Statement.SQLExecute("PrimalItemStructure_StoneWall_Sloped_Left_C", "Sloped Stone Wall Left")
		  Statement.SQLExecute("PrimalItemStructure_StoneWall_Sloped_Right_C", "Sloped Stone Wall Right")
		  Statement.SQLExecute("PrimalItemStructure_MetalRoof_C", "Sloped Metal Roof")
		  Statement.SQLExecute("PrimalItemStructure_MetalWall_Sloped_Left_C", "Sloped Metal Wall Left")
		  Statement.SQLExecute("PrimalItemStructure_MetalWall_Sloped_Right_C", "Sloped Metal Wall Right")
		  Statement.SQLExecute("PrimalItemRaft_C", "Wooden Raft")
		  Statement.SQLExecute("PrimalItemStructure_PaintingCanvas_C", "Painting Canvas")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseWall_C", "Greenhouse Wall")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseCeiling_C", "Greenhouse Ceiling")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseWallWithDoor_C", "Greenhouse Doorframe")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseDoor_C", "Greenhouse Door")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseWall_Sloped_Left_C", "Sloped Greenhouse Wall Left")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseWall_Sloped_Right_C", "Sloped Greenhouse Wall Right")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseRoof_C", "Sloped Greenhouse Roof")
		  Statement.SQLExecute("PrimalItemStructure_GreenhouseWindow_C", "Greenhouse Window")
		  Statement.SQLExecute("PrimalItemStructure_ElevatorTrackBase_C", "Elevator Track")
		  Statement.SQLExecute("PrimalItemStructure_ElevatorPlatformSmall_C", "Small Elevator Platform")
		  Statement.SQLExecute("PrimalItemStructure_ElevatorPlatfromMedium_C", "Medium Elevator Platform")
		  Statement.SQLExecute("PrimalItemStructure_ElevatorPlatformLarge_C", "Large Elevator Platform")
		  Statement.SQLExecute("PrimalItemStructure_TurretBallista_C", "Ballista Turret")
		  Statement.SQLExecute("PrimalItemStructure_Furniture_WoodChair_C", "Wooden Chair")
		  Statement.SQLExecute("PrimalItemStructure_Furniture_WoodBench_C", "Wooden Bench")
		  Statement.SQLExecute("PrimalItemStructure_Furniture_Gravestone_C", "Gravestone")
		  Statement.SQLExecute("PrimalItemStructure_TrophyBase_C", "Trophy Base")
		  Statement.SQLExecute("PrimalItemStructure_Wardrums_C", "Wardrums")
		  Statement.SQLExecute("PrimalItemStructure_WarMap_C", "War Map")
		  Statement.SQLExecute("PrimalItemStructure_WoodRailing_C", "Wooden Railing")
		  Statement.SQLExecute("PrimalItemStructure_StoneRailing_C", "Stone Railing")
		  Statement.SQLExecute("PrimalItemStructure_MetalRailing_C", "Metal Railing")
		  Statement.SQLExecute("PrimalItemStructure_TrophyWall_C", "Trophy Wall-Mount")
		  Statement.SQLExecute("PrimalItemStructure_TurretMinigun_C", "Minigun Turret")
		  Statement.SQLExecute("PrimalItemStructure_TurretCatapult_C", "Catapult Turret")
		  Statement.SQLExecute("PrimalItemStructure_TurretRocket_C", "Rocket Turret")
		  Statement.SQLExecute("PrimalItemStructure_SeaMine_C", "Homing Underwater Mine")
		  Statement.SQLExecute("PrimalItemStructure_WallTorch_C", "Wall Torch")
		  Statement.SQLExecute("PrimalItemStructure_IndustrialForge_C", "Industrial Forge")
		  Statement.SQLExecute("PrimalItemStructure_IndustrialCookingPot_C", "Industrial Cooker")
		  Statement.SQLExecute("PrimalItemStructure_Bed_Modern_C", "Bunk Bed")
		  Statement.SQLExecute("PrimalItemStructure_Furniture_WoodTable_C", "Wooden Table")
		  Statement.SQLExecute("PrimalItemStructure_Fireplace_C", "Stone Fireplace")
		  Statement.SQLExecute("PrimalItemStructure_WoodCage_C", "Wooden Cage")
		  Statement.SQLExecute("PrimalItemStructure_BeerBarrel_C", "Beer Barrel")
		  Statement.SQLExecute("PrimalItemStructure_ChemBench_C", "Chemistry Bench")
		  Statement.SQLExecute("PrimalItemStructure_Cannon_C", "Cannon")
		  Statement.SQLExecute("PrimalItemStructure_Flag_Gorilla_C", "Gorilla Flag")
		  Statement.SQLExecute("PrimalItemStructure_Flag_Dragon_C", "Dragon Flag")
		  Statement.SQLExecute("PrimalItemStructure_TrainingDummy_C", "Training Dummy")
		  Statement.SQLExecute("PrimalItemStructure_RopeLadder_C", "Rope Ladder")
		  Statement.SQLExecute("PrimalItemStructure_TreePlatform_Wood_C", "Wooden Tree Platform")
		  Statement.SQLExecute("PrimalItemStructure_TreePlatform_Metal_C", "Metal Tree Platform")
		  Statement.SQLExecute("PrimalItemStructure_TreeTap_C", "Tree Sap Tap")
		  Statement.SQLExecute("PrimalItemStructure_WoodStairs_C", "Wooden Staircase")
		  Statement.SQLExecute("PrimalItemStructure_StoneStairs_C", "Stone Staircase")
		  Statement.SQLExecute("PrimalItemStructure_MetalStairs_C", "Metal Staircase")
		  Statement.SQLExecute("PrimalItemStructure_Grinder_C", "Industrial Grinder")
		  Statement.SQLExecute("PrimalItemStructure_StoneCeilingWithTrapdoorGiant_C", "Giant Stone Hatchframe")
		  Statement.SQLExecute("PrimalItemStructure_StoneCeilingDoorGiant_C", "Giant Reinforced Trapdoor")
		  Statement.SQLExecute("PrimalItemStructure_MetalCeilingWithTrapdoorGiant_C", "Giant Metal Hatchframe")
		  Statement.SQLExecute("PrimalItemStructure_MetalTrapdoorGiant_C", "Giant Metal Trapdoor")
		  Statement.SQLExecute("PrimalItemStructure_AdobeCeiling_C", "Adobe Ceiling")
		  Statement.SQLExecute("PrimalItemStructure_AdobeCeilingDoorGiant_C", "Giant Adobe Trapdoor")
		  Statement.SQLExecute("PrimalItemStructure_AdobeCeilingWithDoorWay_Giant_C", "Giant Adobe Hatchframe")
		  Statement.SQLExecute("PrimalItemStructure_AdobeCeilingWithTrapdoor_C", "Adobe Hatchframe")
		  Statement.SQLExecute("PrimalItemStructure_AdobeDoor_C", "Adobe Door")
		  Statement.SQLExecute("PrimalItemStructure_AdobeFenceFoundation_C", "Adobe Fence Foundation")
		  Statement.SQLExecute("PrimalItemStructure_AdobeFloor_C", "Adobe Foundation")
		  Statement.SQLExecute("PrimalItemStructure_AdobeFrameGate_C", "Adobe Dinosaur Gateway")
		  Statement.SQLExecute("PrimalItemStructure_AdobeGateDoor_C", "Adobe Dinosaur Gate")
		  Statement.SQLExecute("PrimalItemStructure_AdobeGateDoor_Large_C", "Behemoth Adobe Dinosaur Gate")
		  Statement.SQLExecute("PrimalItemStructure_AdobeGateframe_Large_C", "Behemoth Adobe Dinosaur Gateway")
		  Statement.SQLExecute("PrimalItemStructure_AdobeLader_C", "Adobe Ladder")
		  Statement.SQLExecute("PrimalItemStructure_AdobePillar_C", "Adobe Pillar")
		  Statement.SQLExecute("PrimalItemStructure_AdobeRailing_C", "Adobe Railing")
		  Statement.SQLExecute("PrimalItemStructure_AdobeRamp_C", "Adobe Ramp")
		  Statement.SQLExecute("PrimalItemStructure_AdobeRoof_C", "Sloped Adobe Roof")
		  Statement.SQLExecute("PrimalItemStructure_AdobeStaircase_C", "Adobe Staircase")
		  Statement.SQLExecute("PrimalItemStructure_AdobeTrapdoor_C", "Adobe Trapdoor")
		  Statement.SQLExecute("PrimalItemStructure_AdobeWall_C", "Adobe Wall")
		  Statement.SQLExecute("PrimalItemStructure_AdobeWall_Sloped_Left_C", "Sloped Adobe Wall Left")
		  Statement.SQLExecute("PrimalItemStructure_AdobeWall_Sloped_Right_C", "Sloped Adobe Wall Right")
		  Statement.SQLExecute("PrimalItemStructure_AdobeWallWithDoor_C", "Adobe Doorframe")
		  Statement.SQLExecute("PrimalItemStructure_AdobeWallWithWindow_C", "Adobe Windowframe")
		  Statement.SQLExecute("PrimalItemStructure_AdobeWindow_C", "Adobe Window")
		  Statement.SQLExecute("PrimalItemStructure_Flag_Manticore_C", "Manticore Flag")
		  Statement.SQLExecute("PrimalItemStructure_Mirror_C", "Mirror")
		  Statement.SQLExecute("PrimalItemStructure_oilPump_C", "Oil Pump")
		  Statement.SQLExecute("PrimalItemStructure_Tent_C", "Tent")
		  Statement.SQLExecute("PrimalItemStructure_Vessel_C", "Vessel")
		  Statement.SQLExecute("PrimalItemStructure_WaterWell_C", "Water Well")
		  Statement.SQLExecute("PrimalItemStructure_WindTurbine_C", "Wind Turbine")
		  
		  Statement.SQLExecute("PrimalItemDye_Red_C", "Red Coloring")
		  Statement.SQLExecute("PrimalItemDye_Green_C", "Green Coloring")
		  Statement.SQLExecute("PrimalItemDye_Blue_C", "Blue Coloring")
		  Statement.SQLExecute("PrimalItemDye_Yellow_C", "Yellow Coloring")
		  Statement.SQLExecute("PrimalItemDye_Purple_C", "Purple Coloring")
		  Statement.SQLExecute("PrimalItemDye_Orange_C", "Orange Coloring")
		  Statement.SQLExecute("PrimalItemDye_Black_C", "Black Coloring")
		  Statement.SQLExecute("PrimalItemDye_White_C", "White Coloring")
		  Statement.SQLExecute("PrimalItemDye_Brown_C", "Brown Coloring")
		  Statement.SQLExecute("PrimalItemDye_Cyan_C", "Cyan Coloring")
		  Statement.SQLExecute("PrimalItemDye_Magenta_C", "Purple Coloring")
		  Statement.SQLExecute("PrimalItemDye_Forest_C", "Forest Coloring")
		  Statement.SQLExecute("PrimalItemDye_Parchment_C", "Parchment Coloring")
		  Statement.SQLExecute("PrimalItemDye_Pink_C", "Pink Coloring")
		  Statement.SQLExecute("PrimalItemDye_Royalty_C", "Royalty Coloring")
		  Statement.SQLExecute("PrimalItemDye_Silver_C", "Silver Coloring")
		  Statement.SQLExecute("PrimalItemDye_Sky_C", "Sky Coloring")
		  Statement.SQLExecute("PrimalItemDye_Tan_C", "Tan Coloring")
		  Statement.SQLExecute("PrimalItemDye_Tangerine_C", "Tangerine Coloring")
		  Statement.SQLExecute("PrimalItemDye_ActuallyMagenta_C", "Magenta Coloring")
		  Statement.SQLExecute("PrimalItemDye_Brick_C", "Brick Coloring")
		  Statement.SQLExecute("PrimalItemDye_Cantaloupe_C", "Cantaloupe Coloring")
		  Statement.SQLExecute("PrimalItemDye_Mud_C", "Mud Coloring")
		  Statement.SQLExecute("PrimalItemDye_Navy_C", "Navy Coloring")
		  Statement.SQLExecute("PrimalItemDye_Olive_C", "Olive Coloring")
		  Statement.SQLExecute("PrimalItemDye_Slate_C", "Slate Coloring")
		  
		  Statement.SQLExecute("PrimalItemConsumable_RawMeat_C", "Raw Meat")
		  Statement.SQLExecute("PrimalItemConsumable_SpoiledMeat_C", "Spoiled Meat")
		  Statement.SQLExecute("PrimalItemConsumable_CookedMeat_C", "Cooked Meat")
		  Statement.SQLExecute("PrimalItemConsumable_RawPrimeMeat_C", "Raw Prime Meat")
		  Statement.SQLExecute("PrimalItemConsumable_CookedPrimeMeat_C", "Cooked Prime Meat")
		  Statement.SQLExecute("PrimalItemConsumable_CookedMeat_Jerky_C", "Cooked Meat Jerky")
		  Statement.SQLExecute("PrimalItemConsumable_CookedPrimeMeat_Jerky_C", "Prime Meat Jerky")
		  Statement.SQLExecute("PrimalItemConsumable_RawMeat_Fish_C", "Raw Fish Meat")
		  Statement.SQLExecute("PrimalItemConsumable_CookedMeat_Fish_C", "Cooked Fish Meat")
		  Statement.SQLExecute("PrimalItemConsumable_RawPrimeMeat_Fish_C", "Raw Prime Fish Meat")
		  Statement.SQLExecute("PrimalItemConsumable_CookedPrimeMeat_Fish_C", "Cooked Prime Fish Meat")
		  Statement.SQLExecute("PrimalItemConsumable_WyvernMilk_C", "Wyvern Milk")
		  Statement.SQLExecute("PrimalItemConsumable_Berry_Amarberry_C", "Amarberry")
		  Statement.SQLExecute("PrimalItemConsumable_Berry_Azulberry_C", "Azulberry")
		  Statement.SQLExecute("PrimalItemConsumable_Berry_Mejoberry_C", "Mejoberry")
		  Statement.SQLExecute("PrimalItemConsumable_Berry_Narcoberry_C", "Narcoberry")
		  Statement.SQLExecute("PrimalItemConsumable_Berry_Stimberry_C", "Stimberry")
		  Statement.SQLExecute("PrimalItemConsumable_Berry_Tintoberry_C", "Tintoberry")
		  Statement.SQLExecute("PrimalItemConsumable_CactusSap_C", "Cactus Sap")
		  Statement.SQLExecute("PrimalItemConsumable_Veggie_Citronal_C", "Citronal")
		  Statement.SQLExecute("PrimalItemConsumable_Veggie_Longrass_C", "Longrass")
		  Statement.SQLExecute("PrimalItemConsumable_Veggie_Rockarrot_C", "Rockarrot")
		  Statement.SQLExecute("PrimalItemConsumable_Veggie_Savoroot_C", "Savoroot")
		  Statement.SQLExecute("PrimalItemConsumable_WaterskinCraftable_C", "Waterskin")
		  Statement.SQLExecute("PrimalItemConsumable_WaterskinRefill_C", "Waterskin")
		  Statement.SQLExecute("PrimalItemConsumable_WaterJarCraftable_C", "Water Jar")
		  Statement.SQLExecute("PrimalItemConsumable_WaterJarRefill_C", "Water Jar")
		  Statement.SQLExecute("PrimalItemConsumable_IcedWaterJar_C", "Iced Water Jar")
		  Statement.SQLExecute("PrimalItemConsumable_IcedWaterJarRefill_C", "Iced Water Jar")
		  Statement.SQLExecute("PrimalItemConsumable_CanteenCraftable_C", "Canteen")
		  Statement.SQLExecute("PrimalItemConsumable_CanteenRefill_C", "Canteen")
		  Statement.SQLExecute("PrimalItemConsumable_IcedCanteen_C", "Iced Canteen")
		  Statement.SQLExecute("PrimalItemConsumable_IcedCanteenRefill_C", "Iced Canteen")
		  Statement.SQLExecute("PrimalItemConsumable_BeerJar_C", "Beer Jar")
		  Statement.SQLExecute("PrimalItemConsumable_BeerJarAlt_C", "Beer Jar")
		  Statement.SQLExecute("PrimalItemConsumable_HealSoup_C", "Medical Brew")
		  Statement.SQLExecute("PrimalItemConsumable_StaminaSoup_C", "Energy Brew")
		  Statement.SQLExecute("PrimalItemConsumable_Soup_BattleTartare_C", "Battle Tartare")
		  Statement.SQLExecute("PrimalItemConsumable_TheHorn_C", "Broth of Enlightenment")
		  Statement.SQLExecute("PrimalItemConsumable_BugRepellant_C", "Bug Repellant")
		  Statement.SQLExecute("PrimalItemConsumable_CactusBuffSoup_C", "Cactus Broth")
		  Statement.SQLExecute("PrimalItemConsumable_Soup_CalienSoup_C", "Calien Soup")
		  Statement.SQLExecute("PrimalItemConsumable_Soup_EnduroStew_C", "Enduro Stew")
		  Statement.SQLExecute("PrimalItemConsumable_Soup_FocalChili_C", "Focal Chili")
		  Statement.SQLExecute("PrimalItemConsumable_Soup_FriaCurry_C", "Fria Curry")
		  Statement.SQLExecute("PrimalItemConsumable_Soup_LazarusChowder_C", "Lazarus Chowder")
		  Statement.SQLExecute("PrimalItemConsumable_CureLow_C", "Lesser Antidote")
		  Statement.SQLExecute("PrimalItemConsumableRespecSoup_C", "Mindwipe Tonic")
		  Statement.SQLExecute("PrimalItemConsumable_Soup_ShadowSteak_C", "Shadow Steak Saute")
		  Statement.SQLExecute("PrimalItemConsumableSoap_C", "Soap")
		  Statement.SQLExecute("PrimalItemConsumable_SweetVeggieCake_C", "Sweet Vegetable Cake")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_Allo_C", "Kibble (Allosaurus Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_AnkyloEgg_C", "Kibble (Ankylo Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_SpiderEgg_C", "Kibble (Araneo Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_ArgentEgg_C", "Kibble (Argentavis Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_SauroEgg_C", "Kibble (Bronto Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_TurtleEgg_C", "Kibble (Carbonemys Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_CarnoEgg_C", "Kibble (Carno Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_Compy_C", "Kibble (Compy Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_Camelsaurus_C", "Kibble (Camelsaurus Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_DiloEgg_C", "Kibble (Dilo Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_DimetroEgg_C", "Kibble (Dimetrodon Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_DimorphEgg_C", "Kibble (Dimorph Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_DiploEgg_C", "Kibble (Diplo Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_DodoEgg_C", "Kibble (Dodo Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_GalliEgg_C", "Kibble (Gallimimus Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_KairukuEgg_C", "Kibble (Kairuku Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_LystroEgg_C", "Kibble (Lystrosaurus Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_Mantis_C", "Kibble (Mantis Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_Moth_C", "Kibble (Moth Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_PachyEgg_C", "Kibble (Pachy Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_ParaEgg_C", "Kibble (Parasaur Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_Pela_C", "Kibble (Pelagornis Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_PteroEgg_C", "Kibble (Pteranodon Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_ScorpionEgg_C", "Kibble (Pulmonoscorpius Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_QuetzEgg_C", "Kibble (Quetzal Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_RaptorEgg_C", "Kibble (Raptor Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_RexEgg_C", "Kibble (Rex Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_SarcoEgg_C", "Kibble (Sarco Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_SpinoEgg_C", "Kibble (Spino Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_StegoEgg_C", "Kibble (Stego Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_TerrorbirdEgg_C", "Kibble (Terror Bird Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_SpineyLizard_C", "Kibble (Thorny Dragon Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_BoaEgg_C", "Kibble (Titanboa Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_TrikeEgg_C", "Kibble (Trike Egg)")
		  Statement.SQLExecute("PrimalItemConsumable_Kibble_Vulture_C", "Kibble (Vulture Egg)")
		  
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Allo_C", "Allosaurus Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Ankylo_C", "Ankylo Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Spider_C", "Araneo Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Argent_C", "Argentavis Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Bronto_C", "Bronto Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Camelsaurus_C", "Camelsaurus Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Carno_C", "Carno Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Dilo_C", "Dilo Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Dimetrodon_C", "Dimetrodon Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Dimorph_C", "Dimorph Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Diplo_C", "Diplo Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Dodo_C", "Dodo Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Gigant_C", "Giganotosaurus Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Kairuku_C", "Kairuku Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Lystro_C", "Lystro Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Mantis_C", "Mantis Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Moth_C", "Moth Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Oviraptor_C", "Oviraptor Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Pachy_C", "Pachycephalosaurus Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Para_C", "Parasaur Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Pela_C", "Pelagornis Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Ptero_C", "Pteranodon Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Scorpion_C", "Pulmonoscorpius Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Quetz_C", "Quetzal Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Raptor_C", "Raptor Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Rex_C", "Rex Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Sarco_C", "Sarco Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Spino_C", "Spino Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Stego_C", "Stego Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Terrorbird_C", "Terror Bird Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_SpineyLizard_C", "Thorny Dragon Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Boa_C", "Titanboa Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Trike_C", "Trike Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Turtle_C", "Turtle Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Vulture_C", "Vulture Egg")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Wyvern_Fertilized_Fire_C", "Wyvern Egg Fire")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Wyvern_Fertilized_Lightning_C", "Wyvern Egg Lightning")
		  Statement.SQLExecute("PrimalItemConsumable_Egg_Wyvern_Fertilized_Poison_C", "Wyvern Egg Poison")
		  
		  Statement.SQLExecute("PrimalItemConsumable_DinoPoopSmall_C", "Small Animal Feces")
		  Statement.SQLExecute("PrimalItemConsumable_HumanPoop_C", "Human Feces")
		  Statement.SQLExecute("PrimalItemConsumable_DinoPoopMedium_C", "Medium Animal Feces")
		  Statement.SQLExecute("PrimalItemConsumable_DinoPoopLarge_C", "Large Animal Feces")
		  Statement.SQLExecute("PrimalItemConsumable_DinoPoopMassive_C", "Massive Animal Feces")
		  
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Amarberry_C", "Amarberry Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Citronal_C", "Citronal Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Azulberry_C", "Azulberry Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Tintoberry_C", "Tintoberry Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Mejoberry_C", "Mejoberry Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Narcoberry_C", "Narcoberry Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Stimberry_C", "Stimberry Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Savoroot_C", "Savoroot Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Longrass_C", "Longrass Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_Rockarrot_C", "Rockarrot Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_DefensePlant_C", "Plant Species X Seed")
		  Statement.SQLExecute("PrimalItemConsumable_Seed_PlantSpeciesY_C", "Plant Species Y Seed")
		  
		  Statement.SQLExecute("PrimalItem_WeaponGun_C", "Simple Pistol")
		  Statement.SQLExecute("PrimalItem_WeaponRifle_C", "Assault Rifle")
		  Statement.SQLExecute("PrimalItem_WeaponRocketLauncher_C", "Rocket Launcher")
		  Statement.SQLExecute("PrimalItem_WeaponBow_C", "Bow")
		  Statement.SQLExecute("PrimalItem_WeaponGrenade_C", "Grenade")
		  Statement.SQLExecute("PrimalItem_WeaponC4_C", "C4 Remote Detonator")
		  Statement.SQLExecute("PrimalItem_WeaponTripwireC4_C", "Improvised Explosive Device")
		  Statement.SQLExecute("PrimalItem_WeaponSpear_C", "Spear")
		  Statement.SQLExecute("PrimalItem_WeaponOneShotRifle_C", "Longneck Rifle")
		  Statement.SQLExecute("PrimalItem_WeaponSlingshot_C", "Slingshot")
		  Statement.SQLExecute("PrimalItem_WeaponPike_C", "Pike")
		  Statement.SQLExecute("PrimalItem_WeaponFlareGun_C", "Flare Gun")
		  Statement.SQLExecute("PrimalItem_WeaponMachinedPistol_C", "Fabricated Pistol")
		  Statement.SQLExecute("PrimalItem_WeaponShotgun_C", "Shotgun")
		  Statement.SQLExecute("PrimalItem_WeaponPoisonTrap_C", "Tripwire Narcotic Trap")
		  Statement.SQLExecute("PrimalItem_WeaponAlarmTrap_C", "Tripwire Alarm Trap")
		  Statement.SQLExecute("PrimalItem_WeaponMachinedShotgun_C", "Pump-Action Shotgun")
		  Statement.SQLExecute("PrimalItem_WeaponCrossbow_C", "Crossbow")
		  Statement.SQLExecute("PrimalItem_WeaponTransGPS_C", "Transponder Tracker")
		  Statement.SQLExecute("PrimalItem_WeaponCompoundBow_C", "Compound Bow")
		  Statement.SQLExecute("PrimalItemStructure_BearTrap_C", "Bear Trap")
		  Statement.SQLExecute("PrimalItemStructure_BearTrap_Large_C", "Large Bear Trap")
		  Statement.SQLExecute("PrimalItem_WeaponSprayPaint_C", "Spray Painter")
		  Statement.SQLExecute("PrimalItem_WeaponStoneClub_C", "Wooden Club")
		  Statement.SQLExecute("PrimalItem_PoisonGrenade_C", "Poison Grenade")
		  Statement.SQLExecute("PrimalItem_WeaponMachinedSniper_C", "Fabricated Sniper Rifle")
		  Statement.SQLExecute("PrimalItem_WeaponProd_C", "Electric Prod")
		  Statement.SQLExecute("PrimalItem_WeaponHandcuffs_C", "Handcuffs")
		  Statement.SQLExecute("PrimalItem_GasGrenade_C", "Smoke Grenade")
		  Statement.SQLExecute("PrimalItem_WeaponSword_C", "Metal Sword")
		  Statement.SQLExecute("PrimalItem_WeaponBola_C", "Bola")
		  Statement.SQLExecute("PrimalItemAmmo_ChainBola_C", "Chain Bola")
		  Statement.SQLExecute("PrimalItem_WeapFlamethrower_C", "Flamethrower")
		  Statement.SQLExecute("PrimalItem_WeaponBoomerang_C", "Boomerang")
		  Statement.SQLExecute("PrimalItem_WeaponClusterGrenade_C", "Cluster Grenade")
		  Statement.SQLExecute("PrimalItem_WeaponOilJar_C", "Oil Jar")
		  Statement.SQLExecute("PrimalItemStructure_PlantSpeciesYTrap_C", "Plant Species Y Trap")
		  Statement.SQLExecute("PrimalItemWeaponAttachment_Scope_C", "Scope Attachment")
		  Statement.SQLExecute("PrimalItemWeaponAttachment_Flashlight_C", "Flashlight Attachment")
		  Statement.SQLExecute("PrimalItemWeaponAttachment_Silencer_C", "Silencer Attachment")
		  Statement.SQLExecute("PrimalItemWeaponAttachment_HoloScope_C", "Holo-Scope Attachment")
		  Statement.SQLExecute("PrimalItemWeaponAttachment_Laser_C", "Laser Attachment")
		  
		  Statement.SQLExecute("PrimalItemAmmo_SimpleBullet_C", "Simple Bullet")
		  Statement.SQLExecute("PrimalItemAmmo_ArrowStone_C", "Stone Arrow")
		  Statement.SQLExecute("PrimalItemC4Ammo_C", "C4 Charge")
		  Statement.SQLExecute("PrimalItemAmmo_ArrowTranq_C", "Tranquilizer Arrow")
		  Statement.SQLExecute("PrimalItemAmmo_SimpleRifleBullet_C", "Simple Rifle Ammo")
		  Statement.SQLExecute("PrimalItemAmmo_AdvancedBullet_C", "Advanced Bullet")
		  Statement.SQLExecute("PrimalItemAmmo_AdvancedRifleBullet_C", "Advanced Rifle Bullet")
		  Statement.SQLExecute("PrimalItemAmmo_Rocket_C", "Rocket Propelled Grenade")
		  Statement.SQLExecute("PrimalItemAmmo_SimpleShotgunBullet_C", "Simple Shotgun Ammo")
		  Statement.SQLExecute("PrimalItemTransGPSAmmo_C", "Transponder Node")
		  Statement.SQLExecute("PrimalItemAmmo_CompoundBowArrow_C", "Metal Arrow")
		  Statement.SQLExecute("PrimalItemAmmo_BallistaArrow_C", "Ballista Bolt")
		  Statement.SQLExecute("PrimalItemAmmo_TranqDart_C", "Tranquilizer Dart")
		  Statement.SQLExecute("PrimalItemAmmo_AdvancedSniperBullet_C", "Advanced Sniper Bullet")
		  Statement.SQLExecute("PrimalItemAmmo_Boulder_C", "Boulder")
		  Statement.SQLExecute("PrimalItemAmmo_GrapplingHook_C", "Grappling Hook")
		  Statement.SQLExecute("PrimalItemAmmo_CannonBall_C", "Cannon Ball")
		  Statement.SQLExecute("PrimalItemAmmo_ArrowFlame_C", "Flame Arrow")
		  Statement.SQLExecute("PrimalItemAmmo_Flamethrower_C", "Flamethrower Ammo")
		  Statement.SQLExecute("PrimalItemAmmo_RocketHomingMissile_C", "Rocket Homing Missile")
		  
		  Statement.SQLExecute("PrimalItemArmor_HideHelmetAlt_C", "Hunter Hat Skin")
		  Statement.SQLExecute("PrimalItemArmor_RexSaddle_StompedGlasses_C", "Rex Stomped Glasses Saddle Skin")
		  Statement.SQLExecute("PrimalItemArmor_ParaSaddle_Launch_C", "Parasaur ARK Founder Saddle Skin")
		  Statement.SQLExecute("PrimalItemSkin_BoneHelmet_C", "Rex Bone Helmet")
		  Statement.SQLExecute("PrimalItemSkin_Glasses_C", "Nerdry Glasses")
		  Statement.SQLExecute("PrimalItemSkin_DinoSpecs_C", "Dino Glasses")
		  Statement.SQLExecute("PrimalItemSkin_FlaregunFireworks_C", "Fireworks Flaregun Skin")
		  Statement.SQLExecute("PrimalItemSkin_TrikeSkullHelmet_C", "Trike Bone Helmet Skin")
		  Statement.SQLExecute("PrimalItemSkin_DodorexMask_C", "DodoRex Mask Skin")
		  Statement.SQLExecute("PrimalItemSkin_WitchHat_C", "Witch Hat Skin")
		  Statement.SQLExecute("PrimalItemSkin_DinoWitchHat_C", "Dino Witch Hat Skin")
		  Statement.SQLExecute("PrimalItemCostume_BoneCarno_C", "Carno Bone Costume")
		  Statement.SQLExecute("PrimalItemCostume_BoneRaptor_C", "Raptor Bone Costume")
		  Statement.SQLExecute("PrimalItemCostume_BoneRex_C", "Rex Bone Costume")
		  Statement.SQLExecute("PrimalItemCostume_BoneSauro_C", "Bronto Bone Costume")
		  Statement.SQLExecute("PrimalItemCostume_BoneStego_C", "Stego Bone Costume")
		  Statement.SQLExecute("PrimalItemCostume_BoneTrike_C", "Trike Bone Costume")
		  Statement.SQLExecute("PrimalItemSkin_TurkeyHat_C", "Chieftan Hat Skin")
		  Statement.SQLExecute("PrimalItemSkin_SantaHat_C", "Santa Hat Skin")
		  Statement.SQLExecute("PrimalItemSkin_DinoSantaHat_C", "Dino Santa Hat Skin")
		  Statement.SQLExecute("PrimalItemSkin_CandyClub_C", "Candy Cane Club Skin")
		  Statement.SQLExecute("PrimalItemSkin_TopHat_C", "Top Hat Skin")
		  Statement.SQLExecute("PrimalItemCostume_ReindeerStag_C", "Megaloceros Reindeer Costume")
		  Statement.SQLExecute("PrimalItemSkin_BunnyHat_C", "Bunny Ears Skin")
		  Statement.SQLExecute("PrimalItemSkin_DinoBunnyHat_C", "Dino Bunny Ears Skin")
		  Statement.SQLExecute("PrimalItemCostume_ProcopBunny_C", "Procoptodon Bunny Costume")
		  Statement.SQLExecute("PrimalItemSkin_DinoPartyHat_C", "Dino Party Hat Skin")
		  Statement.SQLExecute("PrimalItemSkin_PartyHat_C", "Party Hat Skin")
		  Statement.SQLExecute("PrimalItemSkin_BirthdayPants_C", "Birthday Suit Pants Skin")
		  Statement.SQLExecute("PrimalItemSkin_BirthdayShirt_C", "Birthday Suit Shirt Skin")
		  Statement.SQLExecute("PrimalItemSkin_RocketLauncherFireworks_C", "Fireworks Rocket Launcher Skin")
		  Statement.SQLExecute("PrimalItemSkin_TorchSparkler_C", "Torch Sparkler Skin")
		  Statement.SQLExecute("PrimalItemArmor_SpineyLizardPromoSaddle_C", "ARK Thorny Dragon Saddle Skin")
		  Statement.SQLExecute("PrimalItemSkin_ManticoreHelmet_C", "Manticore Helmet Skin")
		  Statement.SQLExecute("PrimalItemSkin_ManticoreShield_C", "Manticore Shield Skin")
		  Statement.SQLExecute("PrimalItemSkin_WyvernGloves_C", "Wyvern Gloves Skin")
		  Statement.SQLExecute("PrimalItemSkin_ScorchedSpear_C", "Scorched Spike Skin")
		  Statement.SQLExecute("PrimalItemSkin_ScorchedSword_C", "Scorched Sword Skin")
		  Statement.SQLExecute("PrimalItemSkin_TorchScorched_C", "Scorched Torch Skin")
		  Statement.SQLExecute("PrimalItemSkin_ExplorerHat_C", "Safari Hat Skin")
		  
		  Statement.SQLExecute("PrimalItem_StartingNote_C", "Specimen Implant")
		  Statement.SQLExecute("PrimalItemArtifact_01_C", "Artifact Of The Hunter")
		  Statement.SQLExecute("PrimalItemArtifact_02_C", "Artifact Of The Pack")
		  Statement.SQLExecute("PrimalItemArtifact_03_C", "Artifact Of The Massive")
		  Statement.SQLExecute("PrimalItemArtifact_05_C", "Artifact Of The Clever")
		  Statement.SQLExecute("PrimalItemArtifact_06_C", "Artifact Of The Skylord")
		  Statement.SQLExecute("PrimalItemArtifact_07_C", "Artifact Of The Devourer")
		  Statement.SQLExecute("PrimalItemArtifact_08_C", "Artifact Of The Immune")
		  Statement.SQLExecute("PrimalItemArtifact_09_C", "Artifact Of The Strong")
		  Statement.SQLExecute("PrimalItemArtifactSE_01_C", "Artifact Of The Gatekeeper")
		  Statement.SQLExecute("PrimalItemArtifactSE_02_C", "Artifact Of The Crag")
		  Statement.SQLExecute("PrimalItemArtifactSE_03_C", "Artifact Of The Destroyer")
		  Statement.SQLExecute("PrimalItemResource_ApexDrop_Argentavis_C", "Argentavis Talon")
		  Statement.SQLExecute("PrimalItemResource_ApexDrop_Megalodon_C", "Megalodon Tooth")
		  Statement.SQLExecute("PrimalItemResource_ApexDrop_Rex_C", "Tyrannosaurus Arm")
		  Statement.SQLExecute("PrimalItemResource_ApexDrop_Sauro_C", "Sauropod Vertebra")
		  Statement.SQLExecute("PrimalItemResource_ApexDrop_FireWyvern_C", "Fire Talon")
		  Statement.SQLExecute("PrimalItemResource_ApexDrop_LightningWyvern_C", "Lightning Talon")
		  Statement.SQLExecute("PrimalItemResource_ApexDrop_PoisonWyvern_C", "Poison Talon")
		  
		  Statement.SQLExecute("PrimalItemArmor_NightVisionGoggles_C", "Night Vision Goggles")
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UpdateToVersion2() As Boolean
		  Self.SQLExecute("CREATE TABLE ""beacons"" (""classstring"" TEXT NOT NULL PRIMARY KEY, ""label"" TEXT NOT NULL);")
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("INSERT INTO ""beacons"" (""classstring"", ""label"") VALUES (?, ?);")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  Statement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  // The Island + The Center
		  
		  Statement.SQLExecute("SupplyCrate_Level03_C", "Island White (Level 3)")
		  Statement.SQLExecute("SupplyCrate_Level03_Double_C", "Island White + Bonus (Level 3)")
		  Statement.SQLExecute("SupplyCrate_Level15_C", "Island Green (Level 15)")
		  Statement.SQLExecute("SupplyCrate_Level15_Double_C", "Island Green + Bonus (Level 15)")
		  Statement.SQLExecute("SupplyCrate_Level25_C", "Island Blue (Level 25)")
		  Statement.SQLExecute("SupplyCrate_Level25_Double_C", "Island Blue + Bonus (Level 25)")
		  Statement.SQLExecute("SupplyCrate_Level35_C", "Island Purple (Level 35)")
		  Statement.SQLExecute("SupplyCrate_Level35_Double_C", "Island Purple + Bonus (Level 35)")
		  Statement.SQLExecute("SupplyCrate_Level45_C", "Island Yellow (Level 45)")
		  Statement.SQLExecute("SupplyCrate_Level45_Double_C", "Island Yellow + Bonus (Level 45)")
		  Statement.SQLExecute("SupplyCrate_Level60_C", "Island Red (Level 60)")
		  Statement.SQLExecute("SupplyCrate_Level60_Double_C", "Island Red + Bonus (Level 60)")
		  
		  Statement.SQLExecute("SupplyCrate_Cave_QualityTier1_C", "Island Cave Tier 1")
		  Statement.SQLExecute("SupplyCrate_Cave_QualityTier2_C", "Island Cave Tier 2")
		  Statement.SQLExecute("SupplyCrate_Cave_QualityTier3_C", "Island Cave Tier 3")
		  Statement.SQLExecute("SupplyCrate_Cave_QualityTier4_C", "Island Cave Tier 4")
		  Statement.SQLExecute("SupplyCrate_SwampCaveTier1_C", "Island Swamp Cave Blue")
		  Statement.SQLExecute("SupplyCrate_SwampCaveTier2_C", "Island Swamp Cave Yellow")
		  Statement.SQLExecute("SupplyCrate_SwampCaveTier3_C", "Island Swamp Cave Red")
		  Statement.SQLExecute("SupplyCrate_IceCaveTier1_C", "Island Ice Cave Blue")
		  Statement.SQLExecute("SupplyCrate_IceCaveTier2_C", "Island Ice Cave Yellow")
		  Statement.SQLExecute("SupplyCrate_IceCaveTier3_C", "Island Ice Cave Red")
		  Statement.SQLExecute("SupplyCrate_OceanInstant_C", "Island Deep Sea")
		  Statement.SQLExecute("ArtifactCrate_1_C", "Island Artifact Hunter")
		  Statement.SQLExecute("ArtifactCrate_2_C", "Island Artifact Pack")
		  Statement.SQLExecute("ArtifactCrate_3_C", "Island Artifact Massive")
		  Statement.SQLExecute("ArtifactCrate_4_C", "Island Artifact Devious")
		  Statement.SQLExecute("ArtifactCrate_5_C", "Island Artifact Clever")
		  Statement.SQLExecute("ArtifactCrate_6_C", "Island Artifact Skylord")
		  Statement.SQLExecute("ArtifactCrate_7_C", "Island Artifact Devourer")
		  Statement.SQLExecute("ArtifactCrate_8_C", "Island Artifact Immune")
		  Statement.SQLExecute("ArtifactCrate_9_C", "Island Artifact Strong")
		  
		  // Scorched Earth
		  
		  Statement.SQLExecute("SupplyCrate_Level03_ScorchedEarth_C", "Scorched White (Level 3)")
		  Statement.SQLExecute("SupplyCrate_Level03_Double_ScorchedEarth_C", "Scorched White + Bonus (Level 3)")
		  Statement.SQLExecute("SupplyCrate_Level15_ScorchedEarth_C", "Scorched Green (Level 15)")
		  Statement.SQLExecute("SupplyCrate_Level15_Double_ScorchedEarth_C", "Scorched Green + Bonus (Level 15)")
		  Statement.SQLExecute("SupplyCrate_Level30_ScorchedEarth_C", "Scorched Blue (Level 30)")
		  Statement.SQLExecute("SupplyCrate_Level30_Double_ScorchedEarth_C", "Scorched Blue + Bonus (Level 30)")
		  Statement.SQLExecute("SupplyCrate_Level45_ScorchedEarth_C", "Scorched Purple (Level 45)")
		  Statement.SQLExecute("SupplyCrate_Level45_Double_ScorchedEarth_C", "Scorched Purple + Bonus (Level 45)")
		  Statement.SQLExecute("SupplyCrate_Level55_ScorchedEarth_C", "Scorched Yellow (Level 55)")
		  Statement.SQLExecute("SupplyCrate_Level55_Double_ScorchedEarth_C", "Scorched Yellow + Bonus (Level 55)")
		  Statement.SQLExecute("SupplyCrate_Level70_ScorchedEarth_C", "Scorched Red (Level 70)")
		  Statement.SQLExecute("SupplyCrate_Level70_Double_ScorchedEarth_C", "Scorched Red + Bonus (Level 70)")
		  
		  Statement.SQLExecute("SupplyCrate_Cave_QualityTier1_ScorchedEarth_C", "Scorched Cave Tier 1")
		  Statement.SQLExecute("SupplyCrate_Cave_QualityTier2_ScorchedEarth_C", "Scorched Cave Tier 2")
		  Statement.SQLExecute("SupplyCrate_Cave_QualityTier3_ScorchedEarth_C", "Scorched Cave Tier 3")
		  Statement.SQLExecute("ArtifactCrate_SE_C", "Scorched Artifact Destroyer")
		  Statement.SQLExecute("ArtifactCrate_2_SE_C", "Scorched Artifact Gatekeeper")
		  Statement.SQLExecute("ArtifactCrate_3_SE_C", "Scorched Artifact Crag")
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Constant, Name = CurrentVersion, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="DatabaseFile"
			Visible=true
			Type="FolderItem"
			EditorType="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugMode"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EncryptionKey"
			Visible=true
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LoadExtensions"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MultiUser"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShortColumnNames"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadYieldInterval"
			Visible=true
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Timeout"
			Visible=true
			Type="Double"
			EditorType="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
