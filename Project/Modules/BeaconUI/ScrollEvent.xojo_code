#tag Class
Protected Class ScrollEvent
	#tag Method, Flags = &h0
		Sub Constructor(LineHeight As Integer, DeltaX As Integer, DeltaY As Integer)
		  Self.mLineHeight = LineHeight
		  Self.mMomentumPhase = PhaseNone
		  Self.mHorizontalAmount = LineHeight * DeltaX
		  Self.mVerticalAmount = LineHeight * DeltaY
		  
		  #if TargetCocoa
		    Try
		      Declare Function objc_getClass Lib "/usr/lib/libobjc.dylib" (aClassName As CString) As Ptr
		      Declare Function sel_registerName Lib "/usr/lib/libobjc.dylib" (Name As CString) As Ptr
		      Declare Function GetSharedApplication Lib "Cocoa.framework" Selector "sharedApplication" (Target As Ptr) As Ptr
		      Declare Function GetCurrentEvent Lib "Cocoa.framework" Selector "currentEvent" (Target As Ptr) As Ptr
		      Declare Function RespondsToSelector Lib "Cocoa.framework" Selector "respondsToSelector:" (Target As Ptr, Sel As Ptr) As Boolean
		      Declare Function HasPreciseScrollingDeltas Lib "Cocoa.framework" Selector "hasPreciseScrollingDeltas" (Target As Ptr) As Boolean
		      #if Target64Bit
		        Declare Function ScrollingDeltaX Lib "Cocoa.framework" Selector "scrollingDeltaX" (Target As Ptr) As Double
		        Declare Function ScrollingDeltaY Lib "Cocoa.framework" Selector "scrollingDeltaY" (Target As Ptr) As Double
		      #else
		        Declare Function ScrollingDeltaX Lib "Cocoa.framework" Selector "scrollingDeltaX" (Target As Ptr) As Single
		        Declare Function ScrollingDeltaY Lib "Cocoa.framework" Selector "scrollingDeltaY" (Target As Ptr) As Single
		      #endif
		      Declare Function GetMomentumPhase Lib "Cocoa.framework" Selector "momentumPhase" (Target As Ptr) As Integer
		      Declare Function GetPhase Lib "Cocoa.framework" Selector "phase" (Target As Ptr) As Integer
		      
		      Dim NSApplication As Ptr = objc_getClass("NSApplication")
		      If NSApplication <> Nil Then
		        Dim SharedApplication As Ptr = GetSharedApplication(NSApplication)
		        If SharedApplication <> Nil Then
		          Dim EventObject As Ptr = GetCurrentEvent(SharedApplication)
		          If EventObject <> Nil Then
		            If RespondsToSelector(EventObject,sel_registerName("momentumPhase")) Then
		              Self.mMomentumPhase = GetMomentumPhase(EventObject)
		            End If
		            If RespondsToSelector(EventObject,sel_registerName("phase")) Then
		              Self.mPhase = GetPhase(EventObject)
		            End If
		            If RespondsToSelector(EventObject,sel_registerName("scrollingDeltaY")) Then
		              Dim Factor As Integer = LineHeight
		              If RespondsToSelector(EventObject,sel_registerName("hasPreciseScrollingDeltas")) And HasPreciseScrollingDeltas(EventObject) Then
		                Factor = 1
		              End If
		              Self.mHorizontalAmount = Round(ScrollingDeltaX(EventObject) * Factor) * -1
		              Self.mVerticalAmount = Round(ScrollingDeltaY(EventObject) * Factor) * -1
		            End If
		          End If
		        End If
		      End If
		      Return
		    Catch Err As RuntimeException
		      // Okay to ignore
		    End Try
		  #endif
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLineHeight
			End Get
		#tag EndGetter
		LineHeight As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mHorizontalAmount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mLineHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMomentumPhase As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMomentumPhase
			End Get
		#tag EndGetter
		MomentumPhase As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mPhase As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mVerticalAmount As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			Return Self.mPhase
		#tag EndNote
		#tag Getter
			Get
			  Return Self.mPhase
			End Get
		#tag EndGetter
		Phase As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHorizontalAmount
			End Get
		#tag EndGetter
		ScrollX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mVerticalAmount
			End Get
		#tag EndGetter
		ScrollY As Integer
	#tag EndComputedProperty


	#tag Constant, Name = PhaseBegan, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PhaseCancelled, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PhaseChanged, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PhaseEnded, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PhaseMayBegin, Type = Double, Dynamic = False, Default = \"32", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PhaseNone, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PhaseStationary, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


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
			Name="LineHeight"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MomentumPhase"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Phase"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollX"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollY"
			Group="Behavior"
			Type="Integer"
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
End Class
#tag EndClass
