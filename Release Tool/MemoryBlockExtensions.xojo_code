#tag Module
Protected Module MemoryBlockExtensions
	#tag Method, Flags = &h0
		Function Convert(Extends Source As Global.MemoryBlock) As Xojo.Core.MemoryBlock
		  Dim Data As New Xojo.Core.MutableMemoryBlock(Source.Size)
		  Data.LittleEndian = Source.LittleEndian
		  For I As Integer = 0 To Source.Size - 1
		    Data.UInt8Value(I) = Source.UInt8Value(I)
		  Next
		  Return New Xojo.Core.MemoryBlock(Data)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Convert(Extends Source As Xojo.Core.MemoryBlock) As Global.MemoryBlock
		  Dim Data As New Global.MemoryBlock(Source.Size)
		  Data.LittleEndian = Source.LittleEndian
		  For I As Integer = 0 To Source.Size - 1
		    Data.UInt8Value(I) = Source.UInt8Value(I)
		  Next
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DecodeHex(Source As Text) As Xojo.Core.MemoryBlock
		  Dim Data As New Xojo.Core.MutableMemoryBlock(Source.Length / 2)
		  For I As Integer = 0 To Data.Size - 1
		    Dim Chars As Text = Source.Mid(I * 2, 2)
		    Dim Value As UInt8 = UInt8.FromHex(Chars)
		    Data.UInt8Value(I) = Value
		  Next
		  Return New Xojo.Core.MemoryBlock(Data)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HexValue(Extends Data As Xojo.Core.MemoryBlock) As Text
		  Dim Chars() As Text
		  For I As Integer = 0 To Data.Size - 1
		    Dim Value As UInt8 = Data.UInt8Value(I)
		    Chars.Append(Value.ToHex(2))
		  Next
		  Return Text.Join(Chars, "")
		End Function
	#tag EndMethod


End Module
#tag EndModule
