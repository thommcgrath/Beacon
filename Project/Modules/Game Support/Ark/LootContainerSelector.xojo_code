#tag Class
Protected Class LootContainerSelector
	#tag Method, Flags = &h0
		Function Code() As String
		  Return Self.mCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(TemplateSelector As Beacon.TemplateSelector)
		  Self.mCode = TemplateSelector.Code
		  Self.mLanguage = TemplateSelector.Language
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function CreateEngine(Source As Ark.LootContainer) As JavascriptEngineMBS
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  Var Engine As New JavascriptEngineMBS
		  Var LootColors() As Pair = Ark.LootColors
		  For Each LootColor As Pair In LootColors
		    Engine.GlobalProperty("Color" + LootColor.Left.StringValue) = LootColor.Right.StringValue
		  Next LootColor
		  
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
		Function Language() As Beacon.TemplateSelector.Languages
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
		  Case Beacon.TemplateSelector.Languages.JavaScript
		    Try
		      Var Engine As JavascriptEngineMBS = Self.CreateEngine(Source)
		      Call Engine.Evaluate("function execute() {" + EndOfLine + Self.mCode + EndOfLine + "}")
		      Var Result As Boolean = Engine.CallFunction("execute")
		      Return Result
		    Catch Err As RuntimeException
		      Return False
		    End Try
		  Case Beacon.TemplateSelector.Languages.RegEx
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
		Function TestCode(ByRef Message As String) As Boolean
		  Select Case Self.mLanguage
		  Case Beacon.TemplateSelector.Languages.RegEx
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
		  Case Beacon.TemplateSelector.Languages.JavaScript
		    Var Engine As JavaScriptEngineMBS = Self.CreateEngine(Ark.DataSource.Pool.Get(False).GetLootContainerByUUID("b537ea4d-e0a8-4c92-9763-24d3df5e1562"))
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


	#tag Property, Flags = &h21
		Private mCode As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLanguage As Beacon.TemplateSelector.Languages
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
	#tag EndViewBehavior
End Class
#tag EndClass
