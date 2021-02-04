#tag Class
Protected Class SetEntryOption
	#tag Method, Flags = &h0
		Sub Constructor(Reference As Beacon.BlueprintReference, Weight As Double)
		  Self.mEngram = Reference
		  Self.mWeight = Weight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engram As Beacon.Engram, Weight As Double)
		  Self.Constructor(New Beacon.BlueprintReference(Engram), Weight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntryOption)
		  Self.mEngram = Source.mEngram
		  Self.mHash = Source.mHash
		  Self.mWeight = Source.mWeight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Beacon.Engram
		  Return Beacon.Engram(Self.mEngram.Resolve).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.SetEntryOption
		  Var Weight As Double = 0.5
		  Try
		    Weight = Dict.Value("Weight")
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Weight value")
		  End Try
		  
		  Var Option As Beacon.SetEntryOption
		  If Dict.HasKey("Blueprint") Then
		    Var Reference As Beacon.BlueprintReference = Beacon.BlueprintReference.FromSaveData(Dict.Value("Blueprint"))
		    If Reference Is Nil Then
		      Return Nil
		    End If
		    Option = New Beacon.SetEntryOption(Reference, Weight)
		  ElseIf Dict.HasAnyKey("UUID", "Path", "Class") Then
		    Var Engram As Beacon.Engram = Beacon.ResolveEngram(Dict, "UUID", "Path", "Class", Nil)
		    If Engram Is Nil Then
		      Return Nil
		    End If
		    Option = New Beacon.SetEntryOption(Engram, Weight)
		  End If
		  
		  Return Option
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.mHash.IsEmpty Then
		    Self.mHash = Beacon.MD5(Self.mEngram.ObjectID.Lowercase + "@" + Self.mWeight.ToString(Locale.Raw, "0.0000")).Lowercase
		  End If
		  
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.SetEntryOption) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Var SelfHash As String = Self.Hash
		  Var OtherHash As String = Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reference() As Beacon.BlueprintReference
		  Return Self.mEngram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Keys As New Dictionary
		  Keys.Value("Blueprint") = Self.mEngram.SaveData
		  Keys.Value("Weight") = Self.mWeight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngram As Beacon.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeight As Double
	#tag EndProperty


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
