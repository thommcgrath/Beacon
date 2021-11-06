#tag Class
Protected Class LootItemSetEntryOption
Implements Beacon.Validateable
	#tag Method, Flags = &h0
		Sub Constructor(Reference As Ark.BlueprintReference, Weight As Double)
		  Self.mEngram = Reference
		  Self.mWeight = Weight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engram As Ark.Engram, Weight As Double)
		  Self.Constructor(New Ark.BlueprintReference(Engram), Weight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.LootItemSetEntryOption)
		  Self.mEngram = Source.mEngram
		  Self.mHash = Source.mHash
		  Self.mWeight = Source.mWeight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Ark.Engram
		  Return Ark.Engram(Self.mEngram.Resolve).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Ark.LootItemSetEntryOption
		  Var Weight As Double = 0.5
		  Try
		    Weight = Dict.Value("Weight")
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Weight value")
		  End Try
		  
		  Var Option As Ark.LootItemSetEntryOption
		  If Dict.HasKey("Blueprint") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(Dict.Value("Blueprint"))
		    If Reference Is Nil Then
		      Return Nil
		    End If
		    Option = New Ark.LootItemSetEntryOption(Reference, Weight)
		  ElseIf Dict.HasAnyKey("UUID", "Path", "Class") Then
		    Var Engram As Ark.Engram = Ark.ResolveEngram(Dict, "UUID", "Path", "Class", Nil)
		    If Engram Is Nil Then
		      Return Nil
		    End If
		    Option = New Ark.LootItemSetEntryOption(Engram, Weight)
		  End If
		  
		  Return Option
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.mHash.IsEmpty Then
		    Self.mHash = Beacon.Hash(Self.mEngram.ObjectID.Lowercase + "@" + Self.mWeight.ToString(Locale.Raw, "0.0000"))
		  End If
		  
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.LootItemSetEntryOption) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var SelfHash As String = Self.Hash
		  Var OtherHash As String = Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reference() As Ark.BlueprintReference
		  Return Self.mEngram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Keys As New Dictionary
		  Keys.Value("Blueprint") = Self.mEngram.SaveData
		  Keys.Value("Weight") = Self.mWeight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  // Part of the Beacon.Validateable interface.
		  
		  Try
		    Var ObjectID As String = Self.mEngram.ObjectID
		    Location = Location + "." + ObjectID
		    If Issues.HasIssue(Location) Then
		      Return
		    End If
		    
		    Var Engram As Ark.Engram = Self.Engram
		    If Project IsA Ark.Project And Ark.Project(Project).ContentPackEnabled(Engram.ContentPackUUID) = False Then
		      Issues.Add(New Beacon.Issue(Location, "'" + Engram.Label + "' is provided by the '" + Engram.ContentPackName + "' mod, which is turned off for this project."))
		    ElseIf Engram.IsTagged("Generic") Or Engram.IsTagged("Blueprint") Then
		      Issues.Add(New Beacon.Issue(Location, "'" + Engram.Label + "' is a generic item intended for crafting recipies and cannot spawn in a drop."))
		    End If
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngram As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeight As Double
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
