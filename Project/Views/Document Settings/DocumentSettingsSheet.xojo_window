#tag Window
Begin Window DocumentSettingsSheet
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   362
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Document Settings"
   Visible         =   True
   Width           =   700
   Begin UITweaks.ResizedTextField DocumentTitleField
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
      Italic          =   False
      Left            =   143
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Untitled Document"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   537
   End
   Begin Label MessageLabel
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Document Settings"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   660
   End
   Begin UITweaks.ResizedLabel DocumentTitleLabel
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
      Text            =   "Title:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   111
   End
   Begin GroupBox SupportedMapsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   ""
      Enabled         =   True
      Height          =   124
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   143
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   86
      Underline       =   False
      Visible         =   True
      Width           =   537
      Begin CheckBox MapCheckboxes
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "The Island"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   0
         InitialParent   =   "SupportedMapsGroup"
         Italic          =   False
         Left            =   163
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   106
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   126
      End
      Begin CheckBox MapCheckboxes
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Scorched Earth"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   1
         InitialParent   =   "SupportedMapsGroup"
         Italic          =   False
         Left            =   163
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   138
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   126
      End
      Begin CheckBox MapCheckboxes
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Aberration"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   2
         InitialParent   =   "SupportedMapsGroup"
         Italic          =   False
         Left            =   301
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   138
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   126
      End
      Begin CheckBox MapCheckboxes
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Extinction"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   3
         InitialParent   =   "SupportedMapsGroup"
         Italic          =   False
         Left            =   439
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   138
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   126
      End
      Begin CheckBox MapCheckboxes
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "The Center"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   4
         InitialParent   =   "SupportedMapsGroup"
         Italic          =   False
         Left            =   163
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   126
      End
      Begin CheckBox MapCheckboxes
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Ragnarok"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   5
         InitialParent   =   "SupportedMapsGroup"
         Italic          =   False
         Left            =   301
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         State           =   0
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   126
      End
   End
   Begin Label SupportedMapsLabel
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
      Text            =   "Supported Maps:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   86
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   111
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
      Italic          =   False
      Left            =   143
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "120"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   222
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Max Dino Level:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   222
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   111
   End
   Begin UITweaks.ResizedTextField DinoLevelStepsField
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
      Italic          =   False
      Left            =   143
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "5"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   256
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel DinoLevelStepsLabel
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
      Text            =   "Dino Level Steps:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   256
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   111
   End
   Begin UITweaks.ResizedLabel DinoLevelStepsDetailLabel
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
      Left            =   235
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Levels 5, 10, 15, 20, etc."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   256
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   445
   End
   Begin CheckBox ConsoleSafeCheckbox
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Show Only Console-Safe Engrams"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   143
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   290
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   537
   End
   Begin UITweaks.ResizedPushButton ImportButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Import…"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   322
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   600
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   322
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   508
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   322
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function AberrationCheckbox() As CheckBox
		  Return Self.MapCheckboxes(2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckAction()
		  Dim Enabled As Boolean = True
		  
		  If Self.DocumentTitleField.Text.Trim = "" Then
		    Enabled = False
		  End If
		  
		  If Enabled And (Val(Self.MaxDinoLevelField.Text.Trim) = 0 Or Val(Self.DinoLevelStepsField.Text.Trim) = 0) Then
		    Enabled = False
		  End If
		  
		  If Enabled And Not (Self.TheIslandCheckbox.Value Or Self.ScorchedEarthCheckbox.Value Or Self.AberrationCheckbox.Value Or Self.ExtinctionCheckbox.Value Or Self.TheCenterCheckbox.Value Or Self.RagnarokCheckbox.Value) Then
		    Enabled = False
		  End If
		  
		  If Self.ActionButton.Enabled <> Enabled Then
		    Self.ActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExtinctionCheckbox() As CheckBox
		  Return Self.MapCheckboxes(3)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As Window, Document As Beacon.Document) As Boolean
		  Parent = Parent.TrueWindow
		  
		  Dim Win As New DocumentSettingsSheet
		  Win.mDocument = Document
		  Win.ShowModalWithin(Parent)
		  Return Not Win.mCancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RagnarokCheckbox() As CheckBox
		  Return Self.MapCheckboxes(5)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ScorchedEarthCheckbox() As CheckBox
		  Return Self.MapCheckboxes(1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowModalWithin(Parent As Window)
		  Self.SwapButtons()
		  Self.UpdateUIForDocument(Self.mDocument)
		  Super.ShowModalWithin(Parent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TheCenterCheckbox() As CheckBox
		  Return Self.MapCheckboxes(4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TheIslandCheckbox() As CheckBox
		  Return Self.MapCheckboxes(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUIForDocument(Document As Beacon.Document)
		  Self.DocumentTitleField.Text = Document.Title
		  Self.MaxDinoLevelField.Text = Str(Document.MaxDinoLevel, "-0")
		  Self.DinoLevelStepsField.Text = Str(Document.DinoLevelSteps, "-0")
		  
		  Self.TheIslandCheckbox.Value = Beacon.Maps.TheIsland.Matches(Document.MapCompatibility)
		  Self.ScorchedEarthCheckbox.Value = Beacon.Maps.ScorchedEarth.Matches(Document.MapCompatibility)
		  Self.AberrationCheckbox.Value = Beacon.Maps.Aberration.Matches(Document.MapCompatibility)
		  Self.ExtinctionCheckbox.Value = Beacon.Maps.Extinction.Matches(Document.MapCompatibility)
		  Self.TheCenterCheckbox.Value = Beacon.Maps.TheCenter.Matches(Document.MapCompatibility)
		  Self.RagnarokCheckbox.Value = Beacon.Maps.Ragnarok.Matches(Document.MapCompatibility)
		  
		  Self.ConsoleSafeCheckbox.Value = Document.ConsoleModsOnly
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportedDocument As Beacon.Document
	#tag EndProperty


#tag EndWindowCode

#tag Events DocumentTitleField
	#tag Event
		Sub TextChange()
		  Self.CheckAction()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapCheckboxes
	#tag Event
		Sub Action(index as Integer)
		  Self.CheckAction()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxDinoLevelField
	#tag Event
		Sub TextChange()
		  Self.CheckAction()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DinoLevelStepsField
	#tag Event
		Sub TextChange()
		  Dim DinoLevelSteps As Integer = Val(Me.Text)
		  If DinoLevelSteps <= 0 Then
		    Self.CheckAction()
		    Return
		  End If
		  
		  Self.DinoLevelStepsDetailLabel.Text = "Levels " + Str(DinoLevelSteps * 1, "-0") + ", " + Str(DinoLevelSteps * 2, "-0") + ", " + Str(DinoLevelSteps * 3, "-0") + ", " + Str(DinoLevelSteps * 4, "-0") + ", etc."
		  Self.CheckAction()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ImportButton
	#tag Event
		Sub Action()
		  Dim ImportedDoc As Beacon.Document = DocumentImportDialog.Present
		  If ImportedDoc = Nil Then
		    Return
		  End If
		  
		  Self.mImportedDocument = ImportedDoc
		  Self.UpdateUIForDocument(ImportedDoc)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Action()
		  Self.mCancelled = False
		  
		  Self.mDocument.Title = Self.DocumentTitleField.Text.Trim.ToText
		  Self.mDocument.ConsoleModsOnly = Self.ConsoleSafeCheckbox.Value
		  Self.mDocument.MaxDinoLevel = Val(Self.MaxDinoLevelField.Text.Trim)
		  Self.mDocument.DinoLevelSteps = Val(Self.DinoLevelStepsField.Text.Trim)
		  Self.mDocument.SupportsMap(Beacon.Maps.TheIsland) = Self.TheIslandCheckbox.Value
		  Self.mDocument.SupportsMap(Beacon.Maps.ScorchedEarth) = Self.ScorchedEarthCheckbox.Value
		  Self.mDocument.SupportsMap(Beacon.Maps.Aberration) = Self.AberrationCheckbox.Value
		  Self.mDocument.SupportsMap(Beacon.Maps.Extinction) = Self.ExtinctionCheckbox.Value
		  Self.mDocument.SupportsMap(Beacon.Maps.TheCenter) = Self.TheCenterCheckbox.Value
		  Self.mDocument.SupportsMap(Beacon.Maps.Ragnarok) = Self.RagnarokCheckbox.Value
		  
		  If Self.mImportedDocument <> Nil Then
		    For I As Integer = 0 To Self.mImportedDocument.ServerProfileCount - 1
		      Self.mDocument.Add(Self.mImportedDocument.ServerProfile(I))
		    Next
		    For I As Integer = 0 To Self.mImportedDocument.LootSourceCount - 1
		      Self.mDocument.Add(Self.mImportedDocument.LootSource(I))
		    Next
		  End If
		  
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
		Name="mDocument"
		Group="Behavior"
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
