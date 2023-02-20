#tag Class
Protected Class MutableCraftingCost
Inherits Ark.CraftingCost
	#tag Method, Flags = &h0
		Sub Add(Ingredient As Ark.CraftingCostIngredient)
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
		Sub Add(Resource As Ark.Engram, Quantity As Integer, RequireExact As Boolean)
		  If Resource Is Nil Then
		    Return
		  End If
		  
		  Self.Add(New Ark.CraftingCostIngredient(Resource, Quantity, RequireExact))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Engram(Assigns Value As Ark.Engram)
		  If Value Is Nil Or Value = Self.mEngram Then
		    Return
		  End If
		  
		  Self.mEngram = New Ark.BlueprintReference(Value.ImmutableVersion)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.CraftingCost
		  Return New Ark.CraftingCost(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Ingredient(AtIndex As Integer, Assigns Ingredient As Ark.CraftingCostIngredient)
		  If AtIndex < Self.mIngredients.FirstIndex Or AtIndex > Self.mIngredients.LastIndex Or Self.mIngredients(AtIndex) = Ingredient Then
		    Return
		  End If
		  
		  Self.mIngredients(AtIndex) = Ingredient
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableCraftingCost
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Ingredient As Ark.CraftingCostIngredient)
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
		Sub Remove(Resource As Ark.Engram)
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
