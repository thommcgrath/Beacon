#tag DesktopWindow
Begin ArkSAConfigEditor ArkSAProjectSettingsEditor Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   554
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
   Width           =   628
   Begin UITweaks.ResizedTextField TitleField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
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
      Left            =   221
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   387
   End
   Begin UITweaks.ResizedLabel TitleLabel
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Title:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   61
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin DesktopTextArea DescriptionArea
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   245
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   221
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   95
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   387
   End
   Begin UITweaks.ResizedLabel DescriptionLabel
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Description:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   95
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin OmniBar ConfigToolbar
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
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   628
   End
   Begin UITweaks.ResizedLabel UWPModeLabel
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Windows Store Compatibility:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#HelpUWPMode"
      Top             =   384
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin UITweaks.ResizedPopupMenu UWPModeMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Automatic\nNever\nAlways"
      Italic          =   False
      Left            =   221
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#HelpUWPMode"
      Top             =   384
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   132
   End
   Begin DesktopLabel CompressedLabel
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Compress Project:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#HelpCompressed"
      Top             =   416
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin DesktopLabel AllowUCSLabel
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Allow UCS-2 Files:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#HelpAllowUCS"
      Top             =   448
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin SwitchControl CompressedSwitch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   221
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#HelpCompressed"
      Top             =   416
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
   Begin SwitchControl AllowUCSSwitch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   221
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#HelpAllowUCS"
      Top             =   448
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LocalBackupLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Keep Local Project Backup:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#HelpLocalBackup"
      Top             =   480
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin SwitchControl LocalBackupSwitch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      Left            =   221
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#HelpLocalBackup"
      Top             =   480
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
   Begin DesktopTextField ProjectIdField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
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
      Left            =   221
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   512
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   387
   End
   Begin UITweaks.ResizedLabel ProjectIdLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Project UUID:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   512
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin DesktopLabel SinglePlayerLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Use Single Player Values:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#HelpSinglePlayer"
      Top             =   352
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   189
   End
   Begin SwitchControl SinglePlayerSwitch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      Left            =   221
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#HelpSinglePlayer"
      Top             =   352
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  NotificationKit.Ignore(Self, ArkSA.Project.Notification_SinglePlayerChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.TitleField.Text = Self.Project.Title
		  Self.DescriptionArea.Text = Self.Project.Description
		  Self.CompressedSwitch.Value(False) = Self.Project.IsFlagged(Beacon.Project.FlagUseCompression)
		  Self.AllowUCSSwitch.Value(False) = Self.Project.IsFlagged(ArkSA.Project.FlagAllowUCS2)
		  Self.UWPModeMenu.SelectedRowIndex = CType(Self.Project.UWPMode, Integer)
		  Self.LocalBackupSwitch.Value(False) = Self.Project.IsFlagged(Beacon.Project.FlagKeepLocalBackup)
		  Self.SinglePlayerSwitch.Value(False) = Self.Project.IsFlagged(ArkSA.Project.FlagSinglePlayer)
		  Self.ProjectIdField.Text = Self.Project.ProjectId
		  
		  BeaconUI.SizeToFit(Self.TitleLabel, Self.DescriptionLabel, Self.UWPModeLabel, Self.CompressedLabel, Self.AllowUCSLabel, Self.LocalBackupLabel, Self.ProjectIdLabel, Self.SinglePlayerLabel)
		  Var ControlLeft As Integer = Self.TitleLabel.Right + 12
		  Self.TitleField.Left = ControlLeft
		  Self.TitleField.Width = Self.Width - (ControlLeft + 20)
		  Self.DescriptionArea.Left = ControlLeft
		  Self.DescriptionArea.Width = Self.TitleField.Width
		  Self.SinglePlayerSwitch.Left = ControlLeft
		  Self.UWPModeMenu.Left = ControlLeft
		  Self.CompressedSwitch.Left = ControlLeft
		  Self.AllowUCSSwitch.Left = ControlLeft
		  Self.LocalBackupSwitch.Left = ControlLeft
		  Self.ProjectIdField.Left = ControlLeft
		  Self.ProjectIdField.Width = Self.TitleField.Width
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused UserData
		  #Pragma Unused FireSetupUI
		  
		  NotificationKit.Watch(Self, ArkSA.Project.Notification_SinglePlayerChanged)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameProjectSettings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case ArkSA.Project.Notification_SinglePlayerChanged
		    Var UserData As Dictionary = Notification.UserData
		    If UserData.Value("ProjectId") = Self.Project.ProjectId Then
		      Var SinglePlayer As Boolean = UserData.Value("NewValue")
		      Self.SinglePlayerSwitch.Value = SinglePlayer
		    End If
		  End Select
		End Sub
	#tag EndMethod


	#tag Constant, Name = HelpAllowUCS, Type = String, Dynamic = True, Default = \"When two-byte characters are used in the server name or message of the day\x2C Ark needs the ini file formatted differently\x2C but this different format is not compatible with most text editors. When this setting is off\x2C Beacon will remove two-byte characters\x2C keeping the ini files compatible with all text editors.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpCompressed, Type = String, Dynamic = True, Default = \"When enabled\x2C the project will be compressed to save disk space. Turn this setting off to save the project as a plain text JSON file.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpConsoleMode, Type = String, Dynamic = True, Default = \"Turns off any Steam-exclusive mods so their contents are not accidentally used in the project. Custom mods are not affected.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpLocalBackup, Type = String, Dynamic = True, Default = \"When turned on\x2C projects saved to the cloud will also save a backup copy to your computer.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpSinglePlayer, Type = String, Dynamic = True, Default = \"Beacon will use Ark\'s single player values for breeding multipliers\x2C experience curve\x2C unlock points\x2C and more.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpUWPMode, Type = String, Dynamic = True, Default = \"Use the [ShooterGameMode_Options] header needed by the Windows Store version of Ark in single player.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TitleField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Project.Title = Me.Text.Trim
		  Self.Modified = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DescriptionArea
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Project.Description = Beacon.SanitizeText(Me.Text.Trim, False)
		  Self.Modified = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UWPModeMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Project.UWPMode = CType(Me.SelectedRowIndex, ArkSA.Project.UWPCompatibilityModes)
		  Self.Modified = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CompressedSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Project.IsFlagged(Beacon.Project.FlagUseCompression) = Me.Value
		  Self.Modified = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AllowUCSSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Project.IsFlagged(ArkSA.Project.FlagAllowUCS2) = Me.Value
		  Self.Modified = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LocalBackupSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Project.IsFlagged(Beacon.Project.FlagKeepLocalBackup) = Me.Value
		  Self.Modified = True
		  Self.SettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SinglePlayerSwitch
	#tag Event
		Sub Pressed()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.SettingUp = True
		  Self.Project.IsFlagged(ArkSA.Project.FlagSinglePlayer) = Me.Value
		  Self.Modified = True
		  Self.SettingUp = False
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
#tag EndViewBehavior
