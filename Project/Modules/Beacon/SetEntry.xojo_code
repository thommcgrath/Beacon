#tag Class
Protected Class SetEntry
Implements Beacon.Countable,Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.SetEntryOption)
		  Self.mOptions.Append(Item)
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
		  Select Case Self.mOptions.Ubound
		  Case -1
		    Return "No Items"
		  Case 0
		    Return Self.mOptions(0).Engram.ClassString
		  Case 1
		    Return Self.mOptions(0).Engram.ClassString + " or " + Self.mOptions(1).Engram.ClassString
		  Else
		    Dim Labels() As String
		    For I As Integer = 0 To Self.mOptions.Ubound - 1
		      Labels.Append(Self.mOptions(I).Engram.ClassString)
		    Next
		    Labels.Append("or " + Self.mOptions(Self.mOptions.Ubound).Engram.ClassString)
		    
		    Return Join(Labels, ", ")
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinQuantity = 1
		  Self.mMaxQuantity = 1
		  Self.mMinQuality = Beacon.Qualities.Tier1
		  Self.mMaxQuality = Beacon.Qualities.Tier3
		  Self.mChanceToBeBlueprint = 1.0
		  Self.mWeight = 250
		  Self.mUniqueID = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntry)
		  Self.Constructor()
		  
		  Redim Self.mOptions(UBound(Source.mOptions))
		  
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
		  
		  For I As Integer = 0 To UBound(Source.mOptions)
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
		  ' For I As Integer = 0 To UBound(Self.mOptions)
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
		  Return UBound(Self.mOptions) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateBlueprintEntry(Entries() As Beacon.SetEntry) As Beacon.SetEntry
		  If UBound(Entries) = -1 Then
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
		      Arr.Append(Option)
		      Options.Value(Key) = Arr
		    Next
		  Next
		  
		  If Options.Count = 0 Then
		    Return Nil
		  End If
		  
		  Dim BlueprintEntry As New Beacon.SetEntry
		  For Each Entry As DictionaryMember In Options.Members
		    Dim Path As String = Entry.Key
		    Dim Arr() As Beacon.SetEntryOption = Entry.Value
		    Dim Count As Integer = Arr.Ubound + 1
		    Dim WeightSum As Double
		    For Each Option As Beacon.SetEntryOption In Arr
		      WeightSum = WeightSum + Option.Weight
		    Next
		    Dim AverageWeight As Double = WeightSum / Count
		    
		    BlueprintEntry.Append(New Beacon.SetEntryOption(Beacon.Data.GetEngramByPath(Path), AverageWeight))
		  Next
		  
		  BlueprintEntry.ChanceToBeBlueprint = 1.0
		  BlueprintEntry.MaxQuantity = 1
		  BlueprintEntry.MinQuantity = 1
		  BlueprintEntry.MinQuality = Beacon.Qualities.ForBaseValue(MinQualitySum / Options.Count)
		  BlueprintEntry.MaxQuality = Beacon.Qualities.ForBaseValue(MaxQualitySum / Options.Count)
		  
		  Return BlueprintEntry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Dim Children() As Dictionary
		  For Each Item As Beacon.SetEntryOption In Self.mOptions
		    Children.Append(Item.Export)
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
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Beacon.SetEntryIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.HashIsStale Then
		    Dim Items() As String
		    Redim Items(Self.mOptions.Ubound)
		    For I As Integer = 0 To Items.Ubound
		      Items(I) = Self.mOptions(I).Hash
		    Next
		    Items.Sort
		    
		    Dim Format As String = "0.000"
		    
		    Dim Parts(6) As String
		    Parts(0) = Beacon.MD5(Join(Items, ","))
		    Parts(1) = Str(Self.ChanceToBeBlueprint, Format)
		    Parts(2) = Self.MaxQuality.Key.Lowercase
		    Parts(3) = Str(Self.MaxQuantity, Format)
		    Parts(4) = Self.MinQuality.Key.Lowercase
		    Parts(5) = Str(Self.MinQuantity, Format)
		    Parts(6) = Str(Self.RawWeight, Format)
		    
		    Self.mHash = Beacon.MD5(Join(Parts, ","))
		    Self.mLastHashTime = Microseconds
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
		  
		  Entry.MinQuantity = Dict.Lookup("MinQuantity", Entry.MinQuantity)
		  Entry.MaxQuantity = Dict.Lookup("MaxQuantity", Entry.MaxQuantity)
		  Entry.ChanceToBeBlueprint = Dict.Lookup("ChanceToBeBlueprintOverride", Entry.ChanceToBeBlueprint)
		  
		  If Dict.HasKey("Items") Then
		    Dim Children() As Object = Dict.Value("Items")
		    For Each Obj As Object In Children
		      If Obj IsA Dictionary Then
		        Entry.Append(Beacon.SetEntryOption.ImportFromBeacon(Dictionary(Obj)))
		      End If
		    Next
		  End If
		  Entry.Modified = False
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Multipliers As Beacon.Range, DifficultyValue As Double) As Beacon.SetEntry
		  Dim Entry As New Beacon.SetEntry
		  If Dict.HasKey("EntryWeight") Then
		    Entry.RawWeight = Dict.Value("EntryWeight")
		  End If
		  
		  If Dict.HasKey("MinQuality") Then
		    Entry.MinQuality = Beacon.Qualities.ForValue(Dict.Value("MinQuality"), Multipliers.Min, DifficultyValue)
		  End If
		  If Dict.HasKey("MaxQuality") Then
		    Entry.MaxQuality = Beacon.Qualities.ForValue(Dict.Value("MaxQuality"), Multipliers.Max, DifficultyValue)
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
		      Chance = 1.0
		    End If
		  End If
		  Entry.ChanceToBeBlueprint = Chance
		  
		  Dim ClassWeights() As Auto
		  If Dict.HasKey("ItemsWeights") Then
		    ClassWeights = Dict.Value("ItemsWeights")
		  End If
		  
		  Dim Engrams() As Beacon.Engram
		  If Dict.HasKey("ItemClassStrings") Then
		    Dim ClassStrings() As String = Dict.Value("ItemClassStrings")
		    For Each ClassString As String In ClassStrings
		      Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		      If Engram <> Nil Then
		        Engrams.Append(Engram)
		      Else
		        Engrams.Append(Beacon.Engram.CreateUnknownEngram(ClassString))
		      End If
		    Next
		  ElseIf Dict.HasKey("Items") Then
		    Dim Paths() As String = Dict.Value("Items")
		    For Each Path As String In Paths
		      If Path.Length > 23 And Path.Left(23) = "BlueprintGeneratedClass" Then
		        Path = Path.Mid(24, Path.Length - 27)
		      ElseIf Path.Length > 9 And Path.Left(9) = "Blueprint" Then
		        // This technically does not work, but we'll support it
		        Path = Path.Mid(10, Path.Length - 11)
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
		      Engrams.Append(Engram)
		    Next
		  End If
		  
		  If UBound(ClassWeights) < UBound(Engrams) Then
		    // Add more values
		    While UBound(ClassWeights) < UBound(Engrams)
		      ClassWeights.Append(1)
		    Wend
		  ElseIf UBound(ClassWeights) > UBound(Engrams) Then
		    // Just truncate
		    Redim ClassWeights(UBound(Engrams))
		  End If
		  
		  For I As Integer = 0 To UBound(Engrams)
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
		  For I As Integer = 0 To UBound(Self.mOptions)
		    If Self.mOptions(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Beacon.SetEntryOption)
		  Self.mOptions.Insert(Index, Item)
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
		  Return Self.mOptions.Ubound > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Entries() As Beacon.SetEntry, Separator As String, Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Dim Values() As String
		  For Each Entry As Beacon.SetEntry In Entries
		    Values.Append(Entry.StringValue(Multipliers, UseBlueprints, Difficulty))
		  Next
		  Return Join(Values, Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Select Case Self.mOptions.Ubound
		  Case -1
		    Return "No Items"
		  Case 0
		    Return Self.mOptions(0).Engram.Label
		  Case 1
		    Return Self.mOptions(0).Engram.Label + " or " + Self.mOptions(1).Engram.Label
		  Else
		    Dim Labels() As String
		    For I As Integer = 0 To Self.mOptions.Ubound - 1
		      Labels.Append(Self.mOptions(I).Engram.Label)
		    Next
		    Labels.Append("or " + Self.mOptions(Self.mOptions.Ubound).Engram.Label)
		    
		    Return Join(Labels, ", ")
		  End Select
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
		    Self.mLastSaveTime = Microseconds
		  Else
		    Self.mLastModifiedTime = Microseconds
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
		  
		  Return StrComp(SelfHash, OtherHash, 0)
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
		  Self.mOptions.Remove(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SafeForMods(Mods As Beacon.StringList) As Boolean
		  If Mods.Ubound = -1 Then
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
		    Quantity = RandomInt(Self.mMaxQuantity, Self.mMinQuantity)
		  Else
		    Quantity = RandomInt(Self.mMinQuantity, Self.mMaxQuantity)
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
		    Weights.Append(Sum * 100000)
		    WeightLookup.Value(Sum * 100000) = Entry
		  Next
		  Weights.Sort
		  
		  For I As Integer = 1 To Quantity
		    Dim QualityValue As Double = (RandomInt(MinQuality * 100000, MaxQuality * 100000) / 100000)
		    Dim BlueprintDecision As Integer = RandomInt(1, 100)
		    Dim ClassDecision As Double = RandomInt(100000, 100000 + (Sum * 100000)) - 100000
		    Dim Selection As New Beacon.SimulatedSelection
		    
		    For X As Integer = 0 To UBound(Weights)
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
		    Selections.Append(Selection)
		  Next
		  
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Dim Paths(), Weights(), Classes() As String
		  Redim Paths(Self.mOptions.Ubound)
		  Redim Weights(Self.mOptions.Ubound)
		  Redim Classes(Self.mOptions.Ubound)
		  Dim SumOptionWeights As Double
		  For I As Integer = 0 To Self.mOptions.Ubound
		    SumOptionWeights = SumOptionWeights + Self.mOptions(I).Weight
		  Next
		  For I As Integer = 0 To Self.mOptions.Ubound
		    Dim RelativeWeight As Integer = Round((Self.mOptions(I).Weight / SumOptionWeights) * 1000)
		    Paths(I) = Self.mOptions(I).Engram.GeneratedClassBlueprintPath()
		    Classes(I) = """" + Self.mOptions(I).Engram.ClassString + """"
		    Weights(I) = Str(RelativeWeight, "-0")
		  Next
		  
		  Dim MinQuality As Double = Self.mMinQuality.Value(Multipliers.Min, Difficulty)
		  Dim MaxQuality As Double = Self.mMaxQuality.Value(Multipliers.Max, Difficulty)
		  If MinQuality > MaxQuality Then
		    // This probably isn't a good thing. Use the min for both values.
		    MaxQuality = MinQuality
		  End If
		  
		  Dim Chance As Double = if(Self.CanBeBlueprint, Self.mChanceToBeBlueprint, 0)
		  
		  Dim Values() As String
		  Values.Append("EntryWeight=" + Self.mWeight.PrettyString)
		  If UseBlueprints Then
		    Values.Append("Items=(" + Join(Paths, ",") + ")")
		  Else
		    Values.Append("ItemClassStrings=(" + Join(Classes, ",") + ")")
		  End If
		  Values.Append("ItemsWeights=(" + Join(Weights, ",") + ")")
		  Values.Append("MinQuantity=" + Str(Self.MinQuantity, "-0"))
		  Values.Append("MaxQuantity=" + Str(Self.MaxQuantity, "-0"))
		  Values.Append("MinQuality=" + MinQuality.PrettyString)
		  Values.Append("MaxQuality=" + MaxQuality.PrettyString)
		  
		  // ChanceToActuallyGiveItem and ChanceToBeBlueprintOverride appear to be inverse of each
		  // other. I'm not sure why both exist, but I've got a theory. Some of the loot source
		  // definitions are based on PrimalSupplyCrateItemSets and others on PrimalSupplyCrateItemSet.
		  // There's no common parent between them. Seems like Wildcard messed this up. I think
		  // PrimalSupplyCrateItemSets uses ChanceToActuallyGiveItem, and PrimalSupplyCrateItemSet
		  // uses ChanceToBeBlueprintOverride. Safest option right now is to include both.
		  
		  // 2017-07-07: As of 261.0, it appears ChanceToActuallyGiveItem does something else. It will
		  // now be left off.
		  If Chance < 1 Then
		    Values.Append("bForceBlueprint=false")
		  Else
		    Values.Append("bForceBlueprint=true")
		  End If
		  //Values.Append("ChanceToActuallyGiveItem=" + InverseChance.PrettyString)
		  Values.Append("ChanceToBeBlueprintOverride=" + Chance.PrettyString)
		  
		  Return "(" + Join(Values, ",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UniqueID() As String
		  // For efficiency, don't create a UUID until it is needed
		  If Self.mUniqueID = "" Then
		    Self.mUniqueID = Beacon.CreateUUID
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
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ForceBlueprint"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
			Name="MaxQuantity"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinQuantity"
			Group="Behavior"
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
		#tag ViewProperty
			Name="RawWeight"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
