#tag Module
Protected Module BeaconConfigs
	#tag Method, Flags = &h1
		Protected Function AllConfigNames(Human As Boolean = False) As String()
		  Static Names() As String
		  If Names.LastIndex = -1 Then
		    Names.Add(BeaconConfigs.Difficulty.ConfigName)
		    Names.Add(BeaconConfigs.LootDrops.ConfigName)
		    Names.Add(BeaconConfigs.LootScale.ConfigName)
		    Names.Add(BeaconConfigs.Metadata.ConfigName)
		    Names.Add(BeaconConfigs.ExperienceCurves.ConfigName)
		    Names.Add(BeaconConfigs.CustomContent.ConfigName)
		    Names.Add(BeaconConfigs.CraftingCosts.ConfigName)
		    Names.Add(BeaconConfigs.StackSizes.ConfigName)
		    Names.Add(BeaconConfigs.BreedingMultipliers.ConfigName)
		    Names.Add(BeaconConfigs.HarvestRates.ConfigName)
		    Names.Add(BeaconConfigs.DinoAdjustments.ConfigName)
		    Names.Add(BeaconConfigs.StatMultipliers.ConfigName)
		    Names.Add(BeaconConfigs.DayCycle.ConfigName)
		    Names.Add(BeaconConfigs.SpawnPoints.ConfigName)
		    Names.Add(BeaconConfigs.StatLimits.ConfigName)
		    Names.Add(BeaconConfigs.EngramControl.ConfigName)
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
		Protected Function ConfigPurchased(Config As Beacon.ConfigGroup, PurchasedVersion As Integer) As Boolean
		  Return ConfigPurchased(Config.ConfigName, PurchasedVersion)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigPurchased(ConfigName As String, PurchasedVersion As Integer) As Boolean
		  Var Info As Introspection.TypeInfo = TypeInfoForConfigName(ConfigName)
		  If Info = Nil Then
		    Return True
		  End If
		  
		  Var ConfigAttributes() As Introspection.AttributeInfo = Info.GetAttributes
		  For Each ConfigAttribute As Introspection.AttributeInfo In ConfigAttributes
		    If ConfigAttribute.Name <> "OmniVersion" Then
		      Continue
		    End If
		    
		    Var AttributeValue As Variant = ConfigAttribute.Value
		    Var RequiredVersion As Integer
		    Select Case AttributeValue.Type
		    Case Variant.TypeInt32
		      RequiredVersion = AttributeValue.Int32Value
		    Case Variant.TypeInt64
		      RequiredVersion = AttributeValue.Int64Value
		    Case Variant.TypeString
		      RequiredVersion = Integer.FromString(AttributeValue.StringValue)
		    Case Variant.TypeText
		      RequiredVersion = Integer.FromText(AttributeValue.TextValue)
		    End Select
		    
		    Return PurchasedVersion >= RequiredVersion
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As String) As Beacon.ConfigGroup
		  Var Info As Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info Is Nil Then
		    App.Log("Could not create config group """ + GroupName + """ because the type info is missing.")
		    Return Nil
		  ElseIf Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    App.Log("Could not create config group """ + GroupName + """ because the class is not a subclass of Beacon.ConfigGroup.")
		    Return Nil
		  End If 
		  
		  Var Constructors() As Introspection.ConstructorInfo = Info.GetConstructors
		  For Each Signature As Introspection.ConstructorInfo In Constructors
		    Var Params() As Introspection.ParameterInfo = Signature.GetParameters
		    If Params.LastIndex = -1 Then
		      Return Signature.Invoke()
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As String, GroupData As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document) As Beacon.ConfigGroup
		  Var Info As Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info Is Nil Then
		    App.Log("Could not create config group """ + GroupName + """ because the type info is missing.")
		    Return Nil
		  ElseIf Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    App.Log("Could not create config group """ + GroupName + """ because the class is not a subclass of Beacon.ConfigGroup.")
		    Return Nil
		  End If 
		  
		  Var Constructors() As Introspection.ConstructorInfo = Info.GetConstructors
		  For Each Signature As Introspection.ConstructorInfo In Constructors
		    Var Params() As Introspection.ParameterInfo = Signature.GetParameters
		    If Params.LastIndex = 2 And Params(0).IsByRef = False And Params(0).ParameterType.FullName = "Dictionary" And Params(1).IsByRef = False And Params(1).ParameterType.FullName = "Beacon.Identity" And Params(2).IsByRef = False And Params(2).ParameterType.FullName = "Beacon.Document" Then
		      Var Values(2) As Variant
		      Values(0) = GroupData
		      Values(1) = Identity
		      Values(2) = Document
		      Return Signature.Invoke(Values)
		    End If
		  Next
		  
		  App.Log("Could not create config group """ + GroupName + """ because the correct constructor could not be found.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As String, ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As Beacon.ConfigGroup
		  Var Info As Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info Is Nil Then
		    App.Log("Could not create config group """ + GroupName + """ because the type info is missing.")
		    Return Nil
		  ElseIf Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    App.Log("Could not create config group """ + GroupName + """ because the class is not a subclass of Beacon.ConfigGroup.")
		    Return Nil
		  End If
		  
		  Var Methods() As Introspection.MethodInfo = Info.GetMethods
		  For Each Signature As Introspection.MethodInfo In Methods
		    Try
		      If Signature.IsShared And Signature.Name = "FromImport" And Signature.GetParameters.LastIndex = 3 And Signature.ReturnType <> Nil And Signature.ReturnType.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) Then
		        Var Params(3) As Variant
		        Params(0) = ParsedData
		        Params(1) = CommandLineOptions
		        Params(2) = MapCompatibility
		        Params(3) = Difficulty
		        Return Signature.Invoke(Nil, Params)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  App.Log("Could not create config group """ + GroupName + """ because the correct constructor could not be found.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Purchased(Extends Config As Beacon.ConfigGroup, PurchasedVersion As Integer) As Boolean
		  Return ConfigPurchased(Config.ConfigName, PurchasedVersion)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TypeInfoForConfigName(ConfigName As String) As Introspection.TypeInfo
		  Select Case ConfigName
		  Case BeaconConfigs.Difficulty.ConfigName
		    Return GetTypeInfo(BeaconConfigs.Difficulty)
		  Case BeaconConfigs.LootDrops.ConfigName
		    Return GetTypeInfo(BeaconConfigs.LootDrops)
		  Case BeaconConfigs.LootScale.ConfigName
		    Return GetTypeInfo(BeaconConfigs.LootScale)
		  Case BeaconConfigs.Metadata.ConfigName
		    Return GetTypeInfo(BeaconConfigs.Metadata)
		  Case BeaconConfigs.ExperienceCurves.ConfigName
		    Return GetTypeInfo(BeaconConfigs.ExperienceCurves)
		  Case BeaconConfigs.CustomContent.ConfigName
		    Return GetTypeInfo(BeaconConfigs.CustomContent)
		  Case BeaconConfigs.CraftingCosts.ConfigName
		    Return GetTypeInfo(BeaconConfigs.CraftingCosts)
		  Case BeaconConfigs.StackSizes.ConfigName
		    Return GetTypeInfo(BeaconConfigs.StackSizes)
		  Case BeaconConfigs.BreedingMultipliers.ConfigName
		    Return GetTypeInfo(BeaconConfigs.BreedingMultipliers)
		  Case BeaconConfigs.HarvestRates.ConfigName
		    Return GetTypeInfo(BeaconConfigs.HarvestRates)
		  Case BeaconConfigs.DinoAdjustments.ConfigName
		    Return GetTypeInfo(BeaconConfigs.DinoAdjustments)
		  Case BeaconConfigs.StatMultipliers.ConfigName
		    Return GetTypeInfo(BeaconConfigs.StatMultipliers)
		  Case BeaconConfigs.DayCycle.ConfigName
		    Return GetTypeInfo(BeaconConfigs.DayCycle)
		  Case BeaconConfigs.SpawnPoints.ConfigName
		    Return GetTypeInfo(BeaconConfigs.SpawnPoints)
		  Case BeaconConfigs.StatLimits.ConfigName
		    Return GetTypeInfo(BeaconConfigs.StatLimits)
		  Case BeaconConfigs.EngramControl.ConfigName
		    Return GetTypeInfo(BeaconConfigs.EngramControl)
		  End Select
		End Function
	#tag EndMethod


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
