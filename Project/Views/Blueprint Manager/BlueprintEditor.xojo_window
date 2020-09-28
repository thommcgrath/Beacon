#tag Window
Begin BeaconSubview BlueprintEditor
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
      BorderBottom    =   False
      BorderLeft      =   False
      BorderRight     =   False
      BorderTop       =   False
      Caption         =   "New Object"
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
      InitialValue    =   "Engram\nCreature\nSpawn Point"
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
   Begin MapSelectionGrid MapSelector
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
      Height          =   317
      InitialParent   =   ""
      Left            =   146
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   189
      Transparent     =   True
      Visible         =   True
      Width           =   350
   End
End
#tag EndWindow

#tag WindowCode
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
		  If Confirm And Not Self.ShowConfirm("Revert this object?", "Unsaved changes will be lost. That's the point.", "Revert", "Cancel") Then
		    Return
		  End If
		  
		  Self.Modified = False
		  
		  Var ObjID As v4UUID = Self.ObjectID
		  Self.ObjectID = v4UUID.CreateNull
		  Self.ObjectID = ObjID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  Var Label As String = Self.NameField.Value.Trim
		  Var Path As String = Self.PathField.Value.Trim
		  If Label = "" Then
		    Self.ShowAlert("This object has no name", "You'll want to correct this, it will be hard to find this object again without a name.")
		    Return
		  End If
		  If Not Path.BeginsWith("/Game/") Then
		    If Path.EndsWith("_C") And Path.IndexOf("/") = -1 Then
		      Var TempPath As String
		      Select Case Self.TypeMenu.SelectedRowIndex
		      Case Self.IndexEngram
		        TempPath = Beacon.Engram.CreateFromClass(Path).Path
		      Case Self.IndexCreature
		        TempPath = Beacon.Creature.CreateFromClass(Path).Path
		      Case Self.IndexSpawnPoint
		        TempPath = Beacon.SpawnPoint.CreateFromClass(Path).Path
		      End Select
		      If Self.ShowConfirm("The entered path is a class string, not a blueprint path. Do you want to use the path """ + TempPath + """ instead?", "This is not recommended. Beacon uses the paths to properly track items that may have the same class. When possible, use the full correct path to the blueprint.", "Use Anyway", "Cancel") Then
		        Path = TempPath
		      Else
		        Return
		      End If
		    Else
		      Self.ShowAlert("The blueprint path is required", "Beacon requires the full blueprint path to the object in order to function correctly.")
		      Return
		    End If
		  End If
		  
		  Var Tags() As String = Self.TagsField.Value.Split(",")
		  For I As Integer = Tags.LastRowIndex DownTo 0
		    Tags(I) = Tags(I).Trim
		    If Tags(I) = "" Then
		      Tags.RemoveRowAt(I)
		    End If
		  Next
		  
		  Var Availability As UInt64 = Self.MapSelector.Mask
		  If Availability = CType(0, UInt64) Then
		    Self.ShowAlert("Object is not available to any maps", "This object should be usable on at least one map.")
		    Return
		  End If
		  
		  Select Case Self.TypeMenu.SelectedRowIndex
		  Case Self.IndexEngram
		    Var Engram As New Beacon.MutableEngram(Path, Self.mObjectID)
		    Engram.Label = Label
		    Engram.Tags = Tags
		    Engram.Availability = Availability
		    If Not LocalData.SharedInstance.SaveBlueprint(Engram, True) Then
		      Self.ShowAlert("This engram did not save", "Its blueprint path may already be in the database.")
		      Return
		    End If
		  Case Self.IndexCreature
		    Var Creature As New Beacon.MutableCreature(Path, Self.mObjectID)
		    Creature.Label = Label
		    Creature.Tags = Tags
		    Creature.Availability = Availability
		    If Not LocalData.SharedInstance.SaveBlueprint(Creature, True) Then
		      Self.ShowAlert("This creature did not save", "Its blueprint path may already be in the database.")
		      Return
		    End If
		  Case Self.IndexSpawnPoint
		    Var Point As New Beacon.MutableSpawnPoint(Path, Self.mObjectID)
		    Point.Label = Label
		    Point.Tags = Tags
		    Point.Availability = Availability
		    If Not LocalData.SharedInstance.SaveBlueprint(Point, True) Then
		      Self.ShowAlert("This spawn point did not save", "Its blueprint path may already be in the database.")
		      Return
		    End If
		  End Select
		  
		  Self.Modified = False
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObjectID As v4UUID
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
			    Var Dialog As New MessageDialog
			    Dialog.Title = ""
			    Dialog.Message = "Do you want to save changes to this object?"
			    Dialog.Explanation = "If you do not save now, your changes will be lost."
			    Dialog.ActionButton.Caption = "Save"
			    Dialog.CancelButton.Visible = True
			    Dialog.AlternateActionButton.Caption = "Don't Save"
			    Dialog.AlternateActionButton.Visible = True
			    
			    Var Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
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
			  
			  Var Blueprint As Beacon.Blueprint = LocalData.SharedInstance.GetBlueprintByObjectID(Self.mObjectID)
			  If Blueprint <> Nil Then
			    Select Case Blueprint
			    Case IsA Beacon.Creature
			      Self.TypeMenu.SelectByCaption("Creature")
			    Case IsA Beacon.Engram
			      Self.TypeMenu.SelectByCaption("Engram")
			    Case IsA Beacon.SpawnPoint
			      Self.TypeMenu.SelectByCaption("Spawn Point")
			    End Select
			    Self.PathField.Value = Blueprint.Path
			    Self.NameField.Value = Blueprint.Label
			    Self.TagsField.Value = Blueprint.Tags.Join(", ")
			    Self.MapSelector.Mask = Blueprint.Availability
			  Else
			    Self.TypeMenu.SelectedRowIndex = -1
			    Self.PathField.Value = ""
			    Self.NameField.Value = ""
			    Self.TagsField.Value = ""
			    Self.MapSelector.Mask = 0
			  End If
			  
			  Self.Modified = False
			End Set
		#tag EndSetter
		ObjectID As v4UUID
	#tag EndComputedProperty


	#tag Constant, Name = IndexCreature, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexEngram, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexSpawnPoint, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


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
		  If Me.Value.Trim = "" Then
		    Header.Caption = "New Object"
		  Else
		    Header.Caption = Me.Value.Trim
		  End If
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
#tag Events MapSelector
	#tag Event
		Sub Changed()
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="ToolbarIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
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
