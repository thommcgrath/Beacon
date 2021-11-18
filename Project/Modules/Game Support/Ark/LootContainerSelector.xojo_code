#tag Class
Protected Class LootContainerSelector
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function Code() As String
		  Return Self.mCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mUUID = New v4UUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.LootContainerSelector, NewID As Boolean = False)
		  If NewID Then
		    Self.mUUID = New v4UUID
		  Else
		    Self.mUUID = Source.mUUID
		  End If
		  Self.mLabel = Source.mLabel
		  Self.mCode = Source.mCode
		  Self.mLanguage = Source.mLanguage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(UUID As String, Label As String, Language As String, Code As String)
		  Self.mUUID = UUID
		  Self.mLabel = Label
		  Self.mLanguage = Language
		  Self.mCode = Code
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function CreateEngine(Source As Ark.LootContainer) As JavascriptEngineMBS
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
		  Engine.GlobalProperty("ColorCyan") = "00FFFF00"
		  Engine.GlobalProperty("ColorOrange") = "FFA50000"
		  
		  Var Maps() As Ark.Map = Ark.Maps.All
		  For Each Map As Ark.Map In Maps
		    Engine.GlobalProperty("Mask" + Map.Identifier) = Map.Mask
		  Next
		  
		  Engine.GlobalProperty("BeaconVersion") = App.BuildNumber
		  Engine.GlobalProperty("BeaconVersionString") = App.BuildVersion
		  
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
		  Obj.Value("Tags") = Source.Tags
		  Obj.Value("Experimental") = Source.Experimental
		  
		  Var JSON As String = Beacon.GenerateJSON(Obj, False)
		  Engine.GlobalPropertyJSON("LootSource") = JSON
		  Engine.GlobalPropertyJSON("LootContainer") = JSON
		  
		  Return Engine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Source As Dictionary) As Ark.LootContainerSelector
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  If Source.HasAllKeys("UUID", "Label", "Language", "Code") Then
		    Var LootSelector As New Ark.LootContainerSelector
		    LootSelector.mUUID = Source.Value("UUID")
		    LootSelector.mLabel = Source.Value("Label")
		    LootSelector.mLanguage = Source.Value("Language")
		    LootSelector.mCode = Source.Value("Code")
		    Return LootSelector
		  End If
		  
		  If Source.HasAllKeys("ModifierID", "Pattern", "Label") Then
		    Var LootSelector As New Ark.LootContainerSelector
		    LootSelector.mUUID = Source.Value("ModifierID")
		    LootSelector.mLabel = Source.Value("Label")
		    
		    Var JavaScriptPattern As String = Source.Lookup("Advanced Pattern", "")
		    If JavaScriptPattern.IsEmpty = False Then
		      LootSelector.mLanguage = Ark.LootContainerSelector.LanguageJavaScript
		      LootSelector.mCode = JavaScriptPattern
		    Else
		      LootSelector.mLanguage = Ark.LootContainerSelector.LanguageRegEx
		      LootSelector.mCode = Source.Value("Pattern")
		    End If
		    
		    Return LootSelector
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableClone() As Ark.LootContainerSelector
		  Return New Ark.LootContainerSelector(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootContainerSelector
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Language() As String
		  Return Self.mLanguage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Sources() As Ark.LootContainer) As Ark.LootContainer()
		  Var Results() As Ark.LootContainer
		  For Each Source As Ark.LootContainer In Sources
		    If Self.Matches(Source) Then
		      Results.Add(Source)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Source As Ark.LootContainer) As Boolean
		  Select Case Self.mLanguage
		  Case Self.LanguageJavaScript
		    Try
		      Var Engine As JavascriptEngineMBS = Self.CreateEngine(Source)
		      Call Engine.Evaluate("function execute() {" + EndOfLine + Self.mCode + EndOfLine + "}")
		      Var Result As Boolean = Engine.CallFunction("execute")
		      Return Result
		    Catch Err As RuntimeException
		      Return False
		    End Try
		  Case Self.LanguageRegEx
		    #Pragma BreakOnExceptions False
		    Try
		      Var Reg As New Regex
		      Reg.Options.CaseSensitive = False
		      Reg.SearchPattern = Self.mCode
		      
		      Return Reg.Search(Source.ClassString) <> Nil
		    Catch Err As RegExException
		      Return False
		    End Try
		    #Pragma BreakOnExceptions Default
		  End Select
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
		Function MutableClone() As Ark.LootContainerSelector
		  Return New Ark.MutableLootContainerSelector(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.LootContainerSelector
		  Return New Ark.MutableLootContainerSelector(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.LootContainerSelector) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var SelfData As String = Beacon.GenerateJSON(Self.SaveData(False), False)
		  Var OtherData As String = Beacon.GenerateJSON(Other.SaveData(False), False)
		  If SelfData.Compare(OtherData, ComparisonOptions.CaseSensitive) = 0 Then
		    Return 0
		  End If
		  
		  Return Self.Label.Compare(Other.Label, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(CompatibilityMode As Boolean) As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("UUID") = Self.mUUID
		  Dict.Value("Label") = Self.mLabel
		  Dict.Value("Language") = Self.mLanguage
		  Dict.Value("Code") = Self.mCode
		  If CompatibilityMode Then
		    Dict.Value("ModifierID") = Self.mUUID
		    Select Case Self.mLanguage
		    Case Self.LanguageRegEx
		      Dict.Value("Pattern") = Self.mCode
		    Case Self.LanguageJavaScript
		      Dict.Value("Pattern") = ""
		      Dict.Value("Advanced Pattern") = Self.mCode
		    End Select
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCode(ByRef Message As String) As Boolean
		  Select Case Self.mLanguage
		  Case Self.LanguageRegEx
		    Var Reg As New Regex
		    Reg.Options.CaseSensitive = False
		    Reg.SearchPattern = Self.mCode
		    
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
		  Case Self.LanguageJavaScript
		    Var Engine As JavaScriptEngineMBS = Self.CreateEngine(Ark.DataSource.SharedInstance.GetLootContainerByUUID("b537ea4d-e0a8-4c92-9763-24d3df5e1562"))
		    Try
		      Call Engine.Evaluate("function execute() {" + EndOfLine + Self.mCode + EndOfLine + "}")
		      Call Engine.CallFunction("execute")
		      Return True
		    Catch Err As RuntimeException
		      Message = Err.Message
		      Return False
		    End Try
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mCode As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLanguage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As String
	#tag EndProperty


	#tag Constant, Name = LanguageJavaScript, Type = String, Dynamic = False, Default = \"JavaScript", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LanguageRegEx, Type = String, Dynamic = False, Default = \"RegEx", Scope = Public
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
End Class
#tag EndClass
