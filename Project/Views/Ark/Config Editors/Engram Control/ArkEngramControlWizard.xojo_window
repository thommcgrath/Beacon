#tag DesktopWindow
Begin BeaconDialog ArkEngramControlWizard
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
   Height          =   142
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "Engram Control Wizard"
   Type            =   8
   Visible         =   True
   Width           =   508
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
      Text            =   "Engram Control Quick Setup Wizard"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   468
   End
   Begin UITweaks.ResizedPopupMenu TemplateMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Unlock all at spawn\nUnlock all except Tek at spawn\nUnlock all while leveling\nUnlock all except Tek while leveling\nUnlock unobtainable while leveling\nUnlock Tek at level:\nGrant exact points needed per level\nMake everything unlockable at level:"
      Italic          =   False
      Left            =   86
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   310
   End
   Begin UITweaks.ResizedLabel TemplateLabel
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
      Text            =   "Design:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   54
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
      Left            =   408
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
      Top             =   102
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
      Left            =   316
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   102
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin RangeField TekLevelField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DoubleValue     =   0.0
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
      Left            =   408
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
      Text            =   "135"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   59
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   False
      Width           =   80
   End
   Begin Thread WorkThread
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   3
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
		Sub Opening()
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Cancel()
		  If Thread.Current = Nil Then
		    Self.mCancelled = True
		    Self.Hide
		  Else
		    Var Dict As New Dictionary
		    Dict.Value("Action") = "Cancel"
		    Thread.Current.AddUserInterfaceUpdate(Dict)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project)
		  Self.mProject = Project
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Increment()
		  Self.mEngramsProcessed = Self.mEngramsProcessed + 1
		  
		  If Self.mProgressShown = False And System.Microseconds - Self.mStartTime >= 500000 Then
		    Self.mProgressShown = True
		    
		    If Thread.Current = Nil Then
		      Self.mProgress.Show(Self)
		    Else
		      Var Dict As New Dictionary
		      Dict.Value("Action") = "ShowProgress"
		      Thread.Current.AddUserInterfaceUpdate(Dict)
		    End If
		  End If
		  
		  Self.mProgress.Progress = Self.mEngramsProcessed / Self.mEngramCount
		  Self.mProgress.Detail = "Updated " + Self.mEngramsProcessed.ToString(Locale.Current, "#,##0") + " of " + Self.mEngramCount.ToString(Locale.Current, "#,##0") + " engrams"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Project As Ark.Project) As Boolean
		  If Parent = Nil Then
		    Return False
		  End If
		  
		  Var Win As New ArkEngramControlWizard(Project)
		  Win.ShowModal(Parent)
		  
		  Var Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesign As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramsProcessed As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgressShown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartTime As Double
	#tag EndProperty


	#tag Constant, Name = IndexGrantExactPoints, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexMakeEverythingAvailableAtLevel, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexUnlockAll, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexUnlockAllNoTek, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexUnlockNaturally, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexUnlockNaturallyNoTek, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexUnlockTek, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IndexUnlockUnobtainable, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TemplateMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  Self.TekLevelField.Visible = Me.SelectedRowIndex = Self.IndexUnlockTek Or Me.SelectedRowIndex = Self.IndexMakeEverythingAvailableAtLevel
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Self.mDesign = Self.TemplateMenu.SelectedRowIndex
		  Self.mLevel = Round(Self.TekLevelField.DoubleValue)
		  Self.mStartTime = System.Microseconds
		  Me.Enabled = False
		  Self.CancelButton.Enabled = False
		  Self.mProgress = New ProgressWindow("Updating engrams", "Getting started…")
		  Self.mProgress.Visible = False
		  
		  Self.WorkThread.Start
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
#tag Events TekLevelField
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0
		  MaxValue = 65535
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WorkThread
	#tag Event
		Sub Run()
		  Var Config As Ark.Configs.EngramControl
		  Var AddWhenFinished As Boolean
		  If Self.mProject.HasConfigGroup(Ark.Configs.NameEngramControl) Then
		    Config = Ark.Configs.EngramControl(Self.mProject.ConfigGroup(Ark.Configs.NameEngramControl, False))
		  Else
		    Config = New Ark.Configs.EngramControl
		    AddWhenFinished = True
		  End If
		  
		  Var Engrams() As Ark.Engram = Beacon.Merge(Config.Engrams, Ark.DataSource.Pool.Get(False).GetEngramEntries("", Self.mProject.ContentPacks, ""))
		  Self.mEngramCount = Engrams.Count
		  
		  // Do the work
		  Select Case Self.mDesign
		  Case Self.IndexUnlockAll
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      Config.AutoUnlockEngram(Engram) = True
		      Config.RequiredPlayerLevel(Engram) = 0
		      Config.Hidden(Engram) = False
		      Self.Increment()
		    Next
		    Config.AutoUnlockAllEngrams = False
		  Case Self.IndexUnlockAllNoTek
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      If Engram.IsTagged("tek") Then
		        Self.Increment()
		        Continue
		      End If
		      Config.AutoUnlockEngram(Engram) = True
		      Config.RequiredPlayerLevel(Engram) = 0
		      Config.Hidden(Engram) = False
		      Self.Increment()
		    Next
		    Config.AutoUnlockAllEngrams = False
		  Case Self.IndexUnlockNaturally
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      Config.AutoUnlockEngram(Engram) = True
		      Config.Hidden(Engram) = False
		      Self.Increment()
		    Next
		    Config.AutoUnlockAllEngrams = False
		  Case Self.IndexUnlockNaturallyNoTek
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      If Engram.IsTagged("tek") Then
		        Self.Increment()
		        Continue
		      End If
		      Config.AutoUnlockEngram(Engram) = True
		      Config.Hidden(Engram) = False
		      Self.Increment()
		    Next
		    Config.AutoUnlockAllEngrams = False
		  Case Self.IndexUnlockUnobtainable
		    Var Mask As UInt64 = Self.mProject.MapMask
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      If Engram.ValidForMask(Mask) Then
		        Self.Increment()
		        Continue
		      End If
		      
		      Config.AutoUnlockEngram(Engram) = True
		      Config.Hidden(Engram) = False
		      Self.Increment()
		    Next
		    Config.AutoUnlockAllEngrams = False
		  Case Self.IndexGrantExactPoints
		    Var PlayerLevelCap As Integer = Ark.DataSource.Pool.Get(False).OfficialPlayerLevelData.MaxLevel
		    If Self.mProject.HasConfigGroup(Ark.Configs.NameExperienceCurves) Then
		      Var ExperienceConfig As Ark.Configs.ExperienceCurves = Ark.Configs.ExperienceCurves(Self.mProject.ConfigGroup(Ark.Configs.NameExperienceCurves, False))
		      If ExperienceConfig <> Nil Then
		        PlayerLevelCap = Max(PlayerLevelCap, ExperienceConfig.PlayerLevelCap)
		      End If
		    End If
		    Config.LevelsDefined = PlayerLevelCap
		    
		    For Level As Integer = 1 To PlayerLevelCap
		      Config.PointsForLevel(Level) = 0
		    Next
		    
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      Var Level As NullableDouble = Config.RequiredPlayerLevel(Engram)
		      If IsNull(Level) Then
		        Level = Engram.RequiredPlayerLevel
		        If IsNull(Level) Then
		          Self.Increment()
		          Continue
		        End If
		      End If
		      
		      Var Points As NullableDouble
		      If IsNull(Config.AutoUnlockEngram(Engram)) Or Config.AutoUnlockEngram(Engram).BooleanValue = False Then
		        Points = Config.RequiredPoints(Engram)
		        If IsNull(Points) Then
		          Points = Engram.RequiredUnlockPoints
		          If IsNull(Points) Then
		            Self.Increment()
		            Continue
		          End If
		        End If
		      End If
		      
		      Var ActualLevel As Integer = Level.IntegerValue
		      Var ActualPoints As Integer = If(IsNull(Points), 0, Points.IntegerValue)
		      Var CurrentPoints As NullableDouble = Config.PointsForLevel(ActualLevel)
		      Config.PointsForLevel(ActualLevel) = If(IsNull(CurrentPoints), 0, CurrentPoints.IntegerValue) + ActualPoints
		      Self.Increment()
		    Next
		  Case Self.IndexUnlockTek
		    Var Level As Integer = Self.mLevel
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      If Not Engram.IsTagged("tek") Then
		        Self.Increment()
		        Continue
		      End If
		      Config.AutoUnlockEngram(Engram) = True
		      Config.RequiredPlayerLevel(Engram) = Level
		      Config.Hidden(Engram) = False
		      Self.Increment()
		    Next
		    Config.AutoUnlockAllEngrams = False
		  Case Self.IndexMakeEverythingAvailableAtLevel
		    Var Level As Integer = Self.mLevel
		    For Each Engram As Ark.Engram In Engrams
		      If Self.mProgress.CancelPressed Then
		        Self.Cancel
		        Return
		      End If
		      
		      If IsNull(Config.Hidden(Engram)) Then
		        Config.Hidden(Engram) = False
		      End If
		      If IsNull(Engram.RequiredUnlockPoints) = False Then
		        Config.RequiredPlayerLevel(Engram) = Level
		      End If
		      Self.Increment()
		    Next
		  End Select
		  
		  If AddWhenFinished Then
		    Self.mProject.AddConfigGroup(Config)
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("Action") = "Finished"
		  
		  Me.AddUserInterfaceUpdate(Dict)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    Select Case Dict.Lookup("Action", "").StringValue
		    Case "Finished"
		      If Self.mProgressShown Then
		        Self.mProgress.Close
		      End If
		      Self.mProgress = Nil
		      
		      Self.mCancelled = False
		      Self.Hide
		      Return
		    Case "ShowProgress"
		      Self.mProgress.Show(Self)
		    Case "Cancel"
		      If Self.mProgressShown Then
		        Self.mProgress.Close
		      End If
		      Self.mProgress = Nil
		      
		      Self.mCancelled = True
		      Self.Hide
		    End Select
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
