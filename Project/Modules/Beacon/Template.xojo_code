#tag Class
Protected Class Template
Implements Beacon.NamedItem
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mUUID = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "FromSaveData(JSONItem)" )  Shared Function FromSaveData(Dict As Dictionary) As Beacon.Template
		  Return FromSaveData(New JSONItem(Dict))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(File As FolderItem) As Beacon.Template
		  Var Source As String
		  Try
		    Source = File.Read(Encodings.UTF8)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading template file contents")
		    Return Nil
		  End Try
		  Return FromSaveData(Source)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As JSONItem) As Beacon.Template
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  Var Game As String = Dict.Lookup("Game", Ark.Identifier)
		  Var Template As Beacon.Template
		  Select Case Game
		  Case Ark.Identifier
		    Template = Ark.Template.FromSaveData(Dict)
		  Case ArkSA.Identifier
		    Template = ArkSA.Template.FromSaveData(Dict)
		  End Select
		  If (Template Is Nil) = False Then
		    Template.mUUID = Dict.Value("ID")
		    Template.mLabel = Dict.Value("Label")
		  End If
		  Return Template
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Source As String) As Beacon.Template
		  Var JSON As JSONItem
		  Try
		    JSON = New JSONItem(Source)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing template JSON")
		    Return Nil
		  End Try
		  If JSON.IsArray = False Then
		    Return FromSaveData(JSON)
		  Else
		    App.Log("Parsed template JSON is not a dictionary")
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("ID") = Self.mUUID
		  Dict.Value("Game") = Self.GameId
		  Dict.Value("Label") = Self.mLabel
		  RaiseEvent Save(Dict)
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Save(SaveData As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUUID As String
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
