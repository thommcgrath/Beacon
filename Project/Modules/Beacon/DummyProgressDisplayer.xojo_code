#tag Class
Protected Class DummyProgressDisplayer
Implements Beacon.ProgressDisplayer
	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CancelPressed() As Boolean
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mCancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Detail() As String
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mDetail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Detail(Assigns Value As String)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Self.mDetail = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns Value As String)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Self.mMessage = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As NullableDouble
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Return Self.mProgress
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Progress(Assigns Value As NullableDouble)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  Self.mProgress = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowSubProgress() As Boolean
		  Return Self.mShowSubProgress
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowSubProgress(Assigns Value As Boolean)
		  Self.mShowSubProgress = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubDetail() As String
		  Return Self.mSubDetail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubDetail(Assigns Value As String)
		  Self.mSubDetail = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubProgress() As NullableDouble
		  Return Self.mSubProgress
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubProgress(Assigns Value As NullableDouble)
		  Self.mSubProgress = Value
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDetail As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShowSubProgress As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubDetail As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubProgress As NullableDouble
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
