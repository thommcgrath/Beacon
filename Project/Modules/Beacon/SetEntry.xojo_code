#tag Class
Protected Class SetEntry
Implements Beacon.Countable,Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.SetEntryOption)
		  Self.mOptions.AddRow(Item)
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
		    Dim Labels() As String
		    For I As Integer = 0 To Self.mOptions.LastRowIndex - 1
		      Labels.AddRow(Self.mOptions(I).Engram.ClassString)
		    Next
		    Labels.AddRow("or " + Self.mOptions(Self.mOptions.LastRowIndex).Engram.ClassString)
		    
		    Return Labels.Join(", ")
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
		  
		  Redim Self.mOptions(Source.mOptions.LastRowIndex)
		  
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
		  
		  Dim MinQualitySum, MaxQualitySum As Double
		  Dim Options As New Dictionary
		  For Each Entry As Beacon.SetEntry In Entries
		    For Each Option As Beacon.SetEntryOption In Entry
		      If Option.Engram = Nil Or Option.Engram.IsValid = False Or Option.Engram.IsTagged("blueprintable") = False Then
		        Continue
		      End If
		      
		      Dim Key As String = Option.Engram.Path
		      If Key = "" Then
		        Continue
		      End If
		      
		      MinQualitySum = MinQualitySum + Entry.MinQuality.BaseValue
		      MaxQualitySum = MaxQualitySum + Entry.MaxQuality.BaseValue
		      
		      Dim Arr() As Beacon.SetEntryOption
		      If Options.HasKey(Key) Then
		        Arr = Options.Value(Key)
		      End If
		      Arr.AddRow(Option)
		      Options.Value(Key) = Arr
		    Next
		  Next
		  
		  If Options.KeyCount = 0 Then
		    Return Nil
		  End If
		  
		  Dim BlueprintEntry As New Beacon.SetEntry
		  For Each Entry As DictionaryEntry In Options
		    Dim Path As String = Entry.Key
		    Dim Arr() As Beacon.SetEntryOption = Entry.Value
		    Dim Count As Integer = Arr.LastRowIndex + 1
		    Dim WeightSum As Double
		    For Each Option As Beacon.SetEntryOption In Arr
		      WeightSum = WeightSum + Option.Weight
		    Next
		    Dim AverageWeight As Double = WeightSum / Count
		    
		    Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Path)
		    If Engram = Nil Then
		      Engram = Beacon.Engram.CreateUnknownEngram(Path)
		    End If
		    
		    BlueprintEntry.Append(New Beacon.SetEntryOption(Engram, AverageWeight))
		  Next
		  
		  BlueprintEntry.ChanceToBeBlueprint = 1.0
		  BlueprintEntry.MaxQuantity = 1
		  BlueprintEntry.MinQuantity = 1
		  BlueprintEntry.MinQuality = Beacon.Qualities.ForBaseValue(MinQualitySum / Options.KeyCount)
		  BlueprintEntry.MaxQuality = Beacon.Qualities.ForBaseValue(MaxQualitySum / Options.KeyCount)
		  
		  Return BlueprintEntry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Dim Children() As Dictionary
		  For Each Item As Beacon.SetEntryOption In Self.mOptions
		    Children.AddRow(Item.Export)
		  Next
		  
		  Dim Keys As New Dictionary
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
		    Dim Items() As String
		    Redim Items(Self.mOptions.LastRowIndex)
		    For I As Integer = 0 To Items.LastRowIndex
		      Items(I) = Self.mOptions(I).Hash
		    Next
		    Items.Sort
		    
		    Dim Locale As Locale = Locale.Raw
		    Dim Format As String = "0.000"
		    
		    Dim Parts(6) As String
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
		  Dim Entry As New Beacon.SetEntry
		  If Dict.HasKey("Weight") Then
		    Entry.RawWeight = Dict.Value("Weight")
		  ElseIf Dict.HasKey("EntryWeight") Then
		    Entry.RawWeight = Dict.Value("EntryWeight") * 1000.0
		  End If
		  If Dict.HasKey("MinQuality") Then
		    Entry.MinQuality = Beacon.Qualities.ForKey(Dict.Value("MinQuality"))
		  End If
		  If Dict.HasKey("MaxQuality") Then
		    Entry.MaxQuality = Beacon.Qualities.ForKey(Dict.Value("MaxQuality"))
		  End If
		  If Dict.HasKey("MinQuantity") Then
		    Entry.MinQuantity = Dict.Value("MinQuantity")
		  End If
		  If Dict.HasKey("MaxQuantity") Then
		    Entry.MaxQuantity = Dict.Value("MaxQuantity")
		  End If
		  If Dict.HasKey("ChanceToBeBlueprintOverride") Then
		    Entry.ChanceToBeBlueprint = Dict.Value("ChanceToBeBlueprintOverride")
		  End If
		  If Dict.HasKey("Items") Then
		    Dim Children() As Variant = Dict.Value("Items")
		    For Each Child As Dictionary In Children
		      Entry.Append(Beacon.SetEntryOption.ImportFromBeacon(Child))
		    Next
		  End If
		  Entry.Modified = False
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Multipliers As Beacon.Range, Difficulty As BeaconConfigs.Difficulty) As Beacon.SetEntry
		  Dim Entry As New Beacon.SetEntry
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
		  Dim ForceBlueprint As Boolean = if(Dict.HasKey("bForceBlueprint"), Dict.Value("bForceBlueprint"), True)
		  Dim Chance As Double
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
		  
		  Dim ClassWeights() As Variant
		  If Dict.HasKey("ItemsWeights") Then
		    ClassWeights = Dict.Value("ItemsWeights")
		  End If
		  
		  Dim Engrams() As Beacon.Engram
		  If Dict.HasKey("ItemClassStrings") Then
		    Dim ClassStrings() As Variant = Dict.Value("ItemClassStrings")
		    For Each ClassString As String In ClassStrings
		      Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		      If Engram <> Nil Then
		        Engrams.AddRow(Engram)
		      Else
		        Engrams.AddRow(Beacon.Engram.CreateUnknownEngram(ClassString))
		      End If
		    Next
		  ElseIf Dict.HasKey("Items") Then
		    Dim Paths() As Variant = Dict.Value("Items")
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
		      
		      Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Path)
		      If Engram = Nil Then
		        // Path was not found
		        Dim TempEngram As Beacon.Engram = Beacon.Engram.CreateUnknownEngram(Path)
		        Engram = Beacon.Data.GetEngramByClass(TempEngram.ClassString)
		        If Engram = Nil Then
		          // Didn't find it by class either
		          Engram = TempEngram
		        End If
		      End If
		      Engrams.AddRow(Engram)
		    Next
		  End If
		  
		  If ClassWeights.LastRowIndex < Engrams.LastRowIndex Then
		    // Add more values
		    While ClassWeights.LastRowIndex < Engrams.LastRowIndex
		      ClassWeights.AddRow(1)
		    Wend
		  ElseIf ClassWeights.LastRowIndex > Engrams.LastRowIndex Then
		    // Just truncate
		    Redim ClassWeights(Engrams.LastRowIndex)
		  End If
		  
		  For I As Integer = 0 To Engrams.LastRowIndex
		    Try
		      Dim Engram As Beacon.Engram = Engrams(I)
		      Dim ClassWeight As Double = ClassWeights(I)
		      Entry.Append(New Beacon.SetEntryOption(Engram, ClassWeight))
		    Catch Err As TypeMismatchException
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
		  Dim Options() As Variant
		  Redim Options(Self.mOptions.LastRowIndex)
		  For I As Integer = 0 To Self.mOptions.LastRowIndex
		    Options(I) = Self.mOptions(I)
		  Next
		  Return New Beacon.GenericIterator(Options)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Entries() As Beacon.SetEntry, Separator As String, Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Dim Values() As String
		  For Each Entry As Beacon.SetEntry In Entries
		    Values.AddRow(Entry.StringValue(Multipliers, UseBlueprints, Difficulty))
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
		    Dim Labels() As String
		    For I As Integer = 0 To Self.mOptions.LastRowIndex - 1
		      Labels.AddRow(Self.mOptions(I).Engram.Label)
		    Next
		    Labels.AddRow("or " + Self.mOptions(Self.mOptions.LastRowIndex).Engram.Label)
		    
		    Return Labels.Join(", ")
		  End If
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
		  
		  Dim SelfHash As String = Self.Hash
		  Dim OtherHash As String = Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mOptions(Bound)
		  Self.Modified = True
		End Sub
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
		  Self.mOptions.RemoveRowAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SafeForMods(Mods As Beacon.StringList) As Boolean
		  If Mods.LastRowIndex = -1 Then
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
		  Dim Quantity As Integer
		  If Self.mMaxQuantity < Self.mMinQuantity Then
		    Quantity = System.Random.InRange(Self.mMaxQuantity, Self.mMinQuantity)
		  Else
		    Quantity = System.Random.InRange(Self.mMinQuantity, Self.mMaxQuantity)
		  End If
		  Dim MinQuality As Double = Self.mMinQuality.BaseValue
		  Dim MaxQuality As Double = Self.mMaxQuality.BaseValue
		  Dim Selections() As Beacon.SimulatedSelection
		  Dim RequiredChance As Integer = (1 - Self.mChanceToBeBlueprint) * 100
		  
		  If MaxQuality < MinQuality Then
		    Dim Temp As Double = MinQuality
		    MinQuality = MaxQuality
		    MaxQuality = Temp
		  End If
		  
		  Dim WeightLookup As New Dictionary
		  Dim Sum, Weights() As Double
		  For Each Entry As Beacon.SetEntryOption In Self.mOptions
		    If Entry.Weight = 0 Then
		      Return Selections
		    End If
		    Sum = Sum + Entry.Weight
		    Weights.AddRow(Sum * 100000)
		    WeightLookup.Value(Sum * 100000) = Entry
		  Next
		  Weights.Sort
		  
		  For I As Integer = 1 To Quantity
		    Dim QualityValue As Double = (System.Random.InRange(MinQuality * 100000, MaxQuality * 100000) / 100000)
		    Dim BlueprintDecision As Integer = System.Random.InRange(1, 100)
		    Dim ClassDecision As Double = System.Random.InRange(100000, 100000 + (Sum * 100000)) - 100000
		    Dim Selection As New Beacon.SimulatedSelection
		    
		    For X As Integer = 0 To Weights.LastRowIndex
		      If Weights(X) >= ClassDecision Then
		        Dim SelectedWeight As Double = Weights(X)
		        Dim SelectedEntry As Beacon.SetEntryOption = WeightLookup.Value(SelectedWeight)
		        Selection.Engram = SelectedEntry.Engram
		        Exit For X
		      End If
		    Next
		    If Selection.Engram = Nil Then
		      Continue
		    End If
		    
		    Selection.IsBlueprint = BlueprintDecision > RequiredChance
		    Selection.Quality = Beacon.Qualities.ForBaseValue(QualityValue)
		    Selections.AddRow(Selection)
		  Next
		  
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Dim Paths(), Weights(), Classes() As String
		  Redim Paths(Self.mOptions.LastRowIndex)
		  Redim Weights(Self.mOptions.LastRowIndex)
		  Redim Classes(Self.mOptions.LastRowIndex)
		  Dim SumOptionWeights As Double
		  For I As Integer = 0 To Self.mOptions.LastRowIndex
		    SumOptionWeights = SumOptionWeights + Self.mOptions(I).Weight
		  Next
		  For I As Integer = 0 To Self.mOptions.LastRowIndex
		    Dim RelativeWeight As Integer = Round((Self.mOptions(I).Weight / SumOptionWeights) * 1000)
		    Paths(I) = Self.mOptions(I).Engram.GeneratedClassBlueprintPath()
		    Classes(I) = """" + Self.mOptions(I).Engram.ClassString + """"
		    Weights(I) = RelativeWeight.ToString
		  Next
		  
		  Dim MinQuality As Double = Self.mMinQuality.Value(Multipliers.Min, Difficulty)
		  Dim MaxQuality As Double = Self.mMaxQuality.Value(Multipliers.Max, Difficulty)
		  If MinQuality > MaxQuality Then
		    // This probably isn't a good thing. Use the min for both values.
		    MaxQuality = MinQuality
		  End If
		  
		  Dim Chance As Double = if(Self.CanBeBlueprint, Self.mChanceToBeBlueprint, 0)
		  Dim EntryWeight As Integer = Self.mWeight
		  
		  Dim Values() As String
		  Values.AddRow("EntryWeight=" + EntryWeight.ToString)
		  If UseBlueprints Then
		    Values.AddRow("Items=(" + Paths.Join(",") + ")")
		  Else
		    Values.AddRow("ItemClassStrings=(" + Classes.Join(",") + ")")
		  End If
		  Values.AddRow("ItemsWeights=(" + Weights.Join(",") + ")")
		  Values.AddRow("MinQuantity=" + Self.MinQuantity.ToString)
		  Values.AddRow("MaxQuantity=" + Self.MaxQuantity.ToString)
		  Values.AddRow("MinQuality=" + MinQuality.PrettyText)
		  Values.AddRow("MaxQuality=" + MaxQuality.PrettyText)
		  
		  // ChanceToActuallyGiveItem and ChanceToBeBlueprintOverride appear to be inverse of each
		  // other. I'm not sure why both exist, but I've got a theory. Some of the loot source
		  // definitions are based on PrimalSupplyCrateItemSets and others on PrimalSupplyCrateItemSet.
		  // There's no common parent between them. Seems like Wildcard messed this up. I think
		  // PrimalSupplyCrateItemSets uses ChanceToActuallyGiveItem, and PrimalSupplyCrateItemSet
		  // uses ChanceToBeBlueprintOverride. Safest option right now is to include both.
		  
		  // 2017-07-07: As of 261.0, it appears ChanceToActuallyGiveItem does something else. It will
		  // now be left off.
		  If Chance < 1 Then
		    Values.AddRow("bForceBlueprint=false")
		  Else
		    Values.AddRow("bForceBlueprint=true")
		  End If
		  //Values.AddRow("ChanceToActuallyGiveItem=" + InverseChance.PrettyText)
		  Values.AddRow("ChanceToBeBlueprintOverride=" + Chance.PrettyText)
		  
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
