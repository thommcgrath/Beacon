#tag Class
Protected Class FooterBarButton
	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Icon As Picture, Align As Integer = AlignLeft)
		  Self.Name = Name
		  Self.Icon = Icon
		  Self.Alignment = Align
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Caption As String, Align As Integer = AlignLeft)
		  Self.Name = Name
		  Self.Caption = Caption
		  Self.Alignment = Align
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Caption As String, Icon As Picture, Align As Integer = AlignLeft)
		  Self.Name = Name
		  Self.Caption = Caption
		  Self.Icon = Icon
		  Self.Alignment = Align
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Alignment As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Caption As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Enabled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Height As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Icon As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Left As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New Xojo.Core.Rect(Self.Left, Self.Top, Self.Width, Self.Height)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.Left = Value.Left
			  Self.Top = Value.Top
			  Self.Width = Value.Width
			  Self.Height = Value.Height
			End Set
		#tag EndSetter
		Rect As Xojo.Core.Rect
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Top As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Width As Integer
	#tag EndProperty


	#tag Constant, Name = AlignCenter, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AlignLeft, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AlignRight, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
