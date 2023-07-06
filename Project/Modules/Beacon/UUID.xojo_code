#tag Class
Protected Class UUID
	#tag Method, Flags = &h0
		Sub Constructor(Source As String)
		  Var Version As Integer
		  If Validate(Source, Version) = False Then
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Supplied string is not a UUID"
		    Raise Err
		  End If
		  
		  Self.Constructor(Source, Version)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Source As String, Version As Integer)
		  // Prevalidated constructor
		  
		  Self.mValue = Source
		  Self.mVersion = Version
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FormatBytes(Bytes As MemoryBlock, Version As Integer) As String
		  Bytes.LittleEndian = False
		  Var Pointer As Ptr = Bytes
		  
		  Var Value As Byte = Pointer.Byte(6)
		  Value = Value And CType(&b00001111, Byte)
		  Value = Value Or CType(Bitwise.ShiftLeft(CType(Version, UInt64), 4, 8), Byte)
		  Pointer.Byte(6) = Value
		  
		  Value = Pointer.Byte(8)
		  Value = Value And CType(&b00111111, Byte)
		  Value = Value Or CType(&b10000000, Byte)
		  Pointer.Byte(8) = Value
		  
		  Var Result As String = EncodeHex(Bytes).Left(32).Lowercase()
		  Return Result.Left(8) + "-" + Result.Middle(8, 4) + "-" + Result.Middle(12, 4) + "-" + Result.Middle(16,4) + "-" + Result.Right(12)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNull() As Boolean
		  Return Self.mValue = "00000000-0000-0000-0000-000000000000"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsValid(Input As String) As Boolean
		  Var Version As Integer
		  Return Validate(Input, Version)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Null() As Beacon.UUID
		  Return New Beacon.UUID("00000000-0000-0000-0000-000000000000", 0)
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
		Function Operator_Compare(Other As Beacon.UUID) As Integer
		  If Other Is Nil Then
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
		Function Operator_Compare(Other As String) As Integer
		  Return Self.mValue.Compare(Other)
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

	#tag Method, Flags = &h0
		Shared Function v3(Value As String, Prefix As Beacon.UUID = Nil) As Beacon.UUID
		  Var PrefixString As String = If(Prefix Is Nil, "82aa4465-85f9-4b9e-8d36-f66164cef0a6", Prefix.StringValue)
		  Var DecodedPrefix As String = DecodeHex(PrefixString.ReplaceAll("-", ""))
		  Var Bytes As MemoryBlock = Crypto.Hash(DecodedPrefix + Value, Crypto.HashAlgorithms.MD5)
		  Return New Beacon.UUID(FormatBytes(Bytes, 3), 3)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function v4() As Beacon.UUID
		  Try
		    #if TargetMacOS
		      Declare Function NSClassFromString Lib "Cocoa" (ClassName As CFStringRef) As Ptr
		      Declare Function GenUUID Lib "Cocoa" Selector "UUID" (Target As Ptr) As Ptr
		      Declare Function UUIDString Lib "Cocoa" Selector "UUIDString" (Target As Ptr) As CFStringRef
		      
		      Var NSUUID As Ptr = NSClassFromString("NSUUID")
		      If NSUUID <> Nil Then
		        Var Value As String = UUIDString(GenUUID(NSUUID))
		        Return New Beacon.UUID(Value.Lowercase, 4)
		      End If
		    #elseif TargetWin32
		      Const kLibrary = "rpcrt4"
		      
		      If System.IsFunctionAvailable("UuidCreate", kLibrary) And System.IsFunctionAvailable("UuidToStringA", kLibrary) Then
		        Soft Declare Function UUIDCreate Lib kLibrary Alias "UuidCreate" (ByRef Mem As WindowsUUID) As Integer
		        Soft Declare Function UUIDToString Lib kLibrary Alias "UuidToStringA" (ByRef Mem As WindowsUUID, ByRef Result As CString) As Integer
		        
		        Var UUID As WindowsUUID
		        If UUIDCreate(UUID) = 0 Then
		          Var Result As CString
		          If UUIDToString(UUID, Result) = 0 Then
		            Var Value As String = Result
		            Return New Beacon.UUID(Value.DefineEncoding(Encodings.UTF8).Lowercase, 4)
		          End If
		        End If
		      End If
		    #endif
		  Catch Err As RuntimeException
		  End Try
		  
		  Return New Beacon.UUID(FormatBytes(Crypto.GenerateRandomBytes(16), 4), 4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function v5(Value As String, Prefix As Beacon.UUID = Nil) As Beacon.UUID
		  Var PrefixString As String = If(Prefix Is Nil, "82aa4465-85f9-4b9e-8d36-f66164cef0a6", Prefix.StringValue)
		  Var DecodedPrefix As String = DecodeHex(PrefixString.ReplaceAll("-", ""))
		  Var Bytes As MemoryBlock = Crypto.Hash(DecodedPrefix + Value, Crypto.HashAlgorithms.SHA1)
		  Return New Beacon.UUID(FormatBytes(Bytes, 5), 5)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Validate(Input As String) As Boolean
		  Var Version As Integer
		  Return Validate(Input, Version)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Validate(Input As String, ByRef Version As Integer) As Boolean
		  If Input = "00000000-0000-0000-0000-000000000000" Then
		    Version = 0
		    Return True
		  End If
		  
		  Static Validator As RegEx
		  If IsNull(Validator) Then
		    Validator = New RegEx
		    Validator.SearchPattern = "(?mi-Us)\A[[:xdigit:]]{8}-[[:xdigit:]]{4}-([3-5])[[:xdigit:]]{3}-[89AB][[:xdigit:]]{3}-[[:xdigit:]]{12}\z"
		  End If
		  
		  Var Matches As RegExMatch = Validator.Search(Input)
		  If Matches Is Nil Then
		    Version = -1
		    Return False
		  End If
		  
		  Version = Integer.FromString(Matches.SubExpressionString(1), Locale.Raw)
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValue As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVersion As Integer
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
