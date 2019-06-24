#tag Class
Private Class ListboxScrollDelegate
Implements AnimationKit.Scrollable
	#tag CompatibilityFlags = ( TargetHasGUI )
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Listbox)
		  Self.TargetRef = Xojo.Core.WeakRef.Create(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMaximum() As Double
		  If Self.Target <> Nil Then
		    Return Self.Target.ListCount
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
		    Return Self.Target.ScrollPosition
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollPosition(Assigns Value As Double)
		  If Self.Target <> Nil Then
		    Self.Target.ScrollPosition = Round(Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Target() As Listbox
		  If TargetRef <> Nil And TargetRef.Value <> Nil Then
		    Return Listbox(TargetRef.Value)
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private TargetRef As Xojo.Core.WeakRef
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
