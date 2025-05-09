#tag Class
Protected Class Map
Implements Beacon.Map
	#tag Method, Flags = &h0
		Sub Constructor(MapId As String, HumanName As String, Identifier As String, Mask As UInt64, DifficultyScale As Double, Official As Boolean, ContentPackId As String, Sort As Integer)
		  Self.mMapId = MapId
		  Self.mName = HumanName
		  Self.mIdentifier = Identifier
		  Self.mMask = Mask
		  Self.mDifficultyScale = DifficultyScale
		  Self.mOfficial = Official
		  Self.mContentPackId = ContentPackId
		  Self.mSort = Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  // Part of the Beacon.Map interface.
		  
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyOffset(DifficultyValue As Double) As Double
		  Return Min((DifficultyValue - 0.5) / (Self.mDifficultyScale - 0.5), 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyScale() As Double
		  Return Self.mDifficultyScale
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyValue(DifficultyOffset As Double) As Double
		  DifficultyOffset = Min(DifficultyOffset, 1.0)
		  Return (DifficultyOffset * (Self.mDifficultyScale - 0.5)) + 0.5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  // Part of the Beacon.Map interface.
		  
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MapId() As String
		  // Part of the Beacon.Map interface.
		  
		  Return Self.mMapId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask() As UInt64
		  Return Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Value As UInt64) As Boolean
		  Return (Value And Self.mMask) = Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.Map) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mMask > Other.mMask Then
		    Return 1
		  ElseIf Self.mMask < Other.mMask Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As UInt64
		  Return Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "ContentPackId" )  Function ProvidedByContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sort() As Integer
		  // Part of the Beacon.Map interface.
		  
		  Return Self.mSort
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As String
		  If Self.mOfficial Then
		    Return Beacon.MapTypeCanon
		  Else
		    Return Beacon.MapTypeNonCanon
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDifficultyScale As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOfficial As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSort As Integer
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
