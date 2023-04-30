#tag DesktopWindow
Begin ArkDiscoveryView ArkFTPDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   310
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
   Width           =   600
   Begin DesktopPagePanel ViewPanel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   310
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedLabel ServerModeLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         Text            =   "Mode:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   238
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedPopupMenu ServerModeMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         InitialValue    =   "Autodetect\nFTP\nFTP with TLS\nSFTP"
         Italic          =   False
         Left            =   158
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   238
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   142
      End
      Begin DesktopLabel ExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   38
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Beacon will securely send this information to the Beacon API server, which will perform the FTP work. The server will not store or log FTP information in any way."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopLabel ServerMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Server Settings"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedLabel ServerHostLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Host:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   102
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerHostField
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
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   102
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   422
      End
      Begin UITweaks.ResizedLabel ServerPortLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         Text            =   "Port:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   136
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerPortField
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
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "21"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   136
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   101
      End
      Begin UITweaks.ResizedLabel ServerUserLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         Text            =   "Username:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   170
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerUserField
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
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   170
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   422
      End
      Begin UITweaks.ResizedLabel ServerPassLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         Text            =   "Password:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   204
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerPassField
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
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   204
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   422
      End
      Begin DesktopLabel DiscoveringMessage
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   129
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopProgressBar DiscoveringProgress
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         Tooltip         =   ""
         Top             =   161
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopLabel BrowseMessage
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton BrowseActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton BrowseCancelButton
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
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ColumnBrowser Browser
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         CurrentPath     =   ""
         Enabled         =   True
         HasBackgroundColor=   False
         Height          =   204
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   21
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   53
         Transparent     =   True
         Visible         =   True
         Width           =   558
      End
      Begin DesktopProgressWheel BrowseSpinner
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   3
         Tooltip         =   ""
         Top             =   274
         Transparent     =   False
         Visible         =   False
         Width           =   16
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin UITweaks.ResizedPushButton ServerCancelButton
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
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ServerActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   14
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   0
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   52
         Transparent     =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   1
         Index           =   1
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   257
         Transparent     =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   204
         Index           =   2
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   53
         Transparent     =   True
         Visible         =   True
         Width           =   1
      End
      Begin FadedSeparator BrowseBorders
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         Enabled         =   True
         Height          =   204
         Index           =   3
         InitialParent   =   "ViewPanel"
         Left            =   579
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   53
         Transparent     =   True
         Visible         =   True
         Width           =   1
      End
      Begin DesktopCheckBox VerifyCertificateCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Verify Certificate (TLS Only)"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   312
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   238
         Transparent     =   False
         Underline       =   False
         Value           =   True
         Visible         =   True
         VisualState     =   0
         Width           =   268
      End
   End
   Begin Timer StatusWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   50
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin ClipboardWatcher URLWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 310
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Open
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckHostForPort()
		  Var Checker As New Regex
		  Checker.SearchPattern = ":(\d{1,5})$"
		  Checker.ReplacementPattern = ""
		  
		  Var CheckedValue As String = Self.ServerHostField.Text.Trim
		  
		  Var Matches As RegexMatch = Checker.Search(CheckedValue)
		  If Matches Is Nil Then
		    If Self.ServerHostField.Text <> CheckedValue Then
		      Self.ServerHostField.Text = CheckedValue
		    End If
		    Return
		  End If
		  
		  Self.ServerHostField.Text = CheckedValue.Left(CheckedValue.Length - Matches.SubExpressionString(0).Length)
		  Self.ServerPortField.Text = Matches.SubExpressionString(1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckServerActionButton()
		  Var Enabled As Boolean = Self.ServerHostField.Text.Length > 0 And Val(Self.ServerPortField.Text) > 0 And Self.ServerUserField.Text.Length > 0 And Self.ServerPassField.Text.Length > 0
		  If Self.ServerActionButton.Enabled <> Enabled Then
		    Self.ServerActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mEngine_Discovered(Sender As Ark.FTPIntegrationEngine, Data() As Beacon.DiscoveredData)
		  #Pragma Unused Sender
		  
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  Self.ShouldFinish(Data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mEngine_FileListError(Sender As Ark.FTPIntegrationEngine, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  Self.Browser.Enabled = True
		  Self.BrowseSpinner.Visible = False
		  
		  Var Reason As String
		  // https://tracker.xojo.com/xojoinc/xojo/-/issues/72314
		  #if TargetMacOS And TargetX86 And XojoVersion < 2023.020
		    Reason = "Unhandled Exception"
		  #else
		    If Err.Message.IsEmpty Then
		      Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		      Reason = "Unhandled " + Info.FullName
		    Else
		      Reason = Err.Message
		    End If
		  #endif
		  
		  Self.ShowAlert("Beacon was unable to retrieve the file list.", Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mEngine_FilesListed(Sender As Ark.FTPIntegrationEngine, Path As String, Files() As Beacon.FTPFileListing)
		  #Pragma Unused Sender
		  #Pragma Unused Path
		  
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  Self.Browser.Enabled = True
		  Self.BrowseSpinner.Visible = False
		  
		  Var Children() As String
		  For Each File As Beacon.FTPFileListing In Files
		    If File.Filename = "." Or File.Filename = ".." Then
		      Continue
		    End If
		    
		    Var Child As String = File.Filename
		    If File.IsDirectory Then
		      Child = Child + "/"
		    End If
		    Children.Add(Child)
		  Next
		  Self.Browser.AppendChildren(Children)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mEngine_Wait(Sender As Ark.FTPIntegrationEngine, Controller As Beacon.TaskWaitController) As Boolean
		  #Pragma Unused Sender
		  
		  Select Case Controller.Action
		  Case "Locate Game.ini"
		    // Beacon could not find anything, so we need to show a file browser
		    Self.mActiveController = Controller
		    Self.mBrowserRoot = Dictionary(Controller.UserData).Value("Root")
		    Self.ViewPanel.SelectedPanelIndex = Self.PageBrowse
		    Self.Browser.Reset()
		    Return True
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mActiveController As Beacon.TaskWaitController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBrowserRoot As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngine As Ark.FTPIntegrationEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Ark.FTPServerProfile
	#tag EndProperty


	#tag Constant, Name = PageBrowse, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDiscovering, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageGeneral, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ViewPanel
	#tag Event
		Sub PanelChanged()
		  If Me.SelectedPanelIndex = Self.PageDiscovering Then
		    Self.StatusWatcher.RunMode = Timer.RunModes.Multiple
		  Else
		    Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerModeMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  Self.VerifyCertificateCheck.Visible = Me.SelectedRowIndex = 0 Or Me.SelectedRowIndex = 2
		  Self.VerifyCertificateCheck.Caption = If(Me.SelectedRowIndex = 0, "Verify Certificate (TLS Only)", "Verify Certificate")
		  
		  Self.CheckServerActionButton
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerHostField
	#tag Event
		Sub TextChanged()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
	#tag Event
		Sub FocusLost()
		  Self.CheckHostForPort()
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
		  Var GameIniPath As String = Self.Browser.CurrentPath
		  Var Components() As String = GameIniPath.Split("/")
		  If Components.LastIndex <= 2 Then
		    Self.ShowAlert("FTP Access Too Restrictive", "Beacon needs to be able to access this server's ""Logs"" folder too, to learn more about the server than the config files can provide. The path to this server's Game.ini does not allow access to other directories needed within Ark's ""Saved"" directory.")
		    Return
		  End If
		  Components.RemoveAt(Components.LastIndex) // Remove Game.ini
		  Components.RemoveAt(Components.LastIndex) // Remove WindowsServer
		  Components.RemoveAt(Components.LastIndex) // Remove Config
		  
		  // Should now equal the "Saved" directory
		  Dictionary(Self.mActiveController.UserData).Value("path") = Components.Join("/")
		  Self.mActiveController.Cancelled = False
		  Self.mActiveController.ShouldResume = True
		  
		  Self.ViewPanel.SelectedPanelIndex = Self.PageDiscovering
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
		  If Self.mEngine = Nil Then
		    Return
		  End If
		  
		  Self.Browser.Enabled = False
		  Self.BrowseSpinner.Visible = True
		  
		  Var Empty() As String
		  Me.AppendChildren(Empty)
		  
		  Self.mEngine.ListFiles(Path)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PathSelected(Path As String)
		  Self.BrowseActionButton.Enabled = Path.EndsWith(Ark.ConfigFileGame)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerCancelButton
	#tag Event
		Sub Pressed()
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerActionButton
	#tag Event
		Sub Pressed()
		  Self.CheckHostForPort()
		  
		  Self.mProfile = New Ark.FTPServerProfile()
		  Self.mProfile.Host = Self.ServerHostField.Text
		  Self.mProfile.Port = CDbl(Self.ServerPortField.Text)
		  Self.mProfile.Username = Self.ServerUserField.Text
		  Self.mProfile.Password = Self.ServerPassField.Text
		  Self.mProfile.VerifyHost = Self.VerifyCertificateCheck.Value
		  
		  Select Case Self.ServerModeMenu.SelectedRowIndex
		  Case 1
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeFTP
		  Case 2
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeFTPTLS
		  Case 3
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeSFTP
		  Else
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeAuto
		  End Select
		  
		  Self.ViewPanel.SelectedPanelIndex = Self.PageDiscovering
		  
		  Self.mEngine = New Ark.FTPIntegrationEngine(Self.mProfile)
		  Self.mEngine.VerifyHost = Self.VerifyCertificateCheck.Value
		  AddHandler mEngine.Wait, WeakAddressOf mEngine_Wait
		  AddHandler mEngine.Discovered, WeakAddressOf mEngine_Discovered
		  AddHandler mEngine.FilesListed, WeakAddressOf mEngine_FilesListed
		  AddHandler mEngine.FileListError, WeakAddressOf mEngine_FileListError
		  Self.mEngine.BeginDiscovery(Self.Project)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StatusWatcher
	#tag Event
		Sub Action()
		  If Self.ViewPanel.SelectedPanelIndex = Self.PageDiscovering And Self.mEngine <> Nil Then
		    If Self.mEngine.Errored And Self.mEngine.Finished Then
		      Me.RunMode = Timer.RunModes.Off
		      
		      Var ErrorMessage As String = Self.mEngine.Logs(True)
		      Self.ShowAlert("There was a problem connecting to the FTP server", ErrorMessage)
		      Self.ViewPanel.SelectedPanelIndex = Self.PageGeneral
		    Else
		      Self.DiscoveringMessage.Text = Self.mEngine.Logs(True)
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events URLWatcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  Var Matcher As New Regex
		  Matcher.SearchPattern = "^((ftp|ftps|sftp)://)?(([^@:\s]+):([^@:\s]+)@)?([^/:\s]+\.[^/:\s]+)(:(\d{1,5}))?"
		  
		  Var Matches As RegexMatch = Matcher.Search(Content)
		  If Matches Is Nil Then
		    Return
		  End If
		  
		  Var Protocol As String = If(Matches.SubExpressionCount >= 2, DecodeURLComponent(Matches.SubExpressionString(2)), "")
		  Var Username As String = If(Matches.SubExpressionCount >= 4, DecodeURLComponent(Matches.SubExpressionString(4)), "")
		  Var Password As String = If(Matches.SubExpressionCount >= 5, DecodeURLComponent(Matches.SubExpressionString(5)), "")
		  Var Host As String = If(Matches.SubExpressionCount >= 6, DecodeURLComponent(Matches.SubExpressionString(6)), "")
		  Var Port As String = If(Matches.SubExpressionCount >= 8, DecodeURLComponent(Matches.SubExpressionString(8)), "")
		  
		  Select Case Protocol
		  Case "ftp"
		    Self.ServerModeMenu.SelectedRowIndex = 1
		    If Port.IsEmpty Then
		      Port = "21"
		    End If
		  Case "ftps"
		    Self.ServerModeMenu.SelectedRowIndex = 2
		    If Port.IsEmpty Then
		      Port = "21"
		    End If
		  Case "sftp"
		    Self.ServerModeMenu.SelectedRowIndex = 3
		    If Port.IsEmpty Then
		      Port = "22"
		    End If
		  Else
		    Self.ServerModeMenu.SelectedRowIndex = 0
		  End Select
		  
		  If Host.IsEmpty = False Then
		    Self.ServerHostField.Text = Host
		  End If
		  If Port.IsEmpty = False Then
		    Self.ServerPortField.Text = Port
		  End If
		  If Username.IsEmpty = False Then
		    Self.ServerUserField.Text = Username
		  End If
		  If Password.IsEmpty = False Then
		    Self.ServerPassField.Text = Password
		  End If
		  
		  Exception Err As RuntimeException
		    Return
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
