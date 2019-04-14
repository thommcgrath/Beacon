#tag Interface
Protected Interface Observer
	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, Value As Variant)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
