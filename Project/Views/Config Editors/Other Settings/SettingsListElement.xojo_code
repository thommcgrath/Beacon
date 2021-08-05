#tag Class
Protected Class SettingsListElement
Inherits ContainerControl
	#tag Event
		Sub Resized()
		  RaiseEvent Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  RaiseEvent Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Key As Beacon.ConfigKey)
		  Self.mKey = Key
		  Super.Constructor
		  Self.NameLabel.Text = Key.Label.ReplaceAll("&", "&&").Trim + ":"
		  Self.DescriptionLabel.Text = Key.Description.ReplaceAll("&", "&&").Trim
		  Self.DescriptionLabel.Tooltip = Key.Description.Trim
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Delete()
		  Self.UserValueChange(Nil)
		  Self.Value(True) = Self.mKey.DefaultValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DescriptionLabel() As Label
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DismissButton() As IconCanvas
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As Beacon.ConfigKey
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function KeyNameWidth() As Integer
		  Return Self.mKeyNameWidth
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeyNameWidth(Assigns KeyNameWidth As Integer)
		  Self.mKeyNameWidth = KeyNameWidth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NameLabel() As Label
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UserValueChange(NewValue As Variant)
		  Self.IsOverloaded = IsNull(NewValue) = False
		  
		  If Beacon.SafeToInvoke(Self.SettingChangeDelegate) Then
		    Self.SettingChangeDelegate.Invoke(Self.mKey, NewValue)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Animated As Boolean = False, Assigns NewValue As Variant)
		  #Pragma Unused Animated
		  #Pragma Unused NewValue
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Resize()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldDelete()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOverloaded
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mOverloaded = Value
			  
			  If Self.NameLabel.Bold <> Value Then
			    Self.NameLabel.Bold = Value
			  End If
			  If Self.DismissButton.Visible <> Value Then
			    Self.DismissButton.Visible = Value
			  End If
			End Set
		#tag EndSetter
		IsOverloaded As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mKey As Beacon.ConfigKey
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyNameWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverloaded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SettingChangeDelegate As OtherSettingsConfigEditor.SettingChangeDelegate
	#tag EndProperty


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
			Type="Color"
			EditorType="Color"
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
			Name="EraseBackground"
			Visible=false
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
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
			InitialValue="False"
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
	#tag EndViewBehavior
End Class
#tag EndClass
