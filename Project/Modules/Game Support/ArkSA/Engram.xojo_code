#tag Class
Protected Class Engram
Implements ArkSA.Blueprint,Beacon.DisambiguationCandidate
	#tag Method, Flags = &h0
		Function AllStats(UsedOnly As Boolean = False) As ArkSA.EngramStat()
		  Var Values() As ArkSA.EngramStat
		  If UsedOnly Then
		    For Idx As Integer = 0 To Self.mStats.LastIndex
		      If (Self.mStats(Idx) Is Nil ) = False Then
		        Values.Add(Self.mStats(Idx))
		      End If
		    Next
		  Else
		    Values.ResizeTo(ArkSA.EngramStat.LastIndex)
		    For Idx As Integer = 0 To Self.mStats.LastIndex
		      Values(Idx) = Self.mStats(Idx)
		    Next
		  End If
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mAlternateLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintId() As String
		  Return Self.mEngramId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintPath() As String
		  Return "Blueprint'" + Self.mPath + "'"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return ArkSA.CategoryEngrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ArkSA.Engram
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.Engram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mStats.ResizeTo(ArkSA.EngramStat.LastIndex)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.Engram)
		  Self.Constructor()
		  
		  Self.mAlternateLabel = Source.mAlternateLabel
		  Self.mAvailability = Source.mAvailability
		  Self.mClassString = Source.mClassString
		  Self.mContentPackName = Source.mContentPackName
		  Self.mContentPackId = Source.mContentPackId
		  Self.mEngramEntryString = Source.mEngramEntryString
		  Self.mHasLoadedIngredients = Source.mHasLoadedIngredients
		  Self.mIsValid = Source.mIsValid
		  Self.mItemID = Source.mItemID
		  Self.mLabel = Source.mLabel
		  Self.mModified = Source.mModified
		  Self.mEngramId = Source.mEngramId
		  Self.mPath = Source.mPath
		  Self.mRequiredPlayerLevel = Source.mRequiredPlayerLevel
		  Self.mRequiredUnlockPoints = Source.mRequiredUnlockPoints
		  Self.mStackSize = Source.mStackSize
		  Self.mLastUpdate = Source.mLastUpdate
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Add(Tag)
		  Next
		  
		  Self.mIngredients.ResizeTo(Source.mIngredients.LastIndex)
		  For Idx As Integer = 0 To Self.mIngredients.LastIndex
		    Self.mIngredients(Idx) = Source.mIngredients(Idx)
		  Next
		  
		  Self.mStats.ResizeTo(ArkSA.EngramStat.LastIndex)
		  For Idx As Integer = ArkSA.EngramStat.FirstIndex To ArkSA.EngramStat.LastIndex
		    Self.mStats(Idx) = Source.mStats(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackName() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(BlueprintId As String, Path As String, ClassString As String) As ArkSA.Engram
		  Var Engram As New ArkSA.Engram
		  Engram.mContentPackId = ArkSA.UserContentPackId
		  Engram.mContentPackName = ArkSA.UserContentPackName
		  
		  If BlueprintId.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "PrimalItemMystery_NoData_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = "PrimalItemMystery_" + BlueprintId + "_C"
		    End If
		    Path = ArkSA.UnknownBlueprintPath("Engrams", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = ArkSA.ClassStringFromPath(Path)
		  End If
		  If BlueprintId.IsEmpty Then
		    BlueprintId = Beacon.UUID.v5(Engram.mContentPackId.Lowercase + ":" + Path.Lowercase)
		  End If
		  
		  If Path.Length > 6 And Path.Left(6) = "/Game/" Then
		    If Path.Right(2) = "_C" Then
		      // Appears to be a BlueprintGeneratedClass Path
		      Path = Path.Left(Path.Length - 2)
		    End If
		    Engram.mIsValid = True
		  End If
		  
		  Engram.mPath = Path
		  Engram.mClassString = ClassString
		  Engram.mEngramId = BlueprintId
		  Engram.mTags.Add("blueprintable")
		  
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromEntryString(EntryString As String) As ArkSA.Engram
		  Var Base As String = EntryString
		  If Base.BeginsWith("EngramEntry_") Then
		    Base = Base.Middle(12)
		  End If
		  
		  // Base probably already includes _C, so don't add it again. UnknownBlueprintPath will handle it if missing.
		  Var Engram As ArkSA.Engram = CreateCustom("", "", "PrimalItemMystery_" + Base)
		  Engram.mEngramEntryString = EntryString
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationId() As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mEngramId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationMask() As UInt64
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationSuffix(Mask As UInt64) As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return ArkSA.Maps.LabelForMask(Self.Availability And Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramId() As String
		  Return Self.mEngramId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EntryString() As String
		  Return Self.mEngramEntryString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindIngredient(IngredientId As String) As ArkSA.BlueprintReference
		  For Each Ingredient As ArkSA.CraftingCostIngredient In Self.mIngredients
		    If Ingredient.Reference.BlueprintId = IngredientId Then
		      Return Ingredient.Reference
		    End If
		  Next
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
		Function ImmutableVersion() As ArkSA.Engram
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDefaultUnlocked() As Boolean
		  Return Self.mTags.IndexOf("default_unlocked") > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  // Part of the ArkSA.Blueprint interface.
		  
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
		    Self.mLabel = ArkSA.LabelFromClassString(Self.ClassString)
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ManualUnlock() As Boolean
		  If Self.HasUnlockDetails = False Then
		    Return ArkSA.DataSource.Pool.Get(False).BlueprintIsCustom(Self)
		  End If
		  
		  Return ((Self.RequiredPlayerLevel Is Nil) = False And (Self.RequiredUnlockPoints Is Nil) = False) Or ArkSA.DataSource.Pool.Get(False).BlueprintIsCustom(Self) = True
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
		Function MutableClone() As ArkSA.MutableEngram
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableEngram
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mEngramId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.Engram) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mEngramId = Other.mEngramId Then
		    Return 0
		  End If
		  
		  Return Self.Label.Compare(Other.Label, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As JSONItem, ForAPI As Boolean)
		  // Part of the ArkSA.Blueprint interface.
		  
		  If Self.HasUnlockDetails Then
		    Dict.Value("entryString") = Self.mEngramEntryString
		    If Self.mRequiredPlayerLevel Is Nil Then
		      Dict.Value("requiredLevel") = Nil
		    Else
		      Dict.Value("requiredLevel") = Self.mRequiredPlayerLevel.IntegerValue
		    End If
		    If Self.mRequiredUnlockPoints Is Nil Then
		      Dict.Value("requiredPoints") = Nil
		    Else
		      Dict.Value("requiredPoints") = Self.mRequiredUnlockPoints.IntegerValue
		    End If
		  Else
		    Dict.Value("entryString") = Nil
		    Dict.Value("itemId") = Nil
		    Dict.Value("requiredPoints") = Nil
		    Dict.Value("requiredLevel") = Nil
		  End If
		  
		  If Self.mStackSize Is Nil Then
		    Dict.Value("stackSize") = Nil
		  Else
		    Dict.Value("stackSize") = Self.mStackSize.IntegerValue
		  End If
		  
		  Call Self.Recipe // Forces the recipe to load
		  
		  If Self.mIngredients.Count = 0 Then
		    Dict.Value("recipe") = Nil
		  Else
		    Var Ingredients As New JSONItem("[]")
		    For Each Ingredient As ArkSA.CraftingCostIngredient In Self.mIngredients
		      Ingredients.Add(Ingredient.SaveData(ForAPI))
		    Next
		    Dict.Child("recipe") = Ingredients
		  End If
		  
		  Var Stats As New JSONItem("[]")
		  For Each Stat As ArkSA.EngramStat In Self.mStats
		    If Stat Is Nil Then
		      Continue
		    End If
		    Stats.Add(Stat.SaveData)
		  Next
		  Dict.Child("stats") = Stats
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Recipe() As ArkSA.CraftingCostIngredient()
		  // To prevent recursion, engrams only load ingredients on demand
		  If Self.mHasLoadedIngredients = False Then
		    Self.mIngredients = ArkSA.DataSource.Pool.Get(False).LoadIngredientsForEngram(Self)
		    Self.mHasLoadedIngredients = True
		  End If
		  
		  Var Ingredients() As ArkSA.CraftingCostIngredient
		  For Each Ingredient As ArkSA.CraftingCostIngredient In Self.mIngredients
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
		Function Stat(StatIndex As Integer) As ArkSA.EngramStat
		  If StatIndex > Self.mStats.LastIndex Then
		    Return Nil
		  End If
		  
		  Return Self.mStats(StatIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  // Part of the ArkSA.Blueprint interface.
		  
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
		Protected mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEngramEntryString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEngramId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHasLoadedIngredients As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIngredients() As ArkSA.CraftingCostIngredient
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

	#tag Property, Flags = &h1
		Protected mLastUpdate As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
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
		Protected mStats() As ArkSA.EngramStat
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
