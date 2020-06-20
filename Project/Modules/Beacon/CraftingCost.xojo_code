#tag Class
Protected Class CraftingCost
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Append(Resource As Beacon.Engram, Quantity As Integer, RequireExact As Boolean)
		  If Resource = Nil Then
		    Return
		  End If
		  
		  If Self.IndexOf(Resource) > -1 Then
		    Return
		  End If
		  
		  Self.mResources.AddRow(Resource)
		  Self.mQuantities.AddRow(Quantity)
		  Self.mRequireExacts.AddRow(RequireExact)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mObjectID = New v4UUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.CraftingCost)
		  Self.Constructor()
		  Self.Engram = Source.Engram
		  For I As Integer = 0 To Source.LastRowIndex
		    Self.Append(Source.Resource(I), Source.Quantity(I), Source.RequireExactResource(I))
		  Next
		  Self.Modified = Source.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engram As Beacon.Engram)
		  Self.Constructor()
		  Self.Engram = Engram
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Var Dict As New Dictionary
		  
		  If Self.mEngram <> Nil Then
		    Dict.Value("Engram") = Self.mEngram.ClassString
		    Dict.Value("EngramID") = Self.mEngram.ObjectID.StringValue
		  End If
		  
		  Var Resources() As Dictionary
		  For I As Integer = 0 To Self.mResources.LastRowIndex
		    Var Engram As Beacon.Engram = Self.mResources(I)
		    Var Quantity As Integer = Self.mQuantities(I)
		    Var RequireExact As Boolean = Self.mRequireExacts(I)
		    
		    Var Resource As New Dictionary
		    Resource.Value("Class") = Engram.ClassString
		    Resource.Value("EngramID") = Engram.ObjectID.StringValue
		    Resource.Value("Quantity") = Quantity
		    Resource.Value("Exact") = RequireExact
		    
		    Resources.AddRow(Resource)
		  Next
		  Dict.Value("Resources") = Resources
		  
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As Dictionary) As Beacon.CraftingCost
		  Var TargetEngram As Beacon.Engram = Beacon.ResolveEngram(Dict, "EngramID", "Engram", "")
		  If TargetEngram Is Nil Then
		    Return Nil
		  End If
		  
		  Var Cost As New Beacon.CraftingCost(TargetEngram)
		  
		  If Dict.HasKey("Resources") Then
		    Var Resources() As Variant = Dict.Value("Resources")
		    For Each Resource As Dictionary In Resources
		      Var Quantity As Integer = Resource.Lookup("Quantity", 1)
		      Var RequireExact As Boolean = Resource.Lookup("Exact", False)
		      Var Engram As Beacon.Engram = Beacon.ResolveEngram(Resource, "EngramID", "Class", "")
		      If Engram Is Nil Then
		        Continue
		      End If
		      Cost.mQuantities.AddRow(Quantity)
		      Cost.mRequireExacts.AddRow(RequireExact)
		      Cost.mResources.AddRow(Engram)
		    Next
		  End If
		  
		  Return Cost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary) As Beacon.CraftingCost
		  Try
		    Var ClassString As String = Dict.Lookup("ItemClassString", "")
		    If ClassString = "" Then
		      Return Nil
		    End If
		    
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Engram = Beacon.Engram.CreateFromClass(ClassString)
		    End If
		    
		    Var Cost As New Beacon.CraftingCost(Engram)
		    If Dict.HasKey("BaseCraftingResourceRequirements") Then
		      Var Resources() As Variant = Dict.Value("BaseCraftingResourceRequirements")
		      For Each Resource As Dictionary In Resources
		        Var ResourceClass As String = Resource.Lookup("ResourceItemTypeString", "")
		        If ResourceClass = "" Then
		          Continue
		        End If
		        Var ResourceEngram As Beacon.Engram = Beacon.Data.GetEngramByClass(ResourceClass)
		        If ResourceEngram = Nil Then
		          ResourceEngram = Beacon.Engram.CreateFromClass(ResourceClass)
		        End If
		        Var Quantity As Integer = Resource.Lookup("BaseResourceRequirement", 1)
		        Var RequireExact As Boolean = Resource.Lookup("bCraftingRequireExactResourceType", False)
		        Cost.Append(ResourceEngram, Quantity, RequireExact)
		      Next
		    End If
		    
		    Return Cost
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Resource As Beacon.Engram) As Integer
		  For I As Integer = 0 To Self.mResources.LastRowIndex
		    If Self.mResources(I) = Resource Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Resource As Beacon.Engram, Quantity As Integer, RequireExact As Boolean)
		  If Resource = Nil Then
		    Return
		  End If
		  
		  If Self.IndexOf(Resource) > -1 Then
		    Return
		  End If
		  
		  Self.mResources.AddRowAt(Index, Resource)
		  Self.mQuantities.AddRowAt(Index, Quantity)
		  Self.mRequireExacts.AddRowAt(Index,RequireExact)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mEngram = Nil Then
		    Return ""
		  End If
		  
		  Return Self.mEngram.Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mResources.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mLastModifiedTime > Self.mLastSaveTime Then
		    Return True
		  End If
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
		Function ObjectID() As String
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.CraftingCost) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.mObjectID = Other.mObjectID Then
		    Return 0
		  End If
		  
		  // Try to sort by name first, otherwise sort by object id for lack of a better option
		  Var SelfName As String = If(Self.mEngram <> Nil, Self.mEngram.Label, "")
		  Var OtherName As String = If(Other.mEngram <> Nil, Other.mEngram.Label, "")
		  Var Result As Integer = SelfName.Compare(OtherName, ComparisonOptions.CaseSensitive)
		  If Result = 0 Then
		    Result = Self.mObjectID.StringValue.Compare(Other.mObjectID.StringValue, ComparisonOptions.CaseSensitive)
		  End If
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Quantity(Index As Integer) As Integer
		  If Index < Self.mQuantities.FirstRowIndex Or Index > Self.mQuantities.LastRowIndex Then
		    Return 0
		  End If
		  
		  Return Self.mQuantities(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Quantity(Index As Integer, Assigns Value As Integer)
		  If Index < Self.mQuantities.FirstRowIndex Or Index > Self.mQuantities.LastRowIndex Then
		    Return
		  End If
		  
		  Value = Min(Max(Value, 1), 65535)
		  
		  If Self.mQuantities(Index) <> Value Then
		    Self.mQuantities(Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Resource As Beacon.Engram)
		  Var Idx As Integer = Self.IndexOf(Resource)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  If Index >= Self.mQuantities.FirstRowIndex And Index <= Self.mQuantities.LastRowIndex Then
		    Self.mQuantities.RemoveRowAt(Index)
		  End If
		  If Index >= Self.mRequireExacts.FirstRowIndex And Index <= Self.mRequireExacts.LastRowIndex Then
		    Self.mRequireExacts.RemoveRowAt(Index)
		  End If
		  If Index >= Self.mResources.FirstRowIndex And Index <= Self.mResources.LastRowIndex Then
		    Self.mResources.RemoveRowAt(Index)
		  End If
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequireExactResource(Index As Integer) As Boolean
		  If Index < Self.mRequireExacts.FirstRowIndex Or Index > Self.mRequireExacts.LastRowIndex Then
		    Return False
		  End If
		  
		  Return Self.mRequireExacts(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequireExactResource(Index As Integer, Assigns Value As Boolean)
		  If Index < Self.mRequireExacts.FirstRowIndex Or Index > Self.mRequireExacts.LastRowIndex Then
		    Return
		  End If
		  
		  If Self.mRequireExacts(Index) <> Value Then
		    Self.mRequireExacts(Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Resource(Index As Integer) As Beacon.Engram
		  If Index < Self.mResources.FirstRowIndex Or Index > Self.mResources.LastRowIndex Then
		    Return Nil
		  End If
		  
		  Return Self.mResources(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Resource(Index As Integer, Assigns Value As Beacon.Engram)
		  If Index < Self.mResources.FirstRowIndex Or Index > Self.mResources.LastRowIndex Then
		    Return
		  End If
		  
		  If Self.mResources(Index) <> Value Then
		    Self.mResources(Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  Var Components() As String
		  For I As Integer = 0 To Self.mResources.LastRowIndex
		    Var ClassString As String = Self.mResources(I).ClassString
		    Var QuantityString As String = Self.mQuantities(I).ToString(Locale.Raw, "0")
		    Var RequireExactString As String = If(Self.mRequireExacts(I), "true", "false")
		    Components.AddRow("(ResourceItemTypeString=""" + ClassString + """,BaseResourceRequirement=" + QuantityString + ",bCraftingRequireExactResourceType=" + RequireExactString + ")")
		  Next
		  
		  Var Pieces() As String
		  Pieces.AddRow("ItemClassString=""" + If(Self.mEngram <> Nil, Self.mEngram.ClassString, "") + """")
		  Pieces.AddRow("BaseCraftingResourceRequirements=(" + Components.Join(",") + ")")
		  Return "(" + Pieces.Join(",") + ")"
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEngram
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEngram = Value Then
			    Return
			  End If
			  
			  Self.mEngram = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Engram As Beacon.Engram
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEngram As Beacon.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastModifiedTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSaveTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObjectID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQuantities() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequireExacts() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResources() As Beacon.Engram
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
