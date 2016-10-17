#tag Class
Protected Class MutableLootSource
Inherits Beacon.LootSource
	#tag Method, Flags = &h0
		Sub ClassString(Assigns Value As Text)
		  Self.mClassString = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As Text, Official As Boolean)
		  Super.Constructor
		  Self.mClassString = ClassString
		  Self.mIsOfficial = Official
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsOfficial(Assigns Value As Boolean)
		  Self.mIsOfficial = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Kind(Assigns Value As Beacon.LootSource.Kinds)
		  Self.mKind = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As Text)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Multipliers(Assigns Value As Beacon.Range)
		  Self.mMultipliers = New Beacon.Range(Value.Min, Value.Max)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Package(Assigns Value As Beacon.LootSource.Packages)
		  Self.mPackage = Value
		End Sub
	#tag EndMethod


End Class
#tag EndClass
