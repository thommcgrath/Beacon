#tag Class
Protected Class Map
Implements Beacon.Map
	#tag Method, Flags = &h0
		Sub Constructor(Row As RowSet)
		  Self.Constructor(Row.Column("object_id").StringValue,_
		  Row.Column("label").StringValue,_
		  Row.Column("ark_identifier").StringValue,_
		  Row.Column("mask").Value.UInt64Value,_
		  Row.Column("difficulty_scale").DoubleValue,_
		  Row.Column("type").StringValue,_
		  Row.Column("content_pack_id").StringValue,_
		  Row.Column("sort").IntegerValue,_
		  Row.Column("cycle_scale_multiplier").DoubleValue,_
		  Row.Column("day_scale_multiplier").DoubleValue,_
		  Row.Column("night_scale_multiplier").DoubleValue,_
		  Row.Column("day_start_time").IntegerValue,_
		  Row.Column("day_end_time").IntegerValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MapId As String, HumanName As String, Identifier As String, Mask As UInt64, DifficultyScale As Double, Type As String, ContentPackId As String, Sort As Integer)
		  Self.Constructor(MapId, HumanName, Identifier, Mask, DifficultyScale, Type, ContentPackId, Sort, 1.0, 1.0, 1.0, 18900, 73440)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MapId As String, HumanName As String, Identifier As String, Mask As UInt64, DifficultyScale As Double, Type As String, ContentPackId As String, Sort As Integer, CycleScaleMultiplier As Double, DayScaleMultiplier As Double, NightScaleMultiplier As Double, DayStartTime As Integer, DayEndTime As Integer)
		  Select Case Type
		  Case Beacon.MapTypeCanon, Beacon.MapTypeNonCanon, Beacon.MapTypeThirdParty
		  Else
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Map type must be one of '" + Beacon.MapTypeCanon + "', '" + Beacon.MapTypeNonCanon + "', or '" + Beacon.MapTypeThirdParty + "'."
		    Raise Err
		  End Select
		  
		  Self.mMapId = MapId
		  Self.mName = HumanName
		  Self.mIdentifier = Identifier
		  Self.mMask = Mask
		  Self.mDifficultyScale = DifficultyScale
		  Self.mType = Type
		  Self.mContentPackId = ContentPackId
		  Self.mSort = Sort
		  Self.mCycleScaleMultiplier = CycleScaleMultiplier
		  Self.mDayScaleMultiplier = DayScaleMultiplier
		  Self.mNightScaleMultiplier = NightScaleMultiplier
		  Self.mDayStartTime = DayStartTime
		  Self.mDayEndTime = DayEndTime
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  // Part of the Beacon.Map interface.
		  
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CycleScaleMultiplier() As Double
		  Return Self.mCycleScaleMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DayEndTime() As Integer
		  Return Self.mDayEndTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DayLength() As Integer
		  Return Self.mDayEndTime - Self.mDayStartTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DayRealtimeSeconds(SecondsPerHour As Double) As Double
		  Return (Self.DayLength / 3600) * (SecondsPerHour / (Self.mCycleScaleMultiplier * Self.mDayScaleMultiplier))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DayScaleMultiplier() As Double
		  Return Self.mDayScaleMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DayStartTime() As Integer
		  Return Self.mDayStartTime
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
		  
		  Return ArkSA.Identifier
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
		Function NightLength() As Integer
		  Return 86400 - Self.DayLength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NightRealtimeSeconds(SecondsPerHour As Double) As Double
		  Return (Self.NightLength / 3600) * (SecondsPerHour / (Self.mCycleScaleMultiplier * Self.mNightScaleMultiplier))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NightScaleMultiplier() As Double
		  Return Self.mNightScaleMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.Map) As Integer
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
		  Return Self.mType
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCycleScaleMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDayEndTime As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDayScaleMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDayStartTime As Integer
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
		Private mNightScaleMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As String
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
