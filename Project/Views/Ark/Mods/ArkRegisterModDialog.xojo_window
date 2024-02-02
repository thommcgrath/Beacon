#tag DesktopWindow
Begin BeaconDialog ArkRegisterModDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   252
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   252
   MaximizeButton  =   False
   MaxWidth        =   520
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   252
   MinimizeButton  =   False
   MinWidth        =   520
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Register Mod"
   Visible         =   True
   Width           =   520
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   252
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   520
      Begin UITweaks.ResizedPushButton IntroActionButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   420
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   142
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton IntroCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   328
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   142
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel DetailMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         Text            =   "Register Mod"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin DesktopProgressWheel DetailSpinner
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   2
         Tooltip         =   ""
         Top             =   214
         Transparent     =   False
         Visible         =   False
         Width           =   16
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin UITweaks.ResizedPushButton DetailCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   328
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton DetailActionButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   420
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField DetailModIDField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
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
         TabPanelIndex   =   2
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
         Width           =   480
      End
      Begin DesktopLabel DetailExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   106
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "You can register your mod with Beacon so your engrams and creatures can be available to all Beacon users. You'll even be given a page on Beacon's website with your engram spawn codes and other blueprint details. To get started, enter the Steam workshop id or the url to your mod. You will be given a code to temporarily add to your mod's Steam page so your ownership of the mod can be confirmed."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin UITweaks.ResizedPushButton ConfirmCancelButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   True
         Caption         =   "Later"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   328
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ConfirmActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Check"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   420
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
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel ConfirmMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Confirm Ownership of Your Mod"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin DesktopLabel ConfirmExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   74
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "To confirm ownership of your mod, please copy the value below and insert it anywhere on the mod's Steam page. Then press the ""Check"" button below. Once confirmed, the text can be removed from your Steam page. If you are unable to do this right now, you can cancel now and return to this later."
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin UITweaks.ResizedTextField ConfirmCodeField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   138
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   388
      End
      Begin DesktopProgressWheel ConfirmSpinner
         Active          =   False
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   16
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   3
         Tooltip         =   ""
         Top             =   214
         Transparent     =   False
         Visible         =   False
         Width           =   16
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin ReactionButton ConfirmCopyButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Copy"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   420
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   139
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel NameMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Set Mod Name"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin DesktopLabel NameExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   17
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "#NameExplanationRemote"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin UITweaks.ResizedTextField NameInputField
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
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
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   92
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   480
      End
      Begin UITweaks.ResizedPushButton NameActionButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   420
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   168
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton NameCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   328
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   168
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopCheckBox NameShowInstructionsCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Show me instructions when finished"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         TabIndex        =   6
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   168
         Transparent     =   False
         Underline       =   False
         Value           =   True
         Visible         =   True
         VisualState     =   0
         Width           =   296
      End
      Begin DesktopLabel IntroMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         Text            =   "#IntroMessageLocal"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin DesktopLabel IntroExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   36
         Index           =   -2147483648
         InitialParent   =   "Pages"
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
         Text            =   "#IntroExplanationLocal"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   480
      End
      Begin UITweaks.ResizedPushButton IntroSkipButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Skip"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   142
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedTextField IntroIdField
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
         Hint            =   "Mod Id Or Link"
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   100
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   480
      End
   End
   Begin BeaconAPI.Socket RegisterSocket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin BeaconAPI.Socket ConfirmSocket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Thread RegisterModThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Var Pic As New Picture(10, 10)
		  Pic.Graphics.FontName = Self.IntroExplanationLabel.FontName
		  Pic.Graphics.FontUnit = Self.IntroExplanationLabel.FontUnit
		  Pic.Graphics.FontSize = Self.IntroExplanationLabel.FontSize
		  
		  Const LabelPadding = 4
		  
		  If Self.mMode = Self.ModeLocal Then
		    Self.IntroMessageLabel.Text = Self.IntroMessageLocal
		    Self.IntroExplanationLabel.Text = Self.IntroExplanationLocal
		    Self.NameExplanationLabel.Text = Self.NameExplanationLocal
		    Self.IntroSkipButton.Visible = True
		  Else
		    Self.IntroMessageLabel.Text = Self.IntroMessageRemote
		    Self.IntroExplanationLabel.Text = Self.IntroExplanationRemote
		    Self.NameExplanationLabel.Text = Self.NameExplanationRemote
		    Self.IntroSkipButton.Visible = False
		  End If
		  Self.IntroExplanationLabel.Height = Ceiling(Pic.Graphics.TextHeight(Self.IntroExplanationLabel.Text, Self.IntroExplanationLabel.Width)) + LabelPadding
		  Self.IntroIdField.Top = Self.IntroExplanationLabel.Bottom + 12
		  Self.IntroSkipButton.Top = Self.IntroIdField.Bottom + 20
		  Self.IntroCancelButton.Top = Self.IntroSkipButton.Top
		  Self.IntroActionButton.Top = Self.IntroCancelButton.Top
		  Self.HeightIntro = Self.IntroActionButton.Bottom + 20
		  
		  Self.NameExplanationLabel.Height = Ceiling(Pic.Graphics.TextHeight(Self.NameExplanationLabel.Text, Self.NameExplanationLabel.Width)) + LabelPadding
		  Self.NameInputField.Top = Self.NameExplanationLabel.Bottom + 12
		  Self.NameActionButton.Top = Self.NameInputField.Bottom + 20
		  Self.NameCancelButton.Top = Self.NameActionButton.Top
		  Self.NameShowInstructionsCheck.Top = Self.NameActionButton.Top
		  Self.HeightName = Self.NameActionButton.Bottom + 20
		  
		  If (Self.mModInfo Is Nil) = False Then
		    Self.ShowConfirmation()
		  Else
		    Self.MinimumHeight = Self.HeightIntro
		    Self.Height = Self.HeightIntro
		    Self.MaximumHeight = Self.HeightIntro
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_CheckModDiscovered(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Response.Success Then
		    Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm("Data for this mod is available online.", "Other Beacon users have already used the Mod Discovery feature on this mod. Would you like to downloda their results or continue adding the mod?", "Download", "Cancel", "Add Anway")
		    Select Case Choice
		    Case BeaconUI.ConfirmResponses.Action
		      Var DownloadRequest As New BeaconAPI.Request(Request.URL, "GET", WeakAddressOf APICallback_DownloadDiscoveryResults)
		      BeaconAPI.Send(DownloadRequest)
		      Return
		    Case BeaconUI.ConfirmResponses.Cancel
		      Self.IntroActionButton.Enabled = Self.mSteamId.IsEmpty = False
		      Self.IntroSkipButton.Enabled = True
		      Self.IntroIdField.Enabled = True
		      Return
		    End Select
		  End If
		  
		  Self.GetSteamPage()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ConfirmMod(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.Success Then
		    Self.mModInfo.Constructor(Dictionary(Response.JSON))
		    Self.ShowConfirmation()
		    If Self.mModInfo.Confirmed Then
		      Self.ShowAlert("Mod ownership confirmed.", "You may now remove the confirmation code from your Steam page.")
		      Self.mModId = Self.mModInfo.ContentPackId
		      Self.Hide
		      Return
		    Else
		      Self.ShowAlert("Mod ownership has not been confirmed.", "The confirmation code was not found on mod's Steam page.")
		    End If
		  Else
		    Self.ShowAlert("Mod ownership has not been confirmed.", Response.Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DownloadDiscoveryResults(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Not Response.Success Then
		    Self.ShowAlert("Failed to download discovery results.", "The process will continue as if discovery results were not found.")
		    Self.GetSteamPage()
		    Return
		  End If
		  
		  DataUpdater.Import(Response.Content)
		  Self.mModId = ""
		  Self.Hide
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_RegisterMod(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.Success And Response.JSONParsed Then
		    Try
		      Var Mods() As Dictionary = Response.JSON.DictionaryArrayValue
		      If Mods.Count = 1 Then
		        Self.mModInfo = New BeaconAPI.ContentPack(Mods(0))
		        Self.ShowConfirmation()
		        Return
		      End If
		    Catch Err As RuntimeException
		    End Try
		    
		    Self.Hide
		    
		    Return
		  End If
		  
		  Self.ShowAlert("Mod was not registered", Response.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(ModInfo As BeaconAPI.ContentPack, Mode As Integer)
		  Self.mModInfo = ModInfo
		  Self.mMode = Mode
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetSteamPage()
		  Var Socket As New URLConnection
		  Socket.RequestHeader("User-Agent") = App.UserAgent
		  AddHandler Socket.Error, WeakAddressOf mSteamLookupSocket_Error
		  AddHandler Socket.ContentReceived, WeakAddressOf mSteamLookupSocket_ContentReceived
		  Socket.Send("GET", "https://steamcommunity.com/sharedfiles/filedetails/?id=" + Self.mSteamId)
		  Self.mSteamLookupSocket = Socket
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSteamLookupSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused Url
		  #Pragma Unused HttpStatus
		  
		  Var Extractor As New RegEx
		  Extractor.SearchPattern = "<div class=""workshopItemTitle"">(.+)</div>"
		  Extractor.Options.Greedy = False
		  
		  Var Matches As RegExMatch = Extractor.Search(Content)
		  Var ModName As String
		  If (Matches Is Nil) = False Then
		    ModName = DecodingFromHTMLMBS(Matches.SubExpressionString(1))
		  End If
		  
		  Self.ShowNamePage(ModName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSteamLookupSocket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  #Pragma Unused Err
		  
		  Self.IntroActionButton.Enabled = Self.mSteamId.IsEmpty = False
		  Self.IntroSkipButton.Enabled = True
		  Self.IntroIdField.Enabled = True
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, ModInfo As BeaconAPI.ContentPack) As Boolean
		  If (Parent Is Nil) = False Then
		    Parent = Parent.TrueWindow
		  End If
		  
		  Var Mode As Integer = If(ModInfo.IsLocal, ModeLocal, ModeRemote)
		  Var Win As New ArkRegisterModDialog(ModInfo, Mode)
		  Win.SwapButtons()
		  Win.ShowModal(Parent)
		  Var ModId As String = Win.mModId
		  Win.Close
		  Return ModId.IsEmpty = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Mode As Integer) As String
		  If (Parent Is Nil) = False Then
		    Parent = Parent.TrueWindow
		  End If
		  
		  Var Win As New ArkRegisterModDialog(Nil, Mode)
		  Win.SwapButtons()
		  Win.ShowModal(Parent)
		  Var ModId As String = Win.mModId
		  Win.Close
		  Return ModId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowConfirmation()
		  If Self.mModInfo Is Nil Then
		    Self.Hide
		    Return
		  End If
		  
		  Self.ConfirmMessageLabel.Text = "Confirm Ownership of " + Self.mModInfo.Name
		  Self.ConfirmCodeField.Text = Self.mModInfo.ConfirmationCode
		  
		  Self.Pages.SelectedPanelIndex = Self.PageConfirm
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowNamePage(PrefilledName As String = "")
		  Self.NameInputField.Text = PrefilledName
		  Self.Pages.SelectedPanelIndex = Self.PageName
		  
		  If Self.mMode = Self.ModeLocal Then
		    Self.NameActionButton.Caption = "OK"
		  Else
		    Self.NameActionButton.Caption = "Next"
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private HeightIntro As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private HeightName As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModInfo As BeaconAPI.ContentPack
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSteamId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSteamLookupSocket As URLConnection
	#tag EndProperty


	#tag Constant, Name = FlagModIsConfirmed, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagShouldRefresh, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HeightConfirm, Type = Double, Dynamic = False, Default = \"220", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightDetail, Type = Double, Dynamic = False, Default = \"252", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IntroExplanationLocal, Type = String, Dynamic = False, Default = \"Start by entering the id or link to the mod. You may skip this step\x2C but Beacon can better support this mod if you don\'t.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IntroExplanationRemote, Type = String, Dynamic = False, Default = \"Start by entering the id or link to your mod.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IntroMessageLocal, Type = String, Dynamic = False, Default = \"Add Mod", Scope = Private
	#tag EndConstant

	#tag Constant, Name = IntroMessageRemote, Type = String, Dynamic = False, Default = \"Register Mod", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ModeLocal, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeRemote, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NameExplanationLocal, Type = String, Dynamic = False, Default = \"This is for organization only and will stay synced with your Beacon account.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NameExplanationRemote, Type = String, Dynamic = False, Default = \"This is the name as it will appear to other users in Beacon and the Beacon website.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageConfirm, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDetail, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageIntro, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageName, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Var TargetHeight As Integer
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageIntro
		    TargetHeight = Self.HeightIntro
		  Case Self.PageDetail
		    TargetHeight = Self.HeightDetail
		    Self.DetailModIDField.SetFocus()
		  Case Self.PageConfirm
		    TargetHeight = Self.HeightConfirm
		    Self.ConfirmCodeField.SetFocus()
		  Case Self.PageName
		    TargetHeight = Self.HeightName
		    Self.NameInputField.SetFocus()
		  End Select
		  
		  Self.MinimumHeight = TargetHeight
		  Self.Height = TargetHeight
		  Self.MaximumHeight = TargetHeight
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroActionButton
	#tag Event
		Sub Pressed()
		  If Self.mMode = Self.ModeLocal Then
		    Self.mModId = Beacon.ContentPack.GenerateLocalContentPackId(Beacon.MarketplaceSteamWorkshop, Self.mSteamId)
		    Var ContentPack As Beacon.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPackWithId(Self.mModId)
		    If (ContentPack Is Nil) = False Then
		      Self.ShowAlert("You have already added this mod.", "It is not possible to add the same mod more than once.")
		      Return
		    End If
		    
		    If Preferences.OnlineEnabled = False Then
		      // Go to next step
		      Self.ShowNamePage()
		      Return
		    End If
		    
		    // See if this mod has been discovered already
		    Var Request As New BeaconAPI.Request("/discovery/" + Self.mModId, "HEAD", WeakAddressOf APICallback_CheckModDiscovered)
		    BeaconAPI.Send(Request)
		  Else
		    If Preferences.OnlineEnabled = False Then
		      // Go to next step
		      Self.ShowNamePage()
		      Return
		    End If
		    
		    Self.GetSteamPage()
		  End If
		  
		  Me.Enabled = False
		  Self.IntroSkipButton.Enabled = False
		  Self.IntroIdField.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroCancelButton
	#tag Event
		Sub Pressed()
		  Self.mModId = ""
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DetailCancelButton
	#tag Event
		Sub Pressed()
		  Self.Pages.SelectedPanelIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DetailActionButton
	#tag Event
		Sub Pressed()
		  Var ModID As String = Self.DetailModIDField.Text.Trim
		  If ModID.Left(4) = "http" Then
		    Var Regex As New Regex
		    Regex.SearchPattern = "id=(\d+)"
		    
		    Var Matches As RegexMatch = Regex.Search(ModID)
		    If Matches = Nil Then
		      MessageBox("This url does not appear to be a steam workshop url")
		      Return
		    End If
		    
		    ModID = Matches.SubExpressionString(1)
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("gameId") = Ark.Identifier
		  Dict.Value("marketplace") = Beacon.MarketplaceSteam
		  Dict.Value("marketplaceId") = ModID
		  Var Payload As String = Beacon.GenerateJSON(Dict, False)
		  
		  Var Request As New BeaconAPI.Request("/contentPacks", "POST", Payload, "application/json", AddressOf APICallback_RegisterMod)
		  Self.RegisterSocket.Start(Request)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DetailModIDField
	#tag Event
		Sub TextChanged()
		  Self.DetailActionButton.Enabled = Me.Text.Trim <> ""
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmCancelButton
	#tag Event
		Sub Pressed()
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmActionButton
	#tag Event
		Sub Pressed()
		  Var Request As New BeaconAPI.Request("/contentPacks/" + Self.mModInfo.ContentPackId + "/confirm", "GET", AddressOf APICallback_ConfirmMod)
		  Self.ConfirmSocket.Start(Request)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmCopyButton
	#tag Event
		Sub Pressed()
		  Var C As New Clipboard
		  C.Text = Self.ConfirmCodeField.Text
		  
		  Me.Caption = "Copied!"
		  Me.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameActionButton
	#tag Event
		Sub Pressed()
		  Var ModName As String = Self.NameInputField.Text.Trim
		  If ModName.IsEmpty Then
		    Self.ShowAlert("Your mod should have a name", "It doesn't really make sense not to have one, does it?")
		    Return
		  End If
		  
		  Self.mModName = ModName
		  
		  Self.RegisterModThread.Start
		  
		  Self.NameActionButton.Enabled = False
		  Self.NameCancelButton.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameCancelButton
	#tag Event
		Sub Pressed()
		  Self.Pages.SelectedPanelIndex = 0
		  Self.IntroIdField.Enabled = True
		  Self.IntroActionButton.Enabled = (Self.mSteamId.IsEmpty = False)
		  Self.IntroSkipButton.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroSkipButton
	#tag Event
		Sub Pressed()
		  Self.ShowNamePage("")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroIdField
	#tag Event
		Sub TextChanged()
		  Var Validator As New RegEx
		  Validator.SearchPattern = "^((https?://)?steamcommunity.com/sharedfiles/filedetails/\?id=)?(\d+)"
		  
		  Var Matches As RegExMatch = Validator.Search(Me.Text)
		  If Matches Is Nil Then
		    Self.IntroActionButton.Enabled = False
		    Return
		  End If
		  
		  Self.mSteamId = Matches.SubExpressionString(3)
		  Self.IntroActionButton.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RegisterSocket
	#tag Event
		Sub WorkStarted()
		  Self.DetailSpinner.Visible = True
		  Self.DetailActionButton.Enabled = False
		  Self.DetailModIDField.Enabled = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub WorkCompleted()
		  Self.DetailSpinner.Visible = False
		  Self.DetailActionButton.Enabled = True
		  Self.DetailModIDField.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfirmSocket
	#tag Event
		Sub WorkCompleted()
		  Self.ConfirmSpinner.Visible = False
		  Self.ConfirmActionButton.Enabled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub WorkStarted()
		  Self.ConfirmSpinner.Visible = True
		  Self.ConfirmActionButton.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RegisterModThread
	#tag Event
		Sub Run()
		  Var ModId As String
		  Var ModInfo As BeaconAPI.ContentPack
		  If Self.mMode = Self.ModeLocal Then
		    Var Database As Ark.DataSource = Ark.DataSource.Pool.Get(True)
		    Var ContentPack As Beacon.ContentPack = Database.CreateLocalContentPack(Self.mModName, Self.mSteamId, True)
		    ModId = ContentPack.ContentPackId
		    ModInfo = New BeaconAPI.ContentPack(ContentPack)
		  Else
		    ModId = Beacon.UUID.v4
		    Var PackData As New Dictionary
		    PackData.Value("contentPackId") = ModId
		    PackData.Value("name") = Self.mModName
		    PackData.Value("marketplace") = Beacon.MarketplaceSteamWorkshop
		    PackData.Value("marketplaceId") = Self.mSteamId
		    PackData.Value("gameId") = Ark.Identifier
		    
		    Var Request As New BeaconAPI.Request("contentPacks", "POST", Beacon.GenerateJSON(PackData, False), "application/json")
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    If Not Response.Success Then
		      Var Reason As String = Response.Message
		      If Reason.IsEmpty Then
		        Reason = "Unknown API error"
		      End If
		      Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": False, "Reason": Response.Message))
		      Return
		    End If
		    
		    Try
		      Var Parsed As New JSONItem(Response.Content)
		      Var Lists() As JsonItem
		      If Parsed.HasKey("created") Then
		        Lists.Add(Parsed.Child("created"))
		      End If
		      If Parsed.HasKey("updated") Then
		        Lists.Add(Parsed.Child("updated"))
		      End If
		      
		      For Each List As JsonItem In Lists
		        If List.IsArray = False Then
		          Continue
		        End If
		        
		        Var Bound As Integer = List.LastRowIndex
		        For Idx As Integer = 0 To Bound
		          Var Child As JsonItem = List.ChildAt(Idx)
		          If Child.Lookup("contentPackId", "") = ModId Then
		            ModInfo = New BeaconAPI.ContentPack(Child)
		            Exit For List
		          End If
		        Next
		      Next
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Handling mod creation response")
		    End Try
		  End If
		  
		  Me.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Success": True, "ModId": ModId, "ModInfo": ModInfo))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Dict As Dictionary In Data
		    Var Finished As Boolean = Dict.Lookup("Finished", False)
		    If Finished Then
		      Var Success As Boolean = Dict.Lookup("Success", False)
		      If Success Then
		        If Self.NameShowInstructionsCheck.Value Then
		          System.GotoURL(Beacon.WebURL("/help/adding_blueprints_to_beacon"))
		        End If
		        
		        Self.mModId = Dict.Lookup("ModId", "")
		        Self.mModInfo = Dict.Lookup("ModInfo", Nil)
		        If Self.mMode = Self.ModeLocal Then
		          Self.Hide
		        Else
		          Self.ShowConfirmation
		        End If
		      Else
		        Var ErrorReason As String = Dict.Lookup("Reason", "Unknown error")
		        Self.ShowAlert("There was an error adding the mod.", ErrorReason)
		        Self.NameActionButton.Enabled = True
		        Self.NameCancelButton.Enabled = True
		      End If
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
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
		Type="DesktopMenuBar"
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
