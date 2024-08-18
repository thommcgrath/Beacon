#tag Class
Protected Class FileTemplate
Inherits Beacon.Template
	#tag Event
		Sub Save(SaveData As Dictionary)
		  Var Vars() As Dictionary
		  For Each Vr As Beacon.FileTemplateVariable In Self.mVariables
		    Vars.Add(Vr.ToDictionary)
		  Next
		  
		  SaveData.Value("MinVersion") = 4
		  SaveData.Value("Body") = Self.mBody
		  SaveData.Value("Variables") = Vars
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Body() As String
		  Return Self.mBody
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.FileTemplate)
		  If Source Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "Source parameter is nil"
		    Raise Err
		  End If
		  
		  Super.Constructor(Source)
		  Self.mBody = Source.mBody
		  
		  Self.mVariables.ResizeTo(Source.mVariables.LastIndex)
		  For Idx As Integer = 0 To Self.mVariables.LastIndex
		    Self.mVariables(Idx) = Source.mVariables(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.Template
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  Var Kind As String = Dict.Lookup("Kind", "LootTemplate")
		  If Kind <> "FileTemplate" Then
		    Return Beacon.Template.FromSaveData(Dict)
		  End If
		  
		  If Dict.HasKey("MinVersion") And Dict.Value("MinVersion").IntegerValue > 4 Then
		    Return Nil
		  End If
		  
		  Var Variables() As Beacon.FileTemplateVariable
		  If Dict.HasKey("Variables") And Dict.Value("Variables").IsNull = False And Dict.Value("Variables").IsArray Then
		    Var VariableDicts() As Dictionary = Dict.Value("Variables").DictionaryArrayValue
		    For Each VariableDict As Dictionary In VariableDicts
		      Var Vr As Beacon.FileTemplateVariable = Beacon.FileTemplateVariable.FromDictionary(VariableDict)
		      If (Vr Is Nil) = False Then
		        Variables.Add(Vr)
		      End If
		    Next
		  End If
		  
		  Var Template As New Beacon.FileTemplate
		  
		  Template.mBody = Dict.Value("Body").StringValue
		  Template.mVariables = Variables
		  
		  Return Template
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return "Common"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As Beacon.FileTemplate
		  Return New Beacon.FileTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.FileTemplate
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Kind() As String
		  Return "FileTemplate"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As Beacon.MutableFileTemplate
		  Return New Beacon.MutableFileTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableFileTemplate
		  Return New Beacon.MutableFileTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variables() As Beacon.FileTemplateVariable()
		  Var Arr() As Beacon.FileTemplateVariable
		  Arr.ResizeTo(Self.mVariables.LastIndex)
		  For Idx As Integer = 0 To Arr.LastIndex
		    Arr(Idx) = Self.mVariables(Idx)
		  Next
		  Return Arr
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mBody As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mVariables() As Beacon.FileTemplateVariable
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
