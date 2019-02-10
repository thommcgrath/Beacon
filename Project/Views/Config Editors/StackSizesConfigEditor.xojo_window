#tag Window
Begin ConfigEditor StackSizesConfigEditor
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
      Caption         =   "Stack Size Overrides"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
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
      EraseBackground =   True
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
      RowCount        =   0
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
      EraseBackground =   True
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
		Sub ParsingFinished(ParsedData As Xojo.Core.Dictionary)
		  // Don't import the global multiplier, it would likely be confusing for users
		  
		  If ParsedData = Nil Then
		    Return
		  End If
		  
		  Dim OtherConfig As BeaconConfigs.StackSizes = BeaconConfigs.StackSizes.FromImport(ParsedData, New Xojo.Core.Dictionary, Self.Document.MapCompatibility, Self.Document.DifficultyValue)
		  If OtherConfig = Nil Or OtherConfig.Count = 0 Then
		    Return
		  End If
		  
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Dim Classes() As Text = OtherConfig.Classes
		  For Each ClassString As Text In Classes
		    Config.Override(ClassString) = OtherConfig.Override(ClassString)
		  Next
		  Self.ContentsChanged = True
		  Self.UpdateList(Classes)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.StackSizes
		  Static ConfigName As Text = BeaconConfigs.StackSizes.ConfigName
		  
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

	#tag Method, Flags = &h21
		Private Sub ShowAddOverride()
		  Dim CurrentEngrams() As Beacon.Engram
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Dim Classes() As Text = Config.Classes
		  For Each ClassString As Text In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Continue
		    End If
		    
		    CurrentEngrams.Append(Engram)
		  Next
		  
		  Dim NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, CurrentEngrams, Self.Document.ConsoleModsOnly, False)
		  If NewEngrams = Nil Or NewEngrams.Ubound = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram.ClassString) = 100
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicateOverride()
		  If Self.List.SelCount <> 1 Then
		    Return
		  End If
		  
		  Dim CurrentEngrams() As Beacon.Engram
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Dim Classes() As Text = Config.Classes
		  For Each ClassString As Text In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Continue
		    End If
		    
		    CurrentEngrams.Append(Engram)
		  Next
		  
		  Dim NewEngrams() As Beacon.Engram = EngramSelectorDialog.Present(Self, CurrentEngrams, Self.Document.ConsoleModsOnly, True)
		  If NewEngrams = Nil Or NewEngrams.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim SourceClass As Text = Self.List.RowTag(Self.List.ListIndex)
		  Dim Size As Integer = Config.Override(SourceClass)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Beacon.Engram In NewEngrams
		    Config.Override(Engram.ClassString) = Size
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.ContentsChanged = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Dim Classes() As Text
		  For I As Integer = 0 To Self.List.ListCount - 1
		    If Not Self.List.Selected(I) Then
		      Continue
		    End If
		    
		    Classes.Append(Self.List.RowTag(I))
		  Next
		  Self.UpdateList(Classes)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As Beacon.Engram)
		  Dim Classes() As Text
		  For Each Engram As Beacon.Engram In SelectEngrams
		    Classes.Append(Engram.ClassString)
		  Next
		  Self.UpdateList(Classes) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectClasses() As Text)
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  Dim Classes() As Text = Config.Classes
		  
		  Dim ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Self.List.DeleteAllRows()
		  For Each ClassString As Text In Classes
		    Dim Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByClass(ClassString)
		    Dim EngramName As Text
		    If Engram <> Nil Then
		      EngramName = Engram.Label
		    Else
		      EngramName = ClassString
		    End If
		    
		    Dim Size As Integer = Config.Override(ClassString)
		    Self.List.AddRow(EngramName, Size.ToText)
		    Self.List.RowTag(Self.List.LastIndex) = ClassString
		    Self.List.Selected(Self.List.LastIndex) = SelectClasses.IndexOf(ClassString) > -1
		  Next
		  
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

#tag Events Header
	#tag Event
		Sub Open()
		  Dim AddButton As New BeaconToolbarItem("AddEngram", IconAdd)
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
		  Me.ColumnAlignment(Self.ColumnStackSize) = Listbox.AlignRight
		  Me.ColumnType(Self.ColumnStackSize) = Listbox.TypeEditable
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.Header.Duplicate.Enabled = Me.SelCount = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Column <> Self.ColumnStackSize Then
		    Return
		  End If
		  
		  Dim Size As Integer = Val(Me.Cell(Row, Column))
		  Dim ClassString As Text = Me.RowTag(Row)
		  
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		  Config.Override(ClassString) = Size
		  Self.ContentsChanged = True
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType) Or (Board.TextAvailable And Board.Text.IndexOf("ConfigOverrideItemMaxQuantity") > -1)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Dim Message As String
		    If Me.SelCount = 1 Then
		      Message = "Are you sure you want to delete the """ + Me.Cell(Me.ListIndex, 0) + """ stack size override?"
		    Else
		      Message = "Are you sure you want to delete these " + Str(Me.SelCount, "-0") + " stack size overrides?"
		    End If
		    
		    If Not Self.ShowConfirm(Message, "This action cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		  For I As Integer = 0 To Me.ListCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ClassString As Text = Me.RowTag(I)
		    Config.Override(ClassString) = 0
		  Next
		  Self.ContentsChanged = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Items As New Xojo.Core.Dictionary
		  Dim Config As BeaconConfigs.StackSizes = Self.Config(False)
		  For I As Integer = 0 To Me.ListCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim ClassString As Text = Me.RowTag(I)
		    Dim Size As Integer = Config.Override(ClassString)
		    Items.Value(ClassString) = Size
		  Next
		  
		  Board.AddRawData(Xojo.Data.GenerateJSON(Items), Self.kClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.RawDataAvailable(Self.kClipboardType) Then
		    Dim JSON As Text = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8).ToText
		    Dim Items As Xojo.Core.Dictionary
		    Try
		      Items = Xojo.Data.ParseJSON(JSON)
		    Catch Err As Xojo.Data.InvalidJSONException
		      Items = New Xojo.Core.Dictionary
		    End Try
		    
		    If Items.Count = 0 Then
		      Return
		    End If
		    
		    Dim Config As BeaconConfigs.StackSizes = Self.Config(True)
		    Dim SelectClasses() As Text
		    For Each Entry As Xojo.Core.DictionaryEntry In Items
		      Dim ClassString As Text = Entry.Key
		      Dim Size As Integer = Entry.Value
		      SelectClasses.Append(ClassString)
		      Config.Override(ClassString) = Size
		    Next
		    Self.ContentsChanged = True
		    Self.UpdateList(SelectClasses)
		    Return
		  End If
		  
		  If Board.TextAvailable Then
		    Dim ImportText As String = Board.Text.GuessEncoding
		    Self.Parse(ImportText.ToText, "Clipboard")
		    Return
		  End If
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
