#tag Class
Protected Class BlueprintAttributeManager
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAttributes = New Dictionary
		  Self.mReferences = New Dictionary
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
		  
		  If InputValue IsA Beacon.Blueprint Then
		    Return New Beacon.BlueprintReference(Beacon.Blueprint(InputValue))
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
		Shared Function FromSaveData(SaveData As Variant) As Beacon.BlueprintAttributeManager
		  If SaveData.IsNull Then
		    Return Nil
		  End If
		  
		  Var Manager As New Beacon.BlueprintAttributeManager
		  Var Members() As Variant
		  Try
		    Members = SaveData
		  Catch Err As RuntimeException
		  End Try
		  
		  Var Bound As Integer = Members.LastIndex
		  For Idx As Integer = 0 To Bound
		    Try
		      Var Dict As Dictionary = Members(Idx)
		      Var Reference As Beacon.BlueprintReference = Beacon.BlueprintReference.FromSaveData(Dict.Value("Blueprint"))
		      If Reference Is Nil Then
		        Continue
		      End If
		      
		      Var Attr As New Dictionary
		      For Each Entry As DictionaryEntry In Dict
		        If Entry.Key = "Blueprint" Then
		          Continue
		        End If
		        
		        Attr.Value(Entry.Key) = Entry.Value
		      Next
		      
		      Var ObjectID As String = Reference.ObjectID
		      Manager.mReferences.Value(ObjectID) = Reference
		      Manager.mAttributes.Value(ObjectID) = Attr
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Return Manager
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAttribute(Blueprint As Beacon.Blueprint, Key As String) As Boolean
		  If Blueprint Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasAttribute(Blueprint.ObjectID, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAttribute(Reference As Beacon.BlueprintReference, Key As String) As Boolean
		  If Reference Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasAttribute(Reference.ObjectID, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAttribute(ObjectID As String, Key As String) As Boolean
		  Return Self.mAttributes.HasKey(ObjectID) And Dictionary(Self.mAttributes.Value(ObjectID)).HasKey(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBlueprint(Blueprint As Beacon.Blueprint) As Boolean
		  If Blueprint Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasBlueprint(Blueprint.ObjectID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBlueprint(Reference As Beacon.BlueprintReference) As Boolean
		  If Reference Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasBlueprint(Reference.ObjectID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBlueprint(ObjectID As String) As Boolean
		  Return Self.mReferences.HasKey(ObjectID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectIDs() As String()
		  Var Arr() As String
		  For Each Entry As DictionaryEntry In Self.mReferences
		    Arr.Add(Entry.Key)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reference(ObjectID As String) As Beacon.BlueprintReference
		  If Self.mReferences.HasKey(ObjectID) Then
		    Return Self.mReferences.Value(ObjectID)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function References() As Beacon.BlueprintReference()
		  Var Arr() As Beacon.BlueprintReference
		  For Each Entry As DictionaryEntry In Self.mReferences
		    Arr.Add(Entry.Value)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Blueprint As Beacon.Blueprint)
		  If (Blueprint Is Nil) = False Then
		    Self.Remove(Blueprint.ObjectID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Blueprint As Beacon.Blueprint, Key As String)
		  If (Blueprint Is Nil) = False Then
		    Self.Remove(Blueprint.ObjectID, Key)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Reference As Beacon.BlueprintReference)
		  If (Reference Is Nil) = False Then
		    Self.Remove(Reference.ObjectID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Reference As Beacon.BlueprintReference, Key As String)
		  If (Reference Is Nil) = False Then
		    Self.Remove(Reference.ObjectID, Key)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ObjectID As String)
		  If Self.mAttributes.HasKey(ObjectID) Then
		    Self.mAttributes.Remove(ObjectID)
		  End If
		  
		  If Self.mReferences.HasKey(ObjectID) Then
		    Self.mReferences.Remove(ObjectID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ObjectID As String, Key As String)
		  If Self.mAttributes.HasKey(ObjectID) = False Then
		    Return
		  End If
		  
		  Var Attr As Dictionary = Self.mAttributes.Value(ObjectID)
		  If Attr.HasKey(Key) Then
		    Attr.Remove(Key)
		    Self.mAttributes.Value(ObjectID) = Attr
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Variant
		  Var Dicts() As Dictionary
		  
		  For Each Entry As DictionaryEntry In Self.mAttributes
		    Var ObjectID As String = Entry.Key
		    Var ObjectValues As Dictionary = Entry.Value
		    Var ObjectRef As Beacon.BlueprintReference = Self.mReferences.Value(ObjectID)
		    
		    Var Dict As New Dictionary
		    Dict.Value("Blueprint") = ObjectRef.SaveData
		    For Each ValueEntry As DictionaryEntry In ObjectValues
		      Dict.Value(ValueEntry.Key) = ValueEntry.Value
		    Next
		    
		    Dicts.Add(Dict)
		  Next
		  
		  Return Dicts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Blueprint As Beacon.Blueprint, Key As String) As Variant
		  Return Self.Value(Blueprint.ObjectID, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Blueprint As Beacon.Blueprint, Key As String, Assigns NewValue As Variant)
		  If Self.mReferences.HasKey(Blueprint.ObjectID) = False Then
		    Self.mReferences.Value(Blueprint.ObjectID) = New Beacon.BlueprintReference(Blueprint)
		  End If
		  
		  Self.Value(Blueprint.ObjectID, Key) = NewValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Reference As Beacon.BlueprintReference, Key As String) As Variant
		  Return Self.Value(Reference.ObjectID, Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Reference As Beacon.BlueprintReference, Key As String, Assigns NewValue As Variant)
		  If Self.mReferences.HasKey(Reference.ObjectID) = False Then
		    Self.mReferences.Value(Reference.ObjectID) = Reference
		  End If
		  
		  Self.Value(Reference.ObjectID, Key) = NewValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(ObjectID As String, Key As String) As Variant
		  Var Dict As Dictionary
		  If Self.mAttributes.HasKey(ObjectID) Then
		    Dict = Self.mAttributes.Value(ObjectID)
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
		Sub Value(ObjectID As String, Key As String, Assigns NewValue As Variant)
		  Var Dict As Dictionary
		  If Self.mAttributes.HasKey(ObjectID) Then
		    Dict = Self.mAttributes.Value(ObjectID)
		  Else
		    Dict = New Dictionary
		  End If
		  
		  Dict.Value(Key) = Self.EncodeValue(NewValue)
		  Self.mAttributes.Value(ObjectID) = Dict
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAttributes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReferences As Dictionary
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
		#tag ViewProperty
			Name="mAttributes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
