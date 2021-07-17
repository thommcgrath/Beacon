#tag Class
Protected Class LootContainer
Implements Beacon.DocumentItem,Beacon.NamedItem,Beacon.LootSource
	#tag Method, Flags = &h0
		Function AppendMode() As Boolean
		  // Part of the Beacon.LootSource interface.
		  
		  Return Self.mAppendMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendMode(Assigns Value As Boolean)
		  // Part of the Beacon.LootSource interface.
		  
		  If Self.mAppendMode <> Value Then
		    Self.mAppendMode = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.LootSource
		  Return New Beacon.LootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mItemSets = New Beacon.ItemSetCollection
		  Self.mMinItemSets = 1
		  Self.mMaxItemSets = 3
		  Self.mMultipliers = New Beacon.Range(1, 1)
		  Self.mSetsRandomWithoutReplacement = True
		  Self.mUIColor = &cFFFFFF00
		  Self.mSortValue = 999
		  Self.mAppendMode = False
		  Self.mClassString = "Beacon_Loot_" + EncodeHex(Crypto.GenerateRandomBytes(6)).Lowercase + "_C"
		  Self.mPath = Beacon.UnknownBlueprintPath("LootSources", Self.mClassString)
		  Self.mModID = Beacon.UserModID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.LootSource)
		  Self.Constructor()
		  
		  If Source = Nil Then
		    Var Err As NilObjectException
		    Err.Reason = "Cannot clone a nil loot source"
		    Raise Err
		  End If
		  
		  Self.mMaxItemSets = Source.MaxItemSets
		  Self.mMinItemSets = Source.MinItemSets
		  Self.mSetsRandomWithoutReplacement = Source.PreventDuplicates
		  Self.mClassString = Source.ClassString
		  Self.mPath = Source.Path
		  Self.mLabel = Source.Label
		  Self.mMultipliers = New Beacon.Range(Source.Multipliers)
		  Self.mAvailability = Source.Availability
		  Self.mUIColor = Source.UIColor
		  Self.mSortValue = Source.SortValue
		  Self.mNotes = Source.Notes
		  Self.mItemSets = New Beacon.ItemSetCollection(Source.ItemSets)
		  Self.mRequiredItemSets = Source.RequiredItemSetCount
		  Self.mModID = Source.ModID
		  
		  Var MandatorySets() As Beacon.ItemSet = Source.MandatoryItemSets
		  Self.mMandatoryItemSets.ResizeTo(MandatorySets.LastIndex)
		  For I As Integer = 0 To MandatorySets.LastIndex
		    Self.mMandatoryItemSets(I) = New Beacon.ItemSet(MandatorySets(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EditSaveData(SaveData As Dictionary)
		  #Pragma Unused SaveData
		  
		  // Nothing to do
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Experimental() As Boolean
		  Return Self.mExperimental
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As Beacon.LootSource
		  Var ClassString As String
		  If Dict.HasKey("SupplyCrateClassString") Then
		    ClassString = Dict.Value("SupplyCrateClassString")
		  End If
		  
		  Var LootSource As Beacon.LootSource
		  If Beacon.Data <> Nil Then
		    LootSource = Beacon.Data.GetLootSource(ClassString)
		  End If
		  If LootSource = Nil Then
		    Var UIColor As String = Dict.Lookup("UIColor", "FFFFFF00")
		    Var MutableSource As New Beacon.CustomLootContainer(ClassString)
		    MutableSource.Multipliers = New Beacon.Range(Dict.Lookup("Multiplier_Min", 1), Dict.Lookup("Multiplier_Max", 1))
		    MutableSource.Availability = Beacon.Maps.UniversalMask
		    MutableSource.UIColor = Color.RGB(Integer.FromHex(UIColor.Middle(0, 2)), Integer.FromHex(UIColor.Middle(2, 2)), Integer.FromHex(UIColor.Middle(4, 2)), Integer.FromHex(UIColor.Middle(6, 2)))
		    MutableSource.SortValue = Dict.Lookup("SortValue", 999).IntegerValue
		    MutableSource.Label = Dict.Lookup("Label", ClassString).StringValue
		    MutableSource.RequiredItemSetCount = Dict.Lookup("RequiredItemSets", 1).IntegerValue
		    MutableSource.Experimental = Dict.Lookup("Experimental", False).BooleanValue
		    MutableSource.Notes = Dict.Lookup("Notes", "").StringValue
		    MutableSource.ModID = Beacon.UserModID
		    LootSource = MutableSource
		  End If
		  
		  Var Children() As Dictionary
		  If Dict.HasKey("ItemSets") Then
		    Children = Dict.Value("ItemSets").DictionaryArrayValue
		  End If
		  Var AddedHashes As New Dictionary
		  For Each Child As Dictionary In Children
		    Var Set As Beacon.ItemSet = Beacon.ItemSet.ImportFromConfig(Child, LootSource.Multipliers, Difficulty, Mods)
		    Var Hash As String = Set.Hash
		    If Set <> Nil And AddedHashes.HasKey(Hash) = False Then
		      Call LootSource.ItemSets.Append(Set)
		      AddedHashes.Value(Hash) = True
		    End If
		  Next
		  
		  If Dict.HasKey("MaxItemSets") Then
		    LootSource.MaxItemSets = Dict.Value("MaxItemSets")
		  End If
		  If Dict.HasKey("MinItemSets") Then
		    LootSource.MinItemSets = Dict.Value("MinItemSets")
		  End If
		  If Dict.HasKey("bSetsRandomWithoutReplacement") Then
		    LootSource.PreventDuplicates = Dict.Value("bSetsRandomWithoutReplacement")
		  End If
		  If Dict.HasKey("bAppendItemSets") Then
		    LootSource.AppendMode = Dict.Value("bAppendItemSets")
		  End If
		  
		  LootSource.Modified = False
		  Return LootSource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOfficial() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemSets() As Beacon.ItemSetCollection
		  // Part of the Beacon.LootSource interface.
		  
		  Return Self.mItemSets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ItemSets(Assigns Sets As Beacon.ItemSetCollection)
		  Self.mItemSets = Sets
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mLabel <> "" Then
		    Return Self.mLabel
		  Else
		    Return Self.mClassString
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadSaveData(SaveData As Dictionary) As Boolean
		  #Pragma Unused SaveData
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MandatoryItemSets() As Beacon.ItemSet()
		  Var Arr() As Beacon.ItemSet
		  Arr.ResizeTo(Self.mMandatoryItemSets.LastIndex)
		  For I As Integer = 0 To Self.mMandatoryItemSets.LastIndex
		    Arr(I) = New Beacon.ItemSet(Self.mMandatoryItemSets(I))
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As Beacon.Map()
		  Var AllMaps() As Beacon.Map = Beacon.Maps.All
		  Var AllowedMaps() As Beacon.Map
		  For Each Map As Beacon.Map In AllMaps
		    If Self.ValidForMap(Map) Then
		      AllowedMaps.Add(Map)
		    End If
		  Next
		  Return AllowedMaps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxItemSets() As Integer
		  // Part of the Beacon.LootSource interface.
		  
		  Return Max(Self.mMaxItemSets, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxItemSets(Assigns Value As Integer)
		  // Part of the Beacon.LootSource interface.
		  
		  If Self.mMaxItemSets = Value Then
		    Return
		  End If
		  
		  Self.mMaxItemSets = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinItemSets() As Integer
		  // Part of the Beacon.LootSource interface.
		  
		  Return Max(Self.mMinItemSets, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinItemSets(Assigns Value As Integer)
		  // Part of the Beacon.LootSource interface.
		  
		  If Self.mMinItemSets = Value Then
		    Return
		  End If
		  
		  Self.mMinItemSets = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  Return Self.mItemSets.Modified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  Self.mItemSets.Modified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Multipliers() As Beacon.Range
		  Return Self.mMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Notes() As String
		  Return Self.mNotes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.LootSource) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.ClassString.Compare(Other.ClassString, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PreventDuplicates() As Boolean
		  // Part of the Beacon.LootSource interface.
		  
		  Return Self.mSetsRandomWithoutReplacement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventDuplicates(Assigns Value As Boolean)
		  // Part of the Beacon.LootSource interface.
		  
		  If Self.mSetsRandomWithoutReplacement = Value Then
		    Return
		  End If
		  
		  Self.mSetsRandomWithoutReplacement = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredItemSetCount() As Integer
		  Return Self.mRequiredItemSets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SortValue() As Integer
		  Return Self.mSortValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UIColor() As Color
		  Return Self.mUIColor
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAppendMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mExperimental As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItemSets As Beacon.ItemSetCollection
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMandatoryItemSets() As Beacon.ItemSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMultipliers As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mNotes As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequiredItemSets As Integer = 1
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
End Class
#tag EndClass
