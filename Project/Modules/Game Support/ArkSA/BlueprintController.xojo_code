#tag Class
Protected Class BlueprintController
	#tag Method, Flags = &h21
		Private Sub AddTask(Task As ArkSA.BlueprintControllerTask)
		  Self.mPendingTasks.Add(Task)
		  If Self.mPendingTasks.Count = 1 Then
		    RaiseEvent WorkStarted()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllBlueprints() As ArkSA.Blueprint()
		  Var Blueprints() As ArkSA.Blueprint
		  
		  For Each Entry As DictionaryEntry In Self.mChanges
		    If Entry.Value.Type = Variant.TypeString Then
		      Continue
		    End If
		    
		    Blueprints.Add(Entry.Value)
		  Next
		  
		  For Each Entry As DictionaryEntry In Self.mOriginalBlueprints
		    If Self.mChanges.HasKey(Entry.Key) Then
		      Continue
		    End If
		    
		    Blueprints.Add(Entry.Value)
		  Next
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Blueprint(BlueprintId As String) As ArkSA.Blueprint
		  If Self.mChanges.HasKey(BlueprintId) Then
		    If Self.mChanges.Value(BlueprintId).Type = Variant.TypeString Then
		      Return Nil
		    End If
		    
		    Return Self.mChanges.Value(BlueprintId)
		  End If
		  
		  If Self.mOriginalBlueprints.HasKey(BlueprintId) Then
		    Return Self.mOriginalBlueprints.Value(BlueprintId)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CancelAllTasks()
		  If Self.mPendingTasks.Count > 0 Then
		    Self.mPendingTasks.ResizeTo(-1)
		    RaiseEvent WorkFinished()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupTask(Task As ArkSA.BlueprintControllerTask)
		  For Idx As Integer = 0 To Self.mPendingTasks.LastIndex
		    Var PendingTask As ArkSA.BlueprintControllerTask = Self.mPendingTasks(Idx)
		    If PendingTask IsA ArkSA.BlueprintControllerTaskGroup Then
		      ArkSA.BlueprintControllerTaskGroup(PendingTask).FinishTask(Task) // May not exist in this group, but that's ok.
		      If ArkSA.BlueprintControllerTaskGroup(PendingTask).Finished Then
		        Self.mPendingTasks.RemoveAt(Idx)
		        Exit For Idx
		      End If
		    End If
		    
		    If Self.mPendingTasks(Idx).TaskId = Task.TaskId Then
		      Self.mPendingTasks.RemoveAt(Idx)
		      Exit For Idx
		    End If
		  Next
		  
		  If Self.mPendingTasks.Count = 0 Then
		    RaiseEvent WorkFinished()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.mChanges = New Dictionary
		  Self.mOriginalBlueprints = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ContentPack As Beacon.ContentPack)
		  Self.mContentPack = ContentPack
		  Self.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPack() As Beacon.ContentPack
		  Return Self.mContentPack
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprint(Blueprint As ArkSA.Blueprint)
		  Var Blueprints(0) As ArkSA.Blueprint
		  Blueprints(0) = Blueprint
		  Self.DeleteBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprints(Blueprints() As ArkSA.Blueprint)
		  If Self.IsBusy Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Self.mChanges.Value(Blueprint.BlueprintId) = Blueprint.Category
		  Next
		  
		  Var BlueprintsSaved() As ArkSA.Blueprint
		  If Thread.Current Is Nil Then
		    RaiseEvent BlueprintsChanged(BlueprintsSaved, Blueprints)
		  Else
		    Call CallLater.Schedule(1, WeakAddressOf TriggerBlueprintsChanged, New Dictionary("BlueprintsSaved": BlueprintsSaved, "BlueprintsDeleted": Blueprints))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DiscardChanges()
		  If Self.IsBusy Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  Self.mChanges = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindGroupForTask(Task As ArkSA.BlueprintControllerTask) As ArkSA.BlueprintControllerTaskGroup
		  Return Self.FindGroupForTaskId(Task.TaskId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindGroupForTaskId(TaskId As String) As ArkSA.BlueprintControllerTaskGroup
		  For Idx As Integer = 0 To Self.mPendingTasks.LastIndex
		    If Self.mPendingTasks(Idx) IsA ArkSA.BlueprintControllerTaskGroup Then
		      Var TaskGroup As ArkSA.BlueprintControllerTaskGroup = ArkSA.BlueprintControllerTaskGroup(Self.mPendingTasks(Idx))
		      Var Task As ArkSA.BlueprintControllerTask = TaskGroup.FindTask(TaskId)
		      If (Task Is Nil) = False Then
		        Return TaskGroup
		      End If
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindTask(TaskId As String) As ArkSA.BlueprintControllerTask
		  For Idx As Integer = 0 To Self.mPendingTasks.LastIndex
		    If Self.mPendingTasks(Idx).TaskId = TaskId Then
		      Return Self.mPendingTasks(Idx)
		    ElseIf Self.mPendingTasks(Idx) IsA ArkSA.BlueprintControllerTaskGroup Then
		      Var Task As ArkSA.BlueprintControllerTask = ArkSA.BlueprintControllerTaskGroup(Self.mPendingTasks(Idx)).FindTask(TaskId)
		      If (Task Is Nil) = False Then
		        Return Task
		      End If
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FinishTask(Task As ArkSA.BlueprintControllerFetchTask)
		  Var Clone() As ArkSA.Blueprint
		  Clone.ResizeTo(Task.Blueprints.LastIndex)
		  For Idx As Integer = 0 To Task.Blueprints.LastIndex
		    Clone(Idx) = Task.Blueprints(Idx)
		  Next
		  
		  For Each Blueprint As ArkSA.Blueprint In Task.Blueprints
		    Self.mOriginalBlueprints.Value(Blueprint.BlueprintId) = Blueprint
		  Next
		  
		  RaiseEvent BlueprintsLoaded(Task)
		  
		  Self.CleanupTask(Task)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FinishTask(Task As ArkSA.BlueprintControllerPublishTask)
		  If Task.Errored = False Then
		    If Task.DeleteMode Then
		      Var DeleteIds() As String = Task.DeleteIds
		      For Each Id As String In DeleteIds
		        If Self.mChanges.HasKey(Id) Then
		          Self.mChanges.Remove(Id)
		        End If
		      Next
		    Else
		      Var Blueprints() As ArkSA.Blueprint = Task.Blueprints
		      For Each Blueprint As ArkSA.Blueprint In Blueprints
		        If Self.mChanges.HasKey(Blueprint.BlueprintId) Then
		          Self.mChanges.Remove(Blueprint.BlueprintId)
		        End If
		      Next
		    End If
		  End If
		  
		  Var Group As ArkSA.BlueprintControllerTaskGroup = Self.FindGroupForTask(Task)
		  Var WasFinished As Boolean = (Group Is Nil) = False And Group.Finished = True
		  Self.CleanupTask(Task)
		  If (Group Is Nil) = False And WasFinished = False And Group.Finished = True Then
		    RaiseEvent PublishFinished(Group)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasUnpublishedChanges() As Boolean
		  Return Self.mChanges.KeyCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadBlueprints(Mode As Integer, Page As Integer, PageSize As Integer)
		  Var Task As New ArkSA.BlueprintControllerFetchTask(Mode, Page, PageSize)
		  Self.AddTask(Task)
		  
		  RaiseEvent FetchBlueprints(Task)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadCreatures(Page As Integer, PageSize As Integer)
		  Self.LoadBlueprints(Self.ModeCreatures, Page, PageSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadedBlueprintCount(Mode As Integer) As Integer
		  Var IncludeEngrams As Boolean = (Mode = Self.ModeEngrams)
		  Var IncludeCreatures As Boolean = (Mode = Self.ModeCreatures)
		  Var IncludeLootDrops As Boolean = (Mode = Self.ModeLootDrops)
		  Var IncludeSpawnPoints As Boolean = (Mode = Self.ModeSpawnPoints)
		  
		  Var Total As Integer
		  For Each Entry As DictionaryEntry In Self.mOriginalBlueprints
		    Var Blueprint As ArkSA.Blueprint = Entry.Value
		    Select Case Blueprint
		    Case IsA ArkSA.Engram
		      If IncludeEngrams Then
		        Total = Total + 1
		      End If
		    Case IsA ArkSA.Creature
		      If IncludeCreatures Then
		        Total = Total + 1
		      End If
		    Case IsA ArkSA.LootContainer
		      If IncludeLootDrops Then
		        Total = Total + 1
		      End If
		    Case IsA ArkSA.SpawnPoint
		      If IncludeSpawnPoints Then
		        Total = Total + 1
		      End If
		    End Select
		  Next
		  Return Total
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadEngrams(Page As Integer, PageSize As Integer)
		  Self.LoadBlueprints(Self.ModeEngrams, Page, PageSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadLootDrops(Page As Integer, PageSize As Integer)
		  Self.LoadBlueprints(Self.ModeLootDrops, Page, PageSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadSpawnPoints(Page As Integer, PageSize As Integer)
		  Self.LoadBlueprints(Self.ModeSpawnPoints, Page, PageSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OriginalBlueprint(BlueprintId As String) As ArkSA.Blueprint
		  If Self.mOriginalBlueprints.HasKey(BlueprintId) Then
		    Return Self.mOriginalBlueprints.Value(BlueprintId)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Publish()
		  If Self.IsBusy Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  Var SaveEngrams(), SaveCreatures(), SaveLootDrops(), SaveSpawnPoints() As ArkSA.Blueprint
		  Var DeleteEngrams(), DeleteCreatures(), DeleteLootDrops(), DeleteSpawnPoints() As String
		  
		  For Each Entry As DictionaryEntry In Self.mChanges
		    Var BlueprintId As String = Entry.Key
		    Var Value As Variant = Entry.Value
		    
		    If Value.Type = Variant.TypeString Then
		      Select Case Value.StringValue
		      Case ArkSA.CategoryEngrams
		        DeleteEngrams.Add(BlueprintId)
		      Case ArkSA.CategoryCreatures
		        DeleteCreatures.Add(BlueprintId)
		      Case ArkSA.CategoryLootContainers
		        DeleteLootDrops.Add(BlueprintId)
		      Case ArkSA.CategorySpawnPoints
		        DeleteSpawnPoints.Add(BlueprintId)
		      End Select
		    Else
		      Var Obj As Object = Value.ObjectValue
		      Select Case Obj
		      Case IsA ArkSA.Engram
		        SaveEngrams.Add(ArkSA.Engram(Obj))
		      Case IsA ArkSA.Creature
		        SaveCreatures.Add(ArkSA.Creature(Obj))
		      Case IsA ArkSA.LootContainer
		        SaveLootDrops.Add(ArkSA.LootContainer(Obj))
		      Case IsA ArkSA.SpawnPoint
		        SaveSpawnPoints.Add(ArkSA.SpawnPoint(Obj))
		      End Select
		    End If
		  Next
		  
		  Var Tasks() As ArkSA.BlueprintControllerPublishTask
		  If SaveEngrams.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeEngrams, SaveEngrams))
		  End If
		  If SaveCreatures.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeCreatures, SaveCreatures))
		  End If
		  If SaveLootDrops.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeLootDrops, SaveLootDrops))
		  End If
		  If SaveSpawnPoints.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeSpawnPoints, SaveSpawnPoints))
		  End If
		  If DeleteEngrams.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeEngrams, DeleteEngrams))
		  End If
		  If DeleteCreatures.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeCreatures, DeleteCreatures))
		  End If
		  If DeleteLootDrops.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeLootDrops, DeleteLootDrops))
		  End If
		  If DeleteSpawnPoints.Count > 0 Then
		    Tasks.Add(New ArkSA.BlueprintControllerPublishTask(Self.ModeSpawnPoints, DeleteSpawnPoints))
		  End If
		  
		  If Tasks.Count = 0 Then
		    Return
		  End If
		  
		  Self.AddTask(New ArkSA.BlueprintControllerTaskGroup(Tasks))
		  
		  RaiseEvent Publish(Tasks)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveBlueprint(Blueprint As ArkSA.Blueprint)
		  Var Blueprints(0) As ArkSA.Blueprint
		  Blueprints(0) = Blueprint
		  Self.SaveBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveBlueprints(Blueprints() As ArkSA.Blueprint)
		  If Self.IsBusy Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  Var BlueprintsSaved(), BlueprintsDeleted() As ArkSA.Blueprint
		  Var ContentPack As Beacon.ContentPack = Self.ContentPack
		  
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Var OriginalBlueprintId As String = Blueprint.BlueprintId
		    Var BlueprintId As String = Blueprint.BlueprintId
		    
		    If Blueprint.ContentPackId <> ContentPack.ContentPackId Then
		      // Need to adjust the mod info to match
		      BlueprintsDeleted.Add(Blueprint)
		      Var MutableVersion As ArkSA.MutableBlueprint = Blueprint.MutableVersion
		      MutableVersion.ContentPackId = ContentPack.ContentPackId
		      MutableVersion.ContentPackName = ContentPack.Name
		      MutableVersion.RegenerateBlueprintId()
		      BlueprintId = MutableVersion.BlueprintId
		      Blueprint = MutableVersion.ImmutableVersion
		    End If
		    
		    // If the blueprint id is unchanged, the first change will be replaced
		    Self.mChanges.Value(OriginalBlueprintId) = Blueprint.Category
		    Self.mChanges.Value(BlueprintId) = Blueprint
		    BlueprintsSaved.Add(Blueprint)
		  Next
		  
		  If Thread.Current Is Nil Then
		    RaiseEvent BlueprintsChanged(BlueprintsSaved, BlueprintsDeleted)
		  Else
		    Call CallLater.Schedule(1, WeakAddressOf TriggerBlueprintsChanged, New Dictionary("BlueprintsSaved": BlueprintsSaved, "BlueprintsDeleted": BlueprintsDeleted))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerBlueprintsChanged(Arg As Variant)
		  Var BlueprintsSaved() As ArkSA.Blueprint = Dictionary(Arg).Value("BlueprintsSaved")
		  Var BlueprintsDeleted() As ArkSA.Blueprint = Dictionary(Arg).Value("BlueprintsDeleted")
		  RaiseEvent BlueprintsChanged(BlueprintsSaved, BlueprintsDeleted)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseSaveTerminology() As Boolean
		  Return False
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BlueprintsChanged(BlueprintsSaved() As ArkSA.Blueprint, BlueprintsDeleted() As ArkSA.Blueprint)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BlueprintsLoaded(Task As ArkSA.BlueprintControllerFetchTask)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event FetchBlueprints(Task As ArkSA.BlueprintControllerFetchTask)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Publish(Tasks() As ArkSA.BlueprintControllerPublishTask)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PublishFinished(Task As ArkSA.BlueprintControllerTaskGroup)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkStarted()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPendingTasks.Count > 0
			End Get
		#tag EndGetter
		IsBusy As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCacheErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCacheErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChanges As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPack As Beacon.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingTasks() As ArkSA.BlueprintControllerTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublishing As Boolean
	#tag EndProperty


	#tag Constant, Name = FirstMode, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LastMode, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeCreatures, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeEngrams, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeLootDrops, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeSpawnPoints, Type = Double, Dynamic = False, Default = \"3", Scope = Public
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
		#tag ViewProperty
			Name="IsBusy"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
