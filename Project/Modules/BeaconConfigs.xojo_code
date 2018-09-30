#tag Module
Protected Module BeaconConfigs
	#tag Method, Flags = &h0
		Function AllConfigNames() As Text()
		  Dim Names(2) As Text
		  Names(0) = "Loot Drops"
		  Names(1) = "Loot Drop Quality Scale"
		  Names(2) = "Difficulty"
		  Return Names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateInstance(GroupName As Text, GroupData As Xojo.Core.Dictionary) As Beacon.ConfigGroup
		  Select Case GroupName
		  Case "Loot Drops"
		    Return New BeaconConfigs.LootDrops(GroupData)
		  Case "Difficulty"
		    Return New BeaconConfigs.Difficulty(GroupData)
		  Case "Loot Drop Quality Scale"
		    Return New BeaconConfigs.LootScale(GroupData)
		  End Select
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
