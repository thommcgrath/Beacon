#tag Class
Protected Class LootDrops
Inherits Beacon.ConfigGroup
Implements Iterable
	#tag Event
		Sub DetectIssues(Document As Beacon.Document, Issues() As Beacon.Issue)
		  Dim ConfigName As String = ConfigKey
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    If Source.IsValid(Document) Then
		      Continue
		    End If
		    
		    If Source.Count < Source.RequiredItemSets Then
		      Issues.AddRow(New Beacon.Issue(ConfigName, "Loot source " + Source.Label + " needs at least " +Source.RequiredItemSets.ToString + " " + if(Source.RequiredItemSets = 1, "item set", "item sets") + " to work correctly.", Source))
		    Else
		      For Each Set As Beacon.ItemSet In Source
		        If Set.IsValid(Document) Then
		          Continue
		        End If
		        
		        If Set.Count = 0 Then
		          Issues.AddRow(New Beacon.Issue(ConfigName, "Item set " + Set.Label + " of loot source " + Source.Label + " is empty.", Self.AssembleLocationDict(Source, Set)))
		        Else
		          For Each Entry As Beacon.SetEntry In Set
		            If Entry.IsValid(Document) Then
		              Continue
		            End If
		            
		            If Entry.Count = 0 Then
		              Issues.AddRow(New Beacon.Issue(ConfigName, "An entry in item set " + Set.Label + " of loot source " + Source.Label + " has no engrams selected.", Self.AssembleLocationDict(Source, Set, Entry)))
		            Else
		              For Each Option As Beacon.SetEntryOption In Entry
		                If Option.IsValid(Document) Then
		                  Continue
		                End If
		                
		                If Option.Engram = Nil Then
		                  Issues.AddRow(New Beacon.Issue(ConfigName, "The engram is missing for an option of an entry in " + Set.Label + " of loot source " + Source.Label + ".", Self.AssembleLocationDict(Source, Set, Entry, Option)))
		                ElseIf Document.Mods.Count > 0 And Document.Mods.IndexOf(Option.Engram.ModID) = -1 Then
		                  Issues.AddRow(New Beacon.Issue(ConfigName, Option.Engram.Label + " is provided by a mod that is currently disabled.", Self.AssembleLocationDict(Source, Set, Entry, Option)))
		                ElseIf Option.Engram.IsTagged("Generic") Or Option.Engram.IsTagged("Blueprint") Then
		                  Issues.AddRow(New Beacon.Issue(ConfigName, Option.Engram.Label + " is a generic item intended for crafting recipes. It cannot spawn in a drop.", Self.AssembleLocationDict(Source, Set, Entry, Option)))
		                Else
		                  Issues.AddRow(New Beacon.Issue(ConfigName, "Beacon does not know the blueprint for " + Option.Engram.ClassString + ".", Self.AssembleLocationDict(Source, Set, Entry, Option)))
		                End If
		              Next
		            End If
		          Next
		        End If
		      Next
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  Dim DifficultyConfig As BeaconConfigs.Difficulty = SourceDocument.Difficulty
		  If DifficultyConfig = Nil Then
		    DifficultyConfig = New BeaconConfigs.Difficulty
		    DifficultyConfig.IsImplicit = True
		  End If
		  
		  If App.IdentityManager.CurrentIdentity.IsBanned Then
		    Var Sources() As Beacon.LootSource = LocalData.SharedInstance.SearchForLootSources("", New Beacon.StringList, False)
		    
		    Var Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass("PrimalItemConsumable_DinoPoopSmall_C")
		    
		    Var Entry As New Beacon.SetEntry
		    Entry.Append(New Beacon.SetEntryOption(Engram, 1.0))
		    Entry.MinQuantity = 300
		    Entry.MaxQuantity = 300
		    Entry.MinQuality = Beacon.Qualities.Tier1
		    Entry.MaxQuality = Beacon.Qualities.Tier1
		    Entry.ChanceToBeBlueprint = 0
		    
		    Var Set As New Beacon.ItemSet
		    Set.Label = "Turds"
		    Set.MinNumItems = 1
		    Set.MaxNumItems = 1
		    Set.Append(Entry)
		    
		    For Each Source As Beacon.LootSource In Sources
		      If Not Source.ValidForMask(Profile.Mask) Then
		        Continue
		      End If
		      
		      Source.MinItemSets = 1
		      Source.MaxItemSets = 1
		      Call Source.AddSet(Set, False)
		      
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, ConfigOverrideSupplyCrateItems, Source.StringValue(DifficultyConfig)))
		    Next
		    Return
		  End If
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    If Not Source.ValidForMask(Profile.Mask) Then
		      Continue
		    End If
		    
		    Dim StringValue As String = Source.StringValue(DifficultyConfig)
		    Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, ConfigOverrideSupplyCrateItems, StringValue))
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Contents") Then
		    // Only keep the most recent of the duplicates
		    Dim Contents() As Variant = Dict.Value("Contents")
		    Dim UniqueClasses As New Dictionary
		    For Each DropDict As Dictionary In Contents
		      Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromBeacon(DropDict)
		      If Source <> Nil Then
		        Dim Idx As Integer = UniqueClasses.Lookup(Source.ClassString, -1)
		        If Idx = -1 Then
		          Self.mSources.AddRow(Source)
		          UniqueClasses.Value(Source.ClassString) = Self.mSources.LastRowIndex
		        Else
		          Self.mSources(Idx) = Source
		        End If
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dim Contents() As Dictionary
		  For Each Source As Beacon.LootSource In Self.mSources
		    Contents.AddRow(Source.Export)
		  Next
		  Dict.Value("Contents") = Contents
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(Source As Beacon.LootSource)
		  Self.mSources.AddRow(Source)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function AssembleLocationDict(Source As Beacon.LootSource, ItemSet As Beacon.ItemSet = Nil, Entry As Beacon.SetEntry = Nil, Option As Beacon.SetEntryOption = Nil) As Dictionary
		  Dim Dict As New Dictionary
		  Dict.Value("LootSource") = Source
		  If ItemSet <> Nil Then
		    Dict.Value("ItemSet") = ItemSet
		    If Entry <> Nil Then
		      Dict.Value("Entry") = Entry
		      If Option <> Nil Then
		        Dict.Value("Option") = Option
		      End If
		    End If
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return ConfigKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefinedSources() As Beacon.LootSourceCollection
		  Dim Results As New Beacon.LootSourceCollection
		  For Each LootSource As Beacon.LootSource In Self.mSources
		    Results.Append(LootSource)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.LootDrops
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  
		  If Not ParsedData.HasKey(ConfigOverrideSupplyCrateItems) Then
		    Return Nil
		  End If
		  
		  Var Value As Variant = ParsedData.Value(ConfigOverrideSupplyCrateItems)
		  If IsNull(Value) Then
		    Return Nil
		  End If
		  
		  Var Dicts() As Variant
		  If Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		    Dicts.AddRow(Dictionary(Value.ObjectValue))
		  ElseIf Value.IsArray And Value.ArrayElementType = Value.TypeObject Then
		    Dicts = Value
		  End If
		  
		  // Only keep the most recent of the duplicates
		  Var LootDrops As New BeaconConfigs.LootDrops
		  Var UniqueClasses As New Dictionary
		  For Each Member As Variant In Dicts
		    If IsNull(Member) Or Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var Source As Beacon.LootSource
		    Try
		      Source = Beacon.LootSource.ImportFromConfig(Dictionary(Member.ObjectValue), Difficulty)
		    Catch Err As RuntimeException
		      Continue
		    End Try
		    
		    If Source = Nil Then
		      Continue
		    End If
		    
		    Var Idx As Integer = UniqueClasses.Lookup(Source.ClassString, -1)
		    If Idx = -1 Then
		      LootDrops.Append(Source)
		      UniqueClasses.Value(Source.ClassString) = LootDrops.LastRowIndex
		    Else
		      LootDrops(Idx) = Source
		    End If
		  Next
		  If LootDrops.LastRowIndex > -1 Then
		    Return LootDrops
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasLootSource(Source As Beacon.LootSource) As Boolean
		  Return Self.IndexOf(Source) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Source As Beacon.LootSource) As Integer
		  For I As Integer = 0 To Self.mSources.LastRowIndex
		    If Self.mSources(I).ClassString = Source.ClassString Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Source As Beacon.LootSource)
		  Self.mSources.AddRowAt(Index, Source)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Dim Items() As Variant
		  Redim Items(Self.mSources.LastRowIndex)
		  For I As Integer = Items.FirstRowIndex To Items.LastRowIndex
		    Items(I) = Self.mSources(I)
		  Next
		  
		  Return New Beacon.GenericIterator(Items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mSources.LastRowIndex
		End Function
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
		  If NewUBound <> Self.mSources.LastRowIndex Then
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
		Function ReconfigurePresets(Mask As UInt64, Mods As Beacon.StringList) As UInteger
		  If Mask = 0 Then
		    Return 0
		  End If
		  
		  Dim NumChanged As UInteger
		  For Each Source As Beacon.LootSource In Self.mSources
		    NumChanged = NumChanged + Source.ReconfigurePresets(Mask, Mods)
		  Next
		  Return NumChanged
		End Function
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
		  Self.mSources.RemoveRowAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Searcher_EngramsFound(Sender As Beacon.EngramSearcherThread)
		  Dim Blueprints() As Beacon.Blueprint = Sender.Blueprints(True)
		  Dim Engrams() As Beacon.Engram = Blueprints.Engrams
		  
		  For Each Source As Beacon.LootSource In Self
		    Source.ConsumeMissingEngrams(Engrams)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Searcher_Finished(Sender As Beacon.EngramSearcherThread)
		  RemoveHandler Sender.Finished, AddressOf Searcher_Finished
		  RemoveHandler Sender.EngramsFound, AddressOf Searcher_EngramsFound
		  If Self.mResolveIssuesCallback <> Nil Then
		    Self.mResolveIssuesCallback.Invoke
		    Self.mResolveIssuesCallback = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TryToResolveIssues(InputContent As String, Callback As Beacon.ConfigGroup.ResolveIssuesCallback)
		  Self.mResolveIssuesCallback = Callback
		  
		  Dim Searcher As New Beacon.EngramSearcherThread
		  AddHandler Searcher.EngramsFound, AddressOf Searcher_EngramsFound
		  AddHandler Searcher.Finished, AddressOf Searcher_Finished
		  Searcher.Search(InputContent, False)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mResolveIssuesCallback As Beacon.ConfigGroup.ResolveIssuesCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSources() As Beacon.LootSource
	#tag EndProperty


	#tag Constant, Name = ConfigKey, Type = String, Dynamic = False, Default = \"LootDrops", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ConfigOverrideSupplyCrateItems, Type = String, Dynamic = True, Default = \"ConfigOverrideSupplyCrateItems", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
