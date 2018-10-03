#tag Module
Protected Module BeaconConfigs
	#tag Method, Flags = &h1
		Protected Function AllConfigNames(Human As Boolean = False) As Text()
		  Static Names() As Text
		  If Names.Ubound = -1 Then
		    Names.Append(BeaconConfigs.Difficulty.ConfigName)
		    Names.Append(BeaconConfigs.LootDrops.ConfigName)
		    Names.Append(BeaconConfigs.LootScale.ConfigName)
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
		Protected Function CreateInstance(GroupName As Text, GroupData As Xojo.Core.Dictionary) As Beacon.ConfigGroup
		  Dim Info As Xojo.Introspection.TypeInfo = BeaconConfigs.TypeInfoForConfigName(GroupName)
		  If Info = Nil Or Info.IsSubclassOf(GetTypeInfo(Beacon.ConfigGroup)) = False Then
		    Return Nil
		  End If 
		  
		  Dim Constructors() As Xojo.Introspection.ConstructorInfo = Info.Constructors
		  For Each Signature As Xojo.Introspection.ConstructorInfo In Constructors
		    Dim Params() As Xojo.Introspection.ParameterInfo = Signature.Parameters
		    If Params.Ubound = 0 And Params(0).IsByRef = False And Params(0).ParameterType.FullName = "Xojo.Core.Dictionary" Then
		      Dim Values(0) As Auto
		      Values(0) = GroupData
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
