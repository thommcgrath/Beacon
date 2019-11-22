#tag Window
Begin ConfigEditor MetaDataConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   374
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   628
   Begin UITweaks.ResizedTextField TitleField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
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
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   476
   End
   Begin UITweaks.ResizedLabel TitleLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      Text            =   "Title:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin TextArea DescriptionArea
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   72
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   476
   End
   Begin UITweaks.ResizedLabel DescriptionLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Description:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin CheckBox PublicFileCheckbox
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "List this document in the community file list"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   132
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      State           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   270
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   476
   End
   Begin BeaconListbox ModsList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "26,*,100"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   1
      Height          =   120
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Mod	Console Safe"
      Italic          =   False
      Left            =   132
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   138
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   476
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedLabel ModsLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Enabled Mods:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   138
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label ModsNoteLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   86
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Does not change anything on the server, only limits which engrams are shown in lists."
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   172
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin CheckBox UncompressedCheckbox
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Disable document compression"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   "Document compression can be disabled when the plain text version is needed, such as when storing the file in a version control system."
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   132
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      State           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   302
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   476
   End
   Begin CheckBox AllowUCSCheckbox
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Generate UCS-2 files when necessary"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   "Some letters and symbols cannot be displayed using a normal ini file. UCS-2 files may be used instead, but are more difficult to work with and may display incorrectly in some text editors and host control panels."
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   132
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      State           =   0
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   334
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   476
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.Metadata.ConfigName)
		  Redim Self.Document.Mods(-1)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.TitleField.Value = Self.Document.Title
		  Self.DescriptionArea.Value = Self.Document.Description
		  Self.PublicFileCheckbox.Value = Self.Document.IsPublic
		  Self.PublicFileCheckbox.Enabled = (Self.Controller.URL.Scheme = Beacon.DocumentURL.TypeCloud)
		  Self.UncompressedCheckbox.Value = Not Self.Document.UseCompression
		  Self.AllowUCSCheckbox.Value = Self.Document.AllowUCS
		  
		  Dim Mods() As Beacon.ModDetails = LocalData.SharedInstance.AllMods
		  Dim ScrollPosition As Integer = Self.ModsList.ScrollPosition
		  Dim ListIndex As Integer = Self.ModsList.SelectedRowIndex
		  Self.ModsList.RemoveAllRows()
		  For Each Details As Beacon.ModDetails In Mods
		    Self.ModsList.AddRow("", Details.Name, If(Details.ConsoleSafe, "Yes", "No"))
		    Dim Idx As Integer = Self.ModsList.LastAddedRowIndex
		    Self.ModsList.RowTagAt(Idx) = Details
		    Self.ModsList.CellCheckBoxValueAt(Idx, 0) = Self.Document.Mods.LastRowIndex = -1 Or Self.Document.Mods.IndexOf(Details.ModID) > -1
		  Next
		  Self.ModsList.Sort
		  Self.ModsList.ScrollPosition = ScrollPosition
		  Self.ModsList.SelectedRowIndex = ListIndex
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.SetupUI()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return Language.LabelForConfig(BeaconConfigs.Metadata.ConfigName)
		End Function
	#tag EndMethod


#tag EndWindowCode

#tag Events TitleField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Document.Title = Me.Value.Trim
		  Self.Document.Metadata.IsImplicit = False
		  Self.Changed = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DescriptionArea
	#tag Event
		Sub TextChange()
		  Self.PublicFileCheckbox.Enabled = Me.Value.Trim.Length > 32
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Document.Description = Self.SanitizeText(Me.Value.Trim, False)
		  Self.Document.Metadata.IsImplicit = False
		  Self.Changed = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PublicFileCheckbox
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Document.IsPublic = Me.Value
		  Self.Document.Metadata.IsImplicit = False
		  Self.Changed = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsList
	#tag Event
		Sub Open()
		  Me.ColumnTypeAt(0) = Listbox.CellTypes.CheckBox
		  Me.ColumnAlignmentAt(2) = Listbox.Alignments.Center
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused row
		  
		  If Self.SettingUp Or Column <> 0 Then
		    Return
		  End If
		  
		  Dim AllChecked As Boolean = True
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.CellCheckBoxValueAt(I, 0) Then
		      AllChecked = False
		      Exit For I
		    End If
		  Next
		  
		  If AllChecked Then
		    Redim Self.Document.Mods(-1)
		    Self.Changed = True
		  Else
		    For I As Integer = 0 To Me.RowCount - 1
		      If Me.CellCheckBoxValueAt(I, 0) Then
		        Self.Document.Mods.Append(Beacon.ModDetails(Me.RowTagAt(I)).ModID)
		      Else
		        Self.Document.Mods.Remove(Beacon.ModDetails(Me.RowTagAt(I)).ModID)
		      End If
		    Next
		    Self.Changed = Self.Changed Or Self.Document.Mods.Modified
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UncompressedCheckbox
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Document.UseCompression = Not Me.Value
		  Self.Document.Metadata.IsImplicit = False
		  Self.Changed = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AllowUCSCheckbox
	#tag Event
		Sub Action()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Document.AllowUCS = Me.Value
		  Self.Document.Metadata.IsImplicit = False
		  Self.Changed = True
		  Self.SettingUp = False
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="LockTop"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
