#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class CraftingCosts
Inherits Beacon.ConfigGroup
	#tag Event
		Sub DetectIssues(Document As Beacon.Document, Issues() As Beacon.Issue)
		  #Pragma Unused Document
		  
		  Var ConfigName As String = ConfigKey
		  For I As Integer = 0 To Self.mCosts.LastRowIndex
		    If Self.mCosts(I).IsValid Then
		      Continue
		    End If
		    
		    If Self.mCosts(I).Engram = Nil Then
		      Issues.AddRow(New Beacon.Issue(ConfigName, "Crafting cost has no engram", Self.mCosts(I)))
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  For Each Cost As Beacon.CraftingCost In Self.mCosts
		    If IsNull(Cost.Engram) = False And Cost.Engram.ValidForMask(Profile.Mask) And Cost.Engram.ValidForMods(SourceDocument.Mods) Then
		      Var StringValue As String = Cost.StringValue
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemCraftingCosts", StringValue))
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  Var Source As BeaconConfigs.CraftingCosts = BeaconConfigs.CraftingCosts(Other)
		  For Idx As Integer = 0 To Source.LastRowIndex
		    Self.Append(Source(Idx))
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Costs") Then
		    Var Costs() As Variant = Dict.Value("Costs")
		    For Each CostData As Dictionary In Costs
		      Var Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromBeacon(CostData)
		      If Cost <> Nil Then
		        Self.mCosts.AddRow(Cost)
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Var Costs() As Dictionary
		  For Each Cost As Beacon.CraftingCost In Self.mCosts
		    Costs.AddRow(Cost.Export)
		  Next
		  Dict.Value("Costs") = Costs
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(Cost As Beacon.CraftingCost)
		  If Cost = Nil Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Cost)
		  If Idx = -1 Then
		    Self.mCosts.AddRow(Cost)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return ConfigKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.CraftingCosts
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If Not ParsedData.HasKey("ConfigOverrideItemCraftingCosts") Then
		    Return Nil
		  End If
		  
		  Var Values As Variant = ParsedData.Value("ConfigOverrideItemCraftingCosts")
		  Var ValuesInfo As Introspection.TypeInfo = Introspection.GetType(Values)
		  Var Overrides() As Variant
		  If ValuesInfo.FullName = "Object()" Then
		    Overrides = Values
		  ElseIf ValuesInfo.FullName = "Dictionary" Then
		    Overrides.AddRow(Values)
		  Else
		    Return Nil
		  End If
		  
		  Var Config As New BeaconConfigs.CraftingCosts
		  For Each Dict As Dictionary In Overrides
		    Var Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromConfig(Dict)
		    If Cost <> Nil Then
		      Config.Append(Cost)
		    End If
		  Next
		  If Config.LastRowIndex > -1 Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Cost As Beacon.CraftingCost) As Integer
		  If Cost = Nil Then
		    Return -1
		  End If
		  
		  For I As Integer = 0 To Self.mCosts.LastRowIndex
		    If Self.mCosts(I).Engram = Cost.Engram Or Self.mCosts(I) = Cost Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Cost As Beacon.CraftingCost)
		  If Cost = Nil Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Cost)
		  If Idx = -1 Then
		    Self.mCosts.AddRowAt(Index, Cost)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mCosts.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For I As Integer = 0 To Self.mCosts.LastRowIndex
		    If Self.mCosts(I).Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Not Value Then
		    For I As Integer = 0 To Self.mCosts.LastRowIndex
		      Self.mCosts(I).Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.CraftingCost
		  Return Self.mCosts(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Cost As Beacon.CraftingCost)
		  If Cost = Nil Or Cost = Self.mCosts(Index) Then
		    Return
		  End If
		  
		  Self.mCosts(Index) = Cost
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Cost As Beacon.CraftingCost)
		  Var Idx As Integer = Self.IndexOf(Cost)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mCosts.RemoveRowAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(NewBound As Integer)
		  Self.mCosts.ResizeTo(NewBound)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCosts() As Beacon.CraftingCost
	#tag EndProperty


	#tag Constant, Name = ConfigKey, Type = Text, Dynamic = False, Default = \"CraftingCosts", Scope = Private
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
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
