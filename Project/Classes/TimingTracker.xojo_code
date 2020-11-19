#tag Class
Protected Class TimingTracker
	#tag Method, Flags = &h0
		Sub Advance()
		  #if DebugBuild
		    Self.mLastEventTime = System.Microseconds
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  #if DebugBuild
		    Self.mStartTime = System.Microseconds
		    Self.mLastEventTime = Self.mStartTime
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String, SinceStart As Boolean = False)
		  #if DebugBuild
		    Var Now As Double = System.Microseconds
		    Var Elapsed As Double
		    If SinceStart Then
		      Elapsed = Now - Self.mStartTime
		    Else
		      Elapsed = Now - Self.mLastEventTime
		      Self.mLastEventTime = Now
		    End If
		    
		    App.Log(Message.ReplaceAll("%elapsed%", Self.MicrosecondsToString(Elapsed)))
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MicrosecondsToString(Value As Double) As String
		  #if DebugBuild
		    If Value < 1000 Then
		      Return Round(Value).ToString("0") + " microseconds"
		    End If
		    
		    // Milliseconds
		    Value = Value / 1000
		    If Value < 1000 Then
		      Return Round(Value).ToString("0") + "ms"
		    End If
		    
		    // Seconds
		    Value = Value / 1000
		    Return Value.ToString("0.0###") + " seconds"
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLastEventTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartTime As Double
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
	#tag EndViewBehavior
End Class
#tag EndClass
