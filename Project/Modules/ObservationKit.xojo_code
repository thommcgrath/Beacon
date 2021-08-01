#tag Module
Protected Module ObservationKit
	#tag Method, Flags = &h0
		Sub AddObserver(Extends Source As ObservationKit.Observable, Observer As ObservationKit.Observer, ParamArray Keys() As String)
		  For Each Key As String In Keys
		    Source.AddObserver(Observer, Key)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Extends Source As ObservationKit.Observable, Observer As ObservationKit.Observer, ParamArray Keys() As String)
		  For Each Key As String In Keys
		    Source.RemoveObserver(Observer, Key)
		  Next
		End Sub
	#tag EndMethod


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
