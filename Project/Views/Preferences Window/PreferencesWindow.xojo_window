#tag DesktopWindow
Begin BeaconWindow PreferencesWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   478
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   478
   MinimumWidth    =   320
   Resizeable      =   False
   Title           =   "#WindowTitle"
   Type            =   0
   Visible         =   True
   Width           =   320
   Begin DesktopGroupBox SoundsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Notification Sounds"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   140
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   280
      Begin DesktopCheckBox ImportSoundCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Play Sound After Import"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "SoundsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   56
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   240
      End
      Begin DesktopCheckBox DeploySoundCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Play Sound After Deploy"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "SoundsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   88
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   240
      End
      Begin DesktopCheckBox UpdateSoundCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Play Sound When Update Is Ready"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "SoundsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   120
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   240
      End
   End
   Begin DesktopGroupBox ConnectionsGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Connection Performance"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   78
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   380
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   280
      Begin UITweaks.ResizedTextField MaxConnectionsField
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
         InitialParent   =   "ConnectionsGroup"
         Italic          =   False
         Left            =   200
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   416
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel MaxConnectionsLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "ConnectionsGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Maximum Connections:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   416
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   148
      End
   End
   Begin DesktopGroupBox UpdatesGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Software Updates"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   108
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   260
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   280
      Begin UITweaks.ResizedPopupMenu ChannelMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "UpdatesGroup"
         InitialValue    =   "Automatic\nStable\nBeta\nAlpha"
         Italic          =   False
         Left            =   118
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   162
      End
      Begin UITweaks.ResizedLabel ChannelLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "UpdatesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Channel:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   66
      End
      Begin DesktopCheckBox AutoupdateCheckbox
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Automatically Download Updates"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "UpdatesGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   296
         Transparent     =   False
         Underline       =   False
         Value           =   True
         Visible         =   True
         VisualState     =   1
         Width           =   240
      End
   End
   Begin DesktopGroupBox AppearanceGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Appearance"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   76
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   172
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   280
      Begin UITweaks.ResizedPopupMenu DarkModeMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AppearanceGroup"
         InitialValue    =   "Match System"
         Italic          =   False
         Left            =   128
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   208
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   152
      End
      Begin UITweaks.ResizedLabel DarkModeLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "AppearanceGroup"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Theme:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   208
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   76
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  If mInstance = Self Then
		    mInstance = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Var Delta As Integer
		  
		  #if UpdatesKit.UseSparkle
		    Self.UpdateSoundCheck.Visible = False
		    
		    Delta = Self.UpdateSoundCheck.Height + 12
		    Self.SoundsGroup.Height = Self.SoundsGroup.Height - Delta
		    Self.AppearanceGroup.Top = Self.AppearanceGroup.Top - Delta
		    Self.UpdatesGroup.Top = Self.UpdatesGroup.Top - Delta
		    Self.ConnectionsGroup.Top = Self.ConnectionsGroup.Top - Delta
		    Self.Height = Self.Height - Delta
		  #endif
		  
		  If BeaconUI.DarkModeSupported = False Then
		    Self.AppearanceGroup.Visible = False
		    
		    Delta = Self.AppearanceGroup.Height + 12
		    Self.UpdatesGroup.Top = Self.UpdatesGroup.Top - Delta
		    Self.ConnectionsGroup.Top = Self.ConnectionsGroup.Top - Delta
		    Self.Height = Self.Height - Delta
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.mSettingUp = True
		  Super.Constructor
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present()
		  If mInstance Is Nil Then
		    mInstance = New PreferencesWindow
		  End If
		  mInstance.Show
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mInstance As PreferencesWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


	#tag Constant, Name = WindowTitle, Type = String, Dynamic = False, Default = \"Beacon Options", Scope = Private
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Beacon Preferences"
	#tag EndConstant


#tag EndWindowCode

#tag Events ImportSoundCheck
	#tag Event
		Sub Opening()
		  Me.Value = Preferences.PlaySoundAfterImport
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Preferences.PlaySoundAfterImport = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DeploySoundCheck
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Preferences.PlaySoundAfterDeploy = Me.Value
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Value = Preferences.PlaySoundAfterDeploy
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpdateSoundCheck
	#tag Event
		Sub Opening()
		  Me.Value = Preferences.PlaySoundForUpdate
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Preferences.PlaySoundForUpdate = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxConnectionsField
	#tag Event
		Sub Open()
		  Me.Text = Preferences.MaxConnections.ToString(Locale.Raw, "0")
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If IsNumeric(Me.Text) = False Then
		    Return
		  End If
		  
		  Preferences.MaxConnections = Max(1, CDbl(Me.Text))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxConnectionsLabel
	#tag Event
		Sub Open()
		  Me.SizeToFit
		  Self.MaxConnectionsField.Left = Me.Right + 12
		  Self.MaxConnectionsField.Width = Self.ConnectionsGroup.Width - (Me.Width + 52)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChannelMenu
	#tag Event
		Sub Opening()
		  Var Channel As Integer = Preferences.UpdateChannel
		  Select Case Channel
		  Case 0
		    Me.SelectedRowIndex = 0
		  Case 1
		    Me.SelectedRowIndex = 3
		  Case 2
		    Me.SelectedRowIndex = 2
		  Case 3
		    Me.SelectedRowIndex = 1
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Select Case Me.SelectedRowIndex
		  Case 0
		    Preferences.UpdateChannel = 0
		  Case 1
		    Preferences.UpdateChannel = 3
		  Case 2
		    Preferences.UpdateChannel = 2
		  Case 3
		    Preferences.UpdateChannel = 1
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChannelLabel
	#tag Event
		Sub Open()
		  Me.SizeToFit
		  Self.ChannelMenu.Left = Me.Right + 12
		  Self.ChannelMenu.Width = Self.UpdatesGroup.Width - (Me.Width + 52)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AutoupdateCheckbox
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Preferences.AutomaticallyDownloadsUpdates = Me.Value
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Value = Preferences.AutomaticallyDownloadsUpdates
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DarkModeMenu
	#tag Event
		Sub Opening()
		  Me.RemoveAllRows
		  Me.AddRow("Match System", Preferences.DarkModeOptions.FollowSystem)
		  Me.AddRow("Light", Preferences.DarkModeOptions.ForceLight)
		  #if TargetMacOS
		    Me.AddRow("Dark", Preferences.DarkModeOptions.ForceDark)
		  #endif
		  
		  Try
		    Me.SelectRowWithTag(Preferences.DarkMode)
		  Catch Err As RuntimeException
		    Me.SelectedRowIndex = 0
		  End Try
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Var Mode As Preferences.DarkModeOptions = Me.RowTagAt(Me.SelectedRowIndex)
		  Preferences.DarkMode = Mode
		  
		  #if TargetWindows
		    Static RestartWarned As Boolean
		    If RestartWarned = False Then
		      Self.ShowAlert("A restart is required to see the effect.", "Please relaunch Beacon when you're ready.")
		      RestartWarned = True
		    End If
		  #endif
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DarkModeLabel
	#tag Event
		Sub Open()
		  Me.SizeToFit
		  Self.DarkModeMenu.Left = Me.Right + 12
		  Self.DarkModeMenu.Width = Self.AppearanceGroup.Width - (Me.Width + 52)
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Resizeable"
		Visible=false
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
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
#tag EndViewBehavior
