#tag Class
Protected Class ConfigGroup
	#tag Method, Flags = &h0
		Function CommandLineOptions(SourceDocument As Beacon.Document, Identity As Beacon.Identity, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent CommandLineOptions(SourceDocument, Values, Profile)
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Self)
		  Dim Methods() As Introspection.MethodInfo = Info.GetMethods
		  For Each Signature As Introspection.MethodInfo In Methods
		    If Signature.IsShared And Signature.Name = "ConfigName" And Signature.GetParameters.LastRowIndex = -1 And Signature.ReturnType.Name = "String" Then
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
		Sub Constructor(Source As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  Self.Constructor
		  Self.mIsImplicit = Source.Lookup("Implicit", False)
		  RaiseEvent ReadDictionary(Source, Identity, Document)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document, Identity As Beacon.Identity, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent GameIniValues(SourceDocument, Values, Profile)
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document, Identity As Beacon.Identity, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  Dim Values() As Beacon.ConfigValue
		  
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent GameUserSettingsIniValues(SourceDocument, Values, Profile)
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Issues(Document As Beacon.Document, Identity As Beacon.Identity) As Beacon.Issue()
		  Dim Arr() As Beacon.Issue
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent DetectIssues(Document, Arr)
		  End If
		  Return Arr
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
		Function NonGeneratedKeys() As Beacon.ConfigKey()
		  // If a config group parses keys that it does not generate, they should be returned here
		  // to prevent custom config content from grabbing them
		  
		  Var Keys() As Beacon.ConfigKey
		  Return Keys
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ResolveIssuesCallback()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ToDictionary(Document As Beacon.Document) As Dictionary
		  Dim Dict As New Dictionary
		  Dict.Value("Implicit") = Self.mIsImplicit
		  RaiseEvent WriteDictionary(Dict, Document)
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
		Event CommandLineOptions(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DetectIssues(Document As Beacon.Document, Issues() As Beacon.Issue)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
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
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
