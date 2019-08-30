#tag Window
Begin BeaconDialog DocumentDeployWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   DefaultLocation =   "1"
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinimumHeight   =   400
   MinimumWidth    =   600
   MinWidth        =   600
   Placement       =   1
   Resizable       =   True
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Deploy"
   Type            =   "0"
   Visible         =   True
   Width           =   600
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
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
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin Label ServerSelectionMessageLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Value           =   "Select Deployment Servers"
         Visible         =   True
         Width           =   560
      End
      Begin BeaconListbox ServerSelectionList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
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
         DropIndicatorVisible=   False
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontal=   "0"
         GridLinesHorizontalStyle=   "0"
         GridLinesVertical=   "0"
         GridLinesVerticalStyle=   "0"
         HasBorder       =   True
         HasHeader       =   False
         HasHeading      =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
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
         RowCount        =   "0"
         RowSelectionType=   "0"
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   "0"
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
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
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Begin"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ServerSelectionCancelButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label DeployingMessageLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Value           =   "Deploying…"
         Visible         =   True
         Width           =   560
      End
      Begin Label FinishedMessageLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Value           =   "Finished!"
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton FinishedButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Done"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox DeployingList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
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
         DropIndicatorVisible=   False
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontal=   "0"
         GridLinesHorizontalStyle=   "0"
         GridLinesVertical=   "0"
         GridLinesVerticalStyle=   "0"
         HasBorder       =   True
         HasHeader       =   False
         HasHeading      =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
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
         RowCount        =   "0"
         RowSelectionType=   "0"
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   "0"
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
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
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   360
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label FinishedReportLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
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
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Tooltip         =   ""
         Top             =   60
         Transparent     =   False
         Underline       =   False
         Value           =   "All servers updated successfully."
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
      Mode            =   "0"
      Period          =   100
      RunMode         =   "0"
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		  
		  Self.ServerSelectionList.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		  
		  For I As Integer = 0 To Self.mDocument.ServerProfileCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.mDocument.ServerProfile(I)
		    
		    Self.ServerSelectionList.AddRow("", Profile.Name, Profile.SecondaryName)
		    Self.ServerSelectionList.RowTagAt(Self.ServerSelectionList.LastAddedRowIndex) = Profile
		    Self.ServerSelectionList.CellCheckBoxValueAt(Self.ServerSelectionList.LastAddedRowIndex, 0) = Profile.Enabled
		  Next
		  Self.ServerSelectionList.Sort
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AuthenticateNext()
		  If Self.mOAuthQueue.LastRowIndex = -1 Then
		    // Move to the next step
		    Self.DeployingList.RemoveAllRows
		    
		    Dim Now As New DateTime(DateTime.Now.SecondsFrom1970, New TimeZone(0))
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
		        DeploymentEngine = New Beacon.FTPDeploymentEngine(Beacon.FTPServerProfile(Profile))
		      Else
		        Continue
		      End Select
		      
		      Self.mDeploymentEngines.Append(DeploymentEngine)
		      Self.DeployingList.AddRow(DeploymentEngine.Name + EndOfLine + DeploymentEngine.Status)
		      Self.DeployingList.RowTagAt(DeployingList.LastAddedRowIndex) = DeploymentEngine
		    Next
		    
		    For Each DeploymentEngine As Beacon.DeploymentEngine In Self.mDeploymentEngines
		      DeploymentEngine.Begin(Self.mDeployLabel, Self.mDocument, App.IdentityManager.CurrentIdentity)
		    Next
		    
		    Self.DeployingWatchTimer.RunMode = Timer.RunModes.Multiple
		    Return
		  End If
		  
		  Dim Provider As String = Self.mOAuthQueue(0)
		  Self.mOAuthQueue.Remove(0)
		  
		  Self.Auth.Provider = Provider
		  If Self.Auth.Provider <> Provider Then
		    Self.ShowAlert("This version of Beacon does not support " + Provider + " servers.", "This probably means an upgrade is available.")
		    Return
		  End If
		  
		  Self.Auth.AuthData = Self.mDocument.OAuthData(Provider)
		  
		  Self.mCurrentProvider = Provider
		  Self.Auth.Authenticate(App.IdentityManager.CurrentIdentity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Backup(Engine As Beacon.DeploymentEngine, Folder As FolderItem) As Boolean
		  // Returning true means the backup either succeeded or should not complete
		  // Returning false means there was an error and the process needs to stop
		  
		  If Engine.Errored Then
		    Return True
		  End If
		  
		  Dim GameIniContent As String = Engine.BackupGameIni.Trim
		  Dim GameUserSettingsIniContent As String = Engine.BackupGameUserSettingsIni.Trim
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
		    Try
		      ServerFolder.CreateAsFolder
		    Catch Err As IOException
		      App.Log("Unable to backup " + Engine.Name + ": Could not create server backup folder " + ServerFolder.NativePath + ": " + Err.Message)
		      Return False
		    End Try
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
		  Try
		    Subfolder.CreateAsFolder
		  Catch Err As IOException
		    App.Log("Unable to backup " + Engine.Name + ": Could not create deployment folder " + Subfolder.NativePath + ": " + Err.Message)
		  End Try
		  
		  Dim BackedUp As Boolean = True
		  If GameIniContent <> "" Then
		    Dim GameIniFile As FolderItem = Subfolder.Child("Game.ini")
		    If GameIniFile = Nil Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + ": Could not get path to Game.ini")
		      BackedUp = False
		    ElseIf GameIniFile.Write(GameIniContent) = False Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + " to " + GameIniFile.NativePath)
		      BackedUp = False
		    End If
		  End If
		  If GameUserSettingsIniContent <> "" Then
		    Dim GameUserSettingsIniFile As FolderItem = Subfolder.Child("GameUserSettings.ini")
		    If GameUserSettingsIniFile = Nil Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + ": Could not get path to GameUserSettings.ini")
		      BackedUp = False
		    ElseIf GameUserSettingsIniFile.Write(GameUserSettingsIniContent) = False Then
		      App.Log("Unable to backup Game.ini for " + Engine.Name + " to " + GameUserSettingsIniFile.NativePath)
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
		  TotalCount = Self.mDeploymentEngines.LastRowIndex + 1
		  
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
		  
		  Self.FinishedReportLabel.Value = Join(Report, EndOfLine)
		  
		  Self.Pages.SelectedPanelIndex = Self.PageFinished
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentProvider As String
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
		Private mOAuthQueue() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthWindow As OAuthAuthorizationWindow
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
		    Beacon.ServerProfile(Me.RowTagAt(Row)).Enabled = Me.CellCheckBoxValueAt(Row, Column)
		  End If
		  
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.CellCheckBoxValueAt(I, 0) Then
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
		Sub Pressed()
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
		  
		  Self.Pages.SelectedPanelIndex = Self.PageDeploying
		  
		  For I As Integer = 0 To Self.mDocument.ServerProfileCount - 1
		    Dim Profile As Beacon.ServerProfile = Self.mDocument.ServerProfile(I)
		    If Not Profile.Enabled Then
		      Continue
		    End If
		    
		    Dim Provider As String = Profile.OAuthProvider
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
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FinishedButton
	#tag Event
		Sub Pressed()
		  Self.CLose
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeployingCancelButton
	#tag Event
		Sub Pressed()
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
		  Self.Pages.SelectedPanelIndex = Self.PageServerSelection
		End Sub
	#tag EndEvent
	#tag Event
		Function StartAuthentication(URL As String, Provider As String) As Boolean
		  If Not Self.ShowConfirm("You must reauthorize " + Provider + " to allow Beacon to access your servers.", "The authorization tokens expires. If it has been a while since you've deployed, this can happen.", "Continue", "Cancel") Then
		    Return False
		  End If
		  
		  ShowURL(URL)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub DismissWaitingWindow()
		  If Self.mOAuthWindow <> Nil Then
		    Self.mOAuthWindow.Close
		    Self.mOAuthWindow = Nil
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShowWaitingWindow()
		  Self.mOAuthWindow = New OAuthAuthorizationWindow(Me)
		  Self.mOAuthWindow.Show()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeployingWatchTimer
	#tag Event
		Sub Run()
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
		        LocalData.SharedInstance.SaveNotification(New Beacon.UserNotification("Beacon was unable to create a backup of your ini files for server " + Engine.Name + ", deploy label " + Self.mDeployLabel + "."))
		      End If
		    Next
		    
		    Self.ShowResults()
		    Me.RunMode = Timer.RunModes.Off
		  Else
		    For I As Integer = 0 To Self.DeployingList.RowCount - 1
		      Dim DeploymentEngine As Beacon.DeploymentEngine = Self.DeployingList.RowTagAt(I)
		      Self.DeployingList.CellValueAt(I, 0) = DeploymentEngine.Name + EndOfLine + DeploymentEngine.Status
		    Next
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		Name="Resizable"
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
#tag EndViewBehavior
