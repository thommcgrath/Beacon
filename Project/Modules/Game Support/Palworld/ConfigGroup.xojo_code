#tag Class
Protected Class ConfigGroup
Inherits Beacon.ConfigGroup
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Migrate(SavedWithVersion As Integer, Project As Beacon.Project)
		  If Project IsA Palworld.Project Then
		    RaiseEvent Migrate(SavedWithVersion, Palworld.Project(Project))
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Clone() As Beacon.ConfigGroup
		  Return Palworld.Configs.CloneInstance(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Palworld.ConfigGroup)
		  Self.Constructor()
		  Self.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Other As Palworld.ConfigGroup)
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
		Function GenerateConfigValues(Project As Palworld.Project, Identity As Beacon.Identity, Profile As Palworld.ServerProfile) As Palworld.ConfigValue()
		  Var Values() As Palworld.ConfigValue
		  
		  If Palworld.Configs.ConfigUnlocked(Self, Identity) Then
		    Var Generated() As Palworld.ConfigValue = RaiseEvent GenerateConfigValues(Project, Profile)
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
		Function ManagedKeys() As Palworld.ConfigOption()
		  // Returns all the keys that this group could provide
		  
		  If Self.mManagedKeys.Count = 0 Then
		    Var Keys() As Palworld.ConfigOption = RaiseEvent GetManagedKeys()
		    If (Keys Is Nil) = False Then
		      Self.mManagedKeys = Keys
		    End If
		  End If
		  Return Self.mManagedKeys
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CopyFrom(Other As Palworld.ConfigGroup)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GenerateConfigValues(Project As Palworld.Project, Profile As Palworld.ServerProfile) As Palworld.ConfigValue()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetManagedKeys() As Palworld.ConfigOption()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Migrate(SavedWithVersion As Integer, Project As Palworld.Project)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mManagedKeys() As Palworld.ConfigOption
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
