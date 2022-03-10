#tag DesktopWindow
Begin DesktopWindow EditorWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   True
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   578
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1391144959
   MenuBarVisible  =   True
   MinimumHeight   =   578
   MinimumWidth    =   720
   Resizeable      =   True
   Title           =   "Publisher"
   Type            =   0
   Visible         =   True
   Width           =   720
   Begin URLConnection UploadSocket
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopButton SelectWin32Button
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Select"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   123
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopTextField Win32PathField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   122
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   429
   End
   Begin DesktopLabel Win32PathLabel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Windows 32-bit File:"
      TextAlign       =   3
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   122
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopButton SelectWin64Button
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Select"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   89
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopTextField Win64PathField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   88
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   429
   End
   Begin DesktopLabel Win64PathLabel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Windows 64-bit File:"
      TextAlign       =   3
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   88
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopButton SelectFolderButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Select Installers Folder"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   179
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   258
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   169
   End
   Begin DesktopButton SelectMacButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Select"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton SelectWinComboButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Select"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   55
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel ShortPreviewLabel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Banner Text:"
      TextAlign       =   3
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   224
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopTextField ShortPreviewField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   224
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   521
   End
   Begin DesktopCanvas HorizontalSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   298
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   720
   End
   Begin DesktopButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Begin"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   258
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopTextArea NotesArea
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   False
      Enabled         =   True
      Format          =   ""
      Height          =   279
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   0
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   299
      Transparent     =   True
      Underline       =   False
      UnicodeMode     =   0
      UseFocusRing    =   True
      Visible         =   True
      Width           =   720
   End
   Begin DesktopLabel VersionLabel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Short Version:"
      TextAlign       =   3
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   156
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopTextField VersionField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   156
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   176
   End
   Begin DesktopLabel BuildLabel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Build:"
      TextAlign       =   3
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   190
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopTextField BuildNumberField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   190
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   176
   End
   Begin DesktopTextField WinComboPathField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   429
   End
   Begin DesktopLabel WinComboPathLabel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Windows Combo File:"
      TextAlign       =   3
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopLabel MacPathLabel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Mac File:"
      TextAlign       =   3
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopTextField MacPathField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   429
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Begin()
		  Self.mMacPath = ""
		  Self.mMacSignature = ""
		  Self.mWinComboPath = ""
		  Self.mWinComboSignature = ""
		  Self.mWin64Path = ""
		  Self.mWin64Signature = ""
		  Self.mWin32Path = ""
		  Self.mWin32Signature = ""
		  
		  Self.mUploadQueue = New Dictionary
		  If Self.mMacFile <> Nil And Self.mMacFile.Exists Then
		    Self.mMacPath = EncodeURLComponent(Self.mMacFile.Name)
		    Self.mUploadQueue.Value(Self.mMacPath) = Self.mMacFile
		  End If
		  If Self.mWinComboFile <> Nil And Self.mWinComboFile.Exists Then
		    Self.mWinComboPath = EncodeURLComponent(Self.mWinComboFile.Name)
		    Self.mUploadQueue.Value(Self.mWinComboPath) = Self.mWinComboFile
		  End If
		  If Self.mWin64File <> Nil And Self.mWin64File.Exists Then
		    Self.mWin64Path = "x86_64/" + EncodeURLComponent(Self.mWin64File.Name)
		    Self.mUploadQueue.Value(Self.mWin64Path) = Self.mWin64File
		  End If
		  If Self.mWin32File <> Nil And Self.mWin32File.Exists Then
		    Self.mWin32Path = "x86/" + EncodeURLComponent(Self.mWin32File.Name)
		    Self.mUploadQueue.Value(Self.mWin32Path) = Self.mWin32File
		  End If
		  
		  Self.mProgress = New ProgressSheet
		  Self.mProgress.Show(Self)
		  
		  Self.CheckEnabled()
		  Self.NextQueueItem()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckEnabled()
		  Var Enabled As Boolean = True
		  Var HasWindowsFile As Boolean = (Self.mWinComboFile <> Nil And Self.mWinComboFile.Exists) Or (Self.mWin64File <> Nil And Self.mWin64File.Exists) Or (Self.mWin32File <> Nil And Self.mWin32File.Exists)
		  
		  If Self.mUploadQueue <> Nil And Self.mUploadQueue.KeyCount > 0 Then
		    Enabled = False
		  End If
		  If Enabled And (Self.mMacFile = Nil Or Self.mMacFile.Exists = False) Then
		    Enabled = False
		  End If
		  If Enabled And HasWindowsFile = False Then
		    Enabled = False
		  End If
		  If Enabled And Self.mBannerText = "" Then
		    Enabled = False
		  End If
		  If Enabled And Self.mBuildNumber = 0 Then
		    Enabled = False
		  End If
		  If Enabled And Self.mStageCode = 0 Then
		    Enabled = False
		  End If
		  If Enabled And Self.mDisplayVersion = "" Then
		    Enabled = False
		  End If
		  If Enabled And Self.mNotesText = "" Then
		    Enabled = False
		  End If
		  
		  If Self.ActionButton.Enabled <> Enabled Then
		    Self.ActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Error(Message As String)
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  Self.UploadSocket.Disconnect
		  Self.mUploadQueue = New Dictionary
		  Self.CheckEnabled()
		  
		  MessageBox(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Finish()
		  If Self.mUploadQueue <> Nil And Self.mUploadQueue.KeyCount > 0 Then
		    Return
		  End If
		  
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  Var Root As String = "https://releases.beaconapp.cc/" + EncodeURLComponent(Self.mDisplayVersion)
		  Var DeltaVersion As Integer = 4
		  If Self.mBuildNumber = 10600000 Then
		    DeltaVersion = 6
		  ElseIf Self.mBuildNumber = 10500000 Then
		    DeltaVersion = 5
		  End If
		  
		  Var InsertData As New Dictionary
		  InsertData.Value("build_number") = Str(Self.mBuildNumber, "-0")
		  InsertData.Value("build_display") = "'" + Self.mDisplayVersion + "'"
		  InsertData.Value("notes") = "convert_from(decode('" + EncodeHex(Self.mNotesText) + "', 'hex'), 'UTF8')"
		  InsertData.Value("stage") = Str(Self.mStageCode, "-0")
		  InsertData.Value("preview") = "'" + Self.mBannerText.ReplaceAll("'", "''") + "'"
		  InsertData.Value("min_mac_version") = "'10.12.0'"
		  InsertData.Value("min_win_version") = "'6.1.7601'"
		  InsertData.Value("delta_version") = DeltaVersion
		  InsertData.Value("published") = "'" + DateTime.Now.SQLDateTime + "'"
		  
		  If Self.mMacFile <> Nil And Self.mMacFile.Exists And Self.mMacSignature <> "" And Self.mMacPath <> "" Then
		    Var URL As String = Root + "/" + Self.mMacPath
		    InsertData.Value("mac_url") = "'" + URL.ReplaceAll("'", "''") + "'"
		    InsertData.Value("mac_signature") = "'" + Self.mMacSignature + "'"
		  End If
		  If Self.mWinComboFile <> Nil And Self.mWinComboFile.Exists And Self.mWinComboSignature <> "" And Self.mWinComboPath <> "" Then
		    Var URL As String = Root + "/" + Self.mWinComboPath
		    InsertData.Value("win_combo_url") = "'" + URL.ReplaceAll("'", "''") + "'"
		    InsertData.Value("win_combo_signature") = "'" + Self.mWinComboSignature + "'"
		  End If
		  If Self.mWin64File <> Nil And Self.mWin64File.Exists And Self.mWin64Signature <> "" And Self.mWin64Path <> "" Then
		    Var URL As String = Root + "/" + Self.mWin64Path
		    InsertData.Value("win_64_url") = "'" + URL.ReplaceAll("'", "''") + "'"
		    InsertData.Value("win_64_signature") = "'" + Self.mWin64Signature + "'"
		  End If
		  If Self.mWin32File <> Nil And Self.mWin32File.Exists And Self.mWin32Signature <> "" And Self.mWin32Path <> "" Then
		    Var URL As String = Root + "/" + Self.mWin32Path
		    InsertData.Value("win_32_url") = "'" + URL.ReplaceAll("'", "''") + "'"
		    InsertData.Value("win_32_signature") = "'" + Self.mWin32Signature + "'"
		  End If
		  
		  Var Columns(), Values() As String
		  For Each InsertEntry As DictionaryEntry In InsertData
		    Columns.Add("""" + InsertEntry.Key + """")
		    Values.Add(InsertEntry.Value)
		  Next InsertEntry
		  
		  Var SQL As String = "INSERT INTO ""updates"" (" + String.FromArray(Columns, ", ") + ") VALUES (" + String.FromArray(Values, ", ") + ");"
		  Var Board As New Clipboard
		  Board.Text = SQL
		  
		  MessageBox("Insert statement has been copied to the clipboard.")
		  
		  Self.CheckEnabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NextQueueItem()
		  If Self.mUploadQueue.KeyCount = 0 Then
		    Self.Finish()
		    Return
		  End If
		  
		  Var Path As String = Self.mUploadQueue.Key(0)
		  Var File As FolderItem = Self.mUploadQueue.Value(Path)
		  Self.mUploadQueue.Remove(Path)
		  
		  Var Stream As BinaryStream = BinaryStream.Open(File, False)
		  Var Contents As MemoryBlock = Stream.Read(Stream.Length)
		  Stream.Close
		  
		  Var Host As String
		  #if DebugBuild
		    Host = "private-anon-166a449bae-bunnycdnstorage.apiary-mock.com"
		  #else
		    Host = "storage.bunnycdn.com"
		  #endif
		  
		  Var ParentURL As String = "https://" + Host + "/beacon-releases/" + EncodeURLComponent(Self.mDisplayVersion)
		  Var UploadURL As String = ParentURL + "/" + Path
		  
		  Self.mProgress.Caption = "Uploading " + Path
		  
		  Self.UploadSocket.ClearRequestHeaders()
		  Self.UploadSocket.SetRequestContent(Contents, "application/octet-stream")
		  Self.UploadSocket.RequestHeader("AccessKey") = App.APIKey.ToText
		  Self.UploadSocket.Send("PUT", UploadURL.ToText)
		  System.DebugLog("Uploading to " + UploadURL)
		  
		  Var Signature As String = EncodeHex(Crypto.RSASign(Contents, App.PrivateKey)).Lowercase
		  
		  Select Case Path
		  Case Self.mMacPath
		    Self.mMacSignature = Signature
		  Case Self.mWinComboPath
		    Self.mWinComboSignature = Signature
		  Case Self.mWin64Path
		    Self.mWin64Signature = Signature
		  Case Self.mWin32Path
		    Self.mWin32Signature = Signature
		  End Select
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBannerText As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBuildNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisplayVersion As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMacFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMacPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMacSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotesText As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressSheet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStageCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadQueue As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWin32File As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWin32Path As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWin32Signature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWin64File As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWin64Path As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWin64Signature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWinComboFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWinComboPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWinComboSignature As String
	#tag EndProperty


#tag EndWindowCode

#tag Events UploadSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused Content
		  
		  If HTTPStatus = 201 Then
		    Timer.CallLater(10, AddressOf NextQueueItem)
		  Else
		    Self.Error("Unable to upload build to " + URL + ": " + Str(HTTPStatus, "-0"))
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SendingProgressed(bytesSent As Int64, bytesLeft As Int64)
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Progress = BytesSent / BytesLeft
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.Error(e.Message)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectWin32Button
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.SuggestedFileName = "Install_Beacon.exe"
		  Dialog.Filter = AppFileTypes.WindowsExecutable
		  
		  Var File As FolderItem = Dialog.ShowModal(Self)
		  If File = Nil Then
		    Return
		  End If
		  
		  Self.mWin32File = File
		  Self.Win32PathField.Text = File.NativePath
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Win32PathField
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  Do
		    If Obj.FolderItemAvailable = False Then
		      Continue
		    End If
		    
		    Self.mWin32File = Obj.FolderItem
		    Me.Text = Self.mWin32File.NativePath
		    Self.CheckEnabled
		    Return
		  Loop Until Obj.NextItem = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.AcceptFileDrop(AppFileTypes.WindowsExecutable)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectWin64Button
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.SuggestedFileName = "Install_Beacon.exe"
		  Dialog.Filter = AppFileTypes.WindowsExecutable
		  
		  Var File As FolderItem = Dialog.ShowModal(Self)
		  If File = Nil Then
		    Return
		  End If
		  
		  Self.mWin64File = File
		  Self.Win64PathField.Text = File.NativePath
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Win64PathField
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  Do
		    If Obj.FolderItemAvailable = False Then
		      Continue
		    End If
		    
		    Self.mWin64File = Obj.FolderItem
		    Me.Text = Self.mWin64File.NativePath
		    Self.CheckEnabled
		    Return
		  Loop Until Obj.NextItem = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.AcceptFileDrop(AppFileTypes.WindowsExecutable)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectFolderButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New SelectFolderDialog
		  Dialog.SuggestedFileName = "Installers"
		  
		  Var Folder As FolderItem = Dialog.ShowModal(Self)
		  If Folder = Nil Then
		    Return
		  End If
		  
		  Try
		    Self.mMacFile = Folder.Child("Mac").Child("Output").Child("Beacon.dmg")
		    Self.MacPathField.Text = Self.mMacFile.NativePath
		  Catch Err As RuntimeException
		    Self.mMacFile = Nil
		    Self.MacPathField.Text = ""
		  End Try
		  
		  Try
		    Self.mWinComboFile = Folder.Child("Windows").Child("Output").Child("Combo").Child("Install_Beacon.exe")
		    Self.WinComboPathField.Text = Self.mWinComboFile.NativePath
		  Catch Err As RuntimeException
		    Self.mWinComboFile = Nil
		    Self.WinComboPathField.Text = ""
		  End Try
		  
		  Try
		    Self.mWin64File = Folder.Child("Windows").Child("Output").Child("x64").Child("Install_Beacon.exe")
		    Self.Win64PathField.Text = Self.mWin64File.NativePath
		  Catch Err As RuntimeException
		    Self.mWin64File = Nil
		    Self.Win64PathField.Text = ""
		  End Try
		  
		  Try
		    Self.mWin32File = Folder.Child("Windows").Child("Output").Child("x86").Child("Install_Beacon.exe")
		    Self.Win32PathField.Text = Self.mWin32File.NativePath
		  Catch Err As RuntimeException
		    Self.mWin32File = Nil
		    Self.Win32PathField.Text = ""
		  End Try
		  
		  Self.CheckEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectMacButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.SuggestedFileName = "Beacon.dmg"
		  Dialog.Filter = AppFileTypes.DiskImage
		  
		  Var File As FolderItem = Dialog.ShowModal(Self)
		  If File = Nil Then
		    Return
		  End If
		  
		  Self.mMacFile = File
		  Self.MacPathField.Text = File.NativePath
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectWinComboButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.SuggestedFileName = "Install_Beacon.exe"
		  Dialog.Filter = AppFileTypes.WindowsExecutable
		  
		  Var File As FolderItem = Dialog.ShowModal(Self)
		  If File = Nil Then
		    Return
		  End If
		  
		  Self.mWinComboFile = File
		  Self.WinComboPathField.Text = File.NativePath
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ShortPreviewField
	#tag Event
		Sub TextChanged()
		  Self.mBannerText = Me.Text.Trim
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HorizontalSeparator
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused Areas
		  
		  G.DrawingColor = &cCCCCCC
		  G.FillRectangle(0, 0, G.Width, G.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Self.Begin()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NotesArea
	#tag Event
		Sub TextChanged()
		  Self.mNotesText = Me.Text.Trim
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VersionField
	#tag Event
		Sub TextChanged()
		  Var Parser As New Regex
		  Parser.SearchPattern = "^(\d+)\.(\d+)\.(\d+)(([a-z\.]+)(\d+))?$"
		  
		  Var Matches As RegexMatch = Parser.Search(Me.Text.Trim)
		  If Matches = Nil Then
		    Self.mDisplayVersion = ""
		    Self.mBuildNumber = 0
		    Self.mStageCode = 0
		    Self.CheckEnabled
		    Return
		  End If
		  
		  Var MajorVersion As Integer = Val(Matches.SubExpressionString(1))
		  Var MinorVersion As Integer = Val(Matches.SubExpressionString(2))
		  Var BugVersion As Integer = Val(Matches.SubExpressionString(3))
		  Var StageCode As Integer = 3
		  Var NonReleaseVersion As Integer
		  If Matches.SubExpressionCount > 4 Then
		    NonReleaseVersion = Val(Matches.SubExpressionString(6))
		    Select Case Matches.SubExpressionString(5)
		    Case "a"
		      StageCode = 1
		    Case "b"
		      StageCode = 2
		    Case "."
		      StageCode = 3
		    Else
		      StageCode = 0
		    End Select
		  End If
		  
		  Var BuildNumber As Integer = (MajorVersion * 10000000) + (MinorVersion * 100000) + (BugVersion * 1000) + (StageCode * 100) + NonReleaseVersion
		  Self.BuildNumberField.Text = Str(BuildNumber, "0")
		  Self.mStageCode = StageCode
		  Self.mDisplayVersion = Me.Text.Trim
		  Self.mBuildNumber = BuildNumber
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WinComboPathField
	#tag Event
		Sub Opening()
		  Me.AcceptFileDrop(AppFileTypes.WindowsExecutable)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  Do
		    If Obj.FolderItemAvailable = False Then
		      Continue
		    End If
		    
		    Self.mWinComboFile = Obj.FolderItem
		    Me.Text = Self.mWinComboFile.NativePath
		    Self.CheckEnabled
		    Return
		  Loop Until Obj.NextItem = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MacPathField
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  Do
		    If Obj.FolderItemAvailable = False Then
		      Continue
		    End If
		    
		    Self.mMacFile = Obj.FolderItem
		    Me.Text = Self.mMacFile.NativePath
		    Self.CheckEnabled
		    Return
		  Loop Until Obj.NextItem = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.AcceptFileDrop(AppFileTypes.DiskImage)
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
		Name="MenuBarVisible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
