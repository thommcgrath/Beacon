#tag Class
Protected Class CustomConfig
Inherits SDTD.ConfigGroup
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Function HasContent() As Boolean
		  For Each Entry As DictionaryEntry In Self.mFileContents
		    If Entry.Value.StringValue.Trim.IsEmpty = False Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As Dictionary
		  If EncryptedData.HasKey("Rainbow") Then
		    Try
		      Rainbow = EncryptedData.Value("Rainbow")
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If EncryptedData.HasKey("Salt") Then
		    Self.mSalt = DecodeBase64MBS(EncryptedData.Value("Salt").StringValue)
		  End If
		  
		  For Each Entry As DictionaryEntry In SaveData
		    If Entry.Key = "Salt" Then
		      Continue
		    End If
		    
		    Self.mFileContents.Value(Entry.Key) = Self.DecodeContent(Entry.Value.StringValue, Rainbow)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mFileContents
		    SaveData.Value(Entry.Key) = Self.EncodeContent(Entry.Value.StringValue, Rainbow)
		  Next
		  
		  If Rainbow.KeyCount > 0 Then
		    EncryptedData.Value("Salt") = EncodeBase64MBS(Self.mSalt)
		    EncryptedData.Value("Rainbow") = Rainbow
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mFileContents = New Dictionary
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeContent(Input As String, Rainbow As Dictionary) As String
		  #if Not SDTD.Enabled
		    #Pragma Unused Rainbow
		  #endif
		  
		  Return Input
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EncodeContent(Input As String, Rainbow As Dictionary) As String
		  #if Not SDTD.Enabled
		    #Pragma Unused Rainbow
		  #endif
		  
		  Return Input
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, ContentPacks As Beacon.StringList) As SDTD.Configs.CustomConfig
		  #if Not SDTD.Enabled
		    #Pragma Unused ParsedData
		    #Pragma Unused ContentPacks
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return SDTD.Configs.NameCustomConfig
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function XmlContent(Filename As String) As String
		  Return Self.mFileContents.Lookup(Filename, "").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub XmlContent(Filename As String, Assigns Value As String)
		  Value = Value.Trim
		  
		  If Value.IsEmpty Then
		    If Self.mFileContents.HasKey(Filename) THen
		      Self.mFileContents.Remove(Filename)
		    End If
		  Else
		    Self.mFileContents.Value(Filename) = Value
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFileContents As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSalt As String
	#tag EndProperty


	#tag Constant, Name = EncryptedTag, Type = String, Dynamic = False, Default = \"BeaconEncrypted", Scope = Public
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
