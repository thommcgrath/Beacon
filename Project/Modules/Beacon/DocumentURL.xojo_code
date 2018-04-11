#tag Class
Protected Class DocumentURL
	#tag Method, Flags = &h0
		Sub Constructor(URL As Text)
		  Dim Pos As Integer = URL.IndexOf("://")
		  If Pos = -1 Then
		    Dim Err As New UnsupportedFormatException
		    Err.Reason = "Unable to determine scheme from URL " + URL
		    Raise Err
		  End If
		  
		  Self.mOriginalURL = URL
		  Self.mQueryParams = New Xojo.Core.Dictionary
		  
		  Self.mScheme = URL.Left(Pos)
		  Self.mPath = URL.Mid(Pos + 3)
		  Select Case Self.mScheme
		  Case Self.TypeWeb, Self.TypeCloud, Self.TypeLocal, Self.TypeTransient
		    // official types
		  Case "http", "beacon"
		    // also supported, change the scheme
		    Self.mScheme = Self.TypeWeb
		    Self.mOriginalURL = Self.TypeWeb + URL.Mid(Pos)
		  Else
		    Dim Err As New UnsupportedFormatException
		    Err.Reason = "Unknown document scheme " + Scheme
		    Raise Err
		  End Select
		  
		  Pos = Self.mPath.IndexOf("?")
		  If Pos > -1 Then
		    Self.mQueryString = Self.mPath.Mid(Pos + 1)
		    Self.mPath = Self.mPath.Left(Pos)
		    Dim Parts() As Text = Self.mQueryString.Split("&")
		    For Each Part As Text In Parts
		      Pos = Part.IndexOf("=")
		      If Pos = -1 Then
		        Continue
		      End If
		      
		      Dim Key As Text = Beacon.DecodeURLComponent(Part.Left(Pos))
		      Dim Value As Text = Beacon.DecodeURLComponent(Part.Mid(Pos + 1))
		      
		      Self.mQueryParams.Value(Key.Lowercase) = Value
		    Next
		  End If
		  
		  Dim HashData As Text = Self.mScheme + "://" + Self.mPath
		  Self.mHash = Beacon.EncodeHex(Xojo.Crypto.MD5(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(HashData)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As Text
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasParam(Key As Text) As Boolean
		  Return Self.mQueryParams.HasKey(Key.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Dim Name As Text
		  
		  If Self.HasParam("name") Then
		    Name = Self.Param("name")
		  End If
		  
		  If Name = "" Then
		    // Get the last path component
		    Dim Components() As Text
		    #if TargetWin32
		      If Self.mScheme = Self.TypeLocal Then
		        Components = Self.Path.Split("\")
		      Else
		        Components = Self.Path.Split("/")
		      End If
		    #else
		      Components = Self.Path.Split("/")
		    #endif
		    
		    Name = Components(Components.Ubound)
		    
		    If Name.EndsWith(".beacon") Then
		      Name = Name.Left(Name.Length - 7)
		    End If
		  End If
		  
		  Return Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As Text)
		  If Value = "" Then
		    If Self.mQueryParams.HasKey("name") Then
		      Self.mQueryParams.Remove("name")
		    End If
		  Else
		    Self.mQueryParams.Value("name") = Value
		  End If
		  
		  Dim Parts() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mQueryParams
		    Parts.Append(Beacon.EncodeURLComponent(Entry.Key) + "=" + Beacon.EncodeURLComponent(Entry.Value))
		  Next
		  
		  Self.mQueryString = Text.Join(Parts, "&")
		  
		  Dim Pos As Integer = Self.mOriginalURL.IndexOf("?")
		  If Pos > -1 Then
		    Self.mOriginalURL = Self.mOriginalURL.Left(Pos)
		  End If
		  If Self.mQueryString <> "" Then
		    Self.mOriginalURL = Self.mOriginalURL + "?" + Self.mQueryString
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.DocumentURL) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mHash.Compare(Other.mHash)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Text
		  Return Self.URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As Text)
		  Self.Constructor(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Param(Key As Text) As Text
		  If Not Self.mQueryParams.HasKey(Key.Lowercase) Then
		    Dim Err As New KeyNotFoundException
		    Err.Reason = "Key " + Key + " not found in query parameters"
		    Raise Err
		  End If
		  
		  Return Self.mQueryParams.Value(Key.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As Text
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Scheme() As Text
		  Return Self.mScheme
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Text
		  Return Self.mOriginalURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function URLForFile(File As Beacon.FolderItem) As Beacon.DocumentURL
		  Return TypeLocal + "://" + File.Path
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHash As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueryParams As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueryString As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScheme As Text
	#tag EndProperty


	#tag Constant, Name = TypeCloud, Type = Text, Dynamic = False, Default = \"beacon-cloud", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeLocal, Type = Text, Dynamic = False, Default = \"file", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeTransient, Type = Text, Dynamic = False, Default = \"temp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeWeb, Type = Text, Dynamic = False, Default = \"https", Scope = Public
	#tag EndConstant


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
