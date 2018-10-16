#tag Class
Protected Class Preset
Implements Beacon.Countable
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLabel = "Untitled Preset"
		  Self.mGrouping = "Miscellaneous"
		  Self.mMinItems = 1
		  Self.mMaxItems = 3
		  Self.mPresetID = Beacon.CreateUUID
		  Self.Type = Types.Custom
		  Self.mModifierValues = New Xojo.Core.Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Preset)
		  Self.mLabel = Source.mLabel
		  Self.mGrouping = Source.mGrouping
		  Self.mMinItems = Source.mMinItems
		  Self.mMaxItems = Source.mMaxItems
		  Self.mPresetID = Source.mPresetID
		  Self.Type = Source.Type
		  
		  Self.mModifierValues = New Xojo.Core.Dictionary
		  For Each Entry As Xojo.Core.DictionaryEntry In Source.mModifierValues
		    Dim Dict As Xojo.Core.Dictionary = Entry.Value
		    Self.mModifierValues.Value(Entry.Key) = Beacon.Clone(Dict)
		  Next
		  
		  Redim Self.mModifiers(Source.mModifiers.Ubound)
		  For I As Integer = 0 To Source.mModifiers.Ubound
		    Self.mModifiers(I) = New Beacon.PresetModifier(Source.mModifiers(I))
		  Next
		  
		  Redim Self.mContents(UBound(Source.mContents))
		  For I As Integer = 0 To UBound(Self.mContents)
		    Self.mContents(I) = New Beacon.PresetEntry(Source.mContents(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mContents) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entry(Index As Integer) As Beacon.PresetEntry
		  Return New Beacon.PresetEntry(Self.mContents(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Xojo.Core.Dictionary) As Beacon.Preset
		  Dim Preset As New Beacon.Preset
		  If Dict.HasKey("ID") Then
		    // Don't use lookup here to prevent creating the UUID unless necessary
		    Preset.mPresetID = Dict.Value("ID")
		  End If
		  If Preset.mPresetID = "" Then
		    Preset.mPresetID = Beacon.CreateUUID
		  End If
		  Preset.mLabel = Dict.Lookup("Label", Preset.Label)
		  Preset.mGrouping = Dict.Lookup("Grouping", Preset.Grouping)
		  Preset.mMinItems = Dict.Lookup("Min", Preset.MinItems)
		  Preset.mMaxItems = Dict.Lookup("Max", Preset.MaxItems)
		  
		  If Dict.HasKey("Entries") Then
		    Dim Contents() As Auto = Dict.Value("Entries")
		    For Each EntryDict As Xojo.Core.Dictionary In Contents
		      Dim Entry As Beacon.PresetEntry = Beacon.PresetEntry.ImportFromBeacon(EntryDict)
		      If Entry <> Nil Then
		        Preset.mContents.Append(Entry)
		      End If
		    Next
		  ElseIf Dict.HasKey("Contents") Then
		    Dim Contents As Xojo.Core.Dictionary = Dict.Value("Contents")
		    If Contents <> Nil Then
		      For Each Set As Xojo.Core.DictionaryEntry In Contents
		        Dim ValidForIsland As Boolean = (Set.Key = "Common" Or Set.Key = "Island")
		        Dim ValidForScorched As Boolean = (Set.Key = "Common" Or Set.Key = "Scorched")
		        Dim Items() As Auto = Set.Value
		        For Each Item As Xojo.Core.Dictionary In Items
		          Dim Entry As Beacon.SetEntry = Beacon.SetEntry.ImportFromBeacon(Item)
		          If Entry <> Nil Then
		            Dim Child As New Beacon.PresetEntry(Entry)
		            Child.ValidForMap(Beacon.Maps.TheIsland) = ValidForIsland
		            Child.ValidForMap(Beacon.Maps.ScorchedEarth) = ValidForScorched
		            Preset.mContents.Append(Child)
		          End If
		        Next
		      Next
		    End If
		  End If
		  
		  If Dict.HasKey("Modifier Definitions") Then
		    // Only import the unknown ones. All get exported anyway.
		    Dim Definitions() As Auto = Dict.Value("Modifier Definitions")
		    For Each Definition As Xojo.Core.Dictionary In Definitions
		      If Not Definition.HasKey("ModifierID") Then
		        Continue
		      End If
		      
		      Dim ModifierID As Text = Definition.Value("ModifierID")
		      Dim Modifier As Beacon.PresetModifier = Beacon.Data.GetPresetModifier(ModifierID)
		      If Modifier = Nil Then
		        Modifier = Beacon.PresetModifier.FromDictionary(Definition)
		        If Modifier <> Nil Then
		          Preset.mModifiers.Append(Modifier)
		        End If
		      End If
		    Next
		  End If
		  
		  If Dict.HasKey("Modifiers") Then
		    Dim Modifiers As Xojo.Core.Dictionary = Dict.Value("Modifiers")
		    For Each Set As Xojo.Core.DictionaryEntry In Modifiers
		      Dim Item As Xojo.Core.Dictionary = Set.Value
		      Dim ModifierID As Text = Set.Key
		      Dim Quality As Integer = Item.Lookup("Quality", 1)
		      Dim Quantity As Double = Item.Lookup("Quantity", 1.0)
		      Dim IDs() As Text
		      
		      Select Case ModifierID
		      Case "Standard"
		        IDs = SourceKindToModifierID(Beacon.LootSource.Kinds.Standard)
		      Case "Bonus"
		        IDs = SourceKindToModifierID(Beacon.LootSource.Kinds.Bonus)
		      Case "Cave"
		        IDs = SourceKindToModifierID(Beacon.LootSource.Kinds.Cave)
		      Case "Sea"
		        IDs = SourceKindToModifierID(Beacon.LootSource.Kinds.Sea)
		      Else
		        IDs.Append(ModifierID)
		      End Select
		      
		      For Each ID As Text In IDs
		        Dim ModifierDict As New Xojo.Core.Dictionary
		        ModifierDict.Value("Quality") = Quality
		        ModifierDict.Value("Quantity") = Quantity
		        Preset.mModifierValues.Value(ID) = ModifierDict
		      Next
		    Next
		  End If
		  
		  Return New Beacon.Preset(Preset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Shared Function FromFile(File As Global.FolderItem) As Beacon.Preset
		  If File = Nil Or File.Exists = False Or File.Directory = True Then
		    Return Nil
		  End If
		  
		  Try
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Bytes As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Bytes.ToText)
		    Return Beacon.Preset.FromDictionary(Dict)
		  Catch Err As Xojo.IO.IOException
		    Return Nil
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  Catch Err As TypeMismatchException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Shared Function FromFile(File As Xojo.IO.FolderItem) As Beacon.Preset
		  If File = Nil Or File.Exists = False Or File.IsFolder = True Then
		    Return Nil
		  End If
		  
		  Try
		    Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Open(File, Xojo.IO.BinaryStream.LockModes.Read)
		    Dim Bytes As Xojo.Core.MemoryBlock = Stream.Read(Stream.Length)
		    Stream.Close
		    
		    Dim TextContents As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Bytes)
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContents)
		    Return Beacon.Preset.FromDictionary(Dict)
		  Catch Err As Xojo.IO.IOException
		    Return Nil
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  Catch Err As TypeMismatchException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Beacon.PresetIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Grouping() As Text
		  If Self.mGrouping.Trim = "" Then
		    Return "Miscellaneous"
		  Else
		    Return Self.mGrouping.Trim
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.PresetEntry) As Integer
		  For I As Integer = 0 To UBound(Self.mContents)
		    If Self.mContents(I) = Entry Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCustom() As Boolean
		  Return Beacon.Data.IsPresetCustom(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxItems() As Integer
		  Return Max(Min(Self.mMaxItems, Self.mContents.Ubound + 1), Self.mMinItems, 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinItems() As Integer
		  Return Min(Max(Self.mMinItems, 1), Self.mMaxItems, Self.mContents.Ubound + 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.PresetEntry
		  Return New Beacon.PresetEntry(Self.mContents(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PresetID() As Text
		  If Self.mPresetID = "" Then
		    Self.mPresetID = Beacon.CreateUUID
		  End If
		  Return Self.mPresetID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QualityModifier(Kind As Beacon.LootSource.Kinds) As Integer
		  Dim IDs() As Text = Self.SourceKindToModifierID(Kind)
		  If IDs.Ubound = -1 Then
		    Return 1
		  End If
		  Return Self.QualityModifier(IDs(0))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QualityModifier(Modifier As Beacon.PresetModifier) As Integer
		  Return Self.QualityModifier(Modifier.ModifierID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QualityModifier(ModifierID As Text) As Integer
		  If Self.mModifierValues = Nil Then
		    Return 1
		  End If
		  
		  Dim Dict As Xojo.Core.Dictionary = Self.mModifierValues.Lookup(ModifierID, New Xojo.Core.Dictionary)
		  Return Dict.Lookup("Quality", 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(Kind As Beacon.LootSource.Kinds) As Double
		  Dim IDs() As Text = Self.SourceKindToModifierID(Kind)
		  If IDs.Ubound = -1 Then
		    Return 1.0
		  End If
		  Return Self.QuantityMultiplier(IDs(0))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(Modifier As Beacon.PresetModifier) As Double
		  Return Self.QuantityMultiplier(Modifier.ModifierID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(ModifierID As Text) As Double
		  If Self.mModifierValues = Nil Then
		    Return 1.0
		  End If
		  
		  Dim Dict As Xojo.Core.Dictionary = Self.mModifierValues.Lookup(ModifierID, New Xojo.Core.Dictionary)
		  Return Dict.Lookup("Quantity", 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function SourceKindToModifierID(Kind As Beacon.LootSource.Kinds) As Text()
		  Dim IDs() As Text
		  Select Case Kind
		  Case Beacon.LootSource.Kinds.Bonus
		    IDs.Append(Beacon.PresetModifier.BonusCratesID)
		    IDs.Append(Beacon.PresetModifier.AberrationSurfaceBonusCratesID)
		  Case Beacon.LootSource.Kinds.Cave
		    IDs.Append(Beacon.PresetModifier.CaveCratesID)
		  Case Beacon.LootSource.Kinds.Sea
		    IDs.Append(Beacon.PresetModifier.DeepSeaCratesID)
		    IDs.Append(Beacon.PresetModifier.OpenDesertCratesID)
		  Case Beacon.LootSource.Kinds.Standard
		    IDs.Append(Beacon.PresetModifier.BasicCratesID)
		    IDs.Append(Beacon.PresetModifier.AberrationSurfaceCratesID)
		    IDs.Append(Beacon.PresetModifier.BossesID)
		    IDs.Append(Beacon.PresetModifier.ArtifactCratesID)
		  End Select
		  Return IDs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Xojo.Core.Dictionary
		  Dim Hashes() As Text
		  Dim Contents() As Xojo.Core.Dictionary
		  For Each Entry As Beacon.PresetEntry In Self.mContents
		    Hashes.Append(Entry.Hash)
		    Contents.Append(Entry.Export)
		  Next
		  Hashes.SortWith(Contents)
		  
		  // Export every definition, even though built-ins will be dropped on read. This preserves
		  // the file in the future if a built-in is dropped.
		  Dim Definitions() As Xojo.Core.Dictionary
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mModifierValues
		    Dim ModifierID As Text = Entry.Key
		    Dim Modifier As Beacon.PresetModifier = Beacon.Data.GetPresetModifier(ModifierID)
		    If Modifier = Nil Then
		      For I As Integer = 0 To Self.mModifiers.Ubound
		        If Self.mModifiers(I).ModifierID = ModifierID Then
		          Modifier = Self.mModifiers(I)
		          Exit For I
		        End If
		      Next
		    End If
		    If Modifier <> Nil Then
		      Definitions.Append(Modifier.ToDictionary)
		    End If
		  Next
		  
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Version") = 2
		  Dict.Value("ID") = Self.PresetID
		  Dict.Value("Label") = Self.Label
		  Dict.Value("Grouping") = Self.Grouping
		  Dict.Value("Min") = Self.MinItems
		  Dict.Value("Max") = Self.MaxItems
		  Dict.Value("Entries") = Contents
		  Dict.Value("Modifiers") = Self.mModifierValues
		  Dict.Value("Modifier Definitions") = Definitions
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub ToFile(File As Global.FolderItem)
		  Call Beacon.JSONWriter.WriteSynchronous(Self.ToDictionary, File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Sub ToFile(File As Xojo.IO.FolderItem)
		  Call Beacon.JSONWriter.WriteSynchronous(Self.ToDictionary, File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Beacon.Map) As Boolean
		  Return Self.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Mask As UInt64) As Boolean
		  If Mask = 0 Then
		    Return True
		  End If
		  
		  For Each Entry As Beacon.PresetEntry In Self.mContents
		    If Entry.ValidForMask(Mask) Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mContents() As Beacon.PresetEntry
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGrouping As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModifiers() As Beacon.PresetModifier
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModifierValues As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresetID As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As Beacon.Preset.Types
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		BuiltIn
		  Custom
		CustomizedBuiltIn
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Group="Behavior"
			Type="Beacon.Preset.Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - BuiltIn"
				"1 - Custom"
				"2 - CustomizedBuiltIn"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
