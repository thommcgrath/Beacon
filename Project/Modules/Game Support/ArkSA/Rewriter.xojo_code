#tag Class
Protected Class Rewriter
Inherits Global.Thread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  Self.mFinished = False
		  Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerStarted))
		  
		  Self.mFinishedGameIniContent = ""
		  Self.mFinishedGameUserSettingsIniContent = ""
		  Self.mFinishedCommandLineContent = ""
		  
		  // Load everything we need into local variables in case something changes while the process is running.
		  Var LegacyTrustKey As String = Self.mProject.LegacyTrustKey
		  
		  Var Format As EncodingFormat = EncodingFormat.ASCII
		  If Self.mProject.IsFlagged(ArkSA.Project.FlagAllowUCS2) Then
		    Format = EncodingFormat.UCS2AndASCII
		  End If
		  
		  Var Project As ArkSA.Project = Self.mProject
		  Var Identity As Beacon.Identity = Self.mIdentity
		  Var Profile As ArkSA.ServerProfile = Self.mProfile
		  Var InitialGameIni As String = Self.mInitialGameIniContent
		  Var InitialGameUserSettingsIni As String = Self.mInitialGameUserSettingsIniContent
		  
		  If Self.mOrganizer Is Nil Or Self.mRebuildOrganizer Then
		    If (Self.mOutputFlags And Self.FlagForceTrollMode) = Self.FlagForceTrollMode Then
		      Self.mOrganizer = Project.CreateTrollConfigOrganizer(Profile)
		    Else
		      Self.mOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    End If
		    Self.mRebuildOrganizer = False
		  End If
		  
		  Var Error As RuntimeException
		  
		  If (Self.mOutputFlags And Self.FlagCreateGameIni) = Self.FlagCreateGameIni Then
		    Var GameIni As String = Self.Rewrite(Self.mSource, InitialGameIni, ArkSA.HeaderShooterGame, ArkSA.ConfigFileGame, Self.mOrganizer, Project.ProjectId, LegacyTrustKey, Format, Project.UWPMode, False, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		      Return
		    End If
		    Self.mFinishedGameIniContent = GameIni
		  End If
		  
		  If (Self.mOutputFlags And Self.FlagCreateGameUserSettingsIni) = Self.FlagCreateGameUserSettingsIni Then
		    Var GameUserSettingsIni As String = Self.Rewrite(Self.mSource, InitialGameUserSettingsIni, ArkSA.HeaderServerSettings, ArkSA.ConfigFileGameUserSettings, Self.mOrganizer, Project.ProjectId, LegacyTrustKey, Format, Project.UWPMode, False, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		      Return
		    End If
		    Self.mFinishedGameUserSettingsIniContent = GameUserSettingsIni
		  End If
		  
		  If (Self.mOutputFlags And Self.FlagCreateCommandLine) = Self.FlagCreateCommandLine Then
		    Var QuestionOptions() As ArkSA.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineOption", "?")
		    Var QuestionFlags() As ArkSA.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineFlag", "?")
		    Var HyphenOptions() As ArkSA.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineOption", "-")
		    Var HyphenFlags() As ArkSA.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineFlag", "-")
		    
		    Var Maps() As ArkSA.Map = ArkSA.Maps.ForMask(Self.mProfile.Mask)
		    Var QuestionParameters() As String
		    If Maps.LastIndex = 0 Then
		      QuestionParameters.Add(Maps(0).Identifier) 
		    Else
		      QuestionParameters.Add("Map")
		    End If
		    QuestionParameters.Add("listen")
		    For Each Option As ArkSA.ConfigValue In QuestionOptions
		      If Option.Value.IsEmpty = False Then
		        QuestionParameters.Add(Option.SimplifiedKey + "=" + Option.Value)
		      End If
		    Next
		    For Each Flag As ArkSA.ConfigValue In QuestionFlags
		      If Flag.Value = "True" Then
		        QuestionParameters.Add(Flag.SimplifiedKey)
		      End If
		    Next
		    
		    Var HyphenParameters() As String
		    For Each Option As ArkSA.ConfigValue In HyphenOptions
		      If Option.Value.IsEmpty = False Then
		        HyphenParameters.Add("-" + Option.SimplifiedKey + "=" + Option.Value)
		      End If
		    Next
		    For Each Flag As ArkSA.ConfigValue In HyphenFlags
		      If Flag.Value = "True" Then
		        HyphenParameters.Add("-" + Flag.SimplifiedKey)
		      End If
		    Next
		    
		    Self.mFinishedCommandLineContent = """" + QuestionParameters.Join("?") + """ " + HyphenParameters.Join(" ")
		    Self.mFinishedCommandLineContent = Self.mFinishedCommandLineContent.Trim
		  End If
		  
		  Self.mFinished = True
		  Self.mError = Error
		  Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  If Self.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Self.Stop
		  End If
		  
		  For I As Integer = Self.mTriggers.LastIndex DownTo 0
		    CallLater.Cancel(Self.mTriggers(I))
		    Self.mTriggers.RemoveAt(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ConvertEncoding(Content As String, Format As ArkSA.Rewriter.EncodingFormat) As String
		  If Format = ArkSA.Rewriter.EncodingFormat.Unicode Then
		    If Content.Encoding <> Encodings.UTF8 Then
		      Content = Content.ConvertEncoding(Encodings.UTF8)
		    End If
		    Return Content
		  End If
		  
		  If Format = ArkSA.Rewriter.EncodingFormat.UCS2AndASCII And Encodings.ASCII.IsValidData(Content) = False Then
		    Var Reg As New RegEx
		    Reg.SearchPattern = "[\x{10000}-\x{10FFFF}]"
		    Reg.ReplacementPattern = "?"
		    Reg.Options.ReplaceAllMatches = True
		    Try
		      Content = Reg.Replace(Content)
		    Catch Err As RuntimeException
		      Return Content.ConvertEncoding(Encodings.ASCII)
		    End Try
		    
		    Return Encodings.ASCII.Chr(&hFF) + Encodings.ASCII.Chr(&hFE) + Content.ConvertEncoding(Encodings.UTF16LE)
		  End If
		  
		  If Content.Encoding <> Encodings.ASCII Then
		    Content = Content.ConvertEncoding(Encodings.ASCII)
		  End If
		  
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  For I As Integer = Self.mTriggers.LastIndex DownTo 0
		    CallLater.Cancel(Self.mTriggers(I))
		    Self.mTriggers.RemoveAt(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Error() As RuntimeException
		  Return Self.mError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return (Self.mError Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OutputFlags() As Integer
		  Return Self.mOutputFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As ArkSA.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Organizer As ArkSA.ConfigOrganizer, Format As ArkSA.Rewriter.EncodingFormat, UWPMode As ArkSA.Project.UWPCompatibilityModes, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  // This version will not contain the [Beacon] sections in the output
		  Try
		    Return Rewrite(Source, InitialContent, DefaultHeader, File, Organizer, "", "", Format, UWPMode, Nuke, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As ArkSA.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Organizer As ArkSA.ConfigOrganizer, ProjectUUID As String, LegacyTrustKey As String, Format As ArkSA.Rewriter.EncodingFormat, UWPMode As ArkSA.Project.UWPCompatibilityModes, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  // This is the new master method
		  
		  Try
		    // Even if we're about to nuke the file, determine the mode so the file can be rebuilt in the same format
		    InitialContent = InitialContent.GuessEncoding("/script/").SanitizeIni
		    Var DesiredLineEnding As String = InitialContent.DetectLineEnding
		    Var ConvertToUWP As Boolean
		    Select Case UWPMode
		    Case ArkSA.Project.UWPCompatibilityModes.Automatic
		      ConvertToUWP = InitialContent.IndexOf("[" + ArkSA.HeaderShooterGameUWP + "]") > -1
		    Case ArkSA.Project.UWPCompatibilityModes.Always
		      ConvertToUWP = True
		    End Select
		    If Nuke Then
		      InitialContent = ""
		    End If
		    
		    // Convert into UWP mode
		    If ConvertToUWP And File = ArkSA.ConfigFileGame Then
		      Organizer = Organizer.Clone
		      
		      Var GameIniValues() As ArkSA.ConfigValue = Organizer.FilteredValues(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame)
		      Var ClonedKeys() As ArkSA.ConfigOption
		      Var ClonedValues() As ArkSA.ConfigValue
		      For Each Value As ArkSA.ConfigValue In GameIniValues
		        Var SiblingKey As New ArkSA.ConfigOption(Value.Details.File, ArkSA.HeaderShooterGameUWP, Value.Details.Key)
		        ClonedKeys.Add(SiblingKey)
		        ClonedValues.Add(New ArkSA.ConfigValue(SiblingKey, Value.Command, Value.SortKey))
		      Next Value
		      Organizer.Add(ClonedValues)
		      Organizer.AddManagedKeys(ClonedKeys)
		    End If
		    
		    // Get the initial values into an organizer
		    Var ParsedValues As New ArkSA.ConfigOrganizer(File, DefaultHeader, InitialContent)
		    ParsedValues.Remove(Organizer.ManagedKeys) // Remove anything our groups already generate
		    
		    // Use the old Beacon section to determine which values to remove
		    Var Trusted As Boolean
		    Var TrustValues() As ArkSA.ConfigValue
		    If ProjectUUID.IsEmpty = False Then
		      TrustValues = ParsedValues.FilteredValues(File, "Beacon", "ProjectUUID")
		      For Each TrustValue As ArkSA.ConfigValue In TrustValues
		        If TrustValue.Value = ProjectUUID Then
		          Trusted = True
		          Continue
		        End If
		      Next TrustValue
		    End If
		    If Trusted = False And LegacyTrustKey.IsEmpty = False Then
		      TrustValues = ParsedValues.FilteredValues(File, "Beacon", "Trust")
		      For Each TrustValue As ArkSA.ConfigValue In TrustValues
		        If TrustValue.Value = LegacyTrustKey Then
		          Trusted = True
		          Continue
		        End If
		      Next
		    End If
		    
		    If Trusted Then
		      // Thanks to a deploy bug in how Beacon blends configs from InitialContent, do not trust if the deploy version is between > 1.4.8.4 and < 1.5.0.5
		      Var TrustVersions() As ArkSA.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "Build")
		      For Each TrustVersion As ArkSA.ConfigValue In TrustVersions
		        Try
		          Var TrustBuild As Integer = TrustVersion.Value.ToInteger
		          If TrustBuild > 10408304 And TrustBuild < 10500305 Then
		            Trusted = False
		          End If
		        Catch Err As RuntimeException
		          // Let's err on the side of caution
		          Trusted = False
		        End Try
		      Next
		    End If
		    
		    If Trusted Then
		      Var ManagedKeys() As ArkSA.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "ManagedKeys")
		      For Each ManagedKey As ArkSA.ConfigValue In ManagedKeys
		        Var ManagedSectionStartPos As Integer = ManagedKey.Value.IndexOf("Section=""")
		        If ManagedSectionStartPos = -1 Then
		          Continue
		        End If
		        ManagedSectionStartPos = ManagedSectionStartPos + 9
		        Var ManagedSectionEndPos As Integer = ManagedKey.Value.IndexOf(ManagedSectionStartPos, """")
		        If ManagedSectionEndPos = -1 Then
		          Continue
		        End If
		        Var ManagedSection As String = ManagedKey.Value.Middle(ManagedSectionStartPos, ManagedSectionEndPos - ManagedSectionStartPos)
		        
		        Var KeysStartPos As Integer = ManagedKey.Value.IndexOf("Keys=(")
		        If KeysStartPos = -1 Then
		          Continue
		        End If
		        KeysStartPos = KeysStartPos + 6
		        Var KeysEndPos As Integer = ManagedKey.Value.IndexOf(KeysStartPos, ")")
		        If KeysEndPos = -1 Then
		          Continue
		        End If
		        Var KeysString As String = ManagedKey.Value.Middle(KeysStartPos, KeysEndPos - KeysStartPos)
		        
		        Var Keys() As String = KeysString.Split(",")
		        For Each Key As String In Keys
		          ParsedValues.Remove(File, ManagedSection, Key)
		        Next
		      Next
		    End If
		    
		    // Remove the old Beacon section
		    ParsedValues.Remove(File, "Beacon")
		    
		    // Create a new organizer with the values from the original and unique values from the parsed
		    Var FinalOrganizer As New ArkSA.ConfigOrganizer
		    FinalOrganizer.Add(Organizer.FilteredValues(File)) // Automatically grabs command line options
		    
		    // Remove everything from Parsed that is in Final, but don't do it by hash
		    Var NewValues() As ArkSA.ConfigValue = FinalOrganizer.FilteredValues(File)
		    For Each Value As ArkSA.ConfigValue In NewValues
		      ParsedValues.Remove(Value.File, Value.Header, Value.SimplifiedKey)
		    Next
		    
		    If FinalOrganizer.Count = 0 And ParsedValues.Count = 0 Then
		      // Both the new stuff and the initial stuff are empty
		      Return ""
		    End If
		    
		    If ProjectUUID.IsEmpty = False Then
		      // Build the Beacon section
		      Var SourceString As String = CType(Source, Integer).ToString(Locale.Raw, "0")
		      Select Case Source
		      Case Sources.Deploy
		        SourceString = "Deploy"
		      Case Sources.Original
		        SourceString = "Original"
		      Case Sources.SmartCopy
		        SourceString = "Smart Copy"
		      Case Sources.SmartSave
		        SourceString = "Smart Save"
		      End Select
		      
		      FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "Build=" + App.BuildNumber.ToString(Locale.Raw, "0")))
		      FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "LastUpdated=" + DateTime.Now.SQLDateTimeWithOffset))
		      FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "ProjectUUID=" + ProjectUUID))
		      If LegacyTrustKey.IsEmpty = False Then
		        FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "Trust=" + LegacyTrustKey))
		      End If
		      FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "Source=" + SourceString))
		      FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "InitialSize=" + InitialContent.Bytes.ToString(Locale.Raw, "0")))
		      FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "InitialHash=" + EncodeHex(Crypto.SHA2_256(InitialContent)).Lowercase))
		      FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "WasTrusted=" + If(Trusted, "True", "False")))
		      Var ManagedHeaders() As String = Organizer.Headers(File)
		      For HeaderIdx As Integer = 0 To ManagedHeaders.LastIndex
		        Var Header As String = ManagedHeaders(HeaderIdx)
		        If Header = "Beacon" Then
		          Continue
		        End If
		        
		        Var Keys() As String = FinalOrganizer.Keys(File, Header)
		        FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", "ManagedKeys=(Section=""" + Header + """,Keys=(" + Keys.Join(",") + "))", "ManagedKeys:" + Header))
		      Next
		      
		      Var BeaconKeys() As String = Organizer.BeaconKeys
		      For Each BeaconKey As String In BeaconKeys
		        Var BeaconKeyValue As String = Organizer.BeaconKey(BeaconKey)
		        FinalOrganizer.Add(New ArkSA.ConfigValue(File, "Beacon", BeaconKey + "=" + BeaconKeyValue))
		      Next BeaconKey
		    End If
		    
		    // Now add everything remaining in Parsed to Final
		    FinalOrganizer.Add(ParsedValues.FilteredValues(File))
		    
		    If File = ArkSA.ConfigFileGameUserSettings Then
		      Const QualityHeader = "/Script/ShooterGame.ShooterGameUserSettings"
		      If FinalOrganizer.HasHeader(ArkSA.ConfigFileGameUserSettings, QualityHeader) = False Then
		        // More junk
		        Var QualityValues() As ArkSA.ConfigValue
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "ActiveLingeringWorldTiles=10"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "AmbientSoundVolume=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bAllowAnimationStaggering=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bCameraViewBob=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bChatBubbles=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bChatShowSteamName=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bChatShowTribeName=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bCraftablesShowAllItems=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bDisableBloom=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bDisableLightShafts=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bDisableMeleeCameraSwingAnims=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bDisableMenuTransitions=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bDisableTPVCameraInterpolation=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bDisableTorporEffect=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bDistanceFieldShadowing=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bEnableColorGrading=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bEnableHDROutput=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bEnableInventoryItemTooltips=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bExtraLevelStreamingDistance=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bFPVClimbingGear=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bFPVGlidingGear=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bFilmGrain=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bFirstPersonRiding=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bFloatingNames=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bForceTPVCameraOffset=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHasCompletedGen2=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHasSeenGen2Intro=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHideFloatingPlayerNames=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHideGamepadItemSelectionModifier=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHideServerInfo=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHighQualityAnisotropicFiltering=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHighQualityLODs=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bHostSessionHasBeenOpened=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bInvertLookY=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bJoinNotifications=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bLocalInventoryCraftingShowAllItems=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bLocalInventoryItemsShowAllItems=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bLowQualityAnimations=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bLowQualityVFX=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bMotionBlur=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bNoBloodEffects=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bNoTooltipDelay=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bPreventBiomeWalls=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bPreventColorizedItemNames=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bPreventCrosshair=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bPreventHitMarkers=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bPreventInventoryOpeningSounds=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bPreventItemCraftingSounds=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bQuickToggleItemNames=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bRemoteInventoryCraftingShowAllItems=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bRemoteInventoryItemsShowAllItems=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bRemoteInventoryShowCraftables=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bRemoteInventoryShowEngrams=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bRequestDefaultCharacterItemsOnce=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bReverseTribeLogOrder=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bShowChatBox=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bShowRTSKeyBinds=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bShowStatusNotificationMessages=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bShowedGenesis2DLCBackground=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bShowedGenesisDLCBackground=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bSpectatorManualFloatingNames=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bSuppressAdminIcon=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bTemperatureF=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bThirdPersonPlayer=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bToggleExtendedHUDInfo=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bToggleToTalk=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseDFAO=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseDesktopResolutionForFullscreen=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseDistanceFieldAmbientOcclusion=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseLowQualityLevelStreaming=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseOldThirdPersonCameraOffset=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseOldThirdPersonCameraTrace=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseSSAO=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseSimpleDistanceMovement=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bUseVSync=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bViewedARK2Trailer=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "bViewedAnimatedSeriesTrailer=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "CameraShakeScale=0.100000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "CharacterAudioVolume=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "ClientNetQuality=3"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "CompanionIsHiddenState=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "CompanionReactionVerbosity=3"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "CompanionSubtitleVerbosityLevel=3"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "DOFSettingInterpTime=0.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "DisableDefaultCharacterItems=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "DisableMenuMusic=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "DisableSubtitles=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EmoteKeyBind1=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EmoteKeyBind2=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EnableDeathReactions=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EnableEmoteReactions=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EnableEnvironmentalReactions=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EnableMovementSounds=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EnableRespawnReactions=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "EnableSayHelloReactions=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "FOVMultiplier=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "FullscreenMode=2"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "Gamma1=2.200000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "Gamma2=3.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "GammaCorrection=0.500000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "GraphicsQuality=2"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "GroundClutterDensity=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "HideItemTextOverlay=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "HighQualityMaterials=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "HighQualitySurfaces=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LODScalar=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastAutoFavorite=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastConfirmedFullscreenMode=2"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastDLCTypeSearchType=-1"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastJoinedSessionPerCategory="" """))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastPVESearchType=-1"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastServerSearchHideFull=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastServerSearchProtected=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastServerSearchType=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastServerSort=2"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastServerSortAsc=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastUserConfirmedResolutionSizeX=1280"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LastUserConfirmedResolutionSizeY=720"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LocalCraftingSortType=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LocalItemSortType=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LookLeftRightSensitivity=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "LookUpDownSensitivity=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl0="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl1="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl2="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl3="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl4="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl5="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl6="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl7="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl8="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MacroCtrl9="))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MasterAudioVolume=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MaxAscensionLevel=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "MusicAudioVolume=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "PlayActionWheelClickSound=True"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "PreventDetailGraphics=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "RemoteCraftingSortType=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "RemoteItemSortType=0"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "ResolutionSizeX=1280"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "ResolutionSizeY=720"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "SFXAudioVolume=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "ShowExplorerNoteSubtitles=False"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "TrueSkyQuality=0.270000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "UIQuickbarScaling=0.750000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "UIScaling=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "VSyncMode=1"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "Version=5"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "VersionMetaTag=1"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "VoiceAudioVolume=1.000000"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "WindowPosX=-1"))
		        QualityValues.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, QualityHeader, "WindowPosY=-1"))
		        
		        FinalOrganizer.Add(QualityValues)
		      End If
		      
		      If FinalOrganizer.HasHeader(ArkSA.ConfigFileGameUserSettings, "SessionSettings") = False Then
		        FinalOrganizer.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, "SessionSettings", "SessionName=" + Language.DefaultServerName(ArkSA.Identifier) + " Managed by Beacon"))
		      End If
		    End If
		    
		    // Remove excess junk that sneaks in from who knows where.
		    FinalOrganizer.Remove(ArkSA.ConfigFileGameUserSettings, "/Game/PrimalEarth/CoreBlueprints/TestGameMode.TestGameMode_C")
		    FinalOrganizer.Remove(ArkSA.ConfigFileGame, "ShooterGameMode_TEMPOverrides")
		    
		    Return ConvertEncoding(FinalOrganizer.Build(File).ReplaceLineEndings(DesiredLineEnding), Format)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As ArkSA.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Project As ArkSA.Project, Identity As Beacon.Identity, Profile As ArkSA.ServerProfile, Format As ArkSA.Rewriter.EncodingFormat, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  Try
		    Var Organizer As ArkSA.ConfigOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    Return Rewrite(Source, InitialContent, DefaultHeader, File, Organizer, Project.ProjectId, Project.LegacyTrustKey, Format, Project.UWPMode, Nuke, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rewrite(Flags As Integer)
		  Self.mOutputFlags = Flags And (Self.FlagCreateGameIni Or Self.FlagCreateGameUserSettingsIni Or Self.FlagCreateCommandLine Or Self.FlagForceTrollMode)
		  Super.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Start()
		  Super.Start()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerFinished()
		  RaiseEvent Finished
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerStarted()
		  RaiseEvent Started
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFinishedCommandLineContent
			End Get
		#tag EndGetter
		FinishedCommandLineContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFinishedGameIniContent
			End Get
		#tag EndGetter
		FinishedGameIniContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFinishedGameUserSettingsIniContent
			End Get
		#tag EndGetter
		FinishedGameUserSettingsIniContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIdentity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIdentity <> Value Then
			    Self.mIdentity = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Identity As Beacon.Identity
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mInitialGameIniContent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mInitialGameIniContent = Value.SanitizeIni
			End Set
		#tag EndSetter
		InitialGameIniContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mInitialGameUserSettingsIniContent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mInitialGameUserSettingsIniContent = Value.SanitizeIni
			End Set
		#tag EndSetter
		InitialGameUserSettingsIniContent As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinishedCommandLineContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinishedGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinishedGameUserSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitialGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitialGameUserSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOrganizer As ArkSA.ConfigOrganizer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutputFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As ArkSA.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As ArkSA.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRebuildOrganizer As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As ArkSA.Rewriter.Sources
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTriggers() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProfile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Don't just use <> here, it does not compare correctly with Nitrado
			  
			  If Value Is Nil Then
			    If Self.mProfile Is Nil Then
			      Return
			    End If
			    
			    Self.mProfile = Nil
			    Self.mRebuildOrganizer = True
			    Return
			  End If
			  
			  If (Self.mProfile Is Nil) = False And Self.mProfile.Hash = Value.Hash Then
			    Return
			  End If
			  
			  Self.mProfile = Value
			  Self.mRebuildOrganizer = True
			End Set
		#tag EndSetter
		Profile As ArkSA.ServerProfile
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProject
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProject <> Value Then
			    Self.mProject = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Project As ArkSA.Project
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSource
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSource = Value
			End Set
		#tag EndSetter
		Source As ArkSA.Rewriter.Sources
	#tag EndComputedProperty


	#tag Constant, Name = FlagCreateCommandLine, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagCreateGameIni, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagCreateGameUserSettingsIni, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagForceTrollMode, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeGameIni, Type = String, Dynamic = False, Default = \"Game.ini", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeGameUserSettingsIni, Type = String, Dynamic = False, Default = \"GameUserSettings.ini", Scope = Public
	#tag EndConstant


	#tag Enum, Name = EncodingFormat, Type = Integer, Flags = &h0
		Unicode
		  UCS2AndASCII
		ASCII
	#tag EndEnum

	#tag Enum, Name = Sources, Type = Integer, Flags = &h0
		Original
		  Deploy
		  SmartCopy
		SmartSave
	#tag EndEnum


	#tag ViewBehavior
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
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialGameIniContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialGameUserSettingsIniContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FinishedGameIniContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FinishedGameUserSettingsIniContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FinishedCommandLineContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Source"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ArkSA.Rewriter.Sources"
			EditorType="Enum"
			#tag EnumValues
				"0 - Original"
				"1 - Deploy"
				"2 - SmartCopy"
				"3 - SmartSave"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
