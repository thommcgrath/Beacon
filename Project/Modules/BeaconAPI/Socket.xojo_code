#tag Class
Protected Class Socket
	#tag Method, Flags = &h1
		Protected Sub AdvanceQueue()
		  If UBound(Self.Queue) = -1 Then
		    Self.Working = False
		    Return
		  End If
		  
		  Dim Request As BeaconAPI.Request = Self.Queue(0)
		  Self.Queue.Remove(0)
		  
		  Self.ActiveRequest = Request
		  
		  Self.Socket.ClearRequestHeaders()
		  
		  Dim URL As Text = Request.URL
		  If Request.Authenticated Then
		    Self.Socket.RequestHeader("Authorization") = Request.AuthHeader
		  End If
		  
		  Self.Socket.RequestHeader("Cache-Control") = "no-cache"
		  
		  If Request.Method = "GET" Then
		    Dim Query As Text = Request.Query
		    If Query <> "" Then
		      URL = URL + "?" + Query
		    End If
		    Self.Socket.Send("GET", URL)
		  Else
		    Self.Socket.SetRequestContent(Request.Payload, Request.ContentType)
		    Self.Socket.Send(Request.Method, URL)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Socket = New Xojo.Net.HTTPSocket
		  Self.Socket.ValidateCertificates = True
		  AddHandler Self.Socket.Error, WeakAddressOf Socket_Error
		  AddHandler Self.Socket.PageReceived, WeakAddressOf Socket_PageReceived
		  AddHandler Self.Socket.ReceiveProgress, WeakAddressOf Socket_ReceiveProgress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Xojo.Core.Timer.CancelCall(WeakAddressOf Self.AdvanceQueue)
		  
		  Self.Socket.Disconnect
		  Self.Socket = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_Error(Sender As Xojo.Net.HTTPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.ActiveRequest.InvokeCallback(False, Err.Reason, Nil, 0)
		  Self.ActiveRequest = Nil
		  Xojo.Core.Timer.CallLater(50, WeakAddressOf Self.AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  Dim Details As Auto
		  If TextContent <> "" Then
		    Try
		      Details = Xojo.Data.ParseJSON(TextContent)
		    Catch Err As Xojo.Data.InvalidJSONException
		      Dim Dict As New Xojo.Core.Dictionary
		      Dict.Value("message") = "Invalid JSON"
		      Dict.Value("details") = TextContent
		      Details = Dict
		      HTTPStatus = 500
		    End Try
		  Else
		    Details = New Xojo.Core.Dictionary
		  End If
		  
		  If HTTPStatus = 200 Then
		    Self.ActiveRequest.InvokeCallback(True, "", Details, HTTPStatus)
		  Else
		    Dim Dict As Xojo.Core.Dictionary = Details
		    Dim Message As Text = Dict.Lookup("message", "")
		    Details = Dict.Lookup("details", Nil)
		    Self.ActiveRequest.InvokeCallback(False, Message, Details, HTTPStatus)
		  End If
		  
		  Self.ActiveRequest = Nil
		  Xojo.Core.Timer.CallLater(50, WeakAddressOf Self.AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_ReceiveProgress(Sender As Xojo.Net.HTTPSocket, BytesReceived As Int64, BytesTotal As Int64, NewData As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused NewData
		  
		  RaiseEvent WorkProgress(Self.ActiveRequest, BytesReceived, BytesTotal)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Request As BeaconAPI.Request)
		  Self.Queue.Append(Request)
		  If UBound(Self.Queue) = 0 And Self.Working = False Then
		    Xojo.Core.Timer.CallLater(50, WeakAddressOf Self.AdvanceQueue)
		    Self.Working = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Working() As Boolean
		  Return Self.mWorking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Working(Assigns Value As Boolean)
		  If Self.mWorking = Value Then
		    Return
		  End If
		  
		  Self.mWorking = Value
		  If Self.mWorking Then
		    RaiseEvent WorkStarted
		  Else
		    RaiseEvent WorkCompleted
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event WorkCompleted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkProgress(Request As BeaconAPI.Request, BytesReceived As Int64, BytesTotal As Int64)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkStarted()
	#tag EndHook


	#tag Property, Flags = &h21
		Private ActiveRequest As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Queue() As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Socket As Xojo.Net.HTTPSocket
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
	#tag EndViewBehavior
End Class
#tag EndClass
