#tag Module
Protected Module Language
	#tag Method, Flags = &h0
		Function EnglishOxfordList(Extends Items() As String, Conjunction As String = "and") As String
		  Return EnglishOxfordList(Items, Conjunction)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EnglishOxfordList(Items() As String, Conjunction As String = "and") As String
		  If Items.LastIndex = -1 Then
		    Return ""
		  ElseIf Items.LastIndex = 0 Then
		    Return Items(0)
		  ElseIf Items.LastIndex = 1 Then
		    Return Items(0) + " " + Conjunction + " " + Items(1)
		  Else
		    Var LastItem As String = Items(Items.LastIndex)
		    Items.RemoveAt(Items.LastIndex)
		    Var List As String = Items.Join(", ") + ", " + Conjunction + " " + LastItem
		    Items.Add(LastItem) // Gotta put it back
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
		Protected Function GameName(GameID As String) As String
		  Select Case GameID
		  Case Ark.Identifier
		    Return "Ark: Survival Evolved"
		  Else
		    Return GameID
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForConfig(Config As Ark.ConfigGroup) As String
		  Return Language.LabelForConfig(Config.InternalName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForConfig(ConfigName As String) As String
		  Select Case ConfigName
		  Case Ark.Configs.NameDifficulty
		    Return "Difficulty"
		  Case Ark.Configs.NameLootDrops
		    Return "Loot Drops"
		  Case Ark.Configs.NameExperienceCurves
		    Return "Levels and XP"
		  Case Ark.Configs.NameCustomContent
		    Return "Custom Config"
		  Case Ark.Configs.NameCraftingCosts
		    Return "Crafting Costs"
		  Case Ark.Configs.NameStackSizes
		    Return "Stack Sizes"
		  Case Ark.Configs.NameBreedingMultipliers
		    Return "Breeding Multipliers"
		  Case Ark.Configs.NameHarvestRates
		    Return "Harvest Rates"
		  Case Ark.Configs.NameDinoAdjustments
		    Return "Creature Adjustments"
		  Case Ark.Configs.NameStatMultipliers
		    Return "Stat Multipliers"
		  Case Ark.Configs.NameDayCycle
		    Return "Day and Night Cycle"
		  Case Ark.Configs.NameSpawnPoints
		    Return "Creature Spawns"
		  Case Ark.Configs.NameStatLimits
		    Return "Item Stat Limits"
		  Case Ark.Configs.NameEngramControl
		    Return "Engram Control"
		  Case Ark.Configs.NameSpoilTimers
		    Return "Decay and Spoil"
		  Case Ark.Configs.NameOtherSettings
		    Return "General Settings"
		  Case Ark.Configs.NameServersPseudo
		    Return "Servers"
		  Case Ark.Configs.NameAccountsPsuedo
		    Return "Accounts"
		  Case Ark.Configs.NameMetadataPsuedo
		    Return "Project Settings"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NounWithQuantity(Quantity As Integer, Singular As String, Plural As String) As String
		  Return Quantity.ToString(Locale.Current, ",##0") + " " + If(Quantity = 1, Singular, Plural)
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
