#tag Class
Private Class FrameSetIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(Source As AnimationKit.FrameSet)
		  Self.Index = 0
		  Self.Frames = Source
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the Iterator interface.
		  
		  If Self.Index < Self.Frames.LastRowIndex Then
		    Self.Index = Self.Index + 1
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Part of the Iterator interface.
		  
		  Return Self.Frames(Self.Index)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Frames As AnimationKit.FrameSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Index As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
