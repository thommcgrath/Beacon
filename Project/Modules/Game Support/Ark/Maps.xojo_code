#tag Module
Protected Module Maps
	#tag Method, Flags = &h1
		Protected Function Aberration() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("Aberration_P")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function All() As Ark.Map()
		  Return Ark.DataSource.SharedInstance.GetMaps()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClearCache()
		  mUniversalMask = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CrystalIsles() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("CrystalIsles")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Extinction() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("Extinction")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt64) As Ark.Map()
		  Return Ark.DataSource.SharedInstance.GetMaps(Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Genesis() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("Genesis")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Mask(Extends Maps() As Ark.Map) As UInt64
		  Var Bits As UInt64
		  For Each Map As Ark.Map In Maps
		    Bits = Bits Or Map.Mask
		  Next
		  Return Bits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MaskForIdentifier(Identifier As String) As UInt64
		  Var Map As Ark.Map = Ark.DataSource.SharedInstance.GetMap(Identifier)
		  If (Map Is Nil) Then
		    Return Ark.Maps.UniversalMask
		  End If
		  
		  Return Map.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Ragnarok() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("Ragnarok")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScorchedEarth() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("ScorchedEarth_P")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheCenter() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("TheCenter")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheIsland() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("TheIsland")
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
		Protected Function Valguero() As Ark.Map
		  Return Ark.DataSource.SharedInstance.GetMap("Valguero_P")
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
