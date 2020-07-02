#tag Class
Protected Class RemoteBlueprintController
Inherits BlueprintController
	#tag Event
		Sub Publish(BlueprintsToSave() As Beacon.Blueprint, BlueprintsToDelete() As Beacon.Blueprint)
		  If BlueprintsToDelete.Count > 0 Then
		    Var UUIDs() As String
		    For Each Blueprint As Beacon.Blueprint In BlueprintsToDelete
		      UUIDs.AddRow(Blueprint.ObjectID)
		    Next
		    
		    Self.mPendingDeleteRequest = New BeaconAPI.Request("engram", "DELETE", UUIDs.Join(","), "text/plain", WeakAddressOf APICallback_DeleteBlueprints)
		  End If
		  
		  If BlueprintsToSave.Count > 0 Then
		    Var SaveDictionaries() As Dictionary
		    For Each Blueprint As Beacon.Blueprint In BlueprintsToSave
		      Var Dict As Dictionary = Beacon.PackBlueprint(Blueprint)
		      If (Dict Is Nil) = False Then
		        SaveDictionaries.AddRow(Dict)
		      End If
		    Next
		    
		    Var Body As String
		    Try
		      Body = Beacon.GenerateJSON(SaveDictionaries, False)
		    Catch Err As RuntimeException
		      Self.FinishPublishing(False, "Could not prepare changes for server: " + Err.Message)
		      Return
		    End Try
		    
		    Var Request As New BeaconAPI.Request("engram", "POST", Body, "application/json", WeakAddressOf APICallback_SaveBlueprints)
		    Request.Authenticate(Preferences.OnlineToken)
		    BeaconAPI.Send(Request)
		  ElseIf (Self.mPendingDeleteRequest Is Nil) = False Then
		    Self.SendDeleteRequest()
		  Else
		    Self.FinishPublishing(True, "There was no work to do.")
		  End If
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshBlueprints()
		  If Preferences.OnlineEnabled = False Then
		    Var Blueprints() As Beacon.Blueprint
		    Self.CacheBlueprints(Blueprints)
		    Return
		  End If
		  
		  Self.mLoadedBlueprints.ResizeTo(-1)
		  
		  Var Request As New BeaconAPI.Request("engram?mod_id=" + EncodeURLComponent(Self.mModUUID), "GET", WeakAddressOf APICallback_LoadEngrams)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteBlueprints(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus >= 200 And Response.HTTPStatus < 300 Then
		    Self.FinishPublishing(True, "")
		    Return
		  End If
		  
		  Self.mPendingDeleteRequest = Nil
		  
		  If Response.HTTPStatus = 401 Or Response.HTTPStatus = 403 Then
		    Self.FinishPublishing(False, "Authorization failed. Try signing out and signing back in.")
		    Return
		  End If
		  
		  Self.FinishPublishing(False, "Other HTTP error: " + Str(Response.HTTPStatus, "0"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_LoadCreatures(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus <> 200 Then
		    Self.CacheBlueprints(Self.mLoadedBlueprints)
		    Return
		  End If
		  
		  Var Objects() As Dictionary
		  Try
		    Objects = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		  End Try
		  
		  For Each Obj As Variant In Objects
		    Try
		      If (Obj IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var Dict As Dictionary = Obj
		      Var Blueprint As Beacon.MutableBlueprint = Beacon.UnpackBlueprint(Dict)
		      If (Blueprint Is Nil) = False Then
		        Self.mLoadedBlueprints.AddRow(Blueprint)
		      End If
		    Catch Err As RuntimeException
		      Continue
		    End Try
		  Next
		  
		  Var NextRequest As New BeaconAPI.Request("spawn_point?mod_id=" + EncodeURLComponent(Self.mModUUID), "GET", WeakAddressOf APICallback_LoadSpawnPoints)
		  NextRequest.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(NextRequest) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_LoadEngrams(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus <> 200 Then
		    Self.CacheBlueprints(Self.mLoadedBlueprints)
		    Return
		  End If
		  
		  Var Objects() As Dictionary
		  Try
		    Objects = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		  End Try
		  
		  For Each Obj As Variant In Objects
		    Try
		      If (Obj IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var Dict As Dictionary = Obj
		      Var Blueprint As Beacon.MutableBlueprint = Beacon.UnpackBlueprint(Dict)
		      If (Blueprint Is Nil) = False Then
		        Self.mLoadedBlueprints.AddRow(Blueprint)
		      End If
		    Catch Err As RuntimeException
		      Continue
		    End Try
		  Next
		  
		  Var NextRequest As New BeaconAPI.Request("creature?mod_id=" + EncodeURLComponent(Self.mModUUID), "GET", WeakAddressOf APICallback_LoadCreatures)
		  NextRequest.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(NextRequest)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_LoadSpawnPoints(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus <> 200 Then
		    Self.CacheBlueprints(Self.mLoadedBlueprints)
		    Return
		  End If
		  
		  Var Objects() As Dictionary
		  Try
		    Objects = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		  End Try
		  
		  For Each Obj As Variant In Objects
		    Try
		      If (Obj IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var Dict As Dictionary = Obj
		      Var Blueprint As Beacon.MutableBlueprint = Beacon.UnpackBlueprint(Dict)
		      If (Blueprint Is Nil) = False Then
		        Self.mLoadedBlueprints.AddRow(Blueprint)
		      End If
		    Catch Err As RuntimeException
		      Continue
		    End Try
		  Next
		  
		  Self.CacheBlueprints(Self.mLoadedBlueprints)
		  Self.mLoadedBlueprints.ResizeTo(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_SaveBlueprints(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus >= 200 And Response.HTTPStatus < 300 Then
		    If (Self.mPendingDeleteRequest Is Nil) = False Then
		      Self.SendDeleteRequest()
		    Else
		      Self.FinishPublishing(True, "")
		    End If
		    Return
		  End If
		  
		  Self.mPendingDeleteRequest = Nil
		  
		  If Response.HTTPStatus = 401 Or Response.HTTPStatus = 403 Then
		    Self.FinishPublishing(False, "Authorization failed. Try signing out and signing back in.")
		    Return
		  End If
		  
		  Self.FinishPublishing(False, "Other HTTP error: " + Str(Response.HTTPStatus, "0"))
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
		Private Sub SendDeleteRequest()
		  If Self.mPendingDeleteRequest Is Nil Then
		    Return
		  End If
		  
		  Self.mPendingDeleteRequest.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Self.mPendingDeleteRequest)
		  Self.mPendingDeleteRequest = Nil
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLoadedBlueprints() As Beacon.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModUUID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingDeleteRequest As BeaconAPI.Request
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
