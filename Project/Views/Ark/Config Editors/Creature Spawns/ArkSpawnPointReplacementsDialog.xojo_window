#tag DesktopWindow
Begin BeaconDialog ArkSpawnPointReplacementsDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
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
   Type            =   8
   Visible         =   True
   Width           =   660
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
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
      Text            =   "Replacing Creatures"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   620
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      Text            =   "Ark allows choosing a different creature to spawn whenever the target creature is chosen from this spawn set. This is most commonly used for adding Alpha creatures wherever the normal variant could spawn. With a replacement defined, the target creature will always be replaced, so if you want the target creature to still spawn, you must include it as an option here. For example, if choosing to replace Raptors with Alpha Raptors will always spawn Alpha Raptors unless you also include Raptor in the replacement creature list."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
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
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Target Creature:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   174
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   107
   End
   Begin UITweaks.ResizedLabel TargetCreatureField
      AllowAutoDeactivate=   True
      Bold            =   False
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
      Text            =   "Not Selected"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   174
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   403
   End
   Begin DesktopGroupBox ReplacementsGroup
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
         MacButtonStyle  =   0
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
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   250
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin BeaconListbox ReplacementsList
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
         ColumnWidths    =   "100,*"
         DefaultRowHeight=   -1
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
         PreferencesKey  =   ""
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   290
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   580
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
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
      MacButtonStyle  =   0
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
      MacButtonStyle  =   0
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
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		  
		  If Self.mTargetCreature <> Nil Then
		    Self.TargetCreatureField.Text = Self.mTargetCreature.Label
		    Self.TargetCreatureField.Italic = False
		    
		    Var Replacements() As Ark.Creature = Self.mSpawnSet.ReplacementCreatures(Self.mTargetCreature)
		    For Each Replacement As Ark.Creature In Replacements
		      Var Weight As NullableDouble = Self.mSpawnSet.CreatureReplacementWeight(Self.mTargetCreature, Replacement)
		      If Weight Is Nil Then
		        Continue
		      End If
		      Self.ReplacementsList.AddRow(Weight.DoubleValue.PrettyText, Replacement.Label)
		      Self.ReplacementsList.RowTagAt(Self.ReplacementsList.LastAddedRowIndex) = Replacement
		    Next
		  End If
		  
		  Self.ReplacementsList.ColumnAlignmentAt(Self.ColumnWeight) = DesktopListbox.Alignments.Right
		  Self.ReplacementsList.ColumnTypeAt(Self.ColumnWeight) = DesktopListbox.CellTypes.TextField
		  Self.ReplacementsList.SortingColumn = Self.ColumnCreature
		  Self.ReplacementsList.Sort
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Mods As Beacon.StringList, SpawnSet As Ark.MutableSpawnPointSet, TargetCreature As Ark.Creature)
		  // The target creature should not be in the defined creatures list
		  Var DefinedCreatures() As Ark.Creature = SpawnSet.ReplacedCreatures
		  
		  If TargetCreature <> Nil Then
		    For I As Integer = 0 To DefinedCreatures.LastIndex
		      If DefinedCreatures(I) = TargetCreature Then
		        DefinedCreatures.RemoveAt(I)
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
		Shared Function Present(Parent As DesktopWindow, Mods As Beacon.StringList, SpawnSet As Ark.MutableSpawnPointSet, TargetCreature As Ark.Creature = Nil) As Ark.Creature
		  If Parent = Nil Then
		    Return Nil
		  End If
		  
		  Parent = Parent.TrueWindow
		  
		  Var Win As New ArkSpawnPointReplacementsDialog(Mods, SpawnSet, TargetCreature)
		  Win.ShowModal(Parent)
		  
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
		Private mDefinedCreatures() As Ark.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnSet As Ark.MutableSpawnPointSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetCreature As Ark.Creature
	#tag EndProperty


	#tag Constant, Name = ColumnCreature, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWeight, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TargetCreatureButton
	#tag Event
		Sub Pressed()
		  Var Creatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", Self.mDefinedCreatures, Self.mMods, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If Creatures <> Nil And Creatures.LastIndex = 0 Then
		    Self.mTargetCreature = Creatures(0)
		    Self.TargetCreatureField.Text = Self.mTargetCreature.Label
		    Self.TargetCreatureField.Italic = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementAddButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Creature = Self.mSpawnSet.ReplacementCreatures(Self.mTargetCreature)
		  Var Creatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.mMods, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  Self.ReplacementsList.SelectionChangeBlocked = True
		  For Each Creature As Ark.Creature In Creatures
		    Self.ReplacementsList.AddRow("50", Creature.Label)
		    Self.ReplacementsList.RowTagAt(Self.ReplacementsList.LastAddedRowIndex) = Creature
		  Next
		  Self.ReplacementsList.Sort
		  Self.ReplacementsList.SelectionChangeBlocked = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplacementDeleteButton
	#tag Event
		Sub Pressed()
		  Self.ReplacementsList.DoClear
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
		  Var Creatures() As Ark.Creature
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Creatures.Add(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Creatures, "replacement", "replacements") = False Then
		    Return
		  End If
		  
		  For I As Integer = Bound DownTo 0
		    For X As Integer = 0 To Creatures.LastIndex
		      If Me.RowTagAt(I) = Creatures(X) Then
		        Me.RemoveRowAt(I)
		        Creatures.RemoveAt(X)
		        Continue For I
		      End If
		    Next
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.ReplacementDeleteButton.Enabled = Me.CanDelete
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.mTargetCreature = Nil Then
		    Self.ShowAlert("Please select a target creature", "Use the ""Choose…"" button to select a target creature if you wish to continue.")
		    Return
		  End If
		  
		  Var Replacements As New Dictionary
		  For I As Integer = 0 To Self.ReplacementsList.RowCount - 1
		    Var Creature As Ark.Creature = Self.ReplacementsList.RowTagAt(I)
		    Var WeightString As String = Self.ReplacementsList.CellTextAt(I, Self.ColumnWeight)
		    If IsNumeric(WeightString) = False Then
		      Self.ShowAlert("The weight value """ + WeightString + """ for " + Creature.Label + " is not a number.", "Please use only numbers for weight values.")
		      Return
		    End If
		    Var Weight As Double = CDbl(WeightString)
		    Replacements.Value(Creature) = Weight
		  Next
		  
		  Var OriginalCreatures() As Ark.Creature = Self.mSpawnSet.ReplacementCreatures(Self.mTargetCreature)
		  For Each Creature As Ark.Creature In OriginalCreatures
		    Self.mSpawnSet.CreatureReplacementWeight(Self.mTargetCreature, Creature) = Nil
		  Next
		  
		  For Each Entry As DictionaryEntry In Replacements
		    Var Creature As Ark.Creature = Entry.Key
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
		Sub Pressed()
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
#tag EndViewBehavior
