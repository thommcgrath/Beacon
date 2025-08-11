#tag DesktopWindow
Begin BeaconDialog ArkSpawnPointLimitDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   272
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "Creature Limit"
   Type            =   8
   Visible         =   True
   Width           =   600
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
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
      Text            =   "Creature Spawn Limit"
      TextAlignment   =   0
      TextColor       =   &c00000000
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
      Height          =   90
      Index           =   -2147483648
      InitialParent   =   ""
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
      Text            =   "Here you can set the maximum percentage of a spawn point's total population that can be used by a specific creature. Every spawn point instance has a different total population count, though a common maximum is 40. A creature will be allowed to spawn if it percentage of the total population is below the defined limit. See the help page using the button below for usage examples."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedPushButton HelpButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Help"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   232
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPopupMenu CreatureMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   170
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   154
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   255
   End
   Begin UITweaks.ResizedTextField PercentageField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
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
      Italic          =   False
      Left            =   170
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   186
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedLabel CreatureLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Creature:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   154
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   138
   End
   Begin UITweaks.ResizedLabel PercentageLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
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
      Text            =   "Maximum Percentage:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   186
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   138
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
      Left            =   500
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   232
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
      Left            =   408
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   232
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Mods As Beacon.StringList, Limit As NullableDouble, SelectedCreatures() As Ark.BlueprintReference, DefinedCreatures() As Ark.BlueprintReference, CreaturesInSpawnPoint() As Ark.BlueprintReference)
		  If SelectedCreatures.LastIndex = -1 Then
		    Self.mDisableSelection = False
		    Self.mSelectedCreature = Nil
		  ElseIf SelectedCreatures.LastIndex = 0 Then
		    Self.mDisableSelection = False
		    Self.mSelectedCreature = SelectedCreatures(0)
		  Else
		    Self.mDisableSelection = True
		    Self.mSelectedCreature = Nil
		  End If
		  
		  Var SelectableCreatures() As Ark.BlueprintReference
		  Var Map As New Dictionary
		  If (Self.mSelectedCreature Is Nil) = False Then
		    Map.Value(Self.mSelectedCreature.BlueprintId) = Self.mSelectedCreature
		  End If 
		  For Each CreatureRef As Ark.BlueprintReference In DefinedCreatures
		    If CreatureRef Is Nil Then
		      Continue
		    End If
		    
		    Call CreatureRef.Resolve
		    Map.Value(CreatureRef.BlueprintId) = CreatureRef
		  Next
		  
		  Var CreatureLabels() As String
		  For Each CreatureRef As Ark.BlueprintReference In CreaturesInSpawnPoint
		    If CreatureRef Is Nil Then
		      Continue
		    End If
		    
		    Call CreatureRef.Resolve
		    If Map.HasKey(CreatureRef.BlueprintId) Then
		      Continue
		    End If
		    
		    SelectableCreatures.Add(CreatureRef)
		    CreatureLabels.Add(CreatureRef.Label)
		    Map.Value(CreatureRef.BlueprintId) = CreatureRef
		  Next
		  CreatureLabels.SortWith(SelectableCreatures)
		  
		  // Do this after the sort so the indexes match up
		  If (Self.mSelectedCreature Is Nil) = False Then
		    SelectableCreatures.Add(Self.mSelectedCreature)
		  End If
		  
		  If SelectableCreatures.Count > 0 Then
		    SelectableCreatures.Add(Nil)
		  End If
		  
		  Var AllCreatures() As Ark.Creature = Ark.DataSource.Pool.Get(False).GetCreatures("", Mods, Nil)
		  For Each Creature As Ark.Creature In AllCreatures
		    If IsNull(Creature) Or Map.HasKey(Creature.CreatureId) Then
		      Continue
		    End If
		    
		    SelectableCreatures.Add(New Ark.BlueprintReference(Creature))
		  Next
		  
		  Self.mSelectableCreatures = SelectableCreatures
		  
		  Self.mLimit = Limit
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Mods As Beacon.StringList, Limit As NullableDouble, SelectedCreatures() As Ark.BlueprintReference, DefinedCreatures() As Ark.BlueprintReference, CreaturesInSpawnPoint() As Ark.BlueprintReference) As NullableDouble
		  If Parent Is Nil Then
		    Return Nil
		  End If
		  
		  Var Dialog As New ArkSpawnPointLimitDialog(Mods, Limit, SelectedCreatures, DefinedCreatures, CreaturesInSpawnPoint)
		  Dialog.ShowModal(Parent)
		  If Dialog.mLimit <> Nil And Dialog.mSelectedCreature <> Nil Then
		    SelectedCreatures.ResizeTo(0)
		    SelectedCreatures(0) = Dialog.mSelectedCreature
		  End If
		  
		  Var NewLimit As NullableDouble = Dialog.mLimit
		  Dialog.Close
		  
		  Return NewLimit
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDisableSelection As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLimit As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectableCreatures() As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedCreature As Ark.BlueprintReference
	#tag EndProperty


#tag EndWindowCode

#tag Events HelpButton
	#tag Event
		Sub Pressed()
		  Var Title, Body, HelpURL As String
		  Call Ark.DataSource.Pool.Get(False).GetConfigHelp(Ark.Configs.NameCreatureSpawns, Title, Body, HelpURL)
		  System.GotoURL(HelpURL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CreatureMenu
	#tag Event
		Sub Opening()
		  If Self.mDisableSelection Then
		    Me.AddRow("Multiple Selection")
		    Me.SelectedRowIndex = 0
		    Me.Enabled = False
		  Else
		    For Each CreatureRef As Ark.BlueprintReference In Self.mSelectableCreatures
		      If CreatureRef Is Nil Then
		        #if TargetMacOS
		          Me.AddSeparator
		        #endif
		        Continue
		      End If
		      
		      Me.AddRow(CreatureRef.Label, CreatureRef)
		      
		      If (Self.mSelectedCreature Is Nil) = False And Self.mSelectedCreature = CreatureRef Then
		        Me.SelectedRowIndex = Me.RowCount - 1
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PercentageField
	#tag Event
		Sub Opening()
		  If Self.mLimit <> Nil Then
		    Var Limit As Double = Self.mLimit * 100
		    Me.Text = Limit.PrettyText(True) + "%"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.CreatureMenu.Enabled And Self.CreatureMenu.SelectedRowIndex = -1 Then
		    Self.ShowAlert("Select a creature to limit", "You cannot limit nothing.")
		    Return
		  End If
		  
		  Var PercentageString As String = Self.PercentageField.Text.Trim
		  If PercentageString.EndsWith("%") Then
		    PercentageString = PercentageString.Left(PercentageString.Length - 1)
		  End If
		  
		  If Not IsNumeric(PercentageString) Then
		    Self.ShowAlert("Please enter a valid percentage", "The maximum percentage should be between 0% and 100%.")
		    Return
		  End If
		  
		  Var Limit As Double = CDbl(PercentageString) / 100
		  If Limit < 0 Then
		    Self.ShowAlert("That doesn't make sense", "You can use 0% to prevent a creature from spawning, but a negative percentage doesn't make any sense.")
		    Return
		  End If
		  
		  If Self.CreatureMenu.Enabled Then
		    Self.mSelectedCreature = Self.CreatureMenu.RowTagAt(Self.CreatureMenu.SelectedRowIndex)
		  End If
		  
		  Self.mLimit = Limit
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mLimit = Nil
		  Self.Hide
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
