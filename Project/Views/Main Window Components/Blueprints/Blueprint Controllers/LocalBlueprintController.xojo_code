#tag Class
Protected Class LocalBlueprintController
Inherits BlueprintController
	#tag Event
		Sub Publish(BlueprintsToSave() As Ark.Blueprint, BlueprintsToDelete() As Ark.Blueprint)
		  Var BlueprintMap As New Dictionary
		  For Idx As Integer = 0 To BlueprintsToSave.LastIndex
		    BlueprintMap.Value(BlueprintsToSave(Idx).ObjectID) = BlueprintsToSave(Idx)
		  Next Idx
		  For Idx As Integer = 0 To BlueprintsToDelete.LastIndex
		    BlueprintMap.Value(BlueprintsToDelete(Idx).ObjectID) = BlueprintsToDelete(Idx)
		  Next Idx
		  
		  Var Errors As New Dictionary
		  Var Success As Boolean = Ark.DataSource.SharedInstance.SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, Errors)
		  If Success Then
		    Self.FinishPublishing(True, "")
		  Else
		    Var Reasons() As String
		    For Each Entry As DictionaryEntry In Errors
		      Var Err As RuntimeException = Entry.Value
		      Var Blueprint As Ark.Blueprint = BlueprintMap.Value(Entry.Key)
		      
		      If Err.Message.BeginsWith("Unique constraint failed") Then
		        Reasons.Add(Blueprint.Label + ": A blueprint already exists with this path.")
		      Else
		        Reasons.Add(Blueprint.Label + ": Error #" + Err.ErrorNumber.ToString(Locale.Raw, "0") + " " + Err.Message.NthField(EndOfLine, 1))
		      End If
		    Next
		    Self.FinishPublishing(False, "The following blueprints had saving errors: " + EndOfLine + EndOfLine + Reasons.Join(EndOfLine))
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshBlueprints()
		  Var Mods As New Beacon.StringList(0)
		  Mods(0) = Self.ModID
		  
		  Var Blueprints() As Ark.Blueprint = Ark.DataSource.SharedInstance.GetBlueprints("", Mods, "")
		  
		  Self.CacheBlueprints(Blueprints)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function UseSaveTerminology() As Boolean
		  Return True
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
