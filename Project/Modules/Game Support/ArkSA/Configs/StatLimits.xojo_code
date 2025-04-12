#tag Class
Protected Class StatLimits
Inherits ArkSA.ConfigGroup
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Var Source As ArkSA.Configs.StatLimits = ArkSA.Configs.StatLimits(Other)
		  For Index As Integer = 0 To Self.mValues.LastIndex
		    Self.mValues(Index) = Source.mValues(Index)
		  Next Index
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As ArkSA.ConfigValue
		  Var EnableClamping As Boolean = False
		  
		  For I As Integer = 0 To Self.mValues.LastIndex
		    If Self.mValues(I) Is Nil Then
		      Continue
		    End If
		    
		    EnableClamping = True
		    
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "ItemStatClamps[" + I.ToString + "]=" + Min(Self.mValues(I).DoubleValue, ArkSA.EngramStat.MaxStatValue).PrettyText, I))
		  Next
		  
		  Values.Add(New ArkSA.ConfigValue("CommandLineOption", "?", "ClampItemStats=" + If(EnableClamping, "True", "False")))
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As ArkSA.ConfigOption()
		  Var Keys() As ArkSA.ConfigOption
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "ItemStatClamps"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "ClampItemStats"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  For Each Value As NullableDouble In Self.mValues
		    If IsNull(Value) = False Then
		      Return True
		    End If
		  Next Value
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("Armor") Then
		    Self.mValues(ArkSA.EngramStat.IndexArmor) = Min(SaveData.Value("Armor").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If SaveData.HasKey("Generic") Then
		    Self.mValues(ArkSA.EngramStat.IndexGenericQuality) = Min(SaveData.Value("Generic").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If SaveData.HasKey("Hyper") Then
		    Self.mValues(ArkSA.EngramStat.IndexHyperthermal) = Min(SaveData.Value("Hyper").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If SaveData.HasKey("Hypo") Then
		    Self.mValues(ArkSA.EngramStat.IndexHypothermal) = Min(SaveData.Value("Hypo").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If SaveData.HasKey("Durability") Then
		    Self.mValues(ArkSA.EngramStat.IndexMaxDurability) = Min(SaveData.Value("Durability").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If SaveData.HasKey("Ammo") Then
		    Self.mValues(ArkSA.EngramStat.IndexWeaponAmmo) = Min(SaveData.Value("Ammo").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If SaveData.HasKey("Damage") Then
		    Self.mValues(ArkSA.EngramStat.IndexWeaponDamage) = Min(SaveData.Value("Damage").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If SaveData.HasKey("Weight") Then
		    Self.mValues(ArkSA.EngramStat.IndexWeight) = Min(SaveData.Value("Weight").DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexArmor) Is Nil) = False Then
		    SaveData.Value("Armor") = Min(Self.mValues(ArkSA.EngramStat.IndexArmor).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexGenericQuality) Is Nil) = False Then
		    SaveData.Value("Generic") = Min(Self.mValues(ArkSA.EngramStat.IndexGenericQuality).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexHyperthermal) Is Nil) = False Then
		    SaveData.Value("Hyper") = Min(Self.mValues(ArkSA.EngramStat.IndexHyperthermal).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexHypothermal) Is Nil) = False Then
		    SaveData.Value("Hypo") = Min(Self.mValues(ArkSA.EngramStat.IndexHypothermal).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexMaxDurability) Is Nil) = False Then
		    SaveData.Value("Durability") = Min(Self.mValues(ArkSA.EngramStat.IndexMaxDurability).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexWeaponAmmo) Is Nil) = False Then
		    SaveData.Value("Ammo") = Min(Self.mValues(ArkSA.EngramStat.IndexWeaponAmmo).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexWeaponDamage) Is Nil) = False Then
		    SaveData.Value("Damage") = Min(Self.mValues(ArkSA.EngramStat.IndexWeaponDamage).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		  
		  If (Self.mValues(ArkSA.EngramStat.IndexWeight) Is Nil) = False Then
		    SaveData.Value("Weight") = Min(Self.mValues(ArkSA.EngramStat.IndexWeight).DoubleValue, ArkSA.EngramStat.MaxStatValue)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.Configs.StatLimits
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused ContentPacks
		  
		  Var Config As New ArkSA.Configs.StatLimits()
		  
		  For Index As Integer = 0 To Config.mValues.LastIndex
		    Var ValueTestOne As Double = ParsedData.DoubleValue("ItemStatClamps[" + Index.ToString + "]", 100.0, True)
		    Var ValueTestTwo As Double = ParsedData.DoubleValue("ItemStatClamps[" + Index.ToString + "]", 200.0, True)
		    
		    If ValueTestOne <> ValueTestTwo Then
		      // Default
		      Config.Value(Index) = Nil
		    Else
		      Config.Value(Index) = ValueTestOne
		    End If
		  Next
		  
		  If Config.Modified Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameStatLimits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Stat As Integer) As NullableDouble
		  Return Self.mValues(Stat)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Stat As Integer, Assigns Value As NullableDouble)
		  If Self.mValues(Stat) = Value Then
		    Return
		  End If
		  
		  Self.mValues(Stat) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValues(7) As NullableDouble
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
