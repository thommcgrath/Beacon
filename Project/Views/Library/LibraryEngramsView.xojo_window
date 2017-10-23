#tag Window
Begin BeaconSubview LibraryEngramsView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   419
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
   Width           =   800
   Begin UITweaks.ResizedPushButton ImportFileButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Import File"
      Default         =   False
      Enabled         =   True
      Height          =   20
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
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin UITweaks.ResizedPushButton ImportURLButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Import URL"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   162
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin UITweaks.ResizedPushButton ImportClipboardButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Import Clipboard"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   304
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   130
   End
   Begin Timer ClipboardWatcher
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   500
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin UITweaks.ResizedPushButton RemoveButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Remove"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   700
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   7
      ColumnsResizable=   False
      ColumnWidths    =   "*,100,75,75,75,75,75"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   "#ColumnLabel"
      Height          =   339
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Label	Blueprintable	Island	Scorched	Center	Ragnarok	Aberration"
      Italic          =   False
      Left            =   20
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   60
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   760
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Shown(UserData As Auto = Nil)
		  #Pragma Unused UserData
		  
		  Self.RebuildList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Import(Contents As String)
		  Dim ImportedCount, SkippedCount As Integer
		  Dim Engrams() As Beacon.Engram = Beacon.PullEngramsFromText(Contents)
		  For Each Engram As Beacon.Engram In Engrams
		    If LocalData.SharedInstance.SaveEngram(Engram, False) Then
		      ImportedCount = ImportedCount + 1
		    Else
		      SkippedCount = SkippedCount + 1
		    End If
		  Next
		  
		  Dim Messages() As String
		  If ImportedCount = 1 Then
		    Messages.Append("1 engram was added.")
		  ElseIf ImportedCount > 1 Then
		    Messages.Append(Str(ImportedCount, "-0") + " engrams were added.")
		  End If
		  If SkippedCount = 1 Then
		    Messages.Append("1 engram was skipped because it already exists in the database.")
		  ElseIf SkippedCount > 1 Then
		    Messages.Append(Str(SkippedCount, "-0") + " engrams were skipped because they already exist in the database.")
		  End If
		  If ImportedCount = 0 And SkippedCount = 0 Then
		    Messages.Append("No engrams were found to import.")
		  End If
		  
		  If ImportedCount > 0 Then
		    Self.RebuildList()
		  End If
		  
		  Self.ShowAlert("Import complete", Join(Messages, " "))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildList()
		  Dim SelectedPaths() As Text
		  For I As Integer = 0 To List.ListCount - 1
		    If List.Selected(I) Then
		      Dim Engram As Beacon.Engram = List.RowTag(I)
		      SelectedPaths.Append(Engram.Path)
		    End If
		  Next
		  
		  List.DeleteAllRows
		  
		  Dim Engrams() As Beacon.Engram = LocalData.SharedInstance.GetCustomEngrams()
		  For Each Engram As Beacon.Engram In Engrams
		    List.AddRow("")
		    Self.ShowEngramInRow(Engram, List.LastIndex)
		    If SelectedPaths.IndexOf(Engram.Path) > -1 Then
		      List.Selected(List.LastIndex) = True
		    End If
		  Next
		  
		  List.Sort
		  If List.SelCount > 0 Then
		    For I As Integer = 0 To List.ListCount - 1
		      If List.Selected(I) Then
		        List.ScrollPosition = I
		        Exit For I
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowEngramInRow(Engram As Beacon.Engram, Index As Integer)
		  List.Cell(Index, Self.ColumnLabel) = Engram.Label
		  List.CellCheck(Index, Self.ColumnBlueprintable) = Engram.CanBeBlueprint
		  List.CellCheck(Index, Self.ColumnIsland) = Engram.ValidForMap(Beacon.Maps.TheIsland)
		  List.CellCheck(Index, Self.ColumnScorched) = Engram.ValidForMap(Beacon.Maps.ScorchedEarth)
		  List.CellCheck(Index, Self.ColumnCenter) = Engram.ValidForMap(Beacon.Maps.TheCenter)
		  List.CellCheck(Index, Self.ColumnRagnarok) = Engram.ValidForMap(Beacon.Maps.Ragnarok)
		  List.CellCheck(Index, Self.ColumnAberration) = Engram.ValidForMap(Beacon.Maps.Aberration)
		  List.RowTag(Index) = Engram
		End Sub
	#tag EndMethod


	#tag Constant, Name = ColumnAberration, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnBlueprintable, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnCenter, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIsland, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRagnarok, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnScorched, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ImportFileButton
	#tag Event
		Sub Action()
		  Dim Dialog As New OpenDialog
		  Dialog.Filter = BeaconFileTypes.Text
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File = Nil Then
		    Return
		  End If
		  
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Self.Import(Content)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ImportURLButton
	#tag Event
		Sub Action()
		  Dim Content As String = LibraryEngramsURLDialog.Present(Self)
		  If Content <> "" Then
		    Self.Import(Content)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ImportClipboardButton
	#tag Event
		Sub Action()
		  Dim Board As New Clipboard
		  If Board.TextAvailable Then
		    Self.Import(Board.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClipboardWatcher
	#tag Event
		Sub Action()
		  Dim Board As New Clipboard
		  Self.ImportClipboardButton.Enabled = Board.TextAvailable And (InStr(Board.Text, "Blueprint") > 0 Or InStr(Board.Text, "cheat giveitem") > 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemoveButton
	#tag Event
		Sub Action()
		  For I As Integer = List.ListCount - 1 DownTo 0
		    If Not List.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Engram As Beacon.Engram = List.RowTag(I)
		    If LocalData.SharedInstance.DeleteEngram(Engram) Then
		      List.RemoveRow(I)
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  Self.RemoveButton.Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnType(Self.ColumnLabel) = Listbox.TypeEditableTextField
		  Me.ColumnType(Self.ColumnBlueprintable) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnIsland) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnScorched) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnCenter) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnRagnarok) = Listbox.TypeCheckbox
		  Me.ColumnType(Self.ColumnAberration) = Listbox.TypeCheckbox
		  
		  Me.ColumnAlignment(Self.ColumnBlueprintable) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnIsland) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnScorched) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnCenter) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnRagnarok) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnAberration) = Listbox.AlignCenter
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Dim Engram As Beacon.Engram = Me.RowTag(Row)
		  Dim Editable As New Beacon.MutableEngram(Engram)
		  Select Case Column
		  Case Self.ColumnLabel
		    Editable.Label = Me.Cell(Row, Column).ToText
		  Case Self.ColumnBlueprintable
		    Editable.CanBeBlueprint = Me.CellCheck(Row, Column)
		  Case Self.ColumnIsland
		    Editable.ValidForMap(Beacon.Maps.TheIsland) = Me.CellCheck(Row, Column)
		  Case Self.ColumnScorched
		    Editable.ValidForMap(Beacon.Maps.ScorchedEarth) = Me.CellCheck(Row, Column)
		  Case Self.ColumnCenter
		    Editable.ValidForMap(Beacon.Maps.TheCenter) = Me.CellCheck(Row, Column)
		  Case Self.ColumnRagnarok
		    Editable.ValidForMap(Beacon.Maps.Ragnarok) = Me.CellCheck(Row, Column)
		  Case Self.ColumnAberration
		    Editable.ValidForMap(Beacon.Maps.Aberration) = Me.CellCheck(Row, Column)
		  Else
		    Return
		  End Select
		  
		  If LocalData.SharedInstance.SaveEngram(Editable) Then
		    Self.ShowEngramInRow(New Beacon.Engram(Editable), Row)
		  Else
		    Beep
		    Self.ShowEngramInRow(Engram, Row)
		  End If
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
