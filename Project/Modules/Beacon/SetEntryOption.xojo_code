#tag Class
Protected Class SetEntryOption
Implements Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Constructor(Engram As Beacon.Engram, Weight As Double)
		  Self.SetEngram(Engram)
		  Self.mWeight = Weight
		  Self.mLastModifiedTime = System.Microseconds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntryOption)
		  Self.SetEngram(Source.mEngram)
		  Self.mHash = Source.mHash
		  Self.mLastHashTime = Source.mLastHashTime
		  Self.mLastModifiedTime = Source.mLastModifiedTime
		  Self.mLastSaveTime = Source.mLastSaveTime
		  Self.mWeight = Source.mWeight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  If Self.mEngram.IsValid Then
		    Return
		  End If
		  
		  Var ClassString As String = Self.mEngram.ClassString
		  For Each Engram As Beacon.Engram In Engrams
		    If Engram.ClassString = ClassString Then
		      Self.mEngram = New Beacon.Engram(Engram)
		      Self.mLastModifiedTime = System.Microseconds
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engram() As Beacon.Engram
		  Return New Beacon.Engram(Self.mEngram)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Var Keys As New Dictionary
		  Keys.Value("UUID") = Self.Engram.ObjectID
		  Keys.Value("Weight") = Self.Weight
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.HashIsStale Then
		    Self.mHash = Beacon.MD5(Self.mEngram.ObjectID.Lowercase + "@" + Self.mWeight.ToString(Locale.Raw, "0.0000")).Lowercase
		    Self.mLastHashTime = System.Microseconds
		  End If
		  
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HashIsStale() As Boolean
		  Return Self.mLastHashTime < Self.mLastModifiedTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As Dictionary) As Beacon.SetEntryOption
		  Var Weight As Double = 0.5
		  Try
		    Weight = Dict.Value("Weight")
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Weight value")
		  End Try
		  
		  Var Engram As Beacon.Engram = Beacon.ResolveEngram(Dict, "UUID", "Class", "Path", Nil)
		  
		  Var Option As New Beacon.SetEntryOption(Engram, Weight)
		  Option.Modified = False
		  Return Option
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  If Document.ModChangeTimestamp > Self.mValidityCacheTime Then
		    Self.mValidityCache = Self.mEngramIsValid And Document.ModEnabled(Self.mEngram.ModID)
		    Self.mValidityCacheTime = System.Microseconds
		  End If
		  
		  Return Self.mValidityCache
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mLastModifiedTime > Self.mLastSaveTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value = False Then
		    Self.mLastSaveTime = System.Microseconds
		  Else
		    Self.mLastModifiedTime = System.Microseconds
		  End If
		End Sub
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

	#tag Method, Flags = &h21
		Private Sub SetEngram(Engram As Beacon.Engram)
		  If (Engram Is Nil) = False Then
		    Self.mEngram = New Beacon.Engram(Engram)
		    Self.mEngramIsValid = Self.mEngram.IsValid And Self.mEngram.ModID.IsEmpty = False And Self.mEngram.IsTagged("Generic") = False And Self.mEngram.IsTagged("Blueprint") = False
		  Else
		    Self.mEngram = Beacon.Engram.CreateFromClass("Beacon_Invalid_Engram_C")
		    Self.mEngramIsValid = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngram As Beacon.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramIsValid As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastHashTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastModifiedTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSaveTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValidityCache As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValidityCacheTime As Double
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
