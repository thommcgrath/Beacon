#tag Window
Begin BeaconContainer ArkCraftingCostEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   300
   HelpTag         =   ""
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
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   350
   Begin BeaconListbox List
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "*,90,135"
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
      HeadingIndex    =   0
      Height          =   238
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Resource	Quantity	Prevent Substitutions"
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
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   350
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin StatusBar Status
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Borders         =   1
      Caption         =   ""
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   21
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
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   279
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   350
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   350
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub ShowAddResources()
		  Var Engrams() As Ark.Engram
		  For I As Integer = 0 To Self.mTarget.LastIndex
		    Engrams.Add(Self.mTarget.Resource(I))
		  Next
		  
		  Var NewEngrams() As Ark.Engram = ArkBlueprintSelectorDialog.Present(Self, "Resources", Engrams, RaiseEvent GetActiveMods, ArkBlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  If NewEngrams = Nil Or NewEngrams.LastIndex = -1 Then
		    Return
		  End If
		  
		  For Each Engram As Ark.Engram In NewEngrams
		    If (Engram Is Nil) = False Then
		      Self.mTarget.Add(Engram, 1, False)
		    End If
		  Next
		  
		  Self.UpdateList()
		  Self.Changed = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Var Selected() As String
		  For Idx As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(Idx) Then
		      Var Ingredient As Ark.CraftingCostIngredient = Self.List.RowTagAt(Idx)
		      Selected.Add(Ingredient.Reference.ObjectID)
		    End If
		  Next
		  
		  Self.List.RemoveAllRows
		  For Idx As Integer = 0 To Self.mTarget.LastIndex
		    Var Ingredient As Ark.CraftingCostIngredient = Self.mTarget.Ingredient(Idx)
		    Self.List.AddRow(Ingredient.Engram.Label, Ingredient.Quantity.ToString(Locale.Raw, ",##0"))
		    Self.List.CellCheckBoxValueAt(Self.List.LastAddedRowIndex, Self.ColumnRequireExact) = Ingredient.RequireExact
		    Self.List.Selected(Self.List.LastAddedRowIndex) = Selected.IndexOf(Ingredient.Reference.ObjectID) > -1
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Ingredient
		  Next
		  Self.List.Sort
		  Self.List.ScrollPosition = ScrollPosition
		  Self.UpdateStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Var TotalItems As Integer = Self.List.RowCount
		  Var SelectedItems As Integer = Self.List.SelectedRowCount
		  
		  Var Noun As String = If(TotalItems = 1, "Resource", "Resources")
		  
		  If SelectedItems > 0 Then
		    Self.Status.Caption = SelectedItems.ToString(Locale.Current, ",##0") + " of " + TotalItems.ToString(Locale.Current, ",##0") + " " + Noun + " Selected"
		  Else
		    Self.Status.Caption = TotalItems.ToString(Locale.Raw, "0") + " " + Noun
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetActiveMods() As Beacon.StringList
	#tag EndHook


	#tag Property, Flags = &h21
		Private mTarget As Ark.MutableCraftingCost
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTarget.ImmutableVersion
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mTarget = Value Then
			    Return
			  End If
			  
			  If Value Is Nil Then
			    Self.mTarget = Nil
			    Self.List.RemoveAllRows
			    Self.Enabled = False
			    Return
			  End If
			  
			  Self.mTarget = New Ark.MutableCraftingCost(Value)
			  Self.UpdateList()
			  Self.Enabled = True
			End Set
		#tag EndSetter
		Target As Ark.CraftingCost
	#tag EndComputedProperty


	#tag Constant, Name = ColumnQuantity, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRequireExact, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnResource, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.craftingingredient", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MinimumWidth, Type = Double, Dynamic = False, Default = \"495", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(Self.ColumnQuantity) = Listbox.Alignments.Right
		  Me.ColumnTypeAt(Self.ColumnQuantity) = Listbox.CellTypes.TextField
		  Me.ColumnTypeAt(Self.ColumnRequireExact) = Listbox.CellTypes.CheckBox
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
		  Return Board.RawDataAvailable(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var RowsToDelete() As Ark.CraftingCostIngredient
		  Var Names() As String
		  Var Bound As Integer = Me.RowCount - 1
		  For Idx As Integer = 0 To Bound
		    If Me.Selected(Idx) = False Then
		      Continue
		    End If
		    
		    Var Ingredient As Ark.CraftingCostIngredient = Me.RowTagAt(Idx)
		    Names.Add(Ingredient.Engram.Label)
		    RowsToDelete.Add(Ingredient)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Names, "ingredient", "ingredients") = False Then
		    Return
		  End If
		  
		  For Each Ingredient As Ark.CraftingCostIngredient In RowsToDelete
		    Self.mTarget.Remove(Ingredient)
		    Self.Changed = True
		  Next
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  For Idx As Integer = 0 To Me.RowCount - 1
		    If Not Me.Selected(Idx) Then
		      Continue
		    End If
		    
		    Var Ingredient As Ark.CraftingCostIngredient = Me.RowTagAt(Idx)
		    Var Dict As New Dictionary
		    Dict.Value("UUID") = Ingredient.Reference.ObjectID
		    Dict.Value("Class") = Ingredient.Reference.ClassString
		    Dict.Value("Quantity") = Ingredient.Quantity
		    Dict.Value("Exact") = Ingredient.RequireExact
		    Dicts.Add(Dict)
		  Next
		  
		  Board.RawData(Self.kClipboardType) = Beacon.GenerateJSON(Dicts, False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Not Board.RawDataAvailable(Self.kClipboardType) Then
		    Return
		  End If
		  
		  Var Dicts() As Variant
		  Try
		    Var Contents As String = Board.RawData(Self.kClipboardType).DefineEncoding(Encodings.UTF8)
		    Dicts = Beacon.ParseJSON(Contents)
		    
		    For Each Dict As Dictionary In Dicts
		      Var Engram As Ark.Engram = Ark.ResolveEngram(Dict, "UUID", "Class", "", Nil)
		      Var Quantity As Integer = Dict.Value("Quantity")
		      Var Exact As Boolean = Dict.Value("Exact")
		      Self.mTarget.Add(Engram, Quantity, Exact)
		    Next
		    
		    Self.UpdateList()
		    Self.Changed = True
		  Catch Err As RuntimeException
		    Return
		  End Try
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Var Ingredient As Ark.CraftingCostIngredient = Me.RowTagAt(Row)
		  Select Case Column
		  Case Self.ColumnQuantity
		    Ingredient = New Ark.CraftingCostIngredient(Ingredient.Reference, Val(Me.CellValueAt(Row, Column)), Ingredient.RequireExact)
		  Case Self.ColumnRequireExact
		    Ingredient = New Ark.CraftingCostIngredient(Ingredient.Reference, Ingredient.Quantity, Me.CellCheckBoxValueAt(Row, Column))
		  Else
		    Return
		  End Select
		  
		  Self.mTarget.Add(Ingredient)
		  Me.RowTagAt(Row) = Ingredient
		  Self.Changed = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddResourceButton"
		    Self.ShowAddResources()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.Append(OmniBarItem.CreateTitle("IngredientsTitle", "Ingredients"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddResourceButton", "Add Ingredient", IconToolbarAdd, "Add ingredients to this engram."))
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
