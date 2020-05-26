#tag Module
Protected Module Stats
	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Stat()
		  Var Arr(11) As Beacon.Stat
		  Arr(0) = CraftingSpeed
		  Arr(1) = Food
		  Arr(2) = Fortitude
		  Arr(3) = Health
		  Arr(4) = Melee
		  Arr(5) = Oxygen
		  Arr(6) = Speed
		  Arr(7) = Stamina
		  Arr(8) = Torpor
		  Arr(9) = Water
		  Arr(10) = Weight
		  Arr(11) = Temperature
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CraftingSpeed() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("CraftingSpeed", 11, 2048, True, 100, True, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Food() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Food", 4, 16, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
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
		      Results.AddRow(Stat)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Fortitude() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Fortitude", 10, 1024, False, 0, True, 2, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Health() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Health", 0, 1, False, 100, False, 10, True, 1.0, 0.2, 0.14, 0.44)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Melee() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Melee", 8, 256, True, 100, True, 5, True, 1.0, 0.17, 0.14, 0.44)
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
		    Stat = New Beacon.Stat("Oxygen", 3, 8, False, 100, False, 20, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Speed() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Speed", 9, 512, True, 100, True, 1.5, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Stamina() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Stamina", 1, 2, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Temperature() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Temperature", 6, 64, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Torpor() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Torpor", 2, 4, False, 200, False, 0, False, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Water() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Water", 5, 32, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Weight() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Weight", 7, 128, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0)
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
