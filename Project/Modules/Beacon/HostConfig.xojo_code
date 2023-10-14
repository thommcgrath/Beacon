#tag Class
Protected Class HostConfig
	#tag Method, Flags = &h0
		Function Clone() As Beacon.HostConfig
		  Var SaveData As Dictionary = Self.SaveData
		  Return Beacon.HostConfig.FromSaveData(SaveData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(SaveData As Dictionary, Version As Integer)
		  Self.Constructor()
		  RaiseEvent ReadSaveData(SaveData, Version)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.HostConfig
		  Var ProviderId As String = SaveData.Lookup("providerId", "")
		  Var Version As Integer = SaveData.Lookup("version", 0)
		  If Version > Beacon.HostConfig.Version Then
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Host config save data is too new"
		    Raise Err
		  End If
		  
		  Select Case ProviderId
		  Case Nitrado.Identifier
		    Return New Nitrado.HostConfig(SaveData, Version)
		  Case GameServerApp.Identifier
		    Return New GameServerApp.HostConfig(SaveData, Version)
		  Case FTP.Identifier
		    Return New FTP.HostConfig(SaveData, Version)
		  Case Local.Identifier
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Return EncodeBase64URLMBS(Crypto.SHA3_256(Beacon.GenerateJSON(Self.SaveData, False)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.HostConfig) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyHash As String = Self.Hash
		  Var OtherHash As String = Other.Hash
		  Return MyHash.Compare(OtherHash, ComparisonOptions.CaseSensitive, Locale.Raw)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderId() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("version") = Self.Version
		  SaveData.Value("providerId") = Self.ProviderId
		  
		  Var Dict As New Dictionary
		  RaiseEvent WriteSaveData(Dict)
		  For Each Entry As DictionaryEntry In Dict
		    If SaveData.HasKey(Entry.Key) Then
		      Continue
		    End If
		    
		    SaveData.Value(Entry.Key) = Entry.Value
		  Next
		  
		  Return SaveData
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadSaveData(SaveData As Dictionary, Version As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteSaveData(SaveData As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty


	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


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
