#tag Window
Begin BeaconDialog ExperienceWizard
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   510
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   510
   MaximizeButton  =   False
   MaxWidth        =   651
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   510
   MinimizeButton  =   False
   MinWidth        =   651
   Placement       =   1
   Resizable       =   "False"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Experience Wizard"
   Visible         =   True
   Width           =   651
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
      Text            =   "Experience Wizard"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   611
   End
   Begin Label ExplanationLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   80
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
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "This wizard will help you define many level requirements in bulk. First, set the number of levels to add and the total experience to add for those levels. Then use the blue handles on the curve to define how rapidly the values should increase. The list will show the total experience required for each of the new levels."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   611
   End
   Begin Label NextLevelField
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
      Left            =   147
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
      Text            =   "2"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   144
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   200
   End
   Begin Label NextLevelLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Starting Level:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   144
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin UITweaks.ResizedTextField LevelCountField
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
      Left            =   147
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   176
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   200
   End
   Begin Label FinalLevelField
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
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "3"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   210
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   200
   End
   Begin Label FinalLevelLabel
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Ending Level:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   210
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin UITweaks.ResizedTextField XPField
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
      Left            =   147
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
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "100"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   242
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   200
   End
   Begin UITweaks.ResizedLabel XPLabel
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Additional XP:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   242
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin UITweaks.ResizedLabel LevelCountLabel
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Additional Levels:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   176
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   115
   End
   Begin BezierCurveDesigner Designer
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   272
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   359
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   144
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   272
   End
   Begin BeaconListbox List
      AllowInfiniteScroll=   False
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "75,*,*"
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
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   174
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Level	Level XP	Total XP"
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   276
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      VisibleRowCount =   0
      Width           =   327
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   551
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   470
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   459
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   470
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedTextField PointFields
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
      Index           =   0
      Italic          =   False
      Left            =   359
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   428
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   59
   End
   Begin UITweaks.ResizedTextField PointFields
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
      Index           =   1
      Italic          =   False
      Left            =   430
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   428
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   59
   End
   Begin UITweaks.ResizedTextField PointFields
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
      Index           =   2
      Italic          =   False
      Left            =   501
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   428
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   59
   End
   Begin UITweaks.ResizedTextField PointFields
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
      Index           =   3
      Italic          =   False
      Left            =   572
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   428
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   59
   End
   Begin Timer ComputeDelayTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin ProgressWheel ComputeSpinner
      AllowAutoDeactivate=   True
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
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   472
      Transparent     =   False
      Visible         =   False
      Width           =   16
   End
   Begin Label ComputeMessage
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Calculating levels…"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   470
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   399
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.mSettingUp = False
		  
		  Self.Designer.Curve = New Beacon.Curve(0, 0, 1, 1)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CancelComputeThread()
		  If Self.mComputeThread Is Nil Then
		    Return
		  End If
		  
		  If Self.mComputeThread.ThreadState = Thread.ThreadStates.Running Then
		    Self.mComputeThread.Stop
		  End If
		  
		  RemoveHandler mComputeThread.Run, WeakAddressOf mComputeThread_Run
		  RemoveHandler mComputeThread.UserInterfaceUpdate, WeakAddressOf mComputeThread_UIUpdate
		  
		  Self.mComputeThread = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(StartingLevel As Integer, StartingXP As UInt64)
		  Self.mSettingUp = True
		  Self.mStartingLevel = StartingLevel
		  Self.mStartingXP = StartingXP
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mComputeThread_Run(Sender As Thread)
		  Var AdditionalLevels As Integer = Self.mDesiredLevels
		  Var AdditionalXP As UInt64 = Self.mDesiredXP
		  Var Curve As Beacon.Curve = Self.mDesiredCurve
		  Var XTimes As Dictionary = BeaconConfigs.ExperienceCurves.PrecomputeCurveX(Curve, AdditionalLevels, 0.00001)
		  
		  Sender.AddUserInterfaceUpdate(New Dictionary("XTimes": XTimes, "Action": "Finished", "AdditionalLevels": AdditionalLevels, "AdditionalXP": AdditionalXP, "Curve": Curve))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mComputeThread_UIUpdate(Sender As Thread, Dictionaries() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Idx As Integer = 0 To Dictionaries.LastIndex
		    Var Dict As Dictionary = Dictionaries(Idx)
		    Select Case Dict.Value("Action").StringValue
		    Case "Finished"
		      Self.ActionButton.Enabled = True
		      Self.ComputeSpinner.Visible = False
		      Self.ComputeMessage.Visible = False
		      
		      Var AdditionalLevels As Integer = Dict.Value("AdditionalLevels")
		      Var AdditionalXP As UInt64 = Dict.Value("AdditionalXP")
		      Var Curve As Beacon.Curve = Dict.Value("Curve")
		      
		      Var XTimes As Dictionary = Dict.Value("XTimes")
		      Var LastXP As UInt64 = Self.mStartingXP
		      Var EndingXP As UInt64 = Self.mStartingXP + AdditionalXP
		      Var EndingLevel As Integer = (Self.mStartingLevel + AdditionalLevels) - 1
		      Self.List.RemoveAllRows
		      For Level As Integer = 1 To AdditionalLevels
		        Try
		          Var Time As Double = XTimes.Value(Level)
		          Var Y As Double = Curve.YForT(Time)
		          Var TotalXP As UInt64 = Self.mStartingXP + Round((EndingXP - Self.mStartingXP) * Y)
		          Var LevelXP As UInt64 = TotalXP - LastXP
		          LastXP = TotalXP
		          
		          Var DisplayLevel As Integer = (Level - 1) + Self.mStartingLevel
		          Self.List.AddRow(DisplayLevel.ToString(Locale.Current, ",##0"), LevelXP.ToString(Locale.Current, ",##0"), TotalXP.ToString(Locale.Current, ",##0"))
		          Self.List.RowTagAt(Self.List.LastAddedRowIndex) = TotalXP
		        Catch Err As RuntimeException
		        End Try
		      Next
		      Self.List.ScrollPosition = Self.mLastScrollPosition
		      Self.FinalLevelField.Text = EndingLevel.ToString(Locale.Current, ",##0")
		    End Select
		  Next Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, StartingLevel As Integer, StartingXP As UInt64) As UInt64()
		  Var Win As New ExperienceWizard(StartingLevel, StartingXP)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  Var Levels() As UInt64
		  If Not Win.mCancelled Then
		    For I As Integer = 0 To Win.List.RowCount - 1
		      Levels.Add(Win.List.RowTagAt(I))
		    Next
		  End If
		  Win.Close
		  
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Self.ComputeDelayTimer.Reset
		  Self.ComputeDelayTimer.Period = 250
		  Self.ComputeDelayTimer.RunMode = Timer.RunModes.Single
		  
		  Self.mDesiredLevels = Max(CDbl(Self.LevelCountField.Text), 1)
		  Self.mDesiredXP = Max(CDbl(Self.XPField.Text), 0)
		  Self.mDesiredCurve = Self.Designer.Curve
		  Self.mValidXPAmount = (Self.mStartingXP + Self.mDesiredXP) < CType(BeaconConfigs.ExperienceCurves.MaxSupportedXP, UInt64)
		  
		  Self.ComputeSpinner.Visible = True
		  Self.ComputeMessage.Visible = True
		  Self.ActionButton.Enabled = False
		  
		  If Self.List.RowCount > 0 Then
		    Self.mLastScrollPosition = Self.List.ScrollPosition
		    Self.List.RemoveAllRows
		  End If
		  
		  #if false
		    Var Curve As Beacon.Curve = Self.Designer.Curve
		    Var AdditionalLevels As Integer = Max(CDbl(Self.LevelCountField.Text), 1)
		    Var AdditionalXP As UInt64 = Max(CDbl(Self.XPField.Text), 0)
		    Var StartingLevel As Integer = Self.mStartingLevel
		    Var StartingXP As UInt64 = Self.mStartingXP
		    Var EndingLevel As Integer = (StartingLevel + AdditionalLevels) - 1
		    Var EndingXP As UInt64 = StartingXP + AdditionalXP
		    Var ScrollPosition As Integer = Self.List.ScrollPosition
		    Var Allowed As Boolean = EndingXP <= CType(BeaconConfigs.ExperienceCurves.MaxSupportedXP, UInt64)
		    
		    Self.List.RemoveAllRows()
		    
		    Var XTimes As Dictionary = Curve.PrecomputeX(AdditionalLevels, 0.00001)
		    Var LastXP As UInt64 = StartingXP
		    For Level As Integer = 1 To AdditionalLevels
		      Var Time As Double = XTimes.Value(Level)
		      Var Y As Double = Curve.YForT(Time)
		      Var TotalXP As UInt64 = StartingXP + Round((EndingXP - StartingXP) * Y)
		      Var LevelXP As UInt64 = TotalXP - LastXP
		      LastXP = TotalXP
		      
		      Var DisplayLevel As Integer = (Level - 1) + StartingLevel
		      Self.List.AddRow(DisplayLevel.ToString(Locale.Current, ",##0"), LevelXP.ToString(Locale.Current, ",##0"), TotalXP.ToString(Locale.Current, ",##0"))
		      Self.List.RowTagAt(Self.List.LastAddedRowIndex) = TotalXP
		    Next
		    Self.List.ScrollPosition = ScrollPosition
		    
		    Self.FinalLevelField.Text = EndingLevel.ToString(Locale.Current, ",##0")
		    Self.NextLevelField.Text = StartingLevel.ToString(Locale.Current, ",##0")
		    Self.ActionButton.Enabled = Allowed
		    Self.WarningLabel.Visible = Not Allowed
		  #endif
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mComputeThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesiredCurve As Beacon.Curve
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesiredLevels As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesiredXP As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastScrollPosition As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartingLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartingXP As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValidXPAmount As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events LevelCountField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.Focus <> Me Then
		    Return
		  End If
		  
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events XPField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.Focus <> Me Then
		    Return
		  End If
		  
		  Self.UpdateList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Designer
	#tag Event
		Sub Changed()
		  Var SettingUp As Boolean = Self.mSettingUp
		  Self.mSettingUp = True
		  
		  Var Curve As Beacon.Curve = Me.Curve
		  
		  Self.PointFields(0).Text = Curve.Point(1).X.ToString(Locale.Current, "0.000")
		  Self.PointFields(1).Text = Curve.Point(1).Y.ToString(Locale.Current, "0.000")
		  Self.PointFields(2).Text = Curve.Point(2).X.ToString(Locale.Current, "0.000")
		  Self.PointFields(3).Text = Curve.Point(2).Y.ToString(Locale.Current, "0.000")
		  
		  Self.UpdateList()
		  
		  Self.mSettingUp = SettingUp
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub Open()
		  Me.ColumnAlignmentAt(0) = Listbox.Alignments.Right
		  Me.ColumnAlignmentAt(1) = Listbox.Alignments.Right
		  Me.ColumnAlignmentAt(2) = Listbox.Alignments.Right
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If Not Self.mValidXPAmount Then
		    Self.ShowAlert("XP total is too high", "Ark has a limit of " + BeaconConfigs.ExperienceCurves.MaxSupportedXP.ToString(Locale.Current, ",##0") + " total experience.")
		    Return
		  End If
		  
		  Self.CancelComputeThread()
		  Self.mCancelled = False
		  Self.Hide()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.CancelComputeThread()
		  Self.mCancelled = True
		  Self.Hide()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PointFields
	#tag Event
		Sub TextChange(index as Integer)
		  If Self.mSettingUp Or Self.Focus <> Me Then
		    Return
		  End If
		  
		  Var Curve As New Beacon.Curve(CDbl(Self.PointFields(0).Text), CDbl(Self.PointFields(1).Text), CDbl(Self.PointFields(2).Text), CDbl(Self.PointFields(3).Text))
		  Self.Designer.Curve = Curve
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ComputeDelayTimer
	#tag Event
		Sub Action()
		  Self.CancelComputeThread()
		  
		  Self.mComputeThread = New Thread
		  Self.mComputeThread.DebugIdentifier = "Experience Calculator"
		  AddHandler mComputeThread.Run, WeakAddressOf mComputeThread_Run
		  AddHandler mComputeThread.UserInterfaceUpdate, WeakAddressOf mComputeThread_UIUpdate
		  Self.mComputeThread.Start
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Type="Color"
		EditorType="Color"
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
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
