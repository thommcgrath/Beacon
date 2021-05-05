#tag Class
Protected Class PlayerLevelData
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.mExperience = New Dictionary
		  Self.mPoints = New Dictionary
		  
		  Self.mExperience.Value(1) = 0
		  Self.mPoints.Value(1) = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExperienceForLevel(Level As Integer) As UInt64
		  Return Self.mExperience.Lookup(Level, 0).UInt64Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(JSON As String) As Beacon.PlayerLevelData
		  Try
		    Var Members() As Variant = Beacon.ParseJSON(JSON)
		    Var LevelData As New Beacon.PlayerLevelData
		    For Each Dict As Dictionary In Members
		      If Not Dict.HasAllKeys("level", "xp", "ep") Then
		        Continue
		      End If
		      
		      Var Level As Integer = Dict.Value("level").IntegerValue
		      Var XP As UInt64 = Dict.Value("xp").UInt64Value
		      Var EP As Integer = Dict.Value("ep").IntegerValue
		      
		      LevelData.mMaxLevel = Max(LevelData.mMaxLevel, Level)
		      LevelData.mExperience.Value(Level) = XP
		      LevelData.mPoints.Value(Level) = EP
		    Next
		    Return LevelData
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PointsForLevel(Level As Integer) As Integer
		  Return Self.mPoints.Lookup(Level, 0).IntegerValue
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMaxLevel
			End Get
		#tag EndGetter
		MaxLevel As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mExperience As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPoints As Dictionary
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
			Name="MaxLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
