#tag Class
Protected Class BlueprintReference
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function BlueprintId() As String
		  Return Self.mBlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  If Self.mBlueprint Is Nil Then
		    Return Self.mClassString
		  End If
		  
		  Return Self.mBlueprint.ClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Blueprint As ArkSA.Blueprint)
		  If Blueprint Is Nil Then
		    Return
		  End If
		  
		  Self.mBlueprint = Blueprint
		  Self.mBlueprintId = Blueprint.BlueprintId
		  Self.mClassString = Blueprint.ClassString
		  Self.mContentPackId = Blueprint.ContentPackId
		  Self.mLabel = Blueprint.Label
		  Self.mPath = Blueprint.Path
		  
		  Select Case Blueprint
		  Case IsA ArkSA.Engram
		    Self.mKind = Self.KindEngram
		  Case IsA ArkSA.Creature
		    Self.mKind = Self.KindCreature
		  Case IsA ArkSA.SpawnPoint
		    Self.mKind = Self.KindSpawnPoint
		  Case IsA ArkSA.LootContainer
		    Self.mKind = Self.KindLootContainer
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(SaveData As Dictionary)
		  If SaveData Is Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "SaveData is Nil"
		    Raise Err
		  End If
		  
		  Var Version As Integer = SaveData.FirstValue("version", "Version", 0)
		  If Version < 1 Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Version is too old"
		    Raise Err
		  End If
		  
		  Select Case Version
		  Case 1
		    Self.mBlueprintId = SaveData.Value("UUID")
		    Self.mClassString = SaveData.FirstValue("ClassString", "Class", "")
		    Self.mContentPackId = SaveData.Value("ModUUID")
		    
		    Self.mLabel = SaveData.FirstValue("ClassString", "Class", "Path", "ObjectID")
		    Self.mPath = SaveData.Value("Path")
		    
		    Select Case SaveData.Value("Kind").StringValue
		    Case "Engram"
		      Self.mKind = Self.KindEngram
		    Case "Creature"
		      Self.mKind = Self.KindCreature
		    Case "Spawn Point"
		      Self.mKind = Self.KindSpawnPoint
		    Case "Loot Container"
		      Self.mKind = Self.KindLootContainer
		    Else
		      Self.mKind = SaveData.Value("Kind")
		    End Select
		  Case 2
		    Self.mBlueprintId = SaveData.Value("blueprintId")
		    Self.mClassString = SaveData.Value("classString")
		    Self.mContentPackId = SaveData.Value("contentPackId")
		    Self.mKind = SaveData.Value("kind")
		    Self.mLabel = SaveData.Value("label")
		    Self.mPath = SaveData.Value("path")
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unknown reference version " + Version.ToString(Locale.Raw, "0")
		    Raise Err
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Kind As String, BlueprintId As String, Path As String, ClassString As String, Label As String, ContentPackId As String)
		  Self.mBlueprintId = BlueprintId
		  Self.mClassString = ClassString
		  Self.mContentPackId = ContentPackId
		  Self.mKind = Kind
		  Self.mLabel = Label
		  Self.mPath = Path
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  If Self.mBlueprint Is Nil Then
		    Return Self.mContentPackId
		  End If
		  
		  Return Self.mBlueprint.ContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromDict(Kind As String, Dict As Dictionary, BlueprintIdKey As String, PathKey As String, ClassStringKey As String, LabelKey As String, ContentPackIdKey As String) As ArkSA.BlueprintReference
		  Var BlueprintId, Path, ClassString, Label, ContentPackId As String
		  If BlueprintIdKey.IsEmpty = False And Dict.HasKey(BlueprintIdKey) Then
		    BlueprintId = Dict.Value(BlueprintIdKey)
		  End If
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  If ClassStringKey.IsEmpty = False And Dict.HasKey(ClassStringKey) Then
		    ClassString = Dict.Value(ClassStringKey)
		  End If
		  If LabelKey.IsEmpty = False And Dict.HasKey(LabelKey) Then
		    Label = Dict.Value(LabelKey)
		  End If
		  If ContentPackIdKey.IsEmpty = False And Dict.HasKey(ContentPackIdKey) Then
		    ContentPackId = Dict.Value(ContentPackIdKey)
		  End If
		  Return New ArkSA.BlueprintReference(Kind, BlueprintId, Path, ClassString, Label, ContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSaveData(Blueprint As ArkSA.Blueprint) As Dictionary
		  Var Ref As New ArkSA.BlueprintReference(Blueprint)
		  Return Ref.SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary, AlreadyValidated As Boolean = False) As ArkSA.BlueprintReference
		  If AlreadyValidated = False And IsSaveData(Dict) = False Then
		    Return Nil
		  End If
		  
		  Return New ArkSA.BlueprintReference(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCreature() As Boolean
		  Return Self.mKind = Self.KindCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEngram() As Boolean
		  Return Self.mKind = Self.KindEngram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLootContainer() As Boolean
		  Return Self.mKind = Self.KindLootContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsSaveData(Value As Variant) As Boolean
		  If Value.IsNull Or Value.IsArray Or (Value IsA Dictionary) = False Then
		    Return False
		  End If
		  
		  Var Dict As Dictionary = Value
		  
		  Var VersionValue As Variant = Dict.FirstValue("version", "Version", 0)
		  If VersionValue.IsNull Or VersionValue.IsNumeric = False Or VersionValue.IntegerValue > ArkSA.BlueprintReference.Version  Then
		    Return False
		  End If
		  Var Version As Integer = VersionValue.IntegerValue
		  If Version > ArkSA.BlueprintReference.Version Or Version <= 0 Then
		    Return False
		  End If
		  
		  Var SchemaValue As Variant = Dict.FirstValue("schema", "Schema", "")
		  If SchemaValue.IsNull Or SchemaValue.Type <> Variant.TypeString Or (Version = 1 And SchemaValue.StringValue <> "Beacon.BlueprintReference") Or (Version = 2 And SchemaValue.StringValue <> "blueprintReference") Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSpawnPoint() As Boolean
		  Return Self.mKind = Self.KindSpawnPoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Kind() As String
		  Return Self.mKind
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mBlueprint Is Nil Then
		    Return Self.mLabel
		  End If
		  
		  Return Self.mBlueprint.Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "BlueprintId" )  Function ObjectID() As String
		  Return Self.mBlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.Blueprint) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mBlueprintId = Other.BlueprintId Then
		    Return 0
		  End If
		  
		  Var MySortKey As String = Self.mLabel + ":" + Self.mBlueprintId
		  Var OtherSortKey As String = Other.Label + ":" + Other.BlueprintId
		  
		  Return MySortKey.Compare(OtherSortKey, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.BlueprintReference) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.BlueprintId = Other.BlueprintId Then
		    Return 0
		  End If
		  
		  Var MySortKey As String = Self.mLabel + ":" + Self.mBlueprintId
		  Var OtherSortKey As String = Other.mLabel + ":" + Other.mBlueprintId
		  
		  Return MySortKey.Compare(OtherSortKey, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  If Self.mBlueprint Is Nil Then
		    Return Self.mPath
		  End If
		  
		  Return Self.mBlueprint.Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Resolve(Packs As Beacon.StringList = Nil, Options As Integer = 3) As ArkSA.Blueprint
		  If (Options And Self.OptionUseCache) = Self.OptionUseCache And (Self.mBlueprint Is Nil) = False Then
		    Return Self.mBlueprint
		  End If
		  
		  If Beacon.UUID.Validate(Self.mContentPackId) Then
		    Packs = New Beacon.StringList(Self.mContentPackId)
		  End If
		  
		  Var Create As Boolean = (Options And Self.OptionCreate) = Self.OptionCreate
		  Var Blueprint As ArkSA.Blueprint
		  Select Case Self.mKind
		  Case Self.KindEngram
		    Blueprint = ArkSA.ResolveEngram(Self.mBlueprintId, Self.mPath, Self.mClassString, Packs, Create)
		  Case Self.KindCreature
		    Blueprint = ArkSA.ResolveCreature(Self.mBlueprintId, Self.mPath, Self.mClassString, Packs, Create)
		  Case Self.KindSpawnPoint
		    Blueprint = ArkSA.ResolveSpawnPoint(Self.mBlueprintId, Self.mPath, Self.mClassString, Packs, Create)
		  Case Self.KindLootContainer
		    Blueprint = ArkSA.ResolveLootContainer(Self.mBlueprintId, Self.mPath, Self.mClassString, Packs, Create)
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unknown blueprint reference kind " + Self.mKind
		    Raise Err
		  End Select
		  
		  // Will update all the properties with correct values
		  Self.Constructor(Blueprint)
		  
		  Return Blueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("schema") = "blueprintReference"
		  Dict.Value("version") = Self.Version
		  Dict.Value("kind") = Self.mKind
		  Dict.Value("label") = Self.mLabel
		  Dict.Value("blueprintId") = Self.mBlueprintId
		  Dict.Value("path") = Self.mPath
		  Dict.Value("classString") = Self.mClassString
		  Dict.Value("contentPackId") = Self.mContentPackId
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprint As ArkSA.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBlueprintId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClassString As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKind As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As String
	#tag EndProperty


	#tag Constant, Name = KindCreature, Type = String, Dynamic = False, Default = \"creature", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindEngram, Type = String, Dynamic = False, Default = \"engram", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindLootContainer, Type = String, Dynamic = False, Default = \"lootDrop", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindSpawnPoint, Type = String, Dynamic = False, Default = \"spawnPoint", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionCreate, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionUseCache, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"2", Scope = Private
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
