#tag Class
Protected Class BlueprintImporter
	#tag Method, Flags = &h0
		Function BlueprintAt(Index As Integer) As Ark.Blueprint
		  Return Self.mBlueprints(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintCount() As Integer
		  Return Self.mBlueprints.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintLastIndex() As Integer
		  Return Self.mBlueprints.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Blueprints() As Ark.Blueprint()
		  Var Arr() As Ark.Blueprint
		  Arr.ResizeTo(Self.mBlueprints.LastIndex)
		  For Idx As Integer = Self.mBlueprints.FirstIndex To Self.mBlueprints.LastIndex
		    Arr(Idx) = Self.mBlueprints(Idx)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Contents As String, Progress As ProgressWindow = Nil) As Ark.BlueprintImporter
		  Var Importer As Ark.BlueprintImporter
		  
		  Importer = ImportAsDataDumper(Contents, Progress)
		  If (Progress Is Nil) = False And Progress.CancelPressed Then
		    Return Nil
		  ElseIf (Importer Is Nil) = False Then
		    Return Importer
		  End If
		  
		  Importer = ImportAsJSON(Contents, Progress)
		  If (Progress Is Nil) = False And Progress.CancelPressed Then
		    Return Nil
		  ElseIf (Importer Is Nil) = False Then
		    Return Importer
		  End If
		  
		  Importer = ImportAsPlain(Contents, Progress)
		  If (Progress Is Nil) = False And Progress.CancelPressed Then
		    Return Nil
		  Else
		    Return Importer
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsDataDumper(Contents As String, Progress As ProgressWindow = Nil) As Ark.BlueprintImporter
		  If Contents.IndexOf("########## Start ") = -1 And Contents.IndexOf(" Data ##########") = -1 Then
		    Return Nil
		  End If
		  
		  Contents = Contents.ReplaceLineEndings(EndOfLine)
		  
		  // Cleanup an inconsistency
		  Contents = Contents.ReplaceAll("{END_DINO}", "{END_CREATURE}")
		  
		  Var OffsetMax As Integer = Contents.Length
		  Var Importer As New Ark.BlueprintImporter
		  Var ItemDicts(), CreatureDicts(), SpawnDicts(), LootDicts(), DropDicts() As Dictionary
		  Var EngramsByClass As New Dictionary
		  
		  If (Progress Is Nil) = False Then
		    Progress.Detail = "Parsing log output…"
		  End If
		  Var Offset As Integer
		  While Offset > -1
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    If (Progress Is Nil) = False Then
		      Progress.Progress = Offset / OffsetMax
		    End If
		    Offset = Contents.IndexOf(Offset, "Dump-")
		    If Offset = -1 Then
		      Continue
		    End If
		    Offset = Offset + 5
		    
		    Var LineStartPos As Integer = Contents.IndexOf(Offset, "{")
		    If LineStartPos = -1 Then
		      Continue
		    End If
		    Var Type As String = Contents.Middle(Offset, LineStartPos - Offset)
		    
		    Var LineEndSequence As String = "{END_" + Type.Uppercase + "}"
		    Var LineEndPos As Integer = Contents.IndexOf(LineStartPos, LineEndSequence)
		    Var Line As String = Contents.Middle(LineStartPos, LineEndPos - LineStartPos)
		    Offset = Max(LineEndPos + LineEndSequence.Length, LineStartPos)
		    
		    Var Values As Dictionary = ParseDataDumperLine(Line)
		    If Values.HasKey("PATH") = False Then
		      Continue
		    End If
		    
		    Var Path As String = Values.Value("PATH")
		    If Path.BeginsWith("/Game/Mods/") = False Then
		      Continue
		    End If
		    Var ModName As String = Path.NthField("/", 4)
		    If Importer.mModNames.IndexOf(ModName) = -1 Then
		      Importer.mModNames.Add(ModName)
		    End If
		    
		    Select Case Type
		    Case "Engram"
		      Var BlueprintClass As String = Values.Value("BLUEPRINT")
		      EngramsByClass.Value(BlueprintClass) = Values
		    Case "Item"
		      ItemDicts.Add(Values)
		    Case "Creature"
		      CreatureDicts.Add(Values)
		    Case "MapSpawner"
		      SpawnDicts.Add(Values)
		    Case "SupplyCrate"
		      LootDicts.Add(Values)
		    Case "Inventory"
		      DropDicts.Add(Values)
		    End Select
		  Wend
		  
		  If (Progress Is Nil) = False Then
		    Progress.Progress = Nil
		    Progress.Detail = "Assembling engrams…"
		  End If
		  For Each ItemDict As Dictionary In ItemDicts
		    Try
		      Var ItemClass As String = ItemDict.Value("CLASS")
		      Var EngramDict As Dictionary = EngramsByClass.Lookup(ItemClass, Nil)
		      Var Path As String = ItemDict.Value("PATH")
		      If Path.EndsWith("_C") Then
		        Path = Path.Left(Path.Length - 2)
		      End If
		      
		      Var Engram As New Ark.MutableEngram(Path, New v4UUID)
		      Engram.Label = ItemDict.Value("DESCRIPTIVE_NAME").StringValue.Trim().ReplaceLineEndings(" ")
		      Engram.AddTag("blueprintable")
		      Select Case ItemDict.Value("ITEM_TYPE").StringValue
		      Case "Resource"
		        Engram.AddTag("resource")
		      End Select
		      
		      If (EngramDict Is Nil) = False Then
		        Var UnlockString As String = EngramDict.Value("CLASS")
		        Engram.EntryString = UnlockString
		        Var IsTek As Boolean = EngramDict.Value("FORCE_IS_TEK_ENGRAM").BooleanValue Or EngramDict.Value("ENGRAM_GROUP").StringValue = "ARK_TEK"
		        If IsTek Then
		          Engram.AddTag("tek")
		        End If
		        Var ManualUnlock As Boolean = EngramDict.Value("CAN_BE_MANUAL").BooleanValue
		        If ManualUnlock Then
		          Var RequiredLevel As Integer = EngramDict.Value("REQ_LEVEL")
		          Var RequiredPoints As Integer = EngramDict.Value("REQ_POINTS")
		          Engram.RequiredPlayerLevel = RequiredLevel
		          Engram.RequiredUnlockPoints = RequiredPoints
		        End If
		      End If
		      
		      Importer.mBlueprints.Add(Engram.ImmutableVersion)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing engram data")
		    End Try
		  Next ItemDict
		  
		  If (Progress Is Nil) = False Then
		    Progress.Detail = "Assembling creatures…"
		  End If
		  For Each CreatureDict As Dictionary In CreatureDicts
		    Try
		      Var Path As String = CreatureDict.Value("PATH")
		      If Path.EndsWith("_C") Then
		        Path = Path.Left(Path.Length - 2)
		      End If
		      
		      Var Creature As New Ark.MutableCreature(Path, New v4UUID)
		      Creature.Label = CreatureDict.Value("DESCRIPTIVE_NAME").StringValue.Trim().ReplaceLineEndings(" ")
		      Importer.mBlueprints.Add(Creature.ImmutableVersion)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing creature data")
		    End Try
		  Next CreatureDict
		  
		  If (Progress Is Nil) = False Then
		    Progress.Detail = "Assembling spawn points…"
		  End If
		  For Each SpawnDict As Dictionary In SpawnDicts
		    Try
		      Var Path As String = SpawnDict.Value("PATH")
		      If Path.EndsWith("_C") Then
		        Path = Path.Left(Path.Length - 2)
		      End If
		      
		      Var Point As New Ark.MutableSpawnPoint(Path, New v4UUID)
		      Point.Label = SpawnDict.Value("CLASS")
		      Importer.mBlueprints.Add(Point.ImmutableVersion)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing spawn point data")
		    End Try
		  Next
		  
		  If (Progress Is Nil) = False Then
		    Progress.Detail = "Assembling loot sources…"
		  End If
		  For Each LootDict As Dictionary In LootDicts
		    Try
		      Var Path As String = LootDict.Value("PATH")
		      If Path.EndsWith("_C") Then
		        Path = Path.Left(Path.Length - 2)
		      End If
		      
		      Var Container As New Ark.MutableLootContainer(Path, New v4UUID)
		      Container.Label = LootDict.Value("CLASS")
		      Container.IconID = "84d76c41-4386-467d-83e7-841dcaa4007d"
		      Importer.mBlueprints.Add(Container.ImmutableVersion)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing supply crate data")
		    End Try
		  Next
		  
		  // This does not work because DataDumper does not have a path for inventories.
		  // But it'll remain in case that changes.
		  If (Progress Is Nil) = False Then
		    Progress.Detail = "Assembling dino inventories…"
		  End If
		  For Each DropDict As Dictionary In DropDicts
		    Try
		      Var Path As String = DropDict.Value("PATH")
		      If Path.EndsWith("_C") Then
		        Path = Path.Left(Path.Length - 2)
		      End If
		      
		      Var Container As New Ark.MutableLootContainer(Path, New v4UUID)
		      Container.Label = DropDict.Value("CLASS")
		      Container.IconID = "41dde824-5675-4515-b222-e860a44619d9"
		      Container.Experimental = True
		      Importer.mBlueprints.Add(Container.ImmutableVersion)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Parsing dino inventory data")
		    End Try
		  Next
		  
		  Return Importer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsJSON(Contents As String, Progress As ProgressWindow = Nil) As Ark.BlueprintImporter
		  Var Parsed As Variant
		  Try
		    #Pragma BreakOnExceptions False
		    Parsed = Beacon.ParseJSON(Contents)
		    #Pragma BreakOnExceptions Default
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Var Dictionaries() As Variant
		  Try
		    Dictionaries = Parsed
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If (Progress Is Nil) = False Then
		    Progress.Detail = "Unpacking blueprints…"
		  End If
		  
		  Var Importer As New Ark.BlueprintImporter
		  For Idx As Integer = Dictionaries.FirstIndex To Dictionaries.LastIndex
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    Try
		      Var Dict As Dictionary = Dictionaries(Idx)
		      Var Blueprint As Ark.Blueprint = Ark.UnpackBlueprint(Dict)
		      If Blueprint Is Nil Then
		        Continue
		      End If
		      
		      Importer.mBlueprints.Add(Blueprint)
		      
		      If Blueprint.ContentPackName.IsEmpty = False Then
		        If Importer.mModNames.IndexOf(Blueprint.ContentPackName) = -1 Then
		          Importer.mModNames.Add(Blueprint.ContentPackName)
		        End If
		      Else
		        Var Path As String = Blueprint.Path
		        If Path.BeginsWith("/Game/Mods/") Then
		          Var ModName As String = Path.NthField("/", 4)
		          If Importer.mModNames.IndexOf(ModName) = -1 Then
		            Importer.mModNames.Add(ModName)
		          End If
		        End If
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  // No matter what, it was still JSON data, even if nothing was found.
		  Return Importer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsPlain(Contents As String, Progress As ProgressWindow = Nil) As Ark.BlueprintImporter
		  // First try to parse as a csv
		  #Pragma BreakOnExceptions False
		  Try
		    Var CarriageReturn As String = Encodings.UTF8.Chr(13)
		    
		    Var Importer As New Ark.BlueprintImporter
		    Var Characters() As String = Contents.Trim.ReplaceLineEndings(CarriageReturn).Split("")
		    Var Lines() As Variant
		    Var ColumnBuffer(), Columns() As String
		    Var Started, InQuotes As Boolean
		    For Each Character As String In Characters
		      If (Progress Is Nil) = False And Progress.CancelPressed Then
		        Return Nil
		      End If
		      
		      If InQuotes Then
		        Started = True
		        If Character = """" Then
		          InQuotes = False
		        Else
		          ColumnBuffer.Add(Character)
		        End If
		      Else
		        If Character = """" Then
		          InQuotes = True
		          If Started Then
		            ColumnBuffer.Add(Character)
		          End If
		        ElseIf Character = "," Then
		          Columns.Add(ColumnBuffer.Join(""))
		          ColumnBuffer.ResizeTo(-1)
		          Started = False
		        ElseIf Character = CarriageReturn Then
		          // Next line
		          Columns.Add(ColumnBuffer.Join(""))
		          Lines.Add(Columns)
		          ColumnBuffer.ResizeTo(-1)
		          Columns = Array("") // To create a new array
		          Columns.ResizeTo(-1)
		          Started = False
		        Else
		          ColumnBuffer.Add(Character)
		        End If
		      End If
		    Next
		    Columns.Add(ColumnBuffer.Join(""))
		    Lines.Add(Columns)
		    
		    Var HeaderColumns() As String
		    If Lines.LastIndex >= 0 Then
		      HeaderColumns = Lines(0)
		      Lines.RemoveAt(0)
		    End If
		    Var PathColumnIdx, LabelColumnIdx, MaskColumnIdx, BlueprintColumnIdx, TagsColumnIndx, GroupColumnIdx As Integer
		    PathColumnIdx = HeaderColumns.IndexOf("Path")
		    LabelColumnIdx = HeaderColumns.IndexOf("Label")
		    MaskColumnIdx = HeaderColumns.IndexOf("Availability Mask")
		    TagsColumnIndx = HeaderColumns.IndexOf("Tags")
		    GroupColumnIdx = HeaderColumns.IndexOf("Group")
		    BlueprintColumnIdx = HeaderColumns.IndexOf("Can Blueprint")
		    
		    Var AllAvailabilityMask As UInt64 = Ark.Maps.UniversalMask
		    
		    If PathColumnIdx = -1 Or LabelColumnIdx = -1 Then
		      Var Err As New UnsupportedFormatException
		      Err.Message = "CSV import requires at least Path and Label columns. Make sure the data includes a header row."
		      Raise Err
		    End If
		    
		    For Each Columns In Lines
		      If (Progress Is Nil) = False And Progress.CancelPressed Then
		        Return Nil
		      End If
		      
		      Var Path As String = Columns(PathColumnIdx)
		      Var Label As String = Columns(LabelColumnIdx)
		      Var Availability As UInt64
		      Var Tags() As String
		      If MaskColumnIdx > -1 Then
		        Availability = UInt64.FromString(Columns(MaskColumnIdx))
		      Else
		        Availability = AllAvailabilityMask
		      End If
		      If TagsColumnIndx > -1 Then
		        Tags = Columns(TagsColumnIndx).Split(",")
		      ElseIf BlueprintColumnIdx > -1 Then
		        Var CanBlueprint As Boolean = If(Columns(BlueprintColumnIdx) = "True", True, False)
		        If CanBlueprint Then
		          Tags.Add("blueprintable")
		        End If
		      End If
		      
		      Var Category As String = "engrams"
		      If GroupColumnIdx > -1 Then
		        Category = Columns(GroupColumnIdx)
		      End If
		      
		      Var Blueprint As Ark.MutableBlueprint
		      Select Case Category
		      Case Ark.CategoryEngrams
		        Blueprint = New Ark.MutableEngram(Path, New v4UUID)
		      Case Ark.CategoryCreatures
		        Blueprint = New Ark.MutableCreature(Path, New v4UUID)
		      Else
		        Continue
		      End Select
		      
		      Blueprint.Tags = Tags
		      Blueprint.Availability = Availability
		      Blueprint.Label = Label
		      
		      If (Progress Is Nil) = False And Progress.CancelPressed Then
		        Return Nil
		      End If
		      Importer.mBlueprints.Add(Blueprint.Clone)
		      
		      If Path.BeginsWith("/Game/Mods/") Then
		        Var ModName As String = Path.NthField("/", 4)
		        If Importer.mModNames.IndexOf(ModName) = -1 Then
		          Importer.mModNames.Add(ModName)
		        End If
		      End If
		    Next
		    
		    Return Importer
		  Catch Err As RuntimeException
		    // Probably not a CSV
		  End Try
		  #Pragma BreakOnExceptions Default
		  
		  Const QuotationCharacters = "'‘’""“”"
		  
		  Var Regex As New Regex
		  Regex.Options.CaseSensitive = False
		  Regex.SearchPattern = "(giveitem|spawndino)\s+(([" + QuotationCharacters + "]Blueprint[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "]BlueprintGeneratedClass[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)_C[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]))"
		  
		  Var Importer As New Ark.BlueprintImporter
		  Var Match As RegexMatch = Regex.Search(Contents)
		  Var Paths As New Dictionary
		  Do
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    If Match = Nil Then
		      Continue
		    End If
		    
		    Var Command As String = Match.SubExpressionString(1)
		    Var Path As String
		    If Match.SubExpressionCount >= 4 And Match.SubExpressionString(4) <> "" Then
		      Path = Match.SubExpressionString(4)
		    ElseIf Match.SubExpressionCount >= 6 And Match.SubExpressionString(6) <> "" Then
		      Path = Match.SubExpressionString(6)
		    ElseIf Match.SubExpressionCount >= 8 And Match.SubExpressionString(8) <> "" Then
		      Path = Match.SubExpressionString(8)
		    End If
		    If Path.IsEmpty = False And Command.IsEmpty = False Then
		      If Path.EndsWith("_C") Then
		        Path = Path.Left(Path.Length - 2)
		      End If
		      Paths.Value(Path) = Command
		    End If
		    
		    Match = Regex.Search
		  Loop Until Match Is Nil
		  
		  If (Progress Is Nil) = False And Progress.CancelPressed Then
		    Return Nil
		  End If
		  
		  If Paths.KeyCount = 0 Then
		    Return Nil
		  End If
		  
		  Var Keys() As Variant = Paths.Keys
		  For Each Key As String In Keys
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    Var Command As String = Paths.Value(Key)
		    Var Path As String = Key
		    Var Blueprint As Ark.Blueprint
		    Select Case Command
		    Case "giveitem"
		      Blueprint = New Ark.MutableEngram(Path, New v4UUID)
		    Case "spawndino"
		      Blueprint = New Ark.MutableCreature(Path, New v4UUID)
		    End Select
		    
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    Importer.mBlueprints.Add(Blueprint)
		    
		    If Path.BeginsWith("/Game/Mods/") Then
		      Var ModName As String = Path.NthField("/", 4)
		      If Importer.mModNames.IndexOf(ModName) = -1 Then
		        Importer.mModNames.Add(ModName)
		      End If
		    End If
		  Next
		  
		  Return Importer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModNameAt(Index As Integer) As String
		  Return Self.mModNames(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModNameCount() As Integer
		  Return Self.mModNames.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModNameLastIndex() As Integer
		  Return Self.mModNames.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModNames() As String()
		  Var Arr() As String
		  Arr.ResizeTo(Self.mModNames.LastIndex)
		  For Idx As Integer = Self.mModNames.FirstIndex To Self.mModNames.LastIndex
		    Arr(Idx) = Self.mModNames(Idx)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ParseDataDumperLine(Line As String) As Dictionary
		  Var Values As New Dictionary
		  Var Offset As Integer
		  While Offset > -1
		    Var KeyStartPos As Integer = Line.IndexOf(Offset, "{")
		    If KeyStartPos = -1 Then
		      Return Values
		    End If
		    KeyStartPos = KeyStartPos + 1
		    
		    Var KeyEndPos As Integer = Line.IndexOf(KeyStartPos, "}")
		    Var Key As String = Line.Middle(KeyStartPos, KeyEndPos - KeyStartPos)
		    
		    Var ValueStartPos As Integer = KeyEndPos + 1
		    Var ValueEndPos As Integer = Line.IndexOf(ValueStartPos, "{")
		    Var Value As String
		    If ValueEndPos = -1 Then
		      Value = Line.Middle(ValueStartPos)
		      Offset = Line.Length
		    Else
		      Value = Line.Middle(ValueStartPos, ValueEndPos - ValueStartPos)
		      Offset = ValueEndPos
		    End If
		    
		    Values.Value(Key) = Value
		  Wend
		  
		  Return Values
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprints() As Ark.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModNames() As String
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
