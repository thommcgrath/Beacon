#tag Class
Protected Class CraftingCost
Implements Beacon.NamedItem
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.mRecipeId = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Reference As Ark.BlueprintReference, LoadRecipe As Boolean = False)
		  If Reference Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "Reference is Nil"
		    Raise Err
		  End If
		  
		  Self.Constructor()
		  Self.mEngramRef = Reference
		  
		  If LoadRecipe Then
		    Var Ingredients() As Ark.CraftingCostIngredient = Engram.Recipe
		    Self.mIngredients.ResizeTo(Ingredients.LastIndex)
		    For Idx As Integer = 0 To Self.mIngredients.LastIndex
		      Self.mIngredients(Idx) = Ingredients(Idx)
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.CraftingCost)
		  If Source Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "Source is Nil"
		    Raise Err
		  End If
		  
		  Self.Constructor()
		  Self.mEngramRef = Source.mEngramRef
		  Self.mIngredients.ResizeTo(Source.mIngredients.LastIndex)
		  For Idx As Integer = 0 To Source.mIngredients.LastIndex
		    Self.mIngredients(Idx) = Source.mIngredients(Idx)
		  Next
		  Self.Modified = Source.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engram As Ark.Engram, LoadRecipe As Boolean = False)
		  If Engram Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "Engram is Nil"
		    Raise Err
		  End If
		  
		  Self.Constructor(New Ark.BlueprintReference(Engram.ImmutableVersion), LoadRecipe)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mIngredients.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Ark.Engram
		  Return Ark.Engram(Self.mEngramRef.Resolve)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramId() As String
		  // Alias for BlueprintId
		  Return Self.mEngramRef.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramReference() As Ark.BlueprintReference
		  Return Self.mEngramRef
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Var Ingredients() As Dictionary
		  For Idx As Integer = 0 To Self.mIngredients.LastIndex
		    Var Resource As Dictionary = Self.mIngredients(Idx).SaveData(False)
		    If (Resource Is Nil) = False Then
		      Ingredients.Add(Resource)
		    End If
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("engram") = Self.mEngramRef.SaveData
		  Dict.Value("ingredients") = Ingredients
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableClone() As Ark.CraftingCost
		  Return New Ark.CraftingCost(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.CraftingCost
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As JSONItem) As Ark.CraftingCost
		  Var ReferenceDict As JSONItem = Dict.FirstValue(Nil, "engram", "blueprint", "Blueprint")
		  Var Reference As Ark.BlueprintReference
		  If (ReferenceDict Is Nil) = False Then
		    Try
		      Reference = Ark.BlueprintReference.FromSaveData(ReferenceDict)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  If Reference Is Nil Then
		    Var BlueprintId As String = Dict.FirstValue("", "engramId", "EngramID", "Engram")
		    If BlueprintId.IsEmpty = False Then
		      If Beacon.UUID.Validate(BlueprintId) Then
		        Reference = New Ark.BlueprintReference(Ark.BlueprintReference.KindEngram, BlueprintId, "", "", "", "")
		      Else
		        Reference = New Ark.BlueprintReference(Ark.BlueprintReference.KindEngram, "", "", BlueprintId, "", "")
		      End If
		    Else
		      Return Nil
		    End If
		  End If
		  
		  Var Cost As New Ark.CraftingCost(Reference)
		  Var Ingredients As JSONItem = Dict.FirstValue(Nil, "ingredients", "Ingredients", "Resources")
		  If Ingredients Is Nil Or Ingredients.IsArray = False Then
		    Return Cost
		  End If
		  
		  For Each IngredientEntry As JSONEntry In Ingredients.Iterator
		    Var Ref As Ark.CraftingCostIngredient = Ark.CraftingCostIngredient.FromSaveData(JSONItem(IngredientEntry.Value), Nil)
		    If (Ref Is Nil) = False Then
		      Cost.mIngredients.Add(Ref)
		    End If
		  Next
		  
		  Return Cost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, ContentPacks As Beacon.StringList) As Ark.CraftingCost
		  Try
		    Var ClassString As String = Dict.Lookup("ItemClassString", "")
		    If ClassString.IsEmpty Then
		      Return Nil
		    End If
		    
		    Var Engram As Ark.Engram = Ark.ResolveEngram(Dict, "", "", "ItemClassString", ContentPacks)
		    Var Cost As New Ark.MutableCraftingCost(Engram)
		    If Dict.HasKey("BaseCraftingResourceRequirements") Then
		      Var Resources() As Variant = Dict.Value("BaseCraftingResourceRequirements")
		      For Each Resource As Dictionary In Resources
		        Var ResourceEngram As Ark.Engram = Ark.ResolveEngram(Resource, "", "", "ResourceItemTypeString", ContentPacks)
		        Var Quantity As Double = Resource.Lookup("BaseResourceRequirement", 1)
		        Var RequireExact As Boolean = Resource.Lookup("bCraftingRequireExactResourceType", False)
		        Cost.Add(ResourceEngram, Quantity, RequireExact)
		      Next
		    End If
		    
		    Cost.Modified = False
		    Return Cost
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Resource As Ark.Engram) As Integer
		  For Idx As Integer = 0 To Self.mIngredients.LastIndex
		    If Self.mIngredients(Idx).Engram = Resource Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Ingredient(AtIndex As Integer) As Ark.CraftingCostIngredient
		  If AtIndex < Self.mIngredients.FirstIndex Or AtIndex > Self.mIngredients.LastIndex Then
		    Return Nil
		  End If
		  
		  Return Self.mIngredients(AtIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mEngramRef.Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As Integer
		  Return Self.mIngredients.LastIndex
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
		Function MutableClone() As Ark.MutableCraftingCost
		  Return New Ark.MutableCraftingCost(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableCraftingCost
		  Return New Ark.MutableCraftingCost(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "RecipeId" )  Function ObjectId() As String
		  Return Self.mRecipeId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.CraftingCost) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mRecipeId = Other.mRecipeId Then
		    Return 0
		  End If
		  
		  Var MySortKey As String = Self.Label + ":" + Self.mRecipeId
		  Var OtherSortKey As String = Other.Label + ":" + Other.mRecipeId
		  
		  Return MySortKey.Compare(OtherSortKey, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Quantity(Idx As Integer) As Double
		  If Idx < Self.mIngredients.FirstRowIndex Or Idx > Self.mIngredients.LastIndex Then
		    Return 0
		  End If
		  
		  Return Self.mIngredients(Idx).Quantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RecipeId() As String
		  Return Self.mRecipeId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequireExactResource(Idx As Integer) As Boolean
		  If Idx < Self.mIngredients.FirstRowIndex Or Idx > Self.mIngredients.LastIndex Then
		    Return False
		  End If
		  
		  Return Self.mIngredients(Idx).RequireExact
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Resource(Idx As Integer) As Ark.Engram
		  If Idx < Self.mIngredients.FirstRowIndex Or Idx > Self.mIngredients.LastIndex Then
		    Return Nil
		  End If
		  
		  Return Self.mIngredients(Idx).Engram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  Var Components() As String
		  For Idx As Integer = 0 To Self.mIngredients.LastIndex
		    Var ClassString As String = Self.mIngredients(Idx).ClassString
		    Var QuantityString As String = Self.mIngredients(Idx).Quantity.PrettyText
		    Var RequireExactString As String = If(Self.mIngredients(Idx).RequireExact, "True", "False")
		    Components.Add("(ResourceItemTypeString=""" + ClassString + """,BaseResourceRequirement=" + QuantityString + ",bCraftingRequireExactResourceType=" + RequireExactString + ")")
		  Next
		  
		  Var Engram As Ark.Blueprint = Self.mEngramRef.Resolve
		  Var Pieces() As String
		  Pieces.Add("ItemClassString=""" + Engram.ClassString + """")
		  Pieces.Add("BaseCraftingResourceRequirements=(" + Components.Join(",") + ")")
		  Return "(" + Pieces.Join(",") + ")"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mEngramRef As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIngredients() As Ark.CraftingCostIngredient
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRecipeId As String
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
