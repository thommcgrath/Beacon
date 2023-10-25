#tag Class
Protected Class MutableCraftingCost
Inherits ArkSA.CraftingCost
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Add(Ingredient As ArkSA.CraftingCostIngredient)
		  If Ingredient Is Nil Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Ingredient.Engram)
		  If Idx > -1 Then
		    Self.mIngredients(Idx) = Ingredient
		  Else
		    Self.mIngredients.Add(Ingredient)
		  End If
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Resource As ArkSA.Engram, Quantity As Double, RequireExact As Boolean)
		  If Resource Is Nil Then
		    Return
		  End If
		  
		  Self.Add(New ArkSA.CraftingCostIngredient(Resource, Quantity, RequireExact))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Engram(Assigns Value As ArkSA.Engram)
		  If Value Is Nil Or Value = Self.mEngramRef Then
		    Return
		  End If
		  
		  Self.mEngramRef = New ArkSA.BlueprintReference(Value.ImmutableVersion)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.CraftingCost
		  Return New ArkSA.CraftingCost(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Ingredient(AtIndex As Integer, Assigns Ingredient As ArkSA.CraftingCostIngredient)
		  If AtIndex < Self.mIngredients.FirstIndex Or AtIndex > Self.mIngredients.LastIndex Or Self.mIngredients(AtIndex) = Ingredient Then
		    Return
		  End If
		  
		  Self.mIngredients(AtIndex) = Ingredient
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableCraftingCost
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Ingredient As ArkSA.CraftingCostIngredient)
		  If Ingredient Is Nil Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Ingredient.Engram)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Resource As ArkSA.Engram)
		  If Resource Is Nil Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Resource)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  If Idx >= Self.mIngredients.FirstIndex And Idx <= Self.mIngredients.LastIndex Then
		    Self.mIngredients.RemoveAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Simplify()
		  Var Map As New Dictionary
		  For Idx As Integer = Self.mIngredients.LastIndex DownTo 0
		    Var Ingredient As ArkSA.CraftingCostIngredient = Self.mIngredients(Idx)
		    Var Signature As String = Ingredient.Engram.BlueprintId + ":" + If(Ingredient.RequireExact, "True", "False")
		    If Map.HasKey(Signature) Then
		      Var OtherIngredient As ArkSA.CraftingCostIngredient = Map.Value(Signature)
		      Map.Value(Signature) = New ArkSA.CraftingCostIngredient(Ingredient.Engram, Ingredient.Quantity + OtherIngredient.Quantity, Ingredient.RequireExact)
		    Else
		      Map.Value(Signature) = Ingredient
		    End If
		  Next
		  
		  If Map.KeyCount = Self.mIngredients.Count Then
		    Return
		  End If
		  
		  Self.mIngredients.ResizeTo(-1)
		  For Each Entry As DictionaryEntry In Map
		    Self.Add(ArkSA.CraftingCostIngredient(Map.Value(Entry.Key)))
		  Next
		  Self.Modified = True
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
