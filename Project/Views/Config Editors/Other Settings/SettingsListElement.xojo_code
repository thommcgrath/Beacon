#tag Class
Protected Class SettingsListElement
Inherits ContainerControl
	#tag Event
		Sub Open()
		  RaiseEvent Open()
		  RaiseEvent KeyChanged(Self.mKey)
		End Sub
	#tag EndEvent

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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Delete()
		  RaiseEvent ShouldDelete()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DescriptionLabel() As Label
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As Beacon.ConfigKey
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Key(Assigns NewKey As Beacon.ConfigKey)
		  If (Self.mKey Is Nil) = False And (NewKey Is Nil) = False And Self.mKey.UUID = NewKey.UUID Then
		    Return
		  ElseIf Self.mKey Is Nil And NewKey Is Nil Then
		    Return
		  End If
		  
		  Self.mKey = NewKey
		  RaiseEvent KeyChanged(NewKey)
		End Sub
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


	#tag Hook, Flags = &h0
		Event KeyChanged(NewKey As Beacon.ConfigKey)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldDelete()
	#tag EndHook


	#tag Property, Flags = &h1
		Protected mKey As Beacon.ConfigKey
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyNameWidth As Integer
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
	#tag EndViewBehavior
End Class
#tag EndClass
