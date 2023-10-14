#tag Class
Protected Class DummyLogProducer
Implements Beacon.LogProducer
	#tag Method, Flags = &h21
		Private Sub Log(Message As String, ReplaceLast As Boolean = False)
		  // Part of the Beacon.LogProducer interface.
		  
		  #Pragma Unused Message
		  #Pragma Unused ReplaceLast
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Logs(MostRecent As Boolean = False) As String
		  // Part of the Beacon.LogProducer interface.
		  
		  #Pragma Unused MostRecent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveLastLog()
		  // Part of the Beacon.LogProducer interface.
		  
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
