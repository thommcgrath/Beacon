#tag Module
Protected Module BeaconConfigs
	#tag Method, Flags = &h1
		Protected Function AllConfigNames(Human As Boolean = False) As String()
		  Static Names() As String
		  If Names.LastRowIndex = -1 Then
		    Names.Append(BeaconConfigs.Difficulty.ConfigName)
		    Names.Append(BeaconConfigs.LootDrops.ConfigName)
		    Names.Append(BeaconConfigs.LootScale.ConfigName)
		    Names.Append(BeaconConfigs.Metadata.ConfigName)
		    Names.Append(BeaconConfigs.ExperienceCurves.ConfigName)
		    Names.Append(BeaconConfigs.CustomContent.ConfigName)
		    Names.Append(BeaconConfigs.CraftingCosts.ConfigName)
		    Names.Append(BeaconConfigs.StackSizes.ConfigName)
		    Names.Append(BeaconConfigs.BreedingMultipliers.ConfigName)
		    Names.Append(BeaconConfigs.HarvestRates.ConfigName)
		    Names.Append(BeaconConfigs.DinoAdjustments.ConfigName)
		  End If
		  If Human = True Then
		    Static HumanNames() As String
		    If HumanNames.LastRowIndex = -1 Then
		      Redim HumanNames(Names.LastRowIndex)
		      For I As Integer = 0 To Names.LastRowIndex
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
		  Dim Info As Introspection.TypeInfo = TypeInfoForConfigName(ConfigName)
		  If Info = Nil Then
		    Return True
		  End If
		  
		  Dim ConfigAttributes() As Introspection.AttributeInfo = Info.GetAttributes
		  For Each ConfigAttribute As Introspection.AttributeInfo In ConfigAttributes
		    If ConfigAttribute.Name <> "OmniVersion" Then
		      Continue
		    End If
		    
		    Dim AttributeValue As Variant = ConfigAttribute.Value
		    Dim RequiredVersion As Integer
		    Select Case AttributeValue.Type
		    Case Variant.TypeInteger
		      RequiredVersion = AttributeValue.IntegerValue
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
		  Dim Info As Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info = Nil Or Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    Return Nil
		  End If 
		  
		  Dim Constructors() As Introspection.ConstructorInfo = Info.GetConstructors
		  For Each Signature As Introspection.ConstructorInfo In Constructors
		    Dim Params() As Introspection.ParameterInfo = Signature.GetParameters
		    If Params.LastRowIndex = -1 Then
		      Return Signature.Invoke()
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As String, GroupData As Dictionary, Identity As Beacon.Identity) As Beacon.ConfigGroup
		  Dim Info As Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info = Nil Or Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    Return Nil
		  End If 
		  
		  Dim Constructors() As Introspection.ConstructorInfo = Info.GetConstructors
		  For Each Signature As Introspection.ConstructorInfo In Constructors
		    Dim Params() As Introspection.ParameterInfo = Signature.GetParameters
		    If Params.LastRowIndex = 1 And Params(0).IsByRef = False And Params(0).ParameterType.FullName = "Dictionary" And Params(1).IsByRef = False And Params(1).ParameterType.FullName = "Beacon.Identity" Then
		      Dim Values(1) As Variant
		      Values(0) = GroupData
		      Values(1) = Identity
		      Return Signature.Invoke(Values)
		    End If
		  Next
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
