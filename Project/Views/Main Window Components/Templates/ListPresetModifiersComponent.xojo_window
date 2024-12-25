#tag DesktopWindow
Begin TemplatesComponentView ListPresetModifiersComponent
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
   Height          =   300
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   630
   Begin OmniBar ModifiersToolbar
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
      Width           =   630
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
      ColumnCount     =   3
      ColumnWidths    =   "*,150,150"
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
      Height          =   228
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Game	Type"
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   630
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin StatusContainer Status
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      CenterCaption   =   ""
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   31
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftCaption     =   ""
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      RightCaption    =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   269
      Transparent     =   True
      Visible         =   True
      Width           =   630
   End
   Begin Beacon.Thread AscendedConversionThread
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.ViewTitle = "Selectors"
		  Self.AscendedConversionThread.DebugIdentifier = "ListPresetModifiersComponent.AscendedConversionThread"
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CloneSelected()
		  Var Siblings() As String
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Siblings.Add(Beacon.TemplateSelector(Self.List.RowTagAt(Idx)).Label)
		  Next
		  
		  Var Clones() As Beacon.TemplateSelector
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Source As Beacon.TemplateSelector = Self.List.RowTagAt(Idx)
		    Var Label As String = Beacon.FindUniqueLabel(Source.Label, Siblings)
		    Siblings.Add(Label)
		    Clones.Add(New Beacon.TemplateSelector(Beacon.UUID.v4, Label, Source.GameId, Source.Language, Source.Code))
		  Next
		  
		  Self.SaveSelectors(Clones)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelectors(Selectors() As Beacon.TemplateSelector)
		  Var Th As New Beacon.DeleteTemplateSelectorThread(Selectors)
		  AddHandler Th.DeleteComplete, AddressOf DeleteThread_Completed
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteThread_Completed(Sender As Beacon.DeleteTemplateSelectorThread)
		  #Pragma Unused Sender
		  
		  Self.UpdateList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelector(TemplateSelector As Beacon.TemplateSelector)
		  Var GameId As String
		  If TemplateSelector Is Nil Then
		    GameId = GameSelectorWindow.Present(Self, Beacon.Game.FeatureTemplates, False)
		  Else
		    GameId = TemplateSelector.GameId
		  End If
		  If GameId.IsEmpty Then
		    Return
		  End If
		  
		  Var CreatedSelector As Beacon.TemplateSelector
		  Select Case GameId
		  Case Ark.Identifier
		    CreatedSelector = ArkLootContainerSelectorEditorDialog.Present(Self, TemplateSelector)
		  Case ArkSA.Identifier
		    CreatedSelector = ArkSALootContainerSelectorEditorDialog.Present(Self, TemplateSelector)
		  Else
		    Self.ShowAlert("Game does not support templates", "Beacon does not have support for templates in " + Language.GameName(GameId) + ".")
		    Return
		  End Select
		  If CreatedSelector Is Nil Then
		    Return
		  End If
		  
		  Var Selectors() As Beacon.TemplateSelector = Array(CreatedSelector)
		  Self.SaveSelectors(Selectors)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveSelectors(Selectors() As Beacon.TemplateSelector)
		  Var Th As New Beacon.SaveTemplateSelectorThread(Selectors)
		  AddHandler Th.SaveComplete, AddressOf SaveThread_Completed
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveThread_Completed(Sender As Beacon.SaveTemplateSelectorThread)
		  Self.UpdateList(Sender.Selectors)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Modifiers() As Beacon.TemplateSelector
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    Modifiers.Add(Self.List.RowTagAt(Idx))
		  Next
		  Self.UpdateList(Modifiers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectModifiers() As Beacon.TemplateSelector)
		  Var SelectIDs() As String
		  For Each Modifier As Beacon.TemplateSelector In SelectModifiers
		    SelectIDs.Add(Modifier.UUID)
		  Next
		  
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.Pool.Get(False)
		  Var Modifiers() As Beacon.TemplateSelector = CommonData.GetTemplateSelectors(Beacon.CommonData.FlagIncludeUserItems Or Beacon.CommonData.FlagIncludeOfficialItems)
		  
		  Self.List.RowCount = Modifiers.Count
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Var TemplateSelector As Beacon.TemplateSelector = Modifiers(Idx)
		    Var CustomSelector As Boolean = CommonData.IsTemplateSelectorCustom(TemplateSelector)
		    Var OfficialSelector As Boolean = CommonData.IsTemplateSelectorOfficial(TemplateSelector)
		    If OfficialSelector And CustomSelector Then
		      Self.List.CellTextAt(Idx, Self.ColumnType) = "Customized Built-In"
		    ElseIf OfficialSelector Then
		      Self.List.CellTextAt(Idx, Self.ColumnType) = "Built-In"
		    Else
		      Self.List.CellTextAt(Idx, Self.ColumnType) = "Custom"
		    End If
		    
		    Self.List.CellTextAt(Idx, Self.ColumnName) = TemplateSelector.Label
		    Self.List.CellTextAt(Idx, Self.ColumnGame) = Language.GameName(TemplateSelector.GameId)
		    Self.List.RowTagAt(Idx) = TemplateSelector
		    Self.List.RowSelectedAt(Idx) = SelectIDs.IndexOf(TemplateSelector.UUID) > -1
		  Next
		  
		  Self.List.SizeColumnToFit(Self.ColumnGame, 150)
		  Self.List.SizeColumnToFit(Self.ColumnType, 150)
		  
		  Self.List.Sort
		  Self.List.EnsureSelectionIsVisible
		  
		  Self.UpdateStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectModifier As Beacon.TemplateSelector)
		  Var Modifiers() As Beacon.TemplateSelector
		  If (SelectModifier Is Nil) = False Then
		    Modifiers.Add(SelectModifier)
		  End If
		  Self.UpdateList(Modifiers)
		  Self.List.EnsureSelectionIsVisible
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Self.Status.CenterCaption = Self.List.StatusMessage("Template Selector", "Template Selectors")
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mConversionTargets() As Beacon.TemplateSelector
	#tag EndProperty


	#tag Constant, Name = ColumnGame, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnType, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ConvertToArkAscended, Type = String, Dynamic = True, Default = \"Convert to Ark: Survival Ascended", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.templateselector", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ModifiersToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("NewModifier", "New Selector", IconToolbarAdd, "Create a new loot drop selector."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditModifier", "Edit Selector", IconToolbarEdit, "Edit the selected loot drop selector.", Self.List.SelectedRowCount = 1))
		  Me.Append(OmniBarItem.CreateButton("CloneModifier", "Duplicate", IconToolbarClone, "Create a copy of the selected loot drop selector.", Self.List.SelectedRowCount > 0))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "NewModifier"
		    Self.EditSelector(Nil)
		  Case "EditModifier"
		    Self.List.DoEdit()
		  Case "CloneModifier"
		    Self.CloneSelected()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
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
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Modifiers() As Beacon.TemplateSelector
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) Then
		      Modifiers.Add(Me.RowTagAt(Idx))
		    End If
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Modifiers, "template selector", "template selectors") = False Then
		    Return
		  End If
		  
		  Self.DeleteSelectors(Modifiers)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dictionaries() As Dictionary
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) Then
		      Dictionaries.Add(Beacon.TemplateSelector(Me.RowTagAt(Idx)).SaveData())
		    End If
		  Next
		  
		  If Dictionaries.Count = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(Self.kClipboardType, Dictionaries)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditSelector(Me.RowTagAt(Me.SelectedRowIndex))
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As Variant = Board.GetClipboardData(Self.kClipboardType)
		  If Contents.IsNull = False Then
		    Try
		      Var Dicts() As Variant = Contents
		      Var Added() As Beacon.TemplateSelector
		      For Each Dict As Dictionary In Dicts
		        Var Modifier As Beacon.TemplateSelector = Beacon.TemplateSelector.FromSaveData(Dict)
		        If (Modifier Is Nil) = False Then
		          Added.Add(Modifier)
		        End If
		      Next
		      Self.SaveSelectors(Added)
		    Catch Err As RuntimeException
		      Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    End Try
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  If (Self.ModifiersToolbar.Item("CloneModifier") Is Nil) = False Then
		    Self.ModifiersToolbar.Item("CloneModifier").Enabled = Me.CanCopy()
		  End If
		  If (Self.ModifiersToolbar.Item("EditModifier") Is Nil) = False Then
		    Self.ModifiersToolbar.Item("EditModifier").Enabled = Me.CanEdit()
		  End If
		  
		  Self.UpdateStatus
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  Var RowIdx As Integer = Me.RowFromXY(X, Y)
		  Var Targets() As Beacon.TemplateSelector
		  If RowIdx > -1 Then
		    If Me.RowSelectedAt(RowIdx) Then
		      // Take all selected rows
		      For Idx As Integer = 0 To Me.LastRowIndex
		        If Me.RowSelectedAt(Idx) Then
		          Targets.Add(Me.RowTagAt(Idx))
		        End If
		      Next
		    Else
		      // Take only the clicked row
		      Targets.Add(Me.RowTagAt(RowIdx))
		    End If
		  End If
		  
		  Var ConvertItem As New DesktopMenuItem(Self.ConvertToArkAscended, Targets)
		  ConvertItem.Name = "ConvertToArkAscended"
		  ConvertItem.Enabled = False
		  If Self.AscendedConversionThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    For Each Target As Beacon.TemplateSelector In Targets
		      If Target.GameId = Ark.Identifier Then
		        ConvertItem.Enabled = True
		        Exit
		      End If
		    Next
		  End If
		  Base.AddMenu(ConvertItem)
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(HitItem As DesktopMenuItem) As Boolean
		  If HitItem Is Nil Then
		    Return False
		  End If
		  
		  Select Case HitItem.Name
		  Case "ConvertToArkAscended"
		    Var Targets() As Beacon.TemplateSelector = HitItem.Tag
		    For Each Target As Beacon.TemplateSelector In Targets
		      If Target.GameId = Ark.Identifier Then
		        Self.mConversionTargets.Add(Target)
		      End If
		    Next
		    If Self.mConversionTargets.Count > 0 Then
		      Self.AscendedConversionThread.Start
		      Self.Progress = BeaconSubview.ProgressIndeterminate
		    Else
		      Self.ShowAlert("Nothing to convert", "None of the selected selectors are Ark: Survival Evolved selectors.")
		    End If
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events AscendedConversionThread
	#tag Event
		Sub Run()
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.Pool.Get(True)
		  Var ConvertedSelectors() As Beacon.TemplateSelector
		  For Each SourceSelector As Beacon.TemplateSelector In Self.mConversionTargets
		    Var ConvertedSelector As Beacon.TemplateSelector = Conversions.EvolvedToAscended(SourceSelector)
		    If ConvertedSelector Is Nil Then
		      Continue
		    End If
		    ConvertedSelectors.Add(ConvertedSelector)
		    CommonData.SaveTemplateSelector(ConvertedSelector, False, False)
		  Next
		  
		  Var Update As New Dictionary
		  Update.Value("Finished") = True
		  Update.Value("Selectors") = ConvertedSelectors
		  CommonData.ExportCloudFiles()
		  Me.AddUserInterfaceUpdate(Update)
		  Self.mConversionTargets.ResizeTo(-1)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Var Finished As Boolean = Update.Lookup("Finished", False).BooleanValue
		    If Finished Then
		      Self.Progress = BeaconSubview.ProgressNone
		    End If
		    
		    If Update.HasKey("Selectors") Then
		      Var ConvertedSelectors() As Beacon.TemplateSelector = Update.Value("Selectors")
		      Self.UpdateList(ConvertedSelectors)
		    End If
		  Next
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
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
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
		Name="AllowAutoDeactivate"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
