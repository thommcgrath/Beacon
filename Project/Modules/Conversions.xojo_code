#tag Module
Protected Module Conversions
	#tag Method, Flags = &h1
		Protected Function EvolvedToAscended(Source As Ark.Engram, DataSource As ArkSA.DataSource = Nil) As ArkSA.Engram
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  If DataSource Is Nil Then
		    DataSource = ArkSA.DataSource.Pool.Get(False)
		  End If
		  
		  Var Results() As ArkSA.Engram = DataSource.GetEngramsByPath(Source.Path, Nil)
		  If Results.Count = 1 Then
		    Return Results(0)
		  ElseIf Results.Count > 1 Then
		    Var PackName As String = Source.ContentPackName
		    Var BestResult As ArkSA.Engram
		    Var BestValue As Double
		    For Each Result As ArkSA.Engram In Results
		      Var Value As Double = LevenshteinDistanceMBS(PackName, Result.ContentPackName)
		      If Value = 1 Then
		        Return Result
		      End If
		      
		      If BestResult Is Nil Or Value > BestValue Then
		        BestResult = Result
		        BestValue = Value
		      End If
		    Next
		    
		    Return BestResult
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EvolvedToAscended(Source As Ark.LootItemSet, DataSource As ArkSA.DataSource = Nil) As ArkSA.LootItemSet
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  If DataSource Is Nil Then
		    DataSource = ArkSA.DataSource.Pool.Get(False)
		  End If
		  
		  Var Set As New ArkSA.MutableLootItemSet()
		  For Each Entry As Ark.LootItemSetEntry In Source
		    Var ConvertedEntry As ArkSA.LootItemSetEntry = Conversions.EvolvedToAscended(Entry, DataSource)
		    If (ConvertedEntry Is Nil) = False Then
		      Set.Add(ConvertedEntry)
		    End If
		  Next
		  If Set.Count = 0 Then
		    Return Nil
		  End If
		  Set.ItemsRandomWithoutReplacement = Source.ItemsRandomWithoutReplacement
		  Set.MaxNumItems = Source.MaxNumItems
		  Set.MinNumItems = Source.MinNumItems
		  Set.NumItemsPower = Source.NumItemsPower
		  Set.RawWeight = Source.RawWeight
		  Return Set.ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EvolvedToAscended(Source As Ark.LootItemSetEntryOption, DataSource As ArkSA.DataSource = Nil) As ArkSA.LootItemSetEntryOption
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  If DataSource Is Nil Then
		    DataSource = ArkSA.DataSource.Pool.Get(False)
		  End If
		  
		  Var Engram As ArkSA.Engram = Conversions.EvolvedToAscended(Source.Engram, DataSource)
		  If Engram Is Nil Then
		    Return Nil
		  End If
		  
		  Return New ArkSA.LootItemSetEntryOption(Engram, Source.RawWeight, Beacon.UUID.v4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EvolvedToAscended(Source As Ark.LootTemplate, DataSource As ArkSA.DataSource = Nil, CommonData As Beacon.CommonData = Nil) As ArkSA.LootTemplate
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  If DataSource Is Nil Then
		    DataSource = ArkSA.DataSource.Pool.Get(False)
		  End If
		  
		  Var Template As New ArkSA.MutableLootTemplate
		  For Each Entry As Ark.LootTemplateEntry In Source
		    Var ConvertedEntry As ArkSA.LootTemplateEntry = Conversions.EvolvedToAscended(Entry, DataSource)
		    If (ConvertedEntry Is Nil) = False Then
		      Template.Add(ConvertedEntry)
		    End If
		  Next
		  
		  Template.Grouping = Source.Grouping
		  Template.Label = Source.Label
		  Template.MaxEntriesSelected = Source.MaxEntriesSelected
		  Template.MinEntriesSelected = Source.MinEntriesSelected
		  
		  If CommonData Is Nil Then
		    CommonData = Beacon.CommonData.Pool.Get(False)
		  End If
		  Var ActiveSelectorIds() As String = Source.ActiveSelectorIDs
		  Var SourceSelectors() As Beacon.TemplateSelector
		  For Each SelectorId As String In ActiveSelectorIds
		    Var SourceSelector As Beacon.TemplateSelector = CommonData.GetTemplateSelectorByUUID(SelectorId)
		    If (SourceSelector Is Nil) = False Then
		      SourceSelectors.Add(SourceSelector)
		    End If
		  Next
		  
		  For Each SourceSelector As Beacon.TemplateSelector In SourceSelectors
		    Var ConvertedSelectors() As Beacon.TemplateSelector = CommonData.GetTemplateSelectorsWithLogic(ArkSA.Identifier, SourceSelector.Language, SourceSelector.Code)
		    Var ConvertedSelector As Beacon.TemplateSelector
		    If ConvertedSelectors.Count > 0 Then
		      ConvertedSelector = ConvertedSelectors(0)
		    Else
		      ConvertedSelector = Conversions.EvolvedToAscended(SourceSelector)
		      
		      If Thread.Current Is Nil Then
		        // On main thread, use a thread to do the save.
		        mSelectorThreadLock.Enter
		        mSelectorsToSave.Add(ConvertedSelector)
		        If mSelectorSaveThread Is Nil Then
		          mSelectorSaveThread = New Beacon.Thread
		          mSelectorSaveThread.DebugIdentifier = "Conversions.mSelectorSaveThread"
		          AddHandler mSelectorSaveThread.Run, AddressOf mSelectorSaveThread_Run
		        End If
		        If mSelectorSaveThread.ThreadState = Thread.ThreadStates.NotRunning Then
		          mSelectorSaveThread.Start
		        End If
		        mSelectorThreadLock.Leave
		      Else
		        // Already in a thread, so writing is possible. Switch if necessary.
		        If CommonData.Writeable = False Then
		          CommonData = CommonData.WriteableInstance()
		        End If
		        CommonData.SaveTemplateSelector(ConvertedSelector, False, True)
		      End If
		    End If
		    
		    Template.BlueprintChanceMultiplier(ConvertedSelector) = Source.BlueprintChanceMultiplier(SourceSelector)
		    Template.MaxQualityOffset(ConvertedSelector) = Source.MaxQualityOffset(SourceSelector)
		    Template.MinQualityOffset(ConvertedSelector) = Source.MinQualityOffset(SourceSelector)
		    Template.QuantityMultiplier(ConvertedSelector) = Source.QuantityMultiplier(SourceSelector)
		    Template.WeightMultiplier(ConvertedSelector) = Source.WeightMultiplier(SourceSelector)
		  Next
		  
		  Return Template.ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EvolvedToAscended(Source As Ark.LootTemplateEntry, DataSource As ArkSA.DataSource = Nil) As ArkSA.LootTemplateEntry
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  If DataSource Is Nil Then
		    DataSource = ArkSA.DataSource.Pool.Get(False)
		  End If
		  
		  Var SourceMaps() As Ark.Map = Ark.Maps.ForMask(Source.Availability)
		  Var ConvertedMaps() As ArkSA.Map
		  For Each Map As Ark.Map In SourceMaps
		    Var ConvertedMap As ArkSA.Map = DataSource.GetMap(Map.Name)
		    If (ConvertedMap Is Nil) = False Then
		      ConvertedMaps.Add(ConvertedMap)
		    End If
		  Next
		  If ConvertedMaps.Count = 0 Then
		    Return Nil
		  End If
		  
		  Var Entry As New ArkSA.MutableLootTemplateEntry()
		  For Each Option As Ark.LootItemSetEntryOption In Source
		    Var ConvertedOption As ArkSA.LootItemSetEntryOption = Conversions.EvolvedToAscended(Option, DataSource)
		    If (ConvertedOption Is Nil) = False Then
		      Entry.Add(ConvertedOption)
		    End If
		  Next
		  If Entry.Count = 0 Then
		    Return Nil
		  End If
		  Entry.MaxQuality = ArkSA.Qualities.ForBaseValue(Source.MaxQuality.BaseValue)
		  Entry.MinQuality = ArkSA.Qualities.ForBaseValue(Source.MinQuality.BaseValue)
		  Entry.MaxQuantity = Source.MaxQuantity
		  Entry.MinQuantity = Source.MinQuantity
		  Entry.Availability = ArkSA.Maps.MaskForMaps(ConvertedMaps)
		  Entry.PreventGrinding = Source.PreventGrinding
		  Entry.ChanceToBeBlueprint = Source.ChanceToBeBlueprint
		  Entry.RawWeight = Source.RawWeight
		  Entry.RespectBlueprintChanceMultipliers = Source.RespectBlueprintChanceMultipliers
		  Entry.RespectQualityOffsets = Source.RespectQualityOffsets
		  Entry.RespectQuantityMultipliers = Source.RespectQuantityMultipliers
		  Entry.RespectWeightMultipliers = Source.RespectWeightMultipliers
		  Entry.SingleItemQuantity = Source.SingleItemQuantity
		  Entry.StatClampMultiplier = Source.StatClampMultiplier
		  Return Entry.ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EvolvedToAscended(Source As Beacon.TemplateSelector) As Beacon.TemplateSelector
		  If Source Is Nil Or Source.GameId <> Ark.Identifier Then
		    Return Nil
		  End If
		  
		  Return New Beacon.TemplateSelector(Beacon.UUID.v4, Source.Label, ArkSA.Identifier, Source.Language, Source.Code)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Init()
		  mSelectorThreadLock = New CriticalSection
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSelectorSaveThread_Run(Sender As Beacon.Thread)
		  #Pragma Unused Sender
		  
		  mSelectorThreadLock.Enter
		  
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.Pool.Get(True)
		  While mSelectorsToSave.Count > 0
		    Var TemplateSelector As Beacon.TemplateSelector = mSelectorsToSave(0)
		    mSelectorsToSave.RemoveAt(0)
		    
		    CommonData.SaveTemplateSelector(TemplateSelector, False, False)
		  Wend
		  CommonData.ExportCloudFiles()
		  
		  mSelectorThreadLock.Leave
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSelectorSaveThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectorsToSave() As Beacon.TemplateSelector
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectorThreadLock As CriticalSection
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
			Name="mSelectorsToSave()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
