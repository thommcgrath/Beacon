#tag Window
Begin ConfigEditor MetaDataConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      RowCount        =   0
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
		  Self.TitleField.Text = Self.Document.Title
		  Self.DescriptionArea.Text = Self.Document.Description
		  Self.PublicFileCheckbox.Value = Self.Document.IsPublic
		  Self.PublicFileCheckbox.Enabled = (Self.Controller.URL.Scheme = Beacon.DocumentURL.TypeCloud)
		  Self.UncompressedCheckbox.Value = Not Self.Document.UseCompression
		  Self.AllowUCSCheckbox.Value = Self.Document.AllowUCS
		  
		  Dim Mods() As Beacon.ModDetails = LocalData.SharedInstance.AllMods
		  Dim ScrollPosition As Integer = Self.ModsList.ScrollPosition
		  Dim ListIndex As Integer = Self.ModsList.ListIndex
		  Self.ModsList.DeleteAllRows()
		  For Each Details As Beacon.ModDetails In Mods
		    Self.ModsList.AddRow("", Details.Name, If(Details.ConsoleSafe, "Yes", "No"))
		    Dim Idx As Integer = Self.ModsList.LastIndex
		    Self.ModsList.RowTag(Idx) = Details
		    Self.ModsList.CellCheck(Idx, 0) = Self.Document.Mods.Ubound = -1 Or Self.Document.Mods.IndexOf(Details.ModID) > -1
		  Next
		  Self.ModsList.Sort
		  Self.ModsList.ScrollPosition = ScrollPosition
		  Self.ModsList.ListIndex = ListIndex
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Auto = Nil)
		  #Pragma Unused UserData
		  
		  Self.SetupUI()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigLabel() As Text
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
		  Self.Document.Title = Trim(Me.Text).ToText
		  Self.Document.Metadata.IsImplicit = False
		  Self.ContentsChanged = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DescriptionArea
	#tag Event
		Sub TextChange()
		  Self.PublicFileCheckbox.Enabled = Trim(Me.Text).Len > 32
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Document.Description = Self.SanitizeText(Trim(Me.Text), False).ToText
		  Self.Document.Metadata.IsImplicit = False
		  Self.ContentsChanged = True
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
		  Self.ContentsChanged = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModsList
	#tag Event
		Sub Open()
		  Me.ColumnType(0) = Listbox.TypeCheckbox
		  Me.ColumnAlignment(2) = Listbox.AlignCenter
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused row
		  
		  If Self.SettingUp Or Column <> 0 Then
		    Return
		  End If
		  
		  Dim AllChecked As Boolean = True
		  For I As Integer = 0 To Me.ListCount - 1
		    If Not Me.CellCheck(I, 0) Then
		      AllChecked = False
		      Exit For I
		    End If
		  Next
		  
		  If AllChecked Then
		    Redim Self.Document.Mods(-1)
		    Self.ContentsChanged = True
		  Else
		    For I As Integer = 0 To Me.ListCount - 1
		      If Me.CellCheck(I, 0) Then
		        Self.Document.Mods.Append(Beacon.ModDetails(Me.RowTag(I)).ModID)
		      Else
		        Self.Document.Mods.Remove(Beacon.ModDetails(Me.RowTag(I)).ModID)
		      End If
		    Next
		    Self.ContentsChanged = Self.ContentsChanged Or Self.Document.Mods.Modified
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
		  Self.ContentsChanged = True
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
		  Self.ContentsChanged = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Progress"
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
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
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
