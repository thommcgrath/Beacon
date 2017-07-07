#tag Window
Begin Window DocumentSetupWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Compatibility   =   ""
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   330
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
   Placement       =   2
   Resizeable      =   False
   Title           =   "New Document"
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
      TabIndex        =   0
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
      TabIndex        =   1
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
      TabIndex        =   4
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
         TabIndex        =   3
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
         TabIndex        =   4
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
         TabIndex        =   5
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
         TabIndex        =   6
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
         TabIndex        =   7
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
         TabIndex        =   8
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
   Begin PushButton ActionButton
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
      TabIndex        =   5
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
   Begin PushButton CancelButton
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
      TabIndex        =   6
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
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
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

	#tag Method, Flags = &h0
		Shared Sub ShowCreate()
		  Dim Win As New DocumentSetupWindow
		  Win.Show()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub ShowImport(File As Global.FolderItem)
		  Dim Win As New DocumentSetupWindow
		  Win.ActionButton.Caption = "Import"
		  Win.mImportSource = File.DisplayName
		  Win.Title = "Import From " + File.DisplayName
		  
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Win.mImportContent = Stream.ReadAll(Encodings.UTF8).ToText
		  Stream.Close
		  
		  Win.Show()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ImportProgress As ImporterWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportSource As String
	#tag EndProperty


#tag EndWindowCode

#tag Events MapMenu
	#tag Event
		Sub Open()
		  Dim Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    Me.AddRow(Map.Name, Map)
		  Next
		  DifficultyOffsetField.Text = "1"
		  Me.ListIndex = 0
		End Sub
	#tag EndEvent
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
		  If Self.mImportContent = "" Then
		    Dim Doc As New Beacon.Document
		    Doc.Map = Self.SelectedMap
		    Doc.DifficultyValue = Val(DifficultyValueField.Text)
		    
		    Dim Win As New DocWindow(Doc)
		    Win.Show
		    
		    Self.Close
		    Return
		  End If
		  
		  Self.ImportProgress = New ImporterWindow
		  Self.ImportProgress.Source = Self.mImportSource
		  Self.ImportProgress.CancelAction = WeakAddressOf Self.CancelImport
		  Self.ImportProgress.ShowWithin(Self.TrueWindow)
		  Self.Importer.Run(Self.mImportContent, Val(DifficultyValueField.Text))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  Self.Close
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
		    Dim Doc As New Beacon.Document
		    Doc.Map = Self.SelectedMap
		    Doc.DifficultyValue = Val(DifficultyValueField.Text)
		    For Each Source As Beacon.LootSource In Sources
		      Doc.Add(Source)
		    Next
		    
		    Dim Win As New DocWindow(Doc)
		    Win.Show
		    
		    Self.Close
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
		Visible=true
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
		Name="mImportContent"
		Group="Behavior"
		Type="Integer"
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
