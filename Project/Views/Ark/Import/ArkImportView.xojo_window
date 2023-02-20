#tag DesktopWindow
Begin DocumentImportView ArkImportView
   AllowAutoDeactivate=   "True"
   AllowFocus      =   "False"
   AllowFocusRing  =   "False"
   AllowTabs       =   "True"
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   DoubleBuffer    =   "False"
   Enabled         =   "True"
   EraseBackground =   "True"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   456
   ImplicitInstance=   True
   Index           =   "-2147483648"
   InitialParent   =   ""
   Left            =   "0"
   LockBottom      =   "False"
   LockLeft        =   "False"
   LockRight       =   "False"
   LockTop         =   "False"
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   TabIndex        =   "0"
   TabPanelIndex   =   "0"
   TabStop         =   "True"
   Title           =   "Untitled"
   Tooltip         =   ""
   Top             =   "0"
   Transparent     =   "True"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin DesktopPagePanel Views
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   456
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   8
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   5
      Visible         =   True
      Width           =   600
      Begin DesktopRadioButton SourceRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Nitrado"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   0
         InitialParent   =   "Views"
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
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel ImportSourceMessage
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         Text            =   "Select Import Source"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopRadioButton SourceRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Server With FTP Access"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   4
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   180
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopRadioButton SourceRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Single Player, Local Files, or Copy + Paste"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   3
         InitialParent   =   "Views"
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
         Tooltip         =   ""
         Top             =   148
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton SourceCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   244
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton SourceActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   244
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ArkNitradoDiscoveryView NitradoDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   456
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin ArkFTPDiscoveryView FTPDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   456
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin ArkLocalDiscoveryView LocalDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   456
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin DesktopLabel StatusMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         Text            =   "Import Status"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton StatusCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton StatusActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Import"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   80
      End
      Begin DesktopRadioButton SourceRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Other Beacon project"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   5
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel OtherDocsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
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
         Text            =   "Import from Other Documents"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton OtherDocsActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   6
         TabStop         =   True
         Tooltip         =   ""
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton OtherDocsCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   6
         TabStop         =   True
         Tooltip         =   ""
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ArkConnectorDiscoveryView ConnectorDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   456
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   7
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   False
         Visible         =   True
         Width           =   600
      End
      Begin DesktopRadioButton SourceRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Server with Beacon Connector"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   2
         InitialParent   =   "Views"
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
         Tooltip         =   ""
         Top             =   116
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   False
         Width           =   560
      End
      Begin BeaconListbox StatusList
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
         DefaultRowHeight=   40
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
         HeadingIndex    =   -1
         Height          =   336
         Index           =   -2147483648
         InitialParent   =   "Views"
         InitialValue    =   ""
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   60
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconListbox OtherDocsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   2
         ColumnWidths    =   "26,*"
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
         HeadingIndex    =   1
         Height          =   336
         Index           =   -2147483648
         InitialParent   =   "Views"
         InitialValue    =   ""
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   6
         TabStop         =   True
         Tooltip         =   ""
         Top             =   60
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin ArkGSADiscoveryView GSADiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   456
         Index           =   -2147483648
         InitialParent   =   "Views"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   8
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin DesktopRadioButton SourceRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "GameServerApp.com"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   1
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
   End
   Begin Timer DiscoveryWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   100
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub ImportFile(File As FolderItem)
		  Self.QuickCancel = True
		  Self.Views.SelectedPanelIndex = 3
		  Self.LocalDiscoveryView1.AddFile(File)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Open
		  
		  Const FirstRadioIndex = 0
		  Const LastRadioIndex = 5
		  
		  Var Pos As Integer = Self.ImportSourceMessage.Top + Self.ImportSourceMessage.Height + 20
		  For Idx As Integer = FirstRadioIndex To LastRadioIndex
		    If Self.SourceRadio(Idx).Visible = False Then
		      Continue
		    End If
		    
		    Self.SourceRadio(Idx).Top = Pos
		    Pos = Pos + Self.SourceRadio(Idx).Height + 12
		  Next
		  
		  Self.SourceCancelButton.Top = Pos + 8
		  Self.SourceActionButton.Top = Self.SourceCancelButton.Top
		  Self.mSourcesPageHeight = Self.SourceCancelButton.Top + Self.SourceCancelButton.Height + 20
		  
		  Self.SwapButtons
		  Self.Reset
		End Sub
	#tag EndEvent

	#tag Event
		Sub PullValuesFromProject(Project As Beacon.Project)
		  If (Project IsA Ark.Project) = False Then
		    Return
		  End If
		  
		  Var ArkProject As Ark.Project = Ark.Project(Project)
		  Self.mDestinationProject = ArkProject
		  Self.FTPDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.LocalDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.NitradoDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.ConnectorDiscoveryView1.PullValuesFromProject(ArkProject)
		  Self.GSADiscoveryView1.PullValuesFromProject(ArkProject)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Reset()
		  For I As Integer = 0 To Self.mImporters.LastIndex
		    If Self.mImporters(I) <> Nil And Not Self.mImporters(I).Finished Then
		      Self.mImporters(I).Cancel
		    End If
		  Next
		  
		  Self.mImporters.ResizeTo(-1)
		  
		  If Self.Views.SelectedPanelIndex <> 0 Then
		    Self.Views.SelectedPanelIndex = 0
		  Else
		    Self.SetPageHeight(Self.SourcesPageHeight)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetOtherProjects(Projects() As Beacon.Project)
		  Var ArkProjects() As Ark.Project
		  For Idx As Integer = 0 To Projects.LastIndex
		    If Projects(Idx) IsA Ark.Project Then
		      ArkProjects.Add(Ark.Project(Projects(Idx)))
		    End If
		  Next Idx
		  
		  Self.mOtherProjects = ArkProjects
		  Self.SourceRadio(Self.RadioProject).Enabled = ArkProjects.Count > 0
		  Self.SourceRadio(Self.RadioProject).Caption = "Other Beacon Project" + If(Self.SourceRadio(Self.RadioProject).Enabled, "", " (No Other Projects Open)")
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Finish()
		  Var Projects() As Beacon.Project
		  For I As Integer = Self.mImporters.FirstRowIndex To Self.mImporters.LastIndex
		    If (Self.mImporters(I).Project Is Nil) = False Then
		      Projects.Add(Self.mImporters(I).Project)
		    End If
		  Next
		  Self.Finish(Projects)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Finish(Projects() As Beacon.Project)
		  If Projects.Count > 0 Then
		    For Idx As Integer = 0 To Projects.LastIndex
		      Projects(Idx).Accounts.Import(Self.mAccounts)
		    Next
		    Super.Finish(Projects)
		  End If
		  Self.Dismiss
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportFrom(Data() As Beacon.DiscoveredData)
		  Self.mImporters.ResizeTo(Data.LastIndex)
		  Self.StatusList.RowCount = Data.Count
		  
		  For I As Integer = Self.mImporters.FirstRowIndex To Self.mImporters.LastIndex
		    If (Data(I) IsA Ark.DiscoveredData) = False Then
		      Continue
		    End If
		    
		    Var Importer As New Ark.ImportThread(Ark.DiscoveredData(Data(I)), Self.mDestinationProject)
		    Importer.Start
		    Self.mImporters(I) = Importer
		    
		    Self.StatusList.CellTextAt(I, 0) = Data(I).Profile.Name + EndOfLine + "Starting parser…"
		    Self.StatusList.RowTagAt(I) = Importer
		  Next
		  
		  Self.SetThreadPriorities()
		  Self.DiscoveryWatcher.RunMode = Timer.RunModes.Multiple
		  Self.Views.SelectedPanelIndex = Self.PageStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetThreadPriorities()
		  // Dynamically adjusts thread priority depending on the number that are actively running
		  
		  Var ActiveThreads() As Ark.ImportThread
		  For Each Importer As Ark.ImportThread In Self.mImporters
		    If Importer Is Nil Then
		      Continue
		    End If
		    
		    If Importer.ThreadState <> Thread.ThreadStates.NotRunning Then
		      ActiveThreads.Add(Importer)
		    End If
		  Next
		  
		  Var Priority As Integer = If(ActiveThreads.Count > 3, Thread.LowestPriority, Thread.NormalPriority)
		  For Each Importer As Ark.ImportThread In ActiveThreads
		    If Importer.Priority <> Priority Then
		      Importer.Priority = Priority
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SourcesPageHeight() As Integer
		  Return Self.mSourcesPageHeight
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DocumentsImported(Documents() As Beacon.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinationProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImporters() As Ark.ImportThread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOtherProjects() As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourcesPageHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		QuickCancel As Boolean
	#tag EndProperty


	#tag Constant, Name = PageConnector, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageFTP, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageGSA, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLocal, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageNitrado, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageOtherDocuments, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSources, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageStatus, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioConnector, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioFTP, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioGSA, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioLocal, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioNitrado, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RadioProject, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusPageHeight, Type = Double, Dynamic = False, Default = \"456", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Views
	#tag Event
		Sub PanelChanged()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageSources
		    Self.SetPageHeight(Self.SourcesPageHeight)
		  Case Self.PageNitrado
		    NitradoDiscoveryView1.Begin
		  Case Self.PageFTP
		    FTPDiscoveryView1.Begin
		  Case Self.PageLocal
		    LocalDiscoveryView1.Begin
		  Case Self.PageStatus, Self.PageOtherDocuments
		    Self.SetPageHeight(Self.StatusPageHeight)
		  Case Self.PageConnector
		    ConnectorDiscoveryView1.Begin
		  Case Self.PageGSA
		    Self.GSADiscoveryView1.Begin
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceRadio
	#tag Event
		Sub ValueChanged(index as Integer)
		  SourceActionButton.Enabled = SourceRadio(Self.RadioNitrado).Value Or SourceRadio(Self.RadioFTP).Value Or SourceRadio(Self.RadioLocal).Value Or (SourceRadio(Self.RadioProject).Value And SourceRadio(Self.RadioProject).Enabled And Self.mOtherProjects.Count > 0) Or SourceRadio(Self.RadioConnector).Value Or SourceRadio(Self.RadioGSA).Value
		  SourceActionButton.Default = SourceActionButton.Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceCancelButton
	#tag Event
		Sub Pressed()
		  Self.Dismiss
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceActionButton
	#tag Event
		Sub Pressed()
		  Select Case True
		  Case SourceRadio(Self.RadioNitrado).Value
		    Views.SelectedPanelIndex = Self.PageNitrado
		  Case SourceRadio(Self.RadioFTP).Value
		    Views.SelectedPanelIndex = Self.PageFTP
		  Case SourceRadio(Self.RadioLocal).Value
		    Views.SelectedPanelIndex = Self.PageLocal
		  Case SourceRadio(Self.RadioConnector).Value
		    Views.SelectedPanelIndex = Self.PageConnector
		  Case SourceRadio(Self.RadioProject).Value
		    OtherDocsList.RemoveAllRows
		    OtherDocsList.ColumnTypeAt(0) = DesktopListbox.CellTypes.CheckBox
		    For Each Project As Ark.Project In Self.mOtherProjects
		      OtherDocsList.AddRow("", Project.Title)
		      OtherDocsList.RowTagAt(OtherDocsList.LastAddedRowIndex) = Project
		    Next
		    OtherDocsList.Sort()
		    OtherDocsActionButton.Enabled = False
		    Views.SelectedPanelIndex = Self.PageOtherDocuments
		  Case SourceRadio(Self.RadioGSA).Value
		    Views.SelectedPanelIndex = Self.PageGSA
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NitradoDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Data() As Beacon.DiscoveredData, Accounts As Beacon.ExternalAccountManager)
		  If Self.mAccounts = Nil Then
		    Self.mAccounts = New Beacon.ExternalAccountManager
		  End If
		  Self.mAccounts.Import(Accounts)
		  Self.ImportFrom(Data)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Ark.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events FTPDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Data() As Beacon.DiscoveredData, Accounts As Beacon.ExternalAccountManager)
		  If Self.mAccounts = Nil Then
		    Self.mAccounts = New Beacon.ExternalAccountManager
		  End If
		  Self.mAccounts.Import(Accounts)
		  Self.ImportFrom(Data)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Ark.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events LocalDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Data() As Beacon.DiscoveredData, Accounts As Beacon.ExternalAccountManager)
		  If Self.mAccounts = Nil Then
		    Self.mAccounts = New Beacon.ExternalAccountManager
		  End If
		  Self.mAccounts.Import(Accounts)
		  Self.ImportFrom(Data)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Ark.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events StatusCancelButton
	#tag Event
		Sub Pressed()
		  If Self.QuickCancel Then
		    Self.Close
		  Else
		    Self.Reset()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsActionButton
	#tag Event
		Sub Pressed()
		  Var Projects() As Beacon.Project
		  For I As Integer = 0 To OtherDocsList.RowCount - 1
		    If Not OtherDocsList.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Var Project As Ark.Project = Ark.Project(OtherDocsList.RowTagAt(I)).Clone(App.IdentityManager.CurrentIdentity)
		    If (Project Is Nil) = False Then
		      Projects.Add(Project)
		    End If
		  Next
		  Self.Finish(Projects)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsCancelButton
	#tag Event
		Sub Pressed()
		  Views.SelectedPanelIndex = Self.PageSources
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConnectorDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Finished(Data() As Beacon.DiscoveredData, Accounts As Beacon.ExternalAccountManager)
		  If Self.mAccounts = Nil Then
		    Self.mAccounts = New Beacon.ExternalAccountManager
		  End If
		  Self.mAccounts.Import(Accounts)
		  Self.ImportFrom(Data)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Ark.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  
		  If Column <> 0 Then
		    Return
		  End If
		  
		  Var Enabled As Boolean
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.CellCheckBoxValueAt(I, Column) Then
		      Enabled = True
		      Exit For I
		    End If
		  Next
		  
		  OtherDocsActionButton.Enabled = Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GSADiscoveryView1
	#tag Event
		Sub Finished(Data() As Beacon.DiscoveredData, Accounts As Beacon.ExternalAccountManager)
		  If Self.mAccounts = Nil Then
		    Self.mAccounts = New Beacon.ExternalAccountManager
		  End If
		  Self.mAccounts.Import(Accounts)
		  Self.ImportFrom(Data)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    Self.Dismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  Self.SetPageHeight(NewHeight)
		End Sub
	#tag EndEvent
	#tag Event
		Function GetDestinationProject() As Ark.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events DiscoveryWatcher
	#tag Event
		Sub Action()
		  Self.SetThreadPriorities()
		  
		  Var AllFinished As Boolean = True
		  Var ErrorCount, SuccessCount As Integer
		  For I As Integer = 0 To Self.StatusList.LastRowIndex
		    Var Importer As Ark.ImportThread = Self.StatusList.RowTagAt(I)
		    AllFinished = AllFinished And Importer.Finished
		    Self.StatusList.CellTextAt(I, 0) = Importer.Name + EndOfLine + Importer.Status
		    
		    If Importer.Finished Then
		      If Importer.Project Is Nil Then
		        ErrorCount = ErrorCount + 1
		      Else
		        SuccessCount = SuccessCount + 1
		      End If
		    End If
		  Next
		  
		  If AllFinished Then
		    Me.RunMode = Timer.RunModes.Off
		    If ErrorCount = 0 Then
		      If Preferences.PlaySoundAfterImport Then
		        SoundDeploySuccess.Play
		      End If
		      Self.Finish()
		    ElseIf SuccessCount > 0 Then
		      If Preferences.PlaySoundAfterImport Then
		        SoundDeployFailed.Play
		      End If
		      If Self.ShowConfirm("There were import errors.", "Not all files imported successfully. Do you want to continue importing with the files that did import?", "Continue Import", "Review Errors") Then
		        Self.Finish()
		      Else
		        Self.StatusActionButton.Visible = True
		        #if TargetMacOS
		          Var CancelPos As Integer = Self.StatusActionButton.Left
		          Var ActionPos As Integer = Self.StatusCancelButton.Left
		          Self.StatusCancelButton.Left = CancelPos
		          Self.StatusActionButton.Left = ActionPos
		          Self.StatusActionButton.Default = True
		        #endif
		      End If
		    Else
		      If Preferences.PlaySoundAfterImport Then
		        SoundDeployFailed.Play
		      End If
		      Self.ShowAlert("No files imported.", "Beacon was not able to import anything from the selected files.")
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
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
		Name="QuickCancel"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
