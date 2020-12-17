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
   Begin FadedSeparator FadedSeparator2
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
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
      ScrollActive    =   False
      ScrollingEnabled=   False
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
      AllowInfiniteScroll=   False
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
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      EditCaption     =   "Edit"
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
      PreferencesKey  =   ""
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
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   764
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
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   764
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function ParsingFinished(Document As Beacon.Document) As Boolean
		  // Don't import the global multiplier, it would likely be confusing for users
		  
		  If Document Is Nil Or Document.HasConfigGroup(BeaconConfigs.StackSizes.ConfigName) = False Then
		    Return True
		  End If
		  
		  Var OtherConfig As BeaconConfigs.StackSizes = BeaconConfigs.StackSizes(Document.ConfigGroup(BeaconConfigs.StackSizes.ConfigName))
		  If OtherConfig = Nil Or OtherConfig.Count = CType(0, UInteger) Then
		    Return True
		  End If
		  
		  Var Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Var Engrams() As Beacon.Engram = OtherConfig.Engrams
		  For Each Engram As Beacon.Engram In Engrams
		    Config.Override(Engram) = OtherConfig.Override(Engram)
		  Next
		  Self.Changed = True
		  Self.UpdateList(Engrams)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.StackSizes.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.GlobalMultiplierField.Text = Self.Config(False).GlobalMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.StackSizes
		  Static ConfigName As String = BeaconConfigs.StackSizes.ConfigName
		  
		  Var Document As Beacon.Document = Self.Document
		  Var Config As BeaconConfigs.StackSizes
		  
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
		  Var Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Var CurrentEngrams() As Beacon.Engram = Config.Engrams
		  
		  Var NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Stackables", CurrentEngrams, Self.Document.Mods, EngramSelectorDialog.SelectModes.ImpliedMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    If Engram.StackSize Is Nil Then
		      Config.Override(Engram) = 100
		    ElseIf Engram.StackSize.DoubleValue = 1.0 Then
		      Config.Override(Engram) = 1
		    Else
		      Config.Override(Engram) = Min(Round(Engram.StackSize.DoubleValue * Config.GlobalMultiplier), BeaconConfigs.StackSizes.MaximumQuantity)
		    End If
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
		  
		  Var Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Var CurrentEngrams() As Beacon.Engram = Config.Engrams
		  
		  Var NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, "Stackables", CurrentEngrams, Self.Document.Mods, EngramSelectorDialog.SelectModes.ExplicitMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var SourceEngram As Beacon.Engram = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Var Size As UInt64 = Config.Override(SourceEngram)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram) = Size
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Engrams() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Engrams.Add(Beacon.Engram(Self.List.RowTagAt(I)).ObjectID)
		  Next
		  Self.UpdateList(Engrams)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As Beacon.Engram)
		  Var Engrams() As String
		  For Each Engram As Beacon.Engram In SelectEngrams
		    Engrams.Add(Engram.ObjectID)
		  Next
		  Self.UpdateList(Engrams) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As String)
		  Var Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Var Engrams() As Beacon.Engram = Config.Engrams
		  
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Self.List.RemoveAllRows()
		  For Each Engram As Beacon.Engram In Engrams
		    Var Size As UInt64 = Config.Override(Engram)
		    Self.List.AddRow(Engram.Label, Size.ToString(Locale.Current, Self.NumberFormat))
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Engram
		    Self.List.Selected(Self.List.LastAddedRowIndex) = SelectEngrams.IndexOf(Engram.ObjectID) > -1
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

	#tag Constant, Name = NumberFormat, Type = String, Dynamic = False, Default = \"\x2C##0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events GlobalMultiplierField
	#tag Event
		Sub TextChange()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Config.GlobalMultiplier = CDbl(Me.Text)
		  Self.Changed = True
		  Self.SettingUp = False
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
		  Var DuplicateButton As OmniBarItem = Self.ConfigToolbar.Item("Duplicate")
		  If (DuplicateButton Is Nil) = False Then
		    DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> Self.ColumnStackSize Then
		    Return
		  End If
		  
		  Var Size As UInt64 = CDbl(Me.CellValueAt(Row, Column))
		  If Size > CType(BeaconConfigs.StackSizes.MaximumQuantity, UInt64) Then
		    Size = BeaconConfigs.StackSizes.MaximumQuantity
		    System.Beep
		    Self.ShowAlert("Stack size too high", "Ark has a maximum stack size of " + BeaconConfigs.StackSizes.MaximumQuantity.ToString(Locale.Current, Self.NumberFormat) + ".")
		  End If
		  Me.CellValueAt(Row, Column) = Size.ToString(Locale.Current, Self.NumberFormat)
		  
		  Var Engram As Beacon.Engram = Me.RowTagAt(Row)
		  
		  Var Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Config.Override(Engram) = Size
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
		    
		    Var Engram As Beacon.Engram = Me.RowTagAt(I)
		    If IsNull(Engram) = False Then
		      Engrams.Add(Engram)
		    End If
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Engrams, "stack size override", "stack size overrides") = False Then
		    Return
		  End If
		  
		  Var Config As BeaconConfigs.StackSizes = Self.Config(True)
		  For Each Engram As Beacon.Engram In Engrams
		    Config.Override(Engram) = 0
		  Next
		  Self.Changed = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items As New Dictionary
		  Var Config As BeaconConfigs.StackSizes = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Var Engram As Beacon.Engram = Me.RowTagAt(I)
		    Var Size As UInt64 = Config.Override(Engram)
		    Items.Value(Engram.ObjectID) = Size
		  Next
		  
		  Board.RawData(Self.kClipboardType) = Beacon.GenerateJSON(Items, False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Var JSON As String = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8)
		    Var Items As Dictionary
		    Try
		      Items = Beacon.ParseJSON(JSON)
		    Catch Err As RuntimeException
		      Items = New Dictionary
		    End Try
		    
		    If Items.KeyCount = 0 Then
		      Return
		    End If
		    
		    Var Config As BeaconConfigs.StackSizes = Self.Config(True)
		    Var SelectEngrams() As String
		    For Each Entry As DictionaryEntry In Items
		      Var UUID As String = Entry.Key
		      Var Engram As Beacon.Engram = Beacon.Data.GetEngramByID(UUID)
		      
		      Var Size As UInt64 = Entry.Value
		      SelectEngrams.Add(UUID)
		      Config.Override(Engram) = Size
		    Next
		    Self.Changed = True
		    Self.UpdateList(SelectEngrams)
		    Return
		  End If
		  
		  If Board.TextAvailable Then
		    Var ImportText As String = Board.Text.GuessEncoding
		    Self.Parse(ImportText, "Clipboard")
		    Return
		  End If
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
		  Me.Append(OmniBarItem.CreateButton("AddEngram", "New Override", IconToolbarAdd, "Override the stack size of an engram."))
		  Me.Append(OmniBarItem.CreateButton("Duplicate", "Duplicate", IconToolbarClone, "Duplicate the selected stack size override.", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddEngram"
		    Self.ShowAddOverride()
		  Case "Duplicate"
		    Self.ShowDuplicateOverride()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
