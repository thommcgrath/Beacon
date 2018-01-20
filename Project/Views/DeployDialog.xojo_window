#tag Window
Begin Window DeployDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   234
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   3200
   MaximizeButton  =   False
   MaxWidth        =   3200
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   234
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   1
   Resizeable      =   True
   Title           =   "Publish"
   Visible         =   True
   Width           =   600
   Begin PagePanel Pages
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   234
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
      TabStop         =   True
      Top             =   0
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedPushButton IntroCancelButton
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
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   194
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton IntroActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   194
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin RadioButton PublishChoiceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Choose a Game.ini file on my computer for Beacon to update"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   1
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   162
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin RadioButton PublishChoiceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Save a new Game.ini to my computer"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   0
         InitialParent   =   "Pages"
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
         Top             =   130
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label IntroMessageLabel
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
         Text            =   "How would you like to deploy your Game.ini?"
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
      Begin Label CredentialsMessageLabel
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
         Text            =   "Deployment Servers"
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
      Begin BeaconListbox CredentialsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   ""
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
         Height          =   130
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   "Description	Host	Path"
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
         SelectionType   =   1
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   453
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton AddServerButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Add Server"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   485
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         Visible         =   True
         Width           =   95
      End
      Begin UITweaks.ResizedPushButton EditServerButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Edit"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   485
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Underline       =   False
         Visible         =   True
         Width           =   95
      End
      Begin UITweaks.ResizedPushButton DeleteServerButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   485
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   116
         Underline       =   False
         Visible         =   True
         Width           =   95
      End
      Begin UITweaks.ResizedPushButton CredentialsActionButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   194
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton CredentialsCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Back"
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
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   194
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label DownloadingMessageLabel
         AutoDeactivate  =   True
         Bold            =   False
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
         Text            =   "Downloading required files..."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   91
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label WaitingMessageLabel
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
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Time to stop your servers"
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
      Begin UITweaks.ResizedPushButton WaitingActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Deploy"
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
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   194
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton WaitingCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Back"
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
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   194
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label WaitingExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   130
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
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Your current config files have been downloaded. Stop your servers and wait 5 minutes before pressing the deploy button. Ark gives players on the server a notice before actually stopping. If you deploy before Ark has fully stopped, your changes will usually get reset. So really, you should wait. Go get a coffee or something.\n\nUsers on Nitrado servers should also ensure that Expert Mode is enabled in your control panel. Without this, Nitrado seems to truncate large config files."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label UploadingMessageLabel
         AutoDeactivate  =   True
         Bold            =   False
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
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Deploying changes..."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   91
         Transparent     =   True
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
         TabPanelIndex   =   6
         TabStop         =   True
         Text            =   "All files deployed successfully!"
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
      Begin UITweaks.ResizedPushButton FinishedActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Done"
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
         TabIndex        =   2
         TabPanelIndex   =   6
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   194
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label FinishedExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   130
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
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   6
         TabStop         =   True
         Text            =   "Go ahead and start your servers back up. Unless you have more work to do."
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar DownloadingBar
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabStop         =   True
         Top             =   123
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar UploadingBar
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         Top             =   123
         Value           =   0
         Visible         =   True
         Width           =   560
      End
      Begin RadioButton PublishChoiceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Let Beacon update the Game.ini on my servers"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   2
         InitialParent   =   "Pages"
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
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   560
      End
      Begin Label PrivacyNotice
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   34
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "This feature requires FTP access. Your FTP credentials will be securely submitted to Beacon's server. They will not be saved, monitored, or logged in any way."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   520
      End
   End
   Begin BeaconAPI.Socket APISocket
      Enabled         =   True
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
		  If Self.mTempFolder <> Nil And Self.mTempFolder.Exists Then
		    For I As Integer = Self.mTempFolder.Count DownTo 1
		      Self.mTempFolder.Item(I).Delete
		    Next
		    Self.mTempFolder.Delete
		    Self.mTempFolder = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.SwapButtons()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_FTPDownload(Success As Boolean, Message As Text, Details As Auto)
		  Self.mDownloadSuccess = Self.mDownloadSuccess And Success
		  
		  If Success Then
		    If Self.mTempFolder = Nil Then
		      Self.mTempFolder = SpecialFolder.Temporary.Child(Beacon.CreateUUID)
		      Self.mTempFolder.CreateAsFolder
		    End If
		    
		    Dim Dict As Xojo.Core.Dictionary = Details
		    Dim Ref As Text = Dict.Value("ref")
		    Dim Content As Text = Dict.Value("content")
		    Dim File As FolderItem = Self.mTempFolder.Child(Ref + ".ini")
		    
		    Dim Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(Content)
		    Stream.Close
		    
		    Self.UpdateFile(File)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_FTPUpload(Success As Boolean, Message As Text, Details As Auto)
		  #Pragma Unused Message
		  #Pragma Unused Details
		  
		  Self.mUploadSuccess = Self.mUploadSuccess And Success
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As Window, Document As Beacon.Document)
		  Parent = Parent.TrueWindow
		  
		  If Not Document.IsValid Then
		    Beep
		    ResolveIssuesDialog.Present(Parent, Document)
		    If Not Document.IsValid Then
		      Return
		    End If
		  End If
		  
		  If Document.BeaconCount = 0 Then
		    Dim Warning As New MessageDialog
		    Warning.Title = ""
		    Warning.Message = "No loot sources to export"
		    Warning.Explanation = "Beacon cannot export anything from this document because it contains no loot sources for either environment."
		    Call Warning.ShowModalWithin(Parent)
		    Return
		  End If
		  
		  Dim Win As New DeployDialog
		  Win.mDocument = Document
		  Win.mParentWindow = Parent
		  Win.ShowModalWithin(Parent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Dim DownloadingContentHeight As Integer = Self.DownloadingMessageLabel.Height + 12 + Self.DownloadingBar.Height
		  Dim DownloadingContentTop As Integer = (Self.Height - DownloadingContentHeight) / 2
		  Self.DownloadingMessageLabel.Top = DownloadingContentTop
		  Self.DownloadingBar.Top = DownloadingContentTop + Self.DownloadingMessageLabel.Height + 12
		  
		  Self.UploadingMessageLabel.Top = Self.DownloadingMessageLabel.Top
		  Self.UploadingBar.Top = Self.DownloadingBar.Top
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCredentialsList(ForceSelect As Beacon.FTPProfile = Nil)
		  Dim SelectedHashes() As Text
		  For I As Integer = 0 To CredentialsList.ListCount - 1
		    If Not CredentialsList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Profile As Beacon.FTPProfile = CredentialsList.RowTag(I)
		    SelectedHashes.Append(Profile.Hash)
		  Next
		  
		  CredentialsList.DeleteAllRows
		  
		  For I As Integer = 0 To Self.mDocument.FTPProfileCount - 1
		    Dim Profile As Beacon.FTPProfile = Self.mDocument.FTPProfile(I)
		    If Profile = Nil Then
		      Continue
		    End If
		    
		    CredentialsList.AddRow(Profile.Description, Profile.DescriptiveHost, Profile.GameIniPath)
		    CredentialsList.RowTag(CredentialsList.LastIndex) = Profile
		    CredentialsList.Selected(CredentialsList.LastIndex) = Profile = ForceSelect Or SelectedHashes.IndexOf(Profile.Hash) > -1
		  Next
		  
		  CredentialsActionButton.Enabled = CredentialsList.ListCount > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFile(File As FolderItem)
		  Dim OriginalContent As String
		  Dim EOL As String = Chr(13) + Chr(10)
		  
		  If File.Exists Then
		    Dim InStream As TextInputStream = TextInputStream.Open(File)
		    OriginalContent = ReplaceLineEndings(InStream.ReadAll(Encodings.UTF8), EOL)
		    InStream.Close
		  End If
		  
		  Dim Lines() As String = OriginalContent.Split(EOL)
		  For I As Integer = Lines.Ubound DownTo 0
		    If Lines(I).Left(31) = "ConfigOverrideSupplyCrateItems=" Then
		      Lines.Remove(I)
		    End If
		  Next
		  
		  Dim CurrentSection As String = ""
		  Dim Sections As New Dictionary
		  
		  For Each Line As String In Lines
		    Line = Line.Trim
		    If Line.Len = 0 Then
		      Continue
		    End If
		    
		    If Line.Len > 2 And Line.Left(1) = "[" And Line.Right(1) = "]" Then
		      CurrentSection = Line.Mid(2, Line.Len - 2)
		      Continue
		    End If
		    
		    Dim SectionLines() As String
		    If Sections.HasKey(CurrentSection) Then
		      SectionLines = Sections.Value(CurrentSection)
		    End If
		    
		    SectionLines.Append(Line)
		    Sections.Value(CurrentSection) = SectionLines
		  Next
		  
		  Dim LootLines() As String
		  If Sections.HasKey("/script/shootergame.shootergamemode") Then
		    LootLines = Sections.Value("/script/shootergame.shootergamemode")
		  End If
		  Dim LootSources() As Beacon.LootSource = Self.mDocument.LootSources
		  For Each LootSource As Beacon.LootSource In LootSources
		    If Self.mDocument.SupportsLootSource(LootSource) Then
		      LootLines.Append("ConfigOverrideSupplyCrateItems=" + LootSource.TextValue(Self.mDocument.DifficultyValue))
		    End If
		  Next
		  Sections.Value("/script/shootergame.shootergamemode") = LootLines
		  
		  Dim Chunks() As String
		  Dim Keys() As Variant = Sections.Keys
		  For Each Key As Variant In Keys
		    Dim Header As String = "[" + Key.StringValue + "]"
		    Dim SectionLines() As String = Sections.Value(Key)
		    Chunks.Append(Header + EOL + Join(SectionLines, EOL).Trim)
		  Next
		  
		  Dim UpdatedContent As String = Join(Chunks, EOL + EOL).Trim + EOL
		  
		  Dim OutStream As TextOutputStream = TextOutputStream.Create(File)
		  OutStream.Write(UpdatedContent)
		  OutStream.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadSuccess As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParentWindow As Window
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadSuccess As Boolean
	#tag EndProperty


	#tag Constant, Name = PageCredentials, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDownloading, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageFinished, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageIntro, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageUploading, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageWaiting, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events IntroCancelButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroActionButton
	#tag Event
		Sub Action()
		  If PublishChoiceRadio(0).Value Then
		    // Create
		    Self.Hide
		    
		    Dim Dialog As New SaveAsDialog
		    Dialog.SuggestedFileName = "Game.ini"
		    Dialog.Filter = BeaconFileTypes.IniFile
		    
		    Dim File As FolderItem = Dialog.ShowModalWithin(Self.mParentWindow)
		    If File = Nil Then
		      Self.ShowModalWithin(Self.mParentWindow)
		      Return
		    End If
		    
		    Self.UpdateFile(File)
		    Self.Close
		  ElseIf PublishChoiceRadio(1).Value Then
		    // Update
		    Self.Hide
		    
		    Dim Dialog As New OpenDialog
		    Dialog.SuggestedFileName = "Game.ini"
		    Dialog.Filter = BeaconFileTypes.IniFile
		    
		    Dim File As FolderItem = Dialog.ShowModalWithin(Self.mParentWindow)
		    If File = Nil Then
		      Self.ShowModalWithin(Self.mParentWindow)
		      Return
		    End If
		    
		    Self.UpdateFile(File)
		    Self.Close
		  ElseIf PublishChoiceRadio(2).Value Then
		    // FTP
		    
		    Self.UpdateCredentialsList()
		    Self.Pages.Value = Self.PageCredentials
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PublishChoiceRadio
	#tag Event
		Sub Action(index as Integer)
		  IntroActionButton.Enabled = PublishChoiceRadio(0).Value Or PublishChoiceRadio(1).Value Or PublishChoiceRadio(2).Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CredentialsList
	#tag Event
		Sub Change()
		  EditServerButton.Enabled = Me.SelCount = 1
		  DeleteServerButton.Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddServerButton
	#tag Event
		Sub Action()
		  Dim Profile As Beacon.FTPProfile = FTPProfileDialog.Present()
		  If Profile <> Nil Then
		    Self.mDocument.AddFTPProfile(Profile)
		    Self.UpdateCredentialsList(Profile)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditServerButton
	#tag Event
		Sub Action()
		  Dim Profile As Beacon.FTPProfile = CredentialsList.RowTag(CredentialsList.ListIndex)
		  If Profile = Nil Then
		    Return
		  End If
		  
		  Dim NewProfile As Beacon.FTPProfile = FTPProfileDialog.Present(Profile)
		  If NewProfile <> Nil Then
		    Self.mDocument.RemoveFTPProfile(Profile)
		    Self.mDocument.AddFTPProfile(NewProfile)
		    Self.UpdateCredentialsList(NewProfile)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeleteServerButton
	#tag Event
		Sub Action()
		  For I As Integer = 0 To CredentialsList.ListCount - 1
		    Dim Profile As Beacon.FTPProfile = CredentialsList.RowTag(I)
		    If Profile = Nil Then
		      Continue
		    End If
		    
		    Self.mDocument.RemoveFTPProfile(Profile)
		  Next
		  
		  Self.UpdateCredentialsList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CredentialsActionButton
	#tag Event
		Sub Action()
		  Self.mDownloadSuccess = True
		  Self.Pages.Value = Self.PageDownloading
		  
		  For I As Integer = 0 To CredentialsList.ListCount - 1
		    Dim Profile As Beacon.FTPProfile = CredentialsList.RowTag(I)
		    If Profile = Nil Then
		      Continue
		    End If
		    
		    Dim Request As New BeaconAPI.Request("ftp.php" + Profile.GameIniURL + "&ref=" + Profile.Hash, "GET", WeakAddressOf APICallback_FTPDownload)
		    Request.Sign(App.Identity)
		    Self.APISocket.Start(Request)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CredentialsCancelButton
	#tag Event
		Sub Action()
		  Self.Pages.Value = Self.PageIntro
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WaitingActionButton
	#tag Event
		Sub Action()
		  Self.mUploadSuccess = True
		  Self.Pages.Value = Self.PageUploading
		  
		  For I As Integer = 0 To CredentialsList.ListCount - 1
		    Dim Profile As Beacon.FTPProfile = CredentialsList.RowTag(I)
		    If Profile = Nil Then
		      Continue
		    End If
		    
		    Dim Hash As Text = Profile.Hash
		    Dim File As FolderItem = Self.mTempFolder.Child(Hash + ".ini")
		    If Not File.Exists Then
		      Continue
		    End If
		    
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Dim Request As New BeaconAPI.Request("ftp.php" + Profile.GameIniURL + "&ref=" + Profile.Hash, "POST", Content.ToText, "text/plain", WeakAddressOf APICallback_FTPUpload)
		    Request.Sign(App.Identity)
		    Self.APISocket.Start(Request)
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WaitingCancelButton
	#tag Event
		Sub Action()
		  Self.Pages.Value = Self.PageCredentials
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
#tag Events APISocket
	#tag Event
		Sub WorkCompleted()
		  Select Case Self.Pages.Value
		  Case Self.PageDownloading
		    If Self.mDownloadSuccess Then
		      Self.Pages.Value = Self.PageWaiting
		    Else
		      Self.ShowAlert("Unable to download all files", "Check the details for each deployment server. When editing a server, use the ""Test"" button to try a download.")
		      Self.Pages.Value = Self.PageCredentials
		    End If
		    
		    Return
		  Case Self.PageUploading
		    If Self.mUploadSuccess Then
		      Self.Pages.Value = Self.PageFinished
		    Else
		      Self.ShowAlert("Unable to upload all files", "Check your servers. Not all files deployed. Since all were downloaded, some files may be read-only.")
		      Self.Pages.Value = Self.PageWaiting
		    End If
		  End Select
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
		Visible=true
		Group="Deprecated"
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
