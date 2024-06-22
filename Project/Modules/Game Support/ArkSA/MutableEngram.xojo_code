#tag Class
Protected Class MutableEngram
Inherits ArkSA.Engram
Implements ArkSA.MutableBlueprint
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mAlternateLabel = Value Then
		    Return
		  End If
		  
		  Self.mAlternateLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mAvailability = Value Then
		    Return
		  End If
		  
		  Self.mAvailability = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintId(Assigns Value As String)
		  If Self.mEngramId = Value Then
		    Return
		  End If
		  
		  Self.mEngramId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ArkSA.MutableEngram
		  Return New ArkSA.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Making it public
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, EngramId As String)
		  Super.Constructor()
		  
		  Self.mEngramId = EngramId
		  Self.mPath = Path
		  Self.mClassString = ArkSA.ClassStringFromPath(Path)
		  Self.mAvailability = ArkSA.Maps.UniversalMask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackId(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mContentPackId = Value Then
		    Return
		  End If
		  
		  Self.mContentPackId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackName(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mContentPackName = Value Then
		    Return
		  End If
		  
		  Self.mContentPackName = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EngramId(Assigns Value As String)
		  If Self.mEngramId = Value Then
		    Return
		  End If
		  
		  Self.mEngramId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EntryString(Assigns Value As String)
		  
		  Value = Value.Trim
		  If Self.mEngramEntryString = Value Then
		    Return
		  End If
		  
		  Self.mEngramEntryString = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.Engram
		  Return New ArkSA.Engram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  Tag = Beacon.NormalizeTag(Tag)
		  Var Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 And Value = False Then
		    Self.mTags.RemoveAt(Idx)
		    Self.Modified = True
		  ElseIf Idx = -1 And Value = True Then
		    Self.mTags.Add(Tag)
		    Self.mTags.Sort()
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ItemID(Assigns Value As NullableDouble)
		  If Self.mItemID = Value Then
		    Return
		  End If
		  
		  Self.mItemID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mLabel = Value Then
		    Return
		  End If
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastUpdate(Assigns Value As Double)
		  If Self.mLastUpdate = Value Then
		    Return
		  End If
		  
		  Self.mLastUpdate = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableEngram
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mPath = Value Then
		    Return
		  End If
		  
		  Self.mPath = Value
		  Self.mClassString = ArkSA.ClassStringFromPath(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Recipe(Assigns Ingredients() As ArkSA.CraftingCostIngredient)
		  If Ingredients Is Nil Then
		    Self.mIngredients.ResizeTo(-1)
		    Self.mHasLoadedIngredients = True
		    Return
		  End If
		  
		  Self.mIngredients.ResizeTo(Ingredients.LastIndex)
		  For Idx As Integer = 0 To Self.mIngredients.LastIndex
		    Self.mIngredients(Idx) = Ingredients(Idx)
		  Next
		  Self.mHasLoadedIngredients = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredPlayerLevel(Assigns Level As NullableDouble)
		  If Self.mRequiredPlayerLevel = Level Then
		    Return
		  End If
		  
		  Self.mRequiredPlayerLevel = Level
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredUnlockPoints(Assigns Points As NullableDouble)
		  If Self.mRequiredUnlockPoints = Points Then
		    Return
		  End If
		  
		  Self.mRequiredUnlockPoints = Points
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StackSize(Assigns Value As NullableDouble)
		  If Self.mStackSize = Value Then
		    Return
		  End If
		  
		  Self.mStackSize = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stat(StatIndex As Integer, Assigns Stat As ArkSA.EngramStat)
		  If (Stat Is Nil) = False Then
		    StatIndex = Stat.StatIndex
		  End If
		  
		  If StatIndex >= ArkSA.EngramStat.FirstIndex And StatIndex <= ArkSA.EngramStat.LastIndex And Self.mStats(StatIndex) <> Stat Then
		    Self.mStats(StatIndex) = Stat
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.Add(Tag)
		  Next
		  Self.mTags.Sort
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unpack(Dict As Dictionary)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  Var EntryString As NullableString
		  Var RequiredPoints, RequiredLevel, ItemId As NullableDouble
		  If Dict.HasAllKeys("entryString", "requiredPoints", "requiredLevel") Then
		    EntryString = NullableString.FromVariant(Dict.Value("entryString"))
		    RequiredPoints = NullableDouble.FromVariant(Dict.Value("requiredPoints"))
		    RequiredLevel = NullableDouble.FromVariant(Dict.Value("requiredLevel"))
		  ElseIf Dict.HasAllKeys("entry_string", "required_points", "required_level") Then
		    EntryString = NullableString.FromVariant(Dict.Value("entry_string"))
		    RequiredPoints = NullableDouble.FromVariant(Dict.Value("required_points"))
		    RequiredLevel = NullableDouble.FromVariant(Dict.Value("required_level"))
		  End If
		  
		  If Dict.HasKey("itemId") Then
		    ItemId = NullableDouble.FromVariant(Dict.Value("itemId"))
		  ElseIf Dict.HasKey("item_id") Then
		    ItemId = NullableDouble.FromVariant(Dict.Value("item_id"))
		  End If
		  
		  If EntryString Is Nil Or EntryString.IsEmpty Then
		    Self.mEngramEntryString = ""
		    Self.mRequiredUnlockPoints = Nil
		    Self.mRequiredPlayerLevel = Nil
		    Self.mItemID = Nil
		  Else
		    Self.mEngramEntryString = EntryString.StringValue
		    Self.mRequiredUnlockPoints = RequiredPoints
		    Self.mRequiredPlayerLevel = RequiredLevel
		    Self.mItemID = ItemId
		  End If
		  
		  Var StackSize As NullableDouble
		  If Dict.HasKey("stackSize") Then
		    StackSize = NullableDouble.FromVariant(Dict.Value("stackSize"))
		  ElseIf Dict.HasKey("stack_size") Then
		    StackSize = NullableDouble.FromVariant(Dict.Value("stack_size"))
		  End If
		  Self.mStackSize = StackSize
		  
		  If Dict.HasKey("recipe") And IsNull(Dict.Value("recipe")) = False Then
		    Self.mIngredients = ArkSA.CraftingCostIngredient.FromVariant(Dict.Value("recipe"), Nil)
		    Self.mHasLoadedIngredients = True
		  Else
		    Self.mIngredients.ResizeTo(-1)
		    Self.mHasLoadedIngredients = False
		  End If
		  
		  If Dict.HasKey("stats") And Dict.Value("stats").IsNull = False Then
		    Var Stats() As Variant = Dict.Value("stats")
		    Self.mStats.ResizeTo(ArkSA.EngramStat.LastIndex)
		    For Each StatDict As Dictionary In Stats
		      Var Stat As ArkSA.EngramStat = ArkSA.EngramStat.FromSaveData(StatDict)
		      If (Stat Is Nil) = False Then
		        Self.mStats(Stat.StatIndex) = Stat
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod


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
