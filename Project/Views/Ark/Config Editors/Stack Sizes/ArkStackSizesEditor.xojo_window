#tag DesktopWindow
Begin ArkConfigEditor ArkStackSizesEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   468
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
   Width           =   764
   Begin UITweaks.ResizedTextField GlobalMultiplierField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   209
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   53
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel GlobalMultiplierLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Global Stack Size Multiplier:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   53
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   177
   End
   Begin FadedSeparator FadedSeparator2
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   87
      Transparent     =   True
      Visible         =   True
      Width           =   764
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "*,150"
      DefaultRowHeight=   26
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   380
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
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
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
      BackgroundColor =   ""
      ContentHeight   =   0
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   496
   End
   Begin DelayedSearchField FilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Stacks"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   504
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   9
      Transparent     =   False
      Visible         =   True
      Width           =   250
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin OmniBarSeparator FilterSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   495
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   269
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function ParsingFinished(Project As Ark.Project) As Boolean
		  // Don't import the global multiplier, it would likely be confusing for users
		  
		  If Project Is Nil Or Project.HasConfigGroup(Ark.Configs.NameStackSizes) = False Then
		    Return True
		  End If
		  
		  Var OtherConfig As Ark.Configs.StackSizes = Ark.Configs.StackSizes(Project.ConfigGroup(Ark.Configs.NameStackSizes))
		  If OtherConfig = Nil Or OtherConfig.Count = CType(0, UInteger) Then
		    Return True
		  End If
		  
		  Var Config As Ark.Configs.StackSizes = Self.Config(True)
		  Var Engrams() As Ark.Engram = OtherConfig.Engrams
		  For Each Engram As Ark.Engram In Engrams
		    Config.Override(Engram) = OtherConfig.Override(Engram)
		  Next
		  Self.Modified = True
		  Self.UpdateList(Engrams)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.GlobalMultiplierField.Text = Self.Config(False).GlobalMultiplier.ToString(Locale.Current, "0.0#####")
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As Ark.Configs.StackSizes
		  Return Ark.Configs.StackSizes(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameStackSizes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAddOverride()
		  Var Config As Ark.Configs.StackSizes = Self.Config(False)
		  Var CurrentEngrams() As Ark.Engram = Config.Engrams
		  
		  Var NewEngrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "Stackables", CurrentEngrams, Self.Project.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.ImpliedMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Ark.Engram In NewEngrams
		    If Engram.StackSize Is Nil Then
		      Config.Override(Engram) = 100
		    ElseIf Engram.StackSize.DoubleValue = 1.0 Then
		      Config.Override(Engram) = 1
		    Else
		      Config.Override(Engram) = Min(Round(Engram.StackSize.DoubleValue * Config.GlobalMultiplier), Ark.Configs.StackSizes.MaximumQuantity)
		    End If
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicateOverride()
		  If (Self.List Is Nil) Or Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var SourceEngram As Ark.Engram = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  
		  Var Config As Ark.Configs.StackSizes = Self.Config(False)
		  Var CurrentEngrams() As Ark.Engram = Config.Engrams
		  
		  Var NewEngrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "Stackables", CurrentEngrams, Self.Project.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Size As UInt64 = Config.Override(SourceEngram)
		  
		  Config = Self.Config(True)
		  
		  For Each Engram As Ark.Engram In NewEngrams
		    Config.Override(Engram) = Size
		  Next
		  
		  Self.UpdateList(NewEngrams)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Engrams() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Engrams.Add(Ark.Engram(Self.List.RowTagAt(I)).ObjectID)
		  Next
		  Self.UpdateList(Engrams)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As Ark.Engram)
		  Var Engrams() As String
		  For Each Engram As Ark.Engram In SelectEngrams
		    Engrams.Add(Engram.ObjectID)
		  Next
		  Self.UpdateList(Engrams) 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectEngrams() As String)
		  Var Config As Ark.Configs.StackSizes = Self.Config(False)
		  Var Engrams() As Ark.Engram = Config.Engrams
		  
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Self.List.SelectionChangeBlocked = True
		  
		  Var Filter As String = Self.FilterField.Text.Trim
		  
		  Self.List.RemoveAllRows()
		  For Each Engram As Ark.Engram In Engrams
		    If Filter.IsEmpty = False And Engram.Label.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Var Size As UInt64 = Config.Override(Engram)
		    Self.List.AddRow(Engram.Label, Size.ToString(Locale.Current, Self.NumberFormat))
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Engram
		    Self.List.RowSelectedAt(Self.List.LastAddedRowIndex) = SelectEngrams.IndexOf(Engram.ObjectID) > -1
		  Next Engram
		  
		  Self.List.SortingColumn = 0
		  Self.List.Sort
		  Self.List.ScrollPosition = ScrollPosition
		  Self.List.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod


	#tag Constant, Name = ColumnEngram, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnStackSize, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.stacksize", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NumberFormat, Type = String, Dynamic = False, Default = \"#\x2C##0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events GlobalMultiplierField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Var Config As Ark.Configs.StackSizes = Self.Config(True)
		  Config.GlobalMultiplier = CDbl(Me.Text)
		  Self.Modified = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(Self.ColumnStackSize) = DesktopListbox.Alignments.Right
		  Me.ColumnTypeAt(Self.ColumnStackSize) = DesktopListbox.CellTypes.TextField
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
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
		  
		  Var Size As UInt64 = CDbl(Me.CellTextAt(Row, Column))
		  If Size > CType(Ark.Configs.StackSizes.MaximumQuantity, UInt64) Then
		    Size = Ark.Configs.StackSizes.MaximumQuantity
		    System.Beep
		    Self.ShowAlert("Stack size too high", "Ark has a maximum stack size of " + Ark.Configs.StackSizes.MaximumQuantity.ToString(Locale.Current, Self.NumberFormat) + ".")
		  End If
		  Me.CellTextAt(Row, Column) = Size.ToString(Locale.Current, Self.NumberFormat)
		  
		  Var Engram As Ark.Engram = Me.RowTagAt(Row)
		  
		  Var Config As Ark.Configs.StackSizes = Self.Config(True)
		  Config.Override(Engram) = Size
		  Self.Modified = True
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
		  Var Engrams() As Ark.Engram
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Var Engram As Ark.Engram = Me.RowTagAt(I)
		    If IsNull(Engram) = False Then
		      Engrams.Add(Engram)
		    End If
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Engrams, "stack size override", "stack size overrides") = False Then
		    Return
		  End If
		  
		  Var Config As Ark.Configs.StackSizes = Self.Config(True)
		  For Each Engram As Ark.Engram In Engrams
		    Config.Override(Engram) = 0
		  Next
		  Self.Modified = True
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Items As New Dictionary
		  Var Config As Ark.Configs.StackSizes = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Engram As Ark.Engram = Me.RowTagAt(I)
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
		    
		    Var Config As Ark.Configs.StackSizes = Self.Config(True)
		    Var SelectEngrams() As String
		    For Each Entry As DictionaryEntry In Items
		      Var UUID As String = Entry.Key
		      Var Engram As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngramByUUID(UUID)
		      
		      Var Size As UInt64 = Entry.Value
		      SelectEngrams.Add(UUID)
		      Config.Override(Engram) = Size
		    Next
		    Self.Modified = True
		    Self.UpdateList(SelectEngrams)
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
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
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
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateList
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
#tag EndViewBehavior
