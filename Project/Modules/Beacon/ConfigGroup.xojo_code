#tag Class
Protected Class ConfigGroup
	#tag Method, Flags = &h0
		Function CommandLineOptions(SourceDocument As Beacon.Document, Identity As Beacon.Identity) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent CommandLineOptions(SourceDocument, Values)
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Self)
		  Dim Methods() As Introspection.MethodInfo = Info.GetMethods
		  For Each Signature As Introspection.MethodInfo In Methods
		    If Signature.IsShared And Signature.Name = "ConfigName" And Signature.GetParameters.Ubound = -1 And Signature.ReturnType.Name = "String" Then
		      Return Signature.Invoke(Self)
		    End If
		  Next
		  
		  Dim Err As New UnsupportedOperationException
		  Err.Message = "Class " + Info.FullName + " is missing its ConfigName() As String shared method."
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary, Identity As Beacon.Identity)
		  Self.Constructor
		  Self.mIsImplicit = Source.Lookup("Implicit", False)
		  RaiseEvent ReadDictionary(Source, Identity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document, Identity As Beacon.Identity) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent GameIniValues(SourceDocument, Values)
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document, Identity As Beacon.Identity) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent GameUserSettingsIniValues(SourceDocument, Values)
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Issues(Document As Beacon.Document) As Beacon.Issue()
		  #Pragma Unused Document
		  
		  Dim Arr() As Beacon.Issue
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  #Pragma Unused Document
		  Return True
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

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ResolveIssuesCallback()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ToDictionary(Identity As Beacon.Identity) As Dictionary
		  Dim Dict As New Dictionary
		  Dict.Value("Implicit") = Self.mIsImplicit
		  RaiseEvent WriteDictionary(Dict, Identity)
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TryToResolveIssues(InputContent As String, Callback As Beacon.ConfigGroup.ResolveIssuesCallback)
		  #Pragma Unused InputContent
		  
		  If Callback <> Nil Then
		    Callback.Invoke
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WasPerfectImport() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CommandLineOptions(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteDictionary(Dict As Dictionary, Identity As Beacon.Identity)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIsImplicit
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIsImplicit <> Value Then
			    Self.mIsImplicit = Value
			    Self.mModified = True
			  End If
			End Set
		#tag EndSetter
		IsImplicit As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIsImplicit As Boolean
	#tag EndProperty

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
		#tag ViewProperty
			Name="IsImplicit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
