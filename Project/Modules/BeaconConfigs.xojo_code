#tag Module
Protected Module BeaconConfigs
	#tag Method, Flags = &h1
		Protected Function AllConfigNames(Human As Boolean = False) As Text()
		  Static Names() As Text
		  If Names.Ubound = -1 Then
		    Names.Append(BeaconConfigs.Difficulty.ConfigName)
		    Names.Append(BeaconConfigs.LootDrops.ConfigName)
		    Names.Append(BeaconConfigs.LootScale.ConfigName)
		    Names.Append(BeaconConfigs.Metadata.ConfigName)
		    Names.Append(BeaconConfigs.ExperienceCurves.ConfigName)
		    Names.Append(BeaconConfigs.CustomContent.ConfigName)
		    Names.Append(BeaconConfigs.CraftingCosts.ConfigName)
		  End If
		  If Human = True Then
		    Static HumanNames() As Text
		    If HumanNames.Ubound = -1 Then
		      Redim HumanNames(Names.Ubound)
		      For I As Integer = 0 To Names.Ubound
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
		Protected Function CreateInstance(GroupName As Text) As Beacon.ConfigGroup
		  Dim Info As Xojo.Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info = Nil Or Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    Return Nil
		  End If 
		  
		  Dim Constructors() As Xojo.Introspection.ConstructorInfo = Info.Constructors
		  For Each Signature As Xojo.Introspection.ConstructorInfo In Constructors
		    Dim Params() As Xojo.Introspection.ParameterInfo = Signature.Parameters
		    If Params.Ubound = -1 Then
		      Return Signature.Invoke()
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As Text, GroupData As Xojo.Core.Dictionary, Identity As Beacon.Identity) As Beacon.ConfigGroup
		  Dim Info As Xojo.Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info = Nil Or Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    Return Nil
		  End If 
		  
		  Dim Constructors() As Xojo.Introspection.ConstructorInfo = Info.Constructors
		  For Each Signature As Xojo.Introspection.ConstructorInfo In Constructors
		    Dim Params() As Xojo.Introspection.ParameterInfo = Signature.Parameters
		    If Params.Ubound = 1 And Params(0).IsByRef = False And Params(0).ParameterType.FullName = "Xojo.Core.Dictionary" And Params(1).IsByRef = False And Params(1).ParameterType.FullName = "Beacon.Identity" Then
		      Dim Values(1) As Auto
		      Values(0) = GroupData
		      Values(1) = Identity
		      Return Signature.Invoke(Values)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TypeInfoForConfigName(ConfigName As Text) As Xojo.Introspection.TypeInfo
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
		  End Select
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
