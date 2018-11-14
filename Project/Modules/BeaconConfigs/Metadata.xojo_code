#tag Class
Protected Class Metadata
Inherits Beacon.ConfigGroup
	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  If Dict.HasKey("Title") Then
		    Self.Title = Dict.Value("Title")
		  End If
		  If Dict.HasKey("Description") Then
		    Self.Description = Dict.Value("Description")
		  End If
		  If Dict.HasKey("Public") Then
		    Self.IsPublic = Dict.Value("Public")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dict.Value("Title") = Self.Title
		  Dict.Value("Description") = Self.Description
		  Dict.Value("Public") = Self.IsPublic
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "Metadata"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.Metadata
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused QualityMultiplier
		  
		  If ParsedData.HasKey("SessionName") Then
		    Dim Config As New BeaconConfigs.Metadata
		    Try
		      Config.Title = ParsedData.Value("SessionName")
		      Return Config
		    Catch Err As TypeMismatchException
		    End Try
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Dim Values() As Beacon.ConfigValue
		  Values.Append(New Beacon.ConfigValue("SessionSettings", "SessionName", Self.mTitle))
		  Return Values
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDescription
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDescription.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mDescription = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Description As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIsPublic
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIsPublic <> Value Then
			    Self.mIsPublic = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		IsPublic As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDescription As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsPublic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mTitle.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mTitle = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Title As Text
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsPublic"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
