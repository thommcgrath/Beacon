#tag Class
Protected Class MutableLootTemplateEntry
Inherits Ark.LootTemplateEntry
	#tag Method, Flags = &h0
		Sub Add(Option As Ark.LootItemSetEntryOption)
		  Var Idx As Integer = Self.IndexOf(Option)
		  If Idx = -1 Then
		    Self.mOptions.Add(Option)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  If Self.mAvailability <> Value Then
		    Self.mAvailability = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChanceToBeBlueprint(Assigns Value As Double)
		  If Self.mChanceToBeBlueprint <> Value Then
		    Self.mChanceToBeBlueprint = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mUUID = New v4UUID
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootTemplateEntry
		  Return New Ark.LootTemplateEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuality(Assigns Value As Ark.Quality)
		  If Self.mMaxQuality <> Value Then
		    Self.mMaxQuality = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuantity(Assigns Value As Integer)
		  If Self.mMaxQuantity <> Value Then
		    Self.mMaxQuantity = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuality(Assigns Value As Ark.Quality)
		  If Self.mMinQuality <> Value Then
		    Self.mMinQuality = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuantity(Assigns Value As Integer)
		  If Self.mMinQuantity <> Value Then
		    Self.mMinQuantity = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootTemplateEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Idx As Integer, Assigns Option As Ark.LootItemSetEntryOption)
		  Var CurrentIdx As Integer = Self.IndexOf(Option)
		  If CurrentIdx = -1 Then
		    Self.mOptions(Idx) = Option
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventGrinding(Assigns Value As Boolean)
		  Self.mPreventGrinding = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  If Self.mWeight <> Value Then
		    Self.mWeight = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Option As Ark.LootItemSetEntryOption)
		  Var Idx As Integer = Self.IndexOf(Option)
		  If Idx > -1 Then
		    Self.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
		  Self.mOptions.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectBlueprintChanceMultipliers(Assigns Value As Boolean)
		  If Self.mRespectBlueprintChanceMultipliers <> Value Then
		    Self.mRespectBlueprintChanceMultipliers = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectQualityOffsets(Assigns Value As Boolean)
		  If Self.mRespectQualityOffsets <> Value Then
		    Self.mRespectQualityOffsets = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectQuantityMultipliers(Assigns Value As Boolean)
		  If Self.mRespectQuantityMultipliers <> Value Then 
		    Self.mRespectQuantityMultipliers = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectWeightMultipliers(Assigns Value As Boolean)
		  If Self.mRespectWeightMultipliers <> Value Then 
		    Self.mRespectWeightMultipliers = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SingleItemQuantity(Assigns Value As Boolean)
		  Self.mSingleItemQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StatClampMultiplier(Assigns Value As Double)
		  Self.mStatClampMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UUID(Assigns Value As String)
		  Self.mUUID = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Map As Ark.Map, Assigns Value As Boolean)
		  Self.ValidForMask(Map.Mask) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMask(Mask As UInt64, Assigns Value As Boolean)
		  If Value Then
		    Self.Availability = Self.mAvailability Or Mask
		  Else
		    Self.Availability = Self.mAvailability And Not Mask
		  End If
		End Sub
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
End Class
#tag EndClass
