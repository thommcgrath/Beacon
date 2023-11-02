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
		Sub Constructor(Reference As ArkSA.BlueprintReference, Quantity As Double, RequireExact As Boolean)
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
		Sub Constructor(Engram As ArkSA.Engram, Quantity As Double, RequireExact As Boolean)
		  Self.Constructor(New ArkSA.BlueprintReference(Engram.ImmutableVersion), Quantity, RequireExact)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As ArkSA.Engram
		  Return ArkSA.Engram(Self.mEngramRef.Resolve).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary, ContentPacks As Beacon.StringList) As ArkSA.CraftingCostIngredient
		  #Pragma Unused ContentPacks
		  
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  Try
		    Var BlueprintId As String = Dict.FirstValue("engramId", "object_id", "EngramID", "")
		    Var BlueprintPath As String = Dict.FirstValue("path", "Path", "")
		    Var BlueprintClass As String = Dict.FirstValue("class", "Class", "")
		    Var Blueprint As Dictionary = Dict.FirstValue("blueprint", "Blueprint", "engram", "Engram", Nil)
		    Var Quantity As Double = Dict.FirstValue("quantity", "Quantity", 0.0)
		    Var Exact As Boolean = Dict.FirstValue("exact", "Exact", False)
		    
		    Var Reference As ArkSA.BlueprintReference
		    If (Blueprint Is Nil) = False Then
		      Reference = ArkSA.BlueprintReference.FromSaveData(Blueprint)
		    End If
		    If Reference Is Nil Then
		      If BlueprintId.IsEmpty = False Or BlueprintPath.IsEmpty = False Or BlueprintClass.IsEmpty = False Then
		        Reference = New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindEngram, BlueprintId, BlueprintPath, BlueprintClass, "", "")
		      Else
		        Return Nil
		      End If
		    End If
		    
		    Return New ArkSA.CraftingCostIngredient(Reference, Quantity, Exact)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Loading crafting cost ingredient")
		    Return Nil
		  End Try
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromVariant(Value As Variant, ContentPacks As Beacon.StringList) As ArkSA.CraftingCostIngredient()
		  Var Ingredients() As ArkSA.CraftingCostIngredient
		  
		  If IsNull(Value) Then
		    Return Ingredients
		  End If
		  
		  If Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		    // It's just a dictionary
		    Var Ingredient As ArkSA.CraftingCostIngredient = ArkSA.CraftingCostIngredient.FromDictionary(Value, ContentPacks)
		    If (Ingredient Is Nil) = False Then
		      Ingredients.Add(Ingredient)
		    End If
		  ElseIf Value.Type = Variant.TypeString Then
		    // Treat it as JSON
		    Try
		      Var Parsed() As Variant = Beacon.ParseJSON(Value.StringValue)
		      For Each Dict As Dictionary In Parsed
		        Var Ingredient As ArkSA.CraftingCostIngredient = ArkSA.CraftingCostIngredient.FromDictionary(Dict, ContentPacks)
		        If (Ingredient Is Nil) = False Then
		          Ingredients.Add(Ingredient)
		        End If
		      Next
		    Catch Err As RuntimeException
		    End Try
		  ElseIf Value.IsArray And Value.ArrayElementType = Variant.TypeObject Then
		    // Array of dictionaries
		    Var Dicts() As Dictionary
		    Try
		      #Pragma BreakOnExceptions False
		      Dicts = Value
		      #Pragma BreakOnExceptions Default
		    Catch Err As RuntimeException
		      Var Values() As Variant = Value
		      For Each Obj As Variant In Values
		        If Obj IsA Dictionary Then
		          Dicts.Add(Dictionary(Obj))
		        End If
		      Next
		    End Try
		    
		    For Each Dict As Dictionary In Dicts
		      Try
		        Var Ingredient As ArkSA.CraftingCostIngredient = ArkSA.CraftingCostIngredient.FromDictionary(Dict, ContentPacks)
		        If (Ingredient Is Nil) = False Then
		          Ingredients.Add(Ingredient)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  
		  Return Ingredients
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.CraftingCostIngredient) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyKey As String = Self.mEngramRef.BlueprintId + ":" + Self.mQuantity.PrettyText + ":" + If(Self.mRequireExact, "True", "False")
		  Var OtherKey As String = Other.mEngramRef.BlueprintId + ":" + Other.mQuantity.PrettyText + ":" + If(Other.mRequireExact, "True", "False")
		  
		  Return MyKey.Compare(OtherKey, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pack() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("engramId") = Self.mEngramRef.BlueprintId
		  Dict.Value("quantity") = Self.mQuantity
		  Dict.Value("exact") = Self.mRequireExact
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Quantity() As Double
		  Return Self.mQuantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reference() As ArkSA.BlueprintReference
		  Return Self.mEngramRef
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequireExact() As Boolean
		  Return Self.mRequireExact
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("engram") = Self.mEngramRef.SaveData
		  Dict.Value("quantity") = Self.mQuantity
		  Dict.Value("exact") = Self.mRequireExact
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ToJSON(Ingredients() As ArkSA.CraftingCostIngredient, Pretty As Boolean = False) As String
		  Var Dicts() As Dictionary
		  For Each Ingredient As ArkSA.CraftingCostIngredient In Ingredients
		    Dicts.Add(Ingredient.Pack)
		  Next
		  Return Beacon.GenerateJSON(Dicts, Pretty)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngramRef As ArkSA.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQuantity As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequireExact As Boolean
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
