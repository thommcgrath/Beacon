#tag Module
Protected Module Language
	#tag Method, Flags = &h1
		Protected Function DefaultServerName(GameId As String) As String
		  Var GameName As String = Language.GameName(GameId)
		  Var GameArticle As String = Language.GameArticle(GameId)
		  Return GameArticle.Titlecase + " " + GameName + " Server"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description(Extends License As Beacon.OmniLicense, WithExpiration As Boolean = True) As String
		  Var GameNames() As String
		  If License.IsFlagged(Ark.OmniFlag) Then
		    GameNames.Add(Language.GameName(Ark.Identifier))
		  End If
		  If License.IsFlagged(ArkSA.OmniFlag) Then
		    GameNames.Add(Language.GameName(ArkSA.Identifier))
		  End If
		  If License.IsFlagged(SDTD.OmniFlag)Then
		    GameNames.Add(Language.GameName(SDTD.Identifier))
		  End If
		  If License.IsFlagged(Palworld.OmniFlag) Then
		    GameNames.Add(Language.GameName(Palworld.Identifier))
		  End If
		  If License.IsFlagged(Beacon.OmniLicense.CuratorFlag) Then
		    GameNames.Add("Curator Access")
		  End If
		  
		  Var LicenseText As String = EnglishOxfordList(GameNames)
		  
		  If WithExpiration And License.Expiration.IsEmpty = False Then
		    Var Expiration As DateTime = License.ExpirationDateTime
		    LicenseText = LicenseText + ", " + ReplacePlaceholders(If(Expiration.SecondsFrom1970 < DateTime.Now.SecondsFrom1970, CommonExpiredOnDate, CommonExpiresOnDate), Expiration.ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Short) + " UTC")
		  End If
		  
		  Return LicenseText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EnglishOxfordList(Items() As Beacon.NamedItem, Conjunction As String = "and", Limit As Integer = -1) As String
		  Var Names() As String
		  Names.ResizeTo(Items.LastIndex)
		  For Idx As Integer = 0 To Names.LastIndex
		    Names(Idx) = Items(Idx).Label
		  Next
		  Return EnglishOxfordList(Names, Conjunction, Limit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EnglishOxfordList(Extends Items() As Beacon.NamedItem, Conjunction As String = "and", Limit As Integer = -1) As String
		  Return EnglishOxfordList(Items, Conjunction, Limit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EnglishOxfordList(Extends Items() As String, Conjunction As String = "and", Limit As Integer = -1) As String
		  Return EnglishOxfordList(Items, Conjunction, Limit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EnglishOxfordList(Items() As String, Conjunction As String = "and", Limit As Integer = -1) As String
		  If Items.Count = 0 Then
		    Return ""
		  ElseIf Items.Count = 1 Then
		    Return Items(0)
		  ElseIf Items.Count = 2 Then
		    Return Items(0) + " " + Conjunction + " " + Items(1)
		  ElseIf Limit > 1 And Items.Count > Limit Then
		    Var AllowedItems() As String
		    AllowedItems.ResizeTo(Limit - 2)
		    For Idx As Integer = 0 To AllowedItems.LastIndex
		      AllowedItems(Idx) = Items(Idx)
		    Next
		    
		    // Remaining will never be 1 because we are subtracting 1 from the limit to avoid "and 1 other" that could have just been the 1 other.
		    Var Remaining As Integer = Items.Count - (Limit - 1)
		    AllowedItems.Add(Conjunction + " " + Remaining.ToString(Locale.Current, "0") + " others")
		    
		    If AllowedItems.Count > 2 Then
		      Return String.FromArray(AllowedItems, ", ")
		    Else
		      Return AllowedItems(0) + " " + AllowedItems(1)
		    End If
		  Else
		    Var List As String = Items(0)
		    For Idx As Integer = 1 To Items.LastIndex - 1
		      List = List + ", " + Items(Idx)
		    Next
		    List = List + ", " + Conjunction + " " + Items(Items.LastIndex)
		    
		    Return List
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FilterServerNames(Names() As String) As String()
		  If Names.Count < 2 Then
		    Return Names
		  End If
		  
		  Var Pattern As New Regex
		  Pattern.SearchPattern = "(\S+)"
		  
		  Var WordCounts As New Dictionary
		  For Each Name As String In Names
		    Var Words() As String
		    Do
		      
		      Var Match As RegexMatch = Pattern.Search(Name)
		      If Match Is Nil Then
		        Exit
		      End If
		      
		      Var Word As String = Match.SubExpressionString(1)
		      Words.Add(Word)
		      Name = Name.Middle(Name.IndexOf(Word) + Word.Length)
		    Loop
		    
		    For Each Word As String In Words
		      WordCounts.Value(Word) = WordCounts.Lookup(Word, 0).IntegerValue + 1
		    Next
		  Next
		  
		  Var CommonWords() As String
		  For Each Entry As DictionaryEntry In WordCounts
		    Var Word As String = Entry.Key
		    Var Count As Integer = Entry.Value
		    If Count <> Names.Count Then
		      Continue
		    End If
		    
		    CommonWords.Add(Word)
		  Next
		  
		  Var CleanedNames() As String
		  For Each Name As String In Names
		    For Each Word As String In CommonWords
		      Name = Name.Replace(Word, "").ReplaceAll("  ", " ").Trim
		    Next
		    CleanedNames.Add(Name)
		  Next
		  
		  Return CleanedNames
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FolderItemErrorReason(ErrorCode As Integer) As String
		  Select Case ErrorCode
		  Case FolderItem.DestDoesNotExistError
		    Return "The destination does not exist"
		  Case FolderItem.FileNotFound
		    Return "File not found"
		  Case FolderItem.AccessDenied
		    Return "Permission denied"
		  Case FolderItem.NotEnoughMemory
		    Return "Out of memory"
		  Case FolderItem.FileInUse
		    Return "File is in use"
		  Case FolderItem.InvalidName
		    Return "Filename is invalid"
		  Else
		    Return "Other error #" + ErrorCode.ToString
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GameArticle(GameId As String) As String
		  Select Case GameId
		  Case Ark.Identifier, ArkSA.Identifier
		    Return "an"
		  Case SDTD.Identifier, Palworld.Identifier
		    Return "a"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GameName(GameId As String) As String
		  Select Case GameId
		  Case Ark.Identifier
		    Return Ark.FullName
		  Case SDTD.Identifier
		    Return SDTD.FullName
		  Case ArkSA.Identifier
		    Return ArkSA.FullName
		  Case Palworld.Identifier
		    Return Palworld.Identifier
		  Else
		    Return GameId
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForConfig(Config As Beacon.ConfigGroup) As String
		  Return Language.LabelForConfig(Config.InternalName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForConfig(ConfigName As String) As String
		  Select Case ConfigName
		  Case Ark.Configs.NameDifficulty, ArkSA.Configs.NameDifficulty
		    Return "Difficulty"
		  Case Ark.Configs.NameLootDrops, ArkSA.Configs.NameLootDrops
		    Return "Loot Drops"
		  Case Ark.Configs.NameLevelsAndXP, ArkSA.Configs.NameLevelsAndXP
		    Return "Levels and XP"
		  Case Ark.Configs.NameCustomConfig, SDTD.Configs.NameCustomConfig, ArkSA.Configs.NameCustomConfig, Palworld.Configs.NameCustomConfig
		    Return "Custom Config"
		  Case Ark.Configs.NameCraftingCosts, ArkSA.Configs.NameCraftingCosts
		    Return "Crafting Costs"
		  Case Ark.Configs.NameStackSizes, ArkSA.Configs.NameStackSizes
		    Return "Stack Sizes"
		  Case Ark.Configs.NameBreedingMultipliers, ArkSA.Configs.NameBreedingMultipliers
		    Return "Breeding Multipliers"
		  Case Ark.Configs.NameHarvestRates, ArkSA.Configs.NameHarvestRates
		    Return "Harvest Rates"
		  Case Ark.Configs.NameCreatureAdjustments, ArkSA.Configs.NameCreatureAdjustments
		    Return "Creature Adjustments"
		  Case Ark.Configs.NameStatMultipliers, ArkSA.Configs.NameStatMultipliers
		    Return "Stat Multipliers"
		  Case Ark.Configs.NameDayCycle, ArkSA.Configs.NameDayCycle
		    Return "Day and Night Cycle"
		  Case Ark.Configs.NameCreatureSpawns, ArkSA.Configs.NameCreatureSpawns
		    Return "Creature Spawns"
		  Case Ark.Configs.NameStatLimits, ArkSA.Configs.NameStatLimits
		    Return "Item Stat Limits"
		  Case Ark.Configs.NameEngramControl, ArkSA.Configs.NameEngramControl
		    Return "Engram Control"
		  Case Ark.Configs.NameDecayAndSpoil, ArkSA.Configs.NameDecayAndSpoil
		    Return "Decay and Spoil"
		  Case Ark.Configs.NameGeneralSettings, SDTD.Configs.NameGeneralSettings, ArkSA.Configs.NameGeneralSettings, Palworld.Configs.NameGeneralSettings
		    Return "General Settings"
		  Case Ark.Configs.NameServers, SDTD.Configs.NameServers, ArkSA.Configs.NameServers, Palworld.Configs.NameServers
		    Return "Servers"
		  Case Ark.Configs.NameAccounts, SDTD.Configs.NameAccounts, ArkSA.Configs.NameAccounts, Palworld.Configs.NameAccounts
		    Return "Accounts"
		  Case Ark.Configs.NameProjectSettings, SDTD.Configs.NameProjectSettings, ArkSA.Configs.NameProjectSettings, Palworld.Configs.NameProjectSettings
		    Return "Project Settings"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NounWithQuantity(Quantity As Integer, Singular As String, Plural As String) As String
		  Return Quantity.ToString(Locale.Current, "#,##0") + " " + If(Quantity = 1, Singular, Plural)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ProviderName(ProviderId As String) As String
		  Select Case ProviderId
		  Case Nitrado.Identifier
		    Return "Nitrado"
		  Case GameServerApp.Identifier
		    Return "GameServerApp.com"
		  Case ASAManager.Identifier
		    Return "ASA Manager"
		  Case FTP.Identifier
		    Return "FTP"
		  Case Local.Identifier
		    Return "Local"
		  Else
		    Return ProviderId
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReplacePlaceholders(Source As String, ParamArray Values() As String) As String
		  For I As Integer = 0 To Values.LastIndex
		    Var Placeholder As Integer = I + 1
		    Source = Source.ReplaceAll("?" + Placeholder.ToString(Locale.Raw, "0"), Values(I))
		  Next
		  Return Source
		End Function
	#tag EndMethod


	#tag Constant, Name = Clipboard, Type = String, Dynamic = False, Default = \"Clipboard", Scope = Protected
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"Pasteboard"
	#tag EndConstant

	#tag Constant, Name = CommonCancel, Type = String, Dynamic = True, Default = \"Cancel", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CommonChoose, Type = String, Dynamic = True, Default = \"Choose\xE2\x80\xA6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CommonContinue, Type = String, Dynamic = True, Default = \"Continue", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CommonExpiredOnDate, Type = String, Dynamic = True, Default = \"expired \?1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CommonExpiresOnDate, Type = String, Dynamic = True, Default = \"expires \?1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CommonOk, Type = String, Dynamic = True, Default = \"OK", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ExperimentalWarningActionCaption, Type = String, Dynamic = False, Default = \"Continue", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ExperimentalWarningCancelCaption, Type = String, Dynamic = False, Default = \"Cancel", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ExperimentalWarningExplanation, Type = String, Dynamic = False, Default = \"The \"\?1\" loot drop is only partially supported by Beacon. Its behavior may be unpredictable\x2C both in terms of item quality and quantity. Are you sure you want to continue\?", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ExperimentalWarningMessage, Type = String, Dynamic = False, Default = \"You are adding an experimental loot drop.", Scope = Protected
	#tag EndConstant


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
End Module
#tag EndModule
