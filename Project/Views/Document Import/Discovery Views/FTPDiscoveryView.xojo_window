#tag Window
Begin DiscoveryView FTPDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   310
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
   Visible         =   True
   Width           =   600
   Begin PagePanel ViewPanel
      AllowAutoDeactivate=   True
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   310
      HelpTag         =   ""
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
      SelectedPanelIndex=   1
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedLabel ServerModeLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Mode:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   238
         Transparent     =   True
         Underline       =   False
         Value           =   "Mode:"
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedPopupMenu ServerModeMenu
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         InitialValue    =   "Autodetect\nFTP\nFTP with TLS\nSFTP"
         Italic          =   False
         Left            =   118
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   238
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   142
      End
      Begin Label ExplanationLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   38
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Beacon will securely send this information to the Beacon API server, which will perform the FTP work. The server will not store or log FTP information in any way."
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   True
         Underline       =   False
         Value           =   "Beacon will securely send this information to the Beacon API server, which will perform the FTP work. The server will not store or log FTP information in any way."
         Visible         =   True
         Width           =   560
      End
      Begin Label ServerMessageLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Server Settings"
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Value           =   "Server Settings"
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedLabel ServerHostLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Host:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   102
         Transparent     =   True
         Underline       =   False
         Value           =   "Host:"
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerHostField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   118
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   102
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   462
      End
      Begin UITweaks.ResizedLabel ServerPortLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Port:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   True
         Underline       =   False
         Value           =   "Port:"
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerPortField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   118
         LimitText       =   5
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   "#####"
         MaximumCharactersAllowed=   5
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "21"
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   "#####"
         Value           =   "21"
         Visible         =   True
         Width           =   101
      End
      Begin UITweaks.ResizedLabel ServerUserLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Username:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Transparent     =   True
         Underline       =   False
         Value           =   "Username:"
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerUserField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   118
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   462
      End
      Begin UITweaks.ResizedLabel ServerPassLabel
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Password:"
         TextAlign       =   "2"
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   204
         Transparent     =   True
         Underline       =   False
         Value           =   "Password:"
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedTextField ServerPassField
         AcceptTabs      =   False
         Alignment       =   "0"
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         HelpTag         =   ""
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   118
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         MaximumCharactersAllowed=   0
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   "0"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   204
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   462
      End
      Begin Label DiscoveringMessage
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Connecting to Server…"
         TextAlign       =   "1"
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   129
         Transparent     =   False
         Underline       =   False
         Value           =   "Connecting to Server…"
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar DiscoveringProgress
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         MaximumValue    =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   161
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
      End
      Begin Label BrowseMessage
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Please locate your Game.ini file"
         TextAlign       =   "0"
         TextAlignment   =   "1"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Value           =   "Please locate your Game.ini file"
         Visible         =   True
         Width           =   560
      End
      Begin PushButton BrowseActionButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin PushButton BrowseCancelButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   "False"
         Enabled         =   True
         EraseBackground =   "True"
         Height          =   1
         HelpTag         =   ""
         Index           =   0
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   52
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   "False"
         Enabled         =   True
         EraseBackground =   "True"
         Height          =   1
         HelpTag         =   ""
         Index           =   1
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   257
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   "False"
         Enabled         =   True
         EraseBackground =   "True"
         Height          =   204
         HelpTag         =   ""
         Index           =   2
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   53
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   1
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   "False"
         Enabled         =   True
         EraseBackground =   "True"
         Height          =   204
         HelpTag         =   ""
         Index           =   3
         InitialParent   =   "ViewPanel"
         Left            =   579
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollSpeed     =   20
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   53
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   1
      End
      Begin ColumnBrowser Browser
         AcceptFocus     =   False
         AcceptTabs      =   True
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         CurrentPath     =   ""
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   "True"
         HasBackColor    =   False
         HasBackgroundColor=   False
         Height          =   204
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   21
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   53
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   558
      End
      Begin ProgressWheel BrowseSpinner
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   274
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
      Begin UITweaks.ResizedPushButton ServerCancelButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ServerActionButton
         AllowAutoDeactivate=   True
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   "0"
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin BeaconAPI.Socket BrowseSocket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 310
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DetectPath(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Dim Info As Introspection.TypeInfo
		  Dim Dict As Dictionary
		  If Response.JSON <> Nil Then
		    Info = Introspection.GetType(Response.JSON)
		    If Info.FullName = "Dictionary" Then
		      Dict = Response.JSON
		    End If
		  End If
		  
		  If Dict <> Nil And Dict.HasKey("ftp_mode") Then
		    Self.mProfile.Mode = Dict.Value("ftp_mode")
		  End If
		  
		  If Response.Success Then
		    // Discovery was able to find the path and the user doesn't need to do any further work.
		    Dim Path As String = Dict.Value("path")
		    
		    Dim Engines(0) As Beacon.DiscoveryEngine
		    Engines(0) = New Beacon.FTPDiscoveryEngine(Self.mProfile, Path, App.IdentityManager.CurrentIdentity)
		    Self.ShouldFinish(Engines)
		    
		    Return
		  End If
		  
		  If Response.HTTPStatus = 404 Then
		    // Server was connected, but the path could not be determined, so time to show the browser.
		    Self.ViewPanel.SelectedPanelIndex = Self.PageBrowse
		    Self.Browser.Reset()
		    Return
		  End If
		  
		  // The connection was not succesful
		  Self.ViewPanel.SelectedPanelIndex = Self.PageGeneral
		  
		  Self.ShowAlert("Beacon was unable to discover the server.", "Reason: " + Response.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListPath(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Not Response.Success Then
		    Self.ShowAlert("Unable to list contents of " + Self.Browser.CurrentPath, Response.Message)
		    Return
		  End If
		  
		  Dim Dict As Dictionary = Response.JSON
		  Dim Files() As Variant = Dict.Value("files")
		  Dim Children() As String
		  For Each Child As String In Files
		    Children.Append(Child)
		  Next
		  Self.Browser.AppendChildren(Children)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckServerActionButton()
		  Self.ServerActionButton.Enabled = ServerHostField.Value <> "" And Val(ServerPortField.Value) > 0 And ServerUserField.Value <> "" And ServerPassField.Value <> ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FormDataFromProfile() As Dictionary
		  If Self.mProfile = Nil Then
		    Return Nil
		  End If
		  
		  Return Self.mProfile.AsFormData()
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mProfile As Beacon.FTPServerProfile
	#tag EndProperty


	#tag Constant, Name = PageBrowse, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDiscovering, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageGeneral, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ServerHostField
	#tag Event
		Sub TextChanged()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerPortField
	#tag Event
		Sub TextChanged()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerUserField
	#tag Event
		Sub TextChanged()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerPassField
	#tag Event
		Sub TextChanged()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BrowseActionButton
	#tag Event
		Sub Pressed()
		  Dim GameIniPath As String = Self.Browser.CurrentPath
		  Dim Components() As String = GameIniPath.Split("/")
		  If Components.LastRowIndex <= 2 Then
		    Self.ShowAlert("FTP Access Too Restrictive", "Beacon needs to be able to access this server's ""Logs"" folder too, to learn more about the server than the config files can provide. The path to this server's Game.ini does not allow access to other directories needed within Ark's ""Saved"" directory.")
		    Return
		  End If
		  Components.Remove(Components.LastRowIndex) // Remove Game.ini
		  Components.Remove(Components.LastRowIndex) // Remove WindowsServer
		  Components(Components.LastRowIndex) = "" // Remove Config but retain trailing slash
		  
		  // Should now equal the "Saved" directory
		  Dim InitialPath As String = Components.Join("/")
		  Dim Engines(0) As Beacon.DiscoveryEngine
		  Engines(0) = New Beacon.FTPDiscoveryEngine(Self.mProfile, InitialPath, App.IdentityManager.CurrentIdentity)
		  Self.ShouldFinish(Engines)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BrowseCancelButton
	#tag Event
		Sub Pressed()
		  Self.ViewPanel.SelectedPanelIndex = Self.PageGeneral
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Browser
	#tag Event
		Sub NeedsChildrenForPath(Path As String)
		  Dim Fields As Dictionary = Self.FormDataFromProfile()
		  If Fields = Nil Then
		    Return
		  End If
		  Fields.Value("path") = Path
		  
		  // For now, append an empty list
		  Dim Empty() As String
		  Me.AppendChildren(Empty)
		  
		  Dim Request As New BeaconAPI.Request("ftp", "GET", Fields, WeakAddressOf APICallback_ListPath)
		  Request.Sign(App.IdentityManager.CurrentIdentity)
		  Self.BrowseSocket.Start(Request)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PathSelected(Path As String)
		  Self.BrowseActionButton.Enabled = Path.EndsWith("Game.ini")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerCancelButton
	#tag Event
		Sub Pressed()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerActionButton
	#tag Event
		Sub Pressed()
		  Self.mProfile = New Beacon.FTPServerProfile()
		  Self.mProfile.Host = Self.ServerHostField.Value
		  Self.mProfile.Port = Val(Self.ServerPortField.Value)
		  Self.mProfile.Username = Self.ServerUserField.Value
		  Self.mProfile.Password = Self.ServerPassField.Value
		  
		  Select Case Self.ServerModeMenu.SelectedRowIndex
		  Case 1
		    Self.mProfile.Mode = Beacon.FTPServerProfile.ModeFTP
		  Case 2
		    Self.mProfile.Mode = Beacon.FTPServerProfile.ModeFTPTLS
		  Case 3
		    Self.mProfile.Mode = Beacon.FTPServerProfile.ModeSFTP
		  Else
		    Self.mProfile.Mode = Beacon.FTPServerProfile.ModeAuto
		  End Select
		  
		  Self.ViewPanel.SelectedPanelIndex = Self.PageDiscovering
		  
		  Dim Fields As Dictionary = Self.FormDataFromProfile()
		  Dim Request As New BeaconAPI.Request("ftp/path", "GET", Fields, WeakAddressOf APICallback_DetectPath)
		  Request.Sign(App.IdentityManager.CurrentIdentity)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BrowseSocket
	#tag Event
		Sub WorkCompleted()
		  Self.Browser.Enabled = True
		  Self.BrowseSpinner.Visible = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub WorkStarted()
		  Self.Browser.Enabled = False
		  Self.BrowseSpinner.Visible = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
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
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
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
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType="Picture"
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
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="LockRight"
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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType="String"
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
		EditorType="Boolean"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
