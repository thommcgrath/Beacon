#tag Class
Protected Class LocalBlueprintController
Inherits BlueprintController
	#tag Event
		Sub Publish(BlueprintsToSave() As Beacon.Blueprint, BlueprintsToDelete() As Beacon.Blueprint)
		  Var Errors As New Dictionary
		  Var Success As Boolean = Beacon.Data.SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, Errors)
		  If Success Then
		    Self.FinishPublishing(True, "")
		  Else
		    Var Reasons() As String
		    For Each Entry As DictionaryEntry In Errors
		      Var Blueprint As Beacon.Blueprint = Entry.Key
		      Var Err As RuntimeException = Entry.Value
		      
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
		  Mods(0) = Beacon.UserModID
		  
		  Var Blueprints() As Beacon.Blueprint = Beacon.Data.SearchForBlueprints("", Mods, "")
		  
		  Self.CacheBlueprints(Blueprints)
		End Sub
	#tag EndEvent


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
