#tag DesktopWindow
Begin BeaconContainer ArkCraftingCostEditor
   AcceptFocus     =   "False"
   AcceptTabs      =   "True"
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   AutoDeactivate  =   "True"
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
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
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   350
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
      ColumnCount     =   3
      ColumnWidths    =   "*,90,135"
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
      HeadingIndex    =   0
      Height          =   238
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
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      TotalPages      =   -1
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   350
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin StatusBar Status
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Borders         =   1
      Caption         =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   21
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
      Tooltip         =   ""
      Top             =   279
      Transparent     =   True
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
#tag EndDesktopWindow

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
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var ScrollPosition As Integer = Self.List.ScrollPosition
		  Var Selected() As String
		  For Idx As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.RowSelectedAt(Idx) Then
		      Var Ingredient As Ark.CraftingCostIngredient = Self.List.RowTagAt(Idx)
		      Selected.Add(Ingredient.Reference.BlueprintId)
		    End If
		  Next
		  
		  Self.List.RemoveAllRows
		  For Idx As Integer = 0 To Self.mTarget.LastIndex
		    Var Ingredient As Ark.CraftingCostIngredient = Self.mTarget.Ingredient(Idx)
		    Self.List.AddRow(Ingredient.Engram.Label, Ingredient.Quantity.PrettyText(True))
		    Self.List.CellCheckBoxValueAt(Self.List.LastAddedRowIndex, Self.ColumnRequireExact) = Ingredient.RequireExact
		    Self.List.RowSelectedAt(Self.List.LastAddedRowIndex) = Selected.IndexOf(Ingredient.Reference.BlueprintId) > -1
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
		    Self.Status.Caption = SelectedItems.ToString(Locale.Current, "#,##0") + " of " + TotalItems.ToString(Locale.Current, "#,##0") + " " + Noun + " Selected"
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

	#tag Constant, Name = MinimumWidth, Type = Double, Dynamic = False, Default = \"495", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(Self.ColumnQuantity) = DesktopListbox.Alignments.Right
		  Me.ColumnTypeAt(Self.ColumnQuantity) = DesktopListbox.CellTypes.TextField
		  Me.ColumnTypeAt(Self.ColumnRequireExact) = DesktopListbox.CellTypes.CheckBox
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
		  Return Board.HasClipboardData(Ark.CraftingCostIngredient.ClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var RowsToDelete() As Ark.CraftingCostIngredient
		  Var Names() As String
		  Var Bound As Integer = Me.RowCount - 1
		  For Idx As Integer = 0 To Bound
		    If Me.RowSelectedAt(Idx) = False Then
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
		    Self.Modified = True
		  Next
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  For Idx As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(Idx) Then
		      Continue
		    End If
		    
		    Var Ingredient As Ark.CraftingCostIngredient = Me.RowTagAt(Idx)
		    Dicts.Add(Ingredient.SaveData)
		  Next
		  
		  If Dicts.Count = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(Ark.CraftingCostIngredient.ClipboardType, Dicts)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As Variant = Board.GetClipboardData(Ark.CraftingCostIngredient.ClipboardType)
		  If Contents.IsNull Then
		    Return
		  End If
		  
		  Try
		    Var Modified As Boolean
		    Var Dicts() As Variant = Contents
		    For Each Dict As Dictionary In Dicts
		      Var Ingredient As Ark.CraftingCostIngredient = Ark.CraftingCostIngredient.FromDictionary(Dict, Nil)
		      If Ingredient Is Nil Then
		        Continue
		      End If
		      
		      Self.mTarget.Add(Ingredient)
		      Modified = True
		    Next
		    If Modified Then
		      Self.UpdateList()
		      Self.Modified = True
		    End If
		  Catch Err As RuntimeException
		    Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		  End Try
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Var Ingredient As Ark.CraftingCostIngredient = Me.RowTagAt(Row)
		  Select Case Column
		  Case Self.ColumnQuantity
		    If IsNumeric(Me.CellTextAt(Row, Column)) = False Then
		      System.Beep
		      Return
		    End If
		    
		    Var Quantity As Double
		    Try
		      Quantity = Double.FromString(Me.CellTextAt(Row, Column), Locale.Current)
		    Catch Err As RuntimeException
		      System.Beep
		      Return
		    End Try
		    Ingredient = New Ark.CraftingCostIngredient(Ingredient.Reference, Max(Quantity, 0), Ingredient.RequireExact)
		  Case Self.ColumnRequireExact
		    Ingredient = New Ark.CraftingCostIngredient(Ingredient.Reference, Ingredient.Quantity, Me.CellCheckBoxValueAt(Row, Column))
		  Else
		    Return
		  End Select
		  
		  Self.mTarget.Add(Ingredient)
		  Me.RowTagAt(Row) = Ingredient
		  Self.Modified = True
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
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("IngredientsTitle", "Ingredients"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddResourceButton", "Add Ingredient", IconToolbarAdd, "Add ingredients to this engram."))
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
