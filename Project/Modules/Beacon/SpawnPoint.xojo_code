#tag Class
Protected Class SpawnPoint
Implements Beacon.Blueprint,Beacon.Countable,Beacon.DocumentItem
	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  Return Self.mAlternateLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Beacon.CategorySpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.Blueprint
		  // Part of the Beacon.Blueprint interface.
		  
		  Return New Beacon.SpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mAvailability = Beacon.Maps.All.Mask
		  Self.mLimits = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SpawnPoint)
		  Self.Constructor()
		  
		  Self.mObjectID = Source.mObjectID
		  Self.mAvailability = Source.mAvailability
		  Self.mPath = Source.mPath
		  Self.mClassString = Source.mClassString
		  Self.mLabel = Source.mLabel
		  Self.mModID = Source.mModID
		  Self.mModName = Source.mModName
		  Self.mModified = Source.mModified
		  Self.mLimits = Source.mLimits.Clone
		  Self.mMode = Source.mMode
		  
		  Self.mSets.ResizeTo(Source.mSets.LastRowIndex)
		  For I As Integer = Source.mSets.FirstRowIndex To Source.mSets.LastRowIndex
		    Self.mSets(I) = Source.mSets(I).ImmutableVersion
		  Next
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.AddRow(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Engrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromClass(ClassString As String) As Beacon.SpawnPoint
		  Return CreateFromPath(Beacon.UnknownBlueprintPath("SpawnPoints", ClassString))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromPath(Path As String) As Beacon.SpawnPoint
		  Var SpawnPoint As New Beacon.SpawnPoint
		  SpawnPoint.mClassString = Beacon.ClassStringFromPath(Path)
		  SpawnPoint.mPath = Path
		  SpawnPoint.mObjectID = v4UUID.FromHash(Crypto.HashAlgorithms.MD5, SpawnPoint.mPath.Lowercase)
		  SpawnPoint.mLabel = Beacon.LabelFromClassString(SpawnPoint.mClassString)
		  SpawnPoint.mModID = LocalData.UserModID
		  SpawnPoint.mModName = LocalData.UserModName
		  Return SpawnPoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.SpawnPoint
		  If Dict.HasKey("Category") = False Or Dict.Value("Category") <> Beacon.CategorySpawnPoints Then
		    Return Nil
		  End If
		  
		  If Not Dict.HasAllKeys("UUID", "Label", "Path", "Availability", "Tags", "ModID", "ModName") Then
		    Return Nil
		  End If
		  
		  Var Sets() As Beacon.SpawnPointSet
		  If Dict.HasKey("Sets") Then
		    Var SetSaveData() As Variant = Dict.Value("Sets")
		    For Each SaveData As Dictionary In SetSaveData
		      Var Set As Beacon.SpawnPointSet = Beacon.SpawnPointSet.FromSaveData(SaveData)
		      If Set <> Nil Then
		        Sets.AddRow(Set)
		      End If
		    Next
		  End If
		  
		  Var Point As New Beacon.MutableSpawnPoint(Dict.Value("Path").StringValue, Dict.Value("UUID").StringValue)
		  Point.Label = Dict.Value("Label").StringValue
		  Point.Availability = Dict.Value("Availability").UInt64Value
		  Point.Tags = Dict.Value("Tags")
		  Point.ModID = Dict.Value("ModID").StringValue
		  Point.ModName = Dict.Value("ModName").StringValue
		  
		  Var Immutable As New Beacon.SpawnPoint(Point)
		  If Dict.HasKey("Limits") Then
		    Immutable.mLimits = Dict.Value("Limits")
		  End If
		  Immutable.mSets = Sets
		  Return Immutable
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.SpawnPoint
		  Try
		    Var SpawnPoint As Beacon.SpawnPoint
		    If Dict.HasKey("Path") Then
		      SpawnPoint = Beacon.Data.GetSpawnPointByPath(Dict.Value("Path"))
		      If SpawnPoint = Nil Then
		        SpawnPoint = Beacon.SpawnPoint.CreateFromPath(Dict.Value("Path"))
		      End If
		    End If
		    If SpawnPoint = Nil And Dict.HasKey("Class") Then
		      SpawnPoint = Beacon.Data.GetSpawnPointByClass(Dict.Value("Class"))
		      If SpawnPoint = Nil Then
		        SpawnPoint = Beacon.SpawnPoint.CreateFromClass(Dict.Value("Class"))
		      End If
		    End If
		    If SpawnPoint = Nil Then
		      Return Nil
		    End If
		    
		    SpawnPoint = New Beacon.SpawnPoint(SpawnPoint)
		    SpawnPoint.mSets.ResizeTo(-1)
		    If Dict.HasKey("Limits") Then
		      SpawnPoint.mLimits = Dictionary(Dict.Value("Limits").ObjectValue).Clone
		    Else
		      SpawnPoint.mLimits = New Dictionary
		    End If
		    If Dict.HasKey("Sets") Then
		      Var SetSaveData() As Variant = Dict.Value("Sets")
		      For Each Data As Dictionary In SetSaveData
		        Var Set As Beacon.SpawnPointSet = Beacon.SpawnPointSet.FromSaveData(Data)
		        If Set <> Nil Then
		          SpawnPoint.mSets.AddRow(Set)
		        End If
		      Next
		    End If
		    If Dict.HasKey("Mode") Then
		      SpawnPoint.mMode = Dict.Value("Mode").IntegerValue
		    End If
		    SpawnPoint.Modified = False
		    Return SpawnPoint
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.SpawnPoint
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Set As Beacon.SpawnPointSet) As Integer
		  For I As Integer = 0 To Self.mSets.LastRowIndex
		    If Self.mSets(I) = Set Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Document
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Sets() As Variant
		  Sets.ResizeTo(Self.mSets.LastRowIndex)
		  For I As Integer = 0 To Self.mSets.LastRowIndex
		    Sets(I) = Self.mSets(I)
		  Next
		  Return New Beacon.GenericIterator(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(Creature As Beacon.Creature) As Double
		  If Self.mLimits.HasKey(Creature.Path) Then
		    Return Self.mLimits.Value(Creature.Path)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limits() As Dictionary
		  Var Limits As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mLimits
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Entry.Key)
		    If Creature <> Nil Then
		      Limits.Value(Creature) = Entry.Value
		    End If
		  Next
		  Return Limits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LimitsString(Pretty As Boolean = False) As String
		  Try
		    Return Beacon.GenerateJSON(Self.mLimits, Pretty)
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As Integer
		  Return Self.mMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As v4UUID
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Set As Beacon.SpawnPointSet In Self.mSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Not Value Then
		    For Each Set As Beacon.SpawnPointSet In Self.mSets
		      Set.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mModName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Beacon.MutableSpawnPoint
		  // Part of the Beacon.Blueprint interface.
		  
		  Return New Beacon.MutableSpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableSpawnPoint
		  Return New Beacon.MutableSpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As v4UUID
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  // Part of the Beacon.Blueprint interface.
		  
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Children() As Variant
		  For Each Set As Beacon.SpawnPointSet In Self.mSets
		    Children.AddRow(Set.SaveData)
		  Next
		  
		  Var Keys As New Dictionary
		  Keys.Value("Path") = Self.Path
		  Keys.Value("Class") = Self.ClassString
		  Keys.Value("Mode") = Self.Mode
		  If Children.LastRowIndex > -1 Then
		    Keys.Value("Sets") = Children
		  End If
		  If Self.mLimits.KeyCount > 0 Then
		    Keys.Value("Limits") = Self.mLimits
		  End If
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Set(Index As Integer) As Beacon.SpawnPointSet
		  Return New Beacon.SpawnPointSet(Self.mSets(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetsString(Pretty As Boolean = False) As String
		  Var Objects() As Variant
		  For Each Set As Beacon.SpawnPointSet In Self.mSets
		    If Set <> Nil Then
		      Objects.AddRow(Set.SaveData)
		    End If
		  Next
		  Try
		    Return Beacon.GenerateJSON(Objects, Pretty)
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  // Part of the Beacon.Blueprint interface.
		  
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastRowIndex)
		  For I As Integer = 0 To Self.mTags.LastRowIndex
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Sets() As Variant
		  For Each Set As Beacon.SpawnPointSet In Self.mSets
		    Sets.AddRow(Set.SaveData)
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("Category") = Self.Category
		  Dict.Value("UUID") = Self.ObjectID.StringValue
		  Dict.Value("Label") = Self.Label
		  Dict.Value("Path") = Self.Path
		  Dict.Value("Availability") = Self.Availability
		  Dict.Value("Tags") = Self.Tags
		  Dict.Value("ModID") = Self.ModID.StringValue
		  Dict.Value("ModName") = Self.ModName
		  If Self.mLimits.KeyCount > 0 Then
		    Dict.Value("Limits") = Self.mLimits
		  End If
		  Dict.Value("Mode") = Self.Mode
		  If Sets.LastRowIndex > -1 Then
		    Dict.Value("Sets") = Sets
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UniqueKey() As String
		  Var Key As String = Self.Path
		  Select Case Self.Mode
		  Case Beacon.SpawnPoint.ModeOverride
		    Key = Key + ":Override"
		  Case Beacon.SpawnPoint.ModeAppend
		    Key = Key + ":Append"
		  Case Beacon.SpawnPoint.ModeRemove
		    Key = Key + ":Remove"
		  End Select
		  Return Key
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAlternateLabel As NullableString
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLimits As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mObjectID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSets() As Beacon.SpawnPointSet
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTags() As String
	#tag EndProperty


	#tag Constant, Name = ModeAppend, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeOverride, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeRemove, Type = Double, Dynamic = False, Default = \"4", Scope = Public
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
