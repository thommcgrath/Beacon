#tag Window
Begin BeaconSubview BlueprintEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   520
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
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
      Caption         =   "New Object"
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
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
      EraseBackground =   True
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
   Begin UITweaks.ResizedTextField PathField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   152
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   93
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   338
   End
   Begin UITweaks.ResizedLabel TypeLabel
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Type:"
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
   Begin UITweaks.ResizedLabel PathLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
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
      Text            =   "Blueprint Path:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   93
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin UITweaks.ResizedPopupMenu TypeMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Engram\nCreature"
      Italic          =   False
      Left            =   152
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   159
   End
   Begin UITweaks.ResizedTextField NameField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   152
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   127
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   338
   End
   Begin UITweaks.ResizedLabel NameLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Name:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   127
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   195
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Map Availability:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   195
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin UITweaks.ResizedTextField TagsField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   152
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   161
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   338
   End
   Begin UITweaks.ResizedLabel TagsLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
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
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Tags:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   161
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
		      OfficialMaps.Append(Map)
		      OfficialMasks.Append(Map.Mask)
		    Else
		      ThirdPartyMaps.Append(Map)
		      ThirdPartyMasks.Append(Map.Mask)
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
		    Self.mMapCheckboxes.Append(Check)
		  Next
		  For Each Map As Beacon.Map In ThirdPartyMaps
		    Dim Check As Checkbox = New MapCheckboxes
		    Check.Index = Map.Mask
		    Check.Caption = Map.Name
		    Check.Top = ThirdPartyNextTop
		    Check.Left = ThirdPartyLeft
		    ThirdPartyNextTop = ThirdPartyNextTop + Check.Height + 12
		    Self.mMapCheckboxes.Append(Check)
		  Next
		  
		End Sub
	#tag EndEvent


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
		  Self.ContentsChanged = Value
		  Self.Header.SaveButton.Enabled = Value
		  Self.Header.RevertButton.Enabled = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert(Confirm As Boolean)
		  If Confirm And Not Self.ShowConfirm("Revert this object?", "Unsaved changes will be lost. That's the point.", "Revert", "Cancel") Then
		    Return
		  End If
		  
		  Self.Modified = False
		  
		  Dim ObjID As Text = Self.ObjectID
		  Self.ObjectID = ""
		  Self.ObjectID = ObjID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  Dim Label As Text = Trim(Self.NameField.Text).ToText
		  Dim Path As Text = Trim(Self.PathField.Text).ToText
		  If Label = "" Then
		    Self.ShowAlert("This object has no name", "You'll want to correct this, it will be hard to find this object again without a name.")
		    Return
		  End If
		  If Not Path.BeginsWith("/Game/") Then
		    Self.ShowAlert("The blueprint path is required", "Beacon requires the full blueprint path to the object in order to function correctly.")
		    Return
		  End If
		  
		  Dim Tags() As Text = Self.TagsField.Text.ToText.Split(",")
		  For I As Integer = Tags.Ubound DownTo 0
		    Tags(I) = Tags(I).Trim
		    If Tags(I) = "" Then
		      Tags.Remove(I)
		    End If
		  Next
		  
		  Dim Availability As UInt64
		  For Each Check As Checkbox In Self.mMapCheckboxes
		    If Check.Value Then
		      Availability = Availability Or Check.Index
		    End If
		  Next
		  
		  If Availability = 0 Then
		    Self.ShowAlert("Object is not available to any maps", "This object should be usable on at least one map.")
		    Return
		  End If
		  
		  Select Case Self.TypeMenu.ListIndex
		  Case 0
		    Dim Engram As New Beacon.MutableEngram(Path, Self.mObjectID)
		    Engram.Label = Label
		    Engram.Tags = Tags
		    Engram.Availability = Availability
		    If Not LocalData.SharedInstance.SaveBlueprint(Engram, True) Then
		      Self.ShowAlert("This engram did not save", "Its blueprint path may already be in the database.")
		      Return
		    End If
		  Case 1
		    Dim Creature As New Beacon.MutableCreature(Path, Self.mObjectID)
		    Creature.Label = Label
		    Creature.Tags = Tags
		    Creature.Availability = Availability
		    If Not LocalData.SharedInstance.SaveBlueprint(Creature, True) Then
		      Self.ShowAlert("This creature did not save", "Its blueprint path may already be in the database.")
		      Return
		    End If
		  End Select
		  
		  Self.Modified = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMapCheckboxes() As Checkbox
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObjectID As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mObjectID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mObjectID = Value Then
			    Return
			  End If
			  
			  If Self.Modified Then
			    Dim Dialog As New MessageDialog
			    Dialog.Title = ""
			    Dialog.Message = "Do you want to save changes to this object?"
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
			  
			  Self.mObjectID = Value
			  
			  Dim Blueprint As Beacon.Blueprint = LocalData.SharedInstance.GetBlueprintByObjectID(Self.mObjectID)
			  If Blueprint <> Nil Then
			    Select Case Blueprint
			    Case IsA Beacon.Creature
			      Self.TypeMenu.SelectByCaption("Creature")
			    Case IsA Beacon.Engram
			      Self.TypeMenu.SelectByCaption("Engram")
			    End Select
			    Self.PathField.Text = Blueprint.Path
			    Self.NameField.Text = Blueprint.Label
			    Self.TagsField.Text = Blueprint.Tags.Join(", ")
			    For Each Check As Checkbox In Self.mMapCheckboxes
			      Check.Value = (Blueprint.Availability And Check.Index) = Check.Index
			    Next
			  Else
			    Self.TypeMenu.ListIndex = -1
			    Self.PathField.Text = ""
			    Self.NameField.Text = ""
			    Self.TagsField.Text = ""
			    For Each Check As Checkbox In Self.mMapCheckboxes
			      Check.Value = False
			    Next
			  End If
			  
			  Self.Modified = False
			End Set
		#tag EndSetter
		ObjectID As Text
	#tag EndComputedProperty


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
#tag Events PathField
	#tag Event
		Sub TextChange()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TypeMenu
	#tag Event
		Sub Change()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Trim(Me.Text) = "" Then
		    Header.Caption = "New Object"
		  Else
		    Header.Caption = Trim(Me.Text)
		  End If
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapCheckboxes
	#tag Event
		Sub Action(index as Integer)
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TagsField
	#tag Event
		Sub TextChange()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ObjectID"
		Group="Behavior"
		Type="Text"
	#tag EndViewProperty
#tag EndViewBehavior
