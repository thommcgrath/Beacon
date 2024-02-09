#tag Class
Protected Class RCONMessage
	#tag Method, Flags = &h0
		Function Body() As String
		  Return Self.mBody
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ByteValue() As MemoryBlock
		  Var BodyLen As Integer = Self.mBody.Bytes
		  Var Mem As New MemoryBlock(BodyLen + 14)
		  Mem.LittleEndian = True
		  Mem.Int32Value(0) = BodyLen + 10
		  Mem.Int32Value(4) = Self.mId
		  Mem.Int32Value(8) = Self.mType
		  Mem.StringValue(12, BodyLen) = Self.mBody
		  Return Mem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Type As Int32, Id As Int32, Body As String)
		  Self.mType = Type
		  Self.mId = Id
		  Self.mBody = Body
		  Self.mDetectorId = System.Random.InRange(0, 2147483647)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Type As Int32, Body As String)
		  If Body.Encoding Is Nil Then
		    Body = Body.DefineEncoding(Encodings.ASCII)
		  End If
		  
		  Self.mType = Type
		  Self.mBody = Body.ConvertEncoding(Encodings.ASCII)
		  Self.mId = System.Random.InRange(0, 2147483647)
		  Self.mDetectorId = System.Random.InRange(0, 2147483647)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Consume(Response As Beacon.RCONMessage) As Boolean
		  If Self.Matches(Response) = False Then
		    Return False
		  End If
		  
		  If Response.mId = Self.mDetectorId Then
		    Self.mResponseReceived = True
		  Else
		    Self.mResponse = Self.mResponse + Response.Body
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Detector() As Beacon.RCONMessage
		  Return New Beacon.RCONMessage(Self.TypeResponseValue, Self.mDetectorId, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DetectorId() As Integer
		  Return Self.mDetectorId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromBuffer(Socket As TCPSocket) As Beacon.RCONMessage
		  If Socket Is Nil Or Socket.BytesAvailable < 14 Then
		    Return Nil
		  End If
		  
		  Var Buffer As New MemoryBlock(4)
		  Buffer.LittleEndian = True
		  Buffer.StringValue(0, 4) = Socket.Lookahead
		  
		  Var Size As Int32 = Buffer.Int32Value(0)
		  If Socket.BytesAvailable < Size Then
		    // Not enough yet
		    Return Nil
		  End If
		  
		  Buffer.Size = Size + 4
		  Buffer.StringValue(0, Buffer.Size) = Socket.Read(Buffer.Size)
		  
		  Var Id As Int32 = Buffer.Int32Value(4)
		  Var Type As Int32 = Buffer.Int32Value(8)
		  Var Body As String = Buffer.StringValue(12, Size - 10).DefineEncoding(Encodings.ASCII)
		  
		  Return New Beacon.RCONMessage(Type, Id, Body)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Id() As Int32
		  Return Self.mId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Other As Beacon.RCONMessage) As Boolean
		  Return (Other Is Nil) = False And Other.mType = Self.TypeResponseValue And (Other.mId = Self.mId Or Other.mId = Self.mDetectorId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Response() As String
		  Return Self.mResponse
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResponseReceived() As Boolean
		  Return Self.mResponseReceived
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Int32
		  Return Self.mType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WaitForResponse(Timeout As Integer = 10000) As Boolean
		  If Self.mResponseReceived Then
		    Return True
		  End If
		  
		  Var Thread As Global.Thread = Global.Thread.Current
		  If Thread Is Nil Then
		    Var Err As UnsupportedOperationException
		    Err.Message = "Do not call WaitForResponse on the main thread."
		    Raise Err
		  End If
		  
		  Var StartTime As Integer = System.Ticks
		  While Self.mResponseReceived = False And (System.Ticks - StartTime) < Timeout
		    Thread.Sleep(10)
		  Wend
		  Return Self.mResponseReceived
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBody As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDetectorId As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mId As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResponse As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResponseReceived As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As Int32
	#tag EndProperty


	#tag Constant, Name = TypeAuth, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeAuthResponse, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeExecuteCommand, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeResponseValue, Type = Double, Dynamic = False, Default = \"0", Scope = Public
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
