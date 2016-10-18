#tag Class
Protected Class Engram
	#tag Method, Flags = &h0
		Function AvailableTo(Package As Beacon.LootSource.Packages) As Boolean
		  Dim PackageValue As UInteger = Beacon.LootSource.PackageToInteger(Package)
		  Return (PackageValue And Self.mAvailability) = PackageValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeBlueprint() As Boolean
		  Return Self.mCanBeBlueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As Text
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mCanBeBlueprint = True
		  Self.mAvailability = Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Island) Or Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Scorched)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Engram)
		  Self.Constructor()
		  
		  Self.mAvailability = Source.mAvailability
		  Self.mCanBeBlueprint = Source.mCanBeBlueprint
		  Self.mClassString = Source.mClassString
		  Self.mLabel = Source.mLabel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  If Self.mLabel <> "" Then
		    Return Self.mLabel
		  Else
		    Return Self.mClassString
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Lookup(ClassString As Text) As Beacon.Engram
		  Dim Engram As Beacon.Engram = Beacon.Data.GetEngram(ClassString)
		  If Engram = Nil Then
		    Engram = New Beacon.Engram
		    Engram.mClassString = ClassString
		  End If
		  Return Engram
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAvailability As UInteger
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCanBeBlueprint As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
