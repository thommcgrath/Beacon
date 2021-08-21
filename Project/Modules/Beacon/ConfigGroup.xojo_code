#tag Class
Protected Class ConfigGroup
	#tag Method, Flags = &h0
		Function Clone(Identity As Beacon.Identity, Document As Beacon.Document) As Beacon.ConfigGroup
		  Var Dict As Dictionary = Self.ToDictionary(Document)
		  If Dict Is Nil Then
		    Return Nil
		  End If
		  
		  #if DebugBuild
		    Var StartTime As Double = System.Microseconds
		  #endif
		  
		  Try
		    // To make a proper clone and replicate loading from disk
		    Dict = Beacon.ParseJSON(Beacon.GenerateJSON(Dict, False))
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Var Instance As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(Self.ConfigName, Dict, Identity, Document)
		  If Instance Is Nil Then
		    Return Nil
		  End If
		  
		  #if DebugBuild
		    Var Duration As Double = (System.Microseconds - StartTime) * 0.001
		    System.DebugLog("Cloned config group " + Self.ConfigName + " in " + Duration.ToString(Locale.Raw, "0") + "ms")
		  #endif
		  
		  Return Instance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Var Err As New UnsupportedOperationException
		  Err.Message = "ConfigGroup.ConfigName was not overridden"
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
		  Try
		    RaiseEvent ReadDictionary(Source, Identity, Document)
		    Self.mIsImplicit = Source.Lookup("Implicit", False)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Creating config group from source dictionary")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Identity As Beacon.Identity, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  Var Values() As Beacon.ConfigValue
		  
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) And (Identity.IsBanned = False Or Self.RunWhenBanned = True) Then
		    Var Generated() As Beacon.ConfigValue = RaiseEvent GenerateConfigValues(SourceDocument, Profile)
		    If (Generated Is Nil) = False Then
		      Values = Generated
		    Else
		      App.Log("Warning: " + Self.ConfigName + " did not generate any configs.")
		    End If
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsImplicit() As Boolean
		  If Self.mIsImplicit Then
		    Return Not RaiseEvent HasContent()
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsImplicit(Assigns Value As Boolean)
		  If Self.mIsImplicit <> Value Then
		    Self.mIsImplicit = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Issues(Document As Beacon.Document, Identity As Beacon.Identity) As Beacon.Issue()
		  Var Arr() As Beacon.Issue
		  If BeaconConfigs.ConfigPurchased(Self, Identity.OmniVersion) Then
		    RaiseEvent DetectIssues(Document, Arr)
		  End If
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ManagedKeys() As Beacon.ConfigKey()
		  // Returns all the keys that this group could provide
		  
		  If Self.mManagedKeys.Count = 0 Then
		    Var Keys() As Beacon.ConfigKey = RaiseEvent GetManagedKeys()
		    If (Keys Is Nil) = False Then
		      Self.mManagedKeys = Keys
		    End If
		  End If
		  Return Self.mManagedKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(Other As Beacon.ConfigGroup) As Boolean
		  If Not Self.SupportsMerging Or Other = Nil Then
		    Return False
		  End If
		  
		  Var SelfInfo As Introspection.TypeInfo = Introspection.GetType(Self)
		  Var OtherInfo As Introspection.TypeInfo = Introspection.GetType(Other)
		  If SelfInfo.FullName <> OtherInfo.FullName Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot merge " + OtherInfo.FullName + " into " + SelfInfo.FullName
		    Raise Err
		  End If
		  
		  Try
		    Var WasModified As Boolean = Self.mModified
		    Self.mModified = False
		    RaiseEvent MergeFrom(Other)
		    Var MergeMadeChanges As Boolean = Self.mModified
		    Self.mModified = Self.mModified Or WasModified
		    Return MergeMadeChanges
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Migrate(SavedWithVersion As Integer, Doc As Beacon.Document)
		  RaiseEvent Migrate(SavedWithVersion, Doc)
		End Sub
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
		Function RunWhenBanned() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsConfigSets() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary(Document As Beacon.Document) As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Implicit") = Self.mIsImplicit
		  RaiseEvent WriteDictionary(Dict, Document)
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WasPerfectImport() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DetectIssues(Document As Beacon.Document, Issues() As Beacon.Issue)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetManagedKeys() As Beacon.ConfigKey()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HasContent() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MergeFrom(Other As Beacon.ConfigGroup)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Migrate(SavedWithVersion As Integer, Doc As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mIsImplicit As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mManagedKeys() As Beacon.ConfigKey
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
	#tag EndViewBehavior
End Class
#tag EndClass
