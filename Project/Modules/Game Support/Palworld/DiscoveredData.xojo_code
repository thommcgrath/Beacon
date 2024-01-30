#tag Class
Protected Class DiscoveredData
Inherits Beacon.DiscoveredData
	#tag CompatibilityFlags = ( TargetDesktop and ( Target32Bit or Target64Bit ) )
	#tag Method, Flags = &h0
		Function Profile() As Palworld.ServerProfile
		  Return Palworld.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Profile(Assigns Value As Palworld.ServerProfile)
		  Super.Profile = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SettingsIniContent() As String
		  Return Self.mSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SettingsIniContent(Assigns Value As String)
		  Self.mSettingsIniContent = Value.GuessEncoding("/Script/")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSettingsIniContent As String
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
