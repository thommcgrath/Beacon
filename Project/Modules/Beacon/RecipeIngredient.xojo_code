#tag Class
Protected Class RecipeIngredient
	#tag Method, Flags = &h0
		Sub Constructor(Engram As Beacon.Engram, Quantity As Integer, RequireExact As Boolean)
		  If Engram Is Nil Or Quantity <= 0 Then
		    Var Err As New RuntimeException
		    Err.Message = "Invalid engram or quantity"
		    Raise Err
		  End If
		  
		  Self.mEngram = Engram.ImmutableVersion
		  Self.mQuantity = Quantity
		  Self.mRequireExact = RequireExact
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Beacon.Engram
		  Return Self.mEngram.ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.RecipeIngredient
		  If Dict Is Nil Or (Dict.HasKey("object_id") = False And Dict.HasKey("path") = False) Or Dict.HasKey("quantity") = False Or Dict.HasKey("exact") = False Then
		    Return Nil
		  End If
		  
		  Try
		    Var Engram As Beacon.Engram = Beacon.ResolveEngram(Dict, "object_id", "", "path")
		    Var Quantity As Integer = Dict.Value("quantity")
		    Var Exact As Boolean = Dict.Value("exact")
		    
		    Return New Beacon.RecipeIngredient(Engram, Quantity, Exact)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromVariant(Value As Variant) As Beacon.RecipeIngredient()
		  Var Ingredients() As Beacon.RecipeIngredient
		  
		  If IsNull(Value) Then
		    Return Ingredients
		  End If
		  
		  If Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		    // It's just a dictionary
		    Var Ingredient As Beacon.RecipeIngredient = Beacon.RecipeIngredient.FromDictionary(Value)
		    If (Ingredient Is Nil) = False Then
		      Ingredients.AddRow(Ingredient)
		    End If
		  ElseIf Value.Type = Variant.TypeString Then
		    // Treat it as JSON
		    Try
		      Var Parsed() As Variant = Beacon.ParseJSON(Value.StringValue)
		      For Each Dict As Dictionary In Parsed
		        Var Ingredient As Beacon.RecipeIngredient = Beacon.RecipeIngredient.FromDictionary(Dict)
		        If (Ingredient Is Nil) = False Then
		          Ingredients.AddRow(Ingredient)
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
		          Dicts.AddRow(Dictionary(Obj))
		        End If
		      Next
		    End Try
		    
		    For Each Dict As Dictionary In Dicts
		      Try
		        Var Ingredient As Beacon.RecipeIngredient = Beacon.RecipeIngredient.FromDictionary(Dict)
		        If (Ingredient Is Nil) = False Then
		          Ingredients.AddRow(Ingredient)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  
		  Return Ingredients
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Quantity() As Integer
		  Return Self.mQuantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequireExact() As Boolean
		  Return Self.mRequireExact
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("object_id") = Self.mEngram.ObjectID.StringValue
		  Dict.Value("path") = Self.mEngram.Path
		  Dict.Value("quantity") = Self.mQuantity
		  Dict.Value("exact") = Self.mRequireExact
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ToJSON(Ingredients() As Beacon.RecipeIngredient, Pretty As Boolean = False) As String
		  Var Dicts() As Dictionary
		  For Each Ingredient As Beacon.RecipeIngredient In Ingredients
		    Dicts.AddRow(Ingredient.ToDictionary)
		  Next
		  Return Beacon.GenerateJSON(Dicts, Pretty)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngram As Beacon.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQuantity As Integer
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
