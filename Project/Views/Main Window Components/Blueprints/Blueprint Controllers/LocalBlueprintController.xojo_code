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
		    Self.FinishPublishing(False, "Only saved " + Format(NumSaved, "0,") + " of " + Format(BlueprintsToSave.Count, "0,") + " blueprints.")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshBlueprints()
		  Var Mods As New Beacon.StringList(0)
		  Mods(0) = LocalData.UserModID
		  
		  Self.CacheBlueprints(LocalData.SharedInstance.SearchForBlueprints("", "", Mods, ""))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AutoPublish() As Boolean
		  Return True
		End Function
	#tag EndMethod


End Class
#tag EndClass
