#tag Class
Protected Class HostConfig
Inherits Beacon.HostConfig
Implements Beacon.OAuthConsumer
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, Version As Integer)
		  #Pragma Unused Version
		  
		  Self.mTemplateId = SaveData.Lookup("templateId", 0)
		  Self.mTokenId = SaveData.Lookup("tokenId", "")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary)
		  SaveData.Value("templateId") = Self.mTemplateId
		  SaveData.Value("tokenId") = Self.mTokenId
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ProviderId() As String
		  Return GameServerApp.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TemplateId() As Integer
		  Return Self.mTemplateId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TemplateId(Assigns Value As Integer)
		  If Self.mTemplateId = Value Then
		    Return
		  End If
		  
		  Self.mTemplateId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TokenId() As String
		  Return Self.mTokenId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TokenId(Assigns Value As String)
		  If Self.mTokenId = Value Then
		    Return
		  End If
		  
		  Self.mTokenId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mTemplateId As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenId As String
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
