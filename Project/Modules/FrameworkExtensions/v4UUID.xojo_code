#tag Class
Class v4UUID
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Create a new UUID
		  
		  Try
		    #if TargetMacOS
		      Declare Function NSClassFromString Lib "Cocoa" (ClassName As CFStringRef) As Ptr
		      Declare Function UUID Lib "Cocoa" Selector "UUID" (Target As Ptr) As Ptr
		      Declare Function UUIDString Lib "Cocoa" Selector "UUIDString" (Target As Ptr) As CFStringRef
		      
		      Dim NSUUID As Ptr = NSClassFromString("NSUUID")
		      If NSUUID <> Nil Then
		        Self.mValue = UUIDString(UUID(NSUUID))
		        Self.mValue = Self.mValue.Lowercase
		        Return
		      End If
		    #elseif TargetWin32
		      Const kLibrary = "rpcrt4"
		      
		      If System.IsFunctionAvailable("UuidCreate", kLibrary) And System.IsFunctionAvailable("UuidToStringA", kLibrary) Then
		        Soft Declare Function UUIDCreate Lib kLibrary Alias "UuidCreate" (ByRef Mem As WindowsUUID) As Integer
		        Soft Declare Function UUIDToString Lib kLibrary Alias "UuidToStringA" (ByRef Mem As WindowsUUID, ByRef Result As CString) As Integer
		        
		        Dim UUID As WindowsUUID
		        If UUIDCreate(UUID) = 0 Then
		          Dim Result As CString
		          If UUIDToString(UUID, Result) = 0 Then
		            Self.mValue = Result
		            Self.mValue = Self.mValue.DefineEncoding(Encodings.UTF8).Lowercase
		            Return
		          End If
		        End If
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.mValue = FormatBytes(Crypto.GenerateRandomBytes(16))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As String)
		  // Create a UUID from the given string
		  If Not IsValid(Source) Then
		    Dim Err As New UnsupportedFormatException
		    Err.Message = "Supplied string is not a v4 UUID"
		    Raise Err
		  End If
		  
		  Self.mValue = Source.Lowercase
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create() As v4UUID
		  Return New v4UUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateNull() As v4UUID
		  Return New v4UUID("00000000-0000-0000-0000-000000000000")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FormatBytes(Bytes As MemoryBlock) As String
		  Bytes.LittleEndian = False
		  Dim Pointer As Ptr = Bytes
		  
		  Dim Value As Byte = Pointer.Byte(6)
		  Value = Value And CType(&b00001111, Byte)
		  Value = Value Or CType(&b01000000, Byte)
		  Pointer.Byte(6) = Value
		  
		  Value = Pointer.Byte(8)
		  Value = Value And CType(&b00111111, Byte)
		  Value = Value Or CType(&b10000000, Byte)
		  Pointer.Byte(8) = Value
		  
		  Dim Result As String = EncodeHex(Bytes).Lowercase()
		  Return Result.Left(8) + "-" + Result.Middle(8, 4) + "-" + Result.Middle(12, 4) + "-" + Result.Middle(16,4) + "-" + Result.Right(12)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromHash(Algorithm As Crypto.HashAlgorithms, Data As MemoryBlock) As v4UUID
		  Return New v4UUID(FormatBytes(Crypto.Hash(Data, Algorithm)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNull() As Boolean
		  Return Self.mValue = "00000000-0000-0000-0000-000000000000"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsValid(Value As String) As Boolean
		  If Value = "00000000-0000-0000-0000-000000000000" Then
		    Return True
		  End If
		  
		  Static Validator As RegEx
		  If IsNull(Validator) Then
		    Validator = New RegEx
		    Validator.SearchPattern = "(?mi-Us)\A[[:xdigit:]]{8}-[[:xdigit:]]{4}-4[[:xdigit:]]{3}-[89AB][[:xdigit:]]{3}-[[:xdigit:]]{12}\z"
		  End If
		  Return Validator.Search(Value) <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(RightSide As String) As String
		  Return Self.mValue + RightSide
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_AddRight(LeftSide As String) As String
		  Return LeftSide + Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As String) As Integer
		  Return Self.mValue.Compare(Other)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As v4UUID) As Integer
		  If Other = Nil Then
		    If Self.IsNull Then
		      Return 0
		    Else
		      Return 1
		    End If
		  End If
		  
		  Return Self.mValue.Compare(Other.mValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As String)
		  Self.Constructor(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  Return Self.mValue
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValue As String
	#tag EndProperty


	#tag Structure, Name = WindowsUUID, Flags = &h21
		Data1 As UInt32
		  Data2 As UInt16
		  Data3 As UInt16
		Data4 As String * 8
	#tag EndStructure


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
