#tag Window
Begin ContainerControl ArkLootDropSettingsContainer
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   96
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
   Width           =   250
   Begin RangeField MinItemSetsField
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
      Left            =   117
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
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   50
   End
   Begin UITweaks.ResizedLabel MinItemSetsLabel
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
      TabStop         =   True
      Text            =   "Minimum Item Sets:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   85
   End
   Begin RangeField MaxItemSetsField
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
      Left            =   117
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
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   26
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   50
   End
   Begin UITweaks.ResizedLabel MaxItemSetsLabel
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Maximum Item Sets:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   26
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   85
   End
   Begin UpDownArrows MinItemSetsStepper
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   167
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   2
      Transparent     =   False
      Visible         =   True
      Width           =   13
   End
   Begin UpDownArrows MaxItemSetsStepper
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   167
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   26
      Transparent     =   False
      Visible         =   True
      Width           =   13
   End
   Begin SwitchControl NoDuplicatesCheck
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   117
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   48
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
   Begin SwitchControl AppendModeCheck
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   117
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   71
      Transparent     =   True
      Visible         =   True
      Width           =   40
   End
   Begin UITweaks.ResizedLabel NoDuplicatesLabel
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
      Text            =   "Prevent Duplicates:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   48
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   85
   End
   Begin UITweaks.ResizedLabel AppendModeLabel
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
      Text            =   "Add Item Sets to Default"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   71
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   85
   End
   Begin FadedSeparator BottomSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   93
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.SetupUI()
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Containers() As Ark.MutableLootContainer()
		  Var Results() As Ark.MutableLootContainer
		  For Idx As Integer = 0 To Self.mContainerRefs.LastIndex
		    If (Self.mContainerRefs(Idx).Value Is Nil) = False Then
		      Results.Add(Ark.MutableLootContainer(Self.mContainerRefs(Idx).Value))
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Containers(Assigns Containers() As Ark.MutableLootContainer)
		  Self.mSettingUp = True
		  
		  Self.mContainerRefs.ResizeTo(Containers.LastIndex)
		  
		  If Containers.Count = 0 Then
		    Self.MinItemSetsField.Clear
		    Self.MaxItemSetsField.Clear
		    Self.NoDuplicatesCheck.VisualState(False) = CheckBox.VisualStates.Unchecked
		    Self.AppendModeCheck.VisualState(False) = CheckBox.VisualStates.Unchecked
		  Else
		    Var CommonMinItemSets As Integer = Containers(0).MinItemSets
		    Var CommonMaxItemSets As Integer = Containers(0).MaxItemSets
		    Var CommonNoDuplicates As CheckBox.VisualStates = If(Containers(0).PreventDuplicates, CheckBox.VisualStates.Checked, Checkbox.VisualStates.Unchecked)
		    Var CommonAppendMode As CheckBox.VisualStates = If(Containers(0).AppendMode, CheckBox.VisualStates.Checked, CheckBox.VisualStates.Unchecked)
		    
		    For Idx As Integer = 0 To Containers.LastIndex
		      Self.mContainerRefs(Idx) = New WeakRef(Containers(Idx))
		      
		      If Containers(Idx).MinItemSets <> CommonMinItemSets Then
		        CommonMinItemSets = -1
		      End If
		      If Containers(Idx).MaxItemSets <> CommonMaxItemSets Then
		        CommonMaxItemSets = -1
		      End If
		      If If(Containers(Idx).PreventDuplicates, CheckBox.VisualStates.Checked, Checkbox.VisualStates.Unchecked) <> CommonNoDuplicates Then
		        CommonNoDuplicates = CheckBox.VisualStates.Indeterminate
		      End If
		      If If(Containers(Idx).AppendMode, CheckBox.VisualStates.Checked, Checkbox.VisualStates.Unchecked) <> CommonAppendMode Then
		        CommonAppendMode = CheckBox.VisualStates.Indeterminate
		      End If
		    Next
		    
		    If CommonMinItemSets > -1 Then
		      Self.MinItemSetsField.DoubleValue = CommonMinItemSets
		    Else
		      Self.MinItemSetsField.Clear
		    End If
		    If CommonMaxItemSets > -1 Then
		      Self.MaxItemSetsField.DoubleValue = CommonMaxItemSets
		    Else
		      Self.MaxItemSetsField.Clear
		    End If
		    
		    Self.NoDuplicatesCheck.VisualState(False) = CommonNoDuplicates
		    Self.AppendModeCheck.VisualState(False) = CommonAppendMode
		  End If
		  Self.SetupUI()
		  Self.SetFieldsEnabled()
		  Self.mSettingUp = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetFieldsEnabled()
		  Var Enabled As Boolean = (Self.AppendModeCheck.VisualState = CheckBox.VisualStates.Unchecked)
		  Self.MaxItemSetsField.Enabled = Enabled
		  Self.MaxItemSetsLabel.Enabled = Enabled
		  Self.MaxItemSetsStepper.Enabled = Enabled
		  Self.MinItemSetsField.Enabled = Enabled
		  Self.MinItemSetsLabel.Enabled = Enabled
		  Self.MinItemSetsStepper.Enabled = Enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupUI()
		  Const Gap = 6
		  Const RowHeight = 20
		  Const ContainerHeight = (RowHeight * 4) + (Gap * 5) + 1
		  
		  BeaconUI.SizeToFit(Self.MinItemSetsLabel, Self.MaxItemSetsLabel, Self.NoDuplicatesLabel, Self.AppendModeLabel)
		  
		  Self.MinItemSetsLabel.Left = Gap
		  Self.MinItemSetsLabel.Top = Gap
		  Self.MaxItemSetsLabel.Left = Gap
		  Self.MaxItemSetsLabel.Top = Self.MinItemSetsLabel.Bottom + Gap
		  Self.NoDuplicatesLabel.Left = Gap
		  Self.NoDuplicatesLabel.Top = Self.MaxItemSetsLabel.Bottom + Gap
		  Self.AppendModeLabel.Left = Gap
		  Self.AppendModeLabel.Top = Self.NoDuplicatesLabel.Bottom + Gap
		  
		  Self.MinItemSetsField.Left = Self.MinItemSetsLabel.Right + Gap
		  Self.MinItemSetsField.Top = Self.MinItemSetsLabel.Top
		  Self.MaxItemSetsField.Left = Self.MaxItemSetsLabel.Right + Gap
		  Self.MaxItemSetsField.Top = Self.MaxItemSetsLabel.Top
		  Self.NoDuplicatesCheck.Left = Self.NoDuplicatesLabel.Right + Gap
		  Self.NoDuplicatesCheck.Top = Self.NoDuplicatesLabel.Top
		  Self.AppendModeCheck.Left = Self.AppendModeLabel.Right + Gap
		  Self.AppendModeCheck.Top = Self.AppendModeLabel.Top
		  
		  Self.MinItemSetsStepper.Left = Self.MinItemSetsField.Right + 2
		  Self.MinItemSetsStepper.Top = Self.MinItemSetsField.Top
		  Self.MaxItemSetsStepper.Left = Self.MaxItemSetsField.Right + 2
		  Self.MaxItemSetsStepper.Top = Self.MaxItemSetsField.Top
		  
		  Self.BottomSeparator.Top = ContainerHeight - 1
		  
		  If Self.Height <> ContainerHeight Then
		    Self.Height = ContainerHeight
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event SettingsChanged()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mContainerRefs() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean = True
	#tag EndProperty


	#tag Constant, Name = CollapsedHeight, Type = Double, Dynamic = False, Default = \"23", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ExpandedHeight, Type = Double, Dynamic = False, Default = \"130", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events MinItemSetsField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If IsNumeric(Me.Text) = False Then
		    Return
		  End If
		  
		  Var Value As Integer = Val(Me.Text)
		  Var Containers() As Ark.MutableLootContainer = Self.Containers
		  For Idx As Integer = 0 To Containers.LastIndex
		    Containers(Idx).MinItemSets = Value
		  Next
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  If Value.Trim.IsEmpty And Self.mContainerRefs.LastIndex > 0 Then
		    Return True
		  End If
		End Function
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
#tag Events MaxItemSetsField
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If IsNumeric(Me.Text) = False Then
		    Return
		  End If
		  
		  Var Value As Integer = Val(Me.Text)
		  Var Containers() As Ark.MutableLootContainer = Self.Containers
		  For Idx As Integer = 0 To Containers.LastIndex
		    Containers(Idx).MaxItemSets = Value
		  Next
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  If Value.Trim.IsEmpty And Self.mContainerRefs.LastIndex > 0 Then
		    Return True
		  End If
		End Function
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
#tag Events MinItemSetsStepper
	#tag Event
		Sub Down()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.MinItemSetsField.DoubleValue = Self.MinItemSetsField.DoubleValue - 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.MinItemSetsField.DoubleValue = Self.MinItemSetsField.DoubleValue + 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaxItemSetsStepper
	#tag Event
		Sub Down()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.MaxItemSetsField.DoubleValue = Self.MaxItemSetsField.DoubleValue - 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.MaxItemSetsField.DoubleValue = Self.MaxItemSetsField.DoubleValue + 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NoDuplicatesCheck
	#tag Event
		Sub Action()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Var Containers() As Ark.MutableLootContainer = Self.Containers
		  For Idx As Integer = 0 To Containers.LastIndex
		    Containers(Idx).PreventDuplicates = Me.Value
		  Next
		  
		  RaiseEvent SettingsChanged
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AppendModeCheck
	#tag Event
		Sub Action()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Var Containers() As Ark.MutableLootContainer = Self.Containers
		  For Idx As Integer = 0 To Containers.LastIndex
		    Containers(Idx).AppendMode = Me.Value
		  Next
		  
		  Self.SetFieldsEnabled()
		  
		  RaiseEvent SettingsChanged
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
