#tag Class
Protected Class RemoteBlueprintController
Inherits BlueprintController
	#tag Event
		Sub Publish(BlueprintsToSave() As Beacon.Blueprint, BlueprintsToDelete() As Beacon.Blueprint)
		  Var Engrams(), Creatures(), SpawnPoints(), LootSources() As Dictionary
		  Var Deletions() As String
		  
		  For Each Blueprint As Beacon.Blueprint In BlueprintsToDelete
		    Deletions.Add(Blueprint.ObjectID)
		  Next
		  
		  For Each Blueprint As Beacon.Blueprint In BlueprintsToSave
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    Var Packed As Dictionary = Blueprint.Pack
		    
		    Select Case Blueprint
		    Case IsA Beacon.Engram
		      Engrams.Add(Packed)
		    Case IsA Beacon.Creature
		      Creatures.Add(Packed)
		    Case IsA Beacon.SpawnPoint
		      SpawnPoints.Add(Packed)
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
		  
		  Var Request As New BeaconAPI.Request("blueprint", "POST", Body, "application/json", WeakAddressOf APICallback_SaveBlueprints)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshBlueprints()
		  If Preferences.OnlineEnabled = False Then
		    Self.CacheBlueprints()
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request("blueprint?mod_id=" + EncodeURLComponent(Self.mModUUID), "GET", WeakAddressOf APICallback_LoadBlueprints)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_LoadBlueprints(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  #Pragma Warning "Errors are not handled nicely here."
		  
		  If Response.HTTPStatus <> 200 Then
		    Self.CacheBlueprints()
		    Return
		  End If
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		    Self.CacheBlueprints()
		    Return
		  End Try
		  
		  If Parsed.IsNull Or Parsed.Type <> Variant.TypeObject Or (Parsed.ObjectValue IsA Dictionary) = False Then
		    Self.CacheBlueprints()
		    Return
		  End If
		  
		  Var Blueprints() As Beacon.Blueprint
		  Var Dict As Dictionary = Parsed
		  
		  If Not Self.Unpack(Blueprints, Dict, "engrams") Then
		    Self.CacheBlueprints()
		  End If
		  If Not Self.Unpack(Blueprints, Dict, "creatures") Then
		    Self.CacheBlueprints()
		  End If
		  If Not Self.Unpack(Blueprints, Dict, "spawn_points") Then
		    Self.CacheBlueprints()
		  End If
		  If Not Self.Unpack(Blueprints, Dict, "loot_sources") Then
		    Self.CacheBlueprints()
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
		  
		  Self.FinishPublishing(False, "Other HTTP error: " + Response.HTTPStatus.ToString(Locale.Raw, "0"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ModUUID As String)
		  Self.mModUUID = ModUUID
		  Self.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Unpack(Blueprints() As Beacon.Blueprint, Dict As Dictionary, Key As String) As Boolean
		  If Dict.HasKey(Key) Then
		    Try
		      Var Definitions() As Dictionary = Dict.Value(Key).DictionaryArrayValue
		      For Each Definition As Dictionary In Definitions
		        Var Blueprint As Beacon.Blueprint = Beacon.UnpackBlueprint(Definition)
		        If (Blueprint Is Nil) = False Then
		          Blueprints.Add(Blueprint)
		        End If
		      Next
		    Catch Err As RuntimeException
		      Return False
		    End Try
		  End If
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mModUUID As String
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
