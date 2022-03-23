#tag Window
Begin BeaconContainer ArkLootEntryPropertiesEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   275
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
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   498
   Begin CheckBox EditChanceCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   142
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
   Begin CheckBox EditMaxQualityCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   110
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
   Begin CheckBox EditMinQualityCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   78
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
   Begin CheckBox EditMaxQuantityCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   44
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
   Begin CheckBox EditMinQuantityCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   10
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
   Begin UITweaks.ResizedLabel ChancePercentLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   381
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "%"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   142
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   37
   End
   Begin UITweaks.ResizedTextField ChanceField
      AcceptTabs      =   False
      Alignment       =   3
      AutoDeactivate  =   False
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   325
      LimitText       =   3
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Mask            =   "99#"
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "25"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   142
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   53
   End
   Begin Slider ChanceSlider
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   23
      HelpTag         =   "Items with a higher weight will be selected more frequently than items with a smaller weight. Two items with the same weight will be selected at the same frequency."
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   174
      LineStep        =   5
      LiveScroll      =   True
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   100
      Minimum         =   0
      PageStep        =   25
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TickStyle       =   0
      Top             =   142
      Transparent     =   False
      Value           =   25
      Visible         =   True
      Width           =   139
   End
   Begin Label ChanceLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Chance To Be Blueprint:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   142
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   152
   End
   Begin UITweaks.ResizedPopupMenu QualityMenus
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   1
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   174
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   110
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   244
   End
   Begin Label MaxQualityLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   10
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
      Text            =   "Max Quality:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   110
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   152
   End
   Begin UITweaks.ResizedPopupMenu QualityMenus
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   0
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   174
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   78
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   244
   End
   Begin Label MinQualityLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   10
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
      Text            =   "Min Quality:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   78
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   152
   End
   Begin UITweaks.ResizedTextField MaxQuantityField
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   174
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   "####"
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   44
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin Label MaxQuantityLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Max Quantity:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   44
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   152
   End
   Begin UITweaks.ResizedTextField MinQuantityField
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   174
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   "####"
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   10
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin Label MinQuantityLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   10
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
      Text            =   "Min Quantity:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   10
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   152
   End
   Begin Label WeightLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Weight:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   176
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   152
   End
   Begin Slider WeightSlider
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   23
      HelpTag         =   "Items with a higher weight will be selected more frequently than items with a smaller weight. Two items with the same weight will be selected at the same frequency."
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   174
      LineStep        =   5
      LiveScroll      =   True
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   1000
      Minimum         =   1
      PageStep        =   25
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      TickStyle       =   0
      Top             =   176
      Transparent     =   False
      Value           =   250
      Visible         =   True
      Width           =   139
   End
   Begin RangeField WeightField
      AcceptTabs      =   False
      Alignment       =   3
      AutoDeactivate  =   False
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      DoubleValue     =   0.0
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   325
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "250"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   176
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   53
   End
   Begin UITweaks.ResizedLabel WeightPercentLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   381
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   176
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   37
   End
   Begin CheckBox EditWeightCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Edit"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   176
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
   Begin CheckBox EditStatClampMultiplierCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Edit"
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
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   211
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
   Begin Label StatClampMultiplierLabel
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
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Stat Limits Multiplier:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   "#HelpTagStatClampMultiplier"
      Top             =   211
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   152
   End
   Begin RangeField StatClampMultiplierField
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
      Left            =   174
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "1.0"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   "#HelpTagStatClampMultiplier"
      Top             =   211
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin CheckBox PreventGrindingCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Prevent Grinding"
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
      Left            =   174
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   25
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "#HelpTagPreventGrinding"
      Top             =   245
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   244
   End
   Begin CheckBox EditPreventGrindingCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Edit"
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
      Left            =   430
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   26
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   245
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   False
      Width           =   58
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ApplyTo(ParamArray Entries() As Ark.MutableLootItemSetEntry)
		  Self.ApplyTo(Entries)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ApplyTo(Entries() As Ark.MutableLootItemSetEntry)
		  Var MinQuantity, MaxQuantity As Integer
		  Try
		    MinQuantity = Integer.FromString(MinQuantityField.Text.Trim, Locale.Current)
		  Catch Err As InvalidArgumentException
		  End Try
		  Try
		    MaxQuantity = Integer.FromString(MaxQuantityField.Text.Trim, Locale.Current)
		  Catch Err As InvalidArgumentException
		  End Try
		  If MinQuantity > MaxQuantity Then
		    Var Temp As Integer = MaxQuantity
		    MaxQuantity = MinQuantity
		    MinQuantity = Temp
		  End If
		  
		  Var MinQualityValue As Double = MinQualityMenu.Tag
		  Var MaxQualityValue As Double = MaxQualityMenu.Tag
		  If MinQualityValue > MaxQualityValue Then
		    Var Temp As Double = MaxQualityValue
		    MaxQualityValue = MinQualityValue
		    MinQualityValue = Temp
		  End If
		  Var MinQuality As Ark.Quality = Ark.Qualities.ForBaseValue(MinQualityValue)
		  Var MaxQuality As Ark.Quality = Ark.Qualities.ForBaseValue(MaxQualityValue)
		  
		  Var BlueprintChance As Double = ChanceSlider.Value / 100
		  Var Weight As Double = WeightField.DoubleValue
		  Var StatClampMultiplier As Double = StatClampMultiplierField.DoubleValue
		  Var PreventGrinding As Boolean = PreventGrindingCheck.Value
		  
		  For Idx As Integer = 0 To Entries.LastIndex
		    If Self.EditMaxQuantityCheck.Value Then
		      Entries(Idx).MaxQuantity = MaxQuantity
		    End If
		    If Self.EditMinQuantityCheck.Value Then
		      Entries(Idx).MinQuantity = MinQuantity
		    End If
		    If EditChanceCheck.Value Then
		      Entries(Idx).ChanceToBeBlueprint = BlueprintChance
		    End If
		    If EditWeightCheck.Value Then
		      Entries(Idx).RawWeight = Weight
		    End If
		    If EditPreventGrindingCheck.Value Then
		      Entries(Idx).PreventGrinding = PreventGrinding
		    End If
		    If EditStatClampMultiplierCheck.Value Then
		      Entries(Idx).StatClampMultiplier = StatClampMultiplier
		    End If
		    If Self.EditMaxQualityCheck.Value Then
		      Entries(Idx).MaxQuality = MaxQuality
		    End If
		    If Self.EditMinQualityCheck.Value Then
		      Entries(Idx).MinQuality = MinQuality
		    End If
		  Next Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MaxQualityMenu() As PopupMenu
		  Return Self.QualityMenus(1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MinQualityMenu() As PopupMenu
		  Return Self.QualityMenus(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(Entries() As Ark.LootItemSetEntry)
		  // This seems like a strange sequence of events, but remember that arrays are objects and therefore passed by reference
		  // so any changes made to the array itself do not stay local to this method. This essentially makes a clone of the array
		  // without any nils, and fills in a dummy value if the cloned array winds up with no members.
		  
		  Var Filtered() As Ark.LootItemSetEntry
		  If (Entries Is Nil) = False Then
		    For Idx As Integer = Entries.FirstIndex To Entries.LastIndex
		      If (Entries(Idx) Is Nil) = False Then
		        Filtered.Add(Entries(Idx))
		      End If
		    Next Idx
		  End If
		  If Filtered.Count = 0 Then
		    Var Entry As New Ark.MutableLootItemSetEntry()
		    Entry.Add(New Ark.LootItemSetEntryOption(Ark.Engram.CreateCustom("", "/Game/Mods/Default.Default", ""), 1.0))
		    Filtered.Add(Entry)
		  End If
		  Entries = Filtered
		  Filtered = Nil
		  
		  Var MinQuantities(), MaxQuantities() As Integer
		  Var MinQualities(), MaxQualities() As Double
		  Var TotalWeight, TotalChance, TotalStatClamMultiplier As Double
		  Var CanBeBlueprint, PreventGrinding As Boolean
		  For Each Entry As Ark.LootItemSetEntry In Entries
		    MinQuantities.Add(Entry.MinQuantity)
		    MaxQuantities.Add(Entry.MaxQuantity)
		    TotalWeight = TotalWeight + Entry.RawWeight
		    TotalChance = TotalChance + Entry.ChanceToBeBlueprint
		    TotalStatClamMultiplier = TotalStatClamMultiplier + Entry.StatClampMultiplier
		    MinQualities.Add(Entry.MinQuality.BaseValue)
		    MaxQualities.Add(Entry.MaxQuality.BaseValue)
		    CanBeBlueprint = CanBeBlueprint Or Entry.CanBeBlueprint
		    PreventGrinding = PreventGrinding Or Entry.PreventGrinding
		  Next
		  
		  MinQuantities.Sort
		  MaxQuantities.Sort
		  MinQualities.Sort
		  MaxQualities.Sort
		  
		  Self.mIgnoreChanges = True
		  MinQuantityField.Text = MinQuantities(0).ToString(Locale.Current, "0")
		  MaxQuantityField.Text = MaxQuantities(MaxQuantities.LastIndex).ToString(Locale.Current, "0")
		  If CanBeBlueprint Then
		    ChanceSlider.Value = 100 * (TotalChance / (Entries.LastIndex + 1))
		    ChanceSlider.Enabled = True
		    ChanceLabel.Enabled = True
		    ChanceField.Enabled = True
		    EditChanceCheck.Enabled = True
		  Else
		    ChanceSlider.Value = 0
		    ChanceSlider.Enabled = False
		    ChanceLabel.Enabled = False
		    ChanceField.Enabled = False
		    EditChanceCheck.Enabled = False
		  End If
		  MinQualityMenu.SelectByTag(MinQualities(0))
		  MaxQualityMenu.SelectByTag(MaxQualities(MaxQualities.LastIndex))
		  WeightSlider.Value = TotalWeight / Entries.Count
		  WeightField.DoubleValue = TotalWeight / Entries.Count
		  PreventGrindingCheck.Value = PreventGrinding
		  StatClampMultiplierField.DoubleValue = TotalStatClamMultiplier / Entries.Count
		  Self.mIgnoreChanges = False
		  
		  If Entries.Count > 1 Then
		    EditChanceCheck.Visible = True
		    EditMaxQualityCheck.Visible = True
		    EditMaxQuantityCheck.Visible = True
		    EditMinQualityCheck.Visible = True
		    EditMinQuantityCheck.Visible = True
		    EditWeightCheck.Visible = True
		    EditStatClampMultiplierCheck.Visible = True
		    EditPreventGrindingCheck.Visible = True
		  End If
		  
		  EditChanceCheck.Value = Not EditChanceCheck.Visible
		  EditWeightCheck.Value = Not EditWeightCheck.Visible
		  EditMaxQualityCheck.Value = Not EditMaxQualityCheck.Visible
		  EditMaxQuantityCheck.Value = Not EditMaxQuantityCheck.Visible
		  EditMinQualityCheck.Value = Not EditMinQualityCheck.Visible
		  EditMinQuantityCheck.Value = Not EditMaxQualityCheck.Visible
		  
		  Var RightEdge As Integer
		  If EditMinQualityCheck.Visible Or EditMaxQualityCheck.Visible Or EditChanceCheck.Visible Or EditWeightCheck.Visible Then
		    RightEdge = Min(EditMinQualityCheck.Left, EditMaxQualityCheck.Left, EditChanceCheck.Left, EditWeightCheck.Left) - 12
		  Else
		    RightEdge = Self.Width - 20
		  End If
		  
		  MinQualityMenu.Width = (RightEdge - MinQualityMenu.Left)
		  MaxQualityMenu.Width = (RightEdge - MaxQualityMenu.Left)
		  ChancePercentLabel.Left = RightEdge - (ChancePercentLabel.Width + 3)
		  ChanceField.Left = ChancePercentLabel.Left - (ChanceField.Width + 12)
		  ChanceSlider.Width = ChanceField.Left - (12 + ChanceSlider.Left)
		  WeightPercentLabel.Left = ChancePercentLabel.Left
		  WeightField.Left = ChanceField.Left
		  WeightSlider.Width = ChanceSlider.Width
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(ParamArray Entries() As Ark.LootItemSetEntry)
		  Self.Setup(Entries)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mIgnoreChanges As Boolean
	#tag EndProperty


	#tag Constant, Name = HelpTagPreventGrinding, Type = String, Dynamic = False, Default = \"If checked\x2C the items cannot be fed to the industrial grinder.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HelpTagStatClampMultiplier, Type = String, Dynamic = False, Default = \"If item stat limiting is used on the server\x2C this setting will allow the items to generate above or below the item stat limit. For example\x2C if damage is limited to 1000 in the Item Stat Limits editor\x2C a multiplier of 0.5 would limit to 500 and a multiplier of 2.0 would limit to 2000.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ChanceField
	#tag Event
		Sub LostFocus()
		  Me.Text = ChanceSlider.Value.ToString(Locale.Current, ",##0")
		  ChanceSlider.Enabled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  ChanceSlider.Enabled = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.Focus = Me Then
		    Var MyValue As Integer
		    Try
		      MyValue = Integer.FromString(Me.Text.Trim, Locale.Current)
		    Catch Err As InvalidArgumentException
		    End Try
		    Self.ChanceSlider.Value = Max(Min(MyValue, ChanceSlider.MaximumValue), ChanceSlider.MinimumValue)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChanceSlider
	#tag Event
		Sub ValueChanged()
		  If Self.Focus <> ChanceField Then
		    ChanceField.Text = Me.Value.ToString(Locale.Current, ",##0")
		  End If
		  
		  If Not Self.mIgnoreChanges Then
		    EditChanceCheck.Value = True
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events QualityMenus
	#tag Event
		Sub Change(index as Integer)
		  If Not Self.mIgnoreChanges Then
		    Select Case Index
		    Case 0 // Min
		      EditMinQualityCheck.Value = True
		    Case 1 // Max
		      EditMaxQualityCheck.Value = True
		    End Select
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open(index as Integer)
		  Me.RemoveAllRows()
		  
		  Var Qualities() As Ark.Quality = Ark.Qualities.All
		  For Each Quality As Ark.Quality In Qualities
		    Me.AddRow(Quality.Label, Quality.BaseValue)
		  Next
		  
		  Me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxQuantityField
	#tag Event
		Sub TextChange()
		  If Not Self.mIgnoreChanges Then
		    EditMaxQuantityCheck.Value = True
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinQuantityField
	#tag Event
		Sub TextChange()
		  If Not Self.mIgnoreChanges Then
		    EditMinQuantityCheck.Value = True
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightSlider
	#tag Event
		Sub ValueChanged()
		  If Self.Focus <> WeightField Then
		    WeightField.DoubleValue = Me.Value
		  End If
		  
		  If Not Self.mIgnoreChanges Then
		    EditWeightCheck.Value = True
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightField
	#tag Event
		Sub LostFocus()
		  WeightSlider.Enabled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  WeightSlider.Enabled = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If Self.Focus = Me Then
		    WeightSlider.Value = Round(Me.DoubleValue)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StatClampMultiplierField
	#tag Event
		Sub TextChange()
		  If Not Self.mIgnoreChanges Then
		    EditStatClampMultiplierCheck.Value = True
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0
		  MaxValue = 100000
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PreventGrindingCheck
	#tag Event
		Sub Action()
		  If Not Self.mIgnoreChanges Then
		    EditPreventGrindingCheck.Value = True
		    RaiseEvent Changed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Type="Color"
		EditorType="Color"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
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
