#tag Window
Begin ConfigEditor LootScaleConfigEditor
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   476
   HelpTag         =   ""
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
   Width           =   732
   Begin GroupBox HelpGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "About This Setting"
      Enabled         =   True
      Height          =   436
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   405
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   307
      Begin Label HelpLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   380
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "HelpGroup"
         Italic          =   False
         Left            =   425
         LockBottom      =   True
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
         Text            =   "Loot scaling affects the quality of items found in lootable objects, such as drops, dino inventories, beaver dams, and artifact containers. Setting this value too high can produce loot that is uncraftable. Adjust this in small increments, if at all. Values between 100% and 125% are recommend.\n\nValues greater than 100% increase loot quality, values lower than 100% decrease loot quality.\n\nA word of caution: settings this value too high can produce loot that requires more than 65,535 of a single item to craft or repair. Ark cannot handle quantities so large, meaning the item will be uncraftable no matter how many inventory spaces are available."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   267
      End
   End
   Begin TextField LootScaleField
      AcceptTabs      =   False
      Alignment       =   2
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "100%"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   80
   End
   Begin Slider ScaleSlider
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LineStep        =   1
      LiveScroll      =   True
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   200
      Minimum         =   10
      PageStep        =   20
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TickStyle       =   "0"
      Top             =   54
      Transparent     =   False
      Value           =   100
      Visible         =   True
      Width           =   365
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim Multiplier As Double = 1.0
		  If Self.Document.HasConfigGroup(BeaconConfigs.LootScale.ConfigName) Then
		    Self.mConfigGroup = BeaconConfigs.LootScale(Self.Document.ConfigGroup(BeaconConfigs.LootScale.ConfigName))
		    Multiplier = Self.mConfigGroup.Multiplier
		  End If
		  
		  Self.LootScaleField.Text = Str(Multiplier, "0%")
		  Self.ScaleSlider.Value = Multiplier * 100
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize()
		  Self.LootScaleField.Left = Self.ScaleSlider.Left + ((Self.ScaleSlider.Width - Self.LootScaleField.Width) / 2)
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Resized()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resizing()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mConfigGroup As BeaconConfigs.LootScale
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean = True
	#tag EndProperty


#tag EndWindowCode

#tag Events LootScaleField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Dim Value As Double = CDbl(Me.Text)
		  If Value = 0 Then
		    Return
		  End If
		  
		  Self.mSettingUp = True
		  If Self.mConfigGroup = Nil Then
		    Self.mConfigGroup = New BeaconConfigs.LootScale(Value / 100)
		    Self.Document.AddConfigGroup(Self.mConfigGroup)
		  Else
		    Self.mConfigGroup.Multiplier = Value / 100
		  End If
		  Self.ScaleSlider.Value = Self.mConfigGroup.Multiplier * 100
		  Self.ContentsChanged = True
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ScaleSlider
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.LootScaleField.Text = Str(Me.Value, "-0") + "%"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="ToolbarCaption"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ToolbarIcon"
		Group="Behavior"
		Type="Picture"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
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
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
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
		Name="EraseBackground"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
