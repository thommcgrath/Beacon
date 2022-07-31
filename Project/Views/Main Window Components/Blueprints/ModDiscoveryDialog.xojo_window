#tag Window
Begin BeaconDialog ModDiscoveryDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   234
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   234
   MinimumWidth    =   600
   Resizeable      =   False
   Title           =   "Mod Discovery"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   234
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedPushButton IntroActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "OK"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton IntroCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label IntroMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Automatic Mod Discovery"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   376
      End
      Begin UITweaks.ResizedTextField IntroArkPathField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   118
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   356
      End
      Begin UITweaks.ResizedLabel IntroArkPathLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Ark Path:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   118
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedPushButton IntroArkPathButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Choose…"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   119
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label IntroExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   54
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "This feature will use an installed copy of Ark from Steam to launch a dedicated server, collect mod info using the DataDumper mod, and end the server. Enter the mod ids of the desired mods below."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label IntroSteamLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   380
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Requires Ark on Steam"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   200
      End
      Begin UITweaks.ResizedTextField IntroModsField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   132
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   152
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   448
      End
      Begin UITweaks.ResizedLabel IntroModsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Desired Mod IDs:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   152
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin UITweaks.ResizedPushButton FinishedActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "OK"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label WorkingStatus
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Starting Up…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar WorkingIndicator
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   False
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
      End
      Begin Label FinishedMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Automatic Mod Discovery Finished"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label FinishedExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   130
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label WorkingInstructionsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   130
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "The Ark server may appear stuck for minutes at a time. This is normal. Beacon will stop the server once it has collected the needed data. The Ark server will open three ports, which may trigger malware or firewall alerts. This is ok and should be allowed."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label IntroDisclaimerLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "This technique is not perfect and sometimes misses things!"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   194
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   376
      End
   End
   Begin Thread RunThread
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Shell RunShell
      Arguments       =   ""
      Backend         =   ""
      Canonical       =   False
      ExecuteMode     =   2
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
      TimeOut         =   0
   End
   Begin Timer RunTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   3000
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin TCPSocket RunSocket
      Address         =   "127.0.0.1"
      Index           =   -2147483648
      LockedInPosition=   False
      Port            =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.IntroArkPathField.Text = Preferences.ArkSteamPath
		  
		  Self.IntroSteamLabel.TextColor = SystemColors.SystemRedColor
		  
		  BeaconUI.SizeToFit(Self.IntroArkPathLabel, Self.IntroModsLabel)
		  
		  Self.IntroArkPathField.Left = Self.IntroArkPathLabel.Left + Self.IntroArkPathLabel.Width + 12
		  Self.IntroModsField.Left = Self.IntroArkPathField.Left
		  Self.IntroArkPathField.Width = Self.IntroArkPathButton.Left - (12 + Self.IntroArkPathField.Left)
		  Self.IntroModsField.Width = Self.Width - (20 + Self.IntroModsField.Left)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function BuildCommand(Type As Int32, Command As String) As MemoryBlock
		  Var CommandLen As Integer = Command.Bytes
		  Var Mem As New MemoryBlock(CommandLen + 14)
		  Mem.LittleEndian = True
		  Mem.Int32Value(0) = CommandLen + 10 // Size
		  Mem.Int32Value(4) = System.Random.InRange(1, 9999) // ID
		  Mem.Int32Value(8) = Type // Type
		  Mem.StringValue(12, CommandLen) = Command
		  Return Mem
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function CheckModDelegate(WorkshopID As String) As Boolean
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub CompletedDelegate(DiscoveredMods() As Ark.ContentPack)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Constructor(CheckCallback As ModDiscoveryDialog.CheckModDelegate, CompleteCallback As ModDiscoveryDialog.CompletedDelegate)
		  // Calling the overridden superclass constructor.
		  Self.mCheckCallback = CheckCallback
		  Self.mCompletedCallback = CompleteCallback
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Import(Contents As String)
		  Self.RunThread.AddUserInterfaceUpdate(New Dictionary("message" : "Discovering blueprints…"))
		  
		  Var Importer As Ark.BlueprintImporter = Ark.BlueprintImporter.ImportAsDataDumper(Contents)
		  If Importer Is Nil Or Importer.BlueprintCount = 0 Then
		    Return
		  End If
		  
		  Var Database As Ark.DataSource = Ark.DataSource.SharedInstance(Ark.DataSource.FlagCreateIfNeeded Or Ark.DataSource.FlagUseWeakRef)
		  
		  Var TitleFinder As New Regex
		  TitleFinder.SearchPattern = "<div class=""workshopItemTitle"">(.+)</div>"
		  TitleFinder.Options.Greedy = False
		  
		  Var Packs As New Dictionary
		  Var ForbiddenWorkshopIDs As New Dictionary
		  ForbiddenWorkshopIDs.Value("2171967557") = True
		  For Each WorkshopID As String In Self.mMods
		    If WorkshopID = "2171967557" Then
		      Continue
		    End If
		    
		    Var Pack As Ark.ContentPack = Database.GetContentPackWithWorkshopID(WorkshopID)
		    
		    If Pack Is Nil Then
		      Var PackName As String = Self.mTagsByMod.Lookup(WorkshopID, WorkshopID).StringValue
		      
		      Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		      Socket.RequestHeader("User-Agent") = App.UserAgent
		      Socket.Send("GET", "https://steamcommunity.com/sharedfiles/filedetails/?id=" + WorkshopID)
		      If Socket.LastHTTPStatus = 200 Then
		        Var TitleMatch As RegexMatch = TitleFinder.Search(Socket.LastContent)
		        If (TitleMatch Is Nil) = False Then
		          PackName = DecodingFromHTMLMBS(TitleMatch.SubExpressionString(1))
		        End If
		      End If
		      
		      Pack = Database.CreateLocalContentPack(PackName, WorkshopID)
		      Self.mNumAddedMods = Self.mNumAddedMods + 1
		    ElseIf Pack.IsLocal = False Then
		      ForbiddenWorkshopIDs.Value(WorkshopID) = True
		    End If
		    
		    Packs.Value(WorkshopID) = Pack
		  Next
		  
		  Var CurrentBlueprints() As Ark.Blueprint = Database.GetBlueprints("", Self.mMods, "")
		  Var CurrentBlueprintMap As New Dictionary
		  For Each Blueprint As Ark.Blueprint In CurrentBlueprints
		    CurrentBlueprintMap.Value(Blueprint.Path) = Blueprint
		  Next
		  
		  Var BlueprintsToSave() As Ark.Blueprint
		  Var Blueprints() As Ark.Blueprint = Importer.Blueprints
		  Var NewBlueprintIDs As New Dictionary
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Try
		      Var Path As String = Blueprint.Path
		      If CurrentBlueprintMap.HasKey(Path) Then
		        CurrentBlueprintMap.Remove(Path)
		      End If
		      
		      Var PathComponents() As String = Path.Split("/")
		      Var Tag As String = PathComponents(3)
		      Var WorkshopID As String = Self.mModsByTag.Value(Tag)
		      If Packs.HasKey(WorkshopID) = False Or ForbiddenWorkshopIDs.HasKey(WorkshopID) Then
		        Continue
		      End If
		      
		      Var Pack As Ark.ContentPack = Packs.Value(WorkshopID)
		      Var ExistingBlueprints() As Ark.Blueprint = Database.GetBlueprints(Path, New Beacon.StringList(Pack.UUID))
		      If ExistingBlueprints.Count > 0 Then
		        Continue
		      End If
		      
		      Var Mutable As Ark.MutableBlueprint = Blueprint.MutableVersion
		      Mutable.ContentPackName = Pack.Name
		      Mutable.ContentPackUUID = Pack.UUID
		      BlueprintsToSave.Add(Mutable)
		      NewBlueprintIDs.Value(Blueprint.ObjectID) = True
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Pairing blueprint to mod")
		    End Try
		  Next
		  
		  Var BlueprintsToDelete() As Ark.Blueprint
		  Var DeleteBlueprintIDs As New Dictionary
		  For Each Entry As DictionaryEntry In CurrentBlueprintMap
		    BlueprintsToDelete.Add(Ark.Blueprint(Entry.Value))
		    DeleteBlueprintIDs.Value(Ark.Blueprint(Entry.Value).ObjectID) = True
		  Next
		  
		  Var Errors As New Dictionary
		  Call Database.SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, Errors)
		  
		  Self.mNumErrorBlueprints = Errors.KeyCount
		  Self.mNumAddedBlueprints = BlueprintsToSave.Count
		  Self.mNumRemovedBlueprints = BlueprintsToDelete.Count
		  
		  For Each Entry As DictionaryEntry In Errors
		    App.Log(RuntimeException(Entry.Value), CurrentMethodName, "Automatic mod discovery")
		    
		    Var BlueprintID As String = Entry.Key
		    If NewBlueprintIDs.HasKey(BlueprintID) Then
		      Self.mNumAddedBlueprints = Self.mNumAddedBlueprints - 1
		    ElseIf DeleteBlueprintIDs.HasKey(BlueprintID) Then
		      Self.mNumRemovedBlueprints = Self.mNumRemovedBlueprints - 1
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In Packs
		    Var WorkshopID As String = Entry.Key
		    Var Pack As Ark.ContentPack = Entry.Value
		    
		    If ForbiddenWorkshopIDs.HasKey(WorkshopID) Then
		      Continue
		    End If
		    
		    Self.mDiscoveredMods.Add(Pack)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadUnrealString(Stream As BinaryStream) As String
		  Var Len As UInt32 = Stream.ReadUInt32
		  If Len <> 0 Then
		    Var St As String = Stream.Read(Len - 1).DefineEncoding(Encodings.UTF8)
		    Call Stream.Read(1) // To advance past the trailing null
		    Return St
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mArkRoot As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCheckCallback As ModDiscoveryDialog.CheckModDelegate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompletedCallback As ModDiscoveryDialog.CompletedDelegate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDiscoveredMods() As Ark.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModsByTag As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumAddedBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumAddedMods As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumErrorBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumRemovedBlueprints As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONAuthenticated As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONAuthResponse As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRunShell As Shell
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTagsByMod As Dictionary
	#tag EndProperty


	#tag Constant, Name = PageFinished, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageIntro, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageWorking, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events IntroActionButton
	#tag Event
		Sub Action()
		  Var ArkFolder As FolderItem
		  Try
		    ArkFolder = New FolderItem(Self.IntroArkPathField.Text, FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Ark path is not valid", "Beacon was able to resolve the entered path. Use the choose button to select the folder containing the ShooterGame folder.")
		    Return
		  End Try
		  
		  If ArkFolder.Exists = False Then
		    Self.ShowAlert("Ark path not found", "The selected path does not exist. Use the choose button to select the folder containing the ShooterGame folder.")
		    Return
		  End If
		  
		  Var Executable As FolderItem = Ark.DedicatedServer.ShooterGameServer(ArkFolder)
		  If Executable Is Nil Then
		    Self.ShowAlert("Ark server not found", "Beacon could not find the Ark server executable in the selected path. Use the choose button to select the folder containing the ShooterGame folder.")
		    Return
		  End If
		  
		  Var ModsString As String = Self.IntroModsField.Text.Trim
		  If ModsString.IsEmpty Then
		    Self.ShowAlert("Don't forget to include some mods", "This process doesn't make much sense without mod ids does it?")
		    Return
		  End If
		  
		  Var Matcher As New Regex
		  Matcher.SearchPattern = "^\d+$"
		  Var ModIDs() As String = ModsString.Split(",")
		  For Each ModID As String In ModIDs
		    If Matcher.Search(ModID) Is Nil Then
		      Self.ShowAlert("Mods field should contain only numbers and commas", "Format the mods field exactly like you would the ActiveMods setting in GameUserSettings.ini.")
		      Return
		    End If
		    If (Beacon.SafeToInvoke(Self.mCheckCallback) And Self.mCheckCallback.Invoke(ModID)) = False Then
		      Self.ShowAlert("Close your mod editors to continue", "There is an editor open for mod " + ModID + " that needs to be closed first.")
		      Return
		    End If
		  Next
		  
		  If ModIDs.IndexOf("2171967557") = -1 Then
		    ModIDs.Add("2171967557")
		  End If
		  Preferences.ArkSteamPath = ArkFolder.NativePath
		  Self.mMods = ModIDs
		  Self.mArkRoot = ArkFolder
		  
		  Self.Pages.SelectedPanelIndex = Self.PageWorking
		  Self.RunThread.Start
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroCancelButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroArkPathButton
	#tag Event
		Sub Action()
		  Var InitialFolder As FolderItem
		  Try
		    InitialFolder = New FolderItem(Self.IntroArkPathField.Text, FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		  End Try
		  
		  Var Dialog As New SelectFolderDialog
		  Dialog.InitialFolder = InitialFolder
		  
		  Var SelectedFolder As FolderItem = Dialog.ShowModal(Self)
		  If SelectedFolder Is Nil Then
		    Return
		  End If
		  
		  Self.IntroArkPathField.Text = SelectedFolder.NativePath
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FinishedActionButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RunThread
	#tag Event
		Sub Run()
		  Me.AddUserInterfaceUpdate(New Dictionary("message" : "Building server…"))
		  
		  Var Port As Integer = System.Random.InRange(2000, 65000)
		  Var QueryPort As Integer = Port + 1
		  Var RCONPort As Integer = Port + 2
		  Var Password As String = EncodeHex(Crypto.GenerateRandomBytes(4)).Lowercase
		  
		  Var ConfigLines() As String
		  ConfigLines.Add("[" + Ark.HeaderServerSettings + "]")
		  ConfigLines.Add("ActiveMods=" + Self.mMods.Join(","))
		  ConfigLines.Add("ServerPassword=" + Password)
		  ConfigLines.Add("ServerAdminPassword=" + Password)
		  ConfigLines.Add("RCONEnabled=True")
		  ConfigLines.Add("RCONPort=" + RCONPort.ToString(Locale.Raw, "0"))
		  ConfigLines.Add("RCONPassword=" + Password)
		  
		  Var CustomConfig As New Ark.Configs.CustomContent
		  CustomConfig.GameUserSettingsIniContent = ConfigLines.Join(EndOfLine)
		  
		  Var Profile As New Ark.LocalServerProfile
		  Var Project As New Ark.Project
		  Project.AddConfigGroup(CustomConfig)
		  Project.AddServerProfile(Profile)
		  
		  Var HostDir As FolderItem = App.ApplicationSupport.Child("Servers")
		  
		  If Ark.DedicatedServer.Configure(Project, Profile, HostDir) = False Then
		    Me.AddUserInterfaceUpdate(New Dictionary("error" : true, "message" : "Could not build server directory."))
		    Return
		  End If
		  
		  Me.AddUserInterfaceUpdate(New Dictionary("message" : "Launching server…"))
		  
		  Var ServerFolder As FolderItem = HostDir.Child(Profile.ProfileID)
		  Var Executable As FolderItem = Ark.DedicatedServer.ShooterGameServer(ServerFolder)
		  
		  Var CommandLine As String = """TheIsland?listen?SessionName=Beacon?MaxPlayers=10?Port=" + Port.ToString(Locale.Raw, "0") + "?QueryPort=" + QueryPort.ToString(Locale.Raw, "0") + """ -server -automanagedmods -servergamelog -nobattleye"
		  
		  #if TargetWindows
		    Self.RunShell.Execute(Executable.ShellPath + " " + CommandLine)
		  #else
		    #Pragma Unused Executable
		  #endif
		  
		  App.Log("Launching server with " + CommandLine)
		  App.Log("Server port is " + Port.ToString(Locale.Raw, "0"))
		  
		  Self.mRCONPort = RCONPort
		  Self.mRCONPassword = Password
		  Self.RunTimer.RunMode = Timer.RunModes.Multiple
		  
		  Me.Pause
		  
		  Self.mModsByTag = New Dictionary
		  Self.mTagsByMod = New Dictionary
		  Var ModsFolder As FolderItem
		  Try
		    ModsFolder = ServerFolder.Child("ShooterGame").Child("Content").Child("Mods")
		  Catch Err As RuntimeException
		  End Try
		  If (ModsFolder Is Nil) = False Then
		    Me.AddUserInterfaceUpdate(New Dictionary("message" : "Collecting mod info…"))
		    
		    For Each WorkshopID As String In Self.mMods
		      Try
		        Var ModInfoFile As FolderItem = ModsFolder.Child(WorkshopID).Child("mod.info")
		        Var Stream As BinaryStream = BinaryStream.Open(ModInfoFile, False)
		        Stream.LittleEndian = True
		        Var ModTag As String = ReadUnrealString(Stream)
		        Stream.Close
		        
		        Self.mTagsByMod.Value(WorkshopID) = ModTag
		        Self.mModsByTag.Value(ModTag) = WorkshopID
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Reading mod info file")
		      End Try
		    Next
		  End If
		  
		  Me.AddUserInterfaceUpdate(New Dictionary("message" : "Reading log file…"))
		  
		  Var LogFile As FolderItem
		  Try
		    LogFile = ServerFolder.Child("ShooterGame").Child("Saved").Child("Logs").Child("ShooterGame.log")
		  Catch Err As RuntimeException
		  End Try
		  If LogFile Is Nil Or LogFile.Exists = False Then
		    Me.AddUserInterfaceUpdate(New Dictionary("error" : true, "message" : "Could not find ShooterGame.log file."))
		    Return
		  End If
		  
		  Var Stream As TextInputStream = TextInputStream.Open(LogFile)
		  Var LogContents As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Self.Import(LogContents)
		  
		  #if Not DebugBuild
		    If ServerFolder.DeepDelete(False) = False Then
		      App.Log("Server folder " + ServerFolder.NativePath + " was not deleted")
		    End If
		  #endif
		  
		  Var Message As String = "Finished. Added " + Language.NounWithQuantity(Self.mNumAddedMods, "new mod", "new mods") + ", " + Language.NounWithQuantity(Self.mNumAddedBlueprints, "new blueprint", "new blueprints") + ", and removed " + Language.NounWithQuantity(Self.mNumRemovedBlueprints, "blueprint", "blueprints") + "."
		  If Self.mNumErrorBlueprints > 0 Then
		    Message = Message + " " + Language.NounWithQuantity(Self.mNumErrorBlueprints, "blueprint", "blueprints") + " had errors and could not be imported."
		  End If
		  Me.AddUserInterfaceUpdate(New Dictionary("error" : false, "finished" : true, "message" : Message))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    If Dict.HasKey("message") Then
		      App.Log(Dict.Value("message"))
		    End If
		    
		    If Dict.Lookup("error", False).BooleanValue Then
		      Self.ShowAlert("There was an error creating the server", Dict.Lookup("message", "No further details available").StringValue)
		      Self.Close
		      Return
		    End If
		    
		    If Dict.Lookup("finished", False).BooleanValue Then
		      Self.Pages.SelectedPanelIndex = Self.PageFinished
		      Self.FinishedExplanationLabel.Text = Dict.Value("message")
		      If Beacon.SafeToInvoke(Self.mCompletedCallback) Then
		        Self.mCompletedCallback.Invoke(Self.mDiscoveredMods)
		      End If
		    ElseIf Dict.HasKey("message") Then
		      Self.WorkingStatus.Text = Dict.Value("message")
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RunShell
	#tag Event
		Sub DataAvailable()
		  System.DebugLog(Me.ReadAll)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Completed()
		  System.DebugLog("Completed")
		  Self.RunSocket.Close
		  Self.RunTimer.RunMode = Timer.RunModes.Off
		  Self.RunThread.Resume
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RunTimer
	#tag Event
		Sub Action()
		  If Self.RunSocket.IsConnected = False THen
		    Self.RunSocket.Close
		    Self.RunSocket.Address = "127.0.0.1"
		    Self.RunSocket.Port = Self.mRCONPort
		    Self.RunSocket.Connect
		    Return
		  End If
		  
		  If Self.mRCONAuthenticated = False Then
		    Return
		  End If
		  
		  Var Mem As MemoryBlock = Self.BuildCommand(2, "GetGameLog")
		  Self.RunSocket.Write(Mem)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RunSocket
	#tag Event
		Sub Connected()
		  System.DebugLog("RCON connected")
		  Self.RunThread.AddUserInterfaceUpdate(New Dictionary("message" : "RCON Connected. Waiting for mod data…"))
		  
		  Var PassLen As Int32 = Self.mRCONPassword.Bytes
		  Var Auth As New MemoryBlock(PassLen + 14)
		  Auth.LittleEndian = True
		  Auth.Int32Value(0) = PassLen + 10// Size
		  Auth.Int32Value(4) = System.Random.InRange(1, 9999) // ID
		  Auth.Int32Value(8) = 3 // Type
		  Auth.StringValue(12, PassLen) = Self.mRCONPassword
		  
		  Var AuthResponse As New MemoryBlock(14)
		  AuthResponse.LittleEndian = True
		  AuthResponse.Int32Value(0) = 10
		  AuthResponse.Int32Value(4) = Auth.Int32Value(4)
		  AuthResponse.Int32Value(8) = 2
		  Self.mRCONAuthResponse = AuthResponse
		  
		  Me.Write(Auth)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(err As RuntimeException)
		  System.DebugLog("Socket error: " + Err.Message)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DataAvailable()
		  Var Message As String = Me.ReadAll
		  
		  System.DebugLog(EncodeHex(Message))
		  
		  If Self.mRCONAuthenticated = False Then
		    Self.mRCONAuthenticated = Message = Self.mRCONAuthResponse
		    Return
		  End If
		  
		  If Message.IndexOf("End Dino Drop Inventory Data From Spawns") > -1 Then
		    // Finished
		    
		    Self.RunTimer.RunMode = Timer.RunModes.Off
		    
		    Var Mem As MemoryBlock = Self.BuildCommand(2, "DoExit")
		    Me.Write(Mem)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
