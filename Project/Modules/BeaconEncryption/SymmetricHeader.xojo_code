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
		Sub Constructor(Payload As Xojo.Core.MemoryBlock)
		  Self.mVersion = 2
		  Self.mVector = Xojo.Crypto.GenerateRandomBytes(16)
		  Self.mLength = Payload.Size
		  Self.mChecksum = Beacon.CRC32(Payload)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encoded() As Xojo.Core.MemoryBlock
		  Dim VectorSize As UInt8 = Self.mVector.Size
		  Dim Header As New Xojo.Core.MutableMemoryBlock(Self.Size)
		  Header.LittleEndian = False
		  Header.UInt8Value(0) = MagicByte
		  Header.UInt8Value(1) = Self.mVersion
		  Header.Mid(2, VectorSize) = Self.mVector
		  Header.UInt32Value(2 + VectorSize) = Self.mLength
		  Header.UInt32Value(6 + VectorSize) = Self.mChecksum
		  Return Header
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromMemoryBlock(Source As Xojo.Core.MemoryBlock) As SymmetricHeader
		  If Source.Size < 18 Then
		    // Not enough data
		    Return Nil
		  End If
		  
		  Dim Clone As New Xojo.Core.MemoryBlock(Source)
		  Clone.LittleEndian = False
		  
		  Dim MagicByte As UInt8 = Clone.UInt8Value(0)
		  Dim Version As UInt8 = Clone.UInt8Value(1)
		  If MagicByte <> MagicByte Then
		    // Not one of our payloads
		    Return Nil
		  End If
		  If Version > 2 Then
		    // Too new
		    Return Nil
		  End If
		  
		  Dim VectorSize As UInt8
		  Select Case Version
		  Case 1
		    VectorSize = 8
		  Case 2
		    VectorSize = 16
		  End Select
		  
		  Dim Vector As Xojo.Core.MemoryBlock = Clone.Mid(2, VectorSize)
		  Dim Length As UInt32 = Clone.UInt32Value(2 + VectorSize)
		  Dim Checksum As UInt32 = Clone.UInt32Value(6 + VectorSize)
		  
		  Dim Header As New SymmetricHeader
		  Header.mChecksum = Checksum
		  Header.mLength = Length
		  Header.mVector = Vector
		  Header.mVersion = Version
		  Return Header
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length() As UInt32
		  Return Self.mLength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Size() As UInt8
		  Return 10 + Self.mVector.Size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Vector() As Xojo.Core.MemoryBlock
		  Return Self.mVector
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Version() As UInt8
		  Return Self.mVersion
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mChecksum As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLength As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVector As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVersion As UInt8
	#tag EndProperty


	#tag Constant, Name = MagicByte, Type = Double, Dynamic = False, Default = \"&h8A", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mVersion"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
