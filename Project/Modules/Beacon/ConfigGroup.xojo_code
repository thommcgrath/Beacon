#tag Class
Protected Class ConfigGroup
	#tag Method, Flags = &h0
		Function CommandLineOptions(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Xojo.Core.Dictionary)
		  Self.Constructor()
		  RaiseEvent ReadDictionary(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupName() As Text
		  Dim Err As New UnsupportedOperationException
		  Err.Reason = "Unimplemented Beacon.ConfigGroup.GroupName method"
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  RaiseEvent WriteDictionary(Dict)
		  Return Dict
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadDictionary(Dict As Xojo.Core.Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteDictionary(Dict As Xojo.Core.DIctionary)
	#tag EndHook


	#tag Property, Flags = &h0
		Modified As Boolean
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
		#tag ViewProperty
			Name="Modified"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
