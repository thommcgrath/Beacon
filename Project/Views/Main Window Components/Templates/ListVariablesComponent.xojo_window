#tag DesktopWindow
Begin TemplatesComponentView ListVariablesComponent Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   450
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
   Width           =   720
   Begin OmniBar VariablesToolbar
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
      Width           =   720
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
      ColumnWidths    =   "*,*,150"
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
      Height          =   378
      Index           =   -2147483648
      InitialValue    =   "#HeaderCaptionLabel	#HeaderCaptionName	#HeaderCaptionType"
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
      Top             =   41
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   720
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
      Top             =   419
      Transparent     =   True
      Visible         =   True
      Width           =   720
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, DataUpdater.Notification_ImportStopped)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.ViewTitle = Self.NounVariablePlural
		  RaiseEvent Opening
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  Self.UpdateList()
		  
		  NotificationKit.Watch(Self, DataUpdater.Notification_ImportStopped)
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
		    Siblings.Add(Beacon.FileTemplateVariable(Self.List.RowTagAt(Idx)).Label)
		  Next
		  
		  Var Clones() As Beacon.FileTemplateVariable
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Source As Beacon.FileTemplateVariable = Self.List.RowTagAt(Idx)
		    Var Label As String = Beacon.FindUniqueLabel(Source.Label, Siblings)
		    Siblings.Add(Label)
		    Var Cloned As New Beacon.MutableFileTemplateVariable(Source, True)
		    Cloned.Label = Label
		    
		    Clones.Add(Cloned)
		  Next
		  
		  Self.SaveVariables(Clones)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteThread_Completed(Sender As Beacon.DeleteFileTemplateVariableThread)
		  #Pragma Unused Sender
		  
		  Self.UpdateList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteVariables(Variables() As Beacon.FileTemplateVariable)
		  Var Th As New Beacon.DeleteFileTemplateVariableThread(Variables)
		  AddHandler Th.DeleteComplete, AddressOf DeleteThread_Completed
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditVariable(Vr As Beacon.FileTemplateVariable)
		  Var CreatedVariable As Beacon.FileTemplateVariable = FileTemplateVariableEditorDialog.Present(Self, Vr)
		  If CreatedVariable Is Nil Then
		    Return
		  End If
		  
		  Self.SaveVariables(Array(CreatedVariable))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case DataUpdater.Notification_ImportStopped
		    Self.UpdateList()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveThread_Completed(Sender As Beacon.SaveFileTemplateVariableThread)
		  Self.UpdateList(Sender.Variables)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveVariables(Variables() As Beacon.FileTemplateVariable)
		  Var Th As New Beacon.SaveFileTemplateVariableThread(Variables)
		  AddHandler Th.SaveComplete, AddressOf SaveThread_Completed
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Variables() As Beacon.FileTemplateVariable
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    Variables.Add(Self.List.RowTagAt(Idx))
		  Next
		  Self.UpdateList(Variables)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectVariables() As Beacon.FileTemplateVariable)
		  Var SelectedIds As New Dictionary
		  For Each Vr As Beacon.FileTemplateVariable In SelectVariables
		    SelectedIds.Value(Vr.VariableId) = True
		  Next
		  
		  Var Variables() As Beacon.FileTemplateVariable = Beacon.CommonData.Pool.Get(False).GetFileTemplateVariables(Beacon.CommonData.FlagIncludeUserItems)
		  
		  Self.List.RowCount = Variables.Count
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Self.List.CellTextAt(Idx, Self.ColumnLabel) = Variables(Idx).Label
		    Self.List.CellTextAt(Idx, Self.ColumnName) = Variables(Idx).Name
		    Select Case Variables(Idx).Type
		    Case Beacon.FileTemplateVariable.TypeText
		      Self.List.CellTextAt(Idx, Self.ColumnType) = FileTemplateEditorView.TypeCaptionText
		    Case Beacon.FileTemplateVariable.TypeBoolean
		      Self.List.CellTextAt(Idx, Self.ColumnType) = FileTemplateEditorView.TypeCaptionBoolean
		    Case Beacon.FileTemplateVariable.TypeEnum
		      Self.List.CellTextAt(Idx, Self.ColumnType) = FileTemplateEditorView.TypeCaptionEnum
		    End Select
		    Self.List.RowTagAt(Idx) = Variables(Idx)
		    Self.List.RowSelectedAt(Idx) = SelectedIds.HasKey(Variables(Idx).VariableId)
		  Next
		  
		  Self.List.Sort
		  
		  Self.UpdateStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectVariable As Beacon.FileTemplateVariable)
		  Var Variables() As Beacon.FileTemplateVariable
		  If (SelectVariable Is Nil) = False Then
		    Variables.Add(SelectVariable)
		  End If
		  Self.UpdateList(Variables)
		  Self.List.EnsureSelectionIsVisible
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Self.Status.CenterCaption = Self.List.StatusMessage(Self.NounVariableSingular, Self.NounVariablePlural)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Constant, Name = CaptionCloneField, Type = String, Dynamic = True, Default = \"Duplicate", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CaptionEditField, Type = String, Dynamic = True, Default = \"Edit Field", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CaptionNewField, Type = String, Dynamic = True, Default = \"New Field", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnLabel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnType, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ErrorPasteExplanation, Type = String, Dynamic = True, Default = \"The content is not formatted correctly.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ErrorPasteMessage, Type = String, Dynamic = True, Default = \"There was an error with the pasted content.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeaderCaptionLabel, Type = String, Dynamic = True, Default = \"Display Name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HeaderCaptionName, Type = String, Dynamic = True, Default = \"Accessor", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HeaderCaptionType, Type = String, Dynamic = True, Default = \"Type", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HelpTagCloneField, Type = String, Dynamic = True, Default = \"Create a copy of the selected script fields.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpTagEditField, Type = String, Dynamic = True, Default = \"Edit the selected script field.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpTagNewField, Type = String, Dynamic = True, Default = \"Create a new script field.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.filetemplatevariable", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NounVariablePlural, Type = String, Dynamic = True, Default = \"Script Fields", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NounVariableSingular, Type = String, Dynamic = True, Default = \"Script Field", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events VariablesToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("NewFieldButton", Self.CaptionNewField, IconToolbarAdd, Self.HelpTagNewField))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditFieldButton", Self.CaptionEditField, IconToolbarEdit, Self.HelpTagEditField, Self.List.SelectedRowCount = 1))
		  Me.Append(OmniBarItem.CreateButton("CloneFieldButton", Self.CaptionCloneField, IconToolbarClone, Self.HelpTagCloneField, Self.List.SelectedRowCount > 0))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "NewFieldButton"
		    Self.EditVariable(Nil)
		  Case "EditFieldButton"
		    Self.List.DoEdit()
		  Case "CloneFieldButton"
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
		  Var Variables() As Beacon.FileTemplateVariable
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) Then
		      Variables.Add(Me.RowTagAt(Idx))
		    End If
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Variables, Self.NounVariableSingular.Lowercase, Self.NounVariablePlural.Lowercase) = False Then
		    Return
		  End If
		  
		  Self.DeleteVariables(Variables)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var CopiedData As New JSONItem
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) Then
		      CopiedData.Add(Beacon.FileTemplateVariable(Me.RowTagAt(Idx)).ToJSON)
		    End If
		  Next
		  
		  If CopiedData.Count = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(Self.kClipboardType, CopiedData)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditVariable(Me.RowTagAt(Me.SelectedRowIndex))
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As JSONItem = Board.GetClipboardDataAsJSON(Self.kClipboardType)
		  If Contents Is Nil Then
		    Return
		  End If
		  
		  Try
		    Var Added() As Beacon.FileTemplateVariable
		    Var Bound As Integer = Contents.LastRowIndex
		    For Idx As Integer = 0 To Bound
		      Var Vr As Beacon.FileTemplateVariable = Beacon.FileTemplateVariable.FromJSON(Contents.ChildAt(Idx))
		      If Vr Is Nil Then
		        Continue
		      End If
		      Added.Add(Vr)
		    Next
		    Self.SaveVariables(Added)
		  Catch Err As RuntimeException
		    Self.ShowAlert(Self.ErrorPasteMessage, Self.ErrorPasteExplanation)
		  End Try
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  If (Self.VariablesToolbar.Item("CloneFieldButton") Is Nil) = False Then
		    Self.VariablesToolbar.Item("CloneFieldButton").Enabled = Me.CanCopy()
		  End If
		  If (Self.VariablesToolbar.Item("EditFieldButton") Is Nil) = False Then
		    Self.VariablesToolbar.Item("EditFieldButton").Enabled = Me.CanEdit()
		  End If
		  
		  Self.UpdateStatus
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
