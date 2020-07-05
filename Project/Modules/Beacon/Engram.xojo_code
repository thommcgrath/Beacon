#tag Class
Protected Class Engram
Implements Beacon.Blueprint
	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  Return Self.mAlternateLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
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
		  Return Beacon.CategoryEngrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  If Self.IsValid Then
		    Var Components() As String = Self.mPath.Split("/")
		    Var Tail As String = Components(Components.LastRowIndex)
		    Components = Tail.Split(".")
		    Return Components(Components.LastRowIndex) + "_C"
		  Else
		    If Self.mPath.Length > 2 And Self.mPath.Right(2) = "_C" Then
		      Return Self.mPath
		    Else
		      Return Self.mPath + "_C"
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.Engram
		  Return New Beacon.Engram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mAvailability = Beacon.Maps.All.Mask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Engram)
		  Self.Constructor()
		  
		  Self.mObjectID = Source.mObjectID
		  Self.mAvailability = Source.mAvailability
		  Self.mPath = Source.mPath
		  Self.mLabel = Source.mLabel
		  Self.mIsValid = Source.mIsValid
		  Self.mModID = Source.mModID
		  Self.mModName = Source.mModName
		  Self.mEngramEntryString = Source.mEngramEntryString
		  Self.mRequiredPlayerLevel = Source.mRequiredPlayerLevel
		  Self.mRequiredUnlockPoints = Source.mRequiredUnlockPoints
		  Self.mStackSize = Source.mStackSize
		  Self.mItemID = Source.mItemID
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.AddRow(Tag)
		  Next
		  
		  Self.mHasLoadedIngredients = Source.mHasLoadedIngredients
		  Self.mIngredients.ResizeTo(Source.mIngredients.LastRowIndex)
		  For Idx As Integer = 0 To Self.mIngredients.LastRowIndex
		    Self.mIngredients(Idx) = Source.mIngredients(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromClass(ClassString As String) As Beacon.Engram
		  Return CreateFromPath(Beacon.UnknownBlueprintPath("Engrams", ClassString))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromEntryString(EntryString As String) As Beacon.Engram
		  Var Base As String = EntryString
		  If Base.BeginsWith("EngramEntry_") Then
		    Base = Base.Middle(12)
		  End If
		  
		  Var Engram As Beacon.Engram = CreateFromPath(Beacon.UnknownBlueprintPath("Engrams", "PrimalItemMystery_" + Base + "_C"))
		  Engram.mEngramEntryString = EntryString
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromObjectID(ObjectID As v4UUID) As Beacon.Engram
		  Var ObjectIDString As String = ObjectID.StringValue
		  Var Engram As Beacon.Engram = CreateFromPath(Beacon.UnknownBlueprintPath("Engrams", "PrimalItemMystery_" + ObjectIDString + "_C"))
		  Engram.mLabel = ObjectIDString
		  Engram.mObjectID = ObjectID
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromPath(Path As String) As Beacon.Engram
		  Var Engram As New Beacon.Engram
		  If Path.Length > 6 And Path.Left(6) = "/Game/" Then
		    If Path.Right(2) = "_C" Then
		      // Appears to be a BlueprintGeneratedClass Path
		      Path = Path.Left(Path.Length - 2)
		    End If
		    Engram.mIsValid = True
		  End If
		  Engram.mModID = LocalData.UserModID
		  Engram.mModName = LocalData.UserModName
		  Engram.mPath = Path
		  Engram.mObjectID = v4UUID.FromHash(Crypto.HashAlgorithms.MD5, Path.Lowercase)
		  Engram.mTags.AddRow("blueprintable")
		  Return Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EntryString() As String
		  Return Self.mEngramEntryString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Shared Function FromDictionary(Dict As Dictionary) As Beacon.Engram
		  If Dict.HasKey("Category") = False Or Dict.Value("Category") <> Beacon.CategoryEngrams Then
		    Return Nil
		  End If
		  
		  If Not Dict.HasAllKeys("UUID", "Label", "Path", "Availability", "Tags", "ModID", "ModName") Then
		    Return Nil
		  End If
		  
		  Var Engram As New Beacon.MutableEngram(Dict.Value("Path").StringValue, Dict.Value("UUID").StringValue)
		  Engram.Label = Dict.Value("Label").StringValue
		  Engram.Availability = Dict.Value("Availability").UInt64Value
		  Engram.Tags = Dict.Value("Tags")
		  Engram.ModID = Dict.Value("ModID").StringValue
		  Engram.ModName = Dict.Value("ModName").StringValue
		  Return New Beacon.Engram(Engram)
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
		Function ImmutableVersion() As Beacon.Engram
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  Return Self.mIsValid
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemID() As NullableDouble
		  Return Self.mItemID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mLabel = "" Then
		    Self.mLabel = Beacon.LabelFromClassString(Self.ClassString)
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As v4UUID
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  If IsNull(Self.mModID) = False And Self.mModID <> LocalData.UserModID Then
		    Return Self.mModName
		  End If
		  
		  If Not Self.IsValid Or Self.mPath.Length < 6 Or Self.mPath.Left(6) <> "/Game/" Then
		    Return ""
		  End If
		  
		  Var Idx As Integer = Self.mPath.IndexOf(6, "/")
		  If Idx = -1 Then
		    Return "Unknown"
		  End If
		  Var Name As String = Self.mPath.Middle(6, Idx - 6)
		  Select Case Name
		  Case "PrimalEarth"
		    Return "Ark Prime"
		  Case "ScorchedEarth"
		    Return "Scorched Earth"
		  Case "Mods"
		    Var StartAt As Integer = Idx + 1
		    Var EndAt As Integer = Self.mPath.IndexOf(StartAt, "/")
		    If EndAt = -1 Then
		      EndAt = Self.mPath.Length
		    End If
		    Return Beacon.MakeHumanReadable(Self.mPath.Middle(StartAt, EndAt - StartAt))
		  Else
		    Return Beacon.MakeHumanReadable(Name)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Beacon.MutableEngram
		  Return New Beacon.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableEngram
		  Return New Beacon.MutableEngram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As v4UUID
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Engram) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Var SelfPath As String = If(Self.IsValid, Self.Path, Self.ClassString)
		  Var OtherPath As String = If(Other.IsValid, Other.Path, Other.ClassString)
		  Return SelfPath.Compare(OtherPath, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary)
		  If Self.HasUnlockDetails Then
		    Dict.Value("entry_string") = Self.mEngramEntryString
		    If Self.mItemID Is Nil Then
		      Dict.Value("item_id") = Nil
		    Else
		      Dict.Value("item_id") = Self.mItemID.IntegerValue
		    End If
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
		    For Each Ingredient As Beacon.RecipeIngredient In Self.mIngredients
		      Ingredients.AddRow(Ingredient.ToDictionary)
		    Next
		    Dict.Value("recipe") = Ingredients
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  If Self.IsValid Then
		    Return Self.mPath
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Recipe() As Beacon.RecipeIngredient()
		  // To prevent recursion, engrams only load ingredients on demand
		  If Self.mHasLoadedIngredients = False Then
		    Self.mIngredients = Beacon.Data.LoadIngredientsForEngram(Self)
		    Self.mHasLoadedIngredients = True
		  End If
		  
		  Var Ingredients() As Beacon.RecipeIngredient
		  For Each Ingredient As Beacon.RecipeIngredient In Self.mIngredients
		    Ingredients.AddRow(Ingredient)
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
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastRowIndex)
		  For I As Integer = 0 To Self.mTags.LastRowIndex
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
		Protected mEngramEntryString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHasLoadedIngredients As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIngredients() As Beacon.RecipeIngredient
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
		Protected mModID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mObjectID As v4UUID
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
