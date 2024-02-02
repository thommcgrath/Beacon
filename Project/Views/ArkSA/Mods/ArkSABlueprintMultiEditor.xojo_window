#tag DesktopWindow
Begin BeaconDialog ArkSABlueprintMultiEditor
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
   Height          =   400
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   400
   MinimumWidth    =   640
   Resizeable      =   True
   Title           =   "Edit Blueprints"
   Type            =   8
   Visible         =   True
   Width           =   640
   Begin TagPicker Picker
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Border          =   15
      ContentHeight   =   0
      Enabled         =   True
      ExcludeTagCaption=   "Remove ""%%Tag%%"" From All Blueprints"
      Height          =   100
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   152
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      NeutralTagCaption=   "“%%Tag%%” Is Unchanged"
      RequireTagCaption=   "Add ""%%Tag%%"" to All Blueprints"
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      Spec            =   ""
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   True
      Visible         =   True
      Width           =   468
   End
   Begin UITweaks.ResizedLabel MapLabel
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Map Availability:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   164
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin UITweaks.ResizedLabel PickerLabel
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Tags:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin DesktopLabel PickerHelp
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   74
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   78
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
      Composited      =   False
      DesiredHeight   =   0
      DesiredWidth    =   0
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   188
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   146
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   158
      Transparent     =   True
      Visible         =   True
      Width           =   380
   End
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Edit Blueprints"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   600
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
      Left            =   546
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
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
      Left            =   454
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
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
		  Self.Picker.ClearSelections()
		  Self.Picker.Tags = ArkSA.DataSource.Pool.Get(False).GetTags(New Beacon.StringList)
		  
		  Var Mask As UInt64
		  Var Tags As New Dictionary
		  For Each Blueprint As ArkSA.Blueprint In Self.mBlueprints
		    Mask = Mask Or Blueprint.Availability
		    
		    Var BlueprintTags() As String = Blueprint.Tags
		    For Each Tag As String In BlueprintTags
		      Tags.Value(Tag) = Tags.Lookup(Tag, 0) + 1
		    Next
		  Next
		  
		  Var BlueprintCount As Integer = Self.mBlueprints.LastIndex + 1
		  Self.MapSelector.SetWithMaps(ArkSA.Maps.ForMask(Mask))
		  
		  Var CommonTags() As String
		  For I As Integer = 0 To Tags.KeyCount - 1
		    Var Tag As String = Tags.Key(I)
		    If Tags.Lookup(Tag, 0) = BlueprintCount Then
		      CommonTags.Add(Tag)
		    End If
		  Next
		  Self.Picker.SetSelections(CommonTags, Nil)
		  
		  Self.Modified = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Picker.AutoResize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Picker.AutoResize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(Blueprints() As ArkSA.Blueprint)
		  // Calling the overridden superclass constructor.
		  Self.mBlueprints.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Blueprints.LastIndex
		    Self.mBlueprints(Idx) = Blueprints(Idx)
		  Next
		  
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
		Shared Function Present(Parent As DesktopWindow, Blueprints() As ArkSA.Blueprint) As ArkSA.Blueprint()
		  If Parent Is Nil Then
		    Return Nil
		  End If
		  
		  Var Win As New ArkSABlueprintMultiEditor(Blueprints)
		  Win.ShowModal(Parent)
		  
		  Var EditedBlueprints() As ArkSA.Blueprint
		  If Not Win.mCancelled Then
		    EditedBlueprints = Win.mBlueprints
		  End If
		  Win.Close
		  Return EditedBlueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Save() As Boolean
		  Var AddTags() As String = Self.Picker.RequiredTags
		  Var RemoveTags() As String = Self.Picker.ExcludedTags
		  
		  Var AddMask As UInt64 = ArkSA.Maps.MaskForMaps(Self.MapSelector.CheckedMaps)
		  Var ClearMask As UInt64 = ArkSA.Maps.MaskForMaps(Self.MapSelector.UncheckedMaps)
		  Var LastUpdate As Double = DateTime.Now.SecondsFrom1970
		  
		  For Idx As Integer = 0 To Self.mBlueprints.LastIndex
		    Var Blueprint As ArkSA.MutableBlueprint = Self.mBlueprints(Idx).MutableVersion
		    Blueprint.Availability = (Blueprint.Availability Or AddMask) And Not ClearMask
		    Blueprint.AddTags(AddTags)
		    Blueprint.RemoveTags(RemoveTags)
		    Blueprint.LastUpdate = LastUpdate
		    Self.mBlueprints(Idx) = Blueprint.ImmutableVersion
		  Next
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprints() As ArkSA.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events Picker
	#tag Event
		Sub TagsChanged()
		  Self.Modified = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldAdjustHeight(Delta As Integer)
		  If Me = Nil Then
		    Return
		  End If
		  
		  Var NewHeight As Integer = Max(Me.Height + Delta, (Self.PickerHelp.Top + Self.PickerHelp.Height) - Self.PickerLabel.Top)
		  Delta = NewHeight - Me.Height
		  Me.Height = NewHeight
		  
		  Self.MinimumHeight = Me.Top + Me.Height + 6 + Self.MapSelector.DesiredHeight + 14 + Self.ActionButton.Height + 20
		  Self.Height = Max(Self.Height, Self.MinimumHeight)
		  Self.MapLabel.Top = Me.Top + Me.Height + 12
		  Self.MapSelector.Top = Self.MapLabel.Top - 6
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapSelector
	#tag Event
		Sub Changed()
		  Self.Modified = True
		End Sub
	#tag EndEvent
	#tag Event
		Function GetMaps() As Beacon.Map()
		  Return ArkSA.Maps.All
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.Save() Then
		    Self.mCancelled = False
		    Self.Hide
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
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
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
