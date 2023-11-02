#tag Class
Protected Class DocumentMergeProfileItem
Inherits Beacon.DocumentMergeItem
	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  Self.Label = Profile.LinkPrefix + " Link: " + Profile.Name
		  Self.mProfile = Profile
		  
		  Var TokenId, TokenKey As String
		  Select Case Profile.ProviderId
		  Case Nitrado.Identifier
		    Var HostConfig As Nitrado.HostConfig = Nitrado.HostConfig(Profile.HostConfig)
		    TokenId = HostConfig.TokenId
		    TokenKey = HostConfig.TokenKey
		  Case GameServerApp.Identifier
		    Var HostConfig As GameServerApp.HostConfig = GameServerApp.HostConfig(Profile.HostConfig)
		    TokenId = HostConfig.TokenId
		    TokenKey = HostConfig.TokenKey
		  End Select
		  If TokenId.IsEmpty = False And TokenKey.IsEmpty = False Then
		    Self.mTokenId = TokenId
		    Self.mTokenKey = TokenKey
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Beacon.ServerProfile
		  Return Self.mProfile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TokenId() As String
		  Return Self.mTokenId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TokenKey() As String
		  Return Self.mTokenKey
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mProfile As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenKey As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
		#tag ViewProperty
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
