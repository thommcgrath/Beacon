#tag Class
Protected Class DocumentURL
	#tag Method, Flags = &h0
		Sub Constructor(URL As String)
		  Dim Pos As Integer = URL.IndexOf("://")
		  If Pos = -1 Then
		    #if Not TargetIOS
		      // Try as Xojo SaveInfo
		      Try
		        Dim File As Global.FolderItem = Volume(0).GetRelative(DecodeBase64(URL))
		        If File <> Nil Then
		          URL = URLForFile(File)
		          Pos = URL.IndexOf("://")
		        End If
		      Catch Err As RuntimeException
		        
		      End Try
		    #endif
		    
		    If Pos = -1 Then
		      Dim Err As New UnsupportedFormatException
		      Err.Message = "Unable to determine scheme from URL " + URL
		      Raise Err
		    End If
		  End If
		  
		  Self.mOriginalURL = URL
		  Self.mQueryParams = New Dictionary
		  
		  Self.mScheme = URL.Left(Pos)
		  Self.mPath = URL.SubString(Pos + 3)
		  Select Case Self.mScheme
		  Case Self.TypeWeb, Self.TypeCloud, Self.TypeLocal, Self.TypeTransient
		    // official types
		  Case "http", "beacon"
		    // also supported, change the scheme
		    Self.mScheme = Self.TypeWeb
		    Self.mOriginalURL = Self.TypeWeb + URL.SubString(Pos)
		  Else
		    Dim Err As New UnsupportedFormatException
		    Err.Message = "Unknown document scheme " + Scheme
		    Raise Err
		  End Select
		  
		  Pos = Self.mPath.IndexOf("?")
		  If Pos > -1 Then
		    Self.mQueryString = Self.mPath.SubString(Pos + 1)
		    Self.mPath = Self.mPath.Left(Pos)
		    Dim Parts() As String = Self.mQueryString.Split("&")
		    For Each Part As String In Parts
		      Pos = Part.IndexOf("=")
		      If Pos = -1 Then
		        Continue
		      End If
		      
		      Dim Key As String = Beacon.URLDecode(Part.Left(Pos))
		      Dim Value As String = Beacon.URLDecode(Part.SubString(Pos + 1))
		      
		      Self.mQueryParams.Value(Key.Lowercase) = Value
		    Next
		  End If
		  
		  Dim HashData As String = Self.mScheme + "://" + Self.mPath
		  Self.mHash = EncodeHex(Crypto.MD5(HashData))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasParam(Key As String) As Boolean
		  Return Self.mQueryParams.HasKey(Key.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Dim Name As String
		  
		  If Self.HasParam("name") Then
		    Name = Self.Param("name")
		  End If
		  
		  If Name = "" Then
		    // Get the last path component
		    Dim Components() As String = Self.Path.Split("/")
		    Name = Components(Components.Ubound)
		    
		    If Name.EndsWith(".beacon") Then
		      Name = Name.Left(Name.Length - 7)
		    End If
		  End If
		  
		  Return Beacon.URLDecode(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As String)
		  If Value = "" Then
		    If Self.mQueryParams.HasKey("name") Then
		      Self.mQueryParams.Remove("name")
		    End If
		  Else
		    Self.mQueryParams.Value("name") = Value
		  End If
		  
		  Dim Parts() As String
		  Dim Keys() As Variant = Self.mQueryParams.Keys
		  For Each Key As Variant In Keys
		    Parts.Append(Beacon.URLEncode(Key.StringValue) + "=" + Beacon.URLEncode(Self.mQueryParams.Value(Key).StringValue))
		  Next
		  
		  Self.mQueryString = Join(Parts, "&")
		  
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
		  
		  Return StrComp(Self.mHash, Other.mHash, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As String)
		  Self.Constructor(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Param(Key As String) As String
		  If Not Self.mQueryParams.HasKey(Key.Lowercase) Then
		    Dim Err As New KeyNotFoundException
		    Err.Message = "Key " + Key + " not found in query parameters"
		    Raise Err
		  End If
		  
		  Return Self.mQueryParams.Value(Key.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Return Self.mScheme + "://" + Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Scheme() As String
		  Return Self.mScheme
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As String
		  Return Self.mOriginalURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function URLForFile(File As FolderItem) As Beacon.DocumentURL
		  Dim Path As String = File.URLPath
		  #if TargetMacOS
		    Dim SaveInfo As String = File.SaveInfo
		    If SaveInfo <> "" Then
		      If Path.IndexOf("?") = -1 Then
		        Path = Path + "?saveinfo=" + Beacon.URLEncode(SaveInfo)
		      Else
		        Path = Path + "&saveinfo=" + Beacon.URLEncode(SaveInfo)
		      End If
		    End If
		  #endif
		  Return Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WithScheme(NewScheme As String) As Beacon.DocumentURL
		  Return NewScheme + Self.mOriginalURL.SubString(Self.mScheme.Length)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueryParams As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueryString As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScheme As String
	#tag EndProperty


	#tag Constant, Name = TypeCloud, Type = String, Dynamic = False, Default = \"beacon-cloud", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeLocal, Type = String, Dynamic = False, Default = \"file", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeTransient, Type = String, Dynamic = False, Default = \"temp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeWeb, Type = String, Dynamic = False, Default = \"https", Scope = Public
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
