#tag Class
Protected Class ProjectURL
	#tag Method, Flags = &h21
		Private Sub CleanupPath()
		  Var BaseUrl As String = BeaconAPI.URL("/", False)
		  If Self.mPath.BeginsWith(BaseUrl) = False Or Self.mPath.BeginsWith(BaseUrl + "v4") = True Then
		    Return
		  End If
		  
		  Var ApiPath As String = Self.mPath.Middle(BaseUrl.Length)
		  Var Reg As New RegEx
		  Reg.SearchPattern = "^v(\d)/(project|document)/"
		  
		  Var Matches AS RegExMatch = Reg.Search(ApiPath)
		  Self.mPath = Self.mPath.Replace(Matches.SubExpressionString(0), "v4/projects/")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Dict As Dictionary)
		  Self.mGameId = Dict.Value("GameId")
		  Self.mName = Dict.Value("Name")
		  Self.mPath = Dict.Value("Path")
		  Self.mProjectId = Dict.Value("ProjectId")
		  Self.mSaveInfo = Dict.Value("SaveInfo")
		  Self.mType = Dict.Value("Type")
		  
		  Self.CleanupPath()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Url As String)
		  If Url.BeginsWith("{") And Url.EndsWith("}") Then
		    // Newer Json style
		    Var Dict As Dictionary = Beacon.ParseJson(Url)
		    Self.Constructor(Dict)
		    Return
		  End If
		  
		  Var Pos As Integer = Url.IndexOf("://")
		  If Pos = -1 Then
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Unable to determine scheme from URL " + Url
		    Raise Err
		  End If
		  
		  Self.mPath = Url
		  
		  Var Scheme As String = Url.Left(Pos)
		  Select Case Scheme
		  Case "file"
		    Self.mType = Self.TypeLocal
		  Case "http", "https"
		    Static ProjectsUrl As String = BeaconApi.Url("/projects/")
		    Self.mType = If(Url.BeginsWith(ProjectsUrl), Self.TypeCloud, Self.TypeWeb)
		  Case "beacon", "beacon-cloud"
		    Self.mType = Self.TypeCloud
		    Self.mPath = "https" + Self.mPath.Middle(Scheme.Length)
		  Case "temp"
		    Self.mType = Self.TypeTransient
		  Else
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Unknown url scheme " + Scheme
		    Raise Err
		  End Select
		  
		  Pos = Self.mPath.IndexOf("?")
		  If Pos > -1 Then
		    Var QueryString As String = Self.mPath.Middle(Pos + 1)
		    Self.mPath = Self.mPath.Left(Pos)
		    Var Parts() As String = QueryString.Split("&")
		    Var QueryParams As New Dictionary
		    For Each Part As String In Parts
		      Pos = Part.IndexOf("=")
		      If Pos = -1 Then
		        Continue
		      End If
		      
		      Var Key As String = DecodeURLComponent(Part.Left(Pos).ReplaceAll("+", " ")).DefineEncoding(Encodings.UTF8)
		      Var Value As String = DecodeURLComponent(Part.Middle(Pos + 1).ReplaceAll("+", " ")).DefineEncoding(Encodings.UTF8)
		      
		      QueryParams.Value(Key.Lowercase) = Value
		    Next
		    
		    If QueryParams.HasKey("name") Then
		      Self.mName = QueryParams.Value("name")
		    End If
		    If QueryParams.HasKey("game") Then
		      Self.mGameId = QueryParams.Value("game")
		    End If
		    If QueryParams.HasKey("saveinfo") Then
		      Self.mSaveInfo = QueryParams.Value("saveinfo")
		    End If
		  End If
		  
		  Self.CleanupPath()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GameId As String, Name As String, Path As String, ProjectId As String, SaveInfo As String, Type As String)
		  Self.mGameId = GameId
		  Self.mName = Name
		  Self.mPath = Path
		  Self.mProjectId = ProjectId
		  Self.mSaveInfo = SaveInfo
		  Self.mType = Type
		  
		  Self.CleanupPath()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Project As Beacon.Project, Url As Beacon.ProjectUrl) As Beacon.ProjectUrl
		  Var Copy As New Beacon.ProjectUrl(Project.GameId, Project.Title, Url.mPath, Project.ProjectId, Url.mSaveInfo, Url.mType)
		  Copy.Autosave = Url.Autosave
		  Return Copy
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Project As Beacon.Project, Destination As BookmarkedFolderItem) As Beacon.ProjectUrl
		  Return New Beacon.ProjectUrl(Project.GameId, Project.Title, Destination.UrlPath, Project.ProjectId, Destination.SaveInfo, TypeLocal)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Project As Beacon.Project, Path As String, Type As String, SaveInfo As String = "") As Beacon.ProjectUrl
		  Return New Beacon.ProjectUrl(Project.GameId, Project.Title, Path, Project.ProjectId, SaveInfo, Type)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Source As BookmarkedFolderItem) As Beacon.ProjectUrl
		  Return New Beacon.ProjectUrl("", Source.Name, Source.UrlPath, "", Source.SaveInfo, TypeLocal)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DictionaryValue() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("GameId") = Self.mGameId
		  Dict.Value("Name") = Self.mName
		  Dict.Value("Path") = Self.mPath
		  Dict.Value("ProjectId") = Self.mProjectId
		  Dict.Value("SaveInfo") = Self.mSaveInfo
		  Dict.Value("Type") = Self.mType
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File() As BookmarkedFolderItem
		  // Will return Nil if the scheme is not file
		  If Self.mType <> Self.TypeLocal Then
		    Return Nil
		  End If
		  
		  Var Result As BookmarkedFolderItem
		  If Self.mSaveInfo.IsEmpty = False Then
		    Result = BookmarkedFolderItem.FromSaveInfo(Self.mSaveInfo)
		  Else
		    Result = New BookmarkedFolderItem(Self.mPath, FolderItem.PathModes.URL)
		  End If
		  
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  If Self.mGameId.IsEmpty Then
		    // Assume Ark
		    Self.mGameId = Ark.Identifier
		  End If
		  
		  Return Self.mGameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HumanPath() As String
		  // Not suitable for restoring a file, just a visual reference
		  
		  If Self.mType = Self.TypeLocal Then
		    Var File As FolderItem = Self.File
		    If (File Is Nil) = False Then
		      Return File.NativePath
		    End If
		    Return "Invalid Path"
		  Else
		    Return Self.mPath
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  If Self.mName.IsEmpty Then
		    // Get the last path component
		    Var Components() As String = Self.mPath.Split("/")
		    Var Name As String = Components(Components.LastIndex)
		    
		    If Name.EndsWith(".beacon") Then
		      Name = Name.Left(Name.Length - 7)
		    End If
		    
		    Name = DecodeURLComponent(Name.ReplaceAll("+", " ")).DefineEncoding(Encodings.UTF8)
		    Self.mName = Name
		  End If
		  
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ProjectURL) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mProjectId.IsEmpty = False Then
		    Return Self.mProjectId.Compare(Other.mProjectId, ComparisonOptions.CaseInsensitive)
		  Else
		    Return Self.mPath.Compare(Other.mPath, ComparisonOptions.CaseSensitive)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Dictionary
		  Return Self.DictionaryValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Dict As Dictionary)
		  Self.Constructor(Dict)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As String)
		  Self.Constructor(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProjectId() As String
		  Return Self.mProjectId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  Return Beacon.GenerateJson(Self.DictionaryValue, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As String
		  Return Self.mType
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Autosave As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveInfo As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As String
	#tag EndProperty


	#tag Constant, Name = TypeCloud, Type = String, Dynamic = False, Default = \"beacon-cloud", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeCommunity, Type = String, Dynamic = False, Default = \"beacon-community", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeLocal, Type = String, Dynamic = False, Default = \"file", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeShared, Type = String, Dynamic = False, Default = \"beacon-shared", Scope = Public
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
		#tag ViewProperty
			Name="Autosave"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
