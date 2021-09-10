#tag Class
Protected Class ConfigGroup
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.ConfigGroup)
		  Self.Constructor()
		  Self.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SaveData As Dictionary, Identity As Beacon.Identity, Project As Ark.Project)
		  Self.Constructor()
		  Try
		    RaiseEvent ReadSaveData(SaveData, Identity, Project)
		    Self.mIsImplicit = SaveData.Lookup("Implicit", False)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Creating config group from source dictionary")
		  End Try
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
		Function InternalName() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDefaultImported() As Boolean
		  Return True
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
		Shared Function Merge(Groups() As Ark.ConfigGroup) As Ark.ConfigGroup
		  // First, make sure all groups are the same type
		  
		  If Groups.Count = 0 Then
		    Return Nil
		  End If
		  
		  If Groups(0).SupportsMerging = False Then
		    Return Nil
		  End If
		  
		  Var GroupName As String = Groups(0).InternalName
		  For Idx As Integer = 1 To Groups.LastIndex
		    If Groups(Idx) Is Nil Or Groups(Idx).InternalName <> GroupName Or Groups(Idx).SupportsMerging = False Then
		      Return Nil
		    End If
		  Next Idx
		  
		  Var NewGroup As Ark.ConfigGroup
		  For Idx As Integer = 0 To Groups.LastIndex
		    If NewGroup Is Nil Then
		      NewGroup = Ark.Configs.CreateInstance(GroupName)
		    End If
		    NewGroup.CopyFrom(Groups(Idx))
		  Next Idx
		  
		  Return NewGroup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Merge(ParamArray Groups() As Ark.ConfigGroup) As Ark.ConfigGroup
		  Return Merge(Groups)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Migrate(SavedWithVersion As Integer, Project As Ark.Project)
		  RaiseEvent Migrate(SavedWithVersion, Project)
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

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RunWhenBanned() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(Identity As Beacon.Identity, Project As Ark.Project) As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("Implicit") = Self.mIsImplicit
		  RaiseEvent WriteSaveData(SaveData, Project)
		  Return SaveData
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


	#tag Hook, Flags = &h0
		Event CopyFrom(Other As Ark.ConfigGroup)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetManagedKeys() As Ark.ConfigKey()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HasContent() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Migrate(SavedWithVersion As Integer, Project As Ark.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadSaveData(SaveData As Dictionary, Identity As Beacon.Identity, Project As Ark.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteSaveData(SaveData As Dictionary, Project As Ark.Project)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mIsImplicit As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mManagedKeys() As Ark.ConfigKey
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
