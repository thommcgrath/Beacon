#tag Module
Protected Module BeaconUI
	#tag Method, Flags = &h0
		Sub Dismiss(Extends View As iOSView)
		  Declare Sub dismissViewController Lib "UIKit" Selector "dismissViewControllerAnimated:completion:" (parentView As Ptr, animated As Boolean, completion As Ptr)
		  dismissViewController(View.Handle, True, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowModalWithin(Extends View As iOSView, Parent As iOSView)
		  Declare Sub presentViewController Lib "UIKit" Selector "presentViewController:animated:completion:" (parentView As Ptr, viewControllerToPresent As Ptr, animated As Boolean, completion As Ptr)
		  Declare Sub setModalPresentationStyle Lib "UIKit" Selector "setModalPresentationStyle:" (viewControllerToPresent As Ptr, presentationStyle As Integer)
		  
		  setModalPresentationStyle(View.Handle, 2)
		  presentViewController(Parent.Handle, View.Handle, True, Nil)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
