#tag Window
Begin BeaconDialog BlueprintEditorDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "1"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   500
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   400
   MinimumWidth    =   540
   Resizeable      =   True
   Title           =   "New Blueprint"
   Type            =   "8"
   Visible         =   True
   Width           =   540
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   416
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   38
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   540
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
         Height          =   254
         InitialParent   =   "Pages"
         Left            =   146
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   186
         Transparent     =   True
         Visible         =   True
         Width           =   380
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
         InitialParent   =   "Pages"
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
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   158
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   368
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
         InitialParent   =   "Pages"
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
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   124
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   368
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
         InitialParent   =   "Pages"
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   58
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   159
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
         InitialParent   =   "Pages"
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
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   368
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Tags:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   158
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
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Map Availability:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   192
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
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
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   124
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Blueprint Path:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Type:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   58
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
   End
   Begin OmniBar PageSelector
      Alignment       =   1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   38
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
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   540
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   440
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   460
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   348
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   460
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SwapButtons()
		  
		  If (Self.mOriginalBlueprint Is Nil) = False Then
		    Select Case Self.mOriginalBlueprint
		    Case IsA Beacon.Creature
		      Self.TypeMenu.SelectByCaption("Creature")
		    Case IsA Beacon.Engram
		      Self.TypeMenu.SelectByCaption("Engram")
		    Case IsA Beacon.SpawnPoint
		      Self.TypeMenu.SelectByCaption("Spawn Point")
		    End Select
		    Self.TypeMenu.Enabled = False
		    Self.PathField.Value = Self.mOriginalBlueprint.Path
		    Self.NameField.Value = Self.mOriginalBlueprint.Label
		    Self.TagsField.Value = Self.mOriginalBlueprint.Tags.Join(", ")
		    Self.MapSelector.Mask = Self.mOriginalBlueprint.Availability
		  Else
		    Self.TypeMenu.SelectedRowIndex = -1
		    Self.TypeMenu.Enabled = True
		    Self.PathField.Value = ""
		    Self.NameField.Value = ""
		    Self.TagsField.Value = ""
		    Self.MapSelector.Mask = 0
		  End If
		  
		  Self.Modified = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Blueprint As Beacon.Blueprint)
		  If (Blueprint Is Nil) = False Then
		    Self.mOriginalBlueprint = Blueprint.ImmutableVersion
		  End If
		  Super.Constructor
		  
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
		  Self.ActionButton.Enabled = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Blueprint As Beacon.Blueprint) As Beacon.Blueprint
		  If Parent Is Nil Then
		    Return Nil
		  End If
		  
		  Var Win As New BlueprintEditorDialog(Blueprint)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  Var EditedBlueprint As Beacon.Blueprint
		  If Not Win.mCancelled Then
		    EditedBlueprint = Win.mModifiedBlueprint.ImmutableVersion
		  End If
		  Win.Close
		  Return EditedBlueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save() As Boolean
		  Var Label As String = Self.NameField.Value.Trim
		  Var Path As String = Self.PathField.Value.Trim
		  If Label = "" Then
		    Self.ShowAlert("This object has no name", "You'll want to correct this, it will be hard to find this object again without a name.")
		    Return False
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
		        Return False
		      End If
		    Else
		      Self.ShowAlert("The blueprint path is required", "Beacon requires the full blueprint path to the object in order to function correctly.")
		      Return False
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
		  If Availability = 0 Then
		    Self.ShowAlert("Object is not available to any maps", "This object should be usable on at least one map.")
		    Return False
		  End If
		  
		  Var Blueprint As Beacon.MutableBlueprint
		  If Self.mOriginalBlueprint Is Nil Then
		    Select Case Self.TypeMenu.SelectedRowIndex
		    Case Self.IndexEngram
		      Blueprint = New Beacon.MutableEngram(Path, New v4UUID)
		    Case Self.IndexCreature
		      Blueprint = New Beacon.MutableCreature(Path, New v4UUID)
		    Case Self.IndexSpawnPoint
		      Blueprint = New Beacon.MutableSpawnPoint(Path, New v4UUID)
		    End Select
		  Else
		    Blueprint = Self.mOriginalBlueprint.MutableVersion
		  End If
		  If Blueprint Is Nil Then
		    Return False
		  End If
		  
		  Blueprint.Path = Path
		  Blueprint.Label = Label
		  Blueprint.Tags = Tags
		  Blueprint.Availability = Availability
		  
		  Self.mModifiedBlueprint = Blueprint.ImmutableVersion
		  Self.Modified = False
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModifiedBlueprint As Beacon.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalBlueprint As Beacon.Blueprint
	#tag EndProperty


	#tag Constant, Name = IndexCreature, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexEngram, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexSpawnPoint, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageCommonSettings, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageCreatureSettings, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageEngramSettings, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSpawnSettings, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events MapSelector
	#tag Event
		Sub Changed()
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
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Me.Value.Trim = "" Then
		    Self.Title = "New Blueprint"
		  Else
		    Self.Title = Me.Value.Trim
		  End If
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TypeMenu
	#tag Event
		Sub Change()
		  For Idx As Integer = Self.PageSelector.LastRowIndex DownTo 1
		    Self.PageSelector.Remove(Idx)
		  Next
		  
		  Select Case Me.SelectedRowIndex
		  Case Self.IndexEngram
		    Self.PageSelector.Append(New OmniBarItem("PageEngram", "Advanced"))
		  Case Self.IndexCreature
		    Self.PageSelector.Append(New OmniBarItem("PageCreature", "Advanced"))
		  Case Self.IndexSpawnPoint
		    Self.PageSelector.Append(New OmniBarItem("PageSpawn", "Advanced"))
		  End Select
		  
		  Self.Modified = True
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
#tag Events PageSelector
	#tag Event
		Sub Open()
		  Var CommonItem As New OmniBarItem("PageCommon", "Common")
		  CommonItem.Toggled = True
		  Me.Append(CommonItem)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem)
		  For Idx As Integer = 0 To Me.LastRowIndex
		    Me.Item(Idx).Toggled = (Me.Item(Idx) = Item)
		  Next
		  
		  Select Case Item.Name
		  Case "PageCommon"
		    Self.Pages.SelectedPanelIndex = Self.PageCommonSettings
		  Case "PageEngram"
		    Self.Pages.SelectedPanelIndex = Self.PageEngramSettings
		  Case "PageCreature"
		    Self.Pages.SelectedPanelIndex = Self.PageCreatureSettings
		  Case "PageSpawn"
		    Self.Pages.SelectedPanelIndex = Self.PageSpawnSettings
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If Self.Save() Then
		    Self.mCancelled = False
		    Self.Hide
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
			"9 - Metal Window"
			"11 - Modeless Dialog"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
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
		Name="Visible"
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
#tag EndViewBehavior
