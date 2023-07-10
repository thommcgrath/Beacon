#tag Class
Protected Class MutableEngram
Inherits Ark.Engram
Implements Ark.MutableBlueprint
	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mAlternateLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mAvailability = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.MutableEngram
		  Return New Ark.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, EngramId As String)
		  Super.Constructor()
		  
		  Self.mEngramId = EngramId
		  Self.mPath = Path
		  Self.mClassString = Beacon.ClassStringFromPath(Path)
		  Self.mAvailability = Ark.Maps.UniversalMask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackId(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mContentPackId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackName(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mContentPackName = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EntryString(Assigns Value As String)
		  Self.mEngramEntryString = Value.Trim
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.Engram
		  Return New Ark.Engram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the Ark.MutableBlueprint interface.
		  
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
		  Self.mItemID = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastUpdate(Assigns Value As Double)
		  If Self.mLastUpdate <> Value THen
		    Self.mLastUpdate = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableEngram
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mPath = Value
		  Self.mClassString = Beacon.ClassStringFromPath(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Recipe(Assigns Ingredients() As Ark.CraftingCostIngredient)
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
		  Self.mRequiredPlayerLevel = Level
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredUnlockPoints(Assigns Points As NullableDouble)
		  Self.mRequiredUnlockPoints = Points
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StackSize(Assigns Value As NullableDouble)
		  Self.mStackSize = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
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
		  // Part of the Ark.MutableBlueprint interface.
		  
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
		    Self.mIngredients = Ark.CraftingCostIngredient.FromVariant(Dict.Value("recipe"), Nil)
		    Self.mHasLoadedIngredients = True
		  Else
		    Self.mIngredients.ResizeTo(-1)
		    Self.mHasLoadedIngredients = False
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
