#tag Window
Begin BeaconDialog BreedingTunerDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Breeding Tuner Threshold"
   Visible         =   True
   Width           =   600
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Auto Compute Imprinting Multiplier"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin Label ExplanationLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   36
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Choose an imprinting threshold. A higher value will require a shorter imprint interval. Beacon will try to compute a multiplier value that will allow at least the desired imprinting percent."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin UITweaks.ResizedTextField ThresholdField
      AcceptTabs      =   False
      Alignment       =   2
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
      Left            =   200
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "90%"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   100
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   70
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox CreaturesList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "22,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   22
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   214
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowCount        =   0
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   134
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedLabel ThresholdLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Min Total Imprint Percent:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   168
   End
   Begin UITweaks.ResizedPushButton MajorCreaturesButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "Major Creatures"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   451
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   101
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   129
   End
   Begin UITweaks.ResizedPushButton AllCreaturesButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   True
      Caption         =   "All Creatures"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   310
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   101
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   129
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.CreaturesList.ColumnType(Self.ColumnChecked) = Listbox.TypeCheckbox
		  
		  Dim Creatures() As Beacon.Creature = LocalData.SharedInstance.SearchForCreatures("", New Beacon.TextList)
		  For Each Creature As Beacon.Creature In Creatures
		    If Creature.IncubationTime = Nil Or Creature.MatureTime = Nil Then
		      Continue
		    End If
		    
		    Self.CreaturesList.AddRow("", Creature.Label)
		    Self.CreaturesList.RowTag(Self.CreaturesList.LastIndex) = Creature
		  Next
		  
		  Self.ThresholdField.Text = Format(Preferences.BreedingTunerThreshold, "0%")
		  Self.CheckCreatures(Preferences.BreedingTunerCreatures)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckCreatures(List As String)
		  Self.mAutoCheckingCreatures = True
		  If List = "*" Then
		    For I As Integer = 0 To Self.CreaturesList.ListCount - 1
		      Self.CreaturesList.CellCheck(I, Self.ColumnChecked) = True
		    Next
		  Else
		    Dim Creatures() As String = List.Split(",")
		    For I As Integer = 0 To Creatures.Ubound
		      Creatures(I) = Creatures(I).Trim
		    Next
		    
		    For I As Integer = 0 To Self.CreaturesList.ListCount - 1
		      Dim ClassString As String = Beacon.Creature(Self.CreaturesList.RowTag(I)).ClassString
		      Self.CreaturesList.CellCheck(I, Self.ColumnChecked) = Creatures.IndexOf(ClassString) > -1
		    Next
		  End If
		  Self.mAutoCheckingCreatures = False
		  
		  Self.mLastCheckedList = List
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(MatureSpeedMultiplier As Double)
		  // Calling the overridden superclass constructor.
		  Self.mMatureSpeedMultiplier = MatureSpeedMultiplier
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, MatureSpeedMultiplier As Double) As Double
		  If Parent = Nil Then
		    Return 0
		  End If
		  
		  Dim Win As New BreedingTunerDialog(MatureSpeedMultiplier)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  Dim Multiplier As Double = Win.mChosenMultiplier
		  Win.Close
		  
		  Return Multiplier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAutoCheckingCreatures As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChosenMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCheckedList As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMatureSpeedMultiplier As Double
	#tag EndProperty


	#tag Constant, Name = ColumnChecked, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.mChosenMultiplier = 0
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Dim Threshold As Double = CDbl(Self.ThresholdField.Text) / 100
		  If Threshold = 0 Then
		    Beep
		    Return
		  End If
		  
		  Dim Creatures() As Beacon.Creature
		  For I As Integer = 0 To Self.CreaturesList.ListCount - 1
		    If Self.CreaturesList.CellCheck(I, Self.ColumnChecked) Then
		      Creatures.Append(Self.CreaturesList.RowTag(I))
		    End If
		  Next
		  
		  Const IterationLimit = 10000
		  
		  Dim OfficialCuddlePeriod As Integer = LocalData.SharedInstance.GetIntegerVariable("Cuddle Period")
		  Dim ImprintMultiplier As Double = 1.0
		  Dim Found As Boolean
		  
		  // First, establish a baseline
		  For Each Creature As Beacon.Creature In Creatures
		    Dim MaturePeriod As Xojo.Core.DateInterval = Creature.MatureTime
		    Dim MatureSeconds As UInt64 = Beacon.IntervalToSeconds(MaturePeriod) / Self.mMatureSpeedMultiplier
		    ImprintMultiplier = Min(ImprintMultiplier, (MatureSeconds * Threshold) / OfficialCuddlePeriod)
		  Next
		  
		  // Now tune it using guesswork
		  Dim Iterations As Integer
		  Do
		    Dim CuddlePeriod As Integer = OfficialCuddlePeriod * ImprintMultiplier
		    For Each Creature As Beacon.Creature In Creatures
		      Dim MaturePeriod As Xojo.Core.DateInterval = Creature.MatureTime
		      Dim MatureSeconds As UInt64 = Beacon.IntervalToSeconds(MaturePeriod) / Self.mMatureSpeedMultiplier
		      Dim MaxCuddles As Integer = Floor(MatureSeconds / CuddlePeriod)
		      Dim PerCuddle As Double = CuddlePeriod / MatureSeconds
		      If PerCuddle > 1.0 Then
		        PerCuddle = 0
		      End If
		      Dim MaxImprint As Double = MaxCuddles * PerCuddle
		      If MaxImprint < Threshold Then
		        ImprintMultiplier = ImprintMultiplier - (1 / IterationLimit)
		        Iterations = Iterations + 1
		        Continue Do
		      End If
		    Next
		    Found = True
		  Loop Until Found Or Iterations > IterationLimit
		  
		  If Iterations > IterationLimit Then
		    Self.ShowAlert("Unable to find the desired imprint period multiplier", "Sorry, Beacon can't find the value you're hoping for. Try reducing the mature speed multiplier and try again.")
		    Return
		  End If
		  
		  Preferences.BreedingTunerThreshold = Threshold
		  Preferences.BreedingTunerCreatures = Self.mLastCheckedList.ToText
		  Self.mChosenMultiplier = ImprintMultiplier
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CreaturesList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mAutoCheckingCreatures Or Column <> Self.ColumnChecked Then
		    Return
		  End If
		  
		  Dim Classes() As String
		  For I As Integer = 0 To Self.CreaturesList.ListCount - 1
		    If Self.CreaturesList.CellCheck(I, Column) Then
		      Classes.Append(Beacon.Creature(Self.CreaturesList.RowTag(I)).ClassString)
		    End If
		  Next
		  Self.mLastCheckedList = Classes.Join(",")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MajorCreaturesButton
	#tag Event
		Sub Action()
		  Self.CheckCreatures(LocalData.SharedInstance.GetTextVariable("Major Imprint Creatures"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AllCreaturesButton
	#tag Event
		Sub Action()
		  Self.CheckCreatures("*")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
