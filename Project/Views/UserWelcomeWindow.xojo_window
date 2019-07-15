#tag Window
Begin Window UserWelcomeWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   True
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   360
   ImplicitInstance=   False
   LiveResize      =   True
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
   Resizeable      =   False
   Title           =   "Welcome to Beacon"
   Visible         =   True
   Width           =   640
   Begin BeaconWebView ContentView
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   90
      HelpTag         =   ""
      Index           =   -2147483648
      Left            =   494
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Renderer        =   1
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   -129
      Visible         =   True
      Width           =   107
   End
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
      TabIndex        =   3
      TabPanelIndex   =   0
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   424
      Begin Label Label1
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
      Begin Label Label2
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
         Text            =   "Beacon stores fully anonymous user data to provide community document sharing and cloud storage features."
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
      Begin LinkLabel LinkLabel1
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
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
      Begin PushButton QuitButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
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
         ButtonStyle     =   "0"
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
      Begin UITweaks.ResizedPushButton LoginCancelButton
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
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   448
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   7
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
      Begin UITweaks.ResizedPushButton LoginSignupButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Create or Recover Account"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   236
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   188
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
         Text            =   "Using your Beacon account, you can sync files, engrams, creatures, and presets between computers."
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
         CueText         =   "raptorpounce@beaconapp.cc"
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
         TabIndex        =   9
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   204
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
      Begin Label Label3
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
         ButtonStyle     =   "0"
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
         TabIndex        =   2
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
         ButtonStyle     =   "0"
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
         TabIndex        =   3
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
         CueText         =   "aggressivedodo@beaconapp.cc"
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
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   152
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
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "E-Mail Address:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   152
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
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   186
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
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
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Code:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   186
         Transparent     =   False
         Underline       =   False
         Visible         =   True
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
   End
   Begin Canvas SidebarCanvas
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   216
   End
   Begin URLConnection ConfirmCodeCreationSocket
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin URLConnection CheckForConfirmationSocket
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  RemoveHandler App.IdentityManager.Finished, AddressOf IdentityManager_Finished
		  
		  If App.IdentityManager.CurrentIdentity = Nil Then
		    Quit
		  Else
		    App.NextLaunchQueueTask()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  AddHandler App.IdentityManager.Finished, AddressOf IdentityManager_Finished
		  
		  Self.mBaseURL = Beacon.WebURL("inapp/")
		  Dim Fields() As Text
		  If Self.mLoginOnly Then
		    Fields.Append("login_only=true")
		  Else
		    Preferences.OnlineEnabled = False
		  End If
		  If SystemColors.IsDarkMode Then
		    Fields.Append("dark")
		  End If
		  Dim Path As String = Self.mBaseURL + "welcome.php"
		  If Fields.Ubound > -1 Then
		    Path = Path + "?" + Fields.Join("&")
		  End If
		  Self.ContentView.LoadURL(Path)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckConfirmButton()
		  If Self.mConfirmEncryptionKey = "" Then
		    Self.ConfirmActionButton.Enabled = Self.ValidateEmail(Self.ConfirmAddressField.Text.Trim)
		  Else
		    Self.ConfirmActionButton.Enabled = Self.ConfirmCodeField.Text.Trim <> ""
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckForConfirmedEmail()
		  Dim Fields As New Dictionary
		  Fields.Value("email") = Self.ConfirmAddressField.Text.Trim
		  Fields.Value("key") = Self.mConfirmEncryptionKey
		  Self.CheckForConfirmationSocket.SetFormData(Fields)
		  Self.CheckForConfirmationSocket.Send("POST", Beacon.WebURL("/account/login/verify.php"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckLoginButton()
		  Self.LoginActionButton.Enabled = Self.ValidateEmail(Self.LoginEmailField.Text.Trim) And Self.LoginPasswordField.Text.Trim <> ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(LoginOnly As Boolean = False)
		  Self.mLoginOnly = LoginOnly
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleAnonymous()
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
		  If Sender.CurrentIdentity = Nil Then
		    // Error
		    Dim Message As Text = Sender.LastError
		    If Message = "" Then
		      Message = "Please try again. If the problem persists help, see " + Beacon.WebURL("/help") + " for more help options."
		    End If
		    Self.ShowAlert("There was an error setting up your user.", Message)
		  Else
		    Self.Close()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResetConfirmUI()
		  Self.mConfirmEncryptionKey = ""
		  Self.ConfirmAddressField.ReadOnly = False
		  Self.ConfirmCodeField.ReadOnly = True
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
		Private Sub ShowError(Message As String, HTTPStatus As Integer)
		  Select Case HTTPStatus
		  Case 404
		    Self.ShowAlert(Message, "The connector was not found. Please contact forgotmyparachute@beaconapp.cc for support.")
		  Case 403, 401
		    Self.ShowAlert(Message, "The connector thinks this request is not authorized. Please contact forgotmyparachute@beaconapp.cc for support.")
		  Case 400
		    Self.ShowAlert(Message, "The connector received incorrect parameters. Please contact forgotmyparachute@beaconapp.cc for support.")
		  Case 500
		    Self.ShowAlert(Message, "The connector had an error. Please contact forgotmyparachute@beaconapp.cc for support.")
		  Else
		    Self.ShowAlert(Message, "The connector returned HTTP status " + Str(HTTPStatus, "-0") + " which Beacon was not prepared for. Please contact forgotmyparachute@beaconapp.cc for support.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowError(Message As String, Err As RuntimeException)
		  Self.ShowAlert(Message, "The error message was: " + Err.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ValidateEmail(Address As String) As Boolean
		  Dim Validator As New RegEx
		  Validator.SearchPattern = "^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|""(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*"")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$"
		  Return Validator.Search(Address) <> Nil
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmedAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmedEmailScheduleKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmEncryptionKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginOnly As Boolean
	#tag EndProperty


	#tag Constant, Name = PageChooseIdentity, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageEnterAddress, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageEnterConfirmation, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLogin, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PagePrivacy, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ContentView
	#tag Event
		Function CancelLoad(URL as String) As Boolean
		  If URL.Left(Self.mBaseURL.Len) = Self.mBaseURL Then
		    Return False
		  End If
		  If Not Beacon.IsBeaconURL(URL) Then
		    ShowURL(URL)
		    Return True
		  End If
		  
		  Dim Pos As Integer = URL.InStr("?")
		  Dim Path, Query As String
		  If Pos > 0 Then
		    Path = URL.Left(Pos - 1)
		    Query = URL.Mid(Pos + 1)
		  Else
		    Path = URL
		  End If
		  
		  Pos = Query.InStr("#")
		  If Pos > 0 Then
		    Query = Query.Left(Pos - 1)
		  End If
		  
		  Dim Params As New Dictionary
		  Dim Parts() As String = Split(Query, "&")
		  For Each Part As String In Parts
		    Pos = Part.InStr("=")
		    Dim Key As String = DecodeURLComponent(Part.Left(Pos - 1)).DefineEncoding(Encodings.UTF8)
		    Dim Value As String = DecodeURLComponent(Part.Mid(Pos + 1)).DefineEncoding(Encodings.UTF8)
		    Params.Value(Key) = Value
		  Next
		  
		  Select Case Path
		  Case "set_user_privacy"
		    Dim Action As String = Params.Lookup("action", "full") // err on the side of privacy
		    Select Case Action
		    Case "anonymous"
		      Self.HandleAnonymous()
		    Case "full"
		      Self.HandleDisableOnline()
		    Case "none"
		    Else
		    End Select
		  Case "set_user_token"
		    Dim StringToken As String = Params.Lookup("token", "")
		    Dim StringPassword As String = Params.Lookup("password", "")
		    
		    Preferences.OnlineEnabled = True
		    Preferences.OnlineToken = StringToken.ToText
		    
		    App.IdentityManager.RefreshUserDetails(StringPassword.ToText)
		  Case "dismiss_me"
		    Self.Close()
		  Else
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub Error(errorNumber as Integer, errorMessage as String)
		  App.Log("UserWelcomeWindow.ContentView.Error " + Str(ErrorNumber) + ": " + ErrorMessage)
		  App.IdentityManager.Create()
		End Sub
	#tag EndEvent
	#tag Event
		Sub DocumentComplete(URL as String)
		  If URL.BeginsWith("chrome-error://") Then
		    // It's an error and this is stupid.
		    App.Log("UserWelcomeWindow Chrome Error")
		    App.IdentityManager.Create()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PagePanel1
	#tag Event
		Sub Change()
		  Select Case Me.Value
		  Case Self.PageLogin
		    Self.LoginRevealCheckbox.Value = False
		    Self.CheckLoginButton()
		  Case Self.PageEnterAddress
		    Self.CheckConfirmButton()
		  End Select
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
		  Self.PagePanel1.Value = Self.PageLogin
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
#tag Events LoginCancelButton
	#tag Event
		Sub Action()
		  Self.PagePanel1.Value = Self.PagePrivacy
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LoginSignupButton
	#tag Event
		Sub Action()
		  If Self.ConfirmAddressField.Text.Trim = "" Then
		    Self.ConfirmAddressField.Text = Self.LoginEmailField.Text.Trim
		  End If
		  Self.PagePanel1.Value = Self.PageEnterAddress
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
		  If Self.mConfirmEncryptionKey = "" Then
		    Self.mConfirmEncryptionKey = Beacon.CreateUUID
		    
		    Dim Fields As New Dictionary
		    Fields.Value("email") = Self.ConfirmAddressField.Text.Trim
		    Fields.Value("key") = Self.mConfirmEncryptionKey
		    Self.ConfirmCodeCreationSocket.SetFormData(Fields)
		    Self.ConfirmCodeCreationSocket.Send("POST", Beacon.WebURL("/account/login/email.php"))
		    
		    Self.ConfirmAddressField.ReadOnly = True
		    Self.ConfirmCodeField.ReadOnly = False
		    Self.ConfirmActionButton.Caption = "Check Code"
		    Self.ConfirmActionButton.Width = 100
		    Self.ConfirmActionButton.Left = Self.Width - (20 + Self.ConfirmActionButton.Width)
		    Self.ConfirmCancelButton.Left = Self.ConfirmActionButton.Left - (12 + Self.ConfirmCancelButton.Width)
		    Self.ConfirmStatusLabel.Width = Self.ConfirmCancelButton.Left - (12 + Self.ConfirmStatusLabel.Left)
		    Self.ConfirmStatusLabel.Text = "Sending Code…"
		    Self.ConfirmSpinner.Visible = True
		    Self.ConfirmStatusLabel.Visible = True
		    Self.CheckConfirmButton()
		    Return
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmCancelButton
	#tag Event
		Sub Action()
		  Self.PagePanel1.Value = Self.PageLogin
		  Self.ResetConfirmUI()
		  Self.ConfirmCodeCreationSocket.Disconnect()
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
#tag Events SidebarCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  G.ClearRect(0, 0, G.Width, G.Height)
		  
		  If Not SystemColors.IsDarkMode Then
		    G.ForeColor = &c713a9a
		    G.FillRect(0, 0, G.Width, G.Height)
		  End If
		  
		  G.DrawPicture(LoginSidebar, 0, 0)
		  
		  G.ForeColor = SystemColors.SeparatorColor
		  G.FillRect(G.Width - 1, 0, G.Width - 1, G.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmCodeCreationSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
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
		  If HTTPStatus >= 200 And HTTPStatus < 300 Then
		    // Success
		    
		    Try
		      Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Content.DefineEncoding(Encodings.UTF8).ToText)
		      Dim Verified As Boolean = Dict.Value("verified")
		      Dim Code As Text = Dict.Value("code")
		      If Verified Then
		        Self.ConfirmCodeField.Text = Code
		        Self.mConfirmedAddress = Dict.Value("email")
		        Self.PagePanel1.Value = Self.PageChooseIdentity
		        Return
		      End If
		    Catch Err As Xojo.Data.InvalidJSONException
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
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
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
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
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
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
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
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
