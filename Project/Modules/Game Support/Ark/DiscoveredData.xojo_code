#tag Class
Protected Class DiscoveredData
Inherits Beacon.DiscoveredData
	#tag Method, Flags = &h0
		Function CommandLineOptions() As Dictionary
		  Return Self.mCommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommandLineOptions(Assigns Value As Dictionary)
		  Self.mCommandLineOptions = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As String
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(Assigns Value As String)
		  Self.mGameIniContent = Value.GuessEncoding
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As String
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(Assigns Value As String)
		  Self.mGameUserSettingsIniContent = Value.GuessEncoding
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPrimitivePlus() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.ServerProfile
		  Return Ark.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Profile(Assigns Value As Ark.ServerProfile)
		  Super.Profile = Value
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCommandLineOptions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As String
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
