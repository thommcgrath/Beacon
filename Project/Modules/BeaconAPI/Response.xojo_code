#tag Class
Protected Class Response
	#tag Method, Flags = &h0
		Sub Constructor(Error As RuntimeException)
		  Self.mMessage = Error.Explanation
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  Self.mURL = URL
		  Self.mContent = Content
		  Self.mHTTPStatus = HTTPStatus
		  Self.mJSONParsed = False
		  Self.mJSON = Nil
		  Self.mMessage = ""
		  
		  Try
		    #Pragma BreakOnExceptions False
		    Dim TextValue As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim JSON As Auto = Xojo.Data.ParseJSON(TextValue)  
		    Self.mJSONParsed = True
		    Self.mJSON = JSON
		    
		    Dim Dict As Xojo.Core.Dictionary = JSON
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
		Function Content() As Xojo.Core.MemoryBlock
		  Return Self.mContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HTTPStatus() As Integer
		  Return Self.mHTTPStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JSON() As Auto
		  Return Self.mJSON
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JSONParsed() As Boolean
		  Return Self.mJSONParsed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As Text
		  Return Self.mMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Success() As Boolean
		  Return Self.mHTTPStatus >= 200 And Self.mHTTPStatus < 300
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Text
		  Return Self.mURL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContent As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJSON As Auto
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJSONParsed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessage As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mURL"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
