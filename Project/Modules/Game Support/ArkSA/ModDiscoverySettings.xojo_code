#tag Class
Protected Class ModDiscoverySettings
	#tag Method, Flags = &h0
		Sub Constructor(ContentPackIds As Dictionary, Options As Integer, Threshold As Double)
		  If (Options And Self.OptionUseNewDiscovery) > 0 And ArkSA.ModDiscoveryEngine2.IsAvailable = False Then
		    Options = Options And Not Self.OptionUseNewDiscovery
		  End If
		  If (Options And Self.OptionUploadToCommunity) > 0 And (Options And Self.OptionUseNewDiscovery) = 0 Then
		    Options = Options And Not Self.OptionUploadToCommunity
		  End If
		  If (Options And Self.OptionIgnoreBuiltInClasses) > 0 And (Options And Self.OptionUseNewDiscovery) > 0 Then
		    Options = Options And Not Self.OptionIgnoreBuiltInClasses
		  End If
		  
		  Self.mContentPackIds = ContentPackIds.Clone
		  Self.mOptions = Options
		  Self.mThreshold = Threshold
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId(ModId As String) As String
		  Return Self.mContentPackIds.Value(ModId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteBlueprints() As Boolean
		  Return (Self.mOptions And Self.OptionDeleteBlueprints) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Source As Dictionary) As ArkSA.ModDiscoverySettings
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  Try
		    Var Item As New JSONItem(Source)
		    Return FromJSONItem(Item)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSONItem(Source As JSONItem) As ArkSA.ModDiscoverySettings
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  Try
		    Return New ArkSA.ModDiscoverySettings(New Dictionary, Source.Value("options").IntegerValue, Source.Value("threshold").DoubleValue)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(Source As String) As ArkSA.ModDiscoverySettings
		  If Source.IsEmpty Then
		    Return Nil
		  End If
		  
		  Try
		    Var Item As New JSONItem(Source)
		    Return FromJSONItem(Item)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IgnoreBuiltInClasses() As Boolean
		  Return (Self.mOptions And Self.OptionIgnoreBuiltInClasses) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModIds() As String()
		  Var ModIds() As String
		  For Each Entry As DictionaryEntry In Self.mContentPackIds
		    ModIds.Add(Entry.Key)
		  Next
		  Return ModIds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Options() As Integer
		  Return Self.mOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplaceBlueprints() As Boolean
		  Return (Self.mOptions And Self.OptionReplaceBlueprints) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Threshold() As Double
		  Return Self.mThreshold
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("options") = Self.mOptions
		  Dict.Value("threshold") = Self.mThreshold
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSONItem() As JSONItem
		  Return New JSONItem(Self.ToDictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return Self.ToJSONItem.ToString(True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UploadToCommunity() As Boolean
		  Return (Self.mOptions And Self.OptionUploadToCommunity) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseNewDiscovery() As Boolean
		  Return (Self.mOptions And Self.OptionUseNewDiscovery) > 0
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContentPackIds As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptions As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreshold As Double
	#tag EndProperty


	#tag Constant, Name = OptionDeleteBlueprints, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionIgnoreBuiltInClasses, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionReplaceBlueprints, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionUploadToCommunity, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionUseNewDiscovery, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant


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
