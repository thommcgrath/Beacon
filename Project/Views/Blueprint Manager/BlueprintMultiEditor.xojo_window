#tag Window
Begin BeaconSubview BlueprintMultiEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   520
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
   Width           =   510
   Begin BeaconToolbar Header
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   "Edit Multiple"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   "False"
      Height          =   40
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
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
      Width           =   510
   End
   Begin FadedSeparator HeaderSeparator
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
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
      Width           =   510
   End
   Begin TagPicker Picker
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Border          =   15
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   100
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   152
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollSpeed     =   20
      Spec            =   ""
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   61
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   338
   End
   Begin CheckBox MapCheckboxes
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "The Island"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   173
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   140
   End
   Begin UITweaks.ResizedLabel MapLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Map Availability:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   173
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin UITweaks.ResizedLabel PickerLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Tags:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin Label PickerHelp
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   74
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Selected tags will be added to all, crossed out tags will be removed from all."
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   87
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  Dim OfficialMaps(), ThirdPartyMaps() As Beacon.Map
		  Dim OfficialMasks(), ThirdPartyMasks() As UInt64
		  For Each Map As Beacon.Map In Maps
		    If Map.Official Then
		      OfficialMaps.AddRow(Map)
		      OfficialMasks.AddRow(Map.Mask)
		    Else
		      ThirdPartyMaps.AddRow(Map)
		      ThirdPartyMasks.AddRow(Map.Mask)
		    End If
		  Next
		  OfficialMasks.SortWith(OfficialMaps)
		  ThirdPartyMasks.SortWith(ThirdPartyMaps)
		  
		  Dim OfficialLeft As Integer = MapCheckboxes(0).Left
		  Dim OfficialNextTop As Integer = MapCheckboxes(0).Top
		  Dim ThirdPartyLeft As Integer = MapCheckboxes(0).Left + MapCheckboxes(0).Width + 12
		  Dim ThirdPartyNextTop As Integer = MapCheckboxes(0).Top
		  
		  MapCheckboxes(0).Close
		  For Each Map As Beacon.Map In OfficialMaps
		    Dim Check As Checkbox = New MapCheckboxes
		    Check.Index = Map.Mask
		    Check.Caption = Map.Name
		    Check.Top = OfficialNextTop
		    Check.Left = OfficialLeft
		    OfficialNextTop = OfficialNextTop + Check.Height + 12
		    Self.mMapCheckboxes.AddRow(Check)
		  Next
		  For Each Map As Beacon.Map In ThirdPartyMaps
		    Dim Check As Checkbox = New MapCheckboxes
		    Check.Index = Map.Mask
		    Check.Caption = Map.Name
		    Check.Top = ThirdPartyNextTop
		    Check.Left = ThirdPartyLeft
		    ThirdPartyNextTop = ThirdPartyNextTop + Check.Height + 12
		    Self.mMapCheckboxes.AddRow(Check)
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Blueprints() As Beacon.Blueprint()
		  Dim Blueprints() As Beacon.Blueprint
		  Redim Blueprints(Self.mBlueprints.LastRowIndex)
		  For I As Integer = 0 To Self.mBlueprints.LastRowIndex
		    Blueprints(I) = Self.mBlueprints(I).Clone
		  Next
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Blueprints(Assigns Blueprints() As Beacon.Blueprint)
		  If Self.Modified Then
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Do you want to save changes to these objects"
		    Dialog.Explanation = "If you do not save now, your changes will be lost."
		    Dialog.ActionButton.Caption = "Save"
		    Dialog.CancelButton.Visible = True
		    Dialog.AlternateActionButton.Caption = "Don't Save"
		    Dialog.AlternateActionButton.Visible = True
		    
		    Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		    Select Case Choice
		    Case Dialog.ActionButton
		      // Build and save the object
		      Self.Save()
		    Case Dialog.AlternateActionButton
		      // Do nothing
		    Case Dialog.CancelButton
		      Return
		    End Select
		  End If
		  
		  If Blueprints <> Nil Then
		    Redim Self.mBlueprints(Blueprints.LastRowIndex)
		    For I As Integer = 0 To Blueprints.LastRowIndex
		      Self.mBlueprints(I) = Blueprints(I).MutableClone
		    Next
		  Else
		    Redim Self.mBlueprints(-1)
		  End If
		  
		  Self.SetupUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Modified(Assigns Value As Boolean)
		  If Self.mModified = Value Then
		    Return
		  End If
		  
		  Self.mModified = Value
		  Self.Changed = Value
		  Self.Header.SaveButton.Enabled = Value
		  Self.Header.RevertButton.Enabled = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert(Confirm As Boolean)
		  If Confirm And Not Self.ShowConfirm("Revert these objects?", "Unsaved changes will be lost. That's the point.", "Revert", "Cancel") Then
		    Return
		  End If
		  
		  Dim Blueprints() As Beacon.Blueprint
		  For Each Blueprint As Beacon.Blueprint In Self.mBlueprints
		    Dim Saved As Beacon.Blueprint = LocalData.SharedInstance.GetBlueprintByObjectID(Blueprint.ObjectID)
		    If Saved <> Nil Then
		      Blueprints.AddRow(Saved)
		    End If
		  Next
		  Self.Modified = False
		  Self.Blueprints = Blueprints
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  Dim AddTags() As String = Self.Picker.RequiredTags
		  Dim RemoveTags() As String = Self.Picker.ExcludedTags
		  
		  Dim AddMask, ClearMask As UInt64
		  For Each Check As Checkbox In Self.mMapCheckboxes
		    If Check.VisualState = Checkbox.VisualStates.Checked Then
		      AddMask = AddMask Or Check.Index
		    ElseIf Check.VisualState = Checkbox.VisualStates.Unchecked Then
		      ClearMask = ClearMask Or Check.Index
		    End If
		  Next
		  
		  For Each Blueprint As Beacon.MutableBlueprint In Self.mBlueprints
		    Blueprint.Availability = (Blueprint.Availability Or AddMask) And Not ClearMask
		    Blueprint.AddTags(AddTags)
		    Blueprint.RemoveTags(RemoveTags)
		  Next
		  
		  If LocalData.SharedInstance.SaveBlueprints(Self.mBlueprints) <> (Self.mBlueprints.LastRowIndex + 1) Then
		    Break
		  Else
		    Self.Modified = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Self.mSettingUp = True
		  
		  Self.Picker.ClearSelections()
		  Self.Picker.Tags = LocalData.SharedInstance.AllTags()
		  
		  Dim Masks As New Dictionary
		  Dim Tags As New Dictionary
		  For Each Blueprint As Beacon.Blueprint In Self.mBlueprints
		    For Each Check As Checkbox In Self.mMapCheckboxes
		      If Blueprint.ValidForMask(Check.Index) Then
		        Masks.Value(Check.Index) = Masks.Lookup(Check.Index, 0) + 1
		      End If
		    Next
		    
		    Dim BlueprintTags() As String = Blueprint.Tags
		    For Each Tag As String In BlueprintTags
		      Tags.Value(Tag) = Tags.Lookup(Tag, 0) + 1
		    Next
		  Next
		  
		  Dim BlueprintCount As Integer = Self.mBlueprints.LastRowIndex + 1
		  For Each Check As Checkbox In Self.mMapCheckboxes
		    Dim Count As Integer = Masks.Lookup(Check.Index, 0)
		    If Count = 0 Then
		      Check.VisualState = Checkbox.VisualStates.Unchecked
		    ElseIf Count = BlueprintCount Then
		      Check.VisualState = Checkbox.VisualStates.Checked
		    Else
		      Check.VisualState = Checkbox.VisualStates.Indeterminate
		    End If
		  Next
		  
		  Dim CommonTags() As String
		  For I As Integer = 0 To Tags.KeyCount - 1
		    Dim Tag As String = Tags.Key(I)
		    If Tags.Lookup(Tag, 0) = BlueprintCount Then
		      CommonTags.AddRow(Tag)
		    End If
		  Next
		  Self.Picker.SetSelections(CommonTags, Nil)
		  
		  Self.mSettingUp = False
		  Self.Modified = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprints() As Beacon.MutableBlueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapCheckboxes() As Checkbox
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events Header
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "SaveButton"
		    Self.Save()
		  Case "RevertButton"
		    Self.Revert(True)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("SaveButton", IconToolbarSave, False, "Save Object"))
		  Me.LeftItems.Append(New BeaconToolbarItem("RevertButton", IconToolbarRevert, False, "Revert Changes"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Picker
	#tag Event
		Sub TagsChanged()
		  If Not Self.mSettingUp Then
		    Self.Modified = True
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldAdjustHeight(Delta As Integer)
		  If Me = Nil Then
		    Return
		  End If
		  
		  Dim NewHeight As Integer = Max(Me.Height + Delta, (Self.PickerHelp.Top + Self.PickerHelp.Height) - Self.PickerLabel.Top)
		  Delta = NewHeight - Me.Height
		  Me.Height = NewHeight
		  
		  Self.MapLabel.Top = Self.MapLabel.Top + Delta
		  For Each Check As Checkbox In Self.mMapCheckboxes
		    If Check <> Nil Then
		      Check.Top = Check.Top + Delta
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapCheckboxes
	#tag Event
		Sub Action(index as Integer)
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.Modified = True
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
		Name="ToolbarCaption"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
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
