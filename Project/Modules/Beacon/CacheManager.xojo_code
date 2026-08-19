#tag Class
Protected Class CacheManager
	#tag Method, Flags = &h0
		Sub Cleanup()
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  Var Keys() As Variant = Self.mCache.Keys
		  For Each Key As String In Keys
		    Var Ref As CacheRef = Self.mCache.Value(Key)
		    If Ref.Expired Then
		      Self.mCache.Remove(Key)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mCache = New Dictionary
		  Self.mLock = New CriticalSection
		  Self.mLock.Type = Thread.Types.Preemptive
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(Key As String, Default As Variant = Nil) As Variant
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  If Self.mCache.HasKey(Key) = False Then
		    Return Default
		  End If
		  
		  Var Ref As CacheRef = Self.mCache.Value(Key)
		  If Ref.Expired Then
		    Self.mCache.Remove(Key)
		    Return Default
		  End If
		  
		  Ref.Renew()
		  Return Ref.Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(Key As String) As Boolean
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  If Self.mCache.HasKey(Key) = False Then
		    Return False
		  End If
		  
		  Return Not CacheRef(Self.mCache.Value(Key).ObjectValue).Expired
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Purge()
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  Self.mCache.RemoveAll
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Key As String)
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  If Self.mCache.HasKey(Key) Then
		    Self.mCache.Remove(Key)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Store(Key As String, Value As Variant, TimeToLive As Double)
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  If (Value.IsNull Or TimeToLive <= 0) And Self.mCache.HasKey(Key) Then
		    Self.mCache.Remove(Key)
		    Return
		  End If
		  
		  Self.mCache.Value(Key) = New CacheRef(Value, TimeToLive)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
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
