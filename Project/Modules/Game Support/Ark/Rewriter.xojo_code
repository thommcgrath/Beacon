#tag Class
Protected Class Rewriter
Inherits Global.Thread
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
		  If Self.mProject.AllowUCS2 Then
		    Format = EncodingFormat.UCS2AndASCII
		  End If
		  
		  Var Project As Ark.Project = Self.mProject
		  Var Identity As Beacon.Identity = Self.mIdentity
		  Var Profile As Ark.ServerProfile = Self.mProfile
		  Var InitialGameIni As String = Self.mInitialGameIniContent
		  Var InitialGameUserSettingsIni As String = Self.mInitialGameUserSettingsIniContent
		  
		  If Self.mOrganizer Is Nil Or Self.mRebuildOrganizer Then
		    Self.mOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    Self.mRebuildOrganizer = False
		  End If
		  
		  Var Error As RuntimeException
		  
		  If (Self.mOutputFlags And Self.FlagCreateGameIni) = Self.FlagCreateGameIni Then
		    Var GameIni As String = Self.Rewrite(Self.mSource, InitialGameIni, Ark.HeaderShooterGame, Ark.ConfigFileGame, Self.mOrganizer, Project.UUID, LegacyTrustKey, Format, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		      Return
		    End If
		    Self.mFinishedGameIniContent = GameIni
		  End If
		  
		  If (Self.mOutputFlags And Self.FlagCreateGameUserSettingsIni) = Self.FlagCreateGameUserSettingsIni Then
		    Var GameUserSettingsIni As String = Self.Rewrite(Self.mSource, InitialGameUserSettingsIni, Ark.HeaderServerSettings, Ark.ConfigFileGameUserSettings, Self.mOrganizer, Project.UUID, LegacyTrustKey, Format, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		      Return
		    End If
		    Self.mFinishedGameUserSettingsIniContent = GameUserSettingsIni
		  End If
		  
		  If (Self.mOutputFlags And Self.FlagCreateCommandLine) = Self.FlagCreateCommandLine Then
		    Var QuestionOptions() As Ark.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineOption", "?")
		    Var QuestionFlags() As Ark.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineFlag", "?")
		    Var HyphenOptions() As Ark.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineOption", "-")
		    Var HyphenFlags() As Ark.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineFlag", "-")
		    
		    Var Maps() As Ark.Map = Ark.Maps.ForMask(Self.mProfile.Mask)
		    Var QuestionParameters() As String
		    If Maps.LastIndex = 0 Then
		      QuestionParameters.Add(Maps(0).Identifier) 
		    Else
		      QuestionParameters.Add("Map")
		    End If
		    QuestionParameters.Add("listen")
		    For Each Option As Ark.ConfigValue In QuestionOptions
		      If Option.Value.IsEmpty = False Then
		        QuestionParameters.Add(Option.SimplifiedKey + "=" + Option.Value)
		      End If
		    Next
		    For Each Flag As Ark.ConfigValue In QuestionFlags
		      If Flag.Value = "True" Then
		        QuestionParameters.Add(Flag.SimplifiedKey)
		      End If
		    Next
		    
		    Var HyphenParameters() As String
		    For Each Option As Ark.ConfigValue In HyphenOptions
		      If Option.Value.IsEmpty = False Then
		        HyphenParameters.Add("-" + Option.SimplifiedKey + "=" + Option.Value)
		      End If
		    Next
		    For Each Flag As Ark.ConfigValue In HyphenFlags
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
		Private Shared Function ConvertEncoding(Content As String, Format As Ark.Rewriter.EncodingFormat) As String
		  If Format = Ark.Rewriter.EncodingFormat.Unicode Then
		    If Content.Encoding <> Encodings.UTF8 Then
		      Content = Content.ConvertEncoding(Encodings.UTF8)
		    End If
		    Return Content
		  End If
		  
		  If Format = Ark.Rewriter.EncodingFormat.UCS2AndASCII And Encodings.ASCII.IsValidData(Content) = False Then
		    Var Reg As New RegEx
		    Reg.SearchPattern = "[\x{10000}-\x{10FFFF}]"
		    Reg.ReplacementPattern = "?"
		    Reg.Options.ReplaceAllMatches = True
		    Try
		      Content = Reg.Replace(Content)
		    Catch Err As RegExSearchPatternException
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
		Shared Function Rewrite(Source As Ark.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Organizer As Ark.ConfigOrganizer, Format As Ark.Rewriter.EncodingFormat, ByRef Error As RuntimeException) As String
		  // This version will not contain the [Beacon] sections in the output
		  Try
		    Return Rewrite(Source, InitialContent, DefaultHeader, File, Organizer, "", "", Format, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As Ark.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Organizer As Ark.ConfigOrganizer, ProjectUUID As String, LegacyTrustKey As String, Format As Ark.Rewriter.EncodingFormat, ByRef Error As RuntimeException) As String
		  // This is the new master method
		  
		  Try
		    InitialContent = InitialContent.GuessEncoding.SanitizeIni
		    Var DesiredLineEnding As String = InitialContent.DetectLineEnding
		    
		    // Get the initial values into an organizer
		    Var ParsedValues As New Ark.ConfigOrganizer(File, DefaultHeader, InitialContent)
		    ParsedValues.Remove(Organizer.ManagedKeys) // Remove anything our groups already generate
		    
		    // Use the old Beacon section to determine which values to remove
		    Var Trusted As Boolean
		    Var TrustValues() As Ark.ConfigValue
		    If ProjectUUID.IsEmpty = False Then
		      TrustValues = ParsedValues.FilteredValues(File, "Beacon", "ProjectUUID")
		      For Each TrustValue As Ark.ConfigValue In TrustValues
		        If TrustValue.Value = ProjectUUID Then
		          Trusted = True
		          Continue
		        End If
		      Next TrustValue
		    End If
		    If Trusted = False And LegacyTrustKey.IsEmpty = False Then
		      TrustValues = ParsedValues.FilteredValues(File, "Beacon", "Trust")
		      For Each TrustValue As Ark.ConfigValue In TrustValues
		        If TrustValue.Value = LegacyTrustKey Then
		          Trusted = True
		          Continue
		        End If
		      Next
		    End If
		    
		    If Trusted Then
		      // Thanks to a deploy bug in how Beacon blends configs from InitialContent, do not trust if the deploy version is between > 1.4.8.4 and < 1.5.0.5
		      Var TrustVersions() As Ark.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "Build")
		      For Each TrustVersion As Ark.ConfigValue In TrustVersions
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
		      Var ManagedKeys() As Ark.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "ManagedKeys")
		      For Each ManagedKey As Ark.ConfigValue In ManagedKeys
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
		    Var FinalOrganizer As New Ark.ConfigOrganizer
		    FinalOrganizer.Add(Organizer.FilteredValues(File)) // Automatically grabs command line options
		    
		    // Remove everything from Parsed that is in Final, but don't do it by hash
		    Var NewValues() As Ark.ConfigValue = FinalOrganizer.FilteredValues(File)
		    For Each Value As Ark.ConfigValue In NewValues
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
		      
		      FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "Build=" + App.BuildNumber.ToString(Locale.Raw, "0")))
		      FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "LastUpdated=" + DateTime.Now.SQLDateTimeWithOffset))
		      FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "ProjectUUID=" + ProjectUUID))
		      If LegacyTrustKey.IsEmpty = False Then
		        FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "Trust=" + LegacyTrustKey))
		      End If
		      FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "Source=" + SourceString))
		      FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "InitialSize=" + InitialContent.Bytes.ToString(Locale.Raw, "0")))
		      FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "InitialHash=" + EncodeHex(Crypto.SHA2_256(InitialContent)).Lowercase))
		      FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "WasTrusted=" + If(Trusted, "True", "False")))
		      Var ManagedHeaders() As String = Organizer.Headers(File)
		      For HeaderIdx As Integer = 0 To ManagedHeaders.LastIndex
		        Var Header As String = ManagedHeaders(HeaderIdx)
		        If Header = "Beacon" Then
		          Continue
		        End If
		        
		        Var Keys() As String = FinalOrganizer.Keys(File, Header)
		        FinalOrganizer.Add(New Ark.ConfigValue(File, "Beacon", "ManagedKeys=(Section=""" + Header + """,Keys=(" + Keys.Join(",") + "))", "ManagedKeys:" + Header))
		      Next
		    End If
		    
		    // Now add everything remaining in Parsed to Final
		    FinalOrganizer.Add(ParsedValues.FilteredValues(File))
		    
		    If File = Ark.ConfigFileGameUserSettings Then
		      Const QualityHeader = "/Script/ShooterGame.ShooterGameUserSettings"
		      If FinalOrganizer.HasHeader(Ark.ConfigFileGameUserSettings, QualityHeader) = False Then
		        // More junk
		        Var QualityValues() As Ark.ConfigValue
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "ActiveLingeringWorldTiles=10"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bCameraViewBob=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bChatBubbles=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bCraftablesShowAllItems=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bFilmGrain=False"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bFirstPersonRiding=False"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bFloatingNames=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bInvertLookY=False"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bJoinNotifications=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bMotionBlur=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bShowChatBox=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bShowStatusNotificationMessages=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bThirdPersonPlayer=False"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bUseDesktopResolutionForFullscreen=False"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bUseDFAO=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bUseSSAO=True"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "bUseVSync=False"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "CameraShakeScale=0.100000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "FOVMultiplier=1.000000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "FullscreenMode=2"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "GraphicsQuality=2"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "GroundClutterDensity=1.000000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "LastConfirmedFullscreenMode=2"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "LastUserConfirmedResolutionSizeX=1280"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "LastUserConfirmedResolutionSizeY=720"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "LookLeftRightSensitivity=1.000000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "LookUpDownSensitivity=1.000000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "MasterAudioVolume=1.000000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "MusicAudioVolume=1.000000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "ResolutionSizeX=1280"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "ResolutionSizeY=720"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "SFXAudioVolume=1.000000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "TrueSkyQuality=0.270000"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "Version=5"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "WindowPosX=-1"))
		        QualityValues.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, QualityHeader, "WindowPosY=-1"))
		        FinalOrganizer.Add(QualityValues)
		      End If
		      
		      If FinalOrganizer.HasHeader(Ark.ConfigFileGameUserSettings, "SessionSettings") = False Then
		        FinalOrganizer.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "SessionSettings", "SessionName=An Ark Server Managed by Beacon"))
		      End If
		    End If
		    
		    // Remove excess junk that sneaks in from who knows where.
		    FinalOrganizer.Remove(Ark.ConfigFileGameUserSettings, "/Game/PrimalEarth/CoreBlueprints/TestGameMode.TestGameMode_C")
		    
		    Return ConvertEncoding(FinalOrganizer.Build(File).ReplaceLineEndings(DesiredLineEnding), Format)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As Ark.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Project As Ark.Project, Identity As Beacon.Identity, Profile As Ark.ServerProfile, Format As Ark.Rewriter.EncodingFormat, ByRef Error As RuntimeException) As String
		  Try
		    Var Organizer As Ark.ConfigOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    Return Rewrite(Source, InitialContent, DefaultHeader, File, Organizer, Project.UUID, Project.LegacyTrustKey, Format, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rewrite(Flags As Integer)
		  Self.mOutputFlags = Flags And (Self.FlagCreateGameIni Or Self.FlagCreateGameUserSettingsIni Or Self.FlagCreateCommandLine)
		  Super.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Run()
		  Super.Start
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
		Private mOrganizer As Ark.ConfigOrganizer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutputFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Ark.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRebuildOrganizer As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Ark.Rewriter.Sources
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
		Profile As Ark.ServerProfile
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
		Project As Ark.Project
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
		Source As Ark.Rewriter.Sources
	#tag EndComputedProperty


	#tag Constant, Name = FlagCreateCommandLine, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagCreateGameIni, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagCreateGameUserSettingsIni, Type = Double, Dynamic = False, Default = \"2", Scope = Public
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
			Type="Ark.Rewriter.Sources"
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
