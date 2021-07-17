#tag Class
Private Class SimpleHTTPSocket
	#tag Method, Flags = &h0
		Sub ClearRequestHeaders()
		  Self.mSocket.ClearRequestHeaders
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSocket = New URLConnection
		  AddHandler Self.mSocket.Error, WeakAddressOf mSocket_Error
		  AddHandler Self.mSocket.ContentReceived, WeakAddressOf mSocket_ContentReceived
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsIdle() As Boolean
		  Return Not Self.mWorking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  
		  If Self.Handler <> Nil Then
		    If Beacon.SafeToInvoke(Self.Handler) Then
		      Self.Handler.Invoke(URL, HTTPStatus, Content, Self.Tag)
		    End If
		    Self.Handler = Nil
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  If Self.Handler <> Nil Then
		    If Beacon.SafeToInvoke(Self.Handler) Then
		      Self.Handler.Invoke(Self.mURL, 0, Err.Message, Self.Tag)
		    End If
		    Self.Handler = Nil
		  Else
		    Break
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestHeader(Key As String, Assigns Value As String)
		  Self.mSocket.RequestHeader(Key) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Method As String, URL As String)
		  Self.mWorking = True
		  Self.mURL = URL
		  Self.RequestHeader("User-Agent") = App.UserAgent
		  Self.mSocket.Send(Method, URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRequestContent(Content As MemoryBlock, ContentType As String)
		  Self.mSocket.SetRequestContent(Content, ContentType)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Handler As SimpleHTTP.ResponseCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As URLConnection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
