#tag Module
Protected Module Cache
	#tag Method, Flags = &h1
		Protected Function Fetch(Key As String) As Variant
		  If mCachedValues Is Nil Or mCachedValues.HasKey(Key) = False Then
		    Return Nil
		  End If
		  
		  Var Paired As Pair = mCachedValues.Value(Key)
		  Var Expiration As Double = Paired.Left
		  If DateTime.Now.SecondsFrom1970 > Expiration Then
		    Return Nil
		  End If
		  
		  Return Paired.Right
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Store(Key As String, Value As Variant, TimeToLive As Integer)
		  If Value.IsNull Then
		    If mCachedValues.HasKey(Key) Then
		      mCachedValues.Remove(Key)
		    End If
		    Return
		  End If
		  
		  If mCachedValues Is Nil Then
		    mCachedValues = New Dictionary
		  End If
		  
		  mCachedValues.Value(Key) = New Pair(DateTime.Now.SecondsFrom1970 + TimeToLive, Value)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCachedValues As Dictionary
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
End Module
#tag EndModule
