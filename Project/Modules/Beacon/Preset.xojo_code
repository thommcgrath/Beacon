#tag Class
Protected Class Preset
Implements Beacon.Countable
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLabel = "Untitled Preset"
		  Self.mGrouping = "Miscellaneous"
		  Self.mMinItems = 1
		  Self.mMaxItems = 3
		  Self.mWeight = 1
		  
		  Self.mQualityModifierStandard = 0
		  Self.mQualityModifierBonus = 3
		  Self.mQualityModifierCave = 6
		  Self.mQualityModifierSea = 6
		  
		  Self.mQuantityMultiplierStandard = 1
		  Self.mQuantityMultiplierBonus = 2
		  Self.mQuantityMultiplierCave = 1
		  Self.mQuantityMultiplierSea = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Preset)
		  Self.mLabel = Source.mLabel
		  Self.mGrouping = Source.mGrouping
		  Self.mMinItems = Source.mMinItems
		  Self.mMaxItems = Source.mMaxItems
		  Self.mWeight = Source.mWeight
		  
		  Self.mQualityModifierStandard = Source.mQualityModifierStandard
		  Self.mQualityModifierBonus = Source.mQualityModifierBonus
		  Self.mQualityModifierCave = Source.mQualityModifierCave
		  Self.mQualityModifierSea = Source.mQualityModifierSea
		  
		  Self.mQuantityMultiplierStandard = Source.mQuantityMultiplierStandard
		  Self.mQuantityMultiplierBonus = Source.mQuantityMultiplierBonus
		  Self.mQuantityMultiplierCave = Source.mQuantityMultiplierCave
		  Self.mQuantityMultiplierSea = Source.mQuantityMultiplierSea
		  
		  Redim Self.mContents(UBound(Source.mContents))
		  For I As Integer = 0 To UBound(Self.mContents)
		    Self.mContents(I) = New Beacon.PresetEntry(Source.mContents(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mContents) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateSet(Source As Beacon.LootSource) As Beacon.ItemSet
		  // Temporary until loot sources actually list kinds
		  Dim Kind As Beacon.LootSource.Kinds = Beacon.LootSource.Kinds.Standard
		  
		  Dim Entries() As Beacon.SetEntry
		  For Each Item As Beacon.PresetEntry In Self
		    If (Item.ValidForIsland And Source.IsScorchedEarth = False) Or (Item.ValidForScorched And Source.IsScorchedEarth = True) Then
		      Entries.Append(New Beacon.SetEntry(Item))
		    End If
		  Next
		  
		  Dim Set As New Beacon.ItemSet
		  Set.Label = Self.Label
		  Set.MinNumItems = Self.MinItems
		  Set.MaxNumItems = Self.MaxItems
		  Set.Weight = Self.Weight
		  
		  For Each Entry As Beacon.SetEntry In Entries
		    Dim QuantityMultiplier As Double = Self.QuantityMultiplier(Kind)
		    Dim QualityModifier As Integer = Self.QualityModifier(Kind)
		    
		    Dim MinQuality As Integer = Max(Min(CType(Entry.MinQuality, Integer) + QualityModifier, 8), 0)
		    Dim MaxQuality As Integer = Max(Min(CType(Entry.MaxQuality, Integer) + QualityModifier, 8), 0)
		    
		    Entry.MinQuantity = Entry.MinQuantity * QuantityMultiplier
		    Entry.MaxQuantity = Entry.MaxQuantity * QuantityMultiplier
		    Entry.MinQuality = CType(MinQuality, Beacon.Qualities)
		    Entry.MaxQuality = CType(MaxQuality, Beacon.Qualities)
		    
		    Set.Append(Entry)
		  Next
		  
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entry(Index As Integer) As Beacon.PresetEntry
		  Return New Beacon.PresetEntry(Self.mContents(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Xojo.Core.Dictionary) As Beacon.Preset
		  Dim Preset As New Beacon.MutablePreset
		  Preset.Label = Dict.Lookup("label", Preset.Label)
		  Preset.Grouping = Dict.Lookup("grouping", Preset.Grouping)
		  Preset.MinItems = Dict.Lookup("min", Preset.MinItems)
		  Preset.MaxItems = Dict.Lookup("max", Preset.MaxItems)
		  Preset.Weight = Dict.Lookup("weight", Preset.Weight)
		  
		  Dim Contents As Xojo.Core.Dictionary = Dict.Lookup("contents", Nil)
		  If Contents <> Nil Then
		    For Each Set As Xojo.Core.DictionaryEntry In Contents
		      Dim ValidForIsland As Boolean = (Set.Key = "common" Or Set.Key = "island")
		      Dim ValidForScorched As Boolean = (Set.Key = "common" Or Set.Key = "scorched")
		      Dim Items() As Auto = Set.Value
		      For Each Item As Xojo.Core.Dictionary In Items
		        Dim Entry As Beacon.SetEntry = Beacon.SetEntry.Import(Item)
		        If Entry <> Nil Then
		          Dim Child As New Beacon.PresetEntry(Entry)
		          Child.ValidForIsland = ValidForIsland
		          Child.ValidForScorched = ValidForScorched
		          Preset.Append(Child)
		        End If
		      Next
		    Next
		  End If
		  
		  Dim Modifiers As Xojo.Core.Dictionary = Dict.Lookup("modifiers", Nil)
		  If Modifiers <> Nil Then
		    For Each Set As Xojo.Core.DictionaryEntry In Contents
		      Dim Kind As Beacon.LootSource.Kinds
		      Select Case Set.Key
		      Case "standard"
		        Kind = Beacon.LootSource.Kinds.Standard
		      Case "bonus"
		        Kind = Beacon.LootSource.Kinds.Bonus
		      Case "cave"
		        Kind = Beacon.LootSource.Kinds.Cave
		      Case "sea"
		        Kind = Beacon.LootSource.Kinds.Sea
		      Else
		        Continue
		      End Select
		      
		      Dim Item As Xojo.Core.Dictionary = Set.Value
		      Preset.QualityModifier(Kind) = Item.Lookup("quality", Preset.QualityModifier(Kind))
		      Preset.QuantityMultiplier(Kind) = Item.Lookup("quantity", Preset.QuantityMultiplier(Kind))
		    Next
		  End If
		  
		  Return New Beacon.Preset(Preset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromFile(File As Xojo.IO.FolderItem) As Beacon.Preset
		  If File = Nil Or File.Exists = False Or File.IsFolder = True Then
		    Return Nil
		  End If
		  
		  Try
		    Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(File, Xojo.Core.TextEncoding.UTF8)
		    Dim TextContents As Text = Stream.ReadAll
		    Stream.Close
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContents)
		    Return Beacon.Preset.FromDictionary(Dict)
		  Catch Err As Xojo.IO.IOException
		    Return Nil
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  Catch Err As TypeMismatchException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Beacon.PresetIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Grouping() As Text
		  Return Self.mGrouping
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.PresetEntry) As Integer
		  For I As Integer = 0 To UBound(Self.mContents)
		    If Self.mContents(I) = Entry Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxItems() As Integer
		  Return Self.mMaxItems
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinItems() As Integer
		  Return Self.mMinItems
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.PresetEntry
		  Return New Beacon.PresetEntry(Self.mContents(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QualityModifier(Kind As Beacon.LootSource.Kinds) As Integer
		  Select Case Kind
		  Case Beacon.LootSource.Kinds.Standard
		    Return Self.mQualityModifierStandard
		  Case Beacon.LootSource.Kinds.Bonus
		    Return Self.mQualityModifierBonus
		  Case Beacon.LootSource.Kinds.Cave
		    Return Self.mQualityModifierCave
		  Case Beacon.LootSource.Kinds.Sea
		    Return Self.mQualityModifierSea
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(Kind As Beacon.LootSource.Kinds) As Double
		  Select Case Kind
		  Case Beacon.LootSource.Kinds.Standard
		    Return Self.mQuantityMultiplierStandard
		  Case Beacon.LootSource.Kinds.Bonus
		    Return Self.mQuantityMultiplierBonus
		  Case Beacon.LootSource.Kinds.Cave
		    Return Self.mQuantityMultiplierCave
		  Case Beacon.LootSource.Kinds.Sea
		    Return Self.mQuantityMultiplierSea
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Xojo.Core.Dictionary
		  Dim CommonItems(), IslandItems(), ScorchedItems() As Xojo.Core.Dictionary
		  For Each Entry As Beacon.PresetEntry In Self.mContents
		    Dim Exported As Xojo.Core.Dictionary = Entry.Export
		    If Entry.ValidForIsland And Entry.ValidForScorched Then
		      CommonItems.Append(Exported)
		    ElseIf Entry.ValidForIsland Then
		      IslandItems.Append(Exported)
		    ElseIf Entry.ValidForScorched Then
		      ScorchedItems.Append(Exported)
		    End If
		  Next
		  
		  Dim Contents As New Xojo.Core.Dictionary
		  Contents.Value("Common") = CommonItems
		  Contents.Value("Island") = IslandItems
		  Contents.Value("Scorched") = ScorchedItems
		  
		  Dim StandardModifiers As New Xojo.Core.Dictionary
		  StandardModifiers.Value("Quality") = Self.mQualityModifierStandard
		  StandardModifiers.Value("Quantity") = Self.mQuantityMultiplierStandard
		  
		  Dim BonusModifiers As New Xojo.Core.Dictionary
		  BonusModifiers.Value("Quality") = Self.mQualityModifierBonus
		  BonusModifiers.Value("Quantity") = Self.mQuantityMultiplierBonus
		  
		  Dim CaveModifiers As New Xojo.Core.Dictionary
		  CaveModifiers.Value("Quality") = Self.mQualityModifierCave
		  CaveModifiers.Value("Quantity") = Self.mQuantityMultiplierCave
		  
		  Dim SeaModifiers As New Xojo.Core.Dictionary
		  SeaModifiers.Value("Quality") = Self.mQualityModifierSea
		  SeaModifiers.Value("Quantity") = Self.mQuantityMultiplierSea
		  
		  Dim Modifiers As New Xojo.Core.Dictionary
		  Modifiers.Value("Standard") = StandardModifiers
		  Modifiers.Value("Bonus") = BonusModifiers
		  Modifiers.Value("Cave") = CaveModifiers
		  Modifiers.Value("Sea") = SeaModifiers
		  
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Label") = Self.mLabel
		  Dict.Value("Grouping") = Self.mGrouping
		  Dict.Value("Min") = Self.mMinItems
		  Dict.Value("Max") = Self.mMaxItems
		  Dict.Value("Weight") = Self.mWeight
		  Dict.Value("Contents") = Contents
		  Dict.Value("Modifiers") = Modifiers
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ToFile(File As Xojo.IO.FolderItem)
		  Dim Contents As Text = Xojo.Data.GenerateJSON(Self.ToDictionary)
		  Dim Stream As Xojo.IO.TextOutputStream = Xojo.IO.TextOutputStream.Create(File, Xojo.Core.TextEncoding.UTF8)
		  Stream.Write(Contents)
		  Stream.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mContents() As Beacon.PresetEntry
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGrouping As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQualityModifierBonus As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQualityModifierCave As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQualityModifierSea As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQualityModifierStandard As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQuantityMultiplierBonus As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQuantityMultiplierCave As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQuantityMultiplierSea As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mQuantityMultiplierStandard As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWeight As Double
	#tag EndProperty


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
