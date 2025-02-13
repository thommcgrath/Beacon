#tag Class
Protected Class Template
Inherits Beacon.Template
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Save(SaveData As Dictionary)
		  SaveData.Value("Kind") = Self.Kind
		  RaiseEvent Save(SaveData)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As JSONItem) As Beacon.Template
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  Var Game As String = Dict.Lookup("Game", ArkSA.Identifier)
		  If Game <> ArkSA.Identifier Then
		    Return Beacon.Template.FromSaveData(Dict)
		  End If
		  
		  Var Kind As String = Dict.Lookup("Kind", "LootTemplate")
		  Select Case Kind
		  Case "LootTemplate"
		    Return ArkSA.LootTemplate.FromSaveData(Dict)
		  Else
		    App.Log("Unknown ArkSA.Template kind " + Kind + ".")
		    Return Nil
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return ArkSA.Identifier
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
