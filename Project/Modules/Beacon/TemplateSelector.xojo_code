#tag Class
Protected Class TemplateSelector
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function Code() As String
		  Return Self.mCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SelectorUUID As String, Label As String, GameID As String, Language As Beacon.TemplateSelector.Languages, Code As String)
		  If SelectorUUID.IsEmpty Then
		    SelectorUUID = New v4UUID
		  End If
		  
		  Self.mCode = Code
		  Self.mGameID = GameID
		  Self.mLabel = Label
		  Self.mLanguage = Language
		  Self.mSelectorUUID = SelectorUUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.TemplateSelector
		  Var SelectorUUID As String
		  If Dict.HasKey("UUID") Then
		    SelectorUUID = Dict.Value("UUID")
		  ElseIf Dict.HasKey("ModifierID") Then
		    SelectorUUID = Dict.Value("ModifierID")
		  Else
		    Return Nil
		  End If
		  
		  Var Language As Beacon.TemplateSelector.Languages
		  Var Code As String
		  If Dict.HasKey("Language") And Dict.HasKey("Code") Then
		    Code = Dict.Value("Code")
		    Language = StringToLanguage(Dict.Value("Language").StringValue)
		  ElseIf Dict.HasKey("Advanced Pattern") Then
		    Code = Dict.Value("Advanced Pattern")
		    Language = Beacon.TemplateSelector.Languages.JavaScript
		  ElseIf Dict.HasKey("Pattern") Then
		    Code = Dict.Value("Pattern")
		    Language = Beacon.TemplateSelector.Languages.RegEx
		  Else
		    Return Nil
		  End If
		  
		  Var Label As String = Dict.Lookup("Label", "Untitled Template Selector")
		  Var GameID As String = Dict.Lookup("Game", Ark.Identifier)
		  
		  Return New Beacon.TemplateSelector(SelectorUUID, Label, GameID, Language, Code)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameID() As String
		  Return Self.mGameID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Language() As Beacon.TemplateSelector.Languages
		  Return Self.mLanguage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function LanguageToString(Language As Beacon.TemplateSelector.Languages) As String
		  Select Case Language
		  Case Beacon.TemplateSelector.Languages.RegEx
		    Return "regex"
		  Case Beacon.TemplateSelector.Languages.JavaScript
		    Return "javascript"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Game") = Self.mGameID
		  Dict.Value("UUID") = Self.mSelectorUUID
		  Dict.Value("Label") = Self.mLabel
		  Dict.Value("Language") = Self.LanguageToString(Self.mLanguage)
		  Dict.Value("Code") = Self.mCode
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function StringToLanguage(Value As String) As Beacon.TemplateSelector.Languages
		  Select Case Value
		  Case "regex"
		    Return Beacon.TemplateSelector.Languages.RegEx
		  Case "js", "javascript"
		    Return Beacon.TemplateSelector.Languages.JavaScript
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mSelectorUUID
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Save(SaveData As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h1
		Protected mCode As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGameID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLanguage As Beacon.TemplateSelector.Languages
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSelectorUUID As String
	#tag EndProperty


	#tag Enum, Name = Languages, Type = Integer, Flags = &h0
		RegEx
		JavaScript
	#tag EndEnum


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
