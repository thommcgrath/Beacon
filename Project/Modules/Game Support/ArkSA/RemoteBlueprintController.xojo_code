#tag Class
Protected Class RemoteBlueprintController
Inherits ArkSA.BlueprintController
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub FetchBlueprints(Task As ArkSA.BlueprintControllerFetchTask)
		  If Preferences.OnlineEnabled = False Then
		    Self.FinishTask(Task)
		    Return
		  End If
		  
		  Var FetchThread As New Beacon.Thread
		  FetchThread.DebugIdentifier = CurrentMethodName
		  FetchThread.UserData = Task
		  AddHandler FetchThread.Run, WeakAddressOf FetchThread_Run
		  AddHandler FetchThread.UserInterfaceUpdate, WeakAddressOf FetchThread_UserInterfaceUpdate
		  Self.mThreads.Add(FetchThread)
		  FetchThread.Start
		End Sub
	#tag EndEvent

	#tag Event
		Sub Publish(Tasks() As ArkSA.BlueprintControllerPublishTask)
		  If Preferences.OnlineEnabled = False Then
		    For Each Task As ArkSA.BlueprintControllerPublishTask In Tasks
		      Self.FinishTask(Task)
		    Next
		    Return
		  End If
		  
		  For Each Task As ArkSA.BlueprintControllerPublishTask In Tasks
		    Var PublishThread As New Beacon.Thread
		    PublishThread.DebugIdentifier = CurrentMethodName
		    PublishThread.UserData = Task
		    AddHandler PublishThread.Run, WeakAddressOf PublishThread_Run
		    AddHandler PublishThread.UserInterfaceUpdate, WeakAddressOf PublishThread_UserInterfaceUpdate
		    Self.mThreads.Add(PublishThread)
		    PublishThread.Start
		  Next
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub FetchThread_Run(Sender As Beacon.Thread)
		  Var Task As ArkSA.BlueprintControllerFetchTask = Sender.UserData
		  Var PathComponent As String = Self.PathComponent(Task)
		  
		  Var Params As New Dictionary
		  Params.Value("contentPackId") = Self.ContentPack.ContentPackId
		  Params.Value("page") = Task.Page
		  Params.Value("pageSize") = Task.PageSize
		  
		  Var Request As New BeaconAPI.Request("arksa/" + PathComponent, "GET", Params)
		  Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		  
		  If Response.HTTPStatus <> 200 Then
		    Task.Errored = True
		    Task.ErrorMessage = Response.Message
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		    Task.Errored = True
		    Task.ErrorMessage = Err.Message
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End Try
		  
		  If Parsed.IsNull Or Parsed.Type <> Variant.TypeObject Or (Parsed.ObjectValue IsA Dictionary) = False Then
		    Task.Errored = True
		    Task.ErrorMessage = "Invalid object type returned."
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Var Dict As Dictionary = Parsed
		  Task.TotalResults = Dict.Value("totalResults")
		  Task.TotalPages = Dict.Value("pages")
		  Var Results() As Variant = Dict.Value("results")
		  
		  Try
		    For Each Definition As Dictionary In Results
		      Var Blueprint As ArkSA.Blueprint = ArkSA.UnpackBlueprint(Definition)
		      If (Blueprint Is Nil) = False Then
		        Task.Blueprints.Add(Blueprint)
		      End If
		    Next
		  Catch Err As RuntimeException
		    Task.Errored = True
		    Task.ErrorMessage = "Could not unpack blueprints: " + Err.Message
		  End Try
		  
		  Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FetchThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  For Each Update As Dictionary In Updates
		    Var Finished As Boolean = Update.Value("Finished")
		    If Finished = False Then
		      Continue
		    End If
		    
		    Var Task As ArkSA.BlueprintControllerFetchTask = Sender.UserData
		    Self.FinishTask(Task)
		    
		    For Idx As Integer = Self.mThreads.LastIndex DownTo 0
		      If Self.mThreads(Idx) = Sender Then
		        Self.mThreads.RemoveAt(Idx)
		        Exit For Idx
		      End If
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IdProperty(Task As ArkSA.BlueprintControllerTask) As String
		  Select Case Task.Mode
		  Case Self.ModeCreatures
		    Return "creatureId"
		  Case Self.ModeEngrams
		    Return "engramId"
		  Case Self.ModeLootDrops
		    Return "lootDropId"
		  Case Self.ModeSpawnPoints
		    Return "spawnPointId"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PathComponent(Task As ArkSA.BlueprintControllerTask) As String
		  Select Case Task.Mode
		  Case Self.ModeCreatures
		    Return "creatures"
		  Case Self.ModeEngrams
		    Return "engrams"
		  Case Self.ModeLootDrops
		    Return "lootDrops"
		  Case Self.ModeSpawnPoints
		    Return "spawnPoints"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PublishDelete(Task As ArkSA.BlueprintControllerPublishTask)
		  Var Ids() As String = Task.DeleteIds
		  If Ids.Count = 0 Then
		    Task.Errored = False
		    Return
		  End If
		  
		  Var PathComponent As String = Self.PathComponent(Task)
		  Var IdProperty As String = Self.IdProperty(Task)
		  Var Objects() As Dictionary
		  For Each Id As String In Ids
		    Objects.Add(New Dictionary(IdProperty: Id))
		  Next
		  
		  Var Request As New BeaconAPI.Request("arksa/" + PathComponent, "DELETE", Beacon.GenerateJSON(Objects, False), "application/json")
		  Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		  
		  If Response.HTTPStatus <> 200 And Response.HTTPStatus <> 204 Then
		    Task.Errored = True
		    Task.ErrorMessage = Response.Message
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PublishSave(Task As ArkSA.BlueprintControllerPublishTask)
		  Var Blueprints() As ArkSA.Blueprint = Task.Blueprints
		  If Blueprints.Count = 0 Then
		    Task.Errored = False
		    Return
		  End If
		  
		  Var PathComponent As String = Self.PathComponent(Task)
		  Var Objects() As Dictionary
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Objects.Add(ArkSA.PackBlueprint(Blueprint, True))
		  Next
		  
		  Var Request As New BeaconAPI.Request("arksa/" + PathComponent, "POST", Beacon.GenerateJSON(Objects, False), "application/json")
		  Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		  
		  If Response.HTTPStatus <> 200 And Response.HTTPStatus <> 201 Then
		    Task.Errored = True
		    
		    Try
		      Var Details As Dictionary = Response.JSON
		      If Details.Lookup("code", 0).IntegerValue = 23503 Then
		        Var Column As String = Details.Lookup("column", "").StringValue
		        Var SourceTable As String = Details.Lookup("sourceTable", "").StringValue
		        Var FullColumn As String = SourceTable + "." + Column
		        
		        Select Case FullColumn
		        Case "crafting_costs.ingredient_id"
		          Var IngredientId As String = Details.Lookup("value", "").StringValue
		          For Each Blueprint As ArkSA.Blueprint In Blueprints
		            If (Blueprint IsA ArkSA.Engram) = False Then
		              Continue
		            End If
		            
		            Var Engram As ArkSA.Engram = ArkSA.Engram(Blueprint)
		            Var Ingredient As ArkSA.BlueprintReference = Engram.FindIngredient(IngredientId)
		            If (Ingredient Is Nil) = False Then
		              Task.ErrorMessage = "Ingredient """ + Ingredient.Label + """ of item """ + Engram.Label + """ does not exist."
		              Return
		            End If
		          Next
		        Case "loot_item_set_entry_options.engram_id"
		          Var EngramId As String = Details.Lookup("value", "").StringValue
		          For Each Blueprint As ArkSA.Blueprint In Blueprints
		            If (Blueprint IsA ArkSA.LootContainer) = False Then
		              Continue
		            End If
		            
		            Var LootContainer As ArkSA.LootContainer = ArkSA.LootContainer(Blueprint)
		            Var Engram As ArkSA.BlueprintReference = LootContainer.FindEngram(EngramId)
		            If (Engram Is Nil) = False Then
		              Task.ErrorMessage = "Item """ + Engram.Label + """ of loot drop """ + LootContainer.Label + """ does not exist."
		              Return
		            End If
		          Next
		        Case "spawn_point_limits.creature_id", "spawn_point_set_replacements.target_creature_id", "spawn_point_set_replacements.replacement_creature_id", "spawn_point_set_entries.creature_id"
		          Var CreatureId As String = Details.Lookup("value", "").StringValue
		          For Each Blueprint As ArkSA.Blueprint In Blueprints
		            If (Blueprint IsA ArkSA.SpawnPoint) = False Then
		              Continue
		            End If
		            
		            Var SpawnContainer As ArkSA.SpawnPoint = ArkSA.SpawnPoint(Blueprint)
		            Var Creature As ArkSA.BlueprintReference = SpawnContainer.FindCreature(CreatureId)
		            If (Creature Is Nil) = False Then
		              Task.ErrorMessage = "Creature """ + Creature.Label + """ of spawn point """ + SpawnContainer.Label + """ does not exist."
		              Return
		            End If
		          Next
		        Else
		          Break
		        End Select
		      End If
		    Catch Err As RuntimeException
		    End Try
		    
		    Task.ErrorMessage = Response.Message
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PublishThread_Run(Sender As Beacon.Thread)
		  Var Task As ArkSA.BlueprintControllerPublishTask = Sender.UserData
		  If Task.DeleteMode Then
		    Self.PublishDelete(Task)
		  Else
		    Self.PublishSave(Task)
		  End If
		  Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PublishThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  For Each Update As Dictionary In Updates
		    Var Finished As Boolean = Update.Value("Finished")
		    If Finished = False Then
		      Continue
		    End If
		    
		    Var Task As ArkSA.BlueprintControllerPublishTask = Sender.UserData
		    Self.FinishTask(Task)
		    
		    For Idx As Integer = Self.mThreads.LastIndex DownTo 0
		      If Self.mThreads(Idx) = Sender Then
		        Self.mThreads.RemoveAt(Idx)
		        Exit For Idx
		      End If
		    Next
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mThreads() As Beacon.Thread
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsBusy"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
