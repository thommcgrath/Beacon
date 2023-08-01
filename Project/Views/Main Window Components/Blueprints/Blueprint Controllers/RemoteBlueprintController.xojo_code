#tag Class
Protected Class RemoteBlueprintController
Inherits BlueprintController
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub FetchBlueprints(Page As Integer, PageSize As Integer)
		  If Preferences.OnlineEnabled = False Then
		    Self.CacheBlueprints()
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request("ark/blueprints?contentPackId=" + EncodeURLComponent(Self.ContentPackId) + "&page=" + Page.ToString(Locale.Raw, "0") + "&pageSize=" + PageSize.ToString(Locale.Raw, "0"), "GET", WeakAddressOf APICallback_LoadBlueprints)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Publish(BlueprintsToSave() As Ark.Blueprint, BlueprintsToDelete() As Ark.Blueprint)
		  Var Engrams(), Creatures(), SpawnPoints(), LootSources() As Dictionary
		  Var Deletions() As String
		  
		  For Each Blueprint As Ark.Blueprint In BlueprintsToDelete
		    Deletions.Add(Blueprint.BlueprintId)
		  Next
		  
		  For Each Blueprint As Ark.Blueprint In BlueprintsToSave
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    Var Packed As Dictionary = Ark.PackBlueprint(Blueprint)
		    
		    Select Case Blueprint
		    Case IsA Ark.Engram
		      Engrams.Add(Packed)
		    Case IsA Ark.Creature
		      Creatures.Add(Packed)
		    Case IsA Ark.SpawnPoint
		      SpawnPoints.Add(Packed)
		    Case IsA Ark.LootContainer
		      LootSources.Add(Packed)
		    End Select
		  Next
		  
		  Var Dict As New Dictionary
		  If Engrams.Count > 0 Then
		    Dict.Value("engrams") = Engrams
		  End If
		  If Creatures.Count > 0 Then
		    Dict.Value("creatures") = Creatures
		  End If
		  If SpawnPoints.Count > 0 Then
		    Dict.Value("spawn_points") = SpawnPoints
		  End If
		  If LootSources.Count > 0 Then
		    Dict.Value("loot_sources") = LootSources
		  End If
		  If Deletions.Count > 0 Then
		    Dict.Value("deletions") = Deletions
		  End If
		  
		  If Dict.KeyCount = 0 Then
		    Self.FinishPublishing(True, "There was no work to do.")
		    Return
		  End If
		  
		  Var Body As String
		  Try
		    Body = Beacon.GenerateJSON(Dict, False)
		  Catch Err As RuntimeException
		    Self.FinishPublishing(False, "Could not prepare changes for server: " + Err.Message)
		    Return
		  End Try
		  
		  Var Request As New BeaconAPI.Request("ark/blueprints", "POST", Body, "application/json", WeakAddressOf APICallback_SaveBlueprints)
		  BeaconAPI.Send(Request)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_LoadBlueprints(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus <> 200 Then
		    Self.CacheError(Response.Message)
		    Return
		  End If
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		    Self.CacheError(Err.Message)
		    Return
		  End Try
		  
		  If Parsed.IsNull Or Parsed.Type <> Variant.TypeObject Or (Parsed.ObjectValue IsA Dictionary) = False Then
		    Self.CacheError("Invalid object type returned.")
		    Return
		  End If
		  
		  Var Blueprints() As Ark.Blueprint
		  Var Dict As Dictionary = Parsed
		  Self.mTotalResults = Dict.Value("totalResults")
		  Var Results() As Variant = Dict.Value("results")
		  
		  If Not Self.Unpack(Results, Blueprints) Then
		    Return
		  End If
		  
		  Self.CacheBlueprints(Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_SaveBlueprints(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus >= 200 And Response.HTTPStatus < 300 Then
		    Self.FinishPublishing(True, "")
		    Return
		  End If
		  
		  If Response.HTTPStatus = 401 Or Response.HTTPStatus = 403 Then
		    Self.FinishPublishing(False, "Authorization failed. Try signing out and signing back in.")
		    Return
		  End If
		  
		  If Response.Message.IsEmpty Then
		    Self.FinishPublishing(False, "Other HTTP error: " + Response.HTTPStatus.ToString(Locale.Raw, "0"))
		    #if DebugBuild
		      System.DebugLog(Response.Content)
		    #endif
		  Else
		    Self.FinishPublishing(False, Response.Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintCount() As Integer
		  Return Self.mTotalResults
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Unpack(Definitions() As Variant, Blueprints() As Ark.Blueprint) As Boolean
		  Try
		    For Each Definition As Dictionary In Definitions
		      Var Blueprint As Ark.Blueprint = Ark.UnpackBlueprint(Definition)
		      If (Blueprint Is Nil) = False Then
		        Blueprints.Add(Blueprint)
		      End If
		    Next
		    Return True
		  Catch Err As RuntimeException
		    Self.CacheError(Err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mTotalResults As Integer
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
