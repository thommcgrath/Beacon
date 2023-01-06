#tag Window
Begin BeaconDialog ArkEngramControlEngramOverrideWizard
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
   Height          =   306
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   306
   MaximumWidth    =   475
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   306
   MinimumWidth    =   475
   Resizeable      =   False
   Title           =   "Set Engram Properties"
   Type            =   8
   Visible         =   True
   Width           =   475
   Begin Label MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
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
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Set Engram Properties"
      Visible         =   True
      Width           =   435
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
      Left            =   375
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   266
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
      Left            =   283
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   266
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedTextField EntryStringField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   308
   End
   Begin UITweaks.ResizedLabel EntryStringLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Value           =   "Entry String:"
      Visible         =   True
      Width           =   115
   End
   Begin RadioButton EnabledRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Enabled"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   94
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   100
   End
   Begin RadioButton DisabledRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Disabled"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   259
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   94
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   104
   End
   Begin CheckBox AutoUnlockCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Automatically Unlocks"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   126
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   216
   End
   Begin UITweaks.ResizedTextField RequiredLevelField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedLabel RequiredLevelLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Underline       =   False
      Value           =   "Required Level:"
      Visible         =   True
      Width           =   115
   End
   Begin UITweaks.ResizedTextField RequiredPointsField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   192
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedLabel RequiredPointsLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
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
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   192
      Transparent     =   False
      Underline       =   False
      Value           =   "Required Points:"
      Visible         =   True
      Width           =   115
   End
   Begin CheckBox RemovePrereqCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Remove Prerequisites"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   147
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   226
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   216
   End
   Begin CheckBox HiddenEditCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   375
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   94
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   False
      VisualState     =   0
      Width           =   80
   End
   Begin CheckBox AutoUnlockEditCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   375
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   126
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   False
      VisualState     =   0
      Width           =   80
   End
   Begin CheckBox LevelEditCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   375
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   159
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   False
      VisualState     =   0
      Width           =   80
   End
   Begin CheckBox PointsEditCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   375
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   193
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   False
      VisualState     =   0
      Width           =   80
   End
   Begin CheckBox PrereqEditCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   375
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   226
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   False
      VisualState     =   0
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.CheckEnabled()
		  Self.UpdateUI()
		  Self.SwapButtons()
		  
		  If Self.mEngrams.LastIndex = -1 Then
		    // New entry
		    Self.EnabledRadio.Value = True
		  Else
		    Var AutoUnlocks(), Hiddens(), RequiredLevels(), RequiredPointses(), RemovePrereqs() As Variant
		    
		    For Each Engram As Ark.Engram In Self.mEngrams
		      Var LevelRequirement As NullableDouble = Self.mConfig.RequiredPlayerLevel(Engram)
		      If LevelRequirement Is Nil Then
		        LevelRequirement = Engram.RequiredPlayerLevel
		      End If
		      
		      Var PointRequirement As NullableDouble = Self.mConfig.RequiredPoints(Engram)
		      If PointRequirement Is Nil Then
		        PointRequirement = Engram.RequiredUnlockPoints
		      End If
		      
		      Var DoesAutoUnlock As Boolean
		      If Self.mConfig.AutoUnlockAllEngrams Then
		        DoesAutoUnlock = True
		      Else
		        DoesAutoUnlock = IsNull(Self.mConfig.AutoUnlockEngram(Engram)) = False And NullableBoolean(Self.mConfig.AutoUnlockEngram(Engram)).BooleanValue = True
		      End If
		      
		      AutoUnlocks.Add(DoesAutoUnlock)
		      Hiddens.Add(Self.mConfig.EffectivelyHidden(Engram))
		      RequiredLevels.Add(LevelRequirement)
		      RequiredPointses.Add(PointRequirement)
		      RemovePrereqs.Add(Self.mConfig.RemovePrerequisites(Engram))
		    Next
		    
		    If Beacon.AreElementsEqual(AutoUnlocks) Then
		      Self.AutoUnlockCheck.Value = AutoUnlocks(0).BooleanValue
		    End If
		    
		    If Beacon.AreElementsEqual(Hiddens) Then
		      Var Hidden As Boolean = Hiddens(0)
		      If Hidden Then
		        Self.DisabledRadio.Value = True
		      Else
		        Self.EnabledRadio.Value = True
		      End If
		    End If
		    
		    If Self.mEngrams.LastIndex = 0 Then
		      Self.EntryStringField.Text = Self.mConfig.EntryString(Self.mEngrams(0))
		    Else
		      Self.EntryStringField.Text = "Multiple"
		    End If
		    Self.EntryStringField.Enabled = False
		    
		    If Beacon.AreElementsEqual(RequiredLevels) Then
		      Var RequiredLevel As NullableDouble = RequiredLevels(0)
		      If (RequiredLevel Is Nil) = False Then
		        Self.RequiredLevelField.Text = RequiredLevel.IntegerValue.ToString
		      ElseIf Beacon.AreElementsEqual(AutoUnlocks) And AutoUnlocks(0) = True Then
		        Self.RequiredLevelField.Text = "0"
		      Else
		        Self.RequiredLevelField.Text = ""
		      End If
		    End If
		    
		    If Beacon.AreElementsEqual(RequiredPointses) Then
		      Var RequiredPoints As NullableDouble = RequiredPointses(0)
		      If (RequiredPoints Is Nil) = False Then
		        Self.RequiredPointsField.Text = RequiredPoints.IntegerValue.ToString
		      ElseIf Beacon.AreElementsEqual(AutoUnlocks) And AutoUnlocks(0) = True Then
		        Self.RequiredPointsField.Text = ""
		      Else
		        Self.RequiredPointsField.Text = ""
		      End If
		    End If
		    
		    If Beacon.AreElementsEqual(RemovePrereqs) Then
		      Var RemovePrereq As NullableBoolean = RemovePrereqs(0)
		      If IsNull(RemovePrereq) = False Then
		        Self.RemovePrereqCheck.Value = RemovePrereq.BooleanValue
		      Else
		        Self.RemovePrereqCheck.Value = False
		      End If
		    End If
		  End If
		  
		  If Self.mAllowManualUnlock = False Then
		    Self.RequiredPointsField.Enabled = False
		    Self.RequiredPointsLabel.Enabled = False
		  End If
		  
		  If Self.mEngrams.LastIndex > 0 Then
		    Self.AutoUnlockEditCheck.Visible = True
		    Self.HiddenEditCheck.Visible = True
		    Self.LevelEditCheck.Visible = True
		    Self.PointsEditCheck.Visible = True
		    Self.PrereqEditCheck.Visible = True
		  End If
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckEnabled()
		  Self.ActionButton.Enabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Project As Ark.Project, Engrams() As Ark.Engram)
		  // Calling the overridden superclass constructor.
		  
		  Self.mProject = Project
		  Self.mEngrams = Engrams
		  Self.mSettingUp = True
		  Self.mAllowManualUnlock = True
		  
		  For Idx As Integer = 0 To Engrams.LastIndex
		    If Ark.DataSource.Pool.Get(False).BlueprintIsCustom(Engrams(Idx)) = False And Engrams(Idx).ManualUnlock = False Then
		      Self.mAllowManualUnlock = False
		      Exit For Idx
		    End If
		  Next Idx
		  
		  Var Config As Ark.ConfigGroup = Project.ConfigGroup(Ark.Configs.NameEngramControl, False)
		  If Config = Nil Then
		    Self.mConfig = New Ark.Configs.EngramControl
		    Self.mAddConfigGroup = True
		  Else
		    Self.mConfig = Ark.Configs.EngramControl(Config)
		  End If
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Project As Ark.Project, Engrams() As Ark.Engram) As Ark.Engram()
		  Var Edited() As Ark.Engram
		  If Parent = Nil Then
		    Return Edited
		  End If
		  
		  Var Win As New ArkEngramControlEngramOverrideWizard(Project, Engrams)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  
		  Var Cancelled As Boolean = Win.mCancelled
		  If Not Cancelled Then
		    Edited = Win.mEditedEngrams
		  End If
		  Win.Close
		  
		  Return Edited
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  If Self.DisabledRadio.Value Then
		    Self.AutoUnlockCheck.Enabled = False
		    Self.RemovePrereqCheck.Enabled = False
		    Self.RequiredLevelField.Enabled = False
		    Self.RequiredLevelLabel.Enabled = False
		    Self.RequiredPointsField.Enabled = False
		    Self.RequiredPointsLabel.Enabled = False
		    
		    Var Multi As Boolean = Self.mEngrams.LastIndex > 0
		    Self.AutoUnlockEditCheck.Visible = Multi
		    Self.HiddenEditCheck.Visible = Multi
		    Self.LevelEditCheck.Visible = Multi
		    Self.PointsEditCheck.Visible = Multi
		    Self.PrereqEditCheck.Visible = Multi
		  Else
		    If Self.mConfig.AutoUnlockAllEngrams Then
		      Self.AutoUnlockCheck.Value = True
		      Self.AutoUnlockCheck.Enabled = False
		    Else
		      Self.AutoUnlockCheck.Enabled = True
		    End If
		    
		    // If it auto unlocks, it needs a level field and should not have a points field.
		    // If it does not auto unlock, it should have both a level and points field if all target engrams are manual unlocks
		    Self.RequiredLevelField.Enabled = Self.AutoUnlockCheck.Value = True Or Self.mAllowManualUnlock = True
		    Self.RequiredPointsField.Enabled = Self.AutoUnlockCheck.Value = False And Self.mAllowManualUnlock = True
		    Self.RemovePrereqCheck.Enabled = Self.AutoUnlockCheck.Value = False And Self.mAllowManualUnlock = True
		    Self.RequiredLevelLabel.Enabled = Self.RequiredLevelField.Enabled
		    Self.RequiredPointsLabel.Enabled = Self.RequiredPointsField.Enabled
		  End If
		  
		  Self.AutoUnlockEditCheck.Enabled = Self.AutoUnlockCheck.Enabled
		  Self.HiddenEditCheck.Enabled = True
		  Self.LevelEditCheck.Enabled = Self.RequiredLevelField.Enabled
		  Self.PointsEditCheck.Enabled = Self.RequiredPointsField.Enabled
		  Self.PrereqEditCheck.Enabled = Self.RemovePrereqCheck.Enabled
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAddConfigGroup As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowManualUnlock As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfig As Ark.Configs.EngramControl
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditedEngrams() As Ark.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngrams() As Ark.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Action()
		  Var Engrams() As Ark.Engram
		  If Self.mEngrams.LastIndex = -1 Then
		    If Not Self.EntryStringField.Text.EndsWith("_C") Then
		      Self.ShowAlert("The entered Entry String is not correct.", "Ark Entry Strings usually begin with EngramEntry and always end with _C.")
		      Return
		    End If
		    
		    Var ExistingEngrams() As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngramsByEntryString(Self.EntryStringField.Text, Nil)
		    If ExistingEngrams.Count = 0 Then
		      ExistingEngrams.Add(Ark.Engram.CreateFromEntryString(Self.EntryStringField.Text))
		    End If
		    For Each Engram As Ark.Engram In ExistingEngrams
		      Engrams.Add(Engram)
		    Next
		  Else
		    Engrams = Self.mEngrams
		  End If
		  
		  Var EditHidden As Boolean = Self.HiddenEditCheck.Value And Self.HiddenEditCheck.Enabled
		  Var Hidden As NullableBoolean
		  If EditHidden Then
		    If Self.EnabledRadio.Value Then
		      Hidden = False
		    Else
		      Hidden = True
		    End If
		  End If
		  
		  Var EditLevel As Boolean = Self.LevelEditCheck.Value And Self.LevelEditCheck.Enabled
		  Var RequiredLevel As NullableDouble
		  If EditLevel Then
		    If Self.RequiredLevelField.Text.IsEmpty Then
		      RequiredLevel = Nil
		    ElseIf Self.RequiredLevelField.Text = "Spawn" Then
		      RequiredLevel = 1
		    ElseIf IsNumeric(Self.RequiredLevelField.Text) = False Then
		      Self.ShowAlert("Please enter a number for the level field.", "The value entered is not a number.")
		      Return
		    Else
		      RequiredLevel = CDbl(Self.RequiredLevelField.Text)
		    End If
		  End If
		  
		  Var EditAutoUnlock As Boolean = Self.AutoUnlockEditCheck.Value And Self.AutoUnlockEditCheck.Enabled
		  Var AutoUnlock As NullableBoolean
		  If EditAutoUnlock Then
		    AutoUnlock = Self.AutoUnlockCheck.Value
		  End If
		  
		  Var EditPoints As Boolean = Self.PointsEditCheck.Value And Self.PointsEditCheck.Enabled
		  Var RequiredPoints As NullableDouble
		  If EditPoints Then
		    If Self.RequiredPointsField.Text.IsEmpty Then
		      RequiredPoints = Nil
		    ElseIf IsNumeric(Self.RequiredPointsField.Text) = False Then
		      Self.ShowAlert("Please enter a number for the points field.", "The value entered is not a number.")
		      Return
		    Else
		      RequiredPoints = CDbl(Self.RequiredPointsField.Text)
		    End If
		  End If
		  
		  Var EditPrereq As Boolean = Self.PrereqEditCheck.Value And Self.PrereqEditCheck.Enabled
		  Var RemovePrereq As NullableBoolean
		  If EditPrereq Then
		    RemovePrereq = Self.RemovePrereqCheck.Value
		  End If
		  
		  #if false
		    Var ManualUnlockAllowed As Boolean = True
		    For Idx As Integer = 0 To Engrams
		      If Engrams(Idx) Is Nil Then
		        Continue
		      End If
		      
		      If Ark.DataSource.Pool.Get(False).BlueprintIsCustom(Engrams(Idx)) = False And Engrams(Idx).ManualUnlock = False Then
		        ManualUnlockAllowed = False
		        Exit For Idx
		      End If
		    Next
		    
		    
		    If HasOfficialEngram And (EditAutoUnlock Or (EditLevel And (RequiredLevel Is Nil) = False) Or (EditPoints And (RequiredPoints Is Nil) = False)) Then
		      For Each Engram As Beacon.Engram In Engrams
		        If Engram.ManualUnlock = True Or (EditLevel And RequiredLevel Is Nil) Then
		          Continue
		        End If
		        
		        // This engram cannot be manually unlocked, but the user is trying to make that happen
		        
		        If Engram.ManualUnlock Then
		          // Tek unlock
		          Var EngramIsAutoUnlocked As Boolean
		          If EditAutoUnlock Then
		            EngramIsAutoUnlocked = AutoUnlock
		          Else
		            EngramIsAutoUnlocked = If(Self.mConfig.AutoUnlockEngram(Engram) Is Nil, False, Self.mConfig.AutoUnlockEngram(Engram).BooleanValue)
		          End If
		          If EngramIsAutoUnlocked = False And EditLevel And (RequiredLevel Is Nil) = False Then
		            // Can't do that
		            Self.ShowAlert(Engram.Label + " is a Tek engram and must be configured to auto unlock.", "Tek engrams are normally automatically unlocked by defeating bosses. Enter 'Tek' into the 'Required Level' field to use the official unlock config. To have the engram unlocked when the player reaches a certain level, make sure the 'Automatically Unlocks' box is checked.")
		            Return
		          End If
		        End If
		      Next
		    End If
		  #endif
		  
		  If (EditHidden Or EditLevel Or EditAutoUnlock Or EditPoints Or EditPrereq) = False Then
		    // Need to at least change something
		    EditHidden = True
		    Hidden = False
		  End If
		  
		  For Each Engram As Ark.Engram In Engrams
		    If EditAutoUnlock Then
		      Self.mConfig.AutoUnlockEngram(Engram) = AutoUnlock
		    End If
		    
		    If Ark.DataSource.Pool.Get(False).BlueprintIsCustom(Engram) = True Or Engram.ManualUnlock = True Or Self.mConfig.EffectivelyAutoUnlocked(Engram) = True Then
		      If EditLevel Then
		        Self.mConfig.RequiredPlayerLevel(Engram) = RequiredLevel
		      End If
		      If EditPoints Then
		        Self.mConfig.RequiredPoints(Engram) = RequiredPoints
		      End If
		      If EditPrereq Then
		        Self.mConfig.RemovePrerequisites(Engram) = RemovePrereq
		      End If
		    Else
		      Self.mConfig.RequiredPlayerLevel(Engram) = Nil
		      Self.mConfig.RequiredPoints(Engram) = Nil
		      Self.mConfig.RemovePrerequisites(Engram) = Nil
		    End If
		    
		    If EditHidden Then
		      Self.mConfig.Hidden(Engram) = Hidden
		    End If
		  Next
		  
		  If Self.mAddConfigGroup Then
		    Self.mProject.AddConfigGroup(Self.mConfig)
		  End If
		  Self.mEditedEngrams = Engrams
		  
		  Self.mCancelled = False
		  Self.Hide
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
#tag Events EnabledRadio
	#tag Event
		Sub Action()
		  If Not Self.mSettingUp Then
		    Self.HiddenEditCheck.Value = True
		  End If
		  Self.UpdateUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DisabledRadio
	#tag Event
		Sub Action()
		  If Not Self.mSettingUp Then
		    Self.HiddenEditCheck.Value = True
		  End If
		  Self.UpdateUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoUnlockCheck
	#tag Event
		Sub Action()
		  If Me.Value Then
		    Self.RequiredLevelLabel.Text = "Auto Unlocks At:"
		  Else
		    Self.RequiredLevelLabel.Text = "Required Level:"
		  End If
		  If Not Self.mSettingUp Then
		    Self.AutoUnlockEditCheck.Value = True
		  End If
		  Self.UpdateUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RequiredLevelField
	#tag Event
		Sub TextChange()
		  If Not Self.mSettingUp Then
		    Self.LevelEditCheck.Value = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RequiredPointsField
	#tag Event
		Sub TextChange()
		  If Not Self.mSettingUp Then
		    Self.PointsEditCheck.Value = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RemovePrereqCheck
	#tag Event
		Sub Action()
		  If Not Self.mSettingUp Then
		    Self.PrereqEditCheck.Value = True
		  End If
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
#tag EndViewBehavior
