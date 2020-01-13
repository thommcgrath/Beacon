#tag Class
Protected Class Response
	#tag Method, Flags = &h0
		Sub Constructor(Error As RuntimeException)
		  Self.mMessage = Error.Explanation
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(URL As String, HTTPStatus As Integer, Content As MemoryBlock, Headers As Dictionary)
		  Self.mURL = URL
		  Self.mContent = Content
		  Self.mHTTPStatus = HTTPStatus
		  Self.mJSONParsed = False
		  Self.mJSON = Nil
		  Self.mHeaders = Headers
		  Self.mMessage = ""
		  
		  Try
		    #Pragma BreakOnExceptions False
		    Dim JSON As Variant = Beacon.ParseJSON(Content)  
		    Self.mJSONParsed = True
		    Self.mJSON = JSON
		    
		    Dim Dict As Dictionary = JSON
		    If Dict.HasKey("message") And Dict.HasKey("details") Then
		      Self.mMessage = Dict.Value("message")
		      Self.mJSON = Dict.Value("details")
		    End If
		    #Pragma BreakOnExceptions Default
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Content() As MemoryBlock
		  Return Self.mContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Header(Name As String) As String
		  If Self.mHeaders = Nil Then
		    Return ""
		  End If
		  
		  Return Self.mHeaders.Lookup(Name, "").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HTTPStatus() As Integer
		  Return Self.mHTTPStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JSON() As Variant
		  Return Self.mJSON
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JSONParsed() As Boolean
		  Return Self.mJSONParsed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  Return Self.mMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Success() As Boolean
		  Return Self.mHTTPStatus >= 200 And Self.mHTTPStatus < 300
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As String
		  Return Self.mURL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContent As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeaders As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJSON As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJSONParsed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As String
	#tag EndProperty


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
