#tag Window
Begin ConfigEditor ExperienceCurvesConfigEditor
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
   Height          =   422
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
   Width           =   710
   Begin BeaconToolbar LeftButtons
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      Caption         =   ""
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
      LockRight       =   False
      LockTop         =   True
      Resizer         =   "0"
      ResizerEnabled  =   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   10
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   201
   End
   Begin Shelf Switcher
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      DrawCaptions    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   60
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      IsVertical      =   False
      Left            =   201
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   308
   End
   Begin FadedSeparator FadedSeparator1
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   60
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   710
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.MinimumWidth = 710
		  Self.MinimumHeight = 368
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub RestoreToDefault()
		  Self.Document.RemoveConfigGroup(BeaconConfigs.ExperienceCurves.ConfigName)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As BeaconConfigs.ExperienceCurves
		  Static ConfigName As Text = BeaconConfigs.ExperienceCurves.ConfigName
		  
		  Dim Document As Beacon.Document = Self.Document
		  Dim Config As BeaconConfigs.ExperienceCurves
		  
		  If Self.mConfigRef <> Nil And Self.mConfigRef.Value <> Nil Then
		    Config = BeaconConfigs.ExperienceCurves(Self.mConfigRef.Value)
		  ElseIf Document.HasConfigGroup(ConfigName) Then
		    Config = BeaconConfigs.ExperienceCurves(Document.ConfigGroup(ConfigName))
		    Self.mConfigRef = New WeakRef(Config)
		  Else
		    Config = New BeaconConfigs.ExperienceCurves
		    Self.mConfigRef = New WeakRef(Config)
		  End If
		  
		  If ForWriting And Not Document.HasConfigGroup(ConfigName) Then
		    Document.AddConfigGroup(Config)
		  End If
		  
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigLabel() As Text
		  Return Language.LabelForConfig(BeaconConfigs.ExperienceCurves.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ViewingPlayerStats() As Boolean
		  //Return Self.ViewSwitch.Items(0).Selected
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigRef As WeakRef
	#tag EndProperty


#tag EndWindowCode

#tag Events LeftButtons
	#tag Event
		Sub Action(Item As BeaconToolbarItem)
		  Select Case Item.Name
		  Case "AddButton"
		    
		  Case "WizardButton"
		    
		  Case "EditButton"
		    
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.LeftItems.Append(New BeaconToolbarItem("AddButton", IconToolbarAdd, "Add a level"))
		  Me.LeftItems.Append(New BeaconToolbarItem("WizardButton", IconToolbarWizard, "Add multiple levels using a configuration wizard"))
		  Me.LeftItems.Append(New BeaconToolbarItem("EditButton", IconToolbarEdit, False, "Edit the selected level"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Open()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconPlayers, "Players", "players")
		  Me.Add(IconTames, "Tames", "tames")
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Dim SettingUp As Boolean = Self.SettingUp
		  Self.SettingUp = True
		  Select Case Me.SelectedIndex
		  Case 1
		    // Self.mGameIniState = New TextAreaState(Self.ConfigArea)
		    // Self.ConfigArea.Text = Self.Config(False).GameUserSettingsIniContent
		    // Self.mGameUserSettingsIniState.ApplyTo(Self.ConfigArea)
		  Case 2
		    // Self.mGameUserSettingsIniState = New TextAreaState(Self.ConfigArea)
		    // Self.ConfigArea.Text = Self.Config(False).GameIniContent
		    // Self.mGameIniState.ApplyTo(Self.ConfigArea)
		  End Select
		  Self.SettingUp = SettingUp
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Progress"
		Group="Behavior"
		InitialValue="ProgressNone"
		Type="Double"
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
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
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
#tag EndViewBehavior
