#tag Class
Protected Class APIEngram
	#tag Method, Flags = &h0
		Sub AddEnvironment(Package As Beacon.LootSource.Packages)
		  Self.mAvailability = Self.mAvailability Or Beacon.LootSource.PackageToInteger(Package)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsDictionary() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("class") = Self.ClassString
		  Dict.Value("label") = Self.Label
		  Dict.Value("mod_id") = Self.ModID
		  Dict.Value("availability") = Self.mAvailability
		  Dict.Value("can_blueprint") = Self.CanBeBlueprint
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AvailableTo(Package As Beacon.LootSource.Packages) As Boolean
		  Dim PackageValue As UInteger = Beacon.LootSource.PackageToInteger(Package)
		  Return (PackageValue And Self.mAvailability) = PackageValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAvailability = Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Island) Or Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Scorched)
		  Self.mID = Beacon.CreateUUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As APIEngram)
		  Self.CanBeBlueprint = Source.CanBeBlueprint
		  Self.Label = Source.Label
		  Self.mAvailability = Source.mAvailability
		  Self.mClassString = Source.mClassString
		  Self.mID = Source.mID
		  Self.mModName = Source.mModName
		  Self.ModID = Source.ModID
		  Self.mResourceURL = Source.mResourceURL
		  Self.mSpawnCode = Source.mSpawnCode
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Xojo.Core.Dictionary)
		  Self.CanBeBlueprint = Source.Value("can_blueprint")
		  Self.Label = Source.Value("label")
		  Self.mAvailability = 0
		  Self.mClassString = Source.Value("class")
		  Self.mID = Beacon.CreateUUID
		  Self.mModName = ""
		  Self.ModID = ""
		  Self.mResourceURL = Source.Value("resource_url")
		  Self.mSpawnCode = Source.Value("spawn")
		  
		  If Source.Value("mod_id") <> Nil Then
		    Self.mModName = Source.Value("mod_name")
		    Self.ModID = Source.Value("mod_id")
		  End If
		  
		  Dim Environments() As Text = Source.Value("environments")
		  For Each Environment As Text In Environments
		    Dim Package As Beacon.LootSource.Packages
		    Select Case Environment
		    Case "island"
		      Package = Beacon.LootSource.Packages.Island
		    Case "scorched"
		      Package = Beacon.LootSource.Packages.Scorched
		    End Select
		    Self.mAvailability = Self.mAvailability Or Beacon.LootSource.PackageToInteger(Package)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As Text
		  Return Self.mID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As Text
		  Return Self.mModName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As APIEngram) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mID.Compare(Other.mID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveEnvironment(Package As Beacon.LootSource.Packages)
		  Self.mAvailability = Self.mAvailability And (Not Beacon.LootSource.PackageToInteger(Package))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourceURL() As Text
		  Return Self.mResourceURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnCode() As Text
		  Return Self.mSpawnCode
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAvailability
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Mask As UInteger = Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Island) Or Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Scorched)
			  Self.mAvailability = Value And Mask
			End Set
		#tag EndSetter
		Availability As UInteger
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		CanBeBlueprint As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mClassString
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value.Trim
			  
			  If Value.IndexOf("/") <> -1 Or Value.IndexOf(".") <> -1 Then
			    // Likely have a path
			    If Value.Length > 9 And Value.Left(9) = "Blueprint" Then
			      Value = Value.Mid(9)
			    End If
			    
			    If Value.Left(1) = "'" Then
			      Value = Value.Mid(1)
			    End If
			    
			    If Value.Left(1) = """" Then
			      Value = Value.Mid(1)
			    End If
			    
			    If Value.Right(1) = "'" Then
			      Value = Value.Left(Value.Length - 1)
			    End If
			    
			    If Value.Right(1) = """" Then
			      Value = Value.Left(Value.Length - 1)
			    End If
			    
			    // Should have a normalized path now, grab the last segment
			    If Value.IndexOf("/") <> -1 Then
			      Dim Parts() As Text = Value.Split("/")
			      Value = Parts(UBound(Parts))
			    End If
			    
			    // Now we need the part after the dot
			    If Value.IndexOf(".") <> -1 Then
			      Dim Parts() As Text = Value.Split(".")
			      Value = Parts(UBound(Parts))
			    End If
			  End If
			  
			  If Value.Length < 2 Or Value.Right(2) <> "_C" Then
			    Value = Value + "_C"
			  End If
			  
			  Self.mClassString = Value
			End Set
		#tag EndSetter
		ClassString As Text
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Label As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailability As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClassString As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModName As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		ModID As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResourceURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnCode As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Availability"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanBeBlueprint"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClassString"
			Group="Behavior"
			Type="Text"
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
