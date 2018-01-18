#tag Window
Begin ContainerControl DocumentSetupContainer
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   450
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   511
   Begin GroupBox DifficultyGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Difficulty"
      Enabled         =   True
      Height          =   226
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   172
      Underline       =   False
      Visible         =   True
      Width           =   471
      Begin Label DifficultyExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   36
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "You only need to enter one of these values, the rest will be calculated automatically."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   208
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Difficulty Offset:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   256
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
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
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
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   290
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
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   324
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
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Difficulty Value:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   290
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
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Max Dino Level:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   324
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
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "http://ark.gamepedia.com/Difficulty"
         TextAlign       =   0
         TextColor       =   &c0000FF00
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
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
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Learn More:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   358
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   107
      End
   End
   Begin UITweaks.ResizedPushButton ActionButton
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   411
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   410
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
      Left            =   319
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   410
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Beacon.ImportThread Importer
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   0
      Scope           =   2
      StackSize       =   ""
      State           =   ""
      TabPanelIndex   =   0
   End
   Begin GroupBox MapGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Maps"
      Enabled         =   True
      Height          =   140
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
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
         State           =   1
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   158
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
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   158
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
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   120
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   158
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
         Left            =   210
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
         Top             =   56
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   158
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
         Left            =   210
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
         Top             =   88
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   158
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    If MapCheck(Map.Mask) <> Nil Then
		      MapCheck(Map.Mask).Caption = Map.Name
		    End If
		  Next
		  Self.DifficultyOffsetField.Text = "1"
		  Self.DifficultyValueField.Text = "4"
		  Self.MaxDinoLevelField.Text = "120"
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CancelImport()
		  Importer.Stop
		  
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.Close
		    Self.ImportProgress = Nil
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

	#tag Method, Flags = &h0
		Sub Setup()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(Doc As Beacon.Document)
		  Dim Maps() As Beacon.Map = Doc.Maps
		  Dim Scale As Double = Maps.DifficultyScale()
		  
		  Dim DifficultyValue As Double = Doc.DifficultyValue
		  If DifficultyValue = -1 Then
		    DifficultyValue = Beacon.DifficultyValue(1.0, Scale)
		  End If
		  
		  Self.SelectedMaps = Doc.Maps
		  
		  Dim DifficultyOffset As Double = Beacon.DifficultyOffset(DifficultyValue, Scale)
		  Dim MaxDinoLevel As Integer = DifficultyValue * 30
		  
		  Self.DifficultyValueField.Text = DifficultyValue.PrettyText
		  Self.DifficultyOffsetField.Text = DifficultyOffset.PrettyText
		  Self.MaxDinoLevelField.Text = MaxDinoLevel.ToText
		  
		  Self.mDoc = Doc
		  Self.ActionButton.Caption = "Edit"
		  RaiseEvent TitleChanged("Edit Document Settings")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(File As FolderItem)
		  Self.ActionButton.Caption = "Import"
		  Self.mImportSource = File.DisplayName
		  RaiseEvent TitleChanged("Import From " + File.DisplayName)
		  
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Self.mImportContent = Stream.ReadAll(Encodings.UTF8).ToText
		  Stream.Close
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldClose()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TitleChanged(Title As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private ImportProgress As ImporterWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDoc As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportedSources() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportSource As String
	#tag EndProperty


#tag EndWindowCode

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
#tag Events ActionButton
	#tag Event
		Sub Action()
		  If Self.mDoc <> Nil Then
		    Dim Mask As UInt64 = Self.SelectedMask
		    Dim Sources() As Beacon.LootSource = Self.mDoc.LootSources
		    Dim ValidPresetCount As Integer
		    For Each Source As Beacon.LootSource In Sources
		      If Source.ValidForMask(Mask) Then
		        ValidPresetCount = ValidPresetCount + Source.ImplementedPresetCount()
		      End If
		    Next
		    
		    Dim MapChanged As Boolean = Self.mDoc.MapCompatibility <> Mask
		    Self.mDoc.MapCompatibility = Mask
		    Self.mDoc.DifficultyValue = Val(DifficultyValueField.Text)
		    
		    If MapChanged And ValidPresetCount > 0 And Self.ShowConfirm("Would you like to rebuild your item sets based on their presets?", "Presets fill item sets based on the current map. When changing maps, it is recommended to rebuild the item sets from their original presets to get the most correct loot for the new map.", "Rebuild", "Do Not Rebuild") Then
		      Self.mDoc.ReconfigurePresets()
		    End If
		    
		    RaiseEvent ShouldClose
		    Return
		  End If
		  
		  If UBound(Self.mImportedSources) > -1 Then
		    Dim Doc As New Beacon.Document
		    Doc.MapCompatibility = Self.SelectedMaps.Mask
		    Doc.DifficultyValue = Val(DifficultyValueField.Text)
		    
		    For Each Source As Beacon.LootSource In Self.mImportedSources
		      If Doc.SupportsLootSource(Source) Then
		        Doc.Add(Source)
		      End If
		    Next
		    If Doc.BeaconCount = 0 Then
		      Self.ShowAlert("Nothing imported", "No loot sources were imported for the selected map.")
		      Return
		    End If
		    
		    Dim Win As New DocWindow(Doc)
		    Win.Show
		    
		    RaiseEvent ShouldClose
		    Return
		  End If
		  
		  If Self.mImportContent = "" Then
		    Dim Doc As New Beacon.Document
		    Doc.MapCompatibility = Self.SelectedMaps.Mask
		    Doc.DifficultyValue = Val(DifficultyValueField.Text)
		    Doc.Modified = False
		    
		    Dim Win As New DocWindow(Doc)
		    Win.Show
		    
		    RaiseEvent ShouldClose
		    Return
		  End If
		  
		  Self.ImportProgress = New ImporterWindow
		  Self.ImportProgress.Source = Self.mImportSource
		  Self.ImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.ImportProgress.ShowWithin(Self.TrueWindow)
		  Self.Importer.Run(Self.mImportContent)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  RaiseEvent ShouldClose
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Importer
	#tag Event
		Sub UpdateUI()
		  If Me.LootSourcesProcessed = Me.BeaconCount Then
		    If Self.ImportProgress <> Nil Then
		      Self.ImportProgress.Close
		      Self.ImportProgress = Nil
		    End If
		    
		    Dim Sources() As Beacon.LootSource = Me.LootSources
		    If UBound(Sources) = -1 Then
		      Self.ShowAlert("No loot sources imported.", "The file contained no loot sources.")
		      Return
		    End If
		    
		    Dim Doc As New Beacon.Document
		    Doc.MapCompatibility = Self.SelectedMask
		    Doc.DifficultyValue = Val(DifficultyValueField.Text)
		    For Each Source As Beacon.LootSource In Sources
		      Doc.Add(Source)
		    Next
		    
		    Dim Win As New DocWindow(Doc)
		    Win.Show
		    
		    RaiseEvent ShouldClose
		    Return
		  End If
		  
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.BeaconCount = Me.BeaconCount
		    Self.ImportProgress.LootSourcesProcessed = Me.LootSourcesProcessed
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MapCheck
	#tag Event
		Sub Action(index as Integer)
		  Dim Mask As UInt64 = Self.SelectedMask
		  Dim Maps() As Beacon.Map = Beacon.Maps.ForMask(Mask)
		  Dim DifficultyOffset As Double = Val(DifficultyOffsetField.Text)
		  Dim DifficultyValue As Double = Beacon.DifficultyValue(DifficultyOffset, Maps.DifficultyScale)
		  Dim MaxDinoLevel As Integer = DifficultyValue * 30
		  
		  DifficultyValueField.Text = DifficultyValue.PrettyText
		  MaxDinoLevelField.Text = MaxDinoLevel.ToText
		  
		  Self.ActionButton.Enabled = Mask > 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Type="Integer"
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
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
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
