#tag Class
Protected Class BlueprintImporter
	#tag Method, Flags = &h0
		Function BlueprintAt(Idx As Integer) As ArkSA.Blueprint
		  Return Self.mBlueprints(Idx)
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
		Function Blueprints() As ArkSA.Blueprint()
		  Var Arr() As ArkSA.Blueprint
		  Arr.ResizeTo(Self.mBlueprints.LastIndex)
		  For Idx As Integer = Self.mBlueprints.FirstIndex To Self.mBlueprints.LastIndex
		    Arr(Idx) = Self.mBlueprints(Idx)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMods = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackAt(Idx As Integer) As Beacon.ContentPack
		  Return Self.mContentPacks(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackCount() As Integer
		  Return Self.mContentPacks.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackLastIndex() As Integer
		  Return Self.mContentPacks.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPacks() As Beacon.ContentPack()
		  Var Arr() As Beacon.ContentPack
		  Arr.ResizeTo(Self.mContentPacks.LastIndex)
		  For Idx As Integer = Self.mContentPacks.FirstIndex To Self.mContentPacks.LastIndex
		    Arr(Idx) = Self.mContentPacks(Idx)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Contents As String, Progress As ProgressWindow = Nil) As ArkSA.BlueprintImporter
		  Var Importer As ArkSA.BlueprintImporter
		  
		  Importer = ImportAsBinary(Contents, Progress)
		  If (Progress Is Nil) = False ANd Progress.CancelPressed Then
		    Return Nil
		  ElseIf (Importer Is Nil) = False Then
		    Return Importer
		  End If
		  
		  Importer = ImportAsJson(Contents, Progress)
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
		Shared Function ImportAsBinary(Contents As String, Progress As ProgressWindow = Nil) As ArkSA.BlueprintImporter
		  Var Archive As Beacon.Archive
		  Try
		    Archive = Beacon.Archive.Open(Contents)
		  Catch Err As RuntimeException
		  End Try
		  If Archive Is Nil Then
		    // Not a .beacondata file
		    Return Nil
		  End If
		  
		  // Return the importer no matter what, because this is an archive file
		  Var Importer As New ArkSA.BlueprintImporter
		  
		  Var ManifestString As String = Archive.GetFile("Manifest.json")
		  If ManifestString.IsEmpty Then
		    Return Importer
		  End If
		  
		  Var Manifest As Dictionary
		  Var Filenames() As Variant
		  Try
		    Manifest = Beacon.ParseJSON(ManifestString)
		    Filenames = Manifest.Value("files")
		    If Manifest.Lookup("minVersion", 7).IntegerValue > 7 Then
		      Return Importer
		    End If
		  Catch Err As RuntimeException
		    Return Importer
		  End Try
		  
		  If (Progress Is Nil) = False Then
		    Progress.ShowSubProgress = True
		  End If
		  
		  Var NumFiles As Integer = Filenames.Count
		  Var FilesProcessed As Integer = 0
		  For Each Filename As Variant In Filenames
		    If (Progress Is Nil) = False Then
		      If Progress.CancelPressed Then
		        Return Nil
		      End If
		      
		      Progress.Detail = "Processing " + Filename + "..."
		      Progress.Progress = FilesProcessed / NumFiles
		    End If
		    
		    Try
		      Var FileContents As String = Archive.GetFile(Filename.StringValue)
		      Var Parsed As Dictionary = Beacon.ParseJSON(FileContents)
		      Var Payloads() As Variant = Parsed.Value("payloads")
		      For Each Payload As Dictionary In Payloads
		        If Payload.Value("gameId") <> ArkSA.Identifier Then
		          Continue
		        End If
		        
		        Var TotalObjects As Integer
		        Var ObjectsProcessed As Integer
		        Var ContentPackDicts() As Variant
		        
		        If Payload.HasKey("contentPacks") Then
		          ContentPackDicts = Payload.Value("contentPacks")
		          TotalObjects = TotalObjects + ContentPackDicts.Count
		        End If
		        
		        Var BlueprintArrays() As Variant
		        Var Keys() As String = Array("engrams", "creatures", "lootDrops", "spawnPoints")
		        For Each Key As String In Keys
		          If Payload.HasKey(Key) Then
		            Var BlueprintDicts() As Variant = Payload.Value(Key)
		            TotalObjects = TotalObjects + BlueprintDicts.Count
		            BlueprintArrays.Add(BlueprintDicts)
		          End If
		        Next
		        
		        If (Progress Is Nil) = False Then
		          Progress.SubProgress = ObjectsProcessed / TotalObjects
		        End If
		        
		        For Each ContentPackDict As Dictionary In ContentPackDicts
		          If (Progress Is Nil) = False And Progress.CancelPressed Then
		            Return Nil
		          End If
		          
		          Var ContentPack As Beacon.ContentPack = Beacon.ContentPack.FromSaveData(ContentPackDict)
		          If (ContentPack Is Nil) = False Then
		            Importer.mContentPacks.Add(ContentPack)
		            If (Progress Is Nil) = False Then
		              Progress.SubDetail = "Found mod " + ContentPack.Name + "…"
		            End If
		          End If
		          
		          ObjectsProcessed = ObjectsProcessed + 1
		          
		          If (Progress Is Nil) = False Then
		            Progress.SubProgress = ObjectsProcessed / TotalObjects
		          End If
		        Next
		        
		        For Each BlueprintArray As Variant In BlueprintArrays
		          If (Progress Is Nil) = False And Progress.CancelPressed Then
		            Return Nil
		          End If
		          
		          Var BlueprintDicts() As Variant = BlueprintArray
		          For Each BlueprintDict As Dictionary In BlueprintDicts
		            If (Progress Is Nil) = False And Progress.CancelPressed Then
		              Return Nil
		            End If
		            
		            Var Blueprint As ArkSA.Blueprint = ArkSA.UnpackBlueprint(BlueprintDict)
		            If (Blueprint Is Nil) = False Then
		              Importer.mBlueprints.Add(Blueprint)
		              If (Progress Is Nil) = False Then
		                Progress.SubDetail = "Found blueprint " + Blueprint.Label + "…"
		              End If
		              
		              If Blueprint.Path.BeginsWith("/Game/Mods/") Then
		                Var Tag As String = Blueprint.Path.NthField("/", 4)
		                If Importer.mMods.HasKey(Tag) = False Then
		                  Var ContentPackName As String = Tag
		                  If Blueprint.ContentPackName.IsEmpty = False Then
		                    ContentPackName = Blueprint.ContentPackName + " (" + Tag + ")"
		                  End If
		                  Importer.mMods.Value(Tag) = ContentPackName
		                End If
		              End If
		            End If
		            
		            ObjectsProcessed = ObjectsProcessed + 1
		            If (Progress Is Nil) = False Then
		              Progress.SubProgress = ObjectsProcessed / TotalObjects
		            End If
		          Next
		        Next
		      Next
		    Catch Err As RuntimeException
		    End Try
		    
		    FilesProcessed = FilesProcessed + 1
		    If (Progress Is Nil) = False Then
		      Progress.Progress = FilesProcessed / NumFiles
		    End If
		  Next
		  
		  Return Importer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsJson(Contents As String, Progress As ProgressWindow = Nil) As ArkSA.BlueprintImporter
		  Var Parsed As Variant
		  Try
		    #Pragma BreakOnExceptions False
		    Parsed = Beacon.ParseJSON(Contents)
		    #Pragma BreakOnExceptions Default
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Var Blueprints() As Variant
		  Var ContentPacks() As Variant
		  If Parsed.IsArray Then
		    Try
		      Blueprints = Parsed
		    Catch Err As RuntimeException
		    End Try
		  Else
		    Var ExportDict As Dictionary
		    Try
		      ExportDict = Parsed
		      If ExportDict.Value("minVersion") > 1 Then
		        Return Nil
		      End If
		      Blueprints = ExportDict.Value("blueprints")
		      If ExportDict.HasKey("contentPacks") Then
		        ContentPacks = ExportDict.Value("contentPacks")
		      ElseIf ExportDict.HasKey("contentPack") Then
		        ContentPacks.Add(ExportDict.Value("contentPack"))
		      End If
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  
		  Var NumProcessed As Integer = 0
		  Var NumToProcess As Integer = Blueprints.Count + ContentPacks.Count
		  If (Progress Is Nil) = False Then
		    Progress.Detail = "Unpacking blueprints…"
		    Progress.Progress = NumProcessed / NumToProcess
		  End If
		  
		  Var Importer As New ArkSA.BlueprintImporter
		  For Idx As Integer = ContentPacks.FirstIndex To ContentPacks.LastIndex
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromSaveData(ContentPacks(Idx))
		    If (Pack Is Nil) = False Then
		      Importer.mContentPacks.Add(Pack)
		    End If
		    
		    NumProcessed = NumProcessed + 1
		    If (Progress Is Nil) = False Then
		      Progress.Progress = NumProcessed / NumToProcess
		    End If
		  Next
		  
		  For Idx As Integer = Blueprints.FirstIndex To Blueprints.LastIndex
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    Try
		      Var Dict As Dictionary = Blueprints(Idx)
		      Var Blueprint As ArkSA.Blueprint = ArkSA.UnpackBlueprint(Dict)
		      If Blueprint Is Nil Then
		        Continue
		      End If
		      
		      Importer.mBlueprints.Add(Blueprint)
		      
		      Var Path As String = Blueprint.Path
		      If Path.BeginsWith("/Game/Mods/") Then
		        Var ModTag As String = Path.NthField("/", 4)
		        Var ModName As String = ModTag
		        If Blueprint.ContentPackName.IsEmpty = False Then
		          ModName = Blueprint.ContentPackName
		        End If
		        If ModName <> ModTag Then
		          ModName = ModName + " (" + ModTag + ")"
		        End If
		        Importer.mMods.Value(ModTag) = ModName
		      End If
		    Catch Err As RuntimeException
		    End Try
		    
		    NumProcessed = NumProcessed + 1
		    If (Progress Is Nil) = False Then
		      Progress.Progress = NumProcessed / NumToProcess
		    End If
		  Next
		  
		  // No matter what, it was still JSON data, even if nothing was found.
		  Return Importer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportAsPlain(Contents As String, Progress As ProgressWindow = Nil) As ArkSA.BlueprintImporter
		  // First try to parse as a csv
		  #Pragma BreakOnExceptions False
		  Try
		    Var CarriageReturn As String = Encodings.UTF8.Chr(13)
		    
		    Var Importer As New ArkSA.BlueprintImporter
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
		    
		    Var AllAvailabilityMask As UInt64 = ArkSA.Maps.UniversalMask
		    
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
		      Var ModTag As String = ArkSA.ModTagFromPath(Path)
		      If ModTag.IsEmpty Then
		        Continue
		      End If
		      Importer.mMods.Value(ModTag) = ModTag
		      
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
		      
		      Var Blueprint As ArkSA.MutableBlueprint
		      Var BlueprintId As String = Beacon.UUID.v4
		      Select Case Category
		      Case ArkSA.CategoryEngrams
		        Blueprint = New ArkSA.MutableEngram(Path, BlueprintId)
		      Case ArkSA.CategoryCreatures
		        Blueprint = New ArkSA.MutableCreature(Path, BlueprintId)
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
		    Next
		    
		    Return Importer
		  Catch Err As RuntimeException
		    // Probably not a CSV
		  End Try
		  #Pragma BreakOnExceptions Default
		  
		  Var Regex As Regex = ArkSA.BlueprintPathRegex
		  Var Importer As New ArkSA.BlueprintImporter
		  Var Match As RegexMatch = Regex.Search(Contents)
		  Var Paths As New Dictionary
		  Do
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    If Match Is Nil Then
		      Continue
		    End If
		    
		    Var Command As String = Match.SubExpressionString(1)
		    Var Path As String = ArkSA.BlueprintPath(Match)
		    If Path.IsEmpty = False And Command.IsEmpty = False Then
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
		    Var ModTag As String = ArkSA.ModTagFromPath(Path)
		    If ModTag.IsEmpty Then
		      Continue
		    End If
		    Importer.mMods.Value(ModTag) = ModTag
		    
		    Var Blueprint As ArkSA.Blueprint
		    Var BlueprintId As String = Beacon.UUID.v4
		    Select Case Command
		    Case "giveitem"
		      Blueprint = New ArkSA.MutableEngram(Path, BlueprintId)
		    Case "spawndino"
		      Blueprint = New ArkSA.MutableCreature(Path, BlueprintId)
		    End Select
		    
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    If (Progress Is Nil) = False And Progress.CancelPressed Then
		      Return Nil
		    End If
		    Importer.mBlueprints.Add(Blueprint)
		  Next
		  
		  Return Importer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModCount() As Integer
		  Return Self.mMods.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModNameForTag(Tag As String) As String
		  Return Self.mMods.Lookup(Tag, Tag)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModTags() As String()
		  Var Tags() As String
		  For Each Entry As DictionaryEntry In Self.mMods
		    Tags.Add(Entry.Key)
		  Next
		  Return Tags
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
		Private mBlueprints() As ArkSA.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPacks() As Beacon.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Dictionary
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
