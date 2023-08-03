#tag Class
Protected Class BlueprintController
	#tag Method, Flags = &h21
		Private Sub AddTask(Task As Ark.BlueprintControllerTask)
		  Self.mPendingTasks.Add(Task)
		  If Self.mPendingTasks.Count = 1 Then
		    RaiseEvent WorkStarted()
		  End If
		End Sub
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
		Private Sub Constructor()
		  Self.mChanges = New Dictionary
		  Self.mOriginalBlueprints = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ContentPack As BeaconAPI.ContentPack)
		  Self.mContentPackId = ContentPack.ContentPackId
		  Self.mContentPackName = ContentPack.Name
		  Self.mMarketplace = ContentPack.Marketplace
		  Self.mMarketplaceId = ContentPack.MarketplaceId
		  Self.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackName() As String
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprint(ParamArray Blueprints() As Ark.Blueprint)
		  Self.DeleteBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprints(Blueprints() As Ark.Blueprint)
		  If Self.IsBusy Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Self.mChanges.Value(Blueprint.BlueprintId) = Blueprint.Category
		  Next
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
		Protected Function FindTask(TaskId As String) As Ark.BlueprintControllerTask
		  For Idx As Integer = 0 To Self.mPendingTasks.LastIndex
		    If Self.mPendingTasks(Idx).TaskId = TaskId Then
		      Return Self.mPendingTasks(Idx)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FinishTask(Task As Ark.BlueprintControllerFetchTask)
		  Var Clone() As Ark.Blueprint
		  Clone.ResizeTo(Task.Blueprints.LastIndex)
		  For Idx As Integer = 0 To Task.Blueprints.LastIndex
		    Clone(Idx) = Task.Blueprints(Idx)
		  Next
		  
		  RaiseEvent BlueprintsLoaded(Task)
		  
		  For Each Blueprint As Ark.Blueprint In Task.Blueprints
		    Self.mOriginalBlueprints.Value(Blueprint.BlueprintId) = Blueprint
		  Next
		  
		  For Idx As Integer = 0 To Self.mPendingTasks.LastIndex
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

	#tag Method, Flags = &h1
		Protected Sub FinishTask(Task As Ark.BlueprintControllerPublishTask)
		  If Task.Errored = False Then
		    If Task.DeleteMode Then
		      Var DeleteIds() As String = Task.DeleteIds
		      For Each Id As String In DeleteIds
		        If Self.mChanges.HasKey(Id) Then
		          Self.mChanges.Remove(Id)
		        End If
		      Next
		    Else
		      Var Blueprints() As Ark.Blueprint = Task.Blueprints
		      For Each Blueprint As Ark.Blueprint In Blueprints
		        If Self.mChanges.HasKey(Blueprint.BlueprintId) Then
		          Self.mChanges.Remove(Blueprint.BlueprintId)
		        End If
		      Next
		    End If
		  End If
		  
		  Var RemainingPublishTasks As Integer
		  For Idx As Integer = Self.mPendingTasks.LastIndex DownTo 0
		    If Self.mPendingTasks(Idx).TaskId = Task.TaskId Then
		      Self.mPendingTasks.RemoveAt(Idx)
		      Continue For Idx
		    End If
		    
		    If Self.mPendingTasks(Idx) IsA Ark.BlueprintControllerPublishTask Then
		      RemainingPublishTasks = RemainingPublishTasks + 1
		    End If
		  Next
		  
		  RaiseEvent PublishFinished(Task)
		  
		  If Self.mPendingTasks.Count = 0 Then
		    RaiseEvent WorkFinished()
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
		  Var Task As New Ark.BlueprintControllerFetchTask(Mode, Page, PageSize)
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
		    Var Blueprint As Ark.Blueprint = Entry.Value
		    Select Case Blueprint
		    Case IsA Ark.Engram
		      If IncludeEngrams Then
		        Total = Total + 1
		      End If
		    Case IsA Ark.Creature
		      If IncludeCreatures Then
		        Total = Total + 1
		      End If
		    Case IsA Ark.LootContainer
		      If IncludeLootDrops Then
		        Total = Total + 1
		      End If
		    Case IsA Ark.SpawnPoint
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
		Function Marketplace() As String
		  Return Self.mMarketplace
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MarketplaceId() As String
		  Return Self.mMarketplaceId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OriginalBlueprint(BlueprintId As String) As Ark.Blueprint
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
		  
		  Var SaveEngrams(), SaveCreatures(), SaveLootDrops(), SaveSpawnPoints() As Ark.Blueprint
		  Var DeleteEngrams(), DeleteCreatures(), DeleteLootDrops(), DeleteSpawnPoints() As String
		  
		  For Each Entry As DictionaryEntry In Self.mChanges
		    Var BlueprintId As String = Entry.Key
		    Var Value As Variant = Entry.Value
		    
		    If Value.Type = Variant.TypeString Then
		      Select Case Value.StringValue
		      Case Ark.CategoryEngrams
		        DeleteEngrams.Add(BlueprintId)
		      Case Ark.CategoryCreatures
		        DeleteCreatures.Add(BlueprintId)
		      Case Ark.CategoryLootContainers
		        DeleteLootDrops.Add(BlueprintId)
		      Case Ark.CategorySpawnPoints
		        DeleteSpawnPoints.Add(BlueprintId)
		      End Select
		    Else
		      Var Obj As Object = Value.ObjectValue
		      Select Case Obj
		      Case IsA Ark.Engram
		        SaveEngrams.Add(Ark.Engram(Obj))
		      Case IsA Ark.Creature
		        SaveCreatures.Add(Ark.Creature(Obj))
		      Case IsA Ark.LootContainer
		        SaveLootDrops.Add(Ark.LootContainer(Obj))
		      Case IsA Ark.SpawnPoint
		        SaveSpawnPoints.Add(Ark.SpawnPoint(Obj))
		      End Select
		    End If
		  Next
		  
		  Var Tasks() As Ark.BlueprintControllerPublishTask
		  If SaveEngrams.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeEngrams, SaveEngrams))
		  End If
		  If SaveCreatures.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeCreatures, SaveCreatures))
		  End If
		  If SaveLootDrops.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeLootDrops, SaveLootDrops))
		  End If
		  If SaveSpawnPoints.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeSpawnPoints, SaveSpawnPoints))
		  End If
		  If DeleteEngrams.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeEngrams, DeleteEngrams))
		  End If
		  If DeleteCreatures.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeCreatures, DeleteCreatures))
		  End If
		  If DeleteLootDrops.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeLootDrops, DeleteLootDrops))
		  End If
		  If DeleteSpawnPoints.Count > 0 Then
		    Tasks.Add(New Ark.BlueprintControllerPublishTask(Self.ModeSpawnPoints, DeleteSpawnPoints))
		  End If
		  
		  If Tasks.Count = 0 Then
		    Return
		  End If
		  
		  For Each Task As Ark.BlueprintControllerTask In Tasks
		    Self.AddTask(Task)
		  Next
		  
		  RaiseEvent Publish(Tasks)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveBlueprint(ParamArray Blueprints() As Ark.Blueprint)
		  Self.SaveBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveBlueprints(Blueprints() As Ark.Blueprint)
		  If Self.IsBusy Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Var OriginalBlueprintId As String = Blueprint.BlueprintId
		    Var BlueprintId As String = Blueprint.BlueprintId
		    
		    If Blueprint.ContentPackId <> Self.ContentPackId Then
		      // Need to adjust the mod info to match
		      Var MutableVersion As Ark.MutableBlueprint = Blueprint.MutableVersion
		      MutableVersion.ContentPackId = Self.ContentPackId
		      MutableVersion.ContentPackName = Self.ContentPackName
		      MutableVersion.RegenerateBlueprintId()
		      BlueprintId = MutableVersion.BlueprintId
		      Blueprint = MutableVersion.ImmutableVersion
		    End If
		    
		    // If the blueprint id is unchanged, the first change will be replaced
		    Self.mChanges.Value(OriginalBlueprintId) = Blueprint.Category
		    Self.mChanges.Value(BlueprintId) = Blueprint
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseSaveTerminology() As Boolean
		  Return False
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BlueprintsLoaded(Task As Ark.BlueprintControllerFetchTask)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event FetchBlueprints(Task As Ark.BlueprintControllerFetchTask)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Publish(Tasks() As Ark.BlueprintControllerPublishTask)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PublishFinished(Task As Ark.BlueprintControllerPublishTask)
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
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMarketplace As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMarketplaceId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingTasks() As Ark.BlueprintControllerTask
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
