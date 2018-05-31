#tag Class
Protected Class ControlGroup
Implements Xojo.Core.Iterable
	#tag Method, Flags = &h0
		Sub Append(Ctl As RectControl)
		  If Self.IndexOf(Ctl) = -1 Then
		    Self.mMembers.Append(New WeakRef(Ctl))
		    Self.UpdateBounds()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray Controls() As RectControl)
		  For Each Ctl As RectControl In Controls
		    Self.mMembers.Append(New WeakRef(Ctl))
		  Next
		  Self.UpdateBounds()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.UBound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Xojo.Core.Iterable interface.
		  
		  Return New ControlGroupIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Ctl As RectControl) As Integer
		  For I As Integer = 0 To Self.mMembers.Ubound
		    If Self.mMembers(I).Value = Ctl Then
		      Return I
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Ctl As RectControl)
		  If Self.IndexOf(Ctl) = -1 Then
		    Self.mMembers.Insert(Index, New WeakRef(Ctl))
		    Self.UpdateBounds()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Member(Index As Integer) As RectControl
		  Return RectControl(Self.mMembers(Index).Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Member(Index As Integer, Assigns Ctl As RectControl)
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
		    
		    Dim Ctl As RectControl = RectControl(Ref.Value)
		    Ctl.Top = Ctl.Top + Y
		    Ctl.Left = Ctl.Left + X
		  Next
		  Self.mBounds.Offset(X, Y)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mMembers(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As RectControl
		  Return Self.Member(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Ctl As RectControl)
		  Self.Member(Index) = Ctl
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mMembers.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return Self.mMembers.Ubound
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateBounds()
		  Dim Top, Left, Bottom, Right As Integer
		  Dim First As Boolean = True
		  For I As Integer = 0 To Self.mMembers.Ubound
		    Dim Ctl As RectControl = RectControl(Self.mMembers(I).Value)
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
		  
		  Self.mBounds = New REALbasic.Rect(Left, Top, Right - Left, Bottom - Top)
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
			  Dim Diff As Integer = Value - Self.Bottom
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
			  Dim Diff As Integer = Value - Self.Left
			  Self.Offset(Diff, 0)
			End Set
		#tag EndSetter
		Left As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBounds As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMembers() As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBounds.Right
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Diff As Integer = Value - Self.Right
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
			  Dim Diff As Integer = Value - Self.Top
			  Self.Offset(0, Diff)
			End Set
		#tag EndSetter
		Top As Integer
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
