#tag Class
Protected Class CraftingCost
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mObjectID = New v4UUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Reference As Ark.BlueprintReference, LoadRecipe As Boolean = False)
		  Self.Constructor()
		  Self.mEngram = Reference
		  
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
		  Self.Constructor()
		  Self.mEngram = Source.mEngram
		  Self.mIngredients.ResizeTo(Source.mIngredients.LastIndex)
		  For Idx As Integer = 0 To Source.mIngredients.LastIndex
		    Self.mIngredients(Idx) = Source.mIngredients(Idx)
		  Next
		  Self.Modified = Source.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engram As Ark.Engram, LoadRecipe As Boolean = False)
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
		  Return Ark.Engram(Self.mEngram.Resolve)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  If Self.mEngram Is Nil Then
		    Return Nil
		  End If
		  
		  Var Ingredients() As Dictionary
		  For Idx As Integer = 0 To Self.mIngredients.LastIndex
		    Var Resource As Dictionary = Self.mIngredients(Idx).SaveData
		    If (Resource Is Nil) = False Then
		      Ingredients.Add(Resource)
		    End If
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("Blueprint") = Self.mEngram.SaveData
		  Dict.Value("Ingredients") = Ingredients
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
		Shared Function ImportFromBeacon(Dict As Dictionary) As Ark.CraftingCost
		  Var Cost As Ark.CraftingCost
		  If Dict.HasKey("Blueprint") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(Dict.Value("Blueprint"))
		    If Reference Is Nil Then
		      Return Nil
		    End If
		    Cost = New Ark.CraftingCost(Reference)
		  ElseIf Dict.HasAnyKey("EngramID", "Engram") Then
		    Var Engram As Ark.Engram = Ark.ResolveEngram(Dict, "EngramID", "", "Engram", Nil)
		    If Engram Is Nil Then
		      Return Nil
		    End If
		    Cost = New Ark.CraftingCost(Engram)
		  End If
		  
		  If Dict.HasKey("Ingredients") Then
		    Var Ingredients() As Dictionary = Dict.Value("Ingredients").DictionaryArrayValue
		    For Each Ingredient As Dictionary In Ingredients
		      Var Ref As Ark.CraftingCostIngredient = Ark.CraftingCostIngredient.FromDictionary(Ingredient, Nil)
		      If (Ref Is Nil) = False Then
		        Cost.mIngredients.Add(Ref)
		      End If
		    Next
		  ElseIf Dict.HasKey("Resources") Then
		    Var Resources() As Dictionary = Dict.Value("Resources").DictionaryArrayValue
		    For Each Resource As Dictionary In Resources
		      Var Quantity As Integer = Resource.Lookup("Quantity", 1)
		      Var RequireExact As Boolean = Resource.Lookup("Exact", False)
		      
		      Cost.mIngredients.Add(New Ark.CraftingCostIngredient(Ark.ResolveEngram(Resource, "EngramID", "", "Class", Nil), Quantity, RequireExact))
		    Next
		  End If
		  
		  Return Cost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, ContentPacks As Beacon.StringList) As Ark.CraftingCost
		  Try
		    Var ClassString As String = Dict.Lookup("ItemClassString", "")
		    If ClassString = "" Then
		      Return Nil
		    End If
		    
		    Var Engram As Ark.Engram = Ark.ResolveEngram(Dict, "", "", "ItemClassString", ContentPacks)
		    Var Cost As New Ark.MutableCraftingCost(Engram)
		    If Dict.HasKey("BaseCraftingResourceRequirements") Then
		      Var Resources() As Variant = Dict.Value("BaseCraftingResourceRequirements")
		      For Each Resource As Dictionary In Resources
		        Var ResourceEngram As Ark.Engram = Ark.ResolveEngram(Resource, "", "", "ResourceItemTypeString", ContentPacks)
		        Var Quantity As Integer = Resource.Lookup("BaseResourceRequirement", 1)
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
		  If Self.mEngram Is Nil Then
		    Return ""
		  End If
		  
		  Return Self.Engram.Label
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
		Function ObjectID() As String
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.CraftingCost) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.mObjectID = Other.mObjectID Then
		    Return 0
		  End If
		  
		  // Uh... sort on the id I guess? How else would this be sorted?
		  Return Self.mObjectID.StringValue.Compare(Other.mObjectID.StringValue, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Quantity(Idx As Integer) As Integer
		  If Idx < Self.mIngredients.FirstRowIndex Or Idx > Self.mIngredients.LastIndex Then
		    Return 0
		  End If
		  
		  Return Self.mIngredients(Idx).Quantity
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
		    Var QuantityString As String = Self.mIngredients(Idx).Quantity.ToString(Locale.Raw, "0")
		    Var RequireExactString As String = If(Self.mIngredients(Idx).RequireExact, "True", "False")
		    Components.Add("(ResourceItemTypeString=""" + ClassString + """,BaseResourceRequirement=" + QuantityString + ",bCraftingRequireExactResourceType=" + RequireExactString + ")")
		  Next
		  
		  Var Pieces() As String
		  Pieces.Add("ItemClassString=""" + If((Self.mEngram Is Nil) = False, Self.mEngram.ClassString, "") + """")
		  Pieces.Add("BaseCraftingResourceRequirements=(" + Components.Join(",") + ")")
		  Return "(" + Pieces.Join(",") + ")"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mEngram As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIngredients() As Ark.CraftingCostIngredient
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObjectID As v4UUID
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
