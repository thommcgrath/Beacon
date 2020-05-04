#tag Class
Protected Class SynchronousHTTPSocket
Inherits HTTPClientSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, Content As String)
		  Self.mLastContent = Content
		  Self.mLastHTTPStatus = HTTPStatus
		  Self.mLastException = Nil
		  RaiseEvent PageReceived(URL, HTTPStatus, Content)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Resume
		  End If
		  Self.mOriginThread = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error(E As RuntimeException)
		  Self.mLastContent = Nil
		  Self.mLastHTTPStatus = 0
		  Self.mLastException = e
		  RaiseEvent Error(e)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Resume
		  End If
		  Self.mOriginThread = Nil
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function LastContent() As MemoryBlock
		  Return Self.mLastContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastException() As RuntimeException
		  Return Self.mLastException
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastHTTPStatus() As Integer
		  Return Self.mLastHTTPStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Method As String, URL As String)
		  Self.mOriginThread = App.CurrentThread
		  Super.Send(Method, URL)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Pause
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Error(err as RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PageReceived(URL As String, HTTPStatus As Integer, Content As MemoryBlock)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mLastContent As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastException As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastHTTPStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginThread As Thread
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="MinTLSVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="TLSVersions"
			EditorType="Enum"
			#tag EnumValues
				"0 - v1_0"
				"1 - v1_1"
				"2 - v1_2"
				"3 - v1_3"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequireOCSPStapling"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FollowRedirects"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserAgent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowCertificateValidation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
