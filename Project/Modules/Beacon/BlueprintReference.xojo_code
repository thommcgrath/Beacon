#tag Class
Protected Class BlueprintReference
	#tag Method, Flags = &h0
		Function ClassString() As String
		  If (Self.mBlueprint Is Nil) = False Then
		    Return Self.mBlueprint.ClassString
		  Else
		    Return Self.mSaveData.Value("Class")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Blueprint As Beacon.Blueprint)
		  Self.mBlueprint = Blueprint
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(SaveData As Dictionary)
		  Self.mSaveData = SaveData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSaveData(Blueprint As Beacon.Blueprint) As Dictionary
		  Var Ref As New Beacon.BlueprintReference(Blueprint)
		  Return Ref.SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.BlueprintReference
		  If Dict Is Nil Or Dict.HasKey("Version") = False Then
		    Return Nil
		  End If
		  
		  Return New Beacon.BlueprintReference(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCreature() As Boolean
		  Return Self.Kind = Self.KindCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEngram() As Boolean
		  Return Self.Kind = Self.KindEngram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSpawnPoint() As Boolean
		  Return Self.Kind = Self.KindSpawnPoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Kind() As String
		  If (Self.mSaveData Is Nil) = False Then
		    Return Self.mSaveData.Value("Kind")
		  End If
		  
		  Select Case Self.mBlueprint
		  Case IsA Beacon.Engram
		    Return Self.KindEngram
		  Case IsA Beacon.Creature
		    Return Self.KindCreature
		  Case IsA Beacon.SpawnPoint
		    Return Self.KindSpawnPoint
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  If (Self.mBlueprint Is Nil) = False Then
		    Return Self.mBlueprint.ObjectID
		  Else
		    Return Self.mSaveData.Value("UUID")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Blueprint) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.ObjectID = Other.ObjectID Then
		    Return 0
		  End If
		  
		  Return Self.ObjectID.Compare(Other.ObjectID, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.BlueprintReference) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.ObjectID = Other.ObjectID Then
		    Return 0
		  End If
		  
		  Return Self.ObjectID.Compare(Other.ObjectID, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Resolve() As Beacon.Blueprint
		  If Self.mBlueprint Is Nil Then
		    Try
		      Var Version As Integer = Self.mSaveData.Value("Version")
		      Select Case Version
		      Case 1
		        Var Kind As String = Self.mSaveData.Value("Kind")
		        Select Case Kind
		        Case Self.KindEngram
		          Self.mBlueprint = Beacon.ResolveEngram(Self.mSaveData, "UUID", "Path", "", Nil)
		        Case Self.KindCreature
		          Self.mBlueprint = Beacon.ResolveCreature(Self.mSaveData, "UUID", "Path", "", Nil)
		        Case Self.KindSpawnPoint
		          Self.mBlueprint = Beacon.ResolveSpawnPoint(Self.mSaveData, "UUID", "Path", "", Nil)
		        End Select
		      End Select
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Self.mBlueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  If Self.mSaveData Is Nil Then
		    Var Dict As New Dictionary
		    Dict.Value("Version") = Self.Version
		    Select Case Self.mBlueprint
		    Case IsA Beacon.Engram
		      Dict.Value("Kind") = Self.KindEngram
		    Case IsA Beacon.Creature
		      Dict.Value("Kind") = Self.KindCreature
		    Case IsA Beacon.SpawnPoint
		      Dict.Value("Kind") = Self.KindSpawnPoint
		    End Select
		    Dict.Value("UUID") = Self.mBlueprint.ObjectID
		    Dict.Value("Path") = Self.mBlueprint.Path
		    Dict.Value("Class") = Self.mBlueprint.ClassString
		    Dict.Value("ModUUID") = Self.mBlueprint.ModID
		    Self.mSaveData = Dict
		  End If
		  Return Self.mSaveData
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprint As Beacon.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveData As Dictionary
	#tag EndProperty


	#tag Constant, Name = KindCreature, Type = String, Dynamic = False, Default = \"Creature", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindEngram, Type = String, Dynamic = False, Default = \"Engram", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindSpawnPoint, Type = String, Dynamic = False, Default = \"Spawn Point", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


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
			Name="mBlueprint"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
