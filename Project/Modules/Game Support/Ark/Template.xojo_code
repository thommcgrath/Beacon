#tag Class
Protected Class Template
Inherits Beacon.Template
	#tag Event
		Sub Save(SaveData As Dictionary)
		  SaveData.Value("Kind") = Self.Kind
		  RaiseEvent Save(SaveData)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.Template
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  Var Game As String = Dict.Lookup("Game", Ark.Identifier)
		  If Game <> Ark.Identifier Then
		    Return Beacon.Template.FromSaveData(Dict)
		  End If
		  
		  Var Kind As String = Dict.Lookup("Kind", "LootTemplate")
		  Select Case Kind
		  Case "LootTemplate"
		    Return Ark.LootTemplate.FromSaveData(Dict)
		  Else
		    App.Log("Unknown Ark.Template kind " + Kind + ".")
		    Return Nil
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameID() As String
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Kind() As String
		  Return "LootTemplate"
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Save(SaveData As Dictionary)
	#tag EndHook


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
