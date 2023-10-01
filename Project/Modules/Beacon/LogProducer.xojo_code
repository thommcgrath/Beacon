#tag Interface
Protected Interface LogProducer
	#tag Method, Flags = &h0
		Sub Log(Message As String, ReplaceLast As Boolean = False)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logs(MostRecent As Boolean = False) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveLastLog()
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
