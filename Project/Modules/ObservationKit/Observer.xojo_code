#tag Interface
Protected Interface Observer
	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, OldValue As Variant, NewValue As Variant)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
