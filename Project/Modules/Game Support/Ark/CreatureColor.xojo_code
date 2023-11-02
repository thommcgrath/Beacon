#tag Class
Protected Class CreatureColor
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function ColorValue() As Color
		  Return Color.FromString(Self.mHexValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.CreatureColor)
		  If Source Is Nil Then
		    Return
		  End If
		  
		  Self.mHexValue = Source.mHexValue
		  Self.mID = Source.mID
		  Self.mLabel = Source.mLabel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ID As Integer, Label As String, ColorValue As Color)
		  Self.mID = ID
		  Self.mLabel = Label
		  Self.mHexValue = ColorValue.ToString.Left(6).Lowercase
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ID As Integer, Label As String, HexValue As String)
		  Self.mID = ID
		  Self.mLabel = Label
		  If HexValue.Length >= 6 Then
		    Self.mHexValue = HexValue.Left(6).Lowercase
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HexValue() As String
		  Return Self.mHexValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As Integer
		  Return Self.mID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mHexValue As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mID As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
