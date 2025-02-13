#tag Class
Protected Class Engram
	#tag Method, Flags = &h0
		Function AsDictionary() As Dictionary
		  Var Tags() As String
		  If Self.CanBeBlueprint Then
		    Tags.Add("blueprintable")
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("object_id") = Self.ID
		  Dict.Value("path") = Self.Path
		  Dict.Value("label") = Self.Label
		  Dict.Value("mod_id") = Self.ModID
		  Dict.Value("availability") = Self.Availability
		  Dict.Value("tags") = Tags
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  If Self.mPath.IndexOf("/") > -1 And Self.mPath.IndexOf(".") > -1 Then
		    Var Components() As String = Self.mPath.Split("/")
		    Var Tail As String = Components(Components.LastIndex)
		    Components = Tail.Split(".")
		    Return Components(Components.LastIndex) + "_C"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAvailability = Ark.Maps.UniversalMask
		  Self.mID = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.Engram)
		  Self.CanBeBlueprint = Source.IsTagged("blueprintable")
		  Self.Label = Source.Label
		  Self.mAvailability = Source.Availability
		  Self.mPath = Source.Path
		  Self.mID = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As BeaconAPI.Engram)
		  Self.CanBeBlueprint = Source.CanBeBlueprint
		  Self.Label = Source.Label
		  Self.mAvailability = Source.mAvailability
		  Self.mPath = Source.mPath
		  Self.mID = Source.mID
		  Self.mModName = Source.mModName
		  Self.ModID = Source.ModID
		  Self.mResourceURL = Source.mResourceURL
		  Self.mSpawnCode = Source.mSpawnCode
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
		  Self.CanBeBlueprint = Source.Value("can_blueprint")
		  Self.Label = Source.Value("label")
		  Self.mAvailability = 0
		  Self.mPath = Source.Value("path")
		  Self.mResourceURL = Source.Value("resource_url")
		  Self.mSpawnCode = Source.Value("spawn")
		  
		  If Source.Value("mod_id") <> Nil Then
		    Self.mModName = Source.Value("mod_name")
		    Self.ModID = Source.Value("mod_id")
		  Else
		    Self.mModName = ""
		    Self.ModID = ""
		  End If
		  
		  If Source.HasKey("id") Then
		    Self.mID = Source.Value("id").StringValue
		  Else
		    Self.mID = Beacon.UUID.v4
		  End If
		  
		  If Source.HasKey("availability") Then
		    Self.mAvailability = Source.Value("availability").UInt64Value
		  ElseIf Source.HasKey("environments") Then
		    Var Environments() As Variant = Source.Value("environments")
		    For Each Environment As String In Environments
		      Var Map As Ark.Map
		      Select Case Environment
		      Case "island"
		        Map = Ark.Maps.TheIsland
		      Case "scorched"
		        Map = Ark.Maps.ScorchedEarth
		      Case "center"
		        Map = Ark.Maps.TheCenter
		      Case "ragnarok"
		        Map = Ark.Maps.Ragnarok
		      Case "abberation", "aberration"
		        Map = Ark.Maps.Aberration
		      Case "extinction"
		        Map = Ark.Maps.Extinction
		      Case "valguero"
		        Map = Ark.Maps.Valguero
		      Case "genesis"
		        Map = Ark.Maps.Genesis
		      Case "crystalisles"
		        Map = Ark.Maps.CrystalIsles
		      End Select
		      If Map <> Nil Then
		        Self.ValidForMap(Map) = True
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Var Value As String = Self.mPath.Lowercase + ":" + Self.Label.Lowercase + ":" + Self.mAvailability.ToString(Locale.Raw, "0") + ":" + if(Self.CanBeBlueprint, "True", "False")
		  Return EncodeHex(Crypto.MD5(Value))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As String
		  Return Self.mID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  Return Self.mModName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As BeaconAPI.Engram) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mID.Compare(Other.mID, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourceURL() As String
		  Return Self.mResourceURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnCode() As String
		  Return Self.mSpawnCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UID() As String
		  Return EncodeHex(Crypto.MD5(Self.mPath.Lowercase)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Ark.Map) As Boolean
		  Return Map = Nil Or Map.Matches(Self.mAvailability)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Map As Ark.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.mAvailability = Self.mAvailability Or Map.Mask
		  Else
		    Self.mAvailability = Self.mAvailability And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAvailability
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mAvailability = Value
			End Set
		#tag EndSetter
		Availability As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		CanBeBlueprint As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Label As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ModID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResourceURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnCode As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mPath = Value
			End Set
		#tag EndSetter
		Path As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Availability"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanBeBlueprint"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
			Name="Label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="ModID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Path"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
