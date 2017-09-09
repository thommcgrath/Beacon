#tag Window
Begin BeaconSubview PresetEditorView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   556
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
   Width           =   766
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Preset"
      CaptionEnabled  =   False
      CaptionIsButton =   False
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      HasResizer      =   False
      Height          =   41
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   766
   End
   Begin TabPanel Panel
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   483
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Panels          =   ""
      Scope           =   2
      SmallTabs       =   False
      TabDefinition   =   "Contents\rSettings"
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   53
      Underline       =   False
      Value           =   0
      Visible         =   True
      Width           =   726
      Begin BeaconListbox ContentsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   False
         ColumnWidths    =   "*,100,100"
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
         Height          =   425
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Engram	Quantity	Quality"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   2
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   1
         ShowDropIndicator=   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   91
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   462
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin GroupBox AvailabilityGroup
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Map Availability"
         Enabled         =   False
         Height          =   204
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   514
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   91
         Underline       =   False
         Visible         =   True
         Width           =   212
         Begin CheckBox AvailabilityChecks
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "The Island"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   1
            InitialParent   =   "AvailabilityGroup"
            Italic          =   False
            Left            =   534
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   127
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   172
         End
         Begin CheckBox AvailabilityChecks
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Scorched Earth"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   2
            InitialParent   =   "AvailabilityGroup"
            Italic          =   False
            Left            =   534
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   159
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   172
         End
         Begin CheckBox AvailabilityChecks
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Abberation"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   16
            InitialParent   =   "AvailabilityGroup"
            Italic          =   False
            Left            =   534
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   2
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   191
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   172
         End
         Begin CheckBox AvailabilityChecks
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "The Center"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   4
            InitialParent   =   "AvailabilityGroup"
            Italic          =   False
            Left            =   534
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   3
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   223
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   172
         End
         Begin CheckBox AvailabilityChecks
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Ragnarok"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   8
            InitialParent   =   "AvailabilityGroup"
            Italic          =   False
            Left            =   534
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   4
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   255
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   172
         End
      End
      Begin GroupBox OverridesGroup
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Overrides"
         Enabled         =   False
         Height          =   108
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   514
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
         Top             =   307
         Underline       =   False
         Visible         =   True
         Width           =   212
         Begin CheckBox LockQualityCheck
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Do Not Adjust Quality"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "OverridesGroup"
            Italic          =   False
            Left            =   534
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   343
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   172
         End
         Begin CheckBox LockQuantityCheck
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Do Not Adjust Quantity"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "OverridesGroup"
            Italic          =   False
            Left            =   534
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   375
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   172
         End
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.UpdateUI()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddEntriesToList(Entries() As Beacon.PresetEntry)
		  For Each Entry As Beacon.PresetEntry In Entries
		    Self.ContentsList.AddRow("")
		    Self.PutEntryInRow(Entry, Self.ContentsList.LastIndex)
		  Next
		  Self.ContentsList.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Preset As Beacon.Preset) As PresetEditorView
		  Dim View As New PresetEditorView
		  View.mPreset = New Beacon.MutablePreset(Preset)
		  Return View
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinHeight() As UInteger
		  Return 455
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinWidth() As UInteger
		  Return 700
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PutEntryInRow(Entry As Beacon.PresetEntry, Index As Integer, SelectIt As Boolean = False)
		  If Index = -1 Then
		    Self.ContentsList.AddRow("")
		    Index = Self.ContentsList.LastIndex
		  End If
		  
		  Self.ContentsList.RowTag(Index) = Entry
		  Self.ContentsList.Cell(Index, Self.ColumnDescription) = Entry.Label
		  Self.ContentsList.Cell(Index, Self.ColumnQuantity) = if(Entry.MinQuantity = Entry.MaxQuantity, Format(Entry.MinQuantity, "0"), Format(Entry.MinQuantity, "0") + "-" + Format(Entry.MaxQuantity, "0"))
		  Self.ContentsList.Cell(Index, Self.ColumnQuality) = if(Entry.MinQuality = Entry.MaxQuality, Language.LabelForQuality(Entry.MinQuality), Language.LabelForQuality(Entry.MinQuality).Left(4) + "-" + Language.LabelForQuality(Entry.MaxQuality).Left(4))
		  
		  If SelectIt Then
		    Self.ContentsList.Selected(Index) = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedEntries() As Beacon.PresetEntry()
		  Dim Entries() As Beacon.PresetEntry
		  For I As Integer = Self.ContentsList.ListCount - 1 DownTo 0
		    If Self.ContentsList.Selected(I) Then
		      Entries.Append(Self.ContentsList.RowTag(I))
		    End If
		  Next
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.Header.Caption = Self.mPreset.Label
		  Self.mUpdating = True
		  Self.ContentsChanged = False
		  
		  For Each Entry As Beacon.PresetEntry In Self.mPreset
		    Self.PutEntryInRow(Entry, -1)
		  Next
		  Self.ContentsList.Sort
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPreset As Beacon.MutablePreset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


	#tag Constant, Name = ColumnDescription, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageContents, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSettings, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Panel
	#tag Event
		Sub Open()
		  Me.FixTabFont
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentsList
	#tag Event
		Sub Change()
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  
		  If Me.SelCount = 0 Then
		    Self.mUpdating = True
		    AvailabilityGroup.Enabled = False
		    OverridesGroup.Enabled = False
		    LockQualityCheck.State = Checkbox.CheckedStates.Unchecked
		    LockQuantityCheck.State = Checkbox.CheckedStates.Unchecked
		    For Each Map As Beacon.Map In Maps
		      If AvailabilityChecks(Map.Mask) <> Nil Then
		        AvailabilityChecks(Map.Mask).State = Checkbox.CheckedStates.Unchecked
		      End If
		    Next
		    Self.mUpdating = False
		    Return
		  End If
		  
		  Self.mUpdating = True
		  AvailabilityGroup.Enabled = True
		  OverridesGroup.Enabled = True
		  
		  Dim Entries() As Beacon.PresetEntry = Self.SelectedEntries()
		  
		  LockQualityCheck.State = if(Not Entries(0).RespectQualityModifier, Checkbox.CheckedStates.Checked, Checkbox.CheckedStates.Unchecked)
		  LockQuantityCheck.State = if(Not Entries(0).RespectQuantityMultiplier, Checkbox.CheckedStates.Checked, Checkbox.CheckedStates.Unchecked)
		  For Each Map As Beacon.Map In Maps
		    If AvailabilityChecks(Map.Mask) <> Nil Then
		      AvailabilityChecks(Map.Mask).State = if(Entries(0).ValidForMap(Map), Checkbox.CheckedStates.Checked, Checkbox.CheckedStates.Unchecked)
		    End If
		  Next
		  
		  For I As Integer = Entries.Ubound DownTo 1
		    LockQualityCheck.State = if(if(Not Entries(I).RespectQualityModifier, Checkbox.CheckedStates.Checked, Checkbox.CheckedStates.Unchecked) = LockQualityCheck.State, LockQualityCheck.State, Checkbox.CheckedStates.Indeterminate)
		    LockQuantityCheck.State = if(if(Not Entries(I).RespectQuantityMultiplier, Checkbox.CheckedStates.Checked, Checkbox.CheckedStates.Unchecked) = LockQuantityCheck.State, LockQuantityCheck.State, Checkbox.CheckedStates.Indeterminate)
		    For Each Map As Beacon.Map In Maps
		      If AvailabilityChecks(Map.Mask) <> Nil Then
		        AvailabilityChecks(Map.Mask).State = if(if(Entries(I).ValidForMap(Map), Checkbox.CheckedStates.Checked, Checkbox.CheckedStates.Unchecked) = AvailabilityChecks(Map.Mask).State, AvailabilityChecks(Map.Mask).State, Checkbox.CheckedStates.Indeterminate)
		      End If
		    Next
		  Next
		  Self.mUpdating = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AvailabilityChecks
	#tag Event
		Sub Action(index as Integer)
		  If Self.mUpdating = True Or Me.State = Checkbox.CheckedStates.Indeterminate Then
		    Return
		  End If
		  
		  Dim Entries() As Beacon.PresetEntry = Self.SelectedEntries()
		  If Entries.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim Map As Beacon.Map = Beacon.Maps.ForMask(Index)
		  For Each Entry As Beacon.PresetEntry In Entries
		    If Entry.ValidForMap(Map) <> Me.Value Then
		      Entry.ValidForMap(Map) = Me.Value
		      Self.ContentsChanged = True
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
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
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
