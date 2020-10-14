#tag Window
Begin BeaconWindow SupportTicketWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   3
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   574
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   574
   MinimumWidth    =   600
   Resizeable      =   True
   Title           =   "New Support Ticket"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin GroupBox DisclosureGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   112
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   28
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   402
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   552
      Begin Label DisclosureLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   40
         Index           =   -2147483648
         InitialParent   =   "DisclosureGroup"
         Italic          =   False
         Left            =   48
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   422
         Transparent     =   False
         Underline       =   False
         Value           =   "For diagnostic purposes, this support ticket will include Beacon's recent log files, the selected Beacon document, and any backed up ini files."
         Visible         =   True
         Width           =   512
      End
      Begin CheckBox AgreeCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "I agree"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "DisclosureGroup"
         Italic          =   False
         Left            =   48
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   474
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   512
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Submit"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   534
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   534
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedTextField EmailField
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
      Italic          =   False
      Left            =   155
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
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   425
   End
   Begin UITweaks.ResizedLabel EmailLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Underline       =   False
      Value           =   "E-Mail Address:"
      Visible         =   True
      Width           =   123
   End
   Begin UITweaks.ResizedTextField NameField
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
      Italic          =   False
      Left            =   155
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   425
   End
   Begin UITweaks.ResizedLabel NameLabel
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Name:"
      Visible         =   True
      Width           =   123
   End
   Begin UITweaks.ResizedPopupMenu PlatformMenu
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
      InitialParent   =   ""
      InitialValue    =   "Steam\nEpic Games Store\nXbox / Windows Store\nPlayStation\nSwitch / Mobile / Other"
      Italic          =   False
      Left            =   155
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   -1
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   203
   End
   Begin UITweaks.ResizedLabel PlatformLabel
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Value           =   "Platform:"
      Visible         =   True
      Width           =   123
   End
   Begin UITweaks.ResizedTextField HostField
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
      Hint            =   "Nitrado, GPortal, single player, self-hosted, etc."
      Index           =   -2147483648
      Italic          =   False
      Left            =   155
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   120
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   425
   End
   Begin UITweaks.ResizedLabel HostLabel
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   120
      Transparent     =   False
      Underline       =   False
      Value           =   "Hosting Provider:"
      Visible         =   True
      Width           =   123
   End
   Begin TextArea BodyField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
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
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   156
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   28
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   226
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   552
   End
   Begin Label BodyLabel
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   28
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   194
      Transparent     =   False
      Underline       =   False
      Value           =   "Please describe your issue with as much detail as possible."
      Visible         =   True
      Width           =   552
   End
   Begin UITweaks.ResizedPopupMenu DocumentMenu
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
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   155
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   154
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   203
   End
   Begin UITweaks.ResizedLabel DocumentLabel
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   154
      Transparent     =   False
      Underline       =   False
      Value           =   "Document:"
      Visible         =   True
      Width           =   123
   End
   Begin Thread SubmitThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
   Begin Timer SubmitWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   500
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Activate()
		  Self.RefreshDocumentMenu()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.SwapButtons()
		  
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  If (Identity Is Nil) = False Then
		    Self.mUserID = Identity.UserID
		    If Beacon.ValidateEmail(Identity.Username) Then
		      Self.EmailField.Value = Identity.Username
		    End If
		  End If
		  
		  Self.RefreshDocumentMenu()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function AddToArchive(Path As String, File As FolderItem) As Boolean
		  If File Is Nil Or File.Exists = False Then
		    Return True
		  End If
		  
		  If File.IsFolder Then
		    For Each Child As FolderItem In File.Children
		      If Not Self.AddToArchive(Path + "/" + File.Name, Child) Then
		        Return False
		      End If
		    Next
		    Return True
		  End If
		  
		  Try
		    Var Bytes As MemoryBlock = File.Read
		    Return Self.AddToArchive(Path + "/" + File.Name, Bytes)
		  Catch Err As RuntimeException
		    Self.SetError("Unable to add " + File.NativePath + " to archive.")
		    App.Log(Err, CurrentMethodName, "Trying to add file " + File.NativePath + " to archive at " + Path + ".")
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AddToArchive(Path As String, Data As MemoryBlock) As Boolean
		  If Data Is Nil Or Data.Size = 0 Then
		    Return True
		  End If
		  
		  Var Entry As New ArchiveEntryMBS
		  Entry.PathName = Path
		  Entry.Size = CType(Data.Size, UInt64)
		  Entry.Permissions = &o0644
		  Entry.FileType = ArchiveEntryMBS.kFileTypeRegular
		  
		  Self.mTicketArchive.WriteHeader(Entry)
		  Call Self.mTicketArchive.WriteData(Data)
		  If Self.mTicketArchive.LastError <> ArchiverMBS.kArchiveOK Then
		    Self.SetError("Unable to add " + Path + " to archive: " + Self.ArchiveErrorReason)
		    Return False
		  End If
		  Self.mTicketArchive.FinishEntry
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ArchiveErrorReason() As String
		  Select Case Self.mTicketArchive.LastError
		  Case ArchiverMBS.kArchiveEOF
		    Return "Found end of archive"
		  Case ArchiverMBS.kArchiveFailed
		    Return "Current operation cannot complete"
		  Case ArchiverMBS.kArchiveFatal
		    Return "No more operations are possible"
		  Case ArchiverMBS.kArchiveRetry
		    Return "Retry might succeed"
		  Case ArchiverMBS.kArchiveWarn
		    Return "Partial success"
		  Else
		    Return "Unknown code " + Self.mTicketArchive.LastError.ToString
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshDocumentMenu()
		  Var SelectedDocumentID As String
		  If Self.DocumentMenu.SelectedRowIndex > -1 Then
		    SelectedDocumentID = Beacon.Document(Self.DocumentMenu.SelectedRowTag).DocumentID
		  End If
		  
		  Self.DocumentMenu.RemoveAllRows
		  
		  Var Win As MainWindow = App.MainWindow
		  If Win Is Nil Then
		    Return
		  End If
		  
		  Var Editors() As DocumentEditorView = App.MainWindow.DocumentEditors
		  For Each View As BeaconSubview In Editors
		    Var Document As Beacon.Document = DocumentEditorView(View).Document
		    If Document Is Nil Then
		      Continue
		    End If
		    
		    Self.DocumentMenu.AddRow(Document.Title, Document)
		    If Document.DocumentID = SelectedDocumentID Then
		      Self.DocumentMenu.SelectedRowIndex = Self.DocumentMenu.LastAddedRowIndex
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(Message As String)
		  Self.mThreadErrorMessage = Message
		  Self.mThreadError = True
		  Self.mThreadFinished = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreadError As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreadErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreadFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTicketArchive As ArchiveWriterMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTicketBody As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTicketDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTicketEmail As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTicketHost As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTicketName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTicketPlatform As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserID As String
	#tag EndProperty


	#tag Constant, Name = PlatformEpic, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PlatformOther, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PlatformPlayStation, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PlatformSteam, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PlatformXbox, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Action()
		  Var Name As String = Self.NameField.Value.Trim
		  If Name.IsEmpty Then
		    Self.ShowAlert("Please provide some sort of name", "It might not seem like much, but a name can help solve certain problems, especially if the problem is related to a purchase.")
		    Return
		  End If
		  
		  Var Email As String = Self.EmailField.Value.Trim
		  If Not Beacon.ValidateEmail(Email) Then
		    Self.ShowAlert("Please provide a valid email address", "You would not be able to receive a reply without an email address.")
		    Return
		  End If
		  
		  If Self.PlatformMenu.SelectedRowIndex = -1 Then
		    Self.ShowAlert("Please select the platform where you play Ark", "Not all solutions are available to all platforms, so this helps provide accurate answers more quickly.")
		    Return
		  End If
		  
		  Var Host As String = Self.HostField.Value.Trim
		  If Host.IsEmpty Then
		    Self.ShowAlert("Please include the name of your host", "While Beacon works for all hosts, including single player and self-hosted servers, instructions can vary vary depending on the host. This information helps to get accurate answers more quickly.")
		    Return
		  End If
		  
		  Var Document As Beacon.Document
		  If Self.DocumentMenu.SelectedRowIndex > -1 Then
		    Document = Self.DocumentMenu.RowTagAt(Self.DocumentMenu.SelectedRowIndex)
		  ElseIf Not Self.ShowConfirm("Are you sure you do not wish to include a document?", "Including a Beacon document provides a ton of information and helps get you an answer faster. If you cannot find your document in the menu, open the document first. Are you sure you do not want to include a document?", "Do Not Include", "Cancel") Then
		    Return
		  End If
		  
		  Var Body As String = Self.BodyField.Value.Trim
		  If Body.IsEmpty Or Body.Length < 60 Then
		    Self.ShowAlert("Please include a more detailed description of your issue", "The more information, the better.")
		    Return
		  End If
		  
		  If Not Self.AgreeCheckbox.Value Then
		    Self.ShowAlert("You must agree to the inclusion of the diagnostic data", "Please read the text in the box at the bottom of the window for more information.")
		    Return
		  End If
		  
		  Self.mProgress = New ProgressWindow
		  Self.mProgress.Message = "Creating ticket…"
		  Self.mProgress.ShowWithin(Self)
		  
		  Self.mTicketBody = Body
		  Self.mTicketDocument = Document
		  Self.mTicketEmail = Email
		  Self.mTicketHost = Host
		  Self.mTicketName = Name
		  Self.mTicketPlatform = Self.PlatformMenu.SelectedRowIndex
		  
		  Self.mThreadError = False
		  Self.mThreadErrorMessage = ""
		  Self.mThreadFinished = False
		  Self.mTicketArchive = Nil
		  
		  Me.Enabled = False
		  Self.CancelButton.Enabled = False
		  
		  Self.SubmitWatcher.RunMode = Timer.RunModes.Multiple
		  
		  Self.SubmitThread.Start
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  If Self.Changed And Not Self.ShowConfirm("Are you sure you want to discard this ticket?", "You have made changes that will be lost if you close the window now.", "Discard", "Cancel") Then
		    Return
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EmailField
	#tag Event
		Sub TextChange()
		  If Self.Opened Then
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Self.Opened Then
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlatformMenu
	#tag Event
		Sub Change()
		  If Self.Opened Then
		    Self.Changed = True
		  End If
		  
		  If Me.SelectedRowIndex = Self.PlatformXbox And Self.HostField.Value.IsEmpty Then
		    Self.HostField.Value = "Nitrado"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HostField
	#tag Event
		Sub TextChange()
		  If Self.Opened Then
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BodyField
	#tag Event
		Sub TextChange()
		  If Self.Opened Then
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DocumentMenu
	#tag Event
		Sub Change()
		  If Self.Opened Then
		    Self.Changed = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SubmitThread
	#tag Event
		Sub Run()
		  Self.mTicketArchive = New ArchiveWriterMBS
		  Self.mTicketArchive.SetFormatZip
		  Self.mTicketArchive.ZipSetCompressionDeflate
		  If Not Self.mTicketArchive.CreateMemoryFile Then
		    Self.SetError("Unable to create diagnostic archive: " + Self.ArchiveErrorReason)
		    Return
		  End If
		  
		  If (Self.mTicketDocument Is Nil) = False Then
		    Var Identity As Beacon.Identity
		    If (App.IdentityManager Is Nil) = False And (App.IdentityManager.CurrentIdentity Is Nil) = False Then
		      Identity = App.IdentityManager.CurrentIdentity
		    Else
		      Identity = New Beacon.Identity
		    End If
		    Self.mProgress.Detail = "Attaching document…"
		    Var FileName As String = Self.mTicketDocument.Title + ".beacon"
		    Var FileContent As String = Beacon.GenerateJSON(Self.mTicketDocument.ToDictionary(Identity), True)
		    
		    If Not Self.AddtoArchive(Beacon.SanitizeFilename(FileName), FileContent) Then
		      Return
		    End If
		    
		    Self.mProgress.Detail = "Attaching backup files…"
		    Var ProfileBound As Integer = Self.mTicketDocument.ServerProfileCount - 1
		    Var BackupsFolder As FolderItem = App.BackupsFolder
		    If (BackupsFolder Is Nil) = False And BackupsFolder.Exists Then
		      For Idx As Integer = 0 To ProfileBound
		        Var Profile As Beacon.ServerProfile = Self.mTicketDocument.ServerProfile(Idx)
		        Var Folder As FolderItem = BackupsFolder.Child(Profile.BackupFolderName)
		        If Not Self.AddToArchive("Backups", Folder) Then
		          Return
		        End If
		      Next
		    End If
		  End If
		  
		  Self.mProgress.Detail = "Attaching log files…"
		  
		  Var LogsFolder As FolderItem = App.LogsFolder
		  If (LogsFolder Is Nil) = False And LogsFolder.Exists Then
		    Var Pattern As New Regex
		    Pattern.SearchPattern = "^\d{4}-\d{2}-\d{2}\.log$"
		    
		    For Each File As FolderItem In LogsFolder.Children
		      If Pattern.Search(File.Name) Is Nil Then
		        Continue
		      End If
		      
		      If Not Self.AddToArchive("Logs", File) Then
		        // Error will have been set already
		        Return
		      End If
		    Next
		  End If
		  
		  Self.mTicketArchive.Close
		  
		  Var ArchiveBytes As MemoryBlock = Self.mTicketArchive.MemoryData
		  
		  Var Boundary As String = new v4UUID
		  Var ContentType As String = "multipart/form-data; charset=utf-8; boundary=" + Boundary
		  
		  Var Platform As String
		  Select Case Self.mTicketPlatform
		  Case Self.PlatformSteam
		    Platform = "Steam"
		  Case Self.PlatformEpic
		    Platform = "Epic"
		  Case Self.PlatformXbox
		    Platform = "Xbox"
		  Case Self.PlatformPlayStation
		    Platform = "PlayStation"
		  Case Self.PlatformOther
		    Platform = "Other"
		  End Select
		  
		  Var Parts() As String
		  Parts.AddRow("Content-Disposition: form-data; name=""name""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketName)
		  Parts.AddRow("Content-Disposition: form-data; name=""email""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketEmail)
		  Parts.AddRow("Content-Disposition: form-data; name=""platform""" + EndOfLine.Windows + EndOfLine.Windows + Platform)
		  Parts.AddRow("Content-Disposition: form-data; name=""host""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketHost)
		  Parts.AddRow("Content-Disposition: form-data; name=""body""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketBody)
		  Parts.AddRow("Content-Disposition: form-data; name=""user""" + EndOfLine.Windows + EndOfLine.Windows + Self.mUserID)
		  Parts.AddRow("Content-Disposition: form-data; name=""archive""; filename=""" + Self.mTicketEmail.Left(Self.mTicketEmail.IndexOf("@")) + ".zip""" + EndOfLine.Windows + "Content-Type: application/zip" + EndOfLine.Windows + EndOfLine.Windows + ArchiveBytes.StringValue(0, ArchiveBytes.Size))
		  Parts.AddRow("Content-Disposition: form-data; name=""os""" + EndOfLine.Windows + EndOfLine.Windows + SystemInformationMBS.OSVersionString)
		  Parts.AddRow("Content-Disposition: form-data; name=""version""" + EndOfLine.Windows + EndOfLine.Windows + App.ShortVersion)
		  Parts.AddRow("Content-Disposition: form-data; name=""build""" + EndOfLine.Windows + EndOfLine.Windows + App.BuildNumber.ToString)
		  
		  Var PostBody As String = "--" + Boundary + EndOfLine.Windows + Parts.Join(EndOfLine.Windows + "--" + Boundary + EndOfLine.Windows) + EndOfLine.Windows + "--" + Boundary + "--"
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.SetRequestContent(PostBody, ContentType)
		  Self.mProgress.Detail = "Uploading archive…"
		  Socket.Send("POST", Beacon.WebURL("/help/ticket"))
		  
		  If Socket.LastHTTPStatus >= 200 And Socket.LastHTTPStatus < 300 Then
		    Self.mThreadFinished = True
		    Return
		  End If
		  
		  Self.SetError("Server replied with an HTTP status: " + Socket.LastHTTPStatus.ToString)
		  
		  Exception Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Ticket submission thread")
		    Self.SetError("Unhandled exception while submitting ticket")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SubmitWatcher
	#tag Event
		Sub Action()
		  If Self.mThreadFinished = False Then
		    Return
		  End If
		  
		  Me.RunMode = Timer.RunModes.Off
		  Self.mProgress.Close
		  Self.mProgress = Nil
		  
		  If Self.mThreadError Then
		    Self.ShowAlert("Sorry, the ticket was not submitted", Self.mThreadErrorMessage)
		    Self.ActionButton.Enabled = True
		    Self.CancelButton.Enabled = True
		    Return
		  End If
		  
		  Self.ShowAlert("Your ticket has been submitted", "You should receive an email confirmation shortly.")
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
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
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
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
#tag EndViewBehavior
