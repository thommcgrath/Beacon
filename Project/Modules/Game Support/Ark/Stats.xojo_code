#tag Module
Protected Module Stats
	#tag Method, Flags = &h1
		Protected Function All() As Ark.Stat()
		  Var Arr(11) As Ark.Stat
		  Arr(CraftingSpeed.Index) = CraftingSpeed
		  Arr(Food.Index) = Food
		  Arr(Fortitude.Index) = Fortitude
		  Arr(Health.Index) = Health
		  Arr(Melee.Index) = Melee
		  Arr(Oxygen.Index) = Oxygen
		  Arr(Speed.Index) = Speed
		  Arr(Stamina.Index) = Stamina
		  Arr(Torpor.Index) = Torpor
		  Arr(Water.Index) = Water
		  Arr(Weight.Index) = Weight
		  Arr(Temperature.Index) = Temperature
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CraftingSpeed() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("CraftingSpeed", 11, True, 100, True, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Food() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Food", 4, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt16) As Ark.Stat()
		  Var Arr() As Ark.Stat = All
		  Var Results() As Ark.Stat
		  For Each Stat As Ark.Stat In Arr
		    If (Mask And Stat.Mask) = Stat.Mask Then
		      Results.Add(Stat)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Fortitude() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Fortitude", 10, False, 0, True, 2, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Health() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Health", 0, False, 100, False, 10, True, 1.0, 0.2, 0.14, 0.44)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Melee() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Melee", 8, True, 100, True, 5, True, 1.0, 0.17, 0.14, 0.44)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Named(Key As String) As Ark.Stat
		  Var Arr() As Ark.Stat = All
		  For Each Stat As Ark.Stat In Arr
		    If Stat.Key = Key Then
		      Return Stat
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Oxygen() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Oxygen", 3, False, 100, False, 20, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Speed() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Speed", 9, True, 100, True, 1.5, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Stamina() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Stamina", 1, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Temperature() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Temperature", 6, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Torpor() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Torpor", 2, False, 200, False, 0, False, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Water() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Water", 5, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Weight() As Ark.Stat
		  Static Stat As Ark.Stat
		  If Stat = Nil Then
		    Stat = New Ark.Stat("Weight", 7, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WithIndex(Index As Integer) As Ark.Stat
		  Var Arr() As Ark.Stat = All
		  For Each Stat As Ark.Stat In Arr
		    If Stat.Index = Index Then
		      Return Stat
		    End If
		  Next
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
