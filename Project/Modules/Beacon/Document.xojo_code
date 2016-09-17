#tag Class
Protected Class Document
	#tag Method, Flags = &h0
		Sub Add(Beacon As Ark.Beacon)
		  For I As Integer = 0 To UBound(Self.mBeacons)
		    If Self.mBeacons(I) = Beacon Then
		      Return
		    End If
		  Next
		  Self.mBeacons.Append(Beacon)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeaconCount() As Integer
		  Return UBound(Self.mBeacons) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Beacons() As Ark.Beacon()
		  Dim Results() As Ark.Beacon
		  For Each Beacon As Ark.Beacon In Self.mBeacons
		    Results.Append(Beacon)
		  Next
		  Return Results
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
		Function HasBeacon(Beacon As Ark.Beacon) As Boolean
		  For I As Integer = 0 To UBound(Self.mBeacons)
		    If Self.mBeacons(I) = Beacon Then
		      Return True
		    End If
		  Next
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
		  Dim Stream As Xojo.IO.TextInputStream = Xojo.IO.TextInputStream.Open(File, Xojo.Core.TextEncoding.UTF8)
		  Dim Contents As Text = Stream.ReadAll
		  Stream.Close
		  
		  Dim Parsed As Auto
		  Try
		    Parsed = Xojo.Data.ParseJSON(Contents)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Dim Doc As New Beacon.Document
		  Dim Beacons() As Auto
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    // New style document
		    Dim Dict As Xojo.Core.Dictionary = Parsed
		    Try
		      Beacons = Dict.Value("Beacons")
		      Doc.mIdentifier = Dict.Value("Identifier")
		      Doc.mRevision = Dict.Value("Revision")
		    Catch Err As RuntimeException
		      // Likely a KeyNotFoundException or TypeMismatchException, either way, we can't handle it
		      Return Nil
		    End Try
		  ElseIf Info.FullName = "Auto()" Then
		    // Old style document
		    Beacons = Parsed
		  Else
		    // What on earth is this?
		    Return Nil
		  End If
		  
		  For Each Beacon As Xojo.Core.Dictionary In Beacons
		    Doc.mBeacons.Append(Ark.Beacon.Import(Beacon))
		  Next
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Beacon As Ark.Beacon)
		  For I As Integer = 0 To UBound(Self.mBeacons)
		    If Self.mBeacons(I) = Beacon Then
		      Self.mBeacons.Remove(I)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(File As Xojo.IO.FolderItem)
		  Dim Beacons() As Xojo.Core.Dictionary
		  For Each Beacon As Ark.Beacon In Self.mBeacons
		    Beacons.Append(Beacon.Export)
		  Next
		  
		  Self.mRevision = Self.mRevision + 1
		  
		  Dim Document As New Xojo.Core.Dictionary
		  Document.Value("Revision") = Self.mRevision
		  Document.Value("Version") = Self.DocumentVersion
		  Document.Value("Identifier") = Self.mIdentifier
		  Document.Value("Beacons") = Beacons
		  
		  Dim Contents As Text = Xojo.Data.GenerateJSON(Document)
		  Dim Stream As Xojo.IO.TextOutputStream = Xojo.IO.TextOutputStream.Create(File, Xojo.Core.TextEncoding.UTF8)
		  Stream.Write(Contents)
		  Stream.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBeacons() As Ark.Beacon
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As Text
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
