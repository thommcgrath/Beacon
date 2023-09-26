#tag Class
Protected Class CustomConfig
Inherits SDTD.ConfigGroup
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub CopyFrom(Other As SDTD.ConfigGroup)
		  If Other Is Nil Or (Other IsA SDTD.Configs.CustomConfig) = False Then
		    Return
		  End If
		  
		  Var Source As SDTD.Configs.CustomConfig = SDTD.Configs.CustomConfig(Other)
		  Self.mSalt = Source.mSalt
		  Self.mFileContents = New Dictionary
		  For Each Entry As DictionaryEntry In Source.mFileContents
		    Self.mFileContents.Value(Entry.Key) = Entry.Value
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As SDTD.Project, Profile As SDTD.ServerProfile) As SDTD.ConfigValue()
		  Var DataSource As SDTD.DataSource = SDTD.DataSource.Pool.Get(False)
		  Var Values() As SDTD.ConfigValue
		  
		  // ServerConfigXml
		  Var ServerConfigSource As String = Self.PrepareXml(Self.mFileContents.Lookup(SDTD.ConfigFileServerConfigXml, "").StringValue)
		  If ServerConfigSource.IsEmpty = False Then
		    Try
		      Var Xml As New XmlDocument(ServerConfigSource)
		      Var Nodes As XmlNodeList = Xml.XQL("/ServerSettings/property")
		      Var Bound As Integer = Nodes.Length - 1
		      For Idx As Integer = 0 To Bound
		        Var Node As XmlNode = Nodes.Item(Idx)
		        Var Key As String = Node.GetAttribute("name")
		        Var Value As String = Node.GetAttribute("value")
		        
		        Var Options() As SDTD.ConfigOption = DataSource.GetConfigOptions(SDTD.ConfigFileServerConfigXml, Key, Project.GameVersion, Project.ContentPacks)
		        Var Option As SDTD.ConfigOption
		        If Options.Count > 0 Then
		          Option = Options(0)
		        Else
		          Option = New SDTD.ConfigOption(SDTD.ConfigFileServerConfigXml, Key)
		        End If
		        Values.Add(New SDTD.ConfigValue(Option, Value))
		      Next
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  For Each Entry As DictionaryEntry In Self.mFileContents
		    If Entry.Value.StringValue.Trim.IsEmpty = False Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As Dictionary
		  If (EncryptedData Is Nil) = False Then
		    If EncryptedData.HasKey("rainbow") Then
		      Try
		        Rainbow = EncryptedData.Value("rainbow")
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If EncryptedData.HasKey("salt") Then
		      Self.mSalt = DecodeBase64MBS(EncryptedData.Value("salt").StringValue)
		    End If
		  End If
		  If Rainbow Is Nil Then
		    Rainbow = New Dictionary
		  End If
		  
		  If SaveData.HasKey("files") Then
		    Var Files As Dictionary = SaveData.Value("files")
		    Self.mFileContents = New Dictionary
		    For Each Entry As DictionaryEntry In Files
		      Self.mFileContents.Value(Entry.Key) = Self.DecodeContent(Entry.Value.StringValue, Rainbow)
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  #Pragma Unused Project
		  
		  Var Filenames() As String = Array(SDTD.ConfigFileServerConfigXml)
		  For Each Filename As String In Filenames
		    Var Source As String = Self.PrepareXml(Self.mFileContents.Lookup(Filename, "").StringValue)
		    If Source.IsEmpty Then
		      Continue
		    End If
		    
		    Try
		      Var Xml As New XmlDocument(Source)
		      #Pragma Unused Xml
		    Catch Err As RuntimeException
		      If Err IsA XmlException Then
		        Issues.Add(New Beacon.Issue(Location, XmlException(Err).XmlMessage, Err))
		      Else
		        Issues.Add(New Beacon.Issue(Location, "Could not use " + Filename + ": " + Err.Message, Err))
		      End If
		    End Try
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As New Dictionary
		  Var Files As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mFileContents
		    Files.Value(Entry.Key) = Self.EncodeContent(Entry.Value.StringValue, Rainbow)
		  Next
		  SaveData.Value("files") = Files
		  
		  If Rainbow.KeyCount > 0 Then
		    EncryptedData.Value("salt") = EncodeBase64MBS(Self.mSalt)
		    EncryptedData.Value("rainbow") = Rainbow
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mFileContents = New Dictionary
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeContent(Input As String, Rainbow As Dictionary) As String
		  Var StartLen As Integer = Self.EncryptedTag.Length + 2
		  Var EndLen As Integer = StartLen + 1
		  Var StartPos As Integer = 0
		  
		  Input = DecodeBase64MBS(Input).DefineEncoding(Encodings.UTF8)
		  
		  Do
		    Var OuterStartPos As Integer = Input.IndexOf(StartPos, "<" + Self.EncryptedTag + ">")
		    If OuterStartPos = -1 Then
		      Exit
		    End If
		    
		    Var InnerStartPos As Integer = OuterStartPos + StartLen
		    Var InnerEndPos As Integer = Input.IndexOf(InnerStartPos, "</" + Self.EncryptedTag + ">")
		    If InnerEndPos = -1 Or InnerEndPos = InnerStartPos Then
		      Exit
		    End If
		    
		    Var OuterEndPos As Integer = InnerEndPos + EndLen
		    Var InnerLen As Integer = InnerEndPos - InnerStartPos
		    Var OuterLen As Integer = OuterEndPos - OuterEndPos
		    Var Hash As String = Input.Middle(InnerStartPos, InnerLen)
		    Var Decrypted As String
		    If (Rainbow Is Nil) = False And Rainbow.HasKey(Hash) Then
		      Decrypted = Rainbow.Value(Hash)
		    End If
		    
		    Var Prefix As String = Input.Left(InnerStartPos)
		    Var Suffix As String = Input.Middle(InnerEndPos)
		    Input = Prefix + Decrypted + Suffix
		    StartPos = Prefix.Length + Decrypted.Length + EndLen
		  Loop
		  
		  Return Input
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EncodeContent(Input As String, Rainbow As Dictionary) As String
		  Var StartLen As Integer = Self.EncryptedTag.Length + 2
		  Var EndLen As Integer = StartLen + 1
		  Var StartPos As Integer = 0
		  
		  Do
		    Var OuterStartPos As Integer = Input.IndexOf(StartPos, "<" + Self.EncryptedTag + ">")
		    If OuterStartPos = -1 Then
		      Exit
		    End If
		    
		    Var InnerStartPos As Integer = OuterStartPos + StartLen
		    Var InnerEndPos As Integer = Input.IndexOf(InnerStartPos, "</" + Self.EncryptedTag + ">")
		    If InnerEndPos = -1 Or InnerEndPos = InnerStartPos Then
		      Exit
		    End If
		    
		    If Self.mSalt.IsEmpty Then
		      Self.mSalt = Crypto.GenerateRandomBytes(32)
		    End If
		    
		    Var OuterEndPos As Integer = InnerEndPos + EndLen
		    Var InnerLen As Integer = InnerEndPos - InnerStartPos
		    Var OuterLen As Integer = OuterEndPos - OuterEndPos
		    Var Decrypted As String = Input.Middle(InnerStartPos, InnerLen)
		    Var Hash As String = EncodeHex(Crypto.HMAC(Self.mSalt, Decrypted, Crypto.HashAlgorithms.SHA2_512)).Lowercase
		    Rainbow.Value(Hash) = Decrypted
		    
		    Var Prefix As String = Input.Left(InnerStartPos)
		    Var Suffix As String = Input.Middle(InnerEndPos)
		    Input = Prefix + Hash + Suffix
		    StartPos = Prefix.Length + Hash.Length + EndLen
		  Loop
		  
		  Return EncodeBase64MBS(Input)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, ContentPacks As Beacon.StringList) As SDTD.Configs.CustomConfig
		  #if Not SDTD.Enabled
		    #Pragma Unused ParsedData
		    #Pragma Unused ContentPacks
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return SDTD.Configs.NameCustomConfig
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function PrepareXml(Source As String) As String
		  Return Source.Trim.ReplaceAll("<" + EncryptedTag + ">", "").ReplaceAll("</" + EncryptedTag + ">", "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function XmlContent(Filename As String) As String
		  Return Self.mFileContents.Lookup(Filename, "").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub XmlContent(Filename As String, Assigns Value As String)
		  Value = Value.Trim
		  
		  If Value.IsEmpty Then
		    If Self.mFileContents.HasKey(Filename) THen
		      Self.mFileContents.Remove(Filename)
		    End If
		  Else
		    Self.mFileContents.Value(Filename) = Value
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFileContents As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSalt As String
	#tag EndProperty


	#tag Constant, Name = EncryptedTag, Type = String, Dynamic = False, Default = \"Beacon:Encrypted", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LineCommentPrefix, Type = String, Dynamic = False, Default = \"//", Scope = Public
	#tag EndConstant


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
