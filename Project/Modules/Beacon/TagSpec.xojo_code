#tag Class
Protected Class TagSpec
	#tag Method, Flags = &h0
		Sub ClearTag(Tag As String)
		  If Self.mTags.HasKey(Tag) Then
		    Self.mTags.Remove(Tag)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mTags = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.TagSpec)
		  Self.mTags = Source.mTags.Clone
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RequiredTags() As String, ExcludedTags() As String)
		  Self.Constructor()
		  If (RequiredTags Is Nil) = False Then
		    For Each Tag As String In RequiredTags
		      Self.mTags.Value(Tag) = Self.StateRequired
		    Next
		  End If
		  If (ExcludedTags Is Nil) = False Then
		    For Each Tag As String In ExcludedTags
		      Self.mTags.Value(Tag) = Self.StateExcluded
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExcludedTags() As String()
		  Var Tags() As String
		  For Each Entry As DictionaryEntry In Self.mTags
		    If Entry.Value.IntegerValue <= Self.StateExcluded Then
		      Tags.Add(Entry.Key.StringValue)
		    End If
		  Next
		  Tags.Sort
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExcludeTag(Tag As String)
		  Self.mTags.Value(Tag) = Self.StateExcluded
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredTags() As String()
		  Var Tags() As String
		  For Each Entry As DictionaryEntry In Self.mTags
		    Tags.Add(Entry.Key.StringValue)
		  Next
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Fingerprint() As String
		  Var Required(), Excluded() As String
		  For Each Entry As DictionaryEntry In Self.mTags
		    If Entry.Value.IntegerValue >= Self.StateRequired Then
		      Required.Add(Entry.Key.StringValue.Lowercase)
		    ElseIf Entry.Value.IntegerValue <= Self.StateExcluded Then
		      Excluded.Add(Entry.Key.StringValue.Lowercase)
		    End If
		  Next
		  Required.Sort
		  Excluded.Sort
		  Return EncodeHex(Crypto.MD5("required:" + String.FromArray(Required, ",") + ";excluded:" + String.FromArray(Excluded, ","))) // Use hex because it is not case sensitive
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(Source As String) As Beacon.TagSpec
		  Try
		    Var SaveData As JSONItem = New JSONItem(Source)
		    Var Spec As New Beacon.TagSpec
		    Var Required As JSONItem = SaveData.Child("required")
		    For Idx As Integer = 0 To Required.LastRowIndex
		      Spec.mTags.Value(Required.ValueAt(Idx)) = Beacon.TagSpec.StateRequired
		    Next
		    Var Excluded As JSONItem = SaveData.Child("excluded")
		    For Idx As Integer = 0 To Excluded.LastRowIndex
		      Spec.mTags.Value(Excluded.ValueAt(Idx)) = Beacon.TagSpec.StateExcluded
		    Next
		    Return Spec
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing tag spec")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty() As Boolean
		  Return Self.mTags.KeyCount = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OrganizeTags(RequiredTags() As String, ExcludedTags() As String)
		  For Each Entry As DictionaryEntry In Self.mTags
		    If Entry.Value.IntegerValue >= Self.StateRequired Then
		      RequiredTags.Add(Entry.Key.StringValue)
		    ElseIf Entry.Value.IntegerValue <= Self.StateExcluded Then
		      ExcludedTags.Add(Entry.Key.StringValue)
		    End If
		  Next
		  RequiredTags.Sort
		  ExcludedTags.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredTags() As String()
		  Var Tags() As String
		  For Each Entry As DictionaryEntry In Self.mTags
		    If Entry.Value.IntegerValue >= Self.StateRequired Then
		      Tags.Add(Entry.Key.StringValue)
		    End If
		  Next
		  Tags.Sort
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequireTag(Tag As String)
		  Self.mTags.Value(Tag) = Self.StateRequired
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StateOf(Tag As String) As Integer
		  Return Self.mTags.Lookup(Tag, Self.StateIndifferent).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StateOf(Tag As String, Assigns State As Integer)
		  If State = Self.StateIndifferent Then
		    If Self.mTags.HasKey(Tag) Then
		      Self.mTags.Remove(Tag)
		    End If
		    Return
		  ElseIf State >= Self.StateRequired Then
		    Self.mTags.Value(Tag) = Self.StateRequired
		  Else
		    Self.mtags.Value(Tag) = Self.StateExcluded
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Var Required As New JSONItem
		  Var Excluded As New JSONItem
		  For Each Entry As DictionaryEntry In Self.mTags
		    If Entry.Value.IntegerValue >= Self.StateRequired Then
		      Required.Add(Entry.Key.StringValue)
		    ElseIf Entry.Value.IntegerValue <= Self.StateExcluded Then
		      Excluded.Add(Entry.Key.StringValue)
		    End If
		  Next
		  
		  Var Dict As New JSONItem
		  Dict.Compact = True
		  Dict.Value("required") = Required
		  Dict.Value("excluded") = Excluded
		  Return Dict.ToString
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mTags As Dictionary
	#tag EndProperty


	#tag Constant, Name = StateExcluded, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateIndifferent, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateRequired, Type = Double, Dynamic = False, Default = \"1", Scope = Public
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
