#tag Window
Begin TemplatesComponentView ListTemplatesComponent Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
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
      ColumnCount     =   2
      ColumnWidths    =   "*,200"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   False
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   397
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Template Name	Type"
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   576
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
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
		      Beacon.CommonData.SharedInstance.SaveTemplate(Template)
		      AddedTemplates.Add(Template)
		    End If
		  Loop Until Obj.NextItem = False
		  
		  If AddedTemplates.Count > 0 Then
		    Self.UpdateList(AddedTemplates)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, "Template Saved")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.AcceptFileDrop(BeaconFileTypes.BeaconPreset)
		  Self.ViewTitle = "Templates"
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
		    If Self.List.Selected(Idx) = False Then
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
		  
		  For Each Clone As Beacon.Template In Clones
		    Beacon.CommonData.SharedInstance.SaveTemplate(Clone)
		  Next
		  
		  Self.UpdateList(Clones)
		  
		  If Clones.Count = 1 Then
		    Self.OpenTemplate(Clones(0))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CloneTemplate(Source As Beacon.Template, SiblingNames() As String) As Beacon.Template
		  Var SaveData As String
		  Try
		    Var SaveDict As Dictionary = Source.SaveData
		    SaveDict.Value("ID") = v4UUID.Create.StringValue
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
		  
		  For Idx As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.Selected(Idx) Then
		      Var Template As Beacon.Template = Self.List.RowTagAt(Idx)
		      If Self.CloseTemplate(Template) Then
		        Beacon.CommonData.SharedInstance.DeleteTemplate(Template)
		      End If
		    End If
		  Next    
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
		      Var Contents As String = Beacon.GenerateJSON(Template.SaveData, True)
		      If File.Write(Contents) = False Then
		        Self.ShowAlert("Could not export template", "There was an error saving the template. The disk may be full or may not have write permission.")
		      End If
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
		    If Not Self.List.Selected(Idx) Then
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
		Private Sub UpdateList(ParamArray SelectTemplates() As Beacon.Template)
		  Self.UpdateList(SelectTemplates)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectTemplates() As Beacon.Template)
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.SharedInstance
		  Var Templates() As Beacon.Template = CommonData.GetTemplates()
		  Var TemplateCount As Integer = Templates.Count
		  
		  If SelectTemplates.Count = 0 Then
		    For Idx As Integer = 0 To Self.List.LastRowIndex
		      If Self.List.Selected(Idx) Then
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
		    Self.List.CellValueAt(Idx, 0) = Templates(Idx).Label
		    
		    Var CustomTemplate As Boolean = CommonData.IsTemplateCustom(Templates(Idx))
		    Var OfficialTemplate As Boolean = CommonData.IsTemplateOfficial(Templates(Idx))
		    If OfficialTemplate And CustomTemplate Then
		      Self.List.CellValueAt(Idx, 1) = "Customized Built-In"
		    ElseIf OfficialTemplate Then
		      Self.List.CellValueAt(Idx, 1) = "Built-In"
		    Else
		      Self.List.CellValueAt(Idx, 1) = "Custom"
		    End If
		    
		    Self.List.RowTagAt(Idx) = Templates(Idx)
		    Self.List.Selected(Idx) = SelectUUIDs.IndexOf(Templates(Idx).UUID) > -1
		  Next Idx
		  
		  Self.List.Sort
		  Self.List.EnsureSelectionIsVisible
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Change()
		  If (Self.TemplatesToolbar.Item("CloneTemplate") Is Nil) = False Then
		    Self.TemplatesToolbar.Item("CloneTemplate").Enabled = Me.SelectedRowCount > 0
		  End If
		  If (Self.TemplatesToolbar.Item("EditTemplate") Is Nil) = False Then
		    Self.TemplatesToolbar.Item("EditTemplate").Enabled = Me.SelectedRowCount = 1
		  End If
		  If (Self.TemplatesToolbar.Item("ExportTemplate") Is Nil) = False Then
		    Self.TemplatesToolbar.Item("ExportTemplate").Enabled = Me.SelectedRowCount > 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(1) = Listbox.Alignments.Right
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Not Me.Selected(Idx) Then
		      Continue
		    End If
		    
		    Var Template As Beacon.Template = Me.RowTagAt(Idx)
		    If Beacon.CommonData.SharedInstance.IsTemplateCustom(Template) Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var CommonData As Beacon.CommonData = Beacon.CommonData.SharedInstance
		  Var DeleteCount, RevertCount, DisallowCount As Integer
		  For I As Integer = Me.RowCount - 1 DownTo 0
		    If Not Me.Selected(I) Then
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
#tag EndEvents
#tag Events TemplatesToolbar
	#tag Event
		Sub Open()
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
		Type="Color"
		EditorType="Color"
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
		Name="EraseBackground"
		Visible=false
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
