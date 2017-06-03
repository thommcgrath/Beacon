#tag Window
Begin ContainerControl SetEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
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
      ColumnCount     =   7
      ColumnsResizable=   False
      ColumnWidths    =   "*,80,80,80,80,80,80"
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
      Height          =   213
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Description	Min Quantity	Max Quantity	Min Quality	Max Quality	Select %	Blueprint %"
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
      SelectionType   =   1
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   190
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedTextField LabelField
      AcceptTabs      =   False
      Alignment       =   0
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
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   428
   End
   Begin Label LabelLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      Text            =   "Label:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedTextField MinItemsField
      AcceptTabs      =   False
      Alignment       =   0
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
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   "###"
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedTextField MaxItemsField
      AcceptTabs      =   False
      Alignment       =   0
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
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   "###"
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   88
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin Slider WeightSlider
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   112
      LineStep        =   5
      LiveScroll      =   True
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Maximum         =   100
      Minimum         =   1
      PageStep        =   25
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TickStyle       =   "0"
      Top             =   122
      Value           =   100
      Visible         =   True
      Width           =   139
   End
   Begin Label WeightField
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   263
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      Text            =   "100"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   122
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label MinItemsLabel
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
      TabIndex        =   10
      TabPanelIndex   =   0
      Text            =   "Min Items:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label MaxItemsLabel
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
      TabIndex        =   11
      TabPanelIndex   =   0
      Text            =   "Max Items:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   88
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label WeightLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
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
      TabIndex        =   12
      TabPanelIndex   =   0
      Text            =   "Weight:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   122
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin CheckBox DuplicatesCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "No Duplicates"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   157
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   251
   End
   Begin FooterBar Footer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   25
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   403
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
   End
   Begin ControlCanvas Separators
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   1
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   189
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
   End
   Begin UpDownArrows MinItemsStepper
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   192
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   53
      Visible         =   True
      Width           =   13
   End
   Begin UpDownArrows MaxItemsStepper
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   192
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   87
      Visible         =   True
      Width           =   13
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub EditSelectedEntries()
		  Dim Sources() As Beacon.SetEntry
		  For I As Integer = 0 To EntryList.ListCount - 1
		    If Not EntryList.Selected(I) Then
		      Continue
		    End If
		    
		    Sources.Append(EntryList.RowTag(I))
		  Next
		  
		  Dim Entries() As Beacon.SetEntry = EntryEditor.Present(Self, Sources)
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

	#tag Method, Flags = &h21
		Private Sub UpdateEntryList(SelectEntries() As Beacon.SetEntry = Nil)
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
		    
		    EntryList.Cell(I, 0) = Entry.Label
		    EntryList.Cell(I, 1) = Str(Entry.MinQuantity)
		    EntryList.Cell(I, 2) = Str(Entry.MaxQuantity)
		    EntryList.Cell(I, 3) = Language.LabelForQuality(Entry.MinQuality)
		    EntryList.Cell(I, 4) = Language.LabelForQuality(Entry.MaxQuality)
		    EntryList.Cell(I, 5) = ChanceText
		    EntryList.Cell(I, 6) = Str(BlueprintChance * 100, "0") + "%"
		    
		    EntryList.RowTag(I) = Entry
		    EntryList.Selected(I) = Selected.IndexOf(Entry.UniqueID) > -1
		  Next
		  
		  EntryList.Sort
		  
		  If ScrollToSelection Then
		    For I As Integer = 0 To EntryList.ListCount - 1
		      If EntryList.Selected(I) Then
		        EntryList.ScrollPosition = I
		        Exit For I
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Updated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSet As Beacon.ItemSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
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
			  
			  Self.mUpdating = True
			  If Self.mSet <> Nil Then
			    LabelField.Text = Self.mSet.Label
			    MinItemsField.Text = Str(Self.mSet.MinNumItems, "-0")
			    MaxItemsField.Text = Str(Self.mSet.MaxNumItems, "-0")
			    WeightSlider.Value = Self.mSet.Weight * 100
			    DuplicatesCheck.Value = Self.mSet.ItemsRandomWithoutReplacement
			  Else
			    LabelField.Text = ""
			    MinItemsField.Text = ""
			    MaxItemsField.Text = ""
			    WeightSlider.Value = 100
			    DuplicatesCheck.Value = True
			  End If
			  Self.UpdateEntryList()
			  Self.mUpdating = False
			End Set
		#tag EndSetter
		Set As Beacon.ItemSet
	#tag EndComputedProperty


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.setentry", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events EntryList
	#tag Event
		Sub Change()
		  Footer.Button("EditButton").Enabled = Me.SelCount > 0
		  Footer.Button("DeleteButton").Enabled = Me.SelCount > 0
		End Sub
	#tag EndEvent
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
		Sub PerformClear()
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
		  
		  // The multipliers parameter here is 100% useless as a copied set entry will always use text
		  // quality values and not numeric ones. But this is what the signature is, so something must
		  // be supplied.
		  Dim Range As New Beacon.Range(1, 1)
		  
		  Dim Modified As Boolean
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    // Single item
		    Dim Entry As Beacon.SetEntry = Beacon.SetEntry.Import(Parsed, Range)
		    If Entry <> Nil Then
		      Self.mSet.Append(Entry)
		      Modified = True
		    End If
		  ElseIf Info.FullName = "Auto()" Then
		    // Multiple items
		    Dim Dicts() As Auto = Parsed
		    For Each Dict As Xojo.Core.Dictionary In Dicts
		      Dim Entry As Beacon.SetEntry = Beacon.SetEntry.Import(Dict, Range)
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
		  Case 0 // Description
		    Return False
		  Case 1 // Min quantity
		    Value1 = Entry1.MinQuantity
		    Value2 = Entry2.MinQuantity
		  Case 2 // Max quantity
		    Value1 = Entry1.MaxQuantity
		    Value2 = Entry2.MaxQuantity
		  Case 3 // Min quality
		    Value1 = Beacon.ValueForQuality(Entry1.MinQuality, 1)
		    Value2 = Beacon.ValueForQuality(Entry2.MinQuality, 1)
		  Case 4 // Max quality
		    Value1 = Beacon.ValueForQuality(Entry1.MaxQuality, 1)
		    Value2 = Beacon.ValueForQuality(Entry2.MaxQuality, 1)
		  Case 5 // Chance
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
		  Me.ColumnAlignment(1) = Listbox.AlignRight
		  Me.ColumnAlignment(2) = Listbox.AlignRight
		  Me.ColumnAlignment(5) = Listbox.AlignRight
		  Me.ColumnAlignment(6) = Listbox.AlignRight
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Self.EditSelectedEntries()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LabelField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.mSet.Label = Me.Text.ToText
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.mSet.MinNumItems = Val(Me.Text)
		  Self.UpdateEntryList()
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsField
	#tag Event
		Sub TextChange()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.mSet.MaxNumItems = Val(Me.Text)
		  Self.UpdateEntryList()
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightSlider
	#tag Event
		Sub ValueChanged()
		  WeightField.Text = Str(Me.Value, "-0")
		  
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.mSet.Weight = Me.Value / 100
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DuplicatesCheck
	#tag Event
		Sub Action()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.mSet.ItemsRandomWithoutReplacement = Me.Value
		  Self.UpdateEntryList()
		  RaiseEvent Updated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Footer
	#tag Event
		Sub Open()
		  Dim AddButton As New FooterBarButton("AddButton", IconAdd)
		  Dim EditButton As New FooterBarButton("EditButton", IconEdit)
		  Dim DeleteButton As New FooterBarButton("DeleteButton", IconRemove)
		  
		  EditButton.Enabled = False
		  DeleteButton.Enabled = False
		  
		  Me.Append(AddButton)
		  Me.Append(EditButton)
		  Me.Append(DeleteButton)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(Button As FooterBarButton)
		  Select Case Button.Name
		  Case "AddButton"
		    Dim Entries() As Beacon.SetEntry = EntryEditor.Present(Self)
		    If Entries = Nil Then
		      Return
		    End If
		    
		    For Each Entry As Beacon.SetEntry In Entries
		      Self.mSet.Append(Entry)
		    Next
		    
		    Self.UpdateEntryList(Entries)
		    RaiseEvent Updated
		  Case "EditButton"
		    Self.EditSelectedEntries()
		  Case "DeleteButton"
		    Self.RemoveSelectedEntries()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Separators
	#tag Event
		Sub Paint(index as Integer, g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  G.ForeColor = &cCCCCCC
		  G.FillRect(-1, -1, G.Width + 2, G.Height + 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinItemsStepper
	#tag Event
		Sub Down()
		  Dim MinItems As UInteger = CDbl(MinItemsField.Text)
		  MinItems = Max(MinItems - 1, 1)
		  MinItemsField.Text = Format(MinItems, "0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Dim MinItems As UInteger = CDbl(MinItemsField.Text)
		  Dim MaxItems As UInteger = CDbl(MaxItemsField.Text)
		  MinItems = Min(MinItems + 1, MaxItems)
		  MinItemsField.Text = Format(MinItems, "0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemsStepper
	#tag Event
		Sub Down()
		  Dim MinItems As UInteger = CDbl(MinItemsField.Text)
		  Dim MaxItems As UInteger = CDbl(MaxItemsField.Text)
		  MaxItems = Max(MaxItems - 1, MinItems)
		  MaxItemsField.Text = Format(MaxItems, "0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  Dim EntryCount As UInteger = Self.mSet.Count
		  Dim MaxItems As UInteger = CDbl(MaxItemsField.Text)
		  MaxItems = Min(MaxItems + 1, EntryCount)
		  MaxItemsField.Text = Format(MaxItems, "0")
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
