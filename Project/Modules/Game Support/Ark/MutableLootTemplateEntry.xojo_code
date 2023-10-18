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
		  #Pragma StackOverflowChecking False
		  If Self.mAvailability = Value Then
		    Return
		  End If
		  
		  Self.mAvailability = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChanceToBeBlueprint(Assigns Value As Double)
		  #Pragma StackOverflowChecking False
		  If Self.mChanceToBeBlueprint = Value Then
		    Return
		  End If
		  
		  Self.mChanceToBeBlueprint = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEntryId = Beacon.UUID.v4
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EntryId(Assigns Value As String)
		  #Pragma StackOverflowChecking False
		  If Self.mEntryId = Value Then
		    Return
		  End If
		  
		  Self.mEntryId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootTemplateEntry
		  Return New Ark.LootTemplateEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuality(Assigns Value As Ark.Quality)
		  If Self.mMaxQuality = Value Then
		    Return
		  End If
		  
		  Self.mMaxQuality = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuantity(Assigns Value As Integer)
		  #Pragma StackOverflowChecking False
		  Value = Max(Value, 0)
		  If Self.mMaxQuantity = Value Then
		    Return
		  End If
		  
		  Self.mMaxQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuality(Assigns Value As Ark.Quality)
		  If Self.mMinQuality = Value Then
		    Return
		  End If
		  
		  Self.mMinQuality = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuantity(Assigns Value As Integer)
		  #Pragma StackOverflowChecking False
		  Value = Max(Value, 0)
		  If Self.mMinQuantity = Value Then
		    Return
		  End If
		  
		  Self.mMinQuantity = Value
		  Self.Modified = True
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
		  #Pragma StackOverflowChecking False
		  If Self.mPreventGrinding = Value Then
		    Return
		  End If
		  
		  Self.mPreventGrinding = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  #Pragma StackOverflowChecking False
		  Value = Max(Value, 0)
		  If Self.mWeight = Value Then
		    Return
		  End If
		  
		  Self.mWeight = Value
		  Self.Modified = True
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
		  #Pragma StackOverflowChecking False
		  If Self.mRespectBlueprintChanceMultipliers = Value Then
		    Return
		  End If
		  
		  Self.mRespectBlueprintChanceMultipliers = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectQualityOffsets(Assigns Value As Boolean)
		  #Pragma StackOverflowChecking False
		  If Self.mRespectQualityOffsets = Value Then
		    Return
		  End If
		  
		  Self.mRespectQualityOffsets = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectQuantityMultipliers(Assigns Value As Boolean)
		  #Pragma StackOverflowChecking False
		  If Self.mRespectQuantityMultipliers = Value Then
		    Return
		  End If
		  
		  Self.mRespectQuantityMultipliers = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectWeightMultipliers(Assigns Value As Boolean)
		  #Pragma StackOverflowChecking False
		  If Self.mRespectWeightMultipliers = Value Then
		    Return
		  End If
		  
		  Self.mRespectWeightMultipliers = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SingleItemQuantity(Assigns Value As Boolean)
		  #Pragma StackOverflowChecking False
		  If Self.mSingleItemQuantity = Value Then
		    Return
		  End If
		  
		  Self.mSingleItemQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StatClampMultiplier(Assigns Value As Double)
		  #Pragma StackOverflowChecking False
		  If Self.mStatClampMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mStatClampMultiplier = Value
		  Self.Modified = True
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
