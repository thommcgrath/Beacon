#tag Window
Begin ConfigEditor StackSizesConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   468
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
   Width           =   764
   Begin UITweaks.ResizedTextField GlobalMultiplierField
      AcceptTabs      =   False
      Alignment       =   2
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
      HelpTag         =   "1.0 = Normal. Higher values increase stack sizes, smaller values decrease stack sizes."
      Index           =   -2147483648
      Italic          =   False
      Left            =   209
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   53
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel GlobalMultiplierLabel
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Global Stack Size Multiplier:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   53
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   177
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   "Stack Size Overrides"
      DoubleBuffer    =   False
      Enabled         =   True
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   764
   End
   Begin FadedSeparator FadedSeparator2
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   87
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   764
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "*,150"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   26
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   380
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Engram	Stack Size"
      Italic          =   False
      Left            =   0
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
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   88
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   764
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator FadedSeparator1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   764
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub ParsingFinished(ParsedData As Dictionary)
		  // Don't import the global multiplier, it would likely be confusing for users
		  
		  If ParsedData = Nil Then
		    Return
		  End If
		  
		  Dim OtherConfig As BeaconConfigs.StackSizes = BeaconConfigs.StackSizes.FromImport(ParsedData, New Dictionary, Self.Document.MapCompatibility, Self.Document.Difficulty)
		  If OtherConfig = Nil Or OtherConfig.Count = 0 Then
		    Return
		  End If
		  
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Dim Classes() As String = OtherConfig.Classes
		  For Each ClassString As String In Classes
		    Config.Override(ClassString) = OtherConfig.Override(ClassString)
		  Next
		  Self.Changed = True
		  Self.UpdateList(Classes)
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.StackSizes.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.GlobalMultiplierField.Value = Format(Self.Config(False).GlobalMultiplier, "0.0#####")
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.StackSizes
		  Static ConfigName As String = BeaconConfigs.StackSizes.ConfigName
		  
		  Dim Document As Beacon.Document = Self.Document
		  Dim Config As BeaconConfigs.StackSizes
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.StackSizes(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.StackSizes(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.StackSizes
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
		  Return Language.LabelForConfig(BeaconConfigs.StackSizes.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddOverride()
		  Dim CurrentEngrams() As Beacon.Engram
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Dim Classes() As String = Config.Classes
		  For Each ClassString As String In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Continue
		    End If
		    
		    CurrentEngrams.AddRow(Engram)
		  Next
		  
		  Dim NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Stackables", CurrentEngrams, Self.Document.Mods, False)
		  If NewEngrams = Nil Or NewEngrams.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram.ClassString) = 100
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicateOverride()
		  If Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Dim CurrentEngrams() As Beacon.Engram
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Dim Classes() As String = Config.Classes
		  For Each ClassString As String In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Continue
		    End If
		    
		    CurrentEngrams.AddRow(Engram)
		  Next
		  
		  Dim NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Stackables", CurrentEngrams, Self.Document.Mods, True)
		  If NewEngrams = Nil Or NewEngrams.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Dim SourceClass As String = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Dim Size As Integer = Config.Override(SourceClass)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram.ClassString) = Size
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Dim Classes() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Classes.AddRow(Self.List.RowTagAt(I))
		  Next
		  Self.UpdateList(Classes)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As Beacon.Engram)
		  Dim Classes() As String
		  For Each Engram As Beacon.Engram In SelectEngrams
		    Classes.AddRow(Engram.ClassString)
		  Next
		  Self.UpdateList(Classes) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectClasses() As String)
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Dim Classes() As String = Config.Classes
		  
		  Dim ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Self.List.RemoveAllRows()
		  For Each ClassString As String In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    Dim EngramName As String
		    If Engram <> Nil Then
		      EngramName = Engram.Label
		    Else
		      EngramName = ClassString
		    End If
		    
		    Dim Size As Integer = Config.Override(ClassString)
		    Self.List.AddRow(EngramName, Size.ToString)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = ClassString
		    Self.List.Selected(Self.List.LastAddedRowIndex) = SelectClasses.IndexOf(ClassString) > -1
		  Next
		  
		  Self.List.SortingColumn = 0
		  Self.List.Sort
		  Self.List.ScrollPosition = ScrollPosition
		  Self.List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty


	#tag Constant, Name = ColumnEngram, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnStackSize, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.stacksize", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events GlobalMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Config.GlobalMultiplier = CDbl(Me.Value)
		  Self.Changed = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Open()
		  Dim AddButton As New BeaconToolbarItem("AddEngram", IconToolbarAdd)
		  AddButton.HelpTag = "Override the stack size of an engram."
		  
		  Dim DuplicateButton As New BeaconToolbarItem("Duplicate", IconToolbarClone, False)
		  DuplicateButton.HelpTag = "Duplicate the selected stack size override."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.LeftItems.Append(DuplicateButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddEngram"
		    Self.ShowAddOverride()
		  Case "Duplicate"
		    Self.ShowDuplicateOverride()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(Self.ColumnStackSize) = Listbox.Alignments.Right
		  Me.ColumnTypeAt(Self.ColumnStackSize) = Listbox.CellTypes.TextField
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.Header.Duplicate.Enabled = Me.SelectedRowCount = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> Self.ColumnStackSize Then
		    Return
		  End If
		  
		  Dim Size As Integer = Val(Me.CellValueAt(Row, Column))
		  Dim ClassString As String = Me.RowTagAt(Row)
		  
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Config.Override(ClassString) = Size
		  Self.Changed = True
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
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("ConfigOverrideItemMaxQuantity") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Engrams() As Beacon.Engram
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) = False Then
		      Continue
		    End If
		    
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(Me.RowTagAt(I))
		    If Engram = Nil Then
		      Engram = Beacon.Engram.CreateFromClass(Me.RowTagAt(I))
		    End If
		    
		    Engrams.AddRow(Engram)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Engrams, "stack size override", "stack size overrides") = False Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.StackSizes = Self.Config(True)
		  For Each Engram As Beacon.Engram In Engrams
		    Config.Override(Engram.ClassString) = 0
		  Next
		  Self.Changed = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Items As New Dictionary
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ClassString As String = Me.RowTagAt(I)
		    Dim Size As Integer = Config.Override(ClassString)
		    Items.Value(ClassString) = Size
		  Next
		  
		  Board.AddRawData(Beacon.GenerateJSON(Items, False), Self.kClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim JSON As String = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8)
		    Dim Items As Dictionary
		    Try
		      Items = Beacon.ParseJSON(JSON)
		    Catch Err As RuntimeException
		      Items = New Dictionary
		    End Try
		    
		    If Items.KeyCount = 0 Then
		      Return
		    End If
		    
		    Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		    Dim SelectClasses() As String
		    For Each Entry As DictionaryEntry In Items
		      Dim ClassString As String = Entry.Key
		      Dim Size As Integer = Entry.Value
		      SelectClasses.AddRow(ClassString)
		      Config.Override(ClassString) = Size
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
