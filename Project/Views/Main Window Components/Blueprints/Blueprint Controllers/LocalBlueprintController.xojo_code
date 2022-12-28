#tag Class
Protected Class LocalBlueprintController
Inherits BlueprintController
	#tag Event
		Sub Publish(BlueprintsToSave() As Ark.Blueprint, BlueprintsToDelete() As Ark.Blueprint)
		  Self.mSave = BlueprintsToSave
		  Self.mDelete = BlueprintsToDelete
		  Self.mSaveThread = New Thread
		  AddHandler Self.mSaveThread.Run, WeakAddressOf mSaveThread_Run
		  AddHandler Self.mSaveThread.UserInterfaceUpdate, WeakAddressOf mSaveThread_UserInterfaceUpdate
		  Self.mSaveThread.Start
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


	#tag Method, Flags = &h21
		Private Sub mSaveThread_Run(Sender As Thread)
		  Var Database As Ark.DataSource = Ark.DataSource.SharedInstance(Ark.DataSource.CommonFlagsWritable)
		  
		  Var Errors As New Dictionary
		  Var Success As Boolean = Database.SaveBlueprints(Self.mSave, Self.mDelete, Errors)
		  If Success Then
		    Self.mSave.ResizeTo(-1)
		    Self.mDelete.ResizeTo(-1)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Action": "Save Complete", "Success": True))
		    Return
		  End If
		  
		  Var BlueprintMap As New Dictionary
		  For Idx As Integer = 0 To Self.mSave.LastIndex
		    BlueprintMap.Value(Self.mSave(Idx).ObjectID) = Self.mSave(Idx)
		  Next Idx
		  For Idx As Integer = 0 To Self.mDelete.LastIndex
		    BlueprintMap.Value(Self.mDelete(Idx).ObjectID) = Self.mDelete(Idx)
		  Next Idx
		  
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
		  
		  Self.mSave.ResizeTo(-1)
		  Self.mDelete.ResizeTo(-1)
		  Sender.AddUserInterfaceUpdate(New Dictionary("Action": "Save Complete", "Success": False, "Reasons": Reasons))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSaveThread_UserInterfaceUpdate(Sender As Thread, Dictionaries() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Dict As Dictionary In Dictionaries
		    Var Action As String = Dict.Lookup("Action", "").StringValue
		    
		    Select Case Action
		    Case "Save Complete"
		      Var Success As Boolean = Dict.Value("Success")
		      If Success Then
		        Self.FinishPublishing(True, "")
		      Else
		        Var Reasons() As String = Dict.Value("Reasons")
		        Self.FinishPublishing(False, "The following blueprints had saving errors: " + EndOfLine + EndOfLine + Reasons.Join(EndOfLine))
		      End If
		    End Select
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseSaveTerminology() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDelete() As Ark.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSave() As Ark.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveThread As Thread
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
