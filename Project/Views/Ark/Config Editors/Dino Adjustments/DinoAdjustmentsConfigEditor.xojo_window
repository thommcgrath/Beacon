#tag Window
Begin ArkConfigEditor DinoAdjustmentsConfigEditor
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
   Height          =   526
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   730
   Begin BeaconListbox List
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   5
      ColumnsResizable=   False
      ColumnWidths    =   "*,120,120,120,120"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   34
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      EditCaption     =   "Edit"
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   0
      Height          =   484
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Creature	Wild Damage	Wild Resistance	Tamed Damage	Tamed Resistance"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   "False"
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   730
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   730
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function ParsingFinished(Project As Ark.Project) As Boolean
		  If Document Is Nil Or Document.HasConfigGroup(BeaconConfigs.NameDinoAdjustments) = False Then
		    Return True
		  End If
		  
		  Var OtherConfig As BeaconConfigs.DinoAdjustments = BeaconConfigs.DinoAdjustments(Document.ConfigGroup(BeaconConfigs.NameDinoAdjustments))
		  If OtherConfig = Nil Then
		    Return True
		  End If
		  
		  Var Config As BeaconConfigs.DinoAdjustments = Self.Config(True)
		  Var Behaviors() As Beacon.CreatureBehavior = OtherConfig.All
		  Var Selections() As String
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Config.Add(Behavior)
		    Selections.Add(Behavior.TargetCreature.ObjectID)
		  Next
		  Self.Changed = True
		  Self.UpdateList(Selections)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub RunTask(Task As BeaconConfigs.Task)
		  Select Case Task.UUID
		  Case "614cfc80-b7aa-437d-b17e-01534f2ab778"
		    Var Changes As Integer = Self.Document.ConvertDinoReplacementsToSpawnOverrides()
		    Self.SetupUI
		    If Changes = 0 Then
		      Self.ShowAlert("No changes made", "Beacon was unable to find any replaced creatures that it could convert into spawn point additions.")
		    ElseIf Changes = 1 Then
		      Self.ShowAlert("Converted 1 creature replacement", "Beacon found 1 creature that it was able to convert into spawn point additions. The replaced creature has been disabled.")
		    Else
		      Self.ShowAlert("Converted " + Changes.ToString + " creature replacements", "Beacon found " + Changes.ToString + " creatures that it was able to convert into spawn point additions. The replaced creatures have been disabled.")
		    End If
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function ConvertCreatureReplacementsToSpawnPointAdditions() As Boolean Handles ConvertCreatureReplacementsToSpawnPointAdditions.Action
			If Self.IsFrontmost = False Then
			Return False
			End If
			
			Var Changes As Integer = Self.Document.ConvertDinoReplacementsToSpawnOverrides()
			Self.SetupUI
			If Changes = 0 Then
			Self.ShowAlert("No changes made", "Beacon was unable to find any replaced creatures that it could convert into spawn point additions.")
			ElseIf Changes = 1 Then
			Self.ShowAlert("Converted 1 creature replacement", "Beacon found 1 creature that it was able to convert into spawn point additions. The replaced creature has been disabled.")
			Else
			Self.ShowAlert("Converted " + Changes.ToString + " creature replacements", "Beacon found " + Changes.ToString + " creatures that it was able to convert into spawn point additions. The replaced creatures have been disabled.")
			End If
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.DinoAdjustments
		  Static ConfigName As String = BeaconConfigs.NameDinoAdjustments
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.DinoAdjustments
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.DinoAdjustments(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.DinoAdjustments(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.DinoAdjustments
		    Self.mConfigRef = New WeakRef(Config)
		  End If
		  
		  If ForWriting And Not Document.HasConfigGroup(ConfigName) Then
		    Document.AddConfigGroup(Config)
		  End If
		  
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  Return Language.LabelForConfig(BeaconConfigs.NameDinoAdjustments)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelected()
		  If Self.List.SelectedRowIndex = -1 Then
		    Return
		  End If
		  
		  // See the comment in ShowAdd
		  Var Creature As Beacon.Creature = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  If DinoAdjustmentDialog.Present(Self, Creature, Self.Config(False), Self.Document.Mods) Then
		    Call Self.Config(True)
		    Self.UpdateList()
		    Self.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAdd()
		  // If this returns true, the config will have changed so we should make sure it gets
		  // added to the document if it wasn't already. Calling Self.Config(True) has the
		  // side effect of doing that
		  Var Config As BeaconConfigs.DinoAdjustments = Self.Config(False)
		  If DinoAdjustmentDialog.Present(Self, Nil, Config, Self.Document.Mods) Then
		    Call Self.Config(True)
		    Self.UpdateList()
		    Self.Changed = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicate()
		  If Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.DinoAdjustments = Self.Config(False)
		  Var SelectedCreature As Beacon.Creature = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Var SelectedBehavior As Beacon.CreatureBehavior = Config.Behavior(SelectedCreature)
		  If SelectedBehavior = Nil Then
		    Return
		  End If
		  
		  Var Behaviors() As Beacon.CreatureBehavior = Config.All
		  Var CurrentCreatures() As Beacon.Creature
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Var Creature As Beacon.Creature = Behavior.TargetCreature
		    If Creature <> Nil Then
		      CurrentCreatures.Add(Creature)
		    End If
		  Next
		  
		  Var Creatures() As Beacon.Creature = ArkBlueprintSelectorDialog.Present(Self, "", CurrentCreatures, Self.Document.Mods, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  If Creatures.LastIndex = -1 Then
		    Return
		  End If
		  Config = Self.Config(True)
		  Var Selections() As String
		  For Each Creature As Beacon.Creature In Creatures
		    Var Behavior As Beacon.CreatureBehavior = SelectedBehavior.Clone(Creature)
		    Config.Add(Behavior)
		    Selections.Add(Behavior.TargetCreature.ObjectID)
		  Next
		  Self.UpdateList(Selections)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Selections() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(I) Then
		      Selections.Add(Beacon.Creature(Self.List.RowTagAt(I)).ObjectID)
		    End If
		  Next
		  Self.UpdateList(Selections)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectCreatures() As Beacon.Creature)
		  Var Selections() As String
		  For Each Creature As Beacon.Creature In SelectCreatures
		    Selections.Add(Creature.ObjectID)
		  Next
		  Self.UpdateList(Selections)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selections() As String)
		  Self.List.RemoveAllRows
		  
		  Var Behaviors() As Beacon.CreatureBehavior = Self.Config(False).All
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Var Creature As Beacon.Creature = Behavior.TargetCreature
		    Var Label As String = Creature.Label
		    
		    If Behavior.ProhibitSpawning Then
		      Label = Label + EndOfLine + "Disabled"
		      Self.List.AddRow(Label)
		    ElseIf IsNull(Behavior.ReplacementCreature) = False Then
		      Label = Label + EndOfLine + "Replaced with " + Behavior.ReplacementCreature.Label
		      Self.List.AddRow(Label)
		    Else
		      If Behavior.ProhibitTaming And Behavior.ProhibitTransfer Then
		        Label = Label + EndOfLine + "Cannot be tamed or transferred"
		      ElseIf Behavior.ProhibitTaming Then
		        Label = Label + EndOfLine + "Cannot be tamed"
		      ElseIf Behavior.ProhibitTransfer Then
		        Label = Label + EndOfLine + "Cannot be transferred"
		      End If
		      Self.List.AddRow(Label, Behavior.DamageMultiplier.ToString(Locale.Current, "0.0#####"), Behavior.ResistanceMultiplier.ToString(Locale.Current, "0.0#####"), Behavior.TamedDamageMultiplier.ToString(Locale.Current, "0.0#####"), Behavior.TamedResistanceMultiplier.ToString(Locale.Current, "0.0#####"))
		    End If
		    
		    Self.List.Selected(Self.List.LastAddedRowIndex) = Selections.IndexOf(Behavior.TargetCreature.ObjectID) > -1
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Behavior.TargetCreature
		  Next
		  
		  Self.List.Sort()
		  Self.List.EnsureSelectionIsVisible
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty


	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnTamedDamage, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnTamedResistance, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWildDamage, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWildResistance, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.creatureadjustments", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(Self.ColumnWildDamage) = Listbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnWildResistance) = Listbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnTamedDamage) = Listbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnTamedResistance) = Listbox.Alignments.Center
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And (Board.Text.IndexOf("DinoClassDamageMultipliers") > -1 Or Board.Text.IndexOf("TamedDinoClassDamageMultipliers") > -1 Or Board.Text.IndexOf("DinoClassResistanceMultipliers") > -1 Or Board.Text.IndexOf("TamedDinoClassResistanceMultipliers") > -1 Or Board.Text.IndexOf("NPCReplacements") > -1 Or Board.Text.IndexOf("PreventTransferForClassName") > -1))
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
		    
		    Var Creature As Beacon.Creature = Me.RowTagAt(I)
		    Creatures.Add(Creature)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Creatures, "creature adjustment", "creature adjustments") = False Then
		    Return
		  End If
		  
		  Var Changed As Boolean = Self.Changed
		  Var Config As BeaconConfigs.DinoAdjustments = Self.Config(True)
		  For Each Creature As Beacon.Creature In Creatures
		    Config.RemoveBehavior(Creature)
		    Changed = True
		  Next
		  
		  Self.Changed = Changed
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  Var Config As BeaconConfigs.DinoAdjustments = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Creature As Beacon.Creature = Me.RowTagAt(I)
		    Var Behavior As Beacon.CreatureBehavior = Config.Behavior(Creature)
		    If Behavior = Nil Then
		      Continue
		    End If
		    
		    Dicts.Add(Behavior.ToDictionary)
		  Next
		  
		  Board.RawData(Self.kClipboardType) = Beacon.GenerateJSON(Dicts, False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Var JSON As String = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8)
		    Var Items() As Variant
		    Try
		      Items = Beacon.ParseJSON(JSON)
		    Catch Err As RuntimeException
		    End Try
		    
		    If Items.LastIndex = -1 Then
		      Return
		    End If
		    
		    Var Config As BeaconConfigs.DinoAdjustments = Self.Config(True)
		    Var Selections() As String
		    For Each Entry As Dictionary In Items
		      Var Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior.FromDictionary(Entry)
		      If Behavior = Nil Then
		        Continue
		      End If
		      
		      Selections.Add(Behavior.TargetCreature.ObjectID)
		      Config.Add(Behavior)
		    Next
		    Self.Changed = True
		    Self.UpdateList(Selections)
		    Return
		  End If
		  
		  If Board.TextAvailable Then
		    Var ImportText As String = Board.Text.GuessEncoding
		    Self.Parse("", ImportText, "Clipboard")
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Var DuplicateButton As OmniBarItem = Self.ConfigToolbar.Item("Duplicate")
		  If (DuplicateButton Is Nil) = False Then
		    DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditSelected()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddCreature", "New Adjustment", IconToolbarAdd, "Define new creature adjustments."))
		  Me.Append(OmniBarItem.CreateButton("Duplicate", "Duplicate", IconToolbarClone, "Duplicate the selected creature adjustment.", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddCreature"
		    Self.ShowAdd()
		  Case "Duplicate"
		    Self.ShowDuplicate()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
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