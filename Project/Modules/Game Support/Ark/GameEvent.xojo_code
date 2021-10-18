#tag Class
Protected Class GameEvent
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function ArkCode() As String
		  Return Self.mArkCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColorIDs() As Integer()
		  // Clone the array
		  Var Bound As Integer = Self.mColorIDs.LastIndex
		  Var IDs() As Integer
		  IDs.ResizeTo(Bound)
		  For Idx As Integer = 0 To Bound
		    IDs(Idx) = Self.mColorIDs(Idx)
		  Next
		  Return IDs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mRates = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.GameEvent)
		  Self.Constructor
		  
		  If Source Is Nil Then
		    Return
		  End If
		  
		  Self.mEventUUID = Source.mEventUUID
		  Self.mLabel = Source.mLabel
		  Self.mArkCode = Source.mArkCode
		  
		  // Call the public versions so clones are created
		  Self.mColorIDs = Source.ColorIDs
		  Self.mEngramUUIDs = Source.EngramUUIDs
		  Var RateUUIDs() As String = Source.RateUUIDs
		  For Each RateUUID As String In RateUUIDs
		    Self.mRates.Value(RateUUID) = Source.MultiplierForRateUUID(RateUUID)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(EventUUID As String, Label As String, ArkCode As String, ColorsJSON As String, RatesJSON As String, EngramsJSON As String)
		  Self.Constructor()
		  
		  Self.mEventUUID = EventUUID
		  Self.mLabel = Label
		  Self.mArkCode = ArkCode
		  
		  Try
		    Var Parsed() As Variant = Beacon.ParseJSON(ColorsJSON)
		    For Each ColorID As Integer In Parsed
		      Self.mColorIDs.Add(ColorID)
		    Next
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Attempting to unpack colors json")
		  End Try
		  
		  Try
		    Var Parsed() As Variant = Beacon.ParseJSON(RatesJSON)
		    For Each Dict As Dictionary In Parsed
		      Var RateUUID As String = Dict.Value("object_id")
		      Var Multiplier As Double = Dict.Value("multiplier")
		      Self.mRates.Value(RateUUID) = Multiplier
		    Next
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Attempting to unpack rates json")
		  End Try
		  
		  Try
		    Var Parsed() As Variant = Beacon.ParseJSON(EngramsJSON)
		    For Each EngramUUID As String In Parsed
		      Self.mEngramUUIDs.Add(EngramUUID)
		    Next
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Attempting to unpack engrams json")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramUUIDs() As String()
		  // Clone the array
		  Var Bound As Integer = Self.mEngramUUIDs.LastIndex
		  Var UUIDs() As String
		  UUIDs.ResizeTo(Bound)
		  For Idx As Integer = 0 To Bound
		    UUIDs(Idx) = Self.mEngramUUIDs(Idx)
		  Next
		  Return UUIDs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MultiplierForRateUUID(RateUUID As String) As Double
		  If Self.mRates.HasKey(RateUUID) Then
		    Return Self.mRates.Value(RateUUID)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RateUUIDs() As String()
		  Var UUIDs() As String
		  For Each Entry As DictionaryEntry In Self.mRates
		    UUIDs.Add(Entry.Key)
		  Next
		  Return UUIDs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mEventUUID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mArkCode As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mColorIDs() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramUUIDs() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEventUUID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRates As Dictionary
	#tag EndProperty


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
