#tag Class
Protected Class SynchronousHTTPSocket
Inherits Xojo.Net.HTTPSocket
	#tag Event
		Sub Error(err as RuntimeException)
		  Self.mLastContent = Nil
		  Self.mLastHTTPStatus = 0
		  Self.mLastException = Err
		  RaiseEvent Error(Err)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Resume
		  End If
		  Self.mOriginThread = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub PageReceived(URL as Text, HTTPStatus as Integer, Content as xojo.Core.MemoryBlock)
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


	#tag Method, Flags = &h0
		Function LastContent() As Xojo.Core.MemoryBlock
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
		Sub Send(Method as Text, URL as Text)
		  Self.mOriginThread = App.CurrentThread
		  Super.Send(Method, URL)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Suspend
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Error(err as RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PageReceived(URL as Text, HTTPStatus as Integer, Content as xojo.Core.MemoryBlock)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mLastContent As Xojo.Core.MemoryBlock
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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidateCertificates"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mLastHTTPStatus"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
