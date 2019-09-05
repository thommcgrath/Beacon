#tag Class
Protected Class Metadata
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused SourceDocument
		  
		  Values.Append(New Beacon.ConfigValue("SessionSettings", "SessionName", Profile.Name))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
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
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Title") = Self.Title
		  Dict.Value("Description") = Self.Description
		  Dict.Value("Public") = Self.IsPublic
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "Metadata"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.Metadata
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If ParsedData.HasKey("SessionName") Then
		    Dim SessionNames() As Variant = ParsedData.AutoArrayValue("SessionName")
		    For Each SessionName As Variant In SessionNames
		      Try
		        Dim Config As New BeaconConfigs.Metadata
		        Config.Title = SessionName
		        Return Config
		      Catch Err As TypeMismatchException
		      End Try
		    Next
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
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
			  If Self.mDescription.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mDescription = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Description As String
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
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsPublic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mTitle.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mTitle = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Title As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsPublic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
