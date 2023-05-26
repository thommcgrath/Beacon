#tag DesktopWindow
Begin ServerViewContainer FTPServerView
   AcceptFocus     =   "False"
   AcceptTabs      =   "True"
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   AutoDeactivate  =   "True"
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackColor    =   False
   Height          =   612
   HelpTag         =   ""
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
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   600
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   571
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   600
      Begin BeaconTextArea AdminNotesField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   531
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
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
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   560
      End
      Begin CommonServerSettingsView SettingsView
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         Composited      =   False
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   571
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
         SettingUp       =   False
         ShowsMapMenu    =   True
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   41
         Transparent     =   True
         Visible         =   True
         Width           =   600
      End
      Begin DesktopGroupBox ConnectionGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Connection"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   310
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   15
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   61
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
         Begin FTPSettingsView ConnectionView
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   False
            AllowTabs       =   True
            Backdrop        =   0
            BackgroundColor =   &cFFFFFF
            Composited      =   False
            Enabled         =   True
            HasBackgroundColor=   False
            Height          =   294
            Index           =   -2147483648
            InitialParent   =   "ConnectionGroup"
            Left            =   20
            LockBottom      =   True
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   2
            TabStop         =   True
            Tooltip         =   ""
            Top             =   77
            Transparent     =   True
            Visible         =   True
            Width           =   560
         End
      End
      Begin DesktopGroupBox PathsGroup
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Paths"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   112
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   16
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   383
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
         Begin UITweaks.ResizedTextField GameIniPathField
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
            InitialParent   =   "PathsGroup"
            Italic          =   False
            Left            =   224
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            MaximumCharactersAllowed=   0
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   0
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   419
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   336
         End
         Begin UITweaks.ResizedTextField GameUserSettingsIniPathField
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
            InitialParent   =   "PathsGroup"
            Italic          =   False
            Left            =   224
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            MaximumCharactersAllowed=   0
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextAlignment   =   0
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   453
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   ""
            Visible         =   True
            Width           =   336
         End
         Begin UITweaks.ResizedLabel GameUserSettingsIniPathLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "PathsGroup"
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
            TabIndex        =   2
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "GameUserSettings.ini Path:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   453
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   172
         End
         Begin UITweaks.ResizedLabel GameIniPathLabel
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "PathsGroup"
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
            TabIndex        =   3
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "Game.ini Path:"
            TextAlignment   =   3
            TextColor       =   &c00000000
            Tooltip         =   ""
            Top             =   419
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   172
         End
      End
   End
   Begin OmniBar ControlToolbar
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
      Width           =   600
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.mSettingUp = True
		  Self.AdminNotesField.Text = Self.mProfile.AdminNotes
		  Self.ConnectionView.Mode = Self.mProfile.Mode
		  Self.ConnectionView.Host = Self.mProfile.Host
		  Self.ConnectionView.Port = Self.mProfile.Port
		  Self.ConnectionView.Username = Self.mProfile.Username
		  Self.ConnectionView.Password = Self.mProfile.Password
		  Self.ConnectionView.VerifyTLSCertificate = Self.mProfile.VerifyHost
		  Self.ConnectionView.UsePublicKeyAuth = (Self.mProfile.PrivateKeyFile Is Nil) = False
		  Self.ConnectionView.PrivateKeyFile = Self.mProfile.PrivateKeyFile
		  Self.GameIniPathField.Text = Self.mProfile.GameIniPath
		  Self.GameUserSettingsIniPathField.Text = Self.mProfile.GameUserSettingsIniPath
		  
		  Self.SettingsView.RefreshUI()
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Document As Ark.Project, Profile As Ark.FTPServerProfile)
		  Self.mDocument = Document
		  Self.mProfile = Profile
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDocument As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Ark.FTPServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  For Idx As Integer = 0 To Self.ControlToolbar.LastIndex
		    Self.ControlToolbar.Item(Idx).Toggled = Me.SelectedPanelIndex = Idx
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AdminNotesField
	#tag Event
		Sub TextChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.mProfile.AdminNotes = Me.Text
		  Self.Modified = Self.mProfile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SettingsView
	#tag Event
		Sub ContentsChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.Modified = Me.Modified
		End Sub
	#tag EndEvent
	#tag Event
		Function GetProject() As Ark.Project
		  Return Self.mDocument
		End Function
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Profile = Self.mProfile
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConnectionView
	#tag Event
		Sub WantsHeightChange(NewDesiredHeight As Integer)
		  Self.ConnectionGroup.Height = NewDesiredHeight + 16
		  Self.PathsGroup.Top = Self.ConnectionGroup.Bottom + 12
		End Sub
	#tag EndEvent
	#tag Event
		Sub ContentsChanged()
		  If Me.Ready = False Or Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.mSettingUp = True
		  
		  Self.mProfile.Mode = Me.Mode
		  Self.mProfile.Host = Me.Host
		  Self.mProfile.Port = Me.Port
		  Self.mProfile.Username = Me.Username
		  Self.mProfile.Password = Me.Password
		  Self.mProfile.VerifyHost = Me.VerifyTLSCertificate
		  
		  If Me.UsePublicKeyAuth Then
		    Self.mProfile.PrivateKeyFile(Me.InternalizeKey) = Me.PrivateKeyFile
		    Me.PrivateKeyFile = Self.mProfile.PrivateKeyFile // Just to make sure the path shows correctly
		  Else
		    Self.mProfile.PrivateKeyFile = Nil
		  End If
		  
		  Self.mSettingUp = False
		  
		  Self.Modified = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GameIniPathField
	#tag Event
		Sub TextChanged()
		  Self.mProfile.GameIniPath = Me.Text
		  Self.Modified = Self.mProfile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GameUserSettingsIniPathField
	#tag Event
		Sub TextChanged()
		  Self.mProfile.GameUserSettingsIniPath = Me.Text
		  Self.Modified = Self.mProfile.Modified
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ControlToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTab("PageGeneral", "General"))
		  Me.Append(OmniBarItem.CreateTab("PageConnection", "Connection"))
		  Me.Append(OmniBarItem.CreateTab("PageNotes", "Notes"))
		  Me.Item("PageGeneral").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "PageGeneral"
		    Self.Pages.SelectedPanelIndex = 0
		  Case "PageConnection"
		    Self.Pages.SelectedPanelIndex = 1
		  Case "PageNotes"
		    Self.Pages.SelectedPanelIndex = 2
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
