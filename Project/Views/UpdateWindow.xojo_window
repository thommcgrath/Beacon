#tag Window
Begin BeaconWindow UpdateWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   True
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   132
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   132
   MinimizeButton  =   True
   MinWidth        =   600
   Placement       =   3
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Beacon Updates"
   Visible         =   True
   Width           =   600
   Begin PagePanel ViewPanel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   132
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
      Top             =   0
      Transparent     =   False
      Value           =   "0"
      Visible         =   True
      Width           =   600
      Begin Label CheckMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         Text            =   "Check for Beacon updates…"
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
      Begin ProgressBar CheckProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         Top             =   52
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton CheckCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
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
         Visible         =   True
         Width           =   80
      End
      Begin ControlCanvas ResultsIconCanvas
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   64
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   20
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   64
      End
      Begin Label ResultsMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   96
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
         Text            =   "A new version of Beacon is available!"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   484
      End
      Begin UITweaks.ResizedPushButton ResultsActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Download"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   490
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   92
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin UITweaks.ResizedPushButton ResultsCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   388
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   92
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin Label DownloadMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Downloading update…"
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
      Begin ProgressBar DownloadProgressBar
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         Top             =   52
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton DownloadCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ResultsNotesButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Release Notes"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   96
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   92
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin Label Label1
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   96
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "After downloading, the update will install only when you're ready."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   484
      End
   End
   Begin UpdateChecker Checker
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection Downloader
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Self.mInstance = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub LaunchUpdate()
		  Self.mFile.Open
		  Self.Close
		  Quit
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present()
		  // Will check for updates
		  
		  If mInstance = Nil Then
		    mInstance = New UpdateWindow
		  End If
		  
		  mInstance.ViewPanel.SelectedPanelIndex = UpdateWindow.ViewCheck
		  mInstance.Show
		  mInstance.Checker.Check(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowResults(Version As String, NotesURL As String, URL As String, Signature As String)
		  Self.mURL = URL
		  Self.mSignature = Signature
		  Self.mNotesURL = NotesURL
		  Self.ResultsNotesButton.Enabled = NotesURL.BeginsWith("https://")
		  
		  Var PathComponents() As String = FrameworkExtensions.FieldAtPosition(URL, "?", 1).Split("/")
		  Var Filename As String = FrameworkExtensions.FieldAtPosition(PathComponents(PathComponents.LastIndex), "#", 1)
		  Var FilenameParts() As String = Filename.Split(".")
		  Var Extension As String = FilenameParts(FilenameParts.LastIndex)
		  
		  Self.mFilename = "Beacon " + Version + "." + Extension
		  
		  #if Not TargetMacOS
		    Var Folder As FolderItem = App.ApplicationSupport.Child("Updates")
		    If Not Folder.Exists Then
		      Folder.CreateFolder
		    End If
		    Self.mFile = Folder.Child(Self.mFilename)
		  #endif
		  
		  Self.ViewPanel.SelectedPanelIndex = Self.ViewResults
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFilename As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As UpdateWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotesURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As String
	#tag EndProperty


	#tag Constant, Name = HeightCheck, Type = Double, Dynamic = False, Default = \"124", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightDownload, Type = Double, Dynamic = False, Default = \"124", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightResults, Type = Double, Dynamic = False, Default = \"132", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ViewCheck, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ViewDownload, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ViewResults, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ViewPanel
	#tag Event
		Sub Change()
		  Select Case Me.SelectedPanelIndex
		  Case Self.ViewCheck
		    Self.Height = Self.HeightCheck
		    Self.Resizeable = False
		  Case Self.ViewResults
		    Self.Height = Self.HeightResults
		    Self.Resizeable = True
		  Case Self.ViewDownload
		    Self.Height = Self.HeightDownload
		    Self.Resizeable = False
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckCancelButton
	#tag Event
		Sub Action()
		  Self.Checker.Cancel
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsIconCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect, Highlighted As Boolean)
		  #Pragma Unused areas
		  #Pragma Unused Highlighted
		  
		  G.DrawPicture(IconApp, 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsActionButton
	#tag Event
		Sub Action()
		  If Self.mFile = Nil Then
		    Var Dialog As New SaveFileDialog
		    Dialog.SuggestedFileName = Self.mFilename
		    Dialog.PromptText = "Choose a location for the update file"
		    
		    Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		    If File = Nil Then
		      Return
		    End If
		    
		    Self.mFile = File
		  End If
		  
		  If Self.mFile.Exists Then
		    If UpdateChecker.VerifyFile(Self.mFile, Self.mSignature) Then
		      Self.LaunchUpdate()
		      Return
		    Else
		      Self.mFile.Remove
		    End If
		  End If
		  
		  Self.Downloader.Send("GET", Self.mURL)
		  Self.DownloadProgressBar.MaximumValue = 0
		  Self.ViewPanel.SelectedPanelIndex = Self.ViewDownload
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsCancelButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DownloadCancelButton
	#tag Event
		Sub Action()
		  Self.Downloader.Disconnect
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsNotesButton
	#tag Event
		Sub Action()
		  ShowURL(Self.mNotesURL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Checker
	#tag Event
		Sub CheckError(Message As String)
		  #Pragma Unused Message
		  
		  Var Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to check for updates."
		  Dialog.Explanation = "Uh oh, something seems to be wrong. Please report this problem so it can be fixed as soon as possible."
		  Dialog.ActionButton.Caption = "Report Now"
		  Dialog.CancelButton.Visible = True
		  
		  Var Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  If Choice = Dialog.ActionButton Then
		    App.ShowBugReporter()
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub NoUpdate()
		  Var Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "You are using the latest version."
		  Dialog.Explanation = "Beacon automatically checks for updates on each launch so you won't miss a release."
		  
		  Call Dialog.ShowModalWithin(Self)
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpdateAvailable(Version As String, PreviewText As String, Notes As String, NotesURL As String, URL As String, Signature As String)
		  #Pragma Unused PreviewText
		  #Pragma Unused Notes
		  
		  Self.ShowResults(Version, NotesURL, URL, Signature)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Downloader
	#tag Event
		Sub Error(e As RuntimeException)
		  Me.Disconnect
		  
		  Var Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to Download Update"
		  Dialog.Explanation = e.Reason
		  Call Dialog.ShowModalWithin(Self)
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub HeadersReceived(URL As String, HTTPStatus As Integer)
		  If HTTPStatus <> 200 Then
		    Me.Disconnect
		    
		    Var Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Unable to Download Update"
		    Dialog.Explanation = "The address " + URL + " could not be found."
		    Call Dialog.ShowModalWithin(Self)
		    
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ReceivingProgressed(bytesReceived As Int64, totalBytes As Int64, newData As String)
		  #Pragma Unused NewData
		  
		  If Self.DownloadProgressBar.MaximumValue <> 1000 Then
		    Self.DownloadProgressBar.MaximumValue = 1000
		  End If
		  Self.DownloadProgressBar.Value = (BytesReceived / TotalBytes) * Self.DownloadProgressBar.MaximumValue
		End Sub
	#tag EndEvent
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  #Pragma Unused HTTPStatus
		  
		  If Self.mFile.Write(Content) = False Then
		    Self.ShowAlert("There was an error saving the new version.", "Attempted to save the new version to " + Self.mFile.NativePath)
		    Self.Close
		    Return
		  End If
		  
		  If UpdateChecker.VerifyFile(Self.mFile, Self.mSignature) Then
		    Self.Hide
		    
		    Var Confirm As New MessageDialog
		    Confirm.Title = ""
		    Confirm.Message = "Beacon is ready to update."
		    Confirm.Explanation = "Choose ""Install Now"" to quit Beacon and start the update. If you aren't ready to update now, choose ""Install On Quit"" to start the update when you're done, or ""Show Archive"" to install the update yourself."
		    Confirm.ActionButton.Caption = "Install Now"
		    Confirm.CancelButton.Caption = "Install On Quit"
		    Confirm.CancelButton.Visible = True
		    #if Not TargetMacOS
		      Confirm.AlternateActionButton.Caption = "Show Archive"
		      Confirm.AlternateActionButton.Visible = True
		    #endif
		    
		    Var Selection As MessageDialogButton = Confirm.ShowModal
		    Select Case Selection
		    Case Confirm.ActionButton
		      Self.LaunchUpdate()
		    Case Confirm.CancelButton
		      App.LaunchOnQuit = Self.mFile
		      Self.Close
		    Case Confirm.AlternateActionButton
		      Self.mFile.Parent.Open
		      Self.Close
		    End Select
		    Return
		  End If
		  
		  Self.mFile.Remove
		  Self.mFile = Nil
		  
		  Var Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to Download Update"
		  Dialog.Explanation = "The file was downloaded, but the integrity check did not match. Please report this problem."
		  Dialog.ActionButton.Caption = "Report Now"
		  Dialog.CancelButton.Visible = True
		  
		  Var Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  If Choice = Dialog.ActionButton Then
		    App.ShowBugReporter()
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
