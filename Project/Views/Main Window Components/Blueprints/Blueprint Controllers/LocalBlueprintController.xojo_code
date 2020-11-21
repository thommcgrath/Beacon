#tag Class
Protected Class LocalBlueprintController
Inherits BlueprintController
	#tag Event
		Sub Publish(BlueprintsToSave() As Beacon.Blueprint, BlueprintsToDelete() As Beacon.Blueprint)
		  LocalData.SharedInstance.DeleteBlueprints(BlueprintsToDelete)
		  
		  Var NumSaved As Integer = LocalData.SharedInstance.SaveBlueprints(BlueprintsToSave)
		  If NumSaved = BlueprintsToSave.Count Then
		    Self.FinishPublishing(True, "")
		  Else
		    Self.FinishPublishing(False, "Only saved " + NumSaved.ToString(Locale.Current, ",##0") + " of " + BlueprintsToSave.Count.ToString(Locale.Current, ",##0") + " blueprints.")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshBlueprints()
		  Var Mods As New Beacon.StringList(0)
		  Mods(0) = Beacon.UserModID
		  
		  Var Engrams() As Beacon.Blueprint = Beacon.Data.SearchForBlueprints(Beacon.CategoryEngrams, "", Mods, "")
		  Var Creatures() As Beacon.Blueprint = Beacon.Data.SearchForBlueprints(Beacon.CategoryCreatures, "", Mods, "")
		  Var Spawns() As Beacon.Blueprint = Beacon.Data.SearchForBlueprints(Beacon.CategorySpawnPoints, "", Mods, "")
		  
		  Var Blueprints() As Beacon.Blueprint = Engrams
		  Var Offset As Integer = Engrams.Count
		  Blueprints.ResizeTo((Engrams.Count + Creatures.Count + Spawns.Count) - 1)
		  For Idx As Integer = 0 To Creatures.LastIndex
		    Blueprints(Idx + Offset) = Creatures(Idx)
		  Next
		  Offset = Offset + Creatures.Count
		  For Idx As Integer = 0 To Spawns.LastIndex
		    Blueprints(Idx + Offset) = Spawns(Idx)
		  Next
		  
		  Self.CacheBlueprints(Blueprints)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AutoPublish() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  Return Beacon.UserModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  Return Beacon.UserModName
		End Function
	#tag EndMethod


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
