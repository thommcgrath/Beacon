#tag Window
Begin ConfigEditor DinoAdjustmentsConfigEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   526
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
   Visible         =   True
   Width           =   730
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Creature Adjustments"
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "False"
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   False
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   730
   End
   Begin FadedSeparator HeaderSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   "False"
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   1
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
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   730
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
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
      DropIndicatorVisible=   False
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontal=   "0"
      GridLinesHorizontalStyle=   "0"
      GridLinesVertical=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   False
      HasHeader       =   True
      HasHeading      =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   485
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
      RequiresSelection=   False
      RowCount        =   "0"
      RowSelectionType=   "1"
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionRequired=   False
      SelectionType   =   "1"
      ShowDropIndicator=   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   40
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   730
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub ParsingFinished(ParsedData As Dictionary)
		  If ParsedData = Nil Then
		    Return
		  End If
		  
		  Dim OtherConfig As BeaconConfigs.DinoAdjustments = BeaconConfigs.DinoAdjustments.FromImport(ParsedData, New Dictionary, Self.Document.MapCompatibility, Self.Document.Difficulty)
		  If OtherConfig = Nil Then
		    Return
		  End If
		  
		  Dim Config As BeaconConfigs.DinoAdjustments = Self.Config(True)
		  Dim Behaviors() As Beacon.CreatureBehavior = OtherConfig.All
		  Dim Classes() As String
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Config.Behavior(Behavior.TargetClass) = Behavior
		    Classes.Append(Behavior.TargetClass)
		  Next
		  Self.Changed = True
		  Self.UpdateList(Classes)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.DinoAdjustments.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.DinoAdjustments
		  Static ConfigName As String = BeaconConfigs.DinoAdjustments.ConfigName
		  
		  Dim Document As Beacon.Document = Self.Document
		  Dim Config As BeaconConfigs.DinoAdjustments
		  
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
		  Return Language.LabelForConfig(BeaconConfigs.DinoAdjustments.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelected()
		  If Self.List.SelectedIndex = -1 Then
		    Return
		  End If
		  
		  // See the comment in ShowAdd
		  Dim ClassString As String = Self.List.RowTag(Self.List.SelectedIndex)
		  If DinoAdjustmentDialog.Present(Self, ClassString, Self.Config(False), Self.Document.Mods) Then
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
		  Dim Config As BeaconConfigs.DinoAdjustments = Self.Config(False)
		  If DinoAdjustmentDialog.Present(Self, "", Config, Self.Document.Mods) Then
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
		  
		  Dim Config As BeaconConfigs.DinoAdjustments = Self.Config(False)
		  Dim SelectedClass As String = Self.List.RowTag(Self.List.SelectedIndex)
		  Dim SelectedBehavior As Beacon.CreatureBehavior = Config.Behavior(SelectedClass)
		  If SelectedBehavior = Nil Then
		    Return
		  End If
		  
		  Dim Behaviors() As Beacon.CreatureBehavior = Config.All
		  Dim CurrentCreatures() As Beacon.Creature
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Dim Creature As Beacon.Creature = Behavior.TargetCreature
		    If Creature <> Nil Then
		      CurrentCreatures.Append(Creature)
		    End If
		  Next
		  
		  Dim Creatures() As Beacon.Creature = EngramSelectorDialog.Present(Self, "", CurrentCreatures, True)
		  If Creatures.Ubound = -1 Then
		    Return
		  End If
		  Config = Self.Config(True)
		  Dim SelectClasses() As String
		  For Each Creature As Beacon.Creature In Creatures
		    Dim Behavior As Beacon.CreatureBehavior = SelectedBehavior.Clone(Creature.ClassString)
		    Config.Behavior(Behavior.TargetClass) = Behavior
		    SelectClasses.Append(Behavior.TargetClass)
		  Next
		  Self.UpdateList(SelectClasses)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Dim Classes() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(I) Then
		      Classes.Append(Self.List.RowTag(I))
		    End If
		  Next
		  Self.UpdateList(Classes)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectClasses() As String)
		  Self.List.DeleteAllRows
		  
		  Dim Behaviors() As Beacon.CreatureBehavior = Self.Config(False).All
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Dim Creature As Beacon.Creature = Behavior.TargetCreature
		    Dim Label As String
		    If Creature <> Nil Then
		      Label = Creature.Label
		    Else
		      Label = Behavior.TargetClass
		    End If
		    
		    If Behavior.ProhibitSpawning Then
		      Label = Label + EndOfLine + "Disabled"
		      Self.List.AddRow(Label)
		    ElseIf Behavior.ReplacementClass <> "" Then
		      Creature = Behavior.ReplacementCreature
		      If Creature <> Nil Then
		        Label = Label + EndOfLine + "Replaced with " + Creature.Label
		      Else
		        Label = Label + EndOfLIne + "Replaced with " + Behavior.ReplacementClass
		      End If
		      Self.List.AddRow(Label)
		    Else
		      Self.List.AddRow(Label, Format(Behavior.DamageMultiplier, "0.0#####"), Format(Behavior.ResistanceMultiplier, "0.0#####"), Format(Behavior.TamedDamageMultiplier, "0.0#####"), Format(Behavior.TamedResistanceMultiplier, "0.0#####"))
		    End If
		    
		    If SelectClasses.IndexOf(Behavior.TargetClass) > -1 Then
		      Self.List.Selected(Self.List.LastAddedRowIndex) = True
		    End If
		    
		    Self.List.RowTag(Self.List.LastAddedRowIndex) = Behavior.TargetClass
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

#tag Events Header
	#tag Event
		Sub Opening()
		  Me.Caption = Self.ConfigLabel
		  
		  Dim AddButton As New BeaconToolbarItem("AddCreature", IconAdd)
		  AddButton.HelpTag = "Define new creature adjustments"
		  
		  Dim DuplicateButton As New BeaconToolbarItem("Duplicate", IconToolbarClone, False)
		  DuplicateButton.HelpTag = "Duplicate the selected creature adjustments."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.LeftItems.Append(DuplicateButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddCreature"
		    Self.ShowAdd()
		  Case "Duplicate"
		    Self.ShowDuplicate()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnAlignment(Self.ColumnWildDamage) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnWildResistance) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnTamedDamage) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnTamedResistance) = Listbox.AlignCenter
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
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And (Board.Text.IndexOf("DinoClassDamageMultipliers") > -1 Or Board.Text.IndexOf("TamedDinoClassDamageMultipliers") > -1 Or Board.Text.IndexOf("DinoClassResistanceMultipliers") > -1 Or Board.Text.IndexOf("TamedDinoClassResistanceMultipliers") > -1 Or Board.Text.IndexOf("NPCReplacements") > -1))
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Dim Message As String
		    If Me.SelectedRowCount = 1 Then
		      Message = "Are you sure you want to delete the """ + NthField(Me.Cell(Me.SelectedIndex, Self.ColumnName), EndOfLine, 1) + """ creature adjustment?"
		    Else
		      Message = "Are you sure you want to delete these " + Str(Me.SelectedRowCount, "-0") + " creature adjustments?"
		    End If
		    
		    If Not Self.ShowConfirm(Message, "This action cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Dim Config As BeaconConfigs.DinoAdjustments = Self.Config(True)
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Me.Selected(I) Then
		      Dim ClassString As String = Me.RowTag(I)
		      Config.RemoveBehavior(ClassString)
		      Self.Changed = True
		    End If
		  Next
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Dicts() As Dictionary
		  Dim Config As BeaconConfigs.DinoAdjustments = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ClassString As String = Me.RowTag(I)
		    Dim Behavior As Beacon.CreatureBehavior = Config.Behavior(ClassString)
		    If Behavior = Nil Then
		      Continue
		    End If
		    
		    Dicts.Append(Behavior.ToDictionary)
		  Next
		  
		  Board.AddRawData(Beacon.GenerateJSON(Dicts, False), Self.kClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim JSON As String = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8)
		    Dim Items() As Variant
		    Try
		      Items = Beacon.ParseJSON(JSON)
		    Catch Err As RuntimeException
		    End Try
		    
		    If Items.Ubound = -1 Then
		      Return
		    End If
		    
		    Dim Config As BeaconConfigs.DinoAdjustments = Self.Config(True)
		    Dim SelectClasses() As String
		    For Each Entry As Dictionary In Items
		      Dim Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior.FromDictionary(Entry)
		      If Behavior = Nil Then
		        Continue
		      End If
		      
		      Config.Behavior(Behavior.TargetClass) = Behavior
		    Next
		    Self.Changed = True
		    Self.UpdateList(SelectClasses)
		    Return
		  End If
		  
		  If Board.TextAvailable Then
		    Dim ImportText As String = Board.Text.GuessEncoding
		    Self.Parse(ImportText, "Clipboard")
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.Header.Duplicate.Enabled = Me.SelectedRowCount = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClicked()
		  Self.EditSelected()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
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
