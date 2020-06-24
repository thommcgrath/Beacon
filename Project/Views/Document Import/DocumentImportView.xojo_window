#tag Window
Begin ContainerControl DocumentImportView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   456
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   600
   Begin PagePanel Views
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   456
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   7
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Nitrado"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label ImportSourceMessage
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Server With FTP Access"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   148
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Single Player, Local Files, or Copy + Paste"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   116
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton SourceCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton SourceActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   False
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin NitradoDiscoveryView NitradoDiscoveryView1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   456
         HelpTag         =   ""
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
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   600
      End
      Begin FTPDiscoveryView FTPDiscoveryView1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   456
         HelpTag         =   ""
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
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   600
      End
      Begin LocalDiscoveryView LocalDiscoveryView1
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   456
         HelpTag         =   ""
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
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   600
      End
      Begin Label StatusMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
      Begin UITweaks.ResizedPushButton StatusCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   5
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton StatusActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Import"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   80
      End
      Begin RadioButton SourceRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Other Beacon document"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   180
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label OtherDocsMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
      Begin UITweaks.ResizedPushButton OtherDocsActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   6
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton OtherDocsCancelButton
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
         InitialParent   =   "Views"
         Italic          =   False
         Left            =   408
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
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ConnectorDiscoveryView ConnectorDiscoveryView1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackgroundColor=   False
         Height          =   456
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
      Begin RadioButton SourceRadio
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Server with Beacon Connector"
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
      Begin BeaconListbox StatusList
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
         Height          =   336
         HelpTag         =   ""
         Hierarchical    =   False
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
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   60
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin BeaconListbox OtherDocsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   False
         ColumnWidths    =   "26,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   26
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   1
         Height          =   336
         HelpTag         =   ""
         Hierarchical    =   False
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
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionChangeBlocked=   False
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   1
         TabPanelIndex   =   6
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   60
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         VisibleRowCount =   0
         Width           =   560
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
   Begin Timer DiscoveryWatcher
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
		  RaiseEvent Open
		  
		  #if Not Self.ConnectorEnabled
		    Self.SourceRadio(4).Top = -100
		    Self.SourceRadio(4).Visible = False
		    For I As Integer = 1 To 3
		      Self.SourceRadio(I).Top = Self.SourceRadio(I).Top - 32
		    Next
		    Self.SourceCancelButton.Top = Self.SourceRadio(3).Bottom + 12
		    Self.SourceActionButton.Top = Self.SourceCancelButton.Top
		  #endif
		  
		  Self.SwapButtons
		  Self.Reset
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Finish()
		  Var Documents() As Beacon.Document
		  For I As Integer = Self.mImporters.FirstRowIndex To Self.mImporters.LastRowIndex
		    If Self.mImporters(I).Document <> Nil Then
		      Documents.AddRow(Self.mImporters(I).Document)
		    End If
		  Next
		  Self.Finish(Documents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Finish(Documents() As Beacon.Document)
		  If Documents.LastRowIndex > -1 Then
		    For Idx As Integer = 0 To Documents.LastRowIndex
		      Documents(Idx).Accounts.Import(Self.mAccounts)
		    Next
		    RaiseEvent DocumentsImported(Documents)
		  End If
		  RaiseEvent ShouldDismiss
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(File As FolderItem)
		  Self.QuickCancel = True
		  Self.Views.SelectedPanelIndex = 3
		  Self.LocalDiscoveryView1.AddFile(File)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportFrom(Data() As Beacon.DiscoveredData)
		  Self.mImporters.ResizeTo(Data.LastRowIndex)
		  Self.StatusList.RowCount = Data.Count
		  
		  For I As Integer = Self.mImporters.FirstRowIndex To Self.mImporters.LastRowIndex
		    Var Importer As New Beacon.ImportThread(Data(I), Self.mDestinationDocument)
		    Importer.Start
		    Self.mImporters(I) = Importer
		    
		    Self.StatusList.CellValueAt(I, 0) = Data(I).Profile.Name + EndOfLine + "Starting parser…"
		    Self.StatusList.RowTagAt(I) = Importer
		  Next
		  
		  Self.DiscoveryWatcher.RunMode = Timer.RunModes.Multiple
		  Self.Views.SelectedPanelIndex = Self.PageStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PullValuesFromDocument(Document As Beacon.Document)
		  Self.mDestinationDocument = Document
		  Self.FTPDiscoveryView1.PullValuesFromDocument(Document)
		  Self.LocalDiscoveryView1.PullValuesFromDocument(Document)
		  Self.NitradoDiscoveryView1.PullValuesFromDocument(Document)
		  Self.ConnectorDiscoveryView1.PullValuesFromDocument(Document)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  For I As Integer = 0 To Self.mImporters.LastRowIndex
		    If Self.mImporters(I) <> Nil And Not Self.mImporters(I).Finished Then
		      Self.mImporters(I).Cancel
		    End If
		  Next
		  
		  Self.mImporters.ResizeTo(-1)
		  
		  If Self.Views.SelectedPanelIndex <> 0 Then
		    Self.Views.SelectedPanelIndex = 0
		  Else
		    RaiseEvent ShouldResize(Self.SourcesPageHeight - If(Self.ConnectorEnabled, 0, 32))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOtherDocuments(Documents() As Beacon.Document)
		  Self.mOtherDocuments = Documents
		  Self.SourceRadio(3).Enabled = (Not Self.mDeployRequired) And Documents.LastRowIndex > -1
		  Self.SourceRadio(3).Caption = "Other Beacon Document" + If(Self.SourceRadio(3).Enabled, "", " (No Other Documents Open)")
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DocumentsImported(Documents() As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldDismiss()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(Height As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDeployRequired
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDeployRequired = Value Then
			    Return
			  End If
			  
			  Self.mDeployRequired = Value
			  Self.SourceRadio(2).Enabled = Not Value
			  Self.SourceRadio(3).Enabled = (Not Value) And Self.mOtherDocuments.LastRowIndex > -1
			End Set
		#tag EndSetter
		DeployRequired As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeployRequired As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinationDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImporters() As Beacon.ImportThread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOtherDocuments() As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h0
		QuickCancel As Boolean
	#tag EndProperty


	#tag Constant, Name = ConnectorEnabled, Type = Boolean, Dynamic = False, Default = \"False", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PageConnector, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageFTP, Type = Double, Dynamic = False, Default = \"2", Scope = Private
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

	#tag Constant, Name = SourcesPageHeight, Type = Double, Dynamic = False, Default = \"252", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatusPageHeight, Type = Double, Dynamic = False, Default = \"456", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Views
	#tag Event
		Sub Change()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageSources
		    RaiseEvent ShouldResize(Self.SourcesPageHeight - If(Self.ConnectorEnabled, 0, 32))
		  Case Self.PageNitrado
		    NitradoDiscoveryView1.Begin
		  Case Self.PageFTP
		    FTPDiscoveryView1.Begin
		  Case Self.PageLocal
		    LocalDiscoveryView1.Begin
		  Case Self.PageStatus, Self.PageOtherDocuments
		    RaiseEvent ShouldResize(Self.StatusPageHeight)
		  Case Self.PageConnector
		    ConnectorDiscoveryView1.Begin
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceRadio
	#tag Event
		Sub Action(index as Integer)
		  SourceActionButton.Enabled = SourceRadio(0).Value Or SourceRadio(1).Value Or SourceRadio(2).Value Or (SourceRadio(3).Value And SourceRadio(3).Enabled And Self.mOtherDocuments.LastRowIndex > -1) Or SourceRadio(4).Value
		  SourceActionButton.Default = SourceActionButton.Enabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceCancelButton
	#tag Event
		Sub Action()
		  RaiseEvent ShouldDismiss
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SourceActionButton
	#tag Event
		Sub Action()
		  Select Case True
		  Case SourceRadio(0).Value
		    Views.SelectedPanelIndex = Self.PageNitrado
		  Case SourceRadio(1).Value
		    Views.SelectedPanelIndex = Self.PageFTP
		  Case SourceRadio(2).Value
		    Views.SelectedPanelIndex = Self.PageLocal
		  Case SourceRadio(4).Value
		    Views.SelectedPanelIndex = Self.PageConnector
		  Case SourceRadio(3).Value
		    OtherDocsList.RemoveAllRows
		    OtherDocsList.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		    For Each Doc As Beacon.Document In Self.mOtherDocuments
		      OtherDocsList.AddRow("", Doc.Title)
		      OtherDocsList.RowTagAt(OtherDocsList.LastAddedRowIndex) = Doc
		    Next
		    OtherDocsList.Sort()
		    OtherDocsActionButton.Enabled = False
		    Views.SelectedPanelIndex = Self.PageOtherDocuments
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NitradoDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    RaiseEvent ShouldDismiss
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
		  RaiseEvent ShouldResize(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FTPDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    RaiseEvent ShouldDismiss
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
		  RaiseEvent ShouldResize(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LocalDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    RaiseEvent ShouldDismiss
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
		  RaiseEvent ShouldResize(NewHeight)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StatusCancelButton
	#tag Event
		Sub Action()
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
		Sub Action()
		  Var Documents() As Beacon.Document
		  For I As Integer = 0 To OtherDocsList.RowCount - 1
		    If Not OtherDocsList.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Var Doc As Beacon.Document = OtherDocsList.RowTagAt(I)
		    Documents.AddRow(Doc)
		  Next
		  Self.Finish(Documents)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OtherDocsCancelButton
	#tag Event
		Sub Action()
		  Views.SelectedPanelIndex = Self.PageSources
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConnectorDiscoveryView1
	#tag Event
		Sub ShouldCancel()
		  If Self.QuickCancel Then
		    RaiseEvent ShouldDismiss
		  Else
		    Views.SelectedPanelIndex = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldResize(NewHeight As Integer)
		  RaiseEvent ShouldResize(NewHeight)
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
#tag Events DiscoveryWatcher
	#tag Event
		Sub Action()
		  Var AllFinished As Boolean = True
		  Var ErrorCount, SuccessCount As Integer
		  For I As Integer = 0 To Self.StatusList.LastRowIndex
		    Var Importer As Beacon.ImportThread = Self.StatusList.RowTagAt(I)
		    AllFinished = AllFinished And Importer.Finished
		    Self.StatusList.CellValueAt(I, 0) = Importer.Name + EndOfLine + Importer.Status
		    
		    If Importer.Finished Then
		      If Importer.Document Is Nil Then
		        ErrorCount = ErrorCount + 1
		      Else
		        SuccessCount = SuccessCount + 1
		      End If
		    End If
		  Next
		  
		  If AllFinished Then
		    Me.RunMode = Timer.RunModes.Off
		    If ErrorCount = 0 Then
		      Self.Finish()
		    ElseIf SuccessCount > 0 Then
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
		      Self.ShowAlert("No files imported.", "Beacon was not able to import anything from the selected files.")
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Type="Color"
		EditorType="Color"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
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
	#tag ViewProperty
		Name="DeployRequired"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
