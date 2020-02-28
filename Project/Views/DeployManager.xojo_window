#tag Window
Begin BeaconAutopositionWindow DeployManager
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "2"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   550
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   550
   MinimumWidth    =   800
   Resizeable      =   True
   Title           =   "Deploy"
   Type            =   "0"
   Visible         =   True
   Width           =   800
   Begin BeaconListbox ServerList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "22,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   "0"
      Scope           =   2
      SelectionChangeBlocked=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   300
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator ServerListSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   550
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   301
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   499
      Begin Label OptionsMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   321
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
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   201
         Transparent     =   False
         Underline       =   False
         Value           =   "Choose Deploy Options"
         Visible         =   True
         Width           =   459
      End
      Begin CheckBox CreateBackupCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Back up Game.ini and GameUserSettings.ini before making changes"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   321
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
         Top             =   233
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   459
      End
      Begin CheckBox ReviewChangesCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Allow me to review changes before updating server"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   321
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
         Top             =   265
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   "0"
         Width           =   459
      End
      Begin PushButton OptionsActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Begin"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   700
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   329
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin CheckBox RunAdvisorCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Run advisor on content before updating server"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   321
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
         Top             =   297
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   False
         VisualState     =   "0"
         Width           =   459
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.Title = "Deploy: " + Self.Document.Title
		  
		  Self.CreateBackupCheckbox.Value = Preferences.DeployCreateBackup
		  Self.ReviewChangesCheckbox.Value = Preferences.DeployReviewChanges
		  Self.RunAdvisorCheckbox.Value = Preferences.DeployRunAdvisor
		  
		  Var ProfileBound As Integer = Self.Document.ServerProfileCount - 1
		  For Idx As Integer = 0 To ProfileBound
		    Var Profile As Beacon.ServerProfile = Self.Document.ServerProfile(Idx)
		    Var Label As String = Profile.Name
		    If Profile.SecondaryName.Length > 0 Then
		      Label = Label + EndOfLine + Profile.SecondaryName
		    End If
		    Self.ServerList.AddRow("", Label)
		    Self.ServerList.RowTagAt(Self.ServerList.LastAddedRowIndex) = Profile
		    Self.ServerList.CellCheckBoxValueAt(Self.ServerList.LastAddedRowIndex, 0) = Profile.Enabled
		  Next
		  
		  Self.ServerList.DefaultRowHeight = BeaconListbox.DoubleLineRowHeight
		  Self.ServerList.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		  Self.ServerList.SortingColumn = 1
		  Self.ServerList.Sort
		  
		  Self.CheckOptionsActionEnabled
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateControlPositions()
		  Const MaxOptionsWidth = 460
		  
		  Var AvailableWidth As Integer = Self.Pages.Width - 20
		  Var OptionsWidth As Integer = Min(AvailableWidth, MaxOptionsWidth)
		  Var OptionsLeft As Integer = Round((AvailableWidth - OptionsWidth) / 2)
		  Self.OptionsMessageLabel.Left = Self.Pages.Left + OptionsLeft
		  Self.OptionsMessageLabel.Width = OptionsWidth
		  Self.CreateBackupCheckbox.Left = Self.Pages.Left + OptionsLeft
		  Self.CreateBackupCheckbox.Width = OptionsWidth
		  Self.ReviewChangesCheckbox.Left = Self.Pages.Left + OptionsLeft
		  Self.ReviewChangesCheckbox.Width = OptionsWidth
		  Self.RunAdvisorCheckbox.Left = Self.Pages.Left + OptionsLeft
		  Self.RunAdvisorCheckbox.Width = OptionsWidth
		  Self.OptionsActionButton.Left = (Self.Pages.Left + OptionsLeft + OptionsWidth) - Self.OptionsActionButton.Width
		  
		  Var OptionControlsHeight As Integer = Self.OptionsMessageLabel.Height + 12 + Self.OptionsActionButton.Height
		  If Self.CreateBackupCheckbox.Visible Then
		    OptionControlsHeight = OptionControlsHeight + 12 + Self.CreateBackupCheckbox.Height
		  End If
		  If Self.ReviewChangesCheckbox.Visible Then
		    OptionControlsHeight = OptionControlsHeight + 12 + Self.ReviewChangesCheckbox.Height
		  End If
		  If Self.RunAdvisorCheckbox.Visible Then
		    OptionControlsHeight = OptionControlsHeight + 12 + Self.RunAdvisorCheckbox.Height
		  End If
		  
		  Var OptionControlsTop As Integer = Round((Self.Pages.Height - OptionControlsHeight) / 2) + Self.Pages.Top
		  Self.OptionsMessageLabel.Top = OptionControlsTop
		  Var Pos As Integer = Self.OptionsMessageLabel.Top + Self.OptionsMessageLabel.Height
		  If Self.CreateBackupCheckbox.Visible Then
		    Self.CreateBackupCheckbox.Top = Pos + 12
		    Pos = Pos + 12 + Self.CreateBackupCheckbox.Height
		  End If
		  If Self.ReviewChangesCheckbox.Visible Then
		    Self.ReviewChangesCheckbox.Top = Pos + 12
		    Pos = Pos + 12 + Self.ReviewChangesCheckbox.Height
		  End If
		  If Self.RunAdvisorCheckbox.Visible Then
		    Self.RunAdvisorCheckbox.Top = Pos + 12
		    Pos = Pos + 12 + Self.RunAdvisorCheckbox.Height
		  End If
		  Self.OptionsActionButton.Top = Pos + 12
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckOptionsActionEnabled()
		  Var Enabled As Boolean
		  For I As Integer = 0 To Self.ServerList.LastRowIndex
		    If Self.ServerList.CellCheckBoxValueAt(I, 0) Then
		      Enabled = True
		      Exit For I
		    End If
		  Next
		  
		  If Self.OptionsActionButton.Enabled <> Enabled Then
		    Self.OptionsActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Document As Beacon.Document)
		  Self.Document = Document
		  Super.Constructor
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Document As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Working As Boolean
	#tag EndProperty


	#tag Constant, Name = PageLog, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageOptions, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ServerList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> 0 Then
		    Return
		  End If
		  
		  Var Profile As Beacon.ServerProfile = Me.RowTagAt(Row)
		  Profile.Enabled = Me.CellCheckBoxValueAt(Row, Column)
		  
		  Self.CheckOptionsActionEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CreateBackupCheckbox
	#tag Event
		Sub Action()
		  If Self.Opened Then
		    Preferences.DeployCreateBackup = Me.Value
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReviewChangesCheckbox
	#tag Event
		Sub Action()
		  If Self.Opened Then
		    Preferences.DeployReviewChanges = Me.Value
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RunAdvisorCheckbox
	#tag Event
		Sub Action()
		  If Self.Opened Then
		    Preferences.DeployRunAdvisor = Me.Value
		  End If
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
