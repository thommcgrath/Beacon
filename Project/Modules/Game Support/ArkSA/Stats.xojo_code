#tag Module
Protected Module Stats
	#tag Method, Flags = &h1
		Protected Function All() As ArkSA.Stat()
		  Var Arr(11) As ArkSA.Stat
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
		Protected Function CraftingSpeed() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Crafting", "CraftingSpeed", 11, True, 100, True, 10, True, 1.0, 1.0, 1.0, 1.0) // 2048
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Food() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Food", "Food", 4, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0) // 16
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt16) As ArkSA.Stat()
		  Var Arr() As ArkSA.Stat = All
		  Var Results() As ArkSA.Stat
		  For Each Stat As ArkSA.Stat In Arr
		    If (Mask And Stat.Mask) = Stat.Mask Then
		      Results.Add(Stat)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Fortitude() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Fortitude", "Fortitude", 10, False, 0, True, 2, True, 1.0, 1.0, 1.0, 1.0) // 1024
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Health() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Health", "Health", 0, False, 100, False, 10, True, 1.0, 0.2, 0.14, 0.44) // 1
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Melee() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Melee", "Melee", 8, True, 100, True, 5, True, 1.0, 0.17, 0.14, 0.44) // 256
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Named(Key As String) As ArkSA.Stat
		  Var Arr() As ArkSA.Stat = All
		  For Each Stat As ArkSA.Stat In Arr
		    If Stat.Key = Key Then
		      Return Stat
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Oxygen() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Oxygen", "Oxygen", 3, False, 100, False, 20, True, 1.0, 1.0, 1.0, 1.0) // 8
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Speed() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Speed", "Speed", 9, True, 100, True, 1.5, True, 1.0, 1.0, 1.0, 1.0) // 512
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Stamina() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Stamina", "Stamina", 1, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0) // 2
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Temperature() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Temperature", "Temperature", 6, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0) // 64
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Torpor() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Torpor", "Torpor", 2, False, 200, False, 0, False, 1.0, 1.0, 1.0, 1.0) // 4
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Water() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Water", "Water", 5, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0) // 32
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Weight() As ArkSA.Stat
		  Static Stat As ArkSA.Stat
		  If Stat = Nil Then
		    Stat = New ArkSA.Stat("Weight", "Weight", 7, False, 100, False, 10, True, 1.0, 1.0, 1.0, 1.0) // 128
		  End If
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WithIndex(Index As Integer) As ArkSA.Stat
		  Var Arr() As ArkSA.Stat = All
		  For Each Stat As ArkSA.Stat In Arr
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
