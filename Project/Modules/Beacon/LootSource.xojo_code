#tag Class
Protected Class LootSource
Implements Beacon.Countable,Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.ItemSet)
		  Self.mSets.Append(Item)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As Text
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ComputeSimulationFigures(ItemSetPool() As Beacon.ItemSet, WeightScale As Integer, ByRef WeightSum As Double, ByRef Weights() As Double, ByRef WeightLookup As Xojo.Core.Dictionary)
		  Redim Weights(-1)
		  WeightLookup = New Xojo.Core.Dictionary
		  WeightSum = 0
		  
		  For Each Set As Beacon.ItemSet In ItemSetPool
		    If Set.Weight = 0 Then
		      Continue
		    End If
		    WeightSum = WeightSum + Set.Weight
		    Weights.Append(WeightSum * WeightScale)
		    WeightLookup.Value(WeightSum * WeightScale) = Set
		  Next
		  Weights.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeWeightStatistics(ByRef TotalWeight As Double, ByRef AverageWeight As Double, ByRef MinWeight As Double, ByRef MaxWeight As Double)
		  Dim NumSets As Integer = Self.mSets.Ubound + 1
		  If NumSets = 0 Then
		    Return
		  End If
		  
		  TotalWeight = Self.mSets(0).Weight
		  MinWeight = Self.mSets(0).Weight
		  MaxWeight = Self.mSets(0).Weight
		  
		  For I As Integer = 1 To Self.mSets.Ubound
		    TotalWeight = TotalWeight + Self.mSets(I).Weight
		    MinWeight = Min(MinWeight, Self.mSets(I).Weight)
		    MaxWeight = Max(MaxWeight, Self.mSets(I).Weight)
		  Next
		  
		  AverageWeight = TotalWeight / NumSets
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mMinItemSets = 1
		  Self.mMaxItemSets = 3
		  Self.mMultipliers = New Beacon.Range(1, 1)
		  Self.mSetsRandomWithoutReplacement = True
		  Self.mUIColor = &cFFFFFF00
		  Self.mSortValue = 99
		  Self.mNumItemSetsPower = 1
		  Self.mUseBlueprints = False
		  Self.mAppendMode = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.LootSource)
		  Self.Constructor()
		  
		  If Source = Nil Then
		    Dim Err As NilObjectException
		    Err.Reason = "Cannot clone a nil loot source"
		    Raise Err
		  End If
		  
		  Redim Self.mSets(UBound(Source.mSets))
		  
		  Self.mMaxItemSets = Source.mMaxItemSets
		  Self.mMinItemSets = Source.mMinItemSets
		  Self.mNumItemSetsPower = Source.mNumItemSetsPower
		  Self.mSetsRandomWithoutReplacement = Source.mSetsRandomWithoutReplacement
		  Self.mClassString = Source.mClassString
		  Self.mLabel = Source.mLabel
		  Self.mMultipliers = New Beacon.Range(Source.mMultipliers.Min, Source.mMultipliers.Max)
		  Self.mKind = Source.mKind
		  Self.mAvailability = Source.mAvailability
		  Self.mIsOfficial = Source.mIsOfficial
		  Self.mUIColor = Source.mUIColor
		  Self.mSortValue = Source.mSortValue
		  Self.mUseBlueprints = Source.mUseBlueprints
		  Self.mAppendMode = Source.mAppendMode
		  
		  For I As Integer = 0 To UBound(Source.mSets)
		    Self.mSets(I) = New Beacon.ItemSet(Source.mSets(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  For Each Set As Beacon.ItemSet In Self.mSets
		    Set.ConsumeMissingEngrams(Engrams)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mSets) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Children() As Xojo.Core.Dictionary
		  For Each Set As Beacon.ItemSet In Self.mSets
		    Children.Append(Set.Export)
		  Next
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("ItemSets") = Children
		  Keys.Value("MaxItemSets") = Self.MaxItemSets
		  Keys.Value("MinItemSets") = Self.MinItemSets
		  Keys.Value("NumItemSetsPower") = Self.NumItemSetsPower
		  Keys.Value("bSetsRandomWithoutReplacement") = Self.SetsRandomWithoutReplacement
		  Keys.Value("SupplyCrateClassString") = Self.ClassString
		  Keys.Value("Availability") = Self.mAvailability
		  Keys.Value("Kind") = Self.KindToText(Self.mKind)
		  Keys.Value("Multiplier_Min") = Self.Multipliers.Min
		  Keys.Value("Multiplier_Max") = Self.Multipliers.Max
		  Keys.Value("UIColor") = Self.mUIColor.Red.ToHex(2) + Self.mUIColor.Green.ToHex(2) + Self.mUIColor.Blue.ToHex(2) + Self.mUIColor.Alpha.ToHex(2)
		  Keys.Value("SortValue") = Self.mSortValue
		  Keys.Value("Label") = Self.mLabel
		  Keys.Value("UseBlueprints") = Self.mUseBlueprints
		  Keys.Value("RequiredItemSets") = Self.RequiredItemSets
		  Keys.Value("AppendMode") = Self.mAppendMode
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Beacon.LootSourceIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedPresetCount() As UInteger
		  Dim Total As UInteger
		  For Each Set As Beacon.ItemSet In Self.mSets
		    If Set.SourcePresetID <> "" Then
		      Total = Total + 1
		    End If
		  Next
		  Return Total
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As Xojo.Core.DIctionary) As Beacon.LootSource
		  Dim ClassString As Text
		  If Dict.HasKey("SupplyCrateClassString") Then
		    ClassString = Dict.Value("SupplyCrateClassString")
		  ElseIf Dict.HasKey("Type") Then
		    ClassString = Dict.Value("Type")
		  End If
		  If ClassString = "Beacon:ScorchedEarthDesertCrate_C" Then
		    ClassString = "SupplyCreate_OceanInstant_High_C"
		  End If
		  If ClassString = "" Then
		    Return Nil
		  End If
		  
		  Dim LootSource As Beacon.LootSource
		  If Beacon.Data <> Nil Then
		    LootSource = Beacon.Data.GetLootSource(ClassString)
		  End If
		  If LootSource = Nil Then
		    Dim UIColor As Text = Dict.Lookup("UIColor", "FFFFFF00")
		    Dim MutableSource As New Beacon.MutableLootSource(ClassString, False)
		    MutableSource.Multipliers = New Beacon.Range(Dict.Lookup("Multiplier_Min", 1), Dict.Lookup("Multiplier_Max", 1))
		    MutableSource.Availability = Beacon.Maps.All.Mask
		    MutableSource.Kind = Beacon.LootSource.TextToKind(Dict.Lookup("Kind", "Standard"))
		    MutableSource.UIColor = Color.RGBA(Integer.FromHex(UIColor.Mid(0, 2)), Integer.FromHex(UIColor.Mid(2, 2)), Integer.FromHex(UIColor.Mid(4, 2)), Integer.FromHex(UIColor.Mid(6, 2)))
		    MutableSource.SortValue = Dict.Lookup("SortValue", 99)
		    MutableSource.Label = Dict.Lookup("Label", ClassString)
		    MutableSource.UseBlueprints = Dict.Lookup("UseBlueprints", False)
		    MutableSource.RequiredItemSets = Dict.Lookup("RequiredItemSets", 1)
		    LootSource = New Beacon.LootSource(MutableSource)
		  End If
		  
		  Dim Children() As Auto
		  If Dict.HasKey("ItemSets") Then
		    Children = Dict.Value("ItemSets")
		  Else
		    Children = Dict.Value("Items")
		  End If
		  Dim AddedHashes As New Xojo.Core.Dictionary
		  For Each Child As Xojo.Core.Dictionary In Children
		    Dim Set As Beacon.ItemSet = Beacon.ItemSet.ImportFromBeacon(Child)
		    Dim Hash As Text = Set.Hash
		    If Set <> Nil And AddedHashes.HasKey(Hash) = False Then
		      LootSource.Append(Set)
		      AddedHashes.Value(Hash) = True
		    End If
		  Next
		  
		  If Dict.HasKey("MaxItemSets") Then
		    LootSource.MaxItemSets = Dict.Value("MaxItemSets")
		  End If
		  If Dict.HasKey("MinItemSets") Then
		    LootSource.MinItemSets = Dict.Value("MinItemSets")
		  End If
		  If Dict.HasKey("NumItemSetsPower") Then
		    LootSource.NumItemSetsPower = Dict.Value("NumItemSetsPower")
		  End If
		  If Dict.HasKey("bSetsRandomWithoutReplacement") Then
		    LootSource.SetsRandomWithoutReplacement = Dict.Value("bSetsRandomWithoutReplacement")
		  ElseIf Dict.HasKey("SetsRandomWithoutReplacement") Then
		    LootSource.SetsRandomWithoutReplacement = Dict.Value("SetsRandomWithoutReplacement")
		  End If
		  If Dict.HasKey("AppendMode") Then
		    LootSource.AppendMode = Dict.Value("AppendMode")
		  End If
		  
		  LootSource.mModified = False
		  Return LootSource
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Xojo.Core.Dictionary, DifficultyValue As Double) As Beacon.LootSource
		  Dim ClassString As Text
		  If Dict.HasKey("SupplyCrateClassString") Then
		    ClassString = Dict.Value("SupplyCrateClassString")
		  End If
		  
		  Dim LootSource As Beacon.LootSource
		  If Beacon.Data <> Nil Then
		    LootSource = Beacon.Data.GetLootSource(ClassString)
		  End If
		  If LootSource = Nil Then
		    Dim UIColor As Text = Dict.Lookup("UIColor", "FFFFFF00")
		    Dim MutableSource As New Beacon.MutableLootSource(ClassString, False)
		    MutableSource.Multipliers = New Beacon.Range(Dict.Lookup("Multiplier_Min", 1), Dict.Lookup("Multiplier_Max", 1))
		    MutableSource.Availability = Beacon.Maps.All.Mask
		    MutableSource.Kind = Beacon.LootSource.TextToKind(Dict.Lookup("Kind", "Standard"))
		    MutableSource.UIColor = Color.RGBA(Integer.FromHex(UIColor.Mid(0, 2)), Integer.FromHex(UIColor.Mid(2, 2)), Integer.FromHex(UIColor.Mid(4, 2)), Integer.FromHex(UIColor.Mid(6, 2)))
		    MutableSource.SortValue = Dict.Lookup("SortValue", 99)
		    MutableSource.Label = Dict.Lookup("Label", ClassString)
		    MutableSource.UseBlueprints = Dict.Lookup("UseBlueprints", False)
		    MutableSource.RequiredItemSets = Dict.Lookup("RequiredItemSets", 1)
		    LootSource = New Beacon.LootSource(MutableSource)
		  End If
		  
		  Dim Children() As Auto
		  If Dict.HasKey("ItemSets") Then
		    Children = Dict.Value("ItemSets")
		  End If
		  Dim AddedHashes As New Xojo.Core.Dictionary
		  For Each Child As Xojo.Core.Dictionary In Children
		    Dim Set As Beacon.ItemSet = Beacon.ItemSet.ImportFromConfig(Child, LootSource.Multipliers, DifficultyValue)
		    Dim Hash As Text = Set.Hash
		    If Set <> Nil And AddedHashes.HasKey(Hash) = False Then
		      LootSource.Append(Set)
		      AddedHashes.Value(Hash) = True
		    End If
		  Next
		  
		  If Dict.HasKey("MaxItemSets") Then
		    LootSource.MaxItemSets = Dict.Value("MaxItemSets")
		  End If
		  If Dict.HasKey("MinItemSets") Then
		    LootSource.MinItemSets = Dict.Value("MinItemSets")
		  End If
		  If Dict.HasKey("NumItemSetsPower") Then
		    LootSource.NumItemSetsPower = Dict.Value("NumItemSetsPower")
		  End If
		  If Dict.HasKey("bSetsRandomWithoutReplacement") Then
		    LootSource.SetsRandomWithoutReplacement = Dict.Value("bSetsRandomWithoutReplacement")
		  End If
		  If Dict.HasKey("bAppendItemSets") Then
		    LootSource.AppendMode = Dict.Value("bAppendItemSets")
		  End If
		  
		  LootSource.mModified = False
		  Return LootSource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As Beacon.ItemSet) As Integer
		  For I As Integer = 0 To UBound(Self.mSets)
		    If Self.mSets(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Beacon.ItemSet)
		  Self.mSets.Insert(Index, Item)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOfficial() As Boolean
		  Return Self.mIsOfficial
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  For Each Set As Beacon.ItemSet In Self.mSets
		    If Not Set.IsValid Then
		      Return False
		    End If
		  Next
		  Return UBound(Self.mSets) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Kind() As Beacon.LootSource.Kinds
		  Return Self.mKind
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function KindToText(Kind As Beacon.LootSource.Kinds) As Text
		  Select Case Kind
		  Case Beacon.LootSource.Kinds.Standard
		    Return "Standard"
		  Case Beacon.LootSource.Kinds.Bonus
		    Return "Bonus"
		  Case Beacon.LootSource.Kinds.Cave
		    Return "Cave"
		  Case Beacon.LootSource.Kinds.Sea
		    Return "Sea"
		  Case Beacon.LootSource.Kinds.BossSpider
		    Return "BossSpider"
		  Case Beacon.LootSource.Kinds.BossGorilla
		    Return "BossGorilla"
		  Case Beacon.LootSource.Kinds.BossDragon
		    Return "BossDragon"
		  Case Beacon.LootSource.Kinds.BossManticore
		    Return "BossManticore"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  If Self.mLabel <> "" Then
		    Return Self.mLabel
		  Else
		    Return Self.mClassString
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Lookup(ClassString As Text) As Beacon.LootSource
		  Dim Source As Beacon.LootSource = Beacon.Data.GetLootSource(ClassString)
		  If Source = Nil Then
		    Source = New Beacon.LootSource
		    Source.mClassString = ClassString
		  End If
		  Return Source
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As Beacon.Map()
		  Dim AllMaps() As Beacon.Map = Beacon.Maps.All
		  Dim AllowedMaps() As Beacon.Map
		  For Each Map As Beacon.Map In AllMaps
		    If Self.ValidForMap(Map) Then
		      AllowedMaps.Append(Map)
		    End If
		  Next
		  Return AllowedMaps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Set As Beacon.ItemSet In Self.mSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Not Value Then
		    For Each Set As Beacon.ItemSet In Self.mSets
		      Set.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Multipliers() As Beacon.Range
		  Return Self.mMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.LootSource) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mClassString.Compare(Other.mClassString, Text.CompareCaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mSets(Bound)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.ItemSet
		  Return Self.mSets(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Value As Beacon.ItemSet)
		  Self.mSets(Index) = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReconfigurePresets(Mask As UInt64, ConsoleSafe As Boolean)
		  For Each Set As Beacon.ItemSet In Self.mSets
		    If Set.SourcePresetID = "" Then
		      Continue
		    End If
		    
		    Dim Preset As Beacon.Preset = Beacon.Data.GetPreset(Set.SourcePresetID)
		    If Preset = Nil Then
		      Continue
		    End If
		    
		    Set.ReconfigureWithPreset(Preset, Self, Mask, ConsoleSafe)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mSets.Remove(Index)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredItemSets() As Integer
		  Return Self.mRequiredItemSets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate() As Beacon.SimulatedSelection()
		  Dim Selections() As Beacon.SimulatedSelection
		  If Self.mSets.Ubound = -1 Then
		    Return Selections
		  End If
		  
		  Dim NumSets As Integer = Self.Count
		  Dim MinSets As Integer = Self.MinItemSets
		  Dim MaxSets As Integer = Self.MaxItemSets
		  
		  Dim SelectedSets() As Beacon.ItemSet
		  If NumSets = MinSets And MinSets = MaxSets Then
		    // All
		    SelectedSets = Self.mSets
		  Else
		    Const WeightScale = 100000
		    Dim ItemSetPool() As Beacon.ItemSet
		    Redim ItemSetPool(Self.mSets.Ubound)
		    For I As Integer = 0 To Self.mSets.Ubound
		      ItemSetPool(I) = New Beacon.ItemSet(Self.mSets(I))
		    Next
		    
		    Dim RecomputeFigures As Boolean = True
		    Dim ChooseSets As Integer = Xojo.Math.RandomInt(MinSets, MaxSets)
		    Dim WeightSum, Weights() As Double
		    Dim WeightLookup As Xojo.Core.Dictionary
		    For I As Integer = 1 To ChooseSets
		      If RecomputeFigures Then
		        Self.ComputeSimulationFigures(ItemSetPool, WeightScale, WeightSum, Weights, WeightLookup)
		        RecomputeFigures = False
		      End If
		      
		      Do
		        Dim Decision As Double = Xojo.Math.RandomInt(WeightScale, WeightScale + (WeightSum * WeightScale)) - WeightScale
		        Dim SelectedSet As Beacon.ItemSet
		        
		        For X As Integer = 0 To Weights.Ubound
		          If Weights(X) >= Decision Then
		            Dim SelectedWeight As Double = Weights(X)
		            SelectedSet = WeightLookup.Value(SelectedWeight)
		            Exit For X
		          End If
		        Next
		        
		        If SelectedSet = Nil Then
		          Continue
		        End If
		        
		        SelectedSets.Append(SelectedSet)
		        If Self.SetsRandomWithoutReplacement Then
		          For X As Integer = 0 To ItemSetPool.Ubound
		            If ItemSetPool(X) = SelectedSet Then
		              ItemSetPool.Remove(X)
		              Exit For X
		            End If
		          Next
		          RecomputeFigures = True
		        End If
		        
		        Exit
		      Loop
		    Next
		  End If
		  
		  For Each Set As Beacon.ItemSet In SelectedSets
		    Dim SetSelections() As Beacon.SimulatedSelection = Set.Simulate
		    For Each Selection As Beacon.SimulatedSelection In SetSelections
		      Selections.Append(Selection)
		    Next
		  Next
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SortValue() As Integer
		  Return Self.mSortValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TextToKind(Kind As Text) As Beacon.LootSource.Kinds
		  Select Case Kind
		  Case "Standard"
		    Return Beacon.LootSource.Kinds.Standard
		  Case "Bonus"
		    Return Beacon.LootSource.Kinds.Bonus
		  Case "Cave"
		    Return Beacon.LootSource.Kinds.Cave
		  Case "Sea"
		    Return Beacon.LootSource.Kinds.Sea
		  Case "BossSpider"
		    Return Beacon.LootSource.Kinds.BossSpider
		  Case "BossGorilla"
		    Return Beacon.LootSource.Kinds.BossGorilla
		  Case "BossDragon"
		    Return Beacon.LootSource.Kinds.BossDragon
		  Case "BossManticore"
		    Return Beacon.LootSource.Kinds.BossManticore
		  Else
		    Return Beacon.LootSource.Kinds.Standard
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextValue(Difficulty As BeaconConfigs.Difficulty) As Text
		  Dim Values() As Text
		  
		  // This is terrible, but Ark uses the same code for both Scorched Desert Crates and Island Sea Crates
		  If Self.mClassString = "Beacon:ScorchedEarthDesertCrate_C" Then
		    Values.Append("SupplyCrateClassString=""SupplyCreate_OceanInstant_High_C""")
		  Else
		    Values.Append("SupplyCrateClassString=""" + Self.mClassString + """")
		  End If
		  
		  If Self.mAppendMode Then
		    Values.Append("bAppendItemSets=true")
		  Else
		    Values.Append("MinItemSets=" + Self.MinItemSets.ToText)
		    Values.Append("MaxItemSets=" + Self.MaxItemSets.ToText)
		    Values.Append("NumItemSetsPower=" + Self.mNumItemSetsPower.PrettyText)
		    Values.Append("bSetsRandomWithoutReplacement=" + if(Self.mSetsRandomWithoutReplacement, "true", "false"))
		  End If
		  
		  Values.Append("ItemSets=(" + Beacon.ItemSet.Join(Self.mSets, ",", Self.mMultipliers, Self.mUseBlueprints, Difficulty) + ")")
		  Return "(" + Text.Join(Values, ",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UIColor() As Color
		  Return Self.mUIColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseBlueprints() As Boolean
		  Return Self.mUseBlueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Beacon.Map) As Boolean
		  Return Self.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Mask As UInt64) As Boolean
		  Return Mask = 0 Or (Self.mAvailability And Mask) > 0
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAppendMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAppendMode <> Value Then
			    Self.mAppendMode = Value
			    Self.mModified = True
			  End If
			End Set
		#tag EndSetter
		AppendMode As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAppendMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Min(Max(Self.mMaxItemSets, Self.mMinItemSets), Max(Self.Count, 1))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 1)
			  If Self.mMaxItemSets = Value Then
			    Return
			  End If
			  
			  Self.mMaxItemSets = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		MaxItemSets As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mClassString As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Min(Self.mMinItemSets, Self.mMaxItemSets, Self.Count), 1)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 1)
			  If Self.mMinItemSets = Value Then
			    Return
			  End If
			  
			  Self.mMinItemSets = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		MinItemSets As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mIsOfficial As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mKind As Beacon.LootSource.Kinds
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMultipliers As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumItemSetsPower As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequiredItemSets As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSets() As Beacon.ItemSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetsRandomWithoutReplacement As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSortValue As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUIColor As Color
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUseBlueprints As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mNumItemSetsPower
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 0)
			  If Self.mNumItemSetsPower = Value Then
			    Return
			  End If
			  
			  Self.mNumItemSetsPower = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		NumItemSetsPower As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSetsRandomWithoutReplacement
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSetsRandomWithoutReplacement = Value Then
			    Return
			  End If
			  
			  Self.mSetsRandomWithoutReplacement = Value
			  Self.mModified = True
			End Set
		#tag EndSetter
		SetsRandomWithoutReplacement As Boolean
	#tag EndComputedProperty


	#tag Enum, Name = Kinds, Type = Integer, Flags = &h0
		Standard
		  Bonus
		  Cave
		  Sea
		  BossSpider
		  BossGorilla
		  BossDragon
		BossManticore
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="AppendMode"
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
			Name="MaxItemSets"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinItemSets"
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
			Name="NumItemSetsPower"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SetsRandomWithoutReplacement"
			Group="Behavior"
			Type="Boolean"
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
