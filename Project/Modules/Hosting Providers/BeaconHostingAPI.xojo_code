#tag Module
Protected Module BeaconHostingAPI
	#tag Method, Flags = &h1
		Protected Sub Init()
		  mDetailsLock = New CriticalSection
		  mDetailsLock.Type = Thread.Types.Preemptive
		  mEndpointDetails = New Dictionary
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDetailsLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEndpointDetails As Dictionary
	#tag EndProperty


	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"BeaconHostingAPI", Scope = Protected
	#tag EndConstant


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
End Module
#tag EndModule
