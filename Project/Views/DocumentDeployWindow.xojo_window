#tag Window
Begin BeaconDialog DocumentDeployWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   1
   Resizeable      =   True
   Title           =   "Deploy"
   Visible         =   True
   Width           =   600
   Begin PagePanel Pages
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin Label ServerSelectionMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Select Deployment Servers"
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
      Begin BeaconListbox ServerSelectionList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "22,*,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   -1
         Height          =   280
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   1
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
      Begin UITweaks.ResizedPushButton ServerSelectionActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Begin"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ServerSelectionCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label DeployingMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         Text            =   "Deploying…"
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
      Begin Label FinishedMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Finished!"
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
      Begin UITweaks.ResizedPushButton FinishedButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Done"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox DeployingList
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
         Height          =   280
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
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
      Begin UITweaks.ResizedPushButton DeployingCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
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
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label FinishedReportLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   280
         HelpTag         =   ""
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
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "All servers updated successfully."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   60
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
   End
   Begin Beacon.OAuth2Client Auth
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Provider        =   ""
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Timer DeployingWatchTimer
      Enabled         =   True
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
		  Self.SwapButtons()
		  
		  Self.ServerSelectionList.ColumnType(0) = Listbox.TypeCheckbox
		  
		  For I As Integer = 0 To Self.mDocument.ServerProfileCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.mDocument.ServerProfile(I)
		    
		    Self.ServerSelectionList.AddRow("", Profile.Name, Profile.SecondaryName)
		    Self.ServerSelectionList.RowTag(Self.ServerSelectionList.LastIndex) = Profile
		    Self.ServerSelectionList.CellCheck(Self.ServerSelectionList.LastIndex, 0) = Profile.Enabled
		  Next
		  Self.ServerSelectionList.Sort
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AuthenticateNext()
		  If Self.mOAuthQueue.Ubound = -1 Then
		    // Move to the next step
		    Self.DeployingList.DeleteAllRows
		    
		    Dim Now As New Date()
		    Now.GMTOffset = 0
		    Self.mDeployLabel = Str(Now.Year, "0000") + "-" + Str(Now.Month, "00") + "-" + Str(Now.Day, "00") + " " + Str(Now.Hour, "00") + "." + Str(Now.Minute, "00") + "." + Str(Now.Second, "00") + " GMT"
		    
		    
		    For I As Integer = 0 To Self.mDocument.ServerProfileCount - 1
		      Dim Profile As Beacon.ServerProfile = Self.mDocument.ServerProfile(I)
		      If Not Profile.Enabled Then
		        Continue
		      End If
		      
		      Dim DeploymentEngine As Beacon.DeploymentEngine
		      Select Case Profile
		      Case IsA Beacon.NitradoServerProfile
		        DeploymentEngine = New Beacon.NitradoDeploymentEngine(Beacon.NitradoServerProfile(Profile), Self.mDocument.OAuthData(Profile.OAuthProvider))
		      Case IsA Beacon.FTPServerProfile
		        DeploymentEngine = New Beacon.FTPDeploymentEngine(Beacon.FTPServerProfile(Profile), App.IdentityManager.CurrentIdentity)
		      Else
		        Continue
		      End Select
		      
		      Self.mDeploymentEngines.Append(DeploymentEngine)
		      Self.DeployingList.AddRow(DeploymentEngine.Name + EndOfLine + DeploymentEngine.Status)
		      Self.DeployingList.RowTag(DeployingList.LastIndex) = DeploymentEngine
		    Next
		    
		    For Each DeploymentEngine As Beacon.DeploymentEngine In Self.mDeploymentEngines
		      DeploymentEngine.Begin(Self.mDeployLabel.ToText, Self.mDocument, App.IdentityManager.CurrentIdentity)
		    Next
		    
		    Self.DeployingWatchTimer.Mode = Timer.ModeMultiple
		    Return
		  End If
		  
		  Dim Provider As Text = Self.mOAuthQueue(0)
		  Self.mOAuthQueue.Remove(0)
		  
		  Self.Auth.Provider = Provider
		  If Self.Auth.Provider <> Provider Then
		    Self.ShowAlert("This version of Beacon does not support " + Provider + " servers.", "This probably means an upgrade is available.")
		    Return
		  End If
		  
		  Self.Auth.AuthData = Self.mDocument.OAuthData(Provider)
		  
		  Self.mCurrentProvider = Provider
		  Self.Auth.Authenticate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Backup(Engine As Beacon.DeploymentEngine, Folder As FolderItem) As Boolean
		  // Returning true means the backup either succeeded or should not complete
		  // Returning false means there was an error and the process needs to stop
		  
		  If Engine.Errored Then
		    Return True
		  End If
		  
		  Dim GameIniContent As Text = Engine.BackupGameIni.Trim
		  Dim GameUserSettingsIniContent As Text = Engine.BackupGameUserSettingsIni.Trim
		  If GameIniContent = "" And GameUserSettingsIniContent = "" Then
		    Return True
		  End If
		  
		  If Folder = Nil Then
		    App.Log("Unable to backup " + Engine.Name + ": No backup root folder")
		    Return False
		  End If
		  
		  Dim ServerFolder As FolderItem = Folder.Child(Beacon.SanitizeFilename(Engine.Name))
		  If ServerFolder = Nil Then
		    App.Log("Unable to backup " + Engine.Name + ": Could not to get path to server backup folder")
		    Return False
		  ElseIf ServerFolder.Exists = False Then
		    ServerFolder.CreateAsFolder
		    Dim ServerFolderError As Integer = ServerFolder.LastErrorCode
		    If ServerFolderError <> 0 Then
		      App.Log("Unable to backup " + Engine.Name + ": Could not create server backup folder " + ServerFolder.NativePath + ": " + Language.FolderItemErrorReason(ServerFolderError))
		      Return False
		    End If
		  End If
		  
		  Dim Subfolder As FolderItem = ServerFolder.Child(Beacon.SanitizeFilename(Self.mDeployLabel))
		  Dim Counter As Integer = 1
		  While Subfolder <> Nil And Subfolder.Exists
		    Subfolder = ServerFolder.Child(Beacon.SanitizeFilename(Self.mDeployLabel + "-" + Str(Counter, "-0")))
		    Counter = Counter + 1
		  Wend
		  
		  If Subfolder = Nil Then
		    App.Log("Unable to backup " + Engine.Name + ": Could not to get path to deployment folder")
		    Return False
		  End If
		  Subfolder.CreateAsFolder
		  Dim SubfolderError As Integer = Subfolder.LastErrorCode
		  If SubfolderError <> 0 Then
		    App.Log("Unable to backup " + Engine.Name + ": Could not create deployment folder " + Subfolder.NativePath + ": " + Language.FolderItemErrorReason(SubfolderError))
		    Return False
		  End If
		  
		  Dim BackedUp As Boolean = True
		  If GameIniContent <> "" Then
		    Dim GameIniFile As FolderItem = Subfolder.Child("Game.ini")
		    If GameIniFile = Nil Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + ": Could not get path to Game.ini")
		      BackedUp = False
		    ElseIf GameIniFile.Write(GameIniContent, Xojo.Core.TextEncoding.UTF8) = False Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + " to " + GameIniFile.NativePath + ": " + Language.FolderItemErrorReason(GameIniFile.LastErrorCode))
		      BackedUp = False
		    End If
		  End If
		  If GameUserSettingsIniContent <> "" Then
		    Dim GameUserSettingsIniFile As FolderItem = Subfolder.Child("GameUserSettings.ini")
		    If GameUserSettingsIniFile = Nil Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + ": Could not get path to GameUserSettings.ini")
		      BackedUp = False
		    ElseIf GameUserSettingsIniFile.Write(GameUserSettingsIniContent, Xojo.Core.TextEncoding.UTF8) = False Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + " to " + GameUserSettingsIniFile.NativePath + ": " + Language.FolderItemErrorReason(GameUserSettingsIniFile.LastErrorCode))
		      BackedUp = False
		    End If
		  End If
		  
		  Return BackedUp
		  
		  Exception Err As RuntimeException
		    Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Document As Beacon.Document)
		  Self.mDocument = Document
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Document As Beacon.Document) As DocumentDeployWindow
		  If Document.ServerProfileCount = 0 Then
		    BeaconUI.ShowAlert("This document has not defined any servers.", "See the ""Servers"" config section to define servers.")
		    Return Nil
		  End If
		  
		  Return New DocumentDeployWindow(Document)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowResults()
		  Dim Report() As String
		  Dim SuccessCount, TotalCount As Integer
		  For Each DeploymentEngine As Beacon.DeploymentEngine In Self.mDeploymentEngines
		    If DeploymentEngine.Errored Then
		      Report.Append(DeploymentEngine.Name + ": " + DeploymentEngine.Status)
		    Else
		      SuccessCount = SuccessCount + 1
		      Report.Append(DeploymentEngine.Name + ": Finished successfully. " + If(DeploymentEngine.ServerIsStarting, "The server is starting up now.", "You may start the server when you are ready."))
		    End If
		  Next
		  TotalCount = Self.mDeploymentEngines.Ubound + 1
		  
		  If SuccessCount = 0 Then
		    If TotalCount = 1 Then
		      Report.Insert(0, "The deployment did not succeed!")
		    Else
		      Report.Insert(0, "No server completed the deployment successfully!")
		    End If
		  ElseIf SuccessCount = 1 And TotalCount = 1 Then
		    Report(0) = "The deployment finished successfully. " + If(Self.mDeploymentEngines(0).ServerIsStarting, "The server is starting up now.", "You may start the server when you are ready.")
		  ElseIf SuccessCount = TotalCount Then
		    Report.Insert(0, "All servers updated successfully.")
		  Else
		    Report.Insert(0, "Some servers successfully updated, but there were errors.")
		  End If
		  
		  Self.FinishedReportLabel.Text = Join(Report, EndOfLine)
		  
		  Self.Pages.Value = Self.PageFinished
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentProvider As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeployLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeploymentEngines() As Beacon.DeploymentEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthQueue() As Text
	#tag EndProperty


	#tag Constant, Name = PageDeploying, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageFinished, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageServerSelection, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ServerSelectionList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column = 0 Then
		    Beacon.ServerProfile(Me.RowTag(Row)).Enabled = Me.CellCheck(Row, Column)
		  End If
		  
		  For I As Integer = 0 To Me.ListCount - 1
		    If Me.CellCheck(I, 0) Then
		      Self.ServerSelectionActionButton.Enabled = True
		      Return
		    End If
		  Next
		  
		  Self.ServerSelectionActionButton.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerSelectionActionButton
	#tag Event
		Sub Action()
		  Const RestartSupportedUnknown = -1
		  Const RestartSupportedNone = 0
		  Const RestartSupportedMixed = 1
		  Const RestartSupportedAll = 2
		  
		  Dim SelectedCount As Integer
		  Dim Supported As Integer = RestartSupportedUnknown
		  For I As Integer = 0 To Self.mDocument.ServerProfileCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.mDocument.ServerProfile(I)
		    If Not Profile.Enabled Then
		      Continue
		    End If
		    
		    Self.DeployingList.AddRow(Profile.Name + EndOfLine + If(Profile.OAuthProvider <> "", "Authenticating…", "Waiting…"))
		    
		    SelectedCount = SelectedCount + 1
		    
		    Dim CanRestart As Boolean = Profile.SupportsRestart
		    If Supported = RestartSupportedUnknown Then
		      Supported = If(CanRestart, RestartSupportedAll, RestartSupportedNone)
		    ElseIf (CanRestart = True And Supported = RestartSupportedNone) Or (CanRestart = False And Supported = RestartSupportedAll) Then
		      Supported = RestartSupportedMixed
		    End If
		  Next
		  
		  Dim Predicate As String = If(SelectedCount = 1, "server", "servers")
		  Dim Conjunction As String = If(SelectedCount = 1, "is", "are")
		  Dim Reference As String = If(SelectedCount = 1, "it", "they")
		  
		  Select Case Supported
		  Case RestartSupportedAll
		    If Not Self.ShowConfirm("Deploying will restart your " + Predicate + " if " + Reference + " " + Conjunction + " already running. Do you want to continue?", If(Self.mDocument.ServerProfileCount = 1, "If your server is not running, it will remain stopped when finished.", "Servers that are not running will remain stopped when finished."), "Deploy Now", "Cancel") Then
		      Return
		    End If
		  Case RestartSupportedNone
		    If Not Self.ShowConfirm("Make sure your " + Predicate + " " + Conjunction + " stopped before continuing.", "Beacon cannot restart your " + Predicate + " automatically.", "Continue", "Cancel") Then
		      Return
		    End If
		  Case RestartSupportedMixed
		    If Not Self.ShowConfirm("Some of your servers need to be stopped before continuing. Others will be restarted if they are running. Do you want to continue?", "Beacon can restart some of your servers for you, but not all of them. Servers that are not running will remain stopped when finished.", "Continue", "Cancel") Then
		      Return
		    End If
		  End Select
		  
		  Self.Pages.Value = Self.PageDeploying
		  
		  For I As Integer = 0 To Self.mDocument.ServerProfileCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.mDocument.ServerProfile(I)
		    If Not Profile.Enabled Then
		      Continue
		    End If
		    
		    Dim Provider As Text = Profile.OAuthProvider
		    If Provider <> "" And Self.mOAuthQueue.IndexOf(Provider) = -1 Then
		      Self.mOAuthQueue.Append(Provider)
		    End If
		  Next
		  
		  Self.AuthenticateNext()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerSelectionCancelButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FinishedButton
	#tag Event
		Sub Action()
		  Self.CLose
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeployingCancelButton
	#tag Event
		Sub Action()
		  Dim AnyFinished As Boolean
		  
		  For Each DeploymentEngine As Beacon.DeploymentEngine In Self.mDeploymentEngines
		    If DeploymentEngine.Finished Then
		      AnyFinished = True
		    End If
		    DeploymentEngine.Cancel
		  Next
		  
		  If AnyFinished Then
		    Self.ShowResults()
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Auth
	#tag Event
		Sub Authenticated()
		  Self.mDocument.OAuthData(Self.mCurrentProvider) = Me.AuthData
		  Self.AuthenticateNext()
		End Sub
	#tag EndEvent
	#tag Event
		Sub AuthenticationError()
		  Self.ShowAlert("Authorization failed", "The server provider " + Self.mCurrentProvider + " may be down at the moment, or there could be other problems.")
		  Self.Pages.Value = Self.PageServerSelection
		End Sub
	#tag EndEvent
	#tag Event
		Function ShowURL(URL As Text) As Beacon.WebView
		  Return MiniBrowser.ShowURL(URL)
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events DeployingWatchTimer
	#tag Event
		Sub Action()
		  Dim Finished As Boolean = True
		  For Each DeploymentEngine As Beacon.DeploymentEngine In Self.mDeploymentEngines
		    Finished = Finished And DeploymentEngine.Finished
		  Next
		  
		  If Finished Then
		    Dim BackupsFolder As FolderItem = App.ApplicationSupport.Child("Backups")
		    If Not BackupsFolder.Exists Then
		      BackupsFolder.CreateAsFolder
		    End If
		    
		    For Each Engine As Beacon.DeploymentEngine In Self.mDeploymentEngines
		      If Not Self.Backup(Engine, BackupsFolder) Then
		        LocalData.SharedInstance.SaveNotification(New Beacon.UserNotification("Beacon was unable to create a backup of your ini files for server " + Engine.Name + ", deploy label " + Self.mDeployLabel.ToText + "."))
		      End If
		    Next
		    
		    Self.ShowResults()
		    Me.Mode = Timer.ModeOff
		  Else
		    For I As Integer = 0 To Self.DeployingList.ListCount - 1
		      Dim DeploymentEngine As Beacon.DeploymentEngine = Self.DeployingList.RowTag(I)
		      Self.DeployingList.Cell(I, 0) = DeploymentEngine.Name + EndOfLine + DeploymentEngine.Status
		    Next
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
