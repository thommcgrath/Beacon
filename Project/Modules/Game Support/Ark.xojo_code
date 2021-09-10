#tag Module
Protected Module Ark
	#tag Method, Flags = &h1
		Protected Function Categories() As String()
		  Return Array(Ark.CategoryEngrams, Ark.CategoryCreatures, Ark.CategorySpawnPoints, Ark.CategoryLootContainers)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OmniPurchased(Identity As Beacon.Identity) As Boolean
		  Return Identity.IsOmniFlagged(Ark.OmniFlag)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, Mods As Beacon.StringList) As Ark.Creature
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
		  
		  Return Ark.ResolveCreature(ObjectID, Path, ClassString, Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(ObjectID As String, Path As String, ClassString As String, Mods As Beacon.StringList) As Ark.Creature
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var Creature As Ark.Creature = Ark.DataSource.SharedInstance.GetCreatureByID(ObjectID)
		      If (Creature Is Nil) = False Then
		        Return Creature
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Creatures() As Ark.Creature = Ark.DataSource.SharedInstance.GetCreaturesByPath(Path, Mods)
		      If Creatures.Count > 0 Then
		        Return Creatures(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Creatures() As Ark.Creature = Ark.DataSource.SharedInstance.GetCreaturesByClass(ClassString, Mods)
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
		Protected Function ResolveEngram(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, Mods As Beacon.StringList) As Ark.Engram
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
		  
		  Return Ark.ResolveEngram(ObjectID, Path, ClassString, Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(ObjectID As String, Path As String, ClassString As String, Mods As Beacon.StringList) As Ark.Engram
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var Engram As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramByID(ObjectID)
		      If (Engram Is Nil) = False Then
		        Return Engram
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Engrams() As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramsByPath(Path, Mods)
		      If Engrams.Count > 0 Then
		        Return Engrams(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Engrams() As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramsByClass(ClassString, Mods)
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
		Protected Function ResolveLootContainer(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, Mods As Beacon.StringList) As Ark.LootContainer
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
		  
		  Return Ark.ResolveLootContainer(ObjectID, Path, ClassString, Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveLootContainer(ObjectID As String, Path As String, ClassString As String, Mods As Beacon.StringList) As Ark.LootContainer
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var LootContainer As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainerByID(ObjectID)
		      If (LootContainer Is Nil) = False Then
		        Return LootContainer
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var LootContainers() As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainersByPath(Path, Mods)
		      If LootContainers.Count > 0 Then
		        Return LootContainers(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var LootContainers() As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainersByClass(ClassString, Mods)
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
		Protected Function ResolveSpawnPoint(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, Mods As Beacon.StringList) As Ark.SpawnPoint
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
		  
		  Return Ark.ResolveSpawnPoint(ObjectID, Path, ClassString, Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(ObjectID As String, Path As String, ClassString As String, Mods As Beacon.StringList) As Ark.SpawnPoint
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var SpawnPoint As Ark.SpawnPoint = Ark.DataSource.SharedInstance.GetSpawnPointByID(ObjectID)
		      If (SpawnPoint Is Nil) = False Then
		        Return SpawnPoint
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.SharedInstance.GetSpawnPointsByPath(Path, Mods)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.SharedInstance.GetSpawnPointsByClass(ClassString, Mods)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Ark.SpawnPoint.CreateCustom(ObjectID, Path, ClassString)
		End Function
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


	#tag Constant, Name = CategoryCreatures, Type = String, Dynamic = False, Default = \"creatures", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategoryEngrams, Type = String, Dynamic = False, Default = \"engrams", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategoryLootContainers, Type = String, Dynamic = False, Default = \"loot_containers", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategorySpawnPoints, Type = String, Dynamic = False, Default = \"spawn_points", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FullName, Type = String, Dynamic = False, Default = \"Ark: Survival Evolved", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"Ark", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniFlag, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
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
