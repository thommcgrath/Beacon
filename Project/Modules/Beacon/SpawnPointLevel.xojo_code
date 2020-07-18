#tag Class
Protected Class SpawnPointLevel
	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SpawnPointLevel)
		  Self.Difficulty = Source.Difficulty
		  Self.MaxLevel = Source.MaxLevel
		  Self.MinLevel = Source.MinLevel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MinLevel As Double, MaxLevel As Double, Difficulty As Double)
		  Self.MinLevel = MinLevel
		  Self.MaxLevel = MaxLevel
		  Self.Difficulty = Difficulty
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.SpawnPointLevel
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  If Dict.HasAllKeys("min_level", "max_level", "difficulty") Then
		    Return New Beacon.SpawnPointLevel(Dict.Value("min_level"), Dict.Value("max_level"), Dict.Value("difficulty"))
		  ElseIf Dict.HasAllKeys("Min", "Max", "Diff") = False Then
		    Return New Beacon.SpawnPointLevel(Dict.Value("Min"), Dict.Value("Max"), Dict.Value("Diff"))
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromUserLevel(MinLevel As Integer, MaxLevel As Integer, Difficulty As Double) As Beacon.SpawnPointLevel
		  // See note Formula
		  
		  Var Levels As New Beacon.SpawnPointLevel(0, 0, 0)
		  Levels.MinLevel = Max(Ceil(MinLevel / Difficulty), 1.0)
		  Levels.MaxLevel = Max(Ceil(MaxLevel / Difficulty), 1.0) + 0.999999
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.SpawnPointLevel) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.MinLevel < Other.MinLevel Then
		    Return -1
		  ElseIf Self.MinLevel > Other.MinLevel Then
		    Return 1
		  End If
		  
		  If Self.MaxLevel < Other.MaxLevel Then
		    Return -1
		  ElseIf Self.MaxLevel > Other.MaxLevel Then
		    Return 1
		  End If
		  
		  If Self.Difficulty < Other.Difficulty Then
		    Return -1
		  ElseIf Self.Difficulty > Other.Difficulty Then
		    Return 1
		  End If
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("min_level") = Self.MinLevel
		  Dict.Value("max_level") = Self.MaxLevel
		  Dict.Value("difficulty") = Self.Difficulty
		  Return Dict
		End Function
	#tag EndMethod


	#tag Note, Name = Formula
		Max level of 150 should equal 30.999999 at 5.0 difficulty
		This maximizes the likihood of max level creatures.
		A dino level is computed as `Floor(MinLevel + (RNG * (MaxLevel - MinLevel))) * Difficulty`
		Examples:
		Floor(1.0 + (0.95 * (30.999999 - 1.0))) = 29 * Difficulty = 145
		Floor(1.0 + (0.97 * (30.999999 - 1.0))) = 30 * Difficulty = 150
		Floor(1.0 + (1.00 * (30.999999 - 1.0))) = 30 * Difficulty = 150
		
		Without the nines, the formulas would look like:
		Floor(1.0 + (0.95 * (30 - 1.0))) = 28 * Difficulty = 140
		Floor(1.0 + (0.97 * (30 - 1.0))) = 29 * Difficulty = 145
		Floor(1.0 + (1.00 * (30 - 1.0))) = 30 * Difficulty = 150
		Only a perfect 1.0 RNG value would produce a 150
		
		And a value of 31 would mean a level 155 would be possible
		Floor(1.0 + (1.00 * (31 - 1.0))) = 31 * Difficulty = 155
	#tag EndNote


	#tag Property, Flags = &h0
		Difficulty As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		MaxLevel As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		MinLevel As Double
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
		#tag ViewProperty
			Name="MinLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Difficulty"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
