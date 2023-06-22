#tag Class
Protected Class ConfigSetState
	#tag Method, Flags = &h0
		Shared Function AreArraysEqual(LeftList() As Beacon.ConfigSetState, RightList() As Beacon.ConfigSetState) As Boolean
		  Var LeftListEncoded As String = Beacon.GenerateJSON(Beacon.ConfigSetState.EncodeArray(LeftList), False)
		  Var RightListEncoded As String = Beacon.GenerateJSON(Beacon.ConfigSetState.EncodeArray(RightList), False)
		  Return LeftListEncoded = RightListEncoded
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CloneArray(States() As Beacon.ConfigSetState) As Beacon.ConfigSetState()
		  // Need a new array, but states are immutable so no need to copy them
		  
		  Var Clone() As Beacon.ConfigSetState
		  Clone.ResizeTo(States.LastIndex)
		  
		  For Idx As Integer = 0 To Clone.LastIndex
		    Clone(Idx) = States(Idx)
		  Next
		  
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetId() As String
		  Return Self.mSetId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Set As Beacon.ConfigSet, Enabled As Boolean)
		  Self.Constructor(Set.ConfigSetId, Enabled)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(State As Beacon.ConfigSetState, Enabled As Boolean)
		  Self.Constructor(State.ConfigSetId, Enabled)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SetId As String, Enabled As Boolean)
		  Self.mSetId = SetId
		  Self.mEnabled = Enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function DecodeArray(Source As Variant) As Beacon.ConfigSetState()
		  If Source.IsArray = False Then
		    Return Nil
		  End If
		  
		  Var Members() As Variant = Source
		  Var States() As Beacon.ConfigSetState
		  For Each Member As Variant In Members
		    Try
		      If Member.IsNull Or Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var StateDict As Dictionary = Dictionary(Member)
		      States.Add(New Beacon.ConfigSetState(StateDict.Value("ConfigSetId").StringValue, StateDict.Value("Enabled").BooleanValue))
		    Catch Err As RuntimeException
		    End Try
		  Next
		  Return States
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Enabled() As Boolean
		  Return Self.mEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function EncodeArray(States() As Beacon.ConfigSetState) As Variant
		  Var Arr() As Dictionary
		  For Each State As Beacon.ConfigSetState In States
		    Arr.Add(New Dictionary("ConfigSetId": State.ConfigSetId, "Enabled": State.Enabled))
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FilterSets(States() As Beacon.ConfigSetState, Sets() As Beacon.ConfigSet) As Beacon.ConfigSet()
		  Var SetsMap As New Dictionary
		  For Each Set As Beacon.ConfigSet In Sets
		    SetsMap.Value(Set.ConfigSetId) = Set
		  Next
		  
		  Var FilteredSets() As Beacon.ConfigSet
		  For Each State As Beacon.ConfigSetState In States
		    If State.Enabled = False Or SetsMap.HasKey(State.ConfigSetId) = False Then
		      Continue
		    End If
		    
		    Var Set As Beacon.ConfigSet = SetsMap.Value(State.ConfigSetId)
		    FilteredSets.Add(Set)
		  Next
		  Return FilteredSets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FilterStates(States() As Beacon.ConfigSetState, Sets() As Beacon.ConfigSet) As Beacon.ConfigSetState()
		  Var SetsMap As New Dictionary
		  For Each Set As Beacon.ConfigSet In Sets
		    SetsMap.Value(Set.ConfigSetId) = Set
		  Next
		  
		  Var FilteredStates() As Beacon.ConfigSetState
		  For Each State As Beacon.ConfigSetState In States
		    If State.Enabled = False Or SetsMap.HasKey(State.ConfigSetId) = False Then
		      Continue
		    End If
		    
		    FilteredStates.Add(State)
		  Next
		  Return FilteredStates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ConfigSetState) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MySignature As String = Self.mSetId + ":" + If(Self.mEnabled, "True", "False")
		  Var OtherSignature As String = Other.mSetId + ":" + If(Other.mEnabled, "True", "False")
		  Return MySignature.Compare(OtherSignature, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetId As String
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
