#tag Class
Private Class SymmetricHeader
	#tag Method, Flags = &h0
		Function Checksum() As UInt32
		  Return Self.mChecksum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Payload As MemoryBlock, Version As Integer = 2)
		  If Payload Is Nil Or Payload.Size = MemoryBlock.SizeUnknown Or Payload.Size > Self.MaxLength Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot create symmetric header from memoryblock because it is too large or does not exist."
		    Raise Err
		  End If
		  
		  Self.mVersion = Version
		  Self.mVector = Crypto.GenerateRandomBytes(If(Version = 2, 16, 8))
		  Self.mLength = Payload.Size
		  Self.mChecksum = BeaconEncryption.CRC32(Payload)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encoded() As MemoryBlock
		  Var VectorSize As UInt8 = Self.mVector.Size
		  Var Header As New MemoryBlock(Self.Size)
		  Header.LittleEndian = False
		  Header.UInt8Value(0) = MagicByte
		  Header.UInt8Value(1) = Self.mVersion
		  Header.Middle(2, VectorSize) = Self.mVector
		  Header.Int32Value(2 + VectorSize) = Self.mLength
		  Header.UInt32Value(6 + VectorSize) = Self.mChecksum
		  Return Header
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EncryptedLength() As Int32
		  Var Factor As Int8
		  Select Case Self.mVersion
		  Case 1
		    Factor = 8
		  Case 2
		    Factor = 16
		  End Select
		  
		  Var Blocks As Int32 = Ceiling(Self.mLength / Factor)
		  If Self.mLength Mod Factor = CType(0, Int32) Then
		    Blocks = Blocks + CType(1, Int32)
		  End If
		  Return Blocks * Factor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromMemoryBlock(Source As MemoryBlock) As SymmetricHeader
		  If Source.Size < 18 Then
		    // Not enough data
		    Return Nil
		  End If
		  
		  Var Clone As MemoryBlock = Source.Clone
		  Clone.LittleEndian = False
		  
		  Var MagicByte As UInt8 = Clone.UInt8Value(0)
		  Var Version As UInt8 = Clone.UInt8Value(1)
		  If MagicByte <> MagicByte Then
		    // Not one of our payloads
		    Return Nil
		  End If
		  If Version > 2 Then
		    // Too new
		    Return Nil
		  End If
		  
		  Var VectorSize As UInt8
		  Select Case Version
		  Case 1
		    VectorSize = 8
		  Case 2
		    VectorSize = 16
		  End Select
		  
		  Var Vector As MemoryBlock = Clone.Middle(2, VectorSize)
		  Var Length As Int32 = Clone.Int32Value(2 + VectorSize)
		  Var Checksum As UInt32 = Clone.UInt32Value(6 + VectorSize)
		  
		  Var Header As New SymmetricHeader
		  Header.mChecksum = Checksum
		  Header.mLength = Length
		  Header.mVector = Vector
		  Header.mVersion = Version
		  Return Header
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length() As Int32
		  Return Self.mLength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Size() As UInt8
		  Return 10 + Self.mVector.Size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Vector() As MemoryBlock
		  Return Self.mVector
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Version() As UInt8
		  Return Self.mVersion
		End Function
	#tag EndMethod


	#tag Note, Name = Length
		The length is stored as an Int32 because MemoryBlock methods accept Integer, which translates
		to Int32 or Int64 depending on the platform. So the limit must be the smaller of the two
		for compatibility. The MaxLength constant has enough space for an extra block and another UInt8
		worth of header size.
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mChecksum As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLength As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVector As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVersion As UInt8
	#tag EndProperty


	#tag Constant, Name = MagicByte, Type = Double, Dynamic = False, Default = \"&h8A", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MaxLength, Type = Double, Dynamic = False, Default = \"2147483360", Scope = Public
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
