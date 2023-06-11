#tag Class
Protected Class ControlGroup
Implements Iterable
	#tag Method, Flags = &h0
		Sub Append(Ctl As DesktopUIControl)
		  If Self.IndexOf(Ctl) = -1 Then
		    Self.mMembers.Add(New WeakRef(Ctl))
		    Self.UpdateBounds()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray Controls() As DesktopUIControl)
		  For Each Ctl As DesktopUIControl In Controls
		    Self.mVisible = Self.mVisible Or Ctl.Visible
		    Self.mMembers.Add(New WeakRef(Ctl))
		  Next
		  Self.UpdateBounds()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Ctl As DesktopUIControl) As Integer
		  For I As Integer = 0 To Self.mMembers.LastIndex
		    If Self.mMembers(I).Value = Ctl Then
		      Return I
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Ctl As DesktopUIControl)
		  If Self.IndexOf(Ctl) = -1 Then
		    Self.mMembers.AddAt(Index, New WeakRef(Ctl))
		    Self.UpdateBounds()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Return New ControlGroupIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mMembers.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Member(Index As Integer) As DesktopUIControl
		  Return DesktopUIControl(Self.mMembers(Index).Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Member(Index As Integer, Assigns Ctl As DesktopUIControl)
		  Self.mMembers(Index) = New WeakRef(Ctl)
		  Self.UpdateBounds()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Offset(X As Integer, Y As Integer)
		  For Each Ref As WeakRef In Self.mMembers
		    If Ref.Value = Nil Then
		      Continue
		    End If
		    
		    Var Ctl As DesktopUIControl = DesktopUIControl(Ref.Value)
		    Ctl.Top = Ctl.Top + Y
		    Ctl.Left = Ctl.Left + X
		  Next
		  Self.mBounds.Offset(X, Y)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As DesktopUIControl
		  Return Self.Member(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Ctl As DesktopUIControl)
		  Self.Member(Index) = Ctl
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mMembers.RemoveAt(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.mMembers.ResizeTo(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateBounds()
		  Var Top, Left, Bottom, Right As Integer
		  Var First As Boolean = True
		  For I As Integer = 0 To Self.mMembers.LastIndex
		    Var Ctl As DesktopUIControl = DesktopUIControl(Self.mMembers(I).Value)
		    If Ctl = Nil Then
		      Continue
		    End If
		    
		    If First Then
		      Top = Ctl.Top
		      Left = Ctl.Left    
		      Bottom = Ctl.Top + Ctl.Height
		      Right = Ctl.Left + Ctl.Width
		      First = False
		    Else
		      Top = Min(Top, Ctl.Top)
		      Left = Min(Left, Ctl.Left)
		      Bottom = Max(Bottom, Ctl.Top + Ctl.Height)
		      Right = Max(Right, Ctl.Left + Ctl.Width)
		    End If
		  Next
		  
		  Self.mBounds = New Xojo.Rect(Left, Top, Right - Left, Bottom - Top)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBounds.Bottom
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var Diff As Integer = Value - Self.Bottom
			  Self.Offset(0, Diff)
			End Set
		#tag EndSetter
		Bottom As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBounds.Height
			End Get
		#tag EndGetter
		Height As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBounds.Left
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var Diff As Integer = Value - Self.Left
			  Self.Offset(Diff, 0)
			End Set
		#tag EndSetter
		Left As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBounds As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMembers() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVisible As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBounds.Right
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var Diff As Integer = Value - Self.Right
			  Self.Offset(Diff, 0)
			End Set
		#tag EndSetter
		Right As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBounds.Top
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var Diff As Integer = Value - Self.Top
			  Self.Offset(0, Diff)
			End Set
		#tag EndSetter
		Top As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mVisible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  For Each Ref As WeakRef In Self.mMembers
			    If Ref.Value = Nil Then
			      Continue
			    End If
			    
			    Var Ctl As DesktopUIControl = DesktopUIControl(Ref.Value)
			    Ctl.Visible = Value
			  Next
			End Set
		#tag EndSetter
		Visible As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBounds.Width
			End Get
		#tag EndGetter
		Width As Integer
	#tag EndComputedProperty


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
		#tag ViewProperty
			Name="Bottom"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Right"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
