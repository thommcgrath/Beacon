#tag Class
Protected Class LootTemplateEntry
Implements Beacon.Countable,Iterable
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeBlueprint() As Boolean
		  For Each Option As Ark.LootItemSetEntryOption In Self.mOptions
		    If Option.Engram.IsTagged("blueprintable") Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChanceToBeBlueprint() As Double
		  Return Self.mChanceToBeBlueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mAvailability = Ark.Maps.UniversalMask
		  Self.mRespectQualityOffsets = True
		  Self.mRespectQuantityMultipliers = True
		  Self.mRespectBlueprintChanceMultipliers = True
		  Self.mRespectWeightMultipliers = True
		  Self.mEntryId = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.LootTemplateEntry)
		  Self.Constructor()
		  
		  Self.mAvailability = Source.mAvailability
		  Self.mChanceToBeBlueprint = Source.mChanceToBeBlueprint
		  Self.mHash = Source.mHash
		  Self.mMaxQuality = Source.mMaxQuality
		  Self.mMaxQuantity = Source.mMaxQuantity
		  Self.mMinQuality = Source.mMinQuality
		  Self.mMinQuantity = Source.mMinQuantity
		  Self.mModified = Source.mModified
		  Self.mRespectBlueprintChanceMultipliers = Source.mRespectBlueprintChanceMultipliers
		  Self.mRespectQualityOffsets = Source.mRespectQualityOffsets
		  Self.mRespectQuantityMultipliers = Source.mRespectQuantityMultipliers
		  Self.mWeight = Source.mWeight
		  Self.mEntryId = Source.mEntryId
		  Self.mPreventGrinding = Source.mPreventGrinding
		  Self.mSingleItemQuantity = Source.mSingleItemQuantity
		  Self.mStatClampMultiplier = Source.mStatClampMultiplier
		  
		  Self.mOptions.ResizeTo(Source.LastIndex)
		  For Idx As Integer = 0 To Self.mOptions.LastIndex
		    Self.mOptions(Idx) = Source(Idx)
		  Next Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mOptions.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EntryId() As String
		  Return Self.mEntryId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As JSONItem) As Ark.LootTemplateEntry
		  Var Entry As New Ark.MutableLootTemplateEntry
		  
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
		      Entry.MinQuality = Ark.Qualities.ForKey(Dict.Value("MinQuality"))
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinQuality value")
		  End Try
		  
		  Try
		    If Dict.HasKey("MaxQuality") Then
		      Entry.MaxQuality = Ark.Qualities.ForKey(Dict.Value("MaxQuality"))
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxQuality value")
		  End Try
		  
		  Try
		    Entry.MinQuantity = Dict.Lookup("MinQuantity", Entry.MinQuantity)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinQuantity value")
		  End Try
		  
		  Try
		    Entry.MaxQuantity = Dict.Lookup("MaxQuantity", Entry.MaxQuantity)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxQuantity value")
		  End Try
		  
		  Try
		    Entry.ChanceToBeBlueprint = Dict.Lookup("ChanceToBeBlueprintOverride", Entry.ChanceToBeBlueprint)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading ChangeToBeBlueprintOverride value")
		  End Try
		  
		  Try
		    Entry.Availability = Dict.Lookup("Availability", Entry.Availability)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Availability value")
		  End Try
		  
		  Try
		    Entry.RespectQualityOffsets = Dict.Lookup("RespectQualityModifier", Entry.RespectQualityOffsets)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading RespectQualityModifier value")
		  End Try
		  
		  Try
		    Entry.RespectQuantityMultipliers = Dict.Lookup("RespectQuantityMultiplier", Entry.RespectQuantityMultipliers)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading RespectQuantityMultiplier value")
		  End Try
		  
		  Try
		    Entry.RespectBlueprintChanceMultipliers = Dict.Lookup("RespectBlueprintMultiplier", Entry.RespectBlueprintChanceMultipliers)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading RespectBlueprintMultiplier value")
		  End Try
		  
		  Try
		    Entry.RespectWeightMultipliers = Dict.Lookup("RespectWeightMultiplier", Entry.RespectWeightMultipliers)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading RespectWeightMultiplier value")
		  End Try
		  
		  Try
		    If Dict.HasKey("UUID") Then
		      Entry.EntryId = Dict.Value("UUID")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading UUID value")
		  End Try
		  If Entry.EntryId.IsEmpty Or Beacon.UUID.Validate(Entry.EntryId) = False Then
		    Entry.EntryId = Beacon.UUID.v4
		  End If
		  
		  If Dict.HasKey("Items") Then
		    Var Children As JSONItem
		    Try
		      Children = Dict.Child("Items")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Casting Items to array")
		    End Try
		    
		    If (Children Is Nil) = False Then
		      For Idx As Integer = 0 To Children.LastRowIndex
		        Try
		          Var Option As Ark.LootItemSetEntryOption = Ark.LootItemSetEntryOption.FromSaveData(Children.ChildAt(Idx))
		          If (Option Is Nil) = False Then
		            Entry.Add(Option)
		          End If
		        Catch Err As RuntimeException
		          App.Log(Err, CurrentMethodName, "Reading option dictionary #" + Idx.ToString(Locale.Raw, "0"))
		        End Try
		      Next
		    End If
		  End If
		  
		  Try
		    If Dict.HasKey("PreventGrinding") Then
		      Entry.PreventGrinding = Dict.Value("PreventGrinding")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading PreventGrinding value")
		  End Try
		  
		  Try
		    If Dict.HasKey("StatClampMultiplier") Then
		      Entry.StatClampMultiplier = Dict.Value("StatClampMultiplier")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading StatClampMultiplier value")
		  End Try
		  
		  Try
		    If Dict.HasKey("SingleItemQuantity") Then
		      Entry.SingleItemQuantity = Dict.Value("SingleItemQuantity")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading SingleItemQuantity value")
		  End Try
		  
		  Entry.Modified = False
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.mHash.IsEmpty Then
		    Self.mHash = Beacon.Hash(Beacon.GenerateJSON(Self.SaveData, False))
		  End If
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableClone() As Ark.LootTemplateEntry
		  Return New Ark.LootTemplateEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootTemplateEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Option As Ark.LootItemSetEntryOption) As Integer
		  For Idx As Integer = 0 To Self.mOptions.LastIndex
		    If Self.mOptions(Idx) = Option Then
		      Return Idx
		    End If
		  Next Idx
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Options() As Variant
		  Options.ResizeTo(Self.mOptions.LastIndex)
		  For I As Integer = 0 To Self.mOptions.LastIndex
		    Options(I) = Self.mOptions(I)
		  Next
		  Return New Beacon.GenericIterator(Options)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mOptions.LastIndex = -1 Then
		    Return "No Items"
		  ElseIf Self.mOptions.LastIndex = 0 Then
		    Return Self.mOptions(0).Engram.Label
		  ElseIf Self.mOptions.LastIndex = 1 Then
		    Return Self.mOptions(0).Engram.Label + " or " + Self.mOptions(1).Engram.Label
		  Else
		    Var Labels() As String
		    For I As Integer = 0 To Self.mOptions.LastIndex - 1
		      Labels.Add(Self.mOptions(I).Engram.Label)
		    Next
		    Labels.Add("or " + Self.mOptions(Self.mOptions.LastIndex).Engram.Label)
		    
		    Return Labels.Join(", ")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQuality() As Ark.Quality
		  Return Self.mMaxQuality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQuantity() As Integer
		  Return Self.mMaxQuantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQuality() As Ark.Quality
		  Return Self.mMinQuality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQuantity() As Integer
		  Return Self.mMinQuantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  Self.mHash = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableLootTemplateEntry
		  Return New Ark.MutableLootTemplateEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootTemplateEntry
		  Return New Ark.MutableLootTemplateEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.LootTemplateEntry) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mEntryId = Other.mEntryId Then
		    Return 0
		  End If
		  
		  Var MySort As String = Self.Label + ":" + Self.mEntryId
		  Var OtherSort As String = Other.Label + ":" + Other.mEntryId
		  Return MySort.Compare(OtherSort, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Ark.LootItemSetEntry
		  Var Entry As New Ark.MutableLootItemSetEntry
		  Entry.ChanceToBeBlueprint = Self.mChanceToBeBlueprint
		  Entry.MaxQuality = Self.mMaxQuality
		  Entry.MaxQuantity = Self.mMaxQuantity
		  Entry.MinQuality = Self.mMinQuality
		  Entry.MinQuantity = Self.mMinQuantity
		  Entry.PreventGrinding = Self.mPreventGrinding
		  Entry.SingleItemQuantity = Self.mSingleItemQuantity
		  Entry.StatClampMultiplier = Self.mStatClampMultiplier
		  Entry.RawWeight = Self.mWeight
		  Entry.EntryId = Self.mEntryId
		  Entry.Modified = False
		  
		  // It's ok to reference the source objects here, they are not mutable
		  For Each Option As Ark.LootItemSetEntryOption In Self.mOptions
		    Entry.Add(Option)
		  Next Option
		  
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As Ark.LootItemSetEntry)
		  Self.Constructor()
		  
		  Self.mChanceToBeBlueprint = Source.ChanceToBeBlueprint
		  Self.mMaxQuality = Source.MaxQuality
		  Self.mMaxQuantity = Source.MaxQuantity
		  Self.mMinQuality = Source.MinQuality
		  Self.mMinQuantity = Source.MinQuantity
		  Self.mPreventGrinding = Source.PreventGrinding
		  Self.mSingleItemQuantity = Source.SingleItemQuantity
		  Self.mStatClampMultiplier = Source.StatClampMultiplier
		  Self.mWeight = Source.RawWeight
		  Self.mEntryId = Source.EntryId
		  
		  // It's ok to reference the source objects here, they are not mutable
		  For Each Option As Ark.LootItemSetEntryOption In Source
		    Self.mOptions.Add(Option)
		  Next Option
		  
		  // Just in case
		  Self.mModified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Idx As Integer) As Ark.LootItemSetEntryOption
		  Return Self.mOptions(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PreventGrinding() As Boolean
		  Return Self.mPreventGrinding
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RawWeight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RespectBlueprintChanceMultipliers() As Boolean
		  Return Self.mRespectBlueprintChanceMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RespectQualityOffsets() As Boolean
		  Return Self.mRespectQualityOffsets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RespectQuantityMultipliers() As Boolean
		  Return Self.mRespectQuantityMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RespectWeightMultipliers() As Boolean
		  Return Self.mRespectWeightMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SafeForContentPacks(ContentPacks As Beacon.StringList) As Boolean
		  // This method kind of sucks, but yes it is needed for preset generation.
		  
		  If ContentPacks.Count = 0 Then
		    Return True
		  End If
		  
		  For Each Option As Ark.LootItemSetEntryOption In Self.mOptions
		    If ContentPacks.IndexOf(Option.Engram.ContentPackId) = -1 Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  // Calling the overridden superclass method.
		  Var Children() As Dictionary
		  For Each Item As Ark.LootItemSetEntryOption In Self.mOptions
		    Children.Add(Item.SaveData)
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("Availability") = Self.mAvailability
		  Dict.Value("ChanceToBeBlueprintOverride") = Self.ChanceToBeBlueprint
		  Dict.Value("EntryWeight") = Self.RawWeight / 1000
		  Dict.Value("Items") = Children
		  Dict.Value("MaxQuality") = Self.MaxQuality.Key
		  Dict.Value("MaxQuantity") = Self.MaxQuantity
		  Dict.Value("MinQuality") = Self.MinQuality.Key
		  Dict.Value("MinQuantity") = Self.MinQuantity
		  Dict.Value("RespectBlueprintMultiplier") = Self.mRespectBlueprintChanceMultipliers
		  Dict.Value("RespectQualityModifier") = Self.mRespectQualityOffsets
		  Dict.Value("RespectQuantityMultiplier") = Self.mRespectQuantityMultipliers
		  Dict.Value("RespectWeightMultiplier") = Self.mRespectWeightMultipliers
		  Dict.Value("Weight") = Self.RawWeight
		  Dict.Value("UUID") = Self.EntryId
		  Dict.Value("PreventGrinding") = Self.PreventGrinding
		  Dict.Value("StatClampMultiplier") = Self.StatClampMultiplier
		  Dict.Value("SingleItemQuantity") = Self.SingleItemQuantity
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SingleItemQuantity(Actual As Boolean = False) As Boolean
		  // If Actual is true, the caller is looking for the true state of the setting and not the effective state
		  
		  If Actual Then
		    Return Self.mSingleItemQuantity
		  Else
		    Return Self.mSingleItemQuantity Or Self.mOptions.Count = 1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatClampMultiplier() As Double
		  Return Self.mStatClampMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Ark.Map) As Boolean
		  Return Self.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Mask As UInt64) As Boolean
		  Return (Self.mAvailability And Mask) > CType(0, UInt64)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mChanceToBeBlueprint As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEntryId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxQuality As Ark.Quality
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinQuality As Ark.Quality
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mOptions() As Ark.LootItemSetEntryOption
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPreventGrinding As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRespectBlueprintChanceMultipliers As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRespectQualityOffsets As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRespectQuantityMultipliers As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRespectWeightMultipliers As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSingleItemQuantity As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStatClampMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWeight As Double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
