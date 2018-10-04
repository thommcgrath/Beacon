#tag Class
Protected Class LootDrops
Inherits Beacon.ConfigGroup
Implements Xojo.Core.Iterable
	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary)
		  If Dict.HasKey("Contents") Then
		    Dim Contents() As Auto = Dict.Value("Contents")
		    For Each DropDict As Xojo.Core.Dictionary In Contents
		      Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromBeacon(DropDict)
		      If Source <> Nil Then
		        Self.mSources.Append(Source)
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary)
		  Dim Contents() As Xojo.Core.Dictionary
		  For Each Source As Beacon.LootSource In Self.mSources
		    Contents.Append(Source.Export)
		  Next
		  Dict.Value("Contents") = Contents
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(Source As Beacon.LootSource)
		  Self.mSources.Append(Source)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "LootDrops"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, DiscoveredData As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.LootDrops
		  #Pragma Unused DiscoveredData
		  #Pragma Unused MapCompatibility
		  
		  If Not ParsedData.HasKey("ConfigOverrideSupplyCrateItems") Then
		    Return Nil
		  End If
		  
		  Dim Dicts() As Auto
		  Try
		    Dicts = ParsedData.Value("ConfigOverrideSupplyCrateItems")
		  Catch Err As TypeMismatchException
		    Dicts.Append(ParsedData.Value("ConfigOverrideSupplyCrateItems"))
		  End Try
		  
		  Dim LootDrops As New BeaconConfigs.LootDrops
		  For Each ConfigDict As Xojo.Core.Dictionary In Dicts
		    Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromConfig(ConfigDict, QualityMultiplier)
		    If Source <> Nil Then
		      LootDrops.Append(Source)
		    End If
		  Next
		  If LootDrops.UBound > -1 Then
		    Return LootDrops
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Dim DifficultyConfig As BeaconConfigs.Difficulty = SourceDocument.Difficulty
		  If DifficultyConfig = Nil Then
		    DifficultyConfig = New BeaconConfigs.Difficulty
		  End If
		  
		  Dim Values() As Beacon.ConfigValue
		  For Each Source As Beacon.LootSource In Self.mSources
		    Dim TextValue As Text = Source.TextValue(DifficultyConfig)
		    Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideSupplyCrateItems", TextValue))
		  Next
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Xojo.Core.Iterable interface.
		  
		  Return New BeaconConfigs.LootDropIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Source As Beacon.LootSource) As Integer
		  For I As Integer = 0 To Self.mSources.Ubound
		    If Self.mSources(I).ClassString = Source.ClassString Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Source As Beacon.LootSource)
		  Self.mSources.Insert(Index, Source)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    If Source.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Not Value Then
		    For Each Source As Beacon.LootSource In Self.mSources
		      Source.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(NewUBound As Integer)
		  If NewUBound <> Self.mSources.Ubound Then
		    Redim Self.mSources(NewUBound)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.LootSource
		  Return Self.mSources(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Source As Beacon.LootSource)
		  Self.mSources(Index) = Source
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Source As Beacon.LootSource)
		  Dim Idx As Integer = Self.IndexOf(Source)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mSources.Remove(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return Self.mSources.Ubound
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSources() As Beacon.LootSource
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
	#tag EndViewBehavior
End Class
#tag EndClass
