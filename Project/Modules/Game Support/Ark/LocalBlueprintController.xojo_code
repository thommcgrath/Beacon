#tag Class
Protected Class LocalBlueprintController
Inherits Ark.BlueprintController
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub FetchBlueprints(Task As Ark.BlueprintControllerFetchTask)
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
		Sub Publish(Tasks() As Ark.BlueprintControllerPublishTask)
		  For Each Task As Ark.BlueprintControllerPublishTask In Tasks
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
		  Var Task As Ark.BlueprintControllerFetchTask = Sender.UserData
		  Var Mods As New Beacon.StringList(Self.ContentPackId)
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  
		  Select Case Task.Mode
		  Case Self.ModeCreatures
		    Task.Blueprints = DataSource.GetCreatures("", Mods, Nil)
		  Case Self.ModeEngrams
		    Task.Blueprints = DataSource.GetEngrams("", Mods, Nil)
		  Case Self.ModeLootDrops
		    Task.Blueprints = DataSource.GetLootContainers("", Mods, Nil, True)
		  Case Self.ModeSpawnPoints
		    Task.Blueprints = DataSource.GetSpawnPoints("", Mods, Nil)
		  End Select
		  
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
		    
		    Var Task As Ark.BlueprintControllerFetchTask = Sender.UserData
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
		Private Sub PublishDelete(Task As Ark.BlueprintControllerPublishTask)
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(True)
		  Var Blueprints() As Ark.Blueprint
		  Var Errors As New Dictionary
		  Call DataSource.SaveBlueprints(Blueprints, Task.DeleteIds, Errors, True)
		  
		  If Errors.KeyCount > 0 Then
		    Var Reasons() As String
		    For Each Entry As DictionaryEntry In Errors
		      Var BlueprintId As String = Entry.Key
		      Var Blueprint As Ark.Blueprint = Self.OriginalBlueprint(BlueprintId)
		      If Blueprint Is Nil Then
		        // Not really an error, it never existed in the first place
		        Continue
		      End If
		      
		      Var Err As RuntimeException = Entry.Value
		      Reasons.Add(Blueprint.Label + ": Error #" + Err.ErrorNumber.ToString(Locale.Raw, "0") + " " + Err.Message.NthField(EndOfLine, 1))
		    Next
		    
		    If Reasons.Count > 0 Then
		      Task.Errored = True
		      Task.ErrorMessage = String.FromArray(Reasons, EndOfLine)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PublishSave(Task As Ark.BlueprintControllerPublishTask)
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(True)
		  Var Blueprints() As Ark.Blueprint = Task.Blueprints
		  Var DeleteIds() As String
		  Var Errors As New Dictionary
		  Call DataSource.SaveBlueprints(Blueprints, DeleteIds, Errors, True)
		  
		  If Errors.KeyCount > 0 Then
		    Var BlueprintMap As New Dictionary
		    For Each Blueprint As Ark.Blueprint In Blueprints
		      BlueprintMap.Value(Blueprint.BlueprintId) = Blueprint
		    Next
		    
		    Var Reasons() As String
		    For Each Entry As DictionaryEntry In Errors
		      Var BlueprintId As String = Entry.Key
		      Var Blueprint As Ark.Blueprint = BlueprintMap.Value(BlueprintId)
		      
		      Var Err As RuntimeException = Entry.Value
		      If Err.Message.BeginsWith("Unique constraint failed") Then
		        Reasons.Add(Blueprint.Label + ": A blueprint already exists with this path.")
		      Else
		        Reasons.Add(Blueprint.Label + ": Error #" + Err.ErrorNumber.ToString(Locale.Raw, "0") + " " + Err.Message.NthField(EndOfLine, 1))
		      End If
		    Next
		    
		    If Reasons.Count > 0 Then
		      Task.Errored = True
		      Task.ErrorMessage = String.FromArray(Reasons, EndOfLine)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PublishThread_Run(Sender As Beacon.Thread)
		  Var Task As Ark.BlueprintControllerPublishTask = Sender.UserData
		  Try
		    If Task.DeleteMode Then
		      Self.PublishDelete(Task)
		    Else
		      Self.PublishSave(Task)
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Publishing blueprint changes")
		    Task.Errored = True
		    Task.ErrorMessage = Err.Message
		  End Try
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
		    
		    Var Task As Ark.BlueprintControllerPublishTask = Sender.UserData
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

	#tag Method, Flags = &h0
		Function UseSaveTerminology() As Boolean
		  Return True
		End Function
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
