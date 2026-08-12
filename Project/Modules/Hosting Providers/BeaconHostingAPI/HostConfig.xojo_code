#tag Class
Protected Class HostConfig
Inherits Beacon.HostConfig
Implements Beacon.OAuthConsumer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, Version As Integer)
		  #Pragma Unused Version
		  
		  Self.mServerId = SaveData.Lookup("serverId", "")
		  Self.mTokenId = SaveData.Lookup("tokenId", "")
		  Self.mEndpoint = SaveData.Lookup("endpoint", "")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary)
		  // Do not store the token key
		  
		  SaveData.Value("serverId") = Self.mServerId
		  SaveData.Value("tokenId") = Self.mTokenId
		  SaveData.Value("endpoint") = Self.mEndpoint
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CreateProvider(Logger As Beacon.LogProducer = Nil) As Beacon.HostingProvider
		  Return New BeaconHostingAPI.HostingProvider(Logger)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Endpoint() As String
		  Return Self.mEndpoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Endpoint(Assigns Value As String)
		  If Value.EndsWith("/") Then
		    Value = Value.Left(Value.Length - 1)
		  End If
		  
		  If Self.mEndpoint = Value Then
		    Return
		  End If
		  
		  Self.mEndpoint = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderId() As String
		  Return BeaconHostingAPI.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerId() As String
		  Return Self.mServerId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerId(Assigns Value As String)
		  If Self.mServerId = Value Then
		    Return
		  End If
		  
		  Self.mServerId = Value
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

	#tag Method, Flags = &h0
		Function TokenKey() As String
		  Return Self.mTokenKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TokenKey(Assigns Value As String)
		  // The key is not stored persistently, so don't change modified state.
		  
		  Self.mTokenKey = Value
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEndpoint As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenKey As String
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
