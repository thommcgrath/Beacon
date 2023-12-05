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
		  mLabels = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt64) As ArkSA.Map()
		  Return ArkSA.DataSource.Pool.Get(False).GetMaps(Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForMask(Mask As UInt64) As String
		  If mLabels Is Nil Then
		    mLabels = New Dictionary
		  End If
		  
		  If mLabels.HasKey(Mask) Then
		    Return mLabels.Value(Mask).StringValue
		  End If
		  
		  Var Label As String
		  If Mask = CType(0, UInt64) Then
		    Label = "Unused"
		  Else
		    Label = ForMask(Mask).Label
		  End If
		  mLabels.Value(Mask) = Label
		  Return Label
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
		Protected Function MaskForMaps(Maps() As Beacon.Map) As UInt64
		  Var Bits As UInt64
		  For Each Map As Beacon.Map In Maps
		    If Map IsA ArkSA.Map Then
		      Bits = Bits Or ArkSA.Map(Map).Mask
		    End If
		  Next
		  Return Bits
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
		Private mLabels As Dictionary
	#tag EndProperty

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
