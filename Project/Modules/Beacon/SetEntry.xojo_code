#tag Class
Protected Class SetEntry
Implements Beacon.Countable
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.SetEntryOption)
		  Self.mItems.Append(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeBlueprint() As Boolean
		  For Each Option As Beacon.SetEntryOption In Self.mItems
		    If Option.Engram.CanBeBlueprint Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassesLabel() As Text
		  If UBound(Self.mItems) = -1 Then
		    Return "No Items"
		  ElseIf UBound(Self.mItems) = 0 Then
		    Return Self.mItems(0).Engram.ClassString
		  ElseIf UBound(Self.mItems) = 1 Then
		    Return Self.mItems(0).Engram.ClassString + " or " + Self.mItems(1).Engram.ClassString
		  Else
		    Dim Labels() As Text
		    For I As Integer = 0 To UBound(Self.mItems) - 1
		      Labels.Append(Self.mItems(I).Engram.ClassString)
		    Next
		    Labels.Append("or " + Self.mItems(UBound(Self.mItems)).Engram.ClassString)
		    
		    Return Text.Join(Labels, ", ")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinQuantity = 1
		  Self.mMaxQuantity = 1
		  Self.mMinQuality = Beacon.Qualities.Primitive
		  Self.mMaxQuality = Beacon.Qualities.Ascendant
		  Self.mChanceToBeBlueprint = 1.0
		  Self.mWeight = 1
		  Self.mUniqueID = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntry)
		  Self.Constructor()
		  
		  Redim Self.mItems(UBound(Source.mItems))
		  
		  Self.mChanceToBeBlueprint = Source.mChanceToBeBlueprint
		  Self.mMaxQuality = Source.mMaxQuality
		  Self.mMaxQuantity = Source.mMaxQuantity
		  Self.mMinQuality = Source.mMinQuality
		  Self.mMinQuantity = Source.mMinQuantity
		  Self.mWeight = Source.mWeight
		  Self.mUniqueID = Source.mUniqueID
		  
		  For I As Integer = 0 To UBound(Source.mItems)
		    Self.mItems(I) = New Beacon.SetEntryOption(Source.mItems(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mItems) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Children() As Xojo.Core.Dictionary
		  For Each Item As Beacon.SetEntryOption In Self.mItems
		    Children.Append(Item.Export)
		  Next
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("ChanceToBeBlueprintOverride") = Self.ChanceToBeBlueprint
		  Keys.Value("Items") = Children
		  Keys.Value("MaxQuality") = Beacon.QualityToText(Self.MaxQuality)
		  Keys.Value("MaxQuantity") = Self.MaxQuantity
		  Keys.Value("MinQuality") = Beacon.QualityToText(Self.MinQuality)
		  Keys.Value("MinQuantity") = Self.MinQuantity
		  Keys.Value("EntryWeight") = Self.Weight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Beacon.SetEntryIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As Text
		  Dim Items() As Text
		  Redim Items(UBound(Self.mItems))
		  For I As Integer = 0 To UBound(Items)
		    Items(I) = Self.mItems(I).Hash
		  Next
		  Items.Sort
		  
		  Dim Locale As Xojo.Core.Locale = Xojo.Core.Locale.Raw
		  Dim Format As Text = "0.000"
		  
		  Dim Parts(6) As Text
		  Parts(0) = Beacon.MD5(Text.Join(Items, ",")).Lowercase
		  Parts(1) = Self.ChanceToBeBlueprint.ToText(Locale, Format)
		  Parts(2) = Beacon.QualityToText(Self.MaxQuality).Lowercase
		  Parts(3) = Self.MaxQuantity.ToText(Locale, Format)
		  Parts(4) = Beacon.QualityToText(Self.MinQuality).Lowercase
		  Parts(5) = Self.MinQuantity.ToText(Locale, Format)
		  Parts(6) = Self.Weight.ToText(Locale, Format)
		  
		  Return Beacon.MD5(Text.Join(Parts, ",")).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Dict As Xojo.Core.Dictionary, Multipliers As Beacon.Range) As Beacon.SetEntry
		  Dim Entry As New Beacon.SetEntry
		  If Dict.HasKey("EntryWeight") Then
		    Entry.Weight = Dict.Value("EntryWeight")
		  Else
		    Entry.Weight = Dict.Lookup("Weight", Entry.Weight)
		  End If
		  
		  If Dict.HasKey("MinQuality") Then
		    Dim Value As Auto = Dict.Value("MinQuality")
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		    If Info.FullName = "Text" Then
		      Entry.MinQuality = Beacon.TextToQuality(Value)
		    Else
		      Entry.MinQuality = Beacon.QualityForValue(Value, Multipliers.Min)
		    End If
		  End If
		  If Dict.HasKey("MaxQuality") Then
		    Dim Value As Auto = Dict.Value("MaxQuality")
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		    If Info.FullName = "Text" Then
		      Entry.MaxQuality = Beacon.TextToQuality(Value)
		    Else
		      Entry.MaxQuality = Beacon.QualityForValue(Value, Multipliers.Max)
		    End If
		  End If
		  
		  Entry.MinQuantity = Dict.Lookup("MinQuantity", Entry.MinQuantity)
		  Entry.MaxQuantity = Dict.Lookup("MaxQuantity", Entry.MaxQuantity)
		  
		  // If bForceBlueprint is not included or explicitly true, then force is true. This
		  // mirrors how Ark works. If bForceBlueprint is false, then look to one of the
		  // chance keys. If neither key is specified, chance default to 0.
		  Dim HasExplicitChance As Boolean = Dict.HasKey("ChanceToActuallyGiveItem") Or Dict.HasKey("ChanceToBeBlueprintOverride")
		  Dim ForceBlueprint As Boolean = if(Dict.HasKey("bForceBlueprint"), Dict.Value("bForceBlueprint"), Not HasExplicitChance) // Default is true in-game
		  Dim Chance As Double
		  If ForceBlueprint Then
		    Chance = 1
		  Else
		    If Dict.HasKey("ChanceToActuallyGiveItem") Then
		      Chance = 1.0 - Dict.Value("ChanceToActuallyGiveItem")
		    ElseIf Dict.HasKey("ChanceToBeBlueprintOverride") Then
		      Chance = Dict.Value("ChanceToBeBlueprintOverride")
		    Else
		      Chance = 0
		    End If
		  End If
		  Entry.ChanceToBeBlueprint = Chance
		  
		  Dim ClassWeights() As Auto
		  If Dict.HasKey("ItemsWeights") Then
		    ClassWeights = Dict.Value("ItemsWeights")
		  End If
		  
		  Dim ClassStrings() As Auto
		  If Dict.HasKey("ItemClassStrings") Then
		    ClassStrings = Dict.Value("ItemClassStrings")
		  ElseIf Dict.HasKey("Items") Then
		    // Could be array of blueprints or from a Beacon file
		    Dim Children() As Auto = Dict.Value("Items")
		    For Each Child As Auto In Children
		      Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Child)
		      Select Case Info.FullName
		      Case "Xojo.Core.Dictionary"
		        Entry.Append(Beacon.SetEntryOption.Import(Child))
		      Case "Text"
		        Dim ClassString As Text = Beacon.CleanupClassString(Child)
		        ClassStrings.Append(ClassString)
		      End Select
		    Next
		  End If
		  
		  If UBound(ClassWeights) < UBound(ClassStrings) Then
		    // Add more values
		    While UBound(ClassWeights) < UBound(ClassStrings)
		      ClassWeights.Append(1)
		    Wend
		  ElseIf UBound(ClassWeights) > UBound(ClassStrings) Then
		    // Just truncate
		    Redim ClassWeights(UBound(ClassStrings))
		  End If
		  
		  For I As Integer = 0 To UBound(ClassStrings)
		    Try
		      Dim ClassString As Text = ClassStrings(I)
		      Dim ClassWeight As Double = ClassWeights(I)
		      Entry.Append(New Beacon.SetEntryOption(Beacon.Engram.Lookup(ClassString), ClassWeight))
		    Catch Err As TypeMismatchException
		      Continue
		    End Try
		  Next
		  
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As Beacon.SetEntryOption) As Integer
		  For I As Integer = 0 To UBound(Self.mItems)
		    If Self.mItems(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Beacon.SetEntryOption)
		  Self.mItems.Insert(Index, Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Entries() As Beacon.SetEntry, Separator As Text, Multipliers As Beacon.Range) As Text
		  Dim Values() As Text
		  For Each Entry As Beacon.SetEntry In Entries
		    Values.Append(Entry.TextValue(Multipliers))
		  Next
		  Return Text.Join(Values, Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  If UBound(Self.mItems) = -1 Then
		    Return "No Items"
		  ElseIf UBound(Self.mItems) = 0 Then
		    Return Self.mItems(0).Engram.Label
		  ElseIf UBound(Self.mItems) = 1 Then
		    Return Self.mItems(0).Engram.Label + " or " + Self.mItems(1).Engram.Label
		  Else
		    Dim Labels() As Text
		    For I As Integer = 0 To UBound(Self.mItems) - 1
		      Labels.Append(Self.mItems(I).Engram.Label)
		    Next
		    Labels.Append("or " + Self.mItems(UBound(Self.mItems)).Engram.Label)
		    
		    Return Text.Join(Labels, ", ")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.SetEntry) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Dim SelfHash As Text = Self.Hash
		  Dim OtherHash As Text = Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mItems(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.SetEntryOption
		  Return Self.mItems(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Item As Beacon.SetEntryOption)
		  Self.mItems(Index) = Item
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextValue(Multipliers As Beacon.Range) As Text
		  Dim Classes(), Weights() As Text
		  Redim Classes(UBound(Self.mItems))
		  Redim Weights(UBound(Self.mItems))
		  For I As Integer = 0 To UBound(Self.mItems)
		    Classes(I) = Self.mItems(I).Engram.ClassString
		    Weights(I) = Self.mItems(I).Weight.ToText
		  Next
		  
		  Dim MinQuality As Double = Beacon.ValueForQuality(Self.mMinQuality, Multipliers.Min)
		  Dim MaxQuality As Double = Beacon.ValueForQuality(Self.mMaxQuality, Multipliers.Max)
		  Dim Chance As Double = if(Self.CanBeBlueprint, Self.mChanceToBeBlueprint, 0)
		  Dim InverseChance As Double = 1 - Chance
		  
		  Dim Values() As Text
		  Values.Append("EntryWeight=" + Self.mWeight.ToText)
		  Values.Append("ItemClassStrings=(""" + Text.Join(Classes, """,""") + """)")
		  Values.Append("ItemsWeights=(" + Text.Join(Weights, ",") + ")")
		  Values.Append("MinQuantity=" + Self.mMinQuantity.ToText)
		  Values.Append("MaxQuantity=" + Self.mMaxQuantity.ToText)
		  Values.Append("MinQuality=" + MinQuality.ToText)
		  Values.Append("MaxQuality=" + MaxQuality.ToText)
		  
		  // ChanceToActuallyGiveItem and ChanceToBeBlueprintOverride appear to be inverse of each
		  // other. I'm not sure why both exist, but I've got a theory. Some of the loot source
		  // definitions are based on PrimalSupplyCrateItemSets and others on PrimalSupplyCrateItemSet.
		  // There's no common parent between them. Seems like Wildcard messed this up. I think
		  // PrimalSupplyCrateItemSets uses ChanceToActuallyGiveItem, and PrimalSupplyCrateItemSet
		  // uses ChanceToBeBlueprintOverride. Safest option right now is to include both.
		  If Chance < 1 Then
		    Values.Append("bForceBlueprint=false")
		  Else
		    Values.Append("bForceBlueprint=true")
		  End If
		  Values.Append("ChanceToActuallyGiveItem=" + InverseChance.ToText)
		  Values.Append("ChanceToBeBlueprintOverride=" + Chance.ToText)
		  
		  Return "(" + Text.Join(Values, ",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UniqueID() As Text
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
			  Self.mChanceToBeBlueprint = Max(Min(Value, 1.0), 0.0)
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
			  Self.mMaxQuality = Value
			End Set
		#tag EndSetter
		MaxQuality As Beacon.Qualities
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMaxQuantity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMaxQuantity = Max(Value, 1)
			End Set
		#tag EndSetter
		MaxQuantity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mChanceToBeBlueprint As Double = 1.0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinQuality
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMinQuality = Value
			End Set
		#tag EndSetter
		MinQuality As Beacon.Qualities
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinQuantity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMinQuantity = Max(Value, 1)
			End Set
		#tag EndSetter
		MinQuantity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mItems() As Beacon.SetEntryOption
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxQuality As Beacon.Qualities
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinQuality As Beacon.Qualities
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUniqueID As Text
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
			  Self.mWeight = Min(Max(Value, 0.0), 1.0)
			End Set
		#tag EndSetter
		Weight As Double
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
			Name="MaxQuality"
			Group="Behavior"
			Type="Beacon.Qualities"
			EditorType="Enum"
			#tag EnumValues
				"0 - Primitive"
				"1 - Ramshackle"
				"2 - Apprentice"
				"3 - Journeyman"
				"4 - Mastercraft"
				"5 - Ascendant"
				"6 - AscendantPlus"
				"7 - AscendantPlusPlus"
				"8 - AscendantPlusPlusPlus"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxQuantity"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinQuality"
			Group="Behavior"
			Type="Beacon.Qualities"
			EditorType="Enum"
			#tag EnumValues
				"0 - Primitive"
				"1 - Ramshackle"
				"2 - Apprentice"
				"3 - Journeyman"
				"4 - Mastercraft"
				"5 - Ascendant"
				"6 - AscendantPlus"
				"7 - AscendantPlusPlus"
				"8 - AscendantPlusPlusPlus"
			#tag EndEnumValues
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
			Name="Weight"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
