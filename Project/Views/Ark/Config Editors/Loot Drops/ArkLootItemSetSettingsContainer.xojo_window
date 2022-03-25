#tag Window
Begin ContainerControl ArkLootItemSetSettingsContainer
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   154
   HelpTag         =   ""
   Index           =   -2147483648
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
   Width           =   300
   Begin DisclosureTriangle DisclosureTriangle1
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Facing          =   0
      Height          =   18
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   2
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   2
      Transparent     =   False
      Value           =   False
      Visible         =   True
      Width           =   18
   End
   Begin FadedSeparator BottomBorder
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      ContentHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   1
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   153
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
   Begin Label SettingsLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   18
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
      TabStop         =   True
      Text            =   "Settings"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   219
   End
   Begin UITweaks.ResizedTextField NameField
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
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   101
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   32
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   179
   End
   Begin Label NameLabel
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Name:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   32
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   69
   End
   Begin Label MinEntriesLabel
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
      Text            =   "Min Entries:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   56
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   69
   End
   Begin Label MaxEntriesLabel
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
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Max Entries:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   80
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   69
   End
   Begin Label WeightLabel
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
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Weight:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   104
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   69
   End
   Begin CheckBox PreventDuplicatesCheck
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Prevent Duplicates"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   101
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   128
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   179
   End
   Begin RangeField MinEntriesField
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
      DoubleValue     =   0.0
      Enabled         =   True
      Format          =   ""
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   101
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   56
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   82
   End
   Begin RangeField MaxEntriesField
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
      DoubleValue     =   0.0
      Enabled         =   True
      Format          =   ""
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   101
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
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   80
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   82
   End
   Begin RangeField WeightField
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
      DoubleValue     =   0.0
      Enabled         =   True
      Format          =   ""
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   101
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
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   104
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   82
   End
   Begin UpDownArrows WeightStepper
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   183
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   104
      Transparent     =   False
      Visible         =   True
      Width           =   13
   End
   Begin UpDownArrows MaxEntriesStepper
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   183
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   80
      Transparent     =   False
      Visible         =   True
      Width           =   13
   End
   Begin UpDownArrows MinEntriesStepper
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   183
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   56
      Transparent     =   False
      Visible         =   True
      Width           =   13
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  RaiseEvent Open
		  Self.SetupUI()
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Collapse()
		  Self.DisclosureTriangle1.Value = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EditName()
		  Self.NameField.SetFocus()
		  Self.NameField.SelectAll()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Expand()
		  Self.DisclosureTriangle1.Value = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  If Self.DisclosureTriangle1.Value Then
		    Self.Height = Self.ExpandedHeight
		  Else
		    Self.Height = Self.CollapsedHeight
		  End If
		  
		  Var Visible As Boolean = Self.DisclosureTriangle1.Value
		  Self.MaxEntriesField.Visible = Visible
		  Self.MaxEntriesLabel.Visible = Visible
		  Self.MaxEntriesStepper.Visible = Visible
		  Self.MinEntriesField.Visible = Visible
		  Self.MinEntriesLabel.Visible = Visible
		  Self.MinEntriesStepper.Visible = Visible
		  Self.NameField.Visible = Visible
		  Self.NameLabel.Visible = Visible
		  Self.PreventDuplicatesCheck.Visible = Visible
		  Self.WeightField.Visible = Visible
		  Self.WeightLabel.Visible = Visible
		  Self.WeightStepper.Visible = Visible
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SettingsChanged()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mItemSetRef <> Nil And Self.mItemSetRef.Value <> Nil Then
			    Return Ark.MutableLootItemSet(Self.mItemSetRef.Value)
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSettingUp = True
			  If (Value Is Nil) = False Then
			    Self.mItemSetRef = New WeakRef(Value)
			    Self.NameField.Text = Value.Label
			    Self.MinEntriesField.DoubleValue = Value.MinNumItems
			    Self.MaxEntriesField.DoubleValue = Value.MaxNumItems
			    Self.WeightField.DoubleValue = Value.RawWeight
			    Self.PreventDuplicatesCheck.Value = Value.ItemsRandomWithoutReplacement
			  Else
			    Self.mItemSetRef = Nil
			    Self.NameField.Text = ""
			    Self.MinEntriesField.Clear
			    Self.MaxEntriesField.Clear
			    Self.WeightField.Text = ""
			    Self.PreventDuplicatesCheck.Value = False
			  End If
			  Self.SetupUI()
			  Self.mSettingUp = False
			End Set
		#tag EndSetter
		ItemSet As Ark.MutableLootItemSet
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mItemSetRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean = True
	#tag EndProperty


	#tag Constant, Name = CollapsedHeight, Type = Double, Dynamic = False, Default = \"23", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ExpandedHeight, Type = Double, Dynamic = False, Default = \"154", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WeightScale, Type = Double, Dynamic = False, Default = \"1000", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events DisclosureTriangle1
	#tag Event
		Sub Action()
		  Self.SetupUI
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NameField
	#tag Event
		Sub TextChange()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  If Self.ItemSet.Label.Compare(Me.Text, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.ItemSet.Label = Me.Text
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PreventDuplicatesCheck
	#tag Event
		Sub Action()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  If Self.ItemSet.ItemsRandomWithoutReplacement = Me.Value Then
		    Return
		  End If
		  
		  Self.ItemSet.ItemsRandomWithoutReplacement = Me.Value
		  Self.MaxEntriesField.CheckValue
		  Self.MinEntriesField.CheckValue
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinEntriesField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  If IsNumeric(Me.Text) = False Then
		    Return
		  End If
		  
		  Var Value As Integer = Val(Me.Text)
		  Self.ItemSet.MinNumItems = Value
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0
		  MaxValue = 9999
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxEntriesField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  If IsNumeric(Me.Text) = False Then
		    Return
		  End If
		  
		  Var Value As Integer = Val(Me.Text)
		  Self.ItemSet.MaxNumItems = Value
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0
		  MaxValue = 9999
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  Var Value As Double = Me.DoubleValue
		  If Value = 0 Then
		    Return
		  End If
		  
		  Self.ItemSet.RawWeight = Value
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WeightStepper
	#tag Event
		Sub Down()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue - (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  Self.WeightField.DoubleValue = Self.WeightField.DoubleValue + (If(Keyboard.AsyncShiftKey, 5, 1) * (Self.WeightScale / 100))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxEntriesStepper
	#tag Event
		Sub Down()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  Self.MaxEntriesField.DoubleValue = Self.MaxEntriesField.DoubleValue - 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  Self.MaxEntriesField.DoubleValue = Self.MaxEntriesField.DoubleValue + 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MinEntriesStepper
	#tag Event
		Sub Down()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  Self.MinEntriesField.DoubleValue = Self.MinEntriesField.DoubleValue - 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  If Self.mSettingUp Or Self.ItemSet = Nil Then
		    Return
		  End If
		  
		  Self.MinEntriesField.DoubleValue = Self.MinEntriesField.DoubleValue + 1
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="LockTop"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="TabIndex"
		Visible=true
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
