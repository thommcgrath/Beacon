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
		Sub Constructor(Path As String, ObjectID As v4UUID)
		  Super.Constructor()
		  
		  Self.mObjectID = ObjectID
		  Self.mPath = Path
		  Self.mClassString = Beacon.ClassStringFromPath(Path)
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
		Sub ModID(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mModID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModName(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mModName = Value
		  Self.Modified = True
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
		  
		  If Dict.HasAllKeys("entry_string", "required_points", "required_level") Then
		    If IsNull(Dict.Value("entry_string")) Or Dict.Value("entry_string").StringValue.IsEmpty Then
		      Self.mEngramEntryString = ""
		      Self.mRequiredUnlockPoints = Nil
		      Self.mRequiredPlayerLevel = Nil
		      Self.mItemID = Nil
		    Else
		      Self.mEngramEntryString = Dict.Value("entry_string").StringValue
		      
		      If IsNull(Dict.Value("required_level")) = False Then
		        Self.mRequiredPlayerLevel = Dict.Value("required_level").IntegerValue
		      Else
		        Self.mRequiredPlayerLevel = Nil
		      End If
		      
		      If IsNull(Dict.Value("required_points")) = False Then
		        Self.mRequiredUnlockPoints = Dict.Value("required_points").IntegerValue
		      Else
		        Self.mRequiredUnlockPoints = Nil
		      End If
		    End If
		  End If
		  
		  If Dict.HasKey("stack_size") And IsNull(Dict.Value("stack_size")) = False Then
		    Self.mStackSize = Dict.Value("stack_size").IntegerValue
		  Else
		    Self.mStackSize = Nil
		  End If
		  
		  If Dict.HasKey("recipe") And IsNull(Dict.Value("recipe")) = False Then
		    Self.mIngredients = Ark.CraftingCostIngredient.FromVariant(Dict.Value("recipe"), Nil)
		    Self.mHasLoadedIngredients = True
		  Else
		    Self.mIngredients.ResizeTo(-1)
		    Self.mHasLoadedIngredients = False
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
