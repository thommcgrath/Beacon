#tag Window
Begin ContainerControl DocumentImportView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   456
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   600
   Begin PagePanel Views
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   456
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   6
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Transparent     =   False
      Value           =   4
      Visible         =   True
      Width           =   600
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Nitrado"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   0
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label ImportSourceMessage
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Select Import Source"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Server With FTP Access"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   1
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Single Player, Local Files, or Copy + Paste"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   2
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   116
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton SourceCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   180
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton SourceActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   180
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin NitradoDiscoveryView NitradoDiscoveryView1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   456
         HelpTag         =   ""
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   600
      End
      Begin FTPDiscoveryView FTPDiscoveryView1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   456
         HelpTag         =   ""
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   600
      End
      Begin LocalDiscoveryView LocalDiscoveryView1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   456
         HelpTag         =   ""
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   600
      End
      Begin Label StatusMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Import Status"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton StatusCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   5
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox StatusList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   1
         ColumnsResizable=   False
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   40
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   -1
         Height          =   336
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Views"
         InitialValue    =   ""
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowCount        =   0
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   60
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton StatusActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Import"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   80
      End
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Other Beacon document"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   3
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   148
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label OtherDocsMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   6
         TabStop         =   True
         Text            =   "Import from Other Documents"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton OtherDocsActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   6
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton OtherDocsCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   6
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox OtherDocsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   False
         ColumnWidths    =   "26,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   26
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   1
         Height          =   336
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Views"
         InitialValue    =   ""
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowCount        =   0
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   3
         TabPanelIndex   =   6
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   60
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin Timer DiscoveryWatcher
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   100
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SwapButtons
		  Self.Reset
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub BeginDiscovery(Engines() As Beacon.DiscoveryEngine, OAuthProvider As Text, OAuthData As Xojo.Core.Dictionary)
		  Self.mEngines = Engines
		  Self.mOAuthProvider = OAuthProvider
		  Self.mOAuthData = OAuthData
		  
		  // Make sure the importers and engines stay in order because they need to be matched up later
		  Redim Self.mImporters(-1) // To empty the array
		  Redim Self.mImporters(Engines.Ubound)
		  Redim Self.mParsedData(-1)
		  Redim Self.mParsedData(Engines.Ubound)
		  Redim Self.mDocuments(-1)
		  Redim Self.mDocuments(Engines.Ubound)
		  
		  Self.DiscoveryWatcher.Mode = Timer.ModeMultiple
		  
		  Self.StatusList.DeleteAllRows
		  For Each Engine As Beacon.DiscoveryEngine In Engines
		    Self.StatusList.AddRow(Engine.Name + EndOfLine + Engine.Status)
		    Self.StatusList.RowTag(Self.StatusList.LastIndex) = Engine
		    
		    Engine.Begin()
		  Next
		  
		  Self.Views.Value = Self.PageStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Finish()
		  Dim Documents() As Beacon.Document
		  For I As Integer = 0 To Self.mDocuments.Ubound
		    If Self.mDocuments(I) <> Nil Then
		      Documents.Append(Self.mDocuments(I))
		    End If
		  Next
		  If Documents.Ubound > -1 Then
		    RaiseEvent DocumentsImported(Documents)
		  End If
		  RaiseEvent ShouldDismiss
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(File As FolderItem)
		  Self.QuickCancel = True
		  Self.Views.Value = 3
		  Self.LocalDiscoveryView1.AddFile(File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Importer_ThreadedParseFinished(Sender As Beacon.ImportThread, ParsedData As Xojo.Core.Dictionary)
		  Dim Idx As Integer = -1
		  For I As Integer = 0 To Self.mImporters.Ubound
		    If Self.mImporters(I) = Sender Then
		      Self.mParsedData(I) = ParsedData
		      Idx = I
		      Exit For I
		    End If
		  Next
		  
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Dim Engine As Beacon.DiscoveryEngine = Self.mEngines(Idx)
		  Dim CommandLineOptions As Xojo.Core.Dictionary = Engine.CommandLineOptions
		  If CommandLineOptions = Nil Then
		    CommandLineOptions = New Xojo.Core.Dictionary
		  End If
		  Dim Document As New Beacon.Document
		  Document.MapCompatibility = Engine.Map
		  
		  Try
		    Dim Maps() As Beacon.Map = Beacon.Maps.ForMask(Engine.Map)
		    If Maps.Ubound = -1 Then
		      Maps.Append(Beacon.Maps.TheIsland)
		    End If
		    Dim DifficultyTotal, DifficultyScale As Double
		    For Each Map As Beacon.Map In Maps
		      DifficultyTotal = DifficultyTotal + Map.DifficultyScale
		    Next
		    DifficultyScale = DifficultyTotal / (Maps.Ubound + 1)
		    
		    Dim DifficultyValue As Double
		    If CommandLineOptions.HasKey("OverrideOfficialDifficulty") And CommandLineOptions.DoubleValue("OverrideOfficialDifficulty") > 0 Then
		      DifficultyValue = CommandLineOptions.DoubleValue("OverrideOfficialDifficulty")
		    ElseIf ParsedData.HasKey("OverrideOfficialDifficulty") And ParsedData.DoubleValue("OverrideOfficialDifficulty") > 0 Then
		      DifficultyValue = ParsedData.DoubleValue("OverrideOfficialDifficulty")
		    Else
		      If ParsedData.HasKey("DifficultyOffset") Then
		        DifficultyValue = ParsedData.DoubleValue("DifficultyOffset") * (DifficultyScale - 0.5) + 0.5
		      Else
		        DifficultyValue = DifficultyScale
		      End If
		    End If
		    
		    Document.AddConfigGroup(New BeaconConfigs.Difficulty(DifficultyValue))
		  Catch Err As RuntimeException
		    Document.AddConfigGroup(New BeaconConfigs.Difficulty(5.0))
		  End Try
		  
		  Try
		    If Self.mOAuthData <> Nil And Self.mOAuthProvider <> "" Then
		      Document.OAuthData(Self.mOAuthProvider) = Self.mOAuthData
		    End If
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Try
		    Dim Profile As Beacon.ServerProfile = Engine.Profile
		    If Profile <> Nil Then
		      If ParsedData.HasKey("SessionName") Then
		        Profile.Name = ParsedData.Value("SessionName")
		      End If
		      
		      Document.Add(Profile)
		    End If
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Dim ConfigNames() As Text = BeaconConfigs.AllConfigNames()
		  For Each ConfigName As Text In ConfigNames
		    If ConfigName = BeaconConfigs.Difficulty.ConfigName Or ConfigName = BeaconConfigs.CustomContent.ConfigName Then
		      // Difficulty and custom content area special
		      Continue For ConfigName
		    End If
		    
		    Dim ConfigInfo As Xojo.Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(ConfigName)
		    Dim Methods() As Xojo.Introspection.MethodInfo = ConfigInfo.Methods
		    For Each Signature As Xojo.Introspection.MethodInfo In Methods
		      Try
		        If Signature.IsShared And Signature.Name = "FromImport" And Signature.Parameters.Ubound = 3 And Signature.ReturnType <> Nil And Signature.ReturnType.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) Then
		          Dim Params(3) As Auto
		          Params(0) = ParsedData
		          Params(1) = CommandLineOptions
		          Params(2) = Document.MapCompatibility
		          Params(3) = Document.DifficultyValue
		          Dim Group As Beacon.ConfigGroup = Signature.Invoke(Nil, Params)
		          If Group <> Nil Then
		            Document.AddConfigGroup(Group)
		          End If
		          Continue For ConfigName
		        End If
		      Catch Err As RuntimeException
		        
		      End Try
		    Next
		  Next
		  
		  // Now figure out what configs we'll generate so CustomContent can figure out what NOT to capture.
		  // Do not do this in the loop above to ensure all configs are loaded first, in case they rely on each other.
		  Dim GameIniValues As New Xojo.Core.Dictionary
		  Dim GameUserSettingsIniValues As New Xojo.Core.Dictionary
		  Dim Configs() As Beacon.ConfigGroup = Document.ImplementedConfigs
		  For Each Config As Beacon.ConfigGroup In Configs
		    Beacon.ConfigValue.FillConfigDict(GameIniValues, Config.GameIniValues(Document))
		    Beacon.ConfigValue.FillConfigDict(GameUserSettingsIniValues, Config.GameUserSettingsIniValues(Document))
		  Next
		  
		  Dim CustomContent As New BeaconConfigs.CustomContent
		  Try
		    CustomContent.GameIniContent(GameIniValues) = Sender.GameIniContent
		  Catch Err As RuntimeException
		  End Try
		  Try
		    CustomContent.GameUserSettingsIniContent(GameUserSettingsIniValues) = Sender.GameUserSettingsIniContent
		  Catch Err As RuntimeException
		  End Try
		  If CustomContent.Modified Then
		    Document.AddConfigGroup(CustomContent)
		  End If
		  
		  Self.mDocuments(Idx) = Document
		  Exception Unhandled As RuntimeException
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PullValuesFromDocument(Document As Beacon.Document)
		  Self.FTPDiscoveryView1.PullValuesFromDocument(Document)
		  Self.LocalDiscoveryView1.PullValuesFromDocument(Document)
		  Self.NitradoDiscoveryView1.PullValuesFromDocument(Document)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  For I As Integer = 0 To Self.mImporters.Ubound
		    If Self.mImporters(I) <> Nil And Not Self.mImporters(I).Finished Then
		      Self.mImporters(I).Cancel
		    End If
		  Next
		  
		  Redim Self.mEngines(-1)
		  Redim Self.mImporters(-1)
		  Redim Self.mParsedData(-1)
		  Redim Self.mDocuments(-1)
		  
		  If Self.Views.Value <> 0 Then
		    Self.Views.Value = 0
		  Else
		    RaiseEvent ShouldResize(Self.SourcesPageHeight)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOtherDocuments(Documents() As Beacon.Document)
		  Self.mOtherDocuments = Documents
		  Self.SourceRadio(3).Enabled = Documents.Ubound > -1
		  Self.SourceRadio(3).Caption = "Other Beacon Document" + If(Self.SourceRadio(3).Enabled, "", " (No Other Documents Open)")
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DocumentsImported(Documents() As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldDismiss()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(Height As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDocuments() As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngines() As Beacon.DiscoveryEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImporters() As Beacon.ImportThread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthData As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthProvider As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOtherDocuments() As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParsedData() As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		QuickCancel As Boolean
	#tag EndProperty


	#tag Constant, Name = PageFTP, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLocal, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNitrado, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageOtherDocuments, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSources, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageStatus, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SourcesPageHeight, Type = Double, Dynamic = False, Default = \"220", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusPageHeight, Type = Double, Dynamic = False, Default = \"456", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Views
	#tag Event
		Sub Change()
		  Select Case Me.Value
		  Case Self.PageSources
		    RaiseEvent ShouldResize(Self.SourcesPageHeight)
		  Case Self.PageNitrado
		    NitradoDiscoveryView1.Begin
		  Case Self.PageFTP
		    FTPDiscoveryView1.Begin
		  Case Self.PageLocal
		    LocalDiscoveryView1.Begin
		  Case Self.PageStatus, Self.PageOtherDocuments
		    RaiseEvent ShouldResize(Self.StatusPageHeight)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceRadio
	#tag Event
		Sub Action(index as Integer)
		  SourceActionButton.Enabled = SourceRadio(0).Value Or SourceRadio(1).Value Or SourceRadio(2).Value Or (SourceRadio(3).Value And SourceRadio(3).Enabled And Self.mOtherDocuments.Ubound > -1)
		  SourceActionButton.Default = SourceActionButton.Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceCancelButton
	#tag Event
		Sub Action()
		  RaiseEvent ShouldDismiss
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceActionButton
	#tag Event
		Sub Action()
		  Select Case True
		  Case SourceRadio(0).Value
		    Views.Value = Self.PageNitrado
		  Case SourceRadio(1).Value
		    Views.Value = Self.PageFTP
		  Case SourceRadio(2).Value
		    Views.Value = Self.PageLocal
		  Case SourceRadio(3).Value
		    OtherDocsList.DeleteAllRows
		    OtherDocsList.ColumnType(0) = ListBox.TypeCheckbox
		    For Each Doc As Beacon.Document In Self.mOtherDocuments
		      OtherDocsList.AddRow("", Doc.Title)
		      OtherDocsList.RowTag(OtherDocsList.LastIndex) = Doc
		    Next
		    OtherDocsList.Sort()
		    OtherDocsActionButton.Enabled = False
		    Views.Value = Self.PageOtherDocuments
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NitradoDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    RaiseEvent ShouldDismiss
		  Else
		    Views.Value = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Engines() As Beacon.DiscoveryEngine, OAuthProvider As Text, OAuthData As Xojo.Core.Dictionary)
		  Self.BeginDiscovery(Engines, OAuthProvider, OAuthData)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  RaiseEvent ShouldResize(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FTPDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    RaiseEvent ShouldDismiss
		  Else
		    Views.Value = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Engines() As Beacon.DiscoveryEngine, OAuthProvider As Text, OAuthData As Xojo.Core.Dictionary)
		  Self.BeginDiscovery(Engines, OAuthProvider, OAuthData)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  RaiseEvent ShouldResize(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LocalDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    RaiseEvent ShouldDismiss
		  Else
		    Views.Value = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Engines() As Beacon.DiscoveryEngine, OAuthProvider As Text, OAuthData As Xojo.Core.Dictionary)
		  Self.BeginDiscovery(Engines, OAuthProvider, OAuthData)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  RaiseEvent ShouldResize(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StatusCancelButton
	#tag Event
		Sub Action()
		  If Self.QuickCancel Then
		    Self.Close
		  Else
		    Self.Reset()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsActionButton
	#tag Event
		Sub Action()
		  Redim Self.mDocuments(-1)
		  For I As Integer = 0 To OtherDocsList.ListCount - 1
		    If Not OtherDocsList.CellCheck(I, 0) Then
		      Continue
		    End If
		    
		    Dim Doc As Beacon.Document = OtherDocsList.RowTag(I)
		    Self.mDocuments.Append(Doc)
		  Next
		  Self.Finish()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsCancelButton
	#tag Event
		Sub Action()
		  Views.Value = Self.PageSources
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  
		  If Column <> 0 Then
		    Return
		  End If
		  
		  Dim Enabled As Boolean
		  For I As Integer = 0 To Me.ListCount - 1
		    If Me.CellCheck(I, Column) Then
		      Enabled = True
		      Exit For I
		    End If
		  Next
		  
		  OtherDocsActionButton.Enabled = Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DiscoveryWatcher
	#tag Event
		Sub Action()
		  Dim AllFinished As Boolean = True
		  Dim SuccessCount As Integer
		  Dim Errors As Boolean
		  For I As Integer = 0 To Self.mEngines.Ubound
		    Dim Engine As Beacon.DiscoveryEngine = Self.mEngines(I)
		    Dim Finished As Boolean
		    Dim Status As String
		    If Engine.Finished And Not Engine.Errored Then
		      If Self.mImporters(I) = Nil Then
		        Dim Importer As New Beacon.ImportThread
		        Importer.GameIniContent = Engine.GameIniContent
		        Importer.GameUserSettingsIniContent = Engine.GameUserSettingsIniContent
		        AddHandler Importer.ThreadedParseFinished, WeakAddressOf Importer_ThreadedParseFinished      
		        Self.mImporters(I) = Importer
		        Status = "Parsing Config Files…"
		        Importer.Run
		      ElseIf Self.mImporters(I).Finished Then
		        // Show import finished
		        Finished = True
		        If Self.mDocuments(I) <> Nil Then
		          Status = "Finished"
		          SuccessCount = SuccessCount + 1
		        Else
		          Errors = True
		          Status = "Parse error"
		        End If
		      Else
		        // Show importer progress
		        Dim Progress As Integer = Round(Self.mImporters(I).Progress * 100)
		        If Self.mImporters(I).Progress >= 1 Then
		          Status = "Finishing…"
		        Else
		          Status = "Parsing Config Files… (" + Progress.ToText() + "%)"
		        End If
		      End If
		    Else
		      // Show engine status
		      Status = Engine.Status
		      If Engine.Errored Then
		        Finished = True
		        Errors = True
		      End If
		    End If
		    
		    Status = Engine.Name + EndOfLine + Status
		    If Self.StatusList.Cell(I, 0) <> Status Then
		      Self.StatusList.Cell(I, 0) = Status
		    End If
		    
		    AllFinished = AllFinished And Finished
		  Next
		  
		  If AllFinished Then
		    Me.Mode = Timer.ModeOff
		    If Errors = False Then
		      Self.Finish()
		    ElseIf SuccessCount > 0 Then
		      If Self.ShowConfirm("There were import errors.", "Not all files imported successfully. Do you want to continue importing with the files that did import?", "Continue Import", "Review Errors") Then
		        Self.Finish()
		      Else
		        Self.StatusActionButton.Visible = True
		        #if TargetMacOS
		          Dim CancelPos As Integer = Self.StatusActionButton.Left
		          Dim ActionPos As Integer = Self.StatusCancelButton.Left
		          Self.StatusCancelButton.Left = CancelPos
		          Self.StatusActionButton.Left = ActionPos
		          Self.StatusActionButton.Default = True
		        #endif
		      End If
		    Else
		      Self.ShowAlert("No files imported.", "Beacon was not able to import anything from the selected files.")
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="QuickCancel"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
