#tag Class
Protected Class LocalDiscoveryEngine
Implements Beacon.DiscoveryEngine
	#tag Method, Flags = &h0
		Sub Begin()
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CommandLineOptions() As Xojo.Core.DIctionary
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return New Xojo.Core.Dictionary
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GameIniContent As Text, GameUserSettingsIniContent As Text)
		  Self.mGameIniContent = GameIniContent
		  Self.mGameUserSettingsIniContent = GameUserSettingsIniContent
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As Text
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As Text
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Map() As UInt64
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Beacon.Maps.TheIsland
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Return "Local Content"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Beacon.ServerProfile
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Text
		  Return "Finished"
		End Function
	#tag EndMethod


	#tag Note, Name = Dummy
		This is basically a dummy class to help with organization
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mGameIniContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
