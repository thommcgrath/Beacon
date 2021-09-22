#tag Class
Protected Class ExperienceCurves
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.ExperienceCurves = Ark.Configs.ExperienceCurves(Other)
		  Self.mDinoLevels.ResizeTo(Source.mDinoLevels.LastIndex)
		  Self.mPlayerLevels.ResizeTo(Source.mPlayerLevels.LastIndex)
		  
		  For Idx As Integer = 0 To Self.mDinoLevels.LastIndex
		    Self.mDinoLevels(Idx) = Source.mDinoLevels(Idx)
		  Next Idx
		  For Idx As Integer = 0 To Self.mPlayerLevels.LastIndex
		    Self.mPlayerLevels(Idx) = Source.mPlayerLevels(Idx)
		  Next Idx
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  If Self.mPlayerLevels.LastIndex > -1 Then
		    Var MaxXP As UInt64 = Self.PlayerMaxExperience
		    
		    // Index 0 is level 2!
		    // Index 150 is level 152
		    // Index 178 is level 180
		    // This is because players start at level 1, not level 0. Then the 0-based array needs to be accounted for.
		    Var Chunks() As String
		    Var LastXP As UInt64
		    For Index As Integer = 0 To Self.mPlayerLevels.LastIndex
		      Var XP As UInt64 = Self.mPlayerLevels(Index)
		      Chunks.Add("ExperiencePointsForLevel[" + Index.ToString + "]=" + XP.ToString)
		      LastXP = XP
		    Next
		    
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "LevelExperienceRampOverrides=(" + Chunks.Join(",") + ")", 0))
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "OverrideMaxExperiencePointsPlayer=" + MaxXP.ToString))
		  ElseIf Self.mPlayerLevels.LastIndex = -1 And Self.mDinoLevels.LastIndex > -1 Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "LevelExperienceRampOverrides=", 0))
		  Else
		    Return Values
		  End If
		  
		  If Self.mDinoLevels.LastIndex > -1 Then
		    Var Chunks() As String
		    Var MaxXP As UInt64 = Self.DinoMaxExperience
		    
		    Var LastXP As UInt64
		    For Index As Integer = 0 To Self.mDinoLevels.LastIndex
		      Var XP As UInt64 = Self.mDinoLevels(Index)
		      Chunks.Add("ExperiencePointsForLevel[" + Index.ToString + "]=" + XP.ToString)
		      LastXP = XP
		    Next
		    
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "LevelExperienceRampOverrides=(" + Chunks.Join(",") + ")", 1))
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "OverrideMaxExperiencePointsDino=" + MaxXP.ToString))
		  End If
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "LevelExperienceRampOverrides"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "OverrideMaxExperiencePointsPlayer"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "OverrideMaxExperiencePointsDino"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  If SaveData.HasKey("Player Levels") Then
		    Var Value As Variant = SaveData.Value("Player Levels")
		    If Value.IsNull = False Then
		      Var Info As Introspection.TypeInfo = Introspection.GetType(Value)
		      If Info.FullName = "UInt64()" Then
		        Self.mPlayerLevels = Value
		      Else
		        Var List() As Variant = SaveData.Value("Player Levels")
		        For Each LevelXP As UInt64 In List
		          Self.mPlayerLevels.Add(LevelXP)
		        Next
		      End If
		    End If
		  ElseIf SaveData.HasAllKeys("Player Curve", "Player Level Cap", "Player Max Experience") Then
		    Var Curve As Beacon.Curve = Beacon.Curve.Import(SaveData.Value("Player Curve"))
		    Var MaxLevel As Integer = SaveData.Value("Player Level Cap")
		    Var MaxXP As UInt64 = SaveData.Value("Player Max Experience")
		    Self.mPlayerLevels = Self.LegacyCurveImport(Curve, MaxLevel, MaxXP)
		  End If
		  
		  If SaveData.HasKey("Dino Levels") Then
		    Var Value As Variant = SaveData.Value("Dino Levels")
		    If Value.IsNull = False Then
		      Var Info As Introspection.TypeInfo = Introspection.GetType(Value)
		      If Info.FullName = "UInt64()" Then
		        Self.mDinoLevels = Value
		      Else
		        Var List() As Variant = SaveData.Value("Dino Levels")
		        For Each LevelXP As UInt64 In List
		          Self.mDinoLevels.Add(LevelXP)
		        Next
		      End If
		    End If
		  ElseIf SaveData.HasAllKeys("Dino Curve", "Dino Level Cap", "Dino Max Experience") Then
		    Var Curve As Beacon.Curve = Beacon.Curve.Import(SaveData.Value("Dino Curve"))
		    Var MaxLevel As Integer = SaveData.Value("Dino Level Cap")
		    Var MaxXP As UInt64 = SaveData.Value("Dino Max Experience")
		    Self.mDinoLevels = Self.LegacyCurveImport(Curve, MaxLevel, MaxXP)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  SaveData.Value("Player Levels") = Self.mPlayerLevels
		  SaveData.Value("Dino Levels") = Self.mDinoLevels
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendDinoExperience(XP As UInt64)
		  If Self.mDinoLevels.LastIndex > -1 And XP < Self.mDinoLevels(Self.mDinoLevels.LastIndex) Then
		    Return
		  End If
		  
		  Self.mDinoLevels.Add(XP)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendPlayerExperience(XP As UInt64)
		  If Self.mPlayerLevels.LastIndex > -1 And XP < Self.mPlayerLevels(Self.mPlayerLevels.LastIndex) Then
		    Return
		  End If
		  
		  Self.mPlayerLevels.Add(XP)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AscensionLevels() As Integer
		  Return Ark.DataSource.SharedInstance.GetIntegerVariable("Ascension Levels")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Var List As String = Ark.DataSource.SharedInstance.GetStringVariable("Player Levels")
		  If List <> "" Then
		    Var Values() As String = List.Split(",")
		    For Each Value As String In Values
		      Self.mPlayerLevels.Add(UInt64.FromString(Value))
		    Next
		  End If
		  
		  List = Ark.DataSource.SharedInstance.GetStringVariable("Dino Levels")
		  If List <> "" Then
		    Var Values() As String = List.Split(",")
		    For Each Value As String In Values
		      Self.mDinoLevels.Add(UInt64.FromString(Value))
		    Next
		  End If
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DinoExperience(Index As Integer) As UInt64
		  Return Self.mDinoLevels(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DinoExperience(Index As Integer, Assigns XP As UInt64)
		  Var PreviousXP, NextXP As UInt64
		  Var PreviousIndex, NextIndex As Integer
		  PreviousXP = Self.FindLowValue(Self.mDinoLevels, Index, PreviousIndex)
		  NextXP = Self.FindHighValue(Self.mDinoLevels, Index, NextIndex)
		  
		  If Self.mDinoLevels(Index) = XP Or (PreviousIndex > -1 And XP < PreviousXP) Or (NextIndex > -1 And XP > NextXP) Then
		    Return
		  End If
		  
		  Self.mDinoLevels(Index) = XP
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DinoLevels() As UInt64()
		  Var Levels() As UInt64
		  Levels.ResizeTo(Self.mDinoLevels.LastIndex)
		  For I As Integer = 0 To Self.mDinoLevels.LastIndex
		    Levels(I) = Self.mDinoLevels(I)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FindHighValue(Values() As UInt64, StartingIndex As Integer, ByRef EndingIndex As Integer) As UInt64
		  If StartingIndex >= Values.LastIndex Then
		    EndingIndex = -1
		    Return 0
		  End If
		  
		  For I As Integer = StartingIndex + 1 To Values.LastIndex
		    If Values(I) > CType(0, UInt64) Then
		      EndingIndex = I
		      Return Values(I)
		    End If
		  Next
		  
		  EndingIndex = -1
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FindLowValue(Values() As UInt64, StartingIndex As Integer, ByRef EndingIndex As Integer) As UInt64
		  If StartingIndex <= 0 Then
		    EndingIndex = -1
		    Return 0
		  End If
		  
		  For I As Integer = StartingIndex - 1 DownTo 0
		    If Values(I) > CType(0, UInt64) Then
		      EndingIndex = I
		      Return Values(I)
		    End If
		  Next
		  
		  EndingIndex = -1
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.ExperienceCurves
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused ContentPacks
		  
		  If Not ParsedData.HasKey("LevelExperienceRampOverrides") Then
		    Return Nil
		  End If
		  
		  Var Values As Variant = ParsedData.Value("LevelExperienceRampOverrides")
		  Var ValuesInfo As Introspection.TypeInfo = Introspection.GetType(Values)
		  Var Overrides() As Variant
		  If ValuesInfo.FullName = "Object()" Then
		    Overrides = Values
		  ElseIf ValuesInfo.FullName = "Dictionary" Then
		    Overrides.Add(Values)
		  Else
		    Return Nil
		  End If
		  
		  Const IdxPlayerData = 0
		  Const IdxTameData = 1
		  
		  Var Config As New Ark.Configs.ExperienceCurves
		  Var Bound As Integer = Min(Overrides.LastIndex, 1)
		  For Idx As Integer = 0 To Bound
		    Try
		      Var Dict As Dictionary = Overrides(Idx)
		      Var Levels() As UInt64
		      For Each Entry As DictionaryEntry In Dict
		        Var Key As String = Entry.Key
		        If Key.BeginsWith("ExperiencePointsForLevel") Then
		          Var OpenTagPosition As Integer = Key.IndexOf("[")
		          Var CloseTagPosition As Integer = Key.IndexOf(OpenTagPosition, "]")
		          If OpenTagPosition = -1 Or CloseTagPosition = -1 Then
		            Continue
		          End If
		          OpenTagPosition = OpenTagPosition + 1
		          Var IndexTxt As String = Key.Middle(OpenTagPosition, CloseTagPosition - OpenTagPosition)
		          Var Index As Integer = Integer.FromString(IndexTxt)
		          If Levels.LastIndex < Index Then
		            Levels.ResizeTo(Index)
		          End If
		          Levels(Index) = Entry.Value
		        End If
		      Next
		      
		      // Now make sure there are no gaps. If there are, fill in
		      // the gap with the average of the surrounding values
		      For I As Integer = 0 To Levels.LastIndex
		        If Levels(I) <> CType(0, UInt64) Then
		          Continue
		        End If
		        
		        Var PreviousXP, NextXP As UInt64
		        Var LowIndex, HighIndex As Integer
		        PreviousXP = FindLowValue(Levels, I, LowIndex)
		        NextXP = FindHighValue(Levels, I, HighIndex)
		        If LowIndex = -1 Or HighIndex = -1 Then
		          Continue
		        End If
		        
		        Var Range As Integer = HighIndex - LowIndex
		        Var Difference As UInt64 = NextXP - PreviousXP
		        Var XPPerLevel As UInt64 = Round(Difference / Range)
		        For X As Integer = LowIndex + 1 To HighIndex - 1
		          Levels(X) = PreviousXP + (XPPerLevel * CType(X - LowIndex, UInt64))
		        Next
		      Next
		      
		      If Idx = IdxPlayerData Then
		        Config.mPlayerLevels = Levels
		      ElseIf Idx = IdxTameData Then
		        Config.mDinoLevels = Levels
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameExperienceCurves
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LegacyCurveImport(Curve As Beacon.Curve, MaxLevel As Integer, MaxXP As UInt64) As UInt64()
		  Var XTimes As Dictionary = PrecomputeCurveX(Curve, MaxLevel, 0.0001)
		  Var Levels() As UInt64
		  For Index As Integer = 0 To MaxLevel - 2
		    Var Level As Integer = Index + 2
		    Var T As Double = XTimes.Value(Level)
		    Var Y As Double = Curve.YForT(T)
		    Var XP As UInt64 = Round(MaxXP * Y)
		    Levels.Add(XP)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerExperience(Index As Integer) As UInt64
		  Return Self.mPlayerLevels(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayerExperience(Index As Integer, Assigns XP As UInt64)
		  Var PreviousXP, NextXP As UInt64
		  Var PreviousIndex, NextIndex As Integer
		  PreviousXP = Self.FindLowValue(Self.mPlayerLevels, Index, PreviousIndex)
		  NextXP = Self.FindHighValue(Self.mPlayerLevels, Index, NextIndex)
		  
		  If Self.mPlayerLevels(Index) = XP Or (PreviousIndex > -1 And XP < PreviousXP) Or (NextIndex > -1 And XP > NextXP) Then
		    Return
		  End If
		  
		  Self.mPlayerLevels(Index) = XP
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerLevels() As UInt64()
		  Var Levels() As UInt64
		  Levels.ResizeTo(Self.mPlayerLevels.LastIndex)
		  For I As Integer = 0 To Self.mPlayerLevels.LastIndex
		    Levels(I) = Self.mPlayerLevels(I)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PrecomputeCurveX(Curve As Beacon.Curve, NumValues As Integer, Precision As Double) As Dictionary
		  If Precision > 1 Then
		    Precision = 1 / Precision
		  End If
		  
		  NumValues = Max(NumValues, 1)
		  
		  Var XTimes As New Dictionary
		  XTimes.Value(0) = 0
		  XTimes.Value(NumValues) = 1
		  
		  If NumValues = 1 Then
		    Return XTimes
		  End If
		  
		  Var XDeltas As New Dictionary
		  XDeltas.Value(0) = 0
		  XDeltas.Value(NumValues) = 0
		  
		  For Time As Double = 0 To 1 Step Precision
		    Try
		      Var X As Double = Curve.XForT(Time)
		      Var ValueRaw As Double = X * NumValues
		      Var Value As Integer = Round(ValueRaw)
		      Var Delta As Double = Abs(ValueRaw - Value)
		      If XDeltas.HasKey(Value) = False Or XDeltas.Value(Value).DoubleValue > Delta Then
		        XTimes.Value(Value) = Time
		        XDeltas.Value(Value) = Delta
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next Time
		  
		  Return XTimes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveDinoExperience(Index As Integer)
		  Self.mDinoLevels.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePlayerExperience(Index As Integer)
		  Self.mPlayerLevels.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDinoLevels.LastIndex + 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.DinoLevelCap = Value Then
			    Return
			  End If
			  
			  Self.mDinoLevels.ResizeTo(Value - 1)
			  Self.Modified = True
			End Set
		#tag EndSetter
		DinoLevelCap As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mDinoLevels.LastIndex > -1 Then
			    Return Self.mDinoLevels(Self.mDinoLevels.LastIndex)
			  End If
			End Get
		#tag EndGetter
		DinoMaxExperience As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDinoLevels() As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerLevels() As UInt64
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlayerLevels.LastIndex + 2
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.PlayerLevelCap = Value Then
			    Return
			  End If
			  
			  Self.mPlayerLevels.ResizeTo(Value - 2)
			  Self.Modified = True
			End Set
		#tag EndSetter
		PlayerLevelCap As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mPlayerLevels.LastIndex > -1 Then
			    Return Self.mPlayerLevels(Self.mPlayerLevels.LastIndex)
			  End If
			End Get
		#tag EndGetter
		PlayerMaxExperience As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.PlayerLevelCap - Self.AscensionLevels
			End Get
		#tag EndGetter
		PlayerSoftLevelCap As Integer
	#tag EndComputedProperty


	#tag Constant, Name = MaxSupportedXP, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Public
	#tag EndConstant


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
			Name="DinoLevelCap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DinoMaxExperience"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerLevelCap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerMaxExperience"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerSoftLevelCap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
