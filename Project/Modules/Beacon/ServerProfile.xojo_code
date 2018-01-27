#tag Class
Protected Class ServerProfile
	#tag Method, Flags = &h0
		Function Clone() As Beacon.ServerProfile
		  Return Beacon.ServerProfile.FromDictionary(Self.ToDictionary())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim Err As New UnsupportedOperationException
		  Err.Reason = "Do not instantiate this class, only its subclasses."
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Dict As Xojo.Core.Dictionary)
		  RaiseEvent ReadFromDictionary(Dict)
		  
		  If Not Dict.HasAllKeys("Name", "Profile ID") Then
		    Dim Err As New KeyNotFoundException
		    Err.Reason = "Incomplete server profile"
		    Raise Err
		  End If
		  
		  Self.mName = Dict.Value("Name")
		  Self.mProfileID = Dict.Value("Profile ID")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Xojo.Core.Dictionary) As Beacon.ServerProfile
		  // This isn't a great design because the factory needs to know about all its subclasses, but
		  // there aren't better alternatives. Xojo's dead code stripping prevents a lookup from working.
		  
		  If Not Dict.HasAllKeys("Name", "Provider", "Profile ID") Then
		    Return Nil
		  End If
		  
		  Dim Info As Xojo.Introspection.TypeInfo
		  Dim Provider As Text = Dict.Value("Provider")
		  Select Case Provider
		  Case "Nitrado"
		    Info = GetTypeInfo(Beacon.NitradoServerProfile)
		  Case "FTP"
		    Info = GetTypeInfo(Beacon.FTPServerProfile)
		  End Select
		  If Info = Nil Then
		    Return Nil
		  End If
		  
		  Dim Constructors() As Xojo.Introspection.ConstructorInfo = Info.Constructors
		  For Each Imp As Xojo.Introspection.ConstructorInfo In Constructors
		    Dim Params() As Xojo.Introspection.ParameterInfo = Imp.Parameters
		    If Imp.IsProtected = True And Params.Ubound = 0 And Params(0).IsByRef = False And Params(0).ParameterType.FullName = "Xojo.Core.Dictionary" Then
		      Dim Values(0) As Auto
		      Values(0) = Dict
		      Return Imp.Invoke(Values)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Other.ProfileID = Self.ProfileID Then
		    Return 0
		  Else
		    Return Self.mName.Compare(Other.mName)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProfileID() As Text
		  If Self.mProfileID = "" Then
		    Self.mProfileID = Beacon.CreateUUID
		  End If
		  Return Self.mProfileID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  RaiseEvent WriteToDictionary(Dict)
		  If Not Dict.HasKey("Provider") Then
		    Dim Err As New KeyNotFoundException
		    Err.Reason = "No provider was set in Beacon.ServerProfile.WriteToDictionary"
		    Raise Err
		  End If
		  Dict.Value("Name") = Self.mName
		  Dict.Value("Profile ID") = Self.ProfileID // Do not call mProfileID here in order to force generation
		  Return Dict
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadFromDictionary(Dict As Xojo.Core.Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteToDictionary(Dict As Xojo.Core.Dictionary)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mName As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileID As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mName.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mName = Value
			  End If
			End Set
		#tag EndSetter
		Name As Text
	#tag EndComputedProperty


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
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
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
