#tag Window
Begin BeaconWindow UpdateWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   True
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   True
   MinWidth        =   600
   Placement       =   2
   Resizeable      =   True
   Title           =   "Beacon Updates"
   Visible         =   True
   Width           =   600
   Begin PagePanel ViewPanel
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
      Top             =   0
      Value           =   1
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
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton CheckCancelButton
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
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ControlCanvas ResultsIconCanvas
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   True
         Enabled         =   True
         EraseBackground =   False
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
      Begin HTMLViewer ResultsNotesViewer
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   294
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   97
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Renderer        =   1
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   53
         Visible         =   True
         Width           =   482
      End
      Begin UITweaks.ResizedPushButton ResultsActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Download"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
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
         Top             =   360
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ResultsCancelButton
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
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   408
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
         Top             =   360
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Canvas Borders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   True
         Enabled         =   True
         EraseBackground =   False
         Height          =   1
         HelpTag         =   ""
         Index           =   0
         InitialParent   =   "ViewPanel"
         Left            =   96
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   52
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   484
      End
      Begin Canvas Borders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   True
         Enabled         =   True
         EraseBackground =   False
         Height          =   1
         HelpTag         =   ""
         Index           =   1
         InitialParent   =   "ViewPanel"
         Left            =   96
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   347
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   484
      End
      Begin Canvas Borders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   True
         Enabled         =   True
         EraseBackground =   False
         Height          =   294
         HelpTag         =   ""
         Index           =   3
         InitialParent   =   "ViewPanel"
         Left            =   579
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   52
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   1
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
      Begin Canvas Borders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   True
         Enabled         =   True
         EraseBackground =   False
         Height          =   294
         HelpTag         =   ""
         Index           =   2
         InitialParent   =   "ViewPanel"
         Left            =   96
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   53
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   1
      End
      Begin ProgressBar DownloadProgressBar
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton DownloadCancelButton
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
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin UpdateChecker Checker
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Xojo.Net.HTTPSocket Downloader
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
      ValidateCertificates=   False
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
		  Self.mFile.Launch
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
		  
		  mInstance.ViewPanel.Value = UpdateWindow.ViewCheck
		  mInstance.Show
		  mInstance.Checker.Check(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Version As String, Notes As String, URL As String, Signature As String)
		  // Will show the results of an update check
		  
		  If mInstance = Nil Then
		    mInstance = New UpdateWindow
		  End If
		  
		  mInstance.ShowResults(Version, Notes, URL, Signature)
		  mInstance.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowResults(Version As String, Notes As String, URL As String, Signature As String)
		  #Pragma Unused Version
		  
		  Static Temp As FolderItem = GetTemporaryFolderItem
		  ResultsNotesViewer.LoadPage(Notes, Temp)
		  
		  Self.mURL = URL
		  Self.mSignature = Signature
		  
		  Dim PathComponents() As String = Split(NthField(URL, "?", 1), "/")
		  Dim Filename As String = NthField(PathComponents(UBound(PathComponents)), "#", 1)
		  Dim FilenameParts() As String = Split(Filename, ".")
		  Dim Extension As String = FilenameParts(UBound(FilenameParts))
		  
		  Dim Folder As FolderItem = App.ApplicationSupport.Child("Updates")
		  If Not Folder.Exists Then
		    Folder.CreateAsFolder
		  End If
		  Self.mFile = Folder.Child("Beacon " + Version + "." + Extension)
		  
		  Self.ViewPanel.Value = Self.ViewResults
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As UpdateWindow
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

	#tag Constant, Name = HeightResults, Type = Double, Dynamic = False, Default = \"400", Scope = Private
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
		  Select Case Me.Value
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
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.DrawPicture(IconApp, 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsActionButton
	#tag Event
		Sub Action()
		  If Self.mFile.Exists Then
		    If UpdateChecker.VerifyFile(Self.mFile, Self.mSignature) Then
		      Self.LaunchUpdate()
		      Return
		    Else
		      Self.mFile.Delete
		    End If
		  End If
		  
		  Self.Downloader.Send("GET", Self.mURL.ToText)
		  Self.DownloadProgressBar.Maximum = 0
		  Self.ViewPanel.Value = Self.ViewDownload
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsCancelButton
	#tag Event
		Sub Action()
		  Self.Close
		  
		  If App.Preferences.BooleanValue("Has Shown Subscribe Dialog") = False Then
		    SubscribeDialog.Present()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Borders
	#tag Event
		Sub Paint(index as Integer, g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = &cCCCCCC
		  G.FillRect(0, 0, G.Width, G.Height)
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
#tag Events Checker
	#tag Event
		Sub CheckError(Message As String)
		  #Pragma Unused Message
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to check for updates."
		  Dialog.Explanation = "Uh oh, something seems to be wrong. Please report this problem so it can be fixed as soon as possible."
		  Dialog.ActionButton.Caption = "Report Now"
		  Dialog.CancelButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  If Choice = Dialog.ActionButton Then
		    Beacon.ReportAProblem()
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub NoUpdate()
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "You are using the latest version."
		  Dialog.Explanation = "That's good news, unless you're having a problem. If you are, please report the problem."
		  Dialog.ActionButton.Caption = "Report Now"
		  Dialog.CancelButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  If Choice = Dialog.ActionButton Then
		    Beacon.ReportAProblem()
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub UpdateAvailable(Version As String, Notes As String, URL As String, Signature As String)
		  Self.ShowResults(Version, Notes, URL, Signature)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Downloader
	#tag Event
		Sub Error(err as RuntimeException)
		  Me.Disconnect
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to Download Update"
		  Dialog.Explanation = Err.Reason
		  Call Dialog.ShowModalWithin(Self)
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub HeadersReceived(URL as Text, HTTPStatus as Integer)
		  If HTTPStatus <> 200 Then
		    Me.Disconnect
		    
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Unable to Download Update"
		    Dialog.Explanation = "The address " + URL + " could not be found."
		    Call Dialog.ShowModalWithin(Self)
		    
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ReceiveProgress(BytesReceived as Int64, TotalBytes as Int64, NewData as xojo.Core.MemoryBlock)
		  #Pragma Unused NewData
		  
		  If Self.DownloadProgressBar.Maximum <> 1000 Then
		    Self.DownloadProgressBar.Maximum = 1000
		  End If
		  Self.DownloadProgressBar.Value = (BytesReceived / TotalBytes) * Self.DownloadProgressBar.Maximum
		End Sub
	#tag EndEvent
	#tag Event
		Sub PageReceived(URL as Text, HTTPStatus as Integer, Content as xojo.Core.MemoryBlock)
		  #Pragma Unused URL
		  #Pragma Unused HTTPStatus
		  
		  Dim Stream As BinaryStream = BinaryStream.Create(Self.mFile, True)
		  For I As Integer = 0 To Content.Size - 1
		    Stream.WriteUInt8(Content.UInt8Value(I))
		  Next
		  Stream.Close
		  
		  If UpdateChecker.VerifyFile(Self.mFile, Self.mSignature) Then
		    Self.Hide
		    
		    Dim Confirm As New MessageDialog
		    Confirm.Title = ""
		    Confirm.Message = "Beacon is ready to update."
		    Confirm.Explanation = "Choose ""Install Now"" to quit Beacon and start the update. If you aren't ready to update now, choose ""Install On Quit"" to start the update when you're done, or ""Show Archive"" to install the update yourself."
		    Confirm.ActionButton.Caption = "Install Now"
		    Confirm.CancelButton.Caption = "Install On Quit"
		    Confirm.AlternateActionButton.Caption = "Show Archive"
		    Confirm.CancelButton.Visible = True
		    Confirm.AlternateActionButton.Visible = True
		    
		    Dim Selection As MessageDialogButton = Confirm.ShowModal
		    Select Case Selection
		    Case Confirm.ActionButton
		      Self.LaunchUpdate()
		    Case Confirm.CancelButton
		      App.LaunchOnQuit = Self.mFile
		      Self.Close
		    Case Confirm.AlternateActionButton
		      Self.mFile.Parent.Launch
		      Self.Close
		    End Select
		    Return
		  End If
		  
		  Self.mFile.Delete
		  Self.mFile = Nil
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to Download Update"
		  Dialog.Explanation = "The file was downloaded, but the integrity check did not match. Please report this problem."
		  Dialog.ActionButton.Caption = "Report Now"
		  Dialog.CancelButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		  If Choice = Dialog.ActionButton Then
		    Beacon.ReportAProblem()
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
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
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
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
		InitialValue="400"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
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
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
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
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
