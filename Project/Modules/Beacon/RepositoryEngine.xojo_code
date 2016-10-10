#tag Class
Protected Class RepositoryEngine
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSocket = New Xojo.Net.HTTPSocket
		  AddHandler Self.mSocket.PageReceived, WeakAddressOf Self.mSocket_PageReceived
		  AddHandler Self.mSocket.HeadersReceived, WeakAddressOf Self.mSocket_HeadersReceived
		  AddHandler Self.mSocket.Error, WeakAddressOf Self.mSocket_Error
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteDocument(Document As Beacon.Document, Identity As Beacon.Identity)
		  If Self.mCurrentAction <> Beacon.RepositoryEngine.Actions.None Then
		    Raise New Xojo.Core.UnsupportedOperationException
		  End If
		  
		  Dim Signature As Xojo.Core.MemoryBlock = Identity.Sign(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Document.Identifier))
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.Delete
		  Self.mSocket.Send("DELETE", Self.DocumentURL(Document) + "?signature=" + Beacon.EncodeHex(Signature))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentURL(Document As Beacon.Document) As Text
		  Return Self.DocumentURL(Document.Identifier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentURL(DocumentID As Text) As Text
		  Return Beacon.WebURL + "/documents.php/" + DocumentID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetDocument(DocumentID As Text)
		  If Self.mCurrentAction <> Beacon.RepositoryEngine.Actions.None Then
		    Raise New Xojo.Core.UnsupportedOperationException
		  End If
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.Get
		  Self.mSocket.Send("GET", Self.DocumentURL(DocumentID))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetDocumentStatus(Document As Beacon.Document)
		  Self.GetDocumentStatus(Document.Identifier)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetDocumentStatus(DocumentID As Text)
		  If Self.mCurrentAction <> Beacon.RepositoryEngine.Actions.None Then
		    Raise New Xojo.Core.UnsupportedOperationException
		  End If
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.Status
		  Self.mSocket.Send("HEAD", Self.DocumentURL(DocumentID))
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
		  #Pragma Unused Sender
		  
		  Select Case Self.mCurrentAction
		  Case Beacon.RepositoryEngine.Actions.List
		    RaiseEvent DocumentListError(Err.Reason)
		  Case Beacon.RepositoryEngine.Actions.Get
		    RaiseEvent DocumentRetrieveError(Err.Reason)
		  Case Beacon.RepositoryEngine.Actions.Save
		    RaiseEvent SaveError(Err.Reason)
		  Case Beacon.RepositoryEngine.Actions.Delete
		    RaiseEvent DeleteError
		  Case Beacon.RepositoryEngine.Actions.Status
		    RaiseEvent DocumentStatus(False, "", Nil, "")
		  End Select
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.None
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_HeadersReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer)
		  #Pragma Unused URL
		  
		  If Self.mCurrentAction = Beacon.RepositoryEngine.Actions.Status Then
		    If HTTPStatus <> 200 Then
		      RaiseEvent DocumentStatus(False, "", Nil, "")
		    Else
		      Try
		        Dim AuthorID As Text = Sender.ResponseHeader("X-Beacon-UserID")
		        Dim Hash As Text = Sender.ResponseHeader("X-Beacon-MD5")
		        Dim LastUpdateText As Text = Sender.ResponseHeader("X-Beacon-Date")
		        
		        Dim LastUpdate As Xojo.Core.Date = Xojo.Core.Date.FromText(LastUpdateText, Xojo.Core.Locale.Raw)
		        LastUpdate = New Xojo.Core.Date(LastUpdate.SecondsFrom1970 + LastUpdate.TimeZone.SecondsFromGMT, New Xojo.Core.TimeZone("UTC"))
		        
		        RaiseEvent DocumentStatus(True, AuthorID, LastUpdate, Hash)
		      Catch Err As RuntimeException
		        RaiseEvent DocumentStatus(True, "", Nil, "")
		      End Try
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  Dim Response As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  
		  Select Case Self.mCurrentAction
		  Case Beacon.RepositoryEngine.Actions.List
		    If HTTPStatus = 200 Then
		      Dim Results() As Auto = Xojo.Data.ParseJSON(Response)
		      Break
		    Else
		      RaiseEvent DocumentListError(Response)
		    End If
		  Case Beacon.RepositoryEngine.Actions.Get
		    If HTTPStatus = 200 Then
		      Dim Document As Beacon.Document = Beacon.Document.Read(Response)
		      RaiseEvent DocumentReceived(Document)
		    Else
		      RaiseEvent DocumentRetrieveError(Response)
		    End If
		  Case Beacon.RepositoryEngine.Actions.Save
		    If HTTPStatus <> 200 Then
		      RaiseEvent SaveError(Response)
		    Else
		      RaiseEvent SaveSuccess(Response)
		    End If
		  Case Beacon.RepositoryEngine.Actions.Delete
		    If HTTPStatus <> 200 Then
		      RaiseEvent DeleteError
		    Else
		      RaiseEvent DeleteSuccess
		    End If
		  End Select
		  
		  Self.mCurrentAction = Beacon.RepositoryEngine.Actions.None
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveDocument(Document As Beacon.Document, Identity As Beacon.Identity)
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
		Event DeleteError()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DeleteSuccess()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentListError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentReceived(Document As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentRetrieveError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentsReceived(Documents() As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DocumentStatus(Published As Boolean, AuthorID As Text, LastUpdate As Xojo.Core.Date, ContentHash As Text)
	#tag EndHook

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
		  Delete
		Status
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
