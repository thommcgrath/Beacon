#tag Class
Protected Class ImportThread
Inherits Beacon.CommonThread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  Self.mFinished = False
		  Self.mCancelled = False
		  Self.mCreatedProject = Nil
		  Self.mError = Nil
		  
		  If Self.mProgress Is Nil Then
		    Self.mProgress = New Beacon.DummyProgressDisplayer
		  End If
		  
		  Try
		    Var Project As ArkSA.Project = Self.RunSynchronous(Self.mData, Self.mDestinationProject, Self.mProgress)
		    If Self.mCancelled Then
		      Return
		    End If
		    
		    Self.mCreatedProject = Project
		    Self.mFinished = True
		  Catch Err As RuntimeException
		    Self.mFinished = True
		    Self.mError = Err
		  End Try
		  
		  Var Dict As New Dictionary
		  Dict.Value("Event") = "Finished"
		  Self.AddUserInterfaceUpdate(Dict)
		End Sub
	#tag EndEvent

	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("Event", "").StringValue = "Finished" Then
		      Var Lock As Beacon.LockHolder = Self.Lock()
		      RaiseEvent Finished(Self.mCreatedProject)
		    End If
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function BuildProject(Data As ArkSA.DiscoveredData, DestinationProject As ArkSA.Project, Progress As Beacon.ProgressDisplayer, ParsedData As Dictionary, CommandLineOptions As Dictionary) As ArkSA.Project
		  Var Profile As ArkSA.ServerProfile
		  If (Data Is Nil) = False And (Data.Profile Is Nil) = False Then
		    Profile = Data.Profile
		  End If
		  
		  Var Project As New ArkSA.Project
		  If (Profile Is Nil) = False Then
		    Project.MapMask = Profile.Mask
		  End If
		  If Project.MapMask = CType(0, UInt64) Then
		    Project.MapMask = 1
		  End If
		  If ParsedData.HasKey("SessionName") Then
		    Var SessionNames() As Variant = ParsedData.AutoArrayValue("SessionName")
		    For Each SessionName As Variant In SessionNames
		      Try
		        Var SessionTitle As String = SessionName.StringValue
		        If SessionTitle.Encoding Is Nil Then
		          SessionTitle = SessionTitle.DefineEncoding(Encodings.UTF8)
		        ElseIf SessionTitle.Encoding <> Encodings.UTF8 Then
		          SessionTitle = SessionTitle.ConvertEncoding(Encodings.UTF8)
		        End If
		        Project.Title = SessionTitle
		        Exit
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  
		  If CommandLineOptions Is Nil Then
		    CommandLineOptions = New Dictionary
		  End If
		  
		  If (Data Is Nil) = False And Data.IsPrimitivePlus Then
		    Project.ContentPackEnabled("68d1be8b-a66e-41a2-b0b4-cb2a724fc80b") = True
		  End If
		  
		  If ParsedData.HasKey("ActiveMods") And IsNull(ParsedData.Value("ActiveMods")) = False Then
		    Var ActiveMods As String = ParsedData.StringValue("ActiveMods", "")
		    Var ModIDs() As String = ActiveMods.Split(",")
		    For Each ModId As String In ModIDs
		      Var ContentPacks() As Beacon.ContentPack = ArkSA.DataSource.Pool.Get(False).GetContentPacks(Beacon.MarketplaceCurseForge, ModId)
		      If ContentPacks.Count > 0 Then
		        Project.ContentPackEnabled(ContentPacks(0)) = True
		      End If
		    Next
		  End If
		  
		  If (DestinationProject Is Nil) = False Then
		    Var DestinationPacks As Beacon.StringList = DestinationProject.ContentPacks
		    For Each PackUUID As String In DestinationPacks
		      Project.ContentPackEnabled(PackUUID) = True
		    Next PackUUID
		  End If
		  
		  Try
		    Var Maps() As ArkSA.Map = Project.Maps
		    Var DifficultyTotal, DifficultyScale As Double
		    For Each Map As ArkSA.Map In Maps
		      DifficultyTotal = DifficultyTotal + Map.DifficultyScale
		    Next
		    DifficultyScale = DifficultyTotal / Maps.Count
		    
		    Var ImpliedDifficulty As Boolean
		    Var DifficultyValue As Double
		    If CommandLineOptions.HasKey("OverrideOfficialDifficulty") And CommandLineOptions.DoubleValue("OverrideOfficialDifficulty") > 0 Then
		      DifficultyValue = CommandLineOptions.DoubleValue("OverrideOfficialDifficulty")
		    ElseIf ParsedData.HasKey("OverrideOfficialDifficulty") And ParsedData.DoubleValue("OverrideOfficialDifficulty") > 0 Then
		      DifficultyValue = ParsedData.DoubleValue("OverrideOfficialDifficulty")
		    ElseIf ParsedData.HasKey("DifficultyOffset") Then
		      DifficultyValue = ParsedData.DoubleValue("DifficultyOffset") * (DifficultyScale - 0.5) + 0.5
		    ElseIf (DestinationProject Is Nil) = False Then
		      DifficultyValue = DestinationProject.Difficulty.DifficultyValue
		      ImpliedDifficulty = True
		    Else
		      DifficultyValue = DifficultyScale
		      ImpliedDifficulty = True
		    End If
		    
		    Var DifficultyConfig As New ArkSA.Configs.Difficulty(DifficultyValue)
		    DifficultyConfig.IsImplicit = ImpliedDifficulty
		    Project.AddConfigGroup(DifficultyConfig)
		  Catch Err As RuntimeException
		  End Try
		  
		  If (Profile Is Nil) = False Then
		    Profile.Name = Project.Title
		    
		    Var ServerPassword, AdminPassword, SpectatorPassword As String
		    If ParsedData.HasKey("ServerPassword") Then
		      ServerPassword = ParsedData.StringValue("ServerPassword", "")
		    ElseIf CommandLineOptions.HasKey("ServerPassword") Then
		      ServerPassword = CommandLineOptions.StringValue("ServerPassword", "")
		    End If
		    If CommandLineOptions.HasKey("SpectatorPassword") Then
		      SpectatorPassword = CommandLineOptions.StringValue("SpectatorPassword", "")
		    ElseIf ParsedData.HasKey("SpectatorPassword") Then
		      SpectatorPassword = ParsedData.StringValue("SpectatorPassword", "")
		    End If
		    If CommandLineOptions.HasKey("ServerAdminPassword") Then
		      AdminPassword = CommandLineOptions.StringValue("ServerAdminPassword", "")
		    ElseIf ParsedData.HasKey("ServerAdminPassword") Then
		      AdminPassword = ParsedData.StringValue("ServerAdminPassword", "")
		    End If
		    Profile.ServerPassword = ServerPassword
		    Profile.SpectatorPassword = SpectatorPassword
		    Profile.AdminPassword = AdminPassword
		    
		    If ParsedData.HasKey("Message") Then
		      Var Duration As Integer = 30
		      If ParsedData.HasKey("Duration") Then
		        Duration = Round(ParsedData.DoubleValue("Duration", 30, True))
		      End If
		      
		      Profile.MessageOfTheDay = ArkSA.ArkML.FromArkML(ParsedData.StringValue("Message", "", True).Trim())
		      Profile.MessageDuration = Duration
		    End If
		    
		    Project.AddServerProfile(Profile)
		  End If
		  
		  If ParsedData.HasKey("bUseSingleplayerSettings") Then
		    Project.IsFlagged(ArkSA.Project.FlagSinglePlayer) = ParsedData.BooleanValue("bUseSingleplayerSettings", False, True)
		  End If
		  
		  Var ConfigNames() As String = ArkSA.Configs.AllNames()
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  Var Configs() As ArkSA.ConfigGroup
		  For Each ConfigName As String In ConfigNames
		    If ConfigName = ArkSA.Configs.NameDifficulty Or ConfigName = ArkSA.Configs.NameCustomConfig Then
		      // Difficulty and custom content are special
		      Continue For ConfigName
		    End If
		    
		    If ArkSA.Configs.ConfigUnlocked(ConfigName, Identity) = False Then
		      // Do not import code for groups that the user has not purchased
		      Continue For ConfigName
		    End If
		    
		    Progress.Message = "Building Beacon project… (" + Language.LabelForConfig(ConfigName) + ")"
		    Var Group As ArkSA.ConfigGroup
		    Try
		      Group = ArkSA.Configs.CreateInstance(ConfigName, ParsedData, CommandLineOptions, Project)
		    Catch Err As RuntimeException
		    End Try
		    If Group <> Nil Then
		      Project.AddConfigGroup(Group)
		      Configs.Add(Group)
		    End If
		  Next
		  
		  // Now split the content into values and remove the ones controlled by the imported groups
		  Progress.Message = "Building Beacon project… (" + Language.LabelForConfig(ArkSA.Configs.NameCustomConfig) + ")"
		  Var CustomConfigOrganizer As New ArkSA.ConfigOrganizer(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, Data.GameIniContent)
		  CustomConfigOrganizer.Add(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, Data.GameUserSettingsIniContent)
		  For Each Config As ArkSA.ConfigGroup In Configs
		    Var ManagedKeys() As ArkSA.ConfigOption = Config.ManagedKeys()
		    CustomConfigOrganizer.Remove(ManagedKeys)
		  Next
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "/Game/Mods/Humanoids/TestGameMode_Humanoids.TestGameMode_Humanoids_C")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "/Game/PrimalEarth/CoreBlueprints/TestGameMode.TestGameMode_C")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "/Script/Engine.GameSession")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "/Script/ShooterGame.ShooterGameUserSettings")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "ScalabilityGroups")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "ScalabilityGroups.sg")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "Beacon")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGame, "ShooterGameMode_TEMPOverrides")
		  CustomConfigOrganizer.Remove(ArkSA.ConfigFileGame, "Beacon")
		  
		  If (Profile Is Nil) = False Then
		    Var Lines() As String = Profile.CustomGUS.ReplaceLineEndings(EndOfLine).Split(EndOfLine)
		    Var ServerSpecificKeys() As String = Array("BeaconSentinel:AccessKey", "AsaBotCompanion:ServerId")
		    For Each KeyPath As String In ServerSpecificKeys
		      Var Pos As Integer = KeyPath.IndexOf(":")
		      Var Header As String = KeyPath.Left(Pos)
		      Var Key As String = KeyPath.Middle(Pos + 1)
		      Var Values() As ArkSA.ConfigValue = CustomConfigOrganizer.FilteredValues(ArkSA.ConfigFileGameUserSettings, Header, Key)
		      If Values.Count = 0 Then
		        Continue
		      End If
		      
		      If Lines.Count > 0 Then
		        Lines.Add("")
		      End If
		      
		      Lines.Add("[" + Header + "]")
		      For Each Value As ArkSA.ConfigValue In Values
		        Lines.Add(Value.Command)
		      Next
		      CustomConfigOrganizer.Remove(Values)
		    Next
		    Profile.CustomGUS = String.FromArray(Lines, EndOfLine)
		  End If
		  
		  Var CustomContent As New ArkSA.Configs.CustomContent
		  Try
		    CustomContent.GameIniContent() = CustomConfigOrganizer
		  Catch Err As RuntimeException
		  End Try
		  Try
		    CustomContent.GameUserSettingsIniContent() = CustomConfigOrganizer
		  Catch Err As RuntimeException
		  End Try
		  If CustomContent.Modified Then
		    Project.AddConfigGroup(CustomContent)
		  End If
		  
		  Return Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Data As ArkSA.DiscoveredData, DestinationProject As ArkSA.Project)
		  Self.mData = Data
		  Self.mDestinationProject = DestinationProject
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Error() As RuntimeException
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Return Self.mError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Return (Self.mError Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsHeaderIgnored(Header As String) As Boolean
		  Select Case Header
		  Case "/Game/Mods/Humanoids/TestGameMode_Humanoids.TestGameMode_Humanoids_C", "/Game/PrimalEarth/CoreBlueprints/TestGameMode.TestGameMode_C", "/Script/Engine.GameSession", "/Script/ShooterGame.ShooterGameUserSettings", "ScalabilityGroups", "ScalabilityGroups.sg", "Beacon", "ShooterGameMode_TEMPOverrides"
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Var Name As String
		  If (Self.mData Is Nil) = False And (Self.mData.Profile Is Nil) = False Then
		    Name = Self.mData.Profile.Name
		  End If
		  If Name.IsEmpty Then
		    Name = "Untitled Importer"
		  End If
		  Return Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ParseLine(Line As String, ByRef CurrentHeader As String, ByRef MessageOfTheDayMode As Boolean, ByRef IgnoreSection As Boolean, ParsedData As Dictionary)
		  If Line.BeginsWith("[") And Line.EndsWith("]") Then
		    CurrentHeader = Line.Middle(1, Line.Length - 2)
		    MessageOfTheDayMode = (CurrentHeader = "MessageOfTheDay")
		    IgnoreSection = IsHeaderIgnored(CurrentHeader)
		    Return
		  End If
		  
		  If IgnoreSection Then
		    Return
		  End If
		  
		  If MessageOfTheDayMode Then
		    Try
		      If Line.BeginsWith("Duration=") Then
		        Var Duration As Integer = Integer.FromString(Line.Middle(9))
		        ParsedData.Value("Duration") = Duration
		        ParsedData.Value("MessageOfTheDay.Duration") = Duration
		      Else
		        Var Message As String
		        If Line.BeginsWith("Message=") Then
		          Line = Line.Middle(8)
		        Else
		          Message = ParsedData.Lookup("MessageOfTheDay.Message", "")
		        End If
		        If Message.IsEmpty Then
		          Message = Line
		        Else
		          Message = Message + EndOfLine.UNIX + Line
		        End If
		        ParsedData.Value("Message") = Message
		        ParsedData.Value("MessageOfTheDay.Message") = Message
		      End If
		    Catch Err As RuntimeException
		    End Try
		    Return
		  End If
		  
		  If Line.BeginsWith(";") Or Line.BeginsWith("//") Or Line.BeginsWith("#") Then
		    Return
		  End If
		  
		  If Line.IsEmpty Then
		    Return
		  End If
		  
		  Try
		    Var Value As Variant = ReadValue(Line)
		    If Value.IsNull Then
		      Return
		    End If
		    If Value.Type <> Variant.TypeObject Or Value IsA Beacon.KeyValuePair = False Then
		      Return
		    End If
		    
		    Var Key As String = Beacon.KeyValuePair(Value).Key
		    Var ExtendedKey As String = CurrentHeader + "." + Key
		    Value = Beacon.KeyValuePair(Value).Value
		    
		    If ParsedData.HasKey(Key) Then
		      Var ExistingValue As Variant = ParsedData.Value(Key)
		      
		      Var ValueArray() As Variant
		      If ExistingValue.IsArray Then
		        ValueArray = ExistingValue
		      Else
		        ValueArray.Add(ExistingValue)
		      End If
		      ValueArray.Add(Value)
		      ParsedData.Value(Key) = ValueArray
		    Else
		      ParsedData.Value(Key) = Value
		    End If
		    
		    If ParsedData.HasKey(ExtendedKey) Then
		      Var ExistingValue As Variant = ParsedData.Value(ExtendedKey)
		      
		      Var ValueArray() As Variant
		      If ExistingValue.IsArray Then
		        ValueArray = ExistingValue
		      Else
		        ValueArray.Add(ExistingValue)
		      End If
		      ValueArray.Add(Value)
		      ParsedData.Value(ExtendedKey) = ValueArray
		    Else
		      ParsedData.Value(ExtendedKey) = Value
		    End If
		  Catch Err As RuntimeException
		    // Don't let an error halt processing, skip and move on
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As Beacon.ProgressDisplayer
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Return Self.mProgress
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Progress(Assigns Displayer As Beacon.ProgressDisplayer)
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Var OldDisplayer As Beacon.ProgressDisplayer = Self.mProgress
		  Self.mProgress = Displayer
		  If (OldDisplayer Is Nil) = False And (Self.mProgress Is Nil) = False Then
		    Self.mProgress.Detail = OldDisplayer.Detail
		    Self.mProgress.Message = OldDisplayer.Message
		    Self.mProgress.Progress = OldDisplayer.Progress
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As ArkSA.Project
		  Var Lock As Beacon.LockHolder = Self.Lock()
		  Return Self.mCreatedProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadValue(ByRef Content As String) As Variant
		  // Key=Value
		  // Key="Value"
		  // Key=(Child1=Value1,Child2=Value2) - Struct
		  // Key=(Value1,Value2) - Array of values
		  // Key=((Child1=Value1,Child2=Value2),(Child1=Value1,Child2=Value2)) - Array of structs
		  
		  Var Value As Variant
		  Var Char As String = Content.Left(1)
		  While Char = ","
		    Content = Content.Middle(1)
		    Char = Content.Left(1)
		  Wend
		  
		  Select Case Char
		  Case """"
		    Content = Content.Middle(1)
		    Var ValueEndPosition As Integer = Content.IndexOf("""", ComparisonOptions.CaseSensitive)
		    If ValueEndPosition > -1 Then
		      Value = ToXojoType(RestoreEscapes(Content.Left(ValueEndPosition)))
		      Content = Content.Middle(ValueEndPosition + 1)
		    Else
		      Value = ToXojoType(RestoreEscapes(Content))
		      Content = ""
		    End If
		  Case "("
		    Content = Content.Middle(1)
		    Var Members() As Variant
		    Var IsDict As Boolean
		    Do
		      Var Child As Variant = ReadValue(Content)
		      If Child Is Nil Then
		        Exit
		      End If
		      IsDict = IsDict Or (Child.Type = Variant.TypeObject And Child.ObjectValue IsA Beacon.KeyValuePair)
		      Members.Add(Child)
		    Loop
		    If IsDict Then
		      Value = ToXojoType(Members)
		    Else
		      Value = Members
		    End If
		  Case ")"
		    Content = Content.Middle(1)
		    Return Nil
		  Else
		    Var EqualsPos As Integer = Content.IndexOf("=", ComparisonOptions.CaseSensitive)
		    Var CommaPos As Integer = Content.IndexOf(",", ComparisonOptions.CaseSensitive)
		    Var ParenthesisPos As Integer = Content.IndexOf(")", ComparisonOptions.CaseSensitive)
		    
		    Var ValueEndPosition As Integer = Content.Length
		    If CommaPos > -1 Then
		      ValueEndPosition = Min(CommaPos, ValueEndPosition)
		    End If
		    If ParenthesisPos > -1 Then
		      ValueEndPosition = Min(ParenthesisPos, ValueEndPosition)
		    End If
		    
		    If EqualsPos > -1 And EqualsPos < ValueEndPosition Then
		      // This is key value pair
		      Var Key As String = Content.Left(EqualsPos)
		      Content = Content.Middle(EqualsPos + 1)
		      
		      Value = ReadValue(Content)
		      Return New Beacon.KeyValuePair(Key, Value)
		    End If
		    
		    Value = ToXojoType(RestoreEscapes(Content.Left(ValueEndPosition)))
		    Content = Content.Middle(ValueEndPosition)
		  End Select
		  
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RestoreEscapes(Content As String) As String
		  Content = Content.ReplaceAll("d9ca162bc807", "\")
		  Content = Content.ReplaceAll("dca0378f211e", """")
		  Content = Content.ReplaceAll("61d63f3bb1c9", ",")
		  Content = Content.ReplaceAll("5ea9358933d5", "(")
		  Content = Content.ReplaceAll("4cef9336f9c6", ")")
		  Content = Content.ReplaceAll("\n", EndOfLine.UNIX)
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function RunSynchronous(Data As ArkSA.DiscoveredData, DestinationProject As ArkSA.Project, Progress As Beacon.ProgressDisplayer) As ArkSA.Project
		  Progress.Message = "Importing…"
		  Progress.Detail = "Cleaning up files…"
		  Progress.Progress = Nil
		  Progress.ShowSubProgress = False
		  
		  Var LineEnding As String = EndOfLine.UNIX
		  Var Locale As Locale = Locale.Current
		  
		  // Normalize line endings
		  Var Content As String
		  If (Data Is Nil) = False Then
		    Var Blocks() As String
		    
		    Var GameUserSettingsIniContent As String = Data.GameUserSettingsIniContent.ReplaceLineEndings(LineEnding)
		    If GameUserSettingsIniContent.IsEmpty = False Then
		      If GameUserSettingsIniContent.BeginsWith("[") = False Then
		        GameUserSettingsIniContent = "[" + ArkSA.HeaderServerSettings + "]" + LineEnding + GameUserSettingsIniContent
		      End If
		      Blocks.Add(GameUserSettingsIniContent)
		    End If
		    
		    Var GameIniContent As String = Data.GameIniContent.ReplaceLineEndings(LineEnding)
		    If GameIniContent.IsEmpty = False Then
		      If GameIniContent.BeginsWith("[") = False Then
		        GameIniContent = "[" + ArkSA.HeaderShooterGame + "]" + LineEnding + GameIniContent
		      End If
		      Blocks.Add(GameIniContent)
		    End If
		    
		    Content = Blocks.Join(LineEnding)
		  End If
		  
		  // Fix smart quotes
		  Content = Content.SanitizeIni
		  
		  // The UWP/Windows Store version uses ArkSA.HeaderShooterGameUWP instead of ArkSA.HeaderShooterGame because it's inbred
		  If Content.IndexOf("[" + ArkSA.HeaderShooterGameUWP + "]") > -1 Then
		    Content = Content.ReplaceAll(ArkSA.HeaderShooterGameUWP, ArkSA.HeaderShooterGame)
		    Data.GameIniContent = Data.GameIniContent.ReplaceAll(ArkSA.HeaderShooterGameUWP, ArkSA.HeaderShooterGame)
		  End If
		  
		  // Replace escapes so that they don't mess up our parsing
		  Content = Unescape(Content)
		  
		  Var CurrentHeader As String
		  Var MessageOfTheDayMode, IgnoreMode As Boolean = False
		  Var ParsedData As New Dictionary
		  Var Lines() As String = Content.Split(LineEnding)
		  Var LinesProcessed As Integer
		  Var LineCount As Integer = Lines.Count
		  
		  Progress.Detail = "Parsing files…"
		  
		  For Each Line As String In Lines
		    If Progress.CancelPressed Then
		      Return Nil
		    End If
		    
		    Line = Line.Trim
		    ParseLine(Line, CurrentHeader, MessageOfTheDayMode, IgnoreMode, ParsedData)
		    
		    LinesProcessed = LinesProcessed + 1
		    Var Percent As Double = LinesProcessed / LineCount
		    Progress.Progress = Percent
		    Progress.Detail = "Parsed " + LinesProcessed.ToString(Locale, "0") + " of " + LineCount.ToString(Locale, "0") + " lines (" + Percent.ToString(Locale, "0%") + ")…"
		  Next
		  
		  Progress.Detail = "Building Beacon project…"
		  Try
		    Var CommandLineOptions As Dictionary
		    If (Data Is Nil) = False Then
		      CommandLineOptions = Data.CommandLineOptions
		    End If
		    Return BuildProject(Data, DestinationProject, Progress, ParsedData, CommandLineOptions)
		  Catch Err As RuntimeException
		  End Try
		  Progress.Detail = "Finished"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToXojoType(Input As Variant) As Variant
		  If Input = Nil Then
		    Return Nil
		  End If
		  
		  If Input.IsArray And Input.ArrayElementType = Variant.TypeObject Then
		    Var ArrayValue() As Variant = Input
		    Var IsDict As Boolean = True
		    For Each Item As Variant In ArrayValue
		      IsDict = IsDict And Item.Type = Variant.TypeObject And Item.ObjectValue IsA Beacon.KeyValuePair
		    Next
		    If IsDict Then
		      Var Dict As New Dictionary
		      For Each Item As Beacon.KeyValuePair In ArrayValue
		        Dict.Value(Item.Key) = Item.Value
		      Next
		      Return Dict
		    Else
		      Return ArrayValue
		    End If
		  End If
		  
		  Select Case Input.Type
		  Case Variant.TypeObject
		    Var ObjectValue As Object = Input.ObjectValue
		    Select Case ObjectValue
		    Case IsA Beacon.KeyValuePair
		      Var Original As Beacon.KeyValuePair = Input
		      Return New Beacon.KeyValuePair(Original.Key, ToXojoType(Original.Value))
		    End Select
		  Case Variant.TypeString
		    Var StringValue As String = Input.StringValue
		    If StringValue = "true" Then
		      Return True
		    ElseIf StringValue = "false" Then
		      Return False
		    Else
		      Var IsNumeric As Boolean
		      If StringValue.Length > 0 Then
		        IsNumeric = True
		        Var DecimalPoints As Integer
		        Var Characters() As String = StringValue.Split("")
		        For Each Char As String In Characters
		          Select Case Char
		          Case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
		            // Still a Number
		          Case "."
		            If DecimalPoints = 1 Then
		              IsNumeric = False
		              Exit
		            Else
		              DecimalPoints = 1
		            End If
		          Else
		            IsNumeric = False
		            Exit
		          End Select
		        Next
		      End If
		      If IsNumeric Then
		        // Number
		        Return Double.FromString(StringValue, Locale.Raw)
		      Else
		        // Probably String
		        Return StringValue
		      End If
		    End If
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Unescape(Content As String) As String
		  Content = Content.ReplaceAll("\\", "d9ca162bc807")
		  Content = Content.ReplaceAll("\""", "dca0378f211e")
		  Content = Content.ReplaceAll("\,", "61d63f3bb1c9")
		  Content = Content.ReplaceAll("\(", "5ea9358933d5")
		  Content = Content.ReplaceAll("\)", "4cef9336f9c6")
		  Return Content
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(Project As ArkSA.Project)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatedProject As ArkSA.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mData As ArkSA.DiscoveredData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinationProject As ArkSA.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Beacon.ProgressDisplayer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
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
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
