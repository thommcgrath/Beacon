#tag Window
Begin BeaconSubview EngramsManagerView
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
   Height          =   428
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
   Width           =   594
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "My Engrams"
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
      Resizer         =   ""
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   594
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   8
      ColumnsResizable=   False
      ColumnWidths    =   "*,100,75,75,75,75,75,75"
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
      Height          =   387
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Label	Blueprintable	Island	Scorched	Center	Ragnarok	Aberration	Extinction"
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
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   594
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator HeaderSeparator
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   594
   End
   Begin Beacon.EngramSearcherThread Searcher
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   "0"
      State           =   ""
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  Self.Searcher.Cancel
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.RebuildList()
		  Self.ToolbarCaption = "My Engrams"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub DeleteSelected(Warn As Boolean)
		  If Warn Then
		    Dim Message, Explanation As String
		    If Self.List.SelCount = 1 Then
		      Message = "Delete this engram?"
		      Explanation = "Are you sure you want to delete the selected engram? This action cannot be undone."
		    Else
		      Message = "Delete these engrams?"
		      Explanation = "Are you sure you want to delete the selected engrams? This action cannot be undone."
		    End If
		    
		    If Not Self.ShowConfirm(Message, Explanation, "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = List.ListCount - 1 DownTo 0
		    If Not List.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Engram As Beacon.Engram = List.RowTag(I)
		    If LocalData.SharedInstance.DeleteEngram(Engram) Then
		      List.RemoveRow(I)
		    End If
		  Next
		  
		  Self.RebuildList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportAll()
		  Dim Dialog As New SaveAsDialog
		  Dialog.SuggestedFileName = "Beacon Engrams.csv"
		  Dialog.PromptText = "Export engrams to CSV"
		  Dialog.Filter = BeaconFileTypes.CSVFile
		  
		  Dim File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File <> Nil Then
		    Dim Engrams() As Beacon.Engram = LocalData.SharedInstance.GetCustomEngrams()
		    Dim CSV As Text = Beacon.Engram.CreateCSV(Engrams)
		    Dim Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(CSV)
		    Stream.Close
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportText(Content As String)
		  Self.Searcher.Search(Content)
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
		  If Engrams <> Nil Then
		    For Each Engram As Beacon.Engram In Engrams
		      List.AddRow("")
		      Self.ShowEngramInRow(Engram, List.LastIndex)
		      If SelectedPaths.IndexOf(Engram.Path) > -1 Then
		        List.Selected(List.LastIndex) = True
		      End If
		    Next
		    Header.ExportButton.Enabled = Engrams.Ubound > -1
		  Else
		    Header.ExportButton.Enabled = False
		  End If
		  
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
		  List.CellCheck(Index, Self.ColumnExtinction) = Engram.ValidForMap(Beacon.Maps.Extinction)
		  List.RowTag(Index) = Engram
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mProgress As Integer
	#tag EndProperty


	#tag Constant, Name = ColumnAberration, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnBlueprintable, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnCenter, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnExtinction, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIsland, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRagnarok, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnScorched, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub Open()
		  Dim DeleteButton As New BeaconToolbarItem("DeleteButton", IconRemove, False)
		  DeleteButton.HelpTag = "Delete the selected engrams."
		  
		  Dim ExportButton As New BeaconToolbarItem("ExportButton", IconToolbarExport, False)
		  ExportButton.HelpTag = "Export these engrams."
		  
		  Me.LeftItems.Append(DeleteButton)
		  Me.LeftItems.Append(ExportButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "DeleteButton"
		    Self.DeleteSelected(True)
		  Case "ExportButton"
		    Self.ExportAll()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  Header.DeleteButton.Enabled = Me.SelCount > 0
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
		  Me.ColumnType(Self.ColumnExtinction) = Listbox.TypeCheckbox
		  
		  Me.ColumnAlignment(Self.ColumnBlueprintable) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnIsland) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnScorched) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnCenter) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnRagnarok) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnAberration) = Listbox.AlignCenter
		  Me.ColumnAlignment(Self.ColumnExtinction) = Listbox.AlignCenter
		  
		  Me.Heading(Self.ColumnIsland) = "Island"
		  Me.Heading(Self.ColumnScorched) = "Scorched"
		  Me.Heading(Self.ColumnCenter) = "Center"
		  Me.Heading(Self.ColumnRagnarok) = "Ragnarok"
		  Me.Heading(Self.ColumnAberration) = "Aberration"
		  Me.Heading(Self.ColumnExtinction) = "Extinction"
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
		  Case Self.ColumnExtinction
		    Editable.ValidForMap(Beacon.Maps.Extinction) = Me.CellCheck(Row, Column)
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
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Self.DeleteSelected(Warn)
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.TextAvailable And (InStr(Board.Text, "Blueprint") > 0 Or InStr(Board.Text, "cheat giveitem") > 0)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Lines() As String
		  For I As Integer = 0 To Me.ListCount - 1
		    If Not Me.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Engram As Beacon.Engram = Me.RowTag(I)
		    Dim Line As String = "cheat giveitem ""Blueprint'" + Engram.Path + "'"" 1 1 false"
		    
		    Lines.Append(Line)
		  Next
		  
		  Board.Text = Join(Lines, EndOfLine)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Board.TextAvailable Then
		    Self.ImportText(Board.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Searcher
	#tag Event
		Sub Finished()
		  Self.Progress = BeaconSubview.ProgressNone
		  
		  Dim Engrams() As Beacon.Engram = Me.Engrams(True)
		  Dim ImportedCount, SkippedCount As Integer
		  For Each Engram As Beacon.Engram In Engrams
		    If LocalData.SharedInstance.SaveEngram(Engram, False) Then
		      ImportedCount = ImportedCount + 1
		    Else
		      SkippedCount = SkippedCount + 1
		    End If
		  Next
		  
		  Self.RebuildList()
		  
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
		  
		  Self.ShowAlert("Engram import has finished", Join(Messages, " "))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.Progress = BeaconSubview.ProgressIndeterminate
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
