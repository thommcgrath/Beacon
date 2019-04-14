#tag Class
Private Class ScrollBarScrollDelegate
Implements AnimationKit.Scrollable
	#tag CompatibilityFlags = ( TargetHasGUI )
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ScrollBar)
		  Self.TargetRef = New WeakRef(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMaximum() As Double
		  If Self.Target <> Nil Then
		    Return Self.Target.Maximum
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollMaximum(Assigns Value As Double)
		  If Self.Target <> Nil Then
		    Self.Target.Maximum = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMinimum() As Double
		  If Self.Target <> Nil Then
		    Return Self.Target.Minimum
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollMinimum(Assigns Value As Double)
		  If Self.Target <> Nil Then
		    Self.Target.Minimum = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollPosition() As Double
		  If Self.Target <> Nil Then
		    Return Self.Target.Value
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollPosition(Assigns Value As Double)
		  If Self.Target <> Nil Then
		    Self.Target.Value = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Target() As ScrollBar
		  If TargetRef <> Nil And TargetRef.Value <> Nil Then
		    Return ScrollBar(TargetRef.Value)
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
