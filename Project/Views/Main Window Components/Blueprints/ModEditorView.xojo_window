#tag Window
Begin BeaconSubview ModEditorView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   432
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   844
   Begin BeaconListbox BlueprintList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "*,80"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   391
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Type"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   844
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin ClipboardWatcher Watcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin OmniBar ModToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   844
   End
   Begin Thread ImporterThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.ViewTitle = Self.mController.ModName
		  
		  Self.UpdatePublishButton()
		  Self.mController.LoadBlueprints()
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  Self.mController.Publish
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function ClipboardHasCodes() As Boolean
		  Var Board As New Clipboard
		  Return ClipboardHasCodes(Board)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ClipboardHasCodes(Board As Clipboard) As Boolean
		  If Not Board.TextAvailable Then
		    Return False
		  End If
		  
		  Var Content As String = Board.Text
		  Return Content.IndexOf("Blueprint") > -1 Or Content.IndexOf("giveitem") > -1 Or Content.IndexOf("spawndino") > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Controller As BlueprintController)
		  AddHandler Controller.BlueprintsLoaded, WeakAddressOf mController_BlueprintsLoaded
		  AddHandler Controller.PublishFinished, WeakAddressOf mController_PublishFinished
		  AddHandler Controller.WorkStarted, WeakAddressOf mController_WorkStarted
		  AddHandler Controller.WorkFinished, WeakAddressOf mController_WorkFinished
		  
		  Self.mController = Controller
		  Self.ViewID = Controller.ModID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Export()
		  Var Dialog As New SaveFileDialog
		  Dialog.SuggestedFileName = "Exported Blueprints.json"
		  Dialog.Filter = BeaconFileTypes.JsonFile
		  
		  Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Var Packed() As Dictionary
		  Var SelectAll As Boolean = Self.BlueprintList.SelectedRowCount = 0
		  For Idx As Integer = 0 To Self.BlueprintList.LastRowIndex
		    If SelectAll Or Self.BlueprintList.Selected(Idx) Then
		      Var ObjectID As String = Self.BlueprintList.RowTagAt(Idx)
		      Var Blueprint As Ark.Blueprint = Self.mController.Blueprint(ObjectID)
		      If Blueprint Is Nil Then
		        Continue
		      End If
		      
		      Packed.Add(Blueprint.Pack)
		    End If
		  Next
		  
		  Var JSON As String
		  Try
		    JSON = Beacon.GenerateJSON(Packed, True)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Could not export blueprints", "There was an error while generating the JSON content: " + Err.Message)
		    Return
		  End Try
		  
		  If Not File.Write(JSON) Then
		    Self.ShowAlert("Could not export blueprints", "Beacon was unable to save the JSON file to disk.")
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Import(Contents As String)
		  If Self.ImporterThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Return
		  End If
		  
		  Self.mProgress = New ProgressWindow("Importing blueprints…", "Getting started…")
		  Self.mProgress.ShowDelayed(Self.TrueWindow)
		  
		  Self.mFoundBlueprints.ResizeTo(-1)
		  Self.mFoundModNames.ResizeTo(-1)
		  Self.mContentToImport = Contents.GuessEncoding
		  Self.ImporterThread.Start
		  
		  Self.Progress = BeaconSubview.ProgressIndeterminate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportAsDataDumper(Contents As String) As Boolean
		  If Contents.IndexOf("########## Start ") = -1 And Contents.IndexOf(" Data ##########") = -1 Then
		    Return False
		  End If
		  
		  Contents = Contents.ReplaceLineEndings(EndOfLine)
		  
		  // Cleanup an inconsistency
		  Contents = Contents.ReplaceAll("{END_DINO}", "{END_CREATURE}")
		  Var OffsetMax As Integer = Contents.Length
		  
		  Var ItemDicts(), CreatureDicts(), SpawnDicts() As Dictionary
		  Var EngramsByClass As New Dictionary
		  
		  Self.mProgress.Detail = "Parsing log output…"
		  Var Offset As Integer
		  While Offset > -1
		    If Self.mProgress.CancelPressed Then
		      Return True
		    End If
		    
		    Self.mProgress.Progress = Offset / OffsetMax
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
		    
		    Var Values As Dictionary = Self.ParseDataDumperLine(Line)
		    If Values.HasKey("PATH") = False Then
		      Continue
		    End If
		    
		    Var Path As String = Values.Value("PATH")
		    If Path.BeginsWith("/Game/Mods/") = False Then
		      Continue
		    End If
		    Var ModName As String = Path.NthField("/", 4)
		    If Self.mFoundModNames.IndexOf(ModName) = -1 Then
		      Self.mFoundModNames.Add(ModName)
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
		    End Select
		  Wend
		  Self.mProgress.Progress = Nil
		  
		  Self.mProgress.Detail = "Assembling engrams…"
		  For Each ItemDict As Dictionary In ItemDicts
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
		    
		    Self.mFoundBlueprints.Add(Engram.ImmutableVersion)
		  Next ItemDict
		  
		  Self.mProgress.Detail = "Assembling creatures…"
		  For Each CreatureDict As Dictionary In CreatureDicts
		    Var Path As String = CreatureDict.Value("PATH")
		    If Path.EndsWith("_C") Then
		      Path = Path.Left(Path.Length - 2)
		    End If
		    
		    Var Creature As New Ark.MutableCreature(Path, New v4UUID)
		    Creature.Label = CreatureDict.Value("DESCRIPTIVE_NAME").StringValue.Trim().ReplaceLineEndings(" ")
		    Self.mFoundBlueprints.Add(Creature.ImmutableVersion)
		  Next CreatureDict
		  
		  Self.mProgress.Detail = "Assembling spawn points…"
		  For Each SpawnDict As Dictionary In SpawnDicts
		    Var Path As String = SpawnDict.Value("PATH")
		    If Path.EndsWith("_C") Then
		      Path = Path.Left(Path.Length - 2)
		    End If
		    
		    Var Point As New Ark.MutableSpawnPoint(Path, New v4UUID)
		    Point.Label = SpawnDict.Value("CLASS")
		    Self.mFoundBlueprints.Add(Point.ImmutableVersion)
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportAsJSON(Contents As String) As Boolean
		  Var Parsed As Variant
		  Try
		    #Pragma BreakOnExceptions False
		    Parsed = Beacon.ParseJSON(Contents)
		    #Pragma BreakOnExceptions Default
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Var Dictionaries() As Variant
		  Try
		    Dictionaries = Parsed
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Self.mProgress.Detail = "Unpacking blueprints…"
		  For Idx As Integer = 0 To Dictionaries.LastIndex
		    If Self.mProgress.CancelPressed Then
		      Return True
		    End If
		    
		    Try
		      Var Dict As Dictionary = Dictionaries(Idx)
		      Var Blueprint As Ark.Blueprint = Ark.UnpackBlueprint(Dict)
		      If (Blueprint Is Nil) = False Then
		        Self.mFoundBlueprints.Add(Blueprint)
		        
		        Var Path As String = Blueprint.Path
		        If Path.BeginsWith("/Game/Mods/") Then
		          Var ModName As String = Path.NthField("/", 4)
		          If Self.mFoundModNames.IndexOf(ModName) = -1 Then
		            Self.mFoundModNames.Add(ModName)
		          End If
		        End If
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  // No matter what, it was still JSON data, even if nothing was found.
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportAsPlain(Contents As String)
		  // First try to parse as a csv
		  #Pragma BreakOnExceptions False
		  Try
		    Var CarriageReturn As String = Encodings.UTF8.Chr(13)
		    
		    Var Characters() As String = Contents.Trim.ReplaceLineEndings(CarriageReturn).Split("")
		    Var Lines() As Variant
		    Var ColumnBuffer(), Columns() As String
		    Var Started, InQuotes As Boolean
		    For Each Character As String In Characters
		      If Self.mProgress.CancelPressed Then
		        Return
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
		      If Self.mProgress.CancelPressed Then
		        Return
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
		      
		      If Self.mProgress.CancelPressed Then
		        Return
		      End If
		      Self.mFoundBlueprints.Add(Blueprint.Clone)
		      
		      If Path.BeginsWith("/Game/Mods/") Then
		        Var ModName As String = Path.NthField("/", 4)
		        If Self.mFoundModNames.IndexOf(ModName) = -1 Then
		          Self.mFoundModNames.Add(ModName)
		        End If
		      End If
		    Next
		    
		    Return
		  Catch Err As RuntimeException
		    // Probably not a CSV
		  End Try
		  #Pragma BreakOnExceptions Default
		  
		  Const QuotationCharacters = "'‘’""“”"
		  
		  Var Regex As New Regex
		  Regex.Options.CaseSensitive = False
		  Regex.SearchPattern = "(giveitem|spawndino)\s+(([" + QuotationCharacters + "]Blueprint[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "]BlueprintGeneratedClass[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)_C[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]))"
		  
		  Var Match As RegexMatch = Regex.Search(Contents)
		  Var Paths As New Dictionary
		  Do
		    If Self.mProgress.CancelPressed Then
		      Return
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
		  
		  If Self.mProgress.CancelPressed Then
		    Return
		  End If
		  
		  If Paths.KeyCount = 0 Then
		    Return
		  End If
		  
		  Var Keys() As Variant = Paths.Keys
		  For Each Key As String In Keys
		    If Self.mProgress.CancelPressed Then
		      Return
		    End If
		    
		    Var Command As String = Paths.Value(Key)
		    Var Path As String = Key
		    Var Blueprint As Ark.Blueprint
		    Select Case Command
		    Case "giveitem"
		      Blueprint = Ark.ResolveEngram("", Path, "", New Beacon.StringList(Ark.UserContentPackUUID))
		    Case "spawndino"
		      Blueprint = Ark.ResolveCreature("", Path, "", New Beacon.StringList(Ark.UserContentPackUUID))
		    End Select
		    
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    If Self.mProgress.CancelPressed Then
		      Return
		    End If
		    Self.mFoundBlueprints.Add(Blueprint)
		    
		    If Path.BeginsWith("/Game/Mods/") Then
		      Var ModName As String = Path.NthField("/", 4)
		      If Self.mFoundModNames.IndexOf(ModName) = -1 Then
		        Self.mFoundModNames.Add(ModName)
		      End If
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromClipboard()
		  Var Board As New Clipboard
		  
		  If Not Self.ClipboardHasCodes(Board) Then
		    Return
		  End If
		  
		  Self.Import(Board.Text)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromFile()
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.Text + BeaconFileTypes.CSVFile + BeaconFileTypes.JsonFile
		  
		  Var File As FolderItem = Dialog.ShowModal(Parent.TrueWindow)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Var Contents As String
		  Try
		    Contents = File.Read
		  Catch Err As RuntimeException
		    Self.ShowAlert("Could not open file", "Beacon was unable to open the selected file: " + Err.Message)
		    Return
		  End Try
		  
		  Self.Import(Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromURL()
		  Var Contents As String = LibraryEngramsURLDialog.Present(Self)
		  If Contents.IsEmpty Then
		    Return
		  End If
		  
		  Self.Import(Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_BlueprintsLoaded(Sender As BlueprintController)
		  #Pragma Unused Sender
		  
		  Self.UpdateList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_PublishFinished(Sender As BlueprintController, Success As Boolean, Reason As String)
		  If Success Then
		    Self.mController.LoadBlueprints()
		  Else
		    Self.UpdatePublishButton()
		  End If
		  
		  If Success Then
		    If Sender.UseSaveTerminology = False Then
		      Self.ShowAlert("Your changes have been published.", "Because Beacon generates new update files every 15 minutes, it may take some time for the changes to be available to users.")
		    End If
		  Else
		    If Sender.UseSaveTerminology Then
		      Self.ShowAlert("Beacon was unable to save the changes.", Reason)
		    Else
		      Self.ShowAlert("Beacon was unable to publish the requested changes.", Reason)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkFinished(Sender As BlueprintController)
		  Self.Progress = Self.ProgressNone
		  
		  If Sender.CacheErrored Then
		    Self.ShowAlert("There was an error loading the blueprints.", Sender.CacheErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mController_WorkStarted(Sender As BlueprintController)
		  #Pragma Unused Sender
		  
		  Self.Progress = Self.ProgressIndeterminate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  Return Self.mController.ModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseDataDumperLine(Line As String) As Dictionary
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
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var SelectedBlueprints() As String
		  For Row As Integer = 0 To Self.BlueprintList.LastRowIndex
		    If Self.BlueprintList.Selected(Row) Then
		      SelectedBlueprints.Add(Self.BlueprintList.RowTagAt(Row))
		    End If
		  Next
		  
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected() As Ark.Blueprint)
		  Var SelectedBlueprints() As String
		  For Each Blueprint As Ark.Blueprint In Selected
		    SelectedBlueprints.Add(Blueprint.ObjectID)
		  Next
		  
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected As Ark.Blueprint)
		  Var SelectedBlueprints() As String = Array(Selected.ObjectID)
		  Self.UpdateList(SelectedBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selected() As String)
		  Var Blueprints() As Ark.Blueprint = Self.mController.Blueprints
		  
		  Self.BlueprintList.SelectionChangeBlocked = True
		  Self.BlueprintList.RowCount = Blueprints.Count
		  
		  For Row As Integer = 0 To Self.BlueprintList.LastRowIndex
		    Var Blueprint As Ark.Blueprint = Blueprints(Row)
		    Var ObjectID As String = Blueprint.ObjectID
		    
		    Var Type As String = "Blueprint"
		    Select Case Blueprint
		    Case IsA Ark.Engram
		      Type = "Engram"
		    Case IsA Ark.Creature
		      Type = "Creature"
		    Case IsA Ark.SpawnPoint
		      Type = "Spawn"
		    Case IsA Ark.LootContainer
		      Type = "Loot Container"
		    End Select
		    
		    Self.BlueprintList.CellValueAt(Row, 0) = Blueprint.Label
		    Self.BlueprintList.CellValueAt(Row, 1) = Type
		    Self.BlueprintList.RowTagAt(Row) = ObjectID
		    Self.BlueprintList.Selected(Row) = Selected.IndexOf(ObjectID) > -1
		  Next
		  
		  Self.BlueprintList.SortingColumn = 0
		  Self.BlueprintList.Sort
		  If Self.BlueprintList.SelectedRowCount > 0 Then
		    Self.BlueprintList.EnsureSelectionIsVisible
		  End If
		  Self.BlueprintList.SelectionChangeBlocked = False
		  If (Self.ModToolbar.Item("ExportFile") Is Nil) = False Then
		    Self.ModToolbar.Item("ExportFile").Enabled = Self.BlueprintList.RowCount > 0
		  End If
		  
		  Self.UpdatePublishButton()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdatePublishButton()
		  Var PublishEnabled As Boolean = (Self.mController Is Nil) = False And Self.mController.HasUnpublishedChanges
		  If (Self.ModToolbar.Item("Publish") Is Nil) = False Then
		    Self.ModToolbar.Item("Publish").Enabled = PublishEnabled
		  End If
		  If (Self.ModToolbar.Item("Discard") Is Nil) = False Then
		    Self.ModToolbar.Item("Discard").Enabled = PublishEnabled
		  End If
		  Self.Changed = PublishEnabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewType(Plural As Boolean, Lowercase As Boolean) As String
		  If Plural Then
		    Return If(Lowercase, "mods", "Mods")
		  Else
		    Return If(Lowercase, "mod", "Mod")
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContentToImport As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As BlueprintController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFoundBlueprints() As Ark.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFoundModNames() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressWindow
	#tag EndProperty


#tag EndWindowCode

#tag Events BlueprintList
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(1) = Listbox.Alignments.Right
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Self.mController Is Nil Then
		    Return
		  End If
		  
		  Var Blueprints() As Ark.Blueprint
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Not Me.Selected(Row) Then
		      Continue
		    End If
		    
		    Var ObjectID As String = Me.RowTagAt(Row)
		    Var Blueprint As Ark.Blueprint = Self.mController.Blueprint(ObjectID)
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    
		    Blueprints.Add(Blueprint)
		  Next
		  
		  If Warn And Not Self.ShowDeleteConfirmation(Blueprints, "blueprint", "blueprints") Then
		    Return
		  End If
		  
		  Self.mController.DeleteBlueprints(Blueprints)
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  If Self.mController Is Nil Then
		    Return
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Var ObjectID As String = Me.RowTagAt(Me.SelectedRowIndex)
		    Var Blueprint As Ark.Blueprint = Self.mController.Blueprint(ObjectID)
		    If Blueprint Is Nil Then
		      Return
		    End If
		    
		    Blueprint = BlueprintEditorDialog.Present(Self, Blueprint)
		    If Blueprint Is Nil Then
		      Return
		    End If
		    
		    Self.mController.SaveBlueprint(Blueprint)
		    Self.UpdateList(Blueprint)
		  ElseIf Me.SelectedRowCount > 1 Then
		    Var Blueprints() As Ark.Blueprint
		    For Row As Integer = 0 To Me.LastRowIndex
		      If Me.Selected(Row) Then
		        Blueprints.Add(Self.mController.Blueprint(Me.RowTagAt(Row).StringValue))
		      End If
		    Next
		    
		    Var ModifiedBlueprints() As Ark.Blueprint = BlueprintMultiEditor.Present(Self, Blueprints)
		    If (ModifiedBlueprints Is Nil) = False Then
		      For Each Blueprint As Ark.Blueprint In ModifiedBlueprints
		        Self.mController.SaveBlueprint(Blueprint)
		      Next
		    End If
		    Self.UpdateList(ModifiedBlueprints)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Watcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  #Pragma Unused Content
		  
		  If (Self.ModToolbar.Item("ImportClipboard") Is Nil) = False Then
		    Self.ModToolbar.Item("ImportClipboard").Enabled = Self.ClipboardHasCodes
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateButton("AddBlueprint", "New Blueprint", IconToolbarAdd, "Create a new blueprint."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  If Self.mController.UseSaveTerminology Then
		    Me.Append(OmniBarItem.CreateButton("Publish", "Save", IconToolbarSaveToDisk, "Save your changes.", False))
		  Else
		    Me.Append(OmniBarItem.CreateButton("Publish", "Publish", IconToolbarPublish, "Publish your changes to Beacon's users.", False))
		  End If
		  Me.Append(OmniBarItem.CreateButton("Discard", "Revert", IconToolbarRevert, "Revert your changes.", False))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ImportFile", "Import File", IconToolbarFile, "Import blueprints from a file on your computer."))
		  Me.Append(OmniBarItem.CreateButton("ImportURL", "Import URL", IconToolbarLink, "Import blueprints from cheat codes on a website."))
		  Me.Append(OmniBarItem.CreateButton("ImportClipboard", "Import Copied", IconToolbarCopied, "Import blueprints from copied cheat codes.", Self.ClipboardHasCodes))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("ExportFile", "Export", IconToolbarExport, "Export selected blueprints to a file on your computer."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddBlueprint"
		    Var Blueprint As Ark.Blueprint = BlueprintEditorDialog.Present(Self, Self.mController.ModID, Self.mController.ModName)
		    If (Blueprint Is Nil) = False Then
		      Self.mController.SaveBlueprint(Blueprint)
		      Self.UpdateList()
		    End If
		  Case "ImportFile"
		    Self.ImportFromFile()
		  Case "ImportURL"
		    Self.ImportFromURL()
		  Case "ImportClipboard"
		    Self.ImportFromClipboard()
		  Case "ExportFile"
		    Self.Export()
		  Case "Publish"
		    Self.mController.Publish()
		  Case "Discard"
		    Self.mController.DiscardChanges()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ImporterThread
	#tag Event
		Sub Run()
		  If (Self.ImportAsDataDumper(Self.mContentToImport) Or Self.ImportAsJSON(Self.mContentToImport)) = False Then
		    Self.ImportAsPlain(Self.mContentToImport)
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("Action") = "Finished"
		  Me.AddUserInterfaceUpdate(Dict)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    Var Action As String = Dict.Lookup("Action", "").StringValue
		    Select Case Action
		    Case "Finished"
		      Var Cancelled As Boolean = Self.mProgress.CancelPressed
		      Self.mProgress.Close
		      Self.mProgress = Nil
		      
		      Self.Progress = BeaconSubview.ProgressNone
		      
		      If Cancelled = False Then
		        If Self.mFoundBlueprints.Count = 0 Then
		          Self.ShowAlert("Importing Has Finished", "Beacon did not find any blueprints to import.")
		        ElseIf Self.mFoundModNames.Count = 1 Then
		          // Just import what was found
		          Self.mController.SaveBlueprints(Self.mFoundBlueprints)
		          Self.UpdateList(Self.mFoundBlueprints)
		          Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(Self.mFoundBlueprints.Count, "blueprint", "blueprints") + " to import.")
		        Else
		          // Show a prompt
		          Var ChosenNames() As String = SelectModPrefixDialog.Present(Self, Self.mFoundModNames)
		          If ChosenNames.Count > 0 Then
		            Var ChosenBlueprints() As Ark.Blueprint
		            For Each Name As String In ChosenNames
		              Var Prefix As String = "/Game/Mods/" + Name + "/"
		              For Each Blueprint As Ark.Blueprint In Self.mFoundBlueprints
		                If Blueprint.Path.BeginsWith(Prefix) Then
		                  ChosenBlueprints.Add(Blueprint)
		                End If
		              Next Blueprint
		            Next Name
		            
		            Self.mController.SaveBlueprints(ChosenBlueprints)
		            Self.UpdateList(ChosenBlueprints)
		            Self.ShowAlert("Importing Has Finished", "Beacon found " + Language.NounWithQuantity(ChosenBlueprints.Count, "blueprint", "blueprints") + " to import.")
		          End If
		        End If
		      End If
		      
		      Self.mFoundBlueprints.ResizeTo(-1)
		      Self.mFoundModNames.ResizeTo(-1)
		    End Select
		  Next Dict
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
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
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
