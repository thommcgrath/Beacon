#tag Class
Private Class SimpleHTTPSocket
Inherits Xojo.Net.HTTPSocket
	#tag Event
		Sub Error(err as RuntimeException)
		  If Self.Handler <> Nil Then
		    Self.Handler.Invoke(Self.mURL, 0, Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Err.Reason, True), Self.Tag)
		    Self.Handler = Nil
		  Else
		    Break
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub PageReceived(URL as Text, HTTPStatus as Integer, Content as xojo.Core.MemoryBlock)
		  If Self.Handler <> Nil Then
		    Self.Handler.Invoke(URL, HTTPStatus, Content, Self.Tag)
		    Self.Handler = Nil
		  Else
		    Break
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function IsIdle() As Boolean
		  Return Not Self.mWorking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Method as Text, URL as Text)
		  Self.mWorking = True
		  Self.mURL = URL
		  Super.Send(Method, URL)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Handler As SimpleHTTP.ResponseCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Auto
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
	#tag EndViewBehavior
End Class
#tag EndClass
