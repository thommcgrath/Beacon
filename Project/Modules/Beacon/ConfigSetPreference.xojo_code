#tag Class
Protected Class ConfigSetPreference
	#tag Method, Flags = &h0
		Sub Constructor(SetName As String, MergeMode As Beacon.ConfigSetPreference.MergeModes)
		  Self.mSetName = SetName
		  Self.mMode = MergeMode
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.ConfigSetPreference
		  If Dict Is Nil Or Dict.HasAllKeys("Set Name", "Mode") = False Then
		    Return Nil
		  End If
		  
		  Var SetName As String = Dict.Value("Set Name")
		  Var Mode As Beacon.ConfigSetPreference.MergeModes = CType(Dict.Value("Mode").IntegerValue, Beacon.ConfigSetPreference.MergeModes)
		  Return New Beacon.ConfigSetPreference(SetName, Mode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As Beacon.ConfigSetPreference.MergeModes
		  Return Self.mMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetName() As String
		  Return Self.mSetName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Set Name") = Self.mSetName
		  Dict.Value("Mode") = CType(Self.mMode, Integer)
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMode As Beacon.ConfigSetPreference.MergeModes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetName As String
	#tag EndProperty


	#tag Enum, Name = MergeModes, Type = Integer, Flags = &h0
		OverwriteAll
		  OverwriteCommon
		SkipCommon
	#tag EndEnum


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
		#tag ViewProperty
			Name="mSetName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
