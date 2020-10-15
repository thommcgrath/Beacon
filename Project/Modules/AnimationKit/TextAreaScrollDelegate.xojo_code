#tag Class
Private Class TextAreaScrollDelegate
Implements AnimationKit.Scrollable
	#tag CompatibilityFlags = ( TargetHasGUI )
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As TextArea)
		  Self.TargetRef = New WeakRef(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMaximum() As Double
		  If Self.Target <> Nil Then
		    Return Self.Target.LineNumber(Self.Target.Text.Length - 1)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollMaximum(Assigns Value As Double)
		  // Ignored
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMinimum() As Double
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollMinimum(Assigns Value As Double)
		  // Ignored
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollPosition() As Double
		  If Self.Target <> Nil Then
		    Return Self.Target.VerticalScrollPosition
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollPosition(Assigns Value As Double)
		  If Self.Target <> Nil Then
		    Self.Target.VerticalScrollPosition = Round(Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Target() As TextArea
		  If TargetRef <> Nil And TargetRef.Value <> Nil Then
		    Return TextArea(TargetRef.Value)
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private TargetRef As WeakRef
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
