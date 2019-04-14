#tag Class
Protected Class DictionaryMemberSet
Implements Global.Xojo.Core.Iterable,Global.Xojo.Core.Iterator
	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
		  Dim Keys() As Variant = Source.Keys
		  For Each Key As Variant In Keys
		    Self.mMembers.Append(New FrameworkExtensions.DictionaryMember(Key, Source.Value(Key)))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Global.Xojo.Core.Iterable interface.
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  Self.mIndex = Self.mIndex + 1
		  Return Self.mIndex <= Self.mMembers.Ubound
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Auto
		  Return Self.mMembers(Self.mIndex)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMembers() As FrameworkExtensions.DictionaryMember
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
