#tag Class
Protected Class Engram
	#tag Method, Flags = &h0
		Function AsDictionary() As Dictionary
		  Dim Environments() As String
		  If Self.ValidForMap(Beacon.Maps.TheIsland) Then
		    Environments.Append("Island")
		  End If
		  If Self.ValidForMap(Beacon.Maps.ScorchedEarth) Then
		    Environments.Append("Scorched")
		  End If
		  If Self.ValidForMap(Beacon.Maps.TheCenter) Then
		    Environments.Append("Center")
		  End If
		  If Self.ValidForMap(Beacon.Maps.Ragnarok) Then
		    Environments.Append("Ragnarok")
		  End If
		  If Self.ValidForMap(Beacon.Maps.Aberration) Then
		    Environments.Append("Aberration")
		  End If
		  If Self.ValidForMap(Beacon.Maps.Extinction) Then
		    Environments.Append("Extinction")
		  End If
		  
		  Dim Dict As New Dictionary
		  Dict.Value("path") = Self.Path
		  Dict.Value("label") = Self.Label
		  Dict.Value("mod_id") = Self.ModID
		  Dict.Value("availability") = Environments
		  Dict.Value("can_blueprint") = Self.CanBeBlueprint
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  If Self.mPath.IndexOf("/") > -1 And Self.mPath.IndexOf(".") > -1 Then
		    Dim Components() As String = Self.mPath.Split("/")
		    Dim Tail As String = Components(Components.Ubound)
		    Components = Tail.Split(".")
		    Return Components(Components.Ubound) + "_C"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAvailability = Beacon.Maps.All.Mask
		  Self.mID = Beacon.CreateUUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Engram)
		  Self.CanBeBlueprint = Source.CanBeBlueprint
		  Self.Label = Source.Label
		  Self.mAvailability = Source.Availability
		  Self.mPath = Source.Path
		  Self.mID = Beacon.CreateUUID
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
		  Self.mID = Beacon.CreateUUID
		  Self.mModName = ""
		  Self.ModID = ""
		  Self.mResourceURL = Source.Value("resource_url")
		  Self.mSpawnCode = Source.Value("spawn")
		  
		  If Source.Value("mod_id") <> Nil Then
		    Self.mModName = Source.Value("mod_name")
		    Self.ModID = Source.Value("mod_id")
		  End If
		  
		  Dim Environments() As String = Source.Value("environments")
		  For Each Environment As String In Environments
		    Dim Map As Beacon.Map
		    Select Case Environment
		    Case "island"
		      Map = Beacon.Maps.TheIsland
		    Case "scorched"
		      Map = Beacon.Maps.ScorchedEarth
		    Case "center"
		      Map = Beacon.Maps.TheCenter
		    Case "ragnarok"
		      Map = Beacon.Maps.Ragnarok
		    Case "abberation", "aberration"
		      Map = Beacon.Maps.Aberration
		    Case "extinction"
		      Map = Beacon.Maps.Extinction
		    End Select
		    If Map <> Nil Then
		      Self.ValidForMap(Map) = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Dim Value As String = Self.mPath.Lowercase + ":" + Self.Label.Lowercase + ":" + Str(Self.mAvailability, "-0") + ":" + if(Self.CanBeBlueprint, "true", "false")
		  Return EncodeHex(Value)
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
		  
		  Return StrComp(Self.mID, Other.mID, 0)
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
		  Return Beacon.MD5(Self.mPath.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Beacon.Map) As Boolean
		  Return Map = Nil Or Map.Matches(Self.mAvailability)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Map As Beacon.Map, Assigns Value As Boolean)
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
			Group="Behavior"
			Type="UInt64"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanBeBlueprint"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Label"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ModID"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Path"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
