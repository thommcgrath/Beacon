#tag Class
Protected Class CustomLootContainer
Inherits Beacon.LootContainer
Implements Beacon.MutableLootSource
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
		Function Clone() As Beacon.LootSource
		  Return New Beacon.CustomLootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As String)
		  Super.Constructor
		  Self.mClassString = ClassString
		  Self.mPath = Beacon.UnknownBlueprintPath("LootSources", ClassString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EditSaveData(SaveData As Dictionary)
		  Super.EditSaveData(SaveData)
		  
		  SaveData.Value("Availability") = Self.Availability
		  SaveData.Value("Multiplier_Min") = Self.Multipliers.Min
		  SaveData.Value("Multiplier_Max") = Self.Multipliers.Max
		  SaveData.Value("UIColor") = Self.UIColor.Red.ToHex(2) + Self.UIColor.Green.ToHex(2) + Self.UIColor.Blue.ToHex(2) + Self.UIColor.Alpha.ToHex(2)
		  SaveData.Value("SortValue") = Self.SortValue
		  SaveData.Value("Label") = Self.Label
		  SaveData.Value("RequiredItemSets") = Self.RequiredItemSetCount
		  SaveData.Value("AppendMode") = Self.AppendMode
		  SaveData.Value("Experimental") = Self.Experimental
		  SaveData.Value("Notes") = Self.Notes
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Experimental(Assigns Value As Boolean)
		  Self.mExperimental = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadSaveData(SaveData As Dictionary) As Boolean
		  If Super.LoadSaveData(SaveData) = False Then
		    Return False
		  End If
		  
		  Try
		    Self.Availability = SaveData.Lookup("Availability", Beacon.Maps.All.Mask).UInt64Value
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.Multipliers = New Beacon.Range(SaveData.Lookup("Multiplier_Min", 1.0).DoubleValue, SaveData.Lookup("Multiplier_Max", 1.0).DoubleValue)
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.SortValue = SaveData.Lookup("SortValue", 999).IntegerValue
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.Label = SaveData.Lookup("Label", Self.mClassString).StringValue
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.RequiredItemSetCount = SaveData.Lookup("RequiredItemSets", 1).IntegerValue
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.Experimental = SaveData.Lookup("Experimental", False).BooleanValue
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.Notes = SaveData.Lookup("Notes", "").StringValue
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Var UIColor As String = SaveData.Lookup("UIColor", "FFFFFF00")
		    Self.UIColor = Color.RGB(Integer.FromHex(UIColor.Middle(0, 2)), Integer.FromHex(UIColor.Middle(2, 2)), Integer.FromHex(UIColor.Middle(4, 2)), Integer.FromHex(UIColor.Middle(6, 2)))
		  Catch Err As RuntimeException
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MandatoryItemSets(Assigns Sets() As Beacon.ItemSet)
		  Self.mMandatoryItemSets.ResizeTo(Sets.LastRowIndex)
		  For I As Integer = 0 To Sets.LastRowIndex
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
		Sub Path(Assigns Value As String)
		  If Self.mPath.Compare(Value, ComparisonOptions.CaseInsensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mPath = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredItemSetCount(Assigns Value As Integer)
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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
