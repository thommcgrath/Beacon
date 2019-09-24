#tag Module
Protected Module FrameworkExtensions
	#tag Method, Flags = &h0
		Function Clone(Extends Source As MemoryBlock) As MemoryBlock
		  Dim Replica As New MemoryBlock(Source.Size)
		  Replica.LittleEndian = Source.LittleEndian
		  Replica.StringValue(0, Replica.Size) = Source.StringValue(0, Source.Size)
		  Return Replica
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Left(Extends Source As MemoryBlock, Length As UInteger) As MemoryBlock
		  Return Source.Middle(0, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Left(Extends Target As MemoryBlock, Length As UInteger, Assigns NewData As MemoryBlock)
		  Target.Middle(0, Length) = NewData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Middle(Extends Source As MemoryBlock, Offset As UInteger, Length As UInteger) As MemoryBlock
		  Offset = Min(Offset, Source.Size)
		  Dim Bound As UInteger = Min(Offset + Length, Source.Size)
		  Length = Bound - Offset
		  
		  Dim Mem As New MemoryBlock(Length)
		  Mem.LittleEndian = Source.LittleEndian
		  Mem.StringValue(0, Length) = Source.StringValue(Offset, Length)
		  Return Mem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Middle(Extends Source As MemoryBlock, Offset As UInteger, Length As UInteger, Assigns NewData As MemoryBlock)
		  If NewData = Nil Then
		    Return
		  End If
		  
		  Offset = Min(Offset, Source.Size)
		  Dim Bound As UInteger = Min(Offset + Length, Source.Size)
		  Dim TailLength As UInteger = Source.Size - Bound
		  Length = Bound - Offset
		  Dim Delta As Integer = NewData.Size - Length
		  
		  If TailLength > 0 Then
		    If Delta > 0 Then
		      Source.Size = Source.Size + Delta
		    End If
		    Source.StringValue(Bound + Delta, TailLength) = Source.StringValue(Bound, TailLength)
		    If Delta < 0 Then
		      Source.Size = Source.Size + Delta
		    End If
		  ElseIf Delta <> 0 Then
		    Source.Size = Source.Size + Delta
		  End If
		  
		  Source.StringValue(Offset, NewData.Size) = NewData.StringValue(0, NewData.Size)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Right(Extends Source As MemoryBlock, Length As UInteger) As MemoryBlock
		  Return Source.Middle(Source.Size - Length, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Right(Extends Target As MemoryBlock, Length As UInteger, Assigns NewData As MemoryBlock)
		  Target.Middle(Target.Size - Length, Length) = NewData
		End Sub
	#tag EndMethod


End Module
#tag EndModule
