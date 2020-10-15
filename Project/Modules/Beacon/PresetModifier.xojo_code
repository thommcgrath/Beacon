#tag Class
Protected Class PresetModifier
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Do nothing
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.PresetModifier)
		  Self.mModifierID = Source.mModifierID
		  Self.mLabel = Source.mLabel
		  Self.mPattern = Source.mPattern
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Label As String, Pattern As String)
		  Self.mModifierID = New v4UUID
		  Self.mLabel = Label
		  Self.mPattern = Pattern
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Source As Dictionary) As Beacon.PresetModifier
		  If Source = Nil Or Not Source.HasAllKeys("ModifierID", "Pattern", "Label") Then
		    Return Nil
		  End If
		  
		  Var Modifier As New Beacon.PresetModifier
		  Modifier.mModifierID = Source.Value("ModifierID")
		  Modifier.mPattern = Source.Value("Pattern")
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
		  Var Reg As New Regex
		  Reg.Options.CaseSensitive = False
		  Reg.SearchPattern = Self.mPattern
		  
		  For Each Source As Beacon.LootSource In Sources
		    #Pragma BreakOnExceptions False
		    Try
		      If Reg.Search(Source.ClassString) <> Nil Then
		        Results.Add(Source)
		      End If
		    Catch Err As RegExException
		      
		    End Try
		    #Pragma BreakOnExceptions Default
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Source As Beacon.LootSource) As Boolean
		  #Pragma BreakOnExceptions False
		  Try
		    Var Reg As New Regex
		    Reg.Options.CaseSensitive = False
		    Reg.SearchPattern = Self.mPattern
		    
		    Return Reg.Search(Source.ClassString) <> Nil
		  Catch Err As RegExException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModifierID() As String
		  Return Self.mModifierID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pattern() As String
		  Return Self.mPattern
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestPattern(ByRef Message As String) As Boolean
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
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("ModifierID") = Self.mModifierID
		  Dict.Value("Pattern") = Self.mPattern
		  Dict.Value("Label") = Self.mLabel
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModifierID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPattern As String
	#tag EndProperty


	#tag Constant, Name = AberrationSurfaceBonusCratesID, Type = Text, Dynamic = False, Default = \"b9ea6922-3d19-4333-b2a6-3e518f24d62a", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AberrationSurfaceCratesID, Type = Text, Dynamic = False, Default = \"e3454afa-d47a-4f9f-9cd9-ceb0171317e4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ArtifactCratesID, Type = Text, Dynamic = False, Default = \"87a001d7-5f3b-4d0e-8494-e00c4488e077", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BasicCratesID, Type = Text, Dynamic = False, Default = \"e350c14c-a3a1-493a-bd5c-b34a530e45cb", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BonusCratesID, Type = Text, Dynamic = False, Default = \"13299620-1aaa-43a7-9c44-42fc409ea7a1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BossesID, Type = Text, Dynamic = False, Default = \"4d70fee5-81c7-48f4-8a97-51057f7e6ac2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CaveCratesID, Type = Text, Dynamic = False, Default = \"22b6ba8a-dacb-4bda-945a-26b95d0ad0db", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DeepSeaCratesID, Type = Text, Dynamic = False, Default = \"4ae8364b-4890-4a53-9d24-204ab5f00411", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OpenDesertCratesID, Type = Text, Dynamic = False, Default = \"3910ae49-41bc-4307-b395-2c1bb44619b6", Scope = Public
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
