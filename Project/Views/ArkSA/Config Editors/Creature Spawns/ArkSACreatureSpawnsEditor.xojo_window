#tag DesktopWindow
Begin ArkSAConfigEditor ArkSACreatureSpawnsEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   548
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   980
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   507
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   980
      Begin ArkSASpawnPointsEditor PointsEditor
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   507
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Untitled"
         Visible         =   True
         Width           =   980
      End
      Begin ArkSASpawnWeightsEditor WeightsEditor
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   507
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         Transparent     =   True
         ViewIcon        =   0
         ViewTitle       =   "Untitled"
         Visible         =   True
         Width           =   980
      End
   End
   Begin OmniBar TabBar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   980
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  Var Simulator As ArkSASpawnSimulatorWindow = Self.SimulatorWindow(False)
		  If (Simulator Is Nil) = False Then
		    Simulator.Close
		    Self.mSimulatorWindow = Nil
		  End If
		  
		  RaiseEvent Closing
		End Sub
	#tag EndEvent

	#tag Event
		Sub Hidden()
		  Select Case Self.Pages.SelectedPanelIndex
		  Case Self.PageSpawnPoints
		    Self.PointsEditor.SwitchedFrom()
		  Case Self.PageSpawnWeights
		    Self.WeightsEditor.SwitchedFrom()
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.MinimumWidth = Max(Self.PointsEditor.MinimumWidth, 0)
		  Self.MinimumHeight = Max(Self.PointsEditor.MinimumHeight, 0) + Self.TabBar.Top + Self.TabBar.Height
		  
		  RaiseEvent Opening()
		End Sub
	#tag EndEvent

	#tag Event
		Function ParsingFinished(Project As ArkSA.Project) As Boolean
		  If Project Is Nil Or Project.HasConfigGroup(ArkSA.Configs.NameCreatureSpawns) = False Then
		    Return True
		  End If
		  
		  Var ParsedConfig As ArkSA.Configs.SpawnPoints = ArkSA.Configs.SpawnPoints(Project.ConfigGroup(ArkSA.Configs.NameCreatureSpawns))
		  If ParsedConfig = Nil Or ParsedConfig.Count = 0 Then
		    Self.ShowAlert("No spawn points to import", "The parsed ini content did not contain any spawn point data.")
		    Return True
		  End If
		  
		  Self.Pages.SelectedPanelIndex = Self.PageSpawnPoints
		  Self.PointsEditor.HandlePastedSpawnPoints(ParsedConfig.Overrides)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub RunTool(Tool As ArkSA.ProjectTool)
		  Select Case Tool.UUID
		  Case "614cfc80-b7aa-437d-b17e-01534f2ab778"
		    Var Changes As Integer = Self.Project.ConvertDinoReplacementsToSpawnOverrides()
		    Self.SetupUI
		    If Changes = 0 Then
		      Self.ShowAlert("No changes made", "Beacon was unable to find any replaced creatures that it could convert into spawn point additions.")
		    ElseIf Changes = 1 Then
		      Self.ShowAlert("Converted 1 creature replacement", "Beacon found 1 creature that it was able to convert into spawn point additions. The replaced creature has been disabled.")
		    Else
		      Self.ShowAlert("Converted " + Changes.ToString + " creature replacements", "Beacon found " + Changes.ToString + " creatures that it was able to convert into spawn point additions. The replaced creatures have been disabled.")
		    End If
		  Case "8913bca3-fbae-43bd-a94b-7c3ac06b6ca1"
		    Var SourceConfig As ArkSA.Configs.SpawnPoints = Self.Config(False)
		    If ArkSABulkSpawnEditWindow.Present(Self, SourceConfig, Self.Project.ContentPacks, Self.Project.MapMask, Self.Project.Difficulty.DifficultyValue) Then
		      Call Self.Config(True) // To retain the config
		      Self.Modified = SourceConfig.Modified
		      Self.SetupUI
		    End If
		  Case Self.ToolSpawnSimulator
		    Var Win As ArkSASpawnSimulatorWindow = Self.SimulatorWindow(True)
		    Win.RunSimulator()
		    Win.Show
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.PointsEditor.SetupUI()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ShowIssue(Issue As Beacon.Issue)
		  Var LocationParts() As String = Issue.Location.Split(Beacon.Issue.Separator)
		  // ConfigSet is 0, ConfigName is 1
		  Var PointClass As String = LocationParts(2)
		  Var SpawnSetId As String
		  If LocationParts.LastIndex > 2 Then
		    SpawnSetId = LocationParts(3)
		  End If
		  
		  Self.Pages.SelectedPanelIndex = Self.PageSpawnPoints
		  Call Self.PointsEditor.GoToChild(PointClass, SpawnSetId)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused FireSetupUI
		  
		  Select Case Self.Pages.SelectedPanelIndex
		  Case Self.PageSpawnPoints
		    Self.PointsEditor.SwitchedTo(UserData)
		  Case Self.PageSpawnWeights
		    Self.WeightsEditor.SwitchedTo(UserData)
		  End Select
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function ConvertCreatureReplacementsToSpawnPointAdditions() As Boolean Handles ConvertCreatureReplacementsToSpawnPointAdditions.Action
		  If Self.IsFrontmost = False Then
		    Return False
		  End If
		  
		  Var Changes As Integer = Self.Project.ConvertDinoReplacementsToSpawnOverrides()
		  Self.SetupUI()
		  If Changes = 0 Then
		    Self.ShowAlert("No changes made", "Beacon was unable to find any replaced creatures in Creature Adjustments that it could convert into spawn point additions.")
		  ElseIf Changes = 1 Then
		    Self.ShowAlert("Converted 1 creature replacement", "Beacon found 1 creature in Creature Adjustments that it was able to convert into spawn point additions. The replaced creature has been disabled in Creature Adjustments.")
		  Else
		    Self.ShowAlert("Converted " + Changes.ToString + " creature replacements", "Beacon found " + Changes.ToString + " creatures in Creature Adjustments that it was able to convert into spawn point additions. The replaced creatures have been disabled in Creature Adjustments.")
		  End If
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As ArkSA.Configs.SpawnPoints
		  Return ArkSA.Configs.SpawnPoints(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameCreatureSpawns
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SimulatorWindow(Create As Boolean) As ArkSASpawnSimulatorWindow
		  Var Win As ArkSASpawnSimulatorWindow
		  If Self.mSimulatorWindow Is Nil Or Self.mSimulatorWindow.Value Is Nil Or (Self.mSimulatorWindow.Value IsA ArkSpawnSimulatorWindow) = False Then
		    If Create Then
		      Win = New ArkSASpawnSimulatorWindow(Self.Project)
		      Self.mSimulatorWindow = New WeakRef(Win)
		    Else
		      Return Nil
		    End If
		  Else
		    Win = ArkSASpawnSimulatorWindow(Self.mSimulatorWindow.Value)
		  End If
		  Return Win
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSimulatorWindow As WeakRef
	#tag EndProperty


	#tag Constant, Name = PageSpawnPoints, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageSpawnWeights, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ToolSpawnSimulator, Type = String, Dynamic = False, Default = \"fb860a80-e301-43da-b283-cdfcd7369def", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Var OldPage As Integer = -1
		  
		  Var PointsButton As OmniBarItem = Self.TabBar.Item("PointsButton")
		  If (PointsButton Is Nil) = False Then
		    If PointsButton.Toggled Then
		      OldPage = Self.PageSpawnPoints
		    End If
		    PointsButton.Toggled = (Me.SelectedPanelIndex = Self.PageSpawnPoints)
		  End If
		  
		  Var WeightsButton As OmniBarItem = Self.TabBar.Item("WeightsButton")
		  If (WeightsButton Is Nil) = False Then
		    If WeightsButton.Toggled Then
		      OldPage = Self.PageSpawnWeights
		    End If
		    WeightsButton.Toggled = (Me.SelectedPanelIndex = Self.PageSpawnWeights)
		  End If
		  
		  Select Case OldPage
		  Case Self.PageSpawnPoints
		    Self.PointsEditor.SwitchedFrom()
		  Case Self.PageSpawnWeights
		    Self.WeightsEditor.SwitchedFrom()
		  End Select
		  
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageSpawnPoints
		    Self.PointsEditor.SwitchedTo()
		  Case Self.PageSpawnWeights
		    Self.WeightsEditor.SwitchedTo()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PointsEditor
	#tag Event
		Function GetConfig(Writable As Boolean) As ArkSA.Configs.SpawnPoints
		  Return Self.Config(Writable)
		End Function
	#tag EndEvent
	#tag Event
		Function GetProject() As ArkSA.Project
		  Return Self.Project
		End Function
	#tag EndEvent
	#tag Event
		Sub ContentsChanged()
		  Self.Modified = Self.Project.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightsEditor
	#tag Event
		Function GetProject() As ArkSA.Project
		  Return Self.Project
		End Function
	#tag EndEvent
	#tag Event
		Function GetConfig(Writable As Boolean) As ArkSA.Configs.SpawnPoints
		  Return Self.Config(Writable)
		End Function
	#tag EndEvent
	#tag Event
		Sub ContentsChanged()
		  Self.Modified = Self.Project.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TabBar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator("ConfigTitleSeparator"))
		  Me.Append(OmniBarItem.CreateTab("PointsButton", "Spawn Points"))
		  Me.Append(OmniBarItem.CreateTab("WeightsButton", "Weight Multipliers"))
		  
		  Me.Item("PointsButton").Toggled = True
		  
		  Me.Item("ConfigTitle").Priority = 5
		  Me.Item("ConfigTitleSeparator").Priority = 5
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "PointsButton"
		    Self.Pages.SelectedPanelIndex = Self.PageSpawnPoints
		  Case "WeightsButton"
		    Self.Pages.SelectedPanelIndex = Self.PageSpawnWeights
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
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
		Name="AllowAutoDeactivate"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
