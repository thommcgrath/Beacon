#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class CraftingCosts
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue)
		  #Pragma Unused SourceDocument
		  
		  For Each Cost As Beacon.CraftingCost In Self.mCosts
		    Dim TextValue As Text = Cost.TextValue
		    Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemCraftingCosts", TextValue))
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  If Dict.HasKey("Costs") Then
		    Dim Costs() As Auto = Dict.Value("Costs")
		    For Each CostData As Xojo.Core.Dictionary In Costs
		      Dim Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromBeacon(CostData)
		      If Cost <> Nil Then
		        Self.mCosts.Append(Cost)
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dim Costs() As Xojo.Core.Dictionary
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
		Shared Function ConfigName() As Text
		  Return "CraftingCosts"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.CraftingCosts
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused QualityMultiplier
		  
		  If Not ParsedData.HasKey("ConfigOverrideItemCraftingCosts") Then
		    Return Nil
		  End If
		  
		  Dim Values As Auto = ParsedData.Value("ConfigOverrideItemCraftingCosts")
		  Dim ValuesInfo As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Values)
		  Dim Overrides() As Auto
		  If ValuesInfo.FullName = "Auto()" Then
		    Overrides = Values
		  ElseIf ValuesInfo.FullName = "Xojo.Core.Dictionary" Then
		    Overrides.Append(Values)
		  Else
		    Return Nil
		  End If
		  
		  Dim Config As New BeaconConfigs.CraftingCosts
		  For Each Dict As Xojo.Core.Dictionary In Overrides
		    Dim Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromConfig(Dict)
		    If Cost <> Nil Then
		      Config.Append(Cost)
		    End If
		  Next
		  If Config.Ubound > -1 Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Cost As Beacon.CraftingCost) As Integer
		  If Cost = Nil Then
		    Return -1
		  End If
		  
		  For I As Integer = 0 To Self.mCosts.Ubound
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
		Function Issues(Document As Beacon.Document) As Beacon.Issue()
		  #Pragma Unused Document
		  
		  Dim Issues() As Beacon.Issue
		  Dim ConfigName As Text = "CraftingCosts"
		  For I As Integer = 0 To Self.mCosts.Ubound
		    If Self.mCosts(I).IsValid Then
		      Continue
		    End If
		    
		    If Self.mCosts(I).Engram = Nil Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Crafting cost has no engram", Self.mCosts(I)))
		    End If
		    
		    If Self.mCosts(I).Ubound = -1 Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Crafting cost override of """ + Self.mCosts(I).Label + """ has no resources.", Self.mCosts(I)))
		    End If
		  Next
		  Return Issues
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  #Pragma Unused Document
		  
		  For I As Integer = 0 To Self.mCosts.Ubound
		    If Not Self.mCosts(I).IsValid Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For I As Integer = 0 To Self.mCosts.Ubound
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
		    For I As Integer = 0 To Self.mCosts.Ubound
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

	#tag Method, Flags = &h0
		Function Ubound() As Integer
		  Return Self.mCosts.Ubound
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCosts() As Beacon.CraftingCost
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsImplicit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
