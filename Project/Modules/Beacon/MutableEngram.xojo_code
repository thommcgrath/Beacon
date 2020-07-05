#tag Class
Protected Class MutableEngram
Inherits Beacon.Engram
Implements Beacon.MutableBlueprint
	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  Self.mAlternateLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, ObjectID As v4UUID)
		  Super.Constructor()
		  
		  Self.mPath = Path
		  Self.mIsValid = Self.mPath.Length > 6 And Self.mPath.Left(6) = "/Game/"
		  Self.mObjectID = ObjectID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EntryString(Assigns Value As String)
		  Self.mEngramEntryString = Value.Trim
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.Engram
		  Return New Beacon.Engram(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  Tag = Beacon.NormalizeTag(Tag)
		  Var Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 And Value = False Then
		    Self.mTags.RemoveRowAt(Idx)
		  ElseIf Idx = -1 And Value = True Then
		    Self.mTags.AddRow(Tag)
		    Self.mTags.Sort()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ItemID(Assigns Value As NullableDouble)
		  Self.mItemID = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModID(Assigns Value As v4UUID)
		  Self.mModID = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModName(Assigns Value As String)
		  Self.mModName = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableEngram
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  Self.mPath = Value
		  Self.mIsValid = Self.mPath.Length > 6 And Self.mPath.Left(6) = "/Game/"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Recipe(Assigns Ingredients() As Beacon.RecipeIngredient)
		  If Ingredients Is Nil Then
		    Self.mIngredients.ResizeTo(-1)
		    Self.mHasLoadedIngredients = True
		    Return
		  End If
		  
		  Self.mIngredients.ResizeTo(Ingredients.LastRowIndex)
		  For Idx As Integer = 0 To Self.mIngredients.LastRowIndex
		    Self.mIngredients(Idx) = Ingredients(Idx)
		  Next
		  Self.mHasLoadedIngredients = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredPlayerLevel(Assigns Level As NullableDouble)
		  Self.mRequiredPlayerLevel = Level
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredUnlockPoints(Assigns Points As NullableDouble)
		  Self.mRequiredUnlockPoints = Points
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StackSize(Assigns Value As NullableDouble)
		  Self.mStackSize = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  Self.mTags.ResizeTo(-1)
		  
		  For Each Tag As String In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.AddRow(Tag)
		  Next
		  Self.mTags.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unpack(Dict As Dictionary)
		  If Dict.HasAllKeys("entry_string", "required_points", "required_level") Then
		    If IsNull(Dict.Value("entry_string")) Or Dict.Value("entry_string").StringValue.IsEmpty Then
		      Self.mEngramEntryString = ""
		      Self.mRequiredUnlockPoints = Nil
		      Self.mRequiredPlayerLevel = Nil
		      Self.mItemID = Nil
		    Else
		      Self.mEngramEntryString = Dict.Value("entry_string").StringValue
		      
		      If IsNull(Dict.Value("required_level")) = False Then
		        Self.mRequiredPlayerLevel = Dict.Value("required_level").IntegerValue
		      Else
		        Self.mRequiredPlayerLevel = Nil
		      End If
		      
		      If IsNull(Dict.Value("required_points")) = False Then
		        Self.mRequiredUnlockPoints = Dict.Value("required_points").IntegerValue
		      Else
		        Self.mRequiredUnlockPoints = Nil
		      End If
		    End If
		  End If
		  
		  If Dict.HasKey("stack_size") And IsNull(Dict.Value("stack_size")) = False Then
		    Self.mStackSize = Dict.Value("stack_size").IntegerValue
		  Else
		    Self.mStackSize = Nil
		  End If
		  
		  If Dict.HasKey("recipe") And IsNull(Dict.Value("recipe")) = False Then
		    Self.mIngredients = Beacon.RecipeIngredient.FromVariant(Dict.Value("recipe"))
		    Self.mHasLoadedIngredients = True
		  Else
		    Self.mIngredients.ResizeTo(-1)
		    Self.mHasLoadedIngredients = False
		  End If
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
