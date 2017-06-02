#tag Class
Protected Class APIEngramSet
	#tag Method, Flags = &h0
		Function ActiveEngrams() As APIEngram()
		  Dim Engrams() As APIEngram
		  For Each Engram As APIEngram In Self.mUpdatedEngrams
		    Engrams.Append(New APIEngram(Engram))
		  Next
		  For Each Engram As APIEngram In Self.mNeutralEngrams
		    Engrams.Append(New APIEngram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Engram As APIEngram)
		  If Engram.ClassString = "" Then
		    Return
		  End If
		  
		  For I As Integer = 0 To UBound(Self.mRemovedEngrams)
		    If Self.mRemovedEngrams(I) = Engram Then
		      Self.mRemovedEngrams.Remove(I)
		    End If
		  Next
		  
		  For I As Integer = 0 To UBound(Self.mNeutralEngrams)
		    If Self.mNeutralEngrams(I) = Engram Then
		      Self.mNeutralEngrams.Remove(I)
		    End If
		  Next
		  
		  For I As Integer = 0 To UBound(Self.mUpdatedEngrams)
		    If Self.mUpdatedEngrams(I) = Engram Then
		      Self.mUpdatedEngrams(I) = New APIEngram(Engram)
		      Return
		    End If
		  Next
		  
		  Self.mUpdatedEngrams.Append(New APIEngram(Engram))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Sources() As Auto)
		  For Each Source As Xojo.Core.Dictionary In Sources
		    Dim Engram As New APIEngram(Source)
		    Self.mNeutralEngrams.Append(Engram)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToDelete() As APIEngram()
		  Dim Engrams() As APIEngram
		  For Each Engram As APIEngram In Self.mRemovedEngrams
		    Engrams.Append(New APIEngram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToSave() As APIEngram()
		  Dim Engrams() As APIEngram
		  For Each Engram As APIEngram In Self.mUpdatedEngrams
		    Engrams.Append(New APIEngram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return UBound(Self.mUpdatedEngrams) > -1 Or UBound(Self.mRemovedEngrams) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Engram As APIEngram)
		  If Engram.ClassString = "" Then
		    Return
		  End If
		  
		  For I As Integer = 0 To UBound(Self.mUpdatedEngrams)
		    If Self.mUpdatedEngrams(I) = Engram Then
		      Self.mUpdatedEngrams.Remove(I)
		    End If
		  Next
		  
		  For I As Integer = 0 To UBound(Self.mNeutralEngrams)
		    If Self.mNeutralEngrams(I) = Engram Then
		      Self.mNeutralEngrams.Remove(I)
		    End If
		  Next
		  
		  For I As Integer = 0 To UBound(Self.mRemovedEngrams)
		    If Self.mRemovedEngrams(I) = Engram Then
		      Self.mRemovedEngrams(I) = New APIEngram(Engram)
		      Return
		    End If
		  Next
		  
		  Self.mRemovedEngrams.Append(New APIEngram(Engram))
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mNeutralEngrams() As APIEngram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemovedEngrams() As APIEngram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdatedEngrams() As APIEngram
	#tag EndProperty


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
			Name="mOriginalEngrams()"
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
