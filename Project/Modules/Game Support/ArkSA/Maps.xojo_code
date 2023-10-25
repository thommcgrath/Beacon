#tag Module
Protected Module Maps
	#tag Method, Flags = &h1
		Protected Function All() As ArkSA.Map()
		  Return ArkSA.DataSource.Pool.Get(False).GetMaps()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClearCache()
		  mUniversalMask = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt64) As ArkSA.Map()
		  Return ArkSA.DataSource.Pool.Get(False).GetMaps(Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Mask(Extends Maps() As ArkSA.Map) As UInt64
		  Var Bits As UInt64
		  For Each Map As ArkSA.Map In Maps
		    Bits = Bits Or Map.Mask
		  Next
		  Return Bits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MaskForIdentifier(Identifier As String) As UInt64
		  Var Map As ArkSA.Map = ArkSA.DataSource.Pool.Get(False).GetMap(Identifier)
		  If (Map Is Nil) Then
		    Return ArkSA.Maps.UniversalMask
		  End If
		  
		  Return Map.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheIsland() As ArkSA.Map
		  Return ArkSA.DataSource.Pool.Get(False).GetMap("TheIsland")
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
