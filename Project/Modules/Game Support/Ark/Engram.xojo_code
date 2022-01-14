#tag Class
Protected Class Engram
Implements Ark.Blueprint
	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mAlternateLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintPath() As String
		  Return "Blueprint'" + Self.mPath + "'"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Ark.CategoryEngrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.Engram
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.Engram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.Engram)
		  Self.Constructor()
		  
		  Self.mAlternateLabel = Source.mAlternateLabel
		  Self.mAvailability = Source.mAvailability
		  Self.mClassString = Source.mClassString
		  Self.mContentPackName = Source.mContentPackName
		  Self.mContentPackUUID = Source.mContentPackUUID
		  Self.mEngramEntryString = Source.mEngramEntryString
		  Self.mHasLoadedIngredients = Source.mHasLoadedIngredients
		  Self.mIsValid = Source.mIsValid
		  Self.mItemID = Source.mItemID
		  Self.mLabel = Source.mLabel
		  Self.mModified = Source.mModified
		  Self.mObjectID = Source.mObjectID
		  Self.mPath = Source.mPath
		  Self.mRequiredPlayerLevel = Source.mRequiredPlayerLevel
		  Self.mRequiredUnlockPoints = Source.mRequiredUnlockPoints
		  Self.mStackSize = Source.mStackSize
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Add(Tag)
		  Next
		  
		  Self.mIngredients.ResizeTo(Source.mIngredients.LastIndex)
		  For Idx As Integer = 0 To Self.mIngredients.LastIndex
		    Self.mIngredients(Idx) = Source.mIngredients(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackName() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackUUID() As String
		  // Part of the Ark.Blueprint interface.
		  
		  If Self.mContentPackUUID Is Nil Then
		    Return ""
		  End If
		  
		  Return Self.mContentPackUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(ObjectID As String, Path As String, ClassString As String) As Ark.Engram
		  Var Engram As New Ark.Engram
		  Engram.mContentPackUUID = Ark.UserContentPackUUID
		  Engram.mContentPackName = Ark.UserContentPackName
		  
		  If ObjectID.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "PrimalItemMystery_NoData_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = "PrimalItemMystery_" + ObjectID + "_C"
		    End If
		    Path = Ark.UnknownBlueprintPath("Engrams", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = Beacon.ClassStringFromPath(Path)
		  End If
		  If ObjectID.IsEmpty Then
		    ObjectID = v4UUID.FromHash(Crypto.HashAlgorithms.MD5, Engram.mContentPackUUID + ":" + Path.Lowercase)
		  End If
		  
		  If Path.Length > 6 And Path.Left(6) = "/Game/" Then
		    If Path.Right(2) = "_C" Then
		      // Appears to be a BlueprintGeneratedClass Path
		      Path = Path.Left(Path.Length - 2)
		    End If
		    Engram.mIsValid = True
		  End If
		  
		  Engram.mPath = Path
		  Engram.mObjectID = ObjectID
		  Engram.mTags.Add("blueprintable")
		  
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromEntryString(EntryString As String) As Ark.Engram
		  Var Base As String = EntryString
		  If Base.BeginsWith("EngramEntry_") Then
		    Base = Base.Middle(12)
		  End If
		  
		  // Base probably already includes _C, so don't add it again. UnknownBlueprintPath will handle it if missing.
		  Var Engram As Ark.Engram = CreateCustom("", "", "PrimalItemMystery_" + Base)
		  Engram.mEngramEntryString = EntryString
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EntryString() As String
		  Return Self.mEngramEntryString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GeneratedClassBlueprintPath() As String
		  Return "BlueprintGeneratedClass'" + Self.mPath + "_C'"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasUnlockDetails() As Boolean
		  Return Not Self.mEngramEntryString.IsEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.Engram
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemID() As NullableDouble
		  Return Self.mItemID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  If Self.mLabel.IsEmpty Then
		    Self.mLabel = Beacon.LabelFromClassString(Self.ClassString)
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ManualUnlock() As Boolean
		  If Self.HasUnlockDetails = False Then
		    Return Ark.DataSource.SharedInstance.BlueprintIsCustom(Self)
		  End If
		  
		  Return ((Self.RequiredPlayerLevel Is Nil) = False And (Self.RequiredUnlockPoints Is Nil) = False) Or Ark.DataSource.SharedInstance.BlueprintIsCustom(Self) = True
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableEngram
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableEngram
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.Engram) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.ObjectID = Other.ObjectID Then
		    Return 0
		  End If
		  
		  Return Self.Label.Compare(Other.Label, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary)
		  // Part of the Ark.Blueprint interface.
		  
		  If Self.HasUnlockDetails Then
		    Dict.Value("entry_string") = Self.mEngramEntryString
		    If Self.mRequiredPlayerLevel Is Nil Then
		      Dict.Value("required_level") = Nil
		    Else
		      Dict.Value("required_level") = Self.mRequiredPlayerLevel.IntegerValue
		    End If
		    If Self.mRequiredUnlockPoints Is Nil Then
		      Dict.Value("required_points") = Nil
		    Else
		      Dict.Value("required_points") = Self.mRequiredUnlockPoints.IntegerValue
		    End If
		  Else
		    Dict.Value("entry_string") = Nil
		    Dict.Value("item_id") = Nil
		    Dict.Value("required_points") = Nil
		    Dict.Value("required_level") = Nil
		  End If
		  
		  If Self.mStackSize Is Nil Then
		    Dict.Value("stack_size") = Nil
		  Else
		    Dict.Value("stack_size") = Self.mStackSize.IntegerValue
		  End If
		  
		  Call Self.Recipe // Forces the recipe to load
		  
		  If Self.mIngredients.Count = 0 Then
		    Dict.Value("recipe") = Nil
		  Else
		    Var Ingredients() As Dictionary
		    For Each Ingredient As Ark.CraftingCostIngredient In Self.mIngredients
		      Ingredients.Add(Ingredient.Pack)
		    Next
		    Dict.Value("recipe") = Ingredients
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Recipe() As Ark.CraftingCostIngredient()
		  // To prevent recursion, engrams only load ingredients on demand
		  If Self.mHasLoadedIngredients = False Then
		    Self.mIngredients = Ark.DataSource.SharedInstance.LoadIngredientsForEngram(Self)
		    Self.mHasLoadedIngredients = True
		  End If
		  
		  Var Ingredients() As Ark.CraftingCostIngredient
		  For Each Ingredient As Ark.CraftingCostIngredient In Self.mIngredients
		    Ingredients.Add(Ingredient)
		  Next
		  Return Ingredients
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredPlayerLevel() As NullableDouble
		  Return Self.mRequiredPlayerLevel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredUnlockPoints() As NullableDouble
		  Return Self.mRequiredUnlockPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StackSize() As NullableDouble
		  Return Self.mStackSize
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  // Part of the Ark.Blueprint interface.
		  
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastIndex)
		  For I As Integer = 0 To Self.mTags.LastIndex
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAlternateLabel As NullableString
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackUUID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEngramEntryString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHasLoadedIngredients As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIngredients() As Ark.CraftingCostIngredient
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsValid As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mItemID As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mObjectID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequiredPlayerLevel As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequiredUnlockPoints As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStackSize As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTags() As String
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
