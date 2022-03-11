#tag DesktopWindow
Begin DesktopWindow EditorWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   True
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   578
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1391144959
   MenuBarVisible  =   True
   MinimumHeight   =   578
   MinimumWidth    =   720
   Resizeable      =   True
   Title           =   "Publisher"
   Type            =   0
   Visible         =   True
   Width           =   720
   Begin URLConnection UploadSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopButton SelectFolderButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Select Build Folder"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   469
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   166
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   139
   End
   Begin DesktopLabel ShortPreviewLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Banner Text:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   234
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopTextField ShortPreviewField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   234
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   521
   End
   Begin DesktopCanvas HorizontalSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   308
      Transparent     =   False
      Visible         =   True
      Width           =   720
   End
   Begin DesktopButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Begin"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   268
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopTextArea NotesArea
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   269
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   309
      Transparent     =   True
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   720
   End
   Begin DesktopLabel VersionLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Short Version:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   166
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopTextField VersionField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   166
      Transparent     =   True
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   176
   End
   Begin DesktopLabel BuildLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Build:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   200
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   147
   End
   Begin DesktopTextField BuildNumberField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   179
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   200
      Transparent     =   True
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   176
   End
   Begin DesktopListBox FileList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   5
      ColumnWidths    =   "*,120,60,60,60"
      DefaultRowHeight=   26
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   134
      Index           =   -2147483648
      InitialValue    =   "File	Platform	ARM64	x86	x86_64"
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   680
      _ScrollWidth    =   -1
   End
   Begin DesktopButton AddFileButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Add File"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   166
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  #if TargetMacOS
		    Var Win As NSWindowMBS = Self.NSWindowMBS
		    Win.TitlebarAppearsTransparent = True
		  #endif
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddFile(File As FolderItem, Arch As Integer = 0)
		  Var Platform As String
		  If File.Name.EndsWith(".exe") Then
		    Platform = Download.PlatformWindows
		  ElseIf File.Name.EndsWith(".dmg") Then
		    Platform = Download.PlatformMac
		  End If
		  
		  Var Version As String = Self.VersionField.Text.Trim
		  Var Path As String = File.Name
		  Var Temp As FolderItem = File.Parent
		  While (Temp Is Nil) = False
		    Path = Temp.Name + "/" + Path
		    If Temp.Name <> Version Then
		      Temp = Temp.Parent
		    Else
		      Temp = Nil
		    End If
		  Wend
		  
		  Self.FileList.AddRow(Path, Platform)
		  Var RowIdx As Integer = Self.FileList.LastAddedRowIndex
		  Self.FileList.RowTagAt(RowIdx) = File
		  If (Arch And Download.ArchARM64) = Download.ArchARM64 Then
		    Self.FileList.CellCheckBoxValueAt(RowIdx, Self.ColumnARM64) = True
		  End If
		  If (Arch And Download.ArchIntel32) = Download.ArchIntel32 Then
		    Self.FileList.CellCheckBoxValueAt(RowIdx, Self.ColumnIntel32) = True
		  End If
		  If (Arch And Download.ArchIntel64) = Download.ArchIntel64 Then
		    Self.FileList.CellCheckBoxValueAt(RowIdx, Self.ColumnIntel64) = True
		  End
		  Self.CheckEnabled()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddFiles(Folder As FolderItem, Arch As Integer = 0)
		  If Folder.IsFolder = False Then
		    Self.AddFile(Folder, Arch)
		    Return
		  End If
		  
		  For Each File As FolderItem In Folder.Children
		    Select Case File.Name
		    Case "Beacon.dmg"
		      Self.AddFile(File, If(Arch <> 0, Arch, Download.ArchARM64 Or Download.ArchIntel64))
		    Case "Install_Beacon.exe"
		      Self.AddFile(File, If(Arch <> 0, Arch, Download.ArchIntel32 Or Download.ArchIntel64))
		    Case "Combo"
		      Self.AddFiles(File, If(Arch <> 0, Arch, Download.ArchIntel32 Or Download.ArchIntel64))
		    Case "x64", "x86_64"
		      Self.AddFiles(File, If(Arch <> 0, Arch, Download.ArchIntel64))
		    Case "x86"
		      Self.AddFiles(File, If(Arch <> 0, Arch, Download.ArchIntel32))
		    End Select
		  Next File
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Begin()
		  Var HumanVersion As String = Self.VersionField.Text.Trim
		  
		  Var RSAKey As String = App.PrivateKey
		  Var DSAKey As Chilkat.DSA = App.DSAKey
		  Var EdDSA As Chilkat.PrivateKey = App.EdDSAKey
		  
		  Var Queue As New Dictionary
		  Var Downloads() As Download
		  For RowIdx As Integer = 0 To Self.FileList.LastRowIndex
		    Var File As FolderItem = Self.FileList.RowTagAt(RowIdx)
		    Var Platform As String = Self.FileList.CellTextAt(RowIdx, Self.ColumnPlatform)
		    Var Arch As Integer
		    If Self.FileList.CellCheckBoxValueAt(RowIdx, Self.ColumnARM64) Then
		      Arch = Arch Or Download.ArchARM64
		    End If
		    If Self.FileList.CellCheckBoxValueAt(RowIdx, Self.ColumnIntel32) Then
		      Arch = Arch Or Download.ArchIntel32
		    End If
		    If Self.FileList.CellCheckBoxValueAt(RowIdx, Self.ColumnIntel64) Then
		      Arch = Arch Or Download.ArchIntel64
		    End If
		    
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    Var Contents As MemoryBlock = Stream.ReadAll
		    Stream.Close
		    
		    Var RSASignature As String = Self.SignRSA(RSAKey, Contents)
		    If RSASignature.IsEmpty Then
		      MessageBox("No RSA signature for " + File.NativePath + " generated")
		      Return
		    End If
		    Var DSASignature As String = Self.SignDSA(DSAKey, Contents)
		    If DSASignature.IsEmpty Then
		      MessageBox("No DSA signature for " + File.NativePath + " generated")
		      Return
		    End If
		    Var EdDSASignature As String = Self.SignEdDSA(EdDSA, Contents)
		    If EdDSASignature.IsEmpty Then
		      MessageBox("No EdDSA signature for " + File.NativePath + " generated")
		      Return
		    End If
		    
		    Var Path As String = Download.SuggestedPath(Arch, Platform)
		    Var URL As String = "https://releases.usebeacon.app/" + If(DebugBuild, "Debug/", "") + HumanVersion + "/" + Path
		    Var DownloadObj As New Download(Contents, URL, Arch, Platform)
		    DownloadObj.AddSignature(New DownloadSignature(RSASignature, DownloadSignature.SignatureRSA))
		    DownloadObj.AddSignature(New DownloadSignature(DSASignature, DownloadSignature.SignatureDSA))
		    DownloadObj.AddSignature(New DownloadSignature(EdDSASignature, DownloadSignature.SignatureEdDSA))
		    Queue.Value(DownloadObj.UUID) = DownloadObj
		    Downloads.Add(DownloadObj)
		  Next RowIdx
		  
		  Self.mUploadQueue = Queue
		  Self.mDownloads = Downloads
		  Self.mDisplayVersion = HumanVersion
		  
		  Self.mProgress = New ProgressSheet
		  Self.mProgress.Show(Self)
		  
		  Self.CheckEnabled()
		  Self.NextQueueItem()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckEnabled()
		  Var HasMacFile, HasWindowsFile As Boolean
		  For RowIdx As Integer = 0 To Self.FileList.LastRowIndex
		    Select Case Self.FileList.CellTextAt(RowIdx, Self.ColumnPlatform)
		    Case Download.PlatformMac
		      HasMacFile = True
		    Case Download.PlatformWindows
		      HasWindowsFile = True
		    End Select
		  Next RowIdx
		  
		  Var Enabled As Boolean = HasMacFile And HasWindowsFile
		  
		  If Self.mUploadQueue <> Nil And Self.mUploadQueue.KeyCount > 0 Then
		    Enabled = False
		  End If
		  If Enabled And Self.mBannerText = "" Then
		    Enabled = False
		  End If
		  If Enabled And Self.mBuildNumber = 0 Then
		    Enabled = False
		  End If
		  If Enabled And Self.mStageCode = 0 Then
		    Enabled = False
		  End If
		  If Enabled And Self.mDisplayVersion = "" Then
		    Enabled = False
		  End If
		  If Enabled And Self.mNotesText = "" Then
		    Enabled = False
		  End If
		  
		  If Self.ActionButton.Enabled <> Enabled Then
		    Self.ActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DictionaryToInsertSQL(TableName As String, Dict As Dictionary) As String
		  Var Columns(), Values() As String
		  For Each Entry As DictionaryEntry In Dict
		    Columns.Add("""" + Entry.Key + """")
		    Values.Add(Entry.Value)
		  Next Entry
		  
		  Return "INSERT INTO """ + TableName + """ (" + String.FromArray(Columns, ", ") + ") VALUES (" + String.FromArray(Values, ", ") + ");"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Error(Message As String)
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  Self.UploadSocket.Disconnect
		  Self.mUploadQueue = New Dictionary
		  Self.CheckEnabled()
		  
		  MessageBox(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Finish()
		  If Self.mUploadQueue <> Nil And Self.mUploadQueue.KeyCount > 0 Then
		    Return
		  End If
		  
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Close
		    Self.mProgress = Nil
		  End If
		  
		  Var DeltaVersion As Integer = 4
		  If Self.mBuildNumber = 10600000 Then
		    DeltaVersion = 6
		  ElseIf Self.mBuildNumber = 10500000 Then
		    DeltaVersion = 5
		  End If
		  
		  Var Statements() As String
		  
		  Var UpdateUUID As String = New v4UUID
		  Var InsertData As New Dictionary
		  InsertData.Value("update_id") = "'" + UpdateUUID + "'"
		  InsertData.Value("build_number") = Str(Self.mBuildNumber, "-0")
		  InsertData.Value("build_display") = "'" + Self.mDisplayVersion + "'"
		  InsertData.Value("notes") = "convert_from(decode('" + EncodeHex(Self.mNotesText) + "', 'hex'), 'UTF8')"
		  InsertData.Value("stage") = Str(Self.mStageCode, "-0")
		  InsertData.Value("preview") = "'" + Self.mBannerText.ReplaceAll("'", "''") + "'"
		  InsertData.Value("min_mac_version") = "'10.12.0'"
		  InsertData.Value("min_win_version") = "'6.1.7601'"
		  InsertData.Value("delta_version") = DeltaVersion
		  InsertData.Value("published") = "'" + DateTime.Now.SQLDateTime + "'"
		  Statements.Add(Self.DictionaryToInsertSQL("updates", InsertData))
		  
		  For Each DownloadObj As Download In Self.mDownloads
		    Var Dict As New Dictionary
		    Dict.Value("download_id") = "'" + DownloadObj.UUID + "'"
		    Dict.Value("update_id") = "'" + UpdateUUID + "'"
		    Dict.Value("url") = "'" + DownloadObj.URL + "'"
		    Dict.Value("platform") = "'" + DownloadObj.Platform + "'"
		    Dict.Value("arch") = DownloadObj.Arch
		    Statements.Add(Self.DictionaryToInsertSQL("download_urls", Dict))
		    
		    Var Signatures() As DownloadSignature = DownloadObj.Signatures
		    For Each Signature As DownloadSignature In Signatures
		      Var SignData As New Dictionary
		      SignData.Value("signature_id") = "'" + Signature.UUID + "'"
		      SignData.Value("download_id") = "'" + DownloadObj.UUID + "'"
		      SignData.Value("format") = "'" + Signature.Format + "'"
		      SignData.Value("signature") = "'" + Signature.Signature + "'"
		      Statements.Add(Self.DictionaryToInsertSQL("download_signatures", SignData))
		    Next Signature
		  Next DownloadObj
		  
		  Var Board As New Clipboard
		  Board.Text = String.FromArray(Statements, EndOfLine)
		  
		  MessageBox("Insert statements have been copied to the clipboard.")
		  
		  Self.CheckEnabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NextQueueItem()
		  If Self.mUploadQueue.KeyCount = 0 Then
		    Self.Finish()
		    Return
		  End If
		  
		  Var UUID As String = Self.mUploadQueue.Key(0)
		  Var DownloadObj As Download = Self.mUploadQueue.Value(UUID)
		  Self.mUploadQueue.Remove(UUID)
		  
		  Var Host As String = "storage.bunnycdn.com"
		  
		  Var Path As String = DownloadObj.Path + "/" + DownloadObj.Filename
		  Var UploadURL As String = "https://" + Host + "/beacon-releases/" + DownloadObj.Path + "/" + DownloadObj.Filename
		  
		  Self.mProgress.Caption = "Uploading " + Path
		  
		  Self.UploadSocket.ClearRequestHeaders()
		  Self.UploadSocket.SetRequestContent("Checksum", DownloadObj.Checksum)
		  Self.UploadSocket.SetRequestContent(DownloadObj.Contents, "application/octet-stream")
		  Self.UploadSocket.RequestHeader("AccessKey") = App.APIKey
		  Self.UploadSocket.Send("PUT", UploadURL)
		  System.DebugLog("Uploading to " + UploadURL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SignDSA(Key As Chilkat.DSA, Content As MemoryBlock) As String
		  Var Crypt As New Chilkat.Crypt2
		  Crypt.EncodingMode = "hex"
		  Crypt.HashAlgorithm = "sha-1"
		  Var Hash As MemoryBlock = Crypt.HashBytes(Content)
		  If Hash Is Nil Or Crypt.LastMethodSuccess = False Then
		    System.DebugLog(Crypt.LastErrorText)
		    Return ""
		  End If
		  
		  If Key.SetEncodedHash("hex", Hash) = False Or Key.SignHash() = False Then
		    System.DebugLog(Key.LastErrorText)
		    Return ""
		  End If
		  
		  Return Key.GetEncodedSignature("base64")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SignEdDSA(Key As Chilkat.PrivateKey, Content As MemoryBlock) As String
		  Var Binary As New Chilkat.BinData
		  If Binary.AppendBinary(Content) = False Then
		    System.DebugLog("Unable to append binary")
		    Return ""
		  End If
		  
		  Var EdDSA As New Chilkat.EdDSA
		  Var Signature As String = EdDSA.SignBdENC(Binary, "base64", Key)
		  If EdDSA.LastMethodSuccess = False Then
		    System.DebugLog(EdDSA.LastErrorText)
		    Return ""
		  End If
		  
		  Return Signature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SignRSA(Key As String, Content As MemoryBlock) As String
		  Return EncodeHex(Crypto.RSASign(Content, Key)).Lowercase
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBannerText As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBuildNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisplayVersion As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloads() As Download
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotesText As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As ProgressSheet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStageCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadQueue As Dictionary
	#tag EndProperty


	#tag Constant, Name = ColumnARM64, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnFile, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIntel32, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIntel64, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnPlatform, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events UploadSocket
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #Pragma Unused Content
		  
		  If HTTPStatus = 201 Then
		    Timer.CallLater(10, AddressOf NextQueueItem)
		  Else
		    Self.Error("Unable to upload build to " + URL + ": " + Str(HTTPStatus, "-0"))
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SendingProgressed(bytesSent As Int64, bytesLeft As Int64)
		  If Self.mProgress <> Nil Then
		    Self.mProgress.Progress = BytesSent / BytesLeft
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(e As RuntimeException)
		  Self.Error(e.Message)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectFolderButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New SelectFolderDialog
		  Dialog.SuggestedFileName = Self.VersionField.Text
		  
		  Var Folder As FolderItem = Dialog.ShowModal(Self)
		  If Folder Is Nil Then
		    Return
		  End If
		  
		  Self.VersionField.Text = Folder.Name
		  Self.AddFiles(Folder)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ShortPreviewField
	#tag Event
		Sub TextChanged()
		  Self.mBannerText = Me.Text.Trim
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HorizontalSeparator
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused Areas
		  
		  G.DrawingColor = &cCCCCCC
		  G.FillRectangle(0, 0, G.Width, G.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Self.Begin()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NotesArea
	#tag Event
		Sub TextChanged()
		  Self.mNotesText = Me.Text.Trim
		  Self.CheckEnabled
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VersionField
	#tag Event
		Sub TextChanged()
		  Var Parser As New Regex
		  Parser.SearchPattern = "^(\d+)\.(\d+)\.(\d+)(([a-z\.]+)(\d+))?$"
		  
		  Var Matches As RegexMatch = Parser.Search(Me.Text.Trim)
		  If Matches = Nil Then
		    Self.mDisplayVersion = ""
		    Self.mBuildNumber = 0
		    Self.mStageCode = 0
		    Self.CheckEnabled
		    Return
		  End If
		  
		  Var MajorVersion As Integer = Val(Matches.SubExpressionString(1))
		  Var MinorVersion As Integer = Val(Matches.SubExpressionString(2))
		  Var BugVersion As Integer = Val(Matches.SubExpressionString(3))
		  Var StageCode As Integer = 3
		  Var NonReleaseVersion As Integer
		  If Matches.SubExpressionCount > 4 Then
		    NonReleaseVersion = Val(Matches.SubExpressionString(6))
		    Select Case Matches.SubExpressionString(5)
		    Case "a"
		      StageCode = 1
		    Case "b"
		      StageCode = 2
		    Case "."
		      StageCode = 3
		    Else
		      StageCode = 0
		    End Select
		  End If
		  
		  Var BuildNumber As Integer = (MajorVersion * 10000000) + (MinorVersion * 100000) + (BugVersion * 1000) + (StageCode * 100) + NonReleaseVersion
		  Self.BuildNumberField.Text = Str(BuildNumber, "0")
		  Self.mStageCode = StageCode
		  Self.mDisplayVersion = Me.Text.Trim
		  Self.mBuildNumber = BuildNumber
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FileList
	#tag Event
		Sub Opening()
		  Me.AcceptFileDrop(AppFileTypes.DiskImage + AppFileTypes.WindowsExecutable)
		  
		  Me.ColumnTypeAt(Self.ColumnARM64) = DesktopListBox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnIntel32) = DesktopListbox.CellTypes.CheckBox
		  Me.ColumnTypeAt(Self.ColumnIntel64) = DesktopListbox.CellTypes.CheckBox
		  
		  Me.ColumnAlignmentAt(Self.ColumnARM64) = DesktopListbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnIntel32) = DesktopListbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnIntel64) = DesktopListbox.Alignments.Center
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  #Pragma Unused Action
		  Do
		    If Obj.FolderItemAvailable = False Then
		      Continue
		    End If
		    
		    If Obj.FolderItem.IsFolder Then
		      Self.VersionField.Text = Obj.FolderItem.Name
		    End If
		    Self.AddFiles(Obj.FolderItem)
		    Return
		  Loop Until Obj.NextItem = False
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Encodings.UTF8.Chr(8) Or Key = Encodings.UTF8.Chr(127) Then
		    For RowIdx As Integer = Me.LastRowIndex DownTo 0
		      If Me.RowSelectedAt(RowIdx) Then
		        Me.RemoveRowAt(RowIdx)
		      End If
		    Next RowIdx
		    Return True
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events AddFileButton
	#tag Event
		Sub Pressed()
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = AppFileTypes.WindowsExecutable + AppFileTypes.DiskImage
		  
		  Var File As FolderItem = Dialog.ShowModal(Self)
		  If File Is Nil Then
		    Return
		  End If
		  
		  Self.AddFile(File)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
