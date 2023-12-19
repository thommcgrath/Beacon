#tag Class
Protected Class MutablePlayerList
Inherits ArkSA.PlayerList
	#tag Method, Flags = &h0
		Sub Add(Player As ArkSA.PlayerInfo)
		  Var Idx As Integer = Self.IndexOf(Player)
		  If Idx = -1 Then
		    Self.mMembers.Add(Player)
		    Self.mModified = True
		  ElseIf Self.mMembers(Idx) <> Player Then
		    Self.mMembers(Idx) = Player
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.PlayerList
		  Return New ArkSA.PlayerList(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Member(AtIndex As Integer, Assigns Player As ArkSA.PlayerInfo)
		  If Player Is Nil Then
		    Self.RemoveAt(AtIndex)
		    Return
		  End If
		  
		  If Self.mMembers(AtIndex) = Player Then
		    Return
		  End If
		  
		  Self.mMembers(AtIndex) = Player
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutablePlayerList
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As String)
		  If Self.mName.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mName = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(NewBound As Integer)
		  Self.ResizeTo(NewBound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(AtIndex As Integer, Assigns Player As ArkSA.PlayerInfo)
		  Self.Member(AtIndex) = Player
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Player As ArkSA.PlayerInfo)
		  Var Idx As Integer = Self.IndexOf(Player)
		  If Idx > -1 Then
		    Self.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(AtIndex As Integer)
		  Self.mMembers.RemoveAt(AtIndex)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(NewBound As Integer)
		  If Self.mMembers.LastIndex = NewBound Then
		    Return
		  End If
		  
		  Self.mMembers.ResizeTo(NewBound)
		End Sub
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
