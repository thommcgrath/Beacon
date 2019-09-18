#tag Module
Protected Module Stats
	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Stat()
		  Dim Arr(10) As Beacon.Stat
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
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CraftingSpeed() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("CraftingSpeed", 11, 100, True, 10, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Food() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Food", 4, 100, False, 10, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Fortitude() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Fortitude", 10, 0, True, 2, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Health() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Health", 0, 100, False, 10, 1.0, 0.2, 0.14, 0.44)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Melee() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Melee", 8, 100, True, 5, 1.0, 0.17, 0.14, 0.44)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Named(Key As String) As Beacon.Stat
		  Select Case Key
		  Case "CraftingSpeed"
		    Return CraftingSpeed
		  Case "Food"
		    Return Food
		  Case "Fortitude"
		    Return Fortitude
		  Case "Health"
		    Return Health
		  Case "Melee"
		    Return Melee
		  Case "Oxygen"
		    Return Oxygen
		  Case "Speed"
		    Return Speed
		  Case "Stamina"
		    Return Stamina
		  Case "Torpor"
		    Return Torpor
		  Case "Water"
		    Return Water
		  Case "Weight"
		    Return Weight
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Oxygen() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Oxygen", 3, 100, False, 20, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Speed() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Speed", 9, 100, True, 1.5, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Stamina() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Stamina", 1, 100, False, 10, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Torpor() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Torpor", 2, 200, False, 0, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Water() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Water", 5, 100, False, 10, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Weight() As Beacon.Stat
		  Static Stat As Beacon.Stat
		  If Stat = Nil Then
		    Stat = New Beacon.Stat("Weight", 7, 100, False, 10, 1.0, 1.0, 1.0, 1.0)
		  End If
		  Return Stat
		End Function
	#tag EndMethod


End Module
#tag EndModule
