#tag Module
Protected Module ObservationKit
	#tag Method, Flags = &h0
		Sub AddObserver(Extends Source As ObservationKit.Observable, Observer As ObservationKit.Observer, ParamArray Keys() As Text)
		  For Each Key As Text In Keys
		    Source.AddObserver(Observer, Key)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Extends Source As ObservationKit.Observable, Observer As ObservationKit.Observer, ParamArray Keys() As Text)
		  For Each Key As Text In Keys
		    Source.RemoveObserver(Observer, Key)
		  Next
		End Sub
	#tag EndMethod


End Module
#tag EndModule
