#tag Class
Protected Class ConfigGroup
Implements Beacon.Validateable
	#tag Method, Flags = &h0
		Function Clone() As Beacon.ConfigGroup
		  Var Err As New UnsupportedOperationException
		  Err.Message = "Beacon.ConfigGroup.Clone must be overridden"
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SaveData As Dictionary, EncryptedData As Dictionary)
		  Self.Constructor()
		  Try
		    RaiseEvent ReadSaveData(SaveData, EncryptedData)
		    Self.mIsImplicit = SaveData.Lookup("Implicit", False)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Creating config group from source dictionary")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasContent() As Boolean
		  Return RaiseEvent HasContent()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDefaultImported() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsImplicit() As Boolean
		  If Self.mIsImplicit Then
		    Return Not RaiseEvent HasContent()
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsImplicit(Assigns Value As Boolean)
		  If Self.mIsImplicit <> Value Then
		    Self.mIsImplicit = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Migrate(SavedWithVersion As Integer, Project As Beacon.Project)
		  RaiseEvent Migrate(SavedWithVersion, Project)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  Try
		    RaiseEvent PruneUnknownContent(ContentPackIds)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Pruning a config group's content")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var SaveData As New Dictionary
		  Var EncryptedData As New Dictionary
		  SaveData.Value("Implicit") = Self.mIsImplicit
		  RaiseEvent WriteSaveData(SaveData, EncryptedData)
		  If EncryptedData.KeyCount > 0 Then
		    Var Temp As New Dictionary
		    Temp.Value("Plain") = SaveData
		    Temp.Value("Encrypted") = EncryptedData
		    SaveData = Temp
		  End If
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsConfigSets() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  // Part of the Beacon.Validateable interface.
		  
		  RaiseEvent Validate(Location + Beacon.Issue.Separator + Self.InternalName, Issues, Project)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event HasContent() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Migrate(SavedWithVersion As Integer, Project As Beacon.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PruneUnknownContent(ContentPackIds As Beacon.StringList)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mIsImplicit As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
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
	#tag EndViewBehavior
End Class
#tag EndClass
