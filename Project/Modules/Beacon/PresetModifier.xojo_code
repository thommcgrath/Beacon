#tag Class
Protected Class PresetModifier
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function AdvancedPattern() As String
		  Return Self.mAdvancedPattern
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mModifierID = New v4UUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.PresetModifier, NewID As Boolean = False)
		  If NewID Then
		    Self.mModifierID = New v4UUID
		  Else
		    Self.mModifierID = Source.mModifierID
		  End If
		  Self.mLabel = Source.mLabel
		  Self.mPattern = Source.mPattern
		  Self.mAdvancedPattern = Source.mAdvancedPattern
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Label As String, Pattern As String)
		  Self.mModifierID = New v4UUID
		  Self.mLabel = Label
		  Self.mPattern = Pattern
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function CreateEngine(Source As Beacon.LootSource) As JavascriptEngineMBS
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  Var Engine As New JavascriptEngineMBS
		  Engine.GlobalProperty("ColorWhite") = "FFFFFF00"
		  Engine.GlobalProperty("ColorGreen") = "00FF0000"
		  Engine.GlobalProperty("ColorBlue") = "88C8FF00"
		  Engine.GlobalProperty("ColorPurple") = "E6BAFF00"
		  Engine.GlobalProperty("ColorYellow") = "FFF02A00"
		  Engine.GlobalProperty("ColorRed") = "FFBABA00"
		  
		  Var Maps() As Beacon.Map = Beacon.Maps.All
		  For Each Map As Beacon.Map In Maps
		    Engine.GlobalProperty("Mask" + Map.Identifier) = Map.Mask
		  Next
		  
		  Engine.GlobalProperty("BeaconVersion") = App.BuildNumber
		  Engine.GlobalProperty("BeaconVersionString") = App.BuildVersion
		  
		  Var Tags() As String
		  
		  Var Multipliers As New Dictionary
		  Multipliers.Value("Min") = Source.Multipliers.Min
		  Multipliers.Value("Max") = Source.Multipliers.Max
		  
		  Var Obj As New Dictionary
		  Obj.Value("Path") = Source.Path
		  Obj.Value("Class") = Source.ClassString
		  Obj.Value("Label") = Source.Label
		  Obj.Value("Mask") = Source.Availability
		  Obj.Value("Multipliers") = Multipliers
		  Obj.Value("IconColor") = Source.UIColor.ToHex.Uppercase
		  Obj.Value("Tags") = Tags
		  Engine.GlobalPropertyJSON("LootSource") = Beacon.GenerateJSON(Obj, False)
		  
		  Return Engine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Source As Dictionary) As Beacon.PresetModifier
		  If Source = Nil Or Not Source.HasAllKeys("ModifierID", "Pattern", "Label") Then
		    Return Nil
		  End If
		  
		  Var Modifier As New Beacon.PresetModifier
		  Modifier.mModifierID = Source.Value("ModifierID")
		  Modifier.mPattern = Source.Value("Pattern")
		  Modifier.mAdvancedPattern = Source.Lookup("Advanced Pattern", "")
		  Modifier.mLabel = Source.Value("Label")
		  Return Modifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Sources() As Beacon.LootSource) As Beacon.LootSource()
		  Var Results() As Beacon.LootSource
		  For Each Source As Beacon.LootSource In Sources
		    If Self.Matches(Source) Then
		      Results.Add(Source)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Source As Beacon.LootSource) As Boolean
		  If Self.UsesAdvancedPattern = False Then
		    #Pragma BreakOnExceptions False
		    Try
		      Var Reg As New Regex
		      Reg.Options.CaseSensitive = False
		      Reg.SearchPattern = Self.mPattern
		      
		      Return Reg.Search(Source.ClassString) <> Nil
		    Catch Err As RegExException
		      Return False
		    End Try
		    #Pragma BreakOnExceptions Default
		  End If
		  
		  Try
		    Var Engine As JavascriptEngineMBS = Self.CreateEngine(Source)
		    Call Engine.Evaluate("function execute() {" + EndOfLine + Self.mAdvancedPattern + EndOfLine + "}")
		    Var Result As Boolean = Engine.CallFunction("execute")
		    Return Result
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModifierID() As String
		  Return Self.mModifierID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.PresetModifier) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var SelfData As String = Beacon.GenerateJSON(Self.ToDictionary, False)
		  Var OtherData As String = Beacon.GenerateJSON(Other.ToDictionary, False)
		  If SelfData.Compare(OtherData, ComparisonOptions.CaseSensitive) = 0 Then
		    Return 0
		  End If
		  
		  Return Self.Label.Compare(Other.Label, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pattern() As String
		  Return Self.mPattern
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestPattern(ByRef Message As String) As Boolean
		  If Self.UsesAdvancedPattern = False Then
		    Var Reg As New Regex
		    Reg.Options.CaseSensitive = False
		    Reg.SearchPattern = Self.mPattern
		    
		    #Pragma BreakOnExceptions False
		    Try
		      Call Reg.Search("Testing")
		      Message = ""
		      Return True
		    Catch Err As RegexException
		      Message = Err.Message
		      Return False
		    End Try
		    #Pragma BreakOnExceptions Default
		  End If
		  
		  Var Engine As JavaScriptEngineMBS = Self.CreateEngine(Beacon.Data.GetLootSource("SupplyCrate_Level03_C"))
		  Try
		    Call Engine.Evaluate("function execute() {" + EndOfLine + Self.mAdvancedPattern + EndOfLine + "}")
		    Call Engine.CallFunction("execute")
		    Return True
		  Catch Err As RuntimeException
		    Message = Err.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("ModifierID") = Self.mModifierID
		  Dict.Value("Pattern") = Self.mPattern
		  Dict.Value("Advanced Pattern") = Self.mAdvancedPattern
		  Dict.Value("Label") = Self.mLabel
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesAdvancedPattern() As Boolean
		  Return Self.mAdvancedPattern.IsEmpty = False
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAdvancedPattern As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModifierID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPattern As String
	#tag EndProperty


	#tag Constant, Name = AberrationSurfaceBonusCratesID, Type = Text, Dynamic = False, Default = \"b9ea6922-3d19-4333-b2a6-3e518f24d62a", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = AberrationSurfaceCratesID, Type = Text, Dynamic = False, Default = \"e3454afa-d47a-4f9f-9cd9-ceb0171317e4", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = ArtifactCratesID, Type = Text, Dynamic = False, Default = \"87a001d7-5f3b-4d0e-8494-e00c4488e077", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = BasicCratesID, Type = Text, Dynamic = False, Default = \"e350c14c-a3a1-493a-bd5c-b34a530e45cb", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = BonusCratesID, Type = Text, Dynamic = False, Default = \"13299620-1aaa-43a7-9c44-42fc409ea7a1", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = BossesID, Type = Text, Dynamic = False, Default = \"4d70fee5-81c7-48f4-8a97-51057f7e6ac2", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = CaveCratesID, Type = Text, Dynamic = False, Default = \"22b6ba8a-dacb-4bda-945a-26b95d0ad0db", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = DeepSeaCratesID, Type = Text, Dynamic = False, Default = \"4ae8364b-4890-4a53-9d24-204ab5f00411", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = KeyClassString, Type = String, Dynamic = False, Default = \"class_string", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyColor, Type = String, Dynamic = False, Default = \"color", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyLabel, Type = String, Dynamic = False, Default = \"label", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OpenDesertCratesID, Type = Text, Dynamic = False, Default = \"3910ae49-41bc-4307-b395-2c1bb44619b6", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = OperatorEquals, Type = String, Dynamic = False, Default = \"\x3D", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OperatorNotEquals, Type = String, Dynamic = False, Default = \"!\x3D", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OperatorRegex, Type = String, Dynamic = False, Default = \"~\x3D", Scope = Public
	#tag EndConstant


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
