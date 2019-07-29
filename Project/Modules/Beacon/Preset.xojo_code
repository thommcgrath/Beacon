#tag Class
Protected Class Preset
Implements Beacon.Countable
	#tag Method, Flags = &h0
		Function ActiveModifierIDs() As String()
		  Dim IDs() As String
		  For Each Entry As DictionaryEntry In Self.mModifierValues
		    IDs.Append(Entry.Key)
		  Next
		  Return IDs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintMultiplier(Modifier As Beacon.PresetModifier) As Double
		  Return Self.BlueprintMultiplier(Modifier.ModifierID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintMultiplier(ModifierID As String) As Double
		  If Self.mModifierValues = Nil Then
		    Return 1.0
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  Return Dict.Lookup("Blueprint", 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLabel = "Untitled Preset"
		  Self.mGrouping = "Miscellaneous"
		  Self.mMinItems = 1
		  Self.mMaxItems = 3
		  Self.mPresetID = Beacon.CreateUUID
		  Self.Type = Types.Custom
		  Self.mModifierValues = New Dictionary
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
		  
		  Self.mModifierValues = New Dictionary
		  For Each Entry As DictionaryEntry In Source.mModifierValues
		    Dim Dict As Dictionary = Entry.Value
		    Self.mModifierValues.Value(Entry.Key) = Dict.Clone
		  Next
		  
		  Redim Self.mContents(Source.mContents.LastRowIndex)
		  For I As Integer = 0 To Self.mContents.LastRowIndex
		    Self.mContents(I) = New Beacon.PresetEntry(Source.mContents(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mContents.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entry(Index As Integer) As Beacon.PresetEntry
		  Return New Beacon.PresetEntry(Self.mContents(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.Preset
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
		    Dim Contents() As Variant = Dict.Value("Entries")
		    For Each EntryDict As Dictionary In Contents
		      Dim Entry As Beacon.PresetEntry = Beacon.PresetEntry.ImportFromBeacon(EntryDict)
		      If Entry <> Nil Then
		        Preset.mContents.Append(Entry)
		      End If
		    Next
		  ElseIf Dict.HasKey("Contents") Then
		    Dim Contents As Dictionary = Dict.Value("Contents")
		    If Contents <> Nil Then
		      For Each Set As DictionaryEntry In Contents
		        Dim ValidForIsland As Boolean = (Set.Key = "Common" Or Set.Key = "Island")
		        Dim ValidForScorched As Boolean = (Set.Key = "Common" Or Set.Key = "Scorched")
		        Dim Items() As Variant = Set.Value
		        For Each Item As Dictionary In Items
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
		    Dim Definitions() As Variant = Dict.Value("Modifier Definitions")
		    For Each Definition As Dictionary In Definitions
		      If Not Definition.HasKey("ModifierID") Then
		        Continue
		      End If
		      
		      Dim ModifierID As String = Definition.Value("ModifierID")
		      Dim Modifier As Beacon.PresetModifier = Beacon.Data.GetPresetModifier(ModifierID)
		      If Modifier = Nil Then
		        Modifier = Beacon.PresetModifier.FromDictionary(Definition)
		        If Modifier <> Nil Then
		          Beacon.Data.AddPresetModifier(Modifier)
		        End If
		      End If
		    Next
		  End If
		  
		  If Dict.HasKey("Modifiers") Then
		    Dim Modifiers As Dictionary = Dict.Value("Modifiers")
		    For Each Set As DictionaryEntry In Modifiers
		      Dim Item As Dictionary = Set.Value
		      Dim ModifierID As String = Set.Key
		      Dim MinQuality As Integer = If(Item.HasKey("MinQuality"), Item.Value("MinQuality"), Item.Lookup("Quality", 0))
		      Dim MaxQuality As Integer = If(Item.HasKey("MaxQuality"), Item.Value("MaxQuality"), Item.Lookup("Quality", 0))
		      Dim Quantity As Double = Item.Lookup("Quantity", 1.0)
		      Dim Blueprint As Double = Item.Lookup("Blueprint", 1.0)
		      
		      If MinQuality = 0 And MaxQuality = 0 And Quantity = 1 And Blueprint = 1 Then
		        Continue
		      End If
		      
		      Dim IDs() As String = SourceKindToModifierID(ModifierID)
		      If IDs.LastRowIndex = -1 Then
		        IDs.Append(ModifierID)
		      End If
		      
		      For Each ID As String In IDs
		        Dim ModifierDict As New Dictionary
		        ModifierDict.Value("MinQuality") = MinQuality
		        ModifierDict.Value("MaxQuality") = MaxQuality
		        ModifierDict.Value("Quantity") = Quantity
		        ModifierDict.Value("Blueprint") = Blueprint
		        Preset.mModifierValues.Value(ID) = ModifierDict
		      Next
		    Next
		  End If
		  
		  Return New Beacon.Preset(Preset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Shared Function FromFile(File As Global.FolderItem) As Beacon.Preset
		  If File = Nil Or File.Exists = False Or File.Folder = True Then
		    Return Nil
		  End If
		  
		  Try
		    Dim Bytes As String = File.Read(Encodings.UTF8)
		    If Bytes = "" Then
		      Return Nil
		    End If
		    
		    Dim Dict As Dictionary = Beacon.ParseJSON(Bytes)
		    Return Beacon.Preset.FromDictionary(Dict)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Grouping() As String
		  If Self.mGrouping.Trim = "" Then
		    Return "Miscellaneous"
		  Else
		    Return Self.mGrouping.Trim
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.PresetEntry) As Integer
		  For I As Integer = 0 To Self.mContents.LastRowIndex
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
		Function Iterator() As Iterator
		  Dim Contents() As Variant
		  Redim Contents(Self.mContents.LastRowIndex)
		  For I As Integer = 0 To Self.mContents.LastRowIndex
		    Contents(I) = Self.mContents(I)
		  Next
		  Return New Beacon.GenericIterator(Contents)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxItems() As Integer
		  Return Max(Self.mMaxItems, 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQualityModifier(Modifier As Beacon.PresetModifier) As Integer
		  Return Self.MaxQualityModifier(Modifier.ModifierID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQualityModifier(ModifierID As String) As Integer
		  If Self.mModifierValues = Nil Then
		    Return 0
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  If Dict.HasKey("MaxQuality") Then
		    Return Dict.Value("MaxQuality")
		  Else
		    Return Dict.Lookup("Quality", 0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinItems() As Integer
		  Return Max(Self.mMinItems, 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQualityModifier(Modifier As Beacon.PresetModifier) As Integer
		  Return Self.MinQualityModifier(Modifier.ModifierID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQualityModifier(ModifierID As String) As Integer
		  If Self.mModifierValues = Nil Then
		    Return 0
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  If Dict.HasKey("MinQuality") Then
		    Return Dict.Value("MinQuality")
		  Else
		    Return Dict.Lookup("Quality", 0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.PresetEntry
		  Return New Beacon.PresetEntry(Self.mContents(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PresetID() As String
		  If Self.mPresetID = "" Then
		    Self.mPresetID = Beacon.CreateUUID
		  End If
		  Return Self.mPresetID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(Modifier As Beacon.PresetModifier) As Double
		  Return Self.QuantityMultiplier(Modifier.ModifierID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(ModifierID As String) As Double
		  If Self.mModifierValues = Nil Then
		    Return 1.0
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  Return Dict.Lookup("Quantity", 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function SourceKindToModifierID(Kind As String) As String()
		  Dim IDs() As String
		  Select Case Kind
		  Case "Bonus"
		    IDs.Append(Beacon.PresetModifier.BonusCratesID)
		    IDs.Append(Beacon.PresetModifier.AberrationSurfaceBonusCratesID)
		  Case "Cave"
		    IDs.Append(Beacon.PresetModifier.CaveCratesID)
		  Case "Sea"
		    IDs.Append(Beacon.PresetModifier.DeepSeaCratesID)
		    IDs.Append(Beacon.PresetModifier.OpenDesertCratesID)
		  Case "Standard"
		    IDs.Append(Beacon.PresetModifier.BasicCratesID)
		    IDs.Append(Beacon.PresetModifier.AberrationSurfaceCratesID)
		    IDs.Append(Beacon.PresetModifier.BossesID)
		    IDs.Append(Beacon.PresetModifier.ArtifactCratesID)
		  End Select
		  Return IDs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Dim Hashes() As String
		  Dim Contents() As Dictionary
		  For Each Entry As Beacon.PresetEntry In Self.mContents
		    Hashes.Append(Entry.Hash)
		    Contents.Append(Entry.Export)
		  Next
		  Hashes.SortWith(Contents)
		  
		  // Export every definition, even though built-ins will be dropped on read. This preserves
		  // the file in the future if a built-in is dropped.
		  Dim Definitions() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mModifierValues
		    Dim ModifierID As String = Entry.Key
		    Dim Modifier As Beacon.PresetModifier = Beacon.Data.GetPresetModifier(ModifierID)
		    If Modifier <> Nil Then
		      Definitions.Append(Modifier.ToDictionary)
		    End If
		  Next
		  
		  Dim Dict As New Dictionary
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
		  Call File.Write(Beacon.GenerateJSON(Self.ToDictionary, True))
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
		Protected mGrouping As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModifierValues As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresetID As String
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
