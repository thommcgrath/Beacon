#tag DesktopWindow
Begin TemplatesComponentView ListTemplatesComponent Implements NotificationKit.Receiver
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
   Height          =   438
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
   Width           =   576
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
      DefaultRowHeight=   22
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   366
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Template Name	Game	Type"
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
      Width           =   576
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin OmniBar TemplatesToolbar
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   576
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
      Top             =   407
      Transparent     =   True
      Visible         =   True
      Width           =   576
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
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused action
		  
		  Var AddedTemplates() As Beacon.Template
		  
		  Do
		    If Not Obj.FolderItemAvailable Then
		      Continue
		    End If
		    
		    Var File As FolderItem = Obj.FolderItem
		    If File.ExtensionMatches(Beacon.FileExtensionPreset, Beacon.FileExtensionTemplate) = False Then
		      Continue
		    End If
		    
		    Var Template As Beacon.Template = Beacon.Template.FromSaveData(File)
		    If (Template Is Nil) = False Then
		      AddedTemplates.Add(Template)
		    End If
		  Loop Until Obj.NextItem = False
		  
		  If AddedTemplates.Count > 0 Then
		    Self.SaveTemplates(AddedTemplates)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, "Template Saved")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.AcceptFileDrop(BeaconFileTypes.BeaconPreset)
		  Self.ViewTitle = "Templates"
		  Self.AscendedConversionThread.DebugIdentifier = "ListTemplatesComponent.AscendedConversionThread"
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  NotificationKit.Watch(Self, "Template Saved")
		  
		  If IsNull(UserData) = False Then
		    Self.UpdateList(Beacon.Template(UserData))
		  Else
		    Self.UpdateList()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CloneSelected()
		  If Self.List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var SiblingNames() As String
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Var Sibling As Beacon.Template = Self.List.RowTagAt(Idx)
		    SiblingNames.Add(Sibling.Label)
		  Next Idx
		  
		  Var Clones() As Beacon.Template
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    
		    Var Clone As Beacon.Template = Self.CloneTemplate(Self.List.RowTagAt(Idx), SiblingNames)
		    If (Clone Is Nil) = False Then
		      Clones.Add(Clone)
		    End If
		  Next
		  
		  If Clones.Count = 0 Then
		    Return
		  End If
		  
		  Self.SaveTemplates(Clones)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CloneTemplate(Source As Beacon.Template, SiblingNames() As String) As Beacon.Template
		  Var SaveData As String
		  Try
		    Var SaveDict As Dictionary = Source.SaveData
		    SaveDict.Value("ID") = Beacon.UUID.v4
		    SaveDict.Value("Label") = Beacon.FindUniqueLabel(SaveDict.Value("Label").StringValue, SiblingNames)
		    SiblingNames.Add(SaveDict.Value("Label").StringValue)
		    SaveData = Beacon.GenerateJSON(SaveDict, False)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Could not generate JSON for template save data")
		    Return Nil
		  End Try
		  Return Beacon.Template.FromSaveData(SaveData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteSelected()
		  If Self.List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var TemplatesToDelete() As Beacon.Template
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.RowSelectedAt(Idx) Then
		      Var Template As Beacon.Template = Self.List.RowTagAt(Idx)
		      If Self.CloseTemplate(Template) Then
		        TemplatesToDelete.Add(Template)
		      End If
		    End If
		  Next    
		  Self.DeleteTemplates(TemplatesToDelete)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteTemplates(Templates() As Beacon.Template)
		  Var Th As New Beacon.DeleteTemplateThread(Templates)
		  Th.DebugIdentifier = "Template Delete Thread"
		  AddHandler Th.DeleteComplete, AddressOf DeleteThread_Completed
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteThread_Completed(Sender As Beacon.DeleteTemplateThread)
		  #Pragma Unused Sender
		  
		  Self.UpdateList()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportSelected()
		  If Self.List.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  If Self.List.SelectedRowCount = 1 Then
		    Var Template As Beacon.Template = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		    Var Dialog As New SaveFileDialog
		    Dialog.Filter = BeaconFileTypes.BeaconPreset
		    Dialog.SuggestedFileName = Template.Label + Beacon.FileExtensionTemplate
		    
		    Var File As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		    If (File Is Nil) = False Then
		      Try
		        File.Write(Beacon.GenerateJSON(Template.SaveData, True))
		      Catch Err As RuntimeException
		        Self.ShowAlert("Could not export template", "There was an error saving the template. The disk may be full or may not have write permission.")
		      End Try
		    End If
		    
		    Return
		  End If
		  
		  Var Dialog As New SelectFolderDialog
		  Dialog.PromptText = "Select Folder For Bulk Export"
		  
		  Var Folder As FolderItem = Dialog.ShowModal(Self.TrueWindow)
		  If Folder Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Not Self.List.RowSelectedAt(Idx) Then
		      Continue
		    End If
		    
		    Var Template As Beacon.Template = Self.List.RowTagAt(Idx)
		    Var Contents As String = Beacon.GenerateJSON(Template.SaveData, True)
		    Call Folder.Child(Template.Label + Beacon.FileExtensionTemplate).Write(Contents)
		  Next
		  
		  Folder.Open
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  If Notification.Name = "Template Saved" Then
		    Var Template As Beacon.Template = Notification.UserData
		    Self.UpdateList(Template)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveTemplates(Templates() As Beacon.Template)
		  Var Th As New Beacon.SaveTemplateThread(Templates)
		  Th.DebugIdentifier = "Template Save Thread"
		  AddHandler Th.SaveComplete, AddressOf SaveThread_Completed
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveThread_Completed(Sender As Beacon.SaveTemplateThread)
		  Var Clones() As Beacon.Template = Sender.Templates
		  
		  Self.UpdateList(Clones)
		  
		  If Clones.Count = 1 Then
		    Self.OpenTemplate(Clones(0))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(ParamArray SelectTemplates() As Beacon.Template)
		  Self.UpdateList(SelectTemplates)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectTemplates() As Beacon.Template)
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.Pool.Get(False)
		  Var Templates() As Beacon.Template = CommonData.GetTemplates()
		  Var TemplateCount As Integer = Templates.Count
		  
		  If SelectTemplates.Count = 0 Then
		    For Idx As Integer = 0 To Self.List.LastRowIndex
		      If Self.List.RowSelectedAt(Idx) Then
		        SelectTemplates.Add(Self.List.RowTagAt(Idx))
		      End If
		    Next Idx
		  End If
		  
		  Var SelectUUIDs() As String
		  SelectUUIDs.ResizeTo(SelectTemplates.LastIndex)
		  For Idx As Integer = 0 To SelectTemplates.LastIndex
		    SelectUUIDs(Idx) = SelectTemplates(Idx).UUID
		  Next Idx
		  
		  Self.List.RowCount = TemplateCount
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    Self.List.CellTextAt(Idx, Self.ColumnName) = Templates(Idx).Label
		    Self.List.CellTextAt(Idx, Self.ColumnGame) = Language.GameName(Templates(Idx).GameId)
		    
		    Var CustomTemplate As Boolean = CommonData.IsTemplateCustom(Templates(Idx))
		    Var OfficialTemplate As Boolean = CommonData.IsTemplateOfficial(Templates(Idx))
		    If OfficialTemplate And CustomTemplate Then
		      Self.List.CellTextAt(Idx, Self.ColumnType) = "Customized Built-In"
		    ElseIf OfficialTemplate Then
		      Self.List.CellTextAt(Idx, Self.ColumnType) = "Built-In"
		    Else
		      Self.List.CellTextAt(Idx, Self.ColumnType) = "Custom"
		    End If
		    
		    Self.List.RowTagAt(Idx) = Templates(Idx)
		    Self.List.RowSelectedAt(Idx) = SelectUUIDs.IndexOf(Templates(Idx).UUID) > -1
		  Next
		  
		  Self.List.SizeColumnToFit(Self.ColumnGame, 150)
		  Self.List.SizeColumnToFit(Self.ColumnType, 150)
		  
		  Self.List.Sort
		  Self.List.EnsureSelectionIsVisible
		  
		  Self.UpdateStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Self.Status.CenterCaption = Self.List.StatusMessage("Template", "Templates")
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mConversionTargets() As Ark.LootTemplate
	#tag EndProperty


	#tag Constant, Name = ColumnGame, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnType, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ConvertToArkAscended, Type = String, Dynamic = True, Default = \"Convert to Ark: Survival Ascended", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub SelectionChanged()
		  If (Self.TemplatesToolbar.Item("CloneTemplate") Is Nil) = False Then
		    Self.TemplatesToolbar.Item("CloneTemplate").Enabled = Me.SelectedRowCount > 0
		  End If
		  If (Self.TemplatesToolbar.Item("EditTemplate") Is Nil) = False Then
		    Self.TemplatesToolbar.Item("EditTemplate").Enabled = Me.SelectedRowCount = 1
		  End If
		  If (Self.TemplatesToolbar.Item("ExportTemplate") Is Nil) = False Then
		    Self.TemplatesToolbar.Item("ExportTemplate").Enabled = Me.SelectedRowCount > 0
		  End If
		  
		  Self.UpdateStatus
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Not Me.RowSelectedAt(Idx) Then
		      Continue
		    End If
		    
		    Var Template As Beacon.Template = Me.RowTagAt(Idx)
		    If Beacon.CommonData.Pool.Get(False).IsTemplateCustom(Template) Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.Pool.Get(False)
		  Var DeleteCount, RevertCount, DisallowCount As Integer
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Template As Beacon.Template = Me.RowTagAt(I)
		    Var IsCustom As Boolean = CommonData.IsTemplateCustom(Template)
		    Var IsOfficial As Boolean = CommonData.IsTemplateOfficial(Template)
		    If IsCustom Then
		      If IsOfficial Then
		        RevertCount = RevertCount + 1
		      Else
		        DeleteCount = DeleteCount + 1
		      End If
		    Else
		      DisallowCount = DisallowCount + 1
		    End If
		  Next
		  
		  Var Message, Action As String
		  If DeleteCount > 0 And RevertCount > 0 Then
		    Var TotalCount As Integer = DeleteCount + RevertCount
		    Message = "Are you sure you want to delete or revert these " + TotalCount.ToString(Locale.Current, "0") + " templates?"
		    Action = "Delete"
		  ElseIf DeleteCount = 1 Then
		    Message = "Are you sure you want to delete this template?"
		    Action = "Delete"
		  ElseIf DeleteCount > 1 Then
		    Message = "Are you sure you want to delete these " + DeleteCount.ToString(Locale.Current, "0") + " templates?"
		    Action = "Delete"
		  ElseIf RevertCount = 1 Then
		    Message = "Are you sure you want to revert this template?"
		    Action = "Revert"
		  ElseIf RevertCount > 1 Then
		    Message = "Are you sure you want to revert these " + RevertCount.ToString(Locale.Current, "0") + " templates?"
		    Action = "Revert"
		  Else
		    Return
		  End If
		  
		  Var Explanation As String = "This action cannot be undone."
		  If DisallowCount > 0 Then
		    Explanation = "Built-in templates will not be deleted. " + Explanation
		  End If
		  
		  If Warn And Not Self.ShowConfirm(Message, Explanation, Action, "Cancel") Then
		    Return
		  End If
		  
		  Self.DeleteSelected()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  If Me.SelectedRowIndex > -1 Then
		    Var Template As Beacon.Template = Me.RowTagAt(Me.SelectedRowIndex)
		    Self.OpenTemplate(Template)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  Var RowIdx As Integer = Me.RowFromXY(X, Y)
		  Var Targets() As Beacon.Template
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
		    For Each Target As Beacon.Template In Targets
		      If Target IsA Ark.LootTemplate Then
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
		    Var Targets() As Beacon.Template = HitItem.Tag
		    For Each Target As Beacon.Template In Targets
		      If Target IsA Ark.LootTemplate Then
		        Self.mConversionTargets.Add(Ark.LootTemplate(Target))
		      End If
		    Next
		    If Self.mConversionTargets.Count > 0 Then
		      Self.AscendedConversionThread.Start
		      Self.Progress = BeaconSubview.ProgressIndeterminate
		    Else
		      Self.ShowAlert("Nothing to convert", "None of the selected templates are Ark: Survival Evolved loot templates.")
		    End If
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TemplatesToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("NewTemplate", "New Template", IconToolbarAdd, "Create a new template."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EditTemplate", "Edit Template", IconToolbarEdit, "Edit the selected template.", Self.List.SelectedRowCount = 1))
		  Me.Append(OmniBarItem.CreateButton("CloneTemplate", "Duplicate", IconToolbarClone, "Create a copy of the selected template.", Self.List.SelectedRowCount > 0))
		  Me.Append(OmniBarItem.CreateButton("ExportTemplate", "Export", IconToolbarExport, "Export the selected template to disk for sharing or backup.", Self.List.SelectedRowCount > 0))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "NewTemplate"
		    Self.NewTemplate()
		  Case "EditTemplate"
		    Self.List.DoEdit()
		  Case "CloneTemplate"
		    Self.CloneSelected()
		  Case "ExportTemplate"
		    Self.ExportSelected()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AscendedConversionThread
	#tag Event
		Sub Run()
		  Var ArkSAData As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.Pool.Get(True)
		  Var ConvertedTemplates() As ArkSA.LootTemplate
		  For Each SourceTemplate As Ark.LootTemplate In Self.mConversionTargets
		    Var ConvertedTemplate As ArkSA.LootTemplate = Conversions.EvolvedToAscended(SourceTemplate, ArkSAData, CommonData)
		    If ConvertedTemplate Is Nil Then
		      Continue
		    End If
		    ConvertedTemplates.Add(ConvertedTemplate)
		    CommonData.SaveTemplate(ConvertedTemplate, False, False)
		  Next
		  
		  Var Update As New Dictionary
		  Update.Value("Finished") = True
		  Update.Value("Templates") = ConvertedTemplates
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
		    
		    If Update.HasKey("Templates") Then
		      Var ConvertedTemplates() As ArkSA.LootTemplate = Update.Value("Templates")
		      Self.UpdateList(ConvertedTemplates)
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
