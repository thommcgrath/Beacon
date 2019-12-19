#tag Class
Protected Class SpawnSetOrganizer
	#tag Method, Flags = &h0
		Sub AttachPoint(Point As Beacon.SpawnPoint)
		  Self.mFoundInPoints.AddRow(Point)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Template As Beacon.MutableSpawnPointSet)
		  Self.mTemplate = Template
		  Self.mOriginalHash = Template.Hash
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentHash() As String
		  Return Self.mTemplate.Hash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FoundInPoints() As Beacon.SpawnPoint()
		  Var Arr() As Beacon.SpawnPoint
		  Arr.ResizeTo(Self.mFoundInPoints.LastRowIndex)
		  For I As Integer = 0 To Arr.LastRowIndex
		    Arr(I) = Self.mFoundInPoints(I)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OriginalHash() As String
		  Return Self.mOriginalHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Template() As Beacon.MutableSpawnPointSet
		  Return Self.mTemplate
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFoundInPoints() As Beacon.SpawnPoint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemplate As Beacon.MutableSpawnPointSet
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
		#tag ViewProperty
			Name="mTemplate"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
