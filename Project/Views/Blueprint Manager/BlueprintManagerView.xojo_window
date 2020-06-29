#tag Window
Begin BeaconSubview BlueprintManagerView Implements NotificationKit.Receiver
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   592
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
   Width           =   806
   Begin BeaconToolbar ListHeader
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      Borders         =   0
      BorderTop       =   False
      Caption         =   "Blueprints"
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   296
   End
   Begin FadedSeparator ListSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   552
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   295
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1
   End
   Begin PagePanel Pages
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   592
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   296
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   510
      Begin FadedSeparator EditorHeaderSeparator
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   1
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   296
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   40
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   510
      End
      Begin BlueprintEditor Editor
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   592
         HelpTag         =   ""
         InitialParent   =   "Pages"
         Left            =   296
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   510
      End
      Begin BlueprintMultiEditor MultiEditor
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   592
         HelpTag         =   ""
         InitialParent   =   "Pages"
         Left            =   296
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumHeight   =   300
         MinimumWidth    =   400
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   0
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   510
      End
      Begin BeaconToolbar EditorHeader
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         BorderBottom    =   False
         BorderLeft      =   False
         BorderRight     =   False
         Borders         =   0
         BorderTop       =   False
         Caption         =   ""
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   40
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   296
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Resizer         =   "0"
         ResizerEnabled  =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   0
         Transparent     =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   510
      End
   End
   Begin BeaconListbox List
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   False
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
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
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   551
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionChangeBlocked=   False
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   41
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   295
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator ListHeaderSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   40
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   295
   End
   Begin Beacon.EngramSearcherThread Searcher
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Timer ClipboardWatcher
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   500
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  NotificationKit.Ignore(Self, LocalData.Notification_EngramsChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  If Self.List.RowCount > 0 Then
		    FileExport.Enable
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  Self.ClipboardWatcher.RunMode = Timer.RunModes.Off
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, LocalData.Notification_EngramsChanged)
		  
		  Self.SetupUI()
		  Self.Title = "Blueprint Manager"
		End Sub
	#tag EndEvent

	#tag Event
		Function ShouldSave() As Boolean
		  If Self.Pages.SelectedPanelIndex = Self.PageEditor And Self.Editor.Modified Then
		    Self.Editor.Save()
		  ElseIf Self.Pages.SelectedPanelIndex = Self.PageMulti And Self.MultiEditor.Modified Then
		    Self.MultiEditor.Save()
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.ClipboardWatcher.RunMode = Timer.RunModes.Multiple
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileExport() As Boolean Handles FileExport.Action
			Self.ExportAll()
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub AddObject()
		  Self.Editor.ObjectID = New v4UUID
		  Self.Pages.SelectedPanelIndex = Self.PageEditor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ClipboardHasCodes() As Boolean
		  Var Board As New Clipboard
		  If Not Board.TextAvailable Then
		    Return False
		  End If
		  
		  Var Content As String = Board.Text
		  Return Content.IndexOf("Blueprint") > -1 Or Content.IndexOf("giveitem") > -1 Or Content.IndexOf("spawndino") > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmClose(Callback As BeaconSubview.BringToFrontDelegate) As Boolean
		  If Self.Pages.SelectedPanelIndex = Self.PageEmpty Or (Self.Pages.SelectedPanelIndex = Self.PageEditor And Not Self.Editor.Modified) Or (Self.Pages.SelectedPanelIndex = Self.PageMulti And Not Self.MultiEditor.Modified) Then
		    Return True
		  End If
		  
		  If Callback <> Nil Then
		    Callback.Invoke(Self)
		  End If
		  
		  If Self.Pages.SelectedPanelIndex = Self.PageEditor Then
		    Self.Editor.ObjectID = v4UUID.CreateNull
		    Return Not Self.Editor.Modified
		  ElseIf Self.Pages.SelectedPanelIndex = Self.PageMulti Then
		    Self.MultiEditor.Blueprints = Nil
		    Return Not Self.MultiEditor.Modified
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportAll()
		  Var Dialog As New SaveFileDialog
		  Dialog.SuggestedFileName = "Beacon Objects.csv"
		  Dialog.PromptText = "Export objects to CSV"
		  Dialog.Filter = BeaconFileTypes.CSVFile
		  
		  Var File As FolderItem = Dialog.ShowModalWithin(Self.TrueWindow)
		  If File <> Nil Then
		    Var Mods As New Beacon.StringList
		    Mods.Append(LocalData.UserModID)
		    
		    Var Engrams() As Beacon.Blueprint = LocalData.SharedInstance.SearchForBlueprints(Beacon.CategoryEngrams, "", Mods, "")
		    Var Creatures() As Beacon.Blueprint = LocalData.SharedInstance.SearchForBlueprints(Beacon.CategoryCreatures, "", Mods, "")
		    Var Points() As Beacon.Blueprint = LocalData.SharedInstance.SearchForBlueprints(Beacon.CategorySpawnPoints, "", Mods, "")
		    Var Blueprints() As Beacon.Blueprint
		    For Each Engram As Beacon.Blueprint In Engrams
		      Blueprints.AddRow(Engram)
		    Next
		    For Each Creature As Beacon.Blueprint In Creatures
		      Blueprints.AddRow(Creature)
		    Next
		    For Each Point As Beacon.Blueprint In Points
		      Blueprints.AddRow(Point)
		    Next
		    
		    Var CSV As String = Beacon.CreateCSV(Blueprints)
		    Var Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(CSV)
		    Stream.Close
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromClipboard()
		  Var Board As New Clipboard
		  If Board.TextAvailable Then
		    Self.ImportText(Board.Text)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFromFile(File As FolderItem = Nil)
		  If File = Nil Then
		    File = Self.PromptForImportFile(Self)
		  End If
		  If File = Nil Then
		    Return
		  End If
		  
		  Self.ImportText(File.Read)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportText(Content As String)
		  If Content = "" Then
		    Return
		  End If
		  
		  Self.Searcher.Search(Content)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case LocalData.Notification_EngramsChanged
		    Self.SetupUI()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PromptForImportFile(Parent As Window) As FolderItem
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.Text + BeaconFileTypes.CSVFile
		  Return Dialog.ShowModalWithin(Parent.TrueWindow)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PromptForImportURL(Parent As Window) As String
		  Return LibraryEngramsURLDialog.Present(Parent)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Var Mods As New Beacon.StringList(0)
		  Mods(0) = LocalData.UserModID
		  
		  Var Engrams() As Beacon.Engram = LocalData.SharedInstance.SearchForEngrams("", Mods)
		  Var Creatures() As Beacon.Creature = LocalData.SharedInstance.SearchForCreatures("", Mods)
		  Var Points() As Beacon.SpawnPoint = LocalData.SharedInstance.SearchForSpawnPoints("", Mods)
		  Var Blueprints() As Beacon.Blueprint
		  Var Labels() As String
		  For Each Engram As Beacon.Engram In Engrams
		    Blueprints.AddRow(Engram)
		    Labels.AddRow(Engram.Label)
		  Next
		  For Each Creature As Beacon.Creature In Creatures
		    Blueprints.AddRow(Creature)
		    Labels.AddRow(Creature.Label)
		  Next
		  For Each Point As Beacon.SpawnPoint In Points
		    Blueprints.AddRow(Point)
		    Labels.AddRow(Point.Label)
		  Next
		  Labels.SortWith(Blueprints)
		  
		  Var SelectedPaths() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.Selected(I) Then
		      SelectedPaths.AddRow(Beacon.Blueprint(Self.List.RowTagAt(I)).Path)
		    End If
		  Next
		  
		  Self.mSettingUp = True
		  Self.List.RowCount = Blueprints.LastRowIndex + 1
		  For I As Integer = 0 To Blueprints.LastRowIndex
		    Var Blueprint As Beacon.Blueprint = Blueprints(I)
		    
		    Self.List.RowTagAt(I) = Blueprint
		    Self.List.CellValueAt(I, 0) = Blueprint.Label
		    Self.List.Selected(I) = SelectedPaths.IndexOf(Blueprint.Path) > -1
		  Next
		  Self.List.EnsureSelectionIsVisible()
		  Self.mSettingUp = False
		  Self.UpdateEditorWithSelection()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEditorWithSelection()
		  If Self.List.SelectedRowCount = 0 Then
		    If Self.Pages.SelectedPanelIndex = Self.PageEditor Then
		      Self.Editor.ObjectID = v4UUID.CreateNull
		      If Not Self.Editor.Modified Then
		        Self.Pages.SelectedPanelIndex = Self.PageEmpty
		      End If
		    ElseIf Self.Pages.SelectedPanelIndex = Self.PageMulti Then
		      Self.MultiEditor.Blueprints = Nil
		      If Not Self.MultiEditor.Modified Then
		        Self.Pages.SelectedPanelIndex = Self.PageEmpty
		      End If
		    End If
		  ElseIf Self.List.SelectedRowCount = 1 Then
		    If Self.Pages.SelectedPanelIndex = Self.PageMulti Then
		      Self.MultiEditor.Blueprints = Nil
		      If Self.MultiEditor.Modified Then
		        Return
		      End If
		    End If
		    
		    Var Blueprint As Beacon.Blueprint = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		    Self.Editor.ObjectID = Blueprint.ObjectID
		    
		    If Self.Pages.SelectedPanelIndex <> Self.PageEditor Then
		      Self.Pages.SelectedPanelIndex = Self.PageEditor
		    End If
		  ElseIf Self.List.SelectedRowCount > 1 Then
		    If Self.Pages.SelectedPanelIndex = Self.PageEditor Then
		      Self.Editor.ObjectID = v4UUID.CreateNull
		      If Self.Editor.Modified Then
		        Return
		      End If
		    End If
		    
		    Var Blueprints() As Beacon.Blueprint
		    For I As Integer = 0 To Self.List.RowCount - 1
		      If Self.List.Selected(I) Then
		        Blueprints.AddRow(Beacon.Blueprint(Self.List.RowTagAt(I)))
		      End If
		    Next
		    Self.MultiEditor.Blueprints = Blueprints
		    
		    If Self.Pages.SelectedPanelIndex <> Self.PageMulti Then
		      Self.Pages.SelectedPanelIndex = Self.PageMulti
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mProgress As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = PageEditor, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageEmpty, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageMulti, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ListHeader
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddObject"
		    Self.AddObject()
		  Case "ImportClipboard"
		    Self.ImportFromClipboard()
		  Case "ImportURL"
		    Self.ImportText(Self.PromptForImportURL(Self))
		  Case "ImportFile"
		    Self.ImportFromFile()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("AddObject", IconToolbarAdd, "Define a new blueprint"))
		  
		  Me.RightItems.Append(New BeaconToolbarItem("ImportFile", IconToolbarFile, "Import from file"))
		  Me.RightItems.Append(New BeaconToolbarItem("ImportURL", IconToolbarLink, "Import from website"))
		  Me.RightItems.Append(New BeaconToolbarItem("ImportClipboard", IconToolbarCopied, Self.ClipboardHasCodes, "Import from copied text"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub Change()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageEmpty
		    Self.Changed = False
		  Case Self.PageEditor
		    Self.Changed = Self.Editor.Changed
		  Case Self.PageMulti
		    Self.Changed = Self.Editor.Changed
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub ContentsChanged()
		  If Self.Pages.SelectedPanelIndex = Self.PageEditor Then
		    Self.Changed = Me.Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MultiEditor
	#tag Event
		Sub ContentsChanged()
		  If Self.Pages.SelectedPanelIndex = Self.PageMulti Then
		    Self.Changed = Me.Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Change()
		  If Not Self.mSettingUp Then
		    Self.UpdateEditorWithSelection()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  If Warn Then
		    Var Message As String
		    If Me.SelectedRowCount = 1 Then
		      Message = "Are you sure you want to delete this object?"
		    Else
		      Message = "Are you sure you want to delete these " + Str(Me.SelectedRowCount, "-0") + " objects?"
		    End If
		    
		    If Not Self.ShowConfirm(Message, "This action cannot be undone.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Var Objects() As Beacon.Blueprint
		  For I As Integer = 0 To Me.RowCount - 1
		    If Me.Selected(I) Then
		      Objects.AddRow(Beacon.Blueprint(Me.RowTagAt(I)))
		    End If
		  Next
		  
		  LocalData.SharedInstance.DeleteBlueprints(Objects)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Searcher
	#tag Event
		Sub Finished()
		  Self.Progress = BeaconSubview.ProgressNone
		  
		  Var Blueprints() As Beacon.Blueprint = Me.Blueprints(True)
		  Var ImportedCount As Integer = LocalData.SharedInstance.SaveBlueprints(Blueprints, False)
		  Var SkippedCount As Integer = (Blueprints.LastRowIndex + 1) - ImportedCount
		  
		  Self.SetupUI()
		  
		  Var Messages() As String
		  If ImportedCount = 1 Then
		    Messages.AddRow("1 object was added.")
		  ElseIf ImportedCount > 1 Then
		    Messages.AddRow(Str(ImportedCount, "-0") + " objects were added.")
		  End If
		  If SkippedCount = 1 Then
		    Messages.AddRow("1 object was skipped because it already exists in the database.")
		  ElseIf SkippedCount > 1 Then
		    Messages.AddRow(Str(SkippedCount, "-0") + " objects were skipped because they already exist in the database.")
		  End If
		  If ImportedCount = 0 And SkippedCount = 0 Then
		    Messages.AddRow("No objects were found to import.")
		  End If
		  
		  Self.ShowAlert("Object import has finished", Messages.Join(" "))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.Progress = BeaconSubview.ProgressIndeterminate
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClipboardWatcher
	#tag Event
		Sub Action()
		  Self.ListHeader.ImportClipboard.Enabled = Self.ClipboardHasCodes
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
