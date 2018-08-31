#tag Window
Begin DiscoveryView NitradoDiscoveryView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   400
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   600
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      Top             =   0
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedPushButton FindingCancelButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label FindingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Finding Servers…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   190
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar FindingProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         Top             =   222
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin BeaconListbox List
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,200"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   22
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   296
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   " 	Name	Address"
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
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label ListMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Select Servers"
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
      Begin UITweaks.ResizedPushButton ListCancelButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ListActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ProgressBar ImportingProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         Top             =   206
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin Label ImportingLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         Text            =   "Downloading Required Files…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   174
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
   End
   Begin Beacon.OAuth2Client AuthClient
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Beacon.NitradoDeploymentEngine DeployEngine
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Timer LookupStartTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Beacon.ImportThread Importer
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   0
      Scope           =   2
      StackSize       =   ""
      State           =   ""
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 124
		  Self.LookupStartTimer.Mode = Timer.ModeSingle
		  Self.PagePanel1.Value = 0
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  OAuthProviders.SetupNitrado(Self.AuthClient)
		  Self.SwapButtons()
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Dim ContentHeight As Integer = FindingLabel.Height + 12 + FindingProgress.Height
		  Dim AvailableHeight As Integer = Self.Height - (52 + FindingCancelButton.Height)
		  
		  Dim ContentTop As Integer = 20 + ((AvailableHeight - ContentHeight) / 2)
		  FindingLabel.Top = ContentTop
		  FindingProgress.Top = ContentTop + FindingLabel.Height + 12
		  
		  AvailableHeight = Self.Height - 40
		  ContentTop = 20 + ((AvailableHeight - ContentHeight) / 2)
		  ImportingLabel.Top = ContentTop
		  ImportingProgress.Top = ContentTop + ImportingLabel.Height + 12
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckActionEnabled()
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Self.List.CellCheck(I, 0) Then
		      Self.ListActionButton.Enabled = True
		      Return
		    End If
		  Next
		  
		  Self.ListActionButton.Enabled = False
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSelectedServers As Xojo.Core.Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events FindingCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Self.List.ColumnType(0) = Listbox.TypeCheckbox
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Self.CheckActionEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListCancelButton
	#tag Event
		Sub Action()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListActionButton
	#tag Event
		Sub Action()
		  Self.DesiredHeight = 92
		  Self.PagePanel1.Value = 3
		  
		  Self.mSelectedServers = New Xojo.Core.Dictionary
		  
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Not Self.List.CellCheck(I, 0) Then
		      Continue
		    End If
		    
		    Dim Profile As Beacon.NitradoServerProfile = Self.List.RowTag(I)
		    Self.mSelectedServers.Value(Profile) = New Xojo.Core.Dictionary
		    
		    Self.DeployEngine.LookupServer(Profile, Self.AuthClient.AccessToken)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AuthClient
	#tag Event
		Sub Authenticated()
		  Self.DeployEngine.ListServers(Me.AccessToken)
		End Sub
	#tag EndEvent
	#tag Event
		Sub AuthenticationError()
		  Self.ShowAlert("Unable to communicate with Nitrado", "Sorry, the Nitrado API is not available at this time.")
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
	#tag Event
		Function ShowURL(URL As Text) As Beacon.WebView
		  Return MiniBrowser.ShowURL(URL)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events DeployEngine
	#tag Event
		Sub ServersFound(Servers() As Beacon.NitradoServerProfile)
		  If Servers.Ubound = -1 Then
		    Self.ShowAlert("No servers found", "Looks like Beacon couldn't find any servers accessible from your account.")
		    Self.ShouldCancel()
		    Return
		  End If
		  
		  Self.List.DeleteAllRows
		  
		  For Each Server As Beacon.NitradoServerProfile In Servers
		    Self.List.AddRow("", Server.Name, Server.Address)
		    Self.List.RowTag(Self.List.LastIndex) = Server
		  Next
		  Self.List.Sort
		  
		  Self.DesiredHeight = 400
		  Self.PagePanel1.Value = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub ServerDetails(Profile As Beacon.NitradoServerProfile, Map As Beacon.Map, DifficultyValue As Double)
		  If Map = Nil Then
		    Break
		    Self.ShowAlert("Unable to lookup server details", Profile.Name + " did not reply correctly.")
		    Self.ShouldCancel()
		    Return
		  End If
		  
		  Dim ServerDict As Xojo.Core.Dictionary = Self.mSelectedServers.Value(Profile)
		  ServerDict.Value("Map") = Map
		  ServerDict.Value("Difficulty") = DifficultyValue
		  Self.mSelectedServers.Value(Profile) = ServerDict
		  
		  Me.DownloadGameIni(Profile, Self.AuthClient.AccessToken)
		End Sub
	#tag EndEvent
	#tag Event
		Sub GameIniContent(Profile As Beacon.NitradoServerProfile, Content As Xojo.Core.MemoryBlock)
		  If Content = Nil Then
		    Break
		    Self.ShowAlert("Unable to retrieve Game.ini", Profile.Name + " did not reply correctly.")
		    Self.ShouldCancel()
		    Return
		  End If
		  
		  Dim ServerDict As Xojo.Core.Dictionary = Self.mSelectedServers.Value(Profile)
		  ServerDict.Value("Game.ini") = Content
		  ServerDict.Value("Finished") = True
		  Self.mSelectedServers.Value(Profile) = ServerDict
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mSelectedServers
		    Dim Dict As Xojo.Core.Dictionary = Entry.Value
		    If Dict.HasKey("Finished") = False Or Dict.Value("Finished") = False Then
		      Return
		    End If
		  Next
		  
		  // Everything has been downloaded
		  
		  Self.Importer.Clear
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mSelectedServers
		    Dim Dict As Xojo.Core.Dictionary = Entry.Value
		    Self.Importer.AddContent(Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Dict.Value("Game.ini")))
		  Next
		  Self.Importer.Run
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LookupStartTimer
	#tag Event
		Sub Action()
		  Self.AuthClient.Authenticate()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If ImportingProgress.Maximum = 0 Then
		    ImportingLabel.Text = "Parsing Config…"
		    ImportingProgress.Maximum = 500
		  End If
		  ImportingProgress.Value = ImportingProgress.Maximum * Me.Progress
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(ParsedData As Xojo.Core.Dictionary)
		  #Pragma Warning "Does not parse difficulty"
		  
		  Dim Document As Beacon.Document = Self.CreateDocumentFromImport(ParsedData, Nil)
		  
		  Dim MapMask As UInt64
		  Dim Profiles() As Beacon.NitradoServerProfile
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mSelectedServers
		    Dim Profile As Beacon.NitradoServerProfile = Entry.Key
		    Dim Dict As Xojo.Core.Dictionary = Entry.Value
		    
		    Profiles.Append(Profile)
		    MapMask = MapMask Or Beacon.Map(Dict.Value("Map")).Mask
		  Next
		  
		  Document.OAuthData("Nitrado") = Self.AuthClient.AuthData
		  Document.MapCompatibility = MapMask
		  
		  If Profiles.Ubound = 0 Then
		    Document.Title = Profiles(0).Name
		  Else
		    Document.Title = "Nitrado Cluster"
		  End If
		  
		  For Each Profile As Beacon.NitradoServerProfile In Profiles
		    Document.Add(Profile)
		  Next
		  
		  Self.ShouldFinish(Document)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
