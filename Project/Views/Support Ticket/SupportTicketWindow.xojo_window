#tag DesktopWindow
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
   Height          =   606
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   606
   MinimumWidth    =   800
   Resizeable      =   True
   Title           =   "New Support Ticket"
   Type            =   0
   Visible         =   True
   Width           =   800
   Begin DesktopGroupBox DisclosureGroup
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
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   434
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   760
      Begin DesktopLabel DisclosureLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   40
         Index           =   -2147483648
         InitialParent   =   "DisclosureGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "For diagnostic purposes, this support ticket will include Beacon's recent log files, the selected Beacon project, and any backed up ini files."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   454
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   720
      End
      Begin DesktopCheckBox AgreeCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "I agree"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "DisclosureGroup"
         Italic          =   False
         Left            =   40
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
         Top             =   506
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   720
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
      Left            =   700
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   566
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
      Left            =   608
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   566
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Thread SubmitThread
      DebugIdentifier =   ""
      Enabled         =   True
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
   Begin DesktopGroupBox AttachmentsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Attachments (Optional)"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   210
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   461
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   319
      Begin BeaconListbox AttachmentsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   1
         ColumnWidths    =   ""
         DefaultRowHeight=   26
         DefaultSortColumn=   0
         DefaultSortDirection=   0
         DropIndicatorVisible=   False
         EditCaption     =   "Edit"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   0
         Height          =   122
         Index           =   -2147483648
         InitialParent   =   "AttachmentsGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   481
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   56
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   279
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton AddAttachmentButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add File"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AttachmentsGroup"
         Italic          =   False
         Left            =   670
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   190
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
   End
   Begin DesktopGroupBox DetailsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Details"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   210
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   429
      Begin UITweaks.ResizedLabel HostLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "Hosting Provider:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   156
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   116
      End
      Begin UITweaks.ResizedTextField HostField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   "Nitrado, single player, self-hosted, etc."
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   168
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
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   156
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedLabel PlatformLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "Platform:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   124
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   116
      End
      Begin UITweaks.ResizedPopupMenu PlatformMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         InitialValue    =   "Steam\nEpic Games Store\nXbox / Windows Store\nPlayStation\nSwitch / Mobile / Other"
         Italic          =   False
         Left            =   168
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
         Top             =   124
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   203
      End
      Begin UITweaks.ResizedLabel NameLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "Name:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   56
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   116
      End
      Begin UITweaks.ResizedTextField NameField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   168
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
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   56
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedLabel EmailLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "E-Mail Address:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   90
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   116
      End
      Begin UITweaks.ResizedTextField EmailField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   168
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
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   90
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPopupMenu DocumentMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   168
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
         Top             =   190
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   203
      End
      Begin UITweaks.ResizedLabel DocumentLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "DetailsGroup"
         Italic          =   False
         Left            =   40
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
         Text            =   "Project:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   190
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   116
      End
   End
   Begin DesktopGroupBox BodyGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Please describe your issue with as much detail as possible."
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   180
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   242
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   760
      Begin DesktopTextArea BodyField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   124
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "BodyGroup"
         Italic          =   False
         Left            =   40
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
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   278
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         ValidationMask  =   ""
         Visible         =   True
         Width           =   720
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Activated()
		  Self.RefreshDocumentMenu()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		  
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  If (Identity Is Nil) = False Then
		    Self.mUserID = Identity.UserID
		    If Beacon.ValidateEmail(Identity.Username) Then
		      Self.EmailField.Text = Identity.Username
		    End If
		  End If
		  
		  Self.RefreshDocumentMenu()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddAttachment(File As FolderItem)
		  Var Files(0) As FolderItem
		  Files(0) = File
		  Self.AddAttachments(Files)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddAttachments(Files() As FolderItem)
		  Var SelectionCleared As Boolean
		  For Each File As FolderItem In Files
		    If File Is Nil Then
		      Continue
		    End If
		    
		    If SelectionCleared = False Then
		      Self.AttachmentsList.SelectedRowIndex = -1
		      SelectionCleared = True
		    End If
		    
		    Self.mAttachments.Add(File)
		    
		    Self.AttachmentsList.AddRow(File.Name)
		    Self.AttachmentsList.RowTagAt(Self.AttachmentsList.LastAddedRowIndex) = File
		    Self.AttachmentsList.RowSelectedAt(Self.AttachmentsList.LastAddedRowIndex) = True
		  Next File
		  Self.AttachmentsList.Sort
		  
		  If SelectionCleared Then
		    Self.AttachmentsList.EnsureSelectionIsVisible
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshDocumentMenu()
		  Var SelectedDocumentID As String
		  If Self.DocumentMenu.SelectedRowIndex > -1 Then
		    SelectedDocumentID = Beacon.Project(Self.DocumentMenu.SelectedRowTag).UUID
		  End If
		  
		  Self.DocumentMenu.RemoveAllRows
		  
		  Var Win As MainWindow = App.MainWindow
		  If Win Is Nil Then
		    Return
		  End If
		  
		  Var Editors() As DocumentEditorView = App.MainWindow.DocumentEditors
		  If Editors Is Nil Then
		    Return
		  End If
		  For Each View As BeaconSubview In Editors
		    Var Project As Beacon.Project = DocumentEditorView(View).Project
		    If Project Is Nil Then
		      Continue
		    End If
		    
		    Self.DocumentMenu.AddRow(Project.Title, Project)
		    If Project.UUID = SelectedDocumentID Then
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
		Private mAttachments() As FolderItem
	#tag EndProperty

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
		Private mTicketDocument As Beacon.Project
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


	#tag Constant, Name = EncryptArchive, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

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

	#tag Constant, Name = SupportPublicKey, Type = String, Dynamic = False, Default = \"30820120300D06092A864886F70D01010105000382010D00308201080282010100C07639AB38648E98B5F7D325A60018B6F5A59D7AF329300A418C7F1C540CA75193438F233CAA8C02BCDCD075A1075B67C1BA0B21FCCF3C7799638E11F121FE24F175A360918037C27A968490A53B8C25454B20088B9DB587E5226378706C2E19DA0ED16BC44046D649EE05BD89D680C293E0C5E120072ACBD7FC44C9D5A51154BBB22E178FF0354B3D097CC968EC3B4DD0540933B439146C1BF4D9A00320F483B4A1710945A4BD00C6B20DAD13248BB2264B330070141DBFA66CEF9E907C4667D027466B6E4571C4400DD86244375E27DEF87AE2AA1C0E1801686AE88046889ED90680CE0AA6E40D559F39B0DF13ED8A910BA2B30620E514C14067833A8A3937020111", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Name As String = Self.NameField.Text.Trim
		  If Name.IsEmpty Then
		    Self.ShowAlert("Please provide some sort of name", "It might not seem like much, but a name can help solve certain problems, especially if the problem is related to a purchase.")
		    Return
		  End If
		  
		  Var Email As String = Self.EmailField.Text.Trim
		  If Not Beacon.ValidateEmail(Email) Then
		    Self.ShowAlert("Please provide a valid email address", "You would not be able to receive a reply without an email address.")
		    Return
		  End If
		  
		  If Self.PlatformMenu.SelectedRowIndex = -1 Then
		    Self.ShowAlert("Please select the platform where you play Ark", "Not all solutions are available to all platforms, so this helps provide accurate answers more quickly.")
		    Return
		  End If
		  
		  Var Host As String = Self.HostField.Text.Trim
		  If Host.IsEmpty Then
		    Self.ShowAlert("Please include the name of your host", "While Beacon works for all hosts, including single player and self-hosted servers, instructions can vary vary depending on the host. This information helps to get accurate answers more quickly.")
		    Return
		  End If
		  
		  Var Document As Beacon.Project
		  If Self.DocumentMenu.SelectedRowIndex > -1 Then
		    Document = Self.DocumentMenu.RowTagAt(Self.DocumentMenu.SelectedRowIndex)
		  ElseIf Not Self.ShowConfirm("Are you sure you do not wish to include a project?", "Including a Beacon project provides a ton of information and helps get you an answer faster. If you cannot find your project in the menu, open the project first. Are you sure you do not want to include a project?", "Do Not Include", "Cancel") Then
		    Return
		  End If
		  
		  Var Body As String = Self.BodyField.Text.Trim
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
		  Self.mProgress.Show(Self)
		  
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
		Sub Pressed()
		  If Self.Changed And Not Self.ShowConfirm("Are you sure you want to discard this ticket?", "You have made changes that will be lost if you close the window now.", "Discard", "Cancel") Then
		    Return
		  End If
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SubmitThread
	#tag Event
		Sub Run()
		  Var Password, EncryptedPassword As String
		  #if Self.EncryptArchive
		    Password = Beacon.UUID.v4
		    EncryptedPassword = EncodeBase64(Crypto.RSAEncrypt(Password, Self.SupportPublicKey), 0)
		  #endif
		  
		  Var Archive As Beacon.Archive
		  Try
		    Archive = Beacon.Archive.Create(Password)
		  Catch Err As RuntimeException
		    Self.SetError(Err.Message)
		    Return
		  End Try
		  
		  If (Self.mTicketDocument Is Nil) = False Then
		    Var Identity As Beacon.Identity
		    If (App.IdentityManager Is Nil) = False And (App.IdentityManager.CurrentIdentity Is Nil) = False Then
		      Identity = App.IdentityManager.CurrentIdentity
		    Else
		      Identity = New Beacon.Identity
		    End If
		    Self.mProgress.Detail = "Attaching project…"
		    Var FileName As String = Self.mTicketDocument.Title + ".beacon"
		    Var FileContent As String = Beacon.GenerateJSON(Self.mTicketDocument.SaveData(Identity), True)
		    Archive.AddFile(Beacon.SanitizeFilename(FileName), FileContent)
		    
		    Self.mProgress.Detail = "Attaching backup files…"
		    Var ProfileBound As Integer = Self.mTicketDocument.ServerProfileCount - 1
		    Var BackupsFolder As FolderItem = App.BackupsFolder
		    If (BackupsFolder Is Nil) = False And BackupsFolder.Exists Then
		      For Idx As Integer = 0 To ProfileBound
		        Var Profile As Beacon.ServerProfile = Self.mTicketDocument.ServerProfile(Idx)
		        Var Folder As FolderItem = BackupsFolder.Child(Profile.BackupFolderName)
		        Archive.AddFile("Backups", Folder)
		      Next
		    End If
		  End If
		  
		  Self.mProgress.Detail = "Attaching log files…"
		  
		  Var LogsFolder As FolderItem = App.LogsFolder
		  If (LogsFolder Is Nil) = False And LogsFolder.Exists Then
		    For Each File As FolderItem In LogsFolder.Children
		      Archive.AddFile("Logs", File)
		    Next
		  End If
		  
		  If Self.mAttachments.Count > 0 Then
		    Self.mProgress.Detail = "Attaching other files…"
		    For Idx As Integer = Self.mAttachments.FirstIndex To Self.mAttachments.LastIndex
		      Self.mProgress.Detail = "Attaching " + Self.mAttachments(Idx).Name + "…"
		      Archive.AddFile("Other", Self.mAttachments(Idx))
		    Next Idx
		  End If
		  
		  For Each DataSource As Beacon.DataSource In App.DataSources
		    Var FilesDict As Dictionary = DataSource.AdditionalSupportFiles
		    If FilesDict Is Nil Or FilesDict.KeyCount = 0 Then
		      Continue
		    End If
		    
		    For Each FileEntry As DictionaryEntry In FilesDict
		      Var Filename As String = FileEntry.Key
		      Var Data As MemoryBlock = FileEntry.Value
		      Archive.AddFile("Game Data/" + DataSource.Identifier + "/" + Filename, Data)
		    Next FileEntry
		  Next DataSource
		  
		  Var ArchiveBytes As MemoryBlock = Archive.Finalize
		  Archive = Nil
		  
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
		  Parts.Add("Content-Disposition: form-data; name=""name""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketName)
		  Parts.Add("Content-Disposition: form-data; name=""email""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketEmail)
		  Parts.Add("Content-Disposition: form-data; name=""platform""" + EndOfLine.Windows + EndOfLine.Windows + Platform)
		  Parts.Add("Content-Disposition: form-data; name=""host""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketHost)
		  Parts.Add("Content-Disposition: form-data; name=""body""" + EndOfLine.Windows + EndOfLine.Windows + Self.mTicketBody)
		  Parts.Add("Content-Disposition: form-data; name=""user""" + EndOfLine.Windows + EndOfLine.Windows + Self.mUserID)
		  Parts.Add("Content-Disposition: form-data; name=""archive""; filename=""" + Self.mTicketEmail.Left(Self.mTicketEmail.IndexOf("@")) + ".zip""" + EndOfLine.Windows + "Content-Type: application/zip" + EndOfLine.Windows + EndOfLine.Windows + ArchiveBytes.StringValue(0, ArchiveBytes.Size))
		  #if Self.EncryptArchive
		    Parts.Add("Content-Disposition: form-data; name=""archive_key""" + EndOfLine.Windows + EndOfLine.Windows + EncryptedPassword)
		  #endif
		  Parts.Add("Content-Disposition: form-data; name=""os""" + EndOfLine.Windows + EndOfLine.Windows + Beacon.OSVersionString)
		  Parts.Add("Content-Disposition: form-data; name=""version""" + EndOfLine.Windows + EndOfLine.Windows + App.Version)
		  Parts.Add("Content-Disposition: form-data; name=""build""" + EndOfLine.Windows + EndOfLine.Windows + App.BuildNumber.ToString)
		  
		  Var PostBody As String = "--" + Boundary + EndOfLine.Windows + Parts.Join(EndOfLine.Windows + "--" + Boundary + EndOfLine.Windows) + EndOfLine.Windows + "--" + Boundary + "--"
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.SetRequestContent(PostBody, ContentType)
		  Self.mProgress.Detail = "Uploading archive…"
		  Socket.Send("POST", Beacon.WebURL("/help/ticket"))
		  
		  If Socket.LastHTTPStatus >= 200 And Socket.LastHTTPStatus < 300 Then
		    Self.mThreadFinished = True
		    Return
		  End If
		  
		  Var Message As String = "Server replied with an HTTP status: " + Socket.LastHTTPStatus.ToString
		  Try
		    Var ErrorDict As Dictionary = Beacon.ParseJSON(Socket.LastString)
		    If ErrorDict.HasKey("message") Then
		      Message = ErrorDict.Value("message")
		    End If
		    If ErrorDict.HasKey("detail") Then
		      Var Detail As Variant = ErrorDict.Value("detail")
		      If Detail.IsNull = False And Detail.Type = Variant.TypeString Then
		        Message = Message + ": " + Detail.StringValue
		      End If
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.SetError(Message)
		  
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
#tag Events AttachmentsList
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  #Pragma Unused Warn
		  
		  For RowIdx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Var File As FolderItem = Me.RowTagAt(RowIdx)
		    Var Idx As Integer = Self.mAttachments.IndexOf(File)
		    If Idx > -1 Then
		      Self.mAttachments.RemoveAt(Idx)
		      Me.RemoveRowAt(RowIdx)
		    End If
		  Next RowIdx
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  
		  Var Files() As FolderItem
		  Do
		    If Obj.FolderItemAvailable Then
		      Files.Add(Obj.FolderItem)
		    End If
		  Loop Until Obj.NextItem = False
		  Self.AddAttachments(Files)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.AcceptFileDrop("")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddAttachmentButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.AllowMultipleSelections = True
		  
		  Call Dialog.ShowModal(Self)
		  
		  Var Files() As FolderItem
		  For Each File As FolderItem In Dialog.SelectedFiles
		    Files.Add(File)
		  Next File
		  If Files.Count > 0 Then
		    Self.AddAttachments(Files)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HostField
	#tag Event
		Sub TextChanged()
		  If Self.Opened Then
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlatformMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  If Self.Opened Then
		    Self.Modified = True
		  End If
		  
		  If Me.SelectedRowIndex = Self.PlatformXbox And Self.HostField.Text.IsEmpty Then
		    Self.HostField.Text = "Nitrado"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChanged()
		  If Self.Opened Then
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EmailField
	#tag Event
		Sub TextChanged()
		  If Self.Opened Then
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DocumentMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  If Self.Opened Then
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BodyField
	#tag Event
		Sub TextChanged()
		  If Self.Opened Then
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
			"9 - Modeless Dialog"
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Type="DesktopMenuBar"
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
