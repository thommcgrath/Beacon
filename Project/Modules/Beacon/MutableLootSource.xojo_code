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
