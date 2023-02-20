#tag DesktopWindow
Begin ArkSettingsListElement ArkSettingsListStringElement
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "True"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   62
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   300
   Begin DesktopLabel mDescriptionLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   16
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
      Selectable      =   True
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Untitled"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   40
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   260
   End
   Begin DesktopLabel mNameLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      Selectable      =   True
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Untitled"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   6
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   168
   End
   Begin DelayedTextField mValueField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
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
      Left            =   200
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   6
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   52
   End
   Begin IconCanvas mDismissButton
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Clickable       =   True
      ContentHeight   =   0
      Enabled         =   True
      Height          =   16
      Icon            =   1389395967
      IconColor       =   8
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   264
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "Restore this setting to the default."
      Top             =   9
      Transparent     =   True
      Visible         =   False
      Width           =   16
   End
   Begin UITweaks.ResizedPopupMenu mChoiceMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   200
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -167
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   80
   End
   Begin DelayedComboBox mInputMenu
      AllowAutoComplete=   True
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      InitialValue    =   "sock"
      Italic          =   False
      Left            =   200
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -135
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub LockStateChanged()
		  Self.mValueField.Enabled = Self.Unlocked
		  Self.mChoiceMenu.Enabled = Self.Unlocked
		  Self.mInputMenu.Enabled = Self.Unlocked
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Const VisibleTop = 6
		  Const HiddenTop = -30000
		  
		  Select Case Self.mMode
		  Case Self.PlainMode
		    Self.mChoiceMenu.Visible = False
		    Self.mChoiceMenu.Top = HiddenTop
		    Self.mInputMenu.Visible = False
		    Self.mInputMenu.Top = HiddenTop
		    Self.mValueField.Visible = True
		    Self.mValueField.Top = VisibleTop
		  Case Self.MenuMode
		    Self.mChoiceMenu.Visible = True
		    Self.mChoiceMenu.Top = VisibleTop + 1
		    Self.mInputMenu.Visible = False
		    Self.mInputMenu.Top = HiddenTop
		    Self.mValueField.Visible = False
		    Self.mValueField.Top = HiddenTop
		    
		    Var Choices() As Variant = Self.mKey.Constraint("oneof")
		    Self.mChoiceMenu.RemoveAllRows
		    For Each Choice As String In Choices
		      Self.mChoiceMenu.AddRow(Choice)
		    Next Choice
		  Case Self.ComboMode
		    Self.mChoiceMenu.Visible = False
		    Self.mChoiceMenu.Top = HiddenTop
		    Self.mInputMenu.Visible = True
		    Self.mInputMenu.Top = VisibleTop
		    Self.mValueField.Visible = False
		    Self.mValueField.Top = HiddenTop
		    
		    Var Choices() As Variant = Self.mKey.Constraint("oneof")
		    Self.mInputMenu.RemoveAllRows
		    For Each Choice As String In Choices
		      Self.mInputMenu.AddRow(Choice)
		    Next Choice
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Key As Ark.ConfigKey)
		  If IsNull(Key.Constraint("oneof")) = False Then
		    Var AllowCustom As Variant = Key.Constraint("allowcustom")
		    If IsNull(AllowCustom) = False And AllowCustom.BooleanValue = True Then
		      Self.mMode = Self.ComboMode
		    Else
		      Self.mMode = Self.MenuMode
		    End If
		  Else
		    Self.mMode = Self.PlainMode
		  End If
		  
		  Super.Constructor(Key)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DescriptionLabel() As DesktopLabel
		  Return Self.mDescriptionLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DismissButton() As IconCanvas
		  Return Self.mDismissButton
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeyNameWidth(Assigns KeyNameWidth As Integer)
		  Super.KeyNameWidth = KeyNameWidth
		  
		  Var ValueControl As DesktopUIControl
		  Select Case Self.mMode
		  Case Self.PlainMode
		    ValueControl = Self.mValueField
		  Case Self.MenuMode
		    ValueControl = Self.mChoiceMenu
		  Case Self.ComboMode
		    ValueControl = Self.mInputMenu
		  End Select
		  
		  Self.mNameLabel.Width = KeyNameWidth
		  ValueControl.Left = Self.mNameLabel.Left + Self.mNameLabel.Width + 12
		  ValueControl.Width = (Self.mDismissButton.Left - 12) - ValueControl.Left
		  Self.mDescriptionLabel.Left = ValueControl.Left
		  Self.mDescriptionLabel.Width = ValueControl.Width
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NameLabel() As DesktopLabel
		  Return Self.mNameLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  Var StringValue As String
		  
		  Select Case Self.mMode
		  Case Self.PlainMode
		    StringValue = Self.mValueField.Text
		  Case Self.MenuMode
		    StringValue = Self.mChoiceMenu.SelectedRowValue
		  Case Self.ComboMode
		    StringValue = Self.mInputMenu.Text
		  End Select
		  
		  Var ShouldBeginWith As Variant = Self.mKey.Constraint("beginswith")
		  Var ShouldEndWith As Variant = Self.mKey.Constraint("endswith")
		  
		  If IsNull(ShouldBeginWith) = False And StringValue.BeginsWith(ShouldBeginWith) = False Then
		    StringValue = ShouldBeginWith + StringValue
		  End If
		  If IsNull(ShouldEndWith) = False And StringValue.EndsWith(ShouldEndWith) = False Then
		    StringValue = StringValue + ShouldEndWith
		  End If
		  
		  Return StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Animated As Boolean = False, Assigns NewValue As Variant)
		  #Pragma Unused Animated
		  
		  Var BlockChanges As Boolean = Self.mBlockChanges
		  Self.mBlockChanges = True
		  
		  Var StringValue As String
		  Try
		    StringValue = NewValue.StringValue
		  Catch Err As RuntimeException
		  End Try
		  
		  Select Case Self.mMode
		  Case Self.PlainMode
		    Self.mValueField.SetImmediately(StringValue)
		  Case Self.MenuMode
		    Self.mChoiceMenu.SelectByCaption(StringValue)
		  Case Self.ComboMode
		    Self.mInputMenu.SetImmediately(StringValue)
		  End Select
		  Self.mBlockChanges = BlockChanges
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlockChanges As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Integer
	#tag EndProperty


	#tag Constant, Name = ComboMode, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MenuMode, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PlainMode, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events mValueField
	#tag Event
		Sub TextChanged()
		  If Self.mBlockChanges Then
		    Return
		  End If
		  
		  Self.UserValueChange(Self.Value)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events mDismissButton
	#tag Event
		Sub Pressed()
		  Self.Delete()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events mChoiceMenu
	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  #Pragma Unused DeltaX
		  #Pragma Unused DeltaY
		  
		  #if TargetWindows
		    // Capture the scroll wheel to prevent accidental changing while scrolling the settings list
		    Return True
		  #endif
		End Function
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  If Self.mBlockChanges Then
		    Return
		  End If
		  
		  Self.UserValueChange(Self.Value)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events mInputMenu
	#tag Event
		Sub TextChanged()
		  If Self.mBlockChanges Then
		    Return
		  End If
		  
		  Self.UserValueChange(Self.Value)
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  #Pragma Unused DeltaX
		  #Pragma Unused DeltaY
		  
		  #if TargetWindows
		    // Capture the scroll wheel to prevent accidental changing while scrolling the settings list
		    Return True
		  #endif
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ShowOfficialName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsOverloaded"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="AllowAutoDeactivate"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
