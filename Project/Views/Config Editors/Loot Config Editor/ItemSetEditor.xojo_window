#tag Window
Begin BeaconContainer ItemSetEditor
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
   Width           =   560
   Begin BeaconListbox EntryList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   4
      ColumnsResizable=   False
      ColumnWidths    =   "*,80,120,140"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   1
      GridLinesVertical=   1
      HasHeading      =   True
      HeadingIndex    =   0
      Height          =   364
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Description	Quantity	Quality	Figures"
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
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   64
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Item Set Contents"
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
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
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
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
   End
   Begin ItemSetSettingsContainer Settings
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   23
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   41
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   560
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function Document() As Beacon.Document
		  Return RaiseEvent GetDocument()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelectedEntries(Prefilter As String = "")
		  Dim Sources() As Beacon.SetEntry
		  For I As Integer = 0 To EntryList.ListCount - 1
		    If Not EntryList.Selected(I) Then
		      Continue
		    End If
		    
		    Sources.Append(EntryList.RowTag(I))
		  Next
		  
		  Dim Entries() As Beacon.SetEntry = EntryEditor.Present(Self, Self.Document.ConsoleModsOnly, Sources, Prefilter)
		  If Entries = Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To UBound(Entries)
		    Dim Source As Beacon.SetEntry = Sources(I)
		    Dim Idx As Integer = Self.mSet.IndexOf(Source)
		    Self.mSet(Idx) = Entries(I)
		  Next
		  
		  Self.UpdateEntryList()
		  RaiseEvent Updated
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableMenuItems()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GoToChild(Entry As Beacon.SetEntry, Option As Beacon.SetEntryOption = Nil) As Boolean
		  For I As Integer = 0 To Self.EntryList.ListCount - 1
		    If Self.EntryList.RowTag(I) = Entry Then
		      Self.EntryList.ListIndex = I
		      Self.EntryList.EnsureSelectionIsVisible()
		      If Option <> Nil And Option.Engram <> Nil Then
		        Self.EditSelectedEntries(Option.Engram.ClassString)
		      End If
		      Return True
		    End If
		  Next
		  Self.EntryList.ListIndex = -1
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveSelectedEntries()
		  Dim Changed As Boolean
		  
		  For I As Integer = EntryList.ListCount - 1 DownTo 0
		    If Not EntryList.Selected(I) Then
		      Continue
		    End If
		    
		    Dim Entry As Beacon.SetEntry = EntryList.RowTag(I)
		    Dim Idx As Integer = Self.mSet.IndexOf(Entry)
		    Self.mSet.Remove(Idx)
		    Changed = True
		  Next
		  
		  If Changed Then
		    Self.UpdateEntryList()
		    RaiseEvent Updated
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowSettings(FocusOnName As Boolean = False)
		  Self.Settings.Expand()
		  If FocusOnName Then
		    Self.Settings.EditName()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEntryList(SelectEntries() As Beacon.SetEntry)
		  If Self.mSet = Nil Then
		    EntryList.DeleteAllRows
		    Return
		  End If
		  
		  Dim Selected() As Text
		  Dim ScrollToSelection As Boolean
		  If SelectEntries <> Nil Then
		    For Each Entry As Beacon.SetEntry In SelectEntries
		      Selected.Append(Entry.UniqueID)
		    Next
		    ScrollToSelection = True
		  Else
		    For I As Integer = 0 To EntryList.ListCount - 1
		      If EntryList.Selected(I) Then
		        Dim Entry As Beacon.SetEntry = EntryList.RowTag(I)
		        Selected.Append(Entry.UniqueID)
		      End If
		    Next
		  End If
		  
		  Dim RequiredRows As Integer = UBound(Self.mSet) + 1
		  While EntryList.ListCount < RequiredRows
		    EntryList.AddRow("")
		  Wend
		  While EntryList.ListCount > RequiredRows
		    EntryList.RemoveRow(0)
		  Wend
		  
		  For I As Integer = 0 To UBound(Self.mSet)
		    Dim Entry As Beacon.SetEntry = Self.mSet(I)
		    Dim BlueprintChance As Double = if(Entry.CanBeBlueprint, Entry.ChanceToBeBlueprint, 0)
		    Dim RelativeWeight As Double = Self.mSet.RelativeWeight(I)
		    Dim ChanceText As String
		    If RelativeWeight < 0.01 Then
		      ChanceText = "< 1%"
		    Else
		      ChanceText = Str(RelativeWeight * 100, "0") + "%"
		    End If
		    
		    Dim QualityText As String
		    If Entry.MinQuality = Entry.MaxQuality Then
		      QualityText = Language.LabelForQuality(Entry.MinQuality)
		    Else
		      QualityText = Language.LabelForQuality(Entry.MinQuality, True) + " - " + Language.LabelForQuality(Entry.MaxQuality, True)
		    End If
		    
		    Dim QuantityText As String
		    If Entry.MinQuantity = Entry.MaxQuantity Then
		      QuantityText = Entry.MinQuantity.ToText
		    Else
		      QuantityText = Entry.MinQuantity.ToText + " - " + Entry.MaxQuantity.ToText
		    End If
		    
		    Dim FiguresText As String = Str(Round(Entry.Weight * 100), "0") + " wt"
		    If Entry.CanBeBlueprint Then
		      FiguresText = FiguresText + ", " + Str(BlueprintChance, "0%") + " bp"
		    End If
		    
		    EntryList.Cell(I, Self.ColumnLabel) = Entry.Label
		    EntryList.Cell(I, Self.ColumnQuality) = QualityText
		    EntryList.Cell(I, Self.ColumnQuantity) = QuantityText
		    EntryList.Cell(I, Self.ColumnFigures) = FiguresText
		    
		    EntryList.RowTag(I) = Entry
		    EntryList.Selected(I) = Selected.IndexOf(Entry.UniqueID) > -1
		  Next
		  
		  EntryList.Sort
		  
		  If ScrollToSelection Then
		    EntryList.EnsureSelectionIsVisible()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEntryList(ParamArray SelectEntries() As Beacon.SetEntry)
		  Self.UpdateEntryList(SelectEntries)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetDocument() As Beacon.Document
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Updated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSet As Beacon.ItemSet
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSet
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSet = Value
			  Self.Settings.ItemSet = Value
			  Self.UpdateEntryList()
			End Set
		#tag EndSetter
		Set As Beacon.ItemSet
	#tag EndComputedProperty


	#tag Constant, Name = ColumnFigures, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuality, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.setentry", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events EntryList
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.ListIndex > -1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.RawDataAvailable(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  #Pragma Unused Warn
		  
		  Self.RemoveSelectedEntries()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Dim Entries() As Xojo.Core.Dictionary
		  For I As Integer = 0 To Me.ListCount - 1
		    If Me.Selected(I) Then
		      Entries.Append(Beacon.SetEntry(Me.RowTag(I)).Export)
		    End If
		  Next
		  
		  If UBound(Entries) = -1 Then
		    Return
		  End If
		  
		  Dim Contents As Text
		  If UBound(Entries) = 0 Then
		    Contents = Xojo.Data.GenerateJSON(Entries(0))
		  Else
		    Contents = Xojo.Data.GenerateJSON(Entries)
		  End If
		  
		  Board.AddRawData(Contents, Self.kClipboardType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Board.RawDataAvailable(Self.kClipboardType) Then
		    Return
		  End If
		  
		  Dim Contents As String = DefineEncoding(Board.RawData(Self.kClipboardType), Encodings.UTF8)
		  Dim Parsed As Auto
		  Try
		    Parsed = Xojo.Data.ParseJSON(Contents.ToText)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Beep
		    Return
		  End Try
		  
		  Dim Modified As Boolean
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    // Single item
		    Dim Entry As Beacon.SetEntry = Beacon.SetEntry.ImportFromBeacon(Parsed)
		    If Entry <> Nil Then
		      Self.mSet.Append(Entry)
		      Modified = True
		    End If
		  ElseIf Info.FullName = "Auto()" Then
		    // Multiple items
		    Dim Dicts() As Auto = Parsed
		    For Each Dict As Xojo.Core.Dictionary In Dicts
		      Dim Entry As Beacon.SetEntry = Beacon.SetEntry.ImportFromBeacon(Dict)
		      If Entry <> Nil Then
		        Self.mSet.Append(Entry)
		        Modified = True
		      End If
		    Next
		  End If
		  
		  If Modified Then
		    Self.UpdateEntryList()
		    RaiseEvent Updated
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.ListIndex > -1
		End Function
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Dim Entry1 As Beacon.SetEntry = Me.RowTag(Row1)
		  Dim Entry2 As Beacon.SetEntry = Me.RowTag(Row2)
		  
		  Dim Value1, Value2 As Double
		  Select Case Column
		  Case Self.ColumnLabel
		    Return False
		  Case Self.ColumnQuantity
		    If Entry1.MinQuantity = Entry2.MinQuantity Then
		      Value1 = Entry1.MaxQuantity
		      Value2 = Entry2.MaxQuantity
		    Else
		      Value1 = Entry1.MinQuantity
		      Value2 = Entry2.MinQuantity
		    End If
		  Case Self.ColumnQuality
		    If Entry1.MinQuality = Entry2.MinQuality Then
		      Value1 = Entry1.MaxQuality.BaseValue
		      Value2 = Entry2.MaxQuality.BaseValue
		    Else
		      Value1 = Entry1.MinQuality.BaseValue
		      Value2 = Entry2.MinQuality.BaseValue
		    End If
		  Case Self.ColumnFigures
		    Value1 = Entry1.Weight
		    Value2 = Entry2.Weight
		  End Select
		  
		  If Value1 = Value2 Then
		    Result = 0
		  ElseIf Value1 > Value2 Then
		    Result = 1
		  Else
		    Result = -1
		  End If
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Dim Item As MenuItem
		  
		  Item = New MenuItem
		  Item.Text = "Create Blueprint Entry"
		  Item.Enabled = Me.SelCount > 0
		  Item.Tag = "createblueprintentry"
		  
		  Base.Append(Item)
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  Select Case hitItem.Tag
		  Case "createblueprintentry"
		    Dim Entries() As Beacon.SetEntry
		    For I As Integer = 0 To Me.ListCount - 1
		      If Me.Selected(I) Then
		        Entries.Append(Me.RowTag(I))
		      End If
		    Next
		    
		    Dim BlueprintEntry As Beacon.SetEntry = Beacon.SetEntry.CreateBlueprintEntry(Entries)
		    If BlueprintEntry = Nil Then
		      Return True
		    End If
		    
		    For Each Entry As Beacon.SetEntry In Entries
		      Entry.ChanceToBeBlueprint = 0.0
		    Next
		    
		    Self.mSet.Append(BlueprintEntry)
		    Self.UpdateEntryList(BlueprintEntry)
		    RaiseEvent Updated
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.Header.EditEntry.Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
	#tag Event
		Function RowIsInvalid(Row As Integer) As Boolean
		  Dim Entry As Beacon.SetEntry = Me.RowTag(Row)
		  Return Not Entry.IsValid
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Header
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddEntry"
		    Dim Entries() As Beacon.SetEntry = EntryEditor.Present(Self, Self.Document.ConsoleModsOnly)
		    If Entries = Nil Then
		      Return
		    End If
		    
		    For Each Entry As Beacon.SetEntry In Entries
		      Self.mSet.Append(Entry)
		    Next
		    
		    Self.UpdateEntryList(Entries)
		    RaiseEvent Updated
		  Case "EditEntry"
		    Self.EditSelectedEntries()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Dim AddButton As New BeaconToolbarItem("AddEntry", IconAdd)
		  AddButton.HelpTag = "Add engrams to this item set."
		  
		  Dim EditButton As New BeaconToolbarItem("EditEntry", IconToolbarEdit, False)
		  EditButton.HelpTag = "Edit the selected entries."
		  
		  Me.LeftItems.Append(AddButton)
		  Me.LeftItems.Append(EditButton)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Settings
	#tag Event
		Sub Resized()
		  Dim ListTop As Integer = Me.Top + Me.Height
		  If Self.EntryList.Top = ListTop Then
		    Return
		  End If
		  
		  Dim Diff As Integer = ListTop - Self.EntryList.Top
		  Self.EntryList.Top = Self.EntryList.Top + Diff
		  Self.EntryList.Height = Self.EntryList.Height - Diff
		End Sub
	#tag EndEvent
	#tag Event
		Sub Updated()
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
