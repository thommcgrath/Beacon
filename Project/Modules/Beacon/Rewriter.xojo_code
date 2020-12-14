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
		  Var TrustKey As String = Self.mDocument.TrustKey
		  
		  Var Format As EncodingFormat = EncodingFormat.ASCII
		  If Self.mDocument.AllowUCS Then
		    Format = EncodingFormat.UCS2AndASCII
		  End If
		  
		  Var Document As Beacon.Document = Self.mDocument
		  Var Identity As Beacon.Identity = Self.mIdentity
		  Var Profile As Beacon.ServerProfile = Self.mProfile
		  Var InitialGameIni As String = Self.mInitialGameIniContent
		  Var InitialGameUserSettingsIni As String = Self.mInitialGameUserSettingsIniContent
		  
		  If Self.mOrganizer Is Nil Or Self.mRebuildOrganizer Then
		    Self.mOrganizer = Document.CreateConfigOrganizer(Identity, Profile)
		    Self.mRebuildOrganizer = False
		  End If
		  
		  Var Error As RuntimeException
		  
		  If (Self.mOutputFlags And Self.FlagCreateGameIni) = Self.FlagCreateGameIni Then
		    Var GameIni As String = Self.Rewrite(InitialGameIni, Beacon.ShooterGameHeader, Beacon.ConfigFileGame, Self.mOrganizer, TrustKey, Format, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		      Return
		    End If
		    Self.mFinishedGameIniContent = GameIni
		  End If
		  
		  If (Self.mOutputFlags And Self.FlagCreateGameUserSettingsIni) = Self.FlagCreateGameUserSettingsIni Then
		    Var GameUserSettingsIni As String = Self.Rewrite(InitialGameUserSettingsIni, Beacon.ServerSettingsHeader, Beacon.ConfigFileGameUserSettings, Self.mOrganizer, TrustKey, Format, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		      Return
		    End If
		    Self.mFinishedGameUserSettingsIniContent = GameUserSettingsIni
		  End If
		  
		  If (Self.mOutputFlags And Self.FlagCreateCommandLine) = Self.FlagCreateCommandLine Then
		    Var QuestionOptions() As Beacon.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineOption", "?")
		    Var QuestionFlags() As Beacon.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineFlag", "?")
		    Var HyphenOptions() As Beacon.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineOption", "-")
		    Var HyphenFlags() As Beacon.ConfigValue = Self.mOrganizer.FilteredValues("CommandLineFlag", "-")
		    
		    Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Self.mProfile.Mask)
		    Var QuestionParameters() As String
		    If Maps.LastIndex = 0 Then
		      QuestionParameters.Add(Maps(0).Identifier) 
		    Else
		      QuestionParameters.Add("Map")
		    End If
		    QuestionParameters.Add("listen")
		    For Each Option As Beacon.ConfigValue In QuestionOptions
		      If Option.Value.IsEmpty = False Then
		        QuestionParameters.Add(Option.SimplifiedKey + "=" + Option.Value)
		      End If
		    Next
		    For Each Flag As Beacon.ConfigValue In QuestionFlags
		      If Flag.Value = "True" Then
		        QuestionParameters.Add(Flag.SimplifiedKey)
		      End If
		    Next
		    
		    Var HyphenParameters() As String
		    For Each Option As Beacon.ConfigValue In HyphenOptions
		      If Option.Value.IsEmpty = False Then
		        HyphenParameters.Add("-" + Option.SimplifiedKey + "=" + Option.Value)
		      End If
		    Next
		    For Each Flag As Beacon.ConfigValue In HyphenFlags
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
		Private Shared Function ConvertEncoding(Content As String, Format As Beacon.Rewriter.EncodingFormat) As String
		  If Format = Beacon.Rewriter.EncodingFormat.Unicode Then
		    If Content.Encoding <> Encodings.UTF8 Then
		      Content = Content.ConvertEncoding(Encodings.UTF8)
		    End If
		    Return Content
		  End If
		  
		  If Format = Beacon.Rewriter.EncodingFormat.UCS2AndASCII And Encodings.ASCII.IsValidData(Content) = False Then
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
		Sub Rewrite(Flags As Integer)
		  Self.mOutputFlags = Flags And (Self.FlagCreateGameIni Or Self.FlagCreateGameUserSettingsIni Or Self.FlagCreateCommandLine)
		  Super.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(InitialContent As String, DefaultHeader As String, File As String, Organizer As Beacon.ConfigOrganizer, TrustKey As String, Format As Beacon.Rewriter.EncodingFormat, ByRef Error As RuntimeException) As String
		  // This is the new master method
		  
		  Try
		    Var DesiredLineEnding As String = InitialContent.DetectLineEnding
		    
		    // Get the initial values into an organizer
		    Var ParsedValues As New Beacon.ConfigOrganizer(File, DefaultHeader, InitialContent)
		    
		    // Use the old Beacon section to determine which values to remove
		    Var TrustValues() As Beacon.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "Trust")
		    Var Trusted As Boolean
		    For Each TrustValue As Beacon.ConfigValue In TrustValues
		      If TrustValue.Value = TrustKey Then
		        Trusted = True
		        Continue
		      End If
		    Next
		    If Trusted Then
		      Var ManagedKeys() As Beacon.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "ManagedKeys")
		      For Each ManagedKey As Beacon.ConfigValue In ManagedKeys
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
		    Var FinalOrganizer As New Beacon.ConfigOrganizer
		    FinalOrganizer.Add(Organizer.FilteredValues(File))
		    If File = Beacon.ConfigFileGameUserSettings Then
		      FinalOrganizer.Add(Organizer.FilteredValues("CommandLineOption"))
		      FinalOrganizer.Add(Organizer.FilteredValues("CommandLineFlag"))
		    End If
		    FinalOrganizer.Add(ParsedValues.FilteredValues(File), True)
		    
		    If FinalOrganizer.Count = 0 Then
		      Return ""
		    End If
		    
		    If TrustKey.IsEmpty = False Then
		      // Build the Beacon section
		      FinalOrganizer.Add(New Beacon.ConfigValue(File, "Beacon", "Build", App.BuildNumber.ToString(Locale.Raw)))
		      FinalOrganizer.Add(New Beacon.ConfigValue(File, "Beacon", "LastUpdated", DateTime.Now.SQLDateTimeWithOffset))
		      FinalOrganizer.Add(New Beacon.ConfigValue(File, "Beacon", "Trust", TrustKey))
		      Var ManagedHeaders() As String = Organizer.Headers(File)
		      For Each Header As String In ManagedHeaders
		        If Header = "Beacon" Then
		          Continue
		        End If
		        
		        Var Keys() As String = FinalOrganizer.Keys(File, Header)
		        FinalOrganizer.Add(New Beacon.ConfigValue(File, "Beacon", "ManagedKeys", "(Section=""" + Header + """,Keys=(" + Keys.Join(",") + "))"))
		      Next
		    End If
		    
		    Const QualityHeader = "/Script/ShooterGame.ShooterGameUserSettings"
		    If FinalOrganizer.HasHeader(Beacon.ConfigFileGameUserSettings, QualityHeader) = False Then
		      // More junk
		      Var QualityValues() As Beacon.ConfigValue
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "ActiveLingeringWorldTiles", "10"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bCameraViewBob", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bChatBubbles", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bCraftablesShowAllItems", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bFilmGrain", "False"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bFirstPersonRiding", "False"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bFloatingNames", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bInvertLookY", "False"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bJoinNotifications", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bMotionBlur", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bShowChatBox", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bShowStatusNotificationMessages", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bThirdPersonPlayer", "False"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bUseDesktopResolutionForFullscreen", "False"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bUseDFAO", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bUseSSAO", "True"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "bUseVSync", "False"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "CameraShakeScale", "0.100000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "FOVMultiplier", "1.000000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "FullscreenMode", "2"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "GraphicsQuality", "2"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "GroundClutterDensity", "1.000000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "LastConfirmedFullscreenMode", "2"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "LastUserConfirmedResolutionSizeX", "1280"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "LastUserConfirmedResolutionSizeY", "720"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "LookLeftRightSensitivity", "1.000000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "LookUpDownSensitivity", "1.000000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "MasterAudioVolume", "1.000000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "MusicAudioVolume", "1.000000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "ResolutionSizeX", "1280"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "ResolutionSizeY", "720"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "SFXAudioVolume", "1.000000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "TrueSkyQuality", "0.270000"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "Version", "5"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "WindowPosX", "-1"))
		      QualityValues.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, QualityHeader, "WindowPosY", "-1"))
		      FinalOrganizer.Add(QualityValues)
		    End If
		    
		    If FinalOrganizer.HasHeader(Beacon.ConfigFileGameUserSettings, "SessionSettings") = False Then
		      FinalOrganizer.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, "SessionSettings", "SessionName", "An Ark Server Managed by Beacon"))
		    End If
		    
		    // Remove excess junk that sneaks in from who knows where.
		    FinalOrganizer.Remove(Beacon.ConfigFileGameUserSettings, "/Game/PrimalEarth/CoreBlueprints/TestGameMode.TestGameMode_C")
		    
		    Return ConvertEncoding(FinalOrganizer.Build(File).ReplaceLineEndings(DesiredLineEnding), Format)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(InitialContent As String, DefaultHeader As String, File As String, Document As Beacon.Document, Identity As Beacon.Identity, Profile As Beacon.ServerProfile, Format As Beacon.Rewriter.EncodingFormat, ByRef Error As RuntimeException) As String
		  Try
		    Var Organizer As Beacon.ConfigOrganizer = Document.CreateConfigOrganizer(Identity, Profile)
		    Return Rewrite(InitialContent, DefaultHeader, File, Organizer, Document.TrustKey, Format, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
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
			  Return Self.mDocument
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDocument <> Value Then
			    Self.mDocument = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Document As Beacon.Document
	#tag EndComputedProperty

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
		Private mDocument As Beacon.Document
	#tag EndProperty

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
		Private mOrganizer As Beacon.ConfigOrganizer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutputFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRebuildOrganizer As Boolean
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
			  If Self.mProfile <> Value Then
			    Self.mProfile = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Profile As Beacon.ServerProfile
	#tag EndComputedProperty


	#tag Constant, Name = FlagCreateCommandLine, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagCreateGameIni, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagCreateGameUserSettingsIni, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag Enum, Name = EncodingFormat, Type = Integer, Flags = &h0
		Unicode
		  UCS2AndASCII
		ASCII
	#tag EndEnum


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
	#tag EndViewBehavior
End Class
#tag EndClass
