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
   Height          =   330
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
   Width           =   600
   Begin UITweaks.ResizedPopupMenu MapMenu
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   109
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   177
   End
   Begin UITweaks.ResizedLabel MapLabel
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
      TabIndex        =   0
      TabPanelIndex   =   0
      Text            =   "Map:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   77
   End
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
      Left            =   109
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
      Top             =   52
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
         Left            =   129
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
         Text            =   "You only need to enter one of these values, the rest will be calculated automatically."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   88
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
         Left            =   129
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
         Text            =   "Difficulty Offset:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
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
         Left            =   248
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
         Top             =   136
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
         Left            =   248
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
         Top             =   170
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
         Left            =   248
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
         Top             =   204
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
         Left            =   129
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
         Text            =   "Difficulty Value:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
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
         Left            =   129
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
         Text            =   "Max Dino Level:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   204
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
         Left            =   248
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
         Text            =   "http://ark.gamepedia.com/Difficulty"
         TextAlign       =   0
         TextColor       =   &c0000FF00
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   238
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
         Left            =   129
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
         Text            =   "Learn More:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   238
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
      Left            =   500
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
      Top             =   290
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
      Left            =   408
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
      Top             =   290
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
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    Self.MapMenu.AddRow(Map.Name, Map)
		  Next
		  Self.DifficultyOffsetField.Text = "1"
		  Self.MapMenu.ListIndex = 0
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

	#tag Method, Flags = &h21
		Private Function SelectedMap() As Beacon.Map
		  If MapMenu.ListIndex = -1 Then
		    Return Beacon.Maps.TheIsland
		  Else
		    Return MapMenu.RowTag(MapMenu.ListIndex)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SelectedMap(Assigns Map As Beacon.Map)
		  For I As Integer = 0 To Self.MapMenu.ListCount - 1
		    Dim MenuMap As Beacon.Map = Self.MapMenu.RowTag(I)
		    If MenuMap = Map Then
		      Self.MapMenu.ListIndex = I
		      Return
		    End If
		  Next
		  Self.MapMenu.ListIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(Doc As Beacon.Document)
		  Dim Map As Beacon.Map
		  If Doc.Map <> Nil Then
		    Map = Doc.Map
		  Else
		    Map = Beacon.Maps.GuessMap(Doc.LootSources)
		  End If
		  
		  Dim DifficultyValue As Double = Doc.DifficultyValue
		  If DifficultyValue = -1 Then
		    DifficultyValue = Map.DifficultyValue(1.0)
		  End If
		  
		  Self.SelectedMap = Map
		  
		  Dim DifficultyOffset As Double = Map.DifficultyOffset(DifficultyValue)
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

#tag Events MapMenu
	#tag Event
		Sub Change()
		  Dim DifficultyOffset As Double = Val(DifficultyOffsetField.Text)
		  Dim DifficultyValue As Double = Self.SelectedMap.DifficultyValue(DifficultyOffset)
		  Dim MaxDinoLevel As Integer = DifficultyValue * 30
		  
		  DifficultyValueField.Text = DifficultyValue.PrettyText
		  MaxDinoLevelField.Text = MaxDinoLevel.ToText
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DifficultyOffsetField
	#tag Event
		Sub TextChange()
		  If Self.Focus = Me Then
		    Dim DifficultyOffset As Double = Val(Me.Text)
		    Dim DifficultyValue As Double = Self.SelectedMap.DifficultyValue(DifficultyOffset)
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
		    Dim DifficultyOffset As Double = Self.SelectedMap.DifficultyOffset(DifficultyValue)
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
		    Dim DifficultyOffset As Double = Self.SelectedMap.DifficultyOffset(DifficultyValue)
		    
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
		    Dim Map As Beacon.Map = Self.SelectedMap
		    Dim Sources() As Beacon.LootSource = Self.mDoc.LootSources
		    Dim HasInvalidSources As Boolean
		    Dim ValidSourceCount, ValidPresetCount As Integer
		    For Each Source As Beacon.LootSource In Sources
		      If Source.ValidForMap(Map) Then
		        ValidSourceCount = ValidSourceCount + 1
		        ValidPresetCount = ValidPresetCount + Source.ImplementedPresetCount()
		      Else
		        HasInvalidSources = True
		      End If
		    Next
		    
		    If HasInvalidSources Then
		      Dim DropCount As Integer = Self.mDoc.BeaconCount - ValidSourceCount
		      If Not Self.ShowConfirm(DropCount.ToText + " " + if(DropCount = 1, "loot source is", "loot sources are") + " not compatible and will be removed.", "The " + if(DropCount = 1, "loot source is", "loot sources are") + " not valid for the selected map. If you want to keep " + if(DropCount = 1, "this loot source", "these loot sources") + ", cancel now and copy " + if(DropCount = 1, "it", "them") + " into a new document.", "Remove", "Cancel") Then
		        Return
		      End If
		    End If
		    
		    Dim MapChanged As Boolean = Self.mDoc.Map <> Nil And Self.mDoc.Map.Mask <> Map.Mask
		    Self.mDoc.Map = Map
		    Self.mDoc.DifficultyValue = Val(DifficultyValueField.Text)
		    
		    If MapChanged Then
		      For Each Source As Beacon.LootSource In Sources
		        If Not Source.ValidForMap(Map) Then
		          Self.mDoc.Remove(Source)
		        End If
		      Next
		      
		      If ValidPresetCount > 0 And Self.ShowConfirm("Would you like to rebuild your item sets based on their presets?", "Presets fill item sets based on the current map. When changing maps, it is recommended to rebuild the item sets from their original presets to get the most correct loot for the new map.", "Rebuild", "Do Not Rebuild") Then
		        Self.mDoc.ReconfigurePresets()
		      End If
		    End If
		    
		    RaiseEvent ShouldClose
		    Return
		  End If
		  
		  If UBound(Self.mImportedSources) > -1 Then
		    Dim Doc As New Beacon.Document
		    Doc.Map = Self.SelectedMap
		    Doc.DifficultyValue = Val(DifficultyValueField.Text)
		    
		    For Each Source As Beacon.LootSource In Self.mImportedSources
		      If Source.ValidForMap(Doc.Map) Then
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
		    Doc.Map = Self.SelectedMap
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
		    
		    Dim GuessedMap As Beacon.Map = Beacon.Maps.GuessMap(Sources)
		    If GuessedMap <> Self.SelectedMap Then
		      Dim Dialog As New MessageDialog
		      Dialog.Title = ""
		      Dialog.Message = GuessedMap.Name + " may be a better map selection. Would you like to change your settings?"
		      Dialog.Explanation = "Beacon will only import loot sources which are valid for the selected map."
		      Dialog.ActionButton.Caption = "Change Settings"
		      Dialog.CancelButton.Caption = "Keep Importing"
		      Dialog.CancelButton.Visible = True
		      
		      Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self)
		      If Choice = Dialog.ActionButton Then
		        For I As Integer = 0 To MapMenu.ListCount - 1
		          Dim Tag As Beacon.Map = MapMenu.RowTag(I)
		          If Tag = GuessedMap Then
		            MapMenu.ListIndex = I
		          End If
		        Next
		        Self.mImportContent = ""
		        Self.mImportedSources = Sources
		        Return
		      End If
		    End If
		    
		    Dim Doc As New Beacon.Document
		    Doc.Map = Self.SelectedMap
		    Doc.DifficultyValue = Val(DifficultyValueField.Text)
		    For Each Source As Beacon.LootSource In Sources
		      If Source.ValidForMap(Doc.Map) Then
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
		  
		  If Self.ImportProgress <> Nil Then
		    Self.ImportProgress.BeaconCount = Me.BeaconCount
		    Self.ImportProgress.LootSourcesProcessed = Me.LootSourcesProcessed
		  End If
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
