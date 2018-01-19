#tag Window
Begin Window DocumentSetupSheet
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   496
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   500
   MaximizeButton  =   False
   MaxWidth        =   511
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   484
   MinimizeButton  =   False
   MinWidth        =   511
   Placement       =   1
   Resizeable      =   False
   Title           =   "Document Setup"
   Visible         =   True
   Width           =   511
   Begin PagePanel Pages
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   496
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
      TabIndex        =   8
      TabPanelIndex   =   0
      Top             =   0
      Value           =   2
      Visible         =   True
      Width           =   511
      Begin Label MessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "New Document"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   471
      End
      Begin GroupBox MapGroup
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Supported Maps"
         Enabled         =   True
         Height          =   140
         HelpTag         =   ""
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
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         Visible         =   True
         Width           =   471
         Begin CheckBox MapCheck
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "The Island"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   1
            InitialParent   =   "MapGroup"
            Italic          =   False
            Left            =   40
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   0
            TabPanelIndex   =   3
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   88
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   174
         End
         Begin CheckBox MapCheck
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Scorched Earth"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   2
            InitialParent   =   "MapGroup"
            Italic          =   False
            Left            =   40
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   1
            TabPanelIndex   =   3
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   120
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   174
         End
         Begin CheckBox MapCheck
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Aberration"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   16
            InitialParent   =   "MapGroup"
            Italic          =   False
            Left            =   40
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   2
            TabPanelIndex   =   3
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   152
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   174
         End
         Begin CheckBox MapCheck
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "The Center"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   4
            InitialParent   =   "MapGroup"
            Italic          =   False
            Left            =   226
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   3
            TabPanelIndex   =   3
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   88
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   174
         End
         Begin CheckBox MapCheck
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Ragnarok"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   8
            InitialParent   =   "MapGroup"
            Italic          =   False
            Left            =   226
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            State           =   0
            TabIndex        =   4
            TabPanelIndex   =   3
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   120
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   174
         End
      End
      Begin GroupBox DifficultyGroup
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Difficulty"
         Enabled         =   True
         Height          =   240
         HelpTag         =   ""
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
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   204
         Underline       =   False
         Visible         =   True
         Width           =   471
         Begin Label DifficultyExplanationLabel
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   50
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "DifficultyGroup"
            Italic          =   False
            Left            =   40
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Multiline       =   True
            Scope           =   2
            Selectable      =   False
            TabIndex        =   0
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "You only need to enter one of these values, the rest will be calculated automatically. All selected maps must use the same difficulty, otherwise Beacon will produce incorrect quality items."
            TextAlign       =   0
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   240
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   431
         End
         Begin UITweaks.ResizedLabel DifficultyOffsetLabel
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "DifficultyGroup"
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
            TabIndex        =   1
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "Difficulty Offset:"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   302
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   107
         End
         Begin UITweaks.ResizedTextField DifficultyOffsetField
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
            InitialParent   =   "DifficultyGroup"
            Italic          =   False
            Left            =   159
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   2
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   302
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   80
         End
         Begin UITweaks.ResizedTextField DifficultyValueField
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
            InitialParent   =   "DifficultyGroup"
            Italic          =   False
            Left            =   159
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
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
            Top             =   336
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   80
         End
         Begin UITweaks.ResizedTextField MaxDinoLevelField
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
            InitialParent   =   "DifficultyGroup"
            Italic          =   False
            Left            =   159
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
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
            Top             =   370
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   80
         End
         Begin UITweaks.ResizedLabel DifficultyValueLabel
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "DifficultyGroup"
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
            TabIndex        =   5
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "Difficulty Value:"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   336
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   107
         End
         Begin UITweaks.ResizedLabel MaxDinoLevelLabel
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "DifficultyGroup"
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
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "Max Dino Level:"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   370
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   107
         End
         Begin LinkLabel DifficultyDetailsLink
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "DifficultyGroup"
            Italic          =   False
            Left            =   159
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   7
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "http://ark.gamepedia.com/Difficulty"
            TextAlign       =   0
            TextColor       =   &c0000FF00
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   404
            Transparent     =   False
            Underline       =   True
            Visible         =   True
            Width           =   312
         End
         Begin Label DifficultyDetailsLabel
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "DifficultyGroup"
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
            TabIndex        =   8
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "Learn More:"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   404
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   107
         End
      End
      Begin UITweaks.ResizedPushButton FinalizeActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Create"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   411
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   456
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton FinalizeCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   True
         Caption         =   "Back"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   319
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   456
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label IntroMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         Text            =   "New Document"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   471
      End
      Begin RadioButton ImportServerRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Import settings from a server"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   471
      End
      Begin Label ImportServerExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   110
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "With this option, Beacon will download the GameUserSettings.ini and Game.ini files from a server using FTP and create a document with the current map, difficulty, and loot settings. Beacon will be able to upload changes back to the server.\n\nFTP credentials will be sent to Beacon's server, which will make the connections. These credentials will not be stored on the server in any way."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   84
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   431
      End
      Begin RadioButton ImportLocalRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Import settings from this computer"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
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
         Top             =   206
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   471
      End
      Begin Label ImportLocalExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   51
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Beacon can import the GameUserSettings and Game.ini from this computer to obtain current loot settings, map, and difficulty settings. Automatic deployment can be enabled after import."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   238
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   431
      End
      Begin RadioButton CreateEmptyRadio
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Create a document from scratch"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   20
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
         Top             =   301
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   471
      End
      Begin Label CreateEmptyExplanation
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Start with an empty file. Automatic deployment can be enabled later."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   333
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   431
      End
      Begin PushButton IntroActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   411
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   456
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin PushButton IntroCancelButton
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
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   319
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   456
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label ProgressMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         Text            =   "Importing Config…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   471
      End
      Begin ProgressBar ProgressIndicator
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         Top             =   222
         Value           =   0
         Visible         =   True
         Width           =   471
      End
      Begin Label ProgressStatus
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
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
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Downloading files…"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "SmallSystem"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   254
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   471
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  If Self.mTempFolder <> Nil And Self.mTempFolder.Exists Then
		    For I As Integer = Self.mTempFolder.Count DownTo 1
		      Self.mTempFolder.Item(I).Delete
		    Next
		    Self.mTempFolder.Delete
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.DifficultyOffsetField.Text = "1"
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DownloadConfigFile(Success As Boolean, Message As Text, Details As Auto)
		  If Success Then
		    If Self.mTempFolder = Nil Then
		      Self.mTempFolder = SpecialFolder.Temporary.Child(Beacon.CreateUUID)
		      Self.mTempFolder.CreateAsFolder
		    End If
		    
		    Dim Dict As Xojo.Core.Dictionary = Details
		    Dim Ref As Text = Dict.Value("ref")
		    Dim Basename As Text = Ref.Left(Ref.Length - 32)
		    Dim Content As Text = Dict.Value("content")
		    Dim File As FolderItem = Self.mTempFolder.Child(Ref + ".ini")
		    
		    Dim Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(Content)
		    Stream.Close
		    
		    Select Case Basename
		    Case "Game"
		      Self.mGameIniFile = File
		    Case "GameUserSettings"
		      Self.mGameUserSettingsIniFile = File
		    End Select
		    
		    If Self.mGameIniFile <> Nil And Self.mGameIniFile.Exists And Self.mGameUserSettingsIniFile <> Nil And Self.mGameUserSettingsIniFile.Exists Then
		      // Finished
		      Self.FinishDownloads()
		    End If
		  Else
		    Self.ShowAlert("Unable to download config", "Server said " + Message)
		    Self.PresentServerImport()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectConfigType(File As FolderItem) As ConfigFileType
		  If File = Nil Then
		    Return ConfigFileType.Other
		  End If
		  
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Return DetectConfigType(Content)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DetectConfigType(Content As String) As ConfigFileType
		  Const GameIniHeader = "[/Script/ShooterGame.ShooterGameMode]"
		  Const GameUserSettingsIniHeader = "[/Script/ShooterGame.ShooterGameUserSettings]"
		  
		  If Content.InStr(GameIniHeader) > 0 Then
		    Return ConfigFileType.GameIni
		  ElseIf Content.InStr(GameUserSettingsIniHeader) > 0 Then
		    Return ConfigFileType.GameUserSettingsIni
		  Else
		    Return ConfigFileType.Other
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishDownloads()
		  // At least one of mGameIniFile and mGameUserSettingsIniFile will exist, hopefully both
		  
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Document As Beacon.Document, Mode As DocumentSetupSheet.Modes) As Boolean
		  Parent = Parent.TrueWindow
		  
		  Dim Win As New DocumentSetupSheet
		  Win.mDocument = Document
		  Win.Setup(Mode)
		  Win.ShowModalWithin(Parent)
		  
		  Dim Cancelled As Boolean = Win.mCancelled
		  Win.Close
		  
		  Return Not Cancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PresentLocalImport()
		  Dim Dialog As New OpenDialog
		  Dialog.SuggestedFileName = "Game.ini"
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.PromptText = "Please select a Game.ini or GameUserSettings.ini file"
		  
		  Dim FirstFile As FolderItem = Dialog.ShowModal()
		  If FirstFile = Nil Then
		    Return
		  End If
		  
		  Dim FirstFileType As ConfigFileType = Self.DetectConfigType(FirstFile)
		  Dim OtherFileName As String
		  Dim DesiredOtherFileType As ConfigFileType
		  Select Case FirstFileType
		  Case ConfigFileType.Other
		    Self.ShowAlert("Unknown config file", "Sorry, Beacon can't determine which config file this is.")
		    Return
		  Case ConfigFileType.GameIni
		    OtherFileName = "GameUserSettings.ini"
		    DesiredOtherFileType = ConfigFileType.GameUserSettingsIni
		  Case ConfigFileType.GameUserSettingsIni
		    OtherFileName = "Game.ini"
		    DesiredOtherFileType = ConfigFileType.GameIni
		  End Select
		  
		  Dim Parent As FolderItem = FirstFile.Parent
		  Dim SecondFile As FolderItem = Parent.Child(OtherFileName)
		  If SecondFile = Nil Or SecondFile.Exists = False Then
		    // Couldn't find the sibling file
		    Dialog.SuggestedFileName = OtherFileName
		    Dialog.PromptText = "Now please select " + OtherFileName
		    
		    SecondFile = Dialog.ShowModal()
		  End If
		  
		  Dim SecondFileType As ConfigFileType = Self.DetectConfigType(SecondFile)
		  If SecondFileType <> DesiredOtherFileType Then
		    If Not Self.ShowConfirm("Do you want to do a partial import?", "Beacon couldn't find both Game.ini and GameUserSettings.ini files. Beacon can do a partial import, but you will need to fill in some settings yourself.", "Import Anyway", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  If FirstFileType = ConfigFileType.GameIni Then
		    Self.mGameIniFile = FirstFile
		    Self.mGameUserSettingsIniFile = SecondFile
		  Else
		    Self.mGameIniFile = SecondFile
		    Self.mGameUserSettingsIniFile = FirstFile
		  End If
		  
		  Self.Pages.Value = Self.PageImportProgress
		  Self.FinishDownloads()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PresentServerImport()
		  Self.mGameIniFile = Nil
		  Self.mGameUserSettingsIniFile = Nil
		  
		  Dim FTPSettings As Beacon.FTPProfile = FTPProfileDialog.Present(Self.mFTPSettings)
		  If FTPSettings <> Nil Then
		    Self.mFTPSettings = FTPSettings
		    
		    Dim Hash As Text = FTPSettings.Hash
		    Dim GameIniRequest As New BeaconAPI.Request("ftp.php?" + FTPSettings.QueryString("Game.ini") + "&ref=Game" + Hash, "GET", WeakAddressOf APICallback_DownloadConfigFile)
		    Dim GameUserSettingsIniRequest As New BeaconAPI.Request("ftp.php?" + FTPSettings.QueryString("GameUserSettings.ini") + "&ref=GameUserSettings" + Hash, "GET", WeakAddressOf APICallback_DownloadConfigFile)
		    GameIniRequest.Sign(App.Identity)
		    GameUserSettingsIniRequest.Sign(App.Identity)
		    
		    BeaconAPI.Send(GameIniRequest)
		    BeaconAPI.Send(GameUserSettingsIniRequest)
		    
		    Self.Pages.Value = Self.PageImportProgress
		  Else
		    Self.Pages.Value = Self.PageIntro
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedMaps() As Beacon.Map()
		  Return Beacon.Maps.ForMask(Self.SelectedMask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedMaps(Assigns Maps() As Beacon.Map)
		  Self.SelectedMask = Maps.Mask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedMask() As UInt64
		  Dim Mask As UInt64
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    If MapCheck(Map.Mask) <> Nil And MapCheck(Map.Mask).Value Then
		      Mask = Mask Or Map.Mask
		    End If
		  Next
		  Return Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SelectedMask(Assigns Mask As UInt64)
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    If MapCheck(Map.Mask) <> Nil Then
		      MapCheck(Map.Mask).Value = (Map.Mask And Mask) = Map.Mask
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Setup(Mode As DocumentSetupSheet.Modes)
		  Select Case Mode
		  Case Modes.Create, Modes.Import
		    Self.FinalizeCancelButton.Caption = "Back"
		    Self.FinalizeActionButton.Caption = "Create"
		    Self.Title = "New Document"
		  Case Modes.Edit
		    Self.FinalizeCancelButton.Caption = "Cancel"
		    Self.FinalizeActionButton.Caption = "Edit"
		    Self.Title = "Edit Document Settings"
		    Self.Pages.Value = Self.PageFinalize
		  End Select
		  Self.MessageLabel.Text = Self.Title
		  
		  Dim Mask As UInt64
		  If Self.mDocument.MapCompatibility > 0 Then
		    Mask = Self.mDocument.MapCompatibility
		  Else
		    Mask = Beacon.Maps.GuessMap(Self.mDocument.LootSources)
		  End If
		  
		  Dim SelectedMaps() As Beacon.Map = Beacon.Maps.ForMask(Mask)
		  Dim DifficultyScale As Double
		  Dim DifficultyMatches As Boolean = True
		  For Each Map As Beacon.Map In SelectedMaps
		    DifficultyScale = Max(DifficultyScale, Map.DifficultyScale)
		    DifficultyMatches = DifficultyMatches And (DifficultyScale = Map.DifficultyScale)
		  Next
		  
		  Dim DifficultyValue As Double = Self.mDocument.DifficultyValue
		  If DifficultyValue = -1 Then
		    DifficultyValue = Beacon.DifficultyValue(1.0, DifficultyScale)
		  End If
		  
		  Self.SelectedMask = Mask
		  
		  Dim DifficultyOffset As Double = Beacon.DifficultyOffset(DifficultyValue, DifficultyScale)
		  Dim MaxDinoLevel As Integer = DifficultyValue * 30
		  
		  Self.DifficultyValueField.Text = DifficultyValue.PrettyText
		  Self.DifficultyOffsetField.Text = DifficultyOffset.PrettyText
		  Self.MaxDinoLevelField.Text = MaxDinoLevel.ToText
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFTPSettings As Beacon.FTPProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempFolder As FolderItem
	#tag EndProperty


	#tag Constant, Name = PageFinalize, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageImportProgress, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageIntro, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ConfigFileType, Type = Integer, Flags = &h21
		GameIni
		  GameUserSettingsIni
		Other
	#tag EndEnum

	#tag Enum, Name = Modes, Type = Integer, Flags = &h0
		Create
		  Edit
		Import
	#tag EndEnum


#tag EndWindowCode

#tag Events MapCheck
	#tag Event
		Sub Action(index as Integer)
		  Dim Maps() As Beacon.Map = Self.SelectedMaps
		  If Maps.Ubound = -1 Then
		    Self.FinalizeActionButton.Enabled = False
		    Return
		  End If
		  
		  Dim Scale As Double = Maps.DifficultyScale
		  
		  Dim DifficultyOffset As Double = Val(Self.DifficultyOffsetField.Text)
		  Dim DifficultyValue As Double = Beacon.DifficultyValue(DifficultyOffset, Scale)
		  Dim MaxDinoLevel As Integer = DifficultyValue * 30
		  
		  Self.DifficultyValueField.Text = DifficultyValue.PrettyText
		  Self.DifficultyOffsetField.Text = DifficultyOffset.PrettyText
		  Self.MaxDinoLevelField.Text = MaxDinoLevel.ToText
		  
		  Self.FinalizeActionButton.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DifficultyOffsetField
	#tag Event
		Sub TextChange()
		  If Self.Focus = Me Then
		    Dim DifficultyOffset As Double = Val(Me.Text)
		    Dim DifficultyValue As Double = Beacon.DifficultyValue(DifficultyOffset, Self.SelectedMaps.DifficultyScale)
		    Dim MaxDinoLevel As Integer = DifficultyValue * 30
		    
		    Self.DifficultyValueField.Text = DifficultyValue.PrettyText
		    Self.MaxDinoLevelField.Text = MaxDinoLevel.ToText
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DifficultyValueField
	#tag Event
		Sub TextChange()
		  If Self.Focus = Me Then
		    Dim DifficultyValue As Double = Val(Me.Text)
		    Dim DifficultyOffset As Double = Beacon.DifficultyOffset(DifficultyValue, Self.SelectedMaps.DifficultyScale)
		    Dim MaxDinoLevel As Integer = DifficultyValue * 30
		    
		    Self.DifficultyOffsetField.Text = DifficultyOffset.PrettyText
		    Self.MaxDinoLevelField.Text = MaxDinoLevel.ToText
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxDinoLevelField
	#tag Event
		Sub TextChange()
		  If Self.Focus = Me Then
		    Dim MaxDinoLevel As Integer = Val(Me.Text)
		    Dim DifficultyValue As Double = MaxDinoLevel / 30
		    Dim DifficultyOffset As Double = Beacon.DifficultyOffset(DifficultyValue, Self.SelectedMaps.DifficultyScale)
		    
		    Self.DifficultyOffsetField.Text = DifficultyOffset.PrettyText
		    Self.DifficultyValueField.Text = DifficultyValue.PrettyText
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DifficultyDetailsLink
	#tag Event
		Sub Action()
		  ShowURL("http://ark.gamepedia.com/Difficulty")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FinalizeActionButton
	#tag Event
		Sub Action()
		  Dim Mask As UInt64 = Self.SelectedMask
		  Dim Sources() As Beacon.LootSource = Self.mDocument.LootSources
		  Dim ValidPresetCount As Integer
		  For Each Source As Beacon.LootSource In Sources
		    If Source.ValidForMask(Mask) Then
		      ValidPresetCount = ValidPresetCount + Source.ImplementedPresetCount()
		    End If
		  Next
		  
		  Dim MapChanged As Boolean = Self.mDocument.MapCompatibility <> Mask
		  Self.mDocument.MapCompatibility = Mask
		  Self.mDocument.DifficultyValue = Val(DifficultyValueField.Text)
		  
		  If MapChanged And ValidPresetCount > 0 And Self.ShowConfirm("Would you like to rebuild your item sets based on their presets?", "Presets fill item sets based on the current map. When changing maps, it is recommended to rebuild the item sets from their original presets to get the most correct loot for the new map.", "Rebuild", "Do Not Rebuild") Then
		    Self.mDocument.ReconfigurePresets()
		  End If
		  
		  Self.mCancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FinalizeCancelButton
	#tag Event
		Sub Action()
		  If Me.Caption = "Back" Then
		    Self.Pages.Value = Self.PageIntro
		  Else
		    Self.mCancelled = True
		    Self.Hide
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroActionButton
	#tag Event
		Sub Action()
		  If ImportServerRadio.Value Then
		    Self.PresentServerImport()
		  ElseIf ImportLocalRadio.Value Then
		    Self.PresentLocalImport()
		  ElseIf CreateEmptyRadio.Value Then
		    Self.Pages.Value = Self.PageFinalize
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events IntroCancelButton
	#tag Event
		Sub Action()
		  Self.mCancelled = True
		  Self.Hide
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
