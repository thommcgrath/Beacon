#tag Class
Protected Class BlueprintController
	#tag Method, Flags = &h0
		Function Blueprint(BlueprintId As String) As Ark.Blueprint
		  If Self.mBlueprints.HasKey(BlueprintId) Then
		    Return Self.mBlueprints.Value(BlueprintId)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintCount() As Integer
		  Return Self.mBlueprints.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Blueprints() As Ark.Blueprint()
		  Var Results() As Ark.Blueprint
		  For Each Entry As DictionaryEntry In Self.mBlueprints
		    Results.Add(Entry.Value)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CacheBlueprints()
		  // This is a convenience method to finish loading an empty set.
		  Var Blueprints() As Ark.Blueprint
		  Self.CacheBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CacheBlueprints(Blueprints() As Ark.Blueprint)
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Self.mBlueprints.Value(Blueprint.BlueprintId) = Blueprint
		    Self.mOriginalBlueprints.Value(Blueprint.BlueprintId) = Blueprint
		  Next
		  
		  Self.mCacheErrored = False
		  Self.mCacheErrorMessage = ""
		  Self.mLoading = False
		  RaiseEvent BlueprintsLoaded()
		  RaiseEvent WorkFinished()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CacheError(Message As String)
		  Self.mBlueprints.RemoveAll
		  Self.mOriginalBlueprints.RemoveAll
		  
		  Self.mCacheErrored = True
		  Self.mCacheErrorMessage = Message
		  Self.mLoading = False
		  RaiseEvent BlueprintsLoaded()
		  RaiseEvent WorkFinished()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CacheErrored() As Boolean
		  Return Self.mCacheErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CacheErrorMessage() As String
		  Return Self.mCacheErrorMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.mBlueprints = New Dictionary
		  Self.mBlueprintsToSave = New Dictionary
		  Self.mBlueprintsToDelete = New Dictionary
		  Self.mOriginalBlueprints = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ContentPackId As String, Name As String)
		  Self.mContentPackId = ContentPackId
		  Self.mContentPackName = Name
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
		Function Creatures() As Ark.Creature()
		  Var Results() As Ark.Creature
		  For Each Entry As DictionaryEntry In Self.mBlueprints
		    If Entry.Value IsA Ark.Creature Then
		      Results.Add(Entry.Value)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprint(ParamArray Blueprints() As Ark.Blueprint)
		  Self.DeleteBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprints(Blueprints() As Ark.Blueprint)
		  If Self.IsWorking Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Var BlueprintId As String = Blueprint.BlueprintId
		    
		    If Self.mBlueprints.HasKey(BlueprintId) Then
		      Self.mBlueprints.Remove(BlueprintId)
		    End If
		    If Self.mBlueprintsToSave.HasKey(BlueprintId) Then
		      Self.mBlueprintsToSave.Remove(BlueprintId)
		    End If
		    
		    Self.mBlueprintsToDelete.Value(BlueprintId) = Blueprint
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DiscardChanges()
		  If Self.IsWorking Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  Self.mBlueprints = Self.mOriginalBlueprints.Clone
		  Self.mBlueprintsToSave = New Dictionary
		  Self.mBlueprintsToDelete = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Ark.Engram()
		  Var Results() As Ark.Engram
		  For Each Entry As DictionaryEntry In Self.mBlueprints
		    If Entry.Value IsA Ark.Engram Then
		      Results.Add(Entry.Value)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FinishPublishing(Success As Boolean, ErrorMessage As String)
		  Self.mPublishing = False
		  
		  If Success Then
		    Self.mBlueprintsToSave = New Dictionary
		    Self.mBlueprintsToDelete = New Dictionary
		  End If
		  
		  RaiseEvent WorkFinished()
		  RaiseEvent PublishFinished(Success, ErrorMessage)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasUnpublishedChanges() As Boolean
		  Return Self.mBlueprintsToSave.KeyCount > 0 Or Self.mBlueprintsToDelete.KeyCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadBlueprints(Page As Integer, PageSize As Integer)
		  If Self.IsWorking Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  Self.mLoading = True
		  
		  RaiseEvent WorkStarted()
		  
		  If Page = 1 Then
		    Self.mBlueprints.RemoveAll
		    Self.mOriginalBlueprints.RemoveAll
		  End If
		  
		  If IsEventImplemented("FetchBlueprints") Then
		    RaiseEvent FetchBlueprints(Page, PageSize)
		  Else
		    Var Blueprints() As Ark.Blueprint
		    Self.CacheBlueprints(Blueprints)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootContainers() As Ark.LootContainer()
		  Var Results() As Ark.LootContainer
		  For Each Entry As DictionaryEntry In Self.mBlueprints
		    If Entry.Value IsA Ark.LootContainer Then
		      Results.Add(Entry.Value)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Publish()
		  If Self.IsWorking Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Another action is already running"
		    Raise Err
		  End If
		  
		  Self.mPublishing = True
		  
		  RaiseEvent WorkStarted()
		  
		  If IsEventImplemented("Publish") Then 
		    Var BlueprintsToSave(), BlueprintsToDelete() As Ark.Blueprint
		    For Each Entry As DictionaryEntry In Self.mBlueprintsToSave
		      BlueprintsToSave.Add(Entry.Value)
		    Next
		    For Each Entry As DictionaryEntry In Self.mBlueprintsToDelete
		      BlueprintsToDelete.Add(Entry.Value)
		    Next
		    
		    RaiseEvent Publish(BlueprintsToSave, BlueprintsToDelete)
		  Else
		    Self.FinishPublishing(False, "The code to perform this action is unfinished.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveBlueprint(ParamArray Blueprints() As Ark.Blueprint)
		  Self.SaveBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveBlueprints(Blueprints() As Ark.Blueprint)
		  If Self.IsWorking Then
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
		    
		    Self.mBlueprints.Value(BlueprintId) = Blueprint
		    Self.mBlueprintsToSave.Value(BlueprintId) = Blueprint
		    
		    If Self.mBlueprintsToDelete.HasKey(BlueprintId) Then
		      Self.mBlueprintsToDelete.Remove(BlueprintId)
		    End If
		    
		    If BlueprintId <> OriginalBlueprintId And Self.mBlueprintsToDelete.HasKey(OriginalBlueprintId) Then
		      Self.mBlueprintsToDelete.Remove(OriginalBlueprintId)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPoints() As Ark.SpawnPoint()
		  Var Results() As Ark.SpawnPoint
		  For Each Entry As DictionaryEntry In Self.mBlueprints
		    If Entry.Value IsA Ark.SpawnPoint Then
		      Results.Add(Entry.Value)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseSaveTerminology() As Boolean
		  Return False
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BlueprintsLoaded()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event FetchBlueprints(Page As Integer, PageSize As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Publish(BlueprintsToSave() As Ark.Blueprint, BlueprintsToDelete() As Ark.Blueprint)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PublishFinished(Success As Boolean, Reason As String)
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
			  Return Self.mLoading
			End Get
		#tag EndGetter
		IsLoading As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPublishing
			End Get
		#tag EndGetter
		IsPublishing As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLoading Or Self.mPublishing
			End Get
		#tag EndGetter
		IsWorking As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBlueprintsToDelete As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBlueprintsToSave As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCacheErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCacheErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoading As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublishing As Boolean
	#tag EndProperty


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
			Name="IsLoading"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsPublishing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWorking"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
