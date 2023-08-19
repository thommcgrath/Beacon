#tag Class
Protected Class ConfigGroup
Inherits Beacon.ConfigGroup
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.ConfigGroup)
		  Self.Constructor()
		  Self.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  If Other Is Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot merge nil group into " + Self.InternalName + "."
		    Raise Err
		  ElseIf Other.InternalName <> Self.InternalName Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot merge group " + Other.InternalName + " into " + Self.InternalName + "."
		    Raise Err
		  End If
		  
		  RaiseEvent CopyFrom(Other)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateConfigValues(Project As Ark.Project, Identity As Beacon.Identity, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  Var Values() As Ark.ConfigValue
		  
		  If Ark.Configs.ConfigUnlocked(Self, Identity) And (Identity.IsBanned = False Or Self.RunWhenBanned = True) Then
		    Var Generated() As Ark.ConfigValue = RaiseEvent GenerateConfigValues(Project, Profile)
		    If (Generated Is Nil) = False Then
		      Values = Generated
		    Else
		      App.Log("Warning: " + Self.InternalName + " did not generate any configs.")
		    End If
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ManagedKeys() As Ark.ConfigKey()
		  // Returns all the keys that this group could provide
		  
		  If Self.mManagedKeys.Count = 0 Then
		    Var Keys() As Ark.ConfigKey = RaiseEvent GetManagedKeys()
		    If (Keys Is Nil) = False Then
		      Self.mManagedKeys = Keys
		    End If
		  End If
		  Return Self.mManagedKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Migrate(SavedWithVersion As Integer, Project As Ark.Project)
		  RaiseEvent Migrate(SavedWithVersion, Project)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CopyFrom(Other As Ark.ConfigGroup)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetManagedKeys() As Ark.ConfigKey()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Migrate(SavedWithVersion As Integer, Project As Ark.Project)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mManagedKeys() As Ark.ConfigKey
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
