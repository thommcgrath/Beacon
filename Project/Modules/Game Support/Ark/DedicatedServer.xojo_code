#tag Module
Protected Module DedicatedServer
	#tag Method, Flags = &h1
		Protected Function Configure(Project As Ark.Project, Profile As Ark.ServerProfile, ArkRoot As FolderItem, HostDir As FolderItem) As Boolean
		  Var Organizer As Ark.ConfigOrganizer = Project.CreateConfigOrganizer(App.IdentityManager.CurrentIdentity, Profile)
		  If Organizer Is Nil Then
		    App.Log("Project did not create a config organizer")
		    Return False
		  End If
		  
		  If HostDir.CheckIsFolder(True) = False Then
		    App.Log("Server root " + HostDir.NativePath + " could not be created.")
		    Return False
		  End If
		  
		  Var ShooterGameFolder As FolderItem = ArkRoot.Child("ShooterGame")
		  Var ServerFolder As FolderItem = HostDir.Child(Profile.ProfileID)
		  If ServerFolder.CheckIsFolder(True) = False Then
		    App.Log("Server directory " + ServerFolder.NativePath + " could not be created.")
		    Return False
		  End If
		  
		  Var ServerShooterGameFolder As FolderItem = ServerFolder.Child("ShooterGame")
		  If ServerShooterGameFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create server ShooterGame directory " + ServerShooterGameFolder.NativePath + ".")
		    Return False
		  End If
		  
		  Var SavedFolder As FolderItem = ServerShooterGameFolder.Child("Saved")
		  If SavedFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create server Saved directory " + SavedFolder.NativePath + ".")
		    Return False
		  End If
		  
		  // Create mods folder so mods are downloaded fresh
		  // Var ModsFolder As FolderItem = CreateFolderAtPath(ServerFolder, "ShooterGame/Content/Mods")
		  
		  Var ConfigFolder As FolderItem = SavedFolder.Child("Config")
		  If ConfigFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create server Config directory " + ConfigFolder.NativePath + ".")
		    Return False
		  End If
		  
		  #if TargetWindows
		    ConfigFolder = ConfigFolder.Child("WindowsServer")
		  #elseif TargetLinux
		    ConfigFolder = ConfigFolder.Child("LinuxServer")
		  #elseif TargetMacOS
		    ConfigFolder = ConfigFolder.Child("MacServer")
		  #endif
		  If ConfigFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create platform config directory " + ConfigFolder.NativePath + ".")
		    Return False
		  End If
		  
		  Var GameUserSettingsIniOriginal, GameIniOriginal As String
		  If ConfigFolder.Child(Ark.ConfigFileGameUserSettings).Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(ConfigFolder.Child(Ark.ConfigFileGameUserSettings))
		    GameUserSettingsIniOriginal = Stream.ReadAll(Nil).GuessEncoding
		    Stream.Close
		  End If
		  If ConfigFolder.Child(Ark.ConfigFileGame).Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(ConfigFolder.Child(Ark.ConfigFileGame))
		    GameIniOriginal = Stream.ReadAll(Nil).GuessEncoding
		    Stream.Close
		  End If
		  
		  Var Format As Ark.Rewriter.EncodingFormat
		  If Project.AllowUCS2 Then
		    Format = Ark.Rewriter.EncodingFormat.UCS2AndASCII
		  Else
		    Format = Ark.Rewriter.EncodingFormat.ASCII
		  End If
		  
		  Var RewriteError As RuntimeException
		  
		  Var GameIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, GameIniOriginal, Ark.HeaderShooterGame, Ark.ConfigFileGame, Organizer, Project.UUID, Project.LegacyTrustKey, Format, Ark.Project.UWPCompatibilityModes.Never, False, RewriteError)
		  If (RewriteError Is Nil) = False Then
		    App.Log(RewriteError, CurrentMethodName, "Building Game.ini")
		    Return False
		  End If
		  
		  Var GameUserSettingsIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, GameUserSettingsIniOriginal, Ark.HeaderServerSettings, Ark.ConfigFileGameUserSettings, Organizer, Project.UUID, Project.LegacyTrustKey, Format, Ark.Project.UWPCompatibilityModes.Never, False, RewriteError)
		  If (RewriteError Is Nil) = False Then
		    App.Log(RewriteError, CurrentMethodName, "Building GameUserSettings.ini")
		    Return False
		  End If
		  
		  If ConfigFolder.Child(Ark.ConfigFileGameUserSettings).Write(GameUserSettingsIniRewritten) = False Then
		    App.Log("Could not write GameUserSettings.ini to platform config directory")
		    Return False
		  End If
		  If ConfigFolder.Child(Ark.ConfigFileGame).Write(GameIniRewritten) = False Then
		    App.Log("Could not write Game.ini to platform config directory")
		    Return False
		  End If
		  
		  Try
		    HardLinkContents(ArkRoot, ServerFolder, False)
		    HardLinkContents(ShooterGameFolder, ServerFolder.Child("ShooterGame"), False)
		  Catch Err As RuntimeException
		    App.Log(Err, "Creating hard links", CurrentMethodName)
		    Return False
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateFolderAtPath(Root As FolderItem, Path As String) As FolderItem
		  Var Components() As String = Path.Split("/")
		  Var Parent As FolderItem = Root
		  For Each Component As String In Components
		    Var Child As FolderItem = Parent.Child(Component)
		    If Not Child.CheckIsFolder(True) Then
		      Return Nil
		    End If
		    Parent = Child
		  Next
		  Return Parent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateHardLink(Sh As Shell, SourceFile As FolderItem, DestinationFile As FolderItem)
		  If SourceFile.Exists = False Or DestinationFile.Exists = True Then
		    Return
		  End If
		  
		  #if TargetWindows
		    If SourceFile.IsFolder Then
		      Sh.Execute("mklink /J """ + DestinationFile.NativePath + """ """ + SourceFile.NativePath + """")
		    Else
		      Sh.Execute("mklink /H """ + DestinationFile.NativePath + """ """ + SourceFile.NativePath + """")
		    End If
		    
		    Var ExitCode As Integer = Sh.ExitCode
		    If ExitCode <> 0 Then
		      Var Err As New UnsupportedOperationException
		      Err.ErrorNumber = ExitCode
		      Err.Message = Sh.Result.Trim
		      Raise Err
		    End If
		  #elseif TargetLinux Or TargetMacOS
		    If SourceFile.IsFolder Then
		      Sh.Execute("ln -s " + SourceFile.ShellPath + " " + DestinationFile.ShellPath)
		    Else
		      Sh.Execute("ln " + SourceFile.ShellPath + " " + DestinationFile.ShellPath)
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Decompress(SourceFile As FolderItem, DestinationFile As FolderItem, SkipIfExists As Boolean)
		  // Inspired by https://github.com/project-umbrella/arkit.py/blob/master/arkit.py
		  
		  If SourceFile.IsFolder Then
		    Call DestinationFile.CheckIsFolder(True)
		    
		    For Each Child As FolderItem In SourceFile.Children
		      Var ChildName As String = Child.Name
		      If ChildName.EndsWith(".z") Then
		        ChildName = ChildName.Left(ChildName.Length - 2)
		      End If
		      Decompress(Child, DestinationFile.Child(ChildName), SkipIfExists)
		    Next
		    
		    Return
		  End If
		  
		  If (DestinationFile.Exists And SkipIfExists) Or SourceFile.Name.EndsWith(".z.uncompressed_size") Then
		    Return
		  End If
		  
		  If SourceFile.Name.EndsWith(".z") = False Then
		    Var InStream As BinaryStream = BinaryStream.Open(SourceFile, False)
		    Var OutStream As BinaryStream = BinaryStream.Create(DestinationFile, True)
		    While Not InStream.EndOfFile
		      OutStream.Write(InStream.Read(1048576))
		    Wend
		    OutStream.Close
		    InStream.Close
		    Return
		  End
		  
		  Var InStream As BinaryStream = BinaryStream.Open(SourceFile, False)
		  InStream.LittleEndian = True
		  Var SigVersion As Int64 = InStream.ReadInt64
		  Var SizeUnpackedChunk As Int64 = InStream.ReadInt64
		  Var SizePacked As Int64 = InStream.ReadInt64
		  Var SizeUnpacked As Int64 = InStream.ReadInt64
		  
		  #Pragma Unused SizeUnpackedChunk
		  #Pragma Unused SizePacked
		  
		  If SigVersion <> 2653586369 Then
		    Raise New UnsupportedOperationException("Signature version mismatch.")
		  End If
		  
		  Var CompressionIndex() As Pair
		  Var SizeIndexed As Int64
		  While SizeIndexed < SizeUnpacked
		    Var SizeCompressed As Int64 = InStream.ReadInt64
		    Var SizeUncompressed As Int64 = InStream.ReadInt64
		    CompressionIndex.Add(SizeCompressed : SizeUncompressed)
		    SizeIndexed = SizeIndexed + SizeUncompressed
		  Wend
		  
		  If SizeUnpacked <> SizeIndexed Then
		    // Header index mismatch
		    Raise New UnsupportedOperationException("Header index mismatch.")
		  End If
		  
		  Var OutStream As BinaryStream = BinaryStream.Create(DestinationFile, True)
		  OutStream.LittleEndian = InStream.LittleEndian
		  
		  For Each IndexPair As Pair In CompressionIndex
		    Var SizeCompressed As Int64 = IndexPair.Left
		    Var SizeUncompressed As Int64 = IndexPair.Right
		    Var CompressedData As String = InStream.Read(SizeCompressed)
		    
		    Var Decompressor As New ZLibDecompressMBS(SizeUncompressed)
		    Decompressor.InitZip
		    If Decompressor.SetInput(CompressedData) = False Then
		      Raise New UnsupportedOperationException("Could not set zlib decompression input.")
		    End If
		    Decompressor.ProcessZip(False)
		    Var UncompressedData As String = Decompressor.GetOutput
		    Decompressor.EndZip
		    
		    If UncompressedData.Bytes <> SizeUncompressed Then
		      Raise New UnsupportedOperationException("Uncompressed chunk size does not match header.")
		    End If
		    
		    OutStream.Write(UncompressedData)
		  Next
		  OutStream.Close
		  InStream.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HardLinkContents(Folder As FolderItem, Destination As FolderItem, FillDirectories As Boolean, ParamArray Exclude() As String)
		  HardLinkContents(Folder, Destination, FillDirectories, Exclude)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HardLinkContents(Folder As FolderItem, Destination As FolderItem, FillDirectories As Boolean, Exclude() As String)
		  Var Sh As Shell
		  For Each SourceFile As FolderItem In Folder.Children
		    If Exclude.IndexOf(SourceFile.Name) > -1 Then
		      Continue
		    End If
		    
		    Var TargetFile As FolderItem = Destination.Child(SourceFile.Name)
		    If TargetFile.Exists Then
		      If TargetFile.IsFolder And FillDirectories Then
		        HardLinkContents(SourceFile, TargetFile, FillDirectories, Exclude)
		      Else
		        Continue
		      End If
		    End If
		    
		    If Sh Is Nil Then
		      Sh = New Shell
		    End If
		    
		    CreateHardLink(Sh, SourceFile, TargetFile)
		  Next SourceFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InstallMod(ModID As String, SourceModsDir As FolderItem, DestinationModsDir As FolderItem)
		  Var ModSourceRoot As FolderItem = SourceModsDir.Child(ModID)
		  Var ModInstallDir As FolderItem = DestinationModsDir.Child(ModID)
		  
		  Var PlatformFolder As FolderItem
		  #if TargetWindows
		    PlatformFolder = ModSourceRoot.Child("WindowsNoEditor")
		  #elseif TargetLinux
		    PlatformFolder = ModSourceRoot.Child("LinuxNoEditor")
		  #else
		    #Pragma Unused ModSourceRoot
		  #endif
		  
		  If PlatformFolder Is Nil Or PlatformFolder.Exists = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Mod " + ModID + " does not support this platform."
		    Raise Err
		  End If
		  
		  // Recursively start decompressing files
		  Decompress(PlatformFolder, ModInstallDir, True)
		  
		  // Create the .mod file
		  // See https://raw.githubusercontent.com/LHammonds/ark-bash/main/Ark_Mod_Downloader.py
		  Var ModInfoFile As FolderItem = PlatformFolder.Child("mod.info")
		  Var MetaFile As FolderItem = PlatformFolder.Child("modmeta.info")
		  Var DotModFile As FolderItem = DestinationModsDir.Child(ModID + ".mod")
		  If DotModFile.Exists Then
		    Return
		  End If
		  
		  Var ModInfo As Pair = ReadModInfoFile(ModInfoFile)
		  Var ModName As String = ModInfo.Left
		  Var MapNames() As String = ModInfo.Right
		  Var MetaInfo As Dictionary = ReadMetaFile(MetaFile)
		  
		  // Mod Id, 4 bytes
		  // Padding, 4 bytes
		  // Mod Name, variable
		  // Mod Path, variable
		  // Map Count, 4 bytes
		  // Map Values, variable
		  // 4280483635, 4 bytes
		  // 2, 4 bytes
		  // Mod type, 1 byte
		  // Num meta, 4 bytes
		  // Meta values, variable
		  
		  Var Stream As BinaryStream = BinaryStream.Create(DotModFile, True)
		  Stream.LittleEndian = True
		  Stream.WriteUInt32(UInt32.FromString(ModID, Locale.Raw))
		  Stream.WriteUInt32(0) // Padding bytes
		  WriteUnrealString(Stream, ModName)
		  WriteUnrealString(Stream, "../../../ShooterGame/Content/Mods/" + ModID)
		  Stream.WriteInt32(MapNames.Count)
		  For Each MapName As String In MapNames
		    WriteUnrealString(Stream, MapName)
		  Next
		  Stream.WriteUint32(4280483635)
		  Stream.WriteInt32(2)
		  If MetaInfo.HasKey("ModType") Then
		    Stream.WriteUInt8(1)
		  Else
		    Stream.WriteUInt8(0)
		  End If
		  Stream.WriteInt32(MetaInfo.KeyCount)
		  For Each Entry As DictionaryEntry In MetaInfo
		    WriteUnrealString(Stream, Entry.Key)
		    WriteUnrealString(Stream, Entry.Value)
		  Next
		  Stream.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadFString(Stream As BinaryStream) As String
		  Var Len As Int32 = Stream.ReadInt32
		  If Len = 0 Then
		    Return ""
		  End If
		  
		  Return Stream.Read(Len).DefineEncoding(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadMetaFile(File As FolderItem) As Dictionary
		  Var Stream As BinaryStream = BinaryStream.Open(File, False)
		  Stream.LittleEndian = True
		  
		  Var MetaData As New Dictionary
		  Var MetaEntriesCount As UInt32 = Stream.ReadUInt32
		  For EntryIndex As Integer = 1 To MetaEntriesCount
		    MetaData.Value(ReadUnrealString(Stream)) = ReadUnrealString(Stream)
		  Next
		  Stream.Close
		  
		  Return MetaData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadModInfoFile(File As FolderItem) As Pair
		  Var Stream As BinaryStream = BinaryStream.Open(File, False)
		  Stream.LittleEndian = True
		  
		  Var ModName As String = ReadUnrealString(Stream)
		  Var MapCount As UInt32 = Stream.ReadUInt32
		  Var MapNames() As String
		  For MapIndex As Integer = 1 To MapCount
		    MapNames.Add(ReadUnrealString(Stream))
		  Next
		  Stream.Close
		  
		  Return ModName : MapNames
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadUnrealString(Stream As BinaryStream) As String
		  Var Len As UInt32 = Stream.ReadUInt32
		  If Len = 0 Then
		    Return ""
		  End If
		  
		  Var Value As String = Stream.Read(Len - 1).DefineEncoding(Encodings.UTF8)
		  Call Stream.Read(1) // To advance past the null terminator
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShooterGameServer(ArkRoot As FolderItem) As FolderItem
		  If ArkRoot Is Nil Or ArkRoot.Exists = False Then
		    Return Nil
		  End If
		  
		  Var PathComponents() As String
		  
		  #if TargetWindows
		    PathComponents.Add("ShooterGame")
		    PathComponents.Add("Binaries")
		    PathComponents.Add("Win64")
		    PathComponents.Add("ShooterGameServer.exe")
		  #elseif TargetLinux
		    
		  #elseif TargetMacOS
		    #if DebugBuild
		      PathComponents.Add("ShooterGame.app")
		      PathComponents.Add("Contents")
		      PathComponents.Add("MacOS")
		      PathComponents.Add("ShooterGame")
		    #else
		      Return Nil
		    #endif
		  #endif
		  
		  Var Dir As FolderItem = ArkRoot
		  For Each Component As String In PathComponents
		    Dir = Dir.Child(Component)
		    If Dir Is Nil Or Dir.Exists = False Then
		      Return Nil
		    End If
		  Next
		  Return Dir
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SteamCMD(ArkRoot As FolderItem) As FolderItem
		  If ArkRoot Is Nil Or ArkRoot.Exists = False Then
		    Return Nil
		  End If
		  
		  Var PossiblePaths() As String
		  
		  #if TargetWindows
		    PossiblePaths.Add(ArkRoot.NativePath + "Engine\Binaries\ThirdParty\SteamCMD\Win64\steamcmd.exe")
		    PossiblePaths.Add(ArkRoot.NativePath + "Engine\Binaries\ThirdParty\SteamCMD\Win32\steamcmd.exe")
		  #elseif TargetLinux Or TargetMacOS
		    Return Nil
		  #endif
		  
		  For Each Path As String In PossiblePaths
		    Try
		      Var Dir As New FolderItem(Path, FolderItem.PathModes.Native)
		      If Dir.Exists = True Then
		        Return Dir
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteFString(Stream As BinaryStream, Value As String)
		  If Value.Encoding Is Nil Then
		    Value = Value.GuessEncoding
		  Else
		    Value = Value.ConvertEncoding(Encodings.UTF8)
		  End If
		  
		  Var Len As Int32 = Value.Bytes
		  Stream.WriteInt32(Len)
		  If Len > 0 Then
		    Stream.Write(Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteUnrealString(Stream As BinaryStream, Value As String)
		  If Value.Encoding Is Nil Then
		    Value = Value.GuessEncoding
		  Else
		    Value = Value.ConvertEncoding(Encodings.UTF8)
		  End If
		  
		  Var Len As UInt32 = Value.Bytes
		  Stream.WriteUInt32(Len + 1)
		  If Len > 0 Then
		    Stream.Write(Value)
		  End If
		  Stream.WriteInt8(0)
		End Sub
	#tag EndMethod


	#tag Constant, Name = PathSeparator, Type = String, Dynamic = False, Default = \"/", Scope = Protected
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"\\"
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
End Module
#tag EndModule
