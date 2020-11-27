#tag Module
Protected Module Maps
	#tag Method, Flags = &h1
		Protected Function Aberration() As Beacon.Map
		  Return Beacon.Data.GetMap("Aberration_P")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Map()
		  Return Beacon.Data.GetMaps()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CrystalIsles() As Beacon.Map
		  Return Beacon.Data.GetMap("CrystalIsles")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Extinction() As Beacon.Map
		  Return Beacon.Data.GetMap("Extinction")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt64) As Beacon.Map()
		  Return Beacon.Data.GetMaps(Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Genesis() As Beacon.Map
		  Return Beacon.Data.GetMap("Genesis")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MaskForIdentifier(Identifier As String) As UInt64
		  Var Map As Beacon.Map = Beacon.Data.GetMap(Identifier)
		  If (Map Is Nil) Then
		    Return Beacon.Maps.UniversalMask
		  End If
		  
		  Return Map.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Ragnarok() As Beacon.Map
		  Return Beacon.Data.GetMap("Ragnarok")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScorchedEarth() As Beacon.Map
		  Return Beacon.Data.GetMap("ScorchedEarth_P")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheCenter() As Beacon.Map
		  Return Beacon.Data.GetMap("TheCenter")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheIsland() As Beacon.Map
		  Return Beacon.Data.GetMap("TheIsland")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UniversalMask() As UInt64
		  If mUniversalMask = CType(0, UInt64) Then
		    mUniversalMask = All.Mask
		  End If
		  Return mUniversalMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Valguero() As Beacon.Map
		  Return Beacon.Data.GetMap("Valguero_P")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mUniversalMask As UInt64
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
