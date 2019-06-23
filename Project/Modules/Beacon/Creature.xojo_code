#tag Class
Protected Class Creature
Implements Beacon.Blueprint
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As Text
		  Dim Components() As Text = Self.mPath.Split("/")
		  Dim Tail As Text = Components(Components.Ubound)
		  Components = Tail.Split(".")
		  Return Components(Components.Ubound) + "_C"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.Blueprint
		  Return New Beacon.Creature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mAvailability = Beacon.Maps.All.Mask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Creature)
		  Self.Constructor()
		  
		  Self.mObjectID = Source.mObjectID
		  Self.mAvailability = Source.mAvailability
		  Self.mPath = Source.mPath
		  Self.mLabel = Source.mLabel
		  Self.mModID = Source.mModID
		  Self.mModName = Source.mModName
		  If Source.mIncubationTime <> Nil Then
		    Self.mIncubationTime = Source.mIncubationTime.Clone
		  End If
		  If Source.mMatureTime <> Nil Then
		    Self.mMatureTime = Source.mMatureTime.Clone
		  End If
		  
		  Redim Self.mTags(-1)
		  For Each Tag As Text In Source.mTags
		    Self.mTags.Append(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IncubationTime() As Xojo.Core.DateInterval
		  Return Self.mIncubationTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatureTime() As Xojo.Core.DateInterval
		  Return Self.mMatureTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As Text
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As Text
		  Return Self.mModName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Beacon.MutableBlueprint
		  Return New Beacon.MutableCreature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Text
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Creature) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Dim SelfPath As Text = Self.Path
		  Dim OtherPath As Text = Other.Path
		  Return SelfPath.Compare(OtherPath)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As Text
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As Text()
		  Dim Clone() As Text
		  Redim Clone(Self.mTags.Ubound)
		  For I As Integer = 0 To Self.mTags.Ubound
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIncubationTime As Xojo.Core.DateInterval
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMatureTime As Xojo.Core.DateInterval
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModID As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModName As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mObjectID As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTags() As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
