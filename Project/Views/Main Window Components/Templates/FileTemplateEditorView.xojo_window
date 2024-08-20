#tag DesktopWindow
Begin TemplateEditorView FileTemplateEditorView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   466
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
   Width           =   762
   Begin OmniBar TemplateToolbar
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
      Width           =   762
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   425
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   762
      Begin UITweaks.ResizedTextField NameField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   142
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   600
      End
      Begin UITweaks.ResizedLabel NameLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "#NameCaption"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   110
      End
      Begin CodeEditor BodyArea
         AutoDeactivate  =   True
         Enabled         =   True
         HasBorder       =   False
         Height          =   362
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ShowInfoBar     =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   104
         Visible         =   True
         Width           =   762
      End
      Begin FadedSeparator TopBorder
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   103
         Transparent     =   True
         Visible         =   True
         Width           =   762
      End
      Begin BeaconListbox VarsList
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   True
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   True
         Bold            =   False
         ColumnCount     =   3
         ColumnWidths    =   "*,*,150"
         DefaultRowHeight=   -1
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
         Height          =   425
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         TotalPages      =   -1
         Transparent     =   False
         TypeaheadColumn =   0
         Underline       =   False
         Visible         =   True
         Width           =   762
         _ScrollWidth    =   -1
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  If Self.Modified Then
		    FileSave.Enabled = True
		    If (Self.mSaveFile Is Nil) = False Then
		      FileSaveAs.Enabled = True
		    End If
		  End If
		  If Self.mSaveFile Is Nil Then
		    FileExport.Enabled = True
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.UpdateUI()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShouldSave(CloseWhenFinished As Boolean)
		  Self.mCloseAfterSave = CloseWhenFinished
		  Self.Save()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Template As Beacon.FileTemplate, SourceFile As FolderItem = Nil)
		  Self.mTemplate = New Beacon.MutableFileTemplate(Template)
		  Self.ViewID = Template.UUID
		  Self.mSaveFile = SourceFile
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Save()
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.Caption = Self.mTemplate.Label
		  End If
		  
		  Self.Progress = BeaconSubview.ProgressIndeterminate
		  
		  If Self.mSaveFile Is Nil Then
		    Var SaveThread As New Beacon.SaveTemplateThread(Self.mTemplate)
		    SaveThread.DebugIdentifier = "FileTemplateEditorView.SaveThread"
		    AddHandler SaveThread.SaveComplete, AddressOf SaveThread_SaveComplete
		    SaveThread.Start
		  Else
		    Var Writer As New Beacon.JSONWriter(Self.mTemplate.SaveData, Self.mSaveFile)
		    AddHandler Writer.Finished, AddressOf Writer_Finished
		    Writer.Start
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveThread_SaveComplete(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Self.ViewID = Self.mTemplate.UUID
		  
		  Self.Modified = False
		  Self.mTemplate = New Beacon.MutableFileTemplate(Self.mTemplate) // Makes an unmodified copy
		  NotificationKit.Post("Template Saved", Self.mTemplate)
		  
		  Self.Progress = BeaconSubview.ProgressNone
		  
		  If Self.mCloseAfterSave Then
		    Self.RequestClose()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  If (Self.mSaveFile Is Nil) = False Then
		    Self.Title = Self.mSaveFile.DisplayName
		  Else
		    Self.Title = Self.mTemplate.Label
		  End If
		  Self.ViewTitle = Self.Title
		  Self.mUpdating = True
		  Self.Modified = False
		  
		  Self.NameField.Text = Self.mTemplate.Label
		  Self.BodyArea.Text = Self.mTemplate.Body
		  
		  Self.UpdateVariablesList()
		  
		  Self.mUpdating = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateVariablePositions()
		  Var Vars() As Beacon.FileTemplateVariable
		  For RowIdx As Integer = 0 To Self.VarsList.LastRowIndex
		    Vars.Add(Self.VarsList.RowTagAt(RowIdx))
		  Next
		  Self.mTemplate.Variables = Vars
		  Self.Modified = Self.mTemplate.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateVariablesList()
		  Var SelectedVars() As Beacon.FileTemplateVariable
		  For RowIdx As Integer = 0 To Self.VarsList.LastRowIndex
		    If Self.VarsList.RowSelectedAt(RowIdx) Then
		      SelectedVars.Add(Self.VarsList.RowTagAt(RowIdx))
		    End If
		  Next
		  Self.UpdateVariablesList(SelectedVars)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateVariablesList(SelectedVars() As Beacon.FileTemplateVariable)
		  Var SelDict As New Dictionary
		  For Each Vr As Beacon.FileTemplateVariable In SelectedVars
		    SelDict.Value(Vr.VariableId) = True
		  Next
		  
		  Var Vars() As Beacon.FileTemplateVariable = Self.mTemplate.Variables
		  Self.VarsList.RowCount = Vars.Count
		  For RowIdx As Integer = 0 To Vars.LastIndex
		    Self.VarsList.CellTextAt(RowIdx, Self.ColumnVarLabel) = Vars(RowIdx).Label
		    Self.VarsList.CellTextAt(RowIdx, Self.ColumnVarName) = Vars(RowIdx).Name
		    Select Case Vars(RowIdx).Type
		    Case Beacon.FileTemplateVariable.TypeText
		      Self.VarsList.CellTextAt(RowIdx, Self.ColumnVarType) = TypeCaptionText
		    Case Beacon.FileTemplateVariable.TypeBoolean
		      Self.VarsList.CellTextAt(RowIdx, Self.ColumnVarType) = TypeCaptionBoolean
		    Case Beacon.FileTemplateVariable.TypeEnum
		      Self.VarsList.CellTextAt(RowIdx, Self.ColumnVarType) = TypeCaptionEnum
		    End Select
		    Self.VarsList.RowTagAt(RowIdx) = Vars(RowIdx)
		    Self.VarsList.RowSelectedAt(RowIdx) = SelDict.HasKey(Vars(RowIdx).VariableId)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateVariablesList(SelectedVar As Beacon.FileTemplateVariable)
		  Self.UpdateVariablesList(Array(SelectedVar))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Writer_Finished(Sender As Beacon.JSONWriter, Destination As FolderItem)
		  #Pragma Unused Sender
		  
		  Self.Modified = False
		  NotificationKit.Post("Template Saved", Self.mTemplate)
		  
		  Self.Progress = BeaconSubview.ProgressNone
		  Self.ViewID = EncodeHex(Crypto.MD5(Destination.NativePath))
		  
		  If Self.mCloseAfterSave Then
		    Self.RequestClose()
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCloseAfterSave As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemplate As Beacon.MutableFileTemplate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


	#tag Constant, Name = AddVariableCaption, Type = String, Dynamic = True, Default = \"New Field", Scope = Private
	#tag EndConstant

	#tag Constant, Name = AddVariableHelpTag, Type = String, Dynamic = True, Default = \"Add a new custom field that will be passed to this script when built.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnVarLabel, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnVarName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnVarType, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ContentsCaption, Type = String, Dynamic = True, Default = \"Contents", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeaderCaptionLabel, Type = String, Dynamic = True, Default = \"Display Name", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeaderCaptionName, Type = String, Dynamic = True, Default = \"Accessor", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeaderCaptionType, Type = String, Dynamic = True, Default = \"Type", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.templatevariable", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NameCaption, Type = String, Dynamic = True, Default = \"Template Name:", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NounVariablePlural, Type = String, Dynamic = True, Default = \"Fields", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NounVariableSingular, Type = String, Dynamic = True, Default = \"Field", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageScript, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageVariables, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TypeCaptionBoolean, Type = String, Dynamic = True, Default = \"Switch", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeCaptionEnum, Type = String, Dynamic = True, Default = \"Menu", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeCaptionText, Type = String, Dynamic = True, Default = \"Text", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VariablesCaption, Type = String, Dynamic = True, Default = \"Custom Fields", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TemplateToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTab("ScriptTab", Self.ContentsCaption))
		  Me.Append(OmniBarItem.CreateTab("VariablesTab", Self.VariablesCaption))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddVariableButton", Self.AddVariableCaption, IconToolbarAdd, Self.AddVariableHelpTag))
		  
		  Me.Item("ScriptTab").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "ScriptTab"
		    Self.Pages.SelectedPanelIndex = Self.PageScript
		  Case "VariablesTab"
		    Self.Pages.SelectedPanelIndex = Self.PageVariables
		  Case "AddVariableButton"
		    Var NewVar As Beacon.FileTemplateVariable = FileTemplateVariableEditorDialog.Present(Self)
		    If (NewVar Is Nil) = False Then
		      Self.mTemplate.Add(NewVar)
		      Self.Modified = Self.mTemplate.Modified
		      Self.UpdateVariablesList(NewVar)
		    End If
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Var ScriptTab As OmniBarItem = Self.TemplateToolbar.Item("ScriptTab")
		  If (ScriptTab Is Nil) = False Then
		    ScriptTab.Toggled = Me.SelectedPanelIndex = Self.PageScript
		  End If
		  
		  Var VariablesTab As OmniBarItem = Self.TemplateToolbar.Item("VariablesTab")
		  If (VariablesTab Is Nil) = False Then
		    VariablesTab.Toggled = Me.SelectedPanelIndex = Self.PageVariables
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.mTemplate.Label = Me.Text.Trim
		  Self.Modified = Self.mTemplate.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BodyArea
	#tag Event
		Sub TextChanged()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.mTemplate.Body = Me.Text
		  Self.Modified = Self.mTemplate.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VarsList
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
		Function DragReorderRows(newPosition as Integer, parentRow as Integer) As Boolean
		  #Pragma Unused NewPosition
		  #Pragma Unused ParentRow
		  
		  Call CallLater.Schedule(1, AddressOf UpdateVariablePositions)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Var SelVars() As Beacon.FileTemplateVariable
		    For RowIdx As Integer = 0 To Me.LastRowIndex
		      If Me.RowSelectedAt(RowIdx) = False Then
		        Continue
		      End If
		      
		      SelVars.Add(Me.RowTagAt(RowIdx))
		    Next
		    If Self.ShowDeleteConfirmation(SelVars, Self.NounVariableSingular.Lowercase, Self.NounVariablePlural.Lowercase) = False Then
		      Return
		    End If
		  End If
		  
		  For RowIdx As Integer = Me.LastRowIndex DownTo 0
		    If Me.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Self.mTemplate.RemoveAt(RowIdx)
		  Next
		  Self.Modified = Self.mTemplate.Modified
		  Self.UpdateVariablesList
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Data As New JSONItem
		  For RowIdx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(RowIdx) = False Then
		      Continue
		    End If
		    
		    Var SaveData As JSONItem = Beacon.FileTemplateVariable(Me.RowTagAt(RowIdx)).ToJSON
		    If (SaveData Is Nil) = False Then
		      Data.Add(SaveData)
		    End If
		  Next
		  Board.AddClipboardData(Self.kClipboardType, Data)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Var Original As Beacon.FileTemplateVariable = Me.RowTagAt(Me.SelectedRowIndex)
		  Var Edited As Beacon.FileTemplateVariable = FileTemplateVariableEditorDialog.Present(Self, Original)
		  If Edited Is Nil Then
		    Return
		  End If
		  
		  Self.mTemplate.Add(Edited)
		  Self.Modified = Self.mTemplate.Modified
		  Self.UpdateVariablesList(Edited)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As JSONItem = Board.GetClipboardDataAsJSON(Self.kClipboardType)
		  If Contents Is Nil Then
		    Return
		  End If
		  
		  Var Bound As Integer = Contents.LastRowIndex
		  Var SelVars() As Beacon.FileTemplateVariable
		  For Idx As Integer = 0 To Bound
		    Var SaveData As JSONItem = Contents.ChildAt(Idx)
		    If SaveData Is Nil Then
		      Continue
		    End If
		    
		    Var Vr As Beacon.FileTemplateVariable = Beacon.FileTemplateVariable.FromJSON(SaveData)
		    If Vr Is Nil Then
		      Continue
		    End If
		    
		    Self.mTemplate.Add(Vr)
		    Self.Modified = Self.mTemplate.Modified
		    SelVars.Add(Vr)
		  Next
		  Self.UpdateVariablesList(SelVars)
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
