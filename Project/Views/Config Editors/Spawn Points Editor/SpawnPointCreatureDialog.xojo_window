#tag Window
Begin BeaconDialog SpawnPointCreatureDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "1"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   486
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   486
   MaximumWidth    =   524
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   486
   MinimumWidth    =   524
   Resizeable      =   False
   Title           =   "Creature Entry"
   Type            =   "8"
   Visible         =   True
   Width           =   524
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
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Creature Entry"
      Visible         =   True
      Width           =   484
   End
   Begin UITweaks.ResizedPushButton CreatureChooseButton
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
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   86
   End
   Begin UITweaks.ResizedLabel CreatureLabel
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
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Value           =   "Creature:"
      Visible         =   True
      Width           =   128
   End
   Begin UITweaks.ResizedLabel CreatureNameLabel
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
      InitialParent   =   ""
      Italic          =   True
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   True
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Value           =   "Not Selected"
      Visible         =   True
      Width           =   246
   End
   Begin RangeField OffsetFields
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   0
      Italic          =   False
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   80
   End
   Begin RangeField OffsetFields
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   1
      Italic          =   False
      Left            =   252
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   80
   End
   Begin RangeField OffsetFields
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   2
      Italic          =   False
      Left            =   344
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
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel OffsetLabel
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
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Value           =   "Offset (X, Y, Z):"
      Visible         =   True
      Width           =   128
   End
   Begin RangeField SpawnChanceField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      DoubleValue     =   0.0
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
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "2"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   118
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Value           =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel SpawnChanceLabel
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "3"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   118
      Transparent     =   False
      Underline       =   False
      Value           =   "Weight:"
      Visible         =   True
      Width           =   128
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
      Left            =   424
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   446
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
      Left            =   332
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   446
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label OptionalLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   446
      Transparent     =   False
      Underline       =   False
      Value           =   "All fields optional"
      Visible         =   True
      Width           =   300
   End
   Begin GroupBox GroupBox1
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Wild Levels"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   274
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   332
      Begin Label Label1
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
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   254
         Transparent     =   False
         Underline       =   False
         Value           =   "Or"
         Visible         =   True
         Width           =   172
      End
      Begin UITweaks.ResizedLabel EffectiveLevelLabel
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
         InitialParent   =   "GroupBox1"
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
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   386
         Transparent     =   False
         Underline       =   False
         Value           =   "Level Range:"
         Visible         =   True
         Width           =   108
      End
      Begin Label EffectiveMaxLevelField
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
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   15
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   386
         Transparent     =   False
         Underline       =   False
         Value           =   "30"
         Visible         =   True
         Width           =   80
      End
      Begin Label EffectiveMinLevelField
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
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   14
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   386
         Transparent     =   False
         Underline       =   False
         Value           =   "1"
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel LevelMultiplierLabel
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
         InitialParent   =   "GroupBox1"
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
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Value           =   "Level Multiplier:"
         Visible         =   True
         Width           =   108
      End
      Begin UITweaks.ResizedLabel LevelOffsetLabel
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
         InitialParent   =   "GroupBox1"
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
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   286
         Transparent     =   False
         Underline       =   False
         Value           =   "Level Offset:"
         Visible         =   True
         Width           =   108
      End
      Begin UITweaks.ResizedLabel LevelRangeLabel
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
         InitialParent   =   "GroupBox1"
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
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "3"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   220
         Transparent     =   False
         Underline       =   False
         Value           =   "Override Range:"
         Visible         =   True
         Width           =   108
      End
      Begin RangeField LevelMultiplierMaxField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelMultiplierMinField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOffsetMaxField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   286
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOffsetMinField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
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
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   286
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOverrideMaxField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
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
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   220
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOverrideMinField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   220
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Value           =   ""
         Visible         =   True
         Width           =   80
      End
      Begin Label MaxLabel
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
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   188
         Transparent     =   False
         Underline       =   False
         Value           =   "Max"
         Visible         =   True
         Width           =   80
      End
      Begin Label MinLabel
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
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
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
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   188
         Transparent     =   False
         Underline       =   False
         Value           =   "Min"
         Visible         =   True
         Width           =   80
      End
      Begin Label Label2
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
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         TextAlignment   =   "2"
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   354
         Transparent     =   False
         Underline       =   False
         Value           =   "="
         Visible         =   True
         Width           =   172
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SwapButtons()
		  
		  If Self.mTargetCreature <> Nil Then
		    Self.CreatureNameLabel.Value = Self.mTargetCreature.Label
		    Self.CreatureNameLabel.Italic = False
		  ElseIf Self.mMultiEditMode Then
		    Var Names() As String
		    For Each Entry As Beacon.MutableSpawnPointSetEntry In Self.mEntries
		      Names.AddRow(Entry.Label)
		    Next
		    Names.Sort
		    Self.CreatureNameLabel.Value = Language.EnglishOxfordList(Names)
		  End If
		  
		  Var CommonOffset As Beacon.Point3D
		  Var CommonSpawnChance, CommonMinLevelMultiplier, CommonMaxLevelMultiplier, CommonMinLevelOffset, CommonMaxLevelOffset As NullableDouble
		  Var CommonLevelRange As Beacon.Range
		  
		  If Self.mEntries.LastRowIndex > -1 Then
		    CommonOffset = Self.mEntries(0).Offset
		    CommonSpawnChance = Self.mEntries(0).SpawnChance
		    CommonMinLevelMultiplier = Self.mEntries(0).MinLevelMultiplier
		    CommonMaxLevelMultiplier = Self.mEntries(0).MaxLevelMultiplier
		    CommonMinLevelOffset = Self.mEntries(0).MinLevelOffset
		    CommonMaxLevelOffset = Self.mEntries(0).MaxLevelOffset
		    If Self.mEntries(0).HasCustomLevelRange Then
		      CommonLevelRange = Self.mEntries(0).LevelRangeForDifficulty(Self.mDifficulty, Self.mOffsetBeforeMultiplier)
		    End If
		  End If
		  
		  If Self.mEntries.LastRowIndex > 0 Then
		    For I As Integer = 1 To Self.mEntries.LastRowIndex
		      If CommonOffset <> Nil And Self.mEntries(I).Offset <> CommonOffset Then
		        CommonOffset = Nil
		      End If
		      If CommonSpawnChance <> Nil And Self.mEntries(I).SpawnChance <> CommonSpawnChance Then
		        CommonSpawnChance = Nil
		      End If
		      If CommonMinLevelMultiplier <> Nil And Self.mEntries(I).MinLevelMultiplier <> CommonMinLevelMultiplier Then
		        CommonMinLevelMultiplier = Nil
		      End If
		      If CommonMaxLevelMultiplier <> Nil And Self.mEntries(I).MaxLevelMultiplier <> CommonMaxLevelMultiplier Then
		        CommonMaxLevelMultiplier = Nil
		      End If
		      If CommonMinLevelOffset <> Nil And Self.mEntries(I).MinLevelOffset <> CommonMinLevelOffset Then
		        CommonMinLevelOffset = Nil
		      End If
		      If CommonMaxLevelOffset <> Nil And Self.mEntries(I).MaxLevelOffset <> CommonMaxLevelOffset Then
		        CommonMaxLevelOffset = Nil
		      End If
		      If CommonLevelRange <> Nil And Self.mEntries(I).LevelRangeForDifficulty(Self.mDifficulty, Self.mOffsetBeforeMultiplier) <> CommonLevelRange Then
		        CommonLevelRange = Nil
		      End If
		    Next
		  End If
		  
		  If CommonOffset <> Nil Then
		    Self.OffsetFields(0).DoubleValue = CommonOffset.X
		    Self.OffsetFields(1).DoubleValue = CommonOffset.Y
		    Self.OffsetFields(2).DoubleValue = CommonOffset.Z
		  End If
		  If CommonSpawnChance <> Nil Then
		    Self.SpawnChanceField.DoubleValue = CommonSpawnChance
		  End If
		  If CommonMinLevelMultiplier <> Nil Then
		    Self.LevelMultiplierMinField.DoubleValue = CommonMinLevelMultiplier
		  End If
		  If CommonMaxLevelMultiplier <> Nil Then
		    Self.LevelMultiplierMaxField.DoubleValue = CommonMaxLevelMultiplier
		  End If
		  If CommonMinLevelOffset <> Nil Then
		    Self.LevelOffsetMinField.DoubleValue = CommonMinLevelOffset
		  End If
		  If CommonMaxLevelOffset <> Nil Then
		    Self.LevelOffsetMaxField.DoubleValue = CommonMaxLevelOffset
		  End If
		  If CommonLevelRange <> Nil Then 
		    Self.LevelOverrideMinField.DoubleValue = CommonLevelRange.Min
		    Self.LevelOverrideMaxField.DoubleValue = CommonLevelRange.Max
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Document As Beacon.Document, Entries() As Beacon.MutableSpawnPointSetEntry, OffsetBeforeMultiplier As Boolean)
		  Self.mSettingUp = True
		  
		  Self.mDifficulty = Document.DifficultyValue
		  Self.mMods = Document.Mods
		  Self.mEntries = Entries
		  Self.mMultiEditMode = Entries.LastRowIndex > 0
		  Self.mOffsetBeforeMultiplier = OffsetBeforeMultiplier
		  
		  If Entries.LastRowIndex > 0 Then
		    Self.mMultiEditMode = True
		    
		    Var CommonCreature As Beacon.Creature = Entries(0).Creature
		    For I As Integer = 1 To Entries.LastRowIndex
		      If Entries(I).Creature.Path <> CommonCreature.Path Then
		        CommonCreature = Nil
		        Exit For I
		      End If
		    Next
		    
		    Self.mTargetCreature = CommonCreature
		  ElseIf Entries.LastRowIndex = 0 Then
		    Self.mTargetCreature = Entries(0).Creature
		  End If
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateEntry() As Beacon.MutableSpawnPointSetEntry
		  Var Entry As New Beacon.MutableSpawnPointSetEntry(Self.mTargetCreature)
		  
		  If Self.LevelOverrideMinField.Value <> "" And Self.LevelOverrideMaxField.Value <> "" Then
		    Entry.Append(Beacon.SpawnPointLevel.FromUserLevel(Self.LevelOverrideMinField.DoubleValue, Self.LevelOverrideMaxField.DoubleValue, Self.mDifficulty))
		  End If
		  If Self.LevelMultiplierMinField.Value <> "" Then
		    Entry.MinLevelMultiplier = Self.LevelMultiplierMinField.DoubleValue
		  End If
		  If Self.LevelMultiplierMaxField.Value <> "" Then
		    Entry.MaxLevelMultiplier = Self.LevelMultiplierMaxField.DoubleValue
		  End If
		  If Self.LevelOffsetMinField.Value <> "" Then
		    Entry.MinLevelOffset = Self.LevelOffsetMinField.DoubleValue
		  End If
		  If Self.LevelOffsetMaxField.Value <> "" Then
		    Entry.MaxLevelOffset = Self.LevelOffsetMaxField.DoubleValue
		  End If
		  
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Document As Beacon.Document, Set As Beacon.SpawnPointSet, Entry As Beacon.MutableSpawnPointSetEntry = Nil) As Beacon.MutableSpawnPointSetEntry
		  Var Entries() As Beacon.MutableSpawnPointSetEntry
		  If Entry <> Nil Then
		    Entries.AddRow(Entry)
		  End If
		  
		  Var Results() As Beacon.MutableSpawnPointSetEntry = Present(Parent, Document, Set, Entries)
		  If Results = Nil Or Results.LastRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return Results(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Document As Beacon.Document, Set As Beacon.SpawnPointSet, Entries() As Beacon.MutableSpawnPointSetEntry) As Beacon.MutableSpawnPointSetEntry()
		  Var NewEntries() As Beacon.MutableSpawnPointSetEntry
		  
		  If Parent = Nil Then
		    Return NewEntries
		  End If
		  
		  Var Win As New SpawnPointCreatureDialog(Document, Entries, Set.LevelOffsetBeforeMultiplier)
		  Win.ShowModalWithin(Parent.TrueWindow)
		  If Win.mCancelled Then
		    Win.Close
		    Return NewEntries
		  End If
		  
		  NewEntries = Win.mEntries
		  
		  Win.Close
		  Return NewEntries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEffectiveLevel()
		  Var Entry As Beacon.MutableSpawnPointSetEntry = Self.CreateEntry
		  
		  If IsNumeric(Self.LevelOverrideMinField.Value) And IsNumeric(Self.LevelOverrideMaxField.Value) Then
		    Self.LevelOverrideMinField.Enabled = True
		    Self.LevelOverrideMaxField.Enabled = True
		    Self.LevelOffsetMinField.Enabled = False
		    Self.LevelOffsetMaxField.Enabled = False
		    Self.LevelMultiplierMinField.Enabled = False
		    Self.LevelMultiplierMaxField.Enabled = False
		  ElseIf (IsNumeric(Self.LevelOffsetMinField.Value) And IsNumeric(Self.LevelOffsetMaxField.Value)) Or (IsNumeric(Self.LevelMultiplierMinField.Value) And IsNumeric(Self.LevelMultiplierMaxField.Value)) Then
		    Self.LevelOverrideMinField.Enabled = False
		    Self.LevelOverrideMaxField.Enabled = False
		    Self.LevelOffsetMinField.Enabled = True
		    Self.LevelOffsetMaxField.Enabled = True
		    Self.LevelMultiplierMinField.Enabled = True
		    Self.LevelMultiplierMaxField.Enabled = True
		  Else
		    Self.LevelOverrideMinField.Enabled = True
		    Self.LevelOverrideMaxField.Enabled = True
		    Self.LevelOffsetMinField.Enabled = True
		    Self.LevelOffsetMaxField.Enabled = True
		    Self.LevelMultiplierMinField.Enabled = True
		    Self.LevelMultiplierMaxField.Enabled = True
		  End If
		  
		  Var Range As Beacon.Range = Entry.LevelRangeForDifficulty(Self.mDifficulty, Self.mOffsetBeforeMultiplier)
		  Self.EffectiveMinLevelField.Value = Range.Min.PrettyText
		  Self.EffectiveMaxLevelField.Value = Range.Max.PrettyText
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDifficulty As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditedFields() As RangeField
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEntries() As Beacon.MutableSpawnPointSetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMultiEditMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOffsetBeforeMultiplier As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetCreature As Beacon.Creature
	#tag EndProperty


#tag EndWindowCode

#tag Events CreatureChooseButton
	#tag Event
		Sub Action()
		  Var Exclude() As Beacon.Creature
		  Var Creatures() As Beacon.Creature = EngramSelectorDialog.Present(Self, "", Exclude, Self.mMods, EngramSelectorDialog.SelectModes.Single)
		  If Creatures = Nil Or Creatures.LastRowIndex <> 0 Then
		    Return
		  End If
		  
		  Self.mTargetCreature = Creatures(0)
		  Self.CreatureNameLabel.Value = Self.mTargetCreature.Label
		  Self.CreatureNameLabel.Italic = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OffsetFields
	#tag Event
		Sub TextChange(index as Integer)
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(index as Integer, DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(index as Integer, ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(index as Integer, Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SpawnChanceField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If Self.Focus IsA RangeField And RangeField(Self.Focus).Validate = False Then
		    Return
		  End If
		  
		  If Self.mTargetCreature = Nil And Self.mMultiEditMode = False Then
		    Self.ShowAlert("Please select a creature", "Use the ""Choose…"" button to select a target creature if you wish to continue.")
		    Return
		  End If
		  
		  If Self.mEntries.LastRowIndex = -1 Then
		    Self.mEntries.AddRow(New Beacon.MutableSpawnPointSetEntry(Self.mTargetCreature))
		  End If
		  
		  For Each Entry As Beacon.MutableSpawnPointSetEntry In Self.mEntries
		    If Self.mTargetCreature <> Nil Then
		      Entry.Creature = Self.mTargetCreature
		    End If
		    
		    Var OffsetX, OffsetY, OffsetZ As Double
		    
		    Var Offset As Beacon.Point3D = Entry.Offset
		    If Offset <> Nil Then
		      OffsetX = Offset.X
		      OffsetY = Offset.Y
		      OffsetZ = Offset.Z
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.OffsetFields(0)) > -1 Then
		      If Self.OffsetFields(0).Value <> "" Then
		        OffsetX = Self.OffsetFields(0).DoubleValue
		      Else
		        OffsetX = 0
		      End If
		    End If
		    If Self.mEditedFields.IndexOf(Self.OffsetFields(1)) > -1 Then
		      If Self.OffsetFields(1).Value <> "" Then
		        OffsetY = Self.OffsetFields(1).DoubleValue
		      Else
		        OffsetY = 0
		      End If
		    End If
		    If Self.mEditedFields.IndexOf(Self.OffsetFields(2)) > -1 Then
		      If Self.OffsetFields(2).Value <> "" Then
		        OffsetZ = Self.OffsetFields(2).DoubleValue
		      Else
		        OffsetZ = 0
		      End If
		    End If
		    
		    If OffsetX = 0 And OffsetY = 0 And OffsetZ = 0 Then
		      Entry.Offset = Nil
		    Else
		      Entry.Offset = New Beacon.Point3D(OffsetX, OffsetY, OffsetZ)
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.SpawnChanceField) > -1 Then
		      If Self.SpawnChanceField.Value <> "" Then
		        Entry.SpawnChance = Self.SpawnChanceField.DoubleValue
		      Else
		        Entry.SpawnChance = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelOverrideMinField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelOverrideMaxField) > -1 Then
		      Var MinLevel As Integer = Round(Self.mDifficulty)
		      Var MaxLevel As Integer = Round(Self.mDifficulty) * 30
		      
		      If Self.LevelOverrideMinField.Value <> "" Then
		        MinLevel = Round(Self.LevelOverrideMinField.DoubleValue)
		      End If
		      If Self.LevelOverrideMaxField.Value <> "" Then
		        MaxLevel = Round(Self.LevelOverrideMaxField.DoubleValue)
		      End If
		      
		      Entry.LevelCount = 0
		      Entry.Append(Beacon.SpawnPointLevel.FromUserLevel(MinLevel, MaxLevel, Self.mDifficulty))
		      Entry.LevelOverride = Nil
		      Entry.MinLevelOffset = Nil
		      Entry.MaxLevelOffset = Nil
		      Entry.MinLevelMultiplier = Nil
		      Entry.MaxLevelMultiplier = Nil
		    ElseIf Self.mEditedFields.IndexOf(Self.LevelOffsetMinField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelOffsetMaxField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelMultiplierMinField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelMultiplierMaxField) > -1 Then
		      Entry.LevelCount = 0
		      Entry.LevelOverride = Nil
		      If IsNumeric(Self.LevelOffsetMinField.Value) And IsNumeric(Self.LevelOffsetMaxField.Value) Then
		        Entry.MinLevelOffset = Self.LevelOffsetMinField.DoubleValue
		        Entry.MaxLevelOffset = Self.LevelOffsetMaxField.DoubleValue
		      Else
		        Entry.MinLevelOffset = Nil
		        Entry.MaxLevelOffset = Nil
		      End If
		      If IsNumeric(Self.LevelMultiplierMinField.Value) And IsNumeric(Self.LevelMultiplierMaxField.Value) Then
		        Entry.MinLevelMultiplier = Self.LevelMultiplierMinField.DoubleValue
		        Entry.MaxLevelMultiplier = Self.LevelMultiplierMaxField.DoubleValue
		      Else
		        Entry.MinLevelMultiplier = Nil
		        Entry.MaxLevelMultiplier = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelMultiplierMinField) > -1 Then
		      If Self.LevelMultiplierMinField.Value <> "" Then
		        Entry.MinLevelMultiplier = Self.LevelMultiplierMinField.DoubleValue
		      Else
		        Entry.MinLevelMultiplier = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelMultiplierMaxField) > -1 Then
		      If Self.LevelMultiplierMaxField.Value <> "" Then
		        Entry.MaxLevelMultiplier = Self.LevelMultiplierMaxField.DoubleValue
		      Else
		        Entry.MaxLevelMultiplier = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelOffsetMinField) > -1 Then
		      If Self.LevelOffsetMinField.Value <> "" Then
		        Entry.MinLevelOffset = Self.LevelOffsetMinField.DoubleValue
		      Else
		        Entry.MinLevelOffset = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelOffsetMaxField) > -1 Then
		      If Self.LevelOffsetMaxField.Value <> "" Then
		        Entry.MaxLevelOffset = Self.LevelOffsetMaxField.DoubleValue
		      Else
		        Entry.MaxLevelOffset = Nil
		      End If
		    End If
		  Next
		  
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
#tag Events LevelMultiplierMaxField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelMultiplierMinField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOffsetMaxField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOffsetMinField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOverrideMaxField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOverrideMinField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.AddRow(Me)
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
