#tag Class
Protected Class LocalData
Implements Beacon.DataSource
	#tag Method, Flags = &h1
		Protected Function BuiltinPresetsFolder() As FolderItem
		  Return App.ResourcesFolder.Child("Presets")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mBase = New SQLiteDatabase
		  Self.mBase.DatabaseFile = App.ApplicationSupport.Child("Beacon.sqlite")
		  
		  If Self.mBase.DatabaseFile.Exists Then
		    If Not Self.mBase.Connect Then
		      Return
		    End If
		  Else
		    If Not Self.mBase.CreateDatabaseFile Then
		      Return
		    End If
		  End If
		  
		  Self.mBase.SQLExecute("PRAGMA foreign_keys = ON;")
		  Self.mBase.SQLExecute("PRAGMA journal_mode = WAL;")
		  
		  Dim RS As RecordSet = Self.mBase.SQLSelect("PRAGMA user_version;")
		  Dim Version As Integer = RS.IdxField(1).IntegerValue
		  While Version < Self.CurrentVersion
		    If Not Self.UpdateToVersion(Version + 1) Then
		      Return
		    End If
		    
		    Version = Version + 1
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CustomPresetsFolder() As FolderItem
		  Dim SupportFolder As FolderItem = App.ApplicationSupport
		  Dim PresetsFolder As FolderItem = SupportFolder.Child("Presets")
		  If PresetsFolder.Exists Then
		    If Not PresetsFolder.Directory Then
		      PresetsFolder.Delete
		      PresetsFolder.CreateAsFolder
		    End If
		  Else
		    PresetsFolder.CreateAsFolder
		  End If
		  Return PresetsFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Describe(Entry As Beacon.SetEntry) As String
		  If UBound(Entry) = -1 Then
		    Return "No Items"
		  ElseIf UBound(Entry) = 0 Then
		    Return Self.NameOfEngram(Entry(0).ClassString)
		  Else
		    Dim TotalWeight As Double
		    For I As Integer = 0 To UBound(Entry)
		      TotalWeight = TotalWeight + Entry(I).Weight
		    Next
		    
		    Dim Labels() As String
		    For I As Integer = 0 To UBound(Entry)
		      Labels.Append(Self.NameOfEngram(Entry(I).ClassString) + ":" + Str(Entry(I).Weight / TotalWeight, "0%"))
		    Next
		    Return Join(Labels, ", ")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FileForCustomPreset(Preset As Beacon.Preset) As FolderItem
		  Return Self.CustomPresetsFolder.Child(Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleError(SQLString As String, ErrorCode As Integer, ErrorMessage As String)
		  #Pragma Unused ErrorCode
		  
		  Dim Err As New UnsupportedOperationException
		  Err.Message = ErrorMessage + "EndOfLine" + SQLString
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Return File.Exists
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  Dim Folders(1) As FolderItem
		  Folders(0) = Self.BuiltinPresetsFolder
		  Folders(1) = Self.CustomPresetsFolder
		  
		  Dim Extension As String = BeaconFileTypes.BeaconPreset.PrimaryExtension
		  Dim ExtensionLength As Integer = Len(Extension)
		  
		  Redim Self.mPresets(-1)
		  Dim Names() As String
		  
		  For Each Folder As FolderItem In Folders
		    For I As Integer = 1 To Folder.Count
		      Dim File As FolderItem = Folder.Item(I)
		      If Right(File.Name, ExtensionLength) <> Extension Then
		        Continue For I
		      End If
		      
		      Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(New Xojo.IO.FolderItem(File.NativePath.ToText))
		      If Preset <> Nil Then
		        Dim Idx As Integer = Names.IndexOf(Preset.Label)
		        If Idx > -1 Then
		          Self.mPresets(Idx) = Preset
		        Else
		          Self.mPresets.Append(Preset)
		          Names.Append(Preset.Label)
		        End If
		      End If
		    Next
		  Next
		  
		  Names.SortWith(Self.mPresets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MultipliersForLootSource(ClassString As Text) As Beacon.Range
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""minmult"", ""maxmult"" FROM ""loot_sources"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = ClassString
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return New Beacon.Range(1, 1)
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return New Beacon.Range(1, 1)
		  End If
		  
		  Return New Beacon.Range(RS.Field("minmult").DoubleValue, RS.Field("maxmult").DoubleValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfEngram(ClassString As Text) As Text
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"" FROM ""engrams"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = ClassString
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return ClassString
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return ClassString
		  End If
		  
		  Return RS.Field("label").StringValue.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfLootSource(ClassString As Text) As Text
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"" FROM ""loot_sources"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = ClassString
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return ClassString
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return ClassString
		  End If
		  
		  Return RS.Field("label").StringValue.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Prepare(SQLString As String) As SQLitePreparedStatement
		  Dim Statement As SQLitePreparedStatement = Self.mBase.Prepare(SQLString)
		  If Self.mBase.Error Then
		    Self.HandleError(SQLString, Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		    Return Nil
		  End If
		  Return Statement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  Dim Results() As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    Results.Append(New Beacon.Preset(Preset))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePreset(Preset As Beacon.Preset)
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  If File.Exists Then
		    File.Delete
		    Self.LoadPresets
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePreset(Preset As Beacon.Preset)
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Preset.ToFile(New Xojo.IO.FolderItem(File.NativePath.ToText))
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(SearchText As Text) As Beacon.Engram()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Results() As Beacon.Engram
		  
		  Dim RS As RecordSet
		  Try
		    If SearchText = "" Then
		      RS = Self.SQLSelect("SELECT ""label"", ""classstring"" FROM ""engrams"" ORDER BY ""label"";")
		    Else
		      Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"", ""classstring"" FROM ""engrams"" WHERE LOWER(""label"") LIKE LOWER(?1) OR LOWER(""classstring"") LIKE LOWER(?1) ORDER BY ""label"";")
		      Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      
		      Dim StringValue As String = SearchText
		      RS = Self.SQLSelect(Statement, "%" + StringValue + "%")
		    End If
		  Catch Err As UnsupportedOperationException
		    Return Results()
		  End Try
		  If RS = Nil Then
		    Return Results()
		  End If
		  
		  while Not RS.EOF
		    Results.Append(New Beacon.Engram(RS.Field("label").StringValue.ToText, RS.Field("classstring").StringValue.ToText))
		    RS.MoveNext
		  wend
		  
		  Return Results()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As Text) As Beacon.LootSource()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Results() As Beacon.LootSource
		  
		  Dim RS As RecordSet
		  Try
		    If SearchText = "" Then
		      RS = Self.SQLSelect("SELECT ""label"", ""classstring"" FROM ""loot_sources"" ORDER BY ""label"";")
		    Else
		      Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"", ""classstring"" FROM ""loot_sources"" WHERE LOWER(""label"") LIKE LOWER(?1) OR LOWER(""classstring"") LIKE LOWER(?1) ORDER BY ""label"";")
		      Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      
		      Dim StringValue As String = SearchText
		      RS = Self.SQLSelect(Statement, "%" + StringValue + "%")
		    End If
		  Catch Err As UnsupportedOperationException
		    Return Results()
		  End Try
		  If RS = Nil Then
		    Return Results()
		  End If
		  
		  while Not RS.EOF
		    Results.Append(New Beacon.LootSource(RS.Field("label").StringValue.ToText, RS.Field("classstring").StringValue.ToText))
		    RS.MoveNext
		  wend
		  
		  Return Results()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance() As LocalData
		  If mSharedInstance = Nil Then
		    mSharedInstance = New LocalData
		  End If
		  Return mSharedInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SQLExecute(Statement As SQLitePreparedStatement, ParamArray Values() As Variant)
		  For I As Integer = 0 To UBound(Values)
		    Statement.Bind(I, Values(I))
		  Next
		  Statement.SQLExecute()
		  If Self.mBase.Error Then
		    Self.HandleError("Statement", Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SQLExecute(SQLString As String)
		  Self.mBase.SQLExecute(SQLString)
		  If Self.mBase.Error Then
		    Self.HandleError(SQLString, Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SQLSelect(Statement As SQLitePreparedStatement, ParamArray Values() As Variant) As RecordSet
		  For I As Integer = 0 To UBound(Values)
		    Statement.Bind(I, Values(I))
		  Next
		  Dim RS As RecordSet = Statement.SQLSelect()
		  If Self.mBase.Error Then
		    Self.HandleError("Statement", Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		    Return Nil
		  End If
		  Return RS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SQLSelect(SQLString As String) As RecordSet
		  Dim RS As RecordSet = Self.mBase.SQLSelect(SQLString)
		  If Self.mBase.Error Then
		    Self.HandleError(SQLString, Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		    Return Nil
		  End If
		  Return RS
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
		  Dim Success As Boolean
		  Try
		    Success = MethodDef.Invoke(Self)
		  Catch Err As RuntimeException
		    Success = False
		  End Try
		  If Success Then
		    Self.SQLExecute("COMMIT TRANSACTION")
		    Self.SQLExecute("PRAGMA user_version = " + Str(Version) + ";")
		  Else
		    Self.SQLExecute("ROLLBACK TRANSACTION")
		  End If
		  Return Success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UpdateToVersion1() As Boolean
		  Self.SQLExecute("CREATE TABLE ""engrams"" (""classstring"" TEXT NOT NULL PRIMARY KEY, ""label"" TEXT NOT NULL);")
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("INSERT INTO ""engrams"" (""classstring"", ""label"") VALUES (?, ?);")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  Statement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Self.SQLExecute(Statement, "PrimalItemTrophy_AlphaRex_C", "Alpha Rex Trophy")
		  Self.SQLExecute(Statement, "PrimalItemTrophy_Broodmother_C", "Broodmother Trophy")
		  Self.SQLExecute(Statement, "PrimalItemTrophy_Gorilla_C", "Megapithecus Trophy")
		  Self.SQLExecute(Statement, "PrimalItemTrophy_Dragon_C", "Dragon Trophy")
		  Self.SQLExecute(Statement, "PrimalItemTrophy_Manticore_C", "Manticore Trophy")
		  
		  Self.SQLExecute(Statement, "PrimalItem_Note_C", "Note")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_BattleTartare_C", "Recipe: Battle Tartare")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_CalienSoup_C", "Recipe: Calien Soup")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_EnduroStew_C", "Recipe: Enduro Stew")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_StaminaSoup_C", "Recipe: Energy Brew")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_FocalChili_C", "Recipe: Focal Chili")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_FriaCurry_C", "Recipe: Fria Curry")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_LazarusChowder_C", "Recipe: Lazarus Chowder")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_HealSoup_C", "Recipe: Medical Brew")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_RespecSoup_C", "Recipe: Mindwipe Tonic")
		  Self.SQLExecute(Statement, "PrimalItem_RecipeNote_ShadowSteak_C", "Recipe: Shadow Steak Sauté")
		  
		  Self.SQLExecute(Statement, "PrimalItemArmor_RexSaddle_C", "Rex Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ParaSaddle_C", "Parasaur Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RaptorSaddle_C", "Raptor Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_StegoSaddle_C", "Stego Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_TrikeSaddle_C", "Trike Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ScorpionSaddle_C", "Pulmonoscorpius Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_PteroSaddle_C", "Pteranodon Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SauroSaddle_C", "Bronto Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_TurtleSaddle_C", "Carbonemys Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SarcoSaddle_C", "Sarco Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_AnkyloSaddle_C", "Ankylo Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MammothSaddle_C", "Mammoth Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MegalodonSaddle_C", "Megalodon Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SaberSaddle_C", "Sabertooth Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_CarnoSaddle_C", "Carno Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ArgentavisSaddle_C", "Argentavis Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_PhiomiaSaddle_C", "Phiomia Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SpinoSaddle_C", "Spino Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_PlesiaSaddle_C", "Plesiosaur Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DolphinSaddle_C", "Ichthyosaurus Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DoedSaddle_C", "Doedicurus Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SauroSaddle_Platform_C", "Bronto Platform Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_PachySaddle_C", "Pachy Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_Paracer_Saddle_C", "Paracer Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ParacerSaddle_Platform_C", "Paracer Platform Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ToadSaddle_C", "Beelzebufo Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_StagSaddle_C", "Megaloceros Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_PlesiSaddle_Platform_C", "Plesiosaur Platform Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_QuetzSaddle_Platform_C", "Quetz Platform Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MosaSaddle_Platform_C", "Mosasaur Platform Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MosaSaddle_C", "Mosasaur Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_QuetzSaddle_C", "Quetz Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SpiderSaddle_C", "Araneo Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_GigantSaddle_C", "Giganotosaurus Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ProcoptodonSaddle_C", "Procoptodon Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_Gallimimus_C", "Gallimimus Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_TerrorBirdSaddle_C", "Terror Bird Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_BeaverSaddle_C", "Castoroides Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RhinoSaddle_C", "Woolly Rhino Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DunkleosteusSaddle_C", "Dunkleosteus Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DireBearSaddle_C", "Direbear Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MantaSaddle_C", "Manta Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ArthroSaddle_C", "Arthropluera Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DiplodocusSaddle_C", "Diplodocus Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_TitanSaddle_Platform_C", "Titanosaur Platform Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_PelaSaddle_C", "Pelagornis Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_AlloSaddle_C", "Allosaurus Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_CamelsaurusSaddle_C", "Morellatops Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MantisSaddle_C", "Mantis Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MothSaddle_C", "Lymantria Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RockGolemSaddle_C", "Rock Golem Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SpineyLizardSaddle_C", "Thorny Dragon Saddle")
		  Self.SQLExecute(Statement, "PrimalItemArmor_TapejaraSaddle_C", "Tapejara Saddle")
		  
		  Self.SQLExecute(Statement, "PrimalItemResource_Wood_C", "Wood")
		  Self.SQLExecute(Statement, "PrimalItemResource_Stone_C", "Stone")
		  Self.SQLExecute(Statement, "PrimalItemResource_Metal_C", "Metal")
		  Self.SQLExecute(Statement, "PrimalItemResource_Hide_C", "Hide")
		  Self.SQLExecute(Statement, "PrimalItemResource_Chitin_C", "Chitin")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_BloodPack_C", "Blood Pack")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Fertilizer_Compost_C", "Fertilizer")
		  Self.SQLExecute(Statement, "PrimalItemResource_Flint_C", "Flint")
		  Self.SQLExecute(Statement, "PrimalItemResource_MetalIngot_C", "Metal Ingot")
		  Self.SQLExecute(Statement, "PrimalItemResource_Thatch_C", "Thatch")
		  Self.SQLExecute(Statement, "PrimalItemResource_Fibers_C", "Fiber")
		  Self.SQLExecute(Statement, "PrimalItemResource_Charcoal_C", "Charcoal")
		  Self.SQLExecute(Statement, "PrimalItemResource_Crystal_C", "Crystal")
		  Self.SQLExecute(Statement, "PrimalItemResource_Sparkpowder_C", "Sparkpowder")
		  Self.SQLExecute(Statement, "PrimalItemResource_Gunpowder_C", "Gunpowder")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Narcotic_C", "Narcotic")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Stimulant_C", "Stimulant")
		  Self.SQLExecute(Statement, "PrimalItemResource_Obsidian_C", "Obsidian")
		  Self.SQLExecute(Statement, "PrimalItemResource_ChitinPaste_C", "Cementing Paste")
		  Self.SQLExecute(Statement, "PrimalItemResource_Oil_C", "Oil")
		  Self.SQLExecute(Statement, "PrimalItemResource_Silicon_C", "Silica Pearls")
		  Self.SQLExecute(Statement, "PrimalItemResource_Gasoline_C", "Gasoline")
		  Self.SQLExecute(Statement, "PrimalItemResource_Electronics_C", "Electronics")
		  Self.SQLExecute(Statement, "PrimalItemResource_Polymer_C", "Polymer")
		  Self.SQLExecute(Statement, "PrimalItemResource_Keratin_C", "Keratin")
		  Self.SQLExecute(Statement, "PrimalItemResource_RareFlower_C", "Rare Flower")
		  Self.SQLExecute(Statement, "PrimalItemResource_RareMushroom_C", "Rare Mushroom")
		  Self.SQLExecute(Statement, "PrimalItemConsumableMiracleGro_C", "Re-Fertilizer")
		  Self.SQLExecute(Statement, "PrimalItemResource_Pelt_C", "Pelt")
		  Self.SQLExecute(Statement, "PrimalItemResource_Polymer_Organic_C", "Organic Polymer")
		  Self.SQLExecute(Statement, "PrimalItemResource_AnglerGel_C", "Angler Gel")
		  Self.SQLExecute(Statement, "PrimalItemResource_BlackPearl_C", "Black Pearl")
		  Self.SQLExecute(Statement, "PrimalItemResource_Horn_C", "Woolly Rhino Horn")
		  Self.SQLExecute(Statement, "PrimalItemResource_LeechBlood_C", "Leech Blood")
		  Self.SQLExecute(Statement, "PrimalItemResource_Sap_C", "Sap")
		  Self.SQLExecute(Statement, "PrimalItemResource_SubstrateAbsorbent_C", "Absorbent Substrate")
		  Self.SQLExecute(Statement, "PrimalItemResource_Clay_C", "Clay")
		  Self.SQLExecute(Statement, "PrimalItemResource_KeratinSpike_C", "Deathworm Horn")
		  Self.SQLExecute(Statement, "PrimalItemResource_PreservingSalt_C", "Preserving Salt")
		  Self.SQLExecute(Statement, "PrimalItemResource_Propellant_C", "Propellant")
		  Self.SQLExecute(Statement, "PrimalItemResource_RawSalt_C", "Raw Salt")
		  Self.SQLExecute(Statement, "PrimalItemResource_Sand_C", "Sand")
		  Self.SQLExecute(Statement, "PrimalItemResource_Silk_C", "Silk")
		  Self.SQLExecute(Statement, "PrimalItemResource_Sulfur_C", "Sulfur")
		  
		  Self.SQLExecute(Statement, "PrimalItem_WeaponStonePick_C", "Stone Pick")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponStoneHatchet_C", "Stone Hatchet")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponMetalPick_C", "Metal Pick")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponMetalHatchet_C", "Metal Hatchet")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponTorch_C", "Torch")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponPaintbrush_C", "Paintbrush")
		  Self.SQLExecute(Statement, "PrimalItem_BloodExtractor_C", "Blood Extraction Syringe")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponGPS_C", "GPS")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponCompass_C", "Compass")
		  Self.SQLExecute(Statement, "PrimalItemRadio_C", "Radio")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponSpyglass_C", "Spyglass")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponSickle_C", "Metal Sickle")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponMagnifyingGlass_C", "Magnifying Glass")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponFishingRod_C", "Fishing Rod")
		  Self.SQLExecute(Statement, "PrimalItem_ChainSaw_C", "Chainsaw")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponWhip_C", "Whip")
		  
		  Self.SQLExecute(Statement, "PrimalItemArmor_ClothPants_C", "Cloth Pants")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ClothShirt_C", "Cloth Shirt")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ClothHelmet_C", "Cloth Hat")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ClothBoots_C", "Cloth Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ClothGloves_C", "Cloth Gloves")
		  Self.SQLExecute(Statement, "PrimalItemArmor_HidePants_C", "Hide Pants")
		  Self.SQLExecute(Statement, "PrimalItemArmor_HideShirt_C", "Hide Shirt")
		  Self.SQLExecute(Statement, "PrimalItemArmor_HideHelmet_C", "Hide Hat")
		  Self.SQLExecute(Statement, "PrimalItemArmor_HideBoots_C", "Hide Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_HideGloves_C", "Hide Gloves")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ChitinPants_C", "Chitin Leggings")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ChitinShirt_C", "Chitin Chestpiece")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ChitinHelmet_C", "Chitin Helmet")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ChitinBoots_C", "Chitin Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ChitinGloves_C", "Chitin Gauntlets")
		  Self.SQLExecute(Statement, "PrimalItemConsumableBuff_Parachute_C", "Parachute")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MetalPants_C", "Flak Leggings")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MetalShirt_C", "Flak Chestpiece")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MetalHelmet_C", "Flak Helmet")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MetalBoots_C", "Flak Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MetalGloves_C", "Flak Gauntlets")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MinersHelmet_C", "Heavy Miner's Helmet")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ScubaShirt_SuitWithTank_C", "SCUBA Tank")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ScubaHelmet_Goggles_C", "SCUBA Mask")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ScubaBoots_Flippers_C", "SCUBA Flippers")
		  Self.SQLExecute(Statement, "PrimalItemArmor_FurPants_C", "Fur Leggings")
		  Self.SQLExecute(Statement, "PrimalItemArmor_FurShirt_C", "Fur Chestpiece")
		  Self.SQLExecute(Statement, "PrimalItemArmor_FurHelmet_C", "Fur Cap")
		  Self.SQLExecute(Statement, "PrimalItemArmor_FurBoots_C", "Fur Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_FurGloves_C", "Fur Gauntlets")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RiotPants_C", "Riot Leggings")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RiotShirt_C", "Riot Chestpiece")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RiotGloves_C", "Riot Gauntlets")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RiotBoots_C", "Riot Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RiotHelmet_C", "Riot Helmet")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ScubaPants_C", "SCUBA Leggings")
		  Self.SQLExecute(Statement, "PrimalItemArmor_WoodShield_C", "Wooden Shield")
		  Self.SQLExecute(Statement, "PrimalItemArmor_MetalShield_C", "Metal Shield")
		  Self.SQLExecute(Statement, "PrimalItemArmor_TransparentRiotShield_C", "Riot Shield")
		  Self.SQLExecute(Statement, "PrimalItemArmor_GhillieBoots_C", "Ghillie Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_GhillieShirt_C", "Ghillie Chestpiece")
		  Self.SQLExecute(Statement, "PrimalItemArmor_GhillieGloves_C", "Ghillie Gauntlets")
		  Self.SQLExecute(Statement, "PrimalItemArmor_GhilliePants_C", "Ghillie Leggings")
		  Self.SQLExecute(Statement, "PrimalItemArmor_GhillieHelmet_C", "Ghillie Mask")
		  Self.SQLExecute(Statement, "PrimalItemArmor_GasMask_C", "Gas Mask")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DesertClothBoots_C", "Desert Cloth Boots")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DesertClothGloves_C", "Desert Cloth Gloves")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DesertClothGogglesHelmet_C", "Desert Goggles and Hat")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DesertClothPants_C", "Desert Cloth Pants")
		  Self.SQLExecute(Statement, "PrimalItemArmor_DesertClothShirt_C", "Desert Cloth Shirt")
		  
		  Self.SQLExecute(Statement, "PrimalItemStructure_Campfire_C", "Campfire")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StandingTorch_C", "Standing Torch")
		  Self.SQLExecute(Statement, "PrimalItemStructure_SleepingBag_Hide_C", "Hide Sleeping Bag")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchCeiling_C", "Thatch Roof")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchDoor_C", "Thatch Door")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchFloor_C", "Thatch Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchWall_C", "Thatch Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchWallWithDoor_C", "Thatch Doorframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodCatwalk_C", "Wooden Catwalk")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodCeiling_C", "Wooden Ceiling")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodCeilingWithTrapdoor_C", "Wooden Hatchframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodDoor_C", "Wooden Door")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodFloor_C", "Wooden Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodLadder_C", "Wooden Ladder")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodPillar_C", "Wooden Pillar")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodRamp_C", "Wooden Ramp")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodTrapdoor_C", "Wooden Trapdoor")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodWall_C", "Wooden Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodWallWithDoor_C", "Wooden Doorframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodWallWithWindow_C", "Wooden Windowframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodWindow_C", "Wooden Window")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodSign_C", "Wooden Sign")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StorageBox_Small_C", "Storage Box")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StorageBox_Large_C", "Large Storage Box")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MortarAndPestle_C", "Mortar And Pestle")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StonePipeIntake_C", "Stone Irrigation Pipe - Intake")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StonePipeStraight_C", "Stone Irrigation Pipe - Straight")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StonePipeIncline_C", "Stone Irrigation Pipe - Inclined")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StonePipeIntersection_C", "Stone Irrigation Pipe - Intersection")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StonePipeVertical_C", "Stone Irrigation Pipe - Vertical")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StonePipeTap_C", "Stone Irrigation Pipe - Tap")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Forge_C", "Refining Forge")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AnvilBench_C", "Smithy")
		  Self.SQLExecute(Statement, "PrimalItemStructure_CompostBin_C", "Compost Bin")
		  Self.SQLExecute(Statement, "PrimalItemStructure_CookingPot_C", "Cooking Pot")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Bed_Simple_C", "Simple Bed")
		  Self.SQLExecute(Statement, "PrimalItemStructure_CropPlot_Small_C", "Small Crop Plot")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodFenceFoundation_C", "Wooden Fence Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodGateframe_C", "Dinosaur Gateway")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodGate_C", "Dinosaur Gate")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalCatwalk_C", "Metal Catwalk")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalCeiling_C", "Metal Ceiling")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalCeilingWithTrapdoor_C", "Metal Hatchframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalDoor_C", "Metal Door")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalFenceFoundation_C", "Metal Fence Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalFloor_C", "Metal Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalGate_Large_C", "Behemoth Gate")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalGateframe_Large_C", "Behemoth Gateway")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalLadder_C", "Metal Ladder")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalPillar_C", "Metal Pillar")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalRamp_C", "Metal Ramp")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalTrapdoor_C", "Metal Trapdoor")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalWall_C", "Metal Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalWallWithDoor_C", "Metal Doorframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalWallWithWindow_C", "Metal Windowframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalWindow_C", "Metal Window")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Fabricator_C", "Fabricator")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WaterTank_C", "Water Reservoir")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AirConditioner_C", "Air Conditioner")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PowerGenerator_C", "Electrical Generator")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PowerOutlet_C", "Electrical Outlet")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PowerCableIncline_C", "Inclined Electrical Cable")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PowerCableIntersection_C", "Electrical Cable Intersection")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PowerCableStraight_C", "Straight Electrical Cable")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PowerCableVertical_C", "Vertical Electrical Cable")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Lamppost_C", "Lamppost")
		  Self.SQLExecute(Statement, "PrimalItemStructure_IceBox_C", "Refrigerator")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Turret_C", "Auto Turret")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Keypad_C", "Remote Keypad")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalPipeIncline_C", "Metal Irrigation Pipe - Inclined")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalPipeIntake_C", "Metal Irrigation Pipe - Intake")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalPipeIntersection_C", "Metal Irrigation Pipe - Intersection")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalPipeStraight_C", "Metal Irrigation Pipe - Straight")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalPipeTap_C", "Metal Irrigation Pipe - Tap")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalPipeVertical_C", "Metal Irrigation Pipe - Vertical")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalSign_C", "Metal Sign")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodSign_Large_C", "Wooden Billboard")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalSign_Large_C", "Metal Billboard")
		  Self.SQLExecute(Statement, "PrimalItemStructure_CropPlot_Medium_C", "Medium Crop Plot")
		  Self.SQLExecute(Statement, "PrimalItemStructure_CropPlot_Large_C", "Large Crop Plot")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodSign_Wall_C", "Wooden Wall Sign")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalGateframe_C", "Metal Dinosaur Gateway")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalGate_C", "Metal Dinosaur Gate")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalSign_Wall_C", "Metal Wall Sign")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Flag_C", "Multi-Panel Flag")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Flag_Spider_C", "Spider Flag")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PreservingBin_C", "Preserving Bin")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalSpikeWall_C", "Metal Spike Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StorageBox_Huge_C", "Vault")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodSpikeWall_C", "Wooden Spike Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Bookshelf_C", "Bookshelf")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneFenceFoundation_C", "Stone Fence Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneWall_C", "Stone Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WaterTankMetal_C", "Metal Water Reservoir")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneCeiling_C", "Stone Ceiling")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneCeilingWithTrapdoor_C", "Stone Hatchframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneDoor_C", "Reinforced Wooden Door")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneFloor_C", "Stone Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneGate_C", "Reinforced Dinosaur Gate")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneGateframe_C", "Stone Dinosaur Gateway")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StonePillar_C", "Stone Pillar")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneWallWithDoor_C", "Stone Doorframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneWallWithWindow_C", "Stone Windowframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneWindow_C", "Reinforced Window")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneTrapdoor_C", "Reinforced Trapdoor")
		  Self.SQLExecute(Statement, "PrimalItemStructure_LamppostOmni_C", "Omnidirectional Lamppost")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Grill_C", "Industrial Grill")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Flag_Single_C", "Single Panel Flag")
		  Self.SQLExecute(Statement, "PrimalItemStructure_FeedingTrough_C", "Feeding Trough")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneGateframe_Large_C", "Behemoth Stone Dinosaur Gateway")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneGateLarge_C", "Behemoth Reinforced Dinosaur Gate")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchRoof_C", "Sloped Thatch Roof")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchWall_Sloped_Left_C", "Sloped Thatch Wall Left")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ThatchWall_Sloped_Right_C", "Sloped Thatch Wall Right")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodRoof_C", "Sloped Wooden Roof")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodWall_Sloped_Left_C", "Sloped Wood Wall Left")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodWall_Sloped_Right_C", "Sloped Wood Wall Right")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneRoof_C", "Sloped Stone Roof")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneWall_Sloped_Left_C", "Sloped Stone Wall Left")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneWall_Sloped_Right_C", "Sloped Stone Wall Right")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalRoof_C", "Sloped Metal Roof")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalWall_Sloped_Left_C", "Sloped Metal Wall Left")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalWall_Sloped_Right_C", "Sloped Metal Wall Right")
		  Self.SQLExecute(Statement, "PrimalItemRaft_C", "Wooden Raft")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PaintingCanvas_C", "Painting Canvas")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseWall_C", "Greenhouse Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseCeiling_C", "Greenhouse Ceiling")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseWallWithDoor_C", "Greenhouse Doorframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseDoor_C", "Greenhouse Door")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseWall_Sloped_Left_C", "Sloped Greenhouse Wall Left")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseWall_Sloped_Right_C", "Sloped Greenhouse Wall Right")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseRoof_C", "Sloped Greenhouse Roof")
		  Self.SQLExecute(Statement, "PrimalItemStructure_GreenhouseWindow_C", "Greenhouse Window")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ElevatorTrackBase_C", "Elevator Track")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ElevatorPlatformSmall_C", "Small Elevator Platform")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ElevatorPlatfromMedium_C", "Medium Elevator Platform")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ElevatorPlatformLarge_C", "Large Elevator Platform")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TurretBallista_C", "Ballista Turret")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Furniture_WoodChair_C", "Wooden Chair")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Furniture_WoodBench_C", "Wooden Bench")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Furniture_Gravestone_C", "Gravestone")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TrophyBase_C", "Trophy Base")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Wardrums_C", "Wardrums")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WarMap_C", "War Map")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodRailing_C", "Wooden Railing")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneRailing_C", "Stone Railing")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalRailing_C", "Metal Railing")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TrophyWall_C", "Trophy Wall-Mount")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TurretMinigun_C", "Minigun Turret")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TurretCatapult_C", "Catapult Turret")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TurretRocket_C", "Rocket Turret")
		  Self.SQLExecute(Statement, "PrimalItemStructure_SeaMine_C", "Homing Underwater Mine")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WallTorch_C", "Wall Torch")
		  Self.SQLExecute(Statement, "PrimalItemStructure_IndustrialForge_C", "Industrial Forge")
		  Self.SQLExecute(Statement, "PrimalItemStructure_IndustrialCookingPot_C", "Industrial Cooker")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Bed_Modern_C", "Bunk Bed")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Furniture_WoodTable_C", "Wooden Table")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Fireplace_C", "Stone Fireplace")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodCage_C", "Wooden Cage")
		  Self.SQLExecute(Statement, "PrimalItemStructure_BeerBarrel_C", "Beer Barrel")
		  Self.SQLExecute(Statement, "PrimalItemStructure_ChemBench_C", "Chemistry Bench")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Cannon_C", "Cannon")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Flag_Gorilla_C", "Gorilla Flag")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Flag_Dragon_C", "Dragon Flag")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TrainingDummy_C", "Training Dummy")
		  Self.SQLExecute(Statement, "PrimalItemStructure_RopeLadder_C", "Rope Ladder")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TreePlatform_Wood_C", "Wooden Tree Platform")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TreePlatform_Metal_C", "Metal Tree Platform")
		  Self.SQLExecute(Statement, "PrimalItemStructure_TreeTap_C", "Tree Sap Tap")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WoodStairs_C", "Wooden Staircase")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneStairs_C", "Stone Staircase")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalStairs_C", "Metal Staircase")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Grinder_C", "Industrial Grinder")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneCeilingWithTrapdoorGiant_C", "Giant Stone Hatchframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_StoneCeilingDoorGiant_C", "Giant Reinforced Trapdoor")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalCeilingWithTrapdoorGiant_C", "Giant Metal Hatchframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_MetalTrapdoorGiant_C", "Giant Metal Trapdoor")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeCeiling_C", "Adobe Ceiling")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeCeilingDoorGiant_C", "Giant Adobe Trapdoor")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeCeilingWithDoorWay_Giant_C", "Giant Adobe Hatchframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeCeilingWithTrapdoor_C", "Adobe Hatchframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeDoor_C", "Adobe Door")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeFenceFoundation_C", "Adobe Fence Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeFloor_C", "Adobe Foundation")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeFrameGate_C", "Adobe Dinosaur Gateway")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeGateDoor_C", "Adobe Dinosaur Gate")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeGateDoor_Large_C", "Behemoth Adobe Dinosaur Gate")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeGateframe_Large_C", "Behemoth Adobe Dinosaur Gateway")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeLader_C", "Adobe Ladder")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobePillar_C", "Adobe Pillar")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeRailing_C", "Adobe Railing")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeRamp_C", "Adobe Ramp")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeRoof_C", "Sloped Adobe Roof")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeStaircase_C", "Adobe Staircase")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeTrapdoor_C", "Adobe Trapdoor")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeWall_C", "Adobe Wall")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeWall_Sloped_Left_C", "Sloped Adobe Wall Left")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeWall_Sloped_Right_C", "Sloped Adobe Wall Right")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeWallWithDoor_C", "Adobe Doorframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeWallWithWindow_C", "Adobe Windowframe")
		  Self.SQLExecute(Statement, "PrimalItemStructure_AdobeWindow_C", "Adobe Window")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Flag_Manticore_C", "Manticore Flag")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Mirror_C", "Mirror")
		  Self.SQLExecute(Statement, "PrimalItemStructure_oilPump_C", "Oil Pump")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Tent_C", "Tent")
		  Self.SQLExecute(Statement, "PrimalItemStructure_Vessel_C", "Vessel")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WaterWell_C", "Water Well")
		  Self.SQLExecute(Statement, "PrimalItemStructure_WindTurbine_C", "Wind Turbine")
		  
		  Self.SQLExecute(Statement, "PrimalItemDye_Red_C", "Red Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Green_C", "Green Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Blue_C", "Blue Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Yellow_C", "Yellow Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Purple_C", "Purple Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Orange_C", "Orange Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Black_C", "Black Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_White_C", "White Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Brown_C", "Brown Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Cyan_C", "Cyan Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Magenta_C", "Purple Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Forest_C", "Forest Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Parchment_C", "Parchment Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Pink_C", "Pink Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Royalty_C", "Royalty Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Silver_C", "Silver Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Sky_C", "Sky Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Tan_C", "Tan Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Tangerine_C", "Tangerine Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_ActuallyMagenta_C", "Magenta Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Brick_C", "Brick Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Cantaloupe_C", "Cantaloupe Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Mud_C", "Mud Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Navy_C", "Navy Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Olive_C", "Olive Coloring")
		  Self.SQLExecute(Statement, "PrimalItemDye_Slate_C", "Slate Coloring")
		  
		  Self.SQLExecute(Statement, "PrimalItemConsumable_RawMeat_C", "Raw Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_SpoiledMeat_C", "Spoiled Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CookedMeat_C", "Cooked Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_RawPrimeMeat_C", "Raw Prime Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CookedPrimeMeat_C", "Cooked Prime Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CookedMeat_Jerky_C", "Cooked Meat Jerky")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CookedPrimeMeat_Jerky_C", "Prime Meat Jerky")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_RawMeat_Fish_C", "Raw Fish Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CookedMeat_Fish_C", "Cooked Fish Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_RawPrimeMeat_Fish_C", "Raw Prime Fish Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CookedPrimeMeat_Fish_C", "Cooked Prime Fish Meat")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_WyvernMilk_C", "Wyvern Milk")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Berry_Amarberry_C", "Amarberry")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Berry_Azulberry_C", "Azulberry")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Berry_Mejoberry_C", "Mejoberry")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Berry_Narcoberry_C", "Narcoberry")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Berry_Stimberry_C", "Stimberry")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Berry_Tintoberry_C", "Tintoberry")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CactusSap_C", "Cactus Sap")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Veggie_Citronal_C", "Citronal")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Veggie_Longrass_C", "Longrass")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Veggie_Rockarrot_C", "Rockarrot")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Veggie_Savoroot_C", "Savoroot")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_WaterskinCraftable_C", "Waterskin")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_WaterskinRefill_C", "Waterskin")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_WaterJarCraftable_C", "Water Jar")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_WaterJarRefill_C", "Water Jar")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_IcedWaterJar_C", "Iced Water Jar")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_IcedWaterJarRefill_C", "Iced Water Jar")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CanteenCraftable_C", "Canteen")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CanteenRefill_C", "Canteen")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_IcedCanteen_C", "Iced Canteen")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_IcedCanteenRefill_C", "Iced Canteen")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_BeerJar_C", "Beer Jar")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_BeerJarAlt_C", "Beer Jar")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_HealSoup_C", "Medical Brew")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_StaminaSoup_C", "Energy Brew")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Soup_BattleTartare_C", "Battle Tartare")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_TheHorn_C", "Broth of Enlightenment")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_BugRepellant_C", "Bug Repellant")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CactusBuffSoup_C", "Cactus Broth")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Soup_CalienSoup_C", "Calien Soup")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Soup_EnduroStew_C", "Enduro Stew")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Soup_FocalChili_C", "Focal Chili")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Soup_FriaCurry_C", "Fria Curry")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Soup_LazarusChowder_C", "Lazarus Chowder")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_CureLow_C", "Lesser Antidote")
		  Self.SQLExecute(Statement, "PrimalItemConsumableRespecSoup_C", "Mindwipe Tonic")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Soup_ShadowSteak_C", "Shadow Steak Saute")
		  Self.SQLExecute(Statement, "PrimalItemConsumableSoap_C", "Soap")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_SweetVeggieCake_C", "Sweet Vegetable Cake")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_Allo_C", "Kibble (Allosaurus Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_AnkyloEgg_C", "Kibble (Ankylo Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_SpiderEgg_C", "Kibble (Araneo Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_ArgentEgg_C", "Kibble (Argentavis Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_SauroEgg_C", "Kibble (Bronto Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_TurtleEgg_C", "Kibble (Carbonemys Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_CarnoEgg_C", "Kibble (Carno Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_Compy_C", "Kibble (Compy Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_Camelsaurus_C", "Kibble (Camelsaurus Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_DiloEgg_C", "Kibble (Dilo Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_DimetroEgg_C", "Kibble (Dimetrodon Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_DimorphEgg_C", "Kibble (Dimorph Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_DiploEgg_C", "Kibble (Diplo Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_DodoEgg_C", "Kibble (Dodo Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_GalliEgg_C", "Kibble (Gallimimus Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_KairukuEgg_C", "Kibble (Kairuku Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_LystroEgg_C", "Kibble (Lystrosaurus Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_Mantis_C", "Kibble (Mantis Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_Moth_C", "Kibble (Moth Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_PachyEgg_C", "Kibble (Pachy Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_ParaEgg_C", "Kibble (Parasaur Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_Pela_C", "Kibble (Pelagornis Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_PteroEgg_C", "Kibble (Pteranodon Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_ScorpionEgg_C", "Kibble (Pulmonoscorpius Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_QuetzEgg_C", "Kibble (Quetzal Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_RaptorEgg_C", "Kibble (Raptor Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_RexEgg_C", "Kibble (Rex Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_SarcoEgg_C", "Kibble (Sarco Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_SpinoEgg_C", "Kibble (Spino Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_StegoEgg_C", "Kibble (Stego Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_TerrorbirdEgg_C", "Kibble (Terror Bird Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_SpineyLizard_C", "Kibble (Thorny Dragon Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_BoaEgg_C", "Kibble (Titanboa Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_TrikeEgg_C", "Kibble (Trike Egg)")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Kibble_Vulture_C", "Kibble (Vulture Egg)")
		  
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Allo_C", "Allosaurus Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Ankylo_C", "Ankylo Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Spider_C", "Araneo Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Argent_C", "Argentavis Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Bronto_C", "Bronto Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Camelsaurus_C", "Camelsaurus Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Carno_C", "Carno Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Dilo_C", "Dilo Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Dimetrodon_C", "Dimetrodon Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Dimorph_C", "Dimorph Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Diplo_C", "Diplo Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Dodo_C", "Dodo Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Gigant_C", "Giganotosaurus Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Kairuku_C", "Kairuku Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Lystro_C", "Lystro Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Mantis_C", "Mantis Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Moth_C", "Moth Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Oviraptor_C", "Oviraptor Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Pachy_C", "Pachycephalosaurus Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Para_C", "Parasaur Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Pela_C", "Pelagornis Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Ptero_C", "Pteranodon Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Scorpion_C", "Pulmonoscorpius Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Quetz_C", "Quetzal Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Raptor_C", "Raptor Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Rex_C", "Rex Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Sarco_C", "Sarco Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Spino_C", "Spino Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Stego_C", "Stego Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Terrorbird_C", "Terror Bird Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_SpineyLizard_C", "Thorny Dragon Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Boa_C", "Titanboa Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Trike_C", "Trike Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Turtle_C", "Turtle Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Vulture_C", "Vulture Egg")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Wyvern_Fertilized_Fire_C", "Wyvern Egg Fire")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Wyvern_Fertilized_Lightning_C", "Wyvern Egg Lightning")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Egg_Wyvern_Fertilized_Poison_C", "Wyvern Egg Poison")
		  
		  Self.SQLExecute(Statement, "PrimalItemConsumable_DinoPoopSmall_C", "Small Animal Feces")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_HumanPoop_C", "Human Feces")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_DinoPoopMedium_C", "Medium Animal Feces")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_DinoPoopLarge_C", "Large Animal Feces")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_DinoPoopMassive_C", "Massive Animal Feces")
		  
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Amarberry_C", "Amarberry Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Citronal_C", "Citronal Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Azulberry_C", "Azulberry Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Tintoberry_C", "Tintoberry Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Mejoberry_C", "Mejoberry Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Narcoberry_C", "Narcoberry Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Stimberry_C", "Stimberry Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Savoroot_C", "Savoroot Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Longrass_C", "Longrass Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_Rockarrot_C", "Rockarrot Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_DefensePlant_C", "Plant Species X Seed")
		  Self.SQLExecute(Statement, "PrimalItemConsumable_Seed_PlantSpeciesY_C", "Plant Species Y Seed")
		  
		  Self.SQLExecute(Statement, "PrimalItem_WeaponGun_C", "Simple Pistol")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponRifle_C", "Assault Rifle")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponRocketLauncher_C", "Rocket Launcher")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponBow_C", "Bow")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponGrenade_C", "Grenade")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponC4_C", "C4 Remote Detonator")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponTripwireC4_C", "Improvised Explosive Device")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponSpear_C", "Spear")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponOneShotRifle_C", "Longneck Rifle")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponSlingshot_C", "Slingshot")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponPike_C", "Pike")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponFlareGun_C", "Flare Gun")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponMachinedPistol_C", "Fabricated Pistol")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponShotgun_C", "Shotgun")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponPoisonTrap_C", "Tripwire Narcotic Trap")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponAlarmTrap_C", "Tripwire Alarm Trap")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponMachinedShotgun_C", "Pump-Action Shotgun")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponCrossbow_C", "Crossbow")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponTransGPS_C", "Transponder Tracker")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponCompoundBow_C", "Compound Bow")
		  Self.SQLExecute(Statement, "PrimalItemStructure_BearTrap_C", "Bear Trap")
		  Self.SQLExecute(Statement, "PrimalItemStructure_BearTrap_Large_C", "Large Bear Trap")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponSprayPaint_C", "Spray Painter")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponStoneClub_C", "Wooden Club")
		  Self.SQLExecute(Statement, "PrimalItem_PoisonGrenade_C", "Poison Grenade")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponMachinedSniper_C", "Fabricated Sniper Rifle")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponProd_C", "Electric Prod")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponHandcuffs_C", "Handcuffs")
		  Self.SQLExecute(Statement, "PrimalItem_GasGrenade_C", "Smoke Grenade")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponSword_C", "Metal Sword")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponBola_C", "Bola")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_ChainBola_C", "Chain Bola")
		  Self.SQLExecute(Statement, "PrimalItem_WeapFlamethrower_C", "Flamethrower")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponBoomerang_C", "Boomerang")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponClusterGrenade_C", "Cluster Grenade")
		  Self.SQLExecute(Statement, "PrimalItem_WeaponOilJar_C", "Oil Jar")
		  Self.SQLExecute(Statement, "PrimalItemStructure_PlantSpeciesYTrap_C", "Plant Species Y Trap")
		  Self.SQLExecute(Statement, "PrimalItemWeaponAttachment_Scope_C", "Scope Attachment")
		  Self.SQLExecute(Statement, "PrimalItemWeaponAttachment_Flashlight_C", "Flashlight Attachment")
		  Self.SQLExecute(Statement, "PrimalItemWeaponAttachment_Silencer_C", "Silencer Attachment")
		  Self.SQLExecute(Statement, "PrimalItemWeaponAttachment_HoloScope_C", "Holo-Scope Attachment")
		  Self.SQLExecute(Statement, "PrimalItemWeaponAttachment_Laser_C", "Laser Attachment")
		  
		  Self.SQLExecute(Statement, "PrimalItemAmmo_SimpleBullet_C", "Simple Bullet")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_ArrowStone_C", "Stone Arrow")
		  Self.SQLExecute(Statement, "PrimalItemC4Ammo_C", "C4 Charge")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_ArrowTranq_C", "Tranquilizer Arrow")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_SimpleRifleBullet_C", "Simple Rifle Ammo")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_AdvancedBullet_C", "Advanced Bullet")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_AdvancedRifleBullet_C", "Advanced Rifle Bullet")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_Rocket_C", "Rocket Propelled Grenade")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_SimpleShotgunBullet_C", "Simple Shotgun Ammo")
		  Self.SQLExecute(Statement, "PrimalItemTransGPSAmmo_C", "Transponder Node")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_CompoundBowArrow_C", "Metal Arrow")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_BallistaArrow_C", "Ballista Bolt")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_TranqDart_C", "Tranquilizer Dart")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_AdvancedSniperBullet_C", "Advanced Sniper Bullet")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_Boulder_C", "Boulder")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_GrapplingHook_C", "Grappling Hook")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_CannonBall_C", "Cannon Ball")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_ArrowFlame_C", "Flame Arrow")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_Flamethrower_C", "Flamethrower Ammo")
		  Self.SQLExecute(Statement, "PrimalItemAmmo_RocketHomingMissile_C", "Rocket Homing Missile")
		  
		  Self.SQLExecute(Statement, "PrimalItemArmor_HideHelmetAlt_C", "Hunter Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemArmor_RexSaddle_StompedGlasses_C", "Rex Stomped Glasses Saddle Skin")
		  Self.SQLExecute(Statement, "PrimalItemArmor_ParaSaddle_Launch_C", "Parasaur ARK Founder Saddle Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_BoneHelmet_C", "Rex Bone Helmet")
		  Self.SQLExecute(Statement, "PrimalItemSkin_Glasses_C", "Nerdry Glasses")
		  Self.SQLExecute(Statement, "PrimalItemSkin_DinoSpecs_C", "Dino Glasses")
		  Self.SQLExecute(Statement, "PrimalItemSkin_FlaregunFireworks_C", "Fireworks Flaregun Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_TrikeSkullHelmet_C", "Trike Bone Helmet Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_DodorexMask_C", "DodoRex Mask Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_WitchHat_C", "Witch Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_DinoWitchHat_C", "Dino Witch Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemCostume_BoneCarno_C", "Carno Bone Costume")
		  Self.SQLExecute(Statement, "PrimalItemCostume_BoneRaptor_C", "Raptor Bone Costume")
		  Self.SQLExecute(Statement, "PrimalItemCostume_BoneRex_C", "Rex Bone Costume")
		  Self.SQLExecute(Statement, "PrimalItemCostume_BoneSauro_C", "Bronto Bone Costume")
		  Self.SQLExecute(Statement, "PrimalItemCostume_BoneStego_C", "Stego Bone Costume")
		  Self.SQLExecute(Statement, "PrimalItemCostume_BoneTrike_C", "Trike Bone Costume")
		  Self.SQLExecute(Statement, "PrimalItemSkin_TurkeyHat_C", "Chieftan Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_SantaHat_C", "Santa Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_DinoSantaHat_C", "Dino Santa Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_CandyClub_C", "Candy Cane Club Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_TopHat_C", "Top Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemCostume_ReindeerStag_C", "Megaloceros Reindeer Costume")
		  Self.SQLExecute(Statement, "PrimalItemSkin_BunnyHat_C", "Bunny Ears Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_DinoBunnyHat_C", "Dino Bunny Ears Skin")
		  Self.SQLExecute(Statement, "PrimalItemCostume_ProcopBunny_C", "Procoptodon Bunny Costume")
		  Self.SQLExecute(Statement, "PrimalItemSkin_DinoPartyHat_C", "Dino Party Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_PartyHat_C", "Party Hat Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_BirthdayPants_C", "Birthday Suit Pants Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_BirthdayShirt_C", "Birthday Suit Shirt Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_RocketLauncherFireworks_C", "Fireworks Rocket Launcher Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_TorchSparkler_C", "Torch Sparkler Skin")
		  Self.SQLExecute(Statement, "PrimalItemArmor_SpineyLizardPromoSaddle_C", "ARK Thorny Dragon Saddle Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_ManticoreHelmet_C", "Manticore Helmet Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_ManticoreShield_C", "Manticore Shield Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_WyvernGloves_C", "Wyvern Gloves Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_ScorchedSpear_C", "Scorched Spike Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_ScorchedSword_C", "Scorched Sword Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_TorchScorched_C", "Scorched Torch Skin")
		  Self.SQLExecute(Statement, "PrimalItemSkin_ExplorerHat_C", "Safari Hat Skin")
		  
		  Self.SQLExecute(Statement, "PrimalItem_StartingNote_C", "Specimen Implant")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_01_C", "Artifact Of The Hunter")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_02_C", "Artifact Of The Pack")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_03_C", "Artifact Of The Massive")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_05_C", "Artifact Of The Clever")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_06_C", "Artifact Of The Skylord")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_07_C", "Artifact Of The Devourer")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_08_C", "Artifact Of The Immune")
		  Self.SQLExecute(Statement, "PrimalItemArtifact_09_C", "Artifact Of The Strong")
		  Self.SQLExecute(Statement, "PrimalItemArtifactSE_01_C", "Artifact Of The Gatekeeper")
		  Self.SQLExecute(Statement, "PrimalItemArtifactSE_02_C", "Artifact Of The Crag")
		  Self.SQLExecute(Statement, "PrimalItemArtifactSE_03_C", "Artifact Of The Destroyer")
		  Self.SQLExecute(Statement, "PrimalItemResource_ApexDrop_Argentavis_C", "Argentavis Talon")
		  Self.SQLExecute(Statement, "PrimalItemResource_ApexDrop_Megalodon_C", "Megalodon Tooth")
		  Self.SQLExecute(Statement, "PrimalItemResource_ApexDrop_Rex_C", "Tyrannosaurus Arm")
		  Self.SQLExecute(Statement, "PrimalItemResource_ApexDrop_Sauro_C", "Sauropod Vertebra")
		  Self.SQLExecute(Statement, "PrimalItemResource_ApexDrop_FireWyvern_C", "Fire Talon")
		  Self.SQLExecute(Statement, "PrimalItemResource_ApexDrop_LightningWyvern_C", "Lightning Talon")
		  Self.SQLExecute(Statement, "PrimalItemResource_ApexDrop_PoisonWyvern_C", "Poison Talon")
		  
		  Self.SQLExecute(Statement, "PrimalItemArmor_NightVisionGoggles_C", "Night Vision Goggles")
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UpdateToVersion2() As Boolean
		  Self.SQLExecute("CREATE TABLE ""beacons"" (""classstring"" TEXT NOT NULL PRIMARY KEY, ""label"" TEXT NOT NULL, ""minmult"" REAL NOT NULL DEFAULT 1, ""maxmult"" REAL NOT NULL DEFAULT 1);")
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("INSERT INTO ""beacons"" (""classstring"", ""label"", ""minmult"", ""maxmult"") VALUES (?, ?, ?, ?);")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  Statement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		  Statement.BindType(2, SQLitePreparedStatement.SQLITE_DOUBLE)
		  Statement.BindType(3, SQLitePreparedStatement.SQLITE_DOUBLE)
		  
		  // The Island + The Center
		  
		  Self.SQLExecute(Statement, "SupplyCrate_Level03_C", "Island White (Level 3)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level03_Double_C", "Island White + Bonus (Level 3)", 2, 2)
		  Self.SQLExecute(Statement, "SupplyCrate_Level15_C", "Island Green (Level 15)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level15_Double_C", "Island Green + Bonus (Level 15)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level25_C", "Island Blue (Level 25)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level25_Double_C", "Island Blue + Bonus (Level 25)", 2, 2)
		  Self.SQLExecute(Statement, "SupplyCrate_Level35_C", "Island Purple (Level 35)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level35_Double_C", "Island Purple + Bonus (Level 35)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level45_C", "Island Yellow (Level 45)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level45_Double_C", "Island Yellow + Bonus (Level 45)", 2, 2)
		  Self.SQLExecute(Statement, "SupplyCrate_Level60_C", "Island Red (Level 60)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level60_Double_C", "Island Red + Bonus (Level 60)", 2, 2)
		  
		  Self.SQLExecute(Statement, "SupplyCrate_Cave_QualityTier1_C", "Island Cave Green", 1, 1.75)
		  Self.SQLExecute(Statement, "SupplyCrate_Cave_QualityTier2_C", "Island Cave Blue", 1.75, 2.5)
		  Self.SQLExecute(Statement, "SupplyCrate_Cave_QualityTier3_C", "Island Cave Yellow", 2.5, 3.25)
		  Self.SQLExecute(Statement, "SupplyCrate_Cave_QualityTier4_C", "Island Cave Red", 3.25, 4)
		  Self.SQLExecute(Statement, "SupplyCrate_SwampCaveTier1_C", "Island Swamp Cave Blue", 1.75, 2.5)
		  Self.SQLExecute(Statement, "SupplyCrate_SwampCaveTier2_C", "Island Swamp Cave Yellow", 2.5, 3.25)
		  Self.SQLExecute(Statement, "SupplyCrate_SwampCaveTier3_C", "Island Swamp Cave Red", 3.25, 4)
		  Self.SQLExecute(Statement, "SupplyCrate_IceCaveTier1_C", "Island Ice Cave Blue", 1.75, 2.5)
		  Self.SQLExecute(Statement, "SupplyCrate_IceCaveTier2_C", "Island Ice Cave Yellow", 2.5, 3.25)
		  Self.SQLExecute(Statement, "SupplyCrate_IceCaveTier3_C", "Island Ice Cave Red", 3.25, 4)
		  Self.SQLExecute(Statement, "SupplyCrate_OceanInstant_C", "Island Deep Sea", 3.25, 4)
		  Self.SQLExecute(Statement, "ArtifactCrate_1_C", "Island Artifact Hunter", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_2_C", "Island Artifact Pack", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_3_C", "Island Artifact Massive", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_4_C", "Island Artifact Devious", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_5_C", "Island Artifact Clever", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_6_C", "Island Artifact Skylord", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_7_C", "Island Artifact Devourer", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_8_C", "Island Artifact Immune", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_9_C", "Island Artifact Strong", 1, 1)
		  
		  // Scorched Earth
		  
		  Self.SQLExecute(Statement, "SupplyCrate_Level03_ScorchedEarth_C", "Scorched White (Level 3)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level03_Double_ScorchedEarth_C", "Scorched White + Bonus (Level 3)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level15_ScorchedEarth_C", "Scorched Green (Level 15)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level15_Double_ScorchedEarth_C", "Scorched Green + Bonus (Level 15)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level30_ScorchedEarth_C", "Scorched Blue (Level 30)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level30_Double_ScorchedEarth_C", "Scorched Blue + Bonus (Level 30)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level45_ScorchedEarth_C", "Scorched Purple (Level 45)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level45_Double_ScorchedEarth_C", "Scorched Purple + Bonus (Level 45)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level55_ScorchedEarth_C", "Scorched Yellow (Level 55)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level55_Double_ScorchedEarth_C", "Scorched Yellow + Bonus (Level 55)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level70_ScorchedEarth_C", "Scorched Red (Level 70)", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Level70_Double_ScorchedEarth_C", "Scorched Red + Bonus (Level 70)", 1, 1)
		  
		  Self.SQLExecute(Statement, "SupplyCrate_Cave_QualityTier1_ScorchedEarth_C", "Scorched Cave Tier 1", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Cave_QualityTier2_ScorchedEarth_C", "Scorched Cave Tier 2", 1, 1)
		  Self.SQLExecute(Statement, "SupplyCrate_Cave_QualityTier3_ScorchedEarth_C", "Scorched Cave Tier 3", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_SE_C", "Scorched Artifact Destroyer", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_2_SE_C", "Scorched Artifact Gatekeeper", 1, 1)
		  Self.SQLExecute(Statement, "ArtifactCrate_3_SE_C", "Scorched Artifact Crag", 1, 1)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UpdateToVersion3() As Boolean
		  Self.SQLExecute("ALTER TABLE ""beacons"" RENAME TO ""loot_sources"";")
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBase As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mSharedInstance As LocalData
	#tag EndProperty


	#tag Constant, Name = CurrentVersion, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
