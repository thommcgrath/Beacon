#tag Class
Protected Class BlueprintAttributeManager
	#tag Method, Flags = &h0
		Function AttributesForBlueprint(Blueprint As Ark.Blueprint) As String()
		  Return Self.AttributesForBlueprint(Blueprint.BlueprintId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AttributesForBlueprint(Reference As Ark.BlueprintReference) As String()
		  Return Self.AttributesForBlueprint(Reference.BlueprintId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AttributesForBlueprint(BlueprintId As String) As String()
		  Var Arr() As String
		  If Self.mAttributes.HasKey(BlueprintId) = False Then
		    Return Arr
		  End If
		  
		  Var Dict As Dictionary = Self.mAttributes.Value(BlueprintId)
		  For Each Entry As DictionaryEntry In Dict
		    Arr.Add(Entry.Key.StringValue)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintIds() As String()
		  Var Arr() As String
		  For Each Entry As DictionaryEntry In Self.mReferences
		    Arr.Add(Entry.Key)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.BlueprintAttributeManager
		  Return New Ark.BlueprintAttributeManager(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAttributes = New Dictionary
		  Self.mReferences = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.BlueprintAttributeManager)
		  // The referenced dictionary does not need to create new reference objects
		  // because they are immutable. A new dictionary is required though. Be aware
		  // however that objects inside the attribute values will not be cloned.
		  
		  Self.Constructor()
		  
		  Var References() As Ark.BlueprintReference = Source.References
		  For Each Reference As Ark.BlueprintReference In References
		    Var AttrList() As String = Source.AttributesForBlueprint(Reference)
		    For Each Attr As String In AttrList
		      Var Value As Variant = Source.Value(Reference, Attr)
		      If Value IsA Ark.BlueprintAttributeManager Then
		        Self.Value(Reference, Attr) = Ark.BlueprintAttributeManager(Value).Clone
		      Else
		        Self.Value(Reference, Attr) = Value
		      End If
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mAttributes.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function EncodeValue(InputValue As Variant) As Variant
		  If InputValue.IsNull Then
		    Return InputValue
		  End If
		  
		  If InputValue IsA Ark.Blueprint Then
		    Return New Ark.BlueprintReference(Ark.Blueprint(InputValue))
		  End If
		  
		  If InputValue IsA Dictionary Then
		    Var Dict As Dictionary = Dictionary(InputValue)
		    Var Replacement As New Dictionary
		    For Each Entry As DictionaryEntry In Dict
		      Replacement.Value(Entry.Key) = EncodeValue(Entry.Value)
		    Next
		    Return Replacement
		  End If
		  
		  Return InputValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Variant, AlreadyValidated As Boolean = False) As Ark.BlueprintAttributeManager
		  If AlreadyValidated = False And IsSaveData(SaveData) = False Then
		    Return Nil
		  End If
		  
		  Var SaveDict As Dictionary = SaveData
		  Var AttrArray As Variant = SaveDict.Value("Attributes")
		  
		  Var Manager As New Ark.BlueprintAttributeManager
		  Var Members() As Dictionary
		  Var Info As Introspection.TypeInfo = Introspection.GetType(AttrArray)
		  Select Case Info.FullName
		  Case "Object()"
		    Var Temp() As Variant = AttrArray
		    Var Bound As Integer = Temp.LastIndex
		    For Idx As Integer = 0 To Bound
		      If Temp(Idx) IsA Dictionary Then
		        Members.Add(Dictionary(Temp(Idx)))
		      End If
		    Next
		  Case "Dictionary()"
		    Members = AttrArray
		  End Select
		  
		  For Each Dict As Dictionary In Members
		    Try
		      Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(Dict.Value("Blueprint"))
		      If Reference Is Nil Then
		        Continue
		      End If
		      
		      Var Attr As New Dictionary
		      For Each Entry As DictionaryEntry In Dict
		        If Entry.Key = "Blueprint" Then
		          Continue
		        End If
		        
		        Var Value As Variant = Entry.Value
		        If Ark.BlueprintAttributeManager.IsSaveData(Value) Then
		          Attr.Value(Entry.Key) = Ark.BlueprintAttributeManager.FromSaveData(Value, True)
		        ElseIf Ark.BlueprintReference.IsSaveData(Value) Then
		          Attr.Value(Entry.Key) = Ark.BlueprintReference.FromSaveData(Value, True)
		        Else
		          Attr.Value(Entry.Key) = Entry.Value
		        End If
		      Next
		      
		      Call Reference.Resolve // Get the correct UUID from the reference
		      Var BlueprintId As String = Reference.BlueprintId
		      Manager.mReferences.Value(BlueprintId) = Reference
		      Manager.mAttributes.Value(BlueprintId) = Attr
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Return Manager
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAttribute(Blueprint As Ark.Blueprint, Key As String) As Boolean
		  If Blueprint Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasAttribute(Blueprint.BlueprintId, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAttribute(Reference As Ark.BlueprintReference, Key As String) As Boolean
		  If Reference Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasAttribute(Reference.BlueprintId, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAttribute(BlueprintId As String, Key As String) As Boolean
		  Return Self.mAttributes.HasKey(BlueprintId) And Dictionary(Self.mAttributes.Value(BlueprintId)).HasKey(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBlueprint(Blueprint As Ark.Blueprint) As Boolean
		  If Blueprint Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasBlueprint(Blueprint.BlueprintId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBlueprint(Reference As Ark.BlueprintReference) As Boolean
		  If Reference Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasBlueprint(Reference.BlueprintId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBlueprint(BlueprintId As String) As Boolean
		  Return Self.mReferences.HasKey(BlueprintId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsSaveData(Value As Variant) As Boolean
		  If Value.IsNull Or Value.IsArray Or (Value IsA Dictionary) = False Then
		    Return False
		  End If
		  
		  Var Dict As Dictionary = Value
		  If Dict.HasKey("Version") = False Or Dict.HasKey("Schema") = False Then
		    Return False
		  End If
		  
		  Var SchemaValue As Variant = Dict.Value("Schema")
		  If SchemaValue.IsNull Or SchemaValue.Type <> Variant.TypeString Or (SchemaValue.StringValue <> "Ark.BlueprintAttributeManager" And SchemaValue.StringValue <> "Beacon.BlueprintAttributeManager") Then
		    Return False
		  End If
		  
		  Var VersionValue As Variant = Dict.Value("Version")
		  If VersionValue.IsNull Or VersionValue.IsNumeric = False Or VersionValue.IntegerValue > Ark.BlueprintAttributeManager.Version Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "BlueprintsIds" )  Function ObjectIDs() As String()
		  Return Self.BlueprintIds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reference(BlueprintId As String) As Ark.BlueprintReference
		  If Self.mReferences.HasKey(BlueprintId) Then
		    Return Self.mReferences.Value(BlueprintId)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function References() As Ark.BlueprintReference()
		  Var Arr() As Ark.BlueprintReference
		  For Each Entry As DictionaryEntry In Self.mReferences
		    Arr.Add(Entry.Value)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Blueprint As Ark.Blueprint)
		  If (Blueprint Is Nil) = False Then
		    Self.Remove(Blueprint.BlueprintId)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Blueprint As Ark.Blueprint, Key As String)
		  If (Blueprint Is Nil) = False Then
		    Self.Remove(Blueprint.BlueprintId, Key)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Reference As Ark.BlueprintReference)
		  If (Reference Is Nil) = False Then
		    Self.Remove(Reference.BlueprintId)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Reference As Ark.BlueprintReference, Key As String)
		  If (Reference Is Nil) = False Then
		    Self.Remove(Reference.BlueprintId, Key)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(BlueprintId As String)
		  If Self.mAttributes.HasKey(BlueprintId) Then
		    Self.mAttributes.Remove(BlueprintId)
		  End If
		  
		  If Self.mReferences.HasKey(BlueprintId) Then
		    Self.mReferences.Remove(BlueprintId)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(BlueprintId As String, Key As String)
		  If Self.mAttributes.HasKey(BlueprintId) = False Then
		    Return
		  End If
		  
		  Var Attr As Dictionary = Self.mAttributes.Value(BlueprintId)
		  If Attr.HasKey(Key) Then
		    Attr.Remove(Key)
		    If Attr.KeyCount = 0 Then
		      Self.mAttributes.Remove(BlueprintId)
		      Self.mReferences.Remove(BlueprintId)
		    Else
		      Self.mAttributes.Value(BlueprintId) = Attr
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dicts() As Dictionary
		  
		  For Each Entry As DictionaryEntry In Self.mAttributes
		    Var BlueprintId As String = Entry.Key
		    Var ObjectValues As Dictionary = Entry.Value
		    Var ObjectRef As Ark.BlueprintReference = Self.mReferences.Value(BlueprintId)
		    
		    Var Dict As New Dictionary
		    Dict.Value("Blueprint") = ObjectRef.SaveData
		    For Each ValueEntry As DictionaryEntry In ObjectValues
		      Var Value As Variant = ValueEntry.Value
		      If Value IsA Ark.BlueprintAttributeManager Then
		        Dict.Value(ValueEntry.Key) = Ark.BlueprintAttributeManager(Value).SaveData
		      ElseIf Value IsA Ark.BlueprintReference Then
		        Dict.Value(ValueEntry.Key) = Ark.BlueprintReference(Value).SaveData
		      Else
		        Dict.Value(ValueEntry.Key) = Value
		      End If
		    Next
		    
		    Dicts.Add(Dict)
		  Next
		  
		  Var Schema As New Dictionary
		  Schema.Value("Schema") = "Ark.BlueprintAttributeManager"
		  Schema.Value("Version") = Self.Version
		  Schema.Value("Attributes") = Dicts
		  Return Schema
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Blueprint As Ark.Blueprint, Key As String) As Variant
		  Return Self.Value(Blueprint.BlueprintId, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Blueprint As Ark.Blueprint, Key As String, Assigns NewValue As Variant)
		  If Self.mReferences.HasKey(Blueprint.BlueprintId) = False Then
		    Self.mReferences.Value(Blueprint.BlueprintId) = New Ark.BlueprintReference(Blueprint)
		  End If
		  
		  Self.Value(Blueprint.BlueprintId, Key) = NewValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Reference As Ark.BlueprintReference, Key As String) As Variant
		  Return Self.Value(Reference.BlueprintId, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Reference As Ark.BlueprintReference, Key As String, Assigns NewValue As Variant)
		  If Self.mReferences.HasKey(Reference.BlueprintId) = False Then
		    Self.mReferences.Value(Reference.BlueprintId) = Reference
		  End If
		  
		  Self.Value(Reference.BlueprintId, Key) = NewValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(BlueprintId As String, Key As String) As Variant
		  Var Dict As Dictionary
		  If Self.mAttributes.HasKey(BlueprintId) Then
		    Dict = Self.mAttributes.Value(BlueprintId)
		  Else
		    Dict = New Dictionary
		  End If
		  
		  If Dict.HasKey(Key) Then
		    Return Dict.Value(Key)
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(BlueprintId As String, Key As String, Assigns NewValue As Variant)
		  Var Dict As Dictionary
		  If Self.mAttributes.HasKey(BlueprintId) Then
		    Dict = Self.mAttributes.Value(BlueprintId)
		  Else
		    Dict = New Dictionary
		  End If
		  
		  Dict.Value(Key) = Self.EncodeValue(NewValue)
		  Self.mAttributes.Value(BlueprintId) = Dict
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAttributes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReferences As Dictionary
	#tag EndProperty


	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"1", Scope = Private
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
