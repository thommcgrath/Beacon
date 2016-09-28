#tag Class
Protected Class Document
	#tag Method, Flags = &h0
		Sub Add(LootSource As Beacon.LootSource)
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Return
		    End If
		  Next
		  Self.mLootSources.Append(LootSource)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeaconCount() As Integer
		  Return UBound(Self.mLootSources) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim Bytes As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(16)
		  Dim Id As New Xojo.Core.MutableMemoryBlock(Bytes)
		  Dim Value As UInt8
		  
		  Value = Id.UInt8Value(6)
		  Value = Value And CType(&b00001111, UInt8)
		  Value = Value Or CType(&b01000000, UInt8)
		  Id.UInt8Value(6) = Value
		  
		  Value = Id.UInt8Value(8)
		  Value = Value And CType(&b00111111, UInt8)
		  Value = Value Or CType(&b10000000, UInt8)
		  Id.UInt8Value(8) = Value
		  
		  Dim Chars() As Text
		  For I As Integer = 0 To Id.Size - 1
		    Chars.Append(Id.UInt8Value(I).ToHex(2))
		  Next
		  
		  Chars.Insert(10, "-")
		  Chars.Insert( 8, "-")
		  Chars.Insert( 6, "-")
		  Chars.Insert( 4, "-")
		  
		  Self.mIdentifier = Beacon.CreateUUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBeacon(LootSource As Beacon.LootSource) As Boolean
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSources() As Beacon.LootSource()
		  Dim Results() As Beacon.LootSource
		  For Each LootSource As Beacon.LootSource In Self.mLootSources
		    Results.Append(LootSource)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Document) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mIdentifier.Compare(Other.mIdentifier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Read(File As Xojo.IO.FolderItem) As Beacon.Document
		  Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Open(File, Xojo.IO.BinaryStream.LockModes.Read)
		  Dim Data As Xojo.Core.MemoryBlock = Stream.Read(Stream.Length)
		  Stream.Close
		  
		  Dim Contents As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Data)
		  
		  Dim Parsed As Auto
		  Try
		    Parsed = Xojo.Data.ParseJSON(Contents)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Dim Doc As New Beacon.Document
		  Dim LootSources() As Auto
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    // New style document
		    Dim Dict As Xojo.Core.Dictionary = Parsed
		    Try
		      LootSources = Dict.Value("LootSources")
		      Doc.mIdentifier = Dict.Value("Identifier")
		      Doc.mRevision = Dict.Value("Revision")
		    Catch Err As RuntimeException
		      // Likely a KeyNotFoundException or TypeMismatchException, either way, we can't handle it
		      Return Nil
		    End Try
		  ElseIf Info.FullName = "Auto()" Then
		    // Old style document
		    LootSources = Parsed
		  Else
		    // What on earth is this?
		    Return Nil
		  End If
		  
		  For Each LootSource As Xojo.Core.Dictionary In LootSources
		    Doc.mLootSources.Append(Beacon.LootSource.Import(LootSource))
		  Next
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(LootSource As Beacon.LootSource)
		  For I As Integer = 0 To UBound(Self.mLootSources)
		    If Self.mLootSources(I) = LootSource Then
		      Self.mLootSources.Remove(I)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(File As Xojo.IO.FolderItem)
		  Dim LootSources() As Xojo.Core.Dictionary
		  For Each LootSource As Beacon.LootSource In Self.mLootSources
		    LootSources.Append(LootSource.Export)
		  Next
		  
		  Self.mRevision = Self.mRevision + 1
		  
		  Dim Document As New Xojo.Core.Dictionary
		  Document.Value("Revision") = Self.mRevision
		  Document.Value("Version") = Self.DocumentVersion
		  Document.Value("Identifier") = Self.mIdentifier
		  Document.Value("LootSources") = LootSources
		  
		  Dim Contents As Text = Xojo.Data.GenerateJSON(Document)
		  Dim Data As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Contents)
		  Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Open(File, Xojo.IO.BinaryStream.LockModes.Write)
		  Stream.Write(Data)
		  Stream.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLootSources() As Beacon.LootSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRevision As Integer = 0
	#tag EndProperty


	#tag Constant, Name = DocumentVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


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
