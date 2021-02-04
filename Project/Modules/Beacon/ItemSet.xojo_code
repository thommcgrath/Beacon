#tag Class
Protected Class ItemSet
Implements Beacon.Countable,Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Append(Entry As Beacon.SetEntry)
		  Self.mEntries.Add(Entry)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ComputeSimulationFigures(Pool() As Beacon.SetEntry, WeightScale As Integer, ByRef WeightSum As Double, ByRef Weights() As Double, ByRef WeightLookup As Dictionary)
		  Weights.ResizeTo(-1)
		  WeightLookup = New Dictionary
		  WeightSum = 0
		  
		  For Each Entry As Beacon.SetEntry In Pool
		    If Entry.RawWeight = 0 Then
		      Continue
		    End If
		    WeightSum = WeightSum + Entry.RawWeight
		    Weights.Add(WeightSum * WeightScale)
		    WeightLookup.Value(WeightSum * WeightScale) = Entry
		  Next
		  Weights.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinNumItems = 1
		  Self.mMaxNumItems = 3
		  Self.mNumItemsPower = 1
		  Self.mSetWeight = 500
		  Self.mItemsRandomWithoutReplacement = True
		  Self.mLabel = "Untitled Item Set"
		  Self.mID = New v4UUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ItemSet)
		  Self.Constructor()
		  Self.mID = Source.mID
		  Self.CopyFrom(Source)
		  Self.mLastModifiedTime = Source.mLastModifiedTime
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Source As Beacon.ItemSet)
		  Self.mItemsRandomWithoutReplacement = Source.mItemsRandomWithoutReplacement
		  Self.mMaxNumItems = Source.mMaxNumItems
		  Self.mMinNumItems = Source.mMinNumItems
		  Self.mNumItemsPower = Source.mNumItemsPower
		  Self.mSetWeight = Source.mSetWeight
		  Self.mLabel = Source.mLabel
		  Self.mSourcePresetID = Source.mSourcePresetID
		  Self.mHash = Source.mHash
		  Self.mLastSaveTime = Source.mLastSaveTime
		  Self.mLastHashTime = Source.mLastHashTime
		  Self.mLastModifiedTime = System.Microseconds
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastIndex)
		  For I As Integer = 0 To Source.mEntries.LastIndex
		    Self.mEntries(I) = New Beacon.SetEntry(Source.mEntries(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mEntries.LastIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromPreset(Preset As Beacon.Preset, ForLootSource As Beacon.LootSource, Mask As UInt64, Mods As Beacon.StringList) As Beacon.ItemSet
		  Var Set As New Beacon.ItemSet
		  Set.Label = Preset.Label
		  // Weight is intentionally skipped, as that is relative to the source, no reason for a preset to alter that.
		  Set.mSourcePresetID = Preset.PresetID
		  
		  Var ActiveModifiers() As String = Preset.ActiveModifierIDs
		  Var QuantityMultipliers() As Double
		  Var MinQualityModifiers() As Integer
		  Var MaxQualityModifiers() As Integer
		  Var BlueprintMultipliers() As Double
		  For Each ModifierID As String In ActiveModifiers
		    Var Modifier As Beacon.PresetModifier = Beacon.Data.GetPresetModifier(ModifierID)
		    If Modifier <> Nil And Modifier.Matches(ForLootSource) Then
		      QuantityMultipliers.Add(Preset.QuantityMultiplier(ModifierID))
		      MinQualityModifiers.Add(Preset.MinQualityModifier(ModifierID))
		      MaxQualityModifiers.Add(Preset.MaxQualityModifier(ModifierID))
		      BlueprintMultipliers.Add(Preset.BlueprintMultiplier(ModifierID))
		    End If
		  Next
		  
		  Var Qualities() As Beacon.Quality = Beacon.Qualities.All
		  
		  For Each PresetEntry As Beacon.PresetEntry In Preset
		    If PresetEntry.ValidForMask(Mask) = False Or PresetEntry.SafeForMods(Mods) = False Then
		      Continue
		    End If
		    
		    Var Entry As New Beacon.SetEntry(PresetEntry)
		    
		    If PresetEntry.RespectQualityModifier Then
		      Var MinQualityIndex, MaxQualityIndex As Integer
		      For I As Integer = 0 To Qualities.LastIndex
		        If Qualities(I) = Entry.MinQuality Then
		          MinQualityIndex = I
		        End If
		        If Qualities(I) = Entry.MaxQuality Then
		          MaxQualityIndex = I
		        End If
		      Next
		      
		      For Each Modifier As Integer In MinQualityModifiers
		        MinQualityIndex = MinQualityIndex + Modifier
		      Next
		      For Each Modifier As Integer In MaxQualityModifiers
		        MaxQualityIndex = MaxQualityIndex + Modifier
		      Next
		      MinQualityIndex = Max(Min(MinQualityIndex, Qualities.LastIndex), 0)
		      MaxQualityIndex = Max(Min(MaxQualityIndex, Qualities.LastIndex), 0)
		      Entry.MinQuality = Qualities(MinQualityIndex)
		      Entry.MaxQuality = Qualities(MaxQualityIndex)
		    End If
		    
		    If PresetEntry.RespectQuantityMultiplier Then
		      Var MinQuantityRaw As Double = Entry.MinQuantity
		      Var MaxQuantityRaw As Double = Entry.MaxQuantity
		      For Each Multiplier As Double In QuantityMultipliers
		        MinQuantityRaw = MinQuantityRaw * Multiplier
		        MaxQuantityRaw = MaxQuantityRaw * Multiplier
		      Next
		      Entry.MinQuantity = Round(MinQuantityRaw)
		      Entry.MaxQuantity = Round(MaxQuantityRaw)
		    End If
		    
		    If PresetEntry.CanBeBlueprint And PresetEntry.RespectBlueprintMultiplier Then
		      Var BlueprintChanceRaw As Double = Entry.ChanceToBeBlueprint
		      For Each Multiplier As Double In BlueprintMultipliers
		        BlueprintChanceRaw = BlueprintChanceRaw * Multiplier
		      Next
		      Entry.ChanceToBeBlueprint = Max(Min(BlueprintChanceRaw, 1.0), 0.0)
		    End If
		    
		    Set.Append(Entry)
		  Next
		  
		  Set.MinNumItems = Preset.MinItems
		  Set.MaxNumItems = Preset.MaxItems
		  
		  Set.Modified = False
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.ItemSet
		  Var Set As New Beacon.ItemSet
		  
		  Try
		    If Dict.HasKey("NumItemsPower") Then
		      Set.NumItemsPower = Dict.Value("NumItemsPower")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading NumItemsPower value")
		  End Try
		  
		  Try
		    If Dict.HasKey("Weight") Then
		      Set.RawWeight = Dict.Value("Weight")
		    ElseIf Dict.HasKey("SetWeight") Then
		      Set.RawWeight = Dict.Value("SetWeight") * 1000.0
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Weight value")
		  End Try
		  
		  Try
		    If Dict.HasKey("bItemsRandomWithoutReplacement") Then
		      Set.ItemsRandomWithoutReplacement = Dict.Value("bItemsRandomWithoutReplacement")
		    ElseIf Dict.HasKey("ItemsRandomWithoutReplacement") Then
		      Set.ItemsRandomWithoutReplacement = Dict.Value("ItemsRandomWithoutReplacement")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading bItemsRandomWithoutReplacement value")
		  End Try
		  
		  Try
		    If Dict.HasKey("Label") Then
		      Set.Label = Dict.Value("Label")
		    ElseIf Dict.HasKey("SetName") Then
		      Set.Label = Dict.Value("SetName")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Label value")
		  End Try
		  
		  Var Children() As Dictionary
		  Try
		    If Dict.HasKey("ItemEntries") Then
		      Children = Dict.Value("ItemEntries").DictionaryArrayValue
		    ElseIf Dict.HasKey("Items") Then
		      Children = Dict.Value("Items").DictionaryArrayValue
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Casting ItemEntries to array")
		  End Try
		  
		  For Idx As Integer = 0 To Children.LastIndex
		    Try
		      Var Entry As Beacon.SetEntry = Beacon.SetEntry.FromSaveData(Dictionary(Children(Idx)))
		      If (Entry Is Nil) = False Then
		        Set.Append(Entry)
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading set entry dictionary #" + Idx.ToString(Locale.Raw, "0"))
		    End Try
		  Next
		  
		  Try
		    If Dict.HasKey("MinNumItems") Then
		      Set.MinNumItems = Dict.Value("MinNumItems")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinNumItems value")
		  End Try
		  
		  Try
		    If Dict.HasKey("MaxNumItems") Then
		      Set.MaxNumItems = Dict.Value("MaxNumItems")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxNumItems value")
		  End Try
		  
		  Try
		    If Dict.HasKey("SourcePresetID") Then
		      Set.mSourcePresetID = Dict.Value("SourcePresetID")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading SourcePresetID value")
		  End Try
		  
		  Set.Modified = False
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash(ForPreset As Boolean = False) As String
		  If Self.HashIsStale Or ForPreset Then
		    Var Entries() As String
		    Entries.ResizeTo(Self.mEntries.LastIndex)
		    For I As Integer = 0 To Entries.LastIndex
		      Entries(I) = Self.mEntries(I).Hash
		    Next
		    Entries.Sort
		    
		    Var Locale As Locale = Locale.Raw
		    Var Format As String = "0.000"
		    
		    Var Parts(6) As String
		    Parts(0) = Beacon.MD5(Entries.Join(",")).Lowercase
		    Parts(1) = Self.MaxNumItems.ToString(Locale, Format)
		    Parts(2) = Self.MinNumItems.ToString(Locale, Format)
		    If ForPreset Then
		      Return Beacon.MD5(Parts.Join(",")).Lowercase
		    End If
		    Parts(3) = Self.NumItemsPower.ToString(Locale, Format)
		    Parts(4) = Self.RawWeight.ToString(Locale, Format)
		    Parts(5) = Self.Label.Lowercase  
		    Parts(6) = if(Self.ItemsRandomWithoutReplacement, "1", "0")
		    
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
		  
		  For Each Entry As Beacon.SetEntry In Self.mEntries
		    If Entry.HashIsStale Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As v4UUID
		  Return Self.mID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Multipliers As Beacon.Range, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As Beacon.ItemSet
		  Var Set As New Beacon.ItemSet
		  If Dict.HasKey("NumItemsPower") Then
		    Set.NumItemsPower = Dict.Value("NumItemsPower")
		  End If
		  If Dict.HasKey("SetWeight") Then
		    Set.RawWeight = Dict.Value("SetWeight")
		  End If
		  If Dict.HasKey("bItemsRandomWithoutReplacement") Then
		    Set.ItemsRandomWithoutReplacement = Dict.Value("bItemsRandomWithoutReplacement")
		  End If
		  If Dict.HasKey("SetName") Then
		    Set.Label = Dict.Value("SetName")
		  End If
		  
		  Var Children() As Variant
		  If Dict.HasKey("ItemEntries") Then
		    Children = Dict.Value("ItemEntries")
		  End If
		  For Each Child As Dictionary In Children
		    Var Entry As Beacon.SetEntry = Beacon.SetEntry.ImportFromConfig(Child, Multipliers, Difficulty, Mods)
		    If Entry <> Nil Then
		      Set.Append(Entry)
		    End If
		  Next
		  
		  If Dict.HasKey("MinNumItems") Then
		    Set.MinNumItems = Dict.Value("MinNumItems")
		  End If
		  If Dict.HasKey("MaxNumItems") Then
		    Set.MaxNumItems = Dict.Value("MaxNumItems")
		  End If
		  
		  If Dict.HasKey("SourcePresetID") Then
		    Set.mSourcePresetID = Dict.Value("SourcePresetID")
		  End If
		  
		  Set.Modified = False
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.SetEntry) As Integer
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    If Self.mEntries(I) = Entry Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Entry As Beacon.SetEntry)
		  Self.mEntries.AddAt(Index, Entry)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  Var Entries() As Variant
		  Entries.ResizeTo(Self.mEntries.LastIndex)
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    Entries(I) = Self.mEntries(I)
		  Next
		  Return New Beacon.GenericIterator(Entries)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Sets() As Beacon.ItemSet, Separator As String, Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Var Values() As String
		  For Each Set As Beacon.ItemSet In Sets
		    Values.Add(Set.StringValue(Multipliers, UseBlueprints, Difficulty))
		  Next
		  
		  Return Values.Join(Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mLastModifiedTime > Self.mLastSaveTime Then
		    Return True
		  End If
		  
		  For Each Entry As Beacon.SetEntry In Self.mEntries
		    If Entry.Modified Then
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
		    For Each Entry As Beacon.SetEntry In Self.mEntries
		      Entry.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ItemSet) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  // If they have the same ID, they are the same. End of story.
		  If Self.mID = Other.mID Then
		    Return 0
		  End If
		  
		  // If the do not have the same ID, we must sort them alphabetically but without equating two sets with the same label
		  Var SelfComparison As String = Self.mLabel + " " + Self.mID
		  Var OtherComparison As String = Other.mLabel + " " + Other.mID
		  Return SelfComparison.Compare(OtherComparison, ComparisonOptions.CaseInsensitive, Locale.Current)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.SetEntry
		  Return Self.mEntries(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Entry As Beacon.SetEntry)
		  Self.mEntries(Index) = Entry
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReconfigureWithPreset(Preset As Beacon.Preset = Nil, ForLootSource As Beacon.LootSource, Document As Beacon.Document) As Boolean
		  Return Self.ReconfigureWithPreset(Preset, ForLootSource, Document.MapCompatibility, Document.Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReconfigureWithPreset(Preset As Beacon.Preset = Nil, ForLootSource As Beacon.LootSource, Mask As UInt64, Mods As Beacon.StringList) As Boolean
		  If Preset = Nil And Self.mSourcePresetID <> "" Then
		    Preset = Beacon.Data.GetPreset(Self.mSourcePresetID)
		  End If
		  If Preset = Nil Then
		    Return False
		  End If
		  
		  // Don't compare hashes because it includes more data than presets will change.
		  Var Clone As Beacon.ItemSet = Beacon.ItemSet.FromPreset(Preset, ForLootSource, Mask, Mods)
		  If Self.SourcePresetID = Preset.PresetID And Self.Hash(True) = Clone.Hash(True) Then
		    Return False
		  End If
		  Self.mEntries = Clone.mEntries
		  Self.mMinNumItems = Clone.mMinNumItems
		  Self.MaxNumItems = Clone.mMaxNumItems
		  Self.Modified = True
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RelativeWeight(Index As Integer) As Double
		  Return Self.mEntries(Index).RawWeight / Self.TotalWeight()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mEntries.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.mEntries.ResizeTo(Bound)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Children() As Dictionary
		  For Each Entry As Beacon.SetEntry In Self.mEntries
		    Children.Add(Entry.SaveData)
		  Next
		  
		  Var Keys As New Dictionary
		  Keys.Value("ItemEntries") = Children
		  Keys.Value("bItemsRandomWithoutReplacement") = Self.ItemsRandomWithoutReplacement
		  Keys.Value("Label") = Self.Label // Write "Label" so older versions of Beacon can read it
		  Keys.Value("MaxNumItems") = Self.MaxNumItems
		  Keys.Value("MinNumItems") = Self.MinNumItems
		  Keys.Value("NumItemsPower") = Self.NumItemsPower
		  Keys.Value("Weight") = Self.RawWeight
		  Keys.Value("SetWeight") = Self.RawWeight / 1000
		  If Self.SourcePresetID <> "" Then
		    Keys.Value("SourcePresetID") = Self.SourcePresetID
		  End If
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate() As Beacon.SimulatedSelection()
		  Var Selections() As Beacon.SimulatedSelection
		  If Self.mEntries.LastIndex = -1 Then
		    Return Selections
		  End If
		  
		  Var NumEntries As Integer = Self.Count
		  Var MinEntries As Integer = Min(Self.MinNumItems, Self.MaxNumItems)
		  Var MaxEntries As Integer = Max(Self.MaxNumItems, Self.MinNumItems)
		  
		  Var SelectedEntries() As Beacon.SetEntry
		  If NumEntries = MinEntries And MinEntries = MaxEntries And Self.ItemsRandomWithoutReplacement Then
		    // All
		    For Each Entry As Beacon.SetEntry In Self.mEntries
		      SelectedEntries.Add(Entry)
		    Next
		  Else
		    Const WeightScale = 100000
		    Var Pool() As Beacon.SetEntry
		    Pool.ResizeTo(Self.mEntries.LastIndex)
		    For I As Integer = 0 To Self.mEntries.LastIndex
		      Pool(I) = New Beacon.SetEntry(Self.mEntries(I))
		    Next
		    
		    Var RecomputeFigures As Boolean = True
		    Var ChooseEntries As Integer = System.Random.InRange(MinEntries, MaxEntries)
		    Var WeightSum, Weights() As Double
		    Var WeightLookup As Dictionary
		    For I As Integer = 1 To ChooseEntries
		      If Pool.LastIndex = -1 Then
		        Exit For I
		      End If
		      
		      If RecomputeFigures Then
		        Self.ComputeSimulationFigures(Pool, WeightScale, WeightSum, Weights, WeightLookup)
		        RecomputeFigures = False
		      End If
		      
		      Do
		        Var Decision As Double = System.Random.InRange(WeightScale, WeightScale + (WeightSum * WeightScale)) - WeightScale
		        Var SelectedEntry As Beacon.SetEntry
		        
		        For X As Integer = 0 To Weights.LastIndex
		          If Weights(X) >= Decision Then
		            Var SelectedWeight As Double = Weights(X)
		            SelectedEntry = WeightLookup.Value(SelectedWeight)
		            Exit For X
		          End If
		        Next
		        
		        If SelectedEntry = Nil Then
		          Continue
		        End If
		        
		        SelectedEntries.Add(SelectedEntry)
		        If Self.ItemsRandomWithoutReplacement Then
		          For X As Integer = 0 To Pool.LastIndex
		            If Pool(X) = SelectedEntry Then
		              Pool.RemoveAt(X)
		              Exit For X
		            End If
		          Next
		          RecomputeFigures = True
		        End If
		        
		        Exit
		      Loop
		    Next
		  End If
		  
		  For Each Entry As Beacon.SetEntry In SelectedEntries
		    Var EntrySelections() As Beacon.SimulatedSelection = Entry.Simulate()
		    For Each Selection As Beacon.SimulatedSelection In EntrySelections
		      Selections.Add(Selection)
		    Next
		  Next
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SourcePresetID() As String
		  Return Self.mSourcePresetID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As BeaconConfigs.Difficulty) As String
		  Var Values() As String
		  Values.Add("SetName=""" + Self.Label + """")
		  Values.Add("MinNumItems=" + Self.MinNumItems.ToString)
		  Values.Add("MaxNumItems=" + Self.MaxNumItems.ToString)
		  Values.Add("NumItemsPower=" + Self.mNumItemsPower.PrettyText)
		  Values.Add("SetWeight=" + Self.mSetWeight.PrettyText)
		  Values.Add("bItemsRandomWithoutReplacement=" + if(Self.mItemsRandomWithoutReplacement, "True", "False"))
		  Values.Add("ItemEntries=(" + Beacon.SetEntry.Join(Self.mEntries, ",", Multipliers, UseBlueprints, Difficulty) + ")")
		  Return "(" + Values.Join(",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalWeight() As Double
		  Var Value As Double
		  For Each Entry As Beacon.SetEntry In Self.mEntries
		    Value = Value + Entry.RawWeight
		  Next
		  Return Value
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mItemsRandomWithoutReplacement
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mItemsRandomWithoutReplacement = Value Then
			    Return
			  End If
			  
			  Self.mItemsRandomWithoutReplacement = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		ItemsRandomWithoutReplacement As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLabel
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mLabel.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
			    Return
			  End If
			  
			  Self.mLabel = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Label As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Self.mMaxNumItems, 1)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 1)
			  If Self.mMaxNumItems = Value Then
			    Return
			  End If
			  
			  Self.mMaxNumItems = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MaxNumItems As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEntries() As Beacon.SetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As v4UUID
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Self.mMinNumItems, 1)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 1)
			  If Self.mMinNumItems = Value Then
			    Return
			  End If
			  
			  Self.mMinNumItems = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		MinNumItems As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mItemsRandomWithoutReplacement As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

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
		Private mMaxNumItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinNumItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumItemsPower As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetWeight As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourcePresetID As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mNumItemsPower
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 0)
			  If Self.mNumItemsPower = Value Then
			    Return
			  End If
			  
			  Self.mNumItemsPower = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		NumItemsPower As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSetWeight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 0.0001)
			  If Self.mSetWeight = Value Then
			    Return
			  End If
			  
			  Self.mSetWeight = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		RawWeight As Double
	#tag EndComputedProperty


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
			Name="ItemsRandomWithoutReplacement"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="MaxNumItems"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinNumItems"
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
			Name="NumItemsPower"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
