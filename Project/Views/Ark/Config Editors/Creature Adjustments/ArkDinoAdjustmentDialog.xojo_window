#tag DesktopWindow
Begin BeaconDialog ArkDinoAdjustmentDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   410
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   410
   MaximizeButton  =   False
   MaxWidth        =   626
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   410
   MinimizeButton  =   False
   MinWidth        =   626
   Placement       =   1
   Resizable       =   "False"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Edit Creature"
   Visible         =   True
   Width           =   626
   Begin DesktopLabel MessageLabel
      AllowAutoDeactivate=   True
      Bold            =   True
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
      Text            =   "Edit Creature"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   586
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   36
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "From here you can adjust creature damage and resistance multipliers, replace the creature with another, or disable the creature completely."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   586
   End
   Begin UITweaks.ResizedLabel TargetDinoLabel
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
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Creature:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin DesktopRadioButton ModeMultipliersRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Change Multipliers"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
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
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   140
   End
   Begin DesktopRadioButton ModeReplaceRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Replace Creature"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   304
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   140
   End
   Begin DesktopRadioButton ModeDisableRadio
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Disable Creature"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   456
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   140
   End
   Begin UITweaks.ResizedLabel ModeLabel
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
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Mode:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   132
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin DesktopPagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   136
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   158
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   626
      Begin UITweaks.ResizedTextField WildDamageField
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
         Left            =   152
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel WildDamageLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Wild Damage:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedTextField WildResistanceField
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
         Left            =   152
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   198
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel WildResistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Wild Resistance:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   198
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedLabel WildDamageHelp
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
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
         Text            =   "Greater than 1.0 increases wild creature damage"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedLabel WildResistanceHelp
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Less than 1.0 increases amount of damage taken"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   198
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedTextField TameDamageField
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
         Left            =   152
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   232
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel TameDamageLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Tame Damage:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   232
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedTextField TameResistanceField
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
         Left            =   152
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "1.0"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   266
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel TameResistanceLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
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
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Tame Resistance:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   266
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedLabel TameDamageHelp
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
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
         Text            =   "Greater than 1.0 increases tamed creature damage"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   232
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedLabel TameResistanceHelp
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   244
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Less than 1.0 increases amount of damage taken"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   266
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   362
      End
      Begin UITweaks.ResizedLabel ReplacementDinoLabel
         AllowAutoDeactivate=   True
         Bold            =   False
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Replacement:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin UITweaks.ResizedPushButton ChooseReplacementButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Choose…"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   152
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin UITweaks.ResizedLabel ReplacementDinoNameLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   True
         Left            =   250
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Not Selected"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   164
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   356
      End
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
      Left            =   526
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   370
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
      Left            =   434
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   370
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ChooseTargetButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   86
   End
   Begin UITweaks.ResizedLabel TargetDinoNameLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   250
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Not Selected"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   356
   End
   Begin DesktopCheckBox PreventTransferCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Prevent Transfer"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "When checked, the creature cannot be downloaded from an obelisk."
      Top             =   332
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   454
   End
   Begin DesktopCheckBox PreventTamingCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Prevent Taming"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   152
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "When checked, the creature cannot be tamed."
      Top             =   300
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   454
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		  
		  Var One As Double = 1.0
		  Var OneFormatted As String = One.ToString(Locale.Current, "0.0#####")
		  
		  Self.WildDamageField.Text = OneFormatted
		  Self.WildResistanceField.Text = OneFormatted
		  Self.TameDamageField.Text = OneFormatted
		  Self.TameResistanceField.Text = OneFormatted
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor(ConfiguredCreatures() As Ark.Creature, DisabledCreatures() As Ark.Creature, ContentPacks As Beacon.StringList)
		  Self.ConfiguredCreatures = ConfiguredCreatures
		  Self.DisabledCreatures = DisabledCreatures
		  Self.ContentPacks = ContentPacks
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, EditCreature As Ark.Creature, Config As Ark.Configs.DinoAdjustments, ContentPacks As Beacon.StringList) As Boolean
		  // This one needs the whole config because there are a lot of factors to showing the creatures in the menus
		  
		  If Parent Is Nil Or Config Is Nil Then
		    Return False
		  End If
		  
		  Var ConfiguredBehaviors() As Ark.CreatureBehavior = Config.Behaviors
		  Var ConfiguredCreatures(), DisabledCreatures() As Ark.Creature
		  For Each Behavior As Ark.CreatureBehavior In ConfiguredBehaviors
		    If Behavior.TargetCreature = EditCreature Then
		      Continue
		    End If
		    ConfiguredCreatures.Add(Behavior.TargetCreature)
		    If Behavior.ProhibitSpawning Then
		      DisabledCreatures.Add(Behavior.TargetCreature)
		    End If
		  Next
		  
		  Var Win As New ArkDinoAdjustmentDialog(ConfiguredCreatures, DisabledCreatures, ContentPacks)
		  If IsNull(EditCreature) = False Then
		    Win.SelectedCreature = EditCreature
		    
		    Var Behavior As Ark.CreatureBehavior = Config.Behavior(EditCreature)
		    If Behavior <> Nil Then
		      If Behavior.ProhibitSpawning Then
		        Win.ModeDisableRadio.Value = True
		      ElseIf Behavior.ReplacementCreature <> Nil Then
		        Win.SelectedReplacement = Behavior.ReplacementCreature
		        Win.ModeReplaceRadio.Value = True
		      Else
		        Win.WildDamageField.Text = Behavior.DamageMultiplier.ToString(Locale.Current, "0.0#####")
		        Win.WildResistanceField.Text = Behavior.ResistanceMultiplier.ToString(Locale.Current, "0.0#####")
		        Win.TameDamageField.Text = Behavior.TamedDamageMultiplier.ToString(Locale.Current, "0.0#####")
		        Win.TameResistanceField.Text = Behavior.TamedResistanceMultiplier.ToString(Locale.Current, "0.0#####")
		        Win.ModeMultipliersRadio.Value = True
		      End If
		      Win.PreventTamingCheck.Value = Behavior.ProhibitTaming
		      Win.PreventTransferCheck.Value = Behavior.ProhibitTransfer
		    End If
		  End If
		  Win.ShowModal(Parent)
		  If Win.Cancelled Then
		    Win.Close
		    Return False
		  End If
		  
		  Var TargetCreature As Ark.Creature = Win.SelectedCreature
		  Var Behavior As New Ark.MutableCreatureBehavior(TargetCreature)
		  If Win.ModeDisableRadio.Value Then
		    Behavior.ProhibitSpawning = True
		  ElseIf Win.ModeReplaceRadio.Value Then
		    Behavior.ReplacementCreature = Win.SelectedReplacement
		  Else
		    Behavior.DamageMultiplier = CDbl(Win.WildDamageField.Text)
		    Behavior.ResistanceMultiplier = CDbl(Win.WildResistanceField.Text)
		    Behavior.TamedDamageMultiplier = CDbl(Win.TameDamageField.Text)
		    Behavior.TamedResistanceMultiplier = CDbl(Win.TameResistanceField.Text)
		  End If
		  Behavior.ProhibitTaming = Win.PreventTamingCheck.Value
		  Behavior.ProhibitTransfer = Win.PreventTransferCheck.Value
		  
		  If IsNull(EditCreature) = False And TargetCreature <> EditCreature Then
		    Config.RemoveBehavior(EditCreature)
		  End If
		  Config.Behavior(TargetCreature) = Behavior
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Cancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ConfiguredCreatures() As Ark.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ContentPacks As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DisabledCreatures() As Ark.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedCreature As Ark.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedReplacement As Ark.Creature
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mSelectedCreature
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedCreature = Value Then
			    Return
			  End If
			  
			  Self.mSelectedCreature = Value
			  If IsNull(Self.mSelectedCreature) Then
			    Self.TargetDinoNameLabel.Italic = True
			    Self.TargetDinoNameLabel.Text = "No Selection"
			  Else
			    Self.TargetDinoNameLabel.Italic = False
			    Self.TargetDinoNameLabel.Text = Self.mSelectedCreature.Label
			  End If
			  
			  If Self.mSelectedReplacement = Self.mSelectedCreature Then
			    Self.SelectedReplacement = Nil
			  End If
			End Set
		#tag EndSetter
		Private SelectedCreature As Ark.Creature
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return Self.mSelectedReplacement
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedReplacement = Value Then
			    Return
			  End If
			  
			  Self.mSelectedReplacement = Value
			  If IsNull(Self.mSelectedReplacement) Then
			    Self.ReplacementDinoNameLabel.Italic = True
			    Self.ReplacementDinoNameLabel.Text = "No Selection"
			  Else
			    Self.ReplacementDinoNameLabel.Italic = False
			    Self.ReplacementDinoNameLabel.Text = Self.mSelectedReplacement.Label
			  End If
			End Set
		#tag EndSetter
		Private SelectedReplacement As Ark.Creature
	#tag EndComputedProperty


	#tag Constant, Name = HeightDisable, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightMultipliers, Type = Double, Dynamic = False, Default = \"136", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HeightReplace, Type = Double, Dynamic = False, Default = \"32", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDisable, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageMultipliers, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageReplace, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ModeMultipliersRadio
	#tag Event
		Sub ValueChanged()
		  If Me.Value Then
		    Self.Pages.SelectedPanelIndex = Self.PageMultipliers
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModeReplaceRadio
	#tag Event
		Sub ValueChanged()
		  If Me.Value Then
		    Self.Pages.SelectedPanelIndex = Self.PageReplace
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModeDisableRadio
	#tag Event
		Sub ValueChanged()
		  If Me.Value Then
		    Self.Pages.SelectedPanelIndex = Self.PageDisable
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pages
	#tag Event
		Sub PanelChanged()
		  Var OriginalHeight As Integer = Me.Height
		  Select Case Me.SelectedPanelIndex
		  Case Self.PageMultipliers
		    Me.Height = Self.HeightMultipliers
		  Case Self.PageReplace
		    Me.Height = Self.HeightReplace
		  Case Self.PageDisable
		    Me.Height = Self.HeightDisable
		  End Select
		  Var Delta As Integer = Me.Height - OriginalHeight
		  Self.Height = Self.Height + Delta
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseReplacementButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Creature
		  If Not IsNull(Self.SelectedCreature) Then
		    Exclude.Add(Self.SelectedCreature)
		  End If
		  For Each Creature As Ark.Creature In Self.DisabledCreatures
		    Exclude.Add(Creature)
		  Next
		  
		  Var Creatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If Creatures <> Nil And Creatures.LastIndex = 0 Then
		    Self.SelectedReplacement = Creatures(0)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If IsNull(Self.SelectedCreature) Then
		    Self.ShowAlert("You haven't selected a creature", "That's an important step, right?")
		    Return
		  End If
		  
		  Var PreventTransfer As Boolean = Self.PreventTransferCheck.Value
		  
		  If Self.ModeReplaceRadio.Value Then
		    If IsNull(Self.SelectedReplacement) Then
		      Self.ShowAlert("You haven't selected a replacement creature", "If you wan to replace the creature with nothing, choose the ""Disable Creature"" button.")
		      Return
		    End If
		  ElseIf Self.ModeMultipliersRadio.Value Then
		    Var DamageMultiplier As Double = CDbl(Self.WildDamageField.Text)
		    Var ResistanceMultiplier As Double = CDbl(Self.WildResistanceField.Text)
		    Var TamedDamageMultiplier As Double = CDbl(Self.TameDamageField.Text)
		    Var TamedResistanceMultiplier As Double = CDbl(Self.TameResistanceField.Text)
		    Var PreventTaming As Boolean = Self.PreventTamingCheck.Value
		    
		    If DamageMultiplier < 0 Or ResistanceMultiplier < 0 Or TamedDamageMultiplier < 0 Or TamedResistanceMultiplier < 0 Then
		      Self.ShowAlert("You have a multiplier that doesn't make sense", "It's ok to make the multipliers really small, but they must be at least zero.")
		      Return
		    End If
		    If DamageMultiplier = 1.0 And ResistanceMultiplier = 1.0 And TamedDamageMultiplier = 1.0 And TamedResistanceMultiplier = 1.0 And PreventTaming = False And PreventTransfer = False Then
		      Self.ShowAlert("You haven't changed any multipliers", "There's no reason to save a creature adjustment with no differences than official.")
		      Return
		    End If
		  End If
		  
		  Self.Cancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.Cancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChooseTargetButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Creature
		  For Each Creature As Ark.Creature In Self.ConfiguredCreatures
		    Exclude.Add(Creature)
		  Next
		  
		  Var Creatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.ContentPacks, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If Creatures <> Nil And Creatures.LastIndex = 0 Then
		    Self.SelectedCreature = Creatures(0)
		  End If
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
