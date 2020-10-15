#tag Module
Protected Module Stats
	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Stat()
		  Var Arr(11) As Beacon.Stat
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
		Protected Function CraftingSpeed() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("CraftingSpeed", 11, True, 100, True, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Food() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Food", 4, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt16) As Beacon.Stat()
		  Var Arr() As Beacon.Stat = All
		  Var Results() As Beacon.Stat
		  For Each Stat As Beacon.Stat In Arr
		    If (Mask And Stat.Mask) = Stat.Mask Then
		      Results.Add(Stat)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Fortitude() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Fortitude", 10, False, 0, True, 2, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Health() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Health", 0, False, 100, False, 10, True, 1.0, 0.2, 0.14, 0.44)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Melee() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Melee", 8, True, 100, True, 5, True, 1.0, 0.17, 0.14, 0.44)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Named(Key As String) As Beacon.Stat
		  Var Arr() As Beacon.Stat = All
		  For Each Stat As Beacon.Stat In Arr
		    If Stat.Key = Key Then
		      Return Stat
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Oxygen() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Oxygen", 3, False, 100, False, 20, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Speed() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Speed", 9, True, 100, True, 1.5, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Stamina() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Stamina", 1, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Temperature() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Temperature", 6, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Torpor() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Torpor", 2, False, 200, False, 0, False, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Water() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Water", 5, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Weight() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Weight", 7, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WithIndex(Index As Integer) As Beacon.Stat
		  Var Arr() As Beacon.Stat = All
		  For Each Stat As Beacon.Stat In Arr
		    If Stat.Index = Index Then
		      Return Stat
		    End If
		  Next
		End Function
	#tag EndMethod


End Module
#tag EndModule
