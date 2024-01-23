#tag Module
Protected Module Configs
	#tag Method, Flags = &h1
		Protected Function AllNames(Human As Boolean = False) As String()
		  Static Names() As String
		  If Names.LastIndex = -1 Then
		    Names.Add(NameCustomConfig)
		    Names.Add(NameGeneralSettings)
		  End If
		  If Human = True Then
		    Static HumanNames() As String
		    If HumanNames.LastIndex = -1 Then
		      HumanNames.ResizeTo(Names.LastIndex)
		      For I As Integer = 0 To Names.LastIndex
		        HumanNames(I) = Language.LabelForConfig(Names(I))
		      Next
		      HumanNames.Sort
		    End If
		    Return HumanNames
		  Else
		    Return Names
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AllTools() As Palworld.ProjectTool()
		  Static Tools() As Palworld.ProjectTool
		  If Tools.LastIndex = -1 Then
		    Tools.ResizeTo(-1)
		    Tools.Add(New Palworld.ProjectTool("Setup Guided Editors", "4add8d2b-fca9-4f37-9eb3-aae75b2c21fc", NameCustomConfig))
		    
		    Var Names() As String
		    Names.ResizeTo(Tools.LastIndex)
		    For Idx As Integer = Tools.FirstIndex To Tools.LastIndex
		      Names(Idx) = Language.LabelForConfig(Tools(Idx).FirstGroup) + " - " + Tools(Idx).Caption
		    Next Idx
		    Names.SortWith(Tools)
		  End If
		  Return Tools
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CloneInstance(Group As Palworld.ConfigGroup) As Palworld.ConfigGroup
		  If Group Is Nil Then
		    Return Nil
		  End If
		  
		  Var NewInstance As Palworld.ConfigGroup = CreateInstance(Group.InternalName)
		  NewInstance.CopyFrom(Group)
		  Return NewInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigUnlocked(Config As Palworld.ConfigGroup, Identity As Beacon.Identity) As Boolean
		  Return ConfigUnlocked(Config.InternalName, Identity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigUnlocked(InternalName As String, Identity As Beacon.Identity) As Boolean
		  If mConfigOmniCache Is Nil Then
		    mConfigOmniCache = New Dictionary
		  End If
		  
		  Var RequiresOmni As Boolean
		  If mConfigOmniCache.HasKey(InternalName) = False Then
		    Select Case InternalName
		    Case NameServers, NameProjectSettings, NameAccounts
		      RequiresOmni = False
		    Else
		      Var Instance As Palworld.ConfigGroup = CreateInstance(InternalName)
		      If (Instance Is Nil) = False Then
		        RequiresOmni = Instance.RequiresOmni
		      End If
		    End Select
		    mConfigOmniCache.Value(InternalName) = RequiresOmni
		  Else
		    RequiresOmni = mConfigOmniCache.Value(InternalName)
		  End If
		  
		  If RequiresOmni Then
		    Return Palworld.OmniPurchased(Identity)
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(InternalName As String) As Palworld.ConfigGroup
		  Select Case InternalName
		  Case NameCustomConfig
		    Return New Palworld.Configs.CustomContent()
		  Case NameGeneralSettings
		    Return New Palworld.Configs.OtherSettings()
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + InternalName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(InternalName As String, SaveData As Dictionary, EncryptedData As Dictionary) As Palworld.ConfigGroup
		  If EncryptedData Is Nil Then
		    If SaveData.HasAllKeys("Plain", "Encrypted") Then
		      EncryptedData = SaveData.Value("Encrypted")
		      SaveData = SaveData.Value("Plain")
		    Else
		      EncryptedData = New Dictionary
		    End If
		  End If
		  
		  Select Case InternalName
		  Case NameCustomConfig
		    Return New Palworld.Configs.CustomContent(SaveData, EncryptedData)
		  Case NameGeneralSettings
		    Return New Palworld.Configs.OtherSettings(SaveData, EncryptedData)
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + InternalName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(InternalName As String, ParsedData As Dictionary, Project As Palworld.Project) As Palworld.ConfigGroup
		  // Why not just pass the project itself to these methods? Because we don't want it to be possible
		  // for the creation of an instance to modify the project. MapMask and ContentPacks are immutable,
		  // but the difficulty object is not, so we'll pass the raw value instead.
		  
		  Select Case InternalName
		  Case Palworld.Configs.NameCustomConfig
		    Return Nil
		  Case Palworld.Configs.NameGeneralSettings
		    Return Palworld.Configs.OtherSettings.FromImport(ParsedData, Project.ContentPacks)
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + InternalName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Merge(ZeroHasPriority As Boolean, ParamArray Groups() As Palworld.ConfigGroup) As Palworld.ConfigGroup
		  Return Merge(Groups, ZeroHasPriority)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Merge(Groups() As Palworld.ConfigGroup, ZeroHasPriority As Boolean) As Palworld.ConfigGroup
		  // First, make sure all groups are the same type
		  
		  If Groups.Count = 0 Then
		    Return Nil
		  ElseIf Groups.Count = 1 Then
		    Return CloneInstance(Groups(0))
		  End If
		  
		  Var MergeSupported As Boolean = Groups(0).SupportsMerging
		  Var GroupName As String = Groups(0).InternalName
		  For Idx As Integer = 1 To Groups.LastIndex
		    If Groups(Idx) Is Nil Or Groups(Idx).InternalName <> GroupName Then
		      Return Nil
		    End If
		  Next Idx
		  
		  Var NewGroup As Palworld.ConfigGroup
		  If ZeroHasPriority Then
		    If MergeSupported Then
		      For Idx As Integer = Groups.LastIndex DownTo 0
		        If NewGroup Is Nil Then
		          NewGroup = CreateInstance(GroupName)
		        End If
		        NewGroup.CopyFrom(Groups(Idx))
		      Next Idx
		    Else
		      NewGroup = CloneInstance(Groups(0))
		    End If
		  Else
		    If MergeSupported Then
		      For Idx As Integer = 0 To Groups.LastIndex
		        If NewGroup Is Nil Then
		          NewGroup = CreateInstance(GroupName)
		        End If
		        NewGroup.CopyFrom(Groups(Idx))
		      Next Idx
		    Else
		      NewGroup = CloneInstance(Groups(Groups.LastIndex))
		    End If
		  End If
		  
		  Return NewGroup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SupportsConfigSets(InternalName As String) As Boolean
		  If mConfigSetSupportCache Is Nil Then
		    mConfigSetSupportCache = New Dictionary
		  End If
		  
		  If mConfigSetSupportCache.HasKey(InternalName) = False Then
		    Var Instance As Palworld.ConfigGroup
		    
		    #Pragma BreakOnExceptions False
		    Try
		      Instance = CreateInstance(InternalName)
		    Catch Err As RuntimeException
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    If Instance Is Nil Then
		      mConfigSetSupportCache.Value(InternalName) = False
		    Else
		      mConfigSetSupportCache.Value(InternalName) = Instance.SupportsConfigSets
		    End If
		  End If
		  
		  Return mConfigSetSupportCache.Value(InternalName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SupportsMerging(InternalName As String) As Boolean
		  If mMergingSupportCache Is Nil Then
		    mMergingSupportCache = New Dictionary
		  End If
		  
		  If mMergingSupportCache.HasKey(InternalName) = False Then
		    Var Instance As Palworld.ConfigGroup
		    
		    #Pragma BreakOnExceptions False
		    Try
		      Instance = CreateInstance(InternalName)
		    Catch Err As RuntimeException
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    If Instance Is Nil Then
		      mMergingSupportCache.Value(InternalName) = False
		    Else
		      mMergingSupportCache.Value(InternalName) = Instance.SupportsMerging
		    End If
		  End If
		  
		  Return mMergingSupportCache.Value(InternalName)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigOmniCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetSupportCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMergingSupportCache As Dictionary
	#tag EndProperty


	#tag Constant, Name = NameAccounts, Type = String, Dynamic = False, Default = \"Palworld.Accounts", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameCustomConfig, Type = String, Dynamic = False, Default = \"Palworld.CustomConfig", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameGeneralSettings, Type = String, Dynamic = False, Default = \"Palworld.GeneralSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameProjectSettings, Type = String, Dynamic = False, Default = \"Palworld.ProjectSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameServers, Type = String, Dynamic = False, Default = \"Palworld.Servers", Scope = Protected
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
End Module
#tag EndModule
