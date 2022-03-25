#tag Class
Protected Class RangeField
Inherits UITweaks.ResizedTextField
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If RaiseEvent KeyDown(Key) Then
		    Return True
		  End If
		  
		  Var Code As Integer = Key.Asc
		  Select Case Code
		  Case 10, 13, 3
		    Self.CheckValue()
		    Return True
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub LostFocus()
		  Self.CheckValue()
		  RaiseEvent LostFocus
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub CheckValue()
		  Call Self.Validate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  Self.Text = ""
		  Self.mLastNotifiedValue = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Format(Value As Double) As String
		  If Floor(Value) = Value Then
		    // Integer
		    Return Value.ToString(Locale.Current, ",##0")
		  Else
		    // Double
		    Return Value.ToString(Locale.Current, ",##0.0####")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetValue(Value As String)
		  If Self.Text <> Value Then
		    Self.Text = Value
		  End If
		  If Self.mLastNotifiedValue <> Value Then
		    Self.mLastNotifiedValue = Value
		    RaiseEvent ValueChanged()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Validate() As Boolean
		  If RaiseEvent AllowContents(Me.Text) Then
		    Self.SetValue(Self.Text) // Fires TextChanged only if necessary
		    Return True
		  End If
		  
		  If Not IsNumeric(Self.Text) Then
		    System.Beep
		    Self.SetValue(Self.mLastNotifiedValue)
		    Return False
		  End If
		  
		  Var MinValue, MaxValue As Double
		  RaiseEvent GetRange(MinValue, MaxValue)
		  
		  Var Value As Double
		  Try
		    Value = Double.FromString(Self.Text.Trim, Locale.Current)
		  Catch Err As InvalidArgumentException
		  End Try
		  Var Formatted As String
		  Var Valid As Boolean
		  If Value < MinValue Then
		    Formatted = Self.Format(MinValue)
		    RaiseEvent RangeError(Value, MinValue)
		  ElseIf Value > MaxValue Then
		    Formatted = Self.Format(MaxValue)
		    RaiseEvent RangeError(Value, MaxValue)
		  Else
		    Formatted = Self.Format(Value)
		    Valid = True
		  End If
		  Self.SetValue(Formatted)
		  
		  Return Valid
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AllowContents(Value As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyDown(Key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LostFocus()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RangeError(DesiredValue As Double, NewValue As Double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Try
			    Return Double.FromString(Self.Text.Trim, Locale.Current)
			  Catch Err As RuntimeException
			    Return 0
			  End Try
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If IsNumeric(Me.Text.Trim) = False Or Double.FromString(Self.Text.Trim, Locale.Current) <> Value Then
			    Var MinValue, MaxValue As Double
			    RaiseEvent GetRange(MinValue, MaxValue)
			    
			    Var Formatted As String
			    If Value < MinValue Then
			      Formatted = Self.Format(MinValue)
			      RaiseEvent RangeError(Value, MinValue)
			    ElseIf Value > MaxValue Then
			      Formatted = Self.Format(MaxValue)
			      RaiseEvent RangeError(Value, MaxValue)
			    Else
			      Formatted = Self.Format(Value)
			    End If
			    
			    Self.SetValue(Formatted)
			  End If
			End Set
		#tag EndSetter
		DoubleValue As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastNotifiedValue As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinValue As Double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="Initial State"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
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
			Name="BackgroundColor"
			Visible=true
			Group="Appearance"
			InitialValue="&hFFFFFF"
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
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
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hint"
			Visible=true
			Group="Initial State"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextAlignment"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="TextAlignments"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Left"
				"2 - Center"
				"3 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSpellChecking"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximumCharactersAllowed"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidationMask"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataSource"
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
			Name="Format"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
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
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
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
			Name="LockRight"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="TextColor"
			Visible=true
			Group="Appearance"
			InitialValue="&h000000"
			Type="Color"
			EditorType="Color"
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
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="80"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
