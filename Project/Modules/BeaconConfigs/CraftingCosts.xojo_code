#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class CraftingCosts
Inherits Beacon.ConfigGroup
	#tag Event
		Sub DetectIssues(Document As Beacon.Document, Issues() As Beacon.Issue)
		  #Pragma Unused Document
		  
		  Dim ConfigName As String = ConfigKey
		  For I As Integer = 0 To Self.mCosts.LastRowIndex
		    If Self.mCosts(I).IsValid Then
		      Continue
		    End If
		    
		    If Self.mCosts(I).Engram = Nil Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Crafting cost has no engram", Self.mCosts(I)))
		    End If
		    
		    If Self.mCosts(I).LastRowIndex = -1 Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Crafting cost override of """ + Self.mCosts(I).Label + """ has no resources.", Self.mCosts(I)))
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  For Each Cost As Beacon.CraftingCost In Self.mCosts
		    Dim StringValue As String = Cost.StringValue
		    Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemCraftingCosts", StringValue))
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Costs") Then
		    Dim Costs() As Variant = Dict.Value("Costs")
		    For Each CostData As Dictionary In Costs
		      Dim Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromBeacon(CostData)
		      If Cost <> Nil Then
		        Self.mCosts.Append(Cost)
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dim Costs() As Dictionary
		  For Each Cost As Beacon.CraftingCost In Self.mCosts
		    Costs.Append(Cost.Export)
		  Next
		  Dict.Value("Costs") = Costs
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(Cost As Beacon.CraftingCost)
		  If Cost = Nil Then
		    Return
		  End If
		  
		  Dim Idx As Integer = Self.IndexOf(Cost)
		  If Idx = -1 Then
		    Self.mCosts.Append(Cost)
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
		  
		  Dim Values As Variant = ParsedData.Value("ConfigOverrideItemCraftingCosts")
		  Dim ValuesInfo As Introspection.TypeInfo = Introspection.GetType(Values)
		  Dim Overrides() As Variant
		  If ValuesInfo.FullName = "Auto()" Then
		    Overrides = Values
		  ElseIf ValuesInfo.FullName = "Dictionary" Then
		    Overrides.Append(Values)
		  Else
		    Return Nil
		  End If
		  
		  Dim Config As New BeaconConfigs.CraftingCosts
		  For Each Dict As Dictionary In Overrides
		    Dim Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromConfig(Dict)
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
		  
		  Dim Idx As Integer = Self.IndexOf(Cost)
		  If Idx = -1 Then
		    Self.mCosts.Insert(Index, Cost)
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
		Sub Operator_Redim(NewBound As Integer)
		  Redim Self.mCosts(NewBound)
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
		  Dim Idx As Integer = Self.IndexOf(Cost)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mCosts.Remove(Index)
		  Self.Modified = True
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
