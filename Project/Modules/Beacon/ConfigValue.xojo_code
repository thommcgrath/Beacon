#tag Class
Protected Class ConfigValue
	#tag Method, Flags = &h0
		Sub Constructor(Header As Text, Key As Text, Value As Text)
		  Self.mHeader = Header
		  Self.mKey = Key
		  Self.mValue = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub FillConfigDict(Dict As Dictionary, Values() As Beacon.ConfigValue)
		  If Values = Nil Then
		    Return
		  End If
		  
		  For Each Value As Beacon.ConfigValue In Values
		    Dim SimplifiedKey As String = Value.SimplifiedKey
		    
		    Dim Header As String = Value.Header
		    Dim Section As Dictionary
		    If Dict.HasKey(Header) Then
		      Section = Dict.Value(Header)
		    Else
		      Section = New Dictionary
		    End If
		    
		    Dim Arr() As String
		    If Section.HasKey(SimplifiedKey) Then
		      Arr = Section.Value(SimplifiedKey)
		    End If
		    Arr.Append(Value.Key + "=" + Value.Value)
		    Section.Value(SimplifiedKey) = Arr
		    
		    Dict.Value(Header) = Section
		  Next
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHeader
			End Get
		#tag EndGetter
		Header As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mKey
			End Get
		#tag EndGetter
		Key As Text
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHeader As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Idx As Integer = Self.mKey.IndexOf("[")
			  If Idx = -1 Then
			    Return Self.mKey
			  Else
			    Return Self.mKey.Left(Idx)
			  End If
			End Get
		#tag EndGetter
		SimplifiedKey As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mValue
			End Get
		#tag EndGetter
		Value As Text
	#tag EndComputedProperty


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
		#tag ViewProperty
			Name="Key"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Header"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SimplifiedKey"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
