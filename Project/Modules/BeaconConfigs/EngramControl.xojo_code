#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class EngramControl
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  For Each Points As Integer In Self.mPointsPerLevel
		    Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverridePlayerLevelEngramPoints", Points.ToString))
		  Next
		  
		  Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "bOnlyAllowSpecifiedEngrams", If(Self.OnlyAllowSpecifiedEngrams, "True", "False")))
		  Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "bAutoUnlockAllEngrams", If(Self.AutoUnlockAllEngrams, "True", "False")))
		  
		  Var Whitelisting As Boolean = Self.OnlyAllowSpecifiedEngrams
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behaviors As Dictionary = Entry.Value
		    
		    // Get the entry string from the engram if available, or use the backup if not available.
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Entry.Key)
		    Var EntryString As String
		    If Engram <> Nil And Engram.HasUnlockDetails Then
		      EntryString = Engram.EntryString
		    Else
		      EntryString = Behaviors.Value("EntryString")
		    End If
		    
		    If Behaviors.HasKey("AutoUnlockLevel") Then
		      Var AutoUnlockLevel As Integer = Round(Behaviors.Value("AutoUnlockLevel").DoubleValue)
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "EngramEntryAutoUnlocks", "(EngramClassName=""" + EntryString + """,LevelToAutoUnlock=" + AutoUnlockLevel.ToString + ")"))
		    End If
		    
		    Var Arguments() As String
		    If Behaviors.HasKey("Hidden") Then
		      Var Hidden As Boolean = Behaviors.Value("Hidden").BooleanValue
		      If Hidden <> Whitelisting Then
		        Arguments.AddRow("EngramHidden=" + If(Hidden, "True", "False"))
		      End If
		    End If
		    
		    If Behaviors.HasKey("RemovePrerequisites") Then
		      Var RemovePrereq As Boolean = Behaviors.Value("RemovePrerequisites").BooleanValue
		      If RemovePrereq = True Then
		        Arguments.AddRow("RemoveEngramPreReq=True")
		      End If
		    End If
		    
		    If Behaviors.HasKey("PlayerLevel") Then
		      Var Level As Integer = Round(Behaviors.Value("PlayerLevel").DoubleValue)
		      Arguments.AddRow("EngramLevelRequirement=" + Level.ToString)
		    End If
		    
		    If Behaviors.HasKey("PlayerPoints") Then
		      Var Points As Integer = Round(Behaviors.Value("PlayerPoints").DoubleValue)
		      Arguments.AddRow("EngramPointsCost=" + Points.ToString)
		    End If
		    
		    If Arguments.LastRowIndex > -1 Then
		      Arguments.AddRowAt(0, "EngramClassName=""" + EntryString + """")
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideNamedEngramEntries", "(" + Arguments.Join(",") + ")"))
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub NonGeneratedKeys(Keys() As Beacon.ConfigKey)
		  // Include all the keys here to prevent them from going into Custom Config when
		  // Beacon generates lines that are slightly different than imported.
		  
		  Keys.AddRow(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "OverrideEngramEntries"))
		  Keys.AddRow(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "OverrideNamedEngramEntries"))
		  Keys.AddRow(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "bOnlyAllowSpecifiedEngrams"))
		  Keys.AddRow(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "OverridePlayerLevelEngramPoints"))
		  Keys.AddRow(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "bAutoUnlockAllEngrams"))
		  Keys.AddRow(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "EngramEntryAutoUnlocks"))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Whitelist Mode") Then
		    Self.mOnlyAllowSpecifiedEngrams = Dict.Value("Whitelist Mode").BooleanValue
		  End If
		  
		  If Dict.HasKey("Auto Unlock All") Then
		    Self.mAutoUnlockAllEngrams = Dict.Value("Auto Unlock All").BooleanValue
		  End If
		  
		  If Dict.HasKey("Points Per Level") Then
		    Var Values() As Variant = Dict.Value("Points Per Level")
		    Self.mPointsPerLevel.ResizeTo(Values.LastRowIndex)
		    For Idx As Integer = Self.mPointsPerLevel.FirstRowIndex To Self.mPointsPerLevel.LastRowIndex
		      Self.mPointsPerLevel(Idx) = Values(Idx)
		    Next
		  End If
		  
		  If Dict.HasKey("Engrams") Then
		    Self.mBehaviors = Dict.Value("Engrams")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  If Self.mBehaviors.Count > 0 Then
		    Dict.Value("Engrams") = Self.mBehaviors
		  End If
		  
		  If Self.mPointsPerLevel.LastRowIndex > -1 Then
		    Dict.Value("Points Per Level") = Self.mPointsPerLevel
		  End If
		  
		  Dict.Value("Auto Unlock All") = Self.mAutoUnlockAllEngrams
		  Dict.Value("Whitelist Mode") = Self.mOnlyAllowSpecifiedEngrams
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AutoUnlockEngram(Engram As Beacon.Engram) As NullableDouble
		  Var Value As Variant = Self.BehaviorForEngram(Engram, "AutoUnlockLevel")
		  If IsNull(Value) Then
		    Return Nil
		  Else
		    Return Value.DoubleValue
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AutoUnlockEngram(Engram As Beacon.Engram, Assigns Level As NullableDouble)
		  If IsNull(Level) Then
		    Self.BehaviorForEngram(Engram, "AutoUnlockLevel") = Nil
		  Else
		    Self.BehaviorForEngram(Engram, "AutoUnlockLevel") = Level.Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BehaviorForEngram(Engram As Beacon.Engram, Key As String) As Variant
		  If Not Self.mBehaviors.HasKey(Engram.Path) Then
		    Return Nil
		  End If
		  
		  Var Dict As Dictionary = Self.mBehaviors.Value(Engram.Path)
		  If Dict.HasKey(Key) Then
		    Return Dict.Value(Key)
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BehaviorForEngram(Engram As Beacon.Engram, Key As String, Assigns Value As Variant)
		  If IsNull(Value) Then
		    If Self.mBehaviors.HasKey(Engram.Path) = False Then
		      Return
		    End If
		    
		    Var Dict As Dictionary = Self.mBehaviors.Value(Engram.Path)
		    If Dict.HasKey(Key) = False Then
		      Return
		    End If
		    
		    Dict.Remove(Key)
		    If Engram.HasUnlockDetails Then
		      Dict.Value("EntryString") = Engram.EntryString
		    End If
		    Self.mBehaviors.Value(Engram.Path) = Dict
		    Self.Modified = True
		    
		    Return
		  End If
		  
		  Var Dict As Dictionary
		  If Self.mBehaviors.HasKey(Engram.Path) Then
		    Dict = Self.mBehaviors.Value(Engram.Path)
		  Else
		    Dict = New Dictionary
		  End If
		  
		  If Engram.HasUnlockDetails Then
		    Dict.Value("EntryString") = Engram.EntryString
		  End If
		  Dict.Value(Key) = Value
		  Self.mBehaviors.Value(Engram.Path) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return ConfigKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  
		  Self.mBehaviors = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EffectivelyHidden(Engram As Beacon.Engram) As Boolean
		  Var Hidden As NullableBoolean = Self.Hidden(Engram)
		  If IsNull(Hidden) Then
		    Return Self.OnlyAllowSpecifiedEngrams
		  Else
		    Return Hidden.Value
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EffectivelyHidden(Engram As Beacon.Engram, Assigns Hidden As Boolean)
		  // Really just an alias for Hidden.
		  // This *could* compare against OnlyAllowSpecifiedEngrams and set to nil when it matches,
		  // but that would cause confusion if the setting were changed after this is set. So
		  // this style explicitly sets the user intentions, and code generation will figure out
		  // if a line is actually necessary for this.
		  
		  Self.Hidden(Engram) = Hidden
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.EngramControl
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var Config As New BeaconConfigs.EngramControl
		  Config.AutoUnlockAllEngrams = ParsedData.BooleanValue("bAutoUnlockAllEngrams", False)
		  Config.OnlyAllowSpecifiedEngrams = ParsedData.BooleanValue("bOnlyAllowSpecifiedEngrams", False)
		  
		  If ParsedData.HasKey("OverridePlayerLevelEngramPoints") Then
		    Var ParsedValue As Variant = ParsedData.Value("OverridePlayerLevelEngramPoints")
		    Var Overrides() As Variant
		    If ParsedValue.IsArray Then
		      Overrides = ParsedValue
		    Else
		      Overrides.AddRow(ParsedValue)
		    End If
		    
		    For Idx As Integer = Overrides.FirstRowIndex To Overrides.LastRowIndex
		      Var Level As Integer = Idx + 1
		      Var Points As Integer
		      Try
		        Points = Overrides(Idx)
		      Catch Err As RuntimeException
		      End Try
		      Config.PointsForLevel(Level) = Points
		    Next
		  End If
		  
		  If ParsedData.HasKey("EngramEntryAutoUnlocks") Then
		    Var ParsedValue As Variant = ParsedData.Value("EngramEntryAutoUnlocks")
		    Var Unlocks() As Variant
		    If ParsedValue.IsArray Then
		      Unlocks = ParsedValue
		    Else
		      Unlocks.AddRow(ParsedValue)
		    End If
		    
		    For Idx As Integer = Unlocks.FirstRowIndex To Unlocks.LastRowIndex
		      Var Details As Dictionary
		      Try
		        Details = Unlocks(Idx)
		      Catch Err As RuntimeException
		        Continue
		      End Try
		      
		      If Not Details.HasAllKeys("EngramClassName", "LevelToAutoUnlock") Then
		        Continue
		      End If
		      
		      Try
		        Var EntryString As String = Details.Value("EngramClassName")
		        Var Level As Integer = Details.Value("LevelToAutoUnlock")
		        
		        Var Engram As Beacon.Engram = Beacon.Data.GetEngramByEntryString(EntryString)
		        If Engram = Nil Then
		          Engram = Beacon.Engram.CreateFromEntryString(EntryString)
		        End If
		        
		        Config.AutoUnlockEngram(Engram) = Level
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  
		  If ParsedData.HasKey("OverrideNamedEngramEntries") Then
		    Var ParsedValue As Variant = ParsedData.Value("OverrideNamedEngramEntries")
		    Var Overrides() As Variant
		    If ParsedValue.IsArray Then
		      Overrides = ParsedValue
		    Else
		      Overrides.AddRow(ParsedValue)
		    End If
		    
		    For Idx As Integer = Overrides.FirstRowIndex To Overrides.LastRowIndex
		      Var Details As Dictionary
		      Try
		        Details = Overrides(Idx)
		      Catch Err As RuntimeException
		        Continue
		      End Try
		      
		      If Not Details.HasKey("EngramClassName") Then
		        Continue
		      End If
		      
		      Try
		        Var EntryString As String = Details.Value("EngramClassName")
		        Var Engram As Beacon.Engram = Beacon.Data.GetEngramByEntryString(EntryString)
		        If Engram = Nil Then
		          Engram = Beacon.Engram.CreateFromEntryString(EntryString)
		        End If
		        
		        If Details.HasKey("EngramHidden") Then
		          Config.Hidden(Engram) = Details.BooleanValue("EngramHidden", False)
		        End If
		        
		        If Details.HasKey("RemoveEngramPreReq") Then
		          Config.RemovePrerequisites(Engram) = Details.BooleanValue("RemoveEngramPreReq", False)
		        End If
		        
		        If Details.HasKey("EngramLevelRequirement") And Details.Value("EngramLevelRequirement").Type = Variant.TypeDouble Then
		          Config.RequiredPlayerLevel(Engram) = Details.Value("EngramLevelRequirement").DoubleValue
		        End If
		        
		        If Details.HasKey("EngramPointsCost") And Details.Value("EngramPointsCost").Type = Variant.TypeDouble Then
		          Config.RequiredPoints(Engram) = Details.Value("EngramPointsCost").DoubleValue
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  
		  If Config.Modified Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hidden(Engram As Beacon.Engram) As NullableBoolean
		  Var Value As Variant = Self.BehaviorForEngram(Engram, "Hidden")
		  If IsNull(Value) Then
		    Return Nil
		  Else
		    Return Value.BooleanValue
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Hidden(Engram As Beacon.Engram, Assigns Hidden As NullableBoolean)
		  If IsNull(Hidden) Then
		    Self.BehaviorForEngram(Engram, "Hidden") = Nil
		  Else
		    Self.BehaviorForEngram(Engram, "Hidden") = Hidden.Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelsDefined() As Integer
		  Return Self.mPointsPerLevel.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelsDefined(Assigns FinalLevel As Integer)
		  Var LastRowIndex As Integer = FinalLevel - 1
		  If Self.mPointsPerLevel.LastRowIndex = LastRowIndex Then
		    Return
		  End If
		  
		  Self.mPointsPerLevel.ResizeTo(LastRowIndex)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PointsForLevel(Level As Integer) As Integer
		  // This is 1-based, as the player starts at level 1.
		  
		  Var Idx As Integer = Level - 1
		  If Idx < Self.mPointsPerLevel.FirstRowIndex Or Idx > Self.mPointsPerLevel.LastRowIndex Then
		    Return 0
		  End If
		  
		  Return Self.mPointsPerLevel(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PointsForLevel(Level As Integer, Assigns Points As Integer)
		  // This is 1-based, as the player starts at level 1.
		  
		  Var Idx As Integer = Level - 1
		  If Idx < Self.mPointsPerLevel.FirstRowIndex Then
		    Return
		  End If
		  
		  Var Modified As Boolean = Self.Modified
		  Do Until Self.mPointsPerLevel.LastRowIndex >= Idx
		    Self.mPointsPerLevel.AddRow(0)
		    Modified = True
		  Loop
		  
		  If Self.mPointsPerLevel(Idx) <> Points Then
		    Self.mPointsPerLevel(Idx) = Points
		    Modified = True
		  End If
		  Self.Modified = Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Engram As Beacon.Engram)
		  If Not Self.mBehaviors.HasKey(Engram.Path) Then
		    Return
		  End If
		  
		  Self.mBehaviors.Remove(Engram.Path)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemovePrerequisites(Engram As Beacon.Engram) As NullableBoolean
		  Var Value As Variant = Self.BehaviorForEngram(Engram, "RemovePrerequisites")
		  If IsNull(Value) Then
		    Return Nil
		  Else
		    Return Value.BooleanValue
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePrerequisites(Engram As Beacon.Engram, Assigns Value As NullableBoolean)
		  If IsNull(Value) Then
		    Self.BehaviorForEngram(Engram, "RemovePrerequisites") = Nil
		  Else
		    Self.BehaviorForEngram(Engram, "RemovePrerequisites") = Value.Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredPlayerLevel(Engram As Beacon.Engram) As NullableDouble
		  Var Value As Variant = Self.BehaviorForEngram(Engram, "RequiredLevel")
		  If IsNull(Value) Then
		    Return Nil
		  Else
		    Return Value.DoubleValue
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredPlayerLevel(Engram As Beacon.Engram, Assigns Level As NullableDouble)
		  If IsNull(Level) Then
		    Self.BehaviorForEngram(Engram, "PlayerLevel") = Nil
		  Else
		    Self.BehaviorForEngram(Engram, "PlayerLevel") = Level.Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredPoints(Engram As Beacon.Engram) As NullableDouble
		  Var Value As Variant = Self.BehaviorForEngram(Engram, "RequiredPoints")
		  If IsNull(Value) Then
		    Return Nil
		  Else
		    Return Value.DoubleValue
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredPoints(Engram As Beacon.Engram, Assigns Points As NullableDouble)
		  If IsNull(Points) Then
		    Self.BehaviorForEngram(Engram, "PlayerPoints") = Nil
		  Else
		    Self.BehaviorForEngram(Engram, "PlayerPoints") = Points.Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpecifiedEngrams() As Beacon.Engram()
		  Var Engrams() As Beacon.Engram
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByEntryString(Entry.Key)
		    If Engram = Nil Then
		      Var Dict As Dictionary = Entry.Value
		      Engram = Beacon.Engram.CreateFromEntryString(Dict.Value("EntryString"))
		    End If
		    If Engram <> Nil Then
		      Engrams.AddRow(Engram)
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod


	#tag Note, Name = Configs
		OverrideEngramEntries - Target engrams by index. This is not used by Beacon and will be ignored.
		OverrideNamedEngramEntries - Targets engrams by "entry string" such as EngramEntry_Popsicle. Can change the level requirement, remove prerequisites, change point cost, or enable/disable entirely.
		bOnlyAllowSpecifiedEngrams - When true, engrams are hidden by default. Use OverrideNamedEngramEntries to whitelist. When false, OverrideNamedEngramEntries can be used to blacklist engrams.
		OverridePlayerLevelEngramPoints - Needs one per player level. Each defines the number of unlock points earned for that level.
		bAutoUnlockAllEngrams - Unlocks all engrams that are possible to earn at the player's level. Causes server lag when leveling.
		EngramEntryAutoUnlocks - Automatically unlock the specified engram at the given level.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAutoUnlockAllEngrams
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAutoUnlockAllEngrams <> Value Then
			    Self.mAutoUnlockAllEngrams = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AutoUnlockAllEngrams As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAutoUnlockAllEngrams As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBehaviors As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOnlyAllowSpecifiedEngrams As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPointsPerLevel() As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOnlyAllowSpecifiedEngrams
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOnlyAllowSpecifiedEngrams <> Value Then
			    Self.mOnlyAllowSpecifiedEngrams = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		OnlyAllowSpecifiedEngrams As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = ConfigKey, Type = Text, Dynamic = False, Default = \"EngramControl", Scope = Private
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
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OnlyAllowSpecifiedEngrams"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoUnlockAllEngrams"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
