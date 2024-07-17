#tag DesktopWindow
Begin BeaconDialog ArkSALowConfidenceBlueprintsDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   466
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1233248255
   MenuBarVisible  =   False
   MinimumHeight   =   450
   MinimumWidth    =   600
   Resizeable      =   True
   Title           =   "#DialogTitle"
   Type            =   8
   Visible         =   False
   Width           =   600
   Begin DesktopLabel TitleLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#DialogTitle"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   75
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#ExplanationCaption"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   True
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   3
      ColumnWidths    =   ""
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
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   267
      Index           =   -2147483648
      InitialValue    =   "#HeaderBlueprintName	#HeaderType	#HeaderClassName"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   139
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "#CancelCaption"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   464
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   426
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   116
   End
   Begin DesktopProgressWheel Spinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   430
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel SavingLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   16
      Index           =   -2147483648
      Italic          =   False
      Left            =   48
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "#SavingCaption"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   430
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   242
   End
   Begin Beacon.Thread SaveThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddBlueprintsToList(ContentPackId As String)
		  Var BlueprintNames() As String
		  Var Blueprints() As ArkSA.Blueprint
		  For Each Blueprint As ArkSA.Blueprint In Self.mCandidates
		    If Blueprint.ContentPackId <> ContentPackId Then
		      Continue
		    End If
		    
		    Blueprints.Add(Blueprint)
		    BlueprintNames.Add(Blueprint.Label)
		  Next
		  
		  BlueprintNames.SortWith(Blueprints)
		  
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Var Type As String
		    Select Case Blueprint
		    Case IsA ArkSA.Engram
		      Type = "Engram"
		    Case IsA ArkSA.Creature
		      Type = "Creature"
		    Case IsA ArkSA.LootContainer
		      Type = "Loot Drop"
		    Case IsA ArkSA.SpawnPoint
		      Type = "Spawn Point"
		    End Select
		    
		    Self.List.AddRow(Blueprint.Label, Type, Blueprint.ClassString)
		    Var RowIdx As Integer = Self.List.LastAddedRowIndex
		    Self.List.RowTagAt(RowIdx) = Blueprint
		    Self.List.CellCheckBoxValueAt(RowIdx, Self.ColumnBlueprintName) = Self.mSelectedBlueprints.HasKey(Blueprint.BlueprintId)
		  Next
		  Self.List.SizeColumnToFit(Self.ColumnType)
		  Self.List.SizeColumnToFit(Self.ColumnClassName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddCandidates(Blueprints() As ArkSA.Blueprint)
		  If Blueprints Is Nil Then
		    Return
		  End If
		  
		  Var Provider As ArkSA.BlueprintProvider
		  If Self.mSettings.ReplaceBlueprints = False Then
		    If Self.mController Is Nil Then
		      Provider = ArkSA.DataSource.Pool.Get(False)
		    Else
		      Provider = Self.mController
		    End If
		  End If
		  
		  For Idx As Integer = 0 To Blueprints.LastIndex
		    If Blueprints(Idx) Is Nil Then
		      Continue
		    End If
		    
		    If Self.mSettings.ReplaceBlueprints = False And (Provider.GetBlueprint(Blueprints(Idx).BlueprintId, False) Is Nil) = False Then
		      Continue
		    End If
		    
		    Self.mCandidates.Add(Blueprints(Idx))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Settings As ArkSA.ModDiscoverySettings, Controller As ArkSA.BlueprintController)
		  // Calling the overridden superclass constructor.
		  Self.mSettings = Settings
		  Self.mController = Controller
		  Self.mSelectedBlueprints = New Dictionary
		  Super.Constructor
		  Self.SaveThread.DebugIdentifier = "ArkSALowConfidenceBlueprintsDialog.SaveThread"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasCandidates() As Boolean
		  Return Self.mCandidates.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Present(Parent As DesktopWindow)
		  If Self.mCandidates.Count = 0 Then
		    Self.Close
		    Return
		  End If
		  
		  If (Parent Is Nil) = False Then
		    Parent = Parent.TrueWindow
		  End If
		  
		  Self.SetupUI()
		  Self.ShowModal(Parent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  Self.ExplanationLabel.Height = Self.ExplanationLabel.IdealHeight
		  Self.List.Top = Self.ExplanationLabel.Bottom + 12
		  Self.List.Height = Self.ActionButton.Top - (20 + Self.List.Top)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Self.UpdateActionButton()
		  Self.Resize()
		  
		  Var PacksFilter As New Dictionary
		  Var PackNames() As String
		  Var PackIds() As String
		  For Each Blueprint As ArkSA.Blueprint In Self.mCandidates
		    If PacksFilter.HasKey(Blueprint.ContentPackId) Then
		      Continue
		    End If
		    
		    PackNames.Add(Blueprint.ContentPackName)
		    PackIds.Add(Blueprint.ContentPackId)
		    PacksFilter.Value(Blueprint.ContentPackId) = True
		  Next
		  
		  If PackIds.Count = 1 And Self.mSettings.ModIds.Count = 1 Then
		    Self.AddBlueprintsToList(PackIds(0))
		    Self.List.AllowExpandableRows = False
		    Return
		  End If
		  
		  PackNames.SortWith(PackIds)
		  
		  For Idx As Integer = 0 To PackIds.LastIndex
		    Self.List.AddExpandableRow(PackNames(Idx))
		    Var RowIdx As Integer = Self.List.LastAddedRowIndex
		    Self.List.RowTagAt(RowIdx) = PackIds(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateActionButton()
		  Self.ActionButton.Caption = If(Self.mSelectedBlueprints.KeyCount = 0, Self.CancelCaption, Self.ActionCaption)
		  Self.ActionButton.SizeToFit
		  Self.ActionButton.Left = Self.Width - (20 + Self.ActionButton.Width)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCandidates() As ArkSA.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mController As ArkSA.BlueprintController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettings As ArkSA.ModDiscoverySettings
	#tag EndProperty


	#tag Constant, Name = ActionCaption, Type = String, Dynamic = True, Default = \"Save Selected", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CancelCaption, Type = String, Dynamic = True, Default = \"Discard All", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnBlueprintName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnClassName, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnType, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DialogTitle, Type = String, Dynamic = True, Default = \"Unconfirmed Blueprints Found", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ErrorAlertMessage, Type = String, Dynamic = True, Default = \"There were saving errors", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ExplanationCaption, Type = String, Dynamic = True, Default = \"Beacon found blueprints that it was unable to confirm are used by their mod. They exist in the mod\'s asset registry\x2C but Beacon could not find any route to them using expected mod properties. They may be used by code that Beacon cannot see\x2C abstract classes\x2C or even objects the mod author left in and forgot to remove.\n\nClick the check boxes next to blueprints you want to keep.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeaderBlueprintName, Type = String, Dynamic = True, Default = \"Blueprint Name", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeaderClassName, Type = String, Dynamic = True, Default = \"Class Name", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeaderType, Type = String, Dynamic = True, Default = \"Type", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SavingCaption, Type = String, Dynamic = True, Default = \"Saving Blueprints\xE2\x80\xA6", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(Self.ColumnBlueprintName) = DesktopListBox.CellTypes.CheckBox
		End Sub
	#tag EndEvent
	#tag Event
		Sub RowExpanded(row As Integer)
		  Var ContentPackId As String = Me.RowTagAt(Row)
		  Self.AddBlueprintsToList(ContentPackId)
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Var IsFolder As Boolean = Me.RowExpandableAt(Row)
		  Var Checked As Boolean = Me.CellCheckBoxStateAt(Row, Column) = DesktopCheckBox.VisualStates.Checked
		  
		  If IsFolder Then
		    Var ContentPackId As String = Me.RowTagAt(Row)
		    For Each Blueprint As ArkSA.Blueprint In Self.mCandidates
		      If Blueprint.ContentPackId <> ContentPackId Then
		        Continue
		      End If
		      
		      If Checked Then
		        Self.mSelectedBlueprints.Value(Blueprint.BlueprintId) = Blueprint
		      ElseIf Self.mSelectedBlueprints.HasKey(Blueprint.BlueprintId) Then
		        Self.mSelectedBlueprints.Remove(Blueprint.BlueprintId)
		      End If
		    Next
		    
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.RowExpandableAt(Idx) Then
		        Continue
		      End If
		      
		      Var Blueprint As ArkSA.Blueprint = Me.RowTagAt(Idx)
		      If Blueprint.ContentPackId = ContentPackId Then
		        Me.CellCheckBoxValueAt(Idx, Column) = Checked
		      End If
		    Next
		  Else
		    Var Blueprint As ArkSA.Blueprint = Me.RowTagAt(Row)
		    If Checked Then
		      Self.mSelectedBlueprints.Value(Blueprint.BlueprintId) = Blueprint
		    ElseIf Self.mSelectedBlueprints.HasKey(Blueprint.BlueprintId) Then
		      Self.mSelectedBlueprints.Remove(Blueprint.BlueprintId)
		    End If
		    
		    Var ContentPackId As String = Blueprint.ContentPackId
		    Var ContentPackRow As Integer = -1
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Me.RowExpandableAt(Idx) = False Then
		        Continue
		      End If
		      If Me.RowTagAt(Idx).StringValue = ContentPackId Then
		        ContentPackRow = Idx
		        Exit
		      End If
		    Next
		    
		    If ContentPackRow > -1 Then
		      Var PackBlueprintCount, PackSelectedCount As Integer
		      For Each Blueprint In Self.mCandidates
		        If Blueprint.ContentPackId <> ContentPackId Then
		          Continue
		        End If
		        
		        PackBlueprintCount = PackBlueprintCount + 1
		        If Self.mSelectedBlueprints.HasKey(Blueprint.BlueprintId) Then
		          PackSelectedCount = PackSelectedCount + 1
		        End If
		      Next
		      
		      If PackBlueprintCount = PackSelectedCount Then
		        Me.CellCheckBoxStateAt(ContentPackRow, Column) = DesktopCheckBox.VisualStates.Checked
		      ElseIf PackSelectedCount > 0 Then
		        Me.CellCheckBoxStateAt(ContentPackRow, Column) = DesktopCheckBox.VisualStates.Indeterminate
		      Else
		        Me.CellCheckBoxStateAt(ContentPackRow, Column) = DesktopCheckBox.VisualStates.Unchecked
		      End If
		    End If
		  End If
		  
		  Self.UpdateActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Self.Spinner.Visible = True
		  Self.SavingLabel.Visible = True
		  Self.List.Enabled = False
		  Me.Enabled = False
		  
		  Self.SaveThread.Start
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SaveThread
	#tag Event
		Sub Run()
		  Var BlueprintsToSave(), BlueprintsToDelete() As ArkSA.Blueprint
		  Var DeleteUnsaved As Boolean = Self.mSettings.DeleteBlueprints
		  
		  For Each Blueprint As ArkSA.Blueprint In Self.mCandidates
		    If Self.mSelectedBlueprints.HasKey(Blueprint.BlueprintId) Then
		      BlueprintsToSave.Add(Blueprint)
		    ElseIf DeleteUnsaved Then
		      BlueprintsToDelete.Add(Blueprint)
		    End If
		  Next
		  
		  Var ErrorDict As New Dictionary
		  Var Saved As Boolean
		  If Self.mController Is Nil Then
		    Saved = ArkSA.DataSource.Pool.Get(True).SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, ErrorDict, True)
		  Else
		    Self.mController.SaveBlueprints(BlueprintsToSave)
		    Self.mController.DeleteBlueprints(BlueprintsToDelete)
		    Saved = True
		  End If
		  
		  If Saved Then
		    Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Errored": False, "Saved": BlueprintsToSave, "Deleted": BlueprintsToDelete))
		  Else
		    Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Errored": True, "Errors": ErrorDict, "Saved": BlueprintsToSave, "Deleted": BlueprintsToDelete))
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Var Finished As Boolean = Update.Value("Finished")
		    Var Errored As Boolean = Update.Value("Errored")
		    
		    If Not Finished Then
		      Continue
		    End If
		    
		    If Not Errored Then
		      Self.Close
		      Return
		    End If
		    
		    Self.ActionButton.Enabled = True
		    Self.List.Enabled = True
		    Self.Spinner.Visible = False
		    Self.SavingLabel.Visible = False
		    
		    Var ErrorDict As Dictionary = Update.Value("Errors")
		    Var NumErrors As Integer = ErrorDict.KeyCount
		    Var ErrorLines() As String
		    For Each Blueprint As ArkSA.Blueprint In Self.mCandidates
		      If ErrorDict.HasKey(Blueprint.BlueprintId) = False Then
		        Continue
		      End If
		      If ErrorLines.Count >= 4 And NumErrors > 5 Then
		        Var OtherCount As Integer = NumErrors - ErrorLines.Count 
		        ErrorLines.Add("And " + OtherCount.ToString(Locale.Current, "#,##0") + " others…")
		        Exit
		      End If
		      
		      ErrorLines.Add(Blueprint.Label + ": " + ErrorDict.Value(Blueprint.BlueprintId).StringValue)
		    Next
		    
		    Self.ShowAlert(Self.ErrorAlertMessage, String.FromArray(ErrorLines, EndOfLine))
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
