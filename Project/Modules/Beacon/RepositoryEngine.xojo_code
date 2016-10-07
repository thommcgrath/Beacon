#tag Class
Protected Class RepositoryEngine
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSocket = New Xojo.Net.HTTPSocket
		  AddHandler Self.mSocket.PageReceived, WeakAddressOf Self.mSocket_PageReceived
		  AddHandler Self.mSocket.Error, WeakAddressOf Self.mSocket_Error
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetDocument(DocumentID As Text)
		  If Self.mCurrentAction <> Beacon.RepositoryEngine.Actions.None Then
		    Raise New Xojo.Core.UnsupportedOperationException
		  End If
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.Get
		  Self.mSocket.Send("GET", Beacon.WebURL + "/documents.php/" + DocumentID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListDocuments()
		  If Self.mCurrentAction <> Beacon.RepositoryEngine.Actions.None Then
		    Raise New Xojo.Core.UnsupportedOperationException
		  End If
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.List
		  Self.mSocket.Send("GET", Beacon.WebURL + "/documents.php")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As Xojo.Net.HTTPSocket, Err As RuntimeException)
		  Break
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.None
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  Select Case Self.mCurrentAction
		  Case Beacon.RepositoryEngine.Actions.List
		    
		  Case Beacon.RepositoryEngine.Actions.Get
		    
		  Case Beacon.RepositoryEngine.Actions.Save
		    Dim Response As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		    If HTTPStatus <> 200 Then
		      RaiseEvent SaveError(Response)
		    Else
		      RaiseEvent SaveSuccess(Response)
		    End If
		  End Select
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.None
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveDocument(Identity As Beacon.Identity, Document As Beacon.Document)
		  If Self.mCurrentAction <> Beacon.RepositoryEngine.Actions.None Then
		    Raise New Xojo.Core.UnsupportedOperationException
		  End If
		  
		  Dim Dict As Xojo.Core.Dictionary = Document.Export
		  Dim Contents As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Xojo.Data.GenerateJSON(Dict))
		  Dim Signature As Xojo.Core.MemoryBlock = Identity.Sign(Contents)
		  Dim UserID As Text = Identity.Identifier
		  Dim PublicKey As Text = Identity.PublicKey
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.Save
		  Self.mSocket.SetRequestContent(Contents, "text/plain")
		  Self.mSocket.Send("POST", Beacon.WebURL + "/documents.php?userid=" + UserID + "&pubkey=" + PublicKey + "&signature=" + Beacon.EncodeHex(Signature))
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event SaveError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveSuccess(ShareURL As Text)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCurrentAction As Beacon.RepositoryEngine.Actions
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As Xojo.Net.HTTPSocket
	#tag EndProperty


	#tag Enum, Name = Actions, Type = Integer, Flags = &h21
		None
		  List
		  Get
		Save
	#tag EndEnum


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
