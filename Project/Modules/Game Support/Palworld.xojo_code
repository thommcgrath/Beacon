#tag Module
Protected Module Palworld
	#tag Method, Flags = &h1
		Protected Function OmniPurchased(Identity As Beacon.Identity) As Boolean
		  Return (Identity Is Nil) = False And Identity.IsOmniFlagged(Beacon.OmniLicense.MinimalGamesFlag)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit)) or  (TargetWeb and (Target32Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Sub SetupCodeEditor(Target As CodeEditor)
		  Const SCE_PROPS_DEFAULT = 0
		  Const SCE_PROPS_COMMENT = 1
		  Const SCE_PROPS_SECTION = 2
		  Const SCE_PROPS_ASSIGNMENT = 3
		  Const SCE_PROPS_DEFVAL = 4
		  Const SCE_PROPS_KEY = 5
		  
		  Target.InitializeLexer("props")
		  
		  Var SectionColor, AssignmentColor, KeywordColor As Color
		  
		  If Color.IsDarkMode Then
		    SectionColor = &cFF7778
		    AssignmentColor = &cCBCBCB
		    KeywordColor = &c19A9FF
		  Else
		    SectionColor = &c7D1012
		    AssignmentColor = &c515151
		    KeywordColor = &c0C51C3
		  End If
		  
		  Target.Style(SCE_PROPS_SECTION).ForeColor = SectionColor
		  Target.Style(SCE_PROPS_ASSIGNMENT).ForeColor = AssignmentColor
		  Target.Style(SCE_PROPS_KEY).ForeColor = KeywordColor
		  Target.Style(SCE_PROPS_SECTION).Bold = True
		  
		  // Unknown colors, make sure they stand out so they can be discovered more readily
		  Target.Style(SCE_PROPS_DEFVAL).ForeColor = &cFF00FF
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Values() As Palworld.ConfigValue)
		  If Values.Count <= 1 Then
		    Return
		  End If
		  
		  Var Sorts() As String
		  Sorts.ResizeTo(Values.LastIndex)
		  For Idx As Integer = 0 To Sorts.LastIndex
		    Sorts(Idx) = Values(Idx).SortKey
		  Next
		  Sorts.SortWith(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, RequiredHeaders() As Beacon.StringList) As String()
		  Var MissingHeaders() As String
		  For Each HeaderChoices As Beacon.StringList In RequiredHeaders
		    Var Found As Boolean = False
		    For Each HeaderChoice As String In HeaderChoices
		      If Content.IndexOf("[" + HeaderChoice + "]") > -1 Then
		        Found = True
		        Exit
		      End If
		    Next
		    
		    If Found = False Then
		      MissingHeaders.Add("[" + HeaderChoices(0) + "]")
		    End If
		  Next HeaderChoices
		  MissingHeaders.Sort
		  Return MissingHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, Filename As String) As String()
		  Var RequiredHeaders() As Beacon.StringList
		  If Filename = Palworld.ConfigFileSettings Then
		    RequiredHeaders = Array(New Beacon.StringList(Palworld.HeaderPalworldSettings))
		  End If
		  Return Palworld.ValidateIniContent(Content, RequiredHeaders)
		End Function
	#tag EndMethod


	#tag Constant, Name = ConfigFileSettings, Type = String, Dynamic = False, Default = \"PalWorldSettings.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Enabled, Type = Boolean, Dynamic = False, Default = \"True", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FullName, Type = String, Dynamic = False, Default = \"Palworld", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderPalworldSettings, Type = String, Dynamic = False, Default = \"/Script/Pal.PalGameWorldSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"Palworld", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackId, Type = String, Dynamic = False, Default = \"2325c10e-c30a-4dd9-883c-df2bb3afb95c", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackName, Type = String, Dynamic = False, Default = \"Palworld User Content", Scope = Protected
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
	#tag EndViewBehavior
End Module
#tag EndModule
