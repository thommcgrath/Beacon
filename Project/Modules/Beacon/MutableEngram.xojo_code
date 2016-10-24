#tag Class
Protected Class MutableEngram
Inherits Beacon.Engram
	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInteger)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AvailableTo(Package As Beacon.LootSource.Packages, Assigns Value As Boolean)
		  Dim PackageValue As UInteger = Beacon.LootSource.PackageToInteger(Package)
		  If Value Then
		    Self.mAvailability = Self.mAvailability Or PackageValue
		  Else
		    Self.mAvailability = Self.mAvailability And Not PackageValue
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CanBeBlueprint(Assigns Value As Boolean)
		  Self.mCanBeBlueprint = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClassString(Assigns Value As Text)
		  Self.mClassString = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As Text)
		  Super.Constructor()
		  
		  Self.mClassString = ClassString
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As Text)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod


End Class
#tag EndClass
