#tag Class
Protected Class ConfigGroup
	#tag Method, Flags = &h0
		Function CommandLineOptions(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Dim Values() As Beacon.ConfigValue
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As Text
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Self)
		  Dim Methods() As Xojo.Introspection.MethodInfo = Info.Methods
		  For Each Signature As Xojo.Introspection.MethodInfo In Methods
		    If Signature.IsShared And Signature.Name = "ConfigName" And Signature.Parameters.Ubound = -1 And Signature.ReturnType.Name = "Text" Then
		      Return Signature.Invoke(Self)
		    End If
		  Next
		  
		  Dim Err As New UnsupportedOperationException
		  Err.Reason = "Class " + Info.FullName + " is missing its ConfigName() As Text shared method."
		  Raise Err
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
		  #Pragma Unused SourceDocument
		  
		  Dim Values() As Beacon.ConfigValue
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Dim Values() As Beacon.ConfigValue
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
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


	#tag Property, Flags = &h21
		Private mModified As Boolean
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
