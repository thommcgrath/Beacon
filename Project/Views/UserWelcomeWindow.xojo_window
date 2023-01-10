#tag Window
Begin Window UserWelcomeWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   True
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   360
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   360
   MinimizeButton  =   False
   MinWidth        =   640
   Placement       =   2
   Resizable       =   "True"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Welcome to Beacon"
   Visible         =   True
   Width           =   640
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   360
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   216
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   424
      Begin Label PrivacyMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Welcome to Beacon"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin Label PrivacyExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   36
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Beacon stores fully anonymous user data to provide community project sharing and cloud storage features."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin LinkLabel PrivacyPolicyLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         ShowAsLink      =   True
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "See how Beacon manages your data…"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   100
         Transparent     =   False
         Underline       =   True
         URL             =   ""
         Visible         =   True
         Width           =   384
      End
      Begin UITweaks.ResizedPushButton ContinueAnonymousButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Continue"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   160
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPushButton ContinueAuthenticatedButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Login With Email"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   192
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPushButton DisableOnlineButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Disable Cloud && Community Features"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   224
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPushButton QuitButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Quit"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   298
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   256
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   261
      End
      Begin UITweaks.ResizedPushButton LoginActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Login"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   540
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton LoginCancelButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   448
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label LoginMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Login With Your Beacon Account"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin Label LoginExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   36
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Using your Beacon account, you can sync files, engrams, creatures, and templates between computers."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin UITweaks.ResizedTextField LoginEmailField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "raptorpounce@usebeacon.app"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   352
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   268
      End
      Begin UITweaks.ResizedLabel LoginEmailLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
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
         Text            =   "E-Mail Address:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedTextField LoginPasswordField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   352
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   169
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   268
      End
      Begin UITweaks.ResizedLabel LoginPasswordLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Password:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin CheckBox LoginRevealCheckbox
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Reveal Password"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   352
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   203
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   268
      End
      Begin Label ConfirmMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Enter Your E-Mail Address"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin Label ConfirmExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   36
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "After entering your E-Mail address, you will be sent a message to confirm you own the address."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin UITweaks.ResizedPushButton ConfirmActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Send Confirmation"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   478
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   142
      End
      Begin UITweaks.ResizedPushButton ConfirmCancelButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   386
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField ConfirmAddressField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "aggressivedodo@usebeacon.app"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   352
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   268
      End
      Begin UITweaks.ResizedLabel ConfirmAddressLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "E-Mail Address:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   104
      End
      Begin UITweaks.ResizedTextField ConfirmCodeField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   352
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   False
         Width           =   114
      End
      Begin UITweaks.ResizedLabel ConfirmCodeLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Code:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   104
      End
      Begin ProgressWheel ConfirmSpinner
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   236
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   324
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
      Begin Label ConfirmStatusLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   264
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   9
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Sending Code…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   324
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   110
      End
      Begin Label IdentityMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Create Your Profile"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin Label IdentityExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   90
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Time to choose a username and password. Your username can be anything you wish. Your password must be at least 8 characters long, but there are no other wacky requirements. This password will protect your account's private key, so the longer, the better."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin UITweaks.ResizedTextField IdentityUsernameField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   353
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   154
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   267
      End
      Begin LinkLabel IdentityRandomNameButton
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   353
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         ShowAsLink      =   True
         TabIndex        =   4
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Pick a random name"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   180
         Transparent     =   False
         Underline       =   True
         URL             =   ""
         Visible         =   True
         Width           =   267
      End
      Begin UITweaks.ResizedTextField IdentityPasswordField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   353
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   212
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   267
      End
      Begin UITweaks.ResizedTextField IdentityPasswordConfirmField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   353
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   246
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   267
      End
      Begin UITweaks.ResizedLabel IdentityUsernameLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Username:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   154
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   105
      End
      Begin UITweaks.ResizedLabel IdentityPasswordLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Password:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   212
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   105
      End
      Begin UITweaks.ResizedLabel IdentityPasswordConfirmLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Password Again:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   246
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   105
      End
      Begin CheckBox IdentityRevealCheckbox
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Reveal Password"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   353
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   9
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   280
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   267
      End
      Begin UITweaks.ResizedPushButton IdentityActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Create Account"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   497
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   123
      End
      Begin UITweaks.ResizedPushButton IdentityCancelButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   405
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ProgressWheel IdentitySpinner
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   236
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   4
         TabStop         =   True
         Top             =   324
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
      Begin Label IdentityStatusLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   264
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   13
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Creating account…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   324
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   129
      End
      Begin LinkLabel LoginSignupButton
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   352
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         ShowAsLink      =   True
         TabIndex        =   7
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Create or Recover Account"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   235
         Transparent     =   False
         Underline       =   True
         URL             =   ""
         Visible         =   True
         Width           =   268
      End
      Begin ProgressWheel LoginSpinner
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   324
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
      Begin Label LoginStatusLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   264
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   11
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Logging in…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   324
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   172
      End
      Begin ProgressWheel WelcomePageSpinner
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   236
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   324
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
      Begin Label OTPMessageLabel
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Two-Factor Authentication"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin Label OTPExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   38
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Please enter the code generated by your mobile application or security key."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   384
      End
      Begin TextField OTPCodeField
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   350
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   128
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   142
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   155
      End
      Begin UITweaks.ResizedPushButton OTPCancelButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   425
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton OTPActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Authenticate"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   517
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   103
      End
      Begin ProgressWheel OTPSpinner
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   236
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   324
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
      Begin Label OTPStatusLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   264
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Logging in…"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   324
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   149
      End
      Begin SwitchControl OTPRememberCheck
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   350
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   7
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   176
         Transparent     =   True
         Visible         =   True
         Width           =   40
      End
      Begin Label OTPRememberLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   402
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "Don't ask for codes on this computer"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   176
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   103
      End
   End
   Begin URLConnection ConfirmCodeCreationSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection CheckForConfirmationSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection VerifyConfirmationCodeSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection IdentitySuggestionSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection SubmitIdentitySocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection LoginSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Canvas SidebarCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   360
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   216
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  RemoveHandler App.IdentityManager.Finished, AddressOf IdentityManager_Finished
		  
		  If App.IdentityManager.CurrentIdentity Is Nil Then
		    Quit
		  Else
		    App.NextLaunchQueueTask()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  #if TargetMacOS
		    Self.NSWindowMBS.styleMask = Self.NSWindowMBS.styleMask Or NSWindowMBS.NSFullSizeContentViewWindowMask
		    Self.NSWindowMBS.titlebarAppearsTransparent = True
		    Self.NSWindowMBS.titleVisibility = NSWindowMBS.NSWindowTitleHidden
		  #endif
		  
		  AddHandler App.IdentityManager.Finished, AddressOf IdentityManager_Finished
		  
		  If Self.mLoginOnly Then
		    Self.PagePanel1.SelectedPanelIndex = Self.PageLogin
		  Else
		    Preferences.OnlineEnabled = False
		  End If
		  
		  If Beacon.SafeToInvoke(Self.mExecuteAfterPresent) Then
		    Self.mExecuteAfterPresent.Invoke(Self)
		  End If
		  Self.mExecuteAfterPresent = Nil
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckConfirmButton()
		  If Self.mConfirmEncryptionKey = "" Then
		    Self.ConfirmActionButton.Enabled = Beacon.ValidateEmail(Self.ConfirmAddressField.Text.Trim)
		  Else
		    Self.ConfirmActionButton.Enabled = Self.ConfirmCodeField.Text.Trim <> ""
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckForConfirmedEmail()
		  Var Fields As New Dictionary
		  Fields.Value("email") = Self.ConfirmAddressField.Text.Trim
		  Fields.Value("key") = Self.mConfirmEncryptionKey
		  Self.CheckForConfirmationSocket.SetFormData(Fields)
		  Self.CheckForConfirmationSocket.Send("POST", Beacon.WebURL("/account/login/verify"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckIdentityActionButton()
		  Self.IdentityActionButton.Enabled = Self.IdentityUsernameField.Text.Trim <> "" And Self.IdentityPasswordField.Text <> "" And Self.IdentityPasswordField.Text = Self.IdentityPasswordConfirmField.Text
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckLoginButton()
		  Self.LoginActionButton.Enabled = Beacon.ValidateEmail(Self.LoginEmailField.Text.Trim) And Self.LoginPasswordField.Text <> ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckOTPButton()
		  // Don't hard-code to a certain value in case the length needs to change
		  Self.OTPActionButton.Enabled = Self.OTPCodeField.Text.Length > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Just here to block calling with New
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(LoginOnly As Boolean, ExecuteAfterPresent As UserWelcomeWindow.ExecuteAfterPresentDelegate)
		  Self.mLoginOnly = LoginOnly
		  Self.mExecuteAfterPresent = ExecuteAfterPresent
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ExecuteAfterPresentDelegate(WelcomeWindow As UserWelcomeWindow)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub HandleAnonymous()
		  Self.ContinueAnonymousButton.Enabled = False
		  Self.ContinueAuthenticatedButton.Enabled = False
		  Self.DisableOnlineButton.Enabled = False
		  Self.WelcomePageSpinner.Visible = True
		  
		  Preferences.OnlineEnabled = True
		  Preferences.OnlineToken = ""
		  App.IdentityManager.Create()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDisableOnline()
		  Preferences.OnlineEnabled = False
		  Preferences.OnlineToken = ""
		  App.IdentityManager.Create()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IdentityManager_Finished(Sender As IdentityManager)
		  If Sender.CurrentIdentity Is Nil Then
		    // Error
		    Var Message As String = Sender.LastError
		    If Message = "" Then
		      Message = "Please try again. If the problem persists help, see " + Beacon.WebURL("/help") + " for more help options."
		    End If
		    Self.ShowAlert("There was an error setting up your user.", Message)
		    
		    Self.ContinueAnonymousButton.Enabled = True
		    Self.ContinueAuthenticatedButton.Enabled = True
		    Self.DisableOnlineButton.Enabled = True
		    Self.WelcomePageSpinner.Visible = False
		  Else
		    Self.Close()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsPresent() As Boolean
		  Return (mInstance Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Login()
		  Self.Login("", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Login(OTP As String, Trust As NullableBoolean)
		  Var Body As New Dictionary
		  Body.Value("device_id") = Beacon.HardwareID
		  
		  If (Trust Is Nil) = False Then
		    Body.Value("trust") = Trust.BooleanValue
		  End If
		  
		  If OTP.IsEmpty = False Then
		    Body.Value("verification_code") = OTP
		  End If
		  
		  Self.LoginSocket.SetRequestContent(Beacon.GenerateJSON(Body, False), "application/json")
		  Self.LoginSocket.RequestHeader("Authorization") = "Basic " + EncodeBase64(Self.LoginEmailField.Text.Trim + ":" + Self.LoginPasswordField.Text, 0)
		  Self.LoginSocket.RequestHeader("User-Agent") = App.UserAgent
		  Self.LoginSocket.Send("POST", BeaconAPI.URL("session"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(LoginOnly As Boolean, ExecuteAfterPresent As UserWelcomeWindow.ExecuteAfterPresentDelegate = Nil)
		  If (mInstance Is Nil) = False Or (Thread.Current Is Nil) = False Then
		    Return
		  End If
		  
		  mInstance = New UserWelcomeWindow(LoginOnly, ExecuteAfterPresent)
		  mInstance.ShowModal()
		  mInstance = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResetConfirmUI()
		  Self.mConfirmEncryptionKey = ""
		  Self.ConfirmAddressField.ReadOnly = False
		  Self.ConfirmCodeField.ReadOnly = True
		  Self.ConfirmCodeField.Visible = False
		  Self.ConfirmCodeLabel.Visible = False
		  Self.ConfirmCodeField.Text = ""
		  Self.ConfirmActionButton.Caption = "Send Confirmation"
		  Self.ConfirmActionButton.Width = 142
		  Self.ConfirmActionButton.Left = Self.Width - (20 + Self.ConfirmActionButton.Width)
		  Self.ConfirmCancelButton.Left = Self.ConfirmActionButton.Left - (12 + Self.ConfirmCancelButton.Width)
		  Self.ConfirmStatusLabel.Width = Self.ConfirmCancelButton.Left - (12 + Self.ConfirmStatusLabel.Left)
		  Self.ConfirmStatusLabel.Text = "Sending Code…"
		  Self.ConfirmSpinner.Visible = False
		  Self.ConfirmStatusLabel.Visible = False
		  Self.CheckConfirmButton()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetLoginStatus(Status As String)
		  Self.LoginStatusLabel.Text = Status
		  
		  If Status = "" Then
		    Self.LoginSpinner.Visible = False
		    Self.LoginStatusLabel.Visible = False
		    Self.LoginEmailField.ReadOnly = False
		    Self.LoginPasswordField.ReadOnly = False
		    Self.LoginSignupButton.Enabled = True
		    Self.CheckLoginButton()
		    Return
		  End If
		  
		  Self.LoginSpinner.Visible = True
		  Self.LoginStatusLabel.Visible = True
		  Self.LoginActionButton.Enabled = False
		  Self.LoginEmailField.ReadOnly = True
		  Self.LoginPasswordField.ReadOnly = True
		  Self.LoginSignupButton.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetOTPStatus(Status As String)
		  Self.OTPStatusLabel.Text = Status
		  Self.OTPActionButton.Enabled = False
		  
		  If Status.IsEmpty Then
		    Self.OTPSpinner.Visible = False
		    Self.OTPStatusLabel.Visible = False
		    Self.OTPCodeField.ReadOnly = False
		    Self.OTPRememberCheck.Enabled = True
		    Self.OTPRememberLabel.Enabled = True
		    Self.CheckOTPButton()
		    Return
		  End If
		  
		  Self.OTPSpinner.Visible = True
		  Self.OTPStatusLabel.Visible = True
		  Self.OTPCodeField.ReadOnly = True
		  Self.OTPRememberCheck.Enabled = False
		  Self.OTPRememberLabel.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetPageFocus()
		  Select Case Self.PagePanel1.SelectedPanelIndex
		  Case Self.PageLogin
		    If Self.LoginEmailField.Text.Trim = "" Then
		      Self.LoginEmailField.SetFocus()
		    ElseIf Self.LoginPasswordField.Text.Trim = "" Then
		      Self.LoginPasswordField.SetFocus()
		    End If
		  Case Self.PageConfirm
		    If Self.ConfirmAddressField.Text.Trim = "" And Self.ConfirmAddressField.ReadOnly = False Then
		      Self.ConfirmAddressField.SetFocus()
		    ElseIf Self.ConfirmCodeField.Text.Trim = "" And Self.ConfirmCodeField.ReadOnly = False Then
		      Self.ConfirmCodeField.SetFocus()
		    End If
		  Case Self.PageIdentity
		    If Self.IdentityUsernameField.Text.Trim = "" Then
		      Self.IdentityUsernameField.SetFocus()
		    ElseIf Self.IdentityPasswordField.Text = "" Then
		      Self.IdentityPasswordField.SetFocus()
		    ElseIf Self.IdentityPasswordConfirmField.Text = "" Then
		      Self.IdentityPasswordConfirmField.SetFocus()
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetSubmitIdentityStatus(Status As String)
		  Self.IdentityStatusLabel.Text = Status
		  
		  If Status = "" Then
		    Self.CheckIdentityActionButton()
		    Self.IdentityUsernameField.ReadOnly = False
		    Self.IdentityPasswordField.ReadOnly = False
		    Self.IdentityPasswordConfirmField.ReadOnly = False
		    Self.IdentitySpinner.Visible = False
		    Self.IdentityStatusLabel.Visible = False
		    Return
		  End If
		  
		  Self.IdentityActionButton.Enabled = False
		  Self.IdentityUsernameField.ReadOnly = True
		  Self.IdentityPasswordField.ReadOnly = True
		  Self.IdentityPasswordConfirmField.ReadOnly = True
		  Self.IdentitySpinner.Visible = True
		  Self.IdentityStatusLabel.Visible = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowError(Message As String, HTTPStatus As Integer)
		  App.Log(Message + " HTTP " + HTTPStatus.ToString(Locale.Raw, "0") + " error.")
		  
		  Select Case HTTPStatus
		  Case 404
		    Self.ShowAlert(Message, "The connector was not found. Please contact help@usebeacon.app for support.")
		  Case 403, 401
		    Self.ShowAlert(Message, "The connector thinks this request is not authorized. Please contact help@usebeacon.app for support.")
		  Case 400
		    Self.ShowAlert(Message, "The connector received incorrect parameters. Please contact help@usebeacon.app for support.")
		  Case 500
		    Self.ShowAlert(Message, "The connector had an error. Please contact help@usebeacon.app for support.")
		  Else
		    Self.ShowAlert(Message, "The connector returned HTTP status " + HTTPStatus.ToString(Locale.Raw, "0") + " which Beacon was not prepared for. Please contact help@usebeacon.app for support.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowError(Message As String, Err As RuntimeException)
		  App.Log(Err, CurrentMethodName, Message)
		  
		  Const Explanation = "Press the ""System Status"" button to check on the status of Beacon's services. If Beacon is working correctly, check your internet connection."
		  
		  Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm(Message, Explanation, "System Status", "Cancel", "Help")
		  Select Case Choice
		  Case BeaconUI.ConfirmResponses.Action
		    System.GotoURL("https://status.usebeacon.app/")
		  Case BeaconUI.ConfirmResponses.Alternate
		    System.GotoURL(Beacon.WebURL("/help/solving_connection_problems_to"))
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SubmitIdentity(AllowInsecurePassword As Boolean)
		  Var Fields As New Dictionary
		  Fields.Value("email") = Self.mConfirmedAddress
		  Fields.Value("code") = Self.mConfirmedCode
		  Fields.Value("key") = Self.mConfirmEncryptionKey
		  Fields.Value("username") = Self.IdentityUsernameField.Text.Trim
		  Fields.Value("password") = Self.IdentityPasswordField.Text
		  Fields.Value("allow_vulnerable") = AllowInsecurePassword
		  
		  Self.SubmitIdentitySocket.RequestHeader("X-BEACON-UPGRADE-ENCRYPTION") = "True"
		  Self.SubmitIdentitySocket.SetFormData(Fields)
		  Self.SubmitIdentitySocket.Send("POST", Beacon.WebURL("/account/login/password"))
		  
		  Self.SetSubmitIdentityStatus(If(Self.mUseRecoverLanguage, "Changing password…", "Creating account…"))
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmedAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmedCode As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmedEmailScheduleKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmEncryptionKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExecuteAfterPresent As UserWelcomeWindow.ExecuteAfterPresentDelegate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As UserWelcomeWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginOnly As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseRecoverLanguage As Boolean
	#tag EndProperty


	#tag Constant, Name = PageConfirm, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageIdentity, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLogin, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageOTP, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PagePrivacy, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events PagePanel1
	#tag Event
		Sub Change()
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageLogin
		    Self.LoginRevealCheckbox.Value = False
		    Self.CheckLoginButton()
		  Case Self.PageConfirm
		    Self.CheckConfirmButton()
		  Case Self.PageIdentity
		    Self.IdentityRevealCheckbox.Value = False
		    Self.IdentityActionButton.Caption = If(Self.mUseRecoverLanguage, "Reset Password", "Create Account")
		    Self.IdentityMessageLabel.Text = If(Self.mUseRecoverLanguage, "Recover Your Account", "Create Your Account")
		    Self.CheckIdentityActionButton()
		  End Select
		  
		  Call CallLater.Schedule(1, AddressOf SetPageFocus)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PrivacyPolicyLabel
	#tag Event
		Sub Action()
		  System.GotoURL(Beacon.WebURL("/help/about_user_privacy"))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.SizeToFit
		  Me.Left = Self.PagePanel1.Left + ((Self.PagePanel1.Width - Me.Width) / 2)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContinueAnonymousButton
	#tag Event
		Sub Action()
		  Self.HandleAnonymous()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContinueAuthenticatedButton
	#tag Event
		Sub Action()
		  Self.PagePanel1.SelectedPanelIndex = Self.PageLogin
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DisableOnlineButton
	#tag Event
		Sub Action()
		  Self.HandleDisableOnline()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events QuitButton
	#tag Event
		Sub Action()
		  Quit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginActionButton
	#tag Event
		Sub Action()
		  Self.SetLoginStatus("Logging in…")
		  Self.Login()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginCancelButton
	#tag Event
		Sub Action()
		  Self.SetLoginStatus("")
		  Self.LoginSocket.Disconnect()
		  
		  If Self.mLoginOnly Then
		    Self.Close
		  Else
		    Self.PagePanel1.SelectedPanelIndex = Self.PagePrivacy
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginEmailField
	#tag Event
		Sub TextChange()
		  Self.CheckLoginButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginPasswordField
	#tag Event
		Sub TextChange()
		  Self.CheckLoginButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginRevealCheckbox
	#tag Event
		Sub Action()
		  Self.LoginPasswordField.Password = Not Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmActionButton
	#tag Event
		Sub Action()
		  If Self.mConfirmedAddress = Self.ConfirmAddressField.Text.Trim And Self.mConfirmedCode <> "" Then
		    Self.PagePanel1.SelectedPanelIndex = Self.PageIdentity
		    Return
		  End If
		  
		  If Self.mConfirmEncryptionKey = "" Then
		    Self.mConfirmEncryptionKey = New v4UUID
		    
		    Var Fields As New Dictionary
		    Fields.Value("email") = Self.ConfirmAddressField.Text.Trim
		    Fields.Value("key") = Self.mConfirmEncryptionKey
		    Self.ConfirmCodeCreationSocket.SetFormData(Fields)
		    Self.ConfirmCodeCreationSocket.Send("POST", Beacon.WebURL("/account/login/email"))
		    
		    Self.ConfirmAddressField.ReadOnly = True
		    Self.ConfirmCodeField.ReadOnly = False
		    Self.ConfirmCodeField.Visible = True
		    Self.ConfirmCodeLabel.Visible = True
		    Self.ConfirmActionButton.Caption = "Check Code"
		    Self.ConfirmActionButton.Width = 100
		    Self.ConfirmActionButton.Left = Self.Width - (20 + Self.ConfirmActionButton.Width)
		    Self.ConfirmCancelButton.Left = Self.ConfirmActionButton.Left - (12 + Self.ConfirmCancelButton.Width)
		    Self.ConfirmStatusLabel.Width = Self.ConfirmCancelButton.Left - (12 + Self.ConfirmStatusLabel.Left)
		    Self.ConfirmStatusLabel.Text = "Sending Code…"
		    Self.ConfirmSpinner.Visible = True
		    Self.ConfirmStatusLabel.Visible = True
		    Self.CheckConfirmButton()
		    Self.ConfirmCodeField.SetFocus()
		    Return
		  End If
		  
		  Me.Enabled = False
		  Self.ConfirmCodeField.ReadOnly = True
		  Self.ConfirmCodeField.Visible = False
		  Self.ConfirmCodeLabel.Visible = False
		  
		  Var Fields As New Dictionary
		  Fields.Value("code") = Self.ConfirmCodeField.Text.Trim
		  Fields.Value("key") = Self.mConfirmEncryptionKey
		  Fields.Value("email") = Self.ConfirmAddressField.Text.Trim
		  
		  Self.VerifyConfirmationCodeSocket.SetFormData(Fields)
		  Self.VerifyConfirmationCodeSocket.Send("POST", Beacon.WebURL("/account/login/verify"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmCancelButton
	#tag Event
		Sub Action()
		  Self.PagePanel1.SelectedPanelIndex = Self.PageLogin
		  Self.ResetConfirmUI()
		  Self.ConfirmCodeCreationSocket.Disconnect()
		  Self.CheckForConfirmationSocket.Disconnect()
		  Self.VerifyConfirmationCodeSocket.Disconnect()
		  If Self.mConfirmedEmailScheduleKey <> "" Then
		    CallLater.Cancel(Self.mConfirmedEmailScheduleKey)
		    Self.mConfirmedEmailScheduleKey = ""
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmAddressField
	#tag Event
		Sub TextChange()
		  Self.CheckConfirmButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmCodeField
	#tag Event
		Sub TextChange()
		  Self.CheckConfirmButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentityUsernameField
	#tag Event
		Sub TextChange()
		  Self.CheckIdentityActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentityRandomNameButton
	#tag Event
		Sub Action()
		  Self.IdentitySuggestionSocket.Send("GET", Beacon.WebURL("/account/login/suggest"))
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentityPasswordField
	#tag Event
		Sub TextChange()
		  Self.CheckIdentityActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentityPasswordConfirmField
	#tag Event
		Sub TextChange()
		  Self.CheckIdentityActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentityRevealCheckbox
	#tag Event
		Sub Action()
		  Self.IdentityPasswordField.Password = Not Me.Value
		  Self.IdentityPasswordConfirmField.Password = Not Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentityActionButton
	#tag Event
		Sub Action()
		  Self.SubmitIdentity(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentityCancelButton
	#tag Event
		Sub Action()
		  Self.ResetConfirmUI()
		  Self.PagePanel1.SelectedPanelIndex = Self.PageConfirm
		  Self.SubmitIdentitySocket.Disconnect()
		  Self.IdentitySuggestionSocket.Disconnect()
		  Self.SetSubmitIdentityStatus("")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginSignupButton
	#tag Event
		Sub Action()
		  If Self.ConfirmAddressField.Text.Trim = "" Then
		    Self.ConfirmAddressField.Text = Self.LoginEmailField.Text.Trim
		  End If
		  Self.PagePanel1.SelectedPanelIndex = Self.PageConfirm
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OTPCodeField
	#tag Event
		Sub TextChange()
		  Self.CheckOTPButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OTPCancelButton
	#tag Event
		Sub Action()
		  Self.OTPCodeField.Text = ""
		  Self.SetOTPStatus("")
		  Self.LoginSocket.Disconnect()
		  Self.PagePanel1.SelectedPanelIndex = Self.PageLogin
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OTPActionButton
	#tag Event
		Sub Action()
		  Self.SetOTPStatus("Logging in…")
		  Self.Login(Self.OTPCodeField.Text.Trim, Self.OTPRememberCheck.Value)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OTPRememberLabel
	#tag Event
		Sub Open()
		  Me.SizeToFit
		  
		  Var RememberWidth As Integer = Self.OTPRememberCheck.Width + 12 + Me.Width
		  Self.OTPRememberCheck.Left = Self.PagePanel1.Left + ((Self.PagePanel1.Width - RememberWidth) / 2)
		  Self.OTPRememberLabel.Left = Self.OTPRememberCheck.Right + 12
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmCodeCreationSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  #Pragma Unused Content
		  
		  If HTTPStatus >= 200 And HTTPStatus < 300 Then
		    // Success
		    Self.ConfirmStatusLabel.Text = "Waiting for confirmation…"
		    Self.mConfirmedEmailScheduleKey = CallLater.Schedule(5000, AddressOf CheckForConfirmedEmail)
		    Return
		  End If
		  
		  Self.ResetConfirmUI()
		  Self.ShowError("Could not send your confirmation code.", HTTPStatus)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.ShowError("Could not send your confirmation code.", e)
		  Self.ResetConfirmUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckForConfirmationSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  
		  If HTTPStatus >= 200 And HTTPStatus < 300 Then
		    // Success
		    
		    Try
		      Var Dict As Dictionary = Beacon.ParseJSON(Content.DefineEncoding(Encodings.UTF8))
		      Var Verified As Boolean = Dict.Value("verified")
		      If Verified Then
		        Var Code As String = Dict.Value("code")
		        Self.ConfirmCodeField.Text = Code
		        Self.mConfirmedAddress = Dict.Value("email")
		        Self.mConfirmedCode = Dict.Value("code")
		        
		        If Dict.Value("username") <> Nil Then
		          Self.IdentityUsernameField.Text = Dict.Value("username")
		          Self.mUseRecoverLanguage = True
		        Else
		          Self.mUseRecoverLanguage = False
		        End If
		        
		        Self.PagePanel1.SelectedPanelIndex = Self.PageIdentity
		        Return
		      End If
		    Catch Err As RuntimeException
		      Self.ShowError("You will need to enter your confirmation code manually because there was an error checking for it automatically.", Err)
		      Return
		    End Try
		    
		    Self.mConfirmedEmailScheduleKey = CallLater.Schedule(5000, AddressOf CheckForConfirmedEmail)
		    Return
		  End If
		  
		  Self.ShowError("You will need to enter your confirmation code manually because there was an error checking for it automatically.", HTTPStatus)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.ShowError("You will need to enter your confirmation code manually because there was an error checking for it automatically.", e)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VerifyConfirmationCodeSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  
		  If HTTPStatus >= 200 And HTTPStatus < 300 Then
		    // Success
		    
		    Try
		      Var Dict As Dictionary = Beacon.ParseJSON(Content.DefineEncoding(Encodings.UTF8))
		      Var Verified As Boolean = Dict.Value("verified")
		      If Verified Then
		        If Self.mConfirmedEmailScheduleKey <> "" Then
		          CallLater.Cancel(Self.mConfirmedEmailScheduleKey)
		          Self.mConfirmedEmailScheduleKey = ""
		        End If
		        
		        If Dict.Value("username") <> Nil Then
		          Self.IdentityUsernameField.Text = Dict.Value("username")
		          Self.mUseRecoverLanguage = True
		        Else
		          Self.mUseRecoverLanguage = False
		        End If
		        
		        Self.mConfirmedAddress = Dict.Value("email")
		        Self.mConfirmedCode = Dict.Value("code")
		        Self.PagePanel1.SelectedPanelIndex = Self.PageIdentity
		        Return
		      Else
		        Self.ShowAlert("Your confirmation code is not correct.", "Try using copy and paste, the code is case-sensitive.")
		      End If
		    Catch Err As RuntimeException
		      Self.ShowError("There was an error reading the confirmation response from the connector.", Err)
		    End Try
		    
		    Self.ConfirmCodeField.ReadOnly = False
		    Self.CheckConfirmButton()
		    Return
		  End If
		  
		  Self.ShowError("Unable to verify your confirmation code.", HTTPStatus)
		  Self.ConfirmCodeField.ReadOnly = False
		  Self.CheckConfirmButton()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.ShowError("Unable to verify your confirmation code.", e)
		  Self.ConfirmCodeField.ReadOnly = False
		  Self.CheckConfirmButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IdentitySuggestionSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  
		  Self.IdentityRandomNameButton.Enabled = True
		  
		  If HTTPStatus >= 200 And HTTPStatus < 300 Then
		    Try
		      Var Dict As Dictionary = Beacon.ParseJSON(Content.DefineEncoding(Encodings.UTF8))
		      Var Username As String = Dict.Value("username")
		      Self.IdentityUsernameField.Text = Username
		    Catch Err As RuntimeException
		      Self.ShowError("Cannot get a username suggestion.", Err)
		      Return
		    End Try
		    
		    Return
		  End If
		  
		  Self.ShowError("Cannot get a username suggestion.", HTTPStatus)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.IdentityRandomNameButton.Enabled = True
		  Self.ShowError("Cannot get a username suggestion.", e)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SubmitIdentitySocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  
		  Self.SetSubmitIdentityStatus("")
		  
		  If HTTPStatus >= 200 And HTTPStatus < 300 Then
		    Try
		      Var Dict As Dictionary = Beacon.ParseJSON(Content.DefineEncoding(Encodings.UTF8))
		      Var SessionID As String = Dict.Value("session_id")
		      
		      Preferences.OnlineToken = SessionID
		      Preferences.OnlineEnabled = True
		      
		      App.IdentityManager.RefreshUserDetails(Self.IdentityPasswordField.Text)
		      Self.SetSubmitIdentityStatus("Downloading keys…")
		    Catch Err As RuntimeException
		      Self.ShowError("There was an error reading the response from the connector.", Err)
		    End Try
		    
		    Return
		  End If
		  
		  Select Case HTTPStatus
		  Case 436 // Not Validated
		    Self.ShowAlert("Your E-Mail address has not been validated.", "You will be sent back to the email confirmation step.")
		    Self.mConfirmedAddress = ""
		    Self.mConfirmedCode = ""
		    Self.ResetConfirmUI()
		    Self.PagePanel1.SelectedPanelIndex = Self.PageConfirm
		  Case 437 // Rules
		    Self.ShowAlert("Your chosen password is not acceptable.", "Pick a password at least 8 characters long.")
		  Case 438 // Compromised
		    If Not Self.ShowConfirm("Your password has been previously discovered by hackers. You should pick a different password.", "The website haveibeenpwned.com tracks breaches. Beacon found your password in their database, which means attackers know it. The password should no longer be used on any service.", "Understood", "Use Anyway") Then
		      Self.SubmitIdentity(True)
		    End If
		  Else
		    Self.ShowError("Cannot create your account.", HTTPStatus)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.SetSubmitIdentityStatus("")
		  Self.ShowError("Cannot create your account.", e)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused URL
		  
		  If HTTPStatus >= 200 And HTTPStatus < 300 Then
		    Try
		      Var Dict As Dictionary = Beacon.ParseJSON(Content.DefineEncoding(Encodings.UTF8))
		      Var SessionID As String = Dict.Value("session_id")
		      
		      Preferences.OnlineToken = SessionID
		      Preferences.OnlineEnabled = True
		      
		      App.IdentityManager.RefreshUserDetails(Self.LoginPasswordField.Text)
		      Self.SetLoginStatus("Downloading keys…")
		      Self.SetOTPStatus("Downloading keys…")
		    Catch Err As RuntimeException
		      Self.ShowError("There was an error reading the response from the connector.", Err)
		    End Try
		    
		    Return
		  End If
		  
		  Self.SetLoginStatus("")
		  Self.SetOTPStatus("")
		  
		  If HTTPStatus = 403 Then
		    Try
		      Var Dict As Dictionary = Beacon.ParseJSON(Content.DefineEncoding(Encodings.UTF8))
		      Var ReasonCode As String = Dictionary(Dict.Value("details").ObjectValue).Value("code").StringValue
		      If ReasonCode = "2FA_ENABLED" Then
		        Self.PagePanel1.SelectedPanelIndex = Self.PageOTP
		        
		        If Self.OTPCodeField.Text.IsEmpty = False Then
		          Self.ShowAlert("Invalid two factor token, please try again", "The codes are timed.")
		        End If
		      End If
		      Return
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Looking for reason code in 403 response")
		    End Try
		    
		    Self.ShowAlert("Your email and password was not accepted.", "If you need to reset your password, use the ""Create or Recover Account"" link below.")
		  Else
		    Self.ShowError("Unable to login", HTTPStatus)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.SetLoginStatus("")
		  Self.SetOTPStatus("")
		  Self.ShowError("Unable to login", e)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SidebarCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.ClearRectangle(0, 0, G.Width, G.Height)
		  
		  If Not SystemColors.IsDarkMode Then
		    G.DrawPicture(LoginSidebarBackground, 0, 0)
		  End If
		  
		  G.DrawPicture(LoginSidebarLogo, 0, 0)
		  
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRectangle(G.Width - 1, 0, G.Width - 1, G.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=false
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
