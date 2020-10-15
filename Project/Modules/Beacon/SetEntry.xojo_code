#tag Class
Protected Class SetEntry
Implements Beacon.Countable,Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.SetEntryOption)
		  Self.mOptions.Add(Item)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeBlueprint() As Boolean
		  For Each Option As Beacon.SetEntryOption In Self.mOptions
		    If Option.Engram.IsTagged("blueprintable") Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassesLabel() As String
		  If Self.mOptions.LastRowIndex = -1 Then
		    Return "No Items"
		  ElseIf Self.mOptions.LastRowIndex = 0 Then
		    Return Self.mOptions(0).Engram.ClassString
		  ElseIf Self.mOptions.LastRowIndex = 1 Then
		    Return Self.mOptions(0).Engram.ClassString + " or " + Self.mOptions(1).Engram.ClassString
		  Else
		    Var Labels() As String
		    For I As Integer = 0 To Self.mOptions.LastRowIndex - 1
		      Labels.Add(Self.mOptions(I).Engram.ClassString)
		    Next
		    Labels.Add("or " + Self.mOptions(Self.mOptions.LastRowIndex).Engram.ClassString)
		    
		    Return Labels.Join("")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinQuantity = 1
		  Self.mMaxQuantity = 1
		  Self.mMinQuality = Beacon.Qualities.Tier1
		  Self.mMaxQuality = Beacon.Qualities.Tier3
		  Self.mChanceToBeBlueprint = 0.25
		  Self.mWeight = 250
		  Self.mUniqueID = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntry)
		  Self.Constructor()
		  
		  Self.mOptions.ResizeTo(Source.mOptions.LastRowIndex)
		  
		  Self.mChanceToBeBlueprint = Source.mChanceToBeBlueprint
		  Self.mMaxQuality = Source.mMaxQuality
		  Self.mMaxQuantity = Source.mMaxQuantity
		  Self.mMinQuality = Source.mMinQuality
		  Self.mMinQuantity = Source.mMinQuantity
		  Self.mWeight = Source.mWeight
		  Self.mUniqueID = Source.mUniqueID
		  Self.mHash = Source.mHash
		  Self.mLastHashTime = Source.mLastHashTime
		  Self.mLastModifiedTime = Source.mLastModifiedTime
		  Self.mLastSaveTime = Source.mLastSaveTime
		  
		  For I As Integer = 0 To Source.mOptions.LastRowIndex
		    Self.mOptions(I) = New Beacon.SetEntryOption(Source.mOptions(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  For Each Option As Beacon.SetEntryOption In Self.mOptions
		    Option.ConsumeMissingEngrams(Engrams)
		  Next
		  
		  ' Dim Modified As Boolean
		  ' For I As Integer = 0 To Self.mOptions.LastRowIndex
		  ' Dim Option As Beacon.SetEntryOption = Self.mOptions(I)
		  ' For Each Engram As Beacon.Engram In Engrams
		  ' If Option.Engram <> Nil And Option.Engram.IsValid = False And Option.Engram.ClassString = Engram.ClassString Then
		  ' Self.mOptions(I) = New Beacon.SetEntryOption(Engram, Option.Weight)
		  ' Modified = True
		  ' End If
		  ' Next
		  ' Next
		  ' Return Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mOptions.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateBlueprintEntry(Entries() As Beacon.SetEntry) As Beacon.SetEntry
		  If Entries.LastRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Var SetEntryCount As Integer
		  Var SetEntryWeightSum As Double
		  Var MinQualitySum, MaxQualitySum As Double
		  Var Options As New Dictionary
		  For Each Entry As Beacon.SetEntry In Entries
		    Var WeightAdded As Boolean
		    For Each Option As Beacon.SetEntryOption In Entry
		      If Option.Engram = Nil Or Option.Engram.IsValid = False Or Option.Engram.IsTagged("blueprintable") = False Then
		        Continue
		      End If
		      
		      Var Key As String = Option.Engram.Path
		      If Key = "" Then
		        Continue
		      End If
		      
		      If WeightAdded = False Then
		        SetEntryWeightSum = SetEntryWeightSum + Entry.RawWeight
		        SetEntryCount = SetEntryCount + 1
		        WeightAdded = True
		      End If
		      
		      MinQualitySum = MinQualitySum + Entry.MinQuality.BaseValue
		      MaxQualitySum = MaxQualitySum + Entry.MaxQuality.BaseValue
		      Entry.ChanceToBeBlueprint = 0.0
		      
		      Var Arr() As Beacon.SetEntryOption
		      If Options.HasKey(Key) Then
		        Arr = Options.Value(Key)
		      End If
		      Arr.Add(Option)
		      Options.Value(Key) = Arr
		    Next
		  Next
		  
		  If Options.KeyCount = 0 Then
		    Return Nil
		  End If
		  
		  Var BlueprintEntry As New Beacon.SetEntry
		  For Each Entry As DictionaryEntry In Options
		    Var Path As String = Entry.Key
		    Var Arr() As Beacon.SetEntryOption = Entry.Value
		    Var Count As Integer = Arr.LastRowIndex + 1
		    Var WeightSum As Double
		    For Each Option As Beacon.SetEntryOption In Arr
		      WeightSum = WeightSum + Option.Weight
		    Next
		    Var AverageWeight As Double = WeightSum / Count
		    
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Path)
		    If Engram = Nil Then
		      Engram = Beacon.Engram.CreateFromPath(Path)
		    End If
		    
		    BlueprintEntry.Append(New Beacon.SetEntryOption(Engram, AverageWeight))
		  Next
		  
		  BlueprintEntry.ChanceToBeBlueprint = 1.0
		  BlueprintEntry.MaxQuantity = 1
		  BlueprintEntry.MinQuantity = 1
		  BlueprintEntry.MinQuality = Beacon.Qualities.ForBaseValue(MinQualitySum / Options.KeyCount)
		  BlueprintEntry.MaxQuality = Beacon.Qualities.ForBaseValue(MaxQualitySum / Options.KeyCount)
		  BlueprintEntry.RawWeight = SetEntryWeightSum / SetEntryCount
		  
		  Return BlueprintEntry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Var Children() As Dictionary
		  For Each Item As Beacon.SetEntryOption In Self.mOptions
		    Children.Add(Item.Export)
		  Next
		  
		  Var Keys As New Dictionary
		  Keys.Value("ChanceToBeBlueprintOverride") = Self.ChanceToBeBlueprint
		  Keys.Value("Items") = Children
		  Keys.Value("MinQuality") = Self.MinQuality.Key
		  Keys.Value("MaxQuality") = Self.MaxQuality.Key
		  Keys.Value("MinQuantity") = Self.MinQuantity
		  Keys.Value("MaxQuantity") = Self.MaxQuantity
		  Keys.Value("Weight") = Self.RawWeight
		  Keys.Value("EntryWeight") = Self.RawWeight / 1000
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.HashIsStale Then
		    Var Items() As String
		    Items.ResizeTo(Self.mOptions.LastRowIndex)
		    For I As Integer = 0 To Items.LastRowIndex
		      Items(I) = Self.mOptions(I).Hash
		    Next
		    Items.Sort
		    
		    Var Locale As Locale = Locale.Raw
		    Var Format As String = "0.000"
		    
		    Var Parts(6) As String
		    Parts(0) = Beacon.MD5(Items.Join(",")).Lowercase
		    Parts(1) = Self.ChanceToBeBlueprint.ToString(Locale, Format)
		    Parts(2) = Self.MaxQuality.Key.Lowercase
		    Parts(3) = Self.MaxQuantity.ToString(Locale, Format)
		    Parts(4) = Self.MinQuality.Key.Lowercase
		    Parts(5) = Self.MinQuantity.ToString(Locale, Format)
		    Parts(6) = Self.RawWeight.ToString(Locale, Format)
		    
		    Self.mHash = Beacon.MD5(Parts.Join(",")).Lowercase
		    Self.mLastHashTime = System.Microseconds
		  End If
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HashIsStale() As Boolean
		  If Self.mLastHashTime < Self.mLastModifiedTime Then
		    Return True
		  End If
		  
		  For Each Option As Beacon.SetEntryOption In Self.mOptions
		    If Option.HashIsStale Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As Dictionary) As Beacon.SetEntry
		  Var Entry As New Beacon.SetEntry
		  
		  Try
		    If Dict.HasKey("Weight") Then
		      Entry.RawWeight = Dict.Value("Weight")
		    ElseIf Dict.HasKey("EntryWeight") Then
		      Entry.RawWeight = Dict.Value("EntryWeight") * 1000.0
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Weight value")
		  End Try
		  
		  Try
		    If Dict.HasKey("MinQuality") Then
		      Entry.MinQuality = Beacon.Qualities.ForKey(Dict.Value("MinQuality"))
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinQuality value")
		  End Try
		  
		  Try
		    If Dict.HasKey("MaxQuality") Then
		      Entry.MaxQuality = Beacon.Qualities.ForKey(Dict.Value("MaxQuality"))
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxQuality value")
		  End Try
		  
		  Try
		    If Dict.HasKey("MinQuantity") Then
		      Entry.MinQuantity = Dict.Value("MinQuantity")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinQuantity value")
		  End Try
		  
		  Try
		    If Dict.HasKey("MaxQuantity") Then
		      Entry.MaxQuantity = Dict.Value("MaxQuantity")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxQuantity value")
		  End Try
		  
		  Try
		    If Dict.HasKey("ChanceToBeBlueprintOverride") Then
		      Entry.ChanceToBeBlueprint = Dict.Value("ChanceToBeBlueprintOverride")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading ChangeToBeBlueprintOverride value")
		  End Try
		  
		  If Dict.HasKey("Items") Then
		    Var Children() As Variant
		    Try
		      Children = Dict.Value("Items")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Casting Items to array")
		    End Try
		    
		    For Idx As Integer = 0 To Children.LastRowIndex
		      Try
		        Var Option As Beacon.SetEntryOption = Beacon.SetEntryOption.ImportFromBeacon(Dictionary(Children(Idx)))
		        If (Option Is Nil) = False Then
		          Entry.Append(Option)
		        End If
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Reading option dictionary #" + Str(Idx, "-0"))
		      End Try
		    Next
		  End If
		  
		  Entry.Modified = False
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Multipliers As Beacon.Range, Difficulty As BeaconConfigs.Difficulty) As Beacon.SetEntry
		  Var Entry As New Beacon.SetEntry
		  Entry.RawWeight = Dict.Lookup("EntryWeight", 1.0)
		  
		  If Dict.HasKey("MinQuality") Then
		    Entry.MinQuality = Beacon.Qualities.ForValue(Dict.Value("MinQuality"), Multipliers.Min, Difficulty)
		  End If
		  If Dict.HasKey("MaxQuality") Then
		    Entry.MaxQuality = Beacon.Qualities.ForValue(Dict.Value("MaxQuality"), Multipliers.Max, Difficulty)
		  End If
		  If Dict.HasKey("MinQuantity") Then
		    Entry.MinQuantity = Dict.Value("MinQuantity")
		  End If
		  If Dict.HasKey("MaxQuantity") Then
		    Entry.MaxQuantity = Dict.Value("MaxQuantity")
		  End If
		  
		  // If bForceBlueprint is not included or explicitly true, then force is true. This
		  // mirrors how Ark works. If bForceBlueprint is false, then look to one of the
		  // chance keys. If neither key is specified, chance default to 1.0.
		  Var ForceBlueprint As Boolean = if(Dict.HasKey("bForceBlueprint"), Dict.Value("bForceBlueprint"), True)
		  Var Chance As Double
		  If ForceBlueprint Then
		    Chance = 1.0
		  Else
		    If Dict.HasKey("ChanceToActuallyGiveItem") Then
		      Chance = 1.0 - Dict.Value("ChanceToActuallyGiveItem")
		    ElseIf Dict.HasKey("ChanceToBeBlueprintOverride") Then
		      Chance = Dict.Value("ChanceToBeBlueprintOverride")
		    Else
		      Chance = 0.0
		    End If
		  End If
		  Entry.ChanceToBeBlueprint = Chance
		  
		  Var ClassWeights() As Variant
		  If Dict.HasKey("ItemsWeights") Then
		    ClassWeights = Dict.Value("ItemsWeights")
		  End If
		  
		  Var Engrams() As Beacon.Engram
		  If Dict.HasKey("ItemClassStrings") Then
		    Var ClassStrings() As Variant = Dict.Value("ItemClassStrings")
		    For Each ClassString As String In ClassStrings
		      Var Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		      If Engram <> Nil Then
		        Engrams.Add(Engram)
		      Else
		        Engrams.Add(Beacon.Engram.CreateFromClass(ClassString))
		      End If
		    Next
		  ElseIf Dict.HasKey("Items") Then
		    Var Paths() As Variant = Dict.Value("Items")
		    For Each Path As String In Paths
		      If Path.Length > 23 And Path.Left(23) = "BlueprintGeneratedClass" Then
		        Path = Path.Middle(24, Path.Length - 27)
		      ElseIf Path.Length > 9 And Path.Left(9) = "Blueprint" Then
		        // This technically does not work, but we'll support it
		        Path = Path.Middle(10, Path.Length - 11)
		      Else
		        // No idea what this says
		        Break
		        Continue
		      End If
		      
		      Var Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Path)
		      If Engram = Nil Then
		        Engram = Beacon.Engram.CreateFromPath(Path)
		      End If
		      Engrams.Add(Engram)
		    Next
		  End If
		  
		  If ClassWeights.LastRowIndex < Engrams.LastRowIndex Then
		    // Add more values
		    While ClassWeights.LastRowIndex < Engrams.LastRowIndex
		      ClassWeights.Add(1)
		    Wend
		  ElseIf ClassWeights.LastRowIndex > Engrams.LastRowIndex Then
		    // Just truncate
		    ClassWeights.ResizeTo(Engrams.LastRowIndex)
		  End If
		  
		  For I As Integer = 0 To Engrams.LastRowIndex
		    Try
		      Var Engram As Beacon.Engram = Engrams(I)
		      Var ClassWeight As Double = ClassWeights(I)
		      Entry.Append(New Beacon.SetEntryOption(Engram, If(ClassWeight > 1.0, ClassWeight / 100, ClassWeight)))
		    Catch Err As RuntimeException
		      Continue
		    End Try
		  Next
		  
		  Entry.Modified = False
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As Beacon.SetEntryOption) As Integer
		  For I As Integer = 0 To Self.mOptions.LastRowIndex
		    If Self.mOptions(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Beacon.SetEntryOption)
		  Self.mOptions.AddRowAt(Index, Item)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  For Each Option As Beacon.SetEntryOption In Self.mOptions
		    If Not Option.IsValid(Document) Then
		      Return False
		    End If
		  Next
		  Return Self.mOptions.LastRowIndex > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  Var Options() As Variant
		  Options.ResizeTo(Self.mOptions.LastRowIndex)
		  For I As Integer = 0 To Self.mOptions.LastRowIndex
		    Options(I) = Self.mOptions(I)
		  Next
		  Return New Beacon.GenericIterator(Options)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Entries() As Beacon.SetEntry, Separator As String, Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Var Values() As String
		  For Each Entry As Beacon.SetEntry In Entries
		    Values.Add(Entry.StringValue(Multipliers, UseBlueprints, Difficulty))
		  Next
		  Return Values.Join(Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mOptions.LastRowIndex = -1 Then
		    Return "No Items"
		  ElseIf Self.mOptions.LastRowIndex = 0 Then
		    Return Self.mOptions(0).Engram.Label
		  ElseIf Self.mOptions.LastRowIndex = 1 Then
		    Return Self.mOptions(0).Engram.Label + " or " + Self.mOptions(1).Engram.Label
		  Else
		    Var Labels() As String
		    For I As Integer = 0 To Self.mOptions.LastRowIndex - 1
		      Labels.Add(Self.mOptions(I).Engram.Label)
		    Next
		    Labels.Add("or " + Self.mOptions(Self.mOptions.LastRowIndex).Engram.Label)
		    
		    Return Labels.Join(", ")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Merge(Entries() As Beacon.SetEntry) As Beacon.SetEntry
		  If Entries.Count = 0 Then
		    Return Nil
		  ElseIf Entries.Count = 1 Then
		    Return New Beacon.SetEntry(Entries(0))
		  End If
		  
		  Var EntryCount As Integer
		  Var EntryWeightSum, EntryChanceSum As Double
		  Var MinQualitySum, MaxQualitySum As Double
		  Var MinQuantity, MaxQuantity As Integer = -1
		  Var Options As New Dictionary
		  For Each Entry As Beacon.SetEntry In Entries
		    Var EntryAdded As Boolean
		    For Each Option As Beacon.SetEntryOption In Entry
		      If Option.Engram = Nil Or Option.Engram.IsValid = False Then
		        Continue
		      End If
		      
		      Var Key As String = Option.Engram.Path
		      If Key = "" Then
		        Continue
		      End If
		      
		      If EntryAdded = False Then
		        EntryWeightSum = EntryWeightSum + Entry.RawWeight
		        EntryChanceSum = EntryChanceSum + Entry.ChanceToBeBlueprint
		        EntryCount = EntryCount + 1
		        MinQualitySum = MinQualitySum + Entry.MinQuality.BaseValue
		        MaxQualitySum = MaxQualitySum + Entry.MaxQuality.BaseValue
		        EntryAdded = True
		      End If
		      
		      If MinQuantity = -1 Then
		        MinQuantity = Entry.MinQuantity
		      Else
		        MinQuantity = Min(MinQuantity, Entry.MinQuantity)
		      End If
		      MaxQuantity = Max(MaxQuantity, Entry.MaxQuantity)
		      
		      Var Arr() As Beacon.SetEntryOption
		      If Options.HasKey(Key) Then
		        Arr = Options.Value(Key)
		      End If
		      Arr.Add(Option)
		      Options.Value(Key) = Arr
		    Next
		  Next
		  
		  If Options.KeyCount = 0 Then
		    Return Nil
		  End If
		  
		  Var Replacement As New Beacon.SetEntry
		  Replacement.RawWeight = EntryWeightSum / EntryCount
		  Replacement.ChanceToBeBlueprint = EntryChanceSum / EntryCount
		  Replacement.MinQuantity = MinQuantity
		  Replacement.MaxQuantity = MaxQuantity
		  Replacement.MinQuality = Beacon.Qualities.ForBaseValue(MinQualitySum / EntryCount)
		  Replacement.MaxQuality = Beacon.Qualities.ForBaseValue(MaxQualitySum / EntryCount)
		  
		  For Each Entry As DictionaryEntry In Options
		    Var Arr() As Beacon.SetEntryOption = Entry.Value
		    For Each Option As Beacon.SetEntryOption In Arr
		      Replacement.Append(New Beacon.SetEntryOption(Option))
		    Next
		  Next
		  
		  Return Replacement
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mLastModifiedTime > Self.mLastSaveTime Then
		    Return True
		  End If
		  
		  For Each Option As Beacon.SetEntryOption In Self.mOptions
		    If Option.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value = False Then
		    Self.mLastSaveTime = System.Microseconds
		  Else
		    Self.mLastModifiedTime = System.Microseconds
		  End If
		  
		  If Not Value Then
		    For Each Option As Beacon.SetEntryOption In Self.mOptions
		      Option.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.SetEntry) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Var SelfHash As String = Self.Hash
		  Var OtherHash As String = Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.SetEntryOption
		  Return Self.mOptions(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Item As Beacon.SetEntryOption)
		  Self.mOptions(Index) = Item
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mOptions.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.mOptions.ResizeTo(Bound)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SafeForMods(Mods As Beacon.StringList) As Boolean
		  // This method kind of sucks, but yes it is needed for preset generation.
		  
		  If Mods.Count = CType(0, UInteger) Then
		    Return True
		  End If
		  
		  For Each Option As Beacon.SetEntryOption In Self.mOptions
		    If Mods.IndexOf(Option.Engram.ModID) = -1 Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate() As Beacon.SimulatedSelection()
		  Var Quantity As Integer
		  If Self.mMaxQuantity < Self.mMinQuantity Then
		    Quantity = System.Random.InRange(Self.mMaxQuantity, Self.mMinQuantity)
		  Else
		    Quantity = System.Random.InRange(Self.mMinQuantity, Self.mMaxQuantity)
		  End If
		  Var MinQuality As Double = Self.mMinQuality.BaseValue
		  Var MaxQuality As Double = Self.mMaxQuality.BaseValue
		  Var Selections() As Beacon.SimulatedSelection
		  Var RequiredChance As Integer = (1 - Self.mChanceToBeBlueprint) * 100
		  
		  If MaxQuality < MinQuality Then
		    Var Temp As Double = MinQuality
		    MinQuality = MaxQuality
		    MaxQuality = Temp
		  End If
		  
		  Var WeightLookup As New Dictionary
		  Var Sum, Weights() As Double
		  For Each Entry As Beacon.SetEntryOption In Self.mOptions
		    If Entry.Weight = 0 Then
		      Return Selections
		    End If
		    Sum = Sum + Entry.Weight
		    Weights.Add(Sum * 100000)
		    WeightLookup.Value(Sum * 100000) = Entry
		  Next
		  Weights.Sort
		  
		  For I As Integer = 1 To Quantity
		    Var QualityValue As Double = (System.Random.InRange(MinQuality * 100000, MaxQuality * 100000) / 100000)
		    Var BlueprintDecision As Integer = System.Random.InRange(1, 100)
		    Var ClassDecision As Double = System.Random.InRange(100000, 100000 + (Sum * 100000)) - 100000
		    Var Selection As New Beacon.SimulatedSelection
		    
		    For X As Integer = 0 To Weights.LastRowIndex
		      If Weights(X) >= ClassDecision Then
		        Var SelectedWeight As Double = Weights(X)
		        Var SelectedEntry As Beacon.SetEntryOption = WeightLookup.Value(SelectedWeight)
		        Selection.Engram = SelectedEntry.Engram
		        Exit For X
		      End If
		    Next
		    If Selection.Engram = Nil Then
		      Continue
		    End If
		    
		    Selection.IsBlueprint = BlueprintDecision > RequiredChance
		    Selection.Quality = Beacon.Qualities.ForBaseValue(QualityValue)
		    Selections.Add(Selection)
		  Next
		  
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Split(Entries() As Beacon.SetEntry) As Beacon.SetEntry()
		  Var Replacements() As Beacon.SetEntry
		  For Each Entry As Beacon.SetEntry In Entries
		    If Entry.Count = 1 Then
		      Replacements.Add(New Beacon.SetEntry(Entry))
		      Continue
		    End If
		    
		    For Each Option As Beacon.SetEntryOption In Entry
		      Var Replacement As New Beacon.SetEntry(Entry)
		      Replacement.ResizeTo(0)
		      Replacement(0) = New Beacon.SetEntryOption(Option)
		      Replacements.Add(Replacement)
		    Next
		  Next
		  Return Replacements
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Var Paths(), Weights(), Classes() As String
		  Paths.ResizeTo(Self.mOptions.LastRowIndex)
		  Weights.ResizeTo(Self.mOptions.LastRowIndex)
		  Classes.ResizeTo(Self.mOptions.LastRowIndex)
		  For I As Integer = 0 To Self.mOptions.LastRowIndex
		    Paths(I) = Self.mOptions(I).Engram.GeneratedClassBlueprintPath()
		    Classes(I) = """" + Self.mOptions(I).Engram.ClassString + """"
		    Weights(I) = Beacon.PrettyText(Self.mOptions(I).Weight * 100)
		  Next
		  
		  Var MinQuality As Double = Self.mMinQuality.Value(Multipliers.Min, Difficulty)
		  Var MaxQuality As Double = Self.mMaxQuality.Value(Multipliers.Max, Difficulty)
		  If MinQuality > MaxQuality Then
		    // This probably isn't a good thing. Use the min for both values.
		    MaxQuality = MinQuality
		  End If
		  
		  Var Chance As Double = if(Self.CanBeBlueprint, Self.mChanceToBeBlueprint, 0)
		  Var EntryWeight As Integer = Self.mWeight
		  
		  Var Values() As String
		  Values.Add("EntryWeight=" + EntryWeight.ToString)
		  If UseBlueprints Then
		    Values.Add("Items=(" + Paths.Join(",") + ")")
		  Else
		    Values.Add("ItemClassStrings=(" + Classes.Join(",") + ")")
		  End If
		  Values.Add("ItemsWeights=(" + Weights.Join(",") + ")")
		  Values.Add("MinQuantity=" + Self.MinQuantity.ToString)
		  Values.Add("MaxQuantity=" + Self.MaxQuantity.ToString)
		  Values.Add("MinQuality=" + MinQuality.PrettyText)
		  Values.Add("MaxQuality=" + MaxQuality.PrettyText)
		  
		  // ChanceToActuallyGiveItem and ChanceToBeBlueprintOverride appear to be inverse of each
		  // other. I'm not sure why both exist, but I've got a theory. Some of the loot source
		  // definitions are based on PrimalSupplyCrateItemSets and others on PrimalSupplyCrateItemSet.
		  // There's no common parent between them. Seems like Wildcard messed this up. I think
		  // PrimalSupplyCrateItemSets uses ChanceToActuallyGiveItem, and PrimalSupplyCrateItemSet
		  // uses ChanceToBeBlueprintOverride. Safest option right now is to include both.
		  
		  // 2017-07-07: As of 261.0, it appears ChanceToActuallyGiveItem does something else. It will
		  // now be left off.
		  If Chance < 1 Then
		    Values.Add("bForceBlueprint=false")
		  Else
		    Values.Add("bForceBlueprint=true")
		  End If
		  //Values.Add("ChanceToActuallyGiveItem=" + InverseChance.PrettyText)
		  Values.Add("ChanceToBeBlueprintOverride=" + Chance.PrettyText)
		  
		  Return "(" + Values.Join(",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UniqueID() As String
		  // For efficiency, don't create a UUID until it is needed
		  If Self.mUniqueID = "" Then
		    Self.mUniqueID = New v4UUID
		  End If
		  Return Self.mUniqueID
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mChanceToBeBlueprint
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Min(Value, 1.0), 0.0)
			  If Self.mChanceToBeBlueprint = Value Then
			    Return
			  End If
			  
			  Self.mChanceToBeBlueprint = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		ChanceToBeBlueprint As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mChanceToBeBlueprint >= 1.0
			End Get
		#tag EndGetter
		ForceBlueprint As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMaxQuality
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMaxQuality = Value Then
			    Return
			  End If
			  
			  Self.mMaxQuality = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MaxQuality As Beacon.Quality
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Self.mMaxQuantity, Self.mMinQuantity)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 1)
			  If Self.mMaxQuantity = Value Then
			    Return
			  End If
			  
			  Self.mMaxQuantity = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MaxQuantity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mChanceToBeBlueprint As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinQuality
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMinQuality = Value Then
			    Return
			  End If
			  
			  Self.mMinQuality = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MinQuality As Beacon.Quality
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Min(Max(Self.mMinQuantity, 1), Self.mMaxQuantity)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 1)
			  If Self.mMinQuantity = Value Then
			    Return
			  End If
			  
			  Self.mMinQuantity = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MinQuantity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastHashTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastModifiedTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSaveTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxQuality As Beacon.Quality
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinQuality As Beacon.Quality
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptions() As Beacon.SetEntryOption
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUniqueID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeight As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mWeight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 0.0001)
			  If Self.mWeight = Value Then
			    Return
			  End If
			  
			  Self.mWeight = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		RawWeight As Double
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ChanceToBeBlueprint"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ForceBlueprint"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxQuantity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinQuantity"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
		#tag ViewProperty
			Name="RawWeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
