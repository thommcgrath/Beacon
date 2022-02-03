#tag Module
Protected Module Ark
	#tag Method, Flags = &h0
		Sub AddTag(Extends Blueprint As Ark.MutableBlueprint, ParamArray TagsToAdd() As String)
		  Blueprint.AddTags(TagsToAdd)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTags(Extends Blueprint As Ark.MutableBlueprint, TagsToAdd() As String)
		  Var Tags() As String = Blueprint.Tags
		  Var Changed As Boolean
		  For I As Integer = 0 To TagsToAdd.LastIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToAdd(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    If Tags.IndexOf(Tag) <> -1 Then
		      Continue
		    End If
		    
		    Tags.Add(Tag)
		    Changed = True
		  Next
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  Tags.Sort
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Categories() As String()
		  Return Array(Ark.CategoryEngrams, Ark.CategoryCreatures, Ark.CategorySpawnPoints, Ark.CategoryLootContainers)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Disambiguate(Extends Creatures() As Ark.Creature, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategoryCreatures, Creatures, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Disambiguate(Extends Engrams() As Ark.Engram, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategoryEngrams, Engrams, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Disambiguate(Extends Containers() As Ark.LootContainer, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategoryLootContainers, Containers, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Disambiguate(Extends SpawnPoints() As Ark.SpawnPoint, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategorySpawnPoints, SpawnPoints, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Disambiguate(Category As String, Blueprints() As Ark.Blueprint, EnabledMaps As UInt64) As Dictionary
		  // Items in Blueprints() are always included, regardless of maps.
		  
		  Var Results As New Dictionary
		  For Idx As Integer = 0 To Blueprints.LastIndex
		    Results.Value(Blueprints(Idx).ObjectID) = Blueprints(Idx).Label
		  Next Idx
		  
		  Var All() As Ark.Blueprint = Ark.DataSource.SharedInstance.GetBlueprints(Category, "", New Beacon.StringList, "")
		  Var Labels As New Dictionary
		  For Idx As Integer = 0 To All.LastIndex
		    If All(Idx).ValidForMask(EnabledMaps) = False And Results.HasKey(All(Idx).ObjectID) = False Then
		      Continue For Idx
		    End If
		    
		    Var Siblings() As Ark.Blueprint
		    If Labels.HasKey(All(Idx).Label) Then
		      Siblings = Labels.Value(All(Idx).Label)
		    End If
		    Siblings.Add(All(Idx))
		    Labels.Value(All(Idx).Label) = Siblings
		  Next Idx
		  
		  For Each Entry As DictionaryEntry In Labels
		    Var Siblings() As Ark.Blueprint = Entry.Value
		    
		    If Siblings.Count = 1 Then
		      Continue For Entry
		    End If
		    
		    Var Specifiers() As String
		    Var UseClassStrings As Boolean
		    For Idx As Integer = 0 To Siblings.LastIndex
		      If Specifiers.IndexOf(Siblings(Idx).ContentPackName) > -1 Then
		        UseClassStrings = True
		        Exit For Idx
		      Else
		        Specifiers.Add(Siblings(Idx).ContentPackName)
		      End If
		    Next Idx
		    
		    For Idx As Integer = 0 To Siblings.LastIndex
		      Results.Value(Siblings(Idx).ObjectID) = Siblings(Idx).Label.Disambiguate(If(UseClassStrings, Siblings(Idx).ClassString, Siblings(Idx).ContentPackName))
		    Next Idx
		  Next Entry
		  
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash(Extends Blueprint As Ark.Blueprint) As String
		  #if DebugBuild
		    Return Beacon.GenerateJSON(Ark.PackBlueprint(Blueprint), True)
		  #else
		    Return EncodeHex(Crypto.SHA1(Beacon.GenerateJSON(Ark.PackBlueprint(Blueprint), False))).Lowercase
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(Extends Maps() As Ark.Map) As String
		  Var Names() As String
		  Names.ResizeTo(Maps.LastIndex)
		  For Idx As Integer = 0 To Names.LastIndex
		    Names(Idx) = Maps(Idx).Name
		  Next Idx
		  
		  If Names.Count = 0 Then
		    Return "No Maps"
		  ElseIf Names.Count = 1 Then
		    Return Names(0)
		  ElseIf Names.Count = 2 Then
		    Return Names(0) + " & " + Names(1)
		  Else
		    Var Tail As String = Names(Names.LastIndex)
		    Names.RemoveAt(Names.LastIndex)
		    Return Names.Join(", ") + ", & " + Tail
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask(Extends Maps() As Ark.Map) As UInt64
		  Var Bits As UInt64
		  For Each Map As Ark.Map In Maps
		    Bits = Bits Or Map.Mask
		  Next
		  Return Bits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NormalizeBlueprintPath(Path As String, FolderName As String) As String
		  Path = Path.Trim
		  
		  If Path.BeginsWith("BlueprintGeneratedClass") Then
		    Path = Path.Middle(23)
		  ElseIf Path.BeginsWith("Blueprint") Then
		    Path = Path.Middle(9)
		  End If
		  
		  If (Path.BeginsWith("'") And Path.EndsWith("'")) Or (Path.BeginsWith("""") And Path.EndsWith("""")) Then
		    Path = Path.Middle(1, Path.Length - 2)
		  End If
		  
		  If Path.BeginsWith("/Game/") Then
		    // Looks like a real path
		    
		    If Path.EndsWith("_C") Then
		      Path = Path.Left(Path.Length - 2)
		    End If
		    
		    Return Path
		  Else
		    // Assume this is a class string
		    Var PossiblePath As String = Ark.DataSource.SharedInstance.ResolvePathFromClassString(Path)
		    If PossiblePath.IsEmpty = False Then
		      Return PossiblePath
		    Else
		      Return Ark.UnknownBlueprintPath(FolderName, Path)
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OmniPurchased(Identity As Beacon.Identity) As Boolean
		  Return Identity.IsOmniFlagged(Ark.OmniFlag)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pack(Extends Blueprint As Ark.Blueprint) As Dictionary
		  Return PackBlueprint(Blueprint)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PackBlueprint(Blueprint As Ark.Blueprint) As Dictionary
		  Var Dict As New Dictionary
		  
		  Select Case Blueprint
		  Case IsA Ark.Engram
		    Dict.Value("group") = "engrams"
		  Case IsA Ark.Creature
		    Dict.Value("group") = "creatures"
		  Case IsA Ark.SpawnPoint
		    Dict.Value("group") = "spawn_points"
		  Case IsA Ark.LootContainer
		    Dict.Value("group") = "loot_containers"
		  Else
		    Return Nil
		  End Select
		  
		  Var ModInfo As New Dictionary
		  ModInfo.Value("id") = Blueprint.ContentPackUUID
		  ModInfo.Value("name") = Blueprint.ContentPackName
		  
		  Dict.Value("id") = Blueprint.ObjectID
		  Dict.Value("label") = Blueprint.Label
		  Dict.Value("alternate_label") = Blueprint.AlternateLabel
		  Dict.Value("mod") = ModInfo
		  Dict.Value("tags") = Blueprint.Tags
		  Dict.Value("availability") = Blueprint.Availability
		  Dict.Value("path") = Blueprint.Path
		  
		  // Let the blueprint add whatever additional data it needs
		  Blueprint.Pack(Dict)
		  
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseCommandLine(CommandLine As String, PreserveSyntax As Boolean = False) As Dictionary
		  // This shouldn't take long, but still, probably best to only use this on a thread
		  
		  Var InQuotes As Boolean
		  Var Characters() As String = CommandLine.Split("")
		  Var Buffer, Params() As String
		  For Each Char As String In Characters
		    If Char = """" Then
		      If InQuotes Then
		        Params.Add(Buffer)
		        Buffer = ""
		        InQuotes = False
		      Else
		        InQuotes = True
		      End If
		    ElseIf Char = " " Then
		      If InQuotes = False And Buffer.Length > 0 Then
		        Params.Add(Buffer)
		        Buffer = ""
		      End If
		    ElseIf Char = "-" And Buffer.Length = 0 Then
		      Continue
		    Else
		      Buffer = Buffer + Char
		    End If
		  Next
		  If Buffer.Length > 0 Then
		    Params.Add(Buffer)
		    Buffer = ""
		  End If
		  
		  Var StartupParams() As String = Params.Shift.Split("?")
		  Var Map As String = StartupParams.Shift
		  Call StartupParams.Shift // The listen statement
		  If PreserveSyntax Then
		    For Idx As Integer = 0 To Params.LastIndex
		      Params(Idx) = "-" + Params(Idx)
		    Next
		    For Idx As Integer = 0 To StartupParams.LastIndex
		      StartupParams(Idx) = "?" + StartupParams(Idx)
		    Next
		  End If
		  StartupParams.Merge(Params)
		  
		  Var CommandLineOptions As New Dictionary
		  For Each Parameter As String In StartupParams
		    Var KeyPos As Integer = Parameter.IndexOf("=")
		    Var Key As String
		    Var Value As Variant
		    If KeyPos = -1 Then
		      Key = Parameter
		      Value = True
		    Else
		      Key = Parameter.Left(KeyPos)
		      Value = Parameter.Middle(KeyPos + 1)
		    End If
		    If PreserveSyntax Then
		      Value = Parameter
		    End If
		    CommandLineOptions.Value(Key) = Value
		  Next
		  
		  If PreserveSyntax Then
		    CommandLineOptions.Value("?Map") = Map
		  Else
		    CommandLineOptions.Value("Map") = Map
		  End If
		  Return CommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTag(Extends Blueprint As Ark.MutableBlueprint, ParamArray TagsToRemove() As String)
		  Blueprint.RemoveTags(TagsToRemove)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTags(Extends Blueprint As Ark.MutableBlueprint, TagsToRemove() As String)
		  Var Tags() As String = Blueprint.Tags
		  Var Changed As Boolean
		  For I As Integer = 0 To TagsToRemove.LastIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToRemove(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    Var Idx As Integer = Tags.IndexOf(Tag)
		    If Idx = -1 Then
		      Continue
		    End If
		    
		    Tags.RemoveAt(Idx)
		    Changed = True
		  Next
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  // No, you don't need to sort here
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As Ark.Creature
		  Var ObjectID, Path, ClassString As String
		  
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return Ark.ResolveCreature(ObjectID, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(ObjectID As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As Ark.Creature
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var Creature As Ark.Creature = Ark.DataSource.SharedInstance.GetCreatureByUUID(ObjectID)
		      If (Creature Is Nil) = False Then
		        Return Creature
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Creatures() As Ark.Creature = Ark.DataSource.SharedInstance.GetCreaturesByPath(Path, ContentPacks)
		      If Creatures.Count > 0 Then
		        Return Creatures(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Creatures() As Ark.Creature = Ark.DataSource.SharedInstance.GetCreaturesByClass(ClassString, ContentPacks)
		      If Creatures.Count > 0 Then
		        Return Creatures(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Ark.Creature.CreateCustom(ObjectID, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As Ark.Engram
		  Var ObjectID, Path, ClassString As String
		  
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return Ark.ResolveEngram(ObjectID, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(ObjectID As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As Ark.Engram
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var Engram As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramByUUID(ObjectID)
		      If (Engram Is Nil) = False Then
		        Return Engram
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Engrams() As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramsByPath(Path, ContentPacks)
		      If Engrams.Count > 0 Then
		        Return Engrams(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Engrams() As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramsByClass(ClassString, ContentPacks)
		      If Engrams.Count > 0 Then
		        Return Engrams(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Ark.Engram.CreateCustom(ObjectID, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveLootContainer(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As Ark.LootContainer
		  Var ObjectID, Path, ClassString As String
		  
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return Ark.ResolveLootContainer(ObjectID, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveLootContainer(ObjectID As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As Ark.LootContainer
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var LootContainer As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainerByUUID(ObjectID)
		      If (LootContainer Is Nil) = False Then
		        Return LootContainer
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var LootContainers() As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainersByPath(Path, ContentPacks)
		      If LootContainers.Count > 0 Then
		        Return LootContainers(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var LootContainers() As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainersByClass(ClassString, ContentPacks)
		      If LootContainers.Count > 0 Then
		        Return LootContainers(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Ark.LootContainer.CreateCustom(ObjectID, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As Ark.SpawnPoint
		  Var ObjectID, Path, ClassString As String
		  
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return Ark.ResolveSpawnPoint(ObjectID, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(ObjectID As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As Ark.SpawnPoint
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var SpawnPoint As Ark.SpawnPoint = Ark.DataSource.SharedInstance.GetSpawnPointByUUID(ObjectID)
		      If (SpawnPoint Is Nil) = False Then
		        Return SpawnPoint
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.SharedInstance.GetSpawnPointsByPath(Path, ContentPacks)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.SharedInstance.GetSpawnPointsByClass(ClassString, ContentPacks)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Ark.SpawnPoint.CreateCustom(ObjectID, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit)) or  (TargetWeb and (Target32Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Sub SetupCodeEditor(Target As CodeEditor)
		  Const SCE_PROPS_DEFAULT = 0
		  Const SCE_PROPS_COMMENT = 1
		  Const SCE_PROPS_SECTION = 2
		  Const SCE_PROPS_ASSIGNMENT = 3
		  Const SCE_PROPS_DEFVAL = 4
		  Const SCE_PROPS_KEY = 5
		  
		  Target.InitializeLexer("props")
		  
		  Var BackgroundColor As Color = SystemColors.ControlBackgroundColor
		  
		  Target.Style(SCE_PROPS_DEFAULT).ForeColor = SystemColors.LabelColor.OpaqueColor(BackgroundColor)
		  Target.Style(SCE_PROPS_DEFAULT).BackColor = BackgroundColor
		  // Target.Style(SCE_PROPS_COMMENT).ForeColor = SystemColors.SecondaryLabelColor.OpaqueColor(BackgroundColor)
		  Target.Style(SCE_PROPS_SECTION).ForeColor = SystemColors.SystemRedColor.OpaqueColor(BackgroundColor)
		  Target.Style(SCE_PROPS_SECTION).Bold = True
		  Target.Style(SCE_PROPS_ASSIGNMENT).ForeColor = SystemColors.TertiaryLabelColor.OpaqueColor(BackgroundColor) // Equals sign
		  Target.Style(SCE_PROPS_KEY).ForeColor = SystemColors.SystemBlueColor.OpaqueColor(BackgroundColor)
		  
		  // Unknown colors
		  Target.Style(SCE_PROPS_DEFVAL).ForeColor = SystemColors.SystemPinkColor.OpaqueColor(BackgroundColor)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Values() As Ark.ConfigValue)
		  If Values.Count <= 1 Then
		    Return
		  End If
		  
		  Var Sorts() As String
		  Sorts.ResizeTo(Values.LastIndex)
		  For Idx As Integer = 0 To Sorts.LastIndex
		    Sorts(Idx) = Values(Idx).SortKey
		  Next
		  Sorts.SortWith(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Containers() As Ark.LootContainer)
		  Var Bound As Integer = Containers.LastIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As String
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Containers(I).SortValue.ToString(Locale.Raw, "0000") + Containers(I).Label + Containers(I).ClassString
		  Next
		  
		  Order.SortWith(Containers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Qualities() As Ark.Quality)
		  Var Bound As Integer = Qualities.LastIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As Double
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Qualities(I).BaseValue
		  Next
		  
		  Order.SortWith(Qualities)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TagString(Extends Blueprint As Ark.Blueprint) As String
		  Var Tags() As String = Blueprint.Tags
		  If Tags.IndexOf("object") = -1 Then
		    Tags.AddAt(0, "object")
		  End If
		  Return Tags.Join(",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TagString(Extends Blueprint As Ark.MutableBlueprint, Assigns Value As String)
		  Var Tags() As String = Value.Split(",")
		  Var Idx As Integer = Tags.IndexOf("object")
		  If Idx > -1 Then
		    Tags.RemoveAt(Idx)
		  End If
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnknownBlueprintPath(FolderName As String, ClassString As String) As String
		  Var ClassName As String
		  If ClassString.EndsWith("_C") Then
		    ClassName = ClassString.Left(ClassString.Length - 2)
		  Else
		    ClassName = ClassString
		  End If
		  
		  Return Ark.UnknownBlueprintPrefix + FolderName + "/" + ClassName + "." + ClassName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnpackBlueprint(Dict As Dictionary) As Ark.MutableBlueprint
		  If Not Dict.HasAllKeys("id", "label", "alternate_label", "path", "group", "tags", "availability", "mod") Then
		    Return Nil
		  End If
		  
		  Var Group As String = Dict.Value("group")
		  Var Path As String = Dict.Value("path")
		  Var ObjectID As String = Dict.Value("id")
		  
		  If Path.IsEmpty Or ObjectID.IsEmpty Or Group.IsEmpty Then
		    Return Nil
		  End If
		  
		  Var Blueprint As Ark.MutableBlueprint
		  Select Case Group
		  Case Ark.CategoryEngrams
		    Blueprint = New Ark.MutableEngram(Path, ObjectID)
		  Case Ark.CategoryCreatures
		    Blueprint = New Ark.MutableCreature(Path, ObjectID)
		  Case Ark.CategorySpawnPoints
		    Blueprint = New Ark.MutableSpawnPoint(Path, ObjectID)
		  Case Ark.CategoryLootContainers, "loot_sources"
		    Blueprint = New Ark.MutableLootContainer(Path, ObjectID)
		  Else
		    Return Nil
		  End Select
		  
		  Var ModInfo As Dictionary = Dict.Value("mod")
		  
		  Var Tags() As String
		  If Dict.Value("tags").IsArray Then
		    If Dict.Value("tags").ArrayElementType = Variant.TypeString Then
		      Tags = Dict.Value("tags")
		    ElseIf Dict.Value("tags").ArrayElementType = Variant.TypeObject Then
		      Var Temp() As Variant = Dict.Value("tags")
		      For Each Tag As Variant In Temp
		        If Tag.Type = Variant.TypeString Then
		          Tags.Add(Tag.StringValue)
		        End If
		      Next
		    End If
		  End If
		  
		  If IsNull(Dict.Value("alternate_label")) = False And Dict.Value("alternate_label").StringValue.IsEmpty = False Then
		    Blueprint.AlternateLabel = Dict.Value("alternate_label").StringValue
		  Else
		    Blueprint.AlternateLabel = Nil
		  End If
		  Blueprint.Availability = Dict.Value("availability").UInt64Value
		  Blueprint.Label = Dict.Value("label").StringValue
		  Blueprint.ContentPackUUID = ModInfo.Value("id").StringValue
		  Blueprint.ContentPackName = ModInfo.Value("name").StringValue
		  Blueprint.Tags = Tags
		  
		  // Let the blueprint grab whatever additional data it needs
		  Blueprint.Unpack(Dict)
		  
		  Return Blueprint
		  
		  Exception Err As RuntimeException
		    Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, RequiredHeaders() As String) As String()
		  Var MissingHeaders() As String
		  For Each RequiredHeader As String In RequiredHeaders
		    If Content.IndexOf(RequiredHeader) = -1 Then
		      MissingHeaders.Add(RequiredHeader)
		    End If
		  Next
		  MissingHeaders.Sort
		  Return MissingHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, Filename As String) As String()
		  Var RequiredHeaders() As String
		  If Filename = Ark.ConfigFileGame Then
		    RequiredHeaders = Array("[" + Ark.HeaderShooterGame + "]")
		  ElseIf Filename = Ark.ConfigFileGameUserSettings Then
		    RequiredHeaders = Array("[SessionSettings]", "[" + Ark.HeaderServerSettings + "]", "[/Script/ShooterGame.ShooterGameUserSettings]")
		  End If
		  Return Ark.ValidateIniContent(Content, RequiredHeaders)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Extends Blueprint As Ark.Blueprint, Map As Ark.Map) As Boolean
		  Return Map Is Nil Or Blueprint.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Extends Blueprint As Ark.MutableBlueprint, Map As Ark.Map, Assigns Value As Boolean)
		  If (Map Is Nil) = False Then
		    Blueprint.ValidForMask(Map.Mask) = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Extends Blueprint As Ark.Blueprint, Mask As UInt64) As Boolean
		  Return Mask = CType(0, UInt64) Or (Blueprint.Availability And Mask) > CType(0, UInt64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMask(Extends Blueprint As Ark.MutableBlueprint, Mask As UInt64, Assigns Value As Boolean)
		  Var Availability As UInt64 = Blueprint.Availability
		  If Value Then
		    Availability = Availability Or Mask
		  Else
		    Availability = Availability And Not Mask
		  End If
		  If Availability <> Blueprint.Availability Then
		    Blueprint.Availability = Availability
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForProject(Extends Blueprint As Ark.Blueprint, Project As Ark.Project) As Boolean
		  Return (Project Is Nil) = False And Project.ContentPackEnabled(Blueprint.ContentPackUUID)
		End Function
	#tag EndMethod


	#tag Constant, Name = CategoryCreatures, Type = String, Dynamic = False, Default = \"creatures", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategoryEngrams, Type = String, Dynamic = False, Default = \"engrams", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategoryLootContainers, Type = String, Dynamic = False, Default = \"loot_containers", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategorySpawnPoints, Type = String, Dynamic = False, Default = \"spawn_points", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ConfigFileGame, Type = String, Dynamic = False, Default = \"Game.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ConfigFileGameUserSettings, Type = String, Dynamic = False, Default = \"GameUserSettings.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FullName, Type = String, Dynamic = False, Default = \"Ark: Survival Evolved", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderServerSettings, Type = String, Dynamic = False, Default = \"ServerSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderShooterGame, Type = String, Dynamic = False, Default = \"/script/shootergame.shootergamemode", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"Ark", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniFlag, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UnknownBlueprintPrefix, Type = String, Dynamic = False, Default = \"/Game/BeaconUserBlueprints/", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackName, Type = String, Dynamic = False, Default = \"User Blueprints", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackUUID, Type = String, Dynamic = False, Default = \"23ecf24c-377f-454b-ab2f-d9d8f31a5863", Scope = Protected
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
End Module
#tag EndModule
