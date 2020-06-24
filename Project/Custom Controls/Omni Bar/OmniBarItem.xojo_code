#tag Class
Protected Class OmniBarItem
	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Caption As String, Icon As Picture = Nil)
		  Self.mActiveColor = OmniBarItem.ActiveColors.Accent
		  Self.mAlwaysUseActiveColor = False
		  Self.mCanBeClosed = False
		  Self.mCaption = Caption
		  Self.mEnabled = True
		  Self.mHasProgressIndicator = False
		  Self.mHasUnsavedChanges = False
		  Self.mHelpTag = ""
		  Self.mIcon = Icon
		  Self.mName = Name
		  Self.mProgress = OmniBarItem.ProgressIndeterminate
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mActiveColor <> Value Then
			    Self.mActiveColor = Value
			  End If
			End Set
		#tag EndSetter
		ActiveColor As OmniBarItem.ActiveColors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAlwaysUseActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAlwaysUseActiveColor <> Value Then
			    Self.mAlwaysUseActiveColor = Value
			  End If
			End Set
		#tag EndSetter
		AlwaysUseActiveColor As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCanBeClosed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCanBeClosed <> Value Then
			    Self.mCanBeClosed = Value
			  End If
			End Set
		#tag EndSetter
		CanBeClosed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCaption.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mCaption = Value
			  End If
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEnabled <> Value Then
			    Self.mEnabled = Value
			  End If
			End Set
		#tag EndSetter
		Enabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasProgressIndicator
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasProgressIndicator <> Value Then
			    Self.mHasProgressIndicator = Value
			  End If
			End Set
		#tag EndSetter
		HasProgressIndicator As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasUnsavedChanges
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasUnsavedChanges <> Value Then
			    Self.mHasUnsavedChanges = Value
			  End If
			End Set
		#tag EndSetter
		HasUnsavedChanges As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHelpTag
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHelpTag.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mHelpTag = Value
			  End If
			End Set
		#tag EndSetter
		HelpTag As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mIcon = Value
			End Set
		#tag EndSetter
		Icon As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mActiveColor As OmniBarItem.ActiveColors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAlwaysUseActiveColor As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCanBeClosed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasProgressIndicator As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasUnsavedChanges As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHelpTag As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProgress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProgress <> Value Then
			    Self.mProgress = Value
			  End If
			End Set
		#tag EndSetter
		Progress As Double
	#tag EndComputedProperty


	#tag Constant, Name = ProgressIndeterminate, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


	#tag Enum, Name = ActiveColors, Type = Integer, Flags = &h0
		Accent
		  Blue
		  Brown
		  Gray
		  Green
		  Orange
		  Pink
		  Purple
		  Red
		Yellow
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Super"
			Visible=true
			Group="ID"
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
			Name="ActiveColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="OmniBarItem.ActiveColors"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
