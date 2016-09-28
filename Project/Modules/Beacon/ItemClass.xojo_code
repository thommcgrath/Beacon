#tag Class
Protected Class ItemClass
	#tag Method, Flags = &h0
		Function ClassString() As Text
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ItemClass)
		  Self.mClassString = Source.mClassString
		  Self.mWeight = Source.mWeight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As Text, Weight As Double)
		  Self.mClassString = ClassString
		  Self.mWeight = Weight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("Class") = Self.ClassString
		  Keys.Value("Weight") = Self.Weight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Dict As Xojo.Core.Dictionary) As Beacon.ItemClass
		  Return New Beacon.ItemClass(Dict.Value("Class"), Dict.Value("Weight"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mClassString As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeight As Double
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
