#tag Class
Protected Class TextAreaState
	#tag Method, Flags = &h0
		Sub ApplyTo(Area As CodeEditor)
		  Area.SelectionStart = Self.SelectionStart
		  Area.SelectionLength = Self.SelectionLength
		  Area.VerticalScrollPosition = Self.VerticalScrollPosition
		  Area.HorizontalScrollPosition = Self.HorizontalScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ApplyTo(Area As DesktopTextArea)
		  Area.SelectionStart = Self.SelectionStart
		  Area.SelectionLength = Self.SelectionLength
		  Area.VerticalScrollPosition = Self.VerticalScrollPosition
		  Area.HorizontalScrollPosition = Self.HorizontalScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // No need to do anything
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Area As CodeEditor)
		  Self.VerticalScrollPosition = Area.VerticalScrollPosition
		  Self.SelectionStart = Area.SelectionStart
		  Self.SelectionLength = Area.SelectionLength
		  Self.HorizontalScrollPosition = Area.HorizontalScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Area As DesktopTextArea)
		  Self.VerticalScrollPosition = Area.VerticalScrollPosition
		  Self.SelectionStart = Area.SelectionStart
		  Self.SelectionLength = Area.SelectionLength
		  Self.HorizontalScrollPosition = Area.HorizontalScrollPosition
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		HorizontalScrollPosition As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectionLength As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectionStart As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		VerticalScrollPosition As Integer
	#tag EndProperty


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
			Name="SelectionStart"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerticalScrollPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionLength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HorizontalScrollPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
