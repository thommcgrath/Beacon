#tag Class
Protected Class CraftingCostIngredient
	#tag Method, Flags = &h0
		Function ClassString() As String
		  Var ClassString As String = Self.mEngramRef.ClassString
		  If ClassString.IsEmpty Then
		    Call Self.mEngramRef.Resolve
		    ClassString = Self.mEngramRef.ClassString
		  End If
		  Return ClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Reference As Ark.BlueprintReference, Quantity As Double, RequireExact As Boolean)
		  If Reference Is Nil Or Reference.IsEngram = False Or Quantity < 0 Then
		    Var Err As New RuntimeException
		    Err.Message = "Invalid engram or quantity"
		    Raise Err
		  End If
		  
		  Self.mEngramRef = Reference
		  Self.mQuantity = Quantity
		  Self.mRequireExact = RequireExact
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engram As Ark.Engram, Quantity As Double, RequireExact As Boolean)
		  Self.Constructor(New Ark.BlueprintReference(Engram.ImmutableVersion), Quantity, RequireExact)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Ark.Engram
		  Return Ark.Engram(Self.mEngramRef.Resolve).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As JSONItem, ContentPacks As Beacon.StringList) As Ark.CraftingCostIngredient
		  #Pragma Unused ContentPacks
		  
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  Try
		    Var BlueprintId As String = Dict.FirstValue("", "engramId", "object_id", "EngramID")
		    Var BlueprintPath As String = Dict.FirstValue("", "path", "Path")
		    Var BlueprintClass As String = Dict.FirstValue("", "class", "Class")
		    Var Blueprint As JSONItem = Dict.FirstValue(Nil, "blueprint", "Blueprint", "engram", "Engram")
		    Var Quantity As Double = Dict.FirstValue(0.0, "quantity", "Quantity")
		    Var Exact As Boolean = Dict.FirstValue(False, "exact", "Exact")
		    
		    Var Reference As Ark.BlueprintReference
		    If (Blueprint Is Nil) = False Then
		      Reference = Ark.BlueprintReference.FromSaveData(Blueprint)
		    End If
		    If Reference Is Nil Then
		      If BlueprintId.IsEmpty = False Or BlueprintPath.IsEmpty = False Or BlueprintClass.IsEmpty = False Then
		        Reference = New Ark.BlueprintReference(Ark.BlueprintReference.KindEngram, BlueprintId, BlueprintPath, BlueprintClass, "", "")
		      Else
		        Return Nil
		      End If
		    End If
		    
		    Return New Ark.CraftingCostIngredient(Reference, Quantity, Exact)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Loading crafting cost ingredient")
		    Return Nil
		  End Try
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromVariant(Value As Variant, ContentPacks As Beacon.StringList) As Ark.CraftingCostIngredient()
		  Var Ingredients() As Ark.CraftingCostIngredient
		  Var Source As JSONItem
		  
		  If Value.Type = Variant.TypeString Then
		    Try
		      Source = New JSONItem(Value.StringValue)
		    Catch Err As RuntimeException
		    End Try
		  ElseIf Value.Type = Variant.TypeObject And Value.ObjectValue IsA JSONItem Then
		    Source = JSONItem(Value.ObjectValue)
		  End If
		  
		  If Source Is Nil Then
		    Return Ingredients
		  End If
		  
		  If Source.IsArray Then
		    For Idx As Integer = 0 To Source.LastRowIndex
		      Var Ingredient As Ark.CraftingCostIngredient = Ark.CraftingCostIngredient.FromSaveData(Source.ChildAt(Idx), ContentPacks)
		      If (Ingredient Is Nil) = False Then
		        Ingredients.Add(Ingredient)
		      End If
		    Next
		    Return Ingredients
		  End If
		  
		  Var Ingredient As Ark.CraftingCostIngredient = Ark.CraftingCostIngredient.FromSaveData(Source, ContentPacks)
		  If (Ingredient Is Nil) = False Then
		    Ingredients.Add(Ingredient)
		  End If
		  Return Ingredients
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.CraftingCostIngredient) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyKey As String = Self.mEngramRef.BlueprintId + ":" + Self.mQuantity.PrettyText + ":" + If(Self.mRequireExact, "True", "False")
		  Var OtherKey As String = Other.mEngramRef.BlueprintId + ":" + Other.mQuantity.PrettyText + ":" + If(Other.mRequireExact, "True", "False")
		  
		  Return MyKey.Compare(OtherKey, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Quantity() As Double
		  Return Self.mQuantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reference() As Ark.BlueprintReference
		  Return Self.mEngramRef
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequireExact() As Boolean
		  Return Self.mRequireExact
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(ForAPI As Boolean) As Dictionary
		  Var Dict As New Dictionary
		  If ForAPI Then
		    Dict.Value("engramId") = Self.mEngramRef.BlueprintId
		  Else
		    Dict.Value("engram") = Self.mEngramRef.SaveData
		  End If
		  Dict.Value("quantity") = Self.mQuantity
		  Dict.Value("exact") = Self.mRequireExact
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ToJSON(Ingredients() As Ark.CraftingCostIngredient, Pretty As Boolean = False) As String
		  Var Dicts As New JSONItem
		  For Each Ingredient As Ark.CraftingCostIngredient In Ingredients
		    Dicts.Add(Ingredient.SaveData(False))
		  Next
		  Return Dicts.ToString(Pretty)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngramRef As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQuantity As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequireExact As Boolean
	#tag EndProperty


	#tag Constant, Name = ClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.craftingingredient", Scope = Public
	#tag EndConstant


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
