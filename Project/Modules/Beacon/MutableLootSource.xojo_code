#tag Class
Protected Class MutableLootSource
Inherits Beacon.LootSource
	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClassString(Assigns Value As String)
		  Self.mClassString = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As String, Official As Boolean)
		  Super.Constructor
		  Self.mClassString = ClassString
		  Self.mIsOfficial = Official
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Experimental(Assigns Value As Boolean)
		  Self.mExperimental = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsOfficial(Assigns Value As Boolean)
		  Self.mIsOfficial = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MandatoryItemSets(Assigns Sets() As Beacon.ItemSet)
		  Redim Self.mMandatoryItemSets(Sets.Ubound)
		  For I As Integer = 0 To Sets.Ubound
		    Self.mMandatoryItemSets(I) = New Beacon.ItemSet(Sets(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Multipliers(Assigns Value As Beacon.Range)
		  Self.mMultipliers = New Beacon.Range(Value.Min, Value.Max)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Notes(Assigns Value As String)
		  Self.mNotes = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredItemSets(Assigns Value As Integer)
		  Self.mRequiredItemSets = Max(Value, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortValue(Assigns Value As Integer)
		  Self.mSortValue = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UIColor(Assigns Value As Color)
		  Self.mUIColor = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseBlueprints(Assigns Value As Boolean)
		  Self.mUseBlueprints = Value
		End Sub
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="AppendMode"
			Group="Behavior"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxItemSets"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinItemSets"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NumItemSetsPower"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SetsRandomWithoutReplacement"
			Group="Behavior"
			Type="Boolean"
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
