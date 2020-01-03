#tag Window
Begin BeaconDialog SpawnPointReplacementsDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "1"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   512
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   660
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   512
   MinimumWidth    =   660
   Resizeable      =   True
   Title           =   "Creature Replacements"
   Type            =   "8"
   Visible         =   True
   Width           =   660
   Begin Label MessageLabel
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
      InitialParent   =   ""
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
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Replacing Creatures"
      Visible         =   True
      Width           =   620
   End
   Begin Label ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   110
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Value           =   "Ark allows choosing a different creature to spawn whenever the target creature is chosen from this spawn set. This is most commonly used for adding Alpha creatures wherever the normal variant could spawn. With a replacement defined, the target creature will always be replaced, so if you want the target creature to still spawn, you must include it as an option here. For example, if choosing to replace Raptors with Alpha Raptors will always spawn Alpha Raptors unless you also include Raptor in the replacement creature list."
      Visible         =   True
      Width           =   620
   End
   Begin UITweaks.ResizedPushButton TargetCreatureButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   139
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   174
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   86
   End
   Begin UITweaks.ResizedLabel TargetCreatureLabel
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   174
      Transparent     =   False
      Underline       =   False
      Value           =   "Target Creature:"
      Visible         =   True
      Width           =   107
   End
   Begin UITweaks.ResizedLabel TargetCreatureField
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
      Italic          =   True
      Left            =   237
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   174
      Transparent     =   False
      Underline       =   False
      Value           =   "Not Selected"
      Visible         =   True
      Width           =   403
   End
   Begin GroupBox ReplacementsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Replacement Creatures"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   238
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   214
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   620
      Begin UITweaks.ResizedPushButton ReplacementAddButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add Creature…"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ReplacementsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   250
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin BeaconListbox ReplacementsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   2
         ColumnWidths    =   "100,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         DropIndicatorVisible=   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontalStyle=   "0"
         GridLinesVerticalStyle=   "0"
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   142
         Index           =   -2147483648
         InitialParent   =   "ReplacementsGroup"
         InitialValue    =   "Weight	Creature"
         Italic          =   False
         Left            =   40
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   "1"
         Scope           =   2
         SelectionChangeBlocked=   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   290
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   580
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin UITweaks.ResizedPushButton ReplacementDeleteButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Delete"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ReplacementsGroup"
         Italic          =   False
         Left            =   172
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   250
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   560
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   472
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
      Left            =   468
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   472
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  If Self.mTargetCreature <> Nil Then
		    Self.TargetCreatureField.Value = Self.mTargetCreature.Label
		    Self.TargetCreatureField.Italic = False
		    
		    Var Replacements() As Beacon.Creature = Self.mSpawnSet.ReplacementCreatures(Self.mTargetCreature)
		    For Each Replacement As Beacon.Creature In Replacements
		      Var Weight As Double = Self.mSpawnSet.CreatureReplacementWeight(Self.mTargetCreature, Replacement)
		      Self.ReplacementsList.AddRow(Weight.PrettyText, Replacement.Label)
		      Self.ReplacementsList.RowTagAt(Self.ReplacementsList.LastRowIndex) = Replacement
		    Next
		  End If
		  
		  Self.ReplacementsList.ColumnAlignmentAt(Self.ColumnWeight) = Listbox.Alignments.Right
		  Self.ReplacementsList.ColumnTypeAt(Self.ColumnWeight) = Listbox.CellTypes.TextField
		  Self.ReplacementsList.SortingColumn = Self.ColumnCreature
		  Self.ReplacementsList.Sort
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Mods As Beacon.StringList, SpawnSet As Beacon.MutableSpawnPointSet, TargetCreature As Beacon.Creature)
		  // The target creature should not be in the defined creatures list
		  Var DefinedCreatures() As Beacon.Creature = SpawnSet.ReplacedCreatures
		  
		  If TargetCreature <> Nil Then
		    For I As Integer = 0 To DefinedCreatures.LastRowIndex
		      If DefinedCreatures(I) = TargetCreature Then
		        DefinedCreatures.RemoveRowAt(I)
		        Exit
		      End If
		    Next
		  End If
		  
		  Self.mMods = Mods
		  Self.mDefinedCreatures = DefinedCreatures
		  Self.mTargetCreature = TargetCreature
		  Self.mSpawnSet = SpawnSet
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Mods As Beacon.StringList, SpawnSet As Beacon.MutableSpawnPointSet, TargetCreature As Beacon.Creature = Nil) As Beacon.Creature
		  If Parent = Nil Then
		    Return Nil
		  End If
		  
		  Parent = Parent.TrueWindow
		  
		  Var Win As New SpawnPointReplacementsDialog(Mods, SpawnSet, TargetCreature)
		  Win.ShowModalWithin(Parent)
		  
		  If Win.mCancelled Then
		    Win.Close
		    Return Nil
		  End If
		  
		  TargetCreature = Win.mTargetCreature
		  Win.Close
		  
		  Return TargetCreature
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefinedCreatures() As Beacon.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnSet As Beacon.MutableSpawnPointSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetCreature As Beacon.Creature
	#tag EndProperty


	#tag Constant, Name = ColumnCreature, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWeight, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TargetCreatureButton
	#tag Event
		Sub Action()
		  Var Creatures() As Beacon.Creature = EngramSelectorDialog.Present(Self, "", Self.mDefinedCreatures, False)
		  If Creatures <> Nil And Creatures.LastRowIndex = 0 Then
		    Self.mTargetCreature = Creatures(0)
		    Self.TargetCreatureField.Value = Self.mTargetCreature.Label
		    Self.TargetCreatureField.Italic = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementAddButton
	#tag Event
		Sub Action()
		  Var Exclude() As Beacon.Creature = Self.mSpawnSet.ReplacementCreatures(Self.mTargetCreature)
		  Var Creatures() As Beacon.Creature = EngramSelectorDialog.Present(Self, "", Exclude, Self.mMods, True)
		  Self.ReplacementsList.SelectionChangeBlocked = True
		  For Each Creature As Beacon.Creature In Creatures
		    Self.ReplacementsList.AddRow("50", Creature.Label)
		    Self.ReplacementsList.RowTagAt(Self.ReplacementsList.LastRowIndex) = Creature
		  Next
		  Self.ReplacementsList.Sort
		  Self.ReplacementsList.SelectionChangeBlocked = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementsList
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Creatures() As Beacon.Creature
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Creatures.AddRow(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Creatures, "replacement", "replacements") = False Then
		    Return
		  End If
		  
		  For I As Integer = Bound DownTo 0
		    For X As Integer = 0 To Creatures.LastRowIndex
		      If Me.RowTagAt(I) = Creatures(X) Then
		        Me.RemoveRowAt(I)
		        Creatures.RemoveRowAt(X)
		        Continue For I
		      End If
		    Next
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.ReplacementDeleteButton.Enabled = Me.CanDelete
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementDeleteButton
	#tag Event
		Sub Action()
		  Self.ReplacementsList.DoClear
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If Self.mTargetCreature = Nil Then
		    Self.ShowAlert("Please select a target creature", "Use the ""Choose…"" button to select a target creature if you wish to continue.")
		    Return
		  End If
		  
		  Var Replacements As New Dictionary
		  For I As Integer = 0 To Self.ReplacementsList.RowCount - 1
		    Var Creature As Beacon.Creature = Self.ReplacementsList.RowTagAt(I)
		    Var WeightString As String = Self.ReplacementsList.CellValueAt(I, Self.ColumnWeight)
		    If IsNumeric(WeightString) = False Then
		      Self.ShowAlert("The weight value """ + WeightString + """ for " + Creature.Label + " is not a number.", "Please use only numbers for weight values.")
		      Return
		    End If
		    Var Weight As Double = CDbl(WeightString)
		    Replacements.Value(Creature) = Weight
		  Next
		  
		  Var OriginalCreatures() As Beacon.Creature = Self.mSpawnSet.ReplacementCreatures(Self.mTargetCreature)
		  For Each Creature As Beacon.Creature In OriginalCreatures
		    Self.mSpawnSet.CreatureReplacementWeight(Self.mTargetCreature, Creature) = Nil
		  Next
		  
		  For Each Entry As DictionaryEntry In Replacements
		    Var Creature As Beacon.Creature = Entry.Key
		    Var Weight As Double = Entry.Value
		    Self.mSpawnSet.CreatureReplacementWeight(Self.mTargetCreature, Creature) = Weight
		  Next
		  
		  Self.mCancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.mCancelled = True
		  Self.Hide
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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		InitialValue="600"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
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
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
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
#tag EndViewBehavior
